# Model: Anand, McFarland, Kihm, Wong (Optimization of Aerosol Penetration through Transport Lines, 1992)
# Based on: straightTubePenetrationAnand1992.m

dir = "./src"
push!(LOAD_PATH,dir)

module trachea

import physicalConstants: k, g, p, MM

struct straightTube
    # CarrierFluidProfile
    T :: Float64          # Carrier fluid temperature (T) SI units: K
    ro :: Float64         # Carrier fluid density (ro) SI units: kg m-3
    Q :: Float64          # Carrier fluid flow rate (Q) SI units: m3 s-1
    mu :: Float64         # Carrier fluid dynamic viscosity (mu) SI units: N s m-2
    
    # Droplet
    ro_d :: Float64         # Droplet density (ro_d) SI units: kg m-3
    # mu_d :: Float64       # Droplet dynamic viscosity (mu_d) SI units: N s m-2
    d_d :: Float64          # Droplet diameter (dd) SI units: m
    md :: Float64           # Droplet mass (md) SI units: kg
    
    # Tube
    d :: Float64            # Tube inner diameter (d) SI units: m
    phi :: Float64          # Inclination angle in radians (phi) SI units: rad
    L :: Float64            # Distance from the tube inlet (L) SI units: m

    # Velocities
    Vb :: Float64           # Brownian diffusion velocity (Vb) SI units: m s-1
    U :: Float64            # Fluid flow mean velocity (U) SI units: m s-1
    Vf :: Float64           # Friction velocity (Vf) SI units: m s-1
    Vs :: Float64           # Dimensionless depositional velocity (Vs)
    Vr :: Float64           # Dimensionless depositional velocity (Vr) 
    Vt :: Float64           # Turbulent diffusional velocity (Vt)
    Vg :: Float64           # Gravitational settling velocity (Vg)
    Vd :: Float64           # Sum of Vt and Vb is defined as Vd (Vd)
    Ve :: Float64           # Ve is the effective depositional velocity, given by the vector sum of velocities due to turbulent diffusion (Vt) 

    # FluidProperties
    Re :: Float64           # Reynolds number (Re)
    f :: Float64            # Fanning friction factor, Blasius equation for turbulent pipe flow (f) dimensionless 
    lambda :: Float64       # Model for the mean free path of the carrier fluid (lambda)
    C :: Float64            # Cunningham slip correction (C)
    tau :: Float64          # Droplet relaxation time (tau)

    # Misc.
    extrapl :: Integer      # Flag to test crossed boundaries
    Rplus :: Float64        # Parameter Rplus (Rplus) 
    ParamS :: Float64       # Parameter S (ParamS)
    Splus :: Float64        # Parameter Splus (Splus)
    TETAc :: Float64        # Critical Angle (TETAc)

    # Penetration
    P :: Float64            # P = penetration = C/C0 = ratio between concentration at distance x and initial concentration 

    function straightTube(T, ro, Q, mu, ro_d, d_d, d, phi, L)
        extrapl = 0
        K = 5e-5;
        
        md = ro_d*(4/3)*(pi*(d_d/2)^3)          # Droplet mass (md) SI units: kg
        Vb = sqrt((k*T)/(2*pi*md))              # Brownian diffusion velocity (Vb) SI units: m s-1
        U=4*Q/(pi*d^2)                          # Fluid flow mean velocity (U) SI units: m s-1
        Re=(U*d*ro)/mu                          # Reynolds number (Re)
        f=0.316/(4*Re^0.25)                     # Fanning friction factor, Blasius equation for turbulent pipe flow (f) dimensionless
        
        if (Re .< 3000 || Re .> 100000)
            extrapl=extrapl+1
        end
        
        Vf = U*sqrt(f/2)                        # Friction velocity (Vf) SI units: m s-1
        lambda = (mu/p)*sqrt((pi*k*T)/(2*MM)) 
        C = 1 + (lambda/d_d)*(2.34+1.05*exp(-.39*d_d/lambda))    # Cunningham slip correction (C)
        tau = (C*ro_d*d_d^2)/(18*mu)            # Droplet relaxation time (tau)
        Rplus = (d_d*Vf*ro)/(2*mu)              # Parameter Rplus (Rplus) 
        ParamS = 0.9*tau*Vf + d_d/2             # Parameter S (ParamS)
        Splus = (ParamS*Vf*ro)/(mu)             # Parameter Splus (Splus)

        if (Splus >= 0 && Splus <= 10)
            Vs = 0.05*Splus                            
        else 
            Vs = 0.5 + 0.0125*(Splus - 10)
            extrapl=extrapl+1
        end

        if (Rplus >= 0 && Rplus <= 10)
            Vr = 0.05*Rplus
        else 
            Vr = 0.5 + 0.0125*(Splus - 10)
            extrapl=extrapl+1
        end
        
        Vt = (Vf*(Vs+Vr))/(4)                  # Turbulent diffusional velocity (Vt)
        Vg = tau*g*cos(phi)                    # Gravitational settling velocity (Vg)
        Vd = Vt + Vb*K                         # Sum of Vt and Vb is defined as Vd (Vd)
        TETAc = asin(Vd/Vg)                    # Critical angle (TETAc)
        Ve=Vd*TETAc/pi + Vd/2 + Vg*cos(TETAc)/pi        # Ve is the effective depositional velocity, given by the vector sum of velocities due to turbulent diffusion (Vt),

        if (Vd>Vg)                             # %If Vd>Vg, there is no need to use TETAc, since the integral that originated the Ve equation can be evaluated from 0 to 2pi. Also, arcsine(x) for x>1 is not defined in the real domain, therefore, TETAc would be imaginary.
            Ve=Vd
        end

        P = -exp(-(pi*d*Ve*L)/(Q))             # P = penetration = C/C0 = ratio between concentration at distance x and initial concentration

        results = [md, Vb, U, Re, f, extrapl, Vf, lambda, tau, Rplus, ParamS, Splus, Vs, Vr, Vt, Vg, Vd, TETAc, Ve, P]
        labels = ["md", "Vb", "U", "Re", "f", "extrapl", "Vf", "lambda", "tau", "Rplus", "ParamS", "Splus", "Vs", "Vr", "Vt", "Vg", "Vd", "TETAc", "Ve", "P"]

        for i in 1:20
            print(labels[i], ": ", results[i], '\n')
        end
    
    end

end

# straightTube(T, ro, Q, mu, ro_d, d_d, d, phi, L)
T = 309.5
ro = 1.12027 # Density of Air (http://www.anaesthesia.med.usyd.edu.au/resources/lectures/humidity_clt/humidity.html#:~:text=While%20nose%20breathing%20at%20rest,%25%20to%2070%25%20relative%20humidity.)
Q = 0.001 # Based on 60L/min flowrate of ventilators
mu = 1.895e-5 # Dynamic viscosity of air (https://www.engineersedge.com/physics/viscosity_of_air_dynamic_and_kinematic_14483.htm#:~:text=The%20viscosity%20of%20air%20depends,10%2D5%20Pa%C2%B7s%20.&text=At%2025%20%C2%B0C%2C%20the,the%20kinematic%20viscosity%2015.7%20cSt.)
ro_d = 1000 # Droplet density of water
d_d = 6e-6 # droplet diameter of inhalation
d = 0.0189 # Diameter of trachea (https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.slideshare.net%2Fjinojustinj%2Ftracheal-pathologies&psig=AOvVaw38sp20tGz3PGVizR_R8F_N&ust=1605869019853000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCICtjbi2ju0CFQAAAAAdAAAAABAT)
phi = pi/2 #Vertical pipe length
L = 0.118 # Avg length of trachea (https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5900092/#:~:text=On%20average%2C%20the%20length%20of,to%20be%20shorter%20in%20females.&text=Structure%20of%20the%20trachea.)

# straightTube(T, ro, Q, mu, ro_d, d_d, d, phi, L)

# Dummy values
straightTube(309.5, 1, 2, 3, 4, 5, 6, 7, 8)

end


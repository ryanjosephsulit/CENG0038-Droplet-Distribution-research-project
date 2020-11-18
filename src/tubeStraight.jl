# Model: Anand, McFarland, Kihm, Wong (Optimization of Aerosol Penetration through Transport Lines, 1992)
# Based on: straightTubePenetrationAnand1992.m

dir = "./src"
push!(LOAD_PATH,dir)

module tubeStraight

import physicalConstants: k, g

struct Parameters
 # CarrierFluidProfile
    T :: Float64        # Carrier fluid temperature (T) SI units: K
    Ro :: Float64       # Carrier fluid density (ro) SI units: kg m-3
    Q :: Float64        # Carrier fluid flow rate (Q) SI units: m3 s-1
    mu :: Float64       # Carrier fluid dynamic viscosity (mu) SI units: N s m-2
end

## Input
print("Parameter details \n")
print("Enter T, Ro, Q, mu: ")
params = split(readline(), ",")

T = params[1]
Ro = params[2]
Q = params[3]
mu = params[4]

# print(T)
# print(Ro)
# print(Q)
# print(mu)
# print("\n")

mutable struct Properties
 # Droplet
    ro_d :: Float64                         # Droplet density (ro_d) SI units: kg m-3
    mu_d :: Float64                         # Droplet dynamic viscosity (mu_d) SI units: N s m-2
    d_d :: Float64                          # Droplet diameter (dd) SI units: m
    md :: Float64                           # Droplet mass (md) SI units: kg

 # Tube
    d :: Float64                            # Tube inner diameter (d) SI units: m
    phi :: Float64                          # Inclination angle in radians (phi) SI units: rad
    L :: Float64                            # Distance from the tube inlet (L) SI units: m
end

## Input
print("Droplet Properties \n")
print("Enter ro_d, mu_d, d_d: ")
propsDroplet = split(readline(), ",")

ro_d = propsDroplet[1]
mu_d = propsDroplet[2]
d_d = propsDroplet[3]

# print(ro_d)
# print(mu_d)
# print(d_d)
# print("\n")

print("Tube Properties \n")
print("Enter d, phi, L: ")
propsTube = split(readline(), ",")

function meanFlow(Q,  d)
        U=4*Q/(pi*d^2)                       # Fluid flow mean velocity (U) SI units: m s-1
end
    
function reynold(U,  d, ro, mu)
        Re=(U*d*ro)/mu                       # Reynolds number (Re)
end
    
function fff(Re)
        f=0.316/(4*Re^0.25)                  # Fanning friction factor, Blasius equation for turbulent pipe flow (f) dimensionless
end

# The Blasius equation is not applicable for the following range of Reynolds number:
function blasius(Re)
    if (Re .< 3000 || Re .> 100000)
        extrapolation=extrapolation+1
end
    
function frictionV(U, f)
        Vf = U*sqrt(f/2)                      # Friction velocity (Vf) SI units: m s-1
end
    
function CunninghamSlipCorrection(mu, T, d_d)
         lambda = (mu/p)*sqrt((pi*k*T)/(2*MM))                   # Model for the mean free path of the carrier fluid (lambda)
         C = 1 + (lambda/dd)*(2.34+1.05*exp(-.39*d_d/lambda))    #Cunningham slip correction (C)
end

function relaxationTime(C, ro_d, d_d,  mu)
        tau = (C*ro_d*d_d^2)/(18*mu)          # Droplet relaxation time (tau)
end
        
function Rplus(d_d, Vf, ro, mu)
        Rplus = (d_d*Vf*ro)/(2*mu)            # Parameter Rplus (Rplus) 
end
        
function paramS(tau, Vf, d_d)
        ParamS = 0.9*tau*Vf + d_d/2            # Parameter S (ParamS)
end
        
function Splus(ParamS, Vf, ro, mu)
        Splus = (ParamS*Vf*ro)/(mu)            # Parameter Splus (Splus)
end
     
# Dimensionless depositional velocity (Vs)
if (Splus >= 0 && Splus <= 10)
    Vs = 0.05*Splus                            
else 
    Vs = 0.5 + 0.0125*(Splus - 10)
    extrapolation=extrapolation+1
end

# Dimensionless depositional velocity (Vr)
if (Rplus >= 0 && Rplus <= 10)
    Vr = 0.05*Rplus
else 
    Vr = 0.5 + 0.0125*(Splus - 10)
    extrapolation=extrapolation+1
end
        
function diffVelTur(Vf, Vs, Vr)
        Vt = (Vf*(Vs+Vr))/(4)                  # Turbulent diffusional velocity (Vt)
end
        
function gSettlingVel(tau, g, phi)
        Vg = tau*g*cos(phi)                    # Gravitational settling velocity (Vg)
end
        
function depositionV(Vt, Vb, K)
        Vd = Vt + Vb*K                         # Sum of Vt and Vb is defined as Vd (Vd)
end
        
function critAngle(Vd, Vg)
        TETAc = asin(Vd/Vg)                    # Critical angle (TETAc)
end
        
function effectiveDepositionV(Vd, TETAc, Vg)
        Ve=Vd*TETAc/pi + Vd/2 + Vg*cos(TETAc)/pi        # Ve is the effective depositional velocity, given by the vector sum of velocities due to turbulent diffusion (Vt),
end

# If Vd>Vg, there is no need to use TETAc, since the integral that originated the Ve equation can be evaluated from 0 to 2pi. Also, arcsine(x) for x>1 is not defined in the real domain, therefore, TETAc would be imaginary.
if (Vd>Vg)
    Ve=Vd
end
        
function penetration(d, Ve, L, Q)
        P = -exp(-(pi*d*Ve*L)/(Q))             # P = penetration = C/C0 = ratio between concentration at distance x and initial concentration
end
        
    d = parse(Float64, propsTube[1])
phi = parse(Float64, propsTube[2])
L = parse(Float64, propsTube[3])

print(typeof(d))

# print(d)
# print(phi)
# print(L)
# print("\n")

# function dropletMass(ro_d, d_d)
#     md = ro_d*(4/3)*(pi*(d_d/2)^3)     # Droplet mass (md) SI units: kg
# end

# md = ro_d*(4/3)*(pi*(d_d/2)^3)     # Droplet mass (md) SI units: kg

# dropletMass(ro_d, d_d)

# print(md)

# function velocityBr(k, T, md)
#     Vb = sqrt((k*T)/(2*pi*md))          # Brownian diffusion velocity (Vb) SI units: m s-1
# end

# test = velocityBr(k, T, md)

# print(test)

function velocityTu(Q, d)
end
#Debug test
# println(k)

end




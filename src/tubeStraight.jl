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

struct Properties
 # Droplet
    ro_d :: Float64     # Droplet density (ro_d) SI units: kg m-3
    mu_d :: Float64     # Droplet dynamic viscosity (mu_d) SI units: N s m-2
    d_d :: Float64      # Droplet diameter (dd) SI units: m
 # Tube
    d :: Float64        # Tube inner diameter (d) SI units: m
    phi :: Float64      # Inclination angle in radians (phi) SI units: rad
    L :: Float64        # Distance from the tube inlet (L) SI units: m
end

function velocities(pa :: Parameters, 
                    pr :: Properties) :: Float64
    
    ### Droplet mass (md) SI units: kg
    # Droplet density (ro_d) SI units: kg m-3
    # Droplet diameter (dd) SI units: m
    md = pr.ro_d*(4/3)*(pi*(pr.d_d/2)^3);

    ### Brownian diffusion velocity (Vb) SI units: m s-1
    # Boltzmann constant (k) SI units: m2 kg s-2 K-1
    # Carrier fluid temperature (T) SI units: K
    # Droplet mass (md) SI units: kg
    Vb = sqrt((k*pa.T)/(2*pi*md));

    





end

#Debug test
# println(k)

end


# struct TemperatureProfile
#     T0 :: Float64     # initial temperature
#     Tf :: Float64     # final temperature
#     t1 :: Float64     # time point 
#     a :: Float64      # coefficients of quadratics
#     b :: Float64
#     c :: Float64
#     d :: Float64
#     e :: Float64
#     f :: Float64
#     function TemperatureProfile(T0, Tf, t1)
#         a = T0
#         b = 0
#         c = (Tf-T0)/t1
#         d = (Tf*t1 - T0) / (t1 - 1)
#         e = (2*T0 - 2*Tf) / (t1 - 1)
#         f = (Tf - T0) / (t1 - 1)
#         new(T0, Tf, t1, a, b, c, d, e, f)
#     end
# end
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

# ## Input
# print("Enter T, Ro, Q, mu: ")
# params = split(readline(), ",")

# print(typeof(params))

# testArray = [1,2,3,4]
# print(params)

# T = params[1]
# Ro = params[2]
# Q = params[3]
# mu = params[4]

# print(T)
# print(Ro)
# print(Q)
# print(mu)






mutable struct Properties
 # Droplet
    ro_d :: Float64                         # Droplet density (ro_d) SI units: kg m-3
    mu_d :: Float64                         # Droplet dynamic viscosity (mu_d) SI units: N s m-2
    d_d :: Float64                          # Droplet diameter (dd) SI units: m
    function dropletMass(ro_d, d_d)
        md = ro_d*(4/3)*(pi*(d_d/2)^3);     # Droplet mass (md) SI units: kg
    end

 # Tube
    d :: Float64                            # Tube inner diameter (d) SI units: m
    phi :: Float64                          # Inclination angle in radians (phi) SI units: rad
    L :: Float64                            # Distance from the tube inlet (L) SI units: m
end


function velocities(k, T, md)
    Vb = sqrt((k*T)/(2*pi*md));          # Brownian diffusion velocity (Vb) SI units: m s-1
end

#Debug test
# println(k)





end




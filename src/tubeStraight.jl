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
function velocityTu(Q,  d)
        U=4*Q/(pi*d^2)
end
    
function reynold(U,  d, ro, mu)
        Re=(U*d*ro)/mu
end
    
function fff(Re)
        f=0.316/(4*Re^0.25)
end
    
function blasius(Re)
    if (Re .< 3000 || Re .> 100000)
        extrapolation=extrapolation+1
end
    
function frictionV(U, f)
        Vf = U*sqrt(f/2)
end
    
function CunninghamSlipCorrection(mu, T, d_d)
         lambda = (mu/p)*sqrt((pi*k*T)/(2*MM))                   # Model for the mean free path of the carrier fluid (lambda)
         C = 1 + (lambda/dd)*(2.34+1.05*exp(-.39*d_d/lambda))    #Cunningham slip correction (C)
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




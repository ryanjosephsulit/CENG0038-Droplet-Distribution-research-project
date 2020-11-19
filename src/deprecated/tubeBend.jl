# Model: Y. S. Cheng, C. S. Wang (Motion of Particles in Bends of Circular Pipes, 1980)
# Based on: bendTubePenetrationCheng1980.m

dir = "./src"
push!(LOAD_PATH,dir)

module tubeBend

import physicalConstants: k, g

struct Parameters
#CarrierFluidProfile
     T     :: Float64                                        # Carrier fluid temperature (T) SI units: K
     Q     :: Float64                                        # Carrier fluid flow rate (Q) SI units: m3 s-1
     mu    :: Float64                                        # Carrier fluid dynamic viscosity (mu) SI units: N s m-2
end
struct Properties
#Fluid
     ro_d  :: Float64                                        # Droplet density (ro_d) SI units: kg m-3
     mu_d  :: Float64                                        # Droplet dynamic viscosity (mu_d) SI units: N s m-2
     d_d   :: Float64                                        # Droplet diameter (d_d) SI units: m
#Tube
     Rb    :: Float64                                        # Radius of the bend (Rb) SI units: m
     theta :: Float64                                        # Bend angle (theta) SI units: radians
     d     :: Float64                                        # Tube inner diameter (d) SI units: m   
end

function AerosolPenetration(d :: Properties,
                           Rb :: Properties,
                            Q :: Parameters) :: Float64
     Rt = d/2                                                # Tube inner radius (d) SI units: m
     Ro = Rb/Rt                                              # Curvature ratio (Ro) SI units: dimensionless
     U = 4*Q/(pi*d^2)                                        # Fluid flow mean velocity (U) SI units: m s-1
end

function Cunninghamslipcorrection(mu :: Parameters,
                                   T :: Parameters,
                                 d_d :: Properties) :: Float64
     lambda = (mu/p)*sqrt((pi*k*T)/(2*MM))                   # Model for the mean free path of the carrier fluid (lambda)
     C = 1 + (lambda/dd)*(2.34+1.05*exp(-.39*d_d/lambda))    #Cunningham slip correction (C)
end

function


#Debug test
# println(k)

end
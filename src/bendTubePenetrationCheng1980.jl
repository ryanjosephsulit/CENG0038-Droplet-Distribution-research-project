module TubeBend

using Constants

 struct Properties
#CarrierFluidProfile
     T     :: Float64        # Carrier fluid temperature (T) SI units: K
     Q     :: Float64        # Carrier fluid flow rate (Q) SI units: m3 s-1
     mu    :: Float64        # Carrier fluid dynamic viscosity (mu) SI units: N s m-2
#Fluid
     ro_d  :: Float64        # Droplet density (ro_d) SI units: kg m-3
     mu_d  :: Float64        # Droplet dynamic viscosity (mu_d) SI units: N s m-2
     dd    :: Float64        # Droplet diameter (dd) SI units: m
#Tube
     Rb    :: Float64        # Radius of the bend (Rb) SI units: m
     theta :: Float64        # Bend angle (theta) SI units: radians
     d     :: Float64        # Tube inner diameter (d) SI units: m
function  ()
    
end
end

#struct TemperatureProfile
#    T0 :: Float64     # initial temperature
#    Tf :: Float64     # final temperature
#    t1 :: Float64     # time point 
#    a :: Float64      # coefficients of quadratics
#    b :: Float64
#    c :: Float64
#    d :: Float64
#    e :: Float64
#    f :: Float64
#    function TemperatureProfile(T0, Tf, t1)
#        a = T0
#        b = 0
#        c = (Tf-T0)/t1
#        d = (Tf*t1 - T0) / (t1 - 1)
#        e = (2*T0 - 2*Tf) / (t1 - 1)
#        f = (Tf - T0) / (t1 - 1)
#        new(T0, Tf, t1, a, b, c, d, e, f)
#    end
#end
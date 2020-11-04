module TubeStraight

include("physicalConstants.jl")

# struct CarrierFluidProfile
#     T :: Float64        # Carrier fluid temperature (T) SI units: K
#     Ro :: Float64       # Carrier fluid density (ro) SI units: kg m-3
#     Q :: Float64        # Carrier fluid flow rate (Q) SI units: m3 s-1
#     mu :: Float64       # Carrier fluid dynamic viscosity (mu) SI units: N s m-2


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
if "./src" in LOAD_PATH
    # print("in src")
else
    dir = "./src"
    push!(LOAD_PATH,dir)        
    # print("not in src")
end

module bifurcations

struct bifurcation
    # Stokes Number Properties
    ro_d :: Float64     # Droplet density (ro_d) SI units: kg m-3
    d_d :: Float64      # Droplet diameter (dd) SI units: m
    d_0 :: Float64      # Tube inner diamater of parent branch (d_0)
    d_1 :: Float64      # Tube inner diameter of the daughter branch (d_1)
    mu :: Float64       # Carrier fluid dynamic viscosity (mu) SI units: N s m-2
    Q :: Float64        # Carrier fluid flow rate (Q) SI units: m3 s-1


    U :: Float64        # Fluid flow mean velocity (U) SI units: m s-1

    alpha :: Float64    # Angle between axes of parent and daughter branch
    phi :: Float64      # Bifurcation geometry SI units: degrees

    Stk :: Float64      # Stoke's Number (Stk)
    P :: Float64        # Efficiency of inertial deposition in an airway bifurcation

    function bifurcation(ro_d, d_d, d_0, d_1, mu, Q, alpha)
        U=4*Q/(pi*d_0^2)                          
        Stk = (ro_d*(d_d^2)*U)/(18*mu*d_1)

        phi = 2*(d_0/d_1)^2*sin(alpha)

        # print((sqrt( (4/3)*phi*Stk )))
        # print("\n")

        Deposition = (16/3*pi)*phi*Stk*(2-(sqrt( (4/3)*phi*Stk )))

        # print(Deposition)
        # print("\n")

        P = 1-Deposition
        # print(U)
        # print("\n")

        # print(Stk)
        # print("\n")

        # print(P)
        # print("\n")
    end
end

dataset1 = [5.4444E-07, 5.8472E-07, 6.2656E-07, 6.6727E-07, 7.2656E-07, 7.6727E-07, 8.3492E-07, 9.0000E-07, 9.6627E-07, 1.0557E-06, 1.1621E-06, 1.2616E-06, 1.3686E-06, 1.4746E-06, 1.5741E-06, 1.6736E-06, 1.7828E-06, 1.8863E-06, 1.9858E-06, 2.1567E-06, 2.3432E-06, 2.5136E-06, 2.6939E-06, 2.8643E-06, 3.0672E-06, 3.3113E-06, 3.5555E-06, 3.8230E-06]

# # bifurcation(ro_d, d_d, d_0, d_1, mu, Q, alpha)
# ro_d = 1000 # Droplet density of water
# # d_d = 6e-6 # droplet diameter of inhalation
# d_d = 3.8230E-06 # droplet diameter of inhalation
# d_0 = 0.018 # Diameter of trachea (https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.slideshare.net%2Fjinojustinj%2Ftracheal-pathologies&psig=AOvVaw38sp20tGz3PGVizR_R8F_N&ust=1605869019853000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCICtjbi2ju0CFQAAAAAdAAAAABAT)
# d_1 = 0.0122 # Diameter of trachea (https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.slideshare.net%2Fjinojustinj%2Ftracheal-pathologies&psig=AOvVaw38sp20tGz3PGVizR_R8F_N&ust=1605869019853000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCICtjbi2ju0CFQAAAAAdAAAAABAT)
# mu = 1.895e-5 # Dynamic viscosity of air (https://www.engineersedge.com/physics/viscosity_of_air_dynamic_and_kinematic_14483.htm#:~:text=The%20viscosity%20of%20air%20depends,10%2D5%20Pa%C2%B7s%20.&text=At%2025%20%C2%B0C%2C%20the,the%20kinematic%20viscosity%2015.7%20cSt.)
# # Q = 0.001 # Based on 60L/min flowrate of ventilators
# Q = 1e-4 # Based on 6L/min of average adult male (Guyton and Hall Textbook of Medical Physiology 12th Edition)
# # alpha = 1.06116 # SCA, all ages. Haskin Goodman et. al. "Normal Tracheal Bifurcation Angle"
# alpha = 1.040216 # SCA, all ages. Haskin Goodman et. al. "Normal Tracheal Bifurcation Angle"

# bifurcation(ro_d, d_d, d_0, d_1, mu, Q, alpha)
Q = 0.00050038/2 #Chapter 3
ro_d = 1000 # Droplet density of water
d_0 = 0.018 # Diameter of trachea (https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.slideshare.net%2Fjinojustinj%2Ftracheal-pathologies&psig=AOvVaw38sp20tGz3PGVizR_R8F_N&ust=1605869019853000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCICtjbi2ju0CFQAAAAAdAAAAABAT)
d_1 = 0.018 # Diameter of daughter (https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.slideshare.net%2Fjinojustinj%2Ftracheal-pathologies&psig=AOvVaw38sp20tGz3PGVizR_R8F_N&ust=1605869019853000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCICtjbi2ju0CFQAAAAAdAAAAABAT)
mu = 1.895e-5 # Dynamic viscosity of air (https://www.engineersedge.com/physics/viscosity_of_air_dynamic_and_kinematic_14483.htm#:~:text=The%20viscosity%20of%20air%20depends,10%2D5%20Pa%C2%B7s%20.&text=At%2025%20%C2%B0C%2C%20the,the%20kinematic%20viscosity%2015.7%20cSt.)
alpha = 1.040216 # IBA, all ages. Haskin Goodman et. al. "Normal Tracheal Bifurcation Angle"
# d_d = 3.8230E-06 # droplet diameter of inhalation

# bifurcation(ro_d, d_d, d_0, d_1, mu, Q, alpha)

post_bifurc1 = []

for d_d = dataset1
    bifurc_penetration = bifurcations.bifurcation(ro_d, d_d, d_0, d_1, mu, Q, alpha)
    push!(post_bifurc1, bifurc_penetration)
end

print(post_bifurc1)

end
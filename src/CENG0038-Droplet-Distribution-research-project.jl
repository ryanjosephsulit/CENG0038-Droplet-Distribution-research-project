# CENG0038 Droplet Distribution research project

dir = "./src"
push!(LOAD_PATH,dir)

module researchProject

import trachea
import bifurcations

# straightTube(T, ro, Q, mu, ro_d, d_d, d, phi, L)
T = 309.5 # Temperature of Air
ro = 1.12027 # Density of Air (http://www.anaesthesia.med.usyd.edu.au/resources/lectures/humidity_clt/humidity.html#:~:text=While%20nose%20breathing%20at%20rest,%25%20to%2070%25%20relative%20humidity.)
# Q = 0.001 # Based on 60L/min flowrate of ventilators
# Q = 1e-4 # Based on 6L/min of average adult male (Guyton and Hall Textbook of Medical Physiology 12th Edition)
Q = 0.00050038 #Chapter 3
mu = 1.895e-5 # Dynamic viscosity of air (https://www.engineersedge.com/physics/viscosity_of_air_dynamic_and_kinematic_14483.htm#:~:text=The%20viscosity%20of%20air%20depends,10%2D5%20Pa%C2%B7s%20.&text=At%2025%20%C2%B0C%2C%20the,the%20kinematic%20viscosity%2015.7%20cSt.)
ro_d = 1000 # Droplet density of water
d = 0.018 # Diameter of trachea (https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.slideshare.net%2Fjinojustinj%2Ftracheal-pathologies&psig=AOvVaw38sp20tGz3PGVizR_R8F_N&ust=1605869019853000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCICtjbi2ju0CFQAAAAAdAAAAABAT)
phi = (pi/2) # Inclination angle in radians (phi) SI units: rad
# IBA = 1.040216 # Interbronchial angle, average for all ages, 59.6 degrees SI Units: radians
# phi = pi-(pi/2)-(IBA/2) # Inclination angle in radians (phi) SI units: rad
L = 0.118 # Avg length of trachea (https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5900092/#:~:text=On%20average%2C%20the%20length%20of,to%20be%20shorter%20in%20females.&text=Structure%20of%20the%20trachea.)

## Dataset 1
# Source: "The Mechanism of Breath Formation"
dataset1 = [5.4444E-07, 5.8472E-07, 6.2656E-07, 6.6727E-07, 7.2656E-07, 7.6727E-07, 8.3492E-07, 9.0000E-07, 9.6627E-07, 1.0557E-06, 1.1621E-06, 1.2616E-06, 1.3686E-06, 1.4746E-06, 1.5741E-06, 1.6736E-06, 1.7828E-06, 1.8863E-06, 1.9858E-06, 2.1567E-06, 2.3432E-06, 2.5136E-06, 2.6939E-06, 2.8643E-06, 3.0672E-06, 3.3113E-06, 3.5555E-06, 3.8230E-06]

post_trachea = []

for d_d = dataset1
    penetration = trachea.straightTube(T, ro, Q, mu, ro_d, d_d, d, phi, L)
    push!(post_trachea, penetration)
end

# print(post_trachea)

# bifurcation(ro_d, d_d, d_0, d_1, mu, Q, alpha)
ro_d = 1000 # Droplet density of water
d_0 = 0.018 # Diameter of trachea (https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.slideshare.net%2Fjinojustinj%2Ftracheal-pathologies&psig=AOvVaw38sp20tGz3PGVizR_R8F_N&ust=1605869019853000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCICtjbi2ju0CFQAAAAAdAAAAABAT)
d_1 = 0.018 # Diameter of daughter (https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.slideshare.net%2Fjinojustinj%2Ftracheal-pathologies&psig=AOvVaw38sp20tGz3PGVizR_R8F_N&ust=1605869019853000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCICtjbi2ju0CFQAAAAAdAAAAABAT)
mu = 1.895e-5 # Dynamic viscosity of air (https://www.engineersedge.com/physics/viscosity_of_air_dynamic_and_kinematic_14483.htm#:~:text=The%20viscosity%20of%20air%20depends,10%2D5%20Pa%C2%B7s%20.&text=At%2025%20%C2%B0C%2C%20the,the%20kinematic%20viscosity%2015.7%20cSt.)
# Q = 0.001 # Based on 60L/min flowrate of ventilators
# Q = 1e-4 # Based on 6L/min of average adult male (Guyton and Hall Textbook of Medical Physiology 12th Edition)
Q = 0.00050038 #Chapter 3
# alpha = 1.06116 # SCA, all ages. Haskin Goodman et. al. "Normal Tracheal Bifurcation Angle"
alpha = 1.040216 # IBA, all ages. Haskin Goodman et. al. "Normal Tracheal Bifurcation Angle"

post_bifurc0 = []

for d_d = dataset1
    bifurc_penetration = bifurcations.bifurcation(ro_d, d_d, d_0, d_1, mu, Q, alpha)
    push!(post_bifurc0, bifurc_penetration)
end

# print("\n")
# print(post_bifurc0)

# straightTube(T, ro, Q, mu, ro_d, d_d, d, phi, L)
T = 309.5 # Temperature of Air
ro = 1.12027 # Density of Air (http://www.anaesthesia.med.usyd.edu.au/resources/lectures/humidity_clt/humidity.html#:~:text=While%20nose%20breathing%20at%20rest,%25%20to%2070%25%20relative%20humidity.)
# Q = 0.001 # Based on 60L/min flowrate of ventilators
# Q = 1e-4 # Based on 6L/min of average adult male (Guyton and Hall Textbook of Medical Physiology 12th Edition)
Q = 0.00050038/2 #Chapter 3
mu = 1.895e-5 # Dynamic viscosity of air (https://www.engineersedge.com/physics/viscosity_of_air_dynamic_and_kinematic_14483.htm#:~:text=The%20viscosity%20of%20air%20depends,10%2D5%20Pa%C2%B7s%20.&text=At%2025%20%C2%B0C%2C%20the,the%20kinematic%20viscosity%2015.7%20cSt.)
ro_d = 1000 # Droplet density of water
d = 0.0122 # Diameter of trachea (https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.slideshare.net%2Fjinojustinj%2Ftracheal-pathologies&psig=AOvVaw38sp20tGz3PGVizR_R8F_N&ust=1605869019853000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCICtjbi2ju0CFQAAAAAdAAAAABAT)
# phi = (pi/2) # Inclination angle in radians (phi) SI units: rad
IBA = 1.040216 # Interbronchial angle, average for all ages, 59.6 degrees SI Units: radians Haskin Goodman et. al. "Normal Tracheal Bifurcation Angle"
phi = pi-(pi/2)-(IBA/2) # Inclination angle in radians (phi) SI units: rad
L = 0.118 # Avg length of trachea (https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5900092/#:~:text=On%20average%2C%20the%20length%20of,to%20be%20shorter%20in%20females.&text=Structure%20of%20the%20trachea.)

# post_inclinedTube0 = []

# for d_d = dataset1
#     penetration = trachea.straightTube(T, ro, Q, mu, ro_d, d_d, d, phi, L)
#     push!(post_inclinedTube0, penetration)
# end

# print("\n")
# print(post_inclinedTube0)

# print(post_trachea)
# print("\n")
# print(post_inclinedTube0)
# print("\n")
# print(size(post_trachea))
# print("\n")
# print("\n")
# print(post_bifurc0)
# print("\n")
# print(size(post_bifurc0))

# Deposition Efficiency after first bifurcation
# n_i = post_trachea .* post_bifurc0

# print(n_i)

# Distribution for dataset1
# d_i1 = [0.056718217, 0.060143555, 0.068012484, 0.071244953, 0.073582454, 0.076460071, 0.078809187, 0.077779268, 0.072560295, 0.065129111, 0.056718217, 0.045163553, 0.037531843, 0.031410246, 0.026885611, 0.02266377, 0.018430315, 0.01499732, 0.01121713, 0.00960475, 0.007514077, 0.005690533, 0.003839032, 0.002862148, 0.002179373, 0.001434928, 0.000799432, 0.000618126]
# print(size(d_i1))

# Penetration * Distribution for data set 1 (one bifurcation)
# final_distribution = n_i .* d_i1

# print(final_distribution)

# L = 0.1
# print(L)


# Write your package code here.

end
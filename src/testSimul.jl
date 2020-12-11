# CENG0038 Droplet Distribution research project

dir = "./src"
push!(LOAD_PATH,dir)

module researchProject

import trachea

# straightTube(T, ro, Q, mu, ro_d, d_d, d, phi, L)
T = 309.5 # Temperature of Air
ro = 1.12027 # Density of Air (http://www.anaesthesia.med.usyd.edu.au/resources/lectures/humidity_clt/humidity.html#:~:text=While%20nose%20breathing%20at%20rest,%25%20to%2070%25%20relative%20humidity.)
Q = 0.001 # Based on 60L/min flowrate of ventilators
mu = 1.895e-5 # Dynamic viscosity of air (https://www.engineersedge.com/physics/viscosity_of_air_dynamic_and_kinematic_14483.htm#:~:text=The%20viscosity%20of%20air%20depends,10%2D5%20Pa%C2%B7s%20.&text=At%2025%20%C2%B0C%2C%20the,the%20kinematic%20viscosity%2015.7%20cSt.)
ro_d = 1000 # Droplet density of water
d = 0.0189 # Diameter of trachea (https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.slideshare.net%2Fjinojustinj%2Ftracheal-pathologies&psig=AOvVaw38sp20tGz3PGVizR_R8F_N&ust=1605869019853000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCICtjbi2ju0CFQAAAAAdAAAAABAT)
phi = (pi/2) # Vertical pipe length
L = 0.118 # Avg length of trachea (https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5900092/#:~:text=On%20average%2C%20the%20length%20of,to%20be%20shorter%20in%20females.&text=Structure%20of%20the%20trachea.)

## Dataset 1
# Source: "The Mechanism of Breath Formation"
dataset1 = [5.4444E-07, 5.8472E-07, 6.2656E-07, 6.6727E-07, 7.2656E-07, 7.6727E-07, 8.3492E-07, 9.0000E-07, 9.6627E-07, 1.0557E-06, 1.1621E-06, 1.2616E-06, 1.3686E-06, 1.4746E-06, 1.5741E-06, 1.6736E-06, 1.7828E-06, 1.8863E-06, 1.9858E-06, 2.1567E-06, 2.3432E-06, 2.5136E-06, 2.6939E-06, 2.8643E-06, 3.0672E-06, 3.3113E-06, 3.5555E-06, 3.8230E-06]

results = []

for d_d = dataset1
    penetration = trachea.straightTube(T, ro, Q, mu, ro_d, d_d, d, phi, L)
    push!(results, penetration)
end

# trachea.straightTube(T, ro, Q, mu, ro_d, d_d, d, phi, L)

print(results)
# Write your package code here.

end

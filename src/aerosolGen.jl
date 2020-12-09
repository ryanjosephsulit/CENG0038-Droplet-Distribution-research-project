if "./src" in LOAD_PATH
    # print("in src")
else
    dir = "./src"
    push!(LOAD_PATH,dir)        
    # print("not in src")
end

module aerosolGen

using Distributions

# "The Mechanism of Breath Formation"
# DOI: 10.1089/jamp.2008.0720

# Particle size distribution for young subjects (b-1-0-f3-m-m)
# Mean = 1.015056269 μm
# Variance = 0.209550477 μm

mean0 = 1.015056269#e-6
var0 = 0.209550477#e-6

distrib0 = Distributions.LogNormal(mean0,var0)
# range0 = 0.5e-6:0.1e-6:4e-6
# range0 = 0.5:0.1:4
range0=0.8:0.2:1.2
discrete0 = pdf(distrib0, range0)
# discrete0 = cdf(distrib0, range0)

println(discrete0[1])
println(discrete0)

end
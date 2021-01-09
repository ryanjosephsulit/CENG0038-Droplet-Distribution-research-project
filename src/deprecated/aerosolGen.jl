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
# Variance = 0.457766837 μm

# Determining parameters for log(X)
mean = 1.015056269e-6
var = 0.209550477e-6
std = sqrt(var)

# mean = 243900.6582
# var = 93909632285

# std = 0.457766837e-6


mu = log((mean^2)/(sqrt(var + mean^2)))
sigma = sqrt(log(1+((var)/(mean^2))))

# log_mean = exp(mean + var/2)
# log_var = (exp(var)-1)*exp(2*mean+var)

# log_mean = log(mean)-0.5*log((std/mean)^2 + 1)
# log_std = sqrt(log((std/mean)^2 + 1))

# println(log_mean)
# println("\n")
# println(log_std)
# println(mu)
# println("\n")
# println(sigma)

# println(log_mean + "\n" + log_var)

distrib0 = Distributions.LogNormal(mu, sigma)
# distrib0 = Distributions.LogNormal(mean, var)
range0 = 0.5e-10:0.5e-9:5e-8
# range0 = 0.5:0.1:4
# range0=-0.5e-6:0.2e-6:0.5e-6
discrete0 = pdf(distrib0, range0)
# discrete1 = cdf(distrib0, range0)
# discrete0=pdf(distrib0, ) 

# mean(distrib0)    

# println(discrete0[1])
println(discrete0)
# println(discrete1)
# println(params(distrib0))
# println(meanlogx(distrib0))

end
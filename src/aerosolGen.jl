using Distributions

if "./src" in LOAD_PATH
    # print("in src")
else
    dir = "./src"
    push!(LOAD_PATH,dir)        
    # print("not in src")
end


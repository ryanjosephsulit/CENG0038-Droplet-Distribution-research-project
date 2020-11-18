# Model: Anand, McFarland, Kihm, Wong (Optimization of Aerosol Penetration through Transport Lines, 1992)
# Based on: straightTubePenetrationAnand1992.m

dir = "./src"
push!(LOAD_PATH,dir)

module trachea

import physicalConstants: k, g

struct straightTube
    # CarrierFluidProfile
    T :: Float64        # Carrier fluid temperature (T) SI units: K
    Ro :: Float64       # Carrier fluid density (ro) SI units: kg m-3
    Q :: Float64        # Carrier fluid flow rate (Q) SI units: m3 s-1
    mu :: Float64       # Carrier fluid dynamic viscosity (mu) SI units: N s m-2
    
    # Droplet
    ro_d :: Float64     # Droplet density (ro_d) SI units: kg m-3
    mu_d :: Float64     # Droplet dynamic viscosity (mu_d) SI units: N s m-2
    d_d :: Float64      # Droplet diameter (dd) SI units: m
    md :: Float64       # Droplet mass (md) SI units: kg
    
    # Tube
    d :: Float64        # Tube inner diameter (d) SI units: m
    phi :: Float64      # Inclination angle in radians (phi) SI units: rad
    L :: Float64        # Distance from the tube inlet (L) SI units: m

    # Velocities
    Vb :: Float64       # Brownian diffusion velocity (Vb) SI units: m s-1
    U :: Float64        # Fluid flow mean velocity (U) SI units: m s-1

    function straightTube(T, Ro, Q, mu, ro_d, mu_d, d_d, d, phi, L)
        
    end


end

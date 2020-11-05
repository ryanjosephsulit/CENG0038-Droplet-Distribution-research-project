module physicalConstants

export k, g, p, MM

# Boltzmann constant (k) SI units: m2 kg s-2 K-1
const k = 1.38064852e-23

# Standard gravity (g) SI units: m s-2
const g = 9.80665

# Air at atmospheric pressure (Pa) SI units: kg s-2 m-2
const p = 101325;

# Molar mass of air (kg mol^-1) SI units: kg mol-1
const MM = 28.97/(1000*6.02214179e23);

end
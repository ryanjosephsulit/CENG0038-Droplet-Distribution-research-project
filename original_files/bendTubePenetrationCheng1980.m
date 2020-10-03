%particle penetration through tubing

function P = bendTubePenetrationCheng1980(x,option)

%% Model: Y. S. Cheng, C. S. Wang (Motion of Particles in Bends of Circular Pipes, 1980)
%Goal: P = penetration = C/C0 = ratio between the aerosol content at distance x and initial one

%option = 1 -> full model
%option = 2 -> simplified model

% T is the temperature
% Q is the fluid flow rate
% mu is the carrier fluid dynamic viscosity
% ro_d is the droplet density
% dd is the droplet diameter
% Rb is the bend radius (see figure above)
% theta is the bend angle (see figure above)
% d is the pipe diameter

%parameters = [T, Q, mu, ro_d, dd, Rb, theta, d];
%parameters = [298, 3.3333e-4, 1.821e-5, 1011.9, 1e-5,.5,pi/2, .0254]

%% Constants
%Boltzmann constant (k) SI units: m2 kg s-2 K-1
k = 1.38064852e-23;

%% Parameters
%Carrier fluid
%Carrier fluid temperature (T) SI units: K
T = x(1);

%Carrier fluid flow rate (Q) SI units: m3 s-1
Q = x(2);

%Carrier fluid dynamic viscosity (mu) SI units: N s m-2
mu = x(3);

%Droplets
%Droplet density (ro_d) SI units: kg m-3
ro_d = x(4);

%Droplet diameter (dd) SI units: m
dd = x(5);

%Tube
%Radius of the bend (Rb) SI units: m
Rb = x(6);

%Bend angle (theta) SI units: radians
theta = x(7);

%Tube inner diameter (d) SI units: m
d = x(8);


%% Aerosol penetration (P)

%Tube inner radius (d) SI units: m
%Tube inner diameter (d) SI units: m
Rt = d/2;

%Curvature ratio (Ro) SI units: dimensionless
%Radius of the bend (Rb) SI units: m
%Tube inner radius (Rt) SI units: m
Ro = Rb/Rt;

%Fluid flow mean velocity (U) SI units: m s-1
%Carrier fluid flow rate (Q) SI units: m3 s-1
%Tube inner diameter (d) SI units: m
U = 4*Q/(pi*d^2);

%Cunningham slip correction (C)
%Mean free path of the carrier fluid (lambda)
%For air at std T and P: lambda = .067e-6;
%Avarege internal pressure (p) SI units: Pa
p=101325;
MM=28.97/(1000*6.02214179e23); %average molar mass air
%Model for the mean free path of the carrier fluid (lambda)
lambda = (mu/p)*sqrt((pi*k*T)/(2*MM));
%Droplet diameter (dd) SI units: m
C = 1 + (lambda/dd)*(2.34+1.05*exp(-.39*dd/lambda));

%Droplet relaxation time (td) SI units: s
%Cunningham slip correction (C) SI units: dimensionless
%Droplet density (ro_d) SI units: kg m-3
%Droplet diameter (dd) SI units: m
%Carrier fluid dynamic viscosity (mu) SI units: N s m-2
td = (C*ro_d*dd^2)/(18*mu);

%Stokes number (Stk) SI units: dimensionless
%Droplet relaxation time (t)
%Fluid flow mean velocity (U) SI units: m s-1
%Tube inner diameter (d) SI units: m
Stk = (2*td*U)/(d);

if (option == 1)
    %Model parameters (K, A and B). No clear physical meaning.
    K = 4*Stk/Ro;
    A = sqrt((1+sqrt(1+K^2))/2);
    B = K/(2*A);


    %Dimensionless coordinates (xi, eta) as a function of dimensionless time (tau)
    xi = @(tau)(cos(B*tau)*(cosh(A*tau)+(A^3/(A^2+B^2))*sinh(A*tau))-(B^3*sin(B*tau)*cosh(A*tau))/(A^2+B^2));
    eta = @(tau)(sin(B*tau)*(sinh(A*tau)+(A^3/(A^2+B^2))*cosh(A*tau))+(B^3*cos(B*tau)*sinh(A*tau))/(A^2+B^2));


    %The equations for xi and eta and the equations below are numerically unstable. Therefore, the next calculations will be performed symbolically. The last step will be the conversion from symbolic variable to double.
    syms tauTheta;
    syms etaTheta;
    syms zTheta;
    syms P;

syms a;
syms b;
    
    %Equation to find the dimensionless time at impact (tauTheta)
    %fun = @(tau)(tan(theta)-eta(tau)/xi(tau));
    %options = optimoptions('fsolve','MaxFunctionEvaluations',1000, 'PlotFcn', @optimplotx);
    %tauTheta= sym(fsolve(fun,10,options));
    tauTheta = vpasolve(tan(theta) == eta(b)/xi(b), b, [0,pi/2*1/B]);    
    
    etaTheta = eta(tauTheta);

    zTheta = sqrt(1-(Ro^2*(etaTheta-exp(tauTheta)*sin(theta))^2)/(etaTheta+exp(tauTheta)*sin(theta))^2);

    P = 1/(pi*Ro)*((exp(2*tauTheta)*(sin(theta))^2/etaTheta^2-1)*((Ro^2+1)*zTheta-zTheta^3/3)+Ro*(exp(2*tauTheta)*(sin(theta))^2/etaTheta^2+1)*(zTheta*sqrt(1-zTheta^2)+asin(zTheta)));

    P = double(P);

    
end

if (option == 2)
    %For (Stk << 1), the penetration can be approximated by: 
    P = 1-(2/pi + 1/Ro + 4/(3*pi*Ro^2))*Stk*theta;
end
%Deviation between the approximation and the full model
%Deviation = abs(P-P2);
%RelativeDeviation = Deviation/P;


end
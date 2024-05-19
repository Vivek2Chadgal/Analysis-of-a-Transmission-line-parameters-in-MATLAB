% Group-10
% Group Members
% Srihith Bansal (2021EEB1217)
% Vishakha Agarwal (2021EEB1221)
% Vivek Chadgal (2021EEB1222)

O = input('Type (0) for given Parameters/ Type (1) for giving new input parameters: ');
if O==0
    % Given parameters
    f = 50; % Frequency (Hz)
    L = 400; % Line length (km)
    V_s = 220e3; % Sending-end voltage (V)
    r = 0.125; % Resistance (Ω/km)
    x = 0.4; % Reactance (Ω/km)
    y = 2.8e-6; % Shunt admittance (℧/km)
else
    % Taking input from the user
    f = input('Enter frequency (Hz): ');
    L = input('Enter line length (km): ');
    V_s = input('Enter sending-end voltage (V): ');
    r = input('Enter resistance (Ω/km): ');
    x = input('Enter reactance (Ω/km): ');
    y = input('Enter shunt admittance (℧/km): ');
end

disp(' ')
% Line parameters
Z = (r + 1i*x); % Series impedance
Y = 1i*y; % Shunt admittance
Zc = sqrt(Z/Y);
% Calculate propagation constant
I_r = 0; % At no Load Conditions
gamma = sqrt(Z*Y);
disp('Choice of transmission line')
disp('0: Long')
disp('1: Short')
disp('2: Medium -pi Model')
v = input('Type of Transmission Line:');
if v == 0
    % No-load constants
    A = cosh(gamma*L);
    B = Zc*sinh(gamma*L);
    C = sinh(gamma*L)/Zc;
    D = A;
    disp('Long Transmission Line')

elseif v == 1
    % Short transmission line constants
    A = 1;
    B = conj(Z)*L;
    C = 0;
    D = A;
    disp('Short Transmission Line')

else
    % Medium transmission line constants (nominal Π-representation)
    A = (0.5*Z*Y*L*L)+1;
    B = Z*L;
    C = Y*L*(1+(0.25*Z*Y*L*L));
    D = A;
    disp('Medium Transmission Line Nominal-Π-Model')

end


M =[A, B; C, D];
disp(' ');
% Receiving-End Voltage
V_r = (V_s - M(1,2)*I_r) / M(1,1);

%Sending-End Current
I_s = (M(2,1)*V_r + M(2,2)*I_r)/sqrt(3);

disp('ABCD Parameters:');
disp(['A = ', num2str(M(1,1))]);
disp(['B = ', num2str(M(1,2)), 'ohm']);
disp(['C = ', num2str(M(2,1)),'mho']);
disp(['D = ', num2str(M(2,2))]);
disp(' ');
 
disp('Sending-end Current for No-load:');
disp(['I_s = ', num2str(abs(I_s)), ' ∠', num2str(rad2deg(angle(I_s))), ' degrees A']);
disp(' ');
disp('Receiving-end Voltage for No-load:');
disp(['V_r = ', num2str(abs(V_r)/1e3), ' kV ∠', num2str(rad2deg(angle(V_r))), ' degrees']);
disp(' ');


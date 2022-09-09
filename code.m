function [] = bowshock_and_magnetopause_shapes(planet,U_SW,n_SW,Rho_term_DIV_x_mp_nose,kappa,ecc_BS,BS_MP_ratio,x_max,show_BS,show_MP)
disp('--> bowshock_and_magnetopause_shapes.m')
% EK20220902
mercury=1;venus=2;earth=3;mars=4;jupiter=5;saturn=6;uranus=7;neptune=8;

% ========================================================
% ============= INPUTS ===================================
% ========================================================

% If the user has given only the name of the planet then use these default values:
if (nargin == 1)

    % --------- Earth: BEGIN ---------------
    % SW:
    U_SW     = 400;                  % km/s  AN USER GIVES THIS VARIABLE, THIS IS A DEFAULT VALUE
    n_SW     = 7;                    % cm^-3 AN USER GIVES THIS VARIABLE, THIS IS A DEFAULT VALUE

    % MP:
    Rho_term_DIV_x_mp_nose = 15/10;  % cm^-3 AN USER GIVES THIS VARIABLE, THIS IS A DEFAULT VALUE Kallio&Koskinen 2000
    kappa                  = 0.8;    %       AN USER GIVES THIS VARIABLE, THIS IS A DEFAULT VALUE ~ theory

    % BS:
    ecc_BS      = 1.16;              %      AN USER GIVES THIS VARIABLE, THIS IS A DEFAULT VALUE Kallio&Koskinen 2000
    BS_MP_ratio = 13.8/10;           %      AN USER GIVES THIS VARIABLE, THIS IS A DEFAULT VALUE Kallio&Koskinen 2000
    %BS_MP_ratio = 5/4;              %      AN USER GIVES THIS VARIABLE, THIS IS A DEFAULT VALUE ~ Spreiter&Stahara

    % Plot:
    show_BS = 1;                     % 1: show bow shock; Other: do not show bow shock
    show_MP = 1;                     % 1: show magnetopause; Other: do not show magnetopause
    x_max   = 20;                    % Show the axis range [-1 1 -1 1]*x_max

    % --------- Earth: END ---------------

end


% ========================================================
% === Test that the inputs are in the realistic range ====
% ========================================================
continue_code = false;

if planet == earth
    range_U_SW                   = [300 1000];   % km/s
    range_n_SW                   = [1 20];  % cm^-3
    range_Rho_term_DIV_x_mp_nose = [1.1 2];
    range_kappa                  = [0.5 1];
    range_ecc_BS                 = [1 2];
    range_BS_MP_ratio            = [1.1 2];
    range_x_max                  = [15 30];
    continue_code                = true;
end

% If the wanted planet has values (so if continue_code = true), check the values:
if continue_code

    if  ((U_SW < range_U_SW(1))||(U_SW > range_U_SW(2)))||...
        ((n_SW < range_n_SW(1))||(n_SW > range_n_SW(2)))||...
        ((Rho_term_DIV_x_mp_nose < range_Rho_term_DIV_x_mp_nose(1))||(Rho_term_DIV_x_mp_nose > range_Rho_term_DIV_x_mp_nose(2)))||...
        ((kappa < range_kappa(1))||(kappa > range_kappa(2)))||...
        ((ecc_BS < range_ecc_BS(1))||(ecc_BS > range_ecc_BS(2)))||...
        ((BS_MP_ratio < range_BS_MP_ratio(1))||(BS_MP_ratio > range_BS_MP_ratio(2)))||...
        ((x_max < range_x_max(1))||(x_max > range_x_max(2)))
        disp('The parameter is not in the correct range. Give a new value')
        continue_code = false;
    end

end

% ========================================================
% ============= Constants ================================
% ========================================================
x_label_STR = ' ';
y_label_STR = ' ';
title_STR   = ' ';

if (planet == mercury)&&continue_code
    disp('Mercury: To be done!')
end

if (planet == venus)&&continue_code
    disp('Venus: To be done!')
end

if (planet == earth)&&continue_code

    % ---- Paraboloid magnetopause:
    % Derive x_MP_nose:
    % Estimate the distance of the nose of the MB fron the pressure
    % balance: P_dyn = p_B = Bz^2/2mu
    % => Bz = sqrt(2*muu_o*P_dyn)/
    P_dyn   = kappa*(1.67e-27)*((U_SW*1e3)^2)*(n_SW*1e6);   % rooV2 [Pa]
    Bz = sqrt(2*4*pi*1e-7*P_dyn);
    % The position where that Bz is in the dipole field is at x_MP_nose where
    % Bz = Bo/R^3, where Bo is the magnetic field on the magnetic equator
    % (= 2*31000e-9 T) 2 becasue we take into accout MP currents which double the dipole field=>
    x_nose_MP = (2*31000e-9/Bz)^(1/3);   % subsolar distance [R_E]

    % Derive lamda_o and x_o_MP:
    Rho_term = Rho_term_DIV_x_mp_nose*x_nose_MP;
    lamda_o  = Rho_term/sqrt(2*x_nose_MP);
    x_o_MP   = x_nose_MP - lamda_o^2/2;

    % ---- Conic bow shock:

    x_o_BS    = BS_MP_ratio*x_o_MP;      % Linear transformation ("streching") along the x direction
    x_nose_BS = BS_MP_ratio*x_nose_MP;   % Linear transformation ("streching") along the x direction

    L_BS      = (x_nose_BS - x_o_BS)*(1 + ecc_BS);   % = BS_MP_ratio*(x_nose_MP - x_o_MP)*(1 + ecc_BS)



    % ---- Labels:
    x_label_STR = 'X [R_{Earth}]';
    y_label_STR = 'Y [R_{Earth}] ';

    axis_values = [-1 1 -1 1]*x_max;

    title_STR = ['Earth'];
    %title_STR = ['Earth: BS: e = ' num2str(e,4) ', L = ' num2str(L,4) ' R_E, xo = ' num2str(xo,4) ' R_E'];

end

if (planet == mars)&&continue_code
    disp('Mars: To be done!')
end

if (planet == jupiter)&&continue_code
    disp('Jupiter: To be done!')
end

if (planet == saturn)&&continue_code
    disp('Saturn: To be done!')
end

if (planet == uranus)&&continue_code
    disp('Uranus: To be done!')
end

if planet == neptune
    disp('Neptune: To be done!')
end


if continue_code
    % ========================================================
    % ============= CALCULATE ================================
    % ========================================================
    % This part of the code is similar for all planets:

    % ---- Conic Bow Shock:
    theta_max = 130;                                 % The position along BS is derived at these angles
    theta = 0:0.01:(theta_max*(pi/180));
    r_BS = L_BS./(1 + ecc_BS*cos(theta));

    x_BS = r_BS.*cos(theta) + x_o_BS;
    y_BS = r_BS.*sin(theta);

    % ---- Paraboloid magnetopause:
    muu_tmp_MP = 0:0.1:30;                             % The position along MP is derived at these muu coordinate values
    x_MP = (lamda_o.^2 - muu_tmp_MP.^2)/2 + x_o_MP;
    y_MP = lamda_o.*muu_tmp_MP;


    % ========================================================
    % ============= PLOT =====================================
    % ========================================================
    % This part of the code is similar for all planets:

    plot_planet = plot(sin(0:0.1:2*pi),cos(0:0.1:2*pi),'k-','Color','r');        % Planet
    hold on

    if (show_BS==1), plot(-x_BS,y_BS,'-r',-x_BS,-y_BS,'-r','linewidth',4); end  % Bow shock
    if (show_MP==1), plot(-x_MP,y_MP,'-b',-x_MP,-y_MP,'-b','linewidth',4); end  % Magnetopause
    hold off;

    grid on;
    axis image;
    axis(axis_values);

    xlabel(x_label_STR);
    ylabel(y_label_STR);
    title(title_STR)

    set(gcf,'color','w');
    %set(gca,'color','k');

end  % if continue

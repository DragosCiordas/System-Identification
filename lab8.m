load("lab8_7.mat");
u_id = id.u;
y_id = id.y; %se extrag datele de identificare


l = 0;  %counterul de iterarii l initializat
lmax = 150;  %numarul maxim de iteratii
alpha = 0.2; %pas de convergenta
delta = 1e-2;  %pragul de convergenta (treshold)
theta_0 = [1;1];  %[f_0;b_0]  parametrii initiali
theta_nou = [0;0];  %parametrii nou (theta_(l-1))

% se calculeaza formulele recursive pentru e(k) si de(k)/dtheta

% repeat until norm <= delta sau l_max a fost atins
while( (norm(theta_nou-theta_0) > delta) || (l < lmax) )
    b = theta_0(1,1);
    f = theta_0(2,1);
    N = length(u_id);
    
    %reinitializare
    gradient = 0;  %gradient
    hessian = 0;  %Hessian
    epsilon_derivat(1,1) = 0;
    epsilon_derivat(2,1) = 0;
    epsilon = zeros([1, N]);
    %epsilon(1) = yid(1);

    for k = 2:N  %se aplica formulele recursive dezvoltate la lab + date in pseudocod
        % formula 1:
        epsilon(k) = -f * epsilon(k-1) + y_id(k) + f * y_id(k-1) - b * u_id(k-1);
        % formula 2:
        epsilon_derivat(1,k) = -u_id(k-1) - f*epsilon(k-1);
        % formula 3:
        epsilon_derivat(2,k) = - epsilon(k-1) + y_id(k-1) - f*epsilon(k-1) ;

        % Gradientul functiei obiectiv:
        gradient = gradient + 2/N * epsilon(k) * epsilon_derivat(:,k);
        % Hessianul aproximat al functiei obiectiv:
        hessian = hessian + 2/N * epsilon_derivat(:,k) * epsilon_derivat(:,k)';
    end

    theta_0 = theta_0 - alpha*inv(hessian)*gradient;  % inv(H)*dV
    theta_nou = theta_0;
    l = l + 1;

end

B = [0 theta_nou(1,1)];
F = [1 theta_nou(2,1)];

model = idpoly(1,B,1,1,F,0,id.Ts);
figure, compare(model,val);
title("Compare: model OE cu idpoly vs. date de validare");

nb = n;
nf = n;
nk = 1;
model_OE = oe(id,[nb,nf,nk]);
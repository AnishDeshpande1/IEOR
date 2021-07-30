%Integral estimation using MC methods

%Parameter declaration:
N = 4000;
n = 400;
lmda = 0.1;
mu = 0.2;
Theta_m1 = zeros(N,1);
Theta_m2 = zeros(N,1);
%METHOD 1: RV TRANSFORM, RANDOM SAMPLING
for i = 1:N
    n_sample = 0;
    for j = 1:n
        U = rand();
        V = rand();
        temp = (lmda/(U*U))*exp(-lmda*((1-U)/U))*(mu/(V*V))*exp(-mu*((1-V)/V));
        n_sample = n_sample + temp*min((1/U)-1,(1/V)-1);
        
    end
   Theta_m1(i) = n_sample/n;
end
%METHOD 2: IMPORTANCE SAMPLING
for i = 1:N
    n_sample = 0;
    for j = 1:n
        n_sample = n_sample + min(exprnd(lmda),exprnd(mu));
    end
    Theta_m2(i) = n_sample/n;
end
%disp(Theta_m1);
%disp(Theta_m2);
Norm_Theta_m1 = (Theta_m1 - mean(Theta_m1))/mean(Theta_m1);
Norm_Theta_m2 = (Theta_m2 - mean(Theta_m2))/mean(Theta_m2);
disp("For random sampling, we get the average estimate to be:")
disp(mean(Theta_m1));
disp("The variance is:")
disp(var(Theta_m1));
disp("For importance sampling, we get the average estimate to be:")
disp(mean(Theta_m2));
disp("The variance is:")
disp(var(Theta_m2));

figure, hist(Theta_m1,250), title('Random Sampling'), ylabel('# of Theta_hats'), xlabel('Estimated Value');
figure, hist(Theta_m2,250), title('Importance Sampling'), ylabel('# of Theta_hats'), xlabel('Estimated Value');
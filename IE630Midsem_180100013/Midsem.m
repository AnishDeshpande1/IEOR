%SIMULATON CODE: IE 630 MIDSEM : ANISH DESHPANDE 180100013

%VARIABLES:
T = input("Enter T, Time to simulate until:");
N = input("Enter N, number of runs:"); %total number of times we run the simulation, i.e, # of paths.
n = input("Enter n, number of machines required for operation:");
s = input("Enter s, number of spare machines:");
mu = input("Enter mu, repair time parameter (exponential):");
a = input("Enter a, uniform dist parameter:");
b = input("Enter b, uniform dist parameter:");

%T = 700;
%N = 50000;
%n = 2;
%s = 4;
%mu = 0.0000001;
%a = 3;
%b = 7;
%COUNTERS:

%EVENT LIST

%OUTPUT REQUIRED
uEB = 0;
uER = 0;
cEB = 0;
cER = 0;

%INITIALISATION
t = 0.0;
r = 0;
t_star = 1000000;
ev_list = zeros(n,1);
%SIMULATION:
avg_breakdown_time = 0;
avg_extra_rep_t = 0;

cond_break = 0;
cond_repair = 0;
breakdown_ctr = 0;


for i=1:N
    t = 0.0;
    r = 0;
    t_star = 1000000;
    breakdown_time = 0;
    extra_rep_t = 0;
    for j=1:n
      ev_list(j) = a + (b-a)*rand();  
    end
    ev_list = sort(ev_list);
    while(t<T)
        if(ev_list(1)<t_star)
            t = ev_list(1);
            r = r+1;
            if(r==s+1)
                breakdown_time = t;
                breakdown_ctr = breakdown_ctr + 1;
                cond_break = cond_break + t;
                
                extra_rep_t = t_star - t;
                cond_repair = cond_repair + extra_rep_t;
                break;
            elseif(r<s+1)
                X = a + (b-a)*rand();
                ev_list(1) = t+X;
                ev_list = sort(ev_list);
            end
            if(r==1)
                Y = exprnd(1/mu);
                t_star = t + Y;
            end
            
            
        else
           t = t_star;
           r = r - 1;
           if(r>0)
               Y = exprnd(1/mu);
               t_star = t + Y;
           elseif(r==0)
               t_star = 1000000;
           end
           
        end
        if(t>=T)
            breakdown_time = T;
            extra_rep_t = 0;
            break;
        end
        %breakdown_time = t;
    end
    %disp(breakdown_time);
    avg_breakdown_time = avg_breakdown_time + breakdown_time; 
    avg_extra_rep_t = avg_extra_rep_t + extra_rep_t;
end
uEB = avg_breakdown_time/N;
uER = avg_extra_rep_t/N;

cEB = cond_break/breakdown_ctr;
cER = cond_repair/breakdown_ctr;

disp(uEB);
disp(uER);

disp(cEB);
disp(cER);

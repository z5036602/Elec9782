%%input:
%three real number or one complex and one real;
%%output:
%rho1,2,3 --> parameters of AR(3)  %r_0 = \gamma_0 
%output --> the output data of simulation 
function [rho1,rho2,rho3,r_0,output] = ar3_sim(varargin)

%%%input checking
    if (nargin ~= 2 && nargin ~= 3) error('Wrong number of inputs');end
    if(nargin == 3) 
        assert(isreal(varargin{1}),'all input must be real or one complex one real');
        assert(isreal(varargin{2}),'all input must be real or one complex one real');
        assert(isreal(varargin{3}),'all input must be real or one complex one real');
        root_vec = [varargin{1},varargin{2},varargin{3}];
        p = poly(root_vec);    %get the coefficients of a polynomial given roots of it.
    end
    if(nargin == 2) 
        assert((isreal(varargin{1}) && imag(varargin{2}) ~= 0)||(isreal(varargin{2}) && imag(varargin{1}) ~= 0),...
        'all input must be real or one complex one real' );
        root_vec = [varargin{1},varargin{2},conj(varargin{2})];
        p = poly(root_vec);        %get the coefficients of a polynomial given roots of it.
    end
T = 200;                           % number of simulation points   
y     = zeros(T+3,1);                 
y(1)  = 0;                         %y1,y2,y3 here are actually y(-1),y(-2),y(-3) for 
y(2)  = 0;                         %true y(1) kicked in at y(4);   
y(3)  = 0;                          
rho1  = -p(2);                     %first coefficient        
rho2  = -p(3);                     %second coefficient          
rho3  = -p(4);                     %third coefficient           
sigma = 1;                           
mu_e  = 0;                            
eps   = normrnd(mu_e, sigma, T, 1);   %creating white noises for final output 

%%% the actual recursive simulation
for t=4:T+3                         
    y(t) = rho1*y(t-1) + rho2*y(t-2) + rho3*y(t-3) + eps(t-3);    
end
%%% constructing the matrix to caculate the r_0,r_1,r_2,r_4
% this is contructed from system of linear equations of four unknowns 
col_1 = [-1,rho1,rho2,rho3];
col_2 = [rho1,rho2-1,rho3+rho1,rho2];
col_3 = [rho2,rho3,-1,rho1];
col_4 = [rho3,0,0,-1];

A = [col_1;col_2;col_3;col_4].';
b = [-sigma^2,0,0,0].';
r = A\b;                            %we got result as [r_0,r_1,r_2,r_3]       
r_0 = r(1);                         
output = y(4:end);                  %trim out the proper output data


%Plot the series
figure
plot((y(4:end)));
title('AR(3)');
xlabel('t')
ylabel('y(t)')
end
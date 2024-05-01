%%
clear all
close all
clc
%%% Algorithm checked with part5-slide 17 example

m = 3; % field extension degree
q = 2^m; 

n = 7; 
k = 5; 
d = 3;

g = rsgenpoly(n, k, d, q); 


% message word a(x) = x^3+alpha, highest degree of a(x)=k-1
msg = [0 , 1 , 0, 0, 2];
a = gf(msg, m);  

% Ensure the message word and generator polynomial belong to the same field
a = gf(a.x, m, g.prim_poly);

encoded_word = conv(a, g); %this way it will be non-systematic

%systematic encoding a(x)*x^(n-k)
a = [a zeros(1, n - k)];
[quot, rem] = deconv(a, g);
syst_a = a+rem  
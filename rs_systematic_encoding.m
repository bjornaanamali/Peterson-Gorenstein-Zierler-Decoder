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
encoded_word = a+rem;
disp('Encoded word:')
disp(encoded_word.x)

% Adding errors to the encoded word
seed = 42;
rng(seed); 
N = 1; % add 1 error
error_idx = randperm(n, N);
error_val = gf(randi([1 q-1], N, 1), m, g.prim_poly);
disp(['Error to be added in position ', num2str(error_idx), ': ', num2str(error_val.x)]);
errorVector = gf(zeros(1, n), m, g.prim_poly);
errorVector(error_idx) = error_val;
noisyEncodedWord = encoded_word + errorVector;


disp('Noisy Encoded Word:');
disp(noisyEncodedWord.x);

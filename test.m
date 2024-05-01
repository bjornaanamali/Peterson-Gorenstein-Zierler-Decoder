clear all,
close all;
clc;

q = 9; % Alphabet size
d = 1;  % Distance (d=n-k+1)
N = 1;  % Hamming weight of error
seede = 42;
seedc = 42;
p = 0;
m = 0;

% % p^m=q with p prime has to be determined. We iterate over all p prime
% for base = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97] % all prime numbers <100
%     exp = log(q)/log(base);
%     if mod(exp, 1) < 1e-9
%         p = round(base);
%         m = round(exp);
%         break;
%     end
%     % If no p^m=q is found p is set to 2
%     if base == 97
%         m = ceil(log2(q));
%         p = 2;
%     end
% end

p = ceil(log2(q)); 
n = p^m - 1; % Code block length
k = n-d+1; % Message length

% Create Reed-Solomon encoder and decoder
enc = comm.RSEncoder(n, k);
dec = comm.RSDecoder(n, k);

% Generate random information vector
rng(seedc);
info = randi([0 q-1], k, 1);
info_tp = gftuple(info,m,p);

%%
% Encode information
coded = step(enc, info);

% Introduce errors
rng(seede);
errorIndices = randperm(n, N);
errorVector = zeros(n, 1);
errorVector(errorIndices) = randi([1 q-1], length(errorIndices), 1);
noisyCoded = mod(coded + errorVector, q);

% Decode
decoded = step(dec, noisyCoded)

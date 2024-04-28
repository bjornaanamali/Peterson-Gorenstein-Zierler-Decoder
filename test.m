clear all,
close all;
clc;

q = 16;
d = 1;
N = 1;
seede = 42;
seedc = 42;

m = ceil(log2(q)); % Length of symbol in bits
n = 2^m - 1; % Code block length
k = n - 2*d; % Message length

% Create Reed-Solomon encoder and decoder
enc = comm.RSEncoder(n, k);
dec = comm.RSDecoder(n, k);

% Generate random information vector
rng(seedc);
info = randi([0 q-1], k, 1)

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

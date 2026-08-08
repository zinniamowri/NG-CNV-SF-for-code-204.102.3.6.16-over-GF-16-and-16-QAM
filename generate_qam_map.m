function [qam, qam_binary_map] = generate_qam_map(M, q)

% M = QAM size (16, 64, ...)
% q = GF size (16, 64, ...)

if log2(M) ~= log2(q)
    error('M and GF(q) must have same number of bits');
end

bits = log2(M);
bits_axis = bits / 2;

if mod(bits,2) ~= 0
    error('Only square QAM supported');
end

L = 2^bits_axis;

% Gray-coded decimal order
gray = bitxor((0:L-1)', floor((0:L-1)'/2));

% Convert to binary rows without using de2bi
gray_bits = dec2bin(gray, bits_axis) - '0';

% Amplitude levels
levels = -(L-1):2:(L-1);

qam = zeros(M,1);
qam_binary_map = zeros(M,bits);

idx = 1;
for i = 1:L
    for j = 1:L
        qam(idx) = levels(i) + 1i*levels(j);
        qam_binary_map(idx,:) = [gray_bits(i,:) gray_bits(j,:)];
        idx = idx + 1;
    end
end

end
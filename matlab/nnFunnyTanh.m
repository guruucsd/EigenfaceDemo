function y = nnFunnyTanh(x)
z = 2*x/3;
y = (exp(z) - exp(-z)) ./ (exp(z) + exp(-z));
y = 1.7159*y;
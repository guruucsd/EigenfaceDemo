function probs = nnSoftmax(phi)
% nnSoftmax : Neural classifier softmax

% Determine the number of examples
exam=size(phi,1);

% Expand output unit outputs with 'dummy' zeros for the last class
c=size(phi,2);

% Offsets for numerical trick
offsets = max(phi')';

% Apply exp() to output unit outputs (using numerical trick)
phi = exp(phi-kron(ones(1,c),offsets));

  
% Denominators for the softmax  
tmp = sum(phi')';
denom = ones(size(tmp)) ./ tmp;


% Compute softmax probabilities for each example
probs=phi.*kron(ones(1,c),denom);
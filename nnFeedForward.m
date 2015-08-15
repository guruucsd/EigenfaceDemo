function net = nnFeedForward(net, patterns, targets)
% Description:
%   calculate the hidden-units and the output-units with the input "patterns";
%   compare the output with "targets" to get error.
% Usage:
%   function net = nnForwardOnce(
%       net,        % the bp-net
%       patterns,   % the input, a [n, net.nInputUnits] matrix
%       targets     % the expected output, a [n, net.nOutputUnits] matrix
%   )

nPatterns = size(patterns,1);
net.vInputs = patterns;
net.vHiddenUnits = nnFunnyTanh([net.vInputs ones(nPatterns,1)]*net.vHiddenUnitWeights);
net.vOutputs = nnFunnyTanh([net.vHiddenUnits ones(nPatterns,1)]*net.vOutputUnitWeights);
if (nargin==3)
    net.vErrors = targets - net.vOutputs;
end;
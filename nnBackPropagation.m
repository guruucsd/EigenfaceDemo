function net = nnBackPropagation(net)
% Description:
%   update the output unit weights and hidden unit weights
% Usage:
%   function net = nnBackPropagation(net)

% Calculate the deltas
net.vDeltaOutputUnitWeights = net.vErrors .* (1.7159 - net.vOutputs .* net.vOutputs/1.7159) *2/3;

net.vDeltaHiddenUnitWeights = net.vDeltaOutputUnitWeights * net.vOutputUnitWeights(1:net.nHiddenUnits,:)' ...
    .* (1.7159 - net.vHiddenUnits .* net.vHiddenUnits/1.7159) *2/3;

% update the weights for output units
net.vMomentumOutputUnitWeights = net.dOutputUnitLearningRate * ([net.vHiddenUnits 1]' * net.vDeltaOutputUnitWeights ...
    + net.dMomentumLearningRate * net.vMomentumOutputUnitWeights);
net.vOutputUnitWeights = net.vOutputUnitWeights + net.vMomentumOutputUnitWeights;

% update the weights for hidden units
net.vMomentumHiddenUnitWeights = net.dHiddenUnitLearningRate * ([net.vInputs 1]' * net.vDeltaHiddenUnitWeights ...
    + net.dMomentumLearningRate * net.vMomentumHiddenUnitWeights);
net.vHiddenUnitWeights = net.vHiddenUnitWeights + net.vMomentumHiddenUnitWeights;
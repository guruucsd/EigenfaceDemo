function net = nnCreateNet(nInputUnits, nHiddenUnits, nOutputUnits, ...
    dHiddenUnitLearningRate, dOutputUnitLearningRate, dMomentumLearningRate)
% Description:
%   create a bp-net according to user's configuration.
% Usage:
%   net = nnCreate(
%       nInputUnits,                % number of input units
%       nHiddenUnits,               % number of hidden units
%       nOutputUnits,               % number of output units
%       dHiddenUnitLearningRate,    % learning rate of hidden units
%       dOutputUnitLearningRate,    % learning rate of output units
%       dMomentumLearningRate       % momentum learning rate
%   )

% set the parameters of the bp-net according to user's configuration
net.nInputUnits                 = nInputUnits;              % number of input units
net.nHiddenUnits                = nHiddenUnits;             % number of hidden units
net.nOutputUnits                = nOutputUnits;             % number of output units
net.dHiddenUnitLearningRate     = dHiddenUnitLearningRate;  % learning rate of hidden units
net.dOutputUnitLearningRate     = dOutputUnitLearningRate;  % learning rate of output units
net.dMomentumLearningRate       = dMomentumLearningRate;    % momentum learning rate

% set the initial weights for the hidden units and the output units
net.vHiddenUnitWeights          = rand(net.nInputUnits+1, net.nHiddenUnits);
net.vOutputUnitWeights          = rand(net.nHiddenUnits+1, net.nOutputUnits);

% normalize the initial weights to have a standard deviation as 1/sqrt(m)
net.vHiddenUnitWeights          = net.vHiddenUnitWeights - repmat(sum(net.vHiddenUnitWeights)/(net.nInputUnits+1), net.nInputUnits+1, 1);
net.vHiddenUnitWeights          = net.vHiddenUnitWeights ./ repmat(std(net.vHiddenUnitWeights)*sqrt(net.nInputUnits), net.nInputUnits+1, 1);
net.vOutputUnitWeights          = net.vOutputUnitWeights - repmat(sum(net.vOutputUnitWeights)/(net.nHiddenUnits+1), net.nHiddenUnits+1, 1);
net.vOutputUnitWeights          = net.vOutputUnitWeights ./ repmat(std(net.vOutputUnitWeights)*sqrt(net.nHiddenUnits), net.nHiddenUnits+1, 1);

% define variables for the bp-net components
net.vInputs                     = [];   % inputs        : [n, net.nInputUnits]
net.vHiddenUnits                = [];   % hidden units  : [n, net.nHiddenUnits]
net.vOutputs                    = [];   % outputs       : [n, net.nOutputUnits]
net.vErrors                     = [];   % errors        : [n, net.nOutputUnits]
net.vDeltaHiddenUnitWeights     = [];   % delta         : 
net.vDeltaOutputUnitWeights     = [];   % delta         :
net.vMomentumHiddenUnitWeights  = zeros(net.nInputUnits+1, net.nHiddenUnits);
net.vMomentumOutputUnitWeights  = zeros(net.nHiddenUnits+1, net.nOutputUnits);

% variables used for the repeated learning process
net.nEpoch                      = 0;
net.vRMSEonTrainingData         = [];
net.vRMSEonValidationData       = [];
net.vRMSEonTestData             = [];
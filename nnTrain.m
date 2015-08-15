function net = nnTrain(net, patterns, targets, nValidationData, nTestData, nMaxEpochs, dExpectedRMSE)
% Description:
%   train the bp-net with inputs "patterns" and target "targets"
% Usage:
%   net = nnTrain(
%       net,            % bp-net created by nnCreate
%       patterns,       % input patterns, should be a matrix of size (nPatterns, net.nInputSize)
%       targets,        % targets, should be a matrix of size (nPatterns, net.nOutputSize)
%       nValidationData,% how many patterns in the input "patterns" should be used as validations
%       vTestData,      % "patterns" used as test data, should be manually specified as an array of integers
%       nMaxEpochs,     % how many epochs should the training process repeat
%       dExpectedRMSE   % what's the best RMSE this training process is expecting
%   )

% The best RMSE we have found during the training process
dBestRMSE = Inf;

% Record the changes of RMSE during the training process
net.vRMSEonTrainingData = zeros(1,nMaxEpochs);
net.vRMSEonValidationData = zeros(1,nMaxEpochs);
net.vRMSEonTestData = zeros(1,nMaxEpochs);

% Pick the specified test data
%nTestData = size(vTestData,2);
%testPatterns = zeros(nTestData, net.nInputUnits);
%testTargets = zeros(nTestData, net.nOutputUnits);
%for i = 1:nTestData
%    testPatterns(i,:) = patterns(vTestData(i),:);
%    testTargets(i,:) = targets(vTestData(i),:);
%end

% Get the patterns and targets left after picking the test data out
nPatterns = size(patterns,1);
%leftPatterns = zeros(nPatterns - nTestData, net.nInputUnits);
%leftTargets = zeros(nPatterns - nTestData, net.nOutputUnits);
%start = 1;
%for i = 1:nTestData
%    leftPatterns(start-i+1:vTestData(i)-i,:) = patterns(start:vTestData(i)-1, :);
%    leftTargets(start-i+1:vTestData(i)-i,:) = targets(start:vTestData(i)-1, :);
%    start = vTestData(i)+1;
%end;    
%leftPatterns(start-nTestData:nPatterns-nTestData,:) = patterns(start:nPatterns, :);
%leftTargets(start-nTestData:nPatterns-nTestData,:) = targets(start:nPatterns, :);

% Calculate the number of training data
nTrainingData = nPatterns - nValidationData - nTestData;
perm = randperm(nPatterns);
for i = 1:nPatterns
    leftPatterns(i,:) = patterns(perm(i),:);
    leftTargets(i,:) = targets(perm(i),:);
end


% Do bp-net training for nMaxEpochs times, or until dExpectedRMSE has reached
for epoch = 1:nMaxEpochs
    net.nEpoch = net.nEpoch + 1;
    
    % Reshuffle the data
    perm = randperm(nPatterns - nTestData-nValidationData);
    for i = 1:nPatterns-nTestData-nValidationData
        reshuffledPatterns(i,:) = leftPatterns(perm(i),:);
        reshuffledTargets(i,:) = leftTargets(perm(i),:);
    end
    
    % Search for nValidationData validation data
    %vValidationData = zeros(1,net.nOutputUnits);    
    
    % Compute the RMSE before backpropagation
    dDenominatorOfRMSE = sum(sum((reshuffledTargets(1:nTrainingData,:)-repmat(sum(reshuffledTargets(1:nTrainingData,:),1)./nTrainingData,nTrainingData,1)).^2,1),2);
    net = nnFeedForward(net, reshuffledPatterns(1:nTrainingData,:), reshuffledTargets(1:nTrainingData,:));
    dNumeratorfRMSE = sum(sum(net.vErrors.^2));
    net.vRMSEonTrainingData(net.nEpoch) = dNumeratorfRMSE/dDenominatorOfRMSE;
    if (rem(net.nEpoch, 10) == 0 | net.nEpoch == 1)
        fprintf(1, 'Epoch %d RMSE = %f\n', net.nEpoch, net.vRMSEonTrainingData(net.nEpoch));
    end

    % Feedforward and Backpropagation on training data
    for i = 1:nTrainingData
        net = nnFeedForward(net, reshuffledPatterns(i,:), reshuffledTargets(i,:));
        net = nnBackPropagation(net);
    end
  
    % Feedforward on validation data
    if nValidationData > 0
        net = nnFeedForward(net, leftPatterns(nTrainingData+1:nTrainingData+nValidationData,:), leftTargets(nTrainingData+1:nTrainingData+nValidationData,:));
        dDenominatorOfRMSE = sum(sum((leftTargets(nTrainingData+1:nTrainingData+nValidationData,:)-repmat(sum(leftTargets(nTrainingData+1:nTrainingData+nValidationData,:),1)./nValidationData,nValidationData,1)).^2,1),2);
        esum = sum(sum(net.vErrors.^2));
        if (dDenominatorOfRMSE==0)
            net.vRMSEonValidationData(net.nEpoch) = 5;
        else
            net.vRMSEonValidationData(net.nEpoch) = esum/dDenominatorOfRMSE;
        end;
        if (net.vRMSEonValidationData(net.nEpoch) < dBestRMSE | epoch==1)
            dBestRMSE = net.vRMSEonValidationData(net.nEpoch);
            bestnet.vHiddenUnitWeights = net.vHiddenUnitWeights;
            bestnet.vOutputUnitWeights = net.vOutputUnitWeights;
        end
    end

    % Feedforward on test data
    if nTestData > 0
        net = nnFeedForward(net, leftPatterns(nPatterns-nTestData+1:nPatterns,:), leftTargets(nPatterns-nTestData+1:nPatterns,:));
        dDenominatorOfRMSE = sum(sum((leftTargets(nPatterns-nTestData+1:nPatterns,:)-repmat(sum(leftTargets(nPatterns-nTestData+1:nPatterns,:),1)./nTestData,nTestData,1)).^2,1),2);
        esum = sum(sum(net.vErrors.^2));
        if (dDenominatorOfRMSE==0) 
            dDenominatorOfRMSE = 2;
        end;
        net.vRMSEonTestData(net.nEpoch) = esum/dDenominatorOfRMSE;
    end
    
    % Stop early if we have reached the expected RMSE
    if (net.vRMSEonTrainingData(net.nEpoch) <= dExpectedRMSE)
        fprintf(1, 'Epoch %d RMSE = %f\n', net.nEpoch, net.vRMSEonTrainingData(net.nEpoch));
        break;
    end
end

% Now use best weights
if nValidationData > 0
    net.vHiddenUnitWeights = bestnet.vHiddenUnitWeights;
    net.vOutputUnitWeights = bestnet.vOutputUnitWeights;
end
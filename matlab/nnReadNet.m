function net = nnReadNet(filename)
% Description:
%   create a bp-net and read the net configuration from the file.
% Usage:
%   net = nnReadNet(
%       filename       % the file that stores information about the net.
%   )
% File format:
%   input_size
%   hidden_size
%   output_size
%   bias[1..hidden_size+output_size]
%   input->hidden weight_matrix row 0
%   input->hidden weight_matrix row 1
%   ...
%   input->hidden weight_matrix row hidden_size-1
%   hidden->output weight_matrix row 0
%   hidden->output weight_matrix row 1
%   ...
%   hidden->output weight_matrix row output_size-1
 
% Open the file
fid = fopen(filename,'r');
if (fid < 0)
    error(['Cannot open the file "' filename, '"']);
end;

% input_size
nInputUnits = fscanf(fid,'%d \n', 1);
% hidden_size
nHiddenUnits = fscanf(fid,'%d \n', 1);
% output_size
nOutputUnits = fscanf(fid,'%d \n', 1);

% create a net
net = nnCreateNet(nInputUnits, nHiddenUnits, nOutputUnits, 0.01, 0.01, 0.9);

% bias[1..hidden_size+output_size]
net.vHiddenUnitWeights(net.nInputUnits+1,:) = fscanf(fid, '%g ', net.nHiddenUnits);
net.vOutputUnitWeights(net.nHiddenUnits+1,:) = fscanf(fid, '%g ', nOutputUnits);

% input->hidden weight_matrices
for i = 1:net.nHiddenUnits
    net.vHiddenUnitWeights(1:net.nInputUnits,i) = (fscanf(fid, '%g ', net.nInputUnits))';
end

% hidden->output weight_matrices
for i = 1:net.nOutputUnits
    net.vOutputUnitWeights(1:net.nHiddenUnits,i) = (fscanf(fid, '%g ', net.nHiddenUnits))';
end

% Close the file when done
fclose(fid);
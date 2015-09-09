function nnWriteNet(net, filename)
% Description:
%   write a bp-net to file.
% Usage:
%   nnWriteNet(
%       net,            % the net that you want to store
%       filename        % the file that stores information about the net.
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
fid = fopen(filename,'w');
if (fid < 0)
    error(['Cannot open the file "' filename, '"']);
end;

% input_size
fprintf(fid,'%d \n', net.nInputUnits);
% hidden_size
fprintf(fid,'%d \n', net.nHiddenUnits);
% output_size
fprintf(fid,'%d \n', net.nOutputUnits);

% bias[1..hidden_size+output_size]
for i = 1:net.nHiddenUnits
    fprintf(fid, '%g ', net.vHiddenUnitWeights(net.nInputUnits+1,i));
end
for i = 1:net.nOutputUnits
    fprintf(fid, '%g ', net.vOutputUnitWeights(net.nHiddenUnits+1,i));
end
fprintf(fid, '\n');

% input->hidden weight_matrices
for i = 1:net.nHiddenUnits
    fprintf(fid, '%g ', net.vHiddenUnitWeights(1:net.nInputUnits,i));
    fprintf(fid, '\n');
end

% hidden->output weight_matrices
for i = 1:net.nOutputUnits
    fprintf(fid, '%g ', net.vOutputUnitWeights(1:net.nHiddenUnits,i));
    fprintf(fid, '\n');
end

% Close the file when done
fclose(fid);
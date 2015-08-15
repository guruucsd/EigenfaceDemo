function lc = pgmLineCount(filename)
% pgmLineCount : Count the number of lines in given file
%
%          LC = pgmLineCount(FILENAME) Returns LC, the number of
%          lines in text file named FILENAME, or 0 if the file
%          does not exist or is not readable.
%
% Matthew Dailey 2000

lc = 0;
fid = fopen(filename,'r');
if (fid < 0) return; end;
while (1)
    ln = fgetl(fid);
    if ~ischar(ln) break; end;
    if isempty(ln) continue; end;
    lc = lc + 1;
end;
fclose(fid);

% loading signal package
pkg load signal

% Take the I/Q data file name from the command line
inputFile=argv(){1};
outputFile=argv(){2};


%-------------------------------------------------------------------------------
% Read data from the file
fprintf("Reading file...\n");
fflush(stdout);
%filePtr = fopen('./data/hackrf-F343000000-S20000000-a0-l24-g20-2018-03-22-19:06:01.iq');
filePtr = fopen(inputFile);
data = fread(filePtr, 'int8');
fclose(filePtr);

% Build the complex IQ vector
fprintf("Building complex IQ vector...\n");
fflush(stdout);
inphase = data(1:2:end);
quadrature = data(2:2:end);
IQData = inphase+1i*quadrature;

%------------------------------------------------------------------------------


% Filtering data
% The sampling frequency in Hz.
fprintf("Band-pass Filtering IQ data...\n");
fflush(stdout);
Fsam = 8000000;
%Fsam = 20000000;
Fnyq = Fsam/2;
minfreq =  500000;
maxfreq = 2500000;
[b, a] = butter(20,[minfreq maxfreq]/Fnyq);
IQData=filter(b, a, IQData);


%-------------------------------------------------------------------------------
% Write data to a file
% First, preallocate the interleaved array.
fprintf("Creating zero-filled IQ interleaved vector...\n");
fflush(stdout);
IQInterleaved = zeros(size(data));

fprintf("Filling the real part of IQ interleaved vector...\n");
fflush(stdout);
IQInterleaved(1:2:end) = real(IQData)(1:1:end);

fprintf("Filling the imagined part of IQ interleaved vector...\n");
fflush(stdout);
IQInterleaved(2:2:end) = imag(IQData)(1:1:end);
IQInterleaved=int8(IQInterleaved);

fprintf("Writing file...\n");
fflush(stdout);
%filePtr = fopen('hackrf-octave-data.iq', 'w');
filePtr = fopen(outputFile, 'w');
data = fwrite(filePtr, IQInterleaved, 'int8');
fclose(filePtr);

fprintf("Done\n");
fflush(stdout);
%-------------------------------------------------------------------------------

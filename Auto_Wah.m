% Auto Wah Effect

% Load an audio file
[input_wave, Fs] = audioread('disco-funk.wav');

% Define the parameters
LFO_frequency = 10; % Frequency of the low-frequency oscillator (LFO)
depth = 0.5; 
t = (0:length(input_wave)-1)/Fs; % Time vector for LFO
LFO = depth * sin(2*pi*LFO_frequency*t); % Generate LFO

% Ensure length of LFO matches the length of input_wave
if length(LFO) > length(input_wave)
    LFO = LFO(1:length(input_wave));
elseif length(LFO) < length(input_wave)
    LFO = [LFO, zeros(1, length(input_wave) - length(LFO))];
end

% Apply auto wah effect
output_wave = input_wave .* (1 + LFO');

% Normalize the output
output_wave = output_wave / max(abs(output_wave));

% Play the original audio
sound(input_wave, Fs);
pause(length(input_wave)/Fs); % Pause for the duration of the original audio

% Play the processed audio
sound(output_wave, Fs);

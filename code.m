%% Task 1

%Converting wav file to amplitude arrays
[music_array ,music_fs] = audioread('music16khz.wav');
[speech_array,speech_fs] = audioread('speech8khz.wav');

%% Magnitude response of both the signals

music_amplitude = abs(fft(music_array));
speech_amplitude = abs(fft(speech_array));

% Generating all the frequencies

music_frequency = transpose((0:length(music_amplitude)-1)*music_fs/length(music_amplitude));
speech_frequency = transpose((0:length(speech_amplitude)-1)*speech_fs/length(speech_amplitude));

%% Plotting the music signal

hold on;
xlabel('Frequency');
ylabel('Magnitude');
title('Magnitude Response of music16khz.wav');
plot(music_frequency,music_amplitude);
hold off;
exportgraphics(gcf,'Plots/Music16Khz_MagnitudeResponse.png','Resolution',300)
%% Plotting the speech signal

hold on;
xlabel('Frequency');
ylabel('Magnitude');
title('Magnitude Response of speech8khz.wav');
plot(speech_frequency,speech_amplitude);
hold off;
exportgraphics(gcf,'Plots/Speech_8Khz_MagnitudeResponse.png','Resolution',300)

%% Downsample by 2

music_ds_array = downsample(music_array,2);
speech_ds_array = downsample(speech_array,2);

% Fourier transform of both the signals

music_ds_amplitude = abs(fft(music_ds_array));
speech_ds_amplitude = abs(fft(speech_ds_array));

% Create the X - axis for downsampled signals

speech_ds_fs = speech_fs/2;
music_ds_fs = music_fs/2;

music_ds_frequency = transpose((0:length(music_ds_amplitude)-1)*music_ds_fs/length(music_ds_amplitude));
speech_ds_frequency = transpose((0:length(speech_ds_amplitude)-1)*speech_ds_fs/length(speech_ds_amplitude));

%% Plotting the music signal

hold on;
xlabel('Frequency');
ylabel('Magnitude');
title('Magnitude Response of Downsampled music16khz.wav');
plot(music_ds_frequency,music_ds_amplitude);
hold off;
exportgraphics(gcf,'Plots/Music16Khz_ds_MagnitudeResponse.png','Resolution',300)
%% Plot the speech signal

hold on;
xlabel('Frequency');
ylabel('Magnitude');
title('Magnitude Response of Downsampled speech8khz.wav');
plot(speech_ds_frequency,speech_ds_amplitude);
hold off;
exportgraphics(gcf,'Plots/Speech_8Khz_ds_MagnitudeResponse.png','Resolution',300)

%% convert to audio files

audiowrite('Audio/music16khz_ds.wav',music_ds_array,music_ds_fs);
audiowrite('Audio/speech8khz_ds.wav',speech_ds_array,speech_ds_fs);

%% Task 2 : Equiripple LPF Filter

%% Design Filter

Hd = fdesign.lowpass('Fp,Fst',0.45,0.55);
d = design(Hd,'equiripple');

%Plot the Magnitude Response of the Filter
fvtool(d);
exportgraphics(gcf,'Plots/Filter MagnitudeResponse.png','Resolution',300)
%% Filter and downsample the signals

%Pass the signals through the AA Filter
music_AA_array = filter(d,music_array);
speech_AA_array = filter(d,speech_array);

%Downsample the signals
music_AA_ds_array = downsample(music_array,2);
speech_AA_dsarray = downsample(speech_array,2);

%Apply Fourier transform
music_AA_ds_amplitude = abs(fft(music_AA_ds_array));
speech_AA_ds_amplitude = abs(fft(speech_AA_dsarray));

%% Plot the music signal
hold on;
xlabel('Frequency');
ylabel('Magnitude');
title('Magnitude Response of Downsampled music16khz.wav after filtering');
plot(music_ds_frequency,music_AA_ds_amplitude);
hold off;
exportgraphics(gcf,'Plots/Music_16Khz_ds_AA_MagnitudeResponse.png','Resolution',300)
%% Plot the speech Signal

hold on;
xlabel('Frequency');
ylabel('Magnitude');
title('Magnitude Response of Downsampled speech8khz.wav after filtering');
plot(speech_ds_frequency,speech_AA_ds_amplitude);
hold off;
exportgraphics(gcf,'Plots/Speech_8Khz_ds_MagnitudeResponse.png','Resolution',300)

%% Convert to Audio Files

audiowrite('Plots/music16khz_ds_filtered.wav',music_ds_array,music_ds_fs);
audiowrite('Plots/speech8khz_ds_filtered.wav',speech_ds_array,speech_ds_fs);

%% Task 3

Hd2 = fdesign.lowpass('Fp,Fst',0.22,0.28);
d2 = design(Hd2,'equiripple');

%Plot the Magnitude Response of the Filter
fvtool(d2);

exportgraphics(gcf,'Plots/Filter2MagnitudeResponse.png','Resolution',300)

%% Task 4

%Upsampling by 3
music_us_array = upsample(music_array,3);
speech_us_array = upsample(speech_array,3);

music_us_amplitude = abs(fft(music_us_array));
speech_us_amplitude = abs(fft(speech_us_array));

%Passing the array through AA filter
music_us_AA_array = filter(d2,music_us_array);
speech_us_AA_array = filter(d2,speech_us_array);

%Downsampling by 4
music_us_AA_ds_array = downsample(music_us_AA_array,4);
speech_us_AA_ds_array = downsample(speech_us_AA_array,4);

%Converting to get Magnitude Response
music_us_AA_ds_amplitude = abs(fft(music_us_AA_ds_array));
speech_us_AA_ds_amplitude = abs(fft(speech_us_AA_ds_array));

music_us_fs = music_fs*3;
speech_us_fs = speech_fs*3;

music_us_ds_fs = music_us_fs/4;
speech_us_ds_fs = speech_us_fs/4;

music_us_frequency = transpose((0:length(music_us_amplitude)-1)*music_us_fs/length(music_us_amplitude));
speech_us_frequency = transpose((0:length(speech_us_amplitude)-1)*speech_us_fs/length(speech_us_amplitude));

music_us_ds_frequency = transpose((0:length(music_us_AA_ds_amplitude)-1)*music_us_ds_fs/length(music_us_AA_ds_amplitude));
speech_us_ds_frequency = transpose((0:length(speech_us_AA_ds_amplitude)-1)*speech_us_ds_fs/length(speech_us_AA_ds_amplitude));

%% Plotting upsampling only

%% Plot the music signal
hold on;
xlabel('Frequency');
ylabel('Magnitude');
title('Magnitude Response of Upsampled music16khz.wav');
plot(music_us_frequency,music_us_amplitude);
hold off;
exportgraphics(gcf,'Plots/Music_16Khz_us_MagnitudeResponse.png','Resolution',300)
%% Plot the speech Signal

hold on;
xlabel('Frequency');
ylabel('Magnitude');
title('Magnitude Response of Upsampled speech8khz.wav');
plot(speech_us_frequency,speech_us_amplitude);
hold off;
exportgraphics(gcf,'Plots/Speech_8Khz_MagnitudeResponse_us.png','Resolution',300)

%% Plot upsampling, filtering and downsampled  

%% Plot the music signal
hold on;
xlabel('Frequency');
ylabel('Magnitude');
title('Magnitude Response of Upsampled and then downsampled music16khz.wav after filtering');
plot(music_us_ds_frequency,music_us_AA_ds_amplitude);
hold off;
exportgraphics(gcf,'Plots/Music_16Khz_us_ds_AA_MagnitudeResponse.png','Resolution',300)

%% Plot the speech Signal

hold on;
xlabel('Frequency');
ylabel('Magnitude');
title('Magnitude Response of Upsampled and then downsampled speech8khz.wav after filtering');
plot(speech_us_ds_frequency,speech_us_AA_ds_amplitude);
hold off;
exportgraphics(gcf,'Plots/Speech_8Khz_us_ds_AA_MagnitudeResponse.png','Resolution',300)

%% Convert to audio

audiowrite('Audio/music16khz_us_ds_filtered.wav',music_us_AA_ds_array,music_us_ds_fs);
audiowrite('Audio/speech8khz_us_ds_filtered.wav',speech_us_AA_ds_array,speech_us_ds_fs);

%% Task 5
%Interpolation Filter Design
h1 = intfilt(3,3,1);
n_imp = linspace(-8,8,length(h1));
h1_mag = fftshift(fft(h1),17);
fvtool(h1);

exportgraphics(gcf,'Plots/Interpolation_Filter_MagnitudeResponse.png','Resolution',300)


%%

%impz(h1,1,n);

plot(n_imp,h1)
exportgraphics(gcf,'Plots/Interpolation_Filter_ImpulseResponse.png','Resolution',300)
%%

%Filter using the LPF
music_AA_array = filter(d2,music_array);
speech_AA_array = filter(d2,speech_array);

%Downsample by 4
music_AA_ds_array = downsample(music_AA_array,4);
speech_AA_ds_array = downsample(speech_AA_array,4);

%Upsample by 4
music_AA_ds_us_array = upsample(music_AA_ds_array,3);
speech_AA_ds_us_array = upsample(speech_AA_ds_array,3);

%Filter using Interpolation Filter
music_AA_ds_us_int_array = filter(h1,1,music_AA_ds_us_array);
speech_AA_ds_us_int_array = filter(h1,1,speech_AA_ds_us_array);

%Apply Fourier Transform
music_AA_ds_us_amplitude = abs(fft(music_AA_ds_us_array));
speech_AA_ds_us_amplitude = abs(fft(speech_AA_ds_us_array));

music_AA_ds_us_int_amplitude = abs(fft(music_AA_ds_us_int_array));
speech_AA_ds_us_int_amplitude = abs(fft(speech_AA_ds_us_int_array));

music_AA_ds_us_int_frequency =  transpose((0:length(music_AA_ds_us_int_amplitude)-1)*music_us_ds_fs/length(music_AA_ds_us_int_amplitude));
speech_AA_ds_us_int_frequency =  transpose((0:length(speech_AA_ds_us_int_amplitude)-1)*speech_us_ds_fs/length(speech_AA_ds_us_int_amplitude));

%% Plotting without interpolation

%% Plot the music signal
hold on;
xlabel('Frequency');
ylabel('Magnitude');
title('Magnitude Response of Non-Interpolated music16khz.wav');
plot(music_us_ds_frequency,music_AA_ds_us_int_amplitude);
hold off;
exportgraphics(gcf,'Plots/Music_16Khz_AA_ds_us_MagnitudeResponse.png','Resolution',300)
%% Plot the speech Signal

hold on;
xlabel('Frequency');
ylabel('Magnitude');
title('Magnitude Response of Non-Interpolated speech8khz.wav');
plot(speech_us_ds_frequency,speech_AA_ds_us_amplitude);
hold off;
exportgraphics(gcf,'Plots/Speech_8Khz_AA_ds_us_MagnitudeResponse.png','Resolution',300)

%% Plotting with interpolation filters
%% Plot the music signal
hold on;
xlabel('Frequency');
ylabel('Magnitude');
title('Magnitude Response of Upsampled and then downsampled music16khz.wav after filtering');
plot(music_AA_ds_us_int_frequency,music_AA_ds_us_int_amplitude);
hold off;
exportgraphics(gcf,'Plots/Music_16Khz_AA_ds_us_int_MagnitudeResponse.png','Resolution',300)
%% Plot the speech Signal

hold on;
xlabel('Frequency');
ylabel('Magnitude');
title('Magnitude Response of Upsampled and then downsampled speech8khz.wav after filtering');
plot(speech_AA_ds_us_int_frequency,speech_AA_ds_us_int_amplitude);
hold off;
exportgraphics(gcf,'Plots/Speech_8Khz_AA_ds_us_MagnitudeResponse.png','Resolution',300)

%% Convert to audio files

audiowrite('Audio/music16khz_AA_us_ds_int.wav',music_ds_array,music_ds_fs);
audiowrite('Audio/speech8khz_AA_us_ds_int.wav',speech_ds_array,speech_ds_fs);
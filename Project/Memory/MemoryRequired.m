
clear all % clear all variables
close all % close all windows

FileName = 'C:\Users\no10c\OneDrive\Documents\MATLAB\5011CEM2021_dhaliw38\Model\o3_surface_20180701000000.nc';    % define the name of the file to be used, the path is included

Contents = ncinfo(FileName);                                               % Store the file content information in a variable.

[AllDataMem] = LoadAllData(FileName);

[HourDataMem] = LoadHours(FileName);
 
[HourMem] = LoadAllHours(FileName);

fprintf('\nResults:\n')
fprintf('Memory used for all data: %.3f MB\n', AllDataMem)
fprintf('Memory used for hourly data: %.2f MB\n', HourDataMem)
fprintf('Maximum memory used hourly = %.2f MB\n', HourMem)
fprintf('Hourly memory as fraction of all data = %.2f\n\n', HourMem / AllDataMem)

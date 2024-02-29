function ReportResults(FileName)

Contents = ncinfo(FileName);                                                % Store the file content information in a variable.

[AllDataMem] = LoadAllData(FileName);

[HourDataMem] = LoadHours(FileName);
 
[HourMem] = LoadAllHours(FileName);

fprintf('\nResults:\n')
fprintf('Memory used for all data: %.3f MB\n', AllDataMem)
fprintf('Memory used for hourly data: %.2f MB\n', HourDataMem)
fprintf('Maximum memory used hourly = %.2f MB\n', HourMem)
fprintf('Hourly memory as fraction of all data = %.2f\n\n', HourMem / AllDataMem)
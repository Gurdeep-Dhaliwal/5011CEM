function TestNan(FileName)

NaNErrors = 0;

Contents = ncinfo(FileName); % Store the file content information in a variable.

StartLat = 1;
StartLon = 1;

for idxHour = 1:25
    
    for idxModel = 1:8
        Data(idxModel,:,:) = ncread(FileName, Contents.Variables(idxModel).Name,...
            [StartLat, StartLon, idxHour], [inf, inf, 1]);
    end
    
    % check for NaNs
    if any(isnan(Data), 'All')
        fprintf('NaNs present\n')
        NaNErrors = 1;
    end
end
    
fprintf('Testing files: %s\n', FileName)
if NaNErrors
    fprintf('NaN errors present!\n')
else
    fprintf('No errors!\n')
end




NaNErrors = 0;
Contents = ncinfo(FileName); % Store the file content information in a variable.

StartLat = 1;
StartLon = 1;

fprintf('Testing files: %s\n', FileName)
for idxHour = 1:25
    
    for idxModel = 1:8
        Data(idxModel,:,:) = ncread(FileName, Contents.Variables(idxModel).Name,...
            [StartLat, StartLon, idxHour], [inf, inf, 1]);
    end
    
    % check for NaNs
    if any(isnan(Data), 'All')
        fprintf('NaNs present during hour %i\n', idxHour)
        NaNErrors = 1;
    end
end
    
if NaNErrors
    fprintf('NaN errors present!\n')
else
    fprintf('No errors!\n')
end

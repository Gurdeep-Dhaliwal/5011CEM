function TestText(FileName)

DataTypes = {'NC_Byte', 'NC_Char', 'NC_Short', 'NC_Int', 'NC_Float', 'NC_Double'};

Contents = ncinfo(FileName);                                               % Store the file content information in a variable.

FileID = netcdf.open(FileName,'NC_NOWRITE');                               % open file read only and create handle

for idx = 0:size(Contents.Variables,2)-1                                   % loop through each variable
                                                                           % read data type for each variable and store
    [~, datatype(idx+1), ~, ~] = netcdf.inqVar(FileID,idx);
end

DataInFile = DataTypes(datatype);
FindText = strcmp('NC_Char', DataInFile);

fprintf('Testing file: %s\n', FileName)
if any(FindText)
    fprintf('Error, text variables present:\n')
else
    fprintf('All data is numeric, continue analysis.\n')
end




Contents = ncinfo(FileName);                                           % Store the file content information in a variable.
FileID = netcdf.open(FileName,'NC_NOWRITE');                           % open file read only and create handle
for idx = 0:size(Contents.Variables,2)-1                               % loop through each variable
                                                                           % read data type for each variable and store
    [~, datatype(idx+1), ~, ~] = netcdf.inqVar(FileID,idx);
end

DataInFile = DataTypes(datatype);
FindText = strcmp('NC_Char', DataInFile);
fprintf('Testing file: %s\n', FileName)
if any(FindText)
    fprintf('Error, text variables present:\n')
else
    fprintf('All data is numeric, continue analysis.\n')
end





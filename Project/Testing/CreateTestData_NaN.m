function CreateTestData_NaN(FileName)

NewFileName = './Model/TestFileNaN.nc';
copyfile(FileName, NewFileName);

C = ncinfo(NewFileName);
ModelNames = {C.Variables(1:8).Name};

BadData = NaN(700,400,1);

Hour2Replace = 12;
for idx = 1:8
    ncwrite(NewFileName, ModelNames{idx}, BadData, [1, 1, Hour2Replace]);
end

end


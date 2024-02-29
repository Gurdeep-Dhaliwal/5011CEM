function [ResultsPP,HourlyProcessingTime] = ParallelProcessing(FileName)

Contents = ncinfo(FileName);

Lat = ncread(FileName, 'lat');
Lon = ncread(FileName, 'lon');
NumHours = 25;  

RadLat = 30.2016;
RadLon = 24.8032;
RadO3 = 4.2653986e-08;

StartLat = 1;
NumLat = 400;
StartLon = 1;
NumLon = 700;

NumLocations = (NumLon - 4) * (NumLat - 4);
EnsembleVectorPar = zeros(NumLocations, NumHours);                                           % pre-allocate memory

DataOptions = [500,2500,5000]; %500, 2500, 5000                                              %Declaring data set sizes
Workers = [1,2,3,4,5,6]; %6                                                                  %Ammount of workers/processors
ResultsPP = [];                                                                              %initializing ResultsPP
HourlyProcessingTime = [];                                                                   %initializing HourlyProcessingTime
tic
for DataNum = 1:length(DataOptions)                                                          %For all data sizes in DataOptions
    DataProcessed = DataOptions(DataNum);                                                    %DataProcessed it set to DataOption value
    for idx1 = 1:length(Workers)                                                             %Number of workers from 1 to 6
        PoolSize = Workers(idx1);                                                            %Set PoolSize to processors number
        for idxTime = 1:NumHours                                                             %For each data set 
            DataLayer = 1;
            for idx = [1, 2, 4, 5, 6, 7, 8]
                HourlyData(DataLayer,:,:) = ncread(FileName, Contents.Variables(idx).Name,...
                    [StartLon, StartLat, idxTime], [NumLon, NumLat, 1]); %#ok<*AGROW>
                DataLayer = DataLayer + 1;
            end
            [Data2Process, LatLon] = PrepareData(HourlyData, Lat, Lon);
            if isempty(gcp('nocreate'))
                parpool('local',PoolSize);
            end
            poolobj = gcp;
            addAttachedFiles(poolobj,{'EnsembleValue'});
            T4 = toc;
            parfor idx = 1: DataProcessed                                                     % size(Data2Process,1)
                [EnsembleVectorPar(idx, idxTime)] = EnsembleValue( Data2Process(idx,:,:,:), LatLon, RadLat, RadLon, RadO3);
            end
            T3(idxTime) = toc - T4;                                                           % record the parallel processing time for this hour of data
            fprintf('Parallel processing time for hour %i : %.1f s\n', idxTime, T3(idxTime))
            HourlyProcessingTime = [HourlyProcessingTime; idxTime, sum(T3)];                  %Record processing times for each data set 
        end
        T2 = toc;
        delete(gcp);
        % EnsembleVectorPar = reshape(EnsembleVectorPar, 696, 396, []); %#ok<*NASGU>
        fprintf('Total processing time for %i workers = %.2f s\n', PoolSize, sum(T3));
        ResultsPP = [ResultsPP; PoolSize, DataProcessed, sum(T3)];                             %record processiing times in array
    end
end
end



function ResultsSP = Sequential_Processsing(FileName)

Contents = ncinfo(FileName);

Lat = ncread(FileName, 'lat');                                                           % load the latitude locations
Lon = ncread(FileName, 'lon');                                                           % loadthe longitude locations

RadLat = 30.2016;                                                                        % cluster radius value for latitude
RadLon = 24.8032;                                                                        % cluster radius value for longitude
RadO3 = 4.2653986e-08;                                                                   % cluster radius value for the ozone data

StartLat = 1;                                                                            % latitude location to start laoding
NumLat = 400;                                                                            % number of latitude locations ot load
StartLon = 1;                                                                            % longitude location to start loading
NumLon = 700;                                                                            % number of longitude locations ot load
tic

MaxHours = [];
for Hours = 1:25
    MaxHours(Hours) = Hours;
end

ResultsSP = [];


for NumHour = 1:length(MaxHours)
    fprintf('Processing hour %i\n', NumHour)
    DataLayer = 1;                                                                       % which 'layer' of the array to load the model data into
    for idx = [1, 2, 4, 5, 6, 7, 8]                                                      % model data to load
                                                                                             % load the model data 1,2,4,5,6,7,8
        HourlyData(DataLayer,:,:) = ncread(FileName, Contents.Variables(idx).Name,...
            [StartLon, StartLat, NumHour], [NumLon, NumLat, 1]);
        DataLayer = DataLayer + 1;                                                       % step to the next 'layer'
    end
        
    [Data2Process, LatLon] = PrepareData(HourlyData, Lat, Lon);
    t1 = toc;
    t2 = t1;
        
    for idx = 1:500  %size(Data2Process,1)                                                    % step through each data location to process the dat
        [EnsembleVector(idx, NumHour)] = EnsembleValue(Data2Process(idx,:,:,:), LatLon, RadLat, RadLon, RadO3);
        if idx/50 == ceil( idx/50)
            tt = toc-t2;
            fprintf('Total %i of %i, last 50 in %.2f s  predicted time for all data %.1f s\n',...
                idx, size(Data2Process,1), tt, size(Data2Process,1)/50*25*tt)
            t2 = toc;
        end
    end
    T2(NumHour) = toc - t1; % record the total processing time for this hour
    fprintf('Processing hour %i - %.2f s\n\n', NumHour, sum(T2));
    ResultsSP = [ResultsSP; NumHour, sum(T2)];                                            %Record processing time for each data set 
end

tSeq = toc;

fprintf('Total time for sequential processing = %.2f s\n\n', tSeq)

end

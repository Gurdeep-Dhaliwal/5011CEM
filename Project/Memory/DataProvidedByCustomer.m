function DataProvidedByCustomer(FileName)

Lat = ncread(FileName, 'lat');                                                           % load the latitude locations
Lon = ncread(FileName, 'lon');                                                           % loadthe longitude locations

RadLat = 30.2016;                                                                        % cluster radius value for latitude
RadLon = 24.8032;                                                                        % cluster radius value for longitude
RadO3 = 4.2653986e-08;                                                                   % cluster radius value for the ozone data

StartLat = 1;                                                                            % latitude location to start laoding
NumLat = 400;                                                                            % number of latitude locations ot load
StartLon = 1;                                                                            % longitude location to start loading
NumLon = 700;                                                                            % number of longitude locations ot load
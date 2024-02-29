clear all % clear all variables
close all % close all windows

FileName = 'C:\Users\no10c\OneDrive\Documents\MATLAB\5011CEM2021_dhaliw38\Model\o3_surface_20180701000000.nc';    % define the name of the file to be used, the path is included

Contents = ncinfo(FileName);                                                                                      % Store the file content information in a variable.
                       
ReportResults(FileName)                                                    %Call upon ReportResults function

[ResultsPP,HourlyProcessingTime] = ParallelProcessing(FileName);           %Call upon ParallelProcessing function returning ResultPP and HourlyProcesing Time

ResultsSP = Sequential_Processsing(FileName);                              %Call upon Sequnential_Processing function to return ResultsSP



PPWorkerVal = ResultsPP(1:6,1);                                            %Getting range of worker/processors used
PPDataProcessed500 = ResultsPP(1:6,2);                                     %How much data processed
PPDataProcessed2500 = ResultsPP(7:12,2);
PPDataProcessed5000 = ResultsPP(13:18,2);
PP_ProcessingTime500 = ResultsPP(1:6,3);                                   %Processing speeds for 500 bytes of data
PP_ProcessingTime2500 = ResultsPP(7:12,3);                                 %Processing speeds for 2500 bytes of data
PP_ProcessingTime5000 = ResultsPP(13:18,3);                                %Processing speeds for 5000 bytes of data 


SP_ProcessingTime = ResultsSP(1:25,2);                                     %Sequential Processing times 
SP_ProcessingHour = ResultsSP(1:25,1);                                     %Processing data sets
PP_ProcessingTimePerHour = HourlyProcessingTime(51:75,2);                  %Time to process each data set parallelly 


figure(1)                                                                  %Graph plots processing times for 500, 2500 and 5000 bytes of data
yyaxis left                                                                %Againsts the ammount of processors/workers
plot(PPWorkerVal, PP_ProcessingTime500,'-bd')
xlabel('Number of Processors')
ylabel('Processing time (s)')
title('Processing time vs number of processors')

figure(1)
yyaxis right
plot(PPWorkerVal, PP_ProcessingTime2500,'-rx')
xlabel('Number of Processors')
ylabel('Processing time per hour(s)')
title('Processing time vs number of processors')

figure(1)
yyaxis right
plot(PPWorkerVal, PP_ProcessingTime5000,'-rx')
xlabel('Number of Processors')
ylabel('Processing time per hour(s)')
title('Processing time vs number of processors')
legend('500 Data', '2500 Data', '5000 Data')

figure(3)                                                                  %figure 3 shows sequential processing all data sets
yyaxis 
plot(SP_ProcessingHour, SP_ProcessingTime,'-rx', 'color', 'r')
xlabel('Processing Hour')
ylabel('Processing time per hour(s)')
title('Sequential Vs Parallel (500 data)')

figure(3)                                                                  %Compared with parallel for 3 processors/workers
yyaxis left
plot(SP_ProcessingHour, PP_ProcessingTimePerHour,'-rx', 'color', 'g')
ylabel('Processing time per hour(s) for 3 Workers')
legend('Seqential', 'Parallel')


ProcessingTime500MeanVals = PP_ProcessingTime500 / 500;                    %Mean processing time for 500 bytes of data
ProcessingTime2500MeanVals = PP_ProcessingTime2500 / 2500;                 %Mean processing time for 2500 bytes of data 
ProcessingTime5000MeanVals = PP_ProcessingTime5000 / 5000;                 %Mean processing time for 5000 bytes of data 
figure(2)                                                                  %figure 2 plots mean for 500,2500 and 5000 bytes of data against number of processors 
plot(PPWorkerVal, ProcessingTime500MeanVals, '-bd')  
hold on
plot(PPWorkerVal, ProcessingTime2500MeanVals, '-rx')
hold on
plot(PPWorkerVal, ProcessingTime5000MeanVals, '-rx')
hold off
xlabel('Number of Processors')
ylabel('Time per hour processed per data(s)')
title('Mean Processing time vs number of processors')
legend('500 Data', '2500 Data', '5000 data')

MeanTimePerDataRequired = 1/((25*224000)/(2*60*60));                       %ammount of data per second processed to reach sub 2 hour processing time

ProcessorsRequiredFor500Data  = (0.1974-MeanTimePerDataRequired)/0.02682;  %Calculate how many processors required for 500 data averages 
ProcessorsRequiredFor2500Data = (0.2784-MeanTimePerDataRequired)/0.04119;  %Calculate how many processors requried for 2500 data averages 
ProcessorsRequiredFor5000Data = (0.3083-MeanTimePerDataRequired)/0.04442;  %Calculate how many processors requried for 5000 data average
fprintf('Mean time per Data Required to complete under 2 hours = %i\n', MeanTimePerDataRequired)
fprintf('Processors Required to Process 500 data under 2 hours  = %i\n', ProcessorsRequiredFor500Data )    %Print results for 500,2500 and 5000 data sets 
fprintf('Processors Required to Process 2500 data under 2 hours  = %i\n', ProcessorsRequiredFor2500Data )
fprintf('Processors Required to Process 5000 data under 2 hours  = %i\n', ProcessorsRequiredFor5000Data )
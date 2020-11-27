%% Number Proccessing
% run this script first,
% it will give you distribution of ratings so you can use it for Quality
% Control of FOK data
% need to have numbers across scale to do correlations later
% threshold I've been using is:
% at least 5 trials in 3 of 5 ratings for unsuccessful recall trials
% i.e. if participant has 50 FOK1 trials and 30 FOK2 trials and that's it
% they get excluded

subjID = ''; % here's to specify subject

genFolder = fullfile...
    ('RAW DATA FILE PATH');
pFolder = fullfile (genFolder, subjID); % Change according to who I'm analyzing
data = load (fullfile (pFolder, 'participantresults.txt'));

%% Process Overall FOK Numbers With Successful Trials

FOK1 = 0;
FOK2 = 0;
FOK3 = 0;
FOK4 = 0;
FOK5 = 0;

for i = 1:length(data) % for each trial
    if data (i, ?) == 1 % if FOK rating was 1 
        FOK1 = FOK1 + 1; % add to tally
    elseif data (i, ?) == 2 % if FOK was 2
        FOK2 = FOK2 + 1; % add to tally
    elseif data (i, ?) == 3 % etc
        FOK3 = FOK3 + 1;
    elseif data (i, ?) == 4
        FOK4 = FOK4 + 1;
    elseif data (i, ?) == 5
        FOK5 = FOK5 + 1;
    end
end

totalalltrials = FOK1 + FOK2 + FOK3 + FOK4 + FOK5; 
% should be equal to number of total trials

%% FOK Numbers for No Successful Trials

FOK1No = 0;
FOK2No = 0;
FOK3No = 0;
FOK4No = 0;
FOK5No = 0;

for i = 1:length(data)
    if data (i, ?) == 0 % if recall unsuccessful
        if data (i, ?) == 1 % if FOK 1 (just like above)
            FOK1No = FOK1No + 1;
        elseif data (i, ?) == 2
            FOK2No = FOK2No + 1;
        elseif data (i, ?) == 3
            FOK3No = FOK3No + 1;
        elseif data (i, ?) == 4
            FOK4No = FOK4No + 1;
        elseif data (i, ?) == 5
            FOK5No = FOK5No + 1;
        end
    end
end

NoSuccessTrials = FOK1No + FOK2No + FOK3No + FOK4No + FOK5No;
SuccessTrials = totalalltrials - NoSuccessTrials;

%% Chart, save and export

numbers =  zeros (1, 13);
numbers (1,1) = totalalltrials;
numbers (1,2) = FOK1;
numbers (1,3) = FOK2;
numbers (1,4) = FOK3;
numbers (1,5) = FOK4;
numbers (1,6) = FOK5;
numbers (1,7) = NoSuccessTrials;
numbers (1,8) = SuccessTrials;
numbers (1,9) = FOK1No;
numbers (1,10) = FOK2No;
numbers (1,11) = FOK3No;
numbers (1,12) = FOK4No;
numbers (1,13) = FOK5No;

%% Also save as a growing matrix file

masterfolder = fullfile ...
    ('OUTPUT PATH HERE');...
    % INSERT PATH TO FOLDER WHERE YOU ARE SAVING OUTPUT
masterdata = load...
    (fullfile(masterfolder, 'numberdistribution.txt')); %import master data list
masterdata = [masterdata; numbers]; % concactenate current matrix with master, replace master
filename = fullfile ...
    (masterfolder,'numberdistribution.txt');
dlmwrite (filename, masterdata); % save new master in fill

masterdatatable = array2table (masterdata, 'VariableNames',...
    {'TotalAllTrials', 'FOK1', 'FOK2', 'FOK3', 'FOK4', 'FOK5',...
    'NoSuccessTrials', 'SuccessTrials', 'FOK1NoSuccess',...
    'FOK2NoSuccess', 'FOK3NoSuccess', 'FOK4NoSuccess', 'FOK5NoSuccess'});
tablename = fullfile...
    (masterfolder, 'numberdistributiontable.xlsx');
writetable (masterdatatable, tablename);
% saves in specified locations as txt file and excel file
% check distribution to ensure they can be included

%% Continuous data analysis
% will give you data that you can use to plot and visualize trends
% for example, you can see the recognition accuracy across the 1 to 5 FOK
% Scale

subjID = ''; % change subject here

genFolder = fullfile...
    ('RAW DATA PATH ');
pFolder = fullfile (genFolder, subjID); % Change according to who I'm analyzing
data = load (fullfile (pFolder, 'participantresults.txt'));

%% Calculate Totals and Restudy Numbers for all FOK levels All Trials

FOK1total = 0;
FOK2total = 0;
FOK3total = 0;
FOK4total = 0;
FOK5total = 0;

FOK1restudy = 0;
FOK2restudy = 0;
FOK3restudy = 0;
FOK4restudy = 0;
FOK5restudy = 0;

for i = 1:length(data)
    if data (i, ?) == 1 % if FOK = 1
        FOK1total = FOK1total + 1; % add 1 to FOK1 total
        if data (i, ?) == 1 %if restudtudied
            FOK1restudy = FOK1restudy + 1; % add 1 to restudied total
        end
    elseif data (i, ?) == 2 % if FOK 2 repeat
        FOK2total = FOK2total + 1;
        if data (i, ?) == 1
            FOK2restudy = FOK2restudy + 1;
        end
    elseif data (i, ?) == 3
        FOK3total = FOK3total + 1;
        if data (i, ?) == 1
            FOK3restudy = FOK3restudy + 1;
        end
    elseif data (i, ?) == 4
        FOK4total = FOK4total + 1;
        if data (i, ?) == 1
            FOK4restudy = FOK4restudy + 1;
        end
    elseif data (i, ?) == 5
        FOK5total = FOK5total + 1;
        if data (i, ?) == 1
            FOK5restudy = FOK5restudy + 1;
        end
    end
end

% Calculate proportion restudied

FOK1ProportionAll = (FOK1restudy / FOK1total) * 100;
FOK2ProportionAll = (FOK2restudy / FOK2total) * 100;
FOK3ProportionAll = (FOK3restudy / FOK3total) * 100;
FOK4ProportionAll = (FOK4restudy / FOK4total) * 100;
FOK5ProportionAll = (FOK5restudy / FOK5total) * 100;

%% Calculate Totals and Restudy Numbers for all FOK levels no success only

FOK1total = 0;
FOK2total = 0;
FOK3total = 0;
FOK4total = 0;
FOK5total = 0;

FOK1restudy = 0;
FOK2restudy = 0;
FOK3restudy = 0;
FOK4restudy = 0;
FOK5restudy = 0;

for i = 1:length(data)
    if data (i, ?) == 0 % if recall was unsuccessful
        if data (i, ?) == 1 % if FOK = 1
            FOK1total = FOK1total + 1; % add 1 to FOK1 total
            if data (i, ?) == 1 %if restudtudied
                FOK1restudy = FOK1restudy + 1; % add 1 to restudied total
            end
        elseif data (i, ?) == 2 % repeat
            FOK2total = FOK2total + 1;
            if data (i, ?) == 1
                FOK2restudy = FOK2restudy + 1;
            end
        elseif data (i, ?) == 3
            FOK3total = FOK3total + 1;
            if data (i, ?) == 1
                FOK3restudy = FOK3restudy + 1;
            end
        elseif data (i, ?) == 4
            FOK4total = FOK4total + 1;
            if data (i, ?) == 1
                FOK4restudy = FOK4restudy + 1;
            end
        elseif data (i, ?) == 5
            FOK5total = FOK5total + 1;
            if data (i, ?) == 1
                FOK5restudy = FOK5restudy + 1;
            end
        end
    end
end


% Calculate proportion restudied

FOK1ProportionNoSuccess = (FOK1restudy / FOK1total) * 100;
FOK2ProportionNoSuccess = (FOK2restudy / FOK2total) * 100;
FOK3ProportionNoSuccess = (FOK3restudy / FOK3total) * 100;
FOK4ProportionNoSuccess = (FOK4restudy / FOK4total) * 100;
FOK5ProportionNoSuccess = (FOK5restudy / FOK5total) * 100;

%% Calculate Totals and Restudy Numbers for all FOK levels old trials

FOK1total = 0;
FOK2total = 0;
FOK3total = 0;
FOK4total = 0;
FOK5total = 0;

FOK1restudy = 0;
FOK2restudy = 0;
FOK3restudy = 0;
FOK4restudy = 0;
FOK5restudy = 0;

for i = 1:length(data)
    if data (i, ?) == 1 % if item is old
        if data (i, ?) == 1 % if FOK = 1
            FOK1total = FOK1total + 1; % add 1 to FOK1 total
            if data (i, ?) == 1 %if restudtudied
                FOK1restudy = FOK1restudy + 1; % add 1 to restudied total
            end
        elseif data (i, ?) == 2 % repeat
            FOK2total = FOK2total + 1;
            if data (i, ?) == 1
                FOK2restudy = FOK2restudy + 1;
            end
        elseif data (i, ?) == 3
            FOK3total = FOK3total + 1;
            if data (i, ?) == 1
                FOK3restudy = FOK3restudy + 1;
            end
        elseif data (i, ?) == 4
            FOK4total = FOK4total + 1;
            if data (i, ?) == 1
                FOK4restudy = FOK4restudy + 1;
            end
        elseif data (i, ?) == 5
            FOK5total = FOK5total + 1;
            if data (i, ?) == 1
                FOK5restudy = FOK5restudy + 1;
            end
        end
    end
end

% Calculate proportion restudied

FOK1ProportionOld = (FOK1restudy / FOK1total) * 100;
FOK2ProportionOld = (FOK2restudy / FOK2total) * 100;
FOK3ProportionOld = (FOK3restudy / FOK3total) * 100;
FOK4ProportionOld = (FOK4restudy / FOK4total) * 100;
FOK5ProportionOld = (FOK5restudy / FOK5total) * 100;

%% Calculate Totals and Restudy Numbers for all FOK levels old, no success only

FOK1total = 0;
FOK2total = 0;
FOK3total = 0;
FOK4total = 0;
FOK5total = 0;

FOK1restudy = 0;
FOK2restudy = 0;
FOK3restudy = 0;
FOK4restudy = 0;
FOK5restudy = 0;

for i = 1:length(data)
    if data (i, ?) == 1  % if item is old
        if data (i, ?) == 0 % if recall was unsuccessful
            if data (i, ?) == 1 % if FOK = 1
                FOK1total = FOK1total + 1; % add 1 to FOK1 total
                if data (i, ?) == 1 %if restudtudied
                    FOK1restudy = FOK1restudy + 1; % add 1 to restudied total
                end
            elseif data (i, ?) == 2 % repeat
                FOK2total = FOK2total + 1;
                if data (i, ?) == 1
                    FOK2restudy = FOK2restudy + 1;
                end
            elseif data (i, ?) == 3
                FOK3total = FOK3total + 1;
                if data (i, ?) == 1
                    FOK3restudy = FOK3restudy + 1;
                end
            elseif data (i, ?) == 4
                FOK4total = FOK4total + 1;
                if data (i, ?) == 1
                    FOK4restudy = FOK4restudy + 1;
                end
            elseif data (i, ?) == 5
                FOK5total = FOK5total + 1;
                if data (i, ?) == 1
                    FOK5restudy = FOK5restudy + 1;
                end
            end
        end
    end
end

% Calculate proportion restudied

FOK1ProportionOldNoSuccess = (FOK1restudy / FOK1total) * 100;
FOK2ProportionOldNoSuccess = (FOK2restudy / FOK2total) * 100;
FOK3ProportionOldNoSuccess = (FOK3restudy / FOK3total) * 100;
FOK4ProportionOldNoSuccess = (FOK4restudy / FOK4total) * 100;
FOK5ProportionOldNoSuccess = (FOK5restudy / FOK5total) * 100;

%% Average RT for each FOK rating, All Trials

FOK1RT = 0;
FOK2RT = 0;
FOK3RT = 0;
FOK4RT = 0;
FOK5RT = 0;

FOK1total = 0;
FOK2total = 0;
FOK3total = 0;
FOK4total = 0;
FOK5total = 0;

for i = 1:length(data)
    if data (i, ?) == 1 % if FOK = 1
        FOK1total = FOK1total + 1; % add 1 to FOK1 total
        FOK1RT = FOK1RT + data(i,?); % add RT to running total
    elseif data (i, ?) == 2 % repeat
        FOK2total = FOK2total + 1;
        FOK2RT = FOK2RT + data(i,?);
    elseif data (i, ?) == 3
        FOK3total = FOK3total + 1;
        FOK3RT = FOK3RT + data(i,?);
    elseif data (i, ?) == 4
        FOK4total = FOK4total + 1;
        FOK4RT = FOK4RT + data(i,?);
    elseif data (i, ?) == 5
        FOK5total = FOK5total + 1;
        FOK5RT = FOK5RT + data(i,?);
    end
end

FOK1RTav = FOK1RT / FOK1total;
FOK2RTav = FOK2RT / FOK2total;
FOK3RTav = FOK3RT / FOK3total;
FOK4RTav = FOK4RT / FOK4total;
FOK5RTav = FOK5RT / FOK5total;

%% Average RT for each FOK rating, No success

FOK1RT = 0;
FOK2RT = 0;
FOK3RT = 0;
FOK4RT = 0;
FOK5RT = 0;

FOK1total = 0;
FOK2total = 0;
FOK3total = 0;
FOK4total = 0;
FOK5total = 0;

for i = 1:length(data)
    if data (i, ?) == 0 % if recall was unsuccessful
        if data (i, ?) == 1 % if FOK = 1
            FOK1total = FOK1total + 1; % add 1 to FOK1 total
            FOK1RT = FOK1RT + data(i,?); % add RT to running total
        elseif data (i, ?) == 2 % repeat
            FOK2total = FOK2total + 1;
            FOK2RT = FOK2RT + data(i,?);
        elseif data (i, ?) == 3
            FOK3total = FOK3total + 1;
            FOK3RT = FOK3RT + data(i,?);
        elseif data (i, ?) == 4
            FOK4total = FOK4total + 1;
            FOK4RT = FOK4RT + data(i,?);
        elseif data (i, ?) == 5
            FOK5total = FOK5total + 1;
            FOK5RT = FOK5RT + data(i,?);
        end
    end
end

FOK1RTavNoSuccess = FOK1RT / FOK1total;
FOK2RTavNoSuccess = FOK2RT / FOK2total;
FOK3RTavNoSuccess = FOK3RT / FOK3total;
FOK4RTavNoSuccess = FOK4RT / FOK4total;
FOK5RTavNoSuccess = FOK5RT / FOK5total;

%% Average RT for each FOK rating, old trials

FOK1RT = 0;
FOK2RT = 0;
FOK3RT = 0;
FOK4RT = 0;
FOK5RT = 0;

FOK1total = 0;
FOK2total = 0;
FOK3total = 0;
FOK4total = 0;
FOK5total = 0;

for i = 1:length(data)
    if data (i, ?) == 1 % if item was old
        if data (i, ?) == 1 % if FOK = 1
            FOK1total = FOK1total + 1; % add 1 to FOK1 total
            FOK1RT = FOK1RT + data(i,?); % add RT To running total
        elseif data (i, ?) == 2 % repeat
            FOK2total = FOK2total + 1;
            FOK2RT = FOK2RT + data(i,?);
        elseif data (i, ?) == 3
            FOK3total = FOK3total + 1;
            FOK3RT = FOK3RT + data(i,?);
        elseif data (i, ?) == 4
            FOK4total = FOK4total + 1;
            FOK4RT = FOK4RT + data(i,?);
        elseif data (i, ?) == 5
            FOK5total = FOK5total + 1;
            FOK5RT = FOK5RT + data(i,?);
        end
    end
end

FOK1RTavOld = FOK1RT / FOK1total;
FOK2RTavOld = FOK2RT / FOK2total;
FOK3RTavOld = FOK3RT / FOK3total;
FOK4RTavOld = FOK4RT / FOK4total;
FOK5RTavOld = FOK5RT / FOK5total;

%% Average RT for each FOK rating, old no success trials

FOK1RT = 0;
FOK2RT = 0;
FOK3RT = 0;
FOK4RT = 0;
FOK5RT = 0;

FOK1total = 0;
FOK2total = 0;
FOK3total = 0;
FOK4total = 0;
FOK5total = 0;

for i = 1:length(data)
    if data (i,?) == 1 % if item was old
        if data (i, ?) == 0 % if recall was unsuccessful
            if data (i, ?) == 1 % if FOK = 1
                FOK1total = FOK1total + 1; % add 1 to FOK1 total
                FOK1RT = FOK1RT + data(i,?); % add RT to total
            elseif data (i, ?) == 2 % repeat
                FOK2total = FOK2total + 1;
                FOK2RT = FOK2RT + data(i,?);
            elseif data (i, ?) == 3
                FOK3total = FOK3total + 1;
                FOK3RT = FOK3RT + data(i,?);
            elseif data (i, ?) == 4
                FOK4total = FOK4total + 1;
                FOK4RT = FOK4RT + data(i,?);
            elseif data (i, ?) == 5
                FOK5total = FOK5total + 1;
                FOK5RT = FOK5RT + data(i,?);
            end
        end
    end
end

FOK1RTavOldNoSuccess = FOK1RT / FOK1total;
FOK2RTavOldNoSuccess = FOK2RT / FOK2total;
FOK3RTavOldNoSuccess = FOK3RT / FOK3total;
FOK4RTavOldNoSuccess = FOK4RT / FOK4total;
FOK5RTavOldNoSuccess = FOK5RT / FOK5total;

%% Average Accuracy for each FOK rating, All Non-Restudied Trials

FOK1Correct = 0;
FOK2Correct = 0;
FOK3Correct = 0;
FOK4Correct = 0;
FOK5Correct = 0;

FOK1total = 0;
FOK2total = 0;
FOK3total = 0;
FOK4total = 0;
FOK5total = 0;

for i = 1:length(data)
    if data (i, ?) == 0 % if not restudied
        if data (i, ?) == 1 % if FOK = 1
            FOK1total = FOK1total + 1; % add 1 to FOK1 total
            if data (i, ?) == 1 % if recognized accurately
                FOK1Correct = FOK1Correct + 1; % add 1 to restudied total
            end
        elseif data (i, ?) == 2 % repeat
            FOK2total = FOK2total + 1;
            if data (i, ?) == 1 % if restudied
                FOK1Correct = FOK1Correct + 1; % add 1 to restudied total
            end
        elseif data (i, ?) == 3
            FOK3total = FOK3total + 1;
            if data (i, ?) == 1 % if restudied
                FOK1Correct = FOK1Correct + 1; % add 1 to restudied total
            end
        elseif data (i, ?) == 4
            FOK4total = FOK4total + 1;
            if data (i, ?) == 1 % if restudied
                FOK1Correct = FOK1Correct + 1; % add 1 to restudied total
            end
        elseif data (i, ?) == 5
            FOK5total = FOK5total + 1;
            if data (i, ?) == 1 % if restudied
                FOK1Correct = FOK1Correct + 1; % add 1 to restudied total
            end
        end
    end
end

FOK1AccuracyAll = FOK1Correct / FOK1total;
FOK2AccuracyAll = FOK2Correct / FOK2total;
FOK3AccuracyAll = FOK3Correct / FOK3total;
FOK4AccuracyAll = FOK4Correct / FOK4total;
FOK5AccuracyAll = FOK5Correct / FOK5total;

%% Average Accuracy for each FOK rating, No success No Restudy Trials

FOK1Correct = 0;
FOK2Correct = 0;
FOK3Correct = 0;
FOK4Correct = 0;
FOK5Correct = 0;

FOK1total = 0;
FOK2total = 0;
FOK3total = 0;
FOK4total = 0;
FOK5total = 0;

for i = 1:length(data)
    if data (i, ?) == 0 % if recall unsuccessful
        if data (i, ?) == 0 % if not restudied
            if data (i, ?) == 1 % if FOK = 1
                FOK1total = FOK1total + 1; % add 1 to FOK1 total
                if data (i, ?) == 1 % if recognized accurately
                    FOK1Correct = FOK1Correct + 1; % add 1 to restudied total
                end
            elseif data (i, ?) == 2 % repeat
                FOK2total = FOK2total + 1;
                if data (i, ?) == 1 % if restudied
                    FOK1Correct = FOK1Correct + 1; % add 1 to restudied total
                end
            elseif data (i, ?) == 3
                FOK3total = FOK3total + 1;
                if data (i, ?) == 1 % if restudied
                    FOK1Correct = FOK1Correct + 1; % add 1 to restudied total
                end
            elseif data (i, ?) == 4
                FOK4total = FOK4total + 1;
                if data (i, ?) == 1 % if restudied
                    FOK1Correct = FOK1Correct + 1; % add 1 to restudied total
                end
            elseif data (i, ?) == 5
                FOK5total = FOK5total + 1;
                if data (i, ?) == 1 % if restudied
                    FOK1Correct = FOK1Correct + 1; % add 1 to restudied total
                end
            end
        end
    end
end

FOK1AccuracyNoSuccess = FOK1Correct / FOK1total;
FOK2AccuracyNoSuccess = FOK2Correct / FOK2total;
FOK3AccuracyNoSuccess = FOK3Correct / FOK3total;
FOK4AccuracyNoSuccess = FOK4Correct / FOK4total;
FOK5AccuracyNoSuccess = FOK5Correct / FOK5total;

%% Average Accuracy for each FOK rating, old trials no restudy

FOK1Correct = 0;
FOK2Correct = 0;
FOK3Correct = 0;
FOK4Correct = 0;
FOK5Correct = 0;

FOK1total = 0;
FOK2total = 0;
FOK3total = 0;
FOK4total = 0;
FOK5total = 0;

for i = 1:length(data)
    if data(i,?) == 1 % if item is old
        if data (i, ?) == 0 % if not restudied
            if data (i, ?) == 1 % if FOK = 1
                FOK1total = FOK1total + 1; % add 1 to FOK1 total
                if data (i, ?) == 1 % if recognized accurately
                    FOK1Correct = FOK1Correct + 1; % add 1 to restudied total
                end
            elseif data (i, ?) == 2 % repeat
                FOK2total = FOK2total + 1;
                if data (i, ?) == 1 % if restudied
                    FOK1Correct = FOK1Correct + 1; % add 1 to restudied total
                end
            elseif data (i, ?) == 3
                FOK3total = FOK3total + 1;
                if data (i, ?) == 1 % if restudied
                    FOK1Correct = FOK1Correct + 1; % add 1 to restudied total
                end
            elseif data (i, ?) == 4
                FOK4total = FOK4total + 1;
                if data (i, ?) == 1 % if restudied
                    FOK1Correct = FOK1Correct + 1; % add 1 to restudied total
                end
            elseif data (i, ?) == 5
                FOK5total = FOK5total + 1;
                if data (i, ?) == 1 % if restudied
                    FOK1Correct = FOK1Correct + 1; % add 1 to restudied total
                end
            end
        end
    end
end

FOK1AccuracyOld = FOK1Correct / FOK1total;
FOK2AccuracyOld = FOK2Correct / FOK2total;
FOK3AccuracyOld = FOK3Correct / FOK3total;
FOK4AccuracyOld = FOK4Correct / FOK4total;
FOK5AccuracyOld = FOK5Correct / FOK5total;

%% Average Accuracy for each FOK rating, old no success no restudy trials

FOK1Correct = 0;
FOK2Correct = 0;
FOK3Correct = 0;
FOK4Correct = 0;
FOK5Correct = 0;

FOK1total = 0;
FOK2total = 0;
FOK3total = 0;
FOK4total = 0;
FOK5total = 0;

for i = 1:length(data)
    if data(i,?) == 1 % if item was old
        if data (i,?) == 0 % if recall unsuccessful
            if data (i, ?) == 0 % if not restudied
                if data (i, ?) == 1 % if FOK = 1
                    FOK1total = FOK1total + 1; % add 1 to FOK1 total
                    if data (i, ?) == 1 % if recognized accurately
                        FOK1Correct = FOK1Correct + 1; % add 1 to restudied total
                    end
                elseif data (i, ?) == 2 % repeat
                    FOK2total = FOK2total + 1;
                    if data (i, ?) == 1 % if restudied
                        FOK1Correct = FOK1Correct + 1; % add 1 to restudied total
                    end
                elseif data (i, ?) == 3
                    FOK3total = FOK3total + 1;
                    if data (i, ?) == 1 % if restudied
                        FOK1Correct = FOK1Correct + 1; % add 1 to restudied total
                    end
                elseif data (i, ?) == 4
                    FOK4total = FOK4total + 1;
                    if data (i, ?) == 1 % if restudied
                        FOK1Correct = FOK1Correct + 1; % add 1 to restudied total
                    end
                elseif data (i, ?) == 5
                    FOK5total = FOK5total + 1;
                    if data (i, ?) == 1 % if restudied
                        FOK1Correct = FOK1Correct + 1; % add 1 to restudied total
                    end
                end
            end
        end
    end
end

FOK1AccuracyOldNoSuccess = FOK1Correct / FOK1total;
FOK2AccuracyOldNoSuccess = FOK2Correct / FOK2total;
FOK3AccuracyOldNoSuccess = FOK3Correct / FOK3total;
FOK4AccuracyOldNoSuccess = FOK4Correct / FOK4total;
FOK5AccuracyOldNoSuccess = FOK5Correct / FOK5total;

%% Chart, Save and Export

FOKnumbers = zeros (1,60);
% chart Accuracy Numbers
FOKnumbers (1,1) = FOK1AccuracyAll;
FOKnumbers (1,2) = FOK2AccuracyAll;
FOKnumbers (1,3) = FOK3AccuracyAll;
FOKnumbers (1,4) = FOK4AccuracyAll;
FOKnumbers (1,5) = FOK5AccuracyAll;

FOKnumbers (1,6) = FOK1AccuracyNoSuccess;
FOKnumbers (1,7) = FOK2AccuracyNoSuccess;
FOKnumbers (1,8) = FOK3AccuracyNoSuccess;
FOKnumbers (1,9) = FOK4AccuracyNoSuccess;
FOKnumbers (1,10) = FOK5AccuracyNoSuccess;

FOKnumbers (1,11) = FOK1AccuracyOld;
FOKnumbers (1,12) = FOK2AccuracyOld;
FOKnumbers (1,13) = FOK3AccuracyOld;
FOKnumbers (1,14) = FOK4AccuracyOld;
FOKnumbers (1,15) = FOK5AccuracyOld;

FOKnumbers (1,16) = FOK1AccuracyOldNoSuccess;
FOKnumbers (1,17) = FOK2AccuracyOldNoSuccess;
FOKnumbers (1,18) = FOK3AccuracyOldNoSuccess;
FOKnumbers (1,19) = FOK4AccuracyOldNoSuccess;
FOKnumbers (1,20) = FOK5AccuracyOldNoSuccess;

% Chart Restudy Proportions

FOKnumbers (1,21) = FOK1ProportionAll;
FOKnumbers (1,22) = FOK2ProportionAll;
FOKnumbers (1,23) = FOK3ProportionAll;
FOKnumbers (1,24) = FOK4ProportionAll;
FOKnumbers (1,25) = FOK5ProportionAll;

FOKnumbers (1,26) = FOK1ProportionNoSuccess;
FOKnumbers (1,27) = FOK2ProportionNoSuccess;
FOKnumbers (1,28) = FOK3ProportionNoSuccess;
FOKnumbers (1,29) = FOK4ProportionNoSuccess;
FOKnumbers (1,30) = FOK5ProportionNoSuccess;

FOKnumbers (1,31) = FOK1ProportionOld;
FOKnumbers (1,32) = FOK2ProportionOld;
FOKnumbers (1,33) = FOK3ProportionOld;
FOKnumbers (1,34) = FOK4ProportionOld;
FOKnumbers (1,35) = FOK5ProportionOld;

FOKnumbers (1,36) = FOK1ProportionOldNoSuccess;
FOKnumbers (1,37) = FOK2ProportionOldNoSuccess;
FOKnumbers (1,38) = FOK3ProportionOldNoSuccess;
FOKnumbers (1,39) = FOK4ProportionOldNoSuccess;
FOKnumbers (1,40) = FOK5ProportionOldNoSuccess;

% Chart RT numbers

FOKnumbers (1,41) = FOK1RTav;
FOKnumbers (1,42) = FOK2RTav;
FOKnumbers (1,43) = FOK3RTav;
FOKnumbers (1,44) = FOK4RTav;
FOKnumbers (1,45) = FOK5RTav;

FOKnumbers (1,46) = FOK1RTavNoSuccess;
FOKnumbers (1,47) = FOK2RTavNoSuccess;
FOKnumbers (1,48) = FOK3RTavNoSuccess;
FOKnumbers (1,49) = FOK4RTavNoSuccess;
FOKnumbers (1,50) = FOK5RTavNoSuccess;

FOKnumbers (1,51) = FOK1RTavOld;
FOKnumbers (1,52) = FOK2RTavOld;
FOKnumbers (1,53) = FOK3RTavOld;
FOKnumbers (1,54) = FOK4RTavOld;
FOKnumbers (1,55) = FOK5RTavOld;

FOKnumbers (1,56) = FOK1RTavOldNoSuccess;
FOKnumbers (1,57) = FOK2RTavOldNoSuccess;
FOKnumbers (1,58) = FOK3RTavOldNoSuccess;
FOKnumbers (1,59) = FOK4RTavOldNoSuccess;
FOKnumbers (1,60) = FOK5RTavOldNoSuccess;

%% Save as a growing matrix file

masterfolder = fullfile ...
    ('OUPUT FILE PATH');...
    % INSERT PATH TO FOLDER WHERE YOU ARE SAVING OUTPUT
masterdata = load...
    (fullfile(masterfolder, 'continuous_FOK_processed.txt')); %import master data list
% Create a txt file in the above location with this name (open Excel, save
% a black worksheet as txt file)
masterdata = [masterdata; FOKnumbers]; % concactenate current matrix with master, replace master
filename = fullfile ...
    (masterfolder,'continuous_FOK_processed.txt');
dlmwrite (filename, masterdata); % save new master in fill

masterdatatable = array2table (masterdata, 'VariableNames','FOKRating1AccuracyAllNoRestudyTrials', ...
    'FOKRating2AccuracyAllNoRestudyTrials', 'FOKRating3AccuracyAllNoRestudyTrials', ...
    'FOKRating4AccuracyAllNoRestudyTrials', 'FOKRating5AccuracyAllNoRestudyTrials',...
    'FOKRating1AccuracyNoSuccessNoRestudyTrials', 'FOKRating2AccuracyNoSuccessNoRestudyTrials',...
    'FOKRating3AccuracyNoSuccessNoRestudyTrials', 'FOKRating4AccuracyNoSuccessNoRestudyTrials',...
    'FOKRating5AccuracyNoSuccessNoRestudyTrials','FOKRating1AccuracyOldNoRestudyTrials', ...
    'FOKRating2AccuracyOldNoRestudyTrials', 'FOKRating3AccuracyOldNoRestudyTrials', ...
    'FOKRating4AccuracyOldNoRestudyTrials', 'FOKRating5AccuracyOldNoRestudyTrials',...
    'FOKRating1AccuracyOldNoSuccessNoRestudyTrials', 'FOKRating2AccuracyOldNoSuccessNoRestudyTrials',...
    'FOKRating3AccuracyOldNoSuccessNoRestudyTrials', 'FOKRating4AccuracyOldNoSuccessNoRestudyTrials',...
    'FOKRating5AccuracyOldNoSuccessNoRestudyTrials','FOKRating1RestudyProportionAllTrials', ...
    'FOKRating2RestudyProportionAllTrials', 'FOKRating3RestudyProportionAllTrials', ...
    'FOKRating4RestudyProportionAllTrials', 'FOKRating5RestudyProportionAllTrials',...
    'FOKRating1RestudyProportionNoSuccessTrials', 'FOKRating2RestudyProportionNoSuccessTrials',...
    'FOKRating3RestudyProportionNoSuccessTrials', 'FOKRating4RestudyProportionNoSuccessTrials',...
    'FOKRating5RestudyProportionNoSuccessTrials','FOKRating1RestudyProportionOldTrials', ...
    'FOKRating2RestudyProportionOldTrials', 'FOKRating3RestudyProportionOldTrials', ...
    'FOKRating4RestudyProportionOldTrials', 'FOKRating5RestudyProportionOldTrials',...
    'FOKRating1RestudyProportionOldNoSuccessTrials', 'FOKRating2RestudyProportionOldNoSuccessTrials',...
    'FOKRating3RestudyProportionOldNoSuccessTrials', 'FOKRating4RestudyProportionOldNoSuccessTrials',...
    'FOKRating5RestudyProportionOldNoSuccessTrials', 'FOKRating1AverageRTAllTrials', ...
    'FOKRating2AverageRTAllTrials', 'FOKRating3AverageRTAllTrials', ...
    'FOKRating4AverageRTAllTrials', 'FOKRating5AverageRTAllTrials',...
    'FOKRating1AverageRTNoSuccessTrials', 'FOKRating2AverageRTNoSuccessTrials',...
    'FOKRating3AverageRTNoSuccessTrials', 'FOKRating4AverageRTNoSuccessTrials',...
    'FOKRating5AverageRTNoSuccessTrials','FOKRating1AverageRTOldTrials', ...
    'FOKRating2AverageRTOldTrials', 'FOKRating3AverageRTOldTrials', ...
    'FOKRating4AverageRTOldTrials', 'FOKRating5AverageRTOldTrials',...
    'FOKRating1AverageRTOldNoSuccessTrials', 'FOKRating2AverageRTOldNoSuccessTrials',...
    'FOKRating3AverageRTOldNoSuccessTrials', 'FOKRating4AverageRTOldNoSuccessTrials',...
    'FOKRating5AverageRTOldNoSuccessTrials'});
tablename = fullfile...
    (masterfolder, 'continuous_FOK_processedtable.xlsx');
writetable (masterdatatable, tablename); 

%% Data Analysis for behavioural results
% Change file paths to suit your needs
% Also ensure the Columns of raw data are correct (anywhere with a ?)
% i.e. if script is looking for FOK values be sure that it is searching
% through raw data column containing FOK ratings

subjID = ''; % subj ID, change every time 

genFolder = fullfile...
    ('INSERT FILE PATH TO FOLDER WITH RAW DATA HERE'); 
% folder for unprocessed data (raw data)
pFolder = fullfile (genFolder, subjID); 
data = load (fullfile (pFolder, 'participantresults.txt')); %  imports txt file with raw data

%% Accuracy Chart

overallaccuracy = sum(data(:,?))/length(data)*100; % computes overall accuracy 
% sums "Accuracy" column in raw data (1 for correct, 0 for incorrect) and
% divides by total number of trials and converts to a %
% here and throughout youll need to check "column" 
% data(:,__) this blank throughout script should be filled with proper
% column number

%% Are novel cues restudied more than all old, with successful trials

oldtotal = 0; 
oldrestudy = 0;

noveltotal = 0;
novelrestudied = 0 ;
% create variables to save numbers as when computing stuff

for i = 1:length (data) % for each trial (Note: 1 row of raw data = 1 item) 
    if data (i, ) == 1 % if its old
        oldtotal = oldtotal + 1; % add to the "Old total" 
        if data (i,) == 1 % if it was restudied
            oldrestudy = oldrestudy + 1; % add to the "Old that was restudied total"
        end
    elseif data (i,3) == 0 % otherwise, if it was new
        noveltotal = noveltotal + 1; % add to the "New total"
        if data (i,12) == 1 % if restudied
            novelrestudied = novelrestudied + 1; % add to the "New restudied total"
        end
    end
end

oldproportion = (oldrestudy / oldtotal) * 100;
novelproportion = (novelrestudied / noveltotal) * 100;
% Converts totals to proportions
% i.e. proportion of old trials that were restudied (old restudied / old
% total)

%% Are novel cues restudied more than all old, no success trials only
% Similar format to previous one but now its restriced to trials with
% percived lack of recall success

oldtotalnosuccess = 0;
oldrestudynosuccess = 0;

noveltotalnosuccess = 0;
novelrestudiednosuccess = 0 ;

for i = 1:length (data)
    if data (i, ) == 0 % if free recall was unsuccessful
        % if statements like this allows for the specification of which
        % trials to not include (or to include)
        if data (i, ) == 1 % if its old 
            oldtotalnosuccess = oldtotalnosuccess + 1; 
            if data (i,) == 1 % if it was restudied
                oldrestudynosuccess = oldrestudynosuccess + 1;
            end
        elseif data (i,) == 0 % if its new
            noveltotalnosuccess = noveltotalnosuccess + 1;
            if data (i,) == 1
                novelrestudiednosuccess = novelrestudiednosuccess + 1;
            end
        end
    end
end

oldproportionnosuccess = (oldrestudynosuccess / oldtotalnosuccess) * 100;
novelproportionnosuccess = (novelrestudiednosuccess / noveltotalnosuccess) * 100;

%% Are FOK enhanced for old vs new, all trials

FOKold = 0;
FOKnew = 0;
oldtotal = 0;
newtotal = 0;

for i = 1:length(data)
    if data (i,?) == 1 % if it is old
        oldtotal = oldtotal + 1; % add to old total
        FOKold = FOKold + data(i,?); % add FOK value to FOK tally
    elseif data (i,?) == 0 % else if new
        newtotal = newtotal + 1; % add to new
        FOKnew = FOKnew + data (i,?); % add FOK to new FOK tally
    end
end

FOKoldav = FOKold / oldtotal; % convert to average FOK 
FOKnewav = FOKnew / newtotal;

% Are FOK enhanced for old vs new, no success trials only

FOKoldnosuccess = 0;
FOKnewnosuccess = 0;
oldtotalnosuccess = 0;
newtotalnosuccess = 0;

for i = 1:length(data)
    if data (i,?) == 1
        oldtotalnosuccess = oldtotalnosuccess + 1;
        FOKoldnosuccess = FOKoldnosuccess + data(i,?);
    elseif data (i,?) == 0
        newtotalnosuccess = newtotalnosuccess + 1;
        FOKnewnosuccess = FOKnewnosuccess + data (i,?);
    end
end

FOKoldnosuccessav = FOKoldnosuccess / oldtotalnosuccess;
FOKnewnosuccessav = FOKnewnosuccess / newtotalnosuccess;

%% Accuracy for old vs new, not restudied (1 exposure vs 0 exposures)
% all trials

oldcorrect = 0;
oldtotal = 0;
newcorrect = 0;
newtotal = 0;

for i = 1:length(data)
    if data (i,?) == 0 % if its not restudied
        if data (i,?) == 1 % if its old
            oldtotal = oldtotal + 1;
            if data (i,?) == 1 % if accuracy is correct
                oldcorrect = oldcorrect + 1;
            end
        elseif data (i,?) == 0 % if its new
            newtotal = newtotal + 1;
            if data (i,?) == 1
                newcorrect = newcorrect + 1;
            end
        end
    end
end

oldaccuracy = (oldcorrect / oldtotal) * 100;
newaccuracy = (newcorrect / newtotal) * 100;

%% Accuracy for old vs new, not restudied (1 exposure vs 0 exposures)
% no success trials only as well

oldcorrectnosuccess = 0;
oldtotalnosuccess = 0;
newcorrectnosuccess = 0;
newtotalnosuccess = 0;

for i = 1:length(data)
    if data (i,?) == 0 % if its not restudied
        if data (i,?) == 1 % if its old
            oldtotalnosuccess = oldtotalnosuccess + 1;
            if data (i,?) == 1 % if accurate
                oldcorrectnosuccess = oldcorrectnosuccess + 1;
            end
        elseif data (i,?) == 0 % if its new
            newtotalnosuccess = newtotalnosuccess + 1;
            if data (i,?) == 1
                newcorrectnosuccess = newcorrectnosuccess + 1;
            end
        end
    end
end

oldaccuracynosuccess = (oldcorrectnosuccess / oldtotalnosuccess) * 100;
newaccuracynosuccess = (newcorrectnosuccess / newtotalnosuccess) * 100;

%% Response Times for old vs novel, all trials

RTold = 0;
RTnew = 0;
oldtotal = 0;
newtotal = 0;

for i = 1:length(data)
    if data (i,?) == 1 % if old
        oldtotal = oldtotal + 1; % add to old total
        RTold = RTold + data(i,?); % add RT to tally of all RTs
    elseif data (i,?) == 0 % if new
        newtotal = newtotal + 1; % add to new
        RTnew = RTnew + data (i,?); % add RT
    end
end

RToldav = RTold / oldtotal; % calc average RT (total RT / trial #)
RTnewav = RTnew / newtotal;

%% RT for old vs novel, no success

RToldno = 0;
RTnewno = 0;
oldtotalno = 0;
newtotalno = 0;

for i = 1:length(data)
    if data (i,?) == 0 %if unsuccessful
        if data (i,?) == 1 % if old
            oldtotano = oldtotalno + 1;
            RToldno = RToldno + data(i,?);
        elseif data (i,?) == 0
            newtotalno = newtotalno + 1;
            RTnewno = RTnewno + data (i,?);
        end
    end
end

RToldavno = RToldno / oldtotalno;
RTnewavno = RTnewno / newtotalno;

%% Compute Gamma between FOK-Accuracy, All no restudy trials

% Accuracy for each non-restudied vs FOK

veryhighFOKincorrect = 0; % tallys
highFOKincorrect = 0;
neutralFOKincorrect = 0;
lowFOKincorrect = 0;
verylowFOKincorrect = 0;

veryhighFOKcorrect = 0;
highFOKcorrect = 0;
neutralFOKcorrect = 0;
lowFOKcorrect = 0;
verylowFOKcorrect = 0;

% If it wasnt restudied, check FOK rating and check accuracy
% Add 1 to either correct or incorrect total for that rating
for i = 1:length(data)
    if data (i, ?) == 0 % if not restudied,
        if data (i, ?) == 5 % if FOK 5 CHANGE
            if data (i,?) == 1 % if correct
                veryhighFOKcorrect = veryhighFOKcorrect + 1; % + 1 to FOK5 correct
            else  % else, must be wrong
                veryhighFOKincorrect = veryhighFOKincorrect + 1; % + 1 to FOK5 incorrect
            end
        elseif data (i, ?) == 4 % CHANGE
            if data (i,?) == 1 
                highFOKcorrect = highFOKcorrect + 1;
            else
                highFOKincorrect = highFOKincorrect + 1;
            end
        elseif data (i, ?) == 3 % CHANGE
            if data (i,?) == 1
                neutralFOKcorrect = neutralFOKcorrect + 1;
            else
                neutralFOKincorrect = neutralFOKincorrect + 1;
            end
        elseif data (i, ?) == 2 % CHANGE
            if data(i,?) == 1
                lowFOKcorrect = lowFOKcorrect + 1;
            else
                lowFOKincorrect = lowFOKincorrect + 1;
            end
        elseif data (i, ?) == 1 % CHANGE
            if data (i,?) == 1
                verylowFOKcorrect = verylowFOKcorrect + 1;
            else
                verylowFOKincorrect = verylowFOKincorrect + 1;
            end
        end
    end
end

FOKvsrightwrong = zeros (5,2); % save right vs wrong values

FOKvsrightwrong (1,1) = verylowFOKincorrect;
FOKvsrightwrong (2,1) = lowFOKincorrect;
FOKvsrightwrong (3,1) = neutralFOKincorrect;
FOKvsrightwrong (4,1) = highFOKincorrect;
FOKvsrightwrong (5,1) = veryhighFOKincorrect;

FOKvsrightwrong (1,2) = verylowFOKcorrect;
FOKvsrightwrong (2,2) = lowFOKcorrect;
FOKvsrightwrong (3,2) = neutralFOKcorrect;
FOKvsrightwrong (4,2) = highFOKcorrect;
FOKvsrightwrong (5,2) = veryhighFOKcorrect;
         
% Gamma Correlational Test 

% Call on gammastat function to calculate gamma correlation 

gkgammatst (FOKvsrightwrong, 0.05, 1); % matrix to be analyzed, alpha, tail, NEED TO DOWNLOAD FILE
% this script needs to be with gkgammatst.m file
gammainfo = [g GKasymototicSE significance]; % save current g and SE values as matrix

FOKAccuracyGammaAll = g; % this is the correlation value
FOKAccuracySignificanceAll = significance; % this is a 1 or 0 to represent if its significant or not

%% Compute Gamma for FOK-Accuracy, Old no restudy trials

% Accuracy for each non-restudied vs FOK

veryhighFOKincorrect = 0;
highFOKincorrect = 0;
neutralFOKincorrect = 0;
lowFOKincorrect =0;
verylowFOKincorrect = 0;

veryhighFOKcorrect = 0;
highFOKcorrect = 0;
neutralFOKcorrect = 0;
lowFOKcorrect = 0;
verylowFOKcorrect = 0;

% If it wasnt restudied, check FOK rating and check accuracy
% Add 1 to either correct or incorrect total for that rating
for i = 1:length(data)
    if data (i,?) == 1 % if its old
        if data (i, ?) == 0 % if not restudied,
            if data (i, ?) == 5 % if FOK 5 CHANGE
                if data (i,?) == 1 % if correct
                    veryhighFOKcorrect = veryhighFOKcorrect + 1; % + 1 to FOK5 correct
                else  % else, must be wrong
                    veryhighFOKincorrect = veryhighFOKincorrect + 1; % + 1 to FOK5 incorrect
                end
            elseif data (i, ?) == 4 % CHANGE
                if data (i,?) == 1
                    highFOKcorrect = highFOKcorrect + 1;
                else
                    highFOKincorrect = highFOKincorrect + 1;
                end
            elseif data (i, ?) == 3 % CHANGE
                if data (i,?) == 1
                    neutralFOKcorrect = neutralFOKcorrect + 1;
                else
                    neutralFOKincorrect = neutralFOKincorrect + 1;
                end
            elseif data (i, ?) == 2 % CHANGE
                if data (i,?) == 1
                    lowFOKcorrect = lowFOKcorrect + 1;
                else
                    lowFOKincorrect = lowFOKincorrect + 1;
                end
            elseif data (i, ?) == 1 % CHANGE
                if data (i,?) == 1
                    verylowFOKcorrect = verylowFOKcorrect + 1;
                else
                    verylowFOKincorrect = verylowFOKincorrect + 1;
                end
            end
        end
    end
end

FOKvsrightwrong = zeros (5,2); % save right vs wrong values

FOKvsrightwrong (1,1) = verylowFOKincorrect;
FOKvsrightwrong (2,1) = lowFOKincorrect;
FOKvsrightwrong (3,1) = neutralFOKincorrect;
FOKvsrightwrong (4,1) = highFOKincorrect;
FOKvsrightwrong (5,1) = veryhighFOKincorrect;

FOKvsrightwrong (1,2) = verylowFOKcorrect;
FOKvsrightwrong (2,2) = lowFOKcorrect;
FOKvsrightwrong (3,2) = neutralFOKcorrect;
FOKvsrightwrong (4,2) = highFOKcorrect;
FOKvsrightwrong (5,2) = veryhighFOKcorrect;
         
% Gamma Correlational Test 

% Call on gammastat function

gkgammatst (FOKvsrightwrong, 0.05, 1); % matrix to be analyzed, alpha, tail, NEED TO DOWNLOAD FILE
gammainfo = [g GKasymototicSE significance]; % save current g and SE values as matrix

FOKAccuracyOldGamma = g;
FOKAccuracyOldSignificance = significance;

%% Compute Gamma for FOK-Accuracy, No success no restudy trials (old and new)

% Accuracy for no success non-restudied vs FOK

veryhighFOKincorrectno = 0;
highFOKincorrectno = 0;
neutralFOKincorrectno = 0;
lowFOKincorrectno =0;
verylowFOKincorrectno = 0;

veryhighFOKcorrectno = 0;
highFOKcorrectno = 0;
neutralFOKcorrectno = 0;
lowFOKcorrectno = 0;
verylowFOKcorrectno = 0;

% If it was not remember and not restudied, check FOK rating and check 
% accuracy .Add 1 to either correct or incorrect total for that rating

for i = 1:length(data)
    if data (i,?) == 0 % if not remembered 
        if data (i, ?) == 0 % if not restudied,
            if data (i, ?) == 5 % if FOK 5 CHANGE
                if data (i,?) == 1 % if correct
                    veryhighFOKcorrectno = veryhighFOKcorrectno + 1; % + 1 to FOK5 correct
                else  % else, must be wrong
                    veryhighFOKincorrectno = veryhighFOKincorrectno + 1; % + 1 to FOK5 incorrect
                end
            elseif data (i, ?) == 4 % CHANGE
                if data (i,?) == 1
                    highFOKcorrectno = highFOKcorrectno + 1;
                else
                    highFOKincorrectno = highFOKincorrectno + 1;
                end
            elseif data (i, ?) == 3 % CHANGE
                if data (i,?) == 1
                    neutralFOKcorrectno = neutralFOKcorrectno + 1;
                else
                    neutralFOKincorrectno = neutralFOKincorrectno + 1;
                end
            elseif data (i, ?) == 2 % CHANGE
                if data (i,?) == 1
                    lowFOKcorrectno = lowFOKcorrectno + 1;
                else
                    lowFOKincorrectno = lowFOKincorrectno + 1;
                end
            elseif rawdata (i, 7) == 1 % CHANGE
                if accuracy (i) == 1
                    verylowFOKcorrectno = verylowFOKcorrectno + 1;
                else
                    verylowFOKincorrectno = verylowFOKincorrectno + 1;
                end
            end
        end
    end
end

FOKvsrightwrongno = zeros (5,2); % save right vs wrong values

FOKvsrightwrongno (1,1) = verylowFOKincorrectno;
FOKvsrightwrongno (2,1) = lowFOKincorrectno;
FOKvsrightwrongno (3,1) = neutralFOKincorrectno;
FOKvsrightwrongno (4,1) = highFOKincorrectno;
FOKvsrightwrongno (5,1) = veryhighFOKincorrectno;

FOKvsrightwrongno (1,2) = verylowFOKcorrectno;
FOKvsrightwrongno (2,2) = lowFOKcorrectno;
FOKvsrightwrongno (3,2) = neutralFOKcorrectno;
FOKvsrightwrongno (4,2) = highFOKcorrectno;
FOKvsrightwrongno (5,2) = veryhighFOKcorrectno;
         
% Gamma Correlational Test 

% Call on gammastat function

gkgammatst (FOKvsrightwrongno, 0.05, 1); % matrix to be analyzed, alpha, tail, NEED TO DOWNLOAD FILE
gammainfo = [g GKasymototicSE significance]; % save current g and SE values as matrix

FOKAccuracyGammaNoSuccess = g;
FOKAccuracySignificanceNoSuccess = significance;

%% Compute Gamma for FOK-Accuracy, No success no restudy trials old only

% Accuracy for no success non-restudied vs FOK

veryhighFOKincorrectno = 0;
highFOKincorrectno = 0;
neutralFOKincorrectno = 0;
lowFOKincorrectno =0;
verylowFOKincorrectno = 0;

veryhighFOKcorrectno = 0;
highFOKcorrectno = 0;
neutralFOKcorrectno = 0;
lowFOKcorrectno = 0;
verylowFOKcorrectno = 0;

% If it was not remember and not restudied, check FOK rating and check
% accuracy .Add 1 to either correct or incorrect total for that rating

for i = 1:length(data)
    if data (i,?) == 1 % if old trial
        if data (i,?) == 0 % if not remembered
            if data (i, ?) == 0 % if not restudied,
                if data (i, ?) == 5 % if FOK 5 CHANGE
                    if data (i,?) == 1 % if correct
                        veryhighFOKcorrectno = veryhighFOKcorrectno + 1; % + 1 to FOK5 correct
                    else  % else, must be wrong
                        veryhighFOKincorrectno = veryhighFOKincorrectno + 1; % + 1 to FOK5 incorrect
                    end
                elseif data (i, ?) == 4 % CHANGE
                    if data (i,?) == 1
                        highFOKcorrectno = highFOKcorrectno + 1;
                    else
                        highFOKincorrectno = highFOKincorrectno + 1;
                    end
                elseif data (i, ?) == 3 % CHANGE
                    if data (i,?) == 1
                        neutralFOKcorrectno = neutralFOKcorrectno + 1;
                    else
                        neutralFOKincorrectno = neutralFOKincorrectno + 1;
                    end
                elseif data (i, ?) == 2 % CHANGE
                    if data (i,?) == 1
                        lowFOKcorrectno = lowFOKcorrectno + 1;
                    else
                        lowFOKincorrectno = lowFOKincorrectno + 1;
                    end
                elseif rawdata (i, 7) == 1 % CHANGE
                    if accuracy (i) == 1
                        verylowFOKcorrectno = verylowFOKcorrectno + 1;
                    else
                        verylowFOKincorrectno = verylowFOKincorrectno + 1;
                    end
                end
            end
        end
    end
end

FOKvsrightwrongno = zeros (5,2); % save right vs wrong values

FOKvsrightwrongno (1,1) = verylowFOKincorrectno;
FOKvsrightwrongno (2,1) = lowFOKincorrectno;
FOKvsrightwrongno (3,1) = neutralFOKincorrectno;
FOKvsrightwrongno (4,1) = highFOKincorrectno;
FOKvsrightwrongno (5,1) = veryhighFOKincorrectno;

FOKvsrightwrongno (1,2) = verylowFOKcorrectno;
FOKvsrightwrongno (2,2) = lowFOKcorrectno;
FOKvsrightwrongno (3,2) = neutralFOKcorrectno;
FOKvsrightwrongno (4,2) = highFOKcorrectno;
FOKvsrightwrongno (5,2) = veryhighFOKcorrectno;
         
% Gamma Correlational Test 

% Call on gammastat function

gkgammatst (FOKvsrightwrongno, 0.05, 1); % matrix to be analyzed, alpha, tail, NEED TO DOWNLOAD FILE
gammainfo = [g GKasymototicSE significance]; % save current g and SE values as matrix

FOKAccuracyGammaNoSuccessOld = g;
FOKAccuracySignificanceNoSuccessOld = significance;

%% Compute Gamma correlation between FOK-Restudy
% first for all trials

% Restudy or not vs FOK

veryhighFOKnotrestudy = 0;
highFOKnotrestudy = 0;
neutralFOKnotrestudy = 0;
lowFOKnotrestudy =0;
verylowFOKnotrestudy = 0;

veryhighFOKrestudy = 0;
highFOKrestudy = 0;
neutralFOKrestudy = 0;
lowFOKrestudy = 0;
verylowFOKrestudy = 0;

% Check FOK rating and restudy choice, add 1 to total depending
for i = 1:length(data)
    if data (i, ?) == 5 % if FOK 5, CHANGE
        if data (i,?) == 1 % if restudied, CHANGE
            veryhighFOKrestudy = veryhighFOKrestudy + 1; % + 1 to FOK5 correct
        else  % else, must be not restudied
            veryhighFOKnotrestudy = veryhighFOKnotrestudy + 1; % + 1 to FOK5 incorrect
        end
    elseif data (i,?) == 4 % CHANGE
        if data (i,?) == 1 % CHANGE
            highFOKrestudy = highFOKrestudy + 1;
        else
            highFOKnotrestudy = highFOKnotrestudy + 1;
        end
    elseif data (i, ?) == 3 % CHANGE
        if data (i,?) == 1 % CHANGE
            neutralFOKrestudy = neutralFOKrestudy + 1;
        else
            neutralFOKnotrestudy = neutralFOKnotrestudy + 1;
        end
    elseif data (i, ?) == 2 % CHANGE
        if data (i,?) == 1 % CHANGE
            lowFOKrestudy = lowFOKrestudy + 1;
        else
            lowFOKnotrestudy = lowFOKnotrestudy + 1;
        end
    elseif data (i, ?) == 1 % CHANGE
        if data (i,?) == 1 % CHANGE
            verylowFOKrestudy = verylowFOKrestudy + 1;
        else
            verylowFOKnotrestudy = verylowFOKnotrestudy + 1;
        end
    end
end

FOKvsrestudied = zeros (5,2); % save right vs wrong values

FOKvsrestudied (1,1) = verylowFOKnotrestudy;
FOKvsrestudied (2,1) = lowFOKnotrestudy;
FOKvsrestudied (3,1) = neutralFOKnotrestudy;
FOKvsrestudied (4,1) = highFOKnotrestudy;
FOKvsrestudied (5,1) = veryhighFOKnotrestudy;

FOKvsrestudied (1,2) = verylowFOKrestudy;
FOKvsrestudied (2,2) = lowFOKrestudy;
FOKvsrestudied (3,2) = neutralFOKrestudy;
FOKvsrestudied (4,2) = highFOKrestudy;
FOKvsrestudied (5,2) = veryhighFOKrestudy;

% Gamma Correlational Test

% Call on gammastat function

gkgammatst (FOKvsrestudied, 0.05, 1); % matrix to be analyzed, alpha, tail 
gammainfo = [g GKasymototicSE significance]; % save current g and SE values as matrix

FOKRestudyGammaAll = g;
FOKRestudySignificanceAll = significance;

%% Compute FOK-Restudy Gamma for trials with no recall success
% Restudy or not vs FOK

veryhighFOKnotrestudy = 0;
highFOKnotrestudy = 0;
neutralFOKnotrestudy = 0;
lowFOKnotrestudy =0;
verylowFOKnotrestudy = 0;

veryhighFOKrestudy = 0;
highFOKrestudy = 0;
neutralFOKrestudy = 0;
lowFOKrestudy = 0;
verylowFOKrestudy = 0;

for i = 1:length(data)
        if data (i,?) == 0 % if its unsuccessful CHANGE
            if data (i, ?) == 5 % if FOK 5 % CHANGE
                if data (i,?) == 1 % if restudied CHANGE
                    veryhighFOKrestudy = veryhighFOKrestudy + 1; % + 1 to FOK5 correct
                else  % else, must be not restudied
                    veryhighFOKnotrestudy = veryhighFOKnotrestudy + 1; % + 1 to FOK5 incorrect
                end
            elseif data (i, ?) == 4 % CHANGE
                if data (i,?) == 1 % CHANGE
                    highFOKrestudy = highFOKrestudy + 1;
                else
                    highFOKnotrestudy = highFOKnotrestudy + 1;
                end
            elseif data (i, ?) == 3 %CHANGE
                if data (i,?) == 1 %CHANGE
                    neutralFOKrestudy = neutralFOKrestudy + 1;
                else
                    neutralFOKnotrestudy = neutralFOKnotrestudy + 1;
                end
            elseif data (i, ?) == 2 % CHANGE
                if data (i,?) == 1 %CHANGE
                    lowFOKrestudy = lowFOKrestudy + 1;
                else
                    lowFOKnotrestudy = lowFOKnotrestudy + 1;
                end
            elseif data (i, ?) == 1 % CHANGE
                if data (i,?) == 1 % CHANGE
                    verylowFOKrestudy = verylowFOKrestudy + 1;
                else
                    verylowFOKnotrestudy = verylowFOKnotrestudy + 1;
                end
            end
        end
    end
end

FOKvsrestudied = zeros (5,2); % save right vs wrong values

FOKvsrestudied (1,1) = verylowFOKnotrestudy;
FOKvsrestudied (2,1) = lowFOKnotrestudy;
FOKvsrestudied (3,1) = neutralFOKnotrestudy;
FOKvsrestudied (4,1) = highFOKnotrestudy;
FOKvsrestudied (5,1) = veryhighFOKnotrestudy;

FOKvsrestudied (1,2) = verylowFOKrestudy;
FOKvsrestudied (2,2) = lowFOKrestudy;
FOKvsrestudied (3,2) = neutralFOKrestudy;
FOKvsrestudied (4,2) = highFOKrestudy;
FOKvsrestudied (5,2) = veryhighFOKrestudy;

% Gamma Correlational Test

% Call on gammastat function

gkgammatst (FOKvsrestudied, 0.05, 1); % matrix to be analyzed, alpha, tail
gammainfo = [g GKasymototicSE significance]; % save current g and SE values as matrix

FOKRestudyNoSuccessGamma = g;
FOKRestudyNoSuccessSignificance = significance;

%% Compute FOK-Restudy Gamma for old trials
% restudy or no vs FOK

veryhighFOKnotrestudy = 0;
highFOKnotrestudy = 0;
neutralFOKnotrestudy = 0;
lowFOKnotrestudy =0;
verylowFOKnotrestudy = 0;

veryhighFOKrestudy = 0;
highFOKrestudy = 0;
neutralFOKrestudy = 0;
lowFOKrestudy = 0;
verylowFOKrestudy = 0;

for i = 1:length(data)
    if data (i,?) == 1 % if its old CHANGE
        if data (i, ?) == 5 % if FOK 5 % CHANGE
            if data (i,?) == 1 % if restudied CHANGE
                veryhighFOKrestudy = veryhighFOKrestudy + 1; % + 1 to FOK5 correct
            else  % else, must be not restudied
                veryhighFOKnotrestudy = veryhighFOKnotrestudy + 1; % + 1 to FOK5 incorrect
            end
        elseif data (i, ?) == 4 % CHANGE
            if data (i,?) == 1 % CHANGE
                highFOKrestudy = highFOKrestudy + 1;
            else
                highFOKnotrestudy = highFOKnotrestudy + 1;
            end
        elseif data (i, ?) == 3 %CHANGE
            if data (i,?) == 1 %CHANGE
                neutralFOKrestudy = neutralFOKrestudy + 1;
            else
                neutralFOKnotrestudy = neutralFOKnotrestudy + 1;
            end
        elseif data (i, ?) == 2 % CHANGE
            if data (i,?) == 1 %CHANGE
                lowFOKrestudy = lowFOKrestudy + 1;
            else
                lowFOKnotrestudy = lowFOKnotrestudy + 1;
            end
        elseif data (i, ?) == 1 % CHANGE
            if data (i,?) == 1 % CHANGE
                verylowFOKrestudy = verylowFOKrestudy + 1;
            else
                verylowFOKnotrestudy = verylowFOKnotrestudy + 1;
            end
        end
    end
end

FOKvsrestudied = zeros (5,2); % save right vs wrong values

FOKvsrestudied (1,1) = verylowFOKnotrestudy;
FOKvsrestudied (2,1) = lowFOKnotrestudy;
FOKvsrestudied (3,1) = neutralFOKnotrestudy;
FOKvsrestudied (4,1) = highFOKnotrestudy;
FOKvsrestudied (5,1) = veryhighFOKnotrestudy;

FOKvsrestudied (1,2) = verylowFOKrestudy;
FOKvsrestudied (2,2) = lowFOKrestudy;
FOKvsrestudied (3,2) = neutralFOKrestudy;
FOKvsrestudied (4,2) = highFOKrestudy;
FOKvsrestudied (5,2) = veryhighFOKrestudy;

% Gamma Correlational Test

% Call on gammastat function

gkgammatst (FOKvsrestudied, 0.05, 1); % matrix to be analyzed, alpha, tail
gammainfo = [g GKasymototicSE significance]; % save current g and SE values as matrix

FOKRestudyOldGamma = g;
FOKRestudyOldSignificance = significance;

%% Compute FOK-Restudy Gamma for old trials with no recall success
% restudy or no vs FOK

veryhighFOKnotrestudy = 0;
highFOKnotrestudy = 0;
neutralFOKnotrestudy = 0;
lowFOKnotrestudy =0;
verylowFOKnotrestudy = 0;

veryhighFOKrestudy = 0;
highFOKrestudy = 0;
neutralFOKrestudy = 0;
lowFOKrestudy = 0;
verylowFOKrestudy = 0;

for i = 1:length(data)
    if data (i,?) == 0 % if its unsuccessful CHANGE
        if data (i, ?) == 5 % if FOK 5 % CHANGE
            if data (i,?) == 1 % if restudied CHANGE
                veryhighFOKrestudy = veryhighFOKrestudy + 1; % + 1 to FOK5 correct
            else  % else, must be not restudied
                veryhighFOKnotrestudy = veryhighFOKnotrestudy + 1; % + 1 to FOK5 incorrect
            end
        elseif data (i, ?) == 4 % CHANGE
            if data (i,?) == 1 % CHANGE
                highFOKrestudy = highFOKrestudy + 1;
            else
                highFOKnotrestudy = highFOKnotrestudy + 1;
            end
        elseif data (i, ?) == 3 %CHANGE
            if data (i,?) == 1 %CHANGE
                neutralFOKrestudy = neutralFOKrestudy + 1;
            else
                neutralFOKnotrestudy = neutralFOKnotrestudy + 1;
            end
        elseif data (i, ?) == 2 % CHANGE
            if data (i,?) == 1 %CHANGE
                lowFOKrestudy = lowFOKrestudy + 1;
            else
                lowFOKnotrestudy = lowFOKnotrestudy + 1;
            end
        elseif data (i, ?) == 1 % CHANGE
            if data (i,?) == 1 % CHANGE
                verylowFOKrestudy = verylowFOKrestudy + 1;
            else
                verylowFOKnotrestudy = verylowFOKnotrestudy + 1;
            end
        end
    end
end

FOKvsrestudied = zeros (5,2); % save right vs wrong values

FOKvsrestudied (1,1) = verylowFOKnotrestudy;
FOKvsrestudied (2,1) = lowFOKnotrestudy;
FOKvsrestudied (3,1) = neutralFOKnotrestudy;
FOKvsrestudied (4,1) = highFOKnotrestudy;
FOKvsrestudied (5,1) = veryhighFOKnotrestudy;

FOKvsrestudied (1,2) = verylowFOKrestudy;
FOKvsrestudied (2,2) = lowFOKrestudy;
FOKvsrestudied (3,2) = neutralFOKrestudy;
FOKvsrestudied (4,2) = highFOKrestudy;
FOKvsrestudied (5,2) = veryhighFOKrestudy;

% Gamma Correlational Test

% Call on gammastat function

gkgammatst (FOKvsrestudied, 0.05, 1); % matrix to be analyzed, alpha, tail
gammainfo = [g GKasymototicSE significance]; % save current g and SE values as matrix

FOKRestudyOldNoSuccessGamma = g;
FOKRestudyOldNoSuccessSignificance = significance;

%% Compute FOK vs RT correlations with all trials

[allr, p] = corr (data(:,?), data(:,?), 'Type', 'Spearman'); % correlate the FOK and RT column of data chart
% uses Spearman as to not make assumptions about underlying distribution
% shape
% Pearson assumes normally distributed RTs
if p <= 0.05 % tests sig of p value
    allsig = 1;
else 
    allsig = 0;
end

%% Compute with no success trials only

newdata = []; % restructure data 

for i = 1:length(data)
    if data (i,?) == 0 % if recall unsuccessful
        newdata = [newdata; data(i,:)]; % puts all information from this row into new data chart
    end
end
% make a new chart with only trials lacking in percived recall success

[nosuccessr, p] = corr (newdata(:,?), newdata(:,?), 'Type', 'Spearman'); % correlated again
if p <= 0.05
    nosuccesssig = 1;
else 
    nosuccesssig = 0;
end

%% Compute with old trials only

newdata = []; % restructure data 

for i = 1:length(data)
    if data (i,?) == 1 % if item is old
        newdata = [newdata; data(i,:)]; % puts all information from this row into new data chart
    end
end
% make a new chart with only trials lacking in percived recall success

[oldr, p] = corr (newdata(:,?), newdata(:,?), 'Type', 'Spearman'); % correlated again
if p <= 0.05
    oldsig = 1;
else 
    oldsig = 0;
end

%% Compute with old, no success trials only

newdata = []; % restructure data 

for i = 1:length(data)
    if data (i,?) == 0 % if recall unsuccessful
        if data(i,?) == 1 % if old
            newdata = [newdata; data(i,:)]; % puts all information from this row into new data chart
        end
    end
end
% make a new chart with only trials lacking in percived recall success

[oldnosuccessr, p] = corr (newdata(:,?), newdata(:,?), 'Type', 'Spearman'); % correlated again
if p <= 0.05
    oldnosuccesssig = 1;
else 
    oldnosuccesssig = 0;
end

%% Save Results

% all these numbers that were calculated are entered into a new chart
processeddata = zeros (1, 41); 
processeddata (1,1) = FOKoldav;
processeddata (1,2) = FOKnewav;
processeddata (1,3) = FOKoldnosuccessav;
processeddata (1,4) = FOKnewnosuccessav;
processeddata (1,5) = oldaccuracy;
processeddata (1,6) = newaccuracy;
processeddata (1,7) = oldaccuracynosuccess;
processeddata (1,8) = newaccuracynosuccess;
processeddata (1,9) = overallaccuracy;
processeddata (1,10) = oldproportion;
processeddata (1,11) = novelproportion;
processeddata (1,12) = oldproportionnosuccess;
processeddata (1,13) = novelproportionnosuccess;
processeddata (1,14) = RToldav;
processeddata (1,15) = RTnewav;
processeddata (1,16) = RToldavno;
processeddata (1,17) = RTnewavno;
processeddata (1,18) = FOKAccuracyGammaAll;
processeddata (1,19) = FOKAccuracySignificanceAll;
processeddata (1,20) = FOKAccuracyGammaNoSuccess;
processeddata (1,21) = FOKAccuracySignificanceNoSuccess;
processeddata (1,22) = FOKAccuracyOldGamma;
processeddata (1,23) = FOKAccuracyOldSignificance;
processeddata (1,24) = FOKAccuracyGammaNoSuccessOld;
processeddata (1,25) = FOKAccuracySignificanceNoSuccessOld;
processeddata (1,26) = FOKRestudyGammaAll;
processeddata (1,27) = FOKRestudySignificanceAll;
processeddata (1,28) = FOKRestudyNoSuccessGamma;
processeddata (1,29) = FOKRestudyNoSuccessSignificance;
processeddata (1,30) = FOKRestudyOldGamma;
processeddata (1,31) = FOKRestudyOldSignificance;
processeddata (1,32) = FOKRestudyOldNoSuccessGamma;
processeddata (1,33) = FOKRestudyOldNoSuccessSignificance;
processeddata (1,34) = allr;
processeddata (1,35) = allsig;
processeddata (1,36) = nosuccessr;
processeddata (1,37) = nosuccesssig;
processeddata (1,38) = oldr;
processeddata (1,39) = oldsig;
processeddata (1,40) = oldnosuccessr;
processeddata (1,41) = oldnosuccesssig;

%% Save as a growing matrix file
% this section will compile everyone's data for you as you go
% it will import a chart of everyones data and add this new participants
% data as a new row and save the new chart
% before you run this script the 1st time:
% open Excel and save a blank file as a txt file in the location specified
% below with the name specified below

masterfolder = fullfile ...
    ('OUTPUT FILE PATH');...
    % INSERT PATH TO FOLDER WHERE YOU ARE SAVING the total OUTPUT
masterdata = load...
    (fullfile(masterfolder, 'processed_data_all.txt')); %import "master data" list
masterdata = [masterdata; processeddata]; % combine the current matrix with master, replace master
filename = fullfile ...
    (masterfolder,'processed_data_all.txt');
dlmwrite (filename, masterdata); % save new master in file

masterdatatable = array2table (masterdata, 'VariableNames',...
    {'AverageFOKOld', 'AverageFOKNew', 'AverageFOKOldNoSuccess', 'AverageFOKNewNoSuccess', 'OldAccuracy',...
    'NewAccuracy', 'OldAccuracyNoSuccess', 'NewAccuracyNoSuccess', 'OverallAccuracy', 'OldProportionRestudied',...
    'NewProportionRestudied', 'OldProportionRestudiedNoSuccess', 'NewProportionRestudiedNoSuccess',...
    'AverageRTOld', 'AverageRTNew', 'AverageRTOldNoSuccess', 'AverageRTNewNoSuccess',...
    'FOKAccuracyGammaAllNoRestudyTrials', 'FOKAccuracySignificanceAllNoRestudyTrials', ...
    'FOKAccuracyGammaNoSuccessNoRestudyTrials', 'FOKAccuracySignificanceNoSuccessNoRestudyTrials',...
    'FOKAccuracyGammaOldNoRestudyTrials', 'FOKAccuracySignificanceOldNoRestudyTrials', ....
    'FOKAccuracyGammaOldNoSuccessNoRestudyTrials', 'FOKAccuracySignificanceOldNoSuccessNoRestudyTrials',...
    'FOKRestudyGammaAllTrials', 'FOKRestudySignificanceAllTrials','FOKRestudyGammaNoSuccessTrials',...
    'FOKRestudySignificanceNoSuccessTrials','FOKRestudyGammaOldTrials', 'FOKRestudySignificanceOldTrials',...
    'FOKRestudyGammaOldNoSuccessTrials', 'FOKRestudySignificanceOldNoSuccessTrials',...
    'FOKRTSpearmanCorrelationAllTrials', 'FOKRTSignificanceAllTrials', 'FOKRTSpearmanCorrelationNoSuccessTrials',...
    'FOKRTSignificanceNoSuccessTrials', 'FOKRTSpearmanCorrelationOldTrials', 'FOKRTSignificanceOldTrials',...
    'FOKRTSpearmanCorrelationOldNoSuccessTrials', 'FOKRTSignificanceOldNoSuccessTrials'});
% names all the columns in the output excel file
tablename = fullfile...
    (masterfolder, 'processed_data_alltable.xlsx');
writetable (masterdatatable, tablename); 
% also save as Excel file for easy viewing later

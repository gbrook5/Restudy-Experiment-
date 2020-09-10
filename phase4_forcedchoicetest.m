% FOK-RESTUDY WITH NOVELTY PARADIGM

% Phase 4 - Forced Choice Recongition Test

%% Storage

if exist ('fullFileName')
    resultsMatrix = dlmread (fullFileName);
elseif ~exist('fullFileName')
    path = input ('subjID: ', 's');
    pFolder = fullfile...
        ('/home/kohlerlab/Greg/FOK-Restudy Imaging Study/Unprocessed Subject Data', path);
    pFile = fullfile...
        ('/home/kohlerlab/Greg/FOK-Restudy Imaging Study',...
        'Unprocessed Subject Data', path, ['Data.', path '.' '01' '.mat']);
    fullFileName = fullfile ...
        (pFolder, 'participantresults.txt');
    resultsMatrix = dlmread(fullFileName);
    indicesencode = dlmread(fullfile (pFolder, 'indicesencode.txt'));
    indicesall = dlmread(fullfile...
        (pFolder, 'indicesall.txt'));
    Fnameindicesfoil = dlmread(fullfile...
        (pFolder, 'Fnameindicesfoil.txt'));
    Mnameindicesfoil = dlmread(fullfile...
        (pFolder, 'Mnameindicesfoil.txt'));
    datastrucname = ['Data' '.' path '.' '01' '.' 'mat'];
    datapath = fullfile (pFolder,datastrucname);
    load (datapath);
end

%% Timing Information

isiTimeSecs = 0.5; 
isiTimeFrames = round(isiTimeSecs / ifi);

%% Images

% imageFolderPractice = [filesep 'home' filesep 'gbrooks' filesep 'Documents' filesep...
%     'FOK-Restudy Experimental Paradigm' filesep 'All Faces' filesep 'Face Sets Organized' filesep...
%     'Face Set 1' filesep 'Practice' filesep];

imageFolderTask = ['C:' filesep 'Users' filesep 'gabro' filesep 'Documents' filesep 'Graduate Studies'...
    filesep 'Research' filesep 'Novelty + FOK Behavioural' filesep 'Experimental Paradigm'...
    filesep 'Encoding + Novel Faces' filesep];

%% Names

namefolder = ['/' filesep 'home' filesep 'kohlerlab' filesep 'Greg' filesep 'FOK-Restudy Imaging Study'...
    filesep 'Experimental Paradigm' filesep 'Names.xlsx'];
names = readtable (namefolder,'Sheet', 'Full Names', 'Range', 'A1:B209'); % get table with namesnames = table2array (names);  

names = table2array(names);
names = string(names);
firstname = names(:,1);
lastname = names (:,2);
bothnames = strcat(firstname, {' '},lastname);
bothnames = char(bothnames);
 
%% Keyboard Setup

KbName('UnifyKeyNames');
spaceKey = KbName('space');
escapeKey = KbName('Escape');
option1 = KbName ('1');
option2 = KbName ('2');
option3 = KbName ('3');

%% Experimental Loop

line1 = 'To conclude, you will now complete a recognition memory test.';
line2 = '\n\n each face will appear with 3 options for their name and you will select';
line3 = '\n\n Using the 1, 2 and 3 keys the option you think is correct.';
line4 = '\n\n Images will appear on-screen automatically after previous choice is made.';
Screen ('TextSize', window, 35);
Screen ('TextFont', window, 'Times');
DrawFormattedText (window, [line1 line2 line3 line4],  'center', screenYpixels * 0.25, black);
line5 = 'Press Space To Continue Onto Faces.';
Screen ('TextSize', window, 35);
Screen ('TextFont', window, 'Times');
DrawFormattedText (window, [line5], 'center', screenYpixels * 0.80, black);
Screen('Flip', window);
KbStrokeWait;

% faceindicespractice = randperm (166, (trialnumbertotal - trialnumber));
rng ('shuffle');
indicesforcedchoice = indicesall (randperm(size(indicesall,1)),:); % shuffle order

femaletrials = 0;
maletrials = 0;

rangefemale = [1:52]; % get range of female-showing faces 
femalestudied = [];

rangemale = [53:104]; %same
malestudied = [];

for i = 1:length(resultsMatrix)
    if resultsMatrix (i,3) == 0 % if not encoded
        if resultsMatrix (i,7) == 1 % if restudied
            if sum(i == rangefemale) > 0 
                femalestudied = [femalestudied, i];
            elseif sum(i == rangemale) > 0
                malestudied = [malestudied, i];
            end
        end     
    end
end

rangefemalefamiliar = [rangefemale, femalestudied]; % get list of which faces are familiar (used as foils)
% list is all the old faces, those studied, and any new face that was
% chosen for restudy
rangemalefamiliar = [rangemale, malestudied];

positions = [0.75 0.86 0.97]; % 3 positions on screen to show names          
ordermatrix = zeros (104,3);  
orderposition = zeros(1,3);
   
for i = 1:104 
    ordermatrix (i,:) = positions(randperm(numel(positions),3)); % wll randomly shuffle each "position" for each trial  
end
    
for trials = 1:length(indicesforcedchoice)     
    respToBeMade = true; 
    if trials == (length(indicesforcedchoice))/2 % break halfway
        breaktext = 'REST! \n\n Press space when \n\n you are ready to continue';
        Screen ('TextSize', window, 60);
        Screen ('TextFont', window, 'Times');
        DrawFormattedText (window, [breaktext], 'center', 'center', black);
        Screen ('Flip', window);
        KbStrokeWait; 
    end 
    imageName = ['CFD-1 ' '(' num2str(indicesforcedchoice(trials,1)) ')' '.jpg'];
    theImage = imread([imageFolderTask imageName]); % get face
    [s1, s2, s3] = size(theImage);
    imageTexture = Screen ('MakeTexture', window, theImage);
    aspectRatio = s2/s1; 
    imageHeights = screenYpixels/1.55; 
    imageWidths = imageHeights * aspectRatio;   
    theRect = [(screenXpixels/2 - imageWidths/2) 10 (screenXpixels/2 + imageWidths/2) (imageHeights + 10)];
    fullnamereal = bothnames (indicesforcedchoice(trials,2),:); 
    fullnamereal = strtrim (fullnamereal); % get real name, correct answer
    if sum(indicesforcedchoice (trials,1) == rangefemale) > 0 % if female face
        femaletrials = femaletrials + 1;
        fullnamefoil = bothnames(Fnameindicesfoil(femaletrials),:);
        fullnamefoil = strtrim (fullnamefoil); % get female name for foil (aka is new)
        lureindexface = rangefemalefamiliar(randperm(numel(rangefemalefamiliar),1)); % choose a lure
        while lureindexface == indicesforcedchoice(trials,1) % if its the same try again
            lureindexface = rangefemalefamiliar(randperm(numel(rangefemalefamiliar),1)); 
        end
        [maxval, lureindexpos] = max(indicesforcedchoice(:,1) == lureindexface); % get the name of that lure
        lureindexname = indicesforcedchoice(lureindexpos, 2);
        fullnamelure = bothnames (lureindexname,:);
        fullnamelure = strtrim (fullnamelure);  
    elseif sum(indicesforcedchoice (trials) == rangemale) > 0 
        maletrials = maletrials + 1;   
        fullnamefoil = bothnames(Mnameindicesfoil (maletrials), :);
        fullnamefoil = strtrim (fullnamefoil); 
        lureindexface = rangemalefamiliar(randperm(numel(rangemalefamiliar),1));
        while lureindexface == indicesforcedchoice(trials,1)
            lureindexface = rangemalefamiliar(randperm(numel(rangemalefamiliar),1));
        end
        [maxval, lureindexpos] = max(indicesforcedchoice(:,1) == lureindexface);
        lureindexname = indicesforcedchoice(lureindexpos, 2);
        fullnamelure = bothnames (lureindexname,:);
        fullnamelure = strtrim (fullnamelure);  
    end 
    tStart = GetSecs;
    while respToBeMade == true  
        Screen ('DrawTexture', window, imageTexture, [], theRect);        
        Screen ('TextSize', window, 60);     
        Screen ('TextFont', window, 'Arial'); 
        firstoption = find (ordermatrix(trials,:) == 0.75); 
        orderposition (1,firstoption) = 1; % get which name will be in position 1
        secondoption = find (ordermatrix(trials,:) == 0.86);
        orderposition (1,secondoption) = 2; % position 2
        thirdoption = find (ordermatrix(trials,:) == 0.97);
        orderposition (1,thirdoption) = 3; % position 3
        DrawFormattedText (window, [num2str(orderposition(1,1)), '. ', fullnamereal],...
            'center', (screenYpixels * (ordermatrix(trials,1))), black);  
        DrawFormattedText (window, [num2str(orderposition(1,2)), '. ', fullnamefoil],...
            'center', (screenYpixels * (ordermatrix (trials,2))), black);
        DrawFormattedText (window, [num2str(orderposition(1,3)), '. ', fullnamelure],...
            'center', (screenYpixels * (ordermatrix(trials,3))), black);
        Screen ('Flip', window); % draw each name and show them with the face and prompt      
        [keyIsDown, secs, keyCode] = KbCheck; % get answer       
        if keyCode(escapeKey)    
            ShowCursor;
            sca; 
            return  
        elseif keyCode (option1)
            forcedchoice = 1;
            respToBeMade = false; 
        elseif keyCode (option2)
            forcedchoice = 2;
            respToBeMade = false; 
        elseif keyCode (option3)
            forcedchoice = 3;
            respToBeMade = false; % record
        end 
    end
    tEnd = GetSecs;
    tForcedChoice = tEnd - tStart;
    accuracy = (orderposition(1,1) == forcedchoice); % sees if correct
    resultsMatrix (indicesforcedchoice (trials,1), 14) = trials; % save data
    resultsMatrix (indicesforcedchoice (trials,1), 15) = orderposition (1,1); % this is the correct answer
    resultsMatrix (indicesforcedchoice (trials,1), 16) = forcedchoice; % their answer
    resultsMatrix (indicesforcedchocie (trials,1), 17) = accuracy; % if correct
    resultsMatrix (indicesforcedchoice (trials,1), 18) = orderposition (1,3);
    resultsMatrix (indicesforcedchoice (trials,1), 19) = orderposition (1,2);    
    resultsMatrix (indicesforcedchoice (trials,1), 20) = tForcedChoice;
    Screen ('Close', imageTexture);
    Screen('DrawDots', window, [xCenter; yCenter], 10, black, [], 2);
    Screen('Flip', window);
    for frames = 1:isiTimeFrames -1 
        Screen('Flip', window); 
        Screen ('DrawDots', window, [xCenter; yCenter], 10, black, [], 2);
        Screen ('Flip', window);  
    end 
end
 
Screen ('TextSize', window, 80);
DrawFormattedText (window, 'Section Finished \n\n Press Any Key To Exit',...
    'center', 'center', black);
Screen ('Flip', window);
KbStrokeWait; % end, etc.

%% Save Data Matrix 

dlmwrite (fullFileName, resultsMatrix); % save

resultsTable = array2table (resultsMatrix,'VariableNames', {'Face', 'Name', 'OldOrNovel', 'OrderEncoded',...
'OrderRetrieved', 'Recall', 'FOKRating', 'ResponseTimeTotal', 'ResponseTimeRecall', 'ResponseTimeFOK',...
'OrderRestudied', 'RestudyChoice', 'RestudyResponseTime', 'ForcedChoiceOrder', 'ForcedChoiceCorrectResponse',...
'ForcedChoiceActualResponse', 'Accuracy', 'ForcedChoiceFamiliarLure', 'ForcedChoiceNewFoil',...
'ForcedChoiceResponseTime'});
fulltablename = fullfile (pFolder, 'participantresultstable.xlsx');
writetable(resultsTable, fulltablename); % also save as table with column headings in case you want to double check
 
Data.endTime = datestr(now); % save experiment finish time
save(pFile, 'Data');
 
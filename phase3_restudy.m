% FOK-Restudy with Novelty Paradigm

% Phase 3 - Restudy Choices

%% Storage

if exist ('fullFileName') % same as ever
    resultsMatrix = dlmread (fullFileName);
elseif ~exist('fullFileName')
    path = input ('subjID: ', 's');
    pFolder = fullfile...
        ('/home/kohlerlab/Greg/FOK-Restudy Imaging Study/Unprocessed Subject Data', path);
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
 
imageFolderTask = ['C:', filesep 'Users' filesep 'gabro' filesep 'Documents' filesep 'Graduate Studies' filesep...
    'Research' filesep 'Novelty + FOK Behavioural' filesep 'Experimental Paradigm' filesep ...
    'Encoding + Novel Faces' filesep];  

%% Names

namefolder = ['/' filesep 'home' filesep 'kohlerlab' filesep 'Greg' filesep 'FOK-Restudy Imaging Study'...
    filesep 'Experimental Paradigm' filesep 'Names.xlsx'];
names = readtable (namefolder,'Sheet', 'Full Names', 'Range', 'A1:B209'); % get table with names

names = table2array (names);  
names = string(names);
firstname = names(:,1);
lastname = names (:,2);
bothnames = strcat(firstname, {' '},lastname);
bothnames = char(bothnames);

%% Keyboard Setup

KbName('UnifyKeyNames');
spaceKey = KbName('space');
escapeKey = KbName('Escape');
yeschoice = KbName ('UpArrow');
nochoice = KbName ('DownArrow');

%% Experimental Loop

line1 = 'Now you will get the chance to see some of the names again.';
line2 = '\n\n You will be able to choose up to one half (39) of the faces to restudy the name.';
line3 = '\n\n You will move through each face and will say either yes I wish to see their name,'; 
line4 = '\n\n using the Up Arrow, in which case the face and name will appear together again on screen';
line5 = '\n\n or no I do not want to, using the Down Arrow, moving you right to the next face.';
line6 = '\n\n A countdown with how many yes chocies you have left will be in the bottom corner';
line7 = '\n\n and you will get a break halfway through.';
Screen ('TextSize', window, 30);
Screen ('TextFont', window, 'Times');
DrawFormattedText (window, [line1 line2 line3 line4 line5 line6 line7],  'center', screenYpixels * 0.10, black);
line5 = 'Press Space To Continue Onto Experiment.';
Screen ('TextSize', window, 35); 
Screen ('TextFont', window, 'Times');
DrawFormattedText (window, [line5], 'center', screenYpixels * 0.93, black);
Screen('Flip', window);
KbStrokeWait; % instructions and wait
 
% faceindicespractice = randperm (166, (trialnumbertotal - trialnumber));
rng ('shuffle');
indicesrestudy = indicesall (randperm(size(indicesall,1)),:); % shuffle trial order

% encodemaxchocies
restudyselection = 0;

for trials = 1:length(indicesrestudy)     
    respToBeMade = true;
    choicesleft = num2str(52 - restudyselection); % change to specify number of restudy choices
    if trials == (length(indicesrestudy))/2 % if halfway give a break
        breaktext = 'REST! \n\n Press space when \n\n you are ready to continue';
        Screen ('TextSize', window, 60);
        Screen ('TextFont', window, 'Times');
        DrawFormattedText (window, [breaktext], 'center', 'center', black);
        Screen ('Flip', window);
        KbStrokeWait;
    end
    imageName = ['CFD-1 ' '(' num2str(indicesrestudy(trials,1)) ')' '.jpg'];
    theImage = imread([imageFolderTask imageName]); % get face
    [s1, s2, s3] = size(theImage);
    imageTexture = Screen ('MakeTexture', window, theImage);
    aspectRatio = s2/s1; 
    imageHeights = screenYpixels/1.4; 
    imageWidths = imageHeights * aspectRatio;  
    theRect = [(screenXpixels/2 - imageWidths/2) 150 (screenXpixels/2 + imageWidths/2) (imageHeights + 150)];
    question = 'Would you like to see their name again (Yes = Up, Down = No)?';
  %  question2 = '\n\n Indicate yes with the Up Arrow and no with the Down Arrow.'
    tStart = GetSecs;
    while respToBeMade == true 
        if restudyselection >= 52 % if exceeded max number
            Screen ('TextSize', window, 50);
            Screen ('TextFont', window, 'Times');
            Screen ('DrawTexture', window, imageTexture, [], theRect); 
            DrawFormattedText (window, [question], 'center', screenYpixels *0.1, black);
            Screen ('TextSize', window, 30);
            DrawFormattedText (window, ['\n\n Out of restudy selections! Must select no!'],...
                'center', screenYpixels * 0.1, black);
            Screen ('TextSize', window, 30);  
            DrawFormattedText (window, ['Choices Left:  ', choicesleft], screenXpixels * 0.80, screenYpixels * 0.9, black); 
            Screen ('Flip', window); 
            [keyIsDown, secs, keyCode] = KbCheck;   
            if keyCode (escapeKey)
                ShowCursor;
                sca;
                return
            elseif keyCode (nochoice)
                restudychoice = 0;
                respToBeMade = false; % only allow no choice
            end
        else % if they still have some restudies remaining
            Screen ('TextSize', window, 50);
            Screen ('TextFont', window, 'Times');
            Screen ('DrawTexture', window, imageTexture, [], theRect);
            DrawFormattedText (window, [question], 'center', screenYpixels * 0.12, black);
            Screen ('TextSize', window, 30);
            DrawFormattedText (window, ['Choices Left: ', choicesleft], screenXpixels * 0.80, screenYpixels * 0.9, black);
            Screen('Flip', window); % countdown displayed
            [keyIsDown, secs, keyCode] = KbCheck;  % look for keyboard
            if keyCode (escapeKey) % can exit
                ShowCursor;
                sca;
                return  
            elseif keyCode (yeschoice) % if yes, show the face-name pair
                restudychoice = 1;
                imageName = ['CFD-1 ' '(' num2str(indicesrestudy(trials,1)) ')' '.jpg'];
                theImage = imread([imageFolderTask imageName]);
                [s1, s2, s3] = size(theImage);
                imageTexture = Screen ('MakeTexture', window, theImage);
                aspectRatio = s2/s1;
                imageHeights = screenYpixels/1.4;
                imageWidths = imageHeights * aspectRatio;
                theRect = [(screenXpixels/2 - imageWidths/2) 40 (screenXpixels/2 + imageWidths/2) (imageHeights + 40)];
                fullname = bothnames (indicesrestudy(trials,2),:);
                fullname = strtrim (fullname);
                Screen ('DrawTexture', window, imageTexture, [], theRect);
                Screen ('TextSize', window, 90);
                Screen ('TextFont', window, 'Arial');
                DrawFormattedText (window, [fullname], 'center', screenYpixels * 0.93, black);
                Screen ('Flip', window);
                if keyCode(escapeKey)
                    ShowCursor;
                    sca;
                    return
                end
                WaitSecs(3); % show for 3 seconds
                respToBeMade = false;
                restudyselection = restudyselection + 1; % add 1 to the restudy used total
            elseif keyCode (nochoice) % if choice was no, move along
                restudychoice = 0;
                respToBeMade = false;
            end
        end 
    end
    tEnd = GetSecs;
    tRestudy = tEnd - tStart; % get choice time
    resultsMatrix (indicesrestudy(trials,1), 11) = trials; % save data
    resultsMatrix (indicesrestudy(trials,1), 12) = restudychoice;
    resultsMatrix (indicesrestudy(trials,1), 13) = tRestudy;
    Screen('Close',[imageTexture]);
    Screen('DrawDots', window, [xCenter; yCenter], 10, black, [], 2);
    Screen('Flip', window);
    for frames = 1:isiTimeFrames -1 % do ITI
        Screen('Flip', window); 
        Screen ('DrawDots', window, [xCenter; yCenter], 10, black, [], 2);
        Screen ('Flip', window);  
    end 
end
   
Screen ('TextSize', window, 80);
DrawFormattedText (window, 'Section Finished \n\n Press Any Key To Exit',...
    'center', 'center', black);
Screen ('Flip', window);
KbStrokeWait; % end, wait
 
%% Save Data

dlmwrite (fullFileName , resultsMatrix);
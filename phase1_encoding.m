% FOK-RESTUDY WITH NOVELTY BEHAVIOURAL PARADIGM
  
% Phase 1 - Encoding Phase 

%% Storage

if exist ('fullFileName') % this is what usually will happen, itll bring in the results
    resultsMatrix = dlmread (fullFileName);
elseif ~exist('fullFileName') % if computer crashed this will allow the recovery of that participant information/data
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

Data.startTime = datestr(now);

%% Timing Information

isiTimeSecs = 0.5; 
isiTimeFrames = round(isiTimeSecs / ifi);

%% Images

% imageFolderPractice = ['C:' filesep 'Users' filesep 'gabro' filesep 'Documents' filesep...
%     'Graduate Studies' filesep 'Thesis' filesep 'FOK-Restudy Experimental Paradigm' filesep...
%     'Practice' filesep]; 
 
imageFolderTask = ['C:' filesep 'Users' filesep 'gabro' filesep 'Documents' filesep...
    'Graduate Studies' filesep 'Research' filesep 'Novelty + FOK Behavioural' filesep ...
    'Experimental Paradigm' filesep 'Encoding + Novel Faces' filesep]; % location of face images

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

KbName('UnifyKeyNames'); % set up keyboard again
spaceKey = KbName('space');
escapeKey = KbName('Escape');

%% Presentation randomization

rng ('shuffle');
encodepresent = indicesencode (randperm(size(indicesencode,1)),:); % shuffle face order

for i = 1:length(indicesencode) % save encoding order, the new faces will all have 0s
    resultsMatrix (encodepresent(i,1),4) = i;    
end

%% Experimental Loop

line1 = 'In this part, a series of faces will appear on-screen indiviudally';
line2 = '\n\n with a name beneath it.';
line3 = '\n\n Please memorize the full name of each person while they are on screen.';
line4 = '\n\n Experiment will automatically proceed with no need for keyboard presses,';
line5 = '\n\n but you will get a break halfway through to help maintain your focus.';
Screen ('TextSize', window, 35);
Screen ('TextFont', window, 'Times');
DrawFormattedText (window, [line1 line2 line3 line4 line5],  'center', screenYpixels * 0.25, black);
line6 = 'Press Space To Continue Onto Experiment.'; 
Screen ('TextSize', window, 35);
Screen ('TextFont', window, 'Times');
DrawFormattedText (window, [line6], 'center', screenYpixels * 0.80, black);
Screen('Flip', window);
KbStrokeWait; % new instructions appear, waits for keyboard press

% encodetrials = 1; 
          
for trials = 1:length(indicesencode) % for each encode trial     
    if trials == ((length(indicesencode))/2 +1) % if halfway, gives break
        breaktext = 'REST! \n\n Press space when \n\n you are ready to continue';
        Screen ('TextSize', window, 60);
        Screen ('TextFont', window, 'Times');
        DrawFormattedText (window, [breaktext], 'center', 'center', black);
        Screen ('Flip', window);
        KbStrokeWait;
    end
    imageName = ['CFD-1 ' '(' num2str(indicesencode(trials,1)) ')' '.jpg']; % gets face
    theImage = imread([imageFolderTask imageName]);
    [s1, s2, s3] = size(theImage);
    imageTexture = Screen ('MakeTexture', window, theImage);
    aspectRatio = s2/s1; 
    imageHeights = screenYpixels/1.4; % can change size
    imageWidths = imageHeights * aspectRatio;   
    theRect = [(screenXpixels/2 - imageWidths/2) 40 (screenXpixels/2 + imageWidths/2) (imageHeights + 40)]; % can change position
    fullname = bothnames (indicesencode(trials,2),:); 
    fullname = strtrim (fullname); % gets name
    Screen ('DrawTexture', window, imageTexture, [], theRect);       
    Screen ('TextSize', window, 90);    
    Screen ('TextFont', window, 'Arial');    
    DrawFormattedText (window, [fullname], 'center', screenYpixels * 0.93, black);   
    Screen ('Flip', window); % puts face and name on screen
    [keyIsDown, secs, keyCode] = KbCheck; % looks for keyboard     
    if keyCode(escapeKey) % allows you to exit if need be   
        ShowCursor;
        sca; % closes screen
        return
    end
    WaitSecs(3); % 3 s face-name pair display length
    Screen('DrawDots', window, [xCenter; yCenter], 10, black, [], 2); % draw fixation dots
    Screen('Flip', window);
    for frames = 1:isiTimeFrames -1 % ITI displayed
        Screen ('DrawDots', window, [xCenter; yCenter], 10, black, [], 2);
        Screen ('Flip', window);  
    end 
    Screen('Close', imageTexture);
end
 
Screen('TextSize', window, 80);
DrawFormattedText (window, 'Section Finished \n\n Press Any Key To Exit',...
    'center', 'center', black);
Screen ('Flip', window);
KbStrokeWait; % section finished message
 
%% Save Data Matrix

fullFileName = fullfile (pFolder, 'participantresults.txt'); % saves growing results
dlmwrite(fullFileName, resultsMatrix);  
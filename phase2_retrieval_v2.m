% FOK-RESTUDY WITH NOVELTY BEHAVIOURAL PARADIGM

% Phase 2 - Recall/FOK Phase with Novel Faces

%% Storage

if exist ('fullFileName') % same as before
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
    eyetrack = Data.eyetrack;
    eyetracking = str2num(eyetrack); % converts to number
end

timingdata = zeros(105,9); % will allow the saving of more accurate timing info

%% Preperation for eye tracking (if applicable, mostly copied code)

if eyetracking == 1 % if you are eye tracking
    % Check Eye Tracking
    
    defaultEyetracking='yes';
    validEyetracking={'yes','no'};
    checkEyetracking=@(x) any(validatestring(x,validEyetracking));
    
    % Setup Eye-Tracking
    
    edfFile=strcat(pFolder, 'ED'); % Data file name
    fprintf('EDFFile: %s\n', edfFile );
    
    el=EyelinkInitDefaults(window); % Mysterious initializing function...
    
    % Initialization of the connection with the Eyelink Gazetracker. Exit function if failed
    dummymode=dummypilot;
    if ~EyelinkInit(dummymode)
        fprintf('Eyelink Init aborted.\n');
        cleanup;
        return;
    end
    
    % The following code is used to check the version of the eye tracker and version of the host software
    
    [v,vs]=Eyelink('GetTrackerVersion');
    fprintf('Running experiment on a ''%s'' tracker.\n', vs);
    
    % Open file to record data to
    fi = Eyelink('Openfile', edfFile);
    if fi~=0
        fprintf('Cannot create EDF file ''%s'' ', edfFile);
        Eyelink( 'Shutdown');
        Screen('CloseAll');
        return;
    end
    
    Eyelink('command', 'add_file_preamble_text ''Recorded by EyelinkToolbox demo-experiment''');
    [width, height]=Screen('WindowSize', screenNumber);
    
    % Reduce calibration and validation FOV to adapt to scanner screen
    Eyelink('command','calibration_area_proportion = 0.80 0.80');
    Eyelink('command','validation_area_proportion = 0.75 0.75');
    
    % SET UP TRACKER CONFIGURATION
    % Setting the proper recording resolution, proper calibration type, as well as the data file content;
    Eyelink('command','screen_pixel_coords = %ld %ld %ld %ld', 0, 0, width-1, height-1);
    Eyelink('message', 'DISPLAY_COORDS %ld %ld %ld %ld', 0, 0, width-1, height-1);
    
    % Set calibration type. (5 points)
    Eyelink('command', 'calibration_type = HV5');
    
    % Set EDF file contents using the file_sample_data and file-event_filter commands
    % Set link data thtough link_sample_data and link_event_filter
    Eyelink('command', 'file_event_filter = LEFT,RIGHT,FIXATION,SACCADE,BLINK,MESSAGE,BUTTON,INPUT');
    Eyelink('command', 'link_event_filter = LEFT,RIGHT,FIXATION,SACCADE,BLINK,MESSAGE,BUTTON,INPUT');
    
    % Check the software version
    % Add "HTARGET" to record possible target data for EyeLink Remote
    if sscanf(vs(12:end),'%f') >=4
        Eyelink('command', 'file_sample_data  = LEFT,RIGHT,GAZE,HREF,AREA,HTARGET,GAZERES,STATUS,INPUT');
        Eyelink('command', 'link_sample_data  = LEFT,RIGHT,GAZE,GAZERES,AREA,HTARGET,STATUS,INPUT');
    else
        Eyelink('command', 'file_sample_data  = LEFT,RIGHT,GAZE,HREF,AREA,GAZERES,STATUS,INPUT');
        Eyelink('command', 'link_sample_data  = LEFT,RIGHT,GAZE,GAZERES,AREA,STATUS,INPUT');
    end
    
    % Make sure we're still connected. We can call this at the beginning of each run if we really need
    % eye data, but otherwise just call it once here
    if Eyelink('IsConnected')~=1 && dummymode == 0
        fprintf('not connected, clean up\n');
        Eyelink('Shutdown');
        Screen('CloseAll');
        return;
    end
    
    % Calibrate the eye tracker
    % setup the proper calibration foreground and background colors
    el.backgroundcolour = grey;
    el.calibrationtargetcolour = black;
    
    % Parameters are in frequency, volume, and duration
    % Set the second value in each line to 0 to turn off the sound
    el.cal_target_beep=[600 0.5 0.05];
    el.drift_correction_target_beep=[600 0.5 0.05];
    el.calibration_failed_beep=[400 0.5 0.25];
    el.calibration_success_beep=[800 0.5 0.25];
    el.drift_correction_failed_beep=[400 0.5 0.25];
    el.drift_correction_success_beep=[800 0.5 0.25];
    % You must call this function to apply the changes from above
    EyelinkUpdateDefaults(el);
    % Call another mysterious function...
    EyelinkDoTrackerSetup(el);
    eye_track_starttime = GetSecs;
end

%% Timing Information

isiTimeSecs = 0.5; % ITI length
isiTimeFrames = round(isiTimeSecs / ifi);
waitframes = 1;

%% Images
 
imageFolderTask = ['/' filesep 'home' filesep 'kohlerlab' filesep 'Greg' filesep...
    'FOK-Restudy + Novelty Study' filesep 'Experimental Paradigm' filesep 'Encoding + Novel Faces' filesep]; % faces
  
%% Keyboard Setup

KbName('UnifyKeyNames'); % set up keyboard responses for this phase
spaceKey = KbName('space');
escapeKey = KbName('Escape');
remembered = KbName('UpArrow');
failedtorecall = KbName('DownArrow');
noFOK = KbName('1!');
littleFOK = KbName ('2@');
neutralFOK = KbName ('3#');
FOK = KbName ('4$');
highFOK = KbName ('5%');

%% Randomize

rng ('shuffle');
retrievepresent = indicesall (randperm(size(indicesall,1)),:); % randomize order
 
%% Experimental Loop

line1 = 'Next, faces will appear on the screen and you must try and recall that persons full name.';
line2 = '\n\n Once you are ready, you need to indicate whether or not you were successfully';
line3 = '\n\n able to remember their whole name. Answer this truthfully using either the';
line4 = '\n\n Up Arrow for yes or the Down Arrow for no.';
line5 = '\n\n Then, you will be asked to judge how likely it is, from 1 to 5, that you could';
line6 = '\n\n correctly recognize the name. Please try and distribute your responses across the entire';
line7 = '\n\n 1 to 5 scale, and keep in mind that these ratings are about whether you think you could';
line8 = '\n\n recognize the name if given and not about whether you can recall it right now.'; 
line9 = '\n\n The experiment will proceed once these answers are provided.';
Screen ('TextSize', window, 35 );
Screen ('TextFont', window, 'Times');  
DrawFormattedText (window, [line1 line2 line3 line4 line5 line6 line7 line8 line9],...
    'center', screenYpixels * 0.10, black);
line10 = 'Press Space To Continue Onto Experiment.';
Screen ('TextSize', window, 75);
Screen ('TextFont', window, 'Times');
DrawFormattedText (window, [line10], 'center', screenYpixels * 0.95, black);
Screen('Flip', window);
KbStrokeWait; % instructions and wait
timeinstruct = GetSecs;

for trials = 1:length(retrievepresent)
    if eyetracking == 1
        exp_start = GetSecs;
        Eyelink('Command', 'set_idle_mode');
        WaitSecs(0.05);
        %         Eyelink('StartRecording', 1, 1, 1, 1);
        Eyelink('StartRecording');
        % record a few samples before we actually start displaying
        % otherwise you may lose a few msec of data
        WaitSecs(0.1);
        Eyelink('Message','ITIStart');
    end
    ITIstart = GetSecs;
    for frames = 1:isiTimeFrames-1
        Screen('DrawDots', window, [xCenter; yCenter], 10, black, [], 2);
        Screen('Flip', window);
    end
    ITIend = GetSecs;
    timeITI = ITIend - ITIstart;
    respToBeMade = true;
    imageName = ['CFD-1 ' '(' num2str(retrievepresent(trials,1)) ')' '.jpg'];
    theImage = imread([imageFolderTask imageName]); % gets face
    [s1, s2, s3] = size(theImage);
    imageTexture = Screen ('MakeTexture', window, theImage);
    aspectRatio = s2/s1;
    imageHeights = screenYpixels/1.25; % change size
    imageWidths = imageHeights * aspectRatio;
    theRect = [(screenXpixels/2 - imageWidths/2) 130 (screenXpixels/2 + imageWidths/2) (imageHeights + 130)]; % position
    recallquestion = 'Can you remember the persons full name?';
    recallquestion2 = '\n Up Arrow = yes, Down Arrow = no.';
    while respToBeMade == true
        Screen ('TextSize', window, 60);
        Screen ('TextFont', window, 'Times');
        Screen ('DrawTexture', window, imageTexture, [], theRect);
        DrawFormattedText (window, [recallquestion],  'center', screenYpixels * 0.1, black);
        Screen ('TextSize', window, 40);
        DrawFormattedText (window, [recallquestion2], 'center', screenYpixels * 0.1, black);
        tStart = GetSecs; % gets stim start
        if eyetracking == 1
            Eyelink('Message', 'StimOnset'); % logs the stimulus onset into eye data file
        end
        Screen('Flip', window); % puts face and prompt on screen
        [keyIsDown,secs,keyCode] = KbCheck; % looks for keyboard
        if keyCode (escapeKey) % allows you to exit
            sca;
            return
        elseif keyCode(remembered) % they're answer is provided and saved
            recallresponse = 1;
            respToBeMade = false;
        elseif keyCode(failedtorecall)
            recallresponse = 0;
            respToBeMade = false;
        end
    end
    tMiddle = GetSecs; % gets the mid time
    respToBeMade = true;
    FOKquestion = 'How likely is it that you would correctly recognize their name?';
    FOKquestion2 = '\n\n Use a 1 to 5 scale, where 1 = very unlikely and 5 = very likely';
    Screen ('TextSize', window, 50);
    Screen ('TextFont', window, 'Times');
    while respToBeMade == true
        DrawFormattedText (window, [FOKquestion FOKquestion2],  'center', 'center' , black);
        if eyetracking == 1
            Eyelink ('Message', 'FOKQStart'); % logs FOK start
        end
        tFOKstart = GetSecs;
        Screen('Flip', window);
        [keyIsDown,secs,keyCode] = KbCheck;% looks for keyboard, gets answer, records it
        if keyCode (escapeKey)
            sca;
            return
        elseif keyCode(noFOK)
            FOKresponse = 1;
            respToBeMade = false;
        elseif keyCode(littleFOK)
            FOKresponse = 2;
            respToBeMade = false;
        elseif keyCode (neutralFOK)
            FOKresponse = 3;
            respToBeMade = false;
        elseif keyCode (FOK)
            FOKresponse = 4;
            respToBeMade = false;
        elseif keyCode (highFOK)
            FOKresponse = 5;
            respToBeMade = false;
        end
    end
    tEnd = GetSecs;
    if eyetracking == 1
        Eyelink ('Message', 'FOKJudgementEnd');
    end
    tRecall = tMiddle - tStart;
    tFOK = tEnd - tFOKstart;
    tAll = tEnd - tStart;
    resultsMatrix (retrievepresent(trials,1), 5) = trials; % saves data
    resultsMatrix (retrievepresent(trials,1), 6) = recallresponse;
    resultsMatrix (retrievepresent(trials,1), 7) = FOKresponse;
    resultsMatrix (retrievepresent(trials,1), 8) = tAll;    
    resultsMatrix (retrievepresent(trials,1), 9) = tRecall;
    resultsMatrix (retrievepresent(trials,1), 10) = tFOK;
    if trials == 1
        if eyetracking == 1
            timingdata (trials,2) = eye_track_starttime; % saves timing info
        end
        timingdata (trials,3) = timeinstruct;
    end
    timingdata (trials,1) = trials; % saves timing info
    timingdata (trials,4) = ITIstart;
    timingdata (trials,5) = timeITI;
    timingdata (trials,6) = tStart;
    timingdata (trials,7) = tEnd;
    timingdata (trials,8) = tRecall;
    timingdata (trials,9) = tFOK;
    timingdata (trials,10) = tAll;
    if eyetracking == 1
        Eyelink ('Message', 'TrialEnd');
        Eyelink('StopRecording'); % pauses recording until next trial
    end
    Screen('Close', imageTexture);
end

ITIstart = GetSecs; % do the final ITI
Screen('DrawDots', window, [xCenter; yCenter], 10, black, [], 2);
Screen('Flip', window);
for frames = 1:isiTimeFrames-1
    Screen('DrawDots', window, [xCenter; yCenter], 10, black, [], 2);
    Screen('Flip', window);
end
ITIend = GetSecs;
timeITI = ITIend-ITIstart;
Endtime = GetSecs;

timingdata(trials+1,5) = timeITI; % save the final ITI timing
timingdata(trials+1,4) = ITIstart;
timingdata(trials+1,11) = Endtime;

Screen ('TextSize', window, 100 );
DrawFormattedText (window, 'Section Finished \n\n Press Any Key To Exit',...
    'center', 'center', black);
Screen ('Flip', window);
KbStrokeWait; % section finished, wait, continue
       
%% Save Matrix

dlmwrite (fullFileName, resultsMatrix); % save data
fullFileNameT = fullfile (pFolder, 'timingdata.txt'); % saves it as easy to see TXT
dlmwrite (fullFileNameT, timingdata_run1);

save('timingdata.mat','timingdata'); % also saves as .mat file for decimal precision

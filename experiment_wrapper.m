%% Experiment wrapper script
% Run once, it will run each phase with pause between

%% Run set-up script

run phase0_setup.m

%% Screen Setup

PsychDefaultSetup (2); % just random screen set up stuff
screens = Screen ('Screens');
screenNumber = max(screens); % will open it on external monitor if using one

black = BlackIndex (screenNumber);
white = WhiteIndex (screenNumber);
grey = white/2; % can change background colour if needed (this is a medium grey)

[window, windowRect] = PsychImaging ('OpenWindow', screenNumber, grey); % creates window

Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');
[screenXpixels, screenYpixels] = Screen('WindowSize', window); % gets size in pixels
[xCenter, yCenter] = RectCenter (windowRect); % gets middle pixel 
ifi = Screen ('GetFlipInterval', window); % gets flip rate

ListenChar(2); % silences keyboard so stuff doesn't get typed into scripts
HideCursor; % hides cursor

%% Run Phase 1 Encoding

run phase1_encoding.m

%% Between phase break

line1 = 'Please wait for experiment to continue.'; % can customize this message, I have it this so a participant waits in scanner until I'm ready
Screen ('TextSize', window, 35);
Screen ('TextFont', window, 'Times');
DrawFormattedText (window, [line1],  'center', screenYpixels * 0.25, black); 
Screen('Flip', window);
KbStrokeWait; % waits for you to press anything

%% Run Phase 2 FOK Test Phase

run phase2_retrieval_v2.m

%% Between phase break

line1 = 'Please wait for experiment to continue.'; % can customize this message, I have it this so a participant waits in scanner until I'm ready
Screen ('TextSize', window, 35);
Screen ('TextFont', window, 'Times');
DrawFormattedText (window, [line1],  'center', screenYpixels * 0.25, black); 
Screen('Flip', window);
KbStrokeWait; % waits for you to press anything

%% Run Phase 3 Restudy Phase

run phase3_restudy.m

%% Between phase break

line1 = 'Please wait for experiment to continue.'; % can customize this message, I have it this so a participant waits in scanner until I'm ready
Screen ('TextSize', window, 35);
Screen ('TextFont', window, 'Times');
DrawFormattedText (window, [line1],  'center', screenYpixels * 0.25, black); 
Screen('Flip', window);
KbStrokeWait; % waits for you to press anything

%% Run Phase 4 Forced Choice Recognition-Memory Test

run phase4_forcedchoicetest.m

%% Between phase break

line1 = 'Please wait for experiment to continue.'; % can customize this message, I have it this so a participant waits in scanner until I'm ready
Screen ('TextSize', window, 35);
Screen ('TextFont', window, 'Times');
DrawFormattedText (window, [line1],  'center', screenYpixels * 0.25, black); 
Screen('Flip', window);
KbStrokeWait; % waits for you to press anything

%% Run Curiosity Questionnaire (if needed)

run curiosity_questionnaire.m

%% Exit Experiment

line1 = 'Experiment Finished! Thanks for participating'; % can customize this message
Screen ('TextSize', window, 35);
Screen ('TextFont', window, 'Times');
DrawFormattedText (window, [line1],  'center', screenYpixels * 0.25, black); 
Screen('Flip', window);
KbStrokeWait; % waits for you to press anything
ListenChar(0);
ShowCursor;
sca;

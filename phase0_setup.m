% FOK-Restudy with Novelty Study

% Phase 0 - participant set-up and curiosity questionnaires

%% Participant Information and Folder Set-Up

rng ('shuffle');

checkPID = true;
while checkPID == true
    pID = input ('Participant ID: ', 's'); % will ask uou to input participant ID
    ssnID = input ('Session ID: ', 's'); % will ask for a session #
    sex = input ('Sex: ', 's'); % asks for demographics
    age = input ('Age: ', 's');
    eyetrack = input('Are you eye tracking? 1 for yes, 0 for no? ', 's'); % asks if youre eye tracking
    % allows you to pilot scrips without eye tracker
    eyetracking = str2num(eyetrack); % converts to number
    if isempty(pID)
        pID = '999';
    end
    if isempty (ssnID)
        if isempty(varargin) || ~any(strcmp(varagin, 'DefaultSession'))
            ssnID = '1';
        else
            index = find(strcmp(varagin, 'DefaultSession'));
            ssnID = varagin{index + 1};
        end
    end
    fprintf ('\n Saving data as Data.%s.%s.mat\n\n', pID, ssnID)
    checkPID = false;
    pFile = fullfile...
        ('/home/kohlerlab/Greg/FOK-Restudy + Novelty Study',...
        'Unproccessed Subject Data', pID, ['Data.', pID '.' ssnID, '.mat']); % creates new subfolder for participant
    if exist(pFile, 'file')
        moveOn = input ('WARNING: Datafile already exists! Overwrite? (y/n) ', 's'); % warns you if that one is alread created
        if isempty (moveOn) || moveOn == 'n'
            checkPID = true;
        end
    end
end

pFolder = fullfile...
    ('C:\Users\gabro\Documents\Graduate Studies\Monique',...
    'Unprocessed Subject Data', pID);
if ~exist (pFolder)
    mkdir(pFolder);
end

Data.pID = pID; % saves some data/time/demographic info
Data.ssnID = ssnID;
Data.startTime = datestr(now);
Data.gender = sex;
Data.age = age;
Data.eyetrack = eyetrack;

save(pFile, 'Data');

%% Face - Name Combination Generatior

rng('shuffle');
Ffaceindices = (randperm (52,52))'; % randomly shuffle 52 female faces
Mfaceindices = (randperm (52,52) + 52)'; % also shuffle 52 male faces

Fencode = Ffaceindices (1:39,1); % use first 39 in encoding phase
Mencode = Mfaceindices (1:39,1); 

faceindicesencode = [Fencode; Mencode]; % create list of 78 encoding faces

Fnovel = Ffaceindices (40:52,1); % final 13 faces are novel ones
Mnovel = Mfaceindices (40:52,1);

faceindicesnovel = [Fnovel; Mnovel]; % create list of novel face #s

Fnameindices = (randperm(104,104))'; % sracmble all 104 female and male names
Mnameindices = (randperm (104,104) + 104)'; 
Fnameindicesreal = Fnameindices (1:52,1); % use first 52 as "real" names
Mnameindicesreal = Mnameindices (1:52,1);
Fnameindicesfoil = Fnameindices (53:104,1); % remaining 52 are foils in the memory test
Mnameindicesfoil = Mnameindices (53:104,1);

Fnameindicesfoilpath = fullfile(pFolder,'Fnameindicesfoil.txt');
dlmwrite(Fnameindicesfoilpath, Fnameindicesfoil);
Mnameindicesfoilpath = fullfile(pFolder,'Mnameindicesfoil.txt');
dlmwrite(Mnameindicesfoilpath, Mnameindicesfoil);

nameindicesencode = [Fnameindicesreal(1:39,1); Mnameindicesreal(1:39,1)]; % first 39 of each name are encoding

nameindicesnovel = [Fnameindicesreal(40:52,1); Mnameindicesreal(40:52,1)]; % remaning ones are for novel faces

indicesencode = [faceindicesencode, nameindicesencode];
indicesencodename = fullfile(pFolder,'indicesencode.txt');
dlmwrite(indicesencodename, indicesencode);

indicesnovel = [faceindicesnovel, nameindicesnovel];

indicesall = [indicesencode; indicesnovel]; % create lists of randomized names
indicesallname = fullfile(pFolder,'indicesall.txt');
dlmwrite(indicesallname, indicesall);

%% Storage

resultsMatrix = nan(104, 19); % create matrix for result storage
newcol = (1:104)'; 
resultsMatrix = [newcol resultsMatrix]; % 1st column will be 1 to 104 list (for face #s)

for i = 1:length(indicesall)
    resultsMatrix (indicesall(i,1),2) = indicesall (i,2);
    if i <= length(indicesencode)
        resultsMatrix (indicesall(i,1),3) = 1;
    elseif i > length(indicesencode)
        resultsMatrix (indicesall(i,1),3) = 0;
        resultsMatrix (indicesall(i,1),4) = 0;
    end
end

questionnairematrix = nan (12,2); % this is for the curiosity questionnaire, may not be needed

%% 

fullFileName = fullfile (pFolder, 'participantresults.txt'); % saves results matrices as txt files
dlmwrite (fullFileName, resultsMatrix);

fullFileNameQ = fullfile (pFolder, 'participantquestionnaire.txt');
dlmwrite (fullFileNameQ, questionnairematrix);

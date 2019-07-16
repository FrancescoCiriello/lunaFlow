function acquireBackgroundApp(app)
% The _acquireBackgroundApp_ function works within the camFlowAqApp to
% acquire 'x' (= app.framesbackgroundEditField.Value) frames from the
% active cameras as ticked in checkboxes of the active cameras tab
% (app.CheckBox_*.Value = 1). It stores the background frames and a mean
% background image into a temp folder and also into app.cam1.background.
%
% Developed by F. Ciriello 12/7/2019.

fprintf('\nBackground AQ launched... \n')
numframes = app.framesbackgroundEditField.Value;

%% set manual triggers and store original # of AQ frames
if app.CheckBox_1.Value == 1
    mkdir([app.projectfolderEditField.Value, '\temp\cam1'])
    app.cam1.camera.vid.LoggingMode = 'memory';
    triggerconfig(app.cam1.camera.vid, 'manual');
    numAqFramesStore(1) = app.cam1.camera.vid.FramesPerTrigger;
    app.cam1.camera.vid.FramesPerTrigger = numframes;
end
if app.CheckBox_2.Value == 1
    mkdir([app.projectfolderEditField.Value, '\temp\cam2'])
    app.cam2.camera.vid.LoggingMode = 'memory';
    triggerconfig(app.cam2.camera.vid, 'manual');
    numAqFramesStore(2) = app.cam2.camera.vid.FramesPerTrigger;
    app.cam2.camera.vid.FramesPerTrigger = numframes;
end
if app.CheckBox_3.Value == 1
    mkdir([app.projectfolderEditField.Value, '\temp\cam3'])
    app.cam3.camera.vid.LoggingMode = 'memory';
    triggerconfig(app.cam3.camera.vid, 'manual');
    numAqFramesStore(3) = app.cam3.camera.vid.FramesPerTrigger;
    app.cam3.camera.vid.FramesPerTrigger = numframes;
end
if app.CheckBox_4.Value == 1
    mkdir([app.projectfolderEditField.Value, '\temp\cam4'])
    app.cam4.camera.vid.LoggingMode = 'memory';
    triggerconfig(app.cam4.camera.vid, 'manual');
    numAqFramesStore(4) = app.cam4.camera.vid.FramesPerTrigger;
    app.cam4.camera.vid.FramesPerTrigger = numframes;
end

%% acquire background images

%% cam 1 (only)
if app.CheckBox_1.Value == 1 && app.CheckBox_2.Value == 0 && app.CheckBox_3.Value == 0 && app.CheckBox_4.Value == 0
    % trigger
    start(app.cam1.camera.vid)
    pause(5) % loading time
    trigger(app.cam1.camera.vid)
    
    % acquire
    fprintf('\nAcquiring background images...\n')
    while islogging(app.cam1.camera.vid) == 1 
    end
    fprintf('\nBackground video acquisition complete\n')
    
    % get frames out of volatile memory
    [backgroundFrames, ~] = getdata(app.cam1.camera.vid, app.cam1.camera.vid.FramesPerTrigger);
    
    % make mean
    backgroundMean = backgroundFrames(:,:,:,1); 
    for i = 2:numframes 
        backgroundMean = imadd(0.5*backgroundMean, 0.5*backgroundFrames(:,:,:,i));  % weighted addition
    end
    
    % save into app temp memory
    app.cam1.background.frames = backgroundFrames;
    app.cam1.background.mean = backgroundMean;
    
    % save into temp folder
    save([app.projectfolderEditField.Value, '\temp\cam1\backgroundFrames.mat'] , 'backgroundFrames')
    imwrite(app.cam1.background.mean, [app.projectfolderEditField.Value, '\temp\cam1\backgroundMean.bmp'])
    fprintf(['\nBackground cam1 image stored in temp.\n'])
   
    % cleanup
     pause(2)
     app.cam1.camera.vid.FramesPerTrigger = numAqFramesStore(1);
    
end

%% cam 2 (only)
if app.CheckBox_1.Value == 0 && app.CheckBox_2.Value == 1 && app.CheckBox_3.Value == 0 && app.CheckBox_4.Value == 0
    % trigger
    start(app.cam2.camera.vid)
    pause(5) % loading time
    trigger(app.cam2.camera.vid)
    
    % acquire
    fprintf('\nAcquiring background images...\n')
    while islogging(app.cam2.camera.vid) == 1 
    end
    fprintf('\nBackground video acquisition complete\n')
    
    % get frames out of volatile memory
    [backgroundFrames, ~] = getdata(app.cam2.camera.vid, app.cam2.camera.vid.FramesPerTrigger);
    
    % make mean
    backgroundMean = backgroundFrames(:,:,:,1); 
    for i = 2:numframes 
        backgroundMean = imadd(0.5*backgroundMean, 0.5*backgroundFrames(:,:,:,i));  % weighted addition
    end
    
    % save into app temp memory
    app.cam2.background.frames = backgroundFrames;
    app.cam2.background.mean = backgroundMean;
    
    % save into temp folder
    save([app.projectfolderEditField.Value, '\temp\cam2\backgroundFrames.mat'] , 'backgroundFrames')
    imwrite(app.cam2.background.mean, [app.projectfolderEditField.Value, '\temp\cam2\backgroundMean.bmp'])
    fprintf(['\nBackground cam2 image stored in temp.\n'])
   
    % cleanup
    pause(2)
     app.cam2.camera.vid.FramesPerTrigger = numAqFramesStore(1);
    
end

%% cam 3 (only)
if app.CheckBox_1.Value == 0 && app.CheckBox_2.Value == 0 && app.CheckBox_3.Value == 1 && app.CheckBox_4.Value == 0
    % trigger
    start(app.cam3.camera.vid)
    pause(5) % loading time
    trigger(app.cam3.camera.vid)
    
    % acquire
    fprintf('\nAcquiring background images...\n')
    while islogging(app.cam3.camera.vid) == 1 
    end
    fprintf('\nBackground video acquisition complete\n')
    
    % get frames out of volatile memory
    [backgroundFrames, ~] = getdata(app.cam3.camera.vid, app.cam3.camera.vid.FramesPerTrigger);
    
    % make mean
    backgroundMean = backgroundFrames(:,:,:,1); 
    for i = 2:numframes 
        backgroundMean = imadd(0.5*backgroundMean, 0.5*backgroundFrames(:,:,:,i));  % weighted addition
    end
    
    % save into app temp memory
    app.cam3.background.frames = backgroundFrames;
    app.cam3.background.mean = backgroundMean;
    
    % save into temp folder
    save([app.projectfolderEditField.Value, '\temp\cam3\backgroundFrames.mat'] , 'backgroundFrames')
    imwrite(app.cam3.background.mean, [app.projectfolderEditField.Value, '\temp\cam3\backgroundMean.bmp'])
    fprintf(['\nBackground cam3 image stored in temp.\n'])
   
    % cleanup
        pause(2)
     app.cam3.camera.vid.FramesPerTrigger = numAqFramesStore(1);
    
end

%% cam 4 (only)
if app.CheckBox_1.Value == 0 && app.CheckBox_2.Value == 0 && app.CheckBox_3.Value == 0 && app.CheckBox_4.Value == 1
    % trigger
    start(app.cam4.camera.vid)
    pause(5) % loading time
    trigger(app.cam4.camera.vid)
    
    % acquire
    fprintf('\nAcquiring background images...\n')
    while islogging(app.cam4.camera.vid) == 1 
    end
    fprintf('\nBackground video acquisition complete\n')
    
    % get frames out of volatile memory
    [backgroundFrames, ~] = getdata(app.cam4.camera.vid, app.cam4.camera.vid.FramesPerTrigger);
    
    % make mean
    backgroundMean = backgroundFrames(:,:,:,1); 
    for i = 2:numframes 
        backgroundMean = imadd(0.5*backgroundMean, 0.5*backgroundFrames(:,:,:,i));  % weighted addition
    end
    
    % save into app temp memory
    app.cam4.background.frames = backgroundFrames;
    app.cam4.background.mean = backgroundMean;
    
    % save into temp folder
    save([app.projectfolderEditField.Value, '\temp\cam4\backgroundFrames.mat'] , 'backgroundFrames')
    imwrite(app.cam4.background.mean, [app.projectfolderEditField.Value, '\temp\cam4\backgroundMean.bmp'])
    fprintf(['\nBackground cam4 image stored in temp.\n'])
   
    % cleanup
    pause(2)
     app.cam4.camera.vid.FramesPerTrigger = numAqFramesStore(1);
    
end
%% cam 1 & 2
if app.CheckBox_1.Value == 1 && app.CheckBox_2.Value == 1 && app.CheckBox_3.Value == 0 && app.CheckBox_4.Value == 0
    % trigger
    start([app.cam1.camera.vid, app.cam2.camera.vid])
    fprintf('\nTriggering in 8 seconds (cameras loading)...\n')
    pause(8)
    trigger([app.cam1.camera.vid, app.cam2.camera.vid])
    
    % acquire
    fprintf('\nAcquiring background images...\n')
    while islogging(app.cam1.camera.vid) == 1 || islogging(app.cam2.camera.vid) == 1
    end
    fprintf('\nBackground video acquisition complete\n')
    
% get frames out of volatile memory
    [backgroundFrames1, ~] = getdata(app.cam1.camera.vid, app.cam1.camera.vid.FramesPerTrigger);
    [backgroundFrames2, ~] = getdata(app.cam2.camera.vid, app.cam2.camera.vid.FramesPerTrigger);
    
    
    % make mean
    backgroundMean1 = backgroundFrames1(:,:,:,1); 
    backgroundMean2 = backgroundFrames2(:,:,:,1); 
    for i = 2:numframes 
        backgroundMean1 = imadd(0.5*backgroundMean1, 0.5*backgroundFrames1(:,:,:,i));  % weighted addition
        backgroundMean2 = imadd(0.5*backgroundMean2, 0.5*backgroundFrames2(:,:,:,i));  % weighted addition

    end
    
    % save into app temp memory
    app.cam1.background.frames = backgroundFrames1;
    app.cam2.background.frames = backgroundFrames2;
    app.cam1.background.mean = backgroundMean1;
    app.cam2.background.mean = backgroundMean2;
    
    % save into temp folder
    save([app.projectfolderEditField.Value, '\temp\cam1\backgroundFrames.mat'] , 'backgroundFrames1')
    save([app.projectfolderEditField.Value, '\temp\cam2\backgroundFrames.mat'] , 'backgroundFrames2')
    imwrite(app.cam1.background.mean, [app.projectfolderEditField.Value, '\temp\cam1\backgroundMean.bmp'])
    imwrite(app.cam2.background.mean, [app.projectfolderEditField.Value, '\temp\cam2\backgroundMean.bmp'])
    fprintf(['\nBackground cam1 and cam2 images stored in temp.\n'])
   
    % cleanup
    pause(2)
     app.cam1.camera.vid.FramesPerTrigger = numAqFramesStore(1);
     app.cam2.camera.vid.FramesPerTrigger = numAqFramesStore(2);
end

%% cam 1 & 3
if app.CheckBox_1.Value == 1 && app.CheckBox_2.Value == 0 && app.CheckBox_3.Value == 1 && app.CheckBox_4.Value == 0
    % trigger
    start([app.cam1.camera.vid, app.cam3.camera.vid])
    fprintf('\nTriggering in 8 seconds (cameras loading)...\n')
    pause(8)
    trigger([app.cam1.camera.vid, app.cam3.camera.vid])
    
    % acquire
    fprintf('\nAcquiring background images...\n')
    while islogging(app.cam1.camera.vid) == 1 || islogging(app.cam3.camera.vid) == 1
    end
    fprintf('\nBackground video acquisition complete\n')
    
% get frames out of volatile memory
    [backgroundFrames1, ~] = getdata(app.cam1.camera.vid, app.cam1.camera.vid.FramesPerTrigger);
    [backgroundFrames2, ~] = getdata(app.cam3.camera.vid, app.cam3.camera.vid.FramesPerTrigger);
    
    
    % make mean
    backgroundMean1 = backgroundFrames1(:,:,:,1); 
    backgroundMean2 = backgroundFrames2(:,:,:,1); 
    for i = 2:numframes 
        backgroundMean1 = imadd(0.5*backgroundMean1, 0.5*backgroundFrames1(:,:,:,i));  % weighted addition
        backgroundMean2 = imadd(0.5*backgroundMean2, 0.5*backgroundFrames2(:,:,:,i));  % weighted addition
    end
    
    % save into app temp memory
    app.cam1.background.frames = backgroundFrames1;
    app.cam3.background.frames = backgroundFrames2;
    app.cam1.background.mean = backgroundMean1;
    app.cam3.background.mean = backgroundMean2;
    
    % save into temp folder
    save([app.projectfolderEditField.Value, '\temp\cam1\backgroundFrames.mat'] , 'backgroundFrames1')
    save([app.projectfolderEditField.Value, '\temp\cam3\backgroundFrames.mat'] , 'backgroundFrames2')
    imwrite(app.cam1.background.mean, [app.projectfolderEditField.Value, '\temp\cam1\backgroundMean.bmp'])
    imwrite(app.cam3.background.mean, [app.projectfolderEditField.Value, '\temp\cam3\backgroundMean.bmp'])
    fprintf(['\nBackground cam1 and cam3 images stored in temp.\n'])
   
    % cleanup
    pause(2)
    app.cam1.camera.vid.FramesPerTrigger = numAqFramesStore(1);
    app.cam3.camera.vid.FramesPerTrigger = numAqFramesStore(3);
end

%% cam 1 & 4
if app.CheckBox_1.Value == 1 && app.CheckBox_2.Value == 0 && app.CheckBox_3.Value == 0 && app.CheckBox_4.Value == 1
    % trigger
    start([app.cam1.camera.vid, app.cam4.camera.vid])
    fprintf('\nTriggering in 8 seconds (cameras loading)...\n')
    pause(8)
    trigger([app.cam1.camera.vid, app.cam4.camera.vid])
    
    % acquire
    fprintf('\nAcquiring background images...\n')
    while islogging(app.cam1.camera.vid) == 1 || islogging(app.cam4.camera.vid) == 1
    end
    fprintf('\nBackground video acquisition complete\n')
    
% get frames out of volatile memory
    [backgroundFrames1, ~] = getdata(app.cam1.camera.vid, app.cam1.camera.vid.FramesPerTrigger);
    [backgroundFrames2, ~] = getdata(app.cam4.camera.vid, app.cam4.camera.vid.FramesPerTrigger);
    
    
    % make mean
    backgroundMean1 = backgroundFrames1(:,:,:,1); 
    backgroundMean2 = backgroundFrames2(:,:,:,1); 
    for i = 2:numframes 
        backgroundMean1 = imadd(0.5*backgroundMean1, 0.5*backgroundFrames1(:,:,:,i));  % weighted addition
        backgroundMean2 = imadd(0.5*backgroundMean2, 0.5*backgroundFrames2(:,:,:,i));  % weighted addition

    end
    
    % save into app temp memory
    app.cam1.background.frames = backgroundFrames1;
    app.cam4.background.frames = backgroundFrames2;
    app.cam1.background.mean = backgroundMean1;
    app.cam4.background.mean = backgroundMean2;
    
    % save into temp folder
    save([app.projectfolderEditField.Value, '\temp\cam1\backgroundFrames.mat'] , 'backgroundFrames1')
    save([app.projectfolderEditField.Value, '\temp\cam4\backgroundFrames.mat'] , 'backgroundFrames2')
    imwrite(app.cam1.background.mean, [app.projectfolderEditField.Value, '\temp\cam1\backgroundMean.bmp'])
    imwrite(app.cam4.background.mean, [app.projectfolderEditField.Value, '\temp\cam4\backgroundMean.bmp'])
    fprintf(['\nBackground cam1 and cam4 images stored in temp.\n'])
   
    % cleanup
    pause(2)
     app.cam1.camera.vid.FramesPerTrigger = numAqFramesStore(1);
     app.cam4.camera.vid.FramesPerTrigger = numAqFramesStore(4);
end

%% cam 2 & 3
if app.CheckBox_1.Value == 0 && app.CheckBox_2.Value == 1 && app.CheckBox_3.Value == 1 && app.CheckBox_4.Value == 0
    % trigger
    start([app.cam2.camera.vid, app.cam3.camera.vid])
    fprintf('\nTriggering in 8 seconds (cameras loading)...\n')
    pause(8)
    trigger([app.cam2.camera.vid, app.cam3.camera.vid])
    
    % acquire
    fprintf('\nAcquiring background images...\n')
    while islogging(app.cam2.camera.vid) == 1 || islogging(app.cam3.camera.vid) == 1
    end
    fprintf('\nBackground video acquisition complete\n')
    
% get frames out of volatile memory
    [backgroundFrames1, ~] = getdata(app.cam2.camera.vid, app.cam2.camera.vid.FramesPerTrigger);
    [backgroundFrames2, ~] = getdata(app.cam3.camera.vid, app.cam3.camera.vid.FramesPerTrigger);
    
    
    % make mean
    backgroundMean1 = backgroundFrames1(:,:,:,1); 
    backgroundMean2 = backgroundFrames2(:,:,:,1); 
    for i = 2:numframes 
        backgroundMean1 = imadd(0.5*backgroundMean1, 0.5*backgroundFrames1(:,:,:,i));  % weighted addition
        backgroundMean2 = imadd(0.5*backgroundMean2, 0.5*backgroundFrames2(:,:,:,i));  % weighted addition

    end
    
    % save into app temp memory
    app.cam2.background.frames = backgroundFrames1;
    app.cam3.background.frames = backgroundFrames2;
    app.cam2.background.mean = backgroundMean1;
    app.cam3.background.mean = backgroundMean2;
    
    % save into temp folder
    save([app.projectfolderEditField.Value, '\temp\cam2\backgroundFrames.mat'] , 'backgroundFrames1')
    save([app.projectfolderEditField.Value, '\temp\cam3\backgroundFrames.mat'] , 'backgroundFrames2')
    imwrite(app.cam2.background.mean, [app.projectfolderEditField.Value, '\temp\cam2\backgroundMean.bmp'])
    imwrite(app.cam3.background.mean, [app.projectfolderEditField.Value, '\temp\cam3\backgroundMean.bmp'])
    fprintf(['\nBackground cam2 and cam3 images stored in temp.\n'])
   
    % cleanup
    pause(2)
     app.cam2.camera.vid.FramesPerTrigger = numAqFramesStore(2);
     app.cam3.camera.vid.FramesPerTrigger = numAqFramesStore(3);
end

%% cam 2 & 4
if app.CheckBox_1.Value == 0 && app.CheckBox_2.Value == 1 && app.CheckBox_3.Value == 0 && app.CheckBox_4.Value == 1
    % trigger
    start([app.cam2.camera.vid, app.cam4.camera.vid])
    fprintf('\nTriggering in 8 seconds (cameras loading)...\n')
    pause(8)
    trigger([app.cam2.camera.vid, app.cam4.camera.vid])
    
    % acquire
    fprintf('\nAcquiring background images...\n')
    while islogging(app.cam2.camera.vid) == 1 || islogging(app.cam4.camera.vid) == 1
    end
    fprintf('\nBackground video acquisition complete\n')
    
% get frames out of volatile memory
    [backgroundFrames1, ~] = getdata(app.cam2.camera.vid, app.cam2.camera.vid.FramesPerTrigger);
    [backgroundFrames2, ~] = getdata(app.cam4.camera.vid, app.cam4.camera.vid.FramesPerTrigger);
    
    
    % make mean
    backgroundMean1 = backgroundFrames1(:,:,:,1); 
    backgroundMean2 = backgroundFrames2(:,:,:,1); 
    for i = 2:numframes 
        backgroundMean1 = imadd(0.5*backgroundMean1, 0.5*backgroundFrames1(:,:,:,i));  % weighted addition
        backgroundMean2 = imadd(0.5*backgroundMean2, 0.5*backgroundFrames2(:,:,:,i));  % weighted addition

    end
    
    % save into app temp memory
    app.cam2.background.frames = backgroundFrames1;
    app.cam4.background.frames = backgroundFrames2;
    app.cam2.background.mean = backgroundMean1;
    app.cam4.background.mean = backgroundMean2;
    
    % save into temp folder
    save([app.projectfolderEditField.Value, '\temp\cam2\backgroundFrames.mat'] , 'backgroundFrames1')
    save([app.projectfolderEditField.Value, '\temp\cam4\backgroundFrames.mat'] , 'backgroundFrames2')
    imwrite(app.cam2.background.mean, [app.projectfolderEditField.Value, '\temp\cam2\backgroundMean.bmp'])
    imwrite(app.cam4.background.mean, [app.projectfolderEditField.Value, '\temp\cam4\backgroundMean.bmp'])
    fprintf(['\nBackground cam2 and cam4 images stored in temp.\n'])
   
    % cleanup
    pause(2)
     app.cam2.camera.vid.FramesPerTrigger = numAqFramesStore(2);
     app.cam4.camera.vid.FramesPerTrigger = numAqFramesStore(4);
end

%% cam 3 & 4
if app.CheckBox_1.Value == 0 && app.CheckBox_2.Value == 0 && app.CheckBox_3.Value == 1 && app.CheckBox_4.Value == 1
    % trigger
    start([app.cam3.camera.vid, app.cam4.camera.vid])
    fprintf('\nTriggering in 8 seconds (cameras loading)...\n')
    pause(8)
    trigger([app.cam3.camera.vid, app.cam4.camera.vid])
    
    % acquire
    fprintf('\nAcquiring background images...\n')
    while islogging(app.cam3.camera.vid) == 1 || islogging(app.cam4.camera.vid) == 1
    end
    fprintf('\nBackground video acquisition complete\n')
    
% get frames out of volatile memory
    [backgroundFrames1, ~] = getdata(app.cam3.camera.vid, app.cam3.camera.vid.FramesPerTrigger);
    [backgroundFrames2, ~] = getdata(app.cam4.camera.vid, app.cam4.camera.vid.FramesPerTrigger);
    
    
    % make mean
    backgroundMean1 = backgroundFrames1(:,:,:,1); 
    backgroundMean2 = backgroundFrames2(:,:,:,1); 
    for i = 2:numframes 
        backgroundMean1 = imadd(0.5*backgroundMean1, 0.5*backgroundFrames1(:,:,:,i));  % weighted addition
        backgroundMean2 = imadd(0.5*backgroundMean2, 0.5*backgroundFrames2(:,:,:,i));  % weighted addition

    end
    
    % save into app temp memory
    app.cam3.background.frames = backgroundFrames1;
    app.cam4.background.frames = backgroundFrames2;
    app.cam3.background.mean = backgroundMean1;
    app.cam4.background.mean = backgroundMean2;
    
    % save into temp folder
    save([app.projectfolderEditField.Value, '\temp\cam3\backgroundFrames.mat'] , 'backgroundFrames1')
    save([app.projectfolderEditField.Value, '\temp\cam4\backgroundFrames.mat'] , 'backgroundFrames2')
    imwrite(app.cam3.background.mean, [app.projectfolderEditField.Value, '\temp\cam3\backgroundMean.bmp'])
    imwrite(app.cam4.background.mean, [app.projectfolderEditField.Value, '\temp\cam4\backgroundMean.bmp'])
    fprintf(['\nBackground cam3 and cam4 images stored in temp.\n'])
   
    % cleanup
    pause(2)
     app.cam3.camera.vid.FramesPerTrigger = numAqFramesStore(3);
     app.cam4.camera.vid.FramesPerTrigger = numAqFramesStore(4);
end

%% cam 1 & 2 & 3
if app.CheckBox_1.Value == 1 && app.CheckBox_2.Value == 1 && app.CheckBox_3.Value == 1 && app.CheckBox_4.Value == 0
    % trigger
    start([app.cam1.camera.vid, app.cam2.camera.vid, app.cam3.camera.vid])
    fprintf('\Triggering in 12 seconds (cameras loading)...\n')
    pause(12)
    trigger([app.cam1.camera.vid, app.cam2.camera.vid, app.cam3.camera.vid])
    
    % acquire
    fprintf('\nAcquiring background images...\n')
    while islogging(app.cam1.camera.vid) == 1 || islogging(app.cam2.camera.vid) == 1 || islogging(app.cam3.camera.vid) == 1
    end
    fprintf('\nBackground video acquisition complete\n')
    
% get frames out of volatile memory
    [backgroundFrames1, ~] = getdata(app.cam1.camera.vid, app.cam1.camera.vid.FramesPerTrigger);
    [backgroundFrames2, ~] = getdata(app.cam2.camera.vid, app.cam2.camera.vid.FramesPerTrigger);
    [backgroundFrames3, ~] = getdata(app.cam3.camera.vid, app.cam3.camera.vid.FramesPerTrigger);
    
    
    % make mean
    backgroundMean1 = backgroundFrames1(:,:,:,1); 
    backgroundMean2 = backgroundFrames2(:,:,:,1); 
    backgroundMean3 = backgroundFrames3(:,:,:,1); 
    for i = 2:numframes 
        backgroundMean1 = imadd(0.5*backgroundMean1, 0.5*backgroundFrames1(:,:,:,i));  % weighted addition
        backgroundMean2 = imadd(0.5*backgroundMean2, 0.5*backgroundFrames2(:,:,:,i));  % weighted addition
        backgroundMean3 = imadd(0.5*backgroundMean3, 0.5*backgroundFrames3(:,:,:,i));  % weighted addition
    end
    
    % save into app temp memory
    app.cam1.background.frames = backgroundFrames1;
    app.cam2.background.frames = backgroundFrames2;
    app.cam3.background.frames = backgroundFrames3;
    app.cam1.background.mean = backgroundMean1;
    app.cam2.background.mean = backgroundMean2;
    app.cam3.background.mean = backgroundMean3;
    
    % save into temp folder
    save([app.projectfolderEditField.Value, '\temp\cam1\backgroundFrames.mat'] , 'backgroundFrames1')
    save([app.projectfolderEditField.Value, '\temp\cam2\backgroundFrames.mat'] , 'backgroundFrames2')
    save([app.projectfolderEditField.Value, '\temp\cam3\backgroundFrames.mat'] , 'backgroundFrames3')
    
    imwrite(app.cam1.background.mean, [app.projectfolderEditField.Value, '\temp\cam1\backgroundMean.bmp'])
    imwrite(app.cam2.background.mean, [app.projectfolderEditField.Value, '\temp\cam2\backgroundMean.bmp'])
    imwrite(app.cam3.background.mean, [app.projectfolderEditField.Value, '\temp\cam3\backgroundMean.bmp'])
    
    fprintf(['\nBackground cam1, cam2 and cam3 images stored in temp.\n'])
   
    % cleanup
    pause(2)
     app.cam1.camera.vid.FramesPerTrigger = numAqFramesStore(1);
     app.cam2.camera.vid.FramesPerTrigger = numAqFramesStore(2);
     app.cam3.camera.vid.FramesPerTrigger = numAqFramesStore(3);
end

%% cam 1 & 2 & 4
if app.CheckBox_1.Value == 1 && app.CheckBox_2.Value == 1 && app.CheckBox_3.Value == 0 && app.CheckBox_4.Value == 1
    % trigger
    start([app.cam1.camera.vid, app.cam2.camera.vid, app.cam4.camera.vid])
    fprintf('\Triggering in 12 seconds (cameras loading)...\n')
    pause(12)
    trigger([app.cam1.camera.vid, app.cam2.camera.vid, app.cam4.camera.vid])
    
    % acquire
    fprintf('\nAcquiring background images...\n')
    while islogging(app.cam1.camera.vid) == 1 || islogging(app.cam2.camera.vid) == 1 || islogging(app.cam4.camera.vid) == 1
    end
    fprintf('\nBackground video acquisition complete\n')
    
% get frames out of volatile memory
    [backgroundFrames1, ~] = getdata(app.cam1.camera.vid, app.cam1.camera.vid.FramesPerTrigger);
    [backgroundFrames2, ~] = getdata(app.cam2.camera.vid, app.cam2.camera.vid.FramesPerTrigger);
    [backgroundFrames3, ~] = getdata(app.cam4.camera.vid, app.cam4.camera.vid.FramesPerTrigger);
    
    
    % make mean
    backgroundMean1 = backgroundFrames1(:,:,:,1); 
    backgroundMean2 = backgroundFrames2(:,:,:,1); 
    backgroundMean3 = backgroundFrames3(:,:,:,1); 
    for i = 2:numframes 
        backgroundMean1 = imadd(0.5*backgroundMean1, 0.5*backgroundFrames1(:,:,:,i));  % weighted addition
        backgroundMean2 = imadd(0.5*backgroundMean2, 0.5*backgroundFrames2(:,:,:,i));  % weighted addition
        backgroundMean3 = imadd(0.5*backgroundMean3, 0.5*backgroundFrames3(:,:,:,i));  % weighted addition
    end
    
    % save into app temp memory
    app.cam1.background.frames = backgroundFrames1;
    app.cam2.background.frames = backgroundFrames2;
    app.cam4.background.frames = backgroundFrames3;
    app.cam1.background.mean = backgroundMean1;
    app.cam2.background.mean = backgroundMean2;
    app.cam4.background.mean = backgroundMean3;
    
    % save into temp folder
    save([app.projectfolderEditField.Value, '\temp\cam1\backgroundFrames.mat'] , 'backgroundFrames1')
    save([app.projectfolderEditField.Value, '\temp\cam2\backgroundFrames.mat'] , 'backgroundFrames2')
    save([app.projectfolderEditField.Value, '\temp\cam4\backgroundFrames.mat'] , 'backgroundFrames3')
    
    imwrite(app.cam1.background.mean, [app.projectfolderEditField.Value, '\temp\cam1\backgroundMean.bmp'])
    imwrite(app.cam2.background.mean, [app.projectfolderEditField.Value, '\temp\cam2\backgroundMean.bmp'])
    imwrite(app.cam4.background.mean, [app.projectfolderEditField.Value, '\temp\cam4\backgroundMean.bmp'])
    
    fprintf(['\nBackground cam1, cam2 and cam4 images stored in temp.\n'])
   
    % cleanup
    pause(2)
     app.cam1.camera.vid.FramesPerTrigger = numAqFramesStore(1);
     app.cam2.camera.vid.FramesPerTrigger = numAqFramesStore(2);
     app.cam4.camera.vid.FramesPerTrigger = numAqFramesStore(4);
end

%% cam 1 & 3 & 4
if app.CheckBox_1.Value == 1 && app.CheckBox_2.Value == 0 && app.CheckBox_3.Value == 1 && app.CheckBox_4.Value == 1
    % trigger
    start([app.cam1.camera.vid, app.cam3.camera.vid, app.cam4.camera.vid])
    fprintf('\Triggering in 12 seconds (cameras loading)...\n')
    pause(12)
    trigger([app.cam1.camera.vid, app.cam3.camera.vid, app.cam4.camera.vid])
    
    % acquire
    fprintf('\nAcquiring background images...\n')
    while islogging(app.cam1.camera.vid) == 1 || islogging(app.cam3.camera.vid) == 1 || islogging(app.cam4.camera.vid) == 1
    end
    fprintf('\nBackground video acquisition complete\n')
    
% get frames out of volatile memory
    [backgroundFrames1, ~] = getdata(app.cam1.camera.vid, app.cam1.camera.vid.FramesPerTrigger);
    [backgroundFrames2, ~] = getdata(app.cam3.camera.vid, app.cam3.camera.vid.FramesPerTrigger);
    [backgroundFrames3, ~] = getdata(app.cam4.camera.vid, app.cam4.camera.vid.FramesPerTrigger);
    
    
    % make mean
    backgroundMean1 = backgroundFrames1(:,:,:,1); 
    backgroundMean2 = backgroundFrames2(:,:,:,1); 
    backgroundMean3 = backgroundFrames3(:,:,:,1); 
    for i = 2:numframes 
        backgroundMean1 = imadd(0.5*backgroundMean1, 0.5*backgroundFrames1(:,:,:,i));  % weighted addition
        backgroundMean2 = imadd(0.5*backgroundMean2, 0.5*backgroundFrames2(:,:,:,i));  % weighted addition
        backgroundMean3 = imadd(0.5*backgroundMean3, 0.5*backgroundFrames3(:,:,:,i));  % weighted addition
    end
    
    % save into app temp memory
    app.cam1.background.frames = backgroundFrames1;
    app.cam3.background.frames = backgroundFrames2;
    app.cam4.background.frames = backgroundFrames3;
    app.cam1.background.mean = backgroundMean1;
    app.cam3.background.mean = backgroundMean2;
    app.cam4.background.mean = backgroundMean3;
    
    % save into temp folder
    save([app.projectfolderEditField.Value, '\temp\cam1\backgroundFrames.mat'] , 'backgroundFrames1')
    save([app.projectfolderEditField.Value, '\temp\cam3\backgroundFrames.mat'] , 'backgroundFrames2')
    save([app.projectfolderEditField.Value, '\temp\cam4\backgroundFrames.mat'] , 'backgroundFrames3')
    
    imwrite(app.cam1.background.mean, [app.projectfolderEditField.Value, '\temp\cam1\backgroundMean.bmp'])
    imwrite(app.cam3.background.mean, [app.projectfolderEditField.Value, '\temp\cam3\backgroundMean.bmp'])
    imwrite(app.cam4.background.mean, [app.projectfolderEditField.Value, '\temp\cam4\backgroundMean.bmp'])
    
    fprintf(['\nBackground cam1, cam3 and cam4 images stored in temp.\n'])
   
    % cleanup
    pause(2)
     app.cam1.camera.vid.FramesPerTrigger = numAqFramesStore(1);
     app.cam3.camera.vid.FramesPerTrigger = numAqFramesStore(3);
     app.cam4.camera.vid.FramesPerTrigger = numAqFramesStore(4);
end

%% cam 2 & 3 & 4
if app.CheckBox_1.Value == 0 && app.CheckBox_2.Value == 1 && app.CheckBox_3.Value == 1 && app.CheckBox_4.Value == 1
    % trigger
    start([app.cam3.camera.vid, app.cam2.camera.vid, app.cam4.camera.vid])
    fprintf('\Triggering in 12 seconds (cameras loading)...\n')
    pause(12)
    trigger([app.cam3.camera.vid, app.cam2.camera.vid, app.cam4.camera.vid])
    
    % acquire
    fprintf('\nAcquiring background images...\n')
    while islogging(app.cam3.camera.vid) == 1 || islogging(app.cam2.camera.vid) == 1 || islogging(app.cam4.camera.vid) == 1
    end
    fprintf('\nBackground video acquisition complete\n')
    
% get frames out of volatile memory
    [backgroundFrames1, ~] = getdata(app.cam3.camera.vid, app.cam3.camera.vid.FramesPerTrigger);
    [backgroundFrames2, ~] = getdata(app.cam2.camera.vid, app.cam2.camera.vid.FramesPerTrigger);
    [backgroundFrames3, ~] = getdata(app.cam4.camera.vid, app.cam4.camera.vid.FramesPerTrigger);
    
    
    % make mean
    backgroundMean1 = backgroundFrames1(:,:,:,1); 
    backgroundMean2 = backgroundFrames2(:,:,:,1); 
    backgroundMean3 = backgroundFrames3(:,:,:,1); 
    for i = 2:numframes 
        backgroundMean1 = imadd(0.5*backgroundMean1, 0.5*backgroundFrames1(:,:,:,i));  % weighted addition
        backgroundMean2 = imadd(0.5*backgroundMean2, 0.5*backgroundFrames2(:,:,:,i));  % weighted addition
        backgroundMean3 = imadd(0.5*backgroundMean3, 0.5*backgroundFrames3(:,:,:,i));  % weighted addition
    end
    
    % save into app temp memory
    app.cam3.background.frames = backgroundFrames1;
    app.cam2.background.frames = backgroundFrames2;
    app.cam4.background.frames = backgroundFrames3;
    app.cam3.background.mean = backgroundMean1;
    app.cam2.background.mean = backgroundMean2;
    app.cam4.background.mean = backgroundMean3;
    
    % save into temp folder
    save([app.projectfolderEditField.Value, '\temp\cam3\backgroundFrames.mat'] , 'backgroundFrames1')
    save([app.projectfolderEditField.Value, '\temp\cam2\backgroundFrames.mat'] , 'backgroundFrames2')
    save([app.projectfolderEditField.Value, '\temp\cam4\backgroundFrames.mat'] , 'backgroundFrames3')
    
    imwrite(app.cam3.background.mean, [app.projectfolderEditField.Value, '\temp\cam3\backgroundMean.bmp'])
    imwrite(app.cam2.background.mean, [app.projectfolderEditField.Value, '\temp\cam2\backgroundMean.bmp'])
    imwrite(app.cam4.background.mean, [app.projectfolderEditField.Value, '\temp\cam4\backgroundMean.bmp'])
    
    fprintf(['\nBackground cam3, cam2 and cam4 images stored in temp.\n'])
   
    % cleanup
    pause(2)
     app.cam3.camera.vid.FramesPerTrigger = numAqFramesStore(3);
     app.cam2.camera.vid.FramesPerTrigger = numAqFramesStore(2);
     app.cam4.camera.vid.FramesPerTrigger = numAqFramesStore(4);
end

%% cam 1 & 2 & 3 & 4
if app.CheckBox_1.Value == 1 && app.CheckBox_2.Value == 1 && app.CheckBox_3.Value == 1 && app.CheckBox_4.Value == 4
    % trigger
    start([app.cam1.camera.vid, app.cam2.camera.vid, app.cam3.camera.vid, app.cam4.camera.vid])
    fprintf('\Triggering in 15 seconds (cameras loading)...\n')
    pause(15)
    trigger([app.cam1.camera.vid, app.cam2.camera.vid, app.cam3.camera.vid, app.cam4.camera.vid])
    
    % acquire
    fprintf('\nAcquiring background images...\n')
    while islogging(app.cam1.camera.vid) == 1 || islogging(app.cam2.camera.vid) == 1 || islogging(app.cam3.camera.vid) == 1 || islogging(app.cam4.camera.vid) == 1
    end
    fprintf('\nBackground video acquisition complete\n')
    
% get frames out of volatile memory
    [backgroundFrames1, ~] = getdata(app.cam1.camera.vid, app.cam1.camera.vid.FramesPerTrigger);
    [backgroundFrames2, ~] = getdata(app.cam2.camera.vid, app.cam2.camera.vid.FramesPerTrigger);
    [backgroundFrames3, ~] = getdata(app.cam3.camera.vid, app.cam3.camera.vid.FramesPerTrigger);
    [backgroundFrames4, ~] = getdata(app.cam4.camera.vid, app.cam4.camera.vid.FramesPerTrigger);
    
    
    % make mean
    backgroundMean1 = backgroundFrames1(:,:,:,1); 
    backgroundMean2 = backgroundFrames2(:,:,:,1); 
    backgroundMean3 = backgroundFrames3(:,:,:,1); 
    backgroundMean4 = backgroundFrames4(:,:,:,1); 
    for i = 2:numframes 
        backgroundMean1 = imadd(0.5*backgroundMean1, 0.5*backgroundFrames1(:,:,:,i));  % weighted addition
        backgroundMean2 = imadd(0.5*backgroundMean2, 0.5*backgroundFrames2(:,:,:,i));  % weighted addition
        backgroundMean3 = imadd(0.5*backgroundMean3, 0.5*backgroundFrames3(:,:,:,i));  % weighted addition
        backgroundMean4 = imadd(0.5*backgroundMean4, 0.5*backgroundFrames4(:,:,:,i));  % weighted addition
    end
    
    % save into app temp memory
    app.cam1.background.frames = backgroundFrames1;
    app.cam2.background.frames = backgroundFrames2;
    app.cam3.background.frames = backgroundFrames3;
    app.cam4.background.frames = backgroundFrames4;
    app.cam1.background.mean = backgroundMean1;
    app.cam2.background.mean = backgroundMean2;
    app.cam3.background.mean = backgroundMean3;
    app.cam4.background.mean = backgroundMean4;
    
    % save into temp folder
    save([app.projectfolderEditField.Value, '\temp\cam1\backgroundFrames.mat'] , 'backgroundFrames1')
    save([app.projectfolderEditField.Value, '\temp\cam2\backgroundFrames.mat'] , 'backgroundFrames2')
    save([app.projectfolderEditField.Value, '\temp\cam3\backgroundFrames.mat'] , 'backgroundFrames3')
    save([app.projectfolderEditField.Value, '\temp\cam4\backgroundFrames.mat'] , 'backgroundFrames4')
    
    imwrite(app.cam1.background.mean, [app.projectfolderEditField.Value, '\temp\cam1\backgroundMean.bmp'])
    imwrite(app.cam2.background.mean, [app.projectfolderEditField.Value, '\temp\cam2\backgroundMean.bmp'])
    imwrite(app.cam3.background.mean, [app.projectfolderEditField.Value, '\temp\cam3\backgroundMean.bmp'])
    imwrite(app.cam4.background.mean, [app.projectfolderEditField.Value, '\temp\cam4\backgroundMean.bmp'])
  
    fprintf(['\nBackground cam1, cam2, cam3 and cam4 images stored in temp.\n'])
   
    % cleanup
    pause(2)
     app.cam1.camera.vid.FramesPerTrigger = numAqFramesStore(1);
     app.cam2.camera.vid.FramesPerTrigger = numAqFramesStore(2);
     app.cam3.camera.vid.FramesPerTrigger = numAqFramesStore(3);
     app.cam3.camera.vid.FramesPerTrigger = numAqFramesStore(4);
end
end

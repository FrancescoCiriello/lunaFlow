function previewApp(obj, app)
% use preview to open a figure docked to the working
% environment that previews the videoinput from the camera
%
% See also PREVIEW, CROP.

% TODO: find a way to reset preview status when figure closed
% manually

numCams = length(obj);

% single camera preview
if numCams == 1
    
    % set up preview figure
    res = obj.camera.vid.VideoResolution;
    appHandle = image(app.VideoStream, zeros(res(2),res(1)));
    set(app.VideoStream, 'visible', 'off')
    axis(app.VideoStream, 'tight')
    axis(app.VideoStream, 'equal')
    preview(obj.camera.vid, appHandle);
    
    % multicamera preview
elseif numCams > 1
    % Create VideoStream
    delete(app.VideoStream)
    
    % create UI figure components (implement a manual 'subplot' because
    % subplot does not work in App Designer)
    
    if numCams == 2
        app.VideoStream_1 = uiaxes(app.UIFigure);
        app.VideoStream_1.Color = [0.2706 0.2706 0.2706];
        app.VideoStream_1.BackgroundColor = [0.2706 0.2706 0.2706];
        app.VideoStream_1.Position = [63 396 0.95*623/2 393];
        
        app.VideoStream_2 = uiaxes(app.UIFigure);
        app.VideoStream_2.Color = [0.2706 0.2706 0.2706];
        app.VideoStream_2.BackgroundColor = [0.2706 0.2706 0.2706];
        app.VideoStream_2.Position = [63+1.05*623/2 396 0.95*623/2 393];
        
        
    elseif numCams == 3
        app.VideoStream_1 = uiaxes(app.UIFigure);
        app.VideoStream_1.Color = [0.2706 0.2706 0.2706];
        app.VideoStream_1.BackgroundColor = [0.2706 0.2706 0.2706];
        app.VideoStream_1.Position = [63 1.05*(396+393/2) 0.95*623/2 393/2];
        
        app.VideoStream_2 = uiaxes(app.UIFigure);
        app.VideoStream_2.Color = [0.2706 0.2706 0.2706];
        app.VideoStream_2.BackgroundColor = [0.2706 0.2706 0.2706];
        app.VideoStream_2.Position = [63+1.05*623/2 1.05*(396+393/2) 0.95*623/2 393/2];
        
        app.VideoStream_3 = uiaxes(app.UIFigure);
        app.VideoStream_3.Color = [0.2706 0.2706 0.2706];
        app.VideoStream_3.BackgroundColor = [0.2706 0.2706 0.2706];
        app.VideoStream_3.Position = [63+0.525*623/2 396 0.95*623/2 393/2];
         
        
    elseif numCams == 4
        
        app.VideoStream_1 = uiaxes(app.UIFigure);
        app.VideoStream_1.Color = [0.2706 0.2706 0.2706];
        app.VideoStream_1.BackgroundColor = [0.2706 0.2706 0.2706];
        app.VideoStream_1.Position = [63 1.05*(396+393/2) 0.95*623/2 393/2];
        
        app.VideoStream_2 = uiaxes(app.UIFigure);
        app.VideoStream_2.Color = [0.2706 0.2706 0.2706];
        app.VideoStream_2.BackgroundColor = [0.2706 0.2706 0.2706];
        app.VideoStream_2.Position = [63+1.05*623/2 1.05*(396+393/2) 0.95*623/2 393/2];
        
        app.VideoStream_3 = uiaxes(app.UIFigure);
        app.VideoStream_3.Color = [0.2706 0.2706 0.2706];
        app.VideoStream_3.BackgroundColor = [0.2706 0.2706 0.2706];
        app.VideoStream_3.Position = [63 396 0.95*623/2 393/2];
        
        app.VideoStream_4 = uiaxes(app.UIFigure);
        app.VideoStream_4.Color = [0.2706 0.2706 0.2706];
        app.VideoStream_4.BackgroundColor = [0.2706 0.2706 0.2706];
        app.VideoStream_4.Position = [63+1.05*623/2 396 0.95*623/2 393/2];
        
        
    else
        error('Preview mode not available for > 4 cameras.')
        
    end
    
    for k = 1:numCams
        res = obj(k).camera.vid.VideoResolution;
        appHandle = image(eval(['app.VideoStream_' num2str(k)]), zeros(res(2), res(1)));
        set(eval(['app.VideoStream_' num2str(k)]), 'visible', 'off')
        axis(eval(['app.VideoStream_' num2str(k)]), 'tight')
        axis(eval(['app.VideoStream_' num2str(k)]), 'equal')
        pause(0.1)
        preview(obj(k).camera.vid, appHandle);
    end
    

    
end

end
function cropApp(obj, app, cropCamNum)
% use crop to preview the image and choose the ROI for the
% camera. A user-input is required in the figure to draw out
% the rectangle for the ROI. The rectangle can be adjusted as
% many times as needed after the first selection by dragging on the nodes.
% Double-click to confirm the ROI selection.
%
% See also IMRECT, PREVIEW.
%     if cropCamNum == 1
%         try
%             axisCrop = app.VideoStream
%         catch
%             axisCrop = app.VideoStream_1;
%         end
%     end
%     if cropCamNum == 2
%         try
%             axisCrop = app.VideoStream;
%         catch
%             axisCrop = app.VideoStream_2;
%         end
%     end
%     if cropCamNum == 3
%         try
%             axisCrop = app.VideoStream;
%         catch
%             axisCrop = app.VideoStream_3;
%         end
%     end
%     if cropCamNum == 4
%         try
%             axisCrop = app.VideoStream;
%         catch
%             axisCrop = app.VideoStream_4;
%         end
%     end
           
   
    % user-input for crop rectangle
%     appAxis = axes(app.VideoStream.Parent);
    disp('Adjust ROI and double-click to confirm crop');
    h1 = handle(app.VideoStream.Child);
    cropRectangle = drawrectangle(h1.Parent); % , 'Position', [63 396 0.95*623/2 393]);
%     pos = wait(cropRectangle);
%     obj.camera.vid.ROIPosition = floor(pos);
%     delete(cropRectangle)
%     clear pos
    disp('Cropping done');

    

end
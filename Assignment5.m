%Holly Ross
%October 9, 2017
%Normalized Cross-Correlation

clear all; close all; clc;

%Unknown Image%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Igray = imread('unknown.jpg');
Ithresh = Igray > 150;

BW = ~Ithresh;

SE = strel('disk', 2);
BW2 = imdilate(BW, SE);

%imshow(BW2);

[labels,number] = bwlabel(BW2,8);
Istats = regionprops(labels,'basic','Centroid');

Istats([Istats.Area] < 1000) = [];
num = length(Istats);

Ibox = floor([Istats.BoundingBox]);
Ibox = reshape(Ibox, [4 num]);

%hold on;
%for k = 1: num
%rectangle('position', Ibox(:,k), 'edgecolor', 'r',...
%'LineWidth', 3);
%end

for k = 1: num
    col1 = Istats(k).BoundingBox(1);
    col2 = Istats(k).BoundingBox(1) + Istats(k).BoundingBox(3);
    row1 = Istats(k).BoundingBox(2);
    row2 = Istats(k).BoundingBox(2) + Istats(k).BoundingBox(4);
    subImage = BW2(row1:row2, col1:col2);
    
    for i = 1: 7
        UnknownImage{k} = subImage;
        UnknownImageScaled{k} = ...
            imresize(subImage, [24 12]);
    end
    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Template Image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Igray = imread('template.jpg');
Ithresh = Igray > 150;

BW = ~Ithresh;

SE = strel('disk', 2);
BW2 = imdilate(BW, SE);

%imshow(BW2);

[labels,number] = bwlabel(BW2,8);
Istats = regionprops(labels,'basic','Centroid');

Istats([Istats.Area] < 1000) = [];
num = length(Istats);

Ibox = floor([Istats.BoundingBox]);
Ibox = reshape(Ibox, [4 num]);

%hold on;
%for k = 1: num
%rectangle('position', Ibox(:,k), 'edgecolor', 'r',...
%'LineWidth', 3);
%end

for k = 1: num
    col1 = Istats(k).BoundingBox(1);
    col2 = Istats(k).BoundingBox(1) + Istats(k).BoundingBox(3);
    row1 = Istats(k).BoundingBox(2);
    row2 = Istats(k).BoundingBox(2) + Istats(k).BoundingBox(4);
    subImage = BW2(row1:row2, col1:col2);
    
    for i = 1: 7
        TemplateImage{k} = subImage;
        TemplateImageScaled{k} = ...
            imresize(subImage, [24 12]);
    end
    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


for k = 1: 10
    for i = 1: 6
        corr = normxcorr2(UnknownImageScaled{i},...
            TemplateImageScaled{k});
        
        maxCorr(k,i) = max( corr(:) );
       
    end
    
end

[value, index] = max(maxCorr(:,:));

postcode = index-1;

disp(postcode)








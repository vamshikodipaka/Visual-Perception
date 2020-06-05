clc;
clear;
close all;

% Intrinsic params from the calibration pattern we measured
I = [827.9 0 0; 0 829.21 0; 507.768 389.35 1]';

%% 2
normCame = [eye(3) zeros(3,1)]; %normalsised camera matrix

% Real world 3D Coordinates
P3D = [20 10 800; 100 10 800; 100 50 800; 20 50 800; 20 10 900; 100 10 900; 100 50 900; 20 50 900];
X = [20 10 800; 100 10 800; 100 10 900; 100 10 800; 100 50 800; 100 50 900; 100 50 800; 20 50 800; 20 50 900; 20 50 800; 20 10 800; 20 10 900; 100 10 900; 100 50 900; 20 50 900; 20 10 900];
figure,
plot3(X(:,1), X(:,2), X(:,3))
axis([-200 200 -100 100 0 1000])
hold on;
grid on;

Rot1 = eye(3);
trans1 = [ 0 0 0]'; % to put camera 1 at origin Extrinsic parmeters
P1 = I * normCame * [Rot1 trans1; zeros(1,3) 1];
% Plot a circle on the 3D coordinates of the camera
plot3(trans1(1),trans1(3),trans1(2),'o','MarkerSize',10,'Color','r','Linewidth',1);

%% 3
% camera1

% projections of scene onto camera planes
P_H = [P3D ones(size(P3D,1),1)];
x1 = P1 * P_H';
x1 = x1 ./repmat(x1(3,:),3,1) ;
%%
C1 = camstruct('PM',P1); % to construct camera structure to be used by imagept2plane function
% convert image pts to a plane
pt1 = imagept2plane(C1, x1(1:2,:), [0 0 I(1,1)], [0 0 1]);

%define a plane at focal length fc1
transparency = 0.1;    %mostly clear
% XL = [10 200];
% YL = [10 200];
mini1 = min(pt1(1:2,:),[],2);
maxi1 = max(pt1(1:2,:),[],2);
XL = [mini1(1,1)-100 maxi1(1,1)+100];
YL = [mini1(2,1)-100 maxi1(2,1)+100];
zposi = I(1,1);
patch(XL([1 2 2 1 1]), YL([1 1 2 2 1]), zposi * ones(1,5), [0 .2 .7], 'FaceAlpha', transparency);


% to plot the points on image plane
plot3(pt1(1,:),pt1(2,:), pt1(3,:),'.','MarkerSize',10, 'LineWidth', 1,'Color','r');

% UNCOMMENT below to show the projection lines
 for i = 1:size(X,1)
     plot3([X(i,1) 0],  [X(i,2) 0],[X(i,3) 0], 'LineWidth', 0.00002, 'Color', 'g');
 end
hold off;

%% 4
%DLT

D = [];

for i = 1: size(P_H,1)
    DP = [-P_H(i,1) -P_H(i,2) -P_H(i,3) -1 0 0 0 0 x1(1,i)*P_H(i,1) x1(1,i)*P_H(i,2) x1(1,i)*P_H(i,3) x1(1,i);
          0 0 0 0 -P_H(i,1) -P_H(i,2) -P_H(i,3) -1 x1(2,i)*P_H(i,1) x1(2,i)*P_H(i,2) x1(2,i)*P_H(i,3) x1(2,i)];
      
    D = [D; DP];
    
end


[U,S,V] = svd(D);

P_computed = reshape(V(:,end),4,3)';


[K, Rc_w, Pc, pp, pv] = decomposecamera(P_computed);

%% 5

%% 6
figure,
plot3(X(:,1), X(:,2), X(:,3))
axis([-200 200 -100 100 0 1000])
hold on;
grid on;

Rot2 = eye(3);
tranx = 50;
tran2 = [-tranx 0 0]'; % to put camera 1 at origin Extrinsic parmeters
P2 = I * normCame * [Rot2 tran2; zeros(1,3) 1];
% Plot a circle on the 3D coordinates of the camera
tplot = [tranx 0 0];
plot3(tplot(1),tplot(3),tplot(2),'o','MarkerSize',10,'Color','r','Linewidth',1);

%% 7
% camera2

% projections of scene onto camera planes
P_H = [P3D ones(size(P3D,1),1)];
x2 = P2 * P_H';
x2 = x2 ./repmat(x2(3,:),3,1) ;

%C2 = camstruct('f',I(1,1));
C2 = camstruct('PM', P2, 'P', [50;0;0]); % to construct camera structure to be used by imagept2plane function
% convert image pts to a plane
pt2 = imagept2plane(C2, x2(1:2,:), [0 0 I(1,1)], [0 0 1]);

%define a plane at focal length fc1
transparency = 0.1;    %mostly clear
% XL = [10 200];
% YL = [10 200];
mini1 = min(pt2(1:2,:),[],2);
maxi1 = max(pt2(1:2,:),[],2);
XL = [mini1(1,1)-100 maxi1(1,1)+100];
YL = [mini1(2,1)-100 maxi1(2,1)+100];
zposi = I(1,1);
patch(XL([1 2 2 1 1]), YL([1 1 2 2 1]), zposi * ones(1,5), [0 .2 .7], 'FaceAlpha', transparency);


% to plot the points on image plane
plot3(pt2(1,:),pt2(2,:), pt2(3,:),'.','MarkerSize',10, 'LineWidth', 1,'Color','r');

% UNCOMMENT below to show the projection lines
 for i = 1:size(X,1)
     plot3([X(i,1) 50],  [X(i,2) 0],[X(i,3) 0], 'LineWidth', 0.00002, 'Color', 'g');
 end
hold off;


%% 8 

[ P_tri, error ] = triangulate( P1, x1(1:2,:)', P2, x2(1:2,:)' );

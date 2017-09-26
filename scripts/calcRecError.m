% read the data

datapath = '/cbica/projects/pncNmf/directory_on_cbica/images/' ;
leftHemisphere = [datapath ...
    'lh.thickness.fwhm20.fsaverage.nXXX.mgh' ];
rightHemisphere = [datapath ...
    'rh.thickness.fwhm20.fsaverage.nXXX.mgh'];

% left hemisphere
[vol_lh, ~, ~, ~] = load_mgh(leftHemisphere);
lh_thickness = squeeze(vol_lh) ; clear vol_lh

% right hemisphere
[vol_rh, ~, ~, ~] = load_mgh(rightHemisphere);
rh_thickness = squeeze(vol_rh) ; clear vol_rh

cor_thickness = [lh_thickness ; rh_thickness] ;

% load results and calculate reconstruction error
resultsPath='/cbica/projects/pncNmf/directory_on_cbica/results/';
numBases=2:2:30;

RecError=zeros(length(numBases),1);
for b=1:length(numBases)
    disp(b/length(numBases))
    load([resultsPath 'NumBases' num2str(numBases(b)) '/OPNMF/ResultsExtractBases.mat'])  
    Est = B*C ;
    RecError(b) = norm(cor_thickness-Est,'fro') ;    
    clear B C
end

% make figure
% 1) reconstruction error
figure;plot(numBases,RecError,'r','LineWidth',2)
xlabel('Number of components','fontsize',12)
ylabel('Reconstruction error','fontsize',12)
set(gca,'fontsize',12)
saveas(gcf,'RecError.fig')

% 2) gradient of reconstruction error
figure;plot(numBases(2:end),diff(RecError),'r','LineWidth',2)
xlabel('Number of components','fontsize',12)
ylabel('Gradient of reconstruction error','fontsize',12)
set(gca,'fontsize',12)
saveas(gcf,'gradientRecError.fig')

% 3) Percentage of improvement over range of components used
figure;plot(numBases,abs(RecError-RecError(1))./abs(RecError(1)-RecError(end)),'r','LineWidth',2)
xlabel('Number of components','fontsize',12)
ylabel('Percentage of improvement over range of components used','fontsize',12)
xlim([numBases(1) numBases(end)])
set(gca,'fontsize',12)
saveas(gcf,'percentageImprovementRecError.fig')


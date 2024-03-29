# PDL1-CPS-Denominator
This script helps to count the number of cells within a 20X microscopic field. This number is sometimes important to calculate a CPS PDL1 score to determine access to immunotherapy in various cancers.

Prerequisites and software installation
==========

This software requires installation of Fiji (ImageJ), an open source software written in Java, available for Linux, Mac OS X and Windows. Fiji(ImageJ) is available [here](https://imagej.net/software/fiji/).

The proposed script (PDL1_denominator.ijm) is a "toolset" written in imageJ/FIJI macro language and requires to be installed in a precise directory: →Fiji.app→macros→toolsets. The installation is explained in the video (see at the bottom)

This script is based on the Stardist Plugin which is considered in 2023 the best nuclei segmentation tool
The Stardist plugin is explained [here](https://imagej.net/plugins/stardist). You will install this plugin through FIJI as explained in the video below.

In order to download the script, you can either 1) click on the green icon "code" and click on "dowload zip". The script will be within this zip file that you will decompress on your computer. Or 2) click on "CPS-denominator,ijm", then on "Raw" and save the whole content on computer by naming the new file "CPS-denominator.ijm". 

Calibration using a calibrated slide
==========
Each microscope/camera setup is different. In order to obtain realistic estimation of the number of cells under your 20X microscopic field, you will need to know the horizontal and vertical sizes of the rectangular picture grabbed by your camera and the diameter of your 20X microscopic field. This can be achieved by utilizing a calibrated slide to calculate these values. When known, these values can be stored permanently in the configuration menu as shown in the picture below.

![](/CPS-DenominatorCalibration.jpg) 

YouTube video of FIJI setup + utilization of the startdist plugin and the script "CPS_denominator.ijm"
==========

Please visit this video: [PDL1-CPS-Denominator](https://youtu.be/QSv5eL6t08M) The video is available in High Definition (HD). If needed change the definition from SD to HD by clicking the "settings" button at the bottom right of the YouTube screen.

Comment or question: gilbert.bigras@albertaprecisionlabs.ca


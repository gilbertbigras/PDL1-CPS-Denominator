# PDL1-CPS-Denominator
This script helps to count the number of cells within a 20X microscopic field. This number is sometimes important to calculate a CPS PDL1 score to determine access to immunotherapy in various cancers.

Prerequisites and software installation
==========

This software requires installation of Fiji (ImageJ), an open source software written in Java, available for Linux, Mac OS X and Windows. Fiji(ImageJ) is available here.

The proposed script (PDL1_denominator.ijm) is a "toolset" written in imageJ/FIJI macro language and requires to be installed in a precise directory: →Fiji.app→macros→toolsets. The installation is explained in the video (see at the bottom)

This script is based on the Stardist Plugin which is considered in 2023 the best nuclei segmentation tool
The Stardist plugin is available here https://imagej.net/plugins/stardist. However you will install this plugin through FIJI as explained in the video below.

Calibration using a calibrated slide
==========
Each microscope/camera setup is different. In order to obtain realistic estimation of the number of cells under your 20X microscopic field, you will need to know the horizontal and vertical sizes of the rectangular picture grabbed by your camera and the diameter of your microscopic field. When known, these values can be stored permanently in the configuration menu as shown below.

![](/CPS-DenominatorCalibration.jpg) 

Software utilization
==========

Please visit this video: [PDL1-CPS-Denominator] (https://youtu.be/QSv5eL6t08M)


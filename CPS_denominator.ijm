
var gDimensionsStatus;

var gWarningStardist;
var gWarningStardistDefault="yes";			  

var gHorizontal;			  
var gVertical;
var gMicroscopicFieldDiameter;
var gObjective;

var gHorizontalDefault = 0.625;			  
var gVerticalDefault = 0.47;
var gMicroscopicFieldDiameterDefault = 1.0;
var gObjectiveDefault = "20X";

var gThresholdStatus;

var gThresholdCircularity;
var gThresholdArea;

var gThresholdCircularityDefault = 0.0;
var gThresholdAreaDefault = 0.0;



var gNumberNucleiRed = 0;
var gNumberNucleiGreen = 0;

var gROISDirectory;

var gCurrentImage;
var gRoisFilename;

var gXRed = newArray;
var gYRed = newArray;
var gXGreen = newArray;
var gYGreen = newArray;
var g_n_red;
var g_n_green;
var g_n_red_Microscopic_Field;
var g_n_green_Microscopic_Field;


var bOverlay = true;

var gRoisFilenameAlreadySaved = false;

macro "AutoRun" {
	requires("1.53q");
	close_auxiliary_windows();
	
	
	gROISDirectory = getDir("imagej")+"ROIS_CPS";
	if (!File.isDirectory(gROISDirectory)) File.makeDirectory(gROISDirectory); //if does not exist... create


	

	gDimensionsStatus = call("ij.Prefs.get", "cps.pdl1.MicroscopeAndImagesParams.status", "not determined");
	if (gDimensionsStatus == "not determined")
	{
	setMicroscopeAndImagesParamsFromDefault();	
	call("ij.Prefs.set", "cps.pdl1.MicroscopeAndImagesParams.status", "determined");
	call("ij.Prefs.savePreferences"); // save preferences now
	}
	else
	{
	setMicroscopeAndImagesParamsFromPrefs();	
	}

	gThresholdStatus = call("ij.Prefs.get", "cps.pdl1.gThreshold.status", "not determined");
	if (gThresholdStatus == "not determined")
	{
	setThresholdFromDefault();	
	call("ij.Prefs.set", "cps.pdl1.gThreshold.status", "determined");
	call("ij.Prefs.savePreferences"); // save preferences now
	}
	else
	{
	setThresholdFromPrefs();	
	}
	


	
}

macro "Unused Action Tool - " {}  // leave slot between text tool and magnifying glass unused

macro "Nuclear Segmentation Action Tool - C620D12D13D14D21D22D23D24D25D31D32D33D34D35D41D42D43D44D45D52D53D54D96D97D98Da5Da6Da7Da8Da9Db5Db6Db7Db8Db9Dc5Dc6Dc7Dc8Dc9Dd6Dd7Dd8C08fD18D19D1aD27D28D29D2aD2bD37D38D39D3aD3bD47D48D49D4aD4bD58D59D5aD7dD7eD7fD8cD8dD8eD8fD9cD9dD9eD9fDacDadDaeDafDb1Db2Db3DbdDbeDbfDc0Dc1Dc2Dc3Dc4Dd0Dd1Dd2Dd3Dd4De0De1De2De3De4Df1Df2Df3"{

close_auxiliary_windows();
checkOpenedImageData();

Overlay.remove;
		
setBatchMode(true);
				
if (gRoisFilenameAlreadySaved) //No need to resegment ... go directly to scatterplot
	{
		drawPlot();
	}
else 
	{

	if(gWarningStardist=="yes") waitForUser("WARNING","Depending on size of your image StarDist may take some time\n you can get rid of this warning in parameters setup");
	
	
	
	
	run("Command From Macro",
	"command=[de.csbdresden.stardist.StarDist2D], args=['input':'"+gCurrentImage+"', 'modelChoice':'Versatile (H&E nuclei)', 'normalizeInput':'true', 'percentileBottom':'1.0', 'percentileTop':'99.8', 'probThresh':'0.15000000000000002', 'nmsThresh':'0.5', 'outputType':'ROI Manager', 'nTiles':'1', 'excludeBoundary':'2', 'roiPosition':'Automatic', 'verbose':'false', 'showCsbdeepProgress':'false', 'showProbAndDist':'false'], process=[false]");
	nNuclei=roiManager("count");
	
	roiManager("Set Color", "red");
	roiManager("Show All");
	roiManager("save", gRoisFilename);		
	}	



			
}

macro "Scatter Plot Action Tool - CfffDaaCcddDa5CfffD00D0fD10D20D30D31D32D33D34D35D36D37D38D40D41D42D43D44D45D46D47D48D50D51D52D53D54D55D56D57D58D60D61D62D63D66D67D68D6cD70D71D72D80D81D90D91D92Da0Da1Da2Da9DabDacDb0Db1Db8Db9DbaDbbDbcDc0Dc1Dc6Dc7Dc8Dc9DcaDcbDccDd0Dd1Dd6Dd7Dd8Dd9DdaDdbDdcDe0De1De2De3De4De5De6De7De8De9DeaDebDecDf0Df1Df2Df3Df4Df5Df6Df7Df8Df9DfaDfbDfcDfdDfeDffC666D12D13D14D15D16D17D18D19D1aD1bD1cD1dD1eCfffD69D78CeefD39C369Db3Db4CeeeD02D03D04D05D06D07D08D09D0aD0bD0cD0dD2aD2bD64Dd5C89aD98CfffD01D0eD1fD21D22D23D24D25D26D27D28D29D2cD2fD3fD4fD5fD65D6fD77D7fD82D8fD9cD9fDafDb6Db7DbfDcfDd2DdfDedDefC666D3eD4eD5eD6eD7eD8eD9eDaeDbeDceDdeCeeeD3dD4dD5dD6dD7dD8dD9dDadDbdDcdDddC68aD75Da6CeffD7cC469D89CaaaD11C259D4aD4bD84D97Dc3Dc4CdddD2dC369D8bC9abD73D9bC78aD3bD4cC579D87CbbcD88C555D2eCdddD6aC259D8aC89bD79C579D5aD83CabcD99Dc2Dd3CddeD76C469D5bC9abDb5C78aD7bC68aD94D9aDa7CbccDb2C258D85CcddD3cDa3Da8C89bD3aCbbbDeeCddeD59D6bD8cC469D74D7aCbbcD49D93C468D86C8abDc5CabcD5cDd4CbcdDa4C468D95"{

drawPlot();


}

macro "Threshold Action Tool - CfffD03D04D05D06D07D08D09D0aD0bD0cD0dD0eD0fD13D14D15D16D17D18D19D1aD1bD1cD1dD1eD1fD22D25D26D27D28D29D2aD2bD2cD2dD2eD2fD32D36D37D38D39D3aD3bD3cD3dD3eD3fD47D48D49D4aD4bD4cD4dD4eD4fD58D59D5aD5bD5cD5dD5eD5fD9fDa8Da9DaaDabDacDadDaeDafDb7Db8Db9DbaDbbDbcDbdDbeDbfDc6Dc7Dc8Dc9DcaDcbDccDcdDceDcfDd5Dd6Dd7Dd8Dd9DdaDdbDdcDddDdeDdfDe3De4De5De6De7De8De9DeaDebDecDedDeeDefDf3Df4Df5Df6Df7Df8Df9DfaDfbDfcDfdDfeDffC79cD7fC19dD41C9bcDc2C18dDa4C6cfD64D74C5adDb3CdeeD62D93C26cD9aC6ceD40D50D75Da0Db0C39dD87Db5CadfD10De0C39cD6dC7cfD30D70D80Dc0C5aeD34Dc3CeefD83C26bD6fC6ceD65D76D77C29eDa1Db1C9ceD12C19dD31D51D61D71D81C6cfD84D85C5aeD01De1Df1CdefD00Df0C27dD96C8ceD67C4beD21CdeeD92C39dD6eC8ceD56De2C5beD7aCeffD02Df2C06bD8dC7bcDb2C29dD91CacdDa2C28dD88Da5C6cfD60D90C5adD69CdefD35Dc5C27cD89D8aD97C49eDc4CbdeD46C39dD95Db4C6aeDd3CfffD42D52C16cD8cC7beD45C2aeDc1CadeD72C7cfD66C6adDa3CdefD8fC27cD98C3beD7cCbefD43C49dD6aD6bC8ceD20C5cfD54D79CeffD24C16bD9dC6beD23CacdDd2C27cD99C38dDa6CeffD73C16bD9bC8dfD55C4aeD94CcefD53C49dD6cC16bD9cC8beD57C2aeD7eCaceD82C6cfD78C5adD68C4aeDd1CbdfDb6C5beD11D86C17cD8bC8beDa7C3aeD7dC9dfD44CeefD63C47bD9eC4beD7bCcefD33C8cfDd0CfffDd4"{

setThresholdValues();

}

macro "overlays Action Tool - C19eDb9Cf71D5cDacCfffD00D01D02D03D04D0bD0cD0dD0eD0fD10D11D12D18D1dD1eD1fD20D21D27D28D29D2eD2fD30D31D3eD3fD40D4fD50D5fD60D6fD70D7fD80D8fD90D9fDa0DafDb0DbfDc0Dc1DceDcfDd0Dd1DdeDdfDe0De1De2DedDeeDefDf0Df1Df2Df3Df4DfbDfcDfdDfeDffCd60DeaCcddDa5Cfb4D53D92C655D77C8bdDc8Cf83Df6Cc73DbbCdeeDd9Cfb7DcdC001D99C59cD58Cf92D7dCe71Da4CffcD05Cfa6DaeC566D96CcddD55Cfa3D3cDb2Db3Cd94D74CffeD1cCfc7Da1C000D68C29dD8bCf92D73D93Cd60D54CedcD19Cfb5D91Cc50Dd5C7dfD4aCf94D6eD7eD8eDe4Ce82DbdCeefD66Dd7Cfd6D06D15C16aD7aC3bfDb8Cf92D4dD63Da3Dc3Cf71D4cD6cD7cD8cDbcCffeD41De3DecCfd6D42D43D61C988D67CbefD65Cfa3Da2Cda5D07CeffD39Cfc9DfaC09fDaaCf81D9cCe60Db4CcccDe7Cfb4D2cCc61De6CacdD57Cf94D9eDebCd73Df9CdefD38Cfb7Dc2C159D8aC3aeDbaCf92D5dD6dDd4Ce81Dc4CfedD3aD4eDb1Cfd6D52D62C776D86CbefD47Cd95D84CfffD22D2dDd2Cfe8D14C000D87C1afD5aCf82D8dD9dDadCd61DdbCeddD76Cfc5D1bD72Cc61D35CaefDa6Cd83D94CdefDc6Cfe7D24D33C48aD9bC7cfD48Cca9D45CbffD56D95Cda8D26CfffD36CfeaD32Cd60D3bDcbCb74DdaCf93Dd3Cd83Df7C123D69C3aeD49Cd71D2bCfedDbeCfb6D5eC776DabCbdeDc9Cd85D4bCffeD13Cfd7D23C29dD7bCeedD08Cfc6D81Cc71D25CadfD85Ce83DdcC379Da7C5bfD59Cba9De9CbffD46Cc96D2aCfcaDf5C1afD9aCf91D83Ce60D44CedcDd8Cfc4D82Cc61D16C9ceDc7Cd83D64CcefDe8Cfc7D3dC269Da8C4aeDa9Ce82DccCfc6D71C777D5bCbefD75Cea4D34Cfe9D51C3bfD6aCd71D1aCfedD17Cc72Dc5CaffDb6Cea4D09CdffD37C48aD6bC6cfDb7CbbaDb5Cca9Dd6CfebD0aCfffDddCf82De5CcbaDf8CdcbDca"{

setBatchMode(true);

roiManager("reset");
selectWindow(gCurrentImage);
if(bOverlay) 
	{	
	bOverlay = false;
	run("Hide Overlay");
	}
else 
	{
	bOverlay = true;
	run("Show Overlay");
	}



}

macro "Erase ROIs Action Tool - Cf64D22D33D34Dc3Dc4Dd2Cc33D0dDfdCfffD00D04D05D06D07D08D09D0aD0bD0fD15D16D17D18D19D1aD26D27D28D29D37D38D40D4fD50D51D5eD5fD60D61D62D6dD6eD6fD70D71D72D73D7cD7dD7eD7fD80D81D82D83D8cD8dD8eD8fD90D91D92D9dD9eD9fDa0Da1DaeDafDb0DbfDc7Dc8Dd6Dd7Dd8Dd9De5De6De7De8De9DeaDf0Df4Df5Df6Df7Df8Df9DfaDfbDffCd11Dd5Ce66D3aCe43D78D88Cb11D7bD8bCe55DcaCf32D4cDbcCe22D1eDeeCf86D32Dc2Cf44D1dD2cDdcDedCb11D2fDdfCf64D23Dd3Ce32D4bDbbCd22D4dD5cDacDbdCf77D31D75D85D94Da3Db2Dc1Cf53D55D56Da5Cc11D47Db7Cf75D54Da4Ce44D01D02Df1Cf22D2dD2eDddDdeCf97D21Dd1Cf54D44D45D76D86Db4Db5Ca01D1fD5dDadDefCf54DbaCe33D46Db6Dc5Ce12D03D52D63Df3Cf76Db3Cf43D87Cc12Dc9Cf55D20Dd0Cf43D69D6aD9aCe22D30D41Db1Dc0Cf87D11De1Cf54D4aD59Da9DcbCb11D0eDfeCf75D12De2Ce43D13De3Df2Cd22D6bD9bCd11D3eDceCf75D43Cf44D10De0Cf22D3dDcdCf54D3bCe32D7aD8aCd12D14D25Cf66D53Cf43D68D79D89D98Cb12D1bDdaDebCe66D1cD2bD49Db9DecCf32D5aD5bDaaDabCe22D93Da2Ce54D58Da8Cb11D6cD9cCf65D65D95Ce43D24D99Da7Cd11D36Dc6Ce43D35D57Ce76D64Cf53D66D67D77D96D97Da6Cc22D2aD39Cb12D0cDfcCd22D84Cc22D48Db8Cd12De4Cd65DdbCe22D3cDccCe33Dd4Cf76D42Cd23D74"{

erasesAllROIs(gROISDirectory);

}

macro "CPS Denominator: Help Action Tool - C5adD05D0aD15D27D36D3dD50Da0Db2Db3DbcDc5Dc6DcdDd5Dd6De5Df5DfaC3aeD28D29D34D37D39D49D56D58D59D61D66D6dD6fD7eD9fDa9Db8Db9Dc9Dd8Dd9CeefD12D21D72D79D7dD95Dd1De2C29dD32D38D44D47D48D51D55D57D65D67D69D6aD6bDa1Dc2Dc8C7ceD17D18D24D33D4dD52D5eD5fD7bD84D98D9dDa2DaeDafDbdC4beD25D26D2aD3aD3bD3eD46D4aD4eD5aD6cD8eDaaDbaDbeDcaDcbDceDdaCfffD00D01D02D03D0cD0dD0eD0fD10D11D1eD1fD20D2fD30D3fD63D73D7cD82D83D87D88D89D8cD8dD93D94D96D97Da3Da4Da5Da6Dc0DcfDd0DdfDe0De1DeeDefDf0Df1Df2Df3DfcDfdDfeDffC37cD06D07D08D09D13D14D31D99D9aDc1De3De4Df6Df7Df8Df9C5cfD16D2bD3cD42D5dD6eDc3DccDd4Dd7DdbDe6De7C4beD1aD35D45D5cD71D75D7fD81D8fDabDacDc7DeaCfffD1dD2eD53D9cDdeDedC49dD1bD1cD23D2dD43D74D86D91D9bDa7Db6Dc4Dd3DddDebDecCbceD04D0bD40D4fD54D62D64D78D8bD92Db0Db4Db5DbfDf4DfbC5cfD19D2cD4bD4cD5bD9eDadDbbDdcDe8De9C07dD68D76D77D7aD85D8aDa8Db7"{

  showMessage("Number of Nuclei", "<html>"
     +"<h1>PDL1 CPS denominator assesor help</h1>"
     +"<h2>This software is licensed under MIT Licence</h2>"
     +"<h2>Copyright (c) 2022 Gilbert Bigras</h2>"
     +"<p>Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the \"Software\"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:</p>"
     +"<p>The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.</p>"
     +"<p>THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.</p>" 
     +"<h3>Prerequisites and software installation</h3>"
     +"<p>This software requires installation of Fiji (ImageJ), an open source software written in Java, available for Linux, Mac OS X and Windows. Fiji(ImageJ) is available <a href=\"https://imagej.net/software/fiji/downloads\" target=\"_blank\">here</a>. Basic understanding of Fiji/ImageJ will facilitate installation.</p>"
     +"<p>Current software (PDL1_denominator.txt) is a \"toolset\" written in macro language and requires to be installed in a precise directory: &rarr;Fiji.app&rarr;macros&rarr;toolsets.</p>"
     +"<p>This script is based on the Stardist Plugin which is considered in 2022 the best nuclei segmentation tool</p>"
     +"<p>The Stardist plugin is available <a href=\"https://imagej.net/plugins/stardist\" target=\"_blank\">here</a></p>"
     +"<h3>Software utilization</h3>"
     +"<p>Please follow instruction here <a href=\"https://imagej.net/plugins/stardist\" target=\"_blank\">here</a></p>"
     );

}

var bCmds= newMenu("Settings Menu Tool", newArray("Define Image and Microscopic Areas Params...","-","Define Thresholds Area and Circularity..."));
macro "Settings Menu Tool - C037D3eD4eD5eD6bD6cD6dD7aD89D98Da7Db6Dc6Dd6De4De5D2aD5dDa2Dd5D59D68D69D77D78D86D87D96D1aD1bD1cD29D2bD39D49D4bD4cD4dD58D67D76D85D92D93D94Da1Db1Db2Db4Dc1Dc4Dd4De3D5aD6aD79D88D95D97Da5Da6D19D91D4aD5bDa4Db5D3aD5cDa3Dc5" {

cmd= getArgument();

if (cmd!="-" && cmd == "Define Image and Microscopic Areas Params...")
{
			  objectives = newArray("2X", "4X", "10X", "20X", "40X");
			  answers = newArray("yes","no");
			  title = "Set Image and Microscopic Areas Parameters";
			  Dialog.create(title);			  
			  Dialog.addNumber("Image horizontal dimension (mm)", gHorizontal);
			  Dialog.addNumber("Image Vertical dimension (mm)", gVertical);
			  Dialog.addNumber("Microscopic Field Diameter (mm)", gMicroscopicFieldDiameter);
  			  Dialog.addChoice("Objective:", objectives, gObjective);
  			  Dialog.addChoice("StarDist Warning:", answers, gWarningStardist);
  			  
  			  Dialog.show();

  			  aHorizontal = Dialog.getNumber();
  			  aVertical = Dialog.getNumber();
  			  aMicroscopicFieldDiameter = Dialog.getNumber();
  			  aObjective = Dialog.getChoice();
  			  anAnswer = Dialog.getChoice();

			  if((!isNaN(aHorizontal)) && (!isNaN(aVertical)) && (!isNaN(aMicroscopicFieldDiameter)))
			  {
			  call("ij.Prefs.set", "cps.pdl1.image.dimension.gHorizontal",toString(aHorizontal));
			  call("ij.Prefs.set", "cps.pdl1.image.dimension.gVertical",toString(aVertical));
			  call("ij.Prefs.set", "cps.pdl1.gMicroscopicFieldDiameter",toString(aMicroscopicFieldDiameter));
			  call("ij.Prefs.set", "cps.pdl1.gObjective",toString(aObjective));
			  call("ij.Prefs.set", "cps.pdl1.gWarningStardist",toString(anAnswer));
			  call("ij.Prefs.savePreferences"); // save preferences now
			  setMicroscopeAndImagesParamsFromPrefs();			  
			  }
			 else
			 {
			 	 warning("Values were not saved, please re-enter proper data");	  
			 }
			 
			  

}
if (cmd!="-" && cmd == "Define Thresholds Area and Circularity...")
{
			 title = "Define Thresholds for Nuclear area and circularity";
			  Dialog.create(title);
			  Dialog.addMessage("Inspect the scatterplot to make your choice of Thresholds");
			  Dialog.addMessage("Select all nuclei with area > :");
			  Dialog.addNumber("Threshold Nuclear Area", gThresholdArea);
			  Dialog.addMessage("Select all nuclei with circularity > :");
			  Dialog.addNumber("Threshold Nuclear Circularity", gThresholdCircularity);			  
			  Dialog.show();
			  
			  aThresholdArea = Dialog.getNumber();
			  aThresholdCircularity = Dialog.getNumber();
			
			 if(!isNaN(aThresholdArea) && !isNaN(aThresholdCircularity))
			 {
			 call("ij.Prefs.set", "cps.pdl1.gThresholdArea",toString(aThresholdArea));
			 call("ij.Prefs.set", "cps.pdl1.gThresholdCircularity",toString(aThresholdCircularity));			 
			 call("ij.Prefs.savePreferences"); // save preferences now
			 setThresholdFromPrefs();// replace with new values
			 drawPlot();
			 }
			 else
			 {
			 	 warning("Values were not saved, please re-enter proper data");	  
			 }
	
}


}


function close_auxiliary_windows()
 {
	  if (isOpen("ROI Manager")) {
	  	  selectWindow("ROI Manager");
	  	  run("Close");
	  }
	  if (isOpen("Results")) {
	  	  selectWindow("Results");
	  	  run("Close");
	  }
	  if (isOpen("Log")) {
	  	  selectWindow("Log");
	  	  run("Close");
	  }
	  if (isOpen("Plot of Results")) {
	  	  selectWindow("Plot of Results");
	  	  run("Close");
	  }
 }

function setMicroscopeAndImagesParamsFromDefault()
 	{
 		 		
	gHorizontal=gHorizontalDefault;
	call("ij.Prefs.set", "cps.pdl1.image.dimension.gHorizontal",toString(gHorizontal));
	gVertical=gVerticalDefault;
	call("ij.Prefs.set", "cps.pdl1.image.dimension.gVertical",toString(gVertical));
	gMicroscopicFieldDiameter=gMicroscopicFieldDiameterDefault;
	call("ij.Prefs.set", "cps.pdl1.gMicroscopicFieldDiameter",toString(gMicroscopicFieldDiameter));
	gObjective=gObjectiveDefault;
	call("ij.Prefs.set", "cps.pdl1.gObjective",toString(gObjective));
	gWarningStardist=gWarningStardistDefault;
	call("ij.Prefs.set", "cps.pdl1.gWarningStardist",toString(gWarningStardist));	

	}

function setMicroscopeAndImagesParamsFromPrefs()
 	{
 	
	gHorizontal=parseFloat(call("ij.Prefs.get", "cps.pdl1.image.dimension.gHorizontal","")); //"" is the default value but should never be called. Inserted here to respect number of arguments 
	gVertical=parseFloat(call("ij.Prefs.get", "cps.pdl1.image.dimension.gVertical",""));
	gMicroscopicFieldDiameter=parseFloat(call("ij.Prefs.get", "cps.pdl1.gMicroscopicFieldDiameter",""));
	gObjective=call("ij.Prefs.get", "cps.pdl1.gObjective","");
	gWarningStardist=call("ij.Prefs.get", "cps.pdl1.gWarningStardist","");

	}
	
function setThresholdFromDefault()
 	{
 		 		
	gThresholdArea=gThresholdAreaDefault;
	call("ij.Prefs.set", "cps.pdl1.gThresholdArea",toString(gThresholdArea));
	gThresholdCircularity=gThresholdCircularityDefault;
	call("ij.Prefs.set", "cps.pdl1.gThresholdCircularity",toString(gThresholdCircularity));

	}

function setThresholdFromPrefs()
 	{
 	
	gThresholdArea=parseFloat(call("ij.Prefs.get", "cps.pdl1.gThresholdArea","")); //"" is the default value but should never be called. Inserted here to respect number of arguments 
	gThresholdCircularity=parseFloat(call("ij.Prefs.get", "cps.pdl1.gThresholdCircularity",""));

	}	

function warning(a_message)
{
	Dialog.create("WARNING!");
	Dialog.addMessage(a_message);
	Dialog.show();

}

function checkOpenedImageData()
{
	if (nImages==0)
 	{
      warning("No images are open");
      exit
 	}
 	else {
			imageID = getImageID();
			close("\\Others");
			
    		gCurrentImage = getTitle();
    		nameWithoutExtension =File.getNameWithoutExtension(gCurrentImage);
    		FullPathWithoutExtension = gROISDirectory +File.separator+ "CPS_PDL1_" + replace(nameWithoutExtension," ","_");
    		gRoisFilename = FullPathWithoutExtension + ".zip";
    		if (File.exists(gRoisFilename)) gRoisFilenameAlreadySaved = true; else gRoisFilenameAlreadySaved = false;
		}
}

function drawPlot()
{
	run("Set Measurements...", "area shape redirect=None decimal=3");

if (isOpen("Plot of Results")) {
	  	  selectWindow("Plot of Results");
	  	  run("Close");
	  }
if (isOpen("Results")) {
	  	  selectWindow("Results");
	  	  run("Close");
	  }	  

setBatchMode(true);

checkOpenedImageData();

if (gRoisFilenameAlreadySaved)
	{	
		//roiManager("reset");
		roiManager("open", gRoisFilename);
	}
else
	{
		warning("Please do nuclei segmentation first");
		exit
	}


roiManager("deselect");
roiManager("Set Color", "red");
roiManager("Show All without labels");
roiManager("measure");



tableSize = Table.size;
nPoints = roiManager("count");
removed = 0;
indexes = newArray;
for (i = 0; i < nPoints; i++) {
	if (Table.get("Circ.", i) < gThresholdCircularity || Table.get("Area", i) < gThresholdArea) {
		indexes[removed]= i;
		removed++;		
	}
}



gXRed = newArray(0);
gYRed = newArray(0);
gXGreen = newArray(0);
gYGreen = newArray(0);
allArea = Table.getColumn("Area");
allCirc = Table.getColumn("Circ.");
Array.getStatistics(allArea, minArea, maxArea, mean, stdDev);
Array.getStatistics(allCirc, minCirc, maxCirc, mean, stdDev);




populateGlobalArrays(gThresholdCircularity,gThresholdArea,allArea,allCirc,nPoints);



Plot.create("Plot of Results", "Area", "Circularity");

Plot.setLimits(minArea, maxArea, minCirc,maxCirc);


Plot.setColor("red");
Plot.add("Circle", gXRed,gYRed);

Plot.setColor("green");
Plot.add("Circle", gXGreen,gYGreen);

Plot.setLineWidth(3);
Plot.setColor( "blue");
Plot.drawLine(0, gThresholdCircularity, maxArea, gThresholdCircularity);
Plot.drawLine(gThresholdArea, 0, gThresholdArea, 1.0);

Plot.setLegend("Red = "+toString(g_n_red)+" ("+gObjective+" = "+toString(g_n_red_Microscopic_Field)+")"+"\t"+"Green = "+toString(g_n_green)+" ("+gObjective+" = "+toString(g_n_green_Microscopic_Field)+")");




	  if (isOpen("Results")) {
	  	  selectWindow("Results");
	  	  run("Close");
	  }

selectWindow(gCurrentImage);

roiManager("select", indexes)
roiManager("Set Color", "green");
run("From ROI Manager");

}

function setThresholdValues()
{
				 title = "Define Thresholds for Nuclear area and circularity";
			  Dialog.create(title);
			  Dialog.addMessage("Inspect the scatterplot to make your choice of Thresholds");
			  Dialog.addMessage("Select all nuclei with area > :");
			  Dialog.addNumber("Threshold Nuclear Area", gThresholdArea);
			  Dialog.addMessage("Select all nuclei with circularity > :");
			  Dialog.addNumber("Threshold Nuclear Circularity", gThresholdCircularity);			  
			  Dialog.show();
			  
			  aThresholdArea = Dialog.getNumber();
			  aThresholdCircularity = Dialog.getNumber();
			
			 if(!isNaN(aThresholdArea) && !isNaN(aThresholdCircularity))
			 {
			 call("ij.Prefs.set", "cps.pdl1.gThresholdArea",toString(aThresholdArea));
			 call("ij.Prefs.set", "cps.pdl1.gThresholdCircularity",toString(aThresholdCircularity));			 
			 call("ij.Prefs.savePreferences"); // save preferences now
			 setThresholdFromPrefs();// replace with new values
			 drawPlot();
			 }
			 else
			 {
			 	 warning("Values were not saved, please re-enter proper data");	  
			 }
	
}

function populateGlobalArrays(thresholdCircularity,thresholdArea,areaArray,circArray,n) {

greenCounter = 0;
redCounter = 0;		

for (i = 0; i < n; i++) 
	{
		if (areaArray[i] < thresholdArea || circArray[i] < thresholdCircularity)
		{
			gXGreen[greenCounter] = areaArray[i];
			gYGreen[greenCounter] = circArray[i];
			greenCounter = greenCounter +1;
		}
		else 
		{
			gXRed[redCounter] = areaArray[i];
			gYRed[redCounter] = circArray[i];
			redCounter = redCounter + 1;
		}
	}
	
	g_n_red = redCounter;
	g_n_green = greenCounter;
	
	areacamera = gHorizontal*gVertical;
	
	g_n_red_Microscopic_Field = round(redCounter*PI*(gMicroscopicFieldDiameter/2)*(gMicroscopicFieldDiameter/2)/areacamera);
 	g_n_green_Microscopic_Field = round(greenCounter*PI*(gMicroscopicFieldDiameter/2)*(gMicroscopicFieldDiameter/2)/areacamera);
	
}

function erasesAllROIs(dir) {
	  
  	 showMessageWithCancel("Erasing All Created ROIs","Are you sure you want to erase ROIs");
     
     list = getFileList(dir);
     for (i=0; i<list.length; i++) {
     	File.delete(dir+File.separator+list[i]);
     }
     if (isOpen("Log")) {
	  	  selectWindow("Log");
	  	  run("Close");
	  }
  

}

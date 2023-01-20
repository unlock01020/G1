<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml" class="iframe_con">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<script language="JavaScript" src="js/define.js" type="text/JavaScript"></script>
<script language="JavaScript" src="js/subpage.js" type="text/JavaScript"></script>
<script language="JavaScript" src="js/common.js" type="text/javascript"></script>
<script language="JavaScript" src="js/jquery-1.10.2.min.js" type="text/JavaScript"></script>
<script language="Javascript" src="js/jquery.simplemodal-1.4.4.js" type="text/JavaScript"></script>
<link href="css/subpage.css" type="text/css" rel="stylesheet">

<head>
<script>
var timer=0;
var g_rssi=0;
var g_cinr_reuse1=0;
var g_imbalanceTimer=0;
var isAutoRefreshEnabled = "<% enableAutoRefresh(); %>";
var g_refreshCount=200;
var customer_Qubeepk='<% customerType("Qubeepk"); %>';
var device_type = '<% getDeviceType("CPE","CPE"); %>';
//var displayon = style_display_on();
var timer=0;

var g_Cus = "<% GetCusType(); %>";
var g_ssid_num  = "<% WiFiGetBSSIDNum();%>";
var g_SecuritySSID = "<% WiFiGetSecuritySSID();%>";
var g_scheme = "<% GetAreascanPlatform(); %>";
var picture_vlaue = "<% nvram_get("router_style"); %>";
var model_vlaue = "<% nvram_get("router_disable"); %>";
var arr2 = new Array([ 1, 0, 599 ],[2, 600, 1199 ],[3, 1200, 1949],[4, 1950, 2399],[5, 2400, 2649],[6, 2650, 2749],[7, 2750, 3449],[8, 3450, 3799],[9, 3800, 4149],
[10, 4150, 4749],[11, 4750, 4949],[12, 5010, 5179],[13, 5180, 5279],[14, 5280, 5379],[17, 5730, 5849],[18, 5850, 5999],[19, 6000, 6149],
[20, 6150, 6449],[21, 6450, 6599],[22, 6600, 7399],[23, 7500, 7699],[24, 7700, 8039],[25, 8040, 8689],[26, 8690, 9039],[27, 9040, 9209],[28, 9210, 9659],[31, 9870, 9919],
[33, 36000, 36199],[34, 36200, 36349],[35, 36350, 36949],[36, 36950, 37549],[37, 37550, 37749],[38, 37750, 38249],[39, 38250, 38649],[40, 38650, 39649],[41, 39650, 41589],[42, 41590, 43589],[43, 43590, 45589],[44, 45590, 46589],[46, 46790, 54539],[47, 54540, 55239],[48, 55240, 56739],[52, 59140, 60139],[55, 53850, 54849],[66, 66436, 67335],[71, 68586, 68935],[252, 255144, 256143],[255, 260894, 262143]);

function ShowWindow(){
	 hideLoading();
	 $(".main_content").show();


     if (navigator.appName=="Microsoft Internet Explorer")
     {
         var b_version=navigator.appVersion.split(";");
         var version=parseFloat(b_version[1].replace(/[MSIE ]/g,""));
         if(version < 9)
         {
         }
     }
}

function importOnceJs(scriptPath) {
    var scripts = document.getElementsByTagName("script");
    var scriptTag = document.createElement("script");
    scriptTag.type = "text/javascript";
    scriptTag.src = scriptPath;
    scriptTag.charset = "utf-8";
    var headTag = document.getElementsByTagName("head")[0];
    headTag.appendChild(scriptTag);
}


function importOnceCss(linkPath) {
    var links = document.getElementsByTagName("link");
    var linkTag = document.createElement("link");
    linkTag.rel = "stylesheet";
    linkTag.href = linkPath;
    linkTag.media = "all";
    var headTag = document.getElementsByTagName("head")[0];
    headTag.appendChild(linkTag);
}
function get_band_by_earfcn(earfcn){
 for (i=0; i<arr2.length; i++)
	     {
              if (earfcn>=arr2[i][1] && earfcn<=arr2[i][2])
              {
			      return arr2[i][0];
              }
	     }

		 return "XX";
}
var wlan_status='';
var OR_NOT;
var OR_NOT_5G;
var div_height = new Array();
var wifi_list = new Array();
var wifi_5g_list = new Array();
var contop_height = new Array();
function array_max(arr){
    var max=arr[0];
    for(var i in arr){
    if(arr[i]>max){max=arr[i];}
    }
    return max;
}


function RefreshChange(){
    div_height.length = 0;
    contop_height.length = 0;
    $(".confoot").css("height","");
    $(".contop").css("height","");

    if (parseInt($("html").css("width"))<700){
        $(".connect_div").css("width","99%");
	   $("#current_connection").parent(".connect_div").removeClass("connect_right");

	   $("#id_lte").parent(".connect_div").removeClass("right_border");
        $("#id_lte").parent(".connect_div").addClass("connect_bottom");


        $("#id_lte").parent(".connect_div").removeClass("connect_right");
            
		$("#id_wifi_status").parents(".connect_div").addClass("connect_top");
        $("#id_wifi_status").parents(".connect_div").addClass("connect_bottom");
		$("#control_div").show();

    }else{
        
        $(".connect_div").css("width","49.7%");
		$("#current_connection").parent(".connect_div").addClass("connect_right");
		$("#id_lte").parent(".connect_div").addClass("connect_right");
	    $("#id_lte").parent(".connect_div").addClass("connect_top");
        $("#id_lte").parent(".connect_div").removeClass("connect_bottom");
		$("#id_lte").parent(".connect_div").addClass("right_border");
		$("#id_wifi_status").parent(".connect_div").removeClass("connect_top");
		$("#id_wanStatus").parent(".connect_div").removeClass("connect_top");
        $("#id_wanStatus").parent(".connect_div").removeClass("right_border");
		$("#control_div").hide();
    }

    $(".confoot").each(function(){
      div_height.push(parseInt($(this).css("height")));
      });
    $(".confoot").css("height",array_max(div_height));

    $(".contop").each(function(){
      contop_height.push(parseInt($(this).css("height")));
     }); 

    $(".contop").css("height",array_max(contop_height));
}




function InitWifiValue()
{
     switch("<% WiFiGetAuthMode(1);%>")
     {
         case "open":
              document.getElementById("wlanencryption").innerHTML = "OPEN";
             break;
         case "wpa-psk":
              document.getElementById("wlanencryption").innerHTML = "WPA-PSK";
             break;
         case "wpa2-psk":
              document.getElementById("wlanencryption").innerHTML = "WPA2-PSK";
             break;
         case "wpa-wap2-psk":
              document.getElementById("wlanencryption").innerHTML = "WPA-PSK/WPA2-PSK";
             break;
         default:
             break;
     }
    
}



function InitTimeFun(Seconds)
{   
	var strTime="";
	var strDay = 0;
	var strHour = 0;
	var strMin = 0;
	var strSec = 0;
	strDay = parseInt(Seconds / (24*60*60));
	if (strDay > 0)
	{
	   strTime = strTime + strDay + "d"+" ";
	}

	strHour = Seconds - strDay*24*60*60;
	strHour = parseInt(strHour / (60*60));
	if (strHour > 0)
	{
	    strTime = strTime + strHour + "h"+" ";
	}
	strMin = Seconds - strDay*24*60*60- strHour*60*60;
	strMin = parseInt(strMin / 60);
	if (strMin > 0)
	{
	    strTime = strTime + strMin + "min"+" ";
	}
	strSec = Seconds - strDay*24*60*60- strHour*60*60- strMin*60;
	if (strSec>=0)
	{
	   // strTime = strTime + strSec + "S";
		 strTime = strTime + strSec + "&nbsp;"+"sec";
	}
	return strTime;
}


function loadPageLTE()
{		
	var updteInfo = "<% getupdateState(); %>";
	if(updteInfo == 1)
	{
	  alert("Your modem's software has been successfully updated.");
	}
    var LteBasicInfo = "<% lteGetBasicInfo(); %>";
    var refreshTime = 6000;
    var isAutoRefreshEnabled = "<% enableAutoRefresh(); %>";

    var tempArray = LteBasicInfo.split(";");
    var Soft_Version = "<% show_device_software("soft_version"); %>";
	var Version = Soft_Version.split("Build");
    document.getElementById("productModel").innerHTML=tempArray[1];
	document.getElementById("fwinfo").innerHTML=Version[0];
	var RSRP = tempArray[9].split(",");
	var RSSI = tempArray[10].split(",");
	var ifrist = 0;
	var radio_rsrp = "";
    var rsrp_signal = -160;
	for (i=0; i<RSRP.length; i++)
	{
	    if((!isNaN(RSRP[i]) && (RSRP[i].length)>0)
		   || (RSRP[i]=="-"))
	    {
		    if (0 == ifrist)
		    {   
				 if (RSRP[i]=="-")
				 {
				     radio_rsrp = "-"
				 }
				 else
				 {
				     radio_rsrp = RSRP[i] / 100;
				     rsrp_signal = RSRP[i] / 100;
				 }
				 ifrist = 1;
		    }
			else
			{ 
                if (RSRP[i]=="-")
				{
				    radio_rsrp = radio_rsrp + "&nbsp;/&nbsp;" +  "-";
				}
				else
				{
			        radio_rsrp = radio_rsrp + "&nbsp;/&nbsp;" +  RSRP[i] / 100;
					if (parseInt(rsrp_signal)<parseInt((RSRP[i]/100)))
					{
					    rsrp_signal = RSRP[i]/100;
					}
				}
			}
		}
	}
	if (radio_rsrp == "")
	{
	    document.getElementById("rsrp_0").innerHTML="-" + "&nbsp;/&nbsp;"+"-";
	}
	else
	{
	    document.getElementById("rsrp_0").innerHTML = rsrp_signal +" dBm";
		if(rsrp_signal == "-160")
		{
		   document.getElementById("rsrp_0").innerHTML = "-";
		}
	}
	var imode = 0;
	var radio_rssi = "";
    if(RSSI.length == 8)
	{  

	  for (i=0; i<RSSI.length; i++)
	  {
	   if(isNaN(RSSI[i]) || RSSI[i]>0)
	   {
	     RSSI[i] = "-";
	   }
	   else
	   {
	     RSSI[i] = RSSI[i]/100;
	   }
	  } 
	   var radio_rssi1 =  RSSI[0] + "&nbsp;/&nbsp;" +  RSSI[1] + "&nbsp;/&nbsp;"  + RSSI[2] + "&nbsp;/&nbsp;" +  RSSI[3];
	   var radio_rssi2 =  RSSI[4] + "&nbsp;/&nbsp;" +  RSSI[5] + "&nbsp;/&nbsp;"  + RSSI[6] + "&nbsp;/&nbsp;" +  RSSI[7];
	   document.getElementById("signal").innerHTML = radio_rssi1 +" dBm";
	  // $("#dv_radio_RSSI8").show();  
	  // document.getElementById("radio_RSSI8").innerHTML = radio_rssi2;
	}
	else
   {
	for (i=0; i<RSSI.length; i++)
	{
	    if((!isNaN(RSSI[i]) && (RSSI[i].length)>0)
		   || (RSSI[i]=="-"))
	    {
		    if (0 == imode)
		    {   
				 if (RSSI[i]=="-")
				 {
				     radio_rssi = "-"
				 }
				 else
				 {
				     radio_rssi = RSSI[i] / 100;
				 }
				 imode = 1;
		    }
			else
			{ 
                if (RSSI[i]=="-")
				{
				    radio_rssi = radio_rssi + "&nbsp;/&nbsp;" +  "-";
				}
				else
				{
			        radio_rssi = radio_rssi + "&nbsp;/&nbsp;" +  RSSI[i] / 100;
				}
			}
		}
	}
	if (radio_rssi == "")
	{
	    document.getElementById("signal").innerHTML="";
	}
	else
	{
	    document.getElementById("signal").innerHTML = radio_rssi +" dBm";;
	}
   }
   var SINR = tempArray[11].split(",");
   if (!isNaN(SINR[0]))
   {
        document.getElementById("sinr").innerHTML=SINR[0] / 100 +" dB";
   }
   else if(isNaN(SINR[0]))
   {
         document.getElementById("sinr").innerHTML="-";
   }
	document.getElementById("currStatus").innerHTML=tempArray[16];
	if(document.getElementById("currStatus").innerHTML=="ATTACHED")
	{
	  document.getElementById("currStatus").innerHTML="Connected";
	}
	if("ATTACHED" == tempArray[16] || "CONNECTED" == tempArray[16])
	{
	  $("#id_lte_status").show();
	
	}
	else
	{
	  $("#id_lte_status").hide();
	
	}
	document.getElementById("imei").innerHTML=tempArray[4];
	document.getElementById("imsi").innerHTML=tempArray[28];
	document.getElementById("uiccid").innerHTML="<% nvram_get("sqns_simcard_uiccid"); %>";
	document.getElementById("lte_operator").innerHTML=tempArray[66];
    
    document.getElementById("lte_band").innerHTML=tempArray[53];



	if ((tempArray[44] == "000,000") || (tempArray[44] == "fff,fff") || (tempArray[44] == ""))
	{
	    document.getElementById("plmn").innerHTML="-";
	}
	else
	{
	    document.getElementById("plmn").innerHTML=tempArray[44].replace(",","&nbsp;");
	}
	document.getElementById("cell_id").innerHTML=tempArray[50];
	document.getElementById("eci").innerHTML=tempArray[54];
	var RSRQ = tempArray[35].split(",");
	var irsrqmode = 0;
	var radio_rsrq = "";
	for (i=0; i<RSRQ.length; i++)
	{
	    if((!isNaN(RSRQ[i]) && (RSRQ[i].length)>0)
		   || (RSRQ[i]=="-"))
	    {
		    if (0 == irsrqmode)
		    {   
				 if (RSRQ[i]=="-")
				 {
				     radio_rsrq = "-"
				 }
				 else
				 {
				     radio_rsrq = RSRQ[i] / 100;
				 }
				 irsrqmode = 1;
		    }
			else
			{ 
                if (RSRQ[i]=="-")
				{
				    radio_rsrq = radio_rsrq + "&nbsp;/&nbsp;" +  "-";
				}
				else
				{
			        radio_rsrq = radio_rsrq + "&nbsp;/&nbsp;" +  RSRQ[i] / 100;
				}
			}
		}
	}
    if (radio_rsrq == "")
	{
	    document.getElementById("rsrq").innerHTML="";
	}
	else
	{
	    if(!isNaN(RSRQ[0]))
		{
		  
		  document.getElementById("rsrq").innerHTML = RSRQ[0] / 100 +" dB";
		}
		else
		{
	      document.getElementById("rsrq").innerHTML = "-";
		}
	}
	//wifi
	 InitWifiValue();
	var varValue = "<% nvram_get("wlan_enable"); %>";
	    if ("1" == varValue)
	    {
	        document.getElementById("w_lan").innerHTML = "Enabled";
	    }
	    else
	    {
	        document.getElementById("w_lan").innerHTML = "Disabled";
	    }
	document.getElementById("wifissid").innerHTML = "<% nvram_get("wlan_ssids"); %>";
	document.getElementById("channel").innerHTML =  "<% nvram_get("wlan_channel"); %>";
	document.getElementById("password").innerHTML = "<% nvram_get("wlan_wpapsk"); %>";
	var pdntype = tempArray[58];
    if (pdntype == "IPv4") {
        $("#id_wanStatus").parent(".overview_div").show();
        $("#id_wanStatus").show();
        $("#ipv4_wanStatus").show();
        $("#ipv6_wanStatus").hide();
    }
	else if (pdntype == "IPv6")
	{
        
            $("#id_wanStatus").parent(".overview_div").show();
            $("#id_wanStatus").show();
            $("#ipv4_wanStatus").hide();
            $("#ipv6_wanStatus").show();
	}
	else if (pdntype == "IPv4v6")
	{
            $("#id_wanStatus").parent(".overview_div").show();
            $("#id_wanStatus").show();
            $("#ipv4_wanStatus").show();
            $("#ipv6_wanStatus").show();
	}else
	{
	       $("#ipv4_wanStatus").show();
	}
	
	//$("#wanmethod").text("LTE");
     
	vpnmode = $("#vpnmode_ch").val();
   sqnsvpnmode = $("#sqnsvpnmode_ch").val();
   if (document.getElementById("lan_route").value == "1") {

        var temp = document.getElementById("vpn_page_proto").value;
	  if(document.getElementById("vpnmode_ch").value == "1" || document.getElementById("sqnsvpnmode_ch").value == "1")
	  {
		if(temp == "gre" || temp == "l2tpv3" || temp == "l2tp")
		{
		 $("#wanMode").text("L2 Bridge");
		}
		else{
	
		 $("#wanMode").text("IP Passthrough");
		}  
	  }
	  else
	  {
	    if(temp == "gre")
		{
		  $("#wanMode").text("L2 Bridge");
		}
		else{
		 $("#wanMode").text("IP Passthrough");
		}
	  }
	} else {
		$("#wanMode").text("NAT");

	}

	if(model_vlaue == "1")
	{
	   if("ATTACHED" == tempArray[16] || "CONNECTED" == tempArray[16])
	   {
            document.getElementById("wanIp").innerHTML = tempArray[62].replace("0.0.0.0","&nbsp;&nbsp;&nbsp;&nbsp;");
	   }
	   else
	   {
	        document.getElementById("wanIp").innerHTML = "-";
	   }
	}
	else
    {
	     document.getElementById("wanIp").innerHTML = tempArray[38].replace("0.0.0.0","&nbsp;&nbsp;&nbsp;&nbsp;");    
	}

    var stripv4netmask = tempArray[60];
	if(model_vlaue == "1")
	{
	    if("ATTACHED" == tempArray[16] || "CONNECTED" == tempArray[16])
		{
            document.getElementById("wanMask").innerHTML ="255.255.255.255";
		}
		else
		{
		    document.getElementById("wanMask").innerHTML ="-";
		}
	}
	else
    {
	
	    document.getElementById("wanMask").innerHTML = stripv4netmask.replace("0.0.0.0","&nbsp;&nbsp;&nbsp;&nbsp;");
	}
    document.getElementById("wanDns").innerHTML = tempArray[39].replace("0.0.0.0","").replace(" ","&nbsp;&nbsp;&nbsp;&nbsp;");
	document.getElementById("ipv6wanIp").innerHTML = tempArray[40];
	//document.getElementById("wanMac").innerHTML=tempArray[20];
	//document.getElementById("wanGw").innerHTML=tempArray[65];
	
	/*ipv6 dns too long split two chunks*/
    if ((-1 != tempArray[41].indexOf(" "))&&(tempArray[41].length > 3))
    {
         document.getElementById("ipv6DnsServer_more").style.display =  "block";
         document.getElementById("ipv6DnsServer_more").style.visibility = "visible";
         //document.getElementById("ipv6wanDns").style.display =  "none";
        // document.getElementById("ipv6wanDns").style.visibility = "hidden";
         //document.getElementById("ipv6wanDns").innerHTML = tempArray[41].split(" ")[0];
         //document.getElementById("network_ipv6DnsServer_more").innerHTML = tempArray[41].split(" ")[1];
    }
    else
    {
         document.getElementById("ipv6DnsServer_more").style.display =  "none";
         document.getElementById("ipv6DnsServer_more").style.visibility = "hidden";
		 //document.getElementById("ipv6wanDns").style.display =  "none";
        // document.getElementById("ipv6wanDns").style.visibility = "hidden";
         //document.getElementById("ipv6wanDns").innerHTML = tempArray[41];
    }

	var  stripv4mac= "<% nvram_get("lan_hwaddr"); %>";
    document.getElementById("lanMac").innerHTML = stripv4mac.replace("0.0.0.0","").replace(" ","&nbsp;&nbsp;&nbsp;&nbsp;");

	
	var strlan_ip = "<% nvram_get("lan_ipaddr"); %>";
   // document.getElementById("lanIp").innerHTML = strlan_ip.replace("0.0.0.0","&nbsp;&nbsp;&nbsp;&nbsp;");
    var strlan_netmask = "<% nvram_get("lan_netmask"); %>";
   // document.getElementById("lanMask").innerHTML = strlan_netmask.replace("0.0.0.0","&nbsp;&nbsp;&nbsp;&nbsp;");

	document.getElementById("wanonlineTime").innerHTML = InitTimeFun(tempArray[36]);
	document.getElementById("dl_dr").innerHTML = tempArray[34];
    document.getElementById("ul_dr").innerHTML = tempArray[33];
 
    timer=self.setInterval("infoRef()",refreshTime);

}



function refreshInfo(retStr)
{
    
    if (retStr.indexOf("<!DOCTYPE html PUBLIC") >= 0)
    {
        return ;
    }
	var g_scheme = "<% GetAreascanPlatform(); %>";
    var tempArray=retStr.split(";");
    var Soft_Version = "<% show_device_software("soft_version"); %>";
	var Version = Soft_Version.split("Build");
    document.getElementById("productModel").innerHTML=tempArray[1];
	document.getElementById("fwinfo").innerHTML=Version[0];
	var RSRP = tempArray[9].split(",");
	var RSSI = tempArray[10].split(",");
	var ifrist = 0;
	var radio_rsrp = "";
    var rsrp_signal = -160;
	for (i=0; i<RSRP.length; i++)
	{
	    if((!isNaN(RSRP[i]) && (RSRP[i].length)>0)
		   || (RSRP[i]=="-"))
	    {
		    if (0 == ifrist)
		    {   
				 if (RSRP[i]=="-")
				 {
				     radio_rsrp = "-"
				 }
				 else
				 {
				     radio_rsrp = RSRP[i] / 100;
				     rsrp_signal = RSRP[i] / 100;
				 }
				 ifrist = 1;
		    }
			else
			{ 
                if (RSRP[i]=="-")
				{
				    radio_rsrp = radio_rsrp + "&nbsp;/&nbsp;" +  "-";
				}
				else
				{
			        radio_rsrp = radio_rsrp + "&nbsp;/&nbsp;" +  RSRP[i] / 100;
					if (parseInt(rsrp_signal)<parseInt((RSRP[i]/100)))
					{
					    rsrp_signal = RSRP[i]/100;
					}
				}
			}
		}
	}
	if (radio_rsrp == "")
	{
	    document.getElementById("rsrp_0").innerHTML="-" + "&nbsp;/&nbsp;"+"-";
	}
	else
	{
	    document.getElementById("rsrp_0").innerHTML = rsrp_signal +" dBm";
		if(rsrp_signal == "-160")
		{
		   document.getElementById("rsrp_0").innerHTML = "-";
		}
	}
	var imode = 0;
	var radio_rssi = "";
    if(RSSI.length == 8)
	{  

	  for (i=0; i<RSSI.length; i++)
	  {
	   if(isNaN(RSSI[i]) || RSSI[i]>0)
	   {
	     RSSI[i] = "-";
	   }
	   else
	   {
	     RSSI[i] = RSSI[i]/100;
	   }
	  } 
	   var radio_rssi1 =  RSSI[0] + "&nbsp;/&nbsp;" +  RSSI[1] + "&nbsp;/&nbsp;"  + RSSI[2] + "&nbsp;/&nbsp;" +  RSSI[3];
	   var radio_rssi2 =  RSSI[4] + "&nbsp;/&nbsp;" +  RSSI[5] + "&nbsp;/&nbsp;"  + RSSI[6] + "&nbsp;/&nbsp;" +  RSSI[7];
	   document.getElementById("signal").innerHTML = radio_rssi1 +" dBm";
	  // $("#dv_radio_RSSI8").show();  
	  // document.getElementById("radio_RSSI8").innerHTML = radio_rssi2;
	}
	else
   {
	for (i=0; i<RSSI.length; i++)
	{
	    if((!isNaN(RSSI[i]) && (RSSI[i].length)>0)
		   || (RSSI[i]=="-"))
	    {
		    if (0 == imode)
		    {   
				 if (RSSI[i]=="-")
				 {
				     radio_rssi = "-"
				 }
				 else
				 {
				     radio_rssi = RSSI[i] / 100;
				 }
				 imode = 1;
		    }
			else
			{ 
                if (RSSI[i]=="-")
				{
				    radio_rssi = radio_rssi + "&nbsp;/&nbsp;" +  "-";
				}
				else
				{
			        radio_rssi = radio_rssi + "&nbsp;/&nbsp;" +  RSSI[i] / 100;
				}
			}
		}
	}
	if (radio_rssi == "")
	{
	    document.getElementById("signal").innerHTML="";
	}
	else
	{
	    document.getElementById("signal").innerHTML = radio_rssi +" dBm";;
	}
   }
   var SINR = tempArray[11].split(",");
   if (!isNaN(SINR[0]))
   {
        document.getElementById("sinr").innerHTML=SINR[0] / 100 +" dB";
   }
   else if(isNaN(SINR[0]))
   {
         document.getElementById("sinr").innerHTML="-";
   }
	document.getElementById("currStatus").innerHTML=tempArray[16];
	if(document.getElementById("currStatus").innerHTML=="ATTACHED")
	{
	  document.getElementById("currStatus").innerHTML="Connected";
	}
	if("ATTACHED" == tempArray[16] || "CONNECTED" == tempArray[16])
	{
	  $("#id_lte_status").show();
	
	}
	else
	{
	  $("#id_lte_status").hide();
	
	}
	document.getElementById("imei").innerHTML=tempArray[4];
	document.getElementById("imsi").innerHTML=tempArray[28];
	document.getElementById("uiccid").innerHTML="<% nvram_get("sqns_simcard_uiccid"); %>";
    document.getElementById("lte_operator").innerHTML=tempArray[66];
     
    document.getElementById("lte_band").innerHTML=tempArray[53];

	if ((tempArray[44] == "000,000") || (tempArray[44] == "fff,fff") || (tempArray[44] == ""))
	{
	    document.getElementById("plmn").innerHTML="-";
	}
	else
	{
	    document.getElementById("plmn").innerHTML=tempArray[44].replace(",","&nbsp;");
	}
	document.getElementById("cell_id").innerHTML=tempArray[50];
	document.getElementById("eci").innerHTML=tempArray[54];
	var RSRQ = tempArray[35].split(",");
	var irsrqmode = 0;
	var radio_rsrq = "";
	for (i=0; i<RSRQ.length; i++)
	{
	    if((!isNaN(RSRQ[i]) && (RSRQ[i].length)>0)
		   || (RSRQ[i]=="-"))
	    {
		    if (0 == irsrqmode)
		    {   
				 if (RSRQ[i]=="-")
				 {
				     radio_rsrq = "-"
				 }
				 else
				 {
				     radio_rsrq = RSRQ[i] / 100;
				 }
				 irsrqmode = 1;
		    }
			else
			{ 
                if (RSRQ[i]=="-")
				{
				    radio_rsrq = radio_rsrq + "&nbsp;/&nbsp;" +  "-";
				}
				else
				{
			        radio_rsrq = radio_rsrq + "&nbsp;/&nbsp;" +  RSRQ[i] / 100;
				}
			}
		}
	}
    if (radio_rsrq == "")
	{
	    document.getElementById("rsrq").innerHTML="";
	}
	else
	{
	    if(!isNaN(RSRQ[0]))
		{
		  
		  document.getElementById("rsrq").innerHTML = RSRQ[0] / 100 +" dB";
		}
		else
		{
	      document.getElementById("rsrq").innerHTML = "-";
		}
	}
	//wifi
	var pdntype = tempArray[58];
    if (pdntype == "IPv4") {
        $("#id_wanStatus").parent(".overview_div").show();
        $("#id_wanStatus").show();
        $("#ipv4_wanStatus").show();
        $("#ipv6_wanStatus").hide();
    }
	else if (pdntype == "IPv6")
	{
        
            $("#id_wanStatus").parent(".overview_div").show();
            $("#id_wanStatus").show();
            $("#ipv4_wanStatus").hide();
            $("#ipv6_wanStatus").show();
	}
	else if (pdntype == "IPv4v6")
	{
            $("#id_wanStatus").parent(".overview_div").show();
            $("#id_wanStatus").show();
            $("#ipv4_wanStatus").show();
            $("#ipv6_wanStatus").show();
	}else
	{
	       $("#ipv4_wanStatus").show();
	}
	//$("#wanmethod").text("LTE");
	if(model_vlaue == "1")
	{
	   if("ATTACHED" == tempArray[16] || "CONNECTED" == tempArray[16])
	   {
            document.getElementById("wanIp").innerHTML = tempArray[62].replace("0.0.0.0","&nbsp;&nbsp;&nbsp;&nbsp;");
	   }
	   else
	   {
	        document.getElementById("wanIp").innerHTML = "-";
	   }
	}
	else
    {
	     document.getElementById("wanIp").innerHTML = tempArray[38].replace("0.0.0.0","&nbsp;&nbsp;&nbsp;&nbsp;");    
	}

    var stripv4netmask = tempArray[60];
	if(model_vlaue == "1")
	{
	    if("ATTACHED" == tempArray[16] || "CONNECTED" == tempArray[16])
		{
            document.getElementById("wanMask").innerHTML ="255.255.255.255";
		}
		else
		{
		    document.getElementById("wanMask").innerHTML ="-";
		}
	}
	else
    {
	
	    document.getElementById("wanMask").innerHTML = stripv4netmask.replace("0.0.0.0","&nbsp;&nbsp;&nbsp;&nbsp;");
	}
    document.getElementById("wanDns").innerHTML = tempArray[39].replace("0.0.0.0","").replace(" ","&nbsp;&nbsp;&nbsp;&nbsp;");
	document.getElementById("ipv6wanIp").innerHTML = tempArray[40];
	//document.getElementById("wanMac").innerHTML=tempArray[20];
	//document.getElementById("wanGw").innerHTML=tempArray[65];
	/*ipv6 dns too long split two chunks*/
    if ((-1 != tempArray[41].indexOf(" "))&&(tempArray[41].length > 3))
    {
         document.getElementById("ipv6DnsServer_more").style.display =  "block";
         document.getElementById("ipv6DnsServer_more").style.visibility = "visible";
         //document.getElementById("ipv6wanDns").innerHTML = tempArray[41].split(" ")[0];
		// document.getElementById("ipv6wanDns").style.display =  "none";
        // document.getElementById("ipv6wanDns").style.visibility = "hidden";
       //  document.getElementById("network_ipv6DnsServer_more").innerHTML = tempArray[41].split(" ")[1];
    }
    else
    {
         document.getElementById("ipv6DnsServer_more").style.display =  "none";
         document.getElementById("ipv6DnsServer_more").style.visibility = "hidden";
         //document.getElementById("ipv6wanDns").innerHTML = tempArray[41];
    }

	var  stripv4mac= "<% nvram_get("lan_hwaddr"); %>";
    //document.getElementById("lanMac").innerHTML = stripv4mac.replace("0.0.0.0","").replace(" ","&nbsp;&nbsp;&nbsp;&nbsp;");

	
	var strlan_ip = "<% nvram_get("lan_ipaddr"); %>";
    //document.getElementById("lanIp").innerHTML = strlan_ip.replace("0.0.0.0","&nbsp;&nbsp;&nbsp;&nbsp;");
    //var strlan_netmask = "<% nvram_get("lan_netmask"); %>";
    //document.getElementById("lanMask").innerHTML = strlan_netmask.replace("0.0.0.0","&nbsp;&nbsp;&nbsp;&nbsp;");

	document.getElementById("wanonlineTime").innerHTML = InitTimeFun(tempArray[36]);
	document.getElementById("dl_dr").innerHTML = tempArray[34];
    document.getElementById("ul_dr").innerHTML = tempArray[33];

}

function infoRef()
{

    AjaxHttpRequest("GET","../GP/Overview_info_live.asp", "", refreshInfo);
}

function CheckInvalidSimcard(){
	var sub_device_type = "<% GetGPType(); %>";
	var hplmn = "<% nvram_get("sqns_simcard_hplmn"); %>";

	if (sub_device_type == "MTN"){
		if (hplmn.length==5 && -1 ==hplmn.indexOf("43235")){
			console.log('Unlocked By AMK');
		}else if (hplmn.length==6 && -1 ==hplmn.indexOf("432350")){
			console.log('Unlocked By AMK');
	}
}
	
	
}
//****************************************************************
//**********            $(document).Ready 
//****************************************************************

$(document).ready(function(){
     for (var i=0; i<3; i++){
		importOnceCss("css/subpage.css");
    }
	setInterval("RefreshChange()",3000);
    loadPageLTE();
    contop_height.length = 0;
    $(".contop").css("height","");
    $(".contop").each(function(){
       contop_height.push(parseInt($(this).css("height")));
      });
    $(".contop").css("height",array_max(contop_height));
    $("input:radio[name=setting]").change(function(){
       
    });
    CheckInvalidSimcard();
})
</script>
</head>
<body style="overflow:auto;">


<div class="connect_module">
<div class='main_content'>

<div class="connect_div connect_right contop">
<div id="current_connection" class="margin_div">
<input type="hidden" name="vpn_page_proto" id="vpn_page_proto" value="<% nvram_gozila_get("vpn_proto"); %>" />
<input type="hidden" name="vpnmode_ch"  id="vpnmode_ch" value="<% Getvpnmode(); %>"/>
<input type="hidden" name="sqnsvpnmode_ch"  id="sqnsvpnmode_ch" value="<% Getsqnsvpnmode(); %>"/>
<script type="text/javascript"> add_itemtitle("Current Connection"); </script>
<script type="text/javascript"> add_txt("DL Data Rate","dl_dr");</script>
<script type="text/javascript"> add_txt("UL Data Rate","ul_dr");</script>

<div id="id_currentTime" style="display:none;">
<script type="text/javascript"> add_txt("System Current Time","currentTime");</script>
</div>

<script type="text/javascript"> add_txt("Online Time","wanonlineTime");</script>

</div>
<span style="z-index:9999;"></span>
</div>

<div class="connect_div connect_bottom contop" id="id_wifi" style="">
<div id="id_wifi_status"  class="margin_div">
<script type="text/javascript"> add_itemtitle("WLAN Status"); </script>

<div id="wifi_status">
<script type="text/javascript"> add_txt("WLAN","w_lan");</script>
<script type="text/javascript"> add_txt("SSID","wifissid");</script>
<script type="text/javascript"> add_txt("Channel","channel");</script>
<script type="text/javascript"> add_txt("Security","wlanencryption");</script>
<script type="text/javascript"> add_txt("Password","password");</script>
</div>
</div>
</div>



<div class="connect_div confoot connect_right connect_top">
<div id='id_lte' class="margin_div">
<input type="hidden" name="lan_route"  id= "lan_route" value="<% nvram_get("router_disable"); %>" />
<script type="text/javascript"> add_itemtitle("LTE Status"); </script>
<script type="text/javascript"> add_txt("Status","currStatus");</script>

<div id="id_lte_status" style="display:none;">

<div id="id_plmn" style="display:none;">
<script type="text/javascript"> add_txt("PLMN","plmn");</script><div class="content_item" id="plmn_contentitem" style="min-height:20px;"><div class="content_item_left">PLMN</div><div class="content_item_right" id="plmn">--</div></div>
</div>

<div id="id_operator">
<script type="text/javascript"> add_txt("Operator","lte_operator");</script>
</div>

<div id="id_band">
<script type="text/javascript"> add_txt("Band","lte_band");</script>
</div>

<div id='lte_mode' style="display:none;">
<script type="text/javascript"> add_txt("Mode","mode");</script>
</div>

<div id='cellId_content'>
<script type="text/javascript"> add_txt("Cell ID","cell_id");</script>
</div>

<div id="eci_content">
<script type="text/javascript"> add_txt("ECGI","eci");</script>
</div>

<div id='rssi_content' style="display:none;">
<script type="text/javascript"> add_txt("RSSI","signal");</script>
</div>

<div id='rsrp_content'>
<script type="text/javascript"> add_txt("RSRP","rsrp_0");</script>
<div style="display:none;">
<script type="text/javascript"> add_txt("RSRP1","rsrp_1");</script>
</div>
<script type="text/javascript"> add_txt("RSRQ","rsrq");</script>
<script type="text/javascript"> add_txt("SINR","sinr");</script>
</div>

</div>
</div>

</div>

<div class="connect_div contop" style=";">
<div id='id_wanStatus' class="margin_div" style=";">
<script type="text/javascript"> add_itemtitle("WAN Status"); </script>
<script type="text/javascript"> add_txt("Connect Mode","wanMode");</script>
<div id="ipv4_wanStatus" style="display:none;">
<script type="text/javascript"> add_txt("IP Address","wanIp");</script>
<script type="text/javascript"> add_txt("Subnet Mask","wanMask");</script>
<script type="text/javascript"> add_txt("DNS Server","wanDns");</script>
</div>

<div id="ipv6_wanStatus" style="display:none;">
<script type="text/javascript"> add_txt("IPv6 Global Address","ipv6wanIp");</script>
<script type="text/javascript"> add_txt("IPv6 DNS Server","ipv6wanDns");</script>
<script type="text/javascript"> add_txt("","ipv6DnsServer_more");</script>

</div>

<div id="control_div" style="display:none;">
<script type="text/javascript"> add_txt("","");</script>
<script type="text/javascript"> add_txt("","");</script>
</div>

<span style="display:none;">
<script type="text/javascript"> add_txt("Device Model","productModel");</script>
<script type="text/javascript"> add_txt("IMEI","imei");</script>
<script type="text/javascript"> add_txt("Router Version","fwinfo");</script>
<script type="text/javascript"> add_txt("UICCID","uiccid");</script>
<script type="text/javascript"> add_txt("IMSI","imsi");</script>
<script type="text/javascript"> add_txt("IP","lanIp");</script>
<script type="text/javascript"> add_txt("Netmask","lanMask");</script>
<script type="text/javascript"> add_txt("MAC Address","lanMac");</script>
</span>
</div>
</div>



</div>
</div>
</body>
</html>

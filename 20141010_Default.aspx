<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script language="javascript" type ="text/javascript">

<!-- #include file="Tools\DateCheck.js" -->

function checkCustomerField()
{
    var sType=document.getElementById("<%=CustNameLangList.ClientID%>").value   
    var cName=document.getElementById("<%=customerName.ClientID%>").value.split(" ").join("")
    var sCode=document.getElementById("<%=subCustomerCode.ClientID%>").value.split(" ").join("")
    var sName=document.getElementById("<%=siteName.ClientID%>").value.split(" ").join("")
    var sSerN=""
    if (document.getElementById("<%=serialNo.ClientID%>") != null)
    {
        sSerN=document.getElementById("<%=serialNo.ClientID%>").value.split(" ").join("")
    }    
    
    if ((sType == "E") && (cName.length == 0))
    {
        alert("Please enter Customer English Name");
        document.getElementById("<%=customerName.ClientID%>").focus();
        return false;
    }
    if ((cName.length > 0) && (cName.indexOf("<") >= 0))
    {
        alert("'<' symbol is not allowed here, please re-enter");
        document.getElementById("<%=customerName.ClientID%>").value = "";
        document.getElementById("<%=customerName.ClientID%>").focus();
        return false;
    }
    if ((sCode.length > 0) && (sCode.indexOf("<") >= 0))
    {
        alert("'<' symbol is not allowed here, please re-enter");
        document.getElementById("<%=subCustomerCode.ClientID%>").value = "";
        document.getElementById("<%=subCustomerCode.ClientID%>").focus();
        return false;
    }
    if ((sName.length > 0) && (sName.indexOf("<") >= 0))
    {
        alert("'<' symbol is not allowed here, please re-enter");
        document.getElementById("<%=siteName.ClientID%>").value = "";
        document.getElementById("<%=siteName.ClientID%>").focus();
        return false;
    }
    if ((sSerN.length > 0) && (sSerN.indexOf("<") >= 0))
    {
        alert("'<' symbol is not allowed here, please re-enter");
        document.getElementById("<%=serialNo.ClientID%>").value = "";
        document.getElementById("<%=serialNo.ClientID%>").focus();
        return false;
    }
}

function checkSRField()
{
    var srKW=document.getElementById("<%=SerRepKeyWord.ClientID%>").value.split(" ").join("")
    
    if ((srKW.length > 0) && (srKW.indexOf("<") >= 0))
    {
        alert("'<' symbol is not allowed here, please re-enter");
        document.getElementById("<%=SerRepKeyWord.ClientID%>").value = "";
        document.getElementById("<%=SerRepKeyWord.ClientID%>").focus();
        return false;
    }
}

function chkASRField()
{
    var srKW=document.getElementById("<%=ArchiveKeyWordSearch.ClientID%>").value.split(" ").join("")
    
    if ((srKW.length > 0) && (srKW.indexOf("<") >= 0))
    {
        alert("'<' symbol is not allowed here, please re-enter");
        document.getElementById("<%=ArchiveKeyWordSearch.ClientID%>").value = "";
        document.getElementById("<%=ArchiveKeyWordSearch.ClientID%>").focus();
        return false;
    }
}

function checkAgField()
{
    var srKW=document.getElementById("<%=AgrKeyWordSearch.ClientID%>").value.split(" ").join("")
    
    if ((srKW.length > 0) && (srKW.indexOf("<") >= 0))
    {
        alert("Any script type language or '<' symbol is not allowed here, please re-enter");
        document.getElementById("<%=AgrKeyWordSearch.ClientID%>").value = "";
        document.getElementById("<%=AgrKeyWordSearch.ClientID%>").focus();
        return false;
    }
}

function goPage()
{
    var kw=document.getElementById("<%=IncomKeyWord.ClientID%>").value.split(" ").join("")
    
    if ((kw.length > 0) && (kw.indexOf("<") >= 0))
    {
        alert("Any script type language or '<' symbol is not allowed here, please re-enter");
        document.getElementById("<%=IncomKeyWord.ClientID%>").value = "";
        document.getElementById("<%=IncomKeyWord.ClientID%>").focus();        
    } else {
        var selectT=document.getElementById("<%=IncomSearchList.ClientID%>").value
        var rSRUN="";
        if (document.getElementById("<%=radUnassign.ClientID%>") != null)
        {
            rSRUN=document.getElementById("<%=radUnassign.ClientID%>").checked;
        }
        var rWSRUN="";
        if (document.getElementById("<%=radWinUnassign.ClientID%>") != null)
        {
            rWSRUN==document.getElementById("<%=radWinUnassign.ClientID%>").checked;
        }        
        var rUnrep=document.getElementById("<%=radUnreport.ClientID%>").checked
        
        if (rSRUN == true)
        {
            location.href='IncompleteCall/ServiceReportAssign.aspx?kw=' + kw + '&kwt=' + selectT;
        }
        if (rWSRUN == true)
        {
            location.href='IncompleteCall/OtherServiceReportAssign.aspx?kw=' + kw + '&kwt=' + selectT;
        }
        if (rUnrep == true)
        {
            location.href='IncompleteCall/IncompleteServiceReportList.aspx?kw=' + kw + '&kwt=' + selectT;
        }
    }
}

function confirmAdd()
{
    if (window.confirm("Are you Sure You Want To Add Agreement?"))
	{
		return true;
	} else {
	    return false;
	}
}

function submitSRSearch(){
    if (window.event.keyCode==13){
        __doPostBack('btnLogin', '');
    }
}

function ShortAddCall()
{
    if (event.keyCode == 13)
    {
        document.getElementById("btnAddService").click();
    }
}

function submitSRSearch()
{
    if (event.keyCode == 13)
    {
        document.getElementById("searchReport").click();
    }
}

function SearchAgr()
{
    if (event.keyCode == 13)
    {
        document.getElementById("btnSearchAgreement").click();
    }
}

function submitNSearch()
{
    if (event.keyCode == 13)
    {
        document.getElementById("btnNote").click();
    }
}

function submitASRSearch()
{
    if (event.keyCode == 13)
    {
        document.getElementById("btnSerachArc").click();
    }
}
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=big5" />
    <meta http-equiv="content" content="Nationmark is Hong Kong Primier IBM AS/400 total solution provider. We provide comprehensive AS/400 related services, software, hardware, maintenance, system planning, contingency planning" />
    <meta http-equiv="keywords" content="Hong Kong, China, Asia, IBM, AS/400, solution, hardware, software, maintenance, contingency, backup site, PC, LAN" />
    <meta http-equiv="refresh" content="600" />
    <title>Nationmark (HK) Ltd. Call Checking System</title>
    <link rel="stylesheet" type="text/css" href="Css/default.css" />    
</head>
<body background="images/Bg-0064.jpg" bgcolor="#B6B6AA" text="#000000">
    <script language="javascript" type="text/javascript">
        //function ConfirmMessage()
        //{	            
	    //    PageMethods.updateAlert();
        //}
    </script>
    
    <form id="form1" runat="server">
        
    <div>           
        <center>
            <table border="0" cellpadding="0" cellspacing="0" width="900">
                <tr>
                    <td valign="top" width="469" align="left">
                        <h3><b>Nationmark(HK) Ltd. </b></h3>
                        <h3><u>CALL CHECKING SYSTEM </u></h3><br />
                    </td>
                    <td width="146"><img src="images/Nmark.gif" alt="Nationmark (H.K.) Ltd." border="0" width="144" height="80" /></td>
                </tr>
            </table>
            
            <table border="0" cellpadding="0" cellspacing="0" width="900" align="center">
                <tr><td class="TBox" width="300" align="left">
	                    User: <asp:Label runat="server" ID="userName" Font-Bold="true"></asp:Label></td>
	                <td class="TBox" width="300" align="left">
		                Authorization: <asp:Label runat="server" ID="userAuth" Font-Bold="true"></asp:Label></td>
		            <td class="TBox" width="300" align="left">
            		    Login Time: <asp:Label runat="server" ID="logTime" Font-Bold="true"></asp:Label></td></tr>
                <tr><td class="TBox" width="300" align="left">
	                    <asp:Label runat="server" ID="lbl1" Text="Last Archive Date: " ForeColor="Blue" Font-Bold="true"></asp:Label>
	                    <asp:Label runat="server" ID="archiveDate" Font-Bold="true" ForeColor="Blue"></asp:Label></td>
	                <td class="TBox" width="300" align="left">
	                    <asp:Label runat="server" ID="lbl2" Text="Total Unread Message: " ForeColor="Blue" Font-Bold="true"></asp:Label>
	                    <asp:Label runat="server" ID="unreadMsg" Font-Bold="true" ForeColor="Blue"></asp:Label></td>
	                <td class="TBox" width="300" align="left">
	                    <asp:Label runat="server" ID="lbl3" Text="Remember To Logout: " ForeColor="Blue" Font-Bold="true"></asp:Label>
	                    <asp:LinkButton runat="server" ID="logOut" Text="LogOut"></asp:LinkButton></td></tr> 	            
            </table>
            
            <table border="0" cellpadding="0" cellspacing="0" width="900">
                <tr><td width="300" class="TBox" valign="top">
                        <div id="NewServiceBox" runat="server" visible="false"><!-- New Service -->
                            <table border="1" width="300" height="240">
                                <tr valign="top"><td align="left">	                                    
	                                    <table border="0" width="100%" valign="top">
	                                        <tr bgcolor="#add8e6"><th>New Service</th></tr>
	                                        <tr><td class="TBox" align="left">Customer Name or Code: <br />
	                                                <asp:TextBox runat="server" ID="customerName" MaxLength="100" Width="100" TabIndex="1" CssClass="TBox" onkeypress="javascript:ShortAddCall();" ></asp:TextBox>	                                            
			                                        <asp:DropDownList ID="CustNameLangList" runat="server" AutoPostBack="false" Width="150" TabIndex="2">
			                                            <asp:ListItem Text="ALL" Value="A"></asp:ListItem>
			                                            <asp:ListItem Text="English Customer Name" Value="E"></asp:ListItem>
			                                            <asp:ListItem Text="Chinese Customer Name" Value="C"></asp:ListItem>
			                                        </asp:DropDownList>	                                
		                                        </td></tr>
		                                    <tr><td>Sub-Customer Code <asp:Textbox runat="server" ID="subCustomerCode" MaxLength="20" onkeypress="javascript:ShortAddCall();" TabIndex="3"></asp:Textbox></td></tr>
		                                    <tr><td>Site Name <asp:TextBox runat="server" ID="siteName" MaxLength="50" onkeypress="javascript:ShortAddCall();" TabIndex="4"></asp:TextBox></td></tr>
		                                    <tr id="AddSRSerial" runat="server"><td>Serial No &nbsp;&nbsp;<asp:TextBox runat="server" ID="serialNo" MaxLength="50" onkeypress="javascript:ShortAddCall();" TabIndex="5"></asp:TextBox>
		                                            <asp:CheckBox ID="chkPC" runat="server" Text="PC" TabIndex="6" /></td></tr>		                                    
		                                    <tr><td align="right"><asp:LinkButton ID="btnAddService" Text="Add New Service Call" runat="server" causesvalidation="false" OnClientClick="return checkCustomerField()" PostBackUrl="NewService/PreAddServiceReport.aspx"></asp:LinkButton></td></tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>      
                        </div>
                        
                        <div id="IncompleteBox" runat="server" visible="false"><!-- Incomplete Call -->
                            <table border="1" width="300" height="172">
                                <tr valign="top"><td>
                                        <table border="0" width="100%">
    	                                    <tr bgcolor="#add8e6"><th>Incomplete Call</th></tr>
	                                        <tr><td class="TBox" align="left">
	                                                <b>Key Word Search:</b><br />
	                                                <asp:TextBox runat="server" ID="IncomKeyWord" MaxLength="100" TabIndex="9" CssClass="TBox"></asp:TextBox>&nbsp;
	                                                <asp:DropDownList ID="IncomSearchList" runat="server" AutoPostBack="false" TabIndex="10">
	                                                    <asp:ListItem Text="ALL" Value="A"></asp:ListItem>
	                                                    <asp:ListItem Text="Client Service ID" Value="CS"></asp:ListItem>
	                                                    <asp:ListItem Text="Customer Code" Value="CC"></asp:ListItem>
	                                                    <asp:ListItem Text="Customer Name" Value="CN"></asp:ListItem>
	                                                    <asp:ListItem Text="Distinct" Value="D"></asp:ListItem>
	                                                    <asp:ListItem Text="Engineer" Value="E"></asp:ListItem>
	                                                    <asp:ListItem Text="Report No" Value="R" Selected="True"></asp:ListItem>
	                                                </asp:DropDownList><br />
	                                                <asp:RadioButton runat="server" ID="radUnassign" GroupName="icType" Text="Un-assign Service Call" Checked="true" CssClass="TBox" TabIndex="11" />
	                                                <asp:RadioButton runat="server" ID="radUnreport" GroupName="icType" Text="Un-Report Service Call" CssClass="TBox" TabIndex="12" /><br />
	                                                <asp:RadioButton runat="server" ID="radWinUnassign" GroupName="icType" CssClass="TBox" TabIndex="13" />&nbsp;
						                        </td></tr>
			                                <tr><td align="right"><a href="javascript:goPage()">Search</a>&nbsp;</td></tr>
			                                <tr><td align="left"><a id="notCreate" runat="server" href="IncompleteCall/ServiceReportFollowList.aspx">Follow Not Create New Call</a><br />
			                                                     <asp:HyperLink ID="otherNotCreate" runat="server" NavigateUrl="IncompleteCall/OtherServiceReportFollowList.aspx"></asp:HyperLink>
		                                        </td></tr>
                                        </table></td></tr>
	                            </table>
                        </div>
                        
                        <div id="AdminBox" runat="server" visible="false"> <!-- Admin Box -->
                            <table border="1" width="300" height="190">
					            <tr valign="top"><td>
	                                <table border="0" width="100%" style="text-align:left">      
	                                    <tr bgcolor="#add8e6"><th>Administration</th></tr>					                                    
	                                    <!-- Login Account -->
	                                    <tr id="EditLogin" runat="server" visible="false">
			                                <td class="TBox"><a href="Administration/UserList.aspx">Edit User Login Account</a></td></tr>
            		                                    
		                                <!-- Customer Information -->
	                                    <tr id="EditCustomer" runat="server" visible="false">
			                                <td class="TBox"><a href="Administration/CustomerSearchListFrame.aspx">Edit Customer Information</a></td></tr>
		                                <tr id="AllCustomer" runat="server" visible="false">
		                                    <td class="TBox"><a href="Administration/CustomerFullList.aspx">Customer Full List</a></td></tr>
            		                                        
		                                <!-- Group Name -->
	                                    <tr id="EditGpName" runat="server" visible="false">
	                                        <td class="TBox"><a href="Administration/GroupList.aspx" >Edit Group Name</a></td></tr>
            		                                    
		                                <!-- Report Type -->
		                                <tr id="EditReport" runat="server" visible="false">
			                                <td class="TBox"><a href="Administration/ReportType.aspx">Edit Report Type</a></td></tr>
            		                                    
		                                <!-- Case Type -->
		                                <tr id="EditCase" runat="server" visible="false">
			                                <td class="TBox"><a href="Administration/CaseType.aspx">Edit Cases Type</a></td></tr>
            		                                    
		                                <!-- Service Category -->
		                                <tr id="EditSerCat" runat="server" visible="false">
			                                <td class="TBox"><a href="Administration/ServiceCategory.aspx">Edit Service Category</a></td></tr>
            		                                    
		                                <!-- Company Name -->
		                                <tr id="EditCompany" runat="server" visible="false">
			                                <td class="TBox"><a href="Administration/CompanyList.aspx">Edit Company Name</a></td></tr>		                                    
	                                </table></td></tr>
                            </table>
                        </div>
                        
                        <div id="AlertMessageBox" runat="server" visible="false"><!-- Alert Message -->
                            <table border="1" width="300" height="50">
                                <tr valign="Top"><td>
	                                <table border="0" width="100%">
		                                <tr bgcolor="#add8e6"><th colspan="2">Alert Message</th></tr>
		                                <!-- View Alert -->
		                                <tr id="ViewAlert" visible="false" runat="server" align="left">
		                                    <td class="TBox"><a href="AlertMessage/ViewAlert.aspx">View Alert</a></td></tr>
		                                <!-- Send Alert -->
		                                <tr id="SendAlert" visible="false" runat="server" align="left"> 
		                                    <td class="TBox"><a href="AlertMessage/SendAlert.aspx">Send Alert</a></td></tr>
		                                <!-- Alert Event Admin -->
		                                <tr id="EventAdmin" visible="false" runat="server" align="left"> 
		                                    <td class="TBox"><a href="AlertMessage/EventAlert.aspx">Event Administration</a></td></tr>	
                                    </table></td></tr>
                            </table>
                        </div></td>
                     
                    <td width="300" class="TBox" valign="Top">    
                        <div id="ServiceReportBox" runat="server" visible="false"><!-- Service Report -->
                            <table border="1" width="300" height="240">
                                <tr valign="top"><td>
                                        <table border="0" width="100%">    	                                    
        	                                <tr bgcolor="#add8e6"><th colspan="2">Service Report</th></tr>        	                                            
        	                                <tr><td width='100%' class="TBox" align="left"><b>Key Word Search:</b><br />
		                                            <asp:TextBox runat="server" ID="SerRepKeyWord" MaxLength="100" TabIndex="7" CssClass="TBox" Width="100" onkeypress="javascript:submitSRSearch();"></asp:TextBox>
 		                                            <asp:DropDownList ID="SerRepSearchList" runat="server" AutoPostBack="false" TabIndex="8">
 		                                                <asp:ListItem Text="ALL" Value="ALL"></asp:ListItem>
 		                                                <asp:ListItem Text="Client Service ID" Value="ClientServiceID"></asp:ListItem>
 		                                                <asp:ListItem Text="Customer Code" Value="CustomerCode"></asp:ListItem>
 		                                                <asp:ListItem Text="Customer Name" Value="CustomerName"></asp:ListItem>
 		                                                <asp:ListItem Text="Model Number" Value="ModelNo"></asp:ListItem>
 		                                                <asp:ListItem Text="NM Quotation" Value="NMQUONO"></asp:ListItem>
 		                                                <asp:ListItem Text="Quotation No" Value="QUONO"></asp:ListItem>
 		                                                <asp:ListItem Text="Serial Number" Value="SerialNo"></asp:ListItem>
 		                                                <asp:ListItem Text="Service Report No" Value="WholeServiceReportNo" Selected="True"></asp:ListItem>
 		                                            </asp:DropDownList>
 		                                                        
			                                        <asp:LinkButton ID="searchReport" runat="server" Text="Search" causesvalidation="false" OnClientClick="return checkSRField()" ></asp:LinkButton>			
			                                    </td></tr>			                                                                                	                                        
	                                        <tr><td class="TBox" align="left" colspan="2" style="height:20px"><a href="ServiceReport/ServiceReportSearch.aspx">Service Report Advance Search</a></td></tr>
	                                        <tr id="rosterRow" runat="server"><td class="TBox" align="left" colspan="2" style="height:20px"><a href="ServiceReport/TodayRosterList.aspx">Today Roster</a></td></tr>
	                                        <tr id="jobRow" runat="server"><td class="TBox" align="left" colspan="2" style="height:20px"><a href="ServiceReport/JobStatus.aspx">Job Status</a></td></tr>
	                                        <tr id="ur" runat="server"><td class="TBox" align="left" colspan="2" style="height:20px"><a href="ServiceReport/UnassignReport.aspx">Unassigned Service Report List</a></td></tr>
                                        </table>
	                                </td></tr>
                            </table>
                        </div> 
                        
                        <div id="ArchiveBox" runat="server" visible="false"> <!-- Archive Box -->
                            <table border="1" width="300" height="172">
                                <tr valign="top"><td>
	                                    <table border="0" width="100%">	                                        
	                                        <tr bgcolor="#add8e6"><th colspan="2">Archive Data</th></tr>
	                                        <tr><td width='100%' class="TBox" align="left">
		                                            <b>Key Word Search:</b><br />
		                                            <asp:TextBox runat="server" ID="ArchiveKeyWordSearch" MaxLength="100" Width="100px" CssClass="TBox" TabIndex="22" onkeypress="javascript:submitASRSearch();"></asp:TextBox>
 			                                        <asp:DropDownList ID="ArchiveSearchList" runat="server" AutoPostBack="false" TabIndex="23">
 			                                            <asp:ListItem Text="ALL" Value="ALL"></asp:ListItem>
 			                                            <asp:ListItem Text="Client Service ID" Value="ClientServiceID"></asp:ListItem>
 			                                            <asp:ListItem Text="Customer Code" Value="CustomerCode"></asp:ListItem>
 			                                            <asp:ListItem Text="Customer name" Value="CustomerName"></asp:ListItem>
 			                                            <asp:ListItem Text="Model Number" Value="ModelNo"></asp:ListItem>
 			                                            <asp:ListItem Text="Serial Number" Value="SerialNo"></asp:ListItem>
 			                                            <asp:ListItem Text="Service Report No" Value="WholeServiceReportNo" Selected="True"></asp:ListItem>
 			                                        </asp:DropDownList>			
			                                        <asp:LinkButton ID="btnSerachArc" runat="server" Text="Search" causesvalidation="false" OnClientClick="return chkASRField()" PostBackUrl="ArchiveData/ArchiveServiceReportList.aspx"></asp:LinkButton>
			                                    </td></tr> 
	                                        <tr><td class="TBox" align="left" colspan="2"> 
				                                    <a href="ArchiveData/ArchiveServiceReportSearch.aspx">Archive Service Report Advance Search</a>
		                                        </td></tr>
	                                        <tr><td class="TBox" align="left" colspan="2">&nbsp;</td></tr>
	                                        <tr><td class="TBox" align="left" colspan="2"> 
			                                        <a href="ArchiveData/ArchiveNoteList.aspx">Archive Note Report</a></td></tr>	                                                
                                        </table>
                                    </td></tr>
                            </table>    
                        </div>
                        
                        <div id="AgreementReportBox" runat="server" visible="false"><!-- Agreement Report Box -->
                            <table border="1" width="300" height="132">
                                <tr align="left" valign="top"><td>
	                                <table border="0" width="100%">	                                        
	                                    <tr bgcolor="#add8e6"><th colspan="2">Agreement Report</th></tr>
            	                                                    
	                                    <!-- Agreement Amt Report -->
	                                    <tr id="AgrAmtReport" runat="server" visible="false">
		                                    <td width='80%' class="TBox">
		                                        <a href="AgreementReport/AgreementAmountReport.aspx">Agreement Amount Report</a></td></tr>
            	                                                    
	                                    <!-- Agreement PC, Agreement Non PC -->
	                                    <tr id="AgrPCInfo" runat="server" visible="false">
		                                    <td width='80%' class="TBox">
			                                    <a href="AgreementReport/AgreementPCStockReport.aspx">Agreement PC Product Stock Info.</a></td></tr>
	                                    <tr id="AgrNonPCInfo" runat="server" visible="false">
		                                    <td width='80%' class="TBox">
			                                    <a href="AgreementReport/AgreementNon-PCStockReport.aspx">Agreement Non-PC Product Stock Info.</a></td></tr>
            	                                                    
	                                    <!-- Non Maintenance Report -->
	                                    <tr id="NonMainReport" runat="server" visible="false">
		                                    <td width='80%' class="TBox">
			                                    <a href="AgreementReport/NonMaintenanceReport.aspx">Non-Maintenance Report</a></td></tr>	                                                
                                    </table></td></tr>
                            </table>
                        </div>
                        
                        <div id="EngineerReportBox" runat="server" visible="false"><!-- Engineer Report -->
                            <table border="1" width="300">	                                        
	                            <tr valign="top"><td class="TBox">
	                                <table border="0" width="100%" style="text-align:left; ">
	                                    <tr bgcolor="#add8e6"><th>Engineer Report</th></tr>
                                        <!-- CS Not Check Report -->
                                        <tr id="CSNotCheck" runat="server" visible="false">
			                                <td style="width:250" class="TBox"><a href="EngineerReport/CSNonCheckServiceReport.aspx">CS Not Check Service Report</a></td></tr>
            		                                    
		                                <!-- Engineer Not Complete Report -->
                                        <tr id="EngNotComplete" runat="server" visible="false">
			                                <td style="width:250" class="TBox"><a href="EngineerReport/EngineerNotYetCompleteServiceReport.aspx">Engineer Not Complete Service Report</a></td></tr>
            		                                    
		                                <!-- Engineer Service Report Static -->
	                                    <tr id="EngSerRepSearch" runat="server" visible="false">
			                                <td style="width:250" class="TBox"><a href="EngineerReport/EngineerPerformReportSearch.aspx">Engineer Service Report Static</a></td></tr>
            		                                    
		                                <!-- Engineer Performed Report -->
		                                <tr id="EngPerfReport" runat="server" visible="false">
			                                <td style="width:250" class="TBox"><a href="EngineerReport/EngineerPerformReport.aspx">Engineer Performed Report</a></td></tr>
            		                                    
		                                <!-- Engineer Travel Fare Report -->
                                        <tr id="EngTravelReport" runat="server" visible="false">
			                                <td style="width:250" class="TBox"><a href="EngineerReport/EngineerTravelFareReport.aspx">Engineer Travel Fare Report</a></td></tr>	
	                                </table></td></tr>
                            </table>
                        </div>   
                    </td>
                    <td width="300" valign="top" class="TBox">
                        <div id="NoteReportBox" runat="server" visible="false"><!-- Note Report -->
                            <table border="1" width="300" height="240">
                                <tr valign="top"><td>
	                                        <table border="0" width="100%">
	                                            <tr bgcolor="#add8e6"><th colspan="2">Note Report</th></tr>
	                                            <tr align="left"><td class="TBox" colspan="2"><b>Key Word Search:</b></td></tr>
	                                            <tr align="left"><td class="TBox">Note Number:</td>
			                                        <td class="TBox"><asp:TextBox ID="NoteNo" runat="server" MaxLength="50" onkeypress="javascript:submitNSearch();" TabIndex="14"></asp:TextBox></td>
	                                            </tr>
		                                        <tr align="left"><td class="TBox">Note Hint:</td>
			                                        <td class="TBox"><asp:TextBox ID="NoteHint" runat="server" MaxLength="50" onkeypress="javascript:submitNSearch();" TabIndex="15"></asp:TextBox></td>
	                                            </tr>
	                                            <tr align="left"><td class="TBox">Customer Code:</td>
			                                        <td class="TBox"><asp:TextBox ID="CustomerCode" runat="server" MaxLength="20" onkeypress="javascript:submitNSearch();" TabIndex="16"></asp:TextBox></td>
	                                            </tr>
	                                            <tr align="left"><td class="TBox">Customer Name:</td>
			                                        <td class="TBox"><asp:TextBox ID="ContactCustomerName" runat="server" MaxLength="100" onkeypress="javascript:submitNSearch();" TabIndex="17"></asp:TextBox></td>
	                                            </tr>
	                                            <tr align="left"><td class="TBox">Service Report:</td>
			                                        <td class="TBox"><asp:TextBox ID="ServiceReportNo" runat="server" MaxLength="20" onkeypress="javascript:submitNSearch();" TabIndex="18"></asp:TextBox></td>
	                                            </tr>
	                                            <tr align="left"><td class="TBox">Note Description:</td>
    	                                            <td class="TBox"><asp:TextBox ID="NoteDescription" runat="server" MaxLength="100" onkeypress="javascript:submitNSearch();" TabIndex="19"></asp:TextBox></td>
	                                            </tr>
	                                            <tr><td colspan="2" align='right'><asp:LinkButton ID="btnNote" runat="server" Text="Search" PostBackUrl="NoteReport/NoteList.aspx"></asp:LinkButton></td></tr>
                                            </table>
                                        </td>
                                </tr>
                            </table>
                        </div>
                        
                        <div id="AgreementBox" runat="server" visible="false"> <!-- Agreement Box -->
                            <table border="1" width="300">
                                <tr valign="top"><td>
	                                    <table border="0" width="100%">	                                        
	                                        <tr id="AgrBoxRow1" runat="server" visible="false" bgcolor="#add8e6"><th colspan="2">Agreement Information</th></tr>
                                            <tr id="AgrBoxRow2" runat="server" visible="false">
                                                <td width='100%' class="TBox" align="left">
			                                        <b>Key Word Search:</b><br />
			                                        <asp:TextBox runat="server" ID="AgrKeyWordSearch" MaxLength="100" Width="100px" cssclass="TBox" TabIndex="20" onkeypress="javascript:SearchAgr();"></asp:TextBox>
			                                        <asp:DropDownList ID="AgrSearchList" runat="server" AutoPostBack="false" TabIndex="21">
			                                            <asp:ListItem Text="ALL" Value="ALL"></asp:ListItem>
			                                            <asp:ListItem Text="Agreement No" Selected="True" Value="AgreementNo"></asp:ListItem>
			                                            <asp:ListItem Text="Agreement Type" Value="AgreemenType"></asp:ListItem>
			                                            <asp:ListItem Text="Customer Code" Value="CustomerCode"></asp:ListItem>
			                                            <asp:ListItem Text="Customer name" Value="CustomerName"></asp:ListItem>
			                                            <asp:ListItem Text="Label No" Value="LabelNo"></asp:ListItem>
			                                            <asp:ListItem Text="Model Number" Value="ModelNo"></asp:ListItem>
			                                            <asp:ListItem Text="Serial Number" Value="SerialNo"></asp:ListItem>
			                                            <asp:ListItem Text="Site Name" Value="SiteName"></asp:ListItem>
			                                            <asp:ListItem Text="Support Hours" Value="SupportHours"></asp:ListItem>
			                                        </asp:DropDownList>			                                                   
			                                        <asp:LinkButton ID="btnSearchAgreement" runat="server" Text="Search" causesvalidation="false" OnClientClick="return checkAgField()" PostBackUrl="AgreementInformation/AgreementReportList.aspx"></asp:LinkButton>			
		                                        </td></tr>
	                                        <tr id="AgrBoxRow3" runat="server" visible="false">
		                                        <td class="TBox" align="left" colspan="2"><a href="AgreementInformation/AgreementReportSearch.aspx">Agreement Advance Search</a></td></tr>
	                                                    
	                                        <tr id="AgrBoxRow4" runat="server" visible="false">
			                                    <td class="TBox" align="left" colspan="2" ><a href="AgreementInformation/Agreement.aspx" onclick="return confirmAdd()">Add New Agreement</a></td></tr>
		                                                
		                                    <tr><td class="TBox" align="left" colspan="2">&nbsp;</td></tr>

                                            <!-- Edit Agreement type -->
                                            <tr id="AgrBoxEditAgrType" runat="server" visible="false">
		                                        <td align="left" width="200" class="TBox">
			                                        <a href="AgreementInformation/EditAgreementType.aspx">Edit Agreement Type</a></td></tr>
	                                                    
	                                        <!-- Edit Agreement Machine PC -->
	                                        <tr id="AgrBoxEditAgrPC" runat="server" visible="false">
		                                        <td align="left" width="200" class="TBox">
			                                        <a href="AgreementInformation/AgreementMachine_PCType.aspx">Edit Agreement Machine PC Type</a></td></tr>
	                                        	                                                
                                        </table>
	                                </td>
	                            </tr>
                            </table>                        
                        </div>
                        
                        <div id="SystemReportBox" runat="server" visible="false"><!-- System Report -->
                            <table border="1" width="300">	                                        
	                            <tr valign="top"><td class="TBox">
	                                <table border="0" width="100%" style="text-align:left">
	                                    <tr bgcolor="#add8e6"><th>System Report</th></tr>
	                                    <!-- Service Report Stat., Maintenance Service Analysis Report -->
                                        <tr id="SerRepSta" runat="server" visible="false">
                                            <td style="width:250px" class="TBox"><a href="SystemReport/SRStatisticSearch.aspx">Service Report Statistic</a></td></tr>
                                        <tr id="SysRepSearch" runat="server" visible="false">
                                            <td style="width:250px" class="TBox"><a href="SystemReport/SystemReportSearch.aspx">Maintenance Service Analysis Report</a></td></tr>
            		                    
            		                    <!-- HPIM Report -->
            		                    <tr id="HPIMRow" runat="server" visible="false">
                                            <td style="width:250px" class="TBox"><a href="SystemReport/HPIMReport.aspx">HPIM Report</a></td></tr>
                                                            
		                                <!-- Call Amt Report, Dist Call Amt Report, Case Type Call Amt Report, Service Report Amt Report -->
		                                <tr id="CallAmtReport" runat="server" visible="false">
				                            <td style="width:250px" class="TBox"><a href="SystemReport/CallAmountReport.aspx">Called Amount Report</a></td></tr>
		                                <tr id="DisCallAmtReport" runat="server" visible="false">
			                                <td style="width:250px" class="TBox"><a href="SystemReport/DistrictCallAmountReport.aspx">District Called Amount Report</a></td></tr>
			                            <tr id="CaseTypeAmtReport" runat="server" visible="false">
				                            <td style="width:250px" class="TBox"><a href="SystemReport/CaseTypeCallAmountReport.aspx">Case Type Called Amount Report</a></td></tr>
			                            <tr id="SerRepAmtReport" runat="server" visible="false">
				                            <td style="width:250px" class="TBox"><a href="SystemReport/ServiceReportAmount.aspx">Service Report Amount</a></td></tr>

                                        <!-- Analysis Report -->
		                                <tr id="AnalysisRep" runat="server" visible="false">
			                                <td style="width:250px" class="TBox"><a href="SystemReport/AnalyzingServiceReport.aspx">Analysis Report</a></td></tr> 

                                        <!-- Per Time Report -->
		                                <tr id="PerTimeRep" runat="server" visible="false">
				                            <td style="width:250px" class="TBox"><a href="SystemReport/PerTimeReport.aspx">Per Time Report</a></td></tr>
                                                                                                    	
		                                <!-- Outstanding Report, Service Call Summary, Service Rep Summary, Service Report Return -->
		                                <tr id="OutStandReport" runat="server" visible="false">
				                            <td style="width:250px" class="TBox"><a href="SystemReport/OutstandingReport.aspx">OutStanding Report</a></td></tr>
			                            <tr id="SerCallSummary" runat="server" visible="false">
				                            <td style="width:250px" class="TBox"><a href="SystemReport/ServiceCallSummary.aspx">Service Call Summary</a></td></tr>
			                            <tr id="SerRepSummary" runat="server" visible="false">
				                            <td style="width:250px" class="TBox"><a href="SystemReport/ServiceReportSummary.aspx">Service Report Summary</a></td></tr>			                                
			                            <tr id="SerRepReturn" runat="server" visible="false">
				                            <td style="width:250px" class="TBox"><a href="SystemReport/SRReturnProductSearch.aspx">Service Report Return Products Report</a></td></tr>
				                            
				                        <!-- SLA Report -->
		                                <tr id="SLAReport" runat="server" visible="false">
				                            <td style="width:250px" class="TBox"><asp:HyperLink ID="SLALink" runat="server" Text="SLA Report"></asp:HyperLink></td></tr>
				                            
				                       <!-- Note without PD -->
				                       <tr id="NOPDReport" runat="server" visible="false">
				                            <td style="width:250px" class="TBox"><asp:HyperLink ID="NoteNOPDLink" runat="server" NavigateUrl="SystemReport/NoteWithNOPD.aspx" Text="Note without PD number Report"></asp:HyperLink></td></tr>
			                        </table></td></tr>
                            </table>
                        </div>
                    </td></tr>               
            </table>            
        </center>        
               
        <center>
            <table border="0" cellpadding="0" cellspacing="0" width="760" id="blankReportTable" runat="server">
                <tr><td colspan="2">&nbsp;</td></tr>
                <tr>
                    <td><asp:DropDownList ID="NoteList" runat="server" AutoPostBack="false">
                            <asp:ListItem Text="Collection Note" Value="CN"></asp:ListItem>
			                <asp:ListItem Text="Delivery Order" Value="DO"></asp:ListItem>
			                <asp:ListItem Text="Loan Note" Value="LN"></asp:ListItem>
			                <asp:ListItem Text="Replace Note" Value="RN"></asp:ListItem>                            
                        </asp:DropDownList>
                        <asp:LinkButton ID="btnViewNote" runat="server" Text="Blank HP Note"></asp:LinkButton>&nbsp;&nbsp;
                        <asp:LinkButton ID="btnViewNMNote" runat="server" Text="Blank NM Note"></asp:LinkButton>&nbsp;&nbsp;</td>
                    <td><asp:DropDownList ID="blankFormList" runat="server" AutoPostBack="false"></asp:DropDownList>
                        <asp:LinkButton ID="btnViewForm" runat="server" Text="Blank Service Report"></asp:LinkButton>
                        &nbsp;&nbsp;&nbsp;
                        <a href ="document\NMbnghandbookVersion_2_20100217.pdf" target="_blank" runat="server" id="BNGHandBook" >Hand Book</a>
                    </td>                    
                </tr>              
            </table>
        </center>
    </div>
    </form>
</body>
</html>

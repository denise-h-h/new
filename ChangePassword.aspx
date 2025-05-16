<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ChangePassword.aspx.vb" Inherits="ChangePassword" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script language="javascript" type ="text/javascript">
    
    function startForm(){
        window.status = "Change Password";
        document.form1.UserName.focus();
    }
    
    function validate_form()
    {
        var chkEmptyLogin=(document.getElementById("<%=UserName.ClientID%>").value.split(" ").join(""))
        var chkEmptyOld=(document.getElementById("<%=oldPwd.ClientID%>").value.split(" ").join(""))
        var chkEmptyPwd=(document.getElementById("<%=newPwd.ClientID%>").value.split(" ").join(""))
        var chkEmptyPwdC=(document.getElementById("<%=confirmNewPwd.ClientID%>").value.split(" ").join("")) 
        var logName=document.getElementById("<%=UserName.ClientID%>").value
        var oldPwd=document.getElementById("<%=oldPwd.ClientID%>").value
        var logPwd=document.getElementById("<%=newPwd.ClientID%>").value
        var logCon=document.getElementById("<%=confirmNewPwd.ClientID%>").value
        
        if ((chkEmptyLogin.length == 0) || (chkEmptyOld.length == 0) || (chkEmptyPwd.length == 0) || (chkEmptyPwdC.length == 0))
        {    
            alert("Please enter all the fields before processing");              
            document.getElementById("<%=UserName.ClientID%>").focus();
            return false;
        }
        if (chkEmptyLogin.length > 0)
        {
            if (logName.indexOf("<") >=0 || logName.indexOf("!") >=0 || logName.indexOf("text/javascript") >=0 || logName.indexOf("=") >=0 || 
                logName.indexOf(">") >=0 || logName.indexOf("select") >=0 || logName.indexOf("@") >=0 || logName.indexOf("?") >=0 ||
                logName.indexOf(",") >=0 || logName.indexOf("'") >=0 || logName.indexOf("*") >=0 || logName.indexOf("table") >=0 ||
                logName.indexOf("insert") >=0 || logName.indexOf("update") >=0 || logName.indexOf("where") >=0 || logName.indexOf("#") >=0 ||
                logName.indexOf("delete") >=0 || logName.indexOf("drop") >=0)
            {
                alert("Any script type language or '<' symbol is not allowed here, please re-enter");
                document.getElementById("<%=UserName.ClientID%>").value = "";
                document.getElementById("<%=UserName.ClientID%>").focus();
                return false;
            }
        }
        if (logPwd != logCon)
        {
            alert("Confirm Password does not match with Password, please re-enter");
            document.getElementById("<%=newPwd.ClientID%>").focus();            
            return false;
        }              
    }
    
    function submitForm(){
        if (window.event.keyCode==13){                                  
            if (validate_form() == false) {                
            }else{
                __doPostBack('btnConfirm', '');
            }                        
        }
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=950" />
    <meta http-equiv="Content-Type" content="text/html; charset=big5" />
    <title>Nationmark. Call Checking System - Change Password</title>
    <link rel="stylesheet" type="text/css" href="Css/default.css" />
</head>
<body background="images/Bg-0064.gif" bgcolor="white" text="#000000" onload="javascript:startForm();">
    <form id="form1" runat="server">
    <div>
        <table border="0" cellpadding="0" cellspacing="0" width="660">
            <tr>
                <td class='TBox' valign="top" width="500">
                    <h1><b>Nationmark.</b></h1>
                    <h3><u>CALL CHECKING SYSTEM</u></h3>
	            </td>
                <td class='TBox' width="160">
                    <a href="Login.aspx"><img src="images/Nmark.gif" alt="Nationmark (H.K.) Ltd." border="0" width="144" height="80" /></a></td>
            </tr>
        </table>
        <hr />
        <br />
        
        <div align="center">
            <table border="1" width="660" cellpadding="2" bgcolor="Silver" cellspacing="0" style="text-align:left" bordercolordark="#ffffff" bordercolorlight="#cccccc">
	            <tr><td bordercolordark="#ffffff" bordercolorlight="#cccccc" class="TBox">Change Password:</td>
	                <td bordercolordark="#ffffff" bordercolorlight="#cccccc">&nbsp;</td></tr>
		        <tr><td bordercolordark="#ffffff" bordercolorlight="#cccccc" class="TBox">Please Enter User Name:</td>
			        <td bordercolordark="#ffffff" bordercolorlight="#cccccc" class="TBox"><asp:TextBox ID="UserName" name="UserName" runat="server" MaxLength="20"></asp:TextBox></td>
		        </tr>
	            <tr>
		            <td bordercolordark="#ffffff" bordercolorlight="#cccccc" class="TBox">Please Enter Old Password:</td>
		            <td bordercolordark="#ffffff" bordercolorlight="#cccccc" class="TBox"><asp:TextBox ID="oldPwd" runat="server" MaxLength="20" TextMode="Password"></asp:TextBox></td>
	            </tr>	
	            <tr>
		            <td bordercolordark="#ffffff" bordercolorlight="#cccccc" class="TBox">Please Enter New Password:</td>
		            <td bordercolordark="#ffffff" bordercolorlight="#cccccc" class="TBox"><asp:TextBox ID="newPwd" runat="server" MaxLength="20" TextMode="Password"></asp:TextBox></td>
	            </tr>	
	            <tr>
		            <td bordercolordark="#ffffff" bordercolorlight="#cccccc" class="TBox">Re-Enter New Password:</td>
		            <td bordercolordark="#ffffff" bordercolorlight="#cccccc" class="TBox"><asp:TextBox ID="confirmNewPwd" runat="server" MaxLength="20" TextMode="Password" onkeypress="javascript:submitForm();"></asp:TextBox></td>
	            </tr>
	            <tr>
	                <td bordercolordark="#ffffff" bordercolorlight="#cccccc" colspan="2" class="TBox">
	                    <asp:linkbutton ID="btnConfirm" runat="server" Text="Confirm" CausesValidation="false" OnClientClick="return validate_form()"></asp:linkbutton>
		                <a href="javascript:window.history.back();">Cancel</a>
		            </td>
	            </tr>
            </table>
        </div>


    </div>
    </form>
</body>
</html>

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="LibraryManagement.Librarian.Default" %>

<%@ Register Src="~/controller/header.ascx" TagPrefix="uc1" TagName="header" %>
<%@ Register Src="~/controller/menu.ascx" TagPrefix="uc1" TagName="menu" %>



<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Library Management System</title>
    <link href="../css/bootstrap.css" rel="stylesheet" />
    <link href="../css/style.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <uc1:menu runat="server" ID="menu" />
        <uc1:header runat="server" id="header" />
    </form>
    <script src="../js/jquery-3.2.1.js"></script>
    <script src="../js/bootstrap.js"></script>
</body>
</html>

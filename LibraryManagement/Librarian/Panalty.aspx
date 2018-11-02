<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Panalty.aspx.cs" Inherits="LibraryManagement.Librarian.Panalty" %>

<%@ Register Src="~/controller/menu.ascx" TagPrefix="uc1" TagName="menu" %>
<%@ Register Src="~/controller/header.ascx" TagPrefix="uc1" TagName="header" %>



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
        <uc1:header runat="server" ID="header" />
        <div>
        </div>
    </form>
    <script src="../js/jquery-3.2.1.js"></script>
    <script src="../js/bootstrap.js"></script>
</body>
</html>

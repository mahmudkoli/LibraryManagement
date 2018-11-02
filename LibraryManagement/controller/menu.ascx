<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="menu.ascx.cs" Inherits="LibraryManagement.controller.menu" %>

<%--<nav class="navbar navbar-expand-lg navbar-light" style="background-color: red;">--%>
<div class="fixed-top">
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <a class="navbar-brand" href="#">Library</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item">
                    <a class="nav-link" href="../Librarian/Student.aspx">Student</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="../Librarian/Book.aspx">Book</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="../Librarian/Report.aspx">Report</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="../Librarian/Panalty.aspx">Panalty</a>
                </li>
            </ul>
            <span class="navbar-text" style="padding-top: 0; padding-bottom: 0;">
                <a class="nav-link" style="padding-left: 0; padding-right: 0;" href="../Librarian/Logout.aspx">Logout</a>
            </span>
        </div>
    </nav>
</div>

<div style="margin-bottom:56px;"></div>

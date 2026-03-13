<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm2.aspx.cs" Inherits="ProiectBI.WebForm2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Sesiuni Coaching</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f7f6;
            margin: 0;
        }

        .wrapper {
            display: flex;
            width: 100%;
            min-height: 100vh;
        }

        #sidebar {
            min-width: 250px;
            background: #2c3e50;
            color: #fff;
        }

        .sidebar-header {
            padding: 20px;
            background: #1a252f;
            text-align: center;
        }

        .components {
            list-style: none;
            padding: 20px 0;
            margin: 0;
        }

            .components li a {
                padding: 15px 25px;
                display: block;
                color: #bdc3c7;
                text-decoration: none;
            }

                .components li a:hover {
                    color: #fff;
                    background: #34495e;
                }

        .main-container {
            flex-grow: 1;
            padding: 40px;
        }

        .grid-modern {
            width: 100%;
            border-collapse: collapse;
            background: #fff;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }

            .grid-modern th {
                background: #e67e22;
                color: white;
                padding: 15px;
                text-align: left;
            }

            .grid-modern td {
                padding: 12px 15px;
                border-bottom: 1px solid #eee;
            }

        .card-style {
            background: #fff;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }

        .btn-style {
            background: #e67e22;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="wrapper">
            <nav id="sidebar">
                <div class="sidebar-header">
                    <h3>Coaching App</h3>
                </div>
                <ul class="components">
                    <li><a href="WebForm1.aspx">Clienti</a></li>
                    <li><a href="WebForm2.aspx">Sesiuni Coaching</a></li>
                    <li><a href="WebForm3.aspx">Inscrieri</a></li>
                    <li><a href="WebForm4.aspx">Obiective</a></li>
                    <li><a href="WebForm5.aspx">Statistici</a></li>
                </ul>
            </nav>

            <div class="main-container">
                <h2>Programări Sesiuni</h2>

                <asp:GridView ID="gvSesiuni" runat="server" CssClass="grid-modern"
                    AutoGenerateColumns="False" OnRowCommand="gvSesiuni_RowCommand" DataKeyNames="id_sesiune">
                    <Columns>
                        <asp:BoundField DataField="id_sesiune" HeaderText="ID" />
                        <asp:BoundField DataField="titlu_sesiune" HeaderText="Titlu" />
                        <asp:BoundField DataField="tip_coaching" HeaderText="Tip" />
                        <asp:BoundField DataField="data_programata" HeaderText="Data" DataFormatString="{0:dd/MM/yyyy}" />

                        <asp:TemplateField HeaderText="Acțiuni">
                            <ItemTemplate>
                                <asp:Button ID="btnDelete" runat="server" Text="Șterge"
                                    CommandName="StergeSesiune"
                                    CommandArgument='<%# Eval("id_sesiune") %>'
                                    CssClass="btn-style"
                                    OnClientClick="return confirm('Sigur vrei să ștergi această sesiune?');"
                                    Style="background-color: #e74c3c;" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>

                <div class="card-style">
                    <h3>Sesiune Nouă</h3>
                    Titlu:
                    <asp:TextBox ID="txtTitlu" runat="server"></asp:TextBox>
                    <br />
                    <br />
                    Tip:
                    <asp:DropDownList ID="ddlTip" runat="server">
                        <asp:ListItem>Individual</asp:ListItem>
                        <asp:ListItem>Grup</asp:ListItem>
                        <asp:ListItem>Business</asp:ListItem>
                    </asp:DropDownList>
                    <br />
                    <br />
                    Data:
                    <asp:TextBox ID="txtDataSes" runat="server" TextMode="Date"></asp:TextBox>
                    <br />
                    <br />

                    <asp:Button ID="btnSalvareSes" runat="server" Text="Adaugă Sesiune"
                        OnClick="btnSalvareSes_Click" CssClass="btn-style" />
                </div>
            </div>
        </div>
    </form>
</body>
</html>

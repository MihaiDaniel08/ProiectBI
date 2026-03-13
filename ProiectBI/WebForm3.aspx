<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm3.aspx.cs" Inherits="ProiectBI.WebForm3" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Înscriere Participanți</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f7f6;
            margin: 0;
            display: flex;
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

        .card-inscription {
            background: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            max-width: 600px;
        }

        .grid-modern {
            width: 100%;
            border-collapse: collapse;
            background: #fff;
            border-radius: 8px;
            margin-top: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }

            .grid-modern th {
                background: #9b59b6;
                color: white;
                padding: 12px;
            }

            .grid-modern td {
                padding: 10px;
                border-bottom: 1px solid #eee;
                text-align: center;
            }

        .form-control {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .btn-purple {
            background: #9b59b6;
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
            width: 100%;
        }

            .btn-purple:hover {
                background: #8e44ad;
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
                <h2>Gestionare Participanti Sesiuni</h2>

                <div class="card-inscription">
                    <h3>Înscrie Client la Sesiune</h3>

                    Selecteaza Client:
                   
                    <asp:DropDownList ID="ddlClienti" runat="server" CssClass="form-control"></asp:DropDownList>

                    Selecteaza Sesiune:
                   
                    <asp:DropDownList ID="ddlSesiuni" runat="server" CssClass="form-control"></asp:DropDownList>

                    Status Prezenta:
                   
                    <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control">
                        <asp:ListItem>Confirmat</asp:ListItem>
                        <asp:ListItem>In asteptare</asp:ListItem>
                    </asp:DropDownList>

                    <asp:Button ID="btnInscrie" runat="server" Text="Finalizează Înscriere"
                        OnClick="btnInscrie_Click" CssClass="btn-purple" />

                    <asp:Label ID="lblInfo" runat="server" ForeColor="Green" Style="display: block; margin-top: 10px;"></asp:Label>
                </div>

                <h3 style="margin-top: 40px;">Lista Inscrierilor Actuale</h3>
                <asp:GridView ID="gvParticipanti" runat="server" CssClass="grid-modern"
                    AutoGenerateColumns="False" OnRowCommand="gvParticipanti_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="Client" HeaderText="Nume Client" />
                        <asp:BoundField DataField="Sesiune" HeaderText="Titlu Sesiune" />
                        <asp:BoundField DataField="status_prezenta" HeaderText="Status" />

                        <asp:TemplateField HeaderText="Acțiuni">
                            <ItemTemplate>
                                <asp:Button ID="btnDeleteParticipare" runat="server" Text="Anulează Înscrierea"
                                    CommandName="StergeParticipare"
                                    CommandArgument='<%# Eval("id_client") + ";" + Eval("id_sesiune") %>'
                                    CssClass="btn-purple"
                                    Style="background-color: #e74c3c;"
                                    OnClientClick="return confirm('Sigur doriți să anulați înscrierea acestui client?');" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </form>
</body>
</html>

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm4.aspx.cs" Inherits="ProiectBI.WebForm4" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Obiective și Progres</title>
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

        .grid-master {
            width: 100%;
            border-collapse: collapse;
            background: #fff;
            margin-bottom: 20px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }

            .grid-master th {
                background: #1abc9c;
                color: white;
                padding: 12px;
            }

        .grid-detail {
            width: 100%;
            border-collapse: collapse;
            background: #fff;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

            .grid-detail th {
                background: #34495e;
                color: white;
                padding: 10px;
            }

        .selected-row {
            background-color: #e8f8f5 !important;
            font-weight: bold;
        }

        .card-style {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            margin-top: 20px;
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
                <h2>Obiective Clienti</h2>

                <asp:GridView ID="gvObiective" runat="server" CssClass="grid-master"
                    AutoGenerateColumns="False" DataKeyNames="id_obiectiv"
                    OnSelectedIndexChanged="gvObiective_SelectedIndexChanged">
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" SelectText="Detalii Progres" />
                        <asp:BoundField DataField="nume" HeaderText="Client" />
                        <asp:BoundField DataField="titlu_obiectiv" HeaderText="Obiectiv" />
                        <asp:BoundField DataField="valoare_tinta" HeaderText="Tinta (Numeric)" />
                    </Columns>
                    <SelectedRowStyle CssClass="selected-row" />
                </asp:GridView>

                <div id="divProgres" runat="server" visible="false" class="card-style">
                    <h3>Evoluție Progres (Tabel 5)</h3>

                    <asp:GridView ID="gvProgres" runat="server" CssClass="grid-detail"
                        AutoGenerateColumns="False" DataKeyNames="id_progres"
                        OnRowDeleting="gvProgres_RowDeleting">
                        <Columns>
                            <asp:BoundField DataField="data_masurare" HeaderText="Data Măsurării" DataFormatString="{0:dd/MM/yyyy}" />
                            <asp:BoundField DataField="valoare_atinsa" HeaderText="Valoare Atinsă" />

                            <asp:TemplateField HeaderText="Acțiuni">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnDeleteProgres" runat="server" CommandName="Delete"
                                        Text="Șterge" ForeColor="Red"
                                        OnClientClick="return confirm('Sigur doriți să ștergeți această înregistrare de progres?');" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>

                    <hr />
                    <h4>Adaugă Măsurătoare Nouă:</h4>
                    Valoare Atinsă:
                    <asp:TextBox ID="txtValoare" runat="server" TextMode="Number" step="any" min="0"></asp:TextBox>
                    <asp:Button ID="btnAdaugaProgres" runat="server" Text="Înregistrează Progres"
                        OnClick="btnAdaugaProgres_Click" CssClass="btn-style" Style="background-color: #1abc9c;" />
                </div>
            </div>
        </div>
    </form>
</body>
</html>

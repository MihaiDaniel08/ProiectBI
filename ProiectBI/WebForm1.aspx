<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="ProiectBI.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
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
                transition: 0.3s;
            }

                .components li a:hover {
                    color: #fff;
                    background: #34495e;
                    padding-left: 30px;
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
            border: none;
        }

            .grid-modern th {
                background: #3498db;
                color: white;
                padding: 15px;
                text-align: left;
            }

            .grid-modern td {
                padding: 12px 15px;
                border-bottom: 1px solid #eee;
            }

            .grid-modern tr:hover {
                background: #f9f9f9;
            }

        .card-style {
            background: #fff;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }

        .btn-style {
            background: #27ae60;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
        }

            .btn-style:hover {
                background: #219150;
            }

        .btn-stats {
            background-color: #3498db;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
            transition: 0.3s;
            margin-right: 15px;
        }

            .btn-stats:hover {
                background-color: #2980b9;
            }

        .label-stats {
            font-size: 1rem;
            color: #2c3e50;
            font-weight: 600;
            padding: 10px;
            background-color: #ecf0f1;
            border-left: 4px solid #3498db;
            border-radius: 4px;
            display: inline-block;
            vertical-align: middle;
        }
    </style>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div class="wrapper">
            <nav id="sidebar">
                <div class="sidebar-header">
                    <h3>Coaching App</h3>
                </div>
                <ul class="list-unstyled components">
                    <li><a href="WebForm1.aspx">Clienti</a></li>
                    <li><a href="WebForm2.aspx">Sesiuni Coaching</a></li>
                    <li><a href="WebForm3.aspx">Inscrieri</a></li>
                    <li><a href="WebForm4.aspx">Obiective</a></li>
                    <li><a href="WebForm5.aspx">Statistici</a></li>
                </ul>
            </nav>

            <div class="main-container">
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:biDatabaseConnectionString2 %>" DeleteCommand="DELETE FROM [Clienti] WHERE [id_client] = @id_client" InsertCommand="INSERT INTO [Clienti] ([nume], [email]) VALUES (@nume, @email)" ProviderName="<%$ ConnectionStrings:biDatabaseConnectionString2.ProviderName %>" SelectCommand="SELECT * FROM [Clienti]" UpdateCommand="UPDATE [Clienti] SET [nume] = @nume, [email] = @email WHERE [id_client] = @id_client">
                    <DeleteParameters>
                        <asp:Parameter Name="id_client" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="nume" Type="String" />
                        <asp:Parameter Name="email" Type="String" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="nume" Type="String" />
                        <asp:Parameter Name="email" Type="String" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <asp:GridView ID="GridView1" runat="server" DataKeyNames="id_client"
                    DataSourceID="SqlDataSource1" CssClass="grid-modern"
                    AutoGenerateColumns="False">
                    <Columns>
                        <asp:BoundField DataField="id_client" HeaderText="ID" ReadOnly="True" />
                        <asp:BoundField DataField="nume" HeaderText="Nume Client" />
                        <asp:BoundField DataField="email" HeaderText="Email" />
                        <asp:BoundField DataField="data_aderare" HeaderText="Data Inscriere"
                            ReadOnly="True" DataFormatString="{0:dd/MM/yyyy}" />

                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" CausesValidation="false" />
                    </Columns>
                </asp:GridView>

                <div class="card-style">
                    <h3>Adauga Client Nou</h3>

                    Nume:
                    <asp:TextBox ID="txtNumeNou" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvNume" runat="server" ControlToValidate="txtNumeNou"
                        ErrorMessage="Numele este obligatoriu!" ForeColor="Red" ValidationGroup="GrupAdaugare" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revNumeLitere" runat="server" ControlToValidate="txtNumeNou"
                        ErrorMessage="Folosiți doar litere!" ForeColor="Red" ValidationGroup="GrupAdaugare" Display="Dynamic"
                        ValidationExpression="^[a-zA-Z\săâîșțĂÂÎȘȚ]+$"></asp:RegularExpressionValidator>

                    <br />
                    <br />

                    Email:
                    <asp:TextBox ID="txtEmailNou" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmailNou"
                        ErrorMessage="Email-ul este obligatoriu!" ForeColor="Red" ValidationGroup="GrupAdaugare" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revEmailFormat" runat="server" ControlToValidate="txtEmailNou"
                        ErrorMessage="Format email invalid!" ForeColor="Red" ValidationGroup="GrupAdaugare" Display="Dynamic"
                        ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>

                    <br />
                    <br />

                    <asp:Button ID="btnAdauga" runat="server" Text="Salvează Client"
                        OnClick="btnAdauga_Click" ValidationGroup="GrupAdaugare" CssClass="btn-style" />
                    <asp:Button ID="btnStatistica" runat="server" Text="Calculează Total Clienți"
                        OnClick="btnStatistica_Click" CssClass="btn-stats" />

                    <asp:Label ID="lblTotal" runat="server" Text="Apasă butonul pentru statistici"
                        Style="margin-left: 10px; font-weight: bold;"></asp:Label>
                </div>
            </div>
        </div>
    </form>
</body>
</html>

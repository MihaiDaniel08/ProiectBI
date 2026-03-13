<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm5.aspx.cs" Inherits="ProiectBI.WebForm5" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Dashboard Statistici & Rapoarte</title>
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

        .dashboard-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .card-full {
            grid-column: 1 / span 2;
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }

        .card-half {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            text-align: center;
        }

        .btn-report {
            background: #3498db;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
        }

        .grid-raport {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }

            .grid-raport th {
                background: #34495e;
                color: white;
                padding: 10px;
            }

            .grid-raport td {
                padding: 8px;
                border-bottom: 1px solid #eee;
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
                <h2>Dashboard Analitic</h2>

                <div class="dashboard-grid">

                    <div class="card-full">
                        <h3>Raport Status Clienti</h3>
                        <asp:Button ID="btnRuleazaRaport" runat="server" Text="Genereaza Raport cu Cursor"
                            OnClick="btnRuleazaRaport_Click" CssClass="btn-report" />
                        <asp:GridView ID="gvRaport" runat="server" CssClass="grid-raport" Visible="false"></asp:GridView>
                    </div>

                    <div class="card-half">
                        <h3>Performanta Client</h3>
                        Selectează Client: 
                       
                        <asp:DropDownList ID="ddlClienti" runat="server" AutoPostBack="true"
                            OnSelectedIndexChanged="ddlClienti_SelectedIndexChanged">
                        </asp:DropDownList>
                        <br />
                        <br />
                        <div style="font-size: 1.5rem; color: #27ae60;">
                            Media Progres:
                            <asp:Label ID="lblMedie" runat="server" Text="0.00"></asp:Label>%
                       
                        </div>
                    </div>

                    <div class="card-half">
                        <h3>Tipuri de Coaching</h3>
                        <asp:Chart ID="ChartSesiuni" runat="server" Width="350px">
                            <Series>
                                <asp:Series Name="Series1" ChartType="Pie"></asp:Series>
                            </Series>
                            <ChartAreas>
                                <asp:ChartArea Name="ChartArea1"></asp:ChartArea>
                            </ChartAreas>
                        </asp:Chart>
                    </div>

                    <div class="card-full">
                        <h3>Obiective active per Client</h3>
                        <asp:Chart ID="ChartObiective" runat="server" Width="700px" Height="300px">
                            <Series>
                                <asp:Series Name="Series1" ChartType="Column" Color="#1abc9c"></asp:Series>
                            </Series>
                            <ChartAreas>
                                <asp:ChartArea Name="ChartArea1"></asp:ChartArea>
                            </ChartAreas>
                        </asp:Chart>
                    </div>

                </div>
            </div>
        </div>
    </form>
</body>
</html>

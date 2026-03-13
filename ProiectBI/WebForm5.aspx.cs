using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProiectBI
{
    public partial class WebForm5 : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["biDatabaseConnectionString2"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                IncarcaGrafice();
                PopuleazaDdlClienti();
            }
        }
        protected void btnRuleazaRaport_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlCommand cmd = new SqlCommand("RaportStatusClienti", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvRaport.DataSource = dt;
                gvRaport.DataBind();
                gvRaport.Visible = true;
                IncarcaGrafice();
            }
        }
        protected void ddlClienti_SelectedIndexChanged(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "SELECT dbo.GetMedieProgresClient(@id)";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@id", ddlClienti.SelectedValue);

                conn.Open();
                object result = cmd.ExecuteScalar();
                lblMedie.Text = result != null ? result.ToString() : "0.00";
                IncarcaGrafice();
            }
        }

        private void PopuleazaDdlClienti()
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT id_client, nume FROM Clienti", conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                ddlClienti.DataSource = dt;
                ddlClienti.DataTextField = "nume";
                ddlClienti.DataValueField = "id_client";
                ddlClienti.DataBind();
            }
        }

        private void IncarcaGrafice()
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlDataAdapter da1 = new SqlDataAdapter("SELECT tip_coaching, COUNT(*) as Total FROM Sesiuni GROUP BY tip_coaching", conn);
                DataTable dt1 = new DataTable(); da1.Fill(dt1);
                ChartSesiuni.DataSource = dt1;
                ChartSesiuni.Series["Series1"].XValueMember = "tip_coaching";
                ChartSesiuni.Series["Series1"].YValueMembers = "Total";

                string q2 = "SELECT C.nume, COUNT(O.id_obiectiv) as Nr FROM Clienti C LEFT JOIN Obiective O ON C.id_client = O.id_client GROUP BY C.nume";
                SqlDataAdapter da2 = new SqlDataAdapter(q2, conn);
                DataTable dt2 = new DataTable(); da2.Fill(dt2);
                ChartObiective.DataSource = dt2;
                ChartObiective.Series["Series1"].XValueMember = "nume";
                ChartObiective.Series["Series1"].YValueMembers = "Nr";

                this.DataBind();
            }
        }
    }
}
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
    public partial class WebForm2 : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["biDatabaseConnectionString2"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                IncarcaSesiuni();
            }
        }

        private void IncarcaSesiuni()
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "SELECT id_sesiune, titlu_sesiune, tip_coaching, data_programata FROM Sesiuni";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();

                da.Fill(dt);

                gvSesiuni.DataSource = dt;
                gvSesiuni.DataBind();
            }
        }

        protected void btnSalvareSes_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "INSERT INTO Sesiuni (titlu_sesiune, tip_coaching, data_programata) VALUES (@titlu, @tip, @data)";
                SqlCommand cmd = new SqlCommand(query, conn);

                cmd.Parameters.AddWithValue("@titlu", txtTitlu.Text);
                cmd.Parameters.AddWithValue("@tip", ddlTip.SelectedValue);
                cmd.Parameters.AddWithValue("@data", txtDataSes.Text);

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();

                IncarcaSesiuni();

                txtTitlu.Text = "";
            }
        }

        protected void gvSesiuni_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "StergeSesiune")
            {
                int idSesiune = Convert.ToInt32(e.CommandArgument);
                StergeSesiuneDinBaza(idSesiune);
            }
        }

        private void StergeSesiuneDinBaza(int id)
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "DELETE FROM Sesiuni WHERE id_sesiune = @id";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@id", id);

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();

                    IncarcaSesiuni();
                }
                catch (Exception)
                {
                    Response.Write("<script>alert('Nu se poate șterge: Sesiunea are participanți înscriși!');</script>");
                }
            }
        }
    }
}
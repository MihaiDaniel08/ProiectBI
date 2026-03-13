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
    public partial class WebForm4 : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["biDatabaseConnectionString2"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                IncarcaObiective();
            }
        }

        private void IncarcaObiective()
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                // Join între Clienti și Obiective folosind id_client
                string query = @"SELECT O.id_obiectiv, C.nume, O.titlu_obiectiv, O.valoare_tinta 
                                FROM Obiective O JOIN Clienti C ON O.id_client = C.id_client";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvObiective.DataSource = dt;
                gvObiective.DataBind();
            }
        }

        protected void gvObiective_SelectedIndexChanged(object sender, EventArgs e)
        {
            divProgres.Visible = true;
            IncarcaProgres();
        }

        private void IncarcaProgres()
        {
            int idObiectiv = Convert.ToInt32(gvObiective.SelectedValue);
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "SELECT id_progres, data_masurare, valoare_atinsa FROM Progres WHERE id_obiectiv = @id ORDER BY data_masurare DESC";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@id", idObiectiv);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvProgres.DataSource = dt;
                gvProgres.DataBind();
            }
        }

        protected void btnAdaugaProgres_Click(object sender, EventArgs e)
        {
            if (gvObiective.SelectedValue == null) return;

            int idObiectiv = Convert.ToInt32(gvObiective.SelectedValue);
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "INSERT INTO Progres (id_obiectiv, data_masurare, valoare_atinsa) VALUES (@id, GETDATE(), @valoare)";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@id", idObiectiv);

                decimal valoareZecimala;
                if (decimal.TryParse(txtValoare.Text.Replace(',', '.'),
                    System.Globalization.NumberStyles.Any,
                    System.Globalization.CultureInfo.InvariantCulture,
                    out valoareZecimala))
                {
                    cmd.Parameters.AddWithValue("@valoare", valoareZecimala);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@valoare", 0);
                }

                conn.Open();
                cmd.ExecuteNonQuery();

                txtValoare.Text = "";
                IncarcaProgres();
            }
        }

        protected void gvProgres_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int idProgres = Convert.ToInt32(gvProgres.DataKeys[e.RowIndex].Value);

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "DELETE FROM Progres WHERE id_progres = @id";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@id", idProgres);

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }

            IncarcaProgres();
        }
    }
}


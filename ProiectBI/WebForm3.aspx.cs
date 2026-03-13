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
    public partial class WebForm3 : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["biDatabaseConnectionString2"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PopuleazaListe();
                IncarcaTabelParticipanti();
            }
        }
        private void PopuleazaListe()
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlCommand cmdC = new SqlCommand("SELECT id_client, nume FROM Clienti", conn);
                conn.Open();
                ddlClienti.DataSource = cmdC.ExecuteReader();
                ddlClienti.DataTextField = "nume";
                ddlClienti.DataValueField = "id_client";
                ddlClienti.DataBind();
                conn.Close();

                SqlCommand cmdS = new SqlCommand("SELECT id_sesiune, titlu_sesiune FROM Sesiuni", conn);
                conn.Open();
                ddlSesiuni.DataSource = cmdS.ExecuteReader();
                ddlSesiuni.DataTextField = "titlu_sesiune";
                ddlSesiuni.DataValueField = "id_sesiune";
                ddlSesiuni.DataBind();
                conn.Close();
            }
        }

        private void IncarcaTabelParticipanti()
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = @"SELECT P.id_client, P.id_sesiune, C.nume AS [Client], 
                                S.titlu_sesiune AS [Sesiune], P.status_prezenta 
                        FROM Participanti_sesiune P
                        JOIN Clienti C ON P.id_client = C.id_client
                        JOIN Sesiuni S ON P.id_sesiune = S.id_sesiune";

                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvParticipanti.DataSource = dt;
                gvParticipanti.DataBind();
            }
        }

        protected void btnInscrie_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "INSERT INTO Participanti_sesiune (id_client, id_sesiune, status_prezenta) VALUES (@idC, @idS, @status)";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@idC", ddlClienti.SelectedValue);
                cmd.Parameters.AddWithValue("@idS", ddlSesiuni.SelectedValue);
                cmd.Parameters.AddWithValue("@status", ddlStatus.SelectedValue);

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    lblInfo.Text = "Înscriere realizată cu succes!";
                    IncarcaTabelParticipanti();
                }
                catch (Exception)
                {
                    lblInfo.Text = "Eroare: Clientul este deja înscris la această sesiune!";
                    lblInfo.ForeColor = System.Drawing.Color.Red;
                }
            }
        }

        private void StergeParticipareDinBaza(int idC, int idS)
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "DELETE FROM Participanti_sesiune WHERE id_client = @idC AND id_sesiune = @idS";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@idC", idC);
                cmd.Parameters.AddWithValue("@idS", idS);

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    lblInfo.Text = "Înscriere anulată cu succes!";
                    lblInfo.ForeColor = System.Drawing.Color.Orange;
                    IncarcaTabelParticipanti();
                }
                catch (Exception ex)
                {
                    lblInfo.Text = "Eroare la ștergere: " + ex.Message;
                    lblInfo.ForeColor = System.Drawing.Color.Red;
                }
            }
        }

        protected void gvParticipanti_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "StergeParticipare")
            {
                // Extragem cele două ID-uri din argumentul concatenat (id_client;id_sesiune)
                string[] argumente = e.CommandArgument.ToString().Split(';');
                int idClient = Convert.ToInt32(argumente[0]);
                int idSesiune = Convert.ToInt32(argumente[1]);

                StergeParticipareDinBaza(idClient, idSesiune);
            }
        }
    }
}
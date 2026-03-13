using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProiectBI
{
	public partial class WebForm1 : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{

		}

        protected void btnAdauga_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    SqlDataSource1.InsertParameters["nume"].DefaultValue = txtNumeNou.Text;
                    SqlDataSource1.InsertParameters["email"].DefaultValue = txtEmailNou.Text;

                    SqlDataSource1.Insert();

                    txtNumeNou.Text = "";
                    txtEmailNou.Text = "";
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('Eroare la salvare: " + ex.Message + "');</script>");
                }
            }
        }

        protected void btnStatistica_Click(object sender, EventArgs e)
        {
            string connString = System.Configuration.ConfigurationManager.ConnectionStrings["biDatabaseConnectionString2"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlCommand cmd = new SqlCommand("GetTotalClienti", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                SqlParameter totalParam = new SqlParameter("@Total", SqlDbType.Int);
                totalParam.Direction = ParameterDirection.Output;
                cmd.Parameters.Add(totalParam);

                conn.Open();
                cmd.ExecuteNonQuery();

                lblTotal.Text = "În bază există " + totalParam.Value.ToString() + " clienți înregistrați.";
            }
        }
    }
}
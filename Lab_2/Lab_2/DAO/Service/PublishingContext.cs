using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.Entity;
using System.Data.SqlClient;
using Lab_2.Model;

namespace Lab_2.DAO.Service
{
    class PublishingContext
    {

        private string connectionString = @"Data Source=PC\SQLEXPRESS;Initial Catalog=Lab_1;Integrated Security=True";

        public List<PublishingInfo> GetAll()
        {
            List<PublishingInfo> list = new List<PublishingInfo>();
            string sqlExpression = "SELECT_PUBLISHING_INFO";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                using (SqlCommand command = new SqlCommand(sqlExpression, connection))
                {
                    command.CommandType = System.Data.CommandType.StoredProcedure;

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            list.Add(new PublishingInfo(reader.GetInt32(0), reader.GetInt32(1), reader.GetDateTime(2)));
                        }
                    }
                }
            }
            return list;
        }

        public void InsertPublication(DateTime date, int circulation)
        {
            string sqlExpression = "INSERT_PUBLISHING_INFO";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                using (SqlCommand command = new SqlCommand(sqlExpression, connection))
                {
                    command.CommandType = System.Data.CommandType.StoredProcedure;

                    SqlParameter dateParam = new SqlParameter
                    {
                        ParameterName = "@DATE",
                        Value = date
                    };
                    command.Parameters.Add(dateParam);

                    SqlParameter circulationParam = new SqlParameter
                    {
                        ParameterName = "@CIRCULATION",
                        Value = circulation
                    };
                    command.Parameters.Add(circulationParam);

                    command.ExecuteNonQuery();
                }
            }
        }

        public void UpdatePublication(int id, DateTime date, int circulation)
        {
            string sqlExpression = "UPDATE_PUBLISHING_INFO";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                using (SqlCommand command = new SqlCommand(sqlExpression, connection))
                {
                    command.CommandType = System.Data.CommandType.StoredProcedure;

                    SqlParameter idParam = new SqlParameter
                    {
                        ParameterName = "@ID",
                        Value = id
                    };
                    command.Parameters.Add(idParam);

                    SqlParameter dateParam = new SqlParameter
                    {
                        ParameterName = "@DATE",
                        Value = date
                    };
                    command.Parameters.Add(dateParam);

                    SqlParameter circulationParam = new SqlParameter
                    {
                        ParameterName = "@CIRCULATION",
                        Value = circulation
                    };
                    command.Parameters.Add(circulationParam);

                    command.ExecuteNonQuery();
                }
            }
        }

        public void DeletePublication(int id)
        {
            string sqlExpression = "DELETE_PUBLISHING_INFO";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                using (SqlCommand command = new SqlCommand(sqlExpression, connection))
                {
                    command.CommandType = System.Data.CommandType.StoredProcedure;

                    SqlParameter idParam = new SqlParameter
                    {
                        ParameterName = "@ID",
                        Value = id
                    };
                    command.Parameters.Add(idParam);

                    command.ExecuteNonQuery();
                }
            }
        }
    }
}

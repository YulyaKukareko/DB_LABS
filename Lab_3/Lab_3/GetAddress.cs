using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;

public partial class StoredProcedures
{
    [Microsoft.SqlServer.Server.SqlProcedure]
    public static void GetAddress (SqlDateTime date)
    {
        SqlCommand command = new SqlCommand();

        command.Connection = new SqlConnection("Context connection = true");
        command.Connection.Open();

        string query = "Select addr.ID, addr.FULL_ADDRESS FROM CUSTOMER cust INNER JOIN Lab_1.dbo.ADDRESS addr ON addr.ID = cust.ADDRESS_ID  INNER JOIN ORDERS ON cust.ID = ORDERS.ID_CUSTOMER WHERE ORDER_DATE = @DATE_PARAM;";

        command.CommandText = query.ToString();

        SqlParameter parameter = command.Parameters.Add("@DATE_PARAM", SqlDbType.DateTime);
        parameter.Value = date;
        SqlContext.Pipe.ExecuteAndSend(command);
        command.Connection.Close();
    }
}

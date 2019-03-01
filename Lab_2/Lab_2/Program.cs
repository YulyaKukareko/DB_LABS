using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Lab_2.DAO.Repository;
using Lab_2.DAO.Service;
using Lab_2.Model;

namespace Lab_2
{
    class Program
    {
        static void Main(string[] args)
        {
            PublishingContext context = new PublishingContext();
            UnitOfWork unit = new UnitOfWork(context);


            unit.PublishingRepository.Create(new PublishingInfo(400, DateTime.Now));

            foreach(PublishingInfo info in unit.PublishingRepository.GetAll())
            {
                Console.Write(info);
                Console.WriteLine();
            }

            unit.PublishingRepository.Update(new PublishingInfo(16, 500, DateTime.Now));

            foreach (PublishingInfo info in unit.PublishingRepository.GetAll())
            {
                Console.Write(info);
                Console.WriteLine();
            }

            unit.PublishingRepository.Delete(16);

            foreach (PublishingInfo info in unit.PublishingRepository.GetAll())
            {
                Console.Write("id = " + info.Id + " circulation = " + info.Circulation + " date = " + info.Date);
                Console.WriteLine();
            }
        }
    }
}

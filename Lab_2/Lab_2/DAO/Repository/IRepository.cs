using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Lab_2.Model;

namespace Lab_2.DAO.Repository
{
    interface IRepository<T>
    {
        List<T> GetAll();
        void Create(T publishing);
        void Update(T publishing);
        void Delete(int publicationId);
    }
}

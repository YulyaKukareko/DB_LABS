using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Lab_2.DAO.Service;
using Lab_2.Model;

namespace Lab_2.DAO.Repository
{
    class SQLPublishingRepository : IRepository<PublishingInfo>
    {
        private PublishingContext context;

        public SQLPublishingRepository(PublishingContext db)
        {
            context = db;
        }

        public List<PublishingInfo> GetAll()
        {
            return context.GetAll();
        }

        public void Update(PublishingInfo publishing)
        {
            context.UpdatePublication(publishing.Id, publishing.Date, publishing.Circulation);
        }

        public void Create(PublishingInfo publishing)
        {
            context.InsertPublication(publishing.Date, publishing.Circulation);
        }

        public void Delete(int publicationId)
        {
            context.DeletePublication(publicationId);
        }
    }
}

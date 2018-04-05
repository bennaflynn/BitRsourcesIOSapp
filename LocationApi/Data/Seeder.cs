
using System.Linq;

public class Seeder 
{
    ApplicationDbContext context;
    public Seeder(ApplicationDbContext context) {
        this.context = context;
    }
    public void SeedData() {
        var atms = context.ATMs;
        
        if(atms.Count() > 0) {
            return;
        }

        var atm1 = new ATM {
            Title = "Honey Badger Pender St",
            Lat = 49.2831122f,
            Long = -123.1231192f
        };
        atms.Add(atm1);

        var atm2 = new ATM {
            Title = "BitNational Waves Coffee",
            Lat = 49.2793048f,
            Long = -123.1136826f
        };
        atms.Add(atm2);

        var atm3 = new ATM {
            Title = "Honey Badger West Georgia",
            Lat = 49.2817575f,
            Long = -123.1227369f
        };
        atms.Add(atm3);

        var atm4 = new ATM {
            Title = "ConnectedCoin Robson",
            Lat = 49.2838037f,
            Long = -123.1299892f
        };
        atms.Add(atm4);

        context.SaveChanges();
    }

}
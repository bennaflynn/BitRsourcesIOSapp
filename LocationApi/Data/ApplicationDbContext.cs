

using Microsoft.Data.Sqlite;
using Microsoft.EntityFrameworkCore;

public class ApplicationDbContext : DbContext
{
    public DbSet<ATM> ATMs {get;set;}
    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder) {
        var connectionStringBuilder = new SqliteConnectionStringBuilder {
            DataSource = "TheDatabase.db"
        };
        var connectionString = connectionStringBuilder.ToString();
        var connection = new SqliteConnection(connectionString);

        optionsBuilder.UseSqlite(connection);
    }
}

public class ATM {
    public int Id {get;set;}
    public string Title {get; set;}

    public float Long {get;set;}
    public float Lat {get; set;} 
}
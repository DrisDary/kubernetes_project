from django.db import models


class DbTable(models.Model):
   #name        = "TestTable"
   column_1    = models.CharField(max_length=50,  primary_key=True)
   column_2    = models.CharField(max_length=50)
   column_3    = models.CharField(max_length=50)

   class Meta:
      db_table = "TestTable"

   # def __str__(self):
   #    return self.name
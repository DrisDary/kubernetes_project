from .models import DbTable
from django.http import HttpResponse


def view_table(request): 

   column_list = DbTable.objects.values_list("column_1", "column_2", "column_3") #DbTable.objects.all()

   return HttpResponse(column_list)
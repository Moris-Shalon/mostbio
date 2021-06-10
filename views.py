from django.http import HttpResponse
from django.shortcuts import render, redirect
import requests
import json
import subprocess
from os import remove
from os import path
from os import getcwd
from os import chdir
from shutil import move
import hashlib

from io import BytesIO

from datetime import datetime

from django.conf import settings
from django.core.files.storage import FileSystemStorage

# models
from info.models import Info
from preparation.models import Preparation
from result.models import Result

# search
from django.db.models import Q
from django import forms

salt = "!@SVYAT_SPICE!sidufIF223f32f9SgvZvo3P"

def md5_str_hash(str_):
    hash_md5 = hashlib.md5()
    hash_md5.update(str_.encode("utf-8"))
    return hash_md5.hexdigest()


# views
def home_view(request, *args, **kwargs):
    context = {
        'title'     : 'most.bio - исследуйте препараты онлайн',
    }
    return render(request, "home.html", context)

def about_view(request, *args, **kwargs):
    context = {
        'title'     : 'О проекте most.bio',
        'content'   : Info.objects.get(id=1).about,
    }
    return render(request, "about.html", context)

def documentation_view(request, *args, **kwargs):
    context = {
        'title'         : 'Документация | most.bio',
        'content'       : Info.objects.get(id=1).instructions,
        'preparation'   : Preparation.objects.filter().order_by('order'),
    }
    return render(request, "documentation.html", context)

def feedback_view(request, *args, **kwargs):
    context = {
        'title'     : 'Обратная связь | most.bio',
        'content'   : Info.objects.get(id=1).feedback
    }
    return render(request, "feedback.html", context)

def support_view(request, *args, **kwargs):
    context = {
        'title'     : 'Поддержать проект most.bio',
        'content'   : Info.objects.get(id=1).support
    }
    return render(request, "support.html", context)

def upload_view(request, *args, **kwargs):
    supported_images = ['jpg', 'jpeg', 'png']
    darknet_dir = "/home/boss/darknet"
    context = {
        'title'     : 'Загрузка препарата для исследования | most.bio',
    }
    if request.method == "POST" and request.FILES:
        img_ext = f"{str(request.FILES['upload']).split('.')[-1].lower()}"

        if img_ext in supported_images:
            description = "Lol"

            upload = request.FILES['upload']
            salt_hash = md5_str_hash(salt)
            upload_name_hash = md5_str_hash(upload.name)
            datetime_hash = md5_str_hash(str(datetime.now()))
            full_hash = md5_str_hash(salt_hash+upload_name_hash+datetime_hash)

            fs = FileSystemStorage()
            filename = fs.save(f"{full_hash}.{img_ext}", upload)
            uploaded_file_url = fs.url(filename)
            mostbiopath = getcwd()
            chdir(darknet_dir)
            darknet_test = subprocess.getoutput(f'{darknet_dir}/darknet detector test {darknet_dir}/data/obj.data {darknet_dir}/cfg/yolov4-tiny-custom.cfg {darknet_dir}/backup/yolov4-tiny-custom_final.weights /home/boss/mostbio{uploaded_file_url} -thresh 0.3').split("\n")
            if path.exists(f"{darknet_dir}/predictions.jpg") == True:
                move(f"{darknet_dir}/predictions.jpg", (mostbiopath + "/predictions.jpg"))
            chdir(mostbiopath)
            percentfound = 0
            percenttext = ""
            for darknet_result in darknet_test:
                if "%" in darknet_result:
                    percentfound += 1
                    percenttext += ("| " + darknet_result + " |")
            if percentfound == 0:
                context.update({
                    'darknet_answer': "Не удалось опознать объекты на изображении (вероятность совпадения с имеющимися данными ниже 30%)",
                })
            elif percentfound == 1:
                context.update({
                    'darknet_answer': percenttext,
                    'darknet_picture': '/predictions.jpg',
                })
            else:
                context.update({
                    'darknet_answer': percenttext,
                    'darknet_picture': '/predictions.jpg',
                })
        else:
            context.update({
                'darknet_answer': "Данный формат не поддерживается. Пожалуйста, загружите изображение в одном из указанных выше форматов.",
            })

    return render(request, "upload.html", context)

def search_view(request, *args, **kwargs):
    search = request.GET.get('q',)
    results = Preparation.objects.filter(
        Q(title__icontains=search)|
        Q(description__icontains=search))
    context = {
        'title'     : 'Результаты поиска | most.bio',
        'results'   : results,
    }
    return render(request, "search.html", context)

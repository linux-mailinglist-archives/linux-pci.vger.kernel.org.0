Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD4E237F4
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2019 15:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731711AbfETNXa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 May 2019 09:23:30 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36657 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbfETNX3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 May 2019 09:23:29 -0400
Received: by mail-io1-f65.google.com with SMTP id e19so11011042iob.3
        for <linux-pci@vger.kernel.org>; Mon, 20 May 2019 06:23:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UBrVfji9g8YN1QxOchrV6NTuPqjMFHnp9eL00F6ULiM=;
        b=uPBKQaU/Gs78fOO5tYFi9pCrANsy7VFoxklZXwgJs+BGkEw1ZjRxlPq6/iH6MdreyY
         8IgWooKRVe9uqcPlelOF0oau1h2/t5bkdKw18XliUpWqzolxccMdLG4inazGI66W1u59
         B2gp8QQV84XyW3MGps/oOFZlE0iwWO9IxqN7N3DzhvZv8YDPO9qgEluTDfiMBPbycx0e
         F1tXY4QRWTCLpCOO5e/VDyhYkFzxWI3l2fb4YMejd8HbEOkvnaLUFoG6DXVjJHBWHRx3
         qBFsN/K7WBtvXDStohGgZIO+D2ucHXl8rGMzF8AOfBfHroOvkVku5auhm8RpafsN6j1i
         cXfg==
X-Gm-Message-State: APjAAAVMn5/g6cfGPZm7DbRpwh50RNv8N9Dj3i5Y+nOIhAww9BX5yx4x
        jjMaQYVcEDadgHD3i4wRApsFVFAQto7eOdRmRQpGAg==
X-Google-Smtp-Source: APXvYqxgDIcPYHned1Xf/yYTEvrJIkIzs5wwpGhhFrfdvsPzxJrN7oiVZo0mO0/H8oor3x/E5Q58SxszabJc2I1Kqfw=
X-Received: by 2002:a5e:a919:: with SMTP id c25mr17203847iod.166.1558358608788;
 Mon, 20 May 2019 06:23:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190507201245.9295-1-kherbst@redhat.com>
In-Reply-To: <20190507201245.9295-1-kherbst@redhat.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Mon, 20 May 2019 15:23:17 +0200
Message-ID: <CACO55tvv6uoMkJq1J2eW-o9Lj-+DNZVB5emChMVW5jqSON4zpQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Potential fix for runpm issues on various laptops
To:     nouveau <nouveau@lists.freedesktop.org>
Cc:     Lyude Paul <lyude@redhat.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ping to the pci folks? I really would like to know what you make out of it.

In fact, this kind of looks like a pcie issue, but I just don't know
enough to really be able to tell. I am mainly wondering why putting
the device with a 2.5 vs a 8.0 link into d3cold makes the resume path
break? Any ideas? broken pcie controller? broken implementation on the
gpu?

On Tue, May 7, 2019 at 10:12 PM Karol Herbst <kherbst@redhat.com> wrote:
>
> CCing linux-pci and Bjorn Helgaas. Maybe we could get better insights on
> how a reasonable fix would look like.
>
> Anyway, to me this entire issue looks like something which has to be fixed
> on a PCI level instead of inside a driver, so it makes sense to ask the
> pci folks if they have any better suggestions.
>
> Original cover letter:
> While investigating the runpm issues on my GP107 I noticed that something
> inside devinit makes runpm break. If Nouveau loads up to the point right
> before doing devinit, runpm works without any issues, if devinit is ran,
> not anymore.
>
> Out of curiousity I even tried to "bisect" devinit by not running it on
> vbios provided signed PMU image, but on the devinit parser we have inside
> Nouveau.
> Allthough this one isn't as feature complete as the vbios one, I was able
> to reproduce the runpm issues as well. From that point I was able to only
> run a certain amount of commands until I got to some PCIe initialization
> code inside devinit which trigger those runpm issues.
>
> Devinit on my GPU was changing the PCIe link from 8.0 to 2.5, reversing
> that on the fini path makes runpm work again.
>
> There are a few other things going on, but with my limited knowledge about
> PCIe in general, the change in the link speed sounded like it could cause
> issues on resume if the controller and the device disagree on the actual
> link.
>
> Maybe this is just a bug within the PCI subsystem inside linux instead and
> the controller has to be forced to do _something_?
>
> Anyway, with this runpm seems to work nicely on my machine. Secure booting
> the gr (even with my workaround applied I need anyway) might fail after
> the GPU got runtime resumed though...
>
> Karol Herbst (4):
>   drm: don't set the pci power state if the pci subsystem handles the
>     ACPI bits
>   pci: enable pcie link changes for pascal
>   pci: add nvkm_pcie_get_speed
>   pci: save the boot pcie link speed and restore it on fini
>
>  drm/nouveau/include/nvkm/subdev/pci.h |  6 +++--
>  drm/nouveau/nouveau_acpi.c            |  7 +++++-
>  drm/nouveau/nouveau_acpi.h            |  2 ++
>  drm/nouveau/nouveau_drm.c             | 14 +++++++++---
>  drm/nouveau/nouveau_drv.h             |  2 ++
>  drm/nouveau/nvkm/subdev/pci/base.c    |  9 ++++++--
>  drm/nouveau/nvkm/subdev/pci/gk104.c   |  8 +++----
>  drm/nouveau/nvkm/subdev/pci/gp100.c   | 10 +++++++++
>  drm/nouveau/nvkm/subdev/pci/pcie.c    | 32 +++++++++++++++++++++++----
>  drm/nouveau/nvkm/subdev/pci/priv.h    |  7 ++++++
>  10 files changed, 81 insertions(+), 16 deletions(-)
>
> --
> 2.21.0
>

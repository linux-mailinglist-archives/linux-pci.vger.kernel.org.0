Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 967233C5F4D
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jul 2021 17:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234676AbhGLPfW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Jul 2021 11:35:22 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:33368 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhGLPfW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Jul 2021 11:35:22 -0400
Received: by mail-oi1-f170.google.com with SMTP id s23so10115282oij.0;
        Mon, 12 Jul 2021 08:32:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eoSbY0l2R7T8Dp+6SHfm2nWBKshC7xSCH+2ackq8X5c=;
        b=XVw0bM9zvtZGN7to/lrXOgyFkKq9XhLilh2KJ0A70wWP/EYKTy71djTVhLOjzRKWTJ
         DnCyfofcxdn2VwVFD9GpoUqDynIDjP2f7qBZ7AL/rR0MoE0NA480HJtDoXOMqnkYkBT9
         P3f+UH5ON0SF++8Cbm2DKUT02rXoErf/8WHtEkHgfnSgfGkXb7px0HOmD9+2wSa9NL3N
         5E2+vHWj3IEG8EuTgsE0c6nRt0L2/kYxVMexI059nsRtC62XSGpO/jkxi+H642tm49uv
         c6OW1nbYaWBdOMstra1fXgDrRGJXuwnbeVz4qgsI4y3pJKNrFRTmaFrx9jLzUfMEEgd+
         fQ+Q==
X-Gm-Message-State: AOAM532f8hTZsk5iRbdmFLT+yIzjtC0xK0YUxF7xexhu2uEqVSownPlA
        SR2aq3xaWT+InTPqzTf6k+JsTC3spRJ9sgY70pY=
X-Google-Smtp-Source: ABdhPJxClNJyjoaMQqdJXvZAOQo95mnJXirXCuszMI5IbtvGcJQtRRqPY44SqSd1Pty6j/tp4+bw2nCBh/u4v/O0hQI=
X-Received: by 2002:a05:6808:10d0:: with SMTP id s16mr5729607ois.69.1626103952819;
 Mon, 12 Jul 2021 08:32:32 -0700 (PDT)
MIME-Version: 1.0
References: <4327888.LvFx2qVVIh@kreacher> <5327028b-6e0b-e83c-b147-da083a23634c@gmail.com>
 <CAJZ5v0iCyLircAL928bA4-+Pd1UtaBcZ-PVRNk3qJScSybzwCQ@mail.gmail.com> <CAJZ5v0iw==AbxPR9P=SBWYWKi8PVwp9DafoXe3MTuqA8BVmAsw@mail.gmail.com>
In-Reply-To: <CAJZ5v0iw==AbxPR9P=SBWYWKi8PVwp9DafoXe3MTuqA8BVmAsw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 12 Jul 2021 17:32:21 +0200
Message-ID: <CAJZ5v0goZPRD24Wdd0HoqAFF9HYKifd_=e02FNCm2EmMGLEj8Q@mail.gmail.com>
Subject: Re: [PATCH][RFT] PCI: Use pci_update_current_state() in pci_enable_device_flags()
To:     Michael <phyre@rogers.com>,
        Salvatore Bonaccorso <carnil@debian.org>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 12, 2021 at 5:30 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Jul 9, 2021 at 1:21 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Thu, Jul 8, 2021 at 10:34 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:
> > >
> > > On 7/8/21 3:25 PM, Rafael J. Wysocki wrote:
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > Updating the current_state field of struct pci_dev the way it is done
> > > > in pci_enable_device_flags() before calling do_pci_enable_device() may
> > > > not work.  For example, if the given PCI device depends on an ACPI
> > > > power resource whose _STA method initially returns 0 ("off"), but the
> > > > config space of the PCI device is accessible and the power state
> > > > retrieved from the PCI_PM_CTRL register is D0, the current_state
> > > > field in the struct pci_dev representing that device will get out of
> > > > sync with the power.state of its ACPI companion object and that will
> > > > lead to power management issues going forward.
> > > >
> > > > To avoid such issues, make pci_enable_device_flags() call
> > > > pci_update_current_state() which takes ACPI device power management
> > > > into account, if present, to retrieve the current power state of the
> > > > device.
> > > >
> > > > Link: https://lore.kernel.org/lkml/20210314000439.3138941-1-luzmaximilian@gmail.com/
> > > > Reported-by: Maximilian Luz <luzmaximilian@gmail.com>
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > ---
> > > >
> > > > Hi Maximilian,
> > > >
> > > > Because commit 4514d991d992 ("PCI: PM: Do not read power state in
> > > > pci_enable_device_flags()"), the issue addressed by it is back, so
> > > > we need an alternative way to address it.
> > > >
> > > > Can you please check if this patch makes that issue go away?
> > >
> > > Hi,
> > >
> > > just tested this on v5.13 and it works, thanks! Feel free to add
> > >
> > > Tested-by: Maximilian Luz <luzmaximilian@gmail.com>

Gmail decided to drop Salvatore's address from the To list for me,
sorry about that.

> Michael, Salvatore, since this alternative to commit 4514d991d992
> works for Maximilian, I'm going to queue it up for 5.15 (barring any
> objections from Bjorn), so I would appreciate it if you could test it
> and let me know whether or not there were any problems with it.
>
> The patch can be downloaded from
> https://patchwork.kernel.org/project/linux-pm/patch/4327888.LvFx2qVVIh@kreacher
>
> Thanks!

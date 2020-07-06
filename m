Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92D6F216260
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jul 2020 01:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgGFXfo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jul 2020 19:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbgGFXfn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jul 2020 19:35:43 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155A9C061794
        for <linux-pci@vger.kernel.org>; Mon,  6 Jul 2020 16:35:43 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id h22so40545227lji.9
        for <linux-pci@vger.kernel.org>; Mon, 06 Jul 2020 16:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0xUaLtfV7bWgoPSWuLiBhAg/0ko2eQcaAYCQJ2etMGI=;
        b=h0hfLaWYG1MhCTz6J6AARwPIxYT3gBIha6jL6xVvSUaBoYkx4N94teWLPVBCAUX5Rb
         Mgd6ZfbpomMbwqCIpw6IvR/7+AWSOpd9wxAQaDAndSKUttK7AHQnKPfJUCMld+DdpHSu
         sJug6LFr6dSpqEUPZ5+6SlqOSKPcU4TvkSh0i9oHDdnjmCAeCWWfxOD48hkHGmZ5zzLT
         Qw7h+MQdQuwG++aYuXtmJyJHTeCIayb3GEpeIJHOrsJgSiF0lfhgl6O+IMdV0iCHo6Vj
         tWwgOV29i5d0C37Jw3GV3DT1i0KRM1Kjtu1dClAUAbtDG5GPGRG8YydqDFCi9bBjresk
         O/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0xUaLtfV7bWgoPSWuLiBhAg/0ko2eQcaAYCQJ2etMGI=;
        b=I72lLqBpXSVDlZ4nFnrTMB9W2XL7R6ZsluPK8xFbVYygwSpgoDKOl/5c8Rs9PpgyWu
         1IJdQbJHi5lwonpjYsiRPfxZeOj3bROMR00KufunipGkIUUNYHoUDsicryCmFK8PbQ2+
         F74BqbFgWrJFp3kUfglhA//KwfJ3hloC/6HxgqE5J9DG0MzOA4GIGpoJMye/nHPk7yL9
         ckoBuC0B3x6kA243G+yES3o2eCC7dUhE2f+UhtLB0DQMgmsSlXvKOIfnA8Vyb3uQ4hsr
         QSZkZSfvmVYlbl7m7oYLGI/fPev6aQ04jPhOdmfgN+XE5Nk4f2PYbjXUZBO3p2hFQCFd
         WmRg==
X-Gm-Message-State: AOAM531B9v1X1paJWSWt4SV9+nz4IDHXedKZEM5qirgOLvgxSKEero1D
        C1FdL2WSJzwWhTuT9nF6P9d6v2aYSgsS/8xafm6rxQ==
X-Google-Smtp-Source: ABdhPJw6dXXwcyv4KY9Jl80FcEosFSoQoaGDHkx+0zdTw4HjncZQDYJNWjTLcwx9UlAXOCwdVnow/Rw2NoDsjZTLErM=
X-Received: by 2002:a2e:858e:: with SMTP id b14mr30021146lji.301.1594078541252;
 Mon, 06 Jul 2020 16:35:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200630044943.3425049-1-rajatja@google.com> <20200630044943.3425049-5-rajatja@google.com>
 <20200630080220.GC619174@kroah.com>
In-Reply-To: <20200630080220.GC619174@kroah.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Mon, 6 Jul 2020 16:35:05 -0700
Message-ID: <CACK8Z6FdWqx5oSXtAtZR7MN_yL0CS5g3yOmGeL5J9sZPHK_MYQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] PCI: Add device even if driver attach failed
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Saravana Kannan <saravanak@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 30, 2020 at 1:02 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jun 29, 2020 at 09:49:40PM -0700, Rajat Jain wrote:
> > device_attach() returning failure indicates a driver error while trying to
> > probe the device. In such a scenario, the PCI device should still be added
> > in the system and be visible to the user.
> >
> > This patch partially reverts:
> > commit ab1a187bba5c ("PCI: Check device_attach() return value always")
> >
> > Signed-off-by: Rajat Jain <rajatja@google.com>
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> > v2: Cosmetic change in commit log.
> >     Add Greg's "reviewed-by"
> >
> >  drivers/pci/bus.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> >
> > diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> > index 8e40b3e6da77d..3cef835b375fd 100644
> > --- a/drivers/pci/bus.c
> > +++ b/drivers/pci/bus.c
> > @@ -322,12 +322,8 @@ void pci_bus_add_device(struct pci_dev *dev)
> >
> >       dev->match_driver = true;
> >       retval = device_attach(&dev->dev);
> > -     if (retval < 0 && retval != -EPROBE_DEFER) {
> > +     if (retval < 0 && retval != -EPROBE_DEFER)
> >               pci_warn(dev, "device attach failed (%d)\n", retval);
> > -             pci_proc_detach_device(dev);
> > -             pci_remove_sysfs_dev_files(dev);
> > -             return;
> > -     }
> >
> >       pci_dev_assign_added(dev, true);
> >  }
>
> This should go first in the series, and cc: stable and get merged now.
> No need to tie it to this series at all.
>
> Or just an independant patch, it doesn't have much to do with this
> series, it's a bugfix.

Resent this patch as an independent patch with cc:stable here:
https://lore.kernel.org/patchwork/patch/1268456/

Thanks,

Rajat

>
> thanks,
>
> greg k-h

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D49286CB8
	for <lists+linux-pci@lfdr.de>; Thu,  8 Oct 2020 04:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbgJHCXv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Oct 2020 22:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbgJHCXv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Oct 2020 22:23:51 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B77C061755
        for <linux-pci@vger.kernel.org>; Wed,  7 Oct 2020 19:23:49 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id d20so4636117iop.10
        for <linux-pci@vger.kernel.org>; Wed, 07 Oct 2020 19:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=INuLJfBeUmEH0uw1bq9WIrK5i8dKmvSaFB92Q9UojBM=;
        b=MrTISALNzlXJ3QturtANcCCaH81gaQRCvQaKmxGXiT1m7ZQDBPIYxg9XvvMH6q6VzC
         eYN2wQQ24Q5uhbPjRvNNbGVkjUtSwUAfp5RBGdGK5on6rFkHH6tzET+iGK81n9gL6RWG
         Fby/zu30BO2aiHkUx4/tObTTfJ9Nsv3EzNmBEamA0C/kCaSpplFFWbPi2R8QmLS/rEe+
         NSxO49PFtRdAJFJ70oFbmMVsgy2GK6GlRSI4RY8dEiC+YiLwgFI6eiYjmFTEpi1lllBZ
         scXqdVXjNulHWr4KPdJuWW7kzhTTc5DE1maMVfseZ6F5pvNUeAAA3Z7tP96xsQ2S/evT
         fUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=INuLJfBeUmEH0uw1bq9WIrK5i8dKmvSaFB92Q9UojBM=;
        b=ZALqL2VOo/9p/3doc8ffNHV4H9a14Wp4YlQRFTeKzkvBrbVXnBpzFLx23doOaW/SUA
         YrJHQisCcwwvurxeoapcGUnIa1lNwpwIFc4B6roen+NoY41nwtws+LCVTYNG5ReCV2QU
         +UnaIby+OdtMVBYUgRp6nsqC7XFuyZnwFE5iYu8BqMu9IfxXCZBU+Ouy0AhcIcKk6Dlb
         4bJ1OZU48v+vP1OKuyBjC95m9ZinX3/eGIZc4IWvVB7AB4KTc6TUgjKDv4HMCvApIORe
         icTP0F00hQORpyxb6KkdFgMcGmZgS5DfHUsG8Uk+DlCgdgf611HRi8NxWQpd97j5sk8c
         6WmQ==
X-Gm-Message-State: AOAM5331+e8gy06TdtqYS62FwHdim4/KOHCHwVlVPr9e+j0GCE2wipm3
        d+1oq+2enQA/eOY8gZLsyttuzO9BjGtnUAq0iQuFz6qyky7Yxw==
X-Google-Smtp-Source: ABdhPJwF6c8p7byaDZ5CZ7geEmWRHlc118O6oGWP7oHgpK6Pe3PVCKbbt6qqxjFcqUyRy/3SySScPNlFxuN3oRTjWME=
X-Received: by 2002:a6b:5907:: with SMTP id n7mr4451249iob.75.1602123828699;
 Wed, 07 Oct 2020 19:23:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200925092258.525079-1-clg@kaod.org>
In-Reply-To: <20200925092258.525079-1-clg@kaod.org>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Thu, 8 Oct 2020 13:23:37 +1100
Message-ID: <CAOSf1CGW7ocYm2BXFiy9Nmi+G+xwVcqQzTqPo_nss_tmpG_V=w@mail.gmail.com>
Subject: Re: [PATCH] powerpc/pci: Fix PHB removal/rescan on PowerNV
To:     =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 25, 2020 at 7:23 PM C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> To fix an issue with PHB hotplug on pSeries machine (HPT/XIVE), commit
> 3a3181e16fbd introduced a PPC specific pcibios_remove_bus() routine to
> clear all interrupt mappings when the bus is removed. This routine
> frees an array allocated in pcibios_scan_phb().
>
> This broke PHB hotplug on PowerNV because, when a PHB is removed and
> re-scanned through sysfs, the PCI layer un-assigns and re-assigns
> resources to the PHB but does not destroy and recreate the PCI
> controller structure. Since pcibios_remove_bus() does not clear the
> 'irq_map' array pointer, a second removal of the PHB will try to free
> the array a second time and corrupt memory.

"PHB hotplug" and "hot-plugging devices under a PHB" are different
things. What you're saying here doesn't make a whole lot of sense to
me unless you're conflating the two. The distinction is important
since on pseries we can use DLPAR to add and remove actual PHBs (i.e.
the pci_controller) at runtime, but there's no corresponding mechanism
on PowerNV.

> Free the 'irq_map' array in pcibios_free_controller() to fix
> corruption and clear interrupt mapping after it has been
> disposed. This to avoid filling up the array with successive
> remove/rescan of a bus.

Even with this patch I think we're still broken. With this patch
applied the init path is something like:

per-phb init:
    allocate phb->irq_map array
per-bus init:
    nothing
per-device init:
    pcibios_bus_add_device()
       pci_read_irq_line()
            pci_irq_map_register(pci_dev, virq)
               *record the device's interrupt in phb->irq_map*

And the teardown path:

per-device teardown:
    nothing
per-bus teardown:
    pcibios_remove_bus()
        pci_irq_map_dispose()
            *walk phb->irq_map and dispose of each mapped interrupt*
per-phb teardown:
    free(phb->irq_map)

There's a lot of asymmetry here, which is a problem in itself, but the
real issue is that when removing *any* pci_bus under a PHB we dispose
of the LSI\ for *every* device under that PHB. Not good.

Ideally we should be fixing this by having the per-device teardown
handle disposing the mapping. Unfortunately, there's no pcibios hook
that's called when removing a pci_dev. However, we can register a bus
notifier which will be called when the pci_dev is removed from its bus
and we already do that for the per-device EEH teardown and to handle
IOMMU TCE invalidation when the device is removed.

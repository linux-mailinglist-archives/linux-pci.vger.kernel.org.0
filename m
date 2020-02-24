Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBB516AD76
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 18:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgBXRar (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 12:30:47 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54543 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728080AbgBXRaq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Feb 2020 12:30:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582565445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jBUQXvyIT0NRGeVlKfYzxCNd6VTs5c/rTotbnjQlyHg=;
        b=SOpNRt8eWVIPHGZDDKgm7F13CQR+wUNSBgIQyqgDbz61GQT9G+KR+pqvF2DrC1kQLVytVY
        M2qLqHrPFobhwIAyb9beYeKGZruLJDsO4U4dIxzww/cdNz7qLq70j/5Uy/w6qjS5LLZO8E
        ubSsQN8GdMzblGuodHeWEP9Y86f8TGM=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-Z5mjFphzN7qrHAEDVKgn6g-1; Mon, 24 Feb 2020 12:30:43 -0500
X-MC-Unique: Z5mjFphzN7qrHAEDVKgn6g-1
Received: by mail-io1-f71.google.com with SMTP id z201so16227981iof.8
        for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2020 09:30:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jBUQXvyIT0NRGeVlKfYzxCNd6VTs5c/rTotbnjQlyHg=;
        b=EvGSZJXJJGj1EredyyLn40Mn1x0UkUGTfNupj6d4tA3cBrrSdy0LeBWtSQ4PAbJOdT
         nO+zZ6u1UZjPfrH5nxSnlTjaPjJgzq0vnu8MjibBcMecYN+kZ5D8JNxKD54fVUJHre0n
         843pH0VdfT2+tW7OJ7UPTx7K8MYLeyVlbELVyOi2VJ3amYjM1iAs789LOyWm3NnR8FwH
         WnvVBTkKSucd8KZPSvgghZxZuY3vsZiiqITgzUs5dspo5Wau/JxtSX0oMLav9gdhNQ/R
         8r1pw5TzmW50ZusjzRQfjJymj+eG+WHz3JCKF+hEjrL4Ue/wUeTKQElQmcUNOkMhlRCg
         GJVg==
X-Gm-Message-State: APjAAAXsyHpnzHQJQoLBFUSKVb/vHaHR4kmcPxv6M43rRYr0+FBs1BS3
        GaRO+Mo805GocLS4mykDyQupv0V5U0yScQRsgPamrar+ywF+57THJ+AqbVZHeAHV7/NLYSFa4/c
        5Qt/ahXOb2BroI22duHTmu+tGDMPer9Quyxpv
X-Received: by 2002:a92:3a95:: with SMTP id i21mr62650045ilf.249.1582565442562;
        Mon, 24 Feb 2020 09:30:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqyqzh9CyJ1U9k2mrY0h0+BdZxlgI3BRos8HplHL7d4dWc2+DjxZb0RyDzWWanrk9NL3aDvaxkGg8UaqFzTR+WU=
X-Received: by 2002:a92:3a95:: with SMTP id i21mr62649926ilf.249.1582565441513;
 Mon, 24 Feb 2020 09:30:41 -0800 (PST)
MIME-Version: 1.0
References: <20191225192118.283637-1-kasong@redhat.com> <20200222165631.GA213225@google.com>
In-Reply-To: <20200222165631.GA213225@google.com>
From:   Kairui Song <kasong@redhat.com>
Date:   Tue, 25 Feb 2020 01:30:30 +0800
Message-ID: <CACPcB9dv1YPhRmyWvtdt2U4g=XXU7dK4bV4HB1dvCVMTpPFdzA@mail.gmail.com>
Subject: Re: [RFC PATCH] PCI, kdump: Clear bus master bit upon shutdown in
 kdump kernel
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Khalid Aziz <khalid@gonehiking.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, kexec@lists.infradead.org,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Baoquan He <bhe@redhat.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Randy Wright <rwright@hpe.com>, Dave Young <dyoung@redhat.com>,
        Myron Stowe <myron.stowe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Thanks for the reply, I don't have any better idea than this RFC patch
yet. The patch is hold as previous discussion suggests this just work
around the problem, the real fix should be let crash kernel load every
required kernel module and reset whichever hardware that is not in a
good status. However, user may struggle to find out which driver is
actually needed, and it's not practical to load all drivers in kdump
kernel. (actually kdump have been trying to load as less driver as
possible to save memory).

So as Dave Y suggested in another reply, will it better to apply this
quirk with a kernel param controlling it? If such problem happens, the
option could be turned on as a fix.


On Sun, Feb 23, 2020 at 12:59 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Khalid, Deepa, Randy, Dave, Myron]
>
> On Thu, Dec 26, 2019 at 03:21:18AM +0800, Kairui Song wrote:
> > There are reports about kdump hang upon reboot on some HPE machines,
> > kernel hanged when trying to shutdown a PCIe port, an uncorrectable
> > error occurred and crashed the system.
>
> Did we ever make progress on this?  This definitely sounds like a
> problem that needs to be fixed, but I don't see a resolution here.
>
> > On the machine I can reproduce this issue, part of the topology
> > looks like this:
> >
> > [0000:00]-+-00.0  Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DMI2
> >           +-01.0-[02]--
> >           +-01.1-[05]--
> >           +-02.0-[06]--+-00.0  Emulex Corporation OneConnect NIC (Skyhawk)
> >           |            +-00.1  Emulex Corporation OneConnect NIC (Skyhawk)
> >           |            +-00.2  Emulex Corporation OneConnect NIC (Skyhawk)
> >           |            +-00.3  Emulex Corporation OneConnect NIC (Skyhawk)
> >           |            +-00.4  Emulex Corporation OneConnect NIC (Skyhawk)
> >           |            +-00.5  Emulex Corporation OneConnect NIC (Skyhawk)
> >           |            +-00.6  Emulex Corporation OneConnect NIC (Skyhawk)
> >           |            \-00.7  Emulex Corporation OneConnect NIC (Skyhawk)
> >           +-02.1-[0f]--
> >           +-02.2-[07]----00.0  Hewlett-Packard Company Smart Array Gen9 Controllers
> >
> > When shuting down PCIe port 0000:00:02.2 or 0000:00:02.0, the machine
> > will hang, depend on which device is reinitialized in kdump kernel.
> >
> > If force remove unused device then trigger kdump, the problem will never
> > happen:
> >
> >     echo 1 > /sys/bus/pci/devices/0000\:00\:02.2/0000\:07\:00.0/remove
> >     echo c > /proc/sysrq-trigger
> >
> >     ... Kdump save vmcore through network, the NIC get reinitialized and
> >     hpsa is untouched. Then reboot with no problem. (If hpsa is used
> >     instead, shutdown the NIC in first kernel will help)
> >
> > The cause is that some devices are enabled by the first kernel, but it
> > don't have the chance to shutdown the device, and kdump kernel is not
> > aware of it, unless it reinitialize the device.
> >
> > Upon reboot, kdump kernel will skip downstream device shutdown and
> > clears its bridge's master bit directly. The downstream device could
> > error out as it can still send requests but upstream refuses it.
> >
> > So for kdump, let kernel read the correct hardware power state on boot,
> > and always clear the bus master bit of PCI device upon shutdown if the
> > device is on. PCIe port driver will always shutdown all downstream
> > devices first, so this should ensure all downstream devices have bus
> > master bit off before clearing the bridge's bus master bit.
> >
> > Signed-off-by: Kairui Song <kasong@redhat.com>
> > ---
> >  drivers/pci/pci-driver.c | 11 ++++++++---
> >  drivers/pci/quirks.c     | 20 ++++++++++++++++++++
> >  2 files changed, 28 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > index 0454ca0e4e3f..84a7fd643b4d 100644
> > --- a/drivers/pci/pci-driver.c
> > +++ b/drivers/pci/pci-driver.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/kexec.h>
> >  #include <linux/of_device.h>
> >  #include <linux/acpi.h>
> > +#include <linux/crash_dump.h>
> >  #include "pci.h"
> >  #include "pcie/portdrv.h"
> >
> > @@ -488,10 +489,14 @@ static void pci_device_shutdown(struct device *dev)
> >        * If this is a kexec reboot, turn off Bus Master bit on the
> >        * device to tell it to not continue to do DMA. Don't touch
> >        * devices in D3cold or unknown states.
> > -      * If it is not a kexec reboot, firmware will hit the PCI
> > -      * devices with big hammer and stop their DMA any way.
> > +      * If this is kdump kernel, also turn off Bus Master, the device
> > +      * could be activated by previous crashed kernel and may block
> > +      * it's upstream from shutting down.
> > +      * Else, firmware will hit the PCI devices with big hammer
> > +      * and stop their DMA any way.
> >        */
> > -     if (kexec_in_progress && (pci_dev->current_state <= PCI_D3hot))
> > +     if ((kexec_in_progress || is_kdump_kernel()) &&
> > +                     pci_dev->current_state <= PCI_D3hot)
> >               pci_clear_master(pci_dev);
> >  }
> >
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 4937a088d7d8..c65d11ab3939 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -28,6 +28,7 @@
> >  #include <linux/platform_data/x86/apple.h>
> >  #include <linux/pm_runtime.h>
> >  #include <linux/switchtec.h>
> > +#include <linux/crash_dump.h>
> >  #include <asm/dma.h> /* isa_dma_bridge_buggy */
> >  #include "pci.h"
> >
> > @@ -192,6 +193,25 @@ static int __init pci_apply_final_quirks(void)
> >  }
> >  fs_initcall_sync(pci_apply_final_quirks);
> >
> > +/*
> > + * Read the device state even if it's not enabled. The device could be
> > + * activated by previous crashed kernel, this will read and correct the
> > + * cached state.
> > + */
> > +static void quirk_read_pm_state_in_kdump(struct pci_dev *dev)
> > +{
> > +     u16 pmcsr;
> > +
> > +     if (!is_kdump_kernel())
> > +             return;
> > +
> > +     if (dev->pm_cap) {
> > +             pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> > +             dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
> > +     }
> > +}
> > +DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, quirk_read_pm_state_in_kdump);
> > +
> >  /*
> >   * Decoding should be disabled for a PCI device during BAR sizing to avoid
> >   * conflict. But doing so may cause problems on host bridge and perhaps other
> > --
> > 2.24.1
> >
>


--
Best Regards,
Kairui Song


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A83C23B7CE4
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jun 2021 07:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbhF3FRb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Jun 2021 01:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbhF3FRb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Jun 2021 01:17:31 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7864C061766
        for <linux-pci@vger.kernel.org>; Tue, 29 Jun 2021 22:14:54 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id s19so1679254ioc.3
        for <linux-pci@vger.kernel.org>; Tue, 29 Jun 2021 22:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f8Y0NB86VLIykGs63DiMAHDQNuOK3nv8vC2pAJpB8J0=;
        b=lDxIqsF437QiBiLIJiWXBHDkPUEJnA2s2FGUP9S7MBUbqLWfKmAh5nQ41wNrsuNkgi
         FCwttfsYdSUeQ8ROcxNRsU7dy8eti8nA67wiDMPLX3IdXmAT8gBLgoSdi2Fy4ugCsKZb
         jKaNkkk5bfUwboOXClrWrQS2iYcLUQImzm2HHbWWAdrMosoQFOnsVtni8Qi7luqMoEKl
         8rTenodMrgfNdbelETgcdVcAqbLyZdjuccLnJHN3XNlXPlo8xP9SVJBqJqMQf3MRSXgo
         EoYttQZSar0+UfbvW/eIraQbwCR8tAWpR/7GvdVugaJ8qzwR91Wwp6aqYm6z4ch8V5rw
         PKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f8Y0NB86VLIykGs63DiMAHDQNuOK3nv8vC2pAJpB8J0=;
        b=ggNuCtEE5UYu7btXYuXdEzLRW/SDBH2IgPESv3mMN3M7jRFSzCZCePmMWdSRtUSNu1
         WWkjUKbtlUr8XyhIBuTrND7di2tKkddqtI5bvxwboCrsel6b0s9+mPtmwFe2PLrBO7HH
         YLRzRHOa49nL8kgWVBELfYyLFE2LWVRlObZgTYbZPRFMYFHigCeHkk7iK4ke49atQ7uV
         mu0X00HkFFK4OMNjemEnSb7Av4m5zki7wGhr9oWc9MhcBP+IBNk1bf7viS3LAQFQBhNJ
         Hy0vyruS3ZMDBxIodCOXZn+766zEPYlMmwkUWQsT1DymJIN4Q9oJTjXbMRYzDUInrAYI
         ZdXg==
X-Gm-Message-State: AOAM530FySoYdhhF43m+Ievs18+ppL3rxGveEivAXGsf5w4XwqrFGjQp
        QNDOWyuoyx9u9lnkAZw1cNPAMjJmDgdIsx0i3cg=
X-Google-Smtp-Source: ABdhPJxV4cJc5Q184p3IGCz2KuGnfFYPtQkGYJRUt+zyLMV5hjxKtoynwNvTOakmCzRuHw+99o2vpVFHRy2m/htKKCw=
X-Received: by 2002:a5e:a80b:: with SMTP id c11mr6698731ioa.94.1625030094088;
 Tue, 29 Jun 2021 22:14:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210629085521.2976352-2-chenhuacai@loongson.cn> <20210630000149.GA4081155@bjorn-Precision-5520>
In-Reply-To: <20210630000149.GA4081155@bjorn-Precision-5520>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Wed, 30 Jun 2021 13:14:42 +0800
Message-ID: <CAAhV-H4SgqHZ_=cXGBBxd3AWweqJhMbTeHORPtH39Z0iX1EEFw@mail.gmail.com>
Subject: Re: [PATCH V5 1/4] PCI/portdrv: Don't disable device during shutdown
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Sinan Kaya <okaya@kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Bjorn and Sinan,

On Wed, Jun 30, 2021 at 8:01 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Jun 29, 2021 at 04:55:18PM +0800, Huacai Chen wrote:
> > Use separate remove()/shutdown() callback, and don't disable PCI device
> > during shutdown. This can avoid some poweroff/reboot failures.
>
> To clarify, I think you mean "leave bus mastering enabled for PCIe
> ports during poweroff/reboot."  Maybe even better would be "leave
> DMA/MSI/MSI-X enabled for the PCIe port and downstream devices."
>
> "Disable PCI device" is a little ambiguous because pci_enable_device()
> enables memory and I/O decoding for the device BARs, but
> pci_disable_device() turns off bus mastering and has nothing to do
> with the BARs.  They are unfortunately not symmetric.
>
> > The poweroff/reboot failures could easily be reproduced on Loongson
> > platforms. I think this is not a Loongson-specific problem, instead, is
> > a problem related to some specific PCI hosts. On some x86 platforms,
> > radeon/amdgpu devices can cause the same problem [1][2], and commit
> > faefba95c9e8ca3a ("drm/amdgpu: just suspend the hw on pci shutdown")
> > can resolve it.
>
> This faefba95c9e8ca3a information isn't really connected here because
> we don't know exactly what the problem is, and the faefba95c9e8ca3a
> commit log doesn't say anything about DMA/MSI/MSI-X or bus mastering.
>
> > As Tiezhu said, this occasionally shutdown or reboot failure is due to
> > clear PCI_COMMAND_MASTER on the device in do_pci_disable_device() [3].
> >
> > static void do_pci_disable_device(struct pci_dev *dev)
> > {
> >         u16 pci_command;
> >
> >         pci_read_config_word(dev, PCI_COMMAND, &pci_command);
> >         if (pci_command & PCI_COMMAND_MASTER) {
> >                 pci_command &= ~PCI_COMMAND_MASTER;
> >                 pci_write_config_word(dev, PCI_COMMAND, pci_command);
> >         }
> >
> >         pcibios_disable_device(dev);
> > }
> >
> > When remove "pci_command &= ~PCI_COMMAND_MASTER;", it can work well when
> > shutdown or reboot. The root cause on Loongson platform is that CPU is
> > still accessing PCIe devices while poweroff/reboot, and if we disable
> > the Bus Master Bit at this time, the PCIe controller doesn't forward
> > requests to downstream devices, and also doesn't send TIMEOUT to CPU,
> > which causes CPU wait forever (hardware deadlock).
>
> Sorry, I don't think this is a root cause.  Let me try to dissect this
> because I don't follow this argument yet.  Per PCIe r5.0, sec
> 7.5.1.1.3:
>
>   Bus Master Enable - Controls the ability of a Function to issue
>   Memory and I/O Read/Write Requests, and the ability of a Port to
>   forward Memory and I/O Read/Write Requests in the Upstream
>   direction.
>
> In both endpoints and bridges, Bus Master Enable controls DMA, MSI,
> and MSI-X initiated by a PCI *endpoint*.  It has nothing to do with
> CPU accesses to the device, so I don't understand the claim that on
> Loongson, the CPU is still accessing PCIe devices during
> poweroff/reboot.
>
> You seem to say the CPU hangs because Bus Mastering is disabled.  I
> don't see how that can happen because Bus Mastering isn't involved at
> all in CPU MMIO transactions.  Or maybe this is more LS7A breakage,
> e.g., the Root Ports don't forward Completions for CPU MMIO reads when
> Bus Mastering is disabled?  Obviously that would be completely broken
> per spec, which says "This bit does not affect forwarding of
> Completions in either the Upstream or Downstream direction."
Obviously, LS7A's PCIe controller misused the Bus Master bit, because
as you say, Bus Master shouldn't be involved in CPU MMIO transactions.
LS7A's behavior is due to the bad hardware design.

There are other problems similar to LS7A, such as Radeon/AMDGPU which
I referred to in the commit messages. But yes, as you say, maybe they
are just *similar* problems, no one can say they are exactly the same
problem. Once before I wanted to make a patch to solve "all of these
problems" together, but it seems unreasonable. So, my next version
will be just a quirk for LS7A, and leave other platforms as is.

Thanks,
Huacai

>
> In the poweroff/reboot path, we call pci_device_shutdown(), which
> calls the driver's .shutdown() method if it has one.  Most drivers do
> *not* have one, so they have no idea that poweroff/reboot is happening
> and have no reason to stop DMA.
>
> The portdrv driver *does* have a .shutdown() method, which currently
> disables Bus Mastering, which means DMA/MSI/MSI-X from downstream
> devices no longer works, even if their drivers haven't done anything.
>
> The point of *this* patch is to leave Bus Mastering *enabled* during
> poweroff/reboot.  That raises the question of WHY poweroff/reboot
> fails when DMA/MSI/MSI-X are disabled.  That's the justification I'd
> like to see in the commit log.  Not just "this makes things work," but
> "here is the problem, and this is how this patch solves it."
>
> > This behavior is a PCIe protocol violation, and will be fixed in new
> > revisions of hardware (add timeout mechanism for CPU read request,
> > whether or not Bus Master bit is cleared).
>
> There's some confusion here.  A CPU read request is an MMIO
> transaction that should not be affected by Bus Master Enable.
>
> > Radeon driver is more difficult than amdgpu due to its confusing symbol
> > names, and I have maintained an out-of-tree patch for a long time [4].
>
> I poked around a little but couldn't find any posting of this radeon
> patch.  I assume you're pushing it upstream somewhere?  Is there
> resistance?  Is there any conversation there that linux-pci should be
> involved in?  Regardless, this doesn't seem relevant for this commit
> log.
>
> > Recently, we found more and more devices can cause the same problem, and
> > it is very difficult to modify all problematic drivers as radeon/amdgpu
> > does (the .shutdown callback should make sure there is no DMA activity).
>
> Can you include some examples of these other drivers that cause
> problems?  My guess is that these drivers lack .shutdown() methods, so
> they don't know a reboot or poweroff is in progress?
>
> > So, I think modify the PCIe port driver is a simple and effective way.
> > Because there is no poweroff/reboot problems before cc27b735ad3a75574a6a
> > ("PCI/portdrv: Turn off PCIe services during shutdown"). And as early
> > discussed, kexec can still work fine after this patch [5].
> >
> > [1] https://bugs.freedesktop.org/show_bug.cgi?id=97980
> > [2] https://bugs.freedesktop.org/show_bug.cgi?id=98638
> > [3] https://lore.kernel.org/patchwork/patch/1305067/
> > [4] https://github.com/chenhuacai/linux/commit/8da06f9b669831829416a3e9f4d1c57f217a42f0
> > [5] http://patchwork.ozlabs.org/project/linux-pci/patch/1600680138-10949-1-git-send-email-chenhc@lemote.com/
> >
> > Cc: Sinan Kaya <okaya@kernel.org>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > ---
> >  drivers/pci/pcie/portdrv.h      |  2 +-
> >  drivers/pci/pcie/portdrv_core.c |  6 ++++--
> >  drivers/pci/pcie/portdrv_pci.c  | 15 +++++++++++++--
> >  3 files changed, 18 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
> > index 2ff5724b8f13..358d7281f6e8 100644
> > --- a/drivers/pci/pcie/portdrv.h
> > +++ b/drivers/pci/pcie/portdrv.h
> > @@ -117,7 +117,7 @@ int pcie_port_device_resume(struct device *dev);
> >  int pcie_port_device_runtime_suspend(struct device *dev);
> >  int pcie_port_device_runtime_resume(struct device *dev);
> >  #endif
> > -void pcie_port_device_remove(struct pci_dev *dev);
> > +void pcie_port_device_remove(struct pci_dev *dev, bool disable);
> >  int __must_check pcie_port_bus_register(void);
> >  void pcie_port_bus_unregister(void);
> >
> > diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> > index e1fed6649c41..98c0a99a41d6 100644
> > --- a/drivers/pci/pcie/portdrv_core.c
> > +++ b/drivers/pci/pcie/portdrv_core.c
> > @@ -484,11 +484,13 @@ EXPORT_SYMBOL_GPL(pcie_port_find_device);
> >   * Remove PCI Express port service devices associated with given port and
> >   * disable MSI-X or MSI for the port.
> >   */
> > -void pcie_port_device_remove(struct pci_dev *dev)
> > +void pcie_port_device_remove(struct pci_dev *dev, bool disable)
> >  {
> >       device_for_each_child(&dev->dev, NULL, remove_iter);
> >       pci_free_irq_vectors(dev);
> > -     pci_disable_device(dev);
> > +
> > +     if (disable)
> > +             pci_disable_device(dev);
> >  }
> >
> >  /**
> > diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
> > index c7ff1eea225a..562fbf3c1ea9 100644
> > --- a/drivers/pci/pcie/portdrv_pci.c
> > +++ b/drivers/pci/pcie/portdrv_pci.c
> > @@ -147,7 +147,18 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
> >               pm_runtime_dont_use_autosuspend(&dev->dev);
> >       }
> >
> > -     pcie_port_device_remove(dev);
> > +     pcie_port_device_remove(dev, true);
> > +}
> > +
> > +static void pcie_portdrv_shutdown(struct pci_dev *dev)
> > +{
> > +     if (pci_bridge_d3_possible(dev)) {
> > +             pm_runtime_forbid(&dev->dev);
> > +             pm_runtime_get_noresume(&dev->dev);
> > +             pm_runtime_dont_use_autosuspend(&dev->dev);
> > +     }
> > +
> > +     pcie_port_device_remove(dev, false);
> >  }
> >
> >  static pci_ers_result_t pcie_portdrv_error_detected(struct pci_dev *dev,
> > @@ -219,7 +230,7 @@ static struct pci_driver pcie_portdriver = {
> >
> >       .probe          = pcie_portdrv_probe,
> >       .remove         = pcie_portdrv_remove,
> > -     .shutdown       = pcie_portdrv_remove,
> > +     .shutdown       = pcie_portdrv_shutdown,
> >
> >       .err_handler    = &pcie_portdrv_err_handler,
> >
> > --
> > 2.27.0
> >

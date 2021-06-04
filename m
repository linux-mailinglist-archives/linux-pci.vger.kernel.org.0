Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C55E839B5E7
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jun 2021 11:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhFDJ0E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Jun 2021 05:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhFDJ0D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jun 2021 05:26:03 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB061C06174A
        for <linux-pci@vger.kernel.org>; Fri,  4 Jun 2021 02:24:17 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id t6so1076233iln.8
        for <linux-pci@vger.kernel.org>; Fri, 04 Jun 2021 02:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hQZ7PzC5UVFrd87wI8TzYF/BQmqqi05JfodFFObyDJo=;
        b=WHAbrIhii0ju2aEW4KAMZ/j2BFplbJ5+CgKkRaQphLByRNoIlTckDURyT6gLd6D8g6
         X+2xFwnbbhG04mEqig+2krNC5s814FUYAMb3xcxEmIAZ58ckuMWd5uWWC5zTCl6IMzij
         Zaz/CM2wZClnS4AhD0qeuKCSpdIR0te9g5IUMMtuCjy4SwIsf4WoIWe1t/qx+oj9CRm5
         0ETiP05OHGrW5LMGuqHjtMbI7SAN4E0KhJjXhLIcOAllbJXTkVRyQHhym9vGCGhogkfF
         CM3z+N1zxODGOyy4nlTUwfdch6S4j8AJDFO7TRAQNUkY9HtrEnE+NzE8UDEz0zcbZ8H2
         jRBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hQZ7PzC5UVFrd87wI8TzYF/BQmqqi05JfodFFObyDJo=;
        b=I0+70ttpYD9QmVPltYeb5UUCwtqDpg2WAq1B+VzmNG0l9BLq/jFIR22ZUlIsO5sppK
         gRovFIhyfvc7Dk5LqFlMQ51lzeBQfM3IqM1vptuOSere3w8bP1EbPeZEr7dPfvR8N3W0
         uaGy2DRqvgMkI/bYwdHGm6ktzAncaM4ATgYNpGHHIqmoNkWErkphZhwVzmHK4NYp9SCb
         oFGl8lB+LgsrSdxGcJRLXaoClStMrEyLFkHj5/NSPifxsX5Wsi2VG3xxPC5rW2RCefDW
         iQX11pfWcNM3WyizrbqUic1NoUTKzbw89CmsMzw0LcR0O9qlEy3qGeieChAenhGvtrCG
         XlBA==
X-Gm-Message-State: AOAM532QjBomymefgglv9XtDJOyxu/Lix35Yp+q7w7jvULKQI5REVDiY
        inUT/YPG/9pf0rcF2vigvXZvb3N8zyrKCh84Sik=
X-Google-Smtp-Source: ABdhPJy1m6Qme3yWPTISgZ0Q+Yo0BR6DxIUf60/60zmnsrtlDKIW1X2Vclz0bglhczcoVVZj/cClzisDby73p0/8VGM=
X-Received: by 2002:a92:ce45:: with SMTP id a5mr939214ilr.173.1622798656413;
 Fri, 04 Jun 2021 02:24:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210528071503.1444680-2-chenhuacai@loongson.cn> <20210528214309.GA1523480@bjorn-Precision-5520>
In-Reply-To: <20210528214309.GA1523480@bjorn-Precision-5520>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Fri, 4 Jun 2021 17:24:04 +0800
Message-ID: <CAAhV-H4paNzoF4tEJd1_Z2VgBr64t3evfjdmrrA3CZMw=AXrGw@mail.gmail.com>
Subject: Re: [PATCH V2 1/4] PCI/portdrv: Don't disable device during shutdown
To:     Bjorn Helgaas <helgaas@kernel.org>, huangshuai@loongson.cn
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Sinan Kaya <okaya@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Bjorn,

On Sat, May 29, 2021 at 5:43 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Sinan]
>
> On Fri, May 28, 2021 at 03:15:00PM +0800, Huacai Chen wrote:
> > Use separate remove()/shutdown() callback, and don't disable PCI device
> > during shutdown. This can avoid some poweroff/reboot failures.
> >
> > The poweroff/reboot failures could easily be reproduced on Loongson
> > platforms. I think this is not a Loongson-specific problem, instead, is
> > a problem related to some specific PCI hosts. On some x86 platforms,
> > radeon/amdgpu devices can cause the same problem [1][2], and commit
> > faefba95c9e8ca3a ("drm/amdgpu: just suspend the hw on pci shutdown")
> > can resolve it.
> >
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
> > shutdown or reboot. This may implies that there are DMA activities on the
> > device while shutdown.
> >
> > Radeon driver is more difficult than amdgpu due to its confusing symbol
> > names, and I have maintained an out-of-tree patch for a long time [4].
> > Recently, we found more and more devices can cause the same problem, and
> > it is very difficult to modify all problematic drivers as radeon/amdgpu
> > does (the .shutdown callback should make sure there is no DMA activity).
> > So, I think modify the PCIe port driver is a simple and effective way.
> > Because there is no poweroff/reboot problems before cc27b735ad3a75574a6a
> > ("PCI/portdrv: Turn off PCIe services during shutdown"). And as early
> > discussed, kexec can still work fine after this patch [5].
>
> This needs to say *what* the failure is, and *why* the failure occurs.
> There's a lot of hand-waving here but nothing really specific.
>
> I'm getting the impression that:
>
>   - Whatever the problem is, it didn't happen before cc27b735ad3a
>     ("PCI/portdrv: Turn off PCIe services during shutdown").
>
>   - cc27b735ad3a added a .shutdown() method for portdrv that calls
>     pci_disable_device().
>
>   - pci_disable_device() turns off bus mastering for the PCIe port,
>     which means DMA from devices below the port will stop.
>
>   - If you change the portdrv .shutdown() so DMA from devices below
>     the port can continue, shutdown and reboot start working again.
>
Yes, that all.

> So you need to explain why we need to allow DMA from those devices
> even after we shutdown the port.  "It makes reboot work" is not a
> sufficient explanation.
I think only the designer of LS7A can tell us why. So, Mr. Shuai
Huang, could you please explain this?

>
> When you suggest that commit X introduced a problem, please cc the
> author of X.  I added Sinan for you in this case.
>
> A patch that fixes a problem with X should also include a "Fixes: X"
> tag to help people connect problems with fixes.
OK, I'll add a Fixes tag in the next version.

Huacai
>
> > [1] https://bugs.freedesktop.org/show_bug.cgi?id=97980
> > [2] https://bugs.freedesktop.org/show_bug.cgi?id=98638
> > [3] https://lore.kernel.org/patchwork/patch/1305067/
> > [4] https://github.com/chenhuacai/linux/commit/8da06f9b669831829416a3e9f4d1c57f217a42f0
> > [5] http://patchwork.ozlabs.org/project/linux-pci/patch/1600680138-10949-1-git-send-email-chenhc@lemote.com/
> >
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

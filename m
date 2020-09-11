Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2496A2657DD
	for <lists+linux-pci@lfdr.de>; Fri, 11 Sep 2020 06:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725306AbgIKEDr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Sep 2020 00:03:47 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:46358 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgIKEDq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Sep 2020 00:03:46 -0400
Received: by mail-il1-f194.google.com with SMTP id t16so7782901ilf.13
        for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2020 21:03:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZQu74fbsmQoFaMl+TfsAIhxt9cgbwJweJOgN9enuDJ0=;
        b=dKpOiAEzaHplgOUQ67e/S4z/Z+f/L0exoOirlymqOwqtzQNj3xMBsm3NpWdeao5wr8
         g13UwZHfNRIPA9RY09TY7J0dcKIoY1v8mRXCm8icFunSkUEO4aMf9L4HuBBPh6T373Dm
         Gr2hpqk5bD1xWwVNgumjyXs0qM+cAs/X/6hHJdpaMF0QN40ZTcLCYKMR1jqe5hfQa3yZ
         vxkPzc79xNVpUdEACOm7ZYkPx/RwVYZCYdWwrb7THKesM+fI4HoJuZZWqG2+LQGbfeib
         xGxtuWPDU+kemrngU65iJVNk++Hsp5xiIN0n3xd0ls4i5p+tWvOOYbdBGlW/MS22HFDn
         C8cQ==
X-Gm-Message-State: AOAM530CMGS+MYtbWmqfBNS1FwppR9Hjk8xDyHDtcnFsJRhdNPCvyZU1
        /MRTtr0Y43vmO8wEHJSAjs3HiXlFVGrgsD+NdT4=
X-Google-Smtp-Source: ABdhPJzbj8kbGLIcNmMD2s398vlsTyehs2v7c8RlFDGXCfb6GM+Mf88tkPud1UwcpdlwFnvGBhtZj9c5GzFEnM8NaOE=
X-Received: by 2002:a92:d601:: with SMTP id w1mr227421ilm.251.1599797025019;
 Thu, 10 Sep 2020 21:03:45 -0700 (PDT)
MIME-Version: 1.0
References: <1596268180-9114-1-git-send-email-chenhc@lemote.com> <20200910203242.GA811223@bjorn-Precision-5520>
In-Reply-To: <20200910203242.GA811223@bjorn-Precision-5520>
From:   Huacai Chen <chenhc@lemote.com>
Date:   Fri, 11 Sep 2020 12:03:33 +0800
Message-ID: <CAAhV-H5wnyX4Vs1trt0HOojdAPHWXLgkmM87VvKLyOzEj6GtEA@mail.gmail.com>
Subject: Re: [PATCH RFC] PCI/portdrv: Don't disable pci device during shutdown
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        linux-pci@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, all,

On Fri, Sep 11, 2020 at 4:32 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Tiezhu]
>
> On Sat, Aug 01, 2020 at 03:49:40PM +0800, Huacai Chen wrote:
> > Use separate remove()/shutdown() callback, and don't disable pci device
> > during shutdown. This can avoid some poweroff/reboot failures.
> >
> > The poweroff/reboot failures can easily reproduce on Loongson platforms.
> > I think this is not a Loongson-specific problem, instead, is a problem
> > related to some specific PCI hosts. On some x86 platforms, radeon/amdgpu
> > devices can cause the same problem, and commit faefba95c9e8ca3a523831c2e
> > ("drm/amdgpu: just suspend the hw on pci shutdown") can resolve it.
> >
> > Radeon driver is more difficult than amdgpu due to its confusing symbol
> > names, and I have maintained an out-of-tree patch for a long time [1].
> > Recently, we found more and more devices can cause the same problem, and
> > it is very difficult to modify all problematic drivers as radeon/amdgpu
> > does. So, I think modify the PCIe port driver is a simple and effective
> > way.
>
> Sounds plausible, but I don't know what the actual problem is, other
> than "poweroff/reboot doesn't work, and this patch 'fixes' it".
After all discussions (including those in the other thread), I think
the actual problem is "every driver should implement their shutdown
callback correctly as radeon/amdgpu does, otherwise there will be
poweroff failures because of device's BUS MASTER".

So, I think I should give two patches, the first remove the "remove"
callback, and the second just simply remove the "pci_disable_device()"
instead of modifying a ton of drivers, right?

Huacai
>
> > [1] https://github.com/chenhuacai/linux/commit/6612f9c1fc290d42a14618ce9a7d03014d8ebb1a
> >
> > Signed-off-by: Huacai Chen <chenhc@lemote.com>
> > ---
> >  drivers/pci/pcie/portdrv.h      |  2 +-
> >  drivers/pci/pcie/portdrv_core.c |  6 ++++--
> >  drivers/pci/pcie/portdrv_pci.c  | 15 +++++++++++++--
> >  3 files changed, 18 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
> > index af7cf23..22ba7b9 100644
> > --- a/drivers/pci/pcie/portdrv.h
> > +++ b/drivers/pci/pcie/portdrv.h
> > @@ -123,7 +123,7 @@ int pcie_port_device_resume(struct device *dev);
> >  int pcie_port_device_runtime_suspend(struct device *dev);
> >  int pcie_port_device_runtime_resume(struct device *dev);
> >  #endif
> > -void pcie_port_device_remove(struct pci_dev *dev);
> > +void pcie_port_device_remove(struct pci_dev *dev, bool disable);
> >  int __must_check pcie_port_bus_register(void);
> >  void pcie_port_bus_unregister(void);
> >
> > diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> > index 50a9522..aa165be 100644
> > --- a/drivers/pci/pcie/portdrv_core.c
> > +++ b/drivers/pci/pcie/portdrv_core.c
> > @@ -487,11 +487,13 @@ EXPORT_SYMBOL_GPL(pcie_port_find_device);
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
>
> portdrv can only be built statically (not as a module), and I don't
> think there's value in being able to unbind it.  So I think we should
> remove its .remove() method.  That would be a separate patch, of
> course, but it should make this one quite a bit simpler.
>
> >  /**
> > diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
> > index 3acf151..fcd3d2e 100644
> > --- a/drivers/pci/pcie/portdrv_pci.c
> > +++ b/drivers/pci/pcie/portdrv_pci.c
> > @@ -142,7 +142,18 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
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
>
> I admit to being ignorant about how all this PM stuff works.  A
> comment here about what's going on and why we need to check
> pci_bridge_d3_possible() would be useful.
>
> > +     pcie_port_device_remove(dev, false);
> >  }
> >
> >  static pci_ers_result_t pcie_portdrv_error_detected(struct pci_dev *dev,
> > @@ -211,7 +222,7 @@ static struct pci_driver pcie_portdriver = {
> >
> >       .probe          = pcie_portdrv_probe,
> >       .remove         = pcie_portdrv_remove,
> > -     .shutdown       = pcie_portdrv_remove,
> > +     .shutdown       = pcie_portdrv_shutdown,
> >
> >       .err_handler    = &pcie_portdrv_err_handler,
> >
> > --
> > 2.7.0
> >

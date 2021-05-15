Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 437C9381586
	for <lists+linux-pci@lfdr.de>; Sat, 15 May 2021 05:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbhEODkJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 May 2021 23:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhEODkI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 May 2021 23:40:08 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFFFC06174A
        for <linux-pci@vger.kernel.org>; Fri, 14 May 2021 20:38:56 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id i7so685561ioa.12
        for <linux-pci@vger.kernel.org>; Fri, 14 May 2021 20:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WM3riELsvMBY+8fzmLdrtKANY5j/sQQLmpAWKAKdzU4=;
        b=l4OVviaUi7kyBGps6rXDgaj1Aa7xIbah5i8m7jtDHxORA7AV4PyaTZJVyDZfgXwnTU
         xtbLqY3SjU83HMuX5y9bagTqIqpGBzrLzM2qPj/KKWbCJsIPwIMRQayVd8e+MCSrEJQ8
         I7zq+DbgbdOsnXq5wJ5rHpdzeIcDeTCRKMI2WH4j7EAxodCLW0GL6ugfgjokXdwnBP0R
         PlVRgq/23NofJy75f9XfsUk9iIUPn7onBsSA9v5RUwUI/6tSo8L8/BoBPVhkZGzhX9YN
         KHx7DYRDNSXe8d/gPs7rYRy9CqTzB8FcpCGw1fi1K0AMszw5zY25ekXNklEKrViUDgn1
         9J6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WM3riELsvMBY+8fzmLdrtKANY5j/sQQLmpAWKAKdzU4=;
        b=GIaPch7x7O5uTIGpcvR77gEZ1sGEBXYVDTTsdkIKOVbfwt0rCiSf2nxCuXjN9JEfXE
         BtNAMicpBSwyToaomRLZpR2FUZo5wE8sBdDfd4MkM3b1Ki8uczEliUhsN8jlBx/uvQ/1
         eLl4438pEYxwPIVHhKGd6zOLIDx2KnZqg9IJ0dp15CH/2X2beQE5r6GwZRTyZ+jOspSP
         CgEr+yUnkmECXjg1/eDBfmhfYdClo+x9L45nSr6jQrm9t2jl3MQ9HNAVpwquezTF9VvF
         5FLef6McUCPII7NOCtWMB2T3UMjyq8y2abSnHg/dgJ0aPjyGxJ1HEkeGniu5JmgUdYlE
         E9qA==
X-Gm-Message-State: AOAM533W55VT4fPEDrMSdrCG6tASdmw0AFPBYYOc0NHVbA4prYfMaDfh
        OXDuVWf/nXTVsgcFcmtf2VUFA2fzs1+0GcIcWCU=
X-Google-Smtp-Source: ABdhPJxotTtYBk6X8AFabJfw17tpdiRNMnCHec+buXUU1Le7Y0TE4XIfrw0v/A8/L8pRCFqIlCqkbSMTl2JOqN8X83w=
X-Received: by 2002:a05:6638:a48:: with SMTP id 8mr26558922jap.38.1621049935892;
 Fri, 14 May 2021 20:38:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210514080025.1828197-2-chenhuacai@loongson.cn> <20210514160956.GA2765772@bjorn-Precision-5520>
In-Reply-To: <20210514160956.GA2765772@bjorn-Precision-5520>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sat, 15 May 2021 11:38:44 +0800
Message-ID: <CAAhV-H4P4X49fyhYTe=Eq5YA1BU824xyaT3mLAQZXmhFovUBjA@mail.gmail.com>
Subject: Re: [PATCH 1/5] PCI/portdrv: Don't disable pci device during shutdown
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Krzysztof and Bjorn

On Sat, May 15, 2021 at 12:09 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> In subject, s/pci device/device/.  We already know this is PCI.
>
> On Fri, May 14, 2021 at 04:00:21PM +0800, Huacai Chen wrote:
> > Use separate remove()/shutdown() callback, and don't disable pci device
> > during shutdown. This can avoid some poweroff/reboot failures.
>
> s/pci/PCI/
>
> > The poweroff/reboot failures can easily reproduce on Loongson platforms.
> > I think this is not a Loongson-specific problem, instead, is a problem
> > related to some specific PCI hosts. On some x86 platforms, radeon/amdgpu
> > devices can cause the same problem, and commit faefba95c9e8ca3a523831c2e
> > ("drm/amdgpu: just suspend the hw on pci shutdown") can resolve it.
>
> Please explain exactly what these failures are and include URLs for
> relevant reports, bugzillas, etc.
>
> Conventional citation format is
>
>   faefba95c9e8 ("drm/amdgpu: just suspend the hw on pci shutdown")
Thank you very much, I will send a new version with more information attached.

>
> > As Tiezhu said, this occasionally shutdown or reboot failure is due to
> > clear PCI_COMMAND_MASTER on the device in do_pci_disable_device().
>
> Where did Tiezhu say this?  Please link to this conversation.
>
> > drivers/pci/pci.c
>
> Unnecessary; we can use cscope/tags/grep/etc to find this.
>
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
> > names, and I have maintained an out-of-tree patch for a long time [1].
> > Recently, we found more and more devices can cause the same problem, and
> > it is very difficult to modify all problematic drivers as radeon/amdgpu
> > does (the .shutdown callback should make sure there is no DMA activity).
> > So, I think modify the PCIe port driver is a simple and effective way.
> > And as early discussed, kexec can still work after this patch.
>
> Link to this discussion as well?
>
> This commit log does not contain a clear description of the problem
> and how the patch fixes it.
>
> > [1] https://github.com/chenhuacai/linux/commit/8da06f9b669831829416a3e9f4d1c57f217a42f0
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

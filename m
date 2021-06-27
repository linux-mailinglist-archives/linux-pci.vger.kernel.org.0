Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C66A53B52BD
	for <lists+linux-pci@lfdr.de>; Sun, 27 Jun 2021 11:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhF0J5a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Jun 2021 05:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhF0J53 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Jun 2021 05:57:29 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA6FC061574
        for <linux-pci@vger.kernel.org>; Sun, 27 Jun 2021 02:55:05 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id f21so2826195ioh.13
        for <linux-pci@vger.kernel.org>; Sun, 27 Jun 2021 02:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t2lImDF7ZchwDVs5ZnXpwAdW06KZbMTdmNtEtlPT8Vk=;
        b=MX9mWMD+iqI1KNB1ErhIwDHCDqWYPaOWSPG5XJIGWpbUPUw+YUHimwnIZb8fq/I2mT
         i81lJYtdijO2QXNETsIuESk+cA5qi6WnNDzi+ghGy3TFZbpQm5hZnzSd/PsmBOOXwObI
         PnlBXinxeQ4KsGO8I9BkahUEoz92sR+VJA9Y6qtjpdCG1bGm9K0/wf+XhJS72hxHVrUs
         AOONp/uE5Xp/R8E7MRxyfcPboUnV0PiWeohmqow4xHtzV/45axZLmhWS48h2L6RO5q0s
         rPPG7nG3CO7BGbarxo0sKUQL68xeV+AOb9tBNDzKQfj7CVIBYs3oYkbTgaxscbWi7S4M
         4uNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t2lImDF7ZchwDVs5ZnXpwAdW06KZbMTdmNtEtlPT8Vk=;
        b=eX8g6rR9QkIIemc6kSGDlRx649BMUcJvwrMKzPvrk+2mridr/+ywQeYkhALUP4i7q4
         8OwTOv4lLt1pXzJD6rr5fOmGbR0dIwXrrUdNFPCZSc4H13QWG5E6tEr7KxL/t9Szq39e
         9EBxejtIeIo8v5rb4spHShyLe2gFYhNTcl7EXB5J0lkaRoqtdIj2XEXfT5kBjj6v+ItW
         cnU4G1s3yMcUnui4QDVTWfvlNKXdq0k3pfzgsBffd++YeoeccwSrCa07Rd9mD3kHOqF5
         ngDP1v0IPuzx7WK3EsNtSr26XNyZI+6phgOkrxymfu6CGPkzoTGro3XYjlLef0E7uiOQ
         eqkQ==
X-Gm-Message-State: AOAM5335HRZ5hGXMx545BPwLcR4DUfZv669OEJTzZhyOtaxWGMBZr/2z
        Tp9ZDPtfVD5tHfNiSJCMr55r/Jf4TZNji8U4gUM=
X-Google-Smtp-Source: ABdhPJyoW9aJdO36bmkb/Lo5KTcSql8QMTGAd5Tp9LyEYwI6XYfpMMM/4SkREpGoURhrekM7pguo7UoaA1KOrj+e1aI=
X-Received: by 2002:a5d:9a97:: with SMTP id c23mr16483891iom.38.1624787703714;
 Sun, 27 Jun 2021 02:55:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210625093030.3698570-3-chenhuacai@loongson.cn> <20210626153928.GA3737896@bjorn-Precision-5520>
In-Reply-To: <20210626153928.GA3737896@bjorn-Precision-5520>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sun, 27 Jun 2021 17:54:52 +0800
Message-ID: <CAAhV-H7QDtei_-PWrTYdhap2c-bOkEzSFDYc6pJr5Rmeb1zW8w@mail.gmail.com>
Subject: Re: [PATCH V3 2/4] PCI: Move loongson pci quirks to quirks.c
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Bjorn,

On Sat, Jun 26, 2021 at 11:39 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Jun 25, 2021 at 05:30:28PM +0800, Huacai Chen wrote:
> > Loongson PCH (LS7A chipset) will be used by both MIPS-based and
> > LoongArch-based Loongson processors. MIPS-based Loongson uses FDT
> > but LoongArch-base Loongson uses ACPI, but the driver in drivers/
> > pci/controller/pci-loongson.c is FDT-only. So move the quirks to
> > quirks.c where can be shared by all architectures.
> >
> > LoongArch is a new RISC ISA, mainline support will come soon, and
> > documentations are here (in translation):
> >
> > https://github.com/loongson/LoongArch-Documentation
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  drivers/pci/controller/pci-loongson.c | 69 ---------------------------
> >  drivers/pci/quirks.c                  | 69 +++++++++++++++++++++++++++
> >  2 files changed, 69 insertions(+), 69 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
> > index 48169b1e3817..88066e9db69e 100644
> > --- a/drivers/pci/controller/pci-loongson.c
> > +++ b/drivers/pci/controller/pci-loongson.c
> > @@ -12,15 +12,6 @@
> >
> >  #include "../pci.h"
> >
> > -/* Device IDs */
> > -#define DEV_PCIE_PORT_0      0x7a09
> > -#define DEV_PCIE_PORT_1      0x7a19
> > -#define DEV_PCIE_PORT_2      0x7a29
> > -
> > -#define DEV_LS2K_APB 0x7a02
> > -#define DEV_LS7A_CONF        0x7a10
> > -#define DEV_LS7A_LPC 0x7a0c
> > -
> >  #define FLAG_CFG0    BIT(0)
> >  #define FLAG_CFG1    BIT(1)
> >  #define FLAG_DEV_FIX BIT(2)
> > @@ -32,66 +23,6 @@ struct loongson_pci {
> >       u32 flags;
> >  };
> >
> > -/* Fixup wrong class code in PCIe bridges */
> > -static void bridge_class_quirk(struct pci_dev *dev)
> > -{
> > -     dev->class = PCI_CLASS_BRIDGE_PCI << 8;
> > -}
> > -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> > -                     DEV_PCIE_PORT_0, bridge_class_quirk);
> > -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> > -                     DEV_PCIE_PORT_1, bridge_class_quirk);
> > -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> > -                     DEV_PCIE_PORT_2, bridge_class_quirk);
> > -
> > -static void system_bus_quirk(struct pci_dev *pdev)
> > -{
> > -     /*
> > -      * The address space consumed by these devices is outside the
> > -      * resources of the host bridge.
> > -      */
> > -     pdev->mmio_always_on = 1;
> > -     pdev->non_compliant_bars = 1;
> > -}
> > -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> > -                     DEV_LS2K_APB, system_bus_quirk);
> > -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> > -                     DEV_LS7A_CONF, system_bus_quirk);
> > -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> > -                     DEV_LS7A_LPC, system_bus_quirk);
> > -
> > -static void loongson_mrrs_quirk(struct pci_dev *dev)
> > -{
> > -     struct pci_bus *bus = dev->bus;
> > -     struct pci_dev *bridge;
> > -     static const struct pci_device_id bridge_devids[] = {
> > -             { PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_0) },
> > -             { PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_1) },
> > -             { PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_2) },
> > -             { 0, },
> > -     };
> > -
> > -     /* look for the matching bridge */
> > -     while (!pci_is_root_bus(bus)) {
> > -             bridge = bus->self;
> > -             bus = bus->parent;
> > -             /*
> > -              * Some Loongson PCIe ports have a h/w limitation of
> > -              * 256 bytes maximum read request size. They can't handle
> > -              * anything larger than this. So force this limit on
> > -              * any devices attached under these ports.
> > -              */
> > -             if (pci_match_id(bridge_devids, bridge)) {
> > -                     if (pcie_get_readrq(dev) > 256) {
> > -                             pci_info(dev, "limiting MRRS to 256\n");
> > -                             pcie_set_readrq(dev, 256);
> > -                     }
> > -                     break;
> > -             }
> > -     }
> > -}
> > -DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_mrrs_quirk);
> > -
> >  static void __iomem *cfg1_map(struct loongson_pci *priv, int bus,
> >                               unsigned int devfn, int where)
> >  {
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 22b2bb1109c9..dee4798a49fc 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -205,6 +205,75 @@ static void quirk_mmio_always_on(struct pci_dev *dev)
> >  DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_ANY_ID, PCI_ANY_ID,
> >                               PCI_CLASS_BRIDGE_HOST, 8, quirk_mmio_always_on);
> >
> > +/* Loongson-related quirks */
> > +#define DEV_PCIE_PORT_0      0x7a09
> > +#define DEV_PCIE_PORT_1      0x7a19
> > +#define DEV_PCIE_PORT_2      0x7a29
> > +
> > +#define DEV_LS2K_APB 0x7a02
> > +#define DEV_LS7A_CONF        0x7a10
> > +#define DEV_LS7A_LPC 0x7a0c
> > +
> > +/* Fixup wrong class code in PCIe bridges */
> > +static void loongson_bridge_class_quirk(struct pci_dev *dev)
> > +{
> > +     dev->class = PCI_CLASS_BRIDGE_PCI << 8;
> > +}
> > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> > +                     DEV_PCIE_PORT_0, loongson_bridge_class_quirk);
> > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> > +                     DEV_PCIE_PORT_1, loongson_bridge_class_quirk);
> > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> > +                     DEV_PCIE_PORT_2, loongson_bridge_class_quirk);
> > +
> > +static void loongson_system_bus_quirk(struct pci_dev *pdev)
> > +{
> > +     /*
> > +      * The address space consumed by these devices is outside the
> > +      * resources of the host bridge.
> > +      */
> > +     pdev->mmio_always_on = 1;
> > +     pdev->non_compliant_bars = 1;
> > +}
> > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> > +                     DEV_LS2K_APB, loongson_system_bus_quirk);
> > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> > +                     DEV_LS7A_CONF, loongson_system_bus_quirk);
> > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> > +                     DEV_LS7A_LPC, loongson_system_bus_quirk);
> > +
> > +static void loongson_mrrs_quirk(struct pci_dev *dev)
> > +{
> > +     struct pci_bus *bus = dev->bus;
> > +     struct pci_dev *bridge;
> > +     static const struct pci_device_id bridge_devids[] = {
> > +             { PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_0) },
> > +             { PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_1) },
> > +             { PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_2) },
> > +             { 0, },
> > +     };
> > +
> > +     /* look for the matching bridge */
> > +     while (!pci_is_root_bus(bus)) {
> > +             bridge = bus->self;
> > +             bus = bus->parent;
> > +             /*
> > +              * Some Loongson PCIe ports have a h/w limitation of
> > +              * 256 bytes maximum read request size. They can't handle
> > +              * anything larger than this. So force this limit on
> > +              * any devices attached under these ports.
> > +              */
> > +             if (pci_match_id(bridge_devids, bridge)) {
> > +                     if (pcie_get_readrq(dev) > 256) {
> > +                             pci_info(dev, "limiting MRRS to 256\n");
> > +                             pcie_set_readrq(dev, 256);
> > +                     }
> > +                     break;
> > +             }
> > +     }
> > +}
> > +DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_mrrs_quirk);
>
> I don't want to run this quirk on *every* PCI device on *every* system
> in the world when the defect is not even in these devices at all.  The
> defect is apparently in some Loongson hardware, so the quirk should
> somehow be limited to that.
I'm very sorry that you have told me this problem twice but I forgot
it later, I will improve in the next version.

Huacai
>
> >  /*
> >   * The Mellanox Tavor device gives false positive parity errors.  Disable
> >   * parity error reporting.
> > --
> > 2.27.0
> >

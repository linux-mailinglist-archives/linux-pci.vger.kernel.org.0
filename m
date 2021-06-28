Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98DFD3B5C92
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jun 2021 12:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbhF1Klb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Jun 2021 06:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbhF1Klb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jun 2021 06:41:31 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123ADC061574
        for <linux-pci@vger.kernel.org>; Mon, 28 Jun 2021 03:39:04 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id s19so21635726ioc.3
        for <linux-pci@vger.kernel.org>; Mon, 28 Jun 2021 03:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dOpTJKcbnvBejYpVqZ4Baj+qrPRkhUa0C+SQg4M1GAQ=;
        b=RtjcRpd71HxQdY6KdkwqlqcUnBHLecUuIdzLzl16Nidi1JE9TNTU8RzfPRXISYTn0x
         EAXMUGcpU4lFNK4C0vxagK0+YfSHj5Pid0INVL7vIxYFWUQo2j/3MaYyaA1rE70lrpQm
         AXoCORK4o28a84frdk0kwKfGtzWRLRGIv0krrBmNgZqYyijm5Qavz3y9qZJvqB6usPey
         0AlUONnPWalyFLrRW+jCCSvnXpwmI4I6yHr5YJz//1EQtO8BVEEO+8aZ76vyRoNjly2Z
         YZXK/EB9tXNYnzVx1B7hOKz52RrHSQDq27je4JhSnhbt/Qcz4eQ1eGNN30Tr50pPWE06
         wVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dOpTJKcbnvBejYpVqZ4Baj+qrPRkhUa0C+SQg4M1GAQ=;
        b=DZtxM/oaF2k3TzXyyRVbqnpbHHTpFOAJrZYY4x0Ce5F7Br7eO8e83j8bBRie6vY3He
         IWXZTXb9Vp2z82GORqUdjFMKYUs5sEc+aKLLkHYtT7+N+oTMWE4rm0lqO6+tUyxXXLUS
         zh7uVFRhAJyoRUhq7XU4ygL+qM2LW494Uz6JN2R+aHlIslfXIuvMXVySHvd5orXv+tVB
         Er5D4nJD0GxBJ6E3dDKXm2d8VtYPxvZMTC15rXZ6miVzZnrzLLSVODZxdsBxucdatZCl
         /oD+w9oD4xr8SpDRksyg3R6X05DoPwA+1WPImwKzalv3ffLnHs8ovWs4MtV6aFPftElv
         YPlA==
X-Gm-Message-State: AOAM532VIQ1jN2XR0uA2CY3TCOPF/qcQKmfLHbLX1e/4ZJE7NpnfrIuX
        V89+6DovqXD6aOTrhXIzsnSougKixVtfeMok8J0=
X-Google-Smtp-Source: ABdhPJzwOxlJWXQdZqtsq/qqFSy5uqUwLg1h9N9nUKgXRU1bZ35t945xITfDFZrAJchQ+gcu/Ec5DLeXG97LdvWYWsc=
X-Received: by 2002:a5d:9a97:: with SMTP id c23mr20844116iom.38.1624876743547;
 Mon, 28 Jun 2021 03:39:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210628101027.1372370-1-chenhuacai@loongson.cn>
 <20210628101027.1372370-3-chenhuacai@loongson.cn> <bcde3fa6-9292-3f59-cb39-30ed0f311291@flygoat.com>
In-Reply-To: <bcde3fa6-9292-3f59-cb39-30ed0f311291@flygoat.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Mon, 28 Jun 2021 18:38:51 +0800
Message-ID: <CAAhV-H4rK5uGtDDJDg02i-gNpMSzYLGO5pLUsAYfjUWYtJPi3w@mail.gmail.com>
Subject: Re: [PATCH V4 2/4] PCI: Move loongson pci quirks to quirks.c
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Jiaxun,

On Mon, Jun 28, 2021 at 6:13 PM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote=
:
>
>
>
> =E5=9C=A8 2021/6/28 =E4=B8=8B=E5=8D=886:10, Huacai Chen =E5=86=99=E9=81=
=93:
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
>
> Probably you should guard it with CONFIG_MACH_LOONGSON64 now and add
> CONFIG_LOONGARCH
> once LOONGARCH code is mainlined.
These quirks won't match non-Loongson platforms (because they are
matched by pci ids), so I think that is unnecessary.

Huacai
>
> Thanks.
>
> - Jiaxun
>
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >   drivers/pci/controller/pci-loongson.c | 69 --------------------------=
-
> >   drivers/pci/quirks.c                  | 69 ++++++++++++++++++++++++++=
+
> >   2 files changed, 69 insertions(+), 69 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/contro=
ller/pci-loongson.c
> > index 48169b1e3817..88066e9db69e 100644
> > --- a/drivers/pci/controller/pci-loongson.c
> > +++ b/drivers/pci/controller/pci-loongson.c
> > @@ -12,15 +12,6 @@
> >
> >   #include "../pci.h"
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
> >   #define FLAG_CFG0   BIT(0)
> >   #define FLAG_CFG1   BIT(1)
> >   #define FLAG_DEV_FIX        BIT(2)
> > @@ -32,66 +23,6 @@ struct loongson_pci {
> >       u32 flags;
> >   };
> >
> > -/* Fixup wrong class code in PCIe bridges */
> > -static void bridge_class_quirk(struct pci_dev *dev)
> > -{
> > -     dev->class =3D PCI_CLASS_BRIDGE_PCI << 8;
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
> > -     pdev->mmio_always_on =3D 1;
> > -     pdev->non_compliant_bars =3D 1;
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
> > -     struct pci_bus *bus =3D dev->bus;
> > -     struct pci_dev *bridge;
> > -     static const struct pci_device_id bridge_devids[] =3D {
> > -             { PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_0) },
> > -             { PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_1) },
> > -             { PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_2) },
> > -             { 0, },
> > -     };
> > -
> > -     /* look for the matching bridge */
> > -     while (!pci_is_root_bus(bus)) {
> > -             bridge =3D bus->self;
> > -             bus =3D bus->parent;
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
> >   static void __iomem *cfg1_map(struct loongson_pci *priv, int bus,
> >                               unsigned int devfn, int where)
> >   {
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 22b2bb1109c9..dee4798a49fc 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -205,6 +205,75 @@ static void quirk_mmio_always_on(struct pci_dev *d=
ev)
> >   DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_ANY_ID, PCI_ANY_ID,
> >                               PCI_CLASS_BRIDGE_HOST, 8, quirk_mmio_alwa=
ys_on);
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
> > +     dev->class =3D PCI_CLASS_BRIDGE_PCI << 8;
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
> > +     pdev->mmio_always_on =3D 1;
> > +     pdev->non_compliant_bars =3D 1;
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
> > +     struct pci_bus *bus =3D dev->bus;
> > +     struct pci_dev *bridge;
> > +     static const struct pci_device_id bridge_devids[] =3D {
> > +             { PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_0) },
> > +             { PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_1) },
> > +             { PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_2) },
> > +             { 0, },
> > +     };
> > +
> > +     /* look for the matching bridge */
> > +     while (!pci_is_root_bus(bus)) {
> > +             bridge =3D bus->self;
> > +             bus =3D bus->parent;
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
> > +
> >   /*
> >    * The Mellanox Tavor device gives false positive parity errors.  Dis=
able
> >    * parity error reporting.
>

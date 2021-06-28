Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A35E63B5CC4
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jun 2021 12:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbhF1K5j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Jun 2021 06:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbhF1K5j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jun 2021 06:57:39 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9DBC061574
        for <linux-pci@vger.kernel.org>; Mon, 28 Jun 2021 03:55:12 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id b15so3412149iow.4
        for <linux-pci@vger.kernel.org>; Mon, 28 Jun 2021 03:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wv8vjesbGKf5wPZT/BMp1Y6Fg2yrZlUIzmEl2IsK+cw=;
        b=P3XKBSGWzu6TKzfO6IkH+oJAR/rsIKsL/xCcelRrC8s8P6ZklQBBpgOCdGFOZiK5gu
         COhBh/aK6wtOFV8dw4L0N1cl69rO5E8e1UcXWn1Yqbm5f9S5dmu3M1DLO1opY29xhWH5
         O+7lBnDjtBVOcOCKjv+ChVSf8PjKuM3dQ4tQtxGpZDk3QBiF3za8RmtE5S5CVS98/ABO
         /Uj2/73Ng6SNlh6VBW3OS6YF73SMTjalmSisYjccre+WbJ0KpVv45ciYRG1kGPkwtM2h
         /uhdt9H82Q8xKk8Om3yjr3QZHgR44+s/kWPfMqKNRF+s+DtRyCaaMqbI0ax16J+YKlbQ
         wx8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wv8vjesbGKf5wPZT/BMp1Y6Fg2yrZlUIzmEl2IsK+cw=;
        b=rlKYweziKFVXebt5te16Iw01oyp4VFlmbUp9Cba6JcVqVwiqPg8Q5xOZemSWqjDps3
         Y0IT10gpNr4O56CEI9CrApqPydlQ42tp88L/3HYIK3JETl6q/n/8T/6naaA2TERXqGP/
         oGRWEDmYdE1IWc2L449CRrHf9g3FOKD5AxZJmuQOElWepDmzDhzIH1g8DsgAWrel6yLb
         MP2NM1KwcuSFI2xZMgZZHAxMgDh7OXPsyB/rhvTs1Lst2ZpTp18mXUY156oQMFDIVzIP
         3xLVjARQYBD5klSI+hKkVFW/etbfWzAhFwcWIXxeoPAK2aZtCSbFc05xuMzXulLbv1qo
         Q7vA==
X-Gm-Message-State: AOAM530NUNqt9igdNEXMH30fquPvIMOEKi3+lhUI2id6WUyndIrl0RjO
        zxvEDYJenGLl2ZOrIyHaB+N93hh+7+2VvWVR1GQ=
X-Google-Smtp-Source: ABdhPJzMyRIqW+cX/LpOJcPfNuUpwlmSOfc6pt/F4srLeMvmTqNQGxIynAfBvpRUyRa/pC9+XBB04beupLK/mOO0oos=
X-Received: by 2002:a05:6638:d4b:: with SMTP id d11mr22142519jak.112.1624877712404;
 Mon, 28 Jun 2021 03:55:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210628101027.1372370-1-chenhuacai@loongson.cn>
 <20210628101027.1372370-3-chenhuacai@loongson.cn> <bcde3fa6-9292-3f59-cb39-30ed0f311291@flygoat.com>
 <CAAhV-H4rK5uGtDDJDg02i-gNpMSzYLGO5pLUsAYfjUWYtJPi3w@mail.gmail.com> <1b42d46f-8332-204e-62d6-d0903d5a0af7@flygoat.com>
In-Reply-To: <1b42d46f-8332-204e-62d6-d0903d5a0af7@flygoat.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Mon, 28 Jun 2021 18:55:00 +0800
Message-ID: <CAAhV-H524hSStZRzO2Nsthi86mHu2e4dernPM8_bX+zEN5qiKQ@mail.gmail.com>
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

On Mon, Jun 28, 2021 at 6:41 PM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote=
:
>
>
>
> =E5=9C=A8 2021/6/28 =E4=B8=8B=E5=8D=886:38, Huacai Chen =E5=86=99=E9=81=
=93:
> > Hi, Jiaxun,
> >
> > On Mon, Jun 28, 2021 at 6:13 PM Jiaxun Yang <jiaxun.yang@flygoat.com> w=
rote:
> >>
> >>
> >> =E5=9C=A8 2021/6/28 =E4=B8=8B=E5=8D=886:10, Huacai Chen =E5=86=99=E9=
=81=93:
> >>> Loongson PCH (LS7A chipset) will be used by both MIPS-based and
> >>> LoongArch-based Loongson processors. MIPS-based Loongson uses FDT
> >>> but LoongArch-base Loongson uses ACPI, but the driver in drivers/
> >>> pci/controller/pci-loongson.c is FDT-only. So move the quirks to
> >>> quirks.c where can be shared by all architectures.
> >>>
> >>> LoongArch is a new RISC ISA, mainline support will come soon, and
> >>> documentations are here (in translation):
> >>>
> >>> https://github.com/loongson/LoongArch-Documentation
> >> Probably you should guard it with CONFIG_MACH_LOONGSON64 now and add
> >> CONFIG_LOONGARCH
> >> once LOONGARCH code is mainlined.
> > These quirks won't match non-Loongson platforms (because they are
> > matched by pci ids), so I think that is unnecessary.
> Are you sure?
> As I saw
> +DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID
> It will slow down boot progress on all systems.
This ANY ID matching is only used by loongson_mrrs_quirk(), but the
next patch will rework loongson_mrrs_quirk().

Huacai
>
> Thanks.
>
> - Jiaxun
> >
> > Huacai
> >> Thanks.
> >>
> >> - Jiaxun
> >>
> >>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> >>> ---
> >>>    drivers/pci/controller/pci-loongson.c | 69 -----------------------=
----
> >>>    drivers/pci/quirks.c                  | 69 +++++++++++++++++++++++=
++++
> >>>    2 files changed, 69 insertions(+), 69 deletions(-)
> >>>
> >>> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/cont=
roller/pci-loongson.c
> >>> index 48169b1e3817..88066e9db69e 100644
> >>> --- a/drivers/pci/controller/pci-loongson.c
> >>> +++ b/drivers/pci/controller/pci-loongson.c
> >>> @@ -12,15 +12,6 @@
> >>>
> >>>    #include "../pci.h"
> >>>
> >>> -/* Device IDs */
> >>> -#define DEV_PCIE_PORT_0      0x7a09
> >>> -#define DEV_PCIE_PORT_1      0x7a19
> >>> -#define DEV_PCIE_PORT_2      0x7a29
> >>> -
> >>> -#define DEV_LS2K_APB 0x7a02
> >>> -#define DEV_LS7A_CONF        0x7a10
> >>> -#define DEV_LS7A_LPC 0x7a0c
> >>> -
> >>>    #define FLAG_CFG0   BIT(0)
> >>>    #define FLAG_CFG1   BIT(1)
> >>>    #define FLAG_DEV_FIX        BIT(2)
> >>> @@ -32,66 +23,6 @@ struct loongson_pci {
> >>>        u32 flags;
> >>>    };
> >>>
> >>> -/* Fixup wrong class code in PCIe bridges */
> >>> -static void bridge_class_quirk(struct pci_dev *dev)
> >>> -{
> >>> -     dev->class =3D PCI_CLASS_BRIDGE_PCI << 8;
> >>> -}
> >>> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> >>> -                     DEV_PCIE_PORT_0, bridge_class_quirk);
> >>> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> >>> -                     DEV_PCIE_PORT_1, bridge_class_quirk);
> >>> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> >>> -                     DEV_PCIE_PORT_2, bridge_class_quirk);
> >>> -
> >>> -static void system_bus_quirk(struct pci_dev *pdev)
> >>> -{
> >>> -     /*
> >>> -      * The address space consumed by these devices is outside the
> >>> -      * resources of the host bridge.
> >>> -      */
> >>> -     pdev->mmio_always_on =3D 1;
> >>> -     pdev->non_compliant_bars =3D 1;
> >>> -}
> >>> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> >>> -                     DEV_LS2K_APB, system_bus_quirk);
> >>> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> >>> -                     DEV_LS7A_CONF, system_bus_quirk);
> >>> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> >>> -                     DEV_LS7A_LPC, system_bus_quirk);
> >>> -
> >>> -static void loongson_mrrs_quirk(struct pci_dev *dev)
> >>> -{
> >>> -     struct pci_bus *bus =3D dev->bus;
> >>> -     struct pci_dev *bridge;
> >>> -     static const struct pci_device_id bridge_devids[] =3D {
> >>> -             { PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_0) },
> >>> -             { PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_1) },
> >>> -             { PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_2) },
> >>> -             { 0, },
> >>> -     };
> >>> -
> >>> -     /* look for the matching bridge */
> >>> -     while (!pci_is_root_bus(bus)) {
> >>> -             bridge =3D bus->self;
> >>> -             bus =3D bus->parent;
> >>> -             /*
> >>> -              * Some Loongson PCIe ports have a h/w limitation of
> >>> -              * 256 bytes maximum read request size. They can't hand=
le
> >>> -              * anything larger than this. So force this limit on
> >>> -              * any devices attached under these ports.
> >>> -              */
> >>> -             if (pci_match_id(bridge_devids, bridge)) {
> >>> -                     if (pcie_get_readrq(dev) > 256) {
> >>> -                             pci_info(dev, "limiting MRRS to 256\n")=
;
> >>> -                             pcie_set_readrq(dev, 256);
> >>> -                     }
> >>> -                     break;
> >>> -             }
> >>> -     }
> >>> -}
> >>> -DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_mrrs_quirk=
);
> >>> -
> >>>    static void __iomem *cfg1_map(struct loongson_pci *priv, int bus,
> >>>                                unsigned int devfn, int where)
> >>>    {
> >>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> >>> index 22b2bb1109c9..dee4798a49fc 100644
> >>> --- a/drivers/pci/quirks.c
> >>> +++ b/drivers/pci/quirks.c
> >>> @@ -205,6 +205,75 @@ static void quirk_mmio_always_on(struct pci_dev =
*dev)
> >>>    DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_ANY_ID, PCI_ANY_ID,
> >>>                                PCI_CLASS_BRIDGE_HOST, 8, quirk_mmio_a=
lways_on);
> >>>
> >>> +/* Loongson-related quirks */
> >>> +#define DEV_PCIE_PORT_0      0x7a09
> >>> +#define DEV_PCIE_PORT_1      0x7a19
> >>> +#define DEV_PCIE_PORT_2      0x7a29
> >>> +
> >>> +#define DEV_LS2K_APB 0x7a02
> >>> +#define DEV_LS7A_CONF        0x7a10
> >>> +#define DEV_LS7A_LPC 0x7a0c
> >>> +
> >>> +/* Fixup wrong class code in PCIe bridges */
> >>> +static void loongson_bridge_class_quirk(struct pci_dev *dev)
> >>> +{
> >>> +     dev->class =3D PCI_CLASS_BRIDGE_PCI << 8;
> >>> +}
> >>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> >>> +                     DEV_PCIE_PORT_0, loongson_bridge_class_quirk);
> >>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> >>> +                     DEV_PCIE_PORT_1, loongson_bridge_class_quirk);
> >>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> >>> +                     DEV_PCIE_PORT_2, loongson_bridge_class_quirk);
> >>> +
> >>> +static void loongson_system_bus_quirk(struct pci_dev *pdev)
> >>> +{
> >>> +     /*
> >>> +      * The address space consumed by these devices is outside the
> >>> +      * resources of the host bridge.
> >>> +      */
> >>> +     pdev->mmio_always_on =3D 1;
> >>> +     pdev->non_compliant_bars =3D 1;
> >>> +}
> >>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> >>> +                     DEV_LS2K_APB, loongson_system_bus_quirk);
> >>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> >>> +                     DEV_LS7A_CONF, loongson_system_bus_quirk);
> >>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> >>> +                     DEV_LS7A_LPC, loongson_system_bus_quirk);
> >>> +
> >>> +static void loongson_mrrs_quirk(struct pci_dev *dev)
> >>> +{
> >>> +     struct pci_bus *bus =3D dev->bus;
> >>> +     struct pci_dev *bridge;
> >>> +     static const struct pci_device_id bridge_devids[] =3D {
> >>> +             { PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_0) },
> >>> +             { PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_1) },
> >>> +             { PCI_VDEVICE(LOONGSON, DEV_PCIE_PORT_2) },
> >>> +             { 0, },
> >>> +     };
> >>> +
> >>> +     /* look for the matching bridge */
> >>> +     while (!pci_is_root_bus(bus)) {
> >>> +             bridge =3D bus->self;
> >>> +             bus =3D bus->parent;
> >>> +             /*
> >>> +              * Some Loongson PCIe ports have a h/w limitation of
> >>> +              * 256 bytes maximum read request size. They can't hand=
le
> >>> +              * anything larger than this. So force this limit on
> >>> +              * any devices attached under these ports.
> >>> +              */
> >>> +             if (pci_match_id(bridge_devids, bridge)) {
> >>> +                     if (pcie_get_readrq(dev) > 256) {
> >>> +                             pci_info(dev, "limiting MRRS to 256\n")=
;
> >>> +                             pcie_set_readrq(dev, 256);
> >>> +                     }
> >>> +                     break;
> >>> +             }
> >>> +     }
> >>> +}
> >>> +DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_mrrs_quirk=
);
> >>> +
> >>>    /*
> >>>     * The Mellanox Tavor device gives false positive parity errors.  =
Disable
> >>>     * parity error reporting.
>

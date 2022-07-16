Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9931F576C58
	for <lists+linux-pci@lfdr.de>; Sat, 16 Jul 2022 09:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiGPHcQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Jul 2022 03:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiGPHcP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Jul 2022 03:32:15 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395C11AF04
        for <linux-pci@vger.kernel.org>; Sat, 16 Jul 2022 00:32:13 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id t127so6071260vsb.8
        for <linux-pci@vger.kernel.org>; Sat, 16 Jul 2022 00:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZeIeAQ5O0PJc1AeTfyUU2c4K/msu4VsnXnc5IiTjhKI=;
        b=BHFQiFxlxVbYc8Ks+5I8ylbjeKM16ONUGhU10Z11GfleciEnZ2aR+K5UsdNtajcxN8
         ZpLmww7/X2mkmPia/uY+ol8ApSNNzYckCLXk4L1EHFRaJzlBTeDRcXC8i8x5W0AbSThJ
         OjAjq+ORGlaHFbU+OBLOBHvdNY11JxEyVJ0iUPtlE8WCaoRVgdlAyvNV1Mv9DyIU+sQb
         2X+O5sW71c7GIl2AGZu+7fMMzRqKnOPZNBlot6At12I7hMv4+zeb3lizbAKniJ3XU24Z
         y153CtB7KQ+xWfJmf+wU/omIE5IpOEE6i2iNPJ8Q3by2+6uhV4ty2mDiiNO+BF1FA1s0
         18IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZeIeAQ5O0PJc1AeTfyUU2c4K/msu4VsnXnc5IiTjhKI=;
        b=o9r1n3nEWSUw3GGXKFdrJkD0hgvLI6c4UNi9cqAEFr29UW+cT7dTRnbic5bY12uD+z
         i1EwuqxTBHhCXLHHzKiJFl3oc/vUhOOdACH4NTjH7MX0o7sl0Cw5S5vZmYPEAYJFjf1E
         8b6z/DflQFAHrDpPRJZ2HQTbQ/RN76PFib6TGAk6wd2soyM01wQ+jMtAZdbbV5jZXaYQ
         LHXiQ6THlSh8a3zWg8JsCEubl70/zWd/oX0ukCz6B5gEkyw143yCOZTIYO/WDw3TcH+H
         87lDsX5oEkEAFaY2+/F1S8ObTzYrqCTvn48P9mVpoXabCW0eVmEV3djBux4Aq8+1+YNx
         +HiQ==
X-Gm-Message-State: AJIora9OwP90u22Y+YokOJ3CBRi3tjPhU1m+XJSeEJJuMI6abGi8wlAz
        lSyhgROJETJ+4Y+Vl4sH+F8F204WTN4VIwvpcD/hGe6akMSsIaLI
X-Google-Smtp-Source: AGRyM1t7sb2hJe84L53NbjhfD+1LqXhfB7jJKZF1zYur7SVaOKKg1pdKMANT1nQ2Z4kj/KmxF/JeER+0ZvwxUAWN6uM=
X-Received: by 2002:a67:ec05:0:b0:357:7a48:cba8 with SMTP id
 d5-20020a67ec05000000b003577a48cba8mr7489686vso.78.1657956732263; Sat, 16 Jul
 2022 00:32:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220714124216.1489304-1-chenhuacai@loongson.cn>
 <20220714124216.1489304-6-chenhuacai@loongson.cn> <05be8921-8287-b939-bde8-983dbbfeac62@loongson.cn>
In-Reply-To: <05be8921-8287-b939-bde8-983dbbfeac62@loongson.cn>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sat, 16 Jul 2022 15:31:59 +0800
Message-ID: <CAAhV-H5M9buy2an5R3FX=77m9uRLStztbtpbs8NgiBqCbLtJ1w@mail.gmail.com>
Subject: Re: [PATCH V16 5/7] PCI: loongson: Improve the MRRS quirk for LS7A
To:     Jianmin Lv <lvjianmin@loongson.cn>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Jianmin,

On Sat, Jul 16, 2022 at 3:15 PM Jianmin Lv <lvjianmin@loongson.cn> wrote:
>
> Hi, Huacai and Bjorn,
>
> Actually, I don't think we have to fix the MRRS issue of 7A in this
> way(change core code of PCI). The reasons are:
>
> - First, we don't know if other pci controlers have simillar issue, at
> least I don't see yet. I think if *only we* have the issue, maybe we can
> fix it in our controller driver rather than changing core code. And in
> future, if the issue is proved a common one, abstract it then by common w=
ay.
>
Keystone's pci controller has the same problem (maybe DesignWare based
controllers all have the same problem), this is discussed for a long
time.

Huacai
> - Second, even though we limit the MRRS in pcie_set_readrq() according
> to the flag set in quirk function, some drivers(e.g. in
> drivers/rapidio/devices/tsi721.c, maybe other driver do this in future,
> I dont't know.) directly call pcie_capability_clear_and_set_word to set
> MRRS, which will still break the fix.
>
> - Third, on resuming from S3, the MRRS stored in memory should be
> allowed to set to dev ctrl reg(because the reg has been reset during S3).
>
>
> Fix MMRS in our controller driver by using self-defined config_write(),
> maybe like this:
>
> static u32 handle_mrrs_limit(struct pci_bus *bus, unsigned int devfn,
> void __iomem *addr, u32 val)
> {
>       u32 tmp;
>       bool runtime_flag =3D 1;
>       int pos =3D pci_bus_find_capability_nolock(bus, devfn, PCI_CAP_ID_E=
XP);
>
> #ifdef CONFIG_PM_SLEEP
>        if (pm_suspend_target_state =3D=3D PM_SUSPEND_ON)
>              runtime_flag =3D 0;
> #endif
>
>        if (resume_flag && pos !=3D 0 && (pos + PCI_EXP_DEVCTL) =3D=3D reg=
) {
>              tmp =3D readl(addr);
>              if ((val & PCI_EXP_DEVCTL_READRQ) > (tmp &
> PCI_EXP_DEVCTL_READRQ)) {
>                      val &=3D ~PCI_EXP_DEVCTL_READRQ;
>                      val |=3D (tmp & PCI_EXP_DEVCTL_READRQ);
>              }
>        }
>        return val;
>
> }
>
>
> static int loongson_pci_config_write32(struct pci_bus *bus, unsigned int
> devfn,
>                                 int where, int size, u32 val)
> {
>          void __iomem *addr;
>          u32 mask, tmp;
>          int reg =3D where & ~3;
>
>          addr =3D bus->ops->map_bus(bus, devfn, where & ~0x3);
>          if (!addr)
>                  return PCIBIOS_DEVICE_NOT_FOUND;
>          val =3D handle_mrrs_limit(bus, devfn, addr, reg, val);
>          writel(val, addr);
>
>          return PCIBIOS_SUCCESSFUL;
> }
>
> And I still have to emphasize on the fix in this way: It's still does
> not work for pciehp. It's only used for addressing MRRS issue of 7A
> revisions which have no pciehp support.
>
> And in future, for new revision, we just need to skip handle_mrrs_limit.
>
> The way described here is just my immature opinion, we can discuss it
> if required.
>
> Thanks.
>
> On 2022/7/14 =E4=B8=8B=E5=8D=888:42, Huacai Chen wrote:
> > In new revision of LS7A, some PCIe ports support larger value than 256,
> > but their maximum supported MRRS values are not detectable. Moreover,
> > the current loongson_mrrs_quirk() cannot avoid devices increasing its
> > MRRS after pci_enable_device(), and some devices (e.g. Realtek 8169)
> > will actually set a big value in its driver. So the only possible way
> > is configure MRRS of all devices in BIOS, and add a pci host bridge bit
> > flag (i.e., no_inc_mrrs) to stop the increasing MRRS operations.
> >
> > However, according to PCIe Spec, it is legal for an OS to program any
> > value for MRRS, and it is also legal for an endpoint to generate a Read
> > Request with any size up to its MRRS. As the hardware engineers say, th=
e
> > root cause here is LS7A doesn't break up large read requests. In detail=
,
> > LS7A PCIe port reports CA (Completer Abort) if it receives a Memory Rea=
d
> > request with a size that's "too big" ("too big" means larger than the
> > PCIe ports can handle, which means 256 for some ports and 4096 for the
> > others, and of course this is a problem in the LS7A's hardware design).
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >   drivers/pci/controller/pci-loongson.c | 44 +++++++++-----------------=
-
> >   drivers/pci/pci.c                     |  6 ++++
> >   include/linux/pci.h                   |  1 +
> >   3 files changed, 22 insertions(+), 29 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/contro=
ller/pci-loongson.c
> > index 594653154deb..af73bb766e48 100644
> > --- a/drivers/pci/controller/pci-loongson.c
> > +++ b/drivers/pci/controller/pci-loongson.c
> > @@ -68,37 +68,23 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> >   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> >                       DEV_LS7A_LPC, system_bus_quirk);
> >
> > -static void loongson_mrrs_quirk(struct pci_dev *dev)
> > +static void loongson_mrrs_quirk(struct pci_dev *pdev)
> >   {
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
> > +     /*
> > +      * Some Loongson PCIe ports have h/w limitations of maximum read
> > +      * request size. They can't handle anything larger than this. So
> > +      * force this limit on any devices attached under these ports.
> > +      */
> > +     struct pci_host_bridge *bridge =3D pci_find_host_bridge(pdev->bus=
);
> > +
> > +     bridge->no_inc_mrrs =3D 1;
> >   }
> > -DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_mrrs_quirk);
> > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> > +                     DEV_PCIE_PORT_0, loongson_mrrs_quirk);
> > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> > +                     DEV_PCIE_PORT_1, loongson_mrrs_quirk);
> > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> > +                     DEV_PCIE_PORT_2, loongson_mrrs_quirk);
> >
> >   static struct loongson_pci *pci_bus_to_loongson_pci(struct pci_bus *b=
us)
> >   {
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index cfaf40a540a8..79157cbad835 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -6052,6 +6052,7 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
> >   {
> >       u16 v;
> >       int ret;
> > +     struct pci_host_bridge *bridge =3D pci_find_host_bridge(dev->bus)=
;
> >
> >       if (rq < 128 || rq > 4096 || !is_power_of_2(rq))
> >               return -EINVAL;
> > @@ -6070,6 +6071,11 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
> >
> >       v =3D (ffs(rq) - 8) << 12;
> >
> > +     if (bridge->no_inc_mrrs) {
> > +             if (rq > pcie_get_readrq(dev))
> > +                     return -EINVAL;
> > +     }
> > +
> >       ret =3D pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
> >                                                 PCI_EXP_DEVCTL_READRQ, =
v);
> >
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 81a57b498f22..a9211074add6 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -569,6 +569,7 @@ struct pci_host_bridge {
> >       void            *release_data;
> >       unsigned int    ignore_reset_delay:1;   /* For entire hierarchy *=
/
> >       unsigned int    no_ext_tags:1;          /* No Extended Tags */
> > +     unsigned int    no_inc_mrrs:1;          /* No Increase MRRS */
> >       unsigned int    native_aer:1;           /* OS may use PCIe AER */
> >       unsigned int    native_pcie_hotplug:1;  /* OS may use PCIe hotplu=
g */
> >       unsigned int    native_shpc_hotplug:1;  /* OS may use SHPC hotplu=
g */
> >
>

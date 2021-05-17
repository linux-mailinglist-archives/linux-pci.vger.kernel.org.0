Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6865382C9C
	for <lists+linux-pci@lfdr.de>; Mon, 17 May 2021 14:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbhEQMzM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 May 2021 08:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbhEQMzM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 May 2021 08:55:12 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F75C061573
        for <linux-pci@vger.kernel.org>; Mon, 17 May 2021 05:53:55 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e10so4319023ilu.11
        for <linux-pci@vger.kernel.org>; Mon, 17 May 2021 05:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+xlqTxk/1FBf9Gf5qhPHgRn9P5wkfCBhHseeEh86KcM=;
        b=aHF/3uFBqhZMXAaRpdlrq1aUh9N1p7U/aftpAzanKp6qZoL71dv4u+pN1T8uM+yW5v
         oHymixuiLm+qkYb5cdfrKbqOGH47Z9dneol5kiZSm4bb86vGBtkq/90aebZ6T374Ct0X
         UelDRXezk+Xu6UG3s/KfLl0hdk+zIvagIDkxAdRp45roX7kbuxfY/mH1w+nvvBcaMf6N
         niRGwXrvVTTODny+OzUhS8rimNA8ffS7ugsg3FfZyEqh85Kty9r134nN0uYh9a86PkxQ
         q2Sxiamda+J0uSx3dxkm015VWBhexElEf0u5/DiK1m4jossC4BrQTbHPBRN403+ENEfX
         YS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+xlqTxk/1FBf9Gf5qhPHgRn9P5wkfCBhHseeEh86KcM=;
        b=tmZvGEVG+PSkDyjJ71dEUQVhFKTDRXfxL0aBnnFja0WsCUIV6rU6KEG5UOOq0PIraG
         fkTRWMfSzNB1QgXQZaXXv5SOT7APt1UnUukAxhZL1wK20Mg97t3V2Zd+Q8Roy8QyKqoy
         W2jcLBSxDZcVbs4SDcDuEk+okUYJ9+v4cA4YTJ/AGhhmeTh8aGroTWu5pupGJ5alat5e
         Us0xI/Z1edoCBPLvIVZGVQyqO6ItnCYDiqgnLu0BWUCwR48t0jCXzdy+0RVs8H0IRjJV
         7iwsAuwVPrYaOd8inIdRARq/dtfKTqPgyGVmOlRJjagwH9hafV558sorvpgTmUd5Rlup
         maCg==
X-Gm-Message-State: AOAM530Dmm0mHydj6TebhG/OWE9w4JREix2Nc515QZC0wClOPf5CvWjg
        xFtaJ5RLEq8Z8d813c4WmITTzfTBTFeax5+OdA0=
X-Google-Smtp-Source: ABdhPJzPbwF3nlaNyWmAxy6hrOJ2SjErQNXUY4/WM6qi+LE2orA2rqllfdLTUrFmybhxCQtG6hoZTsUyAij4Nm53phQ=
X-Received: by 2002:a05:6e02:92a:: with SMTP id o10mr154888ilt.270.1621256035110;
 Mon, 17 May 2021 05:53:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210514080025.1828197-6-chenhuacai@loongson.cn>
 <20210514151034.GA2759806@bjorn-Precision-5520> <CAAhV-H7Lo8eWZV170V2Q2bYK4A_6cCjGuhSZOUZ=MLBmVpUL3w@mail.gmail.com>
In-Reply-To: <CAAhV-H7Lo8eWZV170V2Q2bYK4A_6cCjGuhSZOUZ=MLBmVpUL3w@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Mon, 17 May 2021 20:53:43 +0800
Message-ID: <CAAhV-H6E3vh9+SZg5qOmVbfjENRPi0=UbLqK-YHcCA0mzcx9aw@mail.gmail.com>
Subject: Re: [PATCH 5/5] PCI: Support ASpeed VGA cards behind a misbehaving bridge
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jingfeng Sui <suijingfeng@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Bjorn,

On Sat, May 15, 2021 at 5:09 PM Huacai Chen <chenhuacai@gmail.com> wrote:
>
> Hi, Bjorn,
>
> On Fri, May 14, 2021 at 11:10 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Fri, May 14, 2021 at 04:00:25PM +0800, Huacai Chen wrote:
> > > According to PCI-to-PCI bridge spec, bit 3 of Bridge Control Register is
> > > VGA Enable bit which modifies the response to VGA compatible addresses.
> >
> > The bridge spec is pretty old, and most of the content has been
> > incorporated into the PCIe spec.  I think you can cite "PCIe r5.0, sec
> > 7.5.1.3.13" here instead.
> >
> > > If the VGA Enable bit is set, the bridge will decode and forward the
> > > following accesses on the primary interface to the secondary interface.
> >
> > *Which* following accesses?  The structure of English requires that if
> > you say "the following accesses," you must continue by *listing* the
> > accesses.
> >
> > > The ASpeed AST2500 hardward does not set the VGA Enable bit on its
> > > bridge control register, which causes vgaarb subsystem don't think the
> > > VGA card behind the bridge as a valid boot vga device.
> >
> > s/hardward/bridge/
> > s/vga/VGA/ (also in code comments and dmesg strings below)
> >
> > From the code, it looks like AST2500 ([1a03:2000]) is a VGA device,
> > since it apparently has a VGA class code.  But here you say the
> > AST2500 has a Bridge Control register, which suggests that it's a
> > bridge.  If AST2500 is some sort of combination that includes both a
> > bridge and a VGA device, please outline that topology.
> >
> > But the hardware defect is that some bridges forward VGA accesses even
> > though their VGA Enable bit is not set?  The quirk should be attached
> > to broken *bridges*, not to VGA devices.
> >
> > If a bridge forwards VGA accesses regardless of how its VGA Enable bit
> > is set, that means VGA arbitration (in vgaarb.c) cannot work
> > correctly, so merely setting the default VGA device once in a quirk is
> > not sufficient.  You would have to somehow disable any future attempts
> > to use other VGA devices.  Only the VGA device below this defective
> > bridge is usable.  Any other VGA devices in the system would be
> > useless.
> >
> > > So we provide a quirk to fix Xorg auto-detection.
> > >
> > > See similar bug:
> > >
> > > https://patchwork.kernel.org/project/linux-pci/patch/20170619023528.11532-1-dja@axtens.net/
> >
> > This patch was never merged.  If we merged a revised version, please
> > cite the SHA1 instead.
> This patch has never merged, and I found that it is unnecessary after
> commit a37c0f48950b56f6ef2ee637 ("vgaarb: Select a default VGA device
> even if there's no legacy VGA"). Maybe this ASpeed patch is also
> unnecessary. If it is still needed, I'll investigate the root cause.
I found that vga_arb_device_init() and pcibios_init() are both wrapped
by subsys_initcall(), which means their sequence is unpredictable. And
unfortunately, in our platform vga_arb_device_init() is called before
pcibios_init(), which makes vga_arb_device_init() fail to set a
default vga device. This is the root cause why we thought that we
still need a quirk for AST2500.

I think the best solution is make vga_arb_device_init() be wrapped by
subsys_initcall_sync(), do you think so?

Huacai
>
> Huacai
> >
> > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > Signed-off-by: Jingfeng Sui <suijingfeng@loongson.cn>
> > > ---
> > >  drivers/pci/quirks.c | 47 ++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 47 insertions(+)
> > >
> > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > index 6ab4b3bba36b..adf5490706ad 100644
> > > --- a/drivers/pci/quirks.c
> > > +++ b/drivers/pci/quirks.c
> > > @@ -28,6 +28,7 @@
> > >  #include <linux/platform_data/x86/apple.h>
> > >  #include <linux/pm_runtime.h>
> > >  #include <linux/switchtec.h>
> > > +#include <linux/vgaarb.h>
> > >  #include <asm/dma.h> /* isa_dma_bridge_buggy */
> > >  #include "pci.h"
> > >
> > > @@ -297,6 +298,52 @@ static void loongson_mrrs_quirk(struct pci_dev *dev)
> > >  }
> > >  DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_mrrs_quirk);
> > >
> > > +
> > > +static void aspeed_fixup_vgaarb(struct pci_dev *pdev)
> > > +{
> > > +     struct pci_dev *bridge;
> > > +     struct pci_bus *bus;
> > > +     struct pci_dev *vdevp = NULL;
> > > +     u16 config;
> > > +
> > > +     bus = pdev->bus;
> > > +     bridge = bus->self;
> > > +
> > > +     /* Is VGA routed to us? */
> > > +     if (bridge && (pci_is_bridge(bridge))) {
> > > +             pci_read_config_word(bridge, PCI_BRIDGE_CONTROL, &config);
> > > +
> > > +             /* Yes, this bridge is PCI bridge-to-bridge spec compliant,
> > > +              *  just return!
> > > +              */
> > > +             if (config & PCI_BRIDGE_CTL_VGA)
> > > +                     return;
> > > +
> > > +             dev_warn(&pdev->dev, "VGA bridge control is not enabled\n");
> > > +     }
> >
> > You cannot assume that a bridge is defective just because
> > PCI_BRIDGE_CTL_VGA is not set.
> >
> > > +     /* Just return if the system already have a default device */
> > > +     if (vga_default_device())
> > > +             return;
> > > +
> > > +     /* No default vga device */
> > > +     while ((vdevp = pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, vdevp))) {
> > > +             if (vdevp->vendor != 0x1a03) {
> > > +                     /* Have other vga devcie in the system, do nothing */
> > > +                     dev_info(&pdev->dev, "Another boot vga device: 0x%x:0x%x\n",
> > > +                             vdevp->vendor, vdevp->device);
> > > +                     return;
> > > +             }
> > > +     }
> > > +
> > > +     vga_set_default_device(pdev);
> > > +
> > > +     dev_info(&pdev->dev, "Boot vga device set as 0x%x:0x%x\n",
> > > +                     pdev->vendor, pdev->device);
> > > +}
> > > +DECLARE_PCI_FIXUP_CLASS_FINAL(0x1a03, 0x2000, PCI_CLASS_DISPLAY_VGA, 8, aspeed_fixup_vgaarb);
> > > +
> > > +
> > >  /*
> > >   * The Mellanox Tavor device gives false positive parity errors.  Disable
> > >   * parity error reporting.
> > > --
> > > 2.27.0
> > >

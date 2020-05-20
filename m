Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED851DB6CC
	for <lists+linux-pci@lfdr.de>; Wed, 20 May 2020 16:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgETO1e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 10:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbgETO1c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2020 10:27:32 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4277C061A0F
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2020 07:27:31 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g14so174888wme.1
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2020 07:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ptEFNOIgk4B9+DYPafEJRUQDpVN+/z6CM7j9644NXs0=;
        b=N6+F8AHyBsGr0JrchNCjPmACddbP02WM42JVatgqpfz453fPvPxNSwETDM9nnCuNdx
         lmwiFvLsbcA8X8p1dCkos0MC1aP9vojACfnbjOWQMj89Vrd6li3tz3eZNJvm6Cey3kdh
         ibmCBGe++ATvMcSFUTOTMoFa+1gS6rUIgVBiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ptEFNOIgk4B9+DYPafEJRUQDpVN+/z6CM7j9644NXs0=;
        b=mePCLQcHLFwuVapgTVJSyhrrFoHpSENCWRygeMEujn69lIDFSsKDLo4D9q10C+tWgc
         4eISvZ6nzRf4eVfUAQd2Sz8DmUo1jP6aOokh+S6jM84zC/xtUUwrFqjBdl29n0MepISm
         a4JClWDp++zfpMZZHiQn1AuEiCRQ2GeypjmZjG3pD0ive8AdWciQkgVpqrjn4uEvIN4h
         WvJ/whVhGY3BQtDiJpGm8d1Ml/vkCPbLOju0AmayI6lGlj5QzLYybzfUrsFNsHjbNx9+
         Ec+eolo9r4kSo83rogEoVSYeEn3UH5AnCMyB9BKYecjv64OHdMkt6hBzNGcjM1Lo5guC
         WTrw==
X-Gm-Message-State: AOAM532NkleXfcLqoEOse4R/gEJl0QAfeZ1KKiKYqPnnybJytF4gxS8R
        iv3Fxe27MHysMqZCtgKmufD9xLhCDWxh/y1/6s/HqQ==
X-Google-Smtp-Source: ABdhPJySvQfAlpumPlaeBx0gloIM87hF3NnQtQHYZAsxKgeWGRoXo9/4rd6GvjpLG1hbdorf7f1PdTxBLXECGZ/RMao=
X-Received: by 2002:a1c:7d02:: with SMTP id y2mr3542879wmc.92.1589984850314;
 Wed, 20 May 2020 07:27:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200519203419.12369-1-james.quinlan@broadcom.com>
 <20200519203419.12369-15-james.quinlan@broadcom.com> <4a49e7724e9a12e4f128a5e9ff4181da7af40bd3.camel@suse.de>
In-Reply-To: <4a49e7724e9a12e4f128a5e9ff4181da7af40bd3.camel@suse.de>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Wed, 20 May 2020 10:27:17 -0400
Message-ID: <CA+-6iNxB6CS4OJSfCpUfJrd9=7EjFrKwugBT1WycKv-C_j3zAQ@mail.gmail.com>
Subject: Re: [PATCH 14/15] PCI: brcmstb: Set bus max burst side by chip type
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 20, 2020 at 9:44 AM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> On Tue, 2020-05-19 at 16:34 -0400, Jim Quinlan wrote:
> > From: Jim Quinlan <jquinlan@broadcom.com>
> >
> > The proper value of the parameter SCB_MAX_BURST_SIZE varies
> > per chip.  The 2711 family requires 128B whereas other devices
> > can employ 512.  The assignment is complicated by the fact
> > that the values for this two-bit field have different meanings;
> >
> >   Value   Type_Generic    Type_7278
> >
> >      00       Reserved         128B
> >      01           128B         256B
> >      10           256B         512B
> >      11           512B     Reserved
> >
> > Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
> > ---
> >  drivers/pci/controller/pcie-brcmstb.c | 18 +++++++++++++++---
> >  1 file changed, 15 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-brcmstb.c
> > b/drivers/pci/controller/pcie-brcmstb.c
> > index 7bf945efd71b..0dfa1bbd9764 100644
> > --- a/drivers/pci/controller/pcie-brcmstb.c
> > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > @@ -53,7 +53,7 @@
> >  #define  PCIE_MISC_MISC_CTRL_SCB_ACCESS_EN_MASK              0x1000
> >  #define  PCIE_MISC_MISC_CTRL_CFG_READ_UR_MODE_MASK   0x2000
> >  #define  PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_MASK     0x300000
> > -#define  PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_128              0x0
> > +
> >  #define  PCIE_MISC_MISC_CTRL_SCB0_SIZE_MASK          0xf8000000
> >  #define  PCIE_MISC_MISC_CTRL_SCB1_SIZE_MASK          0x07c00000
> >  #define  PCIE_MISC_MISC_CTRL_SCB2_SIZE_MASK          0x0000001f
> > @@ -276,6 +276,7 @@ struct brcm_pcie {
> >       int                     num_memc;
> >       u64                     memc_size[PCIE_BRCM_MAX_MEMC];
> >       u32                     hw_rev;
> > +     const struct of_device_id *of_id;
> >  };
> >
> >  /*
> > @@ -841,7 +842,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
> >       int num_out_wins = 0;
> >       u16 nlw, cls, lnksta;
> >       int i, ret, memc;
> > -     u32 tmp, aspm_support;
> > +     u32 tmp, burst, aspm_support;
> >
> >       /* Reset the bridge */
> >       brcm_pcie_bridge_sw_init_set(pcie, 1);
> > @@ -857,10 +858,20 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
> >       /* Wait for SerDes to be stable */
> >       usleep_range(100, 200);
> >
> > +     /*
> > +      * SCB_MAX_BURST_SIZE is a two bit field.  For GENERIC chips it
> > +      * is encoded as 0=128, 1=256, 2=512, 3=Rsvd, for BCM7278 it
> > +      * is encoded as 0=Rsvd, 1=128, 2=256, 3=512.
> > +      */
> > +     if (strcmp(pcie->of_id->compatible, "brcm,bcm2711-pcie") == 0)
>
> Would it make sense to use pcie->type here? I know GENERIC != BCM2711, but we
> could define it and avoid adding redundant info in struct brcm_pcie.
Yes, that would get rid of the need for keeping of_id around.

Thanks,
Jim
>
> Regards,
> Nicolas
>
> > +             burst = 0x0; /* 128B */
> > +     else
> > +             burst = (pcie->type == BCM7278) ? 0x3 : 0x2; /* 512 bytes */
> > +
> >       /* Set SCB_MAX_BURST_SIZE, CFG_READ_UR_MODE, SCB_ACCESS_EN */
> >       u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_SCB_ACCESS_EN_MASK);
> >       u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_CFG_READ_UR_MODE_MASK);
> > -     u32p_replace_bits(&tmp, PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_128,
> > +     u32p_replace_bits(&tmp, burst,
> >                         PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_MASK);
> >       writel(tmp, base + PCIE_MISC_MISC_CTRL);
> >
> > @@ -1200,6 +1211,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
> >       pcie->reg_offsets = data->offsets;
> >       pcie->reg_field_info = data->reg_field_info;
> >       pcie->type = data->type;
> > +     pcie->of_id = of_id;
> >
> >       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >       pcie->base = devm_ioremap_resource(&pdev->dev, res);
>

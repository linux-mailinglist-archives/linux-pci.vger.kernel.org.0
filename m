Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6541DD755
	for <lists+linux-pci@lfdr.de>; Thu, 21 May 2020 21:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbgEUTf0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 May 2020 15:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728902AbgEUTf0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 May 2020 15:35:26 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE9DC061A0F
        for <linux-pci@vger.kernel.org>; Thu, 21 May 2020 12:35:25 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id n5so7609790wmd.0
        for <linux-pci@vger.kernel.org>; Thu, 21 May 2020 12:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fXTE3yjnFJVJ4RMTP+hFtfV69y3g7idePydsdqEDOvU=;
        b=Urnx6PIU4w0LHEM/0sVFU0WRGpU3pWxVPEGtXRmDC+zUmRU1/zi1kj16aFQ2P/UaY5
         75vqXaVwj4O7sN47cqKRUcikoqiL6Rr84nUGLHkMXgk2PH3S0YM30hi1MPtzdQfWK9tT
         JrBIweGMSKAztPbjtJX/78GjS0zmN6gLpPDq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fXTE3yjnFJVJ4RMTP+hFtfV69y3g7idePydsdqEDOvU=;
        b=SNoL125w7KL4dJ0yDIsrkFeyQ2KPkE7xKoLe92BiGjIyvaOoA5Z2DgwQ0kDiJ6u1x5
         +8LMTfi4T9GefSYJk4vfKgSWduDo6Vmt4S+EAuhK84B6UST7kVKFaMy0mypSmcjZJmKm
         XmHXem63x9oWMnCUjtaXGjyG5o14UHgPn4IRs3RMUl2fa/Fjp1g+aTCsltCqbp26Ak34
         /80/CoVeqMBFUjdw9FKFkJKvfsE1jm5J89ienjKgqIlEMgtyPJNnYoxrVctEhlUS0qVh
         EtqJK5c+tTQbYQ8UiX2d7JvcWhTxDk5xuLHGKNB+XHDMahsx7zdJUrCH3+2uCpijqrjY
         5Pvw==
X-Gm-Message-State: AOAM533sD+syLd6kxrwR5js8w0de3aJ09/Zym+cSSuE+TSSU34b7D7PN
        e4pbG9vfKfqvlkkcvkg1iVAObFUcvB38x9YUdJdtaQ==
X-Google-Smtp-Source: ABdhPJys3lSyamABhSpV9p1+ZRLgdctlDO3boTGydZwLnsXpdO06hyQIO/CDFT1eH5E1CtdgMMR4vEirWBhO7YFGEFU=
X-Received: by 2002:a1c:7d02:: with SMTP id y2mr9060596wmc.92.1590089724177;
 Thu, 21 May 2020 12:35:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200519203419.12369-1-james.quinlan@broadcom.com>
 <20200519203419.12369-5-james.quinlan@broadcom.com> <5a52e39ce99214877e83104b8ea9f95c0d5b4e90.camel@suse.de>
In-Reply-To: <5a52e39ce99214877e83104b8ea9f95c0d5b4e90.camel@suse.de>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Thu, 21 May 2020 15:35:11 -0400
Message-ID: <CA+-6iNyqtFguHJ=sB=nKoghX6PR9ve5OuyafPw88mfSmhe+c8Q@mail.gmail.com>
Subject: Re: [PATCH 04/15] PCI: brcmstb: Add compatibily of other chips
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

On Wed, May 20, 2020 at 7:51 AM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> Hi Jim,
>
> On Tue, 2020-05-19 at 16:34 -0400, Jim Quinlan wrote:
> > From: Jim Quinlan <jquinlan@broadcom.com>
> >
> > Add in compatibility strings and code for three Broadcom STB chips.
> > Some of the register locations, shifts, and masks are different
> > for certain chips, requiring the use of different constants based
> > on of_id.
> >
> > We would like to add the following at this time to the match list
> > but we need to wait until the end of this patchset so that
> > everything works.
> >
> >     { .compatible = "brcm,bcm7211-pcie", .data = &generic_cfg },
> >     { .compatible = "brcm,bcm7278-pcie", .data = &bcm7278_cfg },
> >     { .compatible = "brcm,bcm7216-pcie", .data = &bcm7278_cfg },
> >     { .compatible = "brcm,bcm7445-pcie", .data = &generic_cfg },
> >
> > Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
> > ---
> >  drivers/pci/controller/pcie-brcmstb.c | 103 +++++++++++++++++++++++---
> >  1 file changed, 91 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-brcmstb.c
> > b/drivers/pci/controller/pcie-brcmstb.c
> > index 73020b4ff090..c1cf4ea7d3d9 100644
> > --- a/drivers/pci/controller/pcie-brcmstb.c
> > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > @@ -120,9 +120,8 @@
> >  #define  PCIE_EXT_SLOT_SHIFT                         15
> >  #define  PCIE_EXT_FUNC_SHIFT                         12
> >
> > -#define PCIE_RGR1_SW_INIT_1                          0x9210
> >  #define  PCIE_RGR1_SW_INIT_1_PERST_MASK                      0x1
> > -#define  PCIE_RGR1_SW_INIT_1_INIT_MASK                       0x2
> > +#define  PCIE_RGR1_SW_INIT_1_PERST_SHIFT             0x0
> >
> >  /* PCIe parameters */
> >  #define BRCM_NUM_PCIE_OUT_WINS               0x4
> > @@ -152,6 +151,69 @@
> >  #define SSC_STATUS_SSC_MASK          0x400
> >  #define SSC_STATUS_PLL_LOCK_MASK     0x800
> >
> > +#define IDX_ADDR(pcie)       \
> > +     (pcie->reg_offsets[EXT_CFG_INDEX])
> > +#define DATA_ADDR(pcie)      \
> > +     (pcie->reg_offsets[EXT_CFG_DATA])
> > +#define PCIE_RGR1_SW_INIT_1(pcie) \
> > +     (pcie->reg_offsets[RGR1_SW_INIT_1])
> > +
> > +enum {
> > +     RGR1_SW_INIT_1,
> > +     EXT_CFG_INDEX,
> > +     EXT_CFG_DATA,
> > +};
> > +
> > +enum {
> > +     RGR1_SW_INIT_1_INIT_MASK,
> > +     RGR1_SW_INIT_1_INIT_SHIFT,
> > +};
> > +
> > +enum pcie_type {
> > +     GENERIC,
> > +     BCM7278,
> > +};
> > +
> > +struct pcie_cfg_data {
> > +     const int *reg_field_info;
> > +     const int *offsets;
> > +     const enum pcie_type type;
> > +};
> > +
> > +static const int pcie_reg_field_info[] = {
> > +     [RGR1_SW_INIT_1_INIT_MASK] = 0x2,
> > +     [RGR1_SW_INIT_1_INIT_SHIFT] = 0x1,
> > +};
> > +
> > +static const int pcie_reg_field_info_bcm7278[] = {
> > +     [RGR1_SW_INIT_1_INIT_MASK] = 0x1,
> > +     [RGR1_SW_INIT_1_INIT_SHIFT] = 0x0,
> > +};
> > +
> > +static const int pcie_offsets[] = {
> > +     [RGR1_SW_INIT_1] = 0x9210,
> > +     [EXT_CFG_INDEX]  = 0x9000,
> > +     [EXT_CFG_DATA]   = 0x9004,
> > +};
> > +
> > +static const struct pcie_cfg_data generic_cfg = {
> > +     .reg_field_info = pcie_reg_field_info,
> > +     .offsets        = pcie_offsets,
> > +     .type           = GENERIC,
> > +};
> > +
> > +static const int pcie_offset_bcm7278[] = {
> > +     [RGR1_SW_INIT_1] = 0xc010,
> > +     [EXT_CFG_INDEX] = 0x9000,
> > +     [EXT_CFG_DATA] = 0x9004,
> > +};
> > +
> > +static const struct pcie_cfg_data bcm7278_cfg = {
> > +     .reg_field_info = pcie_reg_field_info_bcm7278,
> > +     .offsets        = pcie_offset_bcm7278,
> > +     .type           = BCM7278,
> > +};
>
> It's not essential, but if v2 is due I'd suggest factoring out the bcm2728
> specific structures above, and moving them to patch #15. This will keep a
> clearer division between the patch introducing the infrastructure and the one
> adding the support for a new device.
>
> > +
> >  struct brcm_msi {
> >       struct device           *dev;
> >       void __iomem            *base;
> > @@ -176,6 +238,9 @@ struct brcm_pcie {
> >       int                     gen;
> >       u64                     msi_target_addr;
> >       struct brcm_msi         *msi;
> > +     const int               *reg_offsets;
> > +     const int               *reg_field_info;
> > +     enum pcie_type          type;
> >  };
> >
> >  /*
> > @@ -602,20 +667,21 @@ static struct pci_ops brcm_pcie_ops = {
> >
> >  static inline void brcm_pcie_bridge_sw_init_set(struct brcm_pcie *pcie, u32
> > val)
> >  {
> > -     u32 tmp;
> > +     u32 tmp, mask =  pcie->reg_field_info[RGR1_SW_INIT_1_INIT_MASK];
> > +     u32 shift = pcie->reg_field_info[RGR1_SW_INIT_1_INIT_SHIFT];
>
> I don't think you need shift here, IIUC u32p_replace_bits() will take care of
> all the masking and shifting internally, moreover, you'd be able to drop the
> shift entry from reg_field_info.
I believe that u32p_replace_bits requires at least one of the value or
mask to be compile time constants to work and we don't have that here.
Regards,
Jim
>
> > -     tmp = readl(pcie->base + PCIE_RGR1_SW_INIT_1);
> > -     u32p_replace_bits(&tmp, val, PCIE_RGR1_SW_INIT_1_INIT_MASK);
> > -     writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1);
> > +     tmp = readl(pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
> > +     tmp = (tmp & ~mask) | ((val << shift) & mask);
> > +     writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
> >  }
>
> Regards,
> Nicolas
>

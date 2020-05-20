Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B54C41DB713
	for <lists+linux-pci@lfdr.de>; Wed, 20 May 2020 16:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgETObP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 10:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgETObO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2020 10:31:14 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB8CC061A0F
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2020 07:31:13 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id i15so3342406wrx.10
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2020 07:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HP7BIyw2Y/C8hkvgzZRIvmSm/MyaptHmyY6CakMJdU0=;
        b=Tj9V6vdUREzHIKAIcpP3UNMkiwFZOfcPfxrRu9Xv38B5EuZqo0CIOpH5uP0XZ/JRTi
         dVeKogHLAYHhyKOiXt062o/+fbm82eFp7zEgKhKW64uh3b6SCTshnMRYrSS+lWlvUMT/
         fEtOzoXazBSk1EL3cd0pjluANGqfFdC4zEpaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HP7BIyw2Y/C8hkvgzZRIvmSm/MyaptHmyY6CakMJdU0=;
        b=aWm2YaQE7PGBUJ9ja7+uhZENztqgpR508+nidMog/WpVkZFUUTdDeTt7ugKcGzZz88
         JIfpttu3BecHMFMzzOyzKN+H6YyKzkMT+vFVKlAGuPTw1Zh2oNeciu6dCeV/dlLvoSv0
         euPiwNeZABKzKQTFPTDPqVHTXDG+pXVk1msJejB7SE3G6qCC54H2gZHi8mKhKvB0MHuw
         OLM95VRrrX18u6Gz6SGb07NVo+2/gQmco4bIY+O4XT7iS6TX1dzcaZHXmx1KVDC2ldHe
         zdhkMDWl5Fs1aNDFyMx5gRsci1tn9tHEfnNDtl1nM/UnkmxzK6kL7aOVAcAhmHJ1xp9S
         O4Zg==
X-Gm-Message-State: AOAM530LAMkHIproLGwPgvirl3JUEooeFtmGAgrzUlqAmKPUsYYWvWfj
        oPcd9j4c+kK6GtpDAQ+Xoy3EGJv6TdpM/61an6EQhA==
X-Google-Smtp-Source: ABdhPJwVIXTx8ngi6DSuNnR19unkLPjwJTEgk1hS1LqfoqkdWGyUpA/+44SVaMxijYJ6PhLELxTsrpH9bpACjNB88j0=
X-Received: by 2002:adf:e688:: with SMTP id r8mr4324103wrm.274.1589985072196;
 Wed, 20 May 2020 07:31:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200519203419.12369-1-james.quinlan@broadcom.com>
 <20200519203419.12369-5-james.quinlan@broadcom.com> <5a52e39ce99214877e83104b8ea9f95c0d5b4e90.camel@suse.de>
In-Reply-To: <5a52e39ce99214877e83104b8ea9f95c0d5b4e90.camel@suse.de>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Wed, 20 May 2020 10:30:59 -0400
Message-ID: <CA+-6iNwE7CkD0r7Z0cKGXxE14Unf7ZGsr4q7Z8dPhgYYXHXHEg@mail.gmail.com>
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
The problem is that one of the commits needs the 7278 type so it has
to be declared earlier.
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
Got it.
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
Thanks!
Jim

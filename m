Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E581FD377
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jun 2020 19:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgFQR23 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Jun 2020 13:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbgFQR22 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Jun 2020 13:28:28 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E45C06174E
        for <linux-pci@vger.kernel.org>; Wed, 17 Jun 2020 10:28:28 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f185so2892751wmf.3
        for <linux-pci@vger.kernel.org>; Wed, 17 Jun 2020 10:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CZymfCvTZe2unxui/On+2nz51hFSacskdir9aJUt334=;
        b=LXB6zjEpECVPFq3pzrvE6u45GCA8crHlrWBnYhY+wOze5PIOETecFxeVdAg/Lo9Igt
         Cf+UfzAtGN0nmdN4LS49chP94ri8xnYFHFTjPXjSwDcikYB3ZmnxEUezY1w+FXB5wCNb
         gKNsOBAaNxOOrWmYq2PBiM+EJh9G7xayZNPPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CZymfCvTZe2unxui/On+2nz51hFSacskdir9aJUt334=;
        b=L1r7LZg3qETROFsFwd9SASkKw/uaN2WksmpGtwPpp9gmB7CwL5ZktVBPMlkVF/CBxG
         Ga8Ljr/bHr7v1RWaWrvgUVjAvIB1NjuvYoPrLwuaL04VShAFuP2KIbsbaVANz7+2qpB7
         aeJUBP+PF3Hh1V27xtu6Xkf7fBVVC09a8d+XUCClWnOhHawtYAVQB0T0R5W1WRY86oMO
         dwA74OKmLIcaxKxP30ZarlI6o9qZAB2mCcejHxV67qdobhbB2TAeMd4qJZlEa9W4hiOT
         ZiI8/KdjDoDSPgFAhvktMpfGEGTnnzT7O+sYmTZdVNF+zylbidAJStMc1HlTxG9bjDoP
         9rHw==
X-Gm-Message-State: AOAM533exXtZ9x/rukhKMeJjxuV5b6unVeh8QfT7rRmJO6QZ3NNdy3mL
        J5M0HAwKW5O2wPs1G+NqhruKeAkEdLtboct1oLCOhQ==
X-Google-Smtp-Source: ABdhPJyI1oGlLhAEtWSCa4AUdXeJmUELYyv/wpCZoDYmqZQ1gL4ZlEwwKnYlPNTrZJ27JEJnJJge9+4OAB7OJK2n1oE=
X-Received: by 2002:a05:600c:2042:: with SMTP id p2mr10027851wmg.85.1592414906580;
 Wed, 17 Jun 2020 10:28:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200616205533.3513-10-james.quinlan@broadcom.com> <20200616220533.GA1984551@bjorn-Precision-5520>
In-Reply-To: <20200616220533.GA1984551@bjorn-Precision-5520>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Wed, 17 Jun 2020 13:28:12 -0400
Message-ID: <CA+-6iNx1j5uK=nL-H32qthxEwZe+KOxtqCG4TPJxD+WdzMQFrA@mail.gmail.com>
Subject: Re: [PATCH v5 09/12] PCI: brcmstb: Set internal memory viewport sizes
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Bjorn,

On Tue, Jun 16, 2020 at 6:05 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Jun 16, 2020 at 04:55:16PM -0400, Jim Quinlan wrote:
> > BrcmSTB PCIe controllers are intimately connected to the memory
> > controller(s) on the SOC.  There is a "viewport" for each memory controller
> > that allows inbound accesses to CPU memory.  Each viewport's size must be
> > set to a power of two, and that size must be equal to or larger than the
> > amount of memory each controller supports.
>
> This describes some requirements, but doesn't actually say what this
> patch *does*.
>
> I *think* it reads the viewport sizes from the "brcm,scb-sizes" DT
> property instead of computing something from "dma-ranges".  Looks like
> it also adds support for SCB1 and SCB2.
>
> Those seem interesting, but don't really come through in the subject
> or even the commit log.
>
> If I understand correctly, this is all for DMA ("inbound accesses to
> CPU memory").  I think it would be worth mentioning "DMA", since
> that's the common term for this.


I have changed the commit message to the text below.  Please let me
know if it requires more work
Thanks, Jim

PCI: brcmstb: Set internal memory DMA viewport sizes

BrcmSTB PCIe controllers are intimately connected to the memory
controller(s) on the SOC.  There is a "viewport" for each memory controller
that allows inbound DMA acceses to CPU memory.  Each viewport's size must
be set to a power of two, and that size must be equal to or larger than the
amount of memory each controller supports.  Unfortunately the viewport
sizes cannot be ascertained from the "dma-ranges" property so they have
their own property, "brcm,scb-sizes".

There may be one to three memory controllers; they are indicated by the
term SCBi.  Each controller has a base region and an optional extension
region.  In physical memory, the base and extension regions are not
adjacent, but in PCIe-space they are.  Further, the 1-3 viewports are also
adjacent in PCIe-space.

The SCB settings work in conjunction with the "dma-ranges' offsets to
enable non-identity mappings between system memory and PCIe space.


>
>
> > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> > ---
> >  drivers/pci/controller/pcie-brcmstb.c | 68 ++++++++++++++++++++-------
> >  1 file changed, 50 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> > index 9189406fd35c..39f77709c6a2 100644
> > --- a/drivers/pci/controller/pcie-brcmstb.c
> > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > @@ -57,6 +57,8 @@
> >  #define  PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_MASK     0x300000
> >  #define  PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_128              0x0
> >  #define  PCIE_MISC_MISC_CTRL_SCB0_SIZE_MASK          0xf8000000
> > +#define  PCIE_MISC_MISC_CTRL_SCB1_SIZE_MASK          0x07c00000
> > +#define  PCIE_MISC_MISC_CTRL_SCB2_SIZE_MASK          0x0000001f
> >
> >  #define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LO             0x400c
> >  #define PCIE_MEM_WIN0_LO(win)        \
> > @@ -154,6 +156,7 @@
> >  #define SSC_STATUS_OFFSET            0x1
> >  #define SSC_STATUS_SSC_MASK          0x400
> >  #define SSC_STATUS_PLL_LOCK_MASK     0x800
> > +#define PCIE_BRCM_MAX_MEMC           3
> >
> >  #define IDX_ADDR(pcie)                       (pcie->reg_offsets[EXT_CFG_INDEX])
> >  #define DATA_ADDR(pcie)                      (pcie->reg_offsets[EXT_CFG_DATA])
> > @@ -260,6 +263,8 @@ struct brcm_pcie {
> >       const int               *reg_field_info;
> >       enum pcie_type          type;
> >       struct reset_control    *rescal;
> > +     int                     num_memc;
> > +     u64                     memc_size[PCIE_BRCM_MAX_MEMC];
> >  };
> >
> >  /*
> > @@ -715,22 +720,44 @@ static inline int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
> >                                                       u64 *rc_bar2_offset)
> >  {
> >       struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
> > -     struct device *dev = pcie->dev;
> >       struct resource_entry *entry;
> > +     struct device *dev = pcie->dev;
> > +     u64 lowest_pcie_addr = ~(u64)0;
> > +     int ret, i = 0;
> > +     u64 size = 0;
> >
> > -     entry = resource_list_first_type(&bridge->dma_ranges, IORESOURCE_MEM);
> > -     if (!entry)
> > -             return -ENODEV;
> > +     resource_list_for_each_entry(entry, &bridge->dma_ranges) {
> > +             u64 pcie_beg = entry->res->start - entry->offset;
> >
> > +             size += entry->res->end - entry->res->start + 1;
> > +             if (pcie_beg < lowest_pcie_addr)
> > +                     lowest_pcie_addr = pcie_beg;
> > +     }
> >
> > -     /*
> > -      * The controller expects the inbound window offset to be calculated as
> > -      * the difference between PCIe's address space and CPU's. The offset
> > -      * provided by the firmware is calculated the opposite way, so we
> > -      * negate it.
> > -      */
> > -     *rc_bar2_offset = -entry->offset;
> > -     *rc_bar2_size = 1ULL << fls64(entry->res->end - entry->res->start);
> > +     if (lowest_pcie_addr == ~(u64)0) {
> > +             dev_err(dev, "DT node has no dma-ranges\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     ret = of_property_read_variable_u64_array(pcie->np, "brcm,scb-sizes", pcie->memc_size, 1,
> > +                                               PCIE_BRCM_MAX_MEMC);
> > +
> > +     if (ret <= 0) {
> > +             /* Make an educated guess */
> > +             pcie->num_memc = 1;
> > +             pcie->memc_size[0] = 1 << fls64(size - 1);
> > +     } else {
> > +             pcie->num_memc = ret;
> > +     }
> > +
> > +     /* Each memc is viewed through a "port" that is a power of 2 */
> > +     for (i = 0, size = 0; i < pcie->num_memc; i++)
> > +             size += pcie->memc_size[i];
> > +
> > +     /* System memory starts at this address in PCIe-space */
> > +     *rc_bar2_offset = lowest_pcie_addr;
> > +     /* The sum of all memc views must also be a power of 2 */
> > +     *rc_bar2_size = 1ULL << fls64(size - 1);
> >
> >       /*
> >        * We validate the inbound memory view even though we should trust
> > @@ -782,12 +809,11 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
> >       void __iomem *base = pcie->base;
> >       struct device *dev = pcie->dev;
> >       struct resource_entry *entry;
> > -     unsigned int scb_size_val;
> >       bool ssc_good = false;
> >       struct resource *res;
> >       int num_out_wins = 0;
> >       u16 nlw, cls, lnksta;
> > -     int i, ret;
> > +     int i, ret, memc;
> >       u32 tmp, aspm_support;
> >
> >       /* Reset the bridge */
> > @@ -824,11 +850,17 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
> >       writel(upper_32_bits(rc_bar2_offset),
> >              base + PCIE_MISC_RC_BAR2_CONFIG_HI);
> >
> > -     scb_size_val = rc_bar2_size ?
> > -                    ilog2(rc_bar2_size) - 15 : 0xf; /* 0xf is 1GB */
> >       tmp = readl(base + PCIE_MISC_MISC_CTRL);
> > -     u32p_replace_bits(&tmp, scb_size_val,
> > -                       PCIE_MISC_MISC_CTRL_SCB0_SIZE_MASK);
> > +     for (memc = 0; memc < pcie->num_memc; memc++) {
> > +             u32 scb_size_val = ilog2(pcie->memc_size[memc]) - 15;
> > +
> > +             if (memc == 0)
> > +                     u32p_replace_bits(&tmp, scb_size_val, PCIE_MISC_MISC_CTRL_SCB0_SIZE_MASK);
> > +             else if (memc == 1)
> > +                     u32p_replace_bits(&tmp, scb_size_val, PCIE_MISC_MISC_CTRL_SCB1_SIZE_MASK);
> > +             else if (memc == 2)
> > +                     u32p_replace_bits(&tmp, scb_size_val, PCIE_MISC_MISC_CTRL_SCB2_SIZE_MASK);
> > +     }
> >       writel(tmp, base + PCIE_MISC_MISC_CTRL);
> >
> >       /*
> > --
> > 2.17.1
> >

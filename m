Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 434741FE92E
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jun 2020 05:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgFRDBp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Jun 2020 23:01:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:56782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726952AbgFRDBo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Jun 2020 23:01:44 -0400
Received: from localhost (mobile-166-170-222-206.mycingular.net [166.170.222.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3240208C7;
        Thu, 18 Jun 2020 03:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592449303;
        bh=D+RIBaE1e99GexBp+YDaMWHaXlTMDUSMPXDMbSLsLhU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=rvspTLk/7iukyPQFUzJrN85r6rr4OtLWCMuGAvhlQQgoCThyT5PA5LDTn4FYkkLfF
         Dhz/y4545V7+UmxzWJxFbRbIXf8ZXXZwvcNKQgfAZ/6UR5RD69gDLOBtFHpP48Gblt
         Kn4t75RU6lP8zLcyLuU06yvIETn4t/g8p0HJDz1I=
Date:   Wed, 17 Jun 2020 22:01:41 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
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
Subject: Re: [PATCH v5 09/12] PCI: brcmstb: Set internal memory viewport sizes
Message-ID: <20200618030141.GA2041805@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+-6iNx1j5uK=nL-H32qthxEwZe+KOxtqCG4TPJxD+WdzMQFrA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 17, 2020 at 01:28:12PM -0400, Jim Quinlan wrote:
> Hello Bjorn,
> 
> On Tue, Jun 16, 2020 at 6:05 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Tue, Jun 16, 2020 at 04:55:16PM -0400, Jim Quinlan wrote:
> > > BrcmSTB PCIe controllers are intimately connected to the memory
> > > controller(s) on the SOC.  There is a "viewport" for each memory controller
> > > that allows inbound accesses to CPU memory.  Each viewport's size must be
> > > set to a power of two, and that size must be equal to or larger than the
> > > amount of memory each controller supports.
> >
> > This describes some requirements, but doesn't actually say what this
> > patch *does*.
> >
> > I *think* it reads the viewport sizes from the "brcm,scb-sizes" DT
> > property instead of computing something from "dma-ranges".  Looks like
> > it also adds support for SCB1 and SCB2.
> >
> > Those seem interesting, but don't really come through in the subject
> > or even the commit log.
> >
> > If I understand correctly, this is all for DMA ("inbound accesses to
> > CPU memory").  I think it would be worth mentioning "DMA", since
> > that's the common term for this.
> 
> 
> I have changed the commit message to the text below.  Please let me
> know if it requires more work
> Thanks, Jim
> 
> PCI: brcmstb: Set internal memory DMA viewport sizes

Did you not set the viewport sizes before?

> BrcmSTB PCIe controllers are intimately connected to the memory
> controller(s) on the SOC.  There is a "viewport" for each memory controller
> that allows inbound DMA acceses to CPU memory.  Each viewport's size must
> be set to a power of two, and that size must be equal to or larger than the
> amount of memory each controller supports.  Unfortunately the viewport
> sizes cannot be ascertained from the "dma-ranges" property so they have
> their own property, "brcm,scb-sizes".

s/inbound DMA acceses to CPU memory/DMA/

"Accesses" is redundant since the "A" in "DMA" stands for "access".
I'm not sure "inbound" adds anything and might confuse since DMA may
be either a read or write of CPU memory.

I assume *all* drivers need to know the address and size of regions in
"dma-ranges".  Is there something special about this device that means
it needs something different?

I guess it's the base/extension split?  That couldn't be described as
two separate DMA ranges?

Could/should the new property have a name somehow related to
"dma-ranges"?

Should "dma-ranges" be documented in
Documentation/devicetree/bindings/pci/pci.txt instead of the
individual device bindings?

> There may be one to three memory controllers; they are indicated by the
> term SCBi.  Each controller has a base region and an optional extension
> region.  In physical memory, the base and extension regions are not
> adjacent, but in PCIe-space they are.  Further, the 1-3 viewports are also
> adjacent in PCIe-space.
> 
> The SCB settings work in conjunction with the "dma-ranges' offsets to
> enable non-identity mappings between system memory and PCIe space.

s/ranges'/ranges"/ (mismatched quotes)

This describes the hardware, but still doesn't actually say what this
patch *does*.

If I'm a user, why do I want this patch?  Does it fix something that
didn't work before?  Does it increase the amount of DMA-able memory?

What does this mean in terms of backwards compatibility with old DTs?
Does this work with old DTs that don't have "brcm,scb-sizes"?  Maybe
this is all related to specific devices that weren't supported before,
so there *are* no old DTs for them?  I can't tell from the binding
update or the patch that this is related to specific devices.

> > > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > > Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> > > ---
> > >  drivers/pci/controller/pcie-brcmstb.c | 68 ++++++++++++++++++++-------
> > >  1 file changed, 50 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> > > index 9189406fd35c..39f77709c6a2 100644
> > > --- a/drivers/pci/controller/pcie-brcmstb.c
> > > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > > @@ -57,6 +57,8 @@
> > >  #define  PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_MASK     0x300000
> > >  #define  PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_128              0x0
> > >  #define  PCIE_MISC_MISC_CTRL_SCB0_SIZE_MASK          0xf8000000
> > > +#define  PCIE_MISC_MISC_CTRL_SCB1_SIZE_MASK          0x07c00000
> > > +#define  PCIE_MISC_MISC_CTRL_SCB2_SIZE_MASK          0x0000001f
> > >
> > >  #define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LO             0x400c
> > >  #define PCIE_MEM_WIN0_LO(win)        \
> > > @@ -154,6 +156,7 @@
> > >  #define SSC_STATUS_OFFSET            0x1
> > >  #define SSC_STATUS_SSC_MASK          0x400
> > >  #define SSC_STATUS_PLL_LOCK_MASK     0x800
> > > +#define PCIE_BRCM_MAX_MEMC           3
> > >
> > >  #define IDX_ADDR(pcie)                       (pcie->reg_offsets[EXT_CFG_INDEX])
> > >  #define DATA_ADDR(pcie)                      (pcie->reg_offsets[EXT_CFG_DATA])
> > > @@ -260,6 +263,8 @@ struct brcm_pcie {
> > >       const int               *reg_field_info;
> > >       enum pcie_type          type;
> > >       struct reset_control    *rescal;
> > > +     int                     num_memc;
> > > +     u64                     memc_size[PCIE_BRCM_MAX_MEMC];
> > >  };
> > >
> > >  /*
> > > @@ -715,22 +720,44 @@ static inline int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
> > >                                                       u64 *rc_bar2_offset)
> > >  {
> > >       struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
> > > -     struct device *dev = pcie->dev;
> > >       struct resource_entry *entry;
> > > +     struct device *dev = pcie->dev;
> > > +     u64 lowest_pcie_addr = ~(u64)0;
> > > +     int ret, i = 0;
> > > +     u64 size = 0;
> > >
> > > -     entry = resource_list_first_type(&bridge->dma_ranges, IORESOURCE_MEM);
> > > -     if (!entry)
> > > -             return -ENODEV;
> > > +     resource_list_for_each_entry(entry, &bridge->dma_ranges) {
> > > +             u64 pcie_beg = entry->res->start - entry->offset;
> > >
> > > +             size += entry->res->end - entry->res->start + 1;
> > > +             if (pcie_beg < lowest_pcie_addr)
> > > +                     lowest_pcie_addr = pcie_beg;
> > > +     }
> > >
> > > -     /*
> > > -      * The controller expects the inbound window offset to be calculated as
> > > -      * the difference between PCIe's address space and CPU's. The offset
> > > -      * provided by the firmware is calculated the opposite way, so we
> > > -      * negate it.
> > > -      */
> > > -     *rc_bar2_offset = -entry->offset;
> > > -     *rc_bar2_size = 1ULL << fls64(entry->res->end - entry->res->start);
> > > +     if (lowest_pcie_addr == ~(u64)0) {
> > > +             dev_err(dev, "DT node has no dma-ranges\n");
> > > +             return -EINVAL;
> > > +     }
> > > +
> > > +     ret = of_property_read_variable_u64_array(pcie->np, "brcm,scb-sizes", pcie->memc_size, 1,
> > > +                                               PCIE_BRCM_MAX_MEMC);
> > > +
> > > +     if (ret <= 0) {
> > > +             /* Make an educated guess */
> > > +             pcie->num_memc = 1;
> > > +             pcie->memc_size[0] = 1 << fls64(size - 1);
> > > +     } else {
> > > +             pcie->num_memc = ret;
> > > +     }
> > > +
> > > +     /* Each memc is viewed through a "port" that is a power of 2 */
> > > +     for (i = 0, size = 0; i < pcie->num_memc; i++)
> > > +             size += pcie->memc_size[i];
> > > +
> > > +     /* System memory starts at this address in PCIe-space */
> > > +     *rc_bar2_offset = lowest_pcie_addr;
> > > +     /* The sum of all memc views must also be a power of 2 */
> > > +     *rc_bar2_size = 1ULL << fls64(size - 1);
> > >
> > >       /*
> > >        * We validate the inbound memory view even though we should trust
> > > @@ -782,12 +809,11 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
> > >       void __iomem *base = pcie->base;
> > >       struct device *dev = pcie->dev;
> > >       struct resource_entry *entry;
> > > -     unsigned int scb_size_val;
> > >       bool ssc_good = false;
> > >       struct resource *res;
> > >       int num_out_wins = 0;
> > >       u16 nlw, cls, lnksta;
> > > -     int i, ret;
> > > +     int i, ret, memc;
> > >       u32 tmp, aspm_support;
> > >
> > >       /* Reset the bridge */
> > > @@ -824,11 +850,17 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
> > >       writel(upper_32_bits(rc_bar2_offset),
> > >              base + PCIE_MISC_RC_BAR2_CONFIG_HI);
> > >
> > > -     scb_size_val = rc_bar2_size ?
> > > -                    ilog2(rc_bar2_size) - 15 : 0xf; /* 0xf is 1GB */
> > >       tmp = readl(base + PCIE_MISC_MISC_CTRL);
> > > -     u32p_replace_bits(&tmp, scb_size_val,
> > > -                       PCIE_MISC_MISC_CTRL_SCB0_SIZE_MASK);
> > > +     for (memc = 0; memc < pcie->num_memc; memc++) {
> > > +             u32 scb_size_val = ilog2(pcie->memc_size[memc]) - 15;
> > > +
> > > +             if (memc == 0)
> > > +                     u32p_replace_bits(&tmp, scb_size_val, PCIE_MISC_MISC_CTRL_SCB0_SIZE_MASK);
> > > +             else if (memc == 1)
> > > +                     u32p_replace_bits(&tmp, scb_size_val, PCIE_MISC_MISC_CTRL_SCB1_SIZE_MASK);
> > > +             else if (memc == 2)
> > > +                     u32p_replace_bits(&tmp, scb_size_val, PCIE_MISC_MISC_CTRL_SCB2_SIZE_MASK);
> > > +     }
> > >       writel(tmp, base + PCIE_MISC_MISC_CTRL);
> > >
> > >       /*
> > > --
> > > 2.17.1
> > >

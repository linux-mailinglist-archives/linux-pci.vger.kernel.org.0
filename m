Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E756105204
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2019 13:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfKUMDY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Nov 2019 07:03:24 -0500
Received: from foss.arm.com ([217.140.110.172]:55174 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbfKUMDX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Nov 2019 07:03:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15D4E328;
        Thu, 21 Nov 2019 04:03:22 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7EBC43F703;
        Thu, 21 Nov 2019 04:03:21 -0800 (PST)
Date:   Thu, 21 Nov 2019 12:03:19 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, mbrugger@suse.com,
        maz@kernel.org, phil@raspberrypi.org, linux-kernel@vger.kernel.org,
        jeremy.linton@arm.com, Eric Anholt <eric@anholt.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Stefan Wahren <wahrenst@gmx.net>, james.quinlan@broadcom.com,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH v2 4/6] PCI: brcmstb: add Broadcom STB PCIe host
 controller driver
Message-ID: <20191121120319.GW43905@e119886-lin.cambridge.arm.com>
References: <20191112155926.16476-1-nsaenzjulienne@suse.de>
 <20191112155926.16476-5-nsaenzjulienne@suse.de>
 <20191119162502.GS43905@e119886-lin.cambridge.arm.com>
 <7e1be0bdcf303224a3fe225654a3c2391207f9eb.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e1be0bdcf303224a3fe225654a3c2391207f9eb.camel@suse.de>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 20, 2019 at 08:53:30PM +0100, Nicolas Saenz Julienne wrote:
> Hi Andrew, thanks for the review.
> 
> On Tue, 2019-11-19 at 16:25 +0000, Andrew Murray wrote:
> > On Tue, Nov 12, 2019 at 04:59:23PM +0100, Nicolas Saenz Julienne wrote:
> > > From: Jim Quinlan <james.quinlan@broadcom.com>
> > > 
> > > This commit adds the basic Broadcom STB PCIe controller.  Missing is the
> > > ability to process MSI. This functionality is added in a subsequent
> > > commit.
> > > 
> > > The PCIe block contains an MDIO interface.  This is a local interface
> > > only accessible by the PCIe controller.  It cannot be used or shared
> > > by any other HW.  As such, the small amount of code for this
> > > controller is included in this driver as there is little upside to put
> > > it elsewhere.
> > 
> > This commit message hasn't changed, despite earlier feedback.
> 
> Sorry, I'll review your previous comment.
> 
> [...]
> 
> > > +#define bcm_readl(a)		readl(a)
> > > +#define bcm_writel(d, a)	writel(d, a)
> > > +#define bcm_readw(a)		readw(a)
> > > +#define bcm_writew(d, a)	writew(d, a)
> > > +
> > > +/* These macros extract/insert fields to host controller's register set. */
> > > +#define RD_FLD(base, reg, field) \
> > > +	brcm_pcie_rd_fld((base) + reg, reg##_##field##_MASK, \
> > > +			 reg##_##field##_SHIFT)
> > > +#define WR_FLD(base, reg, field, val) \
> > > +	brcm_pcie_wr_fld((base) + reg, reg##_##field##_MASK, \
> > > +		    reg##_##field##_SHIFT, val)
> > > +#define WR_FLD_RB(base, reg, field, val) \
> > > +	brcm_pcie_wr_fld_rb((base) + reg, reg##_##field##_MASK, \
> > > +		reg##_##field##_SHIFT, val)
> > > +#define WR_FLD_WITH_OFFSET(base, off, reg, field, val) \
> > > +	brcm_pcie_wr_fld((base) + reg + (off), reg##_##field##_MASK, \
> > > +	       reg##_##field##_SHIFT, val)
> > > +#define EXTRACT_FIELD(val, reg, field) \
> > > +	(((val) & reg##_##field##_MASK) >> reg##_##field##_SHIFT)
> > > +#define INSERT_FIELD(val, reg, field, field_val) \
> > > +	(((val) & ~reg##_##field##_MASK) | \
> > > +	 (reg##_##field##_MASK & (field_val << reg##_##field##_SHIFT)))
> > 
> > Can you use any of the existing macros in linux/bitfield.h
> > (e.g. ...replace_bits...) ?
> 
> Yes, It looks like it fits perfectly, I think I can get rid of all the *_SHIFT
> registers and simplify some of the functions below.

I do love to see code being removed :).

> 
> > > +
> > > +static u32 brcm_pcie_rd_fld(void __iomem *p, u32 mask, int shift)
> > > +{
> > > +	return (bcm_readl(p) & mask) >> shift;
> > > +}
> > > +
> > > +static void brcm_pcie_wr_fld(void __iomem *p, u32 mask, int shift, u32 val)
> > > +{
> > > +	u32 reg = bcm_readl(p);
> > > +
> > > +	reg = (reg & ~mask) | ((val << shift) & mask);
> > > +	bcm_writel(reg, p);
> > > +}
> > > +
> > > +static void brcm_pcie_wr_fld_rb(void __iomem *p, u32 mask, int shift, u32
> > > val)
> > > +{
> > > +	brcm_pcie_wr_fld(p, mask, shift, val);
> > > +	(void)bcm_readl(p);
> > > +}
> > > +
> 
> [...]
> 
> > > +static void brcm_pcie_set_outbound_win(struct brcm_pcie *pcie,
> > > +				       unsigned int win, phys_addr_t cpu_addr,
> > > +				       dma_addr_t  pcie_addr, dma_addr_t size)
> > > +{
> > > +	phys_addr_t cpu_addr_mb, limit_addr_mb;
> > > +	void __iomem *base = pcie->base;
> > > +	u32 tmp;
> > > +
> > > +	/* Set the base of the pcie_addr window */
> > > +	bcm_writel(lower_32_bits(pcie_addr) + MMIO_ENDIAN,
> > > +		   base + PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LO + (win * 8));
> > > +	bcm_writel(upper_32_bits(pcie_addr),
> > > +		   base + PCIE_MISC_CPU_2_PCIE_MEM_WIN0_HI + (win * 8));
> > > +
> > > +	cpu_addr_mb = cpu_addr >> 20;
> > > +	limit_addr_mb = (cpu_addr + size - 1) >> 20;
> > > +
> > > +	/* Write the addr base low register */
> > > +	WR_FLD_WITH_OFFSET(base, (win * 4),
> > > +			   PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT,
> > > +			   BASE, cpu_addr_mb);
> > > +	/* Write the addr limit low register */
> > > +	WR_FLD_WITH_OFFSET(base, (win * 4),
> > > +			   PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT,
> > > +			   LIMIT, limit_addr_mb);
> > > +
> > > +	/* Write the cpu addr high register */
> > > +	tmp = (u32)(cpu_addr_mb >>
> > > +		PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT_NUM_MASK_BITS);
> > 
> > Despite the name _MASK_BITS, this isn't being used as a mask. Is this making
> > some assumption about the value of cpu_addr from the DT?
> 
> It should be read _NUM_MASK_BITS. It contains the number of set bits on that
> specific mask. I agree it's not ideal. I think I'll be able to do away with it
> using the bitfield.h macros.

Also why do you have a define for
PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT_NUM_MASK_BITS but not the '20' shift
used for the low registers?


> 
> FYI, What's happening here is that we have to save the CPU address range (which
> is already shifted right 20 positions) in two parts, the lower 12 bits go into
> PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT while the higher 8 bits go into
> PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_HI or
> PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LIMIT_HI.

The hardware spec require bits 31:20 of the address, and the high registers
require 39:32 right?

(Apologies, the indirection by the WR_FLD_** macros easily confuses me. These
type of macros are helpful, or rather would be if the whole kernel used them.
I think they can add confusion when each driver has its own set of similar
macros. This is why its *really* helpful to use any existing macros in the
kernel - and only invent new ones if needed).


> 
> [...]
> 
> > > +static inline int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie
> > > *pcie,
> > > +							u64 *rc_bar2_size,
> > > +							u64 *rc_bar2_offset)
> > > +{
> > > +	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
> > > +	struct device *dev = pcie->dev;
> > > +	struct resource_entry *entry;
> > > +	u64 total_mem_size = 0;
> > > +
> > > +	*rc_bar2_offset = -1;
> > > +
> > > +	resource_list_for_each_entry(entry, &bridge->dma_ranges) {
> > > +		/*
> > > +		 * We're promised the RC will provide a contiguous view of
> > > +		 * memory to downstream devices. We can then infer the
> > > +		 * rc_bar2_offset from the lower available dma-range offset.
> > > +		 */
> > > +		if (entry->offset < *rc_bar2_offset)
> > > +			*rc_bar2_offset = entry->offset;
> > > +
> > > +		total_mem_size += entry->res->end - entry->res->start + 1;
> > 
> > This requires that if there are multiple dma-ranges, then there are no gaps
> > between them right?
> 
> Yes, the PCI view of inbound memory will always be gapless. See an example
> here: https://patchwork.kernel.org/patch/10605957/

Thanks for the reference. 


> 
> That said, iterating over the dma-ranges is not strictly necessary for now as
> RPi4 is assured to only need one. If that's bothering you I can always remove
> it for now.

One purpose of this function is to validate that the information given in the
device tree is valid - I've seen other feedback on these lists where the view
is taken that 'it's not the job of the kernel to validate the DT'. Subscribing
to this view would be a justification for removing this validation - especially
given that the bindings you include have only one dma-range (in any case if
there are constraints you ought to include them in the binding document).

Though the problem with this point of view is that if the DT is wrong, it may
be possible for the driver to work well enough to do some function but with
some horrible side effects that are difficult to track down to a bad DT.

If you assume the DT will only have one range (at least for the Pi) then this
code will never be used and so can probably be removed.


> 
> [...]
> 
> > > +static int brcm_pcie_setup(struct brcm_pcie *pcie)
> > > +{
> > > +	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
> > > +	u64 rc_bar2_offset, rc_bar2_size;
> > > +	void __iomem *base = pcie->base;
> > > +	struct device *dev = pcie->dev;
> > > +	struct resource_entry *entry;
> > > +	unsigned int scb_size_val;
> > > +	bool ssc_good = false;
> > > +	struct resource *res;
> > > +	int num_out_wins = 0;
> > > +	u16 nlw, cls, lnksta;
> > > +	int i, ret;
> > > +	u32 tmp;
> > > +
> > > +	/* Reset the bridge */
> > > +	brcm_pcie_bridge_sw_init_set(pcie, 1);
> > > +
> > > +	usleep_range(100, 200);
> > > +
> > > +	/* Take the bridge out of reset */
> > > +	brcm_pcie_bridge_sw_init_set(pcie, 0);
> > > +
> > > +	WR_FLD_RB(base, PCIE_MISC_HARD_PCIE_HARD_DEBUG, SERDES_IDDQ, 0);
> > > +	/* Wait for SerDes to be stable */
> > > +	usleep_range(100, 200);
> > > +
> > > +	/* Set SCB_MAX_BURST_SIZE, CFG_READ_UR_MODE, SCB_ACCESS_EN */
> > > +	tmp = INSERT_FIELD(0, PCIE_MISC_MISC_CTRL, SCB_ACCESS_EN, 1);
> > > +	tmp = INSERT_FIELD(tmp, PCIE_MISC_MISC_CTRL, CFG_READ_UR_MODE, 1);
> > > +	tmp = INSERT_FIELD(tmp, PCIE_MISC_MISC_CTRL, MAX_BURST_SIZE,
> > > +			   BURST_SIZE_128);
> > > +	bcm_writel(tmp, base + PCIE_MISC_MISC_CTRL);
> > > +
> > > +	ret = brcm_pcie_get_rc_bar2_size_and_offset(pcie, &rc_bar2_size,
> > > +						    &rc_bar2_offset);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	tmp = lower_32_bits(rc_bar2_offset);
> > > +	tmp = INSERT_FIELD(tmp, PCIE_MISC_RC_BAR2_CONFIG_LO, SIZE,
> > > +			   brcm_pcie_encode_ibar_size(rc_bar2_size));
> > > +	bcm_writel(tmp, base + PCIE_MISC_RC_BAR2_CONFIG_LO);
> > > +	bcm_writel(upper_32_bits(rc_bar2_offset),
> > > +		   base + PCIE_MISC_RC_BAR2_CONFIG_HI);
> > > +
> > > +	scb_size_val = rc_bar2_size ?
> > > +		       ilog2(rc_bar2_size) - 15 : 0xf; /* 0xf is 1GB */
> > > +	WR_FLD(base, PCIE_MISC_MISC_CTRL, SCB0_SIZE, scb_size_val);
> > > +
> > > +	/* disable the PCIe->GISB memory window (RC_BAR1) */
> > > +	WR_FLD(base, PCIE_MISC_RC_BAR1_CONFIG_LO, SIZE, 0);
> > > +
> > > +	/* disable the PCIe->SCB memory window (RC_BAR3) */
> > > +	WR_FLD(base, PCIE_MISC_RC_BAR3_CONFIG_LO, SIZE, 0);
> > > +
> > > +	/* clear any interrupts we find on boot */
> > > +	bcm_writel(0xffffffff, base + PCIE_INTR2_CPU_BASE + CLR);
> > > +	(void)bcm_readl(base + PCIE_INTR2_CPU_BASE + CLR);
> > > +
> > > +	/* Mask all interrupts since we are not handling any yet */
> > > +	bcm_writel(0xffffffff, base + PCIE_INTR2_CPU_BASE + MASK_SET);
> > > +	(void)bcm_readl(base + PCIE_INTR2_CPU_BASE + MASK_SET);
> >
> > Should you change the order and mask before clearing the interrupts?
> 
> Yes, agree.
> 
> > > +
> > > +	if (pcie->gen)
> > > +		brcm_pcie_set_gen(base, pcie->gen);
> > > +
> > > +	/* Unassert the fundamental reset */
> > > +	brcm_pcie_perst_set(pcie, 0);
> > > +
> > > +	/*
> > > +	 * Give the RC/EP time to wake up, before trying to configure RC.
> > > +	 * Intermittently check status for link-up, up to a total of 100ms.
> > > +	 */
> > > +	for (i = 0; i < 100 && !brcm_pcie_link_up(pcie); i += 5)
> > > +		msleep(5);
> > > +
> > > +	if (!brcm_pcie_link_up(pcie)) {
> > > +		dev_info(dev, "link down\n");
> > > +		return -ENODEV;
> > > +	}
> > > +
> > > +	if (!brcm_pcie_rc_mode(pcie)) {
> > > +		dev_err(dev, "PCIe misconfigured; is in EP mode\n");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	resource_list_for_each_entry(entry, &bridge->windows) {
> > > +		res = entry->res;
> > > +
> > > +		if (resource_type(res) != IORESOURCE_MEM)
> > > +			continue;
> > > +
> > > +		if (num_out_wins >= BRCM_NUM_PCIE_OUT_WINS) {
> > > +			dev_err(pcie->dev, "too many outbound wins\n");
> > > +			return -EINVAL;
> > > +		}
> > > +
> > > +		brcm_pcie_set_outbound_win(pcie, num_out_wins, res->start,
> > > +					   res->start - entry->offset,
> > > +					   res->end - res->start + 1);
> > > +		num_out_wins++;
> > > +	}
> > > +
> > > +	/*
> > > +	 * For config space accesses on the RC, show the right class for
> > > +	 * a PCIe-PCIe bridge (the default setting is to be EP mode).
> > > +	 */
> > > +	WR_FLD_RB(base, PCIE_RC_CFG_PRIV1_ID_VAL3, CLASS_CODE, 0x060400);
> > 
> > Why does this need to be _RB ? I haven't looked at all of the uses of _RB
> > though I think there are others that may not be necessary.
> 
> We're reviewing the _RB usage with Jim, I'll come back to you on that topic
> later.

Thanks.


> 
> [...]
> 
> > > +	__brcm_pcie_remove(pcie);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static const struct of_device_id brcm_pcie_match[] = {
> > > +	{ .compatible = "brcm,bcm2711-pcie", .data = &bcm2711_cfg },
> > 
> > I'd rather see use of the pcie_cfg_data structure removed from this series.
> > 
> > I've seen the comments in the previous thread [1], and I understand that
> > the intention is that this driver will eventually be used for other SOCs.
> > 
> > However this indirection isn't needed *now* and it makes reviewing this
> > patch more difficult. If and when a later series is made to cover other
> > SOCs - then I'd expect that series to find a way to apply this indirection.
> > 
> > And if that later series is more difficult to review because of the newly
> > added indirection, then I'd expect an early patch of that series to apply
> > the indirection in a single patch - which would be easy to review.
> > 
> > The other risk of such premature changes like this is that when you come
> > to adding other SOCs, you may then discover that there were shortcomings
> > in the way you've approached it here.
> > 
> 
> I was about to make a point similar to Florian's. I'll wait for your reply and
> change this accordingly.

No problem.

> 
> > > +	{},
> > > +};
> > > +MODULE_DEVICE_TABLE(of, brcm_pcie_match);
> > > +
> > > +static int brcm_pcie_probe(struct platform_device *pdev)
> > > +{
> > > +	struct device_node *np = pdev->dev.of_node;
> > > +	const struct pcie_cfg_data *data;
> > > +	struct pci_host_bridge *bridge;
> > > +	struct brcm_pcie *pcie;
> > > +	struct pci_bus *child;
> > > +	struct resource *res;
> > > +	int ret;
> > > +
> > > +	bridge = devm_pci_alloc_host_bridge(&pdev->dev, sizeof(*pcie));
> > > +	if (!bridge)
> > > +		return -ENOMEM;
> > > +
> > > +	pcie = pci_host_bridge_priv(bridge);
> > 
> > Nit: I'd suggest moving the above line so it sits just above the
> > "pcie->reg_offsets = data->offsets;" line. It looks nicer.
> 
> Ok
> 
> > > +
> > > +	data = of_device_get_match_data(&pdev->dev);
> > > +	if (!data) {
> > > +		dev_err(&pdev->dev, "failed to look up compatible string\n");
> > 
> > Nit: If there is a failure here, it's probably because there is no data
> > defined in the brcm_pcie_match structure - seeing as we wouldn't get here
> > if we didn't have a compatible string. I'd suggest rewording the err slightly
> > or even removing it.
> 
> Ok
> 
> [...]
> 
> > > +	},
> > > +};
> > > +
> > > +module_platform_driver(brcm_pcie_driver);
> > > +
> > > +MODULE_LICENSE("GPL v2");
> > 
> > This is different to the SPDX at the start of the file (please see
> > earlier review comments).
> 
> Ouch, yes, that fix got lost, It seems I even mentioned it on the changelog...

:)

Thanks,

Andrew Murray

> 
> Thanks,
> Nicolas
> 



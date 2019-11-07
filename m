Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBAA1F338F
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2019 16:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388428AbfKGPkZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Nov 2019 10:40:25 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:52853 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726810AbfKGPkY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Nov 2019 10:40:24 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iSjtP-0007sn-GF; Thu, 07 Nov 2019 16:40:15 +0100
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH 4/4] PCI: brcmstb: add MSI capability
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 07 Nov 2019 16:49:36 +0109
From:   Marc Zyngier <maz@kernel.org>
Cc:     Andrew Murray <andrew.murray@arm.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>, <mbrugger@suse.com>,
        <phil@raspberrypi.org>, <linux-kernel@vger.kernel.org>,
        <wahrenst@gmx.net>, <james.quinlan@broadcom.com>,
        Bjorn Helgaas <bhelgaas@google.com>
In-Reply-To: <20191106214527.18736-5-nsaenzjulienne@suse.de>
References: <20191106214527.18736-1-nsaenzjulienne@suse.de>
 <20191106214527.18736-5-nsaenzjulienne@suse.de>
Message-ID: <f1154b65d422e2e37e3b320e662d4268@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: nsaenzjulienne@suse.de, andrew.murray@arm.com, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, f.fainelli@gmail.com, mbrugger@suse.com, phil@raspberrypi.org, linux-kernel@vger.kernel.org, wahrenst@gmx.net, james.quinlan@broadcom.com, bhelgaas@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2019-11-06 22:54, Nicolas Saenz Julienne wrote:
> From: Jim Quinlan <james.quinlan@broadcom.com>
>
> This commit adds MSI to the Broadcom STB PCIe host controller. It 
> does
> not add MSIX since that functionality is not in the HW.  The MSI
> controller is physically located within the PCIe block, however, 
> there
> is no reason why the MSI controller could not be moved elsewhere in
> the future.
>
> Since the internal Brcmstb MSI controller is intertwined with the 
> PCIe
> controller, it is not its own platform device but rather part of the
> PCIe platform device.
>
> This is based on Jim's original submission[1] with some slight 
> changes
> regarding how pcie->msi_target_addr is decided.
>
> [1] https://patchwork.kernel.org/patch/10605955/
>
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> Co-developed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  drivers/pci/controller/Kconfig        |   2 +-
>  drivers/pci/controller/pcie-brcmstb.c | 333 
> +++++++++++++++++++++++++-
>  2 files changed, 332 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/controller/Kconfig 
> b/drivers/pci/controller/Kconfig
> index 8b3aae91d8af..99b972ad3f2f 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -284,7 +284,7 @@ config VMD
>  config PCIE_BRCMSTB
>  	bool "Broadcom Brcmstb PCIe host controller"
>  	depends on ARCH_BRCMSTB || BMIPS_GENERIC
> -	depends on OF
> +	depends on OF && PCI_MSI
>  	depends on SOC_BRCMSTB
>  	default ARCH_BRCMSTB || BMIPS_GENERIC
>  	help
> diff --git a/drivers/pci/controller/pcie-brcmstb.c
> b/drivers/pci/controller/pcie-brcmstb.c
> index 880ec11d06a1..26053e69b95f 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright (C) 2009 - 2019 Broadcom */
>
> +#include <linux/bitops.h>
>  #include <linux/clk.h>
>  #include <linux/compiler.h>
>  #include <linux/delay.h>
> @@ -8,11 +9,13 @@
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/ioport.h>
> +#include <linux/irqchip/chained_irq.h>
>  #include <linux/irqdomain.h>
>  #include <linux/kernel.h>
>  #include <linux/list.h>
>  #include <linux/log2.h>
>  #include <linux/module.h>
> +#include <linux/msi.h>
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_pci.h>
> @@ -46,6 +49,9 @@
>  #define PCIE_MISC_RC_BAR2_CONFIG_LO			0x4034
>  #define PCIE_MISC_RC_BAR2_CONFIG_HI			0x4038
>  #define PCIE_MISC_RC_BAR3_CONFIG_LO			0x403c
> +#define PCIE_MISC_MSI_BAR_CONFIG_LO			0x4044
> +#define PCIE_MISC_MSI_BAR_CONFIG_HI			0x4048
> +#define PCIE_MISC_MSI_DATA_CONFIG			0x404c
>  #define PCIE_MISC_PCIE_CTRL				0x4064
>  #define PCIE_MISC_PCIE_STATUS				0x4068
>  #define PCIE_MISC_REVISION				0x406c
> @@ -54,6 +60,7 @@
>  #define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LIMIT_HI		0x4084
>  #define PCIE_MISC_HARD_PCIE_HARD_DEBUG			0x4204
>  #define PCIE_INTR2_CPU_BASE				0x4300
> +#define PCIE_MSI_INTR2_BASE				0x4500
>
>  /*
>   * Broadcom Settop Box PCIe Register Field shift and mask info. The
> @@ -114,6 +121,8 @@
>
>  #define BRCM_NUM_PCIE_OUT_WINS		0x4
>  #define BRCM_MAX_SCB			0x4
> +#define BRCM_INT_PCI_MSI_NR		32
> +#define BRCM_PCIE_HW_REV_33		0x0303
>
>  #define BRCM_MSI_TARGET_ADDR_LT_4GB	0x0fffffffcULL
>  #define BRCM_MSI_TARGET_ADDR_GT_4GB	0xffffffffcULL
> @@ -199,6 +208,33 @@ struct brcm_window {
>  	dma_addr_t size;
>  };
>
> +struct brcm_msi {
> +	struct device		*dev;
> +	void __iomem		*base;
> +	struct device_node	*dn;
> +	struct irq_domain	*msi_domain;
> +	struct irq_domain	*inner_domain;
> +	struct mutex		lock; /* guards the alloc/free operations */
> +	u64			target_addr;
> +	int			irq;
> +
> +	/* intr_base is the base pointer for interrupt status/set/clr regs 
> */
> +	void __iomem		*intr_base;
> +
> +	/* intr_legacy_mask indicates how many bits are MSI interrupts */
> +	u32			intr_legacy_mask;
> +
> +	/*
> +	 * intr_legacy_offset indicates bit position of MSI_01. It is
> +	 * to map the register bit position to a hwirq that starts at 0.
> +	 */
> +	u32			intr_legacy_offset;
> +
> +	/* used indicates which MSI interrupts have been alloc'd */
> +	unsigned long		used;
> +	unsigned int		rev;
> +};
> +
>  /* Internal PCIe Host Controller Information.*/
>  struct brcm_pcie {
>  	struct device		*dev;
> @@ -211,7 +247,10 @@ struct brcm_pcie {
>  	bool			suspended;
>  	bool			ssc;
>  	int			gen;
> +	u64			msi_target_addr;
>  	struct brcm_window	out_wins[BRCM_NUM_PCIE_OUT_WINS];
> +	struct brcm_msi		*msi;
> +	bool			msi_internal;

Do you need both of these fields? Is there any case where msi is valid
and msi_internal is false?

>  	unsigned int		rev;
>  	const int		*reg_offsets;
>  	const int		*reg_field_info;
> @@ -477,6 +516,267 @@ static void brcm_pcie_set_outbound_win(struct
> brcm_pcie *pcie,
>  			   LIMIT, tmp);
>  }
>
> +static struct irq_chip brcm_msi_irq_chip = {
> +	.name = "Brcm_MSI",
> +	.irq_mask = pci_msi_mask_irq,
> +	.irq_unmask = pci_msi_unmask_irq,
> +};
> +
> +static struct msi_domain_info brcm_msi_domain_info = {
> +	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
> +		   MSI_FLAG_PCI_MSIX),

Is there a particular reason for not supporting MultiMSI? I won't miss
it, but it might be worth documenting the restriction if the HW cannot
support it (though I can't immediately see why).

> +	.chip	= &brcm_msi_irq_chip,
> +};
> +
> +static void brcm_pcie_msi_isr(struct irq_desc *desc)
> +{
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	struct brcm_msi *msi;
> +	unsigned long status, virq;
> +	u32 mask, bit, hwirq;
> +	struct device *dev;
> +
> +	chained_irq_enter(chip, desc);
> +	msi = irq_desc_get_handler_data(desc);
> +	mask = msi->intr_legacy_mask;
> +	dev = msi->dev;
> +
> +	while ((status = bcm_readl(msi->intr_base + STATUS) & mask)) {

Is this loop really worth it? If, as I imagine, this register is at the
end of a wet piece of string, this additional read (likely to return 
zero)
will have a measurable latency impact...

> +		for_each_set_bit(bit, &status, BRCM_INT_PCI_MSI_NR) {
> +			/* clear the interrupt */
> +			bcm_writel(1 << bit, msi->intr_base + CLR);
> +
> +			/* Account for legacy interrupt offset */
> +			hwirq = bit - msi->intr_legacy_offset;
> +
> +			virq = irq_find_mapping(msi->inner_domain, hwirq);
> +			if (virq) {
> +				if (msi->used & (1 << hwirq))
> +					generic_handle_irq(virq);
> +				else
> +					dev_info(dev, "unhandled MSI %d\n",
> +						 hwirq);

Can this ever happen? If you've found the mapping in the irqdomain,
the MSI obviously has been allocated. Or am I missing something?

> +			} else {
> +				/* Unknown MSI, just clear it */
> +				dev_dbg(dev, "unexpected MSI\n");
> +			}
> +		}
> +	}
> +	chained_irq_exit(chip, desc);
> +}
> +
> +static void brcm_compose_msi_msg(struct irq_data *data, struct 
> msi_msg *msg)
> +{
> +	struct brcm_msi *msi = irq_data_get_irq_chip_data(data);
> +	u32 temp;
> +
> +	msg->address_lo = lower_32_bits(msi->target_addr);
> +	msg->address_hi = upper_32_bits(msi->target_addr);
> +	temp = bcm_readl(msi->base + PCIE_MISC_MSI_DATA_CONFIG);

Do you have to reload it from the HW?

> +	msg->data = ((temp >> 16) & (temp & 0xffff)) | data->hwirq;
> +}
> +
> +static int brcm_msi_set_affinity(struct irq_data *irq_data,
> +				 const struct cpumask *mask, bool force)
> +{
> +	return -EINVAL;
> +}
> +
> +static struct irq_chip brcm_msi_bottom_irq_chip = {
> +	.name			= "Brcm_MSI",
> +	.irq_compose_msi_msg	= brcm_compose_msi_msg,
> +	.irq_set_affinity	= brcm_msi_set_affinity,
> +};
> +
> +static int brcm_msi_alloc(struct brcm_msi *msi)
> +{
> +	int bit, hwirq;
> +
> +	mutex_lock(&msi->lock);
> +	bit = ~msi->used ? ffz(msi->used) : -1;
> +
> +	if (bit >= 0 && bit < BRCM_INT_PCI_MSI_NR) {
> +		msi->used |= (1 << bit);
> +		hwirq = bit - msi->intr_legacy_offset;
> +	} else {
> +		hwirq = -ENOSPC;
> +	}

Please consider using bitmap_find_free_region() and co, instead of
open coding your allocator.

> +
> +	mutex_unlock(&msi->lock);
> +	return hwirq;
> +}
> +
> +static void brcm_msi_free(struct brcm_msi *msi, unsigned long hwirq)
> +{
> +	mutex_lock(&msi->lock);
> +	msi->used &= ~(1 << (hwirq + msi->intr_legacy_offset));
> +	mutex_unlock(&msi->lock);
> +}
> +
> +static int brcm_irq_domain_alloc(struct irq_domain *domain, unsigned
> int virq,
> +				 unsigned int nr_irqs, void *args)
> +{
> +	struct brcm_msi *msi = domain->host_data;
> +	int hwirq;
> +
> +	hwirq = brcm_msi_alloc(msi);
> +
> +	if (hwirq < 0)
> +		return hwirq;
> +
> +	irq_domain_set_info(domain, virq, (irq_hw_number_t)hwirq,
> +			    &brcm_msi_bottom_irq_chip, domain->host_data,
> +			    handle_simple_irq, NULL, NULL);

simple_irq doesn't quite match what this does. This really should
use an edge flow.

> +	return 0;
> +}
> +
> +static void brcm_irq_domain_free(struct irq_domain *domain,
> +				 unsigned int virq, unsigned int nr_irqs)
> +{
> +	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
> +	struct brcm_msi *msi = irq_data_get_irq_chip_data(d);
> +
> +	brcm_msi_free(msi, d->hwirq);
> +}
> +
> +static void brcm_msi_set_regs(struct brcm_msi *msi)
> +{
> +	u32 data_val, msi_lo, msi_hi;
> +
> +	if (msi->rev >= BRCM_PCIE_HW_REV_33) {
> +		/*
> +		 * ffe0 -- least sig 5 bits are 0 indicating 32 msgs
> +		 * 6540 -- this is our arbitrary unique data value
> +		 */
> +		data_val = 0xffe06540;
> +	} else {
> +		/*
> +		 * fff8 -- least sig 3 bits are 0 indicating 8 msgs
> +		 * 6540 -- this is our arbitrary unique data value
> +		 */
> +		data_val = 0xfff86540;
> +	}
> +
> +	/*
> +	 * Make sure we are not masking MSIs.  Note that MSIs can be 
> masked,
> +	 * but that occurs on the PCIe EP device

That's not a guarantee, specially with plain MultiMSI. I'm actually
minded to move the masking to be purely local on the MSI controllers
I maintain.

> +	 */
> +	bcm_writel(0xffffffff & msi->intr_legacy_mask,
> +		   msi->intr_base + MASK_CLR);
> +
> +	msi_lo = lower_32_bits(msi->target_addr);
> +	msi_hi = upper_32_bits(msi->target_addr);
> +	/*
> +	 * The 0 bit of PCIE_MISC_MSI_BAR_CONFIG_LO is repurposed to MSI
> +	 * enable, which we set to 1.
> +	 */
> +	bcm_writel(msi_lo | 1, msi->base + PCIE_MISC_MSI_BAR_CONFIG_LO);
> +	bcm_writel(msi_hi, msi->base + PCIE_MISC_MSI_BAR_CONFIG_HI);
> +	bcm_writel(data_val, msi->base + PCIE_MISC_MSI_DATA_CONFIG);
> +}
> +
> +static const struct irq_domain_ops msi_domain_ops = {
> +	.alloc	= brcm_irq_domain_alloc,
> +	.free	= brcm_irq_domain_free,
> +};
> +
> +static int brcm_allocate_domains(struct brcm_msi *msi)
> +{
> +	struct fwnode_handle *fwnode = of_node_to_fwnode(msi->dn);
> +	struct device *dev = msi->dev;
> +
> +	msi->inner_domain = irq_domain_add_linear(NULL, 
> BRCM_INT_PCI_MSI_NR,
> +						  &msi_domain_ops, msi);
> +	if (!msi->inner_domain) {
> +		dev_err(dev, "failed to create IRQ domain\n");
> +		return -ENOMEM;
> +	}
> +
> +	msi->msi_domain = pci_msi_create_irq_domain(fwnode,
> +						    &brcm_msi_domain_info,
> +						    msi->inner_domain);
> +	if (!msi->msi_domain) {
> +		dev_err(dev, "failed to create MSI domain\n");
> +		irq_domain_remove(msi->inner_domain);
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +static void brcm_free_domains(struct brcm_msi *msi)
> +{
> +	irq_domain_remove(msi->msi_domain);
> +	irq_domain_remove(msi->inner_domain);
> +}
> +
> +static void brcm_msi_remove(struct brcm_pcie *pcie)
> +{
> +	struct brcm_msi *msi = pcie->msi;
> +
> +	if (!msi)
> +		return;
> +	irq_set_chained_handler(msi->irq, NULL);
> +	irq_set_handler_data(msi->irq, NULL);
> +	brcm_free_domains(msi);
> +}
> +
> +static int brcm_pcie_enable_msi(struct brcm_pcie *pcie)
> +{
> +	struct brcm_msi *msi;
> +	int irq, ret;
> +	struct device *dev = pcie->dev;
> +
> +	irq = irq_of_parse_and_map(dev->of_node, 1);
> +	if (irq <= 0) {
> +		dev_err(dev, "cannot map msi intr\n");
> +		return -ENODEV;
> +	}
> +
> +	msi = devm_kzalloc(dev, sizeof(struct brcm_msi), GFP_KERNEL);
> +	if (!msi)
> +		return -ENOMEM;
> +
> +	msi->dev = dev;
> +	msi->base = pcie->base;
> +	msi->rev =  pcie->rev;
> +	msi->dn = pcie->dn;
> +	msi->target_addr = pcie->msi_target_addr;
> +	msi->irq = irq;
> +
> +	ret = brcm_allocate_domains(msi);
> +	if (ret)
> +		return ret;

You seem to rely on the devm_* allocators to cleanup on failure. But as 
far
as I can see, failing to initialize the MSI subsystem doesn't translate 
in
a PCIe init failure, hence keeping the memory around.

> +
> +	irq_set_chained_handler_and_data(msi->irq, brcm_pcie_msi_isr, msi);
> +
> +	if (msi->rev >= BRCM_PCIE_HW_REV_33) {
> +		msi->intr_base = msi->base + PCIE_MSI_INTR2_BASE;
> +		/*
> +		 * This version of PCIe hw has only 32 intr bits
> +		 * starting at bit position 0.
> +		 */
> +		msi->intr_legacy_mask = 0xffffffff;
> +		msi->intr_legacy_offset = 0x0;
> +		msi->used = 0x0;
> +
> +	} else {
> +		msi->intr_base = msi->base + PCIE_INTR2_CPU_BASE;
> +		/*
> +		 * This version of PCIe hw has only 8 intr bits starting
> +		 * at bit position 24.
> +		 */
> +		msi->intr_legacy_mask = 0xff000000;
> +		msi->intr_legacy_offset = 24;
> +		msi->used = 0x00ffffff;
> +	}
> +
> +	brcm_msi_set_regs(msi);
> +	pcie->msi = msi;
> +
> +	return 0;
> +}
> +
>  /* Configuration space read/write support */
>  static int cfg_index(int busnr, int devfn, int reg)
>  {
> @@ -643,6 +943,18 @@ static int brcm_pcie_setup(struct brcm_pcie 
> *pcie)
>  	if (ret)
>  		return ret;
>
> +	/*
> +	 * We ideally want the MSI target address to be located in the 
> 32bit
> +	 * addressable memory area. Some devices might depend on it. This 
> is
> +	 * possible either when the inbound window is located above the 
> lower
> +	 * 4GB or when the inbound and outbound areas fit in the lower 4GB 
> of
> +	 * memory.
> +	 */
> +	if (rc_bar2_offset >= SZ_4G || (rc_bar2_size + rc_bar2_offset) <= 
> SZ_4G)
> +		pcie->msi_target_addr = BRCM_MSI_TARGET_ADDR_LT_4GB;
> +	else
> +		pcie->msi_target_addr = BRCM_MSI_TARGET_ADDR_GT_4GB;
> +
>  	tmp = lower_32_bits(rc_bar2_offset);
>  	tmp = INSERT_FIELD(tmp, PCIE_MISC_RC_BAR2_CONFIG_LO, SIZE,
>  			   encode_ibar_size(rc_bar2_size));
> @@ -816,6 +1128,9 @@ static int brcm_pcie_resume(struct device *dev)
>  	if (ret)
>  		return ret;
>
> +	if (pcie->msi && pcie->msi_internal)
> +		brcm_msi_set_regs(pcie->msi);
> +
>  	pcie->suspended = false;
>
>  	return 0;
> @@ -823,6 +1138,7 @@ static int brcm_pcie_resume(struct device *dev)
>
>  static void _brcm_pcie_remove(struct brcm_pcie *pcie)
>  {
> +	brcm_msi_remove(pcie);
>  	turn_off(pcie);
>  	clk_disable_unprepare(pcie->clk);
>  	clk_put(pcie->clk);
> @@ -847,7 +1163,7 @@ MODULE_DEVICE_TABLE(of, brcm_pcie_match);
>
>  static int brcm_pcie_probe(struct platform_device *pdev)
>  {
> -	struct device_node *dn = pdev->dev.of_node;
> +	struct device_node *dn = pdev->dev.of_node, *msi_dn;
>  	const struct of_device_id *of_id;
>  	const struct pcie_cfg_data *data;
>  	struct resource *res;
> @@ -923,6 +1239,20 @@ static int brcm_pcie_probe(struct
> platform_device *pdev)
>  	if (ret)
>  		goto fail;
>
> +	msi_dn = of_parse_phandle(pcie->dn, "msi-parent", 0);
> +	/* Use the internal MSI if no msi-parent property */
> +	if (!msi_dn)
> +		msi_dn = pcie->dn;
> +
> +	if (pci_msi_enabled() && msi_dn == pcie->dn) {
> +		ret = brcm_pcie_enable_msi(pcie);
> +		if (ret)
> +			dev_err(pcie->dev,
> +				"probe of internal MSI failed: %d)", ret);
> +		else
> +			pcie->msi_internal = true;
> +	}
> +
>  	bridge->dev.parent = &pdev->dev;
>  	bridge->busnr = 0;
>  	bridge->ops = &brcm_pcie_ops;
> @@ -944,7 +1274,6 @@ static int brcm_pcie_probe(struct 
> platform_device *pdev)
>  	pcie->root_bus = bridge->bus;
>
>  	return 0;
> -
>  fail:
>  	_brcm_pcie_remove(pcie);
>  	return ret;

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...

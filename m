Return-Path: <linux-pci+bounces-33474-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B06A9B1CC63
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 21:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B36F18C419F
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 19:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B172BD03C;
	Wed,  6 Aug 2025 19:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3EyHDOh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9452BD034;
	Wed,  6 Aug 2025 19:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754507694; cv=none; b=qYlKiOuhGb09ZlCvIMeRf/b4e0Qdd3Ri5H87nsWTKhdy5LCtdcyiuPvhJNERWsvs/6ctQIrJ532CMsWruIy+xsOrxVU/nd1XcILbKG+KT7YOE6AXcR1aHScao1vBtpZk6CNq6g4uabppW0/eF/rLIEzPDITuaU4+6lmwKjv/+iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754507694; c=relaxed/simple;
	bh=tcS5mr/jyRzpJT28O3H86kSEfCRhVdzq9mLUNr4HIQU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=S3PxLK+a2tqOIjvgnqkndDgF5TY43kURID7WEM8q8n8nyn5qbYA36jUcGtR9DcA/mmwMHU7szeJ4PvzolydOkKuc7yyvQAyMJnS2hhDaPjhSqI53m9/CADRPIhdNCwrDADxk2gSi4zh+Q1XXhn2LNvc7lyPzGbsMD1glHNFxdhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3EyHDOh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A1B8C4CEE7;
	Wed,  6 Aug 2025 19:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754507693;
	bh=tcS5mr/jyRzpJT28O3H86kSEfCRhVdzq9mLUNr4HIQU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=L3EyHDOhYlQXCwEdaUOACa9al3j1Fv008lfjM0z7NFb5a+sLm5fA32epknU/YBtD3
	 RVu/35dPvEbBFfedgEUg/FgtQpWOlzn/BAyOxtZW1Yh0Tbx3KcRWnBX3wXgkftahGV
	 c9ZMPNj5uGYuJJzr3mHlQSJjrwbtmYrgWRYpMNg5kdgkwE8W3GPky9ie8H0bx3AHRm
	 +Ivdfy4C+RYqgxZJETkD/2f9BomUpPzybctn8P9rwtwwJt5xXRIcZPUFtZTawvxVa1
	 gD3qsbjl6DjlkT3Ugj0xkdWxjR3gjea9I2kpWy/GSvjCjcvAnYxJEOtS8TT81YaVfE
	 D4gWckA5JM29A==
Date: Wed, 6 Aug 2025 14:14:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] PCI: brcmstb: Add panic/die handler to driver
Message-ID: <20250806191452.GA8313@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613220843.698227-3-james.quinlan@broadcom.com>

On Fri, Jun 13, 2025 at 06:08:43PM -0400, Jim Quinlan wrote:
> Whereas most PCIe HW returns 0xffffffff on illegal accesses and the like,
> by default Broadcom's STB PCIe controller effects an abort.  Some SoCs --
> 7216 and its descendants -- have new HW that identifies error details.
> 
> This simple handler determines if the PCIe controller was the cause of the
> abort and if so, prints out diagnostic info.  Unfortunately, an abort still
> occurs.
> 
> Care is taken to read the error registers only when the PCIe bridge is
> active and the PCIe registers are acceptable.  Otherwise, a "die" event
> caused by something other than the PCIe could cause an abort if the PCIe
> "die" handler tried to access registers when the bridge is off.

s/acceptable/accessible/ ?

> Example error output:
>   brcm-pcie 8b20000.pcie: Error: Mem Acc: 32bit, Read, @0x38000000
>   brcm-pcie 8b20000.pcie:  Type: TO=0 Abt=0 UnspReq=1 AccDsble=0 BadAddr=0

Ugly that we have to do this at all, but since I guess it's the best
we can do, looks ok to me.

> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 155 +++++++++++++++++++++++++-
>  1 file changed, 154 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 400854c893d8..abc56acad1fe 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -13,15 +13,18 @@
>  #include <linux/ioport.h>
>  #include <linux/irqchip/chained_irq.h>
>  #include <linux/irqdomain.h>
> +#include <linux/kdebug.h>
>  #include <linux/kernel.h>
>  #include <linux/list.h>
>  #include <linux/log2.h>
>  #include <linux/module.h>
>  #include <linux/msi.h>
> +#include <linux/notifier.h>
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_pci.h>
>  #include <linux/of_platform.h>
> +#include <linux/panic_notifier.h>
>  #include <linux/pci.h>
>  #include <linux/pci-ecam.h>
>  #include <linux/printk.h>
> @@ -151,6 +154,39 @@
>  #define  MSI_INT_MASK_SET		0x10
>  #define  MSI_INT_MASK_CLR		0x14
>  
> +/* Error report registers */
> +#define PCIE_OUTB_ERR_TREAT				0x6000
> +#define  PCIE_OUTB_ERR_TREAT_CONFIG_MASK		0x1
> +#define  PCIE_OUTB_ERR_TREAT_MEM_MASK			0x2
> +#define PCIE_OUTB_ERR_VALID				0x6004
> +#define PCIE_OUTB_ERR_CLEAR				0x6008
> +#define PCIE_OUTB_ERR_ACC_INFO				0x600c
> +#define  PCIE_OUTB_ERR_ACC_INFO_CFG_ERR_MASK		0x01
> +#define  PCIE_OUTB_ERR_ACC_INFO_MEM_ERR_MASK		0x02
> +#define  PCIE_OUTB_ERR_ACC_INFO_TYPE_64_MASK		0x04
> +#define  PCIE_OUTB_ERR_ACC_INFO_DIR_WRITE_MASK		0x10

Including "MASK" in these names seems kind of pointless since they're
all single bits.  Some drivers don't bother with "MASK" even for the
multi-bit fields, since uses read pretty naturally without it.  But I
suppose this is following the existing brcmstb style.

> +#define  PCIE_OUTB_ERR_ACC_INFO_BYTE_LANES_MASK		0xff00
> +#define PCIE_OUTB_ERR_ACC_ADDR				0x6010
> +#define PCIE_OUTB_ERR_ACC_ADDR_BUS_MASK			0xff00000
> +#define PCIE_OUTB_ERR_ACC_ADDR_DEV_MASK			0xf8000
> +#define PCIE_OUTB_ERR_ACC_ADDR_FUNC_MASK		0x7000
> +#define PCIE_OUTB_ERR_ACC_ADDR_REG_MASK			0xfff
> +#define PCIE_OUTB_ERR_CFG_CAUSE				0x6014
> +#define  PCIE_OUTB_ERR_CFG_CAUSE_TIMEOUT_MASK		0x40
> +#define  PCIE_OUTB_ERR_CFG_CAUSE_ABORT_MASK		0x20
> +#define  PCIE_OUTB_ERR_CFG_CAUSE_UNSUPP_REQ_MASK	0x10
> +#define  PCIE_OUTB_ERR_CFG_CAUSE_ACC_TIMEOUT_MASK	0x4
> +#define  PCIE_OUTB_ERR_CFG_CAUSE_ACC_DISABLED_MASK	0x2
> +#define  PCIE_OUTB_ERR_CFG_CAUSE_ACC_64BIT__MASK	0x1
> +#define PCIE_OUTB_ERR_MEM_ADDR_LO			0x6018
> +#define PCIE_OUTB_ERR_MEM_ADDR_HI			0x601c
> +#define PCIE_OUTB_ERR_MEM_CAUSE				0x6020
> +#define  PCIE_OUTB_ERR_MEM_CAUSE_TIMEOUT_MASK		0x40
> +#define  PCIE_OUTB_ERR_MEM_CAUSE_ABORT_MASK		0x20
> +#define  PCIE_OUTB_ERR_MEM_CAUSE_UNSUPP_REQ_MASK	0x10
> +#define  PCIE_OUTB_ERR_MEM_CAUSE_ACC_DISABLED_MASK	0x2
> +#define  PCIE_OUTB_ERR_MEM_CAUSE_BAD_ADDR_MASK		0x1
> +
>  #define  PCIE_RGR1_SW_INIT_1_PERST_MASK			0x1
>  #define  PCIE_RGR1_SW_INIT_1_PERST_SHIFT		0x0
>  
> @@ -301,6 +337,8 @@ struct brcm_pcie {
>  	struct subdev_regulators *sr;
>  	bool			ep_wakeup_capable;
>  	const struct pcie_cfg_data	*cfg;
> +	struct notifier_block	die_notifier;
> +	struct notifier_block	panic_notifier;
>  	bool			bridge_on;
>  	spinlock_t		bridge_lock;
>  };
> @@ -1711,6 +1749,115 @@ static int brcm_pcie_resume_noirq(struct device *dev)
>  	return ret;
>  }
>  
> +/* Dump out PCIe errors on die or panic */
> +static int _brcm_pcie_dump_err(struct brcm_pcie *pcie,
> +			       const char *type)

Fits on one line.

> +{
> +	void __iomem *base = pcie->base;
> +	int i, is_cfg_err, is_mem_err, lanes;
> +	char *width_str, *direction_str, lanes_str[9];
> +	u32 info, cfg_addr, cfg_cause, mem_cause, lo, hi;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&pcie->bridge_lock, flags);
> +	/* Don't access registers when the bridge is off */
> +	if (!pcie->bridge_on || readl(base + PCIE_OUTB_ERR_VALID) == 0) {
> +		spin_unlock_irqrestore(&pcie->bridge_lock, flags);
> +		return NOTIFY_DONE;
> +	}
> +
> +	/* Read all necessary registers so we can release the spinlock ASAP */
> +	info = readl(base + PCIE_OUTB_ERR_ACC_INFO);
> +	is_cfg_err = !!(info & PCIE_OUTB_ERR_ACC_INFO_CFG_ERR_MASK);
> +	is_mem_err = !!(info & PCIE_OUTB_ERR_ACC_INFO_MEM_ERR_MASK);
> +	if (is_cfg_err) {
> +		cfg_addr = readl(base + PCIE_OUTB_ERR_ACC_ADDR);
> +		cfg_cause = readl(base + PCIE_OUTB_ERR_CFG_CAUSE);
> +	}
> +	if (is_mem_err) {
> +		mem_cause = readl(base + PCIE_OUTB_ERR_MEM_CAUSE);
> +		lo = readl(base + PCIE_OUTB_ERR_MEM_ADDR_LO);
> +		hi = readl(base + PCIE_OUTB_ERR_MEM_ADDR_HI);
> +	}
> +	/* We've got all of the info, clear the error */
> +	writel(1, base + PCIE_OUTB_ERR_CLEAR);
> +	spin_unlock_irqrestore(&pcie->bridge_lock, flags);
> +
> +	dev_err(pcie->dev, "handling %s error notification\n", type);
> +	width_str = (info & PCIE_OUTB_ERR_ACC_INFO_TYPE_64_MASK) ? "64bit" : "32bit";
> +	direction_str = (info & PCIE_OUTB_ERR_ACC_INFO_DIR_WRITE_MASK) ? "Write" : "Read";
> +	lanes = FIELD_GET(PCIE_OUTB_ERR_ACC_INFO_BYTE_LANES_MASK, info);
> +	for (i = 0, lanes_str[8] = 0; i < 8; i++)
> +		lanes_str[i] = (lanes & (1 << i)) ? '1' : '0';
> +
> +	if (is_cfg_err) {
> +		int bus = FIELD_GET(PCIE_OUTB_ERR_ACC_ADDR_BUS_MASK, cfg_addr);
> +		int dev = FIELD_GET(PCIE_OUTB_ERR_ACC_ADDR_DEV_MASK, cfg_addr);
> +		int func = FIELD_GET(PCIE_OUTB_ERR_ACC_ADDR_FUNC_MASK, cfg_addr);
> +		int reg = FIELD_GET(PCIE_OUTB_ERR_ACC_ADDR_REG_MASK, cfg_addr);
> +
> +		dev_err(pcie->dev, "Error: CFG Acc, %s, %s, Bus=%d, Dev=%d, Fun=%d, Reg=0x%x, lanes=%s\n",
> +			width_str, direction_str, bus, dev, func, reg, lanes_str);
> +		dev_err(pcie->dev, " Type: TO=%d Abt=%d UnsupReq=%d AccTO=%d AccDsbld=%d Acc64bit=%d\n",
> +			!!(cfg_cause & PCIE_OUTB_ERR_CFG_CAUSE_TIMEOUT_MASK),
> +			!!(cfg_cause & PCIE_OUTB_ERR_CFG_CAUSE_ABORT_MASK),
> +			!!(cfg_cause & PCIE_OUTB_ERR_CFG_CAUSE_UNSUPP_REQ_MASK),
> +			!!(cfg_cause & PCIE_OUTB_ERR_CFG_CAUSE_ACC_TIMEOUT_MASK),
> +			!!(cfg_cause & PCIE_OUTB_ERR_CFG_CAUSE_ACC_DISABLED_MASK),
> +			!!(cfg_cause & PCIE_OUTB_ERR_CFG_CAUSE_ACC_64BIT__MASK));
> +	}
> +
> +	if (is_mem_err) {
> +		u64 addr = ((u64)hi << 32) | (u64)lo;
> +
> +		dev_err(pcie->dev, "Error: Mem Acc, %s, %s, @0x%llx, lanes=%s\n",
> +			width_str, direction_str, addr, lanes_str);
> +		dev_err(pcie->dev, " Type: TO=%d Abt=%d UnsupReq=%d AccDsble=%d BadAddr=%d\n",
> +			!!(mem_cause & PCIE_OUTB_ERR_MEM_CAUSE_TIMEOUT_MASK),
> +			!!(mem_cause & PCIE_OUTB_ERR_MEM_CAUSE_ABORT_MASK),
> +			!!(mem_cause & PCIE_OUTB_ERR_MEM_CAUSE_UNSUPP_REQ_MASK),
> +			!!(mem_cause & PCIE_OUTB_ERR_MEM_CAUSE_ACC_DISABLED_MASK),
> +			!!(mem_cause & PCIE_OUTB_ERR_MEM_CAUSE_BAD_ADDR_MASK));
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
> +static int brcm_pcie_die_notify_cb(struct notifier_block *self,
> +				   unsigned long v, void *p)
> +{
> +	struct brcm_pcie *pcie =
> +		container_of(self, struct brcm_pcie, die_notifier);
> +
> +	return _brcm_pcie_dump_err(pcie, "Die");
> +}
> +
> +static int brcm_pcie_panic_notify_cb(struct notifier_block *self,
> +				     unsigned long v, void *p)
> +{
> +	struct brcm_pcie *pcie =
> +		container_of(self, struct brcm_pcie, panic_notifier);
> +
> +	return _brcm_pcie_dump_err(pcie, "Panic");
> +}
> +
> +static void brcm_register_die_notifiers(struct brcm_pcie *pcie)
> +{
> +	pcie->panic_notifier.notifier_call = brcm_pcie_panic_notify_cb;
> +	atomic_notifier_chain_register(&panic_notifier_list,
> +				       &pcie->panic_notifier);
> +
> +	pcie->die_notifier.notifier_call = brcm_pcie_die_notify_cb;
> +	register_die_notifier(&pcie->die_notifier);
> +}
> +
> +static void brcm_unregister_die_notifiers(struct brcm_pcie *pcie)
> +{
> +	unregister_die_notifier(&pcie->die_notifier);
> +	atomic_notifier_chain_unregister(&panic_notifier_list,
> +					 &pcie->panic_notifier);
> +}
> +
>  static void __brcm_pcie_remove(struct brcm_pcie *pcie)
>  {
>  	brcm_msi_remove(pcie);
> @@ -1729,6 +1876,9 @@ static void brcm_pcie_remove(struct platform_device *pdev)
>  
>  	pci_stop_root_bus(bridge->bus);
>  	pci_remove_root_bus(bridge->bus);
> +	if (pcie->cfg->has_err_report)
> +		brcm_unregister_die_notifiers(pcie);
> +
>  	__brcm_pcie_remove(pcie);
>  }
>  
> @@ -1829,6 +1979,7 @@ static const struct pcie_cfg_data bcm7216_cfg = {
>  	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_7278,
>  	.has_phy	= true,
>  	.num_inbound_wins = 3,
> +	.has_err_report = true,
>  };
>  
>  static const struct pcie_cfg_data bcm7712_cfg = {
> @@ -2003,8 +2154,10 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	if (pcie->cfg->has_err_report)
> +	if (pcie->cfg->has_err_report) {
>  		spin_lock_init(&pcie->bridge_lock);
> +		brcm_register_die_notifiers(pcie);
> +	}
>  
>  	return 0;
>  
> -- 
> 2.34.1
> 


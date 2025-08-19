Return-Path: <linux-pci+bounces-34314-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFD4B2C98C
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 18:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99BB9621EB5
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 16:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8F3248F42;
	Tue, 19 Aug 2025 16:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z49I23YB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53EE244661;
	Tue, 19 Aug 2025 16:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755620600; cv=none; b=bNNv7YfBZNtpDG2k7b1mvxqCsYTl/S0LzbszOd2I7436JrkawtQw4sl9RBIDiW9gH77Tjoy+Xr5E1BeTv/T6zvq0l9C3syC8L5sCi0BvpYRscXQetScY6i8LIkDFPhCuDTNvrbzoNBgv77QXMhWUETpnVzJTpXm+0ev2N7msaqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755620600; c=relaxed/simple;
	bh=TG5mF2gjBHDGc+RyikyQdTbwl4JX+eFWd/654sv2CnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GDvuc5W0PExYmo09QL5yvkI603rnXvaYThHM28HQi20gwmmi6UL17UB4HJK/mo1901L8BDTtZfTp4VpjRyWLlN75RM0mUiLHf70ilWDb67f1YTCnsEhhgdf4vcYfzNvfWWpENuaV/b4WHly+PtxX8CgNZvwrGerpDxKYN2N/EKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z49I23YB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B6DC4CEF1;
	Tue, 19 Aug 2025 16:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755620600;
	bh=TG5mF2gjBHDGc+RyikyQdTbwl4JX+eFWd/654sv2CnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z49I23YBEcE6OODH3koS1wODoZghGgpRhOfO6tYy5rGLdr/3RC82LDPQVokBwBnWp
	 ggAntLrGmehOlk7JiHw7h6X8HN0ecTeXZoWVdBgzLHgLP94n6w7QgAyXemsS9LTbWk
	 lJ1q+3qNOFtmpN8HegpxeG7oX6SC9k3wAPllJqoj1CxtsD4C810YWlfKXEHJnS2pY8
	 UtBaXvUfQ4j4I2KSYXF/mkXl7vYXpXkeN/Qzw5Hkvp7S1eMzp4/DOWZ1BeJFaD7mxG
	 Lc5Nvw5qtNM1+HgGhDsTBnoAayiZu6RyksBiSwm7d+tT1zoymTfZA6bQD/syxPJK6/
	 DuPSl0cyo7Chg==
Date: Tue, 19 Aug 2025 21:53:11 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
	Cyril Brulebois <kibi@debian.org>, bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] PCI: brcmstb: Add panic/die handler to driver
Message-ID: <on7eajzjb7bb5ut4jiwxgi4gckhspar4eztmvzfslemoohr6kr@ccffktlzlpcn>
References: <20250807221513.1439407-1-james.quinlan@broadcom.com>
 <20250807221513.1439407-3-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250807221513.1439407-3-james.quinlan@broadcom.com>

On Thu, Aug 07, 2025 at 06:15:13PM GMT, Jim Quinlan wrote:
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
> 
> Example error output:
>   brcm-pcie 8b20000.pcie: Error: Mem Acc: 32bit, Read, @0x38000000
>   brcm-pcie 8b20000.pcie:  Type: TO=0 Abt=0 UnspReq=1 AccDsble=0 BadAddr=0
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 155 +++++++++++++++++++++++++-
>  1 file changed, 154 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index ceb431a252b7..43c4ada3de07 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -14,15 +14,18 @@
>  #include <linux/irqchip/chained_irq.h>
>  #include <linux/irqchip/irq-msi-lib.h>
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
> @@ -156,6 +159,39 @@
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
> @@ -305,6 +341,8 @@ struct brcm_pcie {
>  	struct subdev_regulators *sr;
>  	bool			ep_wakeup_capable;
>  	const struct pcie_cfg_data	*cfg;
> +	struct notifier_block	die_notifier;
> +	struct notifier_block	panic_notifier;
>  	bool			bridge_on;
>  	spinlock_t		bridge_lock;
>  };
> @@ -1730,6 +1768,115 @@ static int brcm_pcie_resume_noirq(struct device *dev)
>  	return ret;
>  }
>  
> +/* Dump out PCIe errors on die or panic */
> +static int _brcm_pcie_dump_err(struct brcm_pcie *pcie,
> +			       const char *type)
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

You are not *handling* the error, but just dumping the registers due to the
error. So this error message is misleading.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


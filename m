Return-Path: <linux-pci+bounces-35182-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03819B3CB41
	for <lists+linux-pci@lfdr.de>; Sat, 30 Aug 2025 15:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5047D7A6633
	for <lists+linux-pci@lfdr.de>; Sat, 30 Aug 2025 13:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA72B25484B;
	Sat, 30 Aug 2025 13:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxJNgThA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0702144D7;
	Sat, 30 Aug 2025 13:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756560557; cv=none; b=eaCydDbW1+bqx85iTeHZUahvKVN5QFtkg2Qxpbh8N7XDG89A/uqZyzhUqAd6RuSgd4jDvHtyTleJ9RI1RWepUDpU4xTcv0KOu+okyJRkgFiUUEvhQRj/A8r3yMu50wRhUVfB01vW+P8uj/6hD5gF6luHws4RQS0HHS64a1iHybc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756560557; c=relaxed/simple;
	bh=0+63bx8jI+4n91OtGNXbvlLcLUdxsTZkOxwpEnYZwyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8Q+oyUIL23pQLsx294mnRvQf+GHKK+zXpMshicL9QUYfHrXpistqMR0wb8jV+/oIjqKbnkQsfohEYDpOlaI7mzHRWvRz/jUF8nJUZuISmHBmTsX602CFXirWx5m2CQMuaSwKbiSEactiiMCVzjx3p0OoPxUsDAahWBnmmNOKCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxJNgThA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0100C4CEEB;
	Sat, 30 Aug 2025 13:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756560557;
	bh=0+63bx8jI+4n91OtGNXbvlLcLUdxsTZkOxwpEnYZwyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BxJNgThA7EVc2p8igowIhslgzn1gf+EANLf8LpVOdYBVnoci2UleipeyVLVMY2wuY
	 GUYm1F/43+sXUvrOok04srqcT+FueagThOYGoNemD/QfROzvzd2PxO2fKMeCBBF9fr
	 0raM/U4D8WO1K7cYsO5wmFxgc5pextOtEkg2z8WJl0ANaEwKqIHBRg+MvLE1kpxFu1
	 QdtSY4oAxnvpmFE9EI4nOixgmx214i7cjLZlRUL85Y0Kkrq/PcNPWmLuTgnIbv/Tfq
	 MbMIfHTQ+clyHbux6jR2t5/R/idiqMGM2F0v4mcY/HfZSebFywM9+CaRXOcVHYFcVZ
	 AkuOGnTY88C7A==
Date: Sat, 30 Aug 2025 18:59:08 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: hans.zhang@cixtech.com
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	robh@kernel.org, kwilczynski@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	mpillai@cadence.com, fugang.duan@cixtech.com, guoyin.chen@cixtech.com, 
	peter.chen@cixtech.com, cix-kernel-upstream@cixtech.com, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 12/15] PCI: sky1: Add PCIe host support for CIX Sky1
Message-ID: <ssk2aolyodglbfvql66uk3snopnyneocoom2ymqhqc4lywugfo@2hmsuzgrutuw>
References: <20250819115239.4170604-1-hans.zhang@cixtech.com>
 <20250819115239.4170604-13-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250819115239.4170604-13-hans.zhang@cixtech.com>

On Tue, Aug 19, 2025 at 07:52:36PM GMT, hans.zhang@cixtech.com wrote:
> From: Hans Zhang <hans.zhang@cixtech.com>
> 
> Add driver for the CIX Sky1 SoC PCIe Gen4 16 GT/s controller based
> on the Cadence PCIe core.
> 
> Supports MSI/MSI-x via GICv3, Single Virtual Channel, Single Function.
> 
> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
> ---
> Changes for v8:
> - Optimization of CIX SKY1 Root Port driver. (Bjorn and Krzysztof)
> - Use devm_platform_ioremap_resource_byname.
> ---
>  drivers/pci/controller/cadence/Kconfig    |  15 ++
>  drivers/pci/controller/cadence/Makefile   |   1 +
>  drivers/pci/controller/cadence/pci-sky1.c | 232 ++++++++++++++++++++++
>  3 files changed, 248 insertions(+)
>  create mode 100644 drivers/pci/controller/cadence/pci-sky1.c
> 
> diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
> index 117677a23d68..26a248cdc78a 100644
> --- a/drivers/pci/controller/cadence/Kconfig
> +++ b/drivers/pci/controller/cadence/Kconfig
> @@ -42,6 +42,21 @@ config PCIE_CADENCE_PLAT_EP
>  	  endpoint mode. This PCIe controller may be embedded into many
>  	  different vendors SoCs.
>  
> +config PCI_SKY1_HOST
> +	tristate "CIX SKY1 PCIe controller (host mode)"
> +	depends on OF
> +	select PCIE_CADENCE_HOST
> +	select PCI_ECAM
> +	help
> +	  Say Y here if you want to support the CIX SKY1 PCIe platform
> +	  controller in host mode. CIX SKY1 PCIe controller uses Cadence
> +	  HPA (High Performance Architecture IP [Second generation of
> +	  Cadence PCIe IP])
> +
> +	  This driver requires Cadence PCIe core infrastructure
> +	  (PCIE_CADENCE_HOST) and hardware platform adaptation layer
> +	  to function.
> +
>  config PCI_J721E
>  	tristate
>  	select PCIE_CADENCE_HOST if PCI_J721E_HOST != n
> diff --git a/drivers/pci/controller/cadence/Makefile b/drivers/pci/controller/cadence/Makefile
> index de4ddae7aca4..40d7c6e98b4d 100644
> --- a/drivers/pci/controller/cadence/Makefile
> +++ b/drivers/pci/controller/cadence/Makefile
> @@ -8,3 +8,4 @@ obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host-mod.o
>  obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep-mod.o
>  obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
>  obj-$(CONFIG_PCI_J721E) += pci-j721e.o
> +obj-$(CONFIG_PCI_SKY1_HOST) += pci-sky1.o
> diff --git a/drivers/pci/controller/cadence/pci-sky1.c b/drivers/pci/controller/cadence/pci-sky1.c
> new file mode 100644
> index 000000000000..7dd3546275c5
> --- /dev/null
> +++ b/drivers/pci/controller/cadence/pci-sky1.c
> @@ -0,0 +1,232 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PCIe controller driver for CIX's sky1 SoCs
> + *

No copyright for CIX tech?

> + * Author: Hans Zhang <hans.zhang@cixtech.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/pci.h>
> +#include <linux/pci-ecam.h>
> +#include <linux/pci_ids.h>
> +
> +#include "pcie-cadence.h"
> +#include "pcie-cadence-host-common.h"
> +
> +#define STRAP_REG(n)			((n) * 0x04)
> +#define STATUS_REG(n)			((n) * 0x04)
> +#define  LINK_TRAINING_ENABLE		BIT(0)
> +#define  LINK_COMPLETE			BIT(0)

Extra space.

> +
> +#define SKY1_IP_REG_BANK		0x1000
> +#define SKY1_IP_CFG_CTRL_REG_BANK	0x4c00
> +#define SKY1_IP_AXI_MASTER_COMMON	0xf000
> +#define SKY1_AXI_SLAVE			0x9000
> +#define SKY1_AXI_MASTER			0xb000
> +#define SKY1_AXI_HLS_REGISTERS		0xc000
> +#define SKY1_AXI_RAS_REGISTERS		0xe000
> +#define SKY1_DTI_REGISTERS		0xd000
> +
> +#define IP_REG_I_DBG_STS_0		0x420
> +
> +struct sky1_pcie {
> +	struct cdns_pcie *cdns_pcie;
> +	struct cdns_pcie_rc *cdns_pcie_rc;
> +
> +	struct resource *cfg_res;
> +	struct resource *msg_res;
> +	struct pci_config_window *cfg;
> +	void __iomem *strap_base;
> +	void __iomem *status_base;
> +	void __iomem *reg_base;
> +	void __iomem *cfg_base;
> +	void __iomem *msg_base;
> +};
> +
> +static int sky1_pcie_resource_get(struct platform_device *pdev,
> +				  struct sky1_pcie *pcie)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct resource *res;
> +	void __iomem *base;
> +
> +	base = devm_platform_ioremap_resource_byname(pdev, "reg");
> +	if (IS_ERR(base))
> +		return dev_err_probe(dev, PTR_ERR(base),
> +				     "unable to find reg registers\n");

"unable to find \"reg\" registers". Same for below prints.

> +	pcie->reg_base = base;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
> +	if (!res)
> +		return dev_err_probe(dev, ENXIO, "unable to get cfg resource\n");
> +	pcie->cfg_res = res;
> +
> +	base = devm_platform_ioremap_resource_byname(pdev, "rcsu_strap");
> +	if (IS_ERR(base))
> +		return dev_err_probe(dev, PTR_ERR(base),
> +				     "unable to find rcsu strap registers\n");
> +	pcie->strap_base = base;
> +
> +	base = devm_platform_ioremap_resource_byname(pdev, "rcsu_status");
> +	if (IS_ERR(base))
> +		return dev_err_probe(dev, PTR_ERR(base),
> +				     "unable to find rcsu status registers\n");
> +	pcie->status_base = base;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "msg");
> +	if (!res)
> +		return dev_err_probe(dev, ENXIO, "unable to get msg resource\n");
> +	pcie->msg_res = res;
> +	pcie->msg_base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(pcie->msg_base)) {
> +		return dev_err_probe(dev, PTR_ERR(pcie->msg_base),
> +				     "unable to ioremap msg resource\n");
> +	}
> +
> +	return 0;
> +}
> +
> +static int sky1_pcie_start_link(struct cdns_pcie *cdns_pcie)
> +{
> +	struct sky1_pcie *pcie = dev_get_drvdata(cdns_pcie->dev);
> +	u32 val;
> +
> +	val = readl(pcie->strap_base + STRAP_REG(1));
> +	val |= LINK_TRAINING_ENABLE;
> +	writel(val, pcie->strap_base + STRAP_REG(1));
> +
> +	return 0;
> +}
> +
> +static void sky1_pcie_stop_link(struct cdns_pcie *cdns_pcie)
> +{
> +	struct sky1_pcie *pcie = dev_get_drvdata(cdns_pcie->dev);
> +	u32 val;
> +
> +	val = readl(pcie->strap_base + STRAP_REG(1));
> +	val &= ~LINK_TRAINING_ENABLE;
> +	writel(val, pcie->strap_base + STRAP_REG(1));
> +}
> +
> +static bool sky1_pcie_link_up(struct cdns_pcie *cdns_pcie)
> +{
> +	u32 val;
> +
> +	val = cdns_pcie_hpa_readl(cdns_pcie, REG_BANK_IP_REG,
> +				  IP_REG_I_DBG_STS_0);
> +	return val & LINK_COMPLETE;
> +}
> +
> +static const struct cdns_pcie_ops sky1_pcie_ops = {
> +	.start_link = sky1_pcie_start_link,
> +	.stop_link = sky1_pcie_stop_link,
> +	.link_up = sky1_pcie_link_up,
> +};
> +
> +static int sky1_pcie_probe(struct platform_device *pdev)
> +{
> +	struct cdns_plat_pcie_of_data *reg_off;
> +	struct device *dev = &pdev->dev;
> +	struct pci_host_bridge *bridge;
> +	struct cdns_pcie *cdns_pcie;
> +	struct resource_entry *bus;
> +	struct cdns_pcie_rc *rc;
> +	struct sky1_pcie *pcie;
> +	int ret;
> +
> +	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> +	if (!pcie)
> +		return -ENOMEM;
> +
> +	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*rc));
> +	if (!bridge)
> +		return -ENOMEM;
> +
> +	ret = sky1_pcie_resource_get(pdev, pcie);
> +	if (ret < 0)
> +		return -ENXIO;

return ret;

- Mani

-- 
மணிவண்ணன் சதாசிவம்


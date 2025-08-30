Return-Path: <linux-pci+bounces-35169-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E50EFB3C7AF
	for <lists+linux-pci@lfdr.de>; Sat, 30 Aug 2025 05:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA94F18870B8
	for <lists+linux-pci@lfdr.de>; Sat, 30 Aug 2025 03:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4973A275847;
	Sat, 30 Aug 2025 03:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pEfpekn8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C3F270EAB;
	Sat, 30 Aug 2025 03:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756526078; cv=none; b=eO998g3OOp6IePfQ1wdQvkSFz5IJAupJHx26Jfn9GCdWdTIK9jGInJulZOPXZtqtVvTX+G6RRyxxS69OnBO8mTeBy4HZBsPO2sHt7wfUpFq/XYWFowNAeFN6jqKIvQkSzvsP5DcLyGW92IKfSDHe8nt5kdglkV/5vazmJH316s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756526078; c=relaxed/simple;
	bh=BtSQbHdcttBYNplOGWR0d64OLWQRbQrEyBpxCCGTnrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XU8qW7C9GZjooEZtXkGFZ+4p6JbNqrGuzpXrWLOAR4eCULz0RVmvvQ9Cm+aS0i4ihrlzIVn3lU8LRPu+yIktjDXnGnDM64uuC/hpuISh0ChkURtVqiVDD+Oa6ohBFh6iaYToYmmqOFSGf6nVNYMmpJBenSNM/xfJSpZENKi8W10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pEfpekn8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F41C4CEF6;
	Sat, 30 Aug 2025 03:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756526077;
	bh=BtSQbHdcttBYNplOGWR0d64OLWQRbQrEyBpxCCGTnrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pEfpekn8Ts5RbY7Nc0M9zFodNoHHVTXhN3xQBweYUjhIww2TUngcSC0rF7Veqph7x
	 6H8xKHMmzdUNzoSB2ho5Ba6H3zP6we5qK35FziFjZa+XL0n1y8FgESsVjctfN0MnVw
	 z34wYUAXCMmTqwYyJa4+AviARFQFKq1pbwJP6byItQfatbcO5XRV8E9RH6xJ7HOVCE
	 wpwZ5WuFkyo7A07/5ZwAA1t3qsoIut8OpBqCuOZCZlRZyI99yumTndr1sm90gMQjBT
	 zJxJTFCF16mNsPB+k6jk0jmrzgVb22/r3IQFLvfHQo5J+nN3bkoibqbw66J9pZ3LEs
	 OI+Zbs9uNX8cA==
Date: Sat, 30 Aug 2025 09:24:28 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Shradha Todi <shradha.t@samsung.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
	bhelgaas@google.com, jingoohan1@gmail.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
	alim.akhtar@samsung.com, vkoul@kernel.org, kishon@kernel.org, arnd@arndb.de, 
	m.szyprowski@samsung.com, jh80.chung@samsung.com, pankaj.dubey@samsung.com
Subject: Re: [PATCH v3 11/12] PCI: exynos: Add support for Tesla FSD SoC
Message-ID: <sss3py6cquhcipil3645pgc535ggfewolsld4e4g3v5yr3yvoc@3n57p4cyk43r>
References: <20250811154638.95732-1-shradha.t@samsung.com>
 <CGME20250811154742epcas5p3276c7c053bedc526d9ce370dda83e195@epcas5p3.samsung.com>
 <20250811154638.95732-12-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250811154638.95732-12-shradha.t@samsung.com>

On Mon, Aug 11, 2025 at 09:16:37PM GMT, Shradha Todi wrote:
> Add host and endpoint controller driver support for FSD SoC.
> 

Again, more info about the controller required.

> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> ---
>  drivers/pci/controller/dwc/pci-exynos.c | 278 ++++++++++++++++++++++++
>  1 file changed, 278 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
> index ef1f42236575..9aabfecdc147 100644
> --- a/drivers/pci/controller/dwc/pci-exynos.c
> +++ b/drivers/pci/controller/dwc/pci-exynos.c
> @@ -18,6 +18,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/phy/phy.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/syscon.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  
> @@ -49,15 +51,35 @@
>  #define EXYNOS_PCIE_ELBI_SLV_ARMISC		0x120
>  #define EXYNOS_PCIE_ELBI_SLV_DBI_ENABLE		BIT(21)
>  
> +#define FSD_IRQ2_STS				0x008
> +#define FSD_IRQ_MSI_ENABLE			BIT(17)
> +#define FSD_IRQ2_EN				0x018
> +#define FSD_PCIE_APP_LTSSM_ENABLE		0x054
> +#define FSD_PCIE_LTSSM_ENABLE			0x1
> +#define FSD_PCIE_DEVICE_TYPE			0x080
> +#define FSD_DEVICE_TYPE_RC			0x4
> +#define FSD_DEVICE_TYPE_EP			0x0
> +#define FSD_PCIE_CXPL_DEBUG_00_31		0x2c8
> +
>  /* to store different SoC variants of Samsung */
>  enum samsung_pcie_variants {
> +	FSD,
>  	EXYNOS_5433,

I hope you are going to drop these variants and use the properties for specific
functionality as suggested by Bjorn.

>  };
>  
> +/* Values to be written to SYSREG to view DBI space as CDM/DBI2/IATU/DMA */
> +enum fsd_pcie_addr_type {
> +	ADDR_TYPE_DBI = 0x0,
> +	ADDR_TYPE_DBI2 = 0x12,
> +	ADDR_TYPE_ATU = 0x36,
> +	ADDR_TYPE_DMA = 0x3f,
> +};
> +
>  struct samsung_pcie_pdata {
>  	struct pci_ops				*pci_ops;
>  	const struct dw_pcie_ops		*dwc_ops;
>  	const struct dw_pcie_host_ops		*host_ops;
> +	const struct dw_pcie_ep_ops		*ep_ops;
>  	const struct samsung_res_ops		*res_ops;
>  	unsigned int				soc_variant;
>  	enum dw_pcie_device_mode		device_mode;
> @@ -67,6 +89,8 @@ struct exynos_pcie {
>  	struct dw_pcie			pci;
>  	void __iomem			*elbi_base;
>  	const struct samsung_pcie_pdata	*pdata;
> +	struct regmap			*sysreg;
> +	unsigned int			sysreg_offset;
>  	struct clk_bulk_data		*clks;
>  	struct phy			*phy;
>  	struct regulator_bulk_data	*supplies;
> @@ -334,11 +358,201 @@ static const struct dw_pcie_ops exynos_dw_pcie_ops = {
>  	.start_link = exynos_pcie_start_link,
>  };
>  
> +static void fsd_pcie_stop_link(struct dw_pcie *pci)
> +{
> +	u32 val;
> +	struct exynos_pcie *ep = to_exynos_pcie(pci);

Please use reverse Xmas order for local variables.

> +
> +	val = readl(ep->elbi_base + FSD_PCIE_APP_LTSSM_ENABLE);
> +	val &= ~FSD_PCIE_LTSSM_ENABLE;
> +	writel(val, ep->elbi_base + FSD_PCIE_APP_LTSSM_ENABLE);
> +}
> +
> +static int fsd_pcie_start_link(struct dw_pcie *pci)
> +{
> +	struct exynos_pcie *ep = to_exynos_pcie(pci);
> +	struct dw_pcie_ep *dw_ep = &pci->ep;
> +
> +	if (dw_pcie_link_up(pci))
> +		return 0;
> +
> +	writel(FSD_PCIE_LTSSM_ENABLE, ep->elbi_base + FSD_PCIE_APP_LTSSM_ENABLE);
> +
> +	/* no need to wait for link in case of host as core files take care */

What do you mean by 'core files'? DWC core driver?

> +	if (ep->pdata->device_mode == DW_PCIE_RC_TYPE)
> +		return 0;
> +
> +	/* check if the link is up or not in case of EP */
> +	if (!dw_pcie_wait_for_link(pci)) {

I presume there is no way to detect link up using the SPI interrupt?

> +		dw_pcie_ep_linkup(dw_ep);
> +		return 0;
> +	}
> +
> +	return -ETIMEDOUT;
> +}
> +
> +static irqreturn_t fsd_pcie_irq_handler(int irq, void *arg)
> +{
> +	u32 val;
> +	struct exynos_pcie *ep = arg;
> +	struct dw_pcie *pci = &ep->pci;
> +	struct dw_pcie_rp *pp = &pci->pp;
> +
> +	val = readl(ep->elbi_base + FSD_IRQ2_STS);
> +	if ((val & FSD_IRQ_MSI_ENABLE) == FSD_IRQ_MSI_ENABLE) {
> +		val &= FSD_IRQ_MSI_ENABLE;
> +		writel(val, ep->elbi_base + FSD_IRQ2_STS);
> +		dw_handle_msi_irq(pp);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void fsd_pcie_msi_init(struct exynos_pcie *ep)
> +{
> +	int val;
> +
> +	val = readl(ep->elbi_base + FSD_IRQ2_EN);
> +	val |= FSD_IRQ_MSI_ENABLE;
> +	writel(val, ep->elbi_base + FSD_IRQ2_EN);

Could you please explain how MSI handling works? I don't understand it.

> +}
> +
> +static void __iomem *fsd_atu_setting(struct dw_pcie *pci, void __iomem *base)
> +{
> +	struct exynos_pcie *ep = to_exynos_pcie(pci);
> +
> +	if (base >= pci->atu_base) {
> +		regmap_write(ep->sysreg, ep->sysreg_offset, ADDR_TYPE_ATU);
> +		return (base - DEFAULT_DBI_ATU_OFFSET);
> +	} else if (base == pci->dbi_base) {
> +		regmap_write(ep->sysreg, ep->sysreg_offset, ADDR_TYPE_DBI);
> +	} else if (base == pci->dbi_base2) {
> +		regmap_write(ep->sysreg, ep->sysreg_offset, ADDR_TYPE_DBI2);
> +	}
> +
> +	return base;
> +}
> +
> +static u32 fsd_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base,
> +				u32 reg, size_t size)
> +{
> +	void __iomem *addr;
> +	u32 val;
> +
> +	addr = fsd_atu_setting(pci, base);

The returned 'addr' seems to be static. Why can't you just store it during probe
and use the 'addr' directly?

> +	dw_pcie_read(addr + reg, size, &val);
> +
> +	return val;
> +}
> +
> +static void fsd_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base,
> +				u32 reg, size_t size, u32 val)
> +{
> +	void __iomem *addr;
> +
> +	addr = fsd_atu_setting(pci, base);
> +	dw_pcie_write(addr + reg, size, val);
> +}
> +
> +static void fsd_pcie_write_dbi2(struct dw_pcie *pci, void __iomem *base,
> +				u32 reg, size_t size, u32 val)
> +{
> +	struct exynos_pcie *ep = to_exynos_pcie(pci);
> +
> +	fsd_atu_setting(pci, base);
> +	dw_pcie_write(pci->dbi_base + reg, size, val);
> +	regmap_write(ep->sysreg, ep->sysreg_offset, ADDR_TYPE_DBI);
> +}
> +
> +static bool fsd_pcie_link_up(struct dw_pcie *pci)
> +{
> +	u32 val;
> +	struct exynos_pcie *ep = to_exynos_pcie(pci);
> +
> +	val = readl(ep->elbi_base + FSD_PCIE_CXPL_DEBUG_00_31);
> +	val &= PORT_LOGIC_LTSSM_STATE_MASK;
> +
> +	return (val == PORT_LOGIC_LTSSM_STATE_L0);
> +}
> +
> +static int fsd_pcie_host_init(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct exynos_pcie *ep = to_exynos_pcie(pci);
> +
> +	phy_init(ep->phy);
> +	fsd_pcie_msi_init(ep);
> +
> +	return 0;
> +}
> +
> +static const struct dw_pcie_host_ops fsd_pcie_host_ops = {
> +	.init = fsd_pcie_host_init,
> +};
> +
> +static int fsd_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> +				 unsigned int type, u16 interrupt_num)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +
> +	switch (type) {
> +	case PCI_IRQ_INTX:
> +		return dw_pcie_ep_raise_intx_irq(ep, func_no);
> +	case PCI_IRQ_MSIX:
> +		dev_err(pci->dev, "EP does not support MSI-X\n");
> +		return -EINVAL;
> +	case PCI_IRQ_MSI:
> +		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> +	default:
> +		dev_err(pci->dev, "UNKNOWN IRQ type\n");

Do you want to return success below even for this error?

> +	}
> +
> +	return 0;

this should be -EOPNOTSUPP.

> +}
> +
> +static const struct pci_epc_features fsd_pcie_epc_features = {
> +	.linkup_notifier = false,

Default value is 'false'. So no need to initialize it agian.

> +	.msi_capable = true,
> +	.msix_capable = false,

Here also.

> +};
> +
> +static const struct pci_epc_features *fsd_pcie_get_features(struct dw_pcie_ep *ep)
> +{
> +	return &fsd_pcie_epc_features;
> +}
> +
> +static const struct dw_pcie_ep_ops fsd_ep_ops = {
> +	.raise_irq	= fsd_pcie_raise_irq,
> +	.get_features	= fsd_pcie_get_features,
> +};
> +
> +static void fsd_set_device_mode(struct exynos_pcie *ep)
> +{
> +	if (ep->pdata->device_mode == DW_PCIE_RC_TYPE)
> +		writel(FSD_DEVICE_TYPE_RC, ep->elbi_base + FSD_PCIE_DEVICE_TYPE);
> +	else
> +		writel(FSD_DEVICE_TYPE_EP, ep->elbi_base + FSD_PCIE_DEVICE_TYPE);
> +}
> +
> +static const struct dw_pcie_ops fsd_dw_pcie_ops = {
> +	.read_dbi	= fsd_pcie_read_dbi,
> +	.write_dbi	= fsd_pcie_write_dbi,
> +	.write_dbi2	= fsd_pcie_write_dbi2,
> +	.start_link	= fsd_pcie_start_link,
> +	.stop_link	= fsd_pcie_stop_link,
> +	.link_up	= fsd_pcie_link_up,
> +};
> +
>  static const struct samsung_res_ops exynos_res_ops_data = {
>  	.init_regulator		= exynos_init_regulator,
>  	.pcie_irq_handler	= exynos_pcie_irq_handler,
>  };
>  
> +static const struct samsung_res_ops fsd_res_ops_data = {
> +	.pcie_irq_handler	= fsd_pcie_irq_handler,
> +	.set_device_mode	= fsd_set_device_mode,
> +};
> +
>  static int exynos_pcie_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -361,6 +575,26 @@ static int exynos_pcie_probe(struct platform_device *pdev)
>  	if (IS_ERR(ep->phy))
>  		return PTR_ERR(ep->phy);
>  
> +	if (ep->pdata->soc_variant == FSD) {
> +		ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(36));
> +		if (ret)
> +			return ret;
> +
> +		ep->sysreg = syscon_regmap_lookup_by_phandle(dev->of_node,
> +				"samsung,syscon-pcie");
> +		if (IS_ERR(ep->sysreg)) {
> +			dev_err(dev, "sysreg regmap lookup failed.\n");

Use dev_err_probe() here and below.

> +			return PTR_ERR(ep->sysreg);
> +		}
> +
> +		ret = of_property_read_u32_index(dev->of_node, "samsung,syscon-pcie", 1,
> +						 &ep->sysreg_offset);
> +		if (ret) {
> +			dev_err(dev, "couldn't get the register offset for syscon!\n");
> +			return ret;
> +		}
> +	}
> +
>  	/* External Local Bus interface (ELBI) registers */
>  	ep->elbi_base = devm_platform_ioremap_resource_byname(pdev, "elbi");
>  	if (IS_ERR(ep->elbi_base))
> @@ -397,6 +631,22 @@ static int exynos_pcie_probe(struct platform_device *pdev)
>  		if (ret < 0)
>  			goto fail_phy_init;
>  
> +		break;
> +	case DW_PCIE_EP_TYPE:
> +		phy_init(ep->phy);
> +
> +		ep->pci.ep.ops = pdata->ep_ops;
> +
> +		ret = dw_pcie_ep_init(&ep->pci.ep);
> +		if (ret < 0)
> +			goto fail_phy_init;
> +
> +		ret = dw_pcie_ep_init_registers(&ep->pci.ep);
> +		if (ret)
> +			goto fail_phy_init;
> +
> +		pci_epc_init_notify(ep->pci.ep.epc);

So the platform doesn't support PERST# and generates its own refclk?

- Mani

-- 
மணிவண்ணன் சதாசிவம்


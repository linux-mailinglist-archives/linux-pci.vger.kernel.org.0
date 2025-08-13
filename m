Return-Path: <linux-pci+bounces-34001-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4011DB2573B
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 01:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41FB85A6A37
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 23:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD722FC870;
	Wed, 13 Aug 2025 23:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADgpGAYO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3DF2F656D;
	Wed, 13 Aug 2025 23:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755126466; cv=none; b=UW2n5xZvlbejvWFxmnd8bxXd7Ef2FeUUDrDm10d5SOftOM0fvTqaDmyil6GKUTT9Bx1O6VKiLW3N4rtRf9wI2f+RZurm23Hmb7nJ3d0YU7tzOZxNxC02N+g4P+DMlrsrjAUQRzIPfwCSW4gFDcyx528PUr75Bvezk7sP4nZcwUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755126466; c=relaxed/simple;
	bh=sAl2E1YmCIttRqa3R2EDMWfrF2/E5z2pxSqFYJ9C574=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VYyBgzQ8YtqfwC4fzcuA8iu3zLg3jk3tQsSzTtqc5kqyw7mQ9Y2cvctNaf7gvevAkj6Zs0ft6ZNBn1kcc2bxF9QObHbU3qB6LGdMH4FMMVw33jEwP+KLvftiSl3MlNwbdo91i645NH9bTo0cAIvos8eml8rlaJ2+EcJriZRmUfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADgpGAYO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9CC5C4CEEB;
	Wed, 13 Aug 2025 23:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755126465;
	bh=sAl2E1YmCIttRqa3R2EDMWfrF2/E5z2pxSqFYJ9C574=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ADgpGAYO90FH7j0Jog+v5yAD0PcxKe3FyvE3x1kpJbjyP+CbAYEigEmyLgE3TNH7O
	 z/cdTZs8XycnvBdn+LVSNTNDU+l6WDKwVlbS66ketRY1BmWsSFPUC8w6yNEC0OQnW5
	 ibMu+NM3wrQiCWiYduur1E6uaPq4IlZX0IuWqUdzw1hCQ9w0BJ3/BaNl2ESTnlYnSL
	 v2yxbehFoUyZAK2fiGVBIggwPAKFYRKiYmau/RDACy3KbJvhwd5l5zqGqhHbyu4a+n
	 dHooCAn6tbQRwMTnqOaaW4JCg8sRekJxRNRMua+eui+bw+hGRKc/Dwa0TI/S0w7UCC
	 ozWHMAx1wh5LA==
Date: Wed, 13 Aug 2025 18:07:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shradha Todi <shradha.t@samsung.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, mani@kernel.org,
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	bhelgaas@google.com, jingoohan1@gmail.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, alim.akhtar@samsung.com, vkoul@kernel.org,
	kishon@kernel.org, arnd@arndb.de, m.szyprowski@samsung.com,
	jh80.chung@samsung.com, pankaj.dubey@samsung.com
Subject: Re: [PATCH v3 11/12] PCI: exynos: Add support for Tesla FSD SoC
Message-ID: <20250813230744.GA299971@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811154638.95732-12-shradha.t@samsung.com>

On Mon, Aug 11, 2025 at 09:16:37PM +0530, Shradha Todi wrote:
> Add host and endpoint controller driver support for FSD SoC.

I think this might be easier if you added host mode first, then added
endpoint mode with a separate patch.

It's kind of unfortunate that the driver uses "ep" everywhere for
struct exynos_pcie pointers.  It's going to be confusing because "ep"
is also commonly used for endpoint-related things, e.g., struct
dw_pcie_ep pointers.  Maybe it's not worth changing; I dunno.

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
> +	if (ep->pdata->device_mode == DW_PCIE_RC_TYPE)
> +		return 0;
> +
> +	/* check if the link is up or not in case of EP */
> +	if (!dw_pcie_wait_for_link(pci)) {
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

This looks weird because FSD_IRQ_MSI_ENABLE sounds like an *enable*
bit, but here you're treating it as a *status* bit.

As far as I can tell, you set FSD_IRQ_MSI_ENABLE once at probe-time in
fsd_pcie_msi_init(), then you clear it here in an IRQ handler, and it
will never be set again.  That seems wrong; am I missing something?

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
> +}
> +
> +static void __iomem *fsd_atu_setting(struct dw_pcie *pci, void __iomem *base)

The "setting" name suggests that this merely returns an address
without side effects, but in fact it actively *sets* the view.

In this case there's no locking around:

  addr = fsd_atu_setting(pci, base);
  dw_pcie_read(addr + reg, size, &val);

even though concurrent calls would cause issues, but I think that's OK
because we only get there via the driver, and I assume multiple DBI or
DBI2 accesses never happen because they're not used in asynchronous
paths like interrupt handlers.

But I think a name that hints at the fact that this does have side
effects would be helpful as a reminder in the callers that they must
not be used concurrently.

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
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct pci_epc_features fsd_pcie_epc_features = {
> +	.linkup_notifier = false,
> +	.msi_capable = true,
> +	.msix_capable = false,

I think we should omit features we do *not* support instead of calling
them out explicitly, e.g., we don't need .linkup_notifier or
.msix_capable.

We've added them in the past, but they're unnecessary and they lead to
either pervasive changes (adding ".new_feature = false" to all
existing drivers when adding the feature) or inconsistency (new
drivers include ".new_feature = false" but existing drivers do not).

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

This is a good example of a complicated set of things where I think
you should either add a SoC-specific function pointer to do this or
test a property, e.g., "DMA width", instead of testing for a specific
SoC.

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
> +
>  		break;
>  	default:
>  		dev_err(dev, "invalid device type\n");
> @@ -436,6 +686,9 @@ static int exynos_pcie_suspend_noirq(struct device *dev)
>  	if (ep->pdata->device_mode == DW_PCIE_EP_TYPE)
>  		return 0;
>  
> +	if (ep->pdata->dwc_ops->stop_link)
> +		ep->pdata->dwc_ops->stop_link(pci);
> +
>  	if (ep->pdata->soc_variant == EXYNOS_5433)
>  		exynos_pcie_assert_core_reset(ep);
>  	phy_power_off(ep->phy);
> @@ -471,6 +724,23 @@ static const struct dev_pm_ops exynos_pcie_pm_ops = {
>  				  exynos_pcie_resume_noirq)
>  };
>  
> +
> +static const struct samsung_pcie_pdata fsd_hw3_pcie_rc_pdata = {
> +	.dwc_ops		= &fsd_dw_pcie_ops,
> +	.host_ops		= &fsd_pcie_host_ops,
> +	.res_ops		= &fsd_res_ops_data,
> +	.soc_variant		= FSD,
> +	.device_mode		= DW_PCIE_RC_TYPE,
> +};
> +
> +static const struct samsung_pcie_pdata fsd_hw3_pcie_ep_pdata = {
> +	.dwc_ops		= &fsd_dw_pcie_ops,
> +	.ep_ops			= &fsd_ep_ops,
> +	.res_ops		= &fsd_res_ops_data,
> +	.soc_variant		= FSD,
> +	.device_mode		= DW_PCIE_EP_TYPE,
> +};
> +
>  static const struct samsung_pcie_pdata exynos_5433_pcie_rc_pdata = {
>  	.dwc_ops		= &exynos_dw_pcie_ops,
>  	.pci_ops		= &exynos_pci_ops,
> @@ -485,6 +755,14 @@ static const struct of_device_id exynos_pcie_of_match[] = {
>  		.compatible = "samsung,exynos5433-pcie",
>  		.data = (void *) &exynos_5433_pcie_rc_pdata,
>  	},
> +	{
> +		.compatible = "tesla,fsd-pcie",
> +		.data = (void *) &fsd_hw3_pcie_rc_pdata,
> +	},
> +	{
> +		.compatible = "tesla,fsd-pcie-ep",
> +		.data = (void *) &fsd_hw3_pcie_ep_pdata,
> +	},
>  	{ },
>  };
>  
> -- 
> 2.49.0
> 


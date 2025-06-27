Return-Path: <linux-pci+bounces-30966-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E704AEBFF3
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 21:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCE0E566072
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 19:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728851C5496;
	Fri, 27 Jun 2025 19:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPazJm95"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D85190477;
	Fri, 27 Jun 2025 19:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751052648; cv=none; b=Tvx8k/FAejSwBLWx1W9DHKBudFZunNk7fkLH33cPqwfD7CJUdWzq8IQ/2RDbWqpvOMVUGLI4XfQx8DOJKrn70K7LGE2mffhgCz8dlWZ8GPtKgjCP1B6+CCNEZZ5OVvRNeBRkbROhB91OAqThoDm7qLIdt1kEaF0loKGgVMDFENI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751052648; c=relaxed/simple;
	bh=Ewt6x+TyLrnKWB9bcFNXn39ClBlBLwSs9oVDUkhN+5s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dEekOgAIrpjqnCL1+bbHybWARL7xqIXSaE1TR1XRBy8IGcF9o5fdKd5kXGnZhf1uPjxuwR2URAMxXWmNK/EjJstYerNd6q8Zakw9sYMT8Wu1Vj4zU8igcOh8Mzp0puCT3KRu2+qXjjm1eioRg6Ui/uzu/7fc0MlvcDk4f3ixPqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPazJm95; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A284EC4CEE3;
	Fri, 27 Jun 2025 19:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751052647;
	bh=Ewt6x+TyLrnKWB9bcFNXn39ClBlBLwSs9oVDUkhN+5s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=RPazJm95MCXTQsAh4h8EI9hYme1woTQj/7GHQ1aNwZf1LH+YtE91kNPlux6ZUBXs3
	 tmn7wLtMkotusbLg+Ipj1PXvDzK+Ih5zJaBq89DdFZX2y+yNquxaS3TzCfVg+rKSE3
	 cMh1XG5uXx3I+902Br+hvx+hOoBs5W1oSuav0bvOYvWquAGXVszjNqV0DMxIEZ9lXi
	 SQQ7PRmO6QpvO9Ghk+62IjRV130WaRg+4TzLphnxY5Me5G6m0eD5LpBqLnRjcjUarm
	 7YwJrjnxNeExgej4gvKNBhNgFbCi1cSRqguatqAJKpKOcGCFTA+mrrk3dp/kpQtqS6
	 i5SNPirztErfA==
Date: Fri, 27 Jun 2025 14:30:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shradha Todi <shradha.t@samsung.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-fsd@tesla.com,
	manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	jingoohan1@gmail.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	alim.akhtar@samsung.com, vkoul@kernel.org, kishon@kernel.org,
	arnd@arndb.de, m.szyprowski@samsung.com, jh80.chung@samsung.com,
	pankaj.dubey@samsung.com
Subject: Re: [PATCH v2 09/10] PCI: exynos: Add support for Tesla FSD SoC
Message-ID: <20250627193046.GA1673824@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625165229.3458-10-shradha.t@samsung.com>

On Wed, Jun 25, 2025 at 10:22:28PM +0530, Shradha Todi wrote:
> Add host and endpoint controller driver support for FSD SoC.

> +++ b/drivers/pci/controller/dwc/pci-exynos.c
> @@ -20,6 +20,8 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/syscon.h>

The trend is to sort these alphabetically.  The last couple additions
didn't observe this, but maybe these new ones could go a little
farther up and make it more sorted rather than less?

> +#define FSD_PCIE_CXPL_DEBUG_00_31		0x2C8

Existing #defines use lower-case hex; please follow suit.

> +/* to store different SoC variants of Samsung */
> +enum samsung_pcie_variants {
> +	FSD,
> +	EXYNOS_5433,
> +};

>  struct samsung_pcie_pdata {
>  	struct pci_ops				*pci_ops;
>  	const struct dw_pcie_ops		*dwc_ops;
>  	const struct dw_pcie_host_ops		*host_ops;
> +	const struct dw_pcie_ep_ops		*ep_ops;
>  	const struct samsung_res_ops		*res_ops;
> +	unsigned int				soc_variant;
> +	enum dw_pcie_device_mode		device_mode;
>  };

> +static u32 fsd_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base,
> +				u32 reg, size_t size)
> +{
> +	void __iomem *addr;
> +	u32 val;
> +
> +	addr = fsd_atu_setting(pci, base);
> +
> +	dw_pcie_read(addr + reg, size, &val);
> +
> +	return val;

Remove blank lines to match style of fsd_pcie_write_dbi2().

> +}
> +
> +static void fsd_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base,
> +				u32 reg, size_t size, u32 val)
> +{
> +	void __iomem *addr;
> +
> +	addr = fsd_atu_setting(pci, base);
> +
> +	dw_pcie_write(addr + reg, size, val);

Ditto.

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

> +static int fsd_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> +				 unsigned int type, u16 interrupt_num)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +
> +	switch (type) {
> +	case PCI_IRQ_INTX:
> +		return dw_pcie_ep_raise_intx_irq(ep, func_no);
> +	case PCI_IRQ_MSIX:
> +		dev_err(pci->dev, "EP does not support MSIX\n");

s/MSIX/MSI-X/ to match spec usage.

> @@ -373,13 +617,43 @@ static int exynos_pcie_probe(struct platform_device *pdev)
>  		return ret;
>  
>  	platform_set_drvdata(pdev, ep);
> -	ret = samsung_irq_init(ep, pdev);
> -	if (ret)
> -		goto fail_regulator;
> -	ep->pci.pp.ops = pdata->host_ops;
> -	ret = dw_pcie_host_init(&ep->pci.pp);
> -	if (ret < 0)
> +
> +	if (pdata->res_ops->set_device_mode)
> +		pdata->res_ops->set_device_mode(ep);
> +
> +	switch (ep->pdata->device_mode) {
> +	case DW_PCIE_RC_TYPE:
> +		ret = samsung_irq_init(ep, pdev);
> +		if (ret)
> +			goto fail_regulator;
> +
> +		ep->pci.pp.ops = pdata->host_ops;
> +
> +		ret = dw_pcie_host_init(&ep->pci.pp);
> +		if (ret < 0)
> +			goto fail_phy_init;
> +
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
> +		break;
> +	default:
> +		dev_err(dev, "invalid device type\n");
>  		goto fail_phy_init;
> +	}

This would be a little nicer if you added soc_variant and device_mode
and the code that sets and tests them for exynos_5433 first in a
separate patch.  Then it would be more obvious that the new FSD parts
don't affect exynos_5433 since this patch would only be *adding*
FSD-specific things.

>  static const struct samsung_pcie_pdata exynos_5433_pcie_rc_pdata = {
>  	.dwc_ops		= &exynos_dw_pcie_ops,
>  	.pci_ops		= &exynos_pci_ops,
>  	.host_ops		= &exynos_pcie_host_ops,
>  	.res_ops		= &exynos_res_ops_data,
> +	.soc_variant		= EXYNOS_5433,
> +	.device_mode		= DW_PCIE_RC_TYPE,
>  };

>  static const struct of_device_id exynos_pcie_of_match[] = {
> @@ -449,6 +756,14 @@ static const struct of_device_id exynos_pcie_of_match[] = {
>  		.compatible = "samsung,exynos5433-pcie",
>  		.data = (void *) &exynos_5433_pcie_rc_pdata,
>  	},


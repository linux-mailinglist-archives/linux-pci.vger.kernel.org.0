Return-Path: <linux-pci+bounces-30524-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C50F0AE6BF2
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 18:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82FED3AB2DB
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 16:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E465F2E11D9;
	Tue, 24 Jun 2025 16:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gm6qAgWt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B608028468E;
	Tue, 24 Jun 2025 16:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750780851; cv=none; b=lLSHtB7BLglX06gBi0r5BnLL5M3dBwwcyJD1FEHr48UN+n26+U2v0xr777crhzBaM5XuIASGRIKA3IoUqJ5fzmpfq34PeZG5HWF+1B11PYNLWUzM3Brkw4cKstd4rpLCf/bAO80DgZY7k09L5nUXlpnQwgRI6VdqBYTbynuhgiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750780851; c=relaxed/simple;
	bh=Z8jA80S3zwy20ZT2jiHgqV2tMjx8AnSmArLZvzv3nvs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jIvYCFPEEdXDwsrhgaTnl7RgP3iysLqlNEyoikFRgyuXqrMbSvf/QbYPj5rnOPcsC/boy8jndYBVXPQZeb9z+Sxnre1OmlWMYfeuYtrnaiNpjDhEuqxV+D6+ZMHHPbmO9se/mdMzT1tjFghuHiHMDO0ksJTl/BkHjvglHiyJee4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gm6qAgWt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B0BC4CEE3;
	Tue, 24 Jun 2025 16:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750780851;
	bh=Z8jA80S3zwy20ZT2jiHgqV2tMjx8AnSmArLZvzv3nvs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Gm6qAgWtekRL84jy+ZUefdYbAADtOsCjYh2ciwsENfw341fbejMX2TDi5cfNJl/CD
	 ICKJmnx6l8JyjRFSWtI9POmr1Wm/AGdsz5Pr5U+v+/bK9eET9si6UvGoZbdGTiNcGY
	 rMoSvtffoFcRWzS64WjZ2ACXC71itT8eYiRturXjhUmTbK5UBlDG6Yk5SYMQtDu7wK
	 /4+dmb4TGispkcEalM5ACbAvfgThuAmVvW9FraoHlJYLc+tLuyYWmCgk91ZGtz9eE1
	 /WrqqzHy4yc3dXWkx9kNLUgf9DuIbrBFdc4HvBTGck6TEmgsYfUD70HvIsr3MjFq5b
	 boGBcYNJoyPTA==
Date: Tue, 24 Jun 2025 11:00:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sai Krishna Musham <sai.krishna.musham@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, cassel@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com, bharat.kumar.gogada@amd.com,
	thippeswamy.havalige@amd.com
Subject: Re: [PATCH v3 2/2] PCI: amd-mdb: Add support for PCIe RP PERST#
 signal handling
Message-ID: <20250624160049.GA1479461@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618080931.2472366-3-sai.krishna.musham@amd.com>

On Wed, Jun 18, 2025 at 01:39:31PM +0530, Sai Krishna Musham wrote:
> Add GPIO based PERST# signal handling for AMD Versal Gen 2 MDB
> PCIe Root Port.
> 
> Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
> ---
> Changes in v3:
> - Implement amd_mdb_parse_pcie_port to parse bridge node for reset-gpios property.
> 
> Changes in v2:
> - Change delay to PCIE_T_PVPERL_MS

v3 https://lore.kernel.org/r/20250618080931.2472366-1-sai.krishna.musham@amd.com/
v2 https://lore.kernel.org/r/20250429090046.1512000-1-sai.krishna.musham@amd.com/
v1 https://lore.kernel.org/r/20250326041507.98232-1-sai.krishna.musham@amd.com/

> ---
>  drivers/pci/controller/dwc/pcie-amd-mdb.c | 45 ++++++++++++++++++++++-
>  1 file changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-amd-mdb.c b/drivers/pci/controller/dwc/pcie-amd-mdb.c
> index 4eb2a4e8189d..b4c5b71900a5 100644
> --- a/drivers/pci/controller/dwc/pcie-amd-mdb.c
> +++ b/drivers/pci/controller/dwc/pcie-amd-mdb.c
> @@ -18,6 +18,7 @@
>  #include <linux/resource.h>
>  #include <linux/types.h>
>  
> +#include "../../pci.h"
>  #include "pcie-designware.h"
>  
>  #define AMD_MDB_TLP_IR_STATUS_MISC		0x4C0
> @@ -63,6 +64,7 @@ struct amd_mdb_pcie {
>  	void __iomem			*slcr;
>  	struct irq_domain		*intx_domain;
>  	struct irq_domain		*mdb_domain;
> +	struct gpio_desc		*perst_gpio;
>  	int				intx_irq;
>  };
>  
> @@ -284,7 +286,7 @@ static int amd_mdb_pcie_init_irq_domains(struct amd_mdb_pcie *pcie,
>  	struct device_node *pcie_intc_node;
>  	int err;
>  
> -	pcie_intc_node = of_get_next_child(node, NULL);
> +	pcie_intc_node = of_get_child_by_name(node, "interrupt-controller");

Is this change logically part of the PERST# support?  If not, this
could be a separate patch.

>  	if (!pcie_intc_node) {
>  		dev_err(dev, "No PCIe Intc node found\n");
>  		return -ENODEV;
> @@ -402,6 +404,34 @@ static int amd_mdb_setup_irq(struct amd_mdb_pcie *pcie,
>  	return 0;
>  }
>  
> +static int amd_mdb_parse_pcie_port(struct amd_mdb_pcie *pcie)
> +{
> +	struct device *dev = pcie->pci.dev;
> +	struct device_node *pcie_port_node;
> +
> +	pcie_port_node = of_get_next_child_with_prefix(dev->of_node, NULL, "pcie");
> +	if (!pcie_port_node) {
> +		dev_err(dev, "No PCIe Bridge node found\n");
> +		return -ENODEV;
> +	}
> +
> +	/* Request the GPIO for PCIe reset signal and assert */
> +	pcie->perst_gpio = devm_fwnode_gpiod_get(dev, of_fwnode_handle(pcie_port_node),
> +						 "reset", GPIOD_OUT_HIGH, NULL);
> +	if (IS_ERR(pcie->perst_gpio)) {
> +		if (PTR_ERR(pcie->perst_gpio) != -ENOENT) {
> +			of_node_put(pcie_port_node);
> +			return dev_err_probe(dev, PTR_ERR(pcie->perst_gpio),
> +					     "Failed to request reset GPIO\n");
> +		}
> +		pcie->perst_gpio = NULL;
> +	}
> +
> +	of_node_put(pcie_port_node);
> +
> +	return 0;
> +}
> +
>  static int amd_mdb_add_pcie_port(struct amd_mdb_pcie *pcie,
>  				 struct platform_device *pdev)
>  {
> @@ -426,6 +456,14 @@ static int amd_mdb_add_pcie_port(struct amd_mdb_pcie *pcie,
>  
>  	pp->ops = &amd_mdb_pcie_host_ops;
>  
> +	if (pcie->perst_gpio) {
> +		mdelay(PCIE_T_PVPERL_MS);
> +
> +		/* Deassert the reset signal */
> +		gpiod_set_value_cansleep(pcie->perst_gpio, 0);
> +		mdelay(PCIE_T_RRS_READY_MS);
> +	}
> +
>  	err = dw_pcie_host_init(pp);
>  	if (err) {
>  		dev_err(dev, "Failed to initialize host, err=%d\n", err);
> @@ -444,6 +482,7 @@ static int amd_mdb_pcie_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct amd_mdb_pcie *pcie;
>  	struct dw_pcie *pci;
> +	int ret;
>  
>  	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
>  	if (!pcie)
> @@ -454,6 +493,10 @@ static int amd_mdb_pcie_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, pcie);
>  
> +	ret = amd_mdb_parse_pcie_port(pcie);
> +	if (ret)
> +		return ret;
> +
>  	return amd_mdb_add_pcie_port(pcie, pdev);
>  }
>  
> -- 
> 2.43.0
> 


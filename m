Return-Path: <linux-pci+bounces-31732-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11316AFDBCF
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 01:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79E487AFDDC
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 23:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3FD22FDEC;
	Tue,  8 Jul 2025 23:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUIHkohF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A37C1E2614;
	Tue,  8 Jul 2025 23:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752017010; cv=none; b=EVId2NlEiCqU1em8rGitHSJRV3mdjmxj0OwjgSNgIhFmLiFfQtYiriyXQIVl3w8r8EX1suZc5z7tORGQdeUY+VqzeJo4i3p36Q/7Gy1i0PP2BgNln3P6DA4ZxxNK5pSIHVE5HLA+Ug3Iz8Ckg3Zcy5W7Rr4+6J+T7xozHaaGPLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752017010; c=relaxed/simple;
	bh=w4ZimzqNZhwh10Nd+06BzC1zOzN4/9VkqJ3RnYLKHvY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=McKxbq+/Z7K1vwvJ9S4QJGA/9igRua6+yicjMWUe7LWMPxy0ztsq4ZeMaX8Uxq6/iklb6BEF1RS6GxxXPiBGIcnlRhB4X3dm3M6SqmCLFTXMB7cGCWE/00dxkm/e2FE7l6Tk2qFmSO6FS5+7WAzUqDvggBKtAn5DqecMaXa4ELM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUIHkohF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 636D2C4CEED;
	Tue,  8 Jul 2025 23:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752017009;
	bh=w4ZimzqNZhwh10Nd+06BzC1zOzN4/9VkqJ3RnYLKHvY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=mUIHkohF61FUiIxcxKSxPbqqXGgBJu97d6FWMxWc0KnDUe8HOp0gIKMulN99B7kDc
	 Cich3FKk4F9EGzXNxrqGsRrV6InbZnv1hGdYyyr026MNG+iYXA+1JIPjgHL2LpbRxR
	 xgMcocD6w/wCU2qyiyRGisiq5bJ8wDTomGDU6XLw/CwzXQjO+8aKnc55WfG4MoOdaP
	 1JKvEYdCFD5wACPC6WsOBGTPE9LnwxCJvCkZDsL80HxjXQvIGHzJqPubb0z0Jao1IM
	 2pqt91E/xa/UuMUi8MoYTL9HpSiQ3xTpPMT/ViTC82x9/Sk6Ga2YihAM+HDwWfkq+2
	 3P28BJsMz6PPA==
Date: Tue, 8 Jul 2025 18:23:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sai Krishna Musham <sai.krishna.musham@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, cassel@kernel.org, lkp@intel.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, michal.simek@amd.com,
	bharat.kumar.gogada@amd.com, thippeswamy.havalige@amd.com
Subject: Re: [PATCH v4 2/2] PCI: amd-mdb: Add support for PCIe RP PERST#
 signal handling
Message-ID: <20250708232327.GA2169793@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626054906.3277029-3-sai.krishna.musham@amd.com>

On Thu, Jun 26, 2025 at 11:19:06AM +0530, Sai Krishna Musham wrote:
> Add support for handling the AMD Versal Gen 2 MDB PCIe Root Port PERST#
> signal via a GPIO by parsing the new PCIe bridge node to acquire the
> reset GPIO.
> 
> As part of this, update the interrupt controller node parsing to use
> of_get_child_by_name() instead of of_get_next_child(), since the PCIe
> node now has multiple children. This ensures the correct node is
> selected during initialization.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202506241020.rPD1a2Vr-lkp@intel.com/

Omit these tags.  This kernel test robot report is basically a code
review comment that doesn't need to be acknowledged here (the robot's
report says:

  If you fix the issue in a separate patch/commit (i.e. not just a new
  version of the same patch/commit), kindly add following tags ...

IIUC this is just a new version of the same patch, so doesn't need the
tags.

> Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
> ---
> Changes in v4:
> - Resolve kernel test robot warning.
> https://lore.kernel.org/oe-kbuild-all/202506241020.rPD1a2Vr-lkp@intel.com/
> - Update commit message.
> 
> Changes in v3:
> - Implement amd_mdb_parse_pcie_port to parse bridge node for reset-gpios property.
> 
> Changes in v2:
> - Change delay to PCIE_T_PVPERL_MS
> 
> v3 https://lore.kernel.org/r/20250618080931.2472366-1-sai.krishna.musham@amd.com/
> v2 https://lore.kernel.org/r/20250429090046.1512000-1-sai.krishna.musham@amd.com/
> v1 https://lore.kernel.org/r/20250326041507.98232-1-sai.krishna.musham@amd.com/
> ---
>  drivers/pci/controller/dwc/pcie-amd-mdb.c | 46 ++++++++++++++++++++++-
>  1 file changed, 45 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-amd-mdb.c b/drivers/pci/controller/dwc/pcie-amd-mdb.c
> index 9f7251a16d32..f011a83550b9 100644
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
> @@ -56,6 +57,7 @@
>   * @slcr: MDB System Level Control and Status Register (SLCR) base
>   * @intx_domain: INTx IRQ domain pointer
>   * @mdb_domain: MDB IRQ domain pointer
> + * @perst_gpio: GPIO descriptor for PERST# signal handling
>   * @intx_irq: INTx IRQ interrupt number
>   */
>  struct amd_mdb_pcie {
> @@ -63,6 +65,7 @@ struct amd_mdb_pcie {
>  	void __iomem			*slcr;
>  	struct irq_domain		*intx_domain;
>  	struct irq_domain		*mdb_domain;
> +	struct gpio_desc		*perst_gpio;
>  	int				intx_irq;
>  };
>  
> @@ -284,7 +287,7 @@ static int amd_mdb_pcie_init_irq_domains(struct amd_mdb_pcie *pcie,
>  	struct device_node *pcie_intc_node;
>  	int err;
>  
> -	pcie_intc_node = of_get_next_child(node, NULL);
> +	pcie_intc_node = of_get_child_by_name(node, "interrupt-controller");
>  	if (!pcie_intc_node) {
>  		dev_err(dev, "No PCIe Intc node found\n");
>  		return -ENODEV;
> @@ -402,6 +405,34 @@ static int amd_mdb_setup_irq(struct amd_mdb_pcie *pcie,
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
> @@ -426,6 +457,14 @@ static int amd_mdb_add_pcie_port(struct amd_mdb_pcie *pcie,
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
> @@ -444,6 +483,7 @@ static int amd_mdb_pcie_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct amd_mdb_pcie *pcie;
>  	struct dw_pcie *pci;
> +	int ret;
>  
>  	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
>  	if (!pcie)
> @@ -454,6 +494,10 @@ static int amd_mdb_pcie_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, pcie);
>  
> +	ret = amd_mdb_parse_pcie_port(pcie);
> +	if (ret)
> +		return ret;

I'm not a DT expert, but doesn't this break if you run
amd_mdb_parse_pcie_port() on a system with an existing DT that lacks
the pcie@0,0 stanza you added to the binding in patch [1/2]?

I.e., amd_mdb_parse_pcie_port() will return -ENODEV in that case, and
the probe will now fail?

It's good to add new functionality, but if the driver runs with a DT
that doesn't describe the new functionality, it should fall back to
the previous behavior (without the new functionality) instead of
failing completely.

>  	return amd_mdb_add_pcie_port(pcie, pdev);
>  }
>  
> -- 
> 2.44.1
> 


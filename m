Return-Path: <linux-pci+bounces-31973-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB37B02792
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jul 2025 01:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DADA1CA625F
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 23:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAB522257E;
	Fri, 11 Jul 2025 23:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWM+ug5T"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC22221FA0;
	Fri, 11 Jul 2025 23:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752275912; cv=none; b=Uqj6X1YvyArd59uok0sEytmet+Ug5IrNcn7LT+5FvolLM1ArLRXW6aNd0wgzqLNqX9Lh2LaysTlH1DU+WyAyxPSj7Y5HIF0INu1dWwnmppG80feLU5jkqucpsKliBmwbqNqublJgulTESFBgmTh31NJEWG3jGQCcPiO85WDoAuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752275912; c=relaxed/simple;
	bh=ITlyJPhXduNCEmMJVfEegU2LqFMs89I4bv7JmVMvknI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MlgfBoKJX8Z4tomHjdXywRjW3RMu0Ki3NvuQAZA6zKTb8mO7J95ixShjU5MdvMfi+wbYRtmDuFjhZI7rsvHqRHZJx+r0ju316N//sUYQMw+lwNzXf3wtw3XojLJXmz0XVGnN20iRY9zqbgUE4a6aNhIi4VauazFe/+Ncld4V0oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWM+ug5T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C7EDC4CEED;
	Fri, 11 Jul 2025 23:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752275911;
	bh=ITlyJPhXduNCEmMJVfEegU2LqFMs89I4bv7JmVMvknI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=YWM+ug5TWwreWSYWTO/dfBD5r9DyA6wc1aGXEQm1hVIqdVC3pg+SEmt3lDMKiLp6Q
	 zD8zEEvLioEyhDvsyQVKDMLaSRWNmzm6fxOi4kQqtP2MvG0UwH5J+v5rjRBs4cIWJy
	 DFmYQtLD16SqtwKxmTWfMojJT9uiUFaMwHbQNdEE6mlZOffvbO8hD6vwfJ4eISPg25
	 jeIa1Oj6uTLgYkZPtdQLUh5KVRrvrRjjtCSHZDGfcOVTKYa6VgHxPXmNcOfsHdnlP5
	 GMQMq+o7EdIDbgQNQnktFaj2JIowOH2tApznCFHBnCCTu0NlosrC2MrtCe5ig1HWXd
	 hNSpHpojx9SCw==
Date: Fri, 11 Jul 2025 18:18:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sai Krishna Musham <sai.krishna.musham@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, cassel@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com, bharat.kumar.gogada@amd.com,
	thippeswamy.havalige@amd.com
Subject: Re: [PATCH v5 2/2] PCI: amd-mdb: Add support for PCIe RP PERST#
 signal handling
Message-ID: <20250711231830.GA2313060@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711052357.3859719-3-sai.krishna.musham@amd.com>

On Fri, Jul 11, 2025 at 10:53:57AM +0530, Sai Krishna Musham wrote:
> Add support for handling the AMD Versal Gen 2 MDB PCIe Root Port PERST#
> signal via a GPIO by parsing the new PCIe bridge node to acquire the
> reset GPIO. If the bridge node is not found, fall back to acquiring it
> from the PCIe node.
> 
> As part of this, update the interrupt controller node parsing to use
> of_get_child_by_name() instead of of_get_next_child(), since the PCIe
> node now has multiple children. This ensures the correct node is
> selected during initialization.
> 
> Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
> ---
> Changes in v5:
> - Add fall back mechanism to acquire reset GPIO from PCIe node when PCIe Bridge
> node is not present.
> 
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
> v4 https://lore.kernel.org/all/20250626054906.3277029-1-sai.krishna.musham@amd.com/
> v3 https://lore.kernel.org/r/20250618080931.2472366-1-sai.krishna.musham@amd.com/
> v2 https://lore.kernel.org/r/20250429090046.1512000-1-sai.krishna.musham@amd.com/
> v1 https://lore.kernel.org/r/20250326041507.98232-1-sai.krishna.musham@amd.com/
> ---
>  drivers/pci/controller/dwc/pcie-amd-mdb.c | 63 ++++++++++++++++++++++-
>  1 file changed, 62 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-amd-mdb.c b/drivers/pci/controller/dwc/pcie-amd-mdb.c
> index 9f7251a16d32..d633463dc9fe 100644
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
> @@ -454,6 +494,27 @@ static int amd_mdb_pcie_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, pcie);
>  
> +	ret = amd_mdb_parse_pcie_port(pcie);
> +
> +	/*
> +	 * If amd_mdb_parse_pcie_port returns -ENODEV, it indicates that the
> +	 * PCIe Bridge node was not found in the device tree. This is not
> +	 * considered a fatal error and will trigger a fallback where the
> +	 * reset GPIO is acquired directly from the PCIe node.
> +	 */
> +	if (ret && ret != -ENODEV) {
> +		return ret;
> +	} else if (ret == -ENODEV) {

The "ret" checking seems unnecessarily complicated.

> +		dev_info(dev, "Falling back to acquire reset GPIO from PCIe node\n");

I don't think this is worthy of a message.  If there are DTs in the
field that were valid once, they continue to be valid forever, and
there's no point in complaining about them.

https://lore.kernel.org/all/20250702-perst-v5-2-920b3d1f6ee1@qti.qualcomm.com/
has a good example of how to this fallback nicely.

Otherwise looks good to me.

> +
> +		/* Request the GPIO for PCIe reset signal and assert */
> +		pcie->perst_gpio = devm_gpiod_get_optional(dev, "reset",
> +							   GPIOD_OUT_HIGH);
> +		if (IS_ERR(pcie->perst_gpio))
> +			return dev_err_probe(dev, PTR_ERR(pcie->perst_gpio),
> +					     "Failed to request reset GPIO\n");
> +	}
> +
>  	return amd_mdb_add_pcie_port(pcie, pdev);
>  }
>  
> -- 
> 2.44.1
> 


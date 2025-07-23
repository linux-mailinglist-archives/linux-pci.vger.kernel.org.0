Return-Path: <linux-pci+bounces-32816-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA45CB0F523
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 16:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 656981CC1A84
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 14:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8D22E8DEE;
	Wed, 23 Jul 2025 14:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGZTlqQ3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59E62E5415;
	Wed, 23 Jul 2025 14:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753280578; cv=none; b=p+TtoA8H1MjecYTtquS1tvrdUI23W1lETZt5UvlcDTyfKAyJUd+2kO8IEXIvVFSHf1OA75nZd5ogxbcSynrz4VEBxAyUOQLInKs8EvBC0NNuOcQCRYNC4UEePldbc7a6aybcpj+EiSJnRoFEZqEkzLzsq9vSNlSuS5jLwDh8vss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753280578; c=relaxed/simple;
	bh=cYT83ItX8i0zQEyyAAKccpe8aP2G3UA6P+4s88looH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rUP0RLOjxOOe9bZL4s3pY53FGS4ZDSz4GnEDaJt3qgows6XlE695ANeYuYEe5BB05ar1bEDSIC4GqK7g6fjHFyB57PX4qupSCO6Y7+4DOejkNlDoJ5AorkvxqF0Gm9h5iKq8ighf9zb4v3U0+ZbVDkeCYshxEDuU3dQOxU6rKJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGZTlqQ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 804C5C4CEE7;
	Wed, 23 Jul 2025 14:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753280578;
	bh=cYT83ItX8i0zQEyyAAKccpe8aP2G3UA6P+4s88looH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CGZTlqQ3fprVmpxMhYFaeGXDOwnsK2fIrIFXA5QycJ6N8mbZA44NkQk5NX4qhz9NI
	 rz6x8cvMJ7dBBGTfDcyxWcT+xW7t63EJ444vmoPkhnigjSp/AT+U3u+RtV3hF2AQVV
	 1yS21MLJ3c0vvChOSKKnWwXEquTznIn25vFDn6aADSUaEGmYY//1EK95N/elrP9enh
	 2gekE1WJmRgt79l7UmSN3QPGMoY20+xefpx0MtXp/pgTcgNtPsW/HMAHUJ/ogah5C+
	 tQsOeblnTDo13uAuge1mhZc1OHpwTQwKLFTiA8yhRoaVA6ra3UcdMEpAM6DI/hYHAD
	 kLyqci7puio1Q==
Date: Wed, 23 Jul 2025 19:52:48 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Sai Krishna Musham <sai.krishna.musham@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, cassel@kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	michal.simek@amd.com, bharat.kumar.gogada@amd.com, thippeswamy.havalige@amd.com
Subject: Re: [PATCH v6 2/2] PCI: amd-mdb: Add support for PCIe RP PERST#
 signal handling
Message-ID: <bozkhw7eebaxj7odsilphvlbfzfo7xmdfteng5dq5mtznroefi@trlegpl6fkcf>
References: <20250719030951.3616385-1-sai.krishna.musham@amd.com>
 <20250719030951.3616385-3-sai.krishna.musham@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250719030951.3616385-3-sai.krishna.musham@amd.com>

On Sat, Jul 19, 2025 at 08:39:51AM GMT, Sai Krishna Musham wrote:
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
> Changes in v6:
> - Simplified error checking condition logic.
> - Removed unnecessary fallback message.
> 
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
> v5 https://lore.kernel.org/all/20250711052357.3859719-1-sai.krishna.musham@amd.com/
> v4 https://lore.kernel.org/all/20250626054906.3277029-1-sai.krishna.musham@amd.com/
> v3 https://lore.kernel.org/r/20250618080931.2472366-1-sai.krishna.musham@amd.com/
> v2 https://lore.kernel.org/r/20250429090046.1512000-1-sai.krishna.musham@amd.com/
> v1 https://lore.kernel.org/r/20250326041507.98232-1-sai.krishna.musham@amd.com/
> ---
>  drivers/pci/controller/dwc/pcie-amd-mdb.c | 62 ++++++++++++++++++++++-
>  1 file changed, 61 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-amd-mdb.c b/drivers/pci/controller/dwc/pcie-amd-mdb.c
> index 9f7251a16d32..697f5b3fc75e 100644
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

Please use for_each_child_of_node_with_prefix() and get rid of the above check.
Since this is a scoped variant, you do not need to care about OF node refcount.

If your platform supports only one Root Port, you can add a comment on top that
the loop will execute only once. Maybe you can also add a TODO so that someone
could prepare the driver to handle multi Root Ports in the future.

> +	/* Request the GPIO for PCIe reset signal and assert */

Drop the comment.

> +	pcie->perst_gpio = devm_fwnode_gpiod_get(dev, of_fwnode_handle(pcie_port_node),
> +						 "reset", GPIOD_OUT_HIGH, NULL);
> +	if (IS_ERR(pcie->perst_gpio)) {
> +		if (PTR_ERR(pcie->perst_gpio) != -ENOENT) {
> +			of_node_put(pcie_port_node);
> +			return dev_err_probe(dev, PTR_ERR(pcie->perst_gpio),
> +					     "Failed to request reset GPIO\n");
> +		}
> +		pcie->perst_gpio = NULL;

Not required.

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
> @@ -454,6 +494,26 @@ static int amd_mdb_pcie_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, pcie);
>  
> +	ret = amd_mdb_parse_pcie_port(pcie);
> +

Spurious newline

> +	/*
> +	 * If amd_mdb_parse_pcie_port returns -ENODEV, it indicates that the
> +	 * PCIe Bridge node was not found in the device tree. This is not
> +	 * considered a fatal error and will trigger a fallback where the
> +	 * reset GPIO is acquired directly from the PCIe node.

s/PCIe node/PCIe Host Bridge node

> +	 */
> +	if (ret == -ENODEV) {

Please use the below pattern:

	if (ret) {
		if (ret != -ENODEV) {
			dev_err();
			return ret;
		}

		pcie->perst_gpio = devm_gpiod_get_optional()...
	}

> +

Spurious newline

> +		/* Request the GPIO for PCIe reset signal and assert */

Drop the comment

- Mani

-- 
மணிவண்ணன் சதாசிவம்


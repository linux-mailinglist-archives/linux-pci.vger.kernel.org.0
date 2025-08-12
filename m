Return-Path: <linux-pci+bounces-33885-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 452B6B23930
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 21:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ECFB18880AB
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 19:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AF52FFDCA;
	Tue, 12 Aug 2025 19:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGDZnbnf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C3C2475F7;
	Tue, 12 Aug 2025 19:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755027677; cv=none; b=XTJoelFt53LrcX5VSMX7gxzncFL1FyOwyUjIelauubPmsLmT9R6aYvKsc1+KgaqF0RZGzRf/kg+RvmaLZNtMLx19qJ5/jXQXfK6L8MdTb1PJC9edWqh7MtWpj/ZtrnaavqCW7geGaGT1o99qF9cTCIRCiDeFGjk4tOdYgxaUGKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755027677; c=relaxed/simple;
	bh=4I2v3tVVquqTK2UwFUheQXcfJusyM0LQva933gT7z0s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=es7XHOXKa3Q++f6KRC4cJlxpJobgm2anGFX3PGSg+bB9uiz9CJ05NQagLMXFd6Sg8k8j5trXi1QBcsSn1Z5qWMjZcsFCR4o84c5Z6wZrXy0fHBNVhWbPj9EK00qMvRsKnZdNwS+DQyEzXxaaqBUwEDIUkyday2pmfvF5Uz1YFvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGDZnbnf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6FE6C4CEF0;
	Tue, 12 Aug 2025 19:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755027675;
	bh=4I2v3tVVquqTK2UwFUheQXcfJusyM0LQva933gT7z0s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=EGDZnbnfhdJw23Zu3MiLfuxaymyIK9T1vM4lWJ9i0WBGqpJgIFrsE9Ak20gGtmURO
	 pYt5xF9eQF1/JGgoqwmw7T8k0gQLDkj5RwIHP5kF4QUFbY4GDkJW8bh06DG1JxTn2w
	 jFyVt/fv+UIM25dtJBFgMsQy77CKE9ogiYPSchdUfFEQkz4QxwrJ4wZ9k/l5xx4CCp
	 zQJf5OPkgrMVBHu0MZ8J958yBO9gPPQwgI3H80AfVxS1BdOzxiXQbS17ssQXURRvv/
	 2D9m0UV76y0CxizbX22OLnqhCGWiAz8scb3k5E7vpYGUW52qpMbgXEFWu6BNzoXd95
	 NhoDlXZYZ8zGg==
Date: Tue, 12 Aug 2025 14:41:13 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sai Krishna Musham <sai.krishna.musham@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, cassel@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com, bharat.kumar.gogada@amd.com,
	thippeswamy.havalige@amd.com
Subject: Re: [PATCH v7 2/2] PCI: amd-mdb: Add support for PCIe RP PERST#
 signal handling
Message-ID: <20250812194113.GA199940@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807074019.811672-3-sai.krishna.musham@amd.com>

On Thu, Aug 07, 2025 at 01:10:19PM +0530, Sai Krishna Musham wrote:
> Add support for handling the AMD Versal Gen 2 MDB PCIe Root Port PERST#
> signal via a GPIO by parsing the new PCIe bridge node to acquire the
> reset GPIO. If the bridge node is not found, fall back to acquiring it
> from the PCIe host bridge node.
> 
> As part of this, update the interrupt controller node parsing to use
> of_get_child_by_name() instead of of_get_next_child(), since the PCIe
> host bridge node now has multiple children. This ensures the correct
> node is selected during initialization.
> 
> Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
> ---
> Changes in v7:
> - Use for_each_child_of_node_with_prefix() to iterate through PCIe
>   Bridge nodes.
> 
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
> v6 https://lore.kernel.org/all/20250719030951.3616385-1-sai.krishna.musham@amd.com/
> v5 https://lore.kernel.org/all/20250711052357.3859719-1-sai.krishna.musham@amd.com/
> v4 https://lore.kernel.org/all/20250626054906.3277029-1-sai.krishna.musham@amd.com/
> v3 https://lore.kernel.org/r/20250618080931.2472366-1-sai.krishna.musham@amd.com/
> v2 https://lore.kernel.org/r/20250429090046.1512000-1-sai.krishna.musham@amd.com/
> v1 https://lore.kernel.org/r/20250326041507.98232-1-sai.krishna.musham@amd.com/
> ---
>  drivers/pci/controller/dwc/pcie-amd-mdb.c | 52 ++++++++++++++++++++++-
>  1 file changed, 51 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-amd-mdb.c b/drivers/pci/controller/dwc/pcie-amd-mdb.c
> index 9f7251a16d32..3c6e837465bb 100644
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
> @@ -402,6 +405,28 @@ static int amd_mdb_setup_irq(struct amd_mdb_pcie *pcie,
>  	return 0;
>  }
>  
> +static int amd_mdb_parse_pcie_port(struct amd_mdb_pcie *pcie)
> +{
> +	struct device *dev = pcie->pci.dev;
> +	struct device_node *pcie_port_node __maybe_unused;
> +
> +	/*
> +	 * This platform currently supports only one Root Port, so the loop
> +	 * will execute only once.
> +	 * TODO: Enhance the driver to handle multiple Root Ports in the future.
> +	 */
> +	for_each_child_of_node_with_prefix(dev->of_node, pcie_port_node, "pcie") {

This is only the second user of for_each_child_of_node_with_prefix()
in the whole tree.  Also the only use of "__maybe_unused" in
drivers/pci/controller/.

Most of the PCI controller drivers use
for_each_available_child_of_node_scoped(); can we do the same here?

The apple, kirin, mt7621, mtk, and qcom drivers are examples.  I think
the qcom structure is pretty good, and it has a similar fallback path
for DTs without Root Port nodes (qcom_pcie_parse_legacy_binding()):

  qcom_pcie_probe
    ret = qcom_pcie_parse_ports
      for_each_available_child_of_node_scoped(dev->of_node, of_port)
        qcom_pcie_parse_port(of_port)
          reset = devm_fwnode_gpiod_get(..., "reset", ...)
    if (ret)
      qcom_pcie_parse_legacy_binding

IIUC the current amd-mdb hardware only supports a single Root Port, so
I don't think you need a TODO, since there's no point in that
enhancement until hardware supports multiple RPs.

But I probably *would* add a check here so that if we run the current
driver on future hardware that does have multiple Root Ports with
separate resets for each RP, there's at least a chance that the first
RP will work.  E.g.,

  amd_mdb_parse_pcie_port(...)
  {
    if (pcie->perst_gpio) {
      dev_warn("Ignoring extra Root Port\n");
      return 0;
    }

    pcie->perst_gpio = devm_fwnode_gpiod_get(...);

> +		pcie->perst_gpio = devm_fwnode_gpiod_get(dev, of_fwnode_handle(pcie_port_node),
> +							 "reset", GPIOD_OUT_HIGH, NULL);
> +		if (IS_ERR(pcie->perst_gpio))
> +			return dev_err_probe(dev, PTR_ERR(pcie->perst_gpio),
> +					     "Failed to request reset GPIO\n");
> +		return 0;
> +	}
> +
> +	return -ENODEV;
> +}
> +
>  static int amd_mdb_add_pcie_port(struct amd_mdb_pcie *pcie,
>  				 struct platform_device *pdev)
>  {
> @@ -426,6 +451,12 @@ static int amd_mdb_add_pcie_port(struct amd_mdb_pcie *pcie,
>  
>  	pp->ops = &amd_mdb_pcie_host_ops;
>  
> +	if (pcie->perst_gpio) {
> +		mdelay(PCIE_T_PVPERL_MS);
> +		gpiod_set_value_cansleep(pcie->perst_gpio, 0);
> +		mdelay(PCIE_RESET_CONFIG_WAIT_MS);
> +	}
> +
>  	err = dw_pcie_host_init(pp);
>  	if (err) {
>  		dev_err(dev, "Failed to initialize host, err=%d\n", err);
> @@ -444,6 +475,7 @@ static int amd_mdb_pcie_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct amd_mdb_pcie *pcie;
>  	struct dw_pcie *pci;
> +	int ret;
>  
>  	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
>  	if (!pcie)
> @@ -454,6 +486,24 @@ static int amd_mdb_pcie_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, pcie);
>  
> +	ret = amd_mdb_parse_pcie_port(pcie);
> +	/*
> +	 * If amd_mdb_parse_pcie_port returns -ENODEV, it indicates that the
> +	 * PCIe Bridge node was not found in the device tree. This is not
> +	 * considered a fatal error and will trigger a fallback where the
> +	 * reset GPIO is acquired directly from the PCIe Host Bridge node.
> +	 */
> +	if (ret) {
> +		if (ret != -ENODEV)
> +			return ret;
> +
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
> 2.43.0
> 


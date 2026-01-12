Return-Path: <linux-pci+bounces-44529-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA7FD1425E
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 17:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C909307C716
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 16:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9E536998E;
	Mon, 12 Jan 2026 16:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQemu9lb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F082EA15C;
	Mon, 12 Jan 2026 16:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768236210; cv=none; b=piWqC5+AOJhTv8vXoTAjOr6ckxT81mInOjrHG6GM3yIK7TaxY1XlutfR4ecW5JFf1DVbK7beu9UaoX3WYxm/p4DNUv5T/kVdOBPKSss+9PDA5UtYwK58OeDTGH4RMNjXzYzJjUCmb1qJxrFE+cCS4Inf97AT1RqL1IziIwISSes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768236210; c=relaxed/simple;
	bh=lFgctjtutGQXOiqTT6uzDo7xxjSfF86bzNybiJFqlFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TqERfB7Ihs2lPnYlrc843qZm2YPpErJJBQDKzd9t9rYn1GO+pS/js2W61G8oDdRLYGXZOS/5RtkaihupD40Y/6CmrGjA9b5Q3SzT0z1GKrEyNYTNpz0gN27DNVgNqFTZEi8LB9VRktjxNJvL9jC/06NPjsA/z7MxD9Br2pyGycM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQemu9lb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE18C116D0;
	Mon, 12 Jan 2026 16:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768236209;
	bh=lFgctjtutGQXOiqTT6uzDo7xxjSfF86bzNybiJFqlFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KQemu9lbPmlYlUdtCfab0b3qxZiqjkrWH1seRGrIAxCggA9PopzCct9Mh4DzyzYTx
	 OepzY7Vybccjz7N141sngTsDVA35C3gqQ5wObndsc7Qskcw0zYDbxoezbrEfodA86z
	 jmDo/5g3u7XxNhxgeh9FZ7x+GthsibsbLsw+CLJ+bJIN9izFhGzwfQpcywuu++wsnF
	 i6Elmuk5du1aosfR0RdykwcjBsKiUaG+lQQMhDQYmwfAmqVxHWfKnvhW4k41V18qQ3
	 u6qtf+z+VLd1ebCDg1TuxOBbYHIRDvgs47m8AEqbDwo/QU0KxGJDga6uPBbSWRhSyA
	 h2zFd7sNTP96w==
Date: Mon, 12 Jan 2026 22:13:16 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Rob Herring <robh@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Hans de Goede <hansg@kernel.org>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 03/14] software node: Implement device_get_match_data
 fwnode callback
Message-ID: <jo4flkszwuy6bxmjn55jtprtj567adlisaqfqgrqwbigfmvd4e@zp3kllj2y4fh>
References: <20260112-pci-m2-e-v4-0-eff84d2c6d26@oss.qualcomm.com>
 <20260112-pci-m2-e-v4-9-eff84d2c6d26@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260112-pci-m2-e-v4-9-eff84d2c6d26@oss.qualcomm.com>

On Mon, Jan 12, 2026 at 09:56:08PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> For supporting bluetooth over the non-discoverable UART interface of
> WCN7850, create the serdev device after enumerating the PCIe interface.
> This is mandatory since the device ID is only known after the PCIe
> enumeration and the ID is used for creating the serdev device.
> 
> Since by default there is no OF or ACPI node for the created serdev,
> create a dynamic OF 'bluetooth' node with the 'compatible' property and
> attach it to the serdev device. This will allow the serdev device to bind
> to the existing bluetooth driver.
> 

Missed "select OF_DYNAMIC" in Kconfig...

- Mani

> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  drivers/power/sequencing/pwrseq-pcie-m2.c | 170 +++++++++++++++++++++++++++++-
>  1 file changed, 169 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
> index 4b85a40d7692..5f9232e6c700 100644
> --- a/drivers/power/sequencing/pwrseq-pcie-m2.c
> +++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
> @@ -17,6 +17,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/pwrseq/provider.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/serdev.h>
>  #include <linux/slab.h>
>  
>  struct pwrseq_pcie_m2_pdata {
> @@ -32,6 +33,9 @@ struct pwrseq_pcie_m2_ctx {
>  	struct gpio_desc *w_disable1_gpio;
>  	struct gpio_desc *w_disable2_gpio;
>  	struct device *dev;
> +	struct serdev_device *serdev;
> +	struct notifier_block nb;
> +	struct of_changeset *ocs;
>  };
>  
>  static int pwrseq_pcie_m2_vregs_enable(struct pwrseq_device *pwrseq)
> @@ -178,9 +182,169 @@ static void pwrseq_pcie_free_resources(void *data)
>  {
>  	struct pwrseq_pcie_m2_ctx *ctx = data;
>  
> +	serdev_device_remove(ctx->serdev);
> +	of_changeset_revert(ctx->ocs);
> +	of_changeset_destroy(ctx->ocs);
> +	bus_unregister_notifier(&pci_bus_type, &ctx->nb);
>  	regulator_bulk_free(ctx->num_vregs, ctx->regs);
>  }
>  
> +static int pwrseq_m2_pcie_create_bt_node(struct pwrseq_pcie_m2_ctx *ctx,
> +					struct device_node *parent)
> +{
> +	struct device *dev = ctx->dev;
> +	struct device_node *np;
> +	int ret;
> +
> +	ctx->ocs = devm_kzalloc(dev, sizeof(*ctx->ocs), GFP_KERNEL);
> +	if (!ctx->ocs)
> +		return -ENOMEM;
> +
> +	of_changeset_init(ctx->ocs);
> +
> +	np = of_changeset_create_node(ctx->ocs, parent, "bluetooth");
> +	if (!np) {
> +		dev_err(dev, "Failed to create bluetooth node\n");
> +		ret = -ENODEV;
> +		goto err_destroy_changeset;
> +	}
> +
> +	ret = of_changeset_add_prop_string(ctx->ocs, np, "compatible", "qcom,wcn7850-bt");
> +	if (ret) {
> +		dev_err(dev, "Failed to add bluetooth compatible: %d\n", ret);
> +		goto err_destroy_changeset;
> +	}
> +
> +	ret = of_changeset_apply(ctx->ocs);
> +	if (ret) {
> +		dev_err(dev, "Failed to apply changeset: %d\n", ret);
> +		goto err_destroy_changeset;
> +	}
> +
> +	ret = device_add_of_node(&ctx->serdev->dev, np);
> +	if (ret) {
> +		dev_err(dev, "Failed to add OF node: %d\n", ret);
> +		goto err_revert_changeset;
> +	}
> +
> +	return 0;
> +
> +err_revert_changeset:
> +	of_changeset_revert(ctx->ocs);
> +err_destroy_changeset:
> +	of_changeset_destroy(ctx->ocs);
> +
> +	return ret;
> +}
> +
> +static int pwrseq_m2_pcie_notify(struct notifier_block *nb, unsigned long action,
> +			      void *data)
> +{
> +	struct pwrseq_pcie_m2_ctx *ctx = container_of(nb, struct pwrseq_pcie_m2_ctx, nb);
> +	struct pci_dev *pdev = to_pci_dev(data);
> +	struct serdev_controller *serdev_ctrl;
> +	struct device *dev = ctx->dev;
> +	struct device_node *pci_parent;
> +	int ret;
> +
> +	/*
> +	 * Check whether the PCI device is associated with this M.2 connector or
> +	 * not, by comparing the OF node of the PCI device parent and the Port 0
> +	 * (PCIe) remote node parent OF node.
> +	 */
> +	pci_parent = of_graph_get_remote_node(dev_of_node(ctx->dev), 0, 0);
> +	if (!pci_parent || (pci_parent != pdev->dev.parent->of_node)) {
> +		of_node_put(pci_parent);
> +		return NOTIFY_DONE;
> +	}
> +	of_node_put(pci_parent);
> +
> +	switch (action) {
> +	case BUS_NOTIFY_ADD_DEVICE:
> +		/* Create serdev device for WCN7850 */
> +		if (pdev->vendor == PCI_VENDOR_ID_QCOM && pdev->device == 0x1107) {
> +			struct device_node *serdev_parent __free(device_node) =
> +				of_graph_get_remote_node(dev_of_node(ctx->dev), 1, 1);
> +			if (!serdev_parent)
> +				return NOTIFY_DONE;
> +
> +			serdev_ctrl = of_find_serdev_controller_by_node(serdev_parent);
> +			if (!serdev_ctrl)
> +				return NOTIFY_DONE;
> +
> +			ctx->serdev = serdev_device_alloc(serdev_ctrl);
> +			if (!ctx->serdev)
> +				return NOTIFY_BAD;
> +
> +			ret = pwrseq_m2_pcie_create_bt_node(ctx, serdev_parent);
> +			if (ret) {
> +				serdev_device_put(ctx->serdev);
> +				return notifier_from_errno(ret);
> +			}
> +
> +			ret = serdev_device_add(ctx->serdev);
> +			if (ret) {
> +				dev_err(dev, "Failed to add serdev for WCN7850: %d\n", ret);
> +				of_changeset_revert(ctx->ocs);
> +				of_changeset_destroy(ctx->ocs);
> +				serdev_device_put(ctx->serdev);
> +				return notifier_from_errno(ret);
> +			}
> +		}
> +		break;
> +	case BUS_NOTIFY_REMOVED_DEVICE:
> +		/* Destroy serdev device for WCN7850 */
> +		if (pdev->vendor == PCI_VENDOR_ID_QCOM && pdev->device == 0x1107) {
> +			serdev_device_remove(ctx->serdev);
> +			of_changeset_revert(ctx->ocs);
> +			of_changeset_destroy(ctx->ocs);
> +		}
> +		break;
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
> +static bool pwrseq_pcie_m2_check_remote_node(struct device *dev, u8 port, u8 endpoint,
> +					     const char *node)
> +{
> +	struct device_node *remote __free(device_node) =
> +			of_graph_get_remote_node(dev_of_node(dev), port, endpoint);
> +
> +	if (remote && of_node_name_eq(remote, node))
> +		return true;
> +
> +	return false;
> +}
> +
> +/*
> + * If the connector exposes a non-discoverable bus like UART, the respective
> + * protocol device needs to be created manually with the help of the notifier
> + * of the discoverable bus like PCIe.
> + */
> +static int pwrseq_pcie_m2_register_notifier(struct pwrseq_pcie_m2_ctx *ctx, struct device *dev)
> +{
> +	int ret;
> +
> +	/*
> +	 * Register a PCI notifier for Key E connector that has PCIe as Port
> +	 * 0/Endpoint 0 interface and Serial as Port 1/Endpoint 1 interface.
> +	 */
> +	if (pwrseq_pcie_m2_check_remote_node(dev, 1, 1, "serial")) {
> +		if (pwrseq_pcie_m2_check_remote_node(dev, 0, 0, "pcie")) {
> +			ctx->dev = dev;
> +			ctx->nb.notifier_call = pwrseq_m2_pcie_notify;
> +			ret = bus_register_notifier(&pci_bus_type, &ctx->nb);
> +			if (ret) {
> +				dev_err_probe(dev, ret, "Failed to register notifier for serdev\n");
> +				return ret;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -235,7 +399,11 @@ static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
>  		return dev_err_probe(dev, PTR_ERR(ctx->pwrseq),
>  				     "Failed to register the power sequencer\n");
>  
> -	return 0;
> +	/*
> +	 * Register a notifier for creating protocol devices for
> +	 * non-discoverable busses like UART.
> +	 */
> +	return pwrseq_pcie_m2_register_notifier(ctx, dev);
>  }
>  
>  static const struct of_device_id pwrseq_pcie_m2_of_match[] = {
> 
> -- 
> 2.48.1
> 
> 

-- 
மணிவண்ணன் சதாசிவம்


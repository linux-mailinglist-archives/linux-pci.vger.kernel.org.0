Return-Path: <linux-pci+bounces-44610-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3CDD19563
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 15:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13E1D304A8DC
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 14:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D5939281B;
	Tue, 13 Jan 2026 14:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8sL/Nwz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1C434575A
	for <linux-pci@vger.kernel.org>; Tue, 13 Jan 2026 14:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768313513; cv=none; b=lp1DypQ6tpsMqY50dJhsVRCqHNg0VyrbOyVuy4F2E5/Yd93X9wYu5REM+GKCVlKHQMmAb0Mf1lscurKg3eQlVHvsAvqvU3y68EDwD2JuMoAMHJbWlNLqugoCgumntgVvkRC5mpCjXxYVk5T7bC5LhIBu9ekAPFAvSvea2bbVckk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768313513; c=relaxed/simple;
	bh=2o4fVLbj2q/juHrQ29zfxRlsPMFPI33ueLLq8D8m2z8=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s0dXiHXy6XauLUCezbz/SsFit1gjJ89SmxImK1HAZPlhG9rDVZa8ACNg5tZcZDLfdXcGyNPfS7kAkyOr4HyjIGc9ZbF0V//vb1DU3ElPr6MHacT36a7MmWPf9XvPLGxZboVbys797/CxcB0DDH/fb959ZcMxN0OSExlJ0ZPmWFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8sL/Nwz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3DD3C2BC9E
	for <linux-pci@vger.kernel.org>; Tue, 13 Jan 2026 14:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768313512;
	bh=2o4fVLbj2q/juHrQ29zfxRlsPMFPI33ueLLq8D8m2z8=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=W8sL/NwzlaWzWubNWcJpoDGOzscVAJzioDKK7dAWaTM4Wr/4ELYqiY9f/N6kZjM8Z
	 OfgC4dl/GPTNPpZfddzwYCy6AG/utPG0aRUhBxMtPHN2StpkFGCiYateDgTxHW2Vd5
	 sB3vkGN6ihv/BWC53Jw8pQNiCkE/A1g5Fk8uMqKPmwF55YtAQD1tJdyYeS7WApzG1H
	 kcxSQw5BClPnzEhak9epDujg/AUWGriJP4CAmHeoL4dPwHRJ+Pq7NhYgQs6uRQ11c9
	 Z4TTmTLRbVcMZjGC9Zw0bGRFsF84RejcyZMhPEl3hGUr6KidQ0sjw8VYrZF4ikxYQD
	 /Q86a00se/A6w==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59b6c89d306so6938810e87.0
        for <linux-pci@vger.kernel.org>; Tue, 13 Jan 2026 06:11:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVEOn+p3AD9dvMKKG3mf5qlG99jquzNki/eIMSn4SEfwsaU5GHx/6PTElbyCftvFk1jb6+inda1RW4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0xU8PN8Yu8Pjgyz5oWklylQvj+cYMvDAiAspNm6Mg1PP45LC6
	+b35ZstvM2qMISWAMYX13B8L51ScxZqZdwgVmXmYP3kciVGNvMcH+/mAh4oWgFCtWN0uLHvkSad
	z15OKnu1oQC8FYaYeAKqLqBQqpKskXGtzQFdWspZpxw==
X-Google-Smtp-Source: AGHT+IHgO6vQGVDAoaDpXL7sqdQ9dk9g/IUD4KvpqB+NS3F4pyKCpRT9NezHlfM6BjRDI2utaK1So06W8B6m0G6XZlg=
X-Received: by 2002:a05:6512:3dac:b0:598:e8b7:665d with SMTP id
 2adb3069b0e04-59b6ef0698bmr8302723e87.3.1768313511342; Tue, 13 Jan 2026
 06:11:51 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 13 Jan 2026 06:11:50 -0800
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 13 Jan 2026 06:11:50 -0800
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260112-pci-m2-e-v4-9-eff84d2c6d26@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112-pci-m2-e-v4-0-eff84d2c6d26@oss.qualcomm.com> <20260112-pci-m2-e-v4-9-eff84d2c6d26@oss.qualcomm.com>
Date: Tue, 13 Jan 2026 06:11:50 -0800
X-Gmail-Original-Message-ID: <CAMRc=Me3vW+7HF4Xn3YbO=8gPuE5qNDr_7G3ML1i9FNf4__MNw@mail.gmail.com>
X-Gm-Features: AZwV_QhKs9mbfNudW09wPN-rpaKD-7Pg9ZU_jQe7S1RnAaBm7jn4QSxPwzhOrL0
Message-ID: <CAMRc=Me3vW+7HF4Xn3YbO=8gPuE5qNDr_7G3ML1i9FNf4__MNw@mail.gmail.com>
Subject: Re: [PATCH v4 9/9] power: sequencing: pcie-m2: Create serdev device
 for WCN7850 bluetooth
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-acpi@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas.schier@linux.dev>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 Jan 2026 17:26:08 +0100, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> said:
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

Ah, looks like this should have not appeared here before this patch?

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

Don't you need to depend on CONFIG_OF_DYNAMIC? These symbols are not
stubbed out.

> +	bus_unregister_notifier(&pci_bus_type, &ctx->nb);

Shouldn't this happen earlier? What if a notification happens when you're
reverting previous changesets?

>  	regulator_bulk_free(ctx->num_vregs, ctx->regs);
>  }
>
> +static int pwrseq_m2_pcie_create_bt_node(struct pwrseq_pcie_m2_ctx *ctx,
> +					struct device_node *parent)
> +{
> +	struct device *dev = ctx->dev;
> +	struct device_node *np;
> +	int ret;

Are we sure this will not happen twice for some reason?

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

struct device_node *pci_parent __free(device_node) ?

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

You're almost always doing both, maybe it's time to add of_changeset_undo() or
something that wraps these?

> +				serdev_device_put(ctx->serdev);

And since you're touching serdev, maybe DEFINE_FREE(serdev_device_put)?

> +				return notifier_from_errno(ret);

Thanks for including this.

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

Return dev_err_probe()?

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
>

Bart


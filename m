Return-Path: <linux-pci+bounces-29057-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC772ACF8C3
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 22:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E911A3A9EF3
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 20:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1954327E1AB;
	Thu,  5 Jun 2025 20:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAJ5mJGb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2A127CCF5;
	Thu,  5 Jun 2025 20:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749155193; cv=none; b=pgeEd3RDQ4Rfh00pgvzP3ATPnsIAYEfni70ntqPoPEJha4pAKSBmvB/WM1kVekcwSFj1QAdn/GY+kbNyxY6pQsh9wBloymQJwRLEL4MN3tF7yWpluZXdohoM9KJee6Hly7k2G9mYYTfN2d5IJO6L+H0ZLs0hlqRSp3JjsJoxWw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749155193; c=relaxed/simple;
	bh=HqLK9FLNyni2o9eamovpLoHUs7SKHQEul0Dkt7S3oTE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pEgvW28dYXfCrTFMagd8f7tq0xRQZn7F3z26n/BmsIIkLVcXIhRQ/lKjUjlgxoYeXnhQ24QjACvTuws37n0I8s/l7wb6ewaF+A1OTGGa9d7PlJdXow3w8UQibA0JqSA4bwpm5HRVmzlZCekLaB3lOAPUy88lQB3zdUrBNGV3VOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAJ5mJGb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F3E1C4CEE7;
	Thu,  5 Jun 2025 20:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749155192;
	bh=HqLK9FLNyni2o9eamovpLoHUs7SKHQEul0Dkt7S3oTE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FAJ5mJGbeAX225unTQ2D3kweV83yCz6BS8Ky+yQMeDbS4g57wlRzmLk7lmVl0KFzs
	 +i1sxqM6OAbCXeLNwHJwmdohHrwzvpbmWuL7F6syc93WywF0yfUl7kSPtJZgW+kflm
	 LuZNSol+jSXKHYHuqCsHspVSV+5Cqk7CPIQUuSehYlkBOJxUgapoG8D1IsAxkBTfh6
	 sH+42vq2RW/o2jxOJE0nCHE7JuhlTFLKhPXA3/egYcjxmWqm2B7XXKSuBB2ONzdLRU
	 4woGB9FSicQsE6pzFQ8ZnQKfrQE19jxtnqwLsFusYoC0oH/13dpAZhwTkaVKduNRuv
	 p2uG9eCSBxrvQ==
Date: Thu, 5 Jun 2025 15:26:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, quic_vbadigan@quicinc.com,
	quic_mrana@quicinc.com, Sherry Sun <sherry.sun@nxp.com>
Subject: Re: [PATCH v3 2/2] PCI/portdrv: Add support for PCIe wake interrupt
Message-ID: <20250605202630.GA622231@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605-wake_irq_support-v3-2-7ba56dc909a5@oss.qualcomm.com>

On Thu, Jun 05, 2025 at 10:54:45AM +0530, Krishna Chaitanya Chundru wrote:
> PCIe wake interrupt is needed for bringing back PCIe device state
> from D3cold to D0.

Does this refer to the WAKE# signal or Beacon or both?  I guess the
comments in the patch suggest WAKE#.  Is there any spec section we can
cite here?

> Implement new functions, of_pci_setup_wake_irq() and
> of_pci_teardown_wake_irq(), to manage wake interrupts for PCI devices
> using the Device Tree.
> 
> From the port bus driver call these functions to enable wake support
> for bridges.

What is the connection to bridges and portdrv?  WAKE# is described in
PCIe r6.0, sec 5.3.3.2, and PCIe CEM r6.0, sec 2.3, but AFAICS neither
restricts it to bridges.

Unless there's some related functionality in a Root Port, RCEC, or
Switch Port, maybe this code should be elsewhere, like
set_pcie_port_type(), so we could set this up for any PCIe device that
has a WAKE# description?

> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> Tested-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>  drivers/pci/of.c           | 67 ++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/pci.h          |  6 +++++
>  drivers/pci/pcie/portdrv.c | 12 ++++++++-
>  3 files changed, 84 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index ab7a8252bf4137a17971c3eb8ab70ce78ca70969..3487cd62d81f0a66e7408e286475e8d91c2e410a 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -7,6 +7,7 @@
>  #define pr_fmt(fmt)	"PCI: OF: " fmt
>  
>  #include <linux/cleanup.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/irqdomain.h>
>  #include <linux/kernel.h>
>  #include <linux/pci.h>
> @@ -15,6 +16,7 @@
>  #include <linux/of_address.h>
>  #include <linux/of_pci.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_wakeirq.h>
>  #include "pci.h"
>  
>  #ifdef CONFIG_PCI
> @@ -966,3 +968,68 @@ u32 of_pci_get_slot_power_limit(struct device_node *node,
>  	return slot_power_limit_mw;
>  }
>  EXPORT_SYMBOL_GPL(of_pci_get_slot_power_limit);
> +
> +/**
> + * of_pci_slot_setup_wake_irq - Set up wake interrupt for PCI device
> + * @pdev: The PCI device structure
> + *
> + * This function sets up the wake interrupt for a PCI device by getting the
> + * corresponding WAKE# gpio from the device tree, and configuring it as a
> + * dedicated wake interrupt.
> + *
> + * Return: 0 if the WAKE# gpio is not available or successfully parsed else
> + * errno otherwise.
> + */
> +int of_pci_slot_setup_wake_irq(struct pci_dev *pdev)
> +{
> +	struct gpio_desc *wake;
> +	struct device_node *dn;
> +	int ret, wake_irq;
> +
> +	dn = pci_device_to_OF_node(pdev);
> +	if (!dn)
> +		return 0;
> +
> +	wake = devm_fwnode_gpiod_get(&pdev->dev, of_fwnode_handle(dn),
> +				     "wake", GPIOD_IN, NULL);

I guess this finds "wake-gpio" or "wake-gpios", as used in
Documentation/devicetree/bindings/pci/qcom,pcie.yaml,
qcom,pcie-sa8775p.yaml, etc?  Are these names specified in any generic
place, e.g.,
https://github.com/devicetree-org/dt-schema/tree/main/dtschema/schemas/pci?

> +	if (IS_ERR(wake) && PTR_ERR(wake) != -ENOENT) {
> +		dev_err(&pdev->dev, "Failed to get wake GPIO: %ld\n", PTR_ERR(wake));
> +		return PTR_ERR(wake);
> +	}
> +	if (IS_ERR(wake))
> +		return 0;
> +
> +	wake_irq = gpiod_to_irq(wake);
> +	if (wake_irq < 0) {
> +		dev_err(&pdev->dev, "Dailed to get wake irq: %d\n", wake_irq);

s/Dailed/Failed/

> +		return wake_irq;
> +	}
> +
> +	device_init_wakeup(&pdev->dev, true);
> +
> +	ret = dev_pm_set_dedicated_wake_irq(&pdev->dev, wake_irq);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to set wake IRQ: %d\n", ret);
> +		device_init_wakeup(&pdev->dev, false);
> +		return ret;
> +	}
> +	irq_set_irq_type(wake_irq, IRQ_TYPE_EDGE_FALLING);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(of_pci_slot_setup_wake_irq);
> +
> +/**
> + * of_pci_slot_teardown_wake_irq - Teardown wake interrupt setup for PCI device
> + *
> + * @pdev: The PCI device structure
> + *
> + * This function tears down the wake interrupt setup for a PCI device,
> + * clearing the dedicated wake interrupt and disabling device wake-up.
> + */
> +void of_pci_slot_teardown_wake_irq(struct pci_dev *pdev)
> +{
> +	dev_pm_clear_wake_irq(&pdev->dev);
> +	device_init_wakeup(&pdev->dev, false);
> +}
> +EXPORT_SYMBOL_GPL(of_pci_slot_teardown_wake_irq);
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 39f368d2f26de872f6484c6cb4e12752abfff7bc..dd7a4da1225bbdb1dff82707b580e7e0a95a5abf 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -888,6 +888,9 @@ void pci_release_of_node(struct pci_dev *dev);
>  void pci_set_bus_of_node(struct pci_bus *bus);
>  void pci_release_bus_of_node(struct pci_bus *bus);
>  
> +int of_pci_slot_setup_wake_irq(struct pci_dev *pdev);
> +void of_pci_slot_teardown_wake_irq(struct pci_dev *pdev);
> +
>  int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge);
>  bool of_pci_supply_present(struct device_node *np);
>  
> @@ -931,6 +934,9 @@ static inline int devm_of_pci_bridge_init(struct device *dev, struct pci_host_br
>  	return 0;
>  }
>  
> +static int of_pci_slot_setup_wake_irq(struct pci_dev *pdev) { return 0; }
> +static void of_pci_slot_teardown_wake_irq(struct pci_dev *pdev) { }
> +
>  static inline bool of_pci_supply_present(struct device_node *np)
>  {
>  	return false;
> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index e8318fd5f6ed537a1b236a3a0f054161d5710abd..9a6beec87e4523a33ecace684109cd44e025c97b 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -694,12 +694,18 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
>  	     (type != PCI_EXP_TYPE_RC_EC)))
>  		return -ENODEV;
>  
> +	status = of_pci_slot_setup_wake_irq(dev);
> +	if (status)
> +		return status;
> +
>  	if (type == PCI_EXP_TYPE_RC_EC)
>  		pcie_link_rcec(dev);
>  
>  	status = pcie_port_device_register(dev);
> -	if (status)
> +	if (status) {
> +		of_pci_slot_teardown_wake_irq(dev);
>  		return status;
> +	}
>  
>  	pci_save_state(dev);
>  
> @@ -732,6 +738,8 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
>  
>  	pcie_port_device_remove(dev);
>  
> +	of_pci_slot_teardown_wake_irq(dev);
> +
>  	pci_disable_device(dev);
>  }
>  
> @@ -744,6 +752,8 @@ static void pcie_portdrv_shutdown(struct pci_dev *dev)
>  	}
>  
>  	pcie_port_device_remove(dev);
> +
> +	of_pci_slot_teardown_wake_irq(dev);
>  }
>  
>  static pci_ers_result_t pcie_portdrv_error_detected(struct pci_dev *dev,
> 
> -- 
> 2.34.1
> 


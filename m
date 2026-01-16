Return-Path: <linux-pci+bounces-45040-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E93ED30BE0
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 12:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0586530136D3
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 11:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F0337E2E0;
	Fri, 16 Jan 2026 11:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgbeSaNW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C952FDC20;
	Fri, 16 Jan 2026 11:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768564607; cv=none; b=nrcy1hliKFotjlkH/zhEpm7uhpRYhgl9Bd8qg8NjQtKAcykIMgE8A9GTeMQ+B42SoAFysBMN4/5KHqq6B3mCFGr20HFCfIa6EOFhxm2YiAmmpHktRky+HhvEfKZyWVqYbqhdPyxz0OZflt7bmGRZitJYYMH845OnRG5gmqBN/Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768564607; c=relaxed/simple;
	bh=vNXSWBR9CH5JIsi8nV5h+e6ovGLPQ6ZopD1T34okv+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pvxpvA9tnJ5KPAIvsr6794SXOWN7OXYrCfXfceAZJeeIIrpalCpUVdd0LqsvNfhnK+1rm26c4CCUV/zoq+V+E4N5EDNPVoxwqPC5i1Ji2c1HKZ2jpEgbzftI7ZrQwvnYoKZqKBG+rKkPlw+KeRn5xfWlPA/Kagy9TYUKxutYxec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgbeSaNW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B64DC116C6;
	Fri, 16 Jan 2026 11:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768564607;
	bh=vNXSWBR9CH5JIsi8nV5h+e6ovGLPQ6ZopD1T34okv+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FgbeSaNWLZAs69IlMTetUtp9yMXIXzIYn8SZYG3dukV5Hp8spNEjpaKC5k8h0bENy
	 lK7KUmq6VMjj8MJgNFJC9fftmd9EZDdzIfTXRNlcHELRYHznFypLQggQw5Gljy9cMf
	 iGVykyWUX77j9sIXk4yaH0u7HKDpKu7Qi3gdv1ts4lPJGoMBp97230n0UeF6PPpCq6
	 XNU6XF9YynCeRr1a8CiBFRqcu4tec8Gl3PDJ9AVJGgrSjirNXRvWKm8sFOIK8l94fu
	 beBrARhOZJ1fM8XZ8bcV4IoHuEOCN6XYsFes50eVzFQVetTpdeQmL88UJV6TbyefVx
	 ywI27bbeQYFtg==
Date: Fri, 16 Jan 2026 17:26:33 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org, 
	quic_vbadigan@quicinc.com, quic_mrana@quicinc.com, sherry.sun@nxp.com
Subject: Re: [PATCH v6 2/2] PCI: Add support for PCIe WAKE# interrupt
Message-ID: <ip6k4kjyu5lrnafqyrnq54dw6lqixaqx7wckwn3ttxr7hpu4ob@77l52tthlfnp>
References: <20251127-wakeirq_support-v6-0-60f581f94205@oss.qualcomm.com>
 <20251127-wakeirq_support-v6-2-60f581f94205@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251127-wakeirq_support-v6-2-60f581f94205@oss.qualcomm.com>

On Thu, Nov 27, 2025 at 06:15:43PM +0530, Krishna Chaitanya Chundru wrote:
> According to the PCIe specification 6, sec 5.3.3.2, there are two defined
> wakeup mechanisms: Beacon and WAKE# for the Link wakeup mechanisms to
> provide a means of signaling the platform to re-establish power and
> reference clocks to the components within its domain. Beacon is a hardware
> mechanism invisible to software (PCIe r7.0, sec 4.2.7.8.1). Adding WAKE#
> support in PCI framework.

Use imperative tone.

> 
> According to the PCIe specification, multiple WAKE# signals can exist in
> a system.

Add 'or each component in the hierarchy could share a single WAKE# signal'.

> In configurations involving a PCIe switch, each downstream port
> (DSP) of the switch may be connected to a separate WAKE# line, allowing
> each endpoint to signal WAKE# independently. From figure 5.4, WAKE# can

Add spec revision.

> also be terminated at the switch itself. To support this, the WAKE#
> should be described in the device tree node of the endpint/bridge. If all

'endpoint'

> endpoints share a single WAKE# line, then WAKE# should be defined in the
> each node.
> 

'.., then each endpoint node should describe the same WAKE# signal or a single
WAKE# in the Root Port node'.

> To support legacy devicetree in direct attach case, driver will search
> in root port node for WAKE# if the driver doesn't find in the endpoint
> node.
> 

This is not a legacy way. If there is a single WAKE#, then DTS may still
describe it only in the Root Port node.

> In pci_device_add(), PCI framework will search for the WAKE# in its node,

s/its/device

> If not found, it searches in its upstream port only if upstream port is
> root port to support legacy bindings. Once found, register for the wake IRQ

s/root port/Root Port

Again, drop 'legacy binding'.

> in shared mode, as the WAKE# may be shared among multiple endpoints.
> 
> When the IRQ is asserted, the handle_threaded_wake_irq() handler triggers

handle_threaded_wake_irq() is not part of this patch. So maybe say,

'When a device asserts WAKE#, PM core will wakeup the system, resume the device
and its parent(s) in the hierarchy, which will cause the restoration of power
and refclk to the device.'

> a pm_runtime_resume().
> The PM framework ensures that the parent device is
> resumed before the child i.e controller driver which can bring back device
> state to D0.
> 
> WAKE# is added in dts schema and merged based on below links.
> 
> Link: https://lore.kernel.org/all/20250515090517.3506772-1-krishna.chundru@oss.qualcomm.com/
> Link: https://github.com/devicetree-org/dt-schema/pull/170
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/of.c     | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/pci.h    |  6 ++++++
>  drivers/pci/probe.c  |  2 ++
>  drivers/pci/remove.c |  1 +
>  include/linux/pci.h  |  2 ++
>  5 files changed, 69 insertions(+)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 3579265f119845637e163d9051437c89662762f8..fc33405a7b1f001e171277434663cc9dfe57c69b 100644
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
> @@ -586,6 +588,62 @@ int of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin)
>  	return irq_create_of_mapping(&oirq);
>  }
>  EXPORT_SYMBOL_GPL(of_irq_parse_and_map_pci);
> +
> +static void pci_configure_wake_irq(struct pci_dev *pdev, struct gpio_desc *wake)
> +{
> +	int ret, wake_irq;
> +
> +	if (!wake)
> +		return;
> +
> +	wake_irq = gpiod_to_irq(wake);
> +	if (wake_irq < 0) {
> +		dev_err(&pdev->dev, "Failed to get wake irq: %d\n", wake_irq);

Why not pci_err()?

> +		return;
> +	}
> +
> +	device_init_wakeup(&pdev->dev, true);

I don't think we should enable wakeup by default for all devices, but only
conditionally in platform_pci_set_wakeup().

> +
> +	ret = dev_pm_set_dedicated_shared_wake_irq(&pdev->dev, wake_irq,
> +						   IRQ_TYPE_EDGE_FALLING);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to set wake IRQ: %d\n", ret);

pci_err()?

> +		device_init_wakeup(&pdev->dev, false);
> +	}
> +}
> +
> +void pci_configure_of_wake_gpio(struct pci_dev *dev)
> +{
> +	struct device_node *dn = pci_device_to_OF_node(dev);
> +	struct gpio_desc *gpio;
> +	struct pci_dev *root;

s/root/upstream

> +
> +	if (!dn)
> +		return;
> +
> +	gpio = fwnode_gpiod_get_index(of_fwnode_handle(dn),
> +				      "wake", 0, GPIOD_IN | GPIOD_FLAGS_BIT_NONEXCLUSIVE, NULL);

You can add a new fwnode_gpiod_get() API that wraps
fwnode_gpiod_get_index(..0..), similar to devm_fwnode_gpiod_get().

> +	if (IS_ERR(gpio)) {
> +		/*
> +		 * To support legacy devicetree, search in root port for WAKE#
> +		 * in direct attach case.

"In case the entire topology shares a single WAKE# signal, look for it in the
upstream bridge node. But if it is not Root Port, then skip it."

> +		 */
> +		root = pci_upstream_bridge(dev);
> +		if (pci_is_root_bus(root->bus))
> +			pci_configure_wake_irq(dev, root->wake);
> +	} else {
> +		dev->wake = gpio;
> +		pci_configure_wake_irq(dev, gpio);
> +	}
> +}
> +
> +void pci_remove_of_wake_gpio(struct pci_dev *dev)
> +{
> +	dev_pm_clear_wake_irq(&dev->dev);
> +	device_init_wakeup(&dev->dev, false);
> +	gpiod_put(dev->wake);
> +	dev->wake = NULL;
> +}
>  #endif	/* CONFIG_OF_IRQ */
>  
>  static int pci_parse_request_of_pci_ranges(struct device *dev,
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 4492b809094b5794bd94dfbc20102cb208c3fa2f..05cb240ecdb59f9833ca6dae2357fdbd012195d6 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -1056,6 +1056,9 @@ void pci_release_of_node(struct pci_dev *dev);
>  void pci_set_bus_of_node(struct pci_bus *bus);
>  void pci_release_bus_of_node(struct pci_bus *bus);
>  
> +void pci_configure_of_wake_gpio(struct pci_dev *dev);
> +void pci_remove_of_wake_gpio(struct pci_dev *dev);
> +
>  int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge);
>  bool of_pci_supply_present(struct device_node *np);
>  int of_pci_get_equalization_presets(struct device *dev,
> @@ -1101,6 +1104,9 @@ static inline int devm_of_pci_bridge_init(struct device *dev, struct pci_host_br
>  	return 0;
>  }
>  
> +static inline void pci_configure_of_wake_gpio(struct pci_dev *dev) { }
> +static inline void pci_remove_of_wake_gpio(struct pci_dev *dev) { }
> +
>  static inline bool of_pci_supply_present(struct device_node *np)
>  {
>  	return false;
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 0ce98e18b5a876afe72af35a9f4a44d598e8d500..f9b879c8e3f72a9845f60577335019aa2002dc23 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2762,6 +2762,8 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
>  	ret = device_add(&dev->dev);
>  	WARN_ON(ret < 0);
>  
> +	pci_configure_of_wake_gpio(dev);

This should be wrapped inside a new platform_pci_configure_wake() API, similar
to other platform APIs.

> +
>  	pci_npem_create(dev);
>  
>  	pci_doe_sysfs_init(dev);
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index ce5c25adef5518e5aec30c41de37ea66d682f3b0..26e9c1df51c76344a1d7f5cc7edd433780e73474 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -54,6 +54,7 @@ static void pci_destroy_dev(struct pci_dev *dev)
>  	if (pci_dev_test_and_set_removed(dev))
>  		return;
>  
> +	pci_remove_of_wake_gpio(dev);

Same as above, wrap it inside platform_pci_remove_wake() API.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


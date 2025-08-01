Return-Path: <linux-pci+bounces-33317-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5183FB188BA
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 23:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74328583A1C
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 21:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9BA28DB7E;
	Fri,  1 Aug 2025 21:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYpCv7aj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A80614AD2B;
	Fri,  1 Aug 2025 21:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754083647; cv=none; b=NVpSahfqFh99HqQOfksBez/O7VhYAN39WFFlR8/gBcJeCQ6JkZ/83iysZM1ajEGkKy3X/ce8ZSbgmlK3VcDRAsLi0DL6CcUAXqVDXf2sN8i8KUW73qKFHJBgu5ac/71MaLDkLVC2p0c+y55bj4lMGVa0vdrfP1+LxNUa2z/yshY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754083647; c=relaxed/simple;
	bh=0SxswfLZxEHoTgRaIAQYChRRKBrt2yMqSX3GGZmr4v8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=UnoViA3aBWHZ9swsxySscesnUoWMrvhcM1emBMi/zvgnzqmLX4ZlwBlU1dxdSktpZaLpGVwrHWNcBj1aAuYKLc7NNRMbR2gOBsCQHE3qZKLJqRYdD5jF4efK88xL0wdZJySygNMHd4WJepgEjQgkp5CGRP1r387hfKdWB9iURSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GYpCv7aj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA277C4CEE7;
	Fri,  1 Aug 2025 21:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754083647;
	bh=0SxswfLZxEHoTgRaIAQYChRRKBrt2yMqSX3GGZmr4v8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=GYpCv7ajxY0nQzOSBWd6r8ISWaIDw/D1bgTcr6771KsHkbNHcBh3RGr418ucMGJFG
	 Di2Ei7hmYabZZRF27ukYa65LyQGeqLfQ32LE94TbjbSCS1NadmNmImP3KQAMQk5hSF
	 45hEf1524sFSCxB1cHOwwMKUQIBEDFtONZUnjW2Jc4YBBV0D0jMbir+pFi1dQ1XcN+
	 J9Bqdf1TaVaTOe1MYt6m42ZGpdhBS5QoIwn2nnWucA/vM6H9a4K4B4MUZ7QUqS57nt
	 6nGv+k4Q9Y17pgmj2BMJAzx1mf5xEH0HjvjStopRqfl0h24TpbgVcW+FOk2LYNQRdA
	 ui64eRfK0nL7A==
Date: Fri, 1 Aug 2025 16:27:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, quic_vbadigan@quicinc.com,
	quic_mrana@quicinc.com, sherry.sun@nxp.com,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 3/3] PCI: Add support for PCIe WAKE# interrupt
Message-ID: <20250801212725.GA3506354@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801-wake_irq_support-v4-3-6b6639013a1a@oss.qualcomm.com>

On Fri, Aug 01, 2025 at 04:29:44PM +0530, Krishna Chaitanya Chundru wrote:
> According to the PCIe specification 6, sec 5.3.3.2, there are two defined
> wakeup mechanisms: Beacon and WAKE# for the Link wakeup mechanisms to
> provide a means of signaling the platform to re-establish power and
> reference clocks to the components within its domain. Adding WAKE#
> support in PCI framework.

I think Beacon is a hardware mechanism invisible to software (PCIe
r7.0, sec 4.2.7.8.1).

> According to the PCIe specification, multiple WAKE# signals can exist in a
> system. In configurations involving a PCIe switch, each downstream port
> (DSP) of the switch may be connected to a separate WAKE# line, allowing
> each endpoint to signal WAKE# independently. To support this, the WAKE#
> should be described in the device tree node of the upstream bridge to which
> the endpoint is connected.

I think this says a bit more than we know.  AFAICS, the PCIe spec does
not require any particular WAKE# routing.  WAKE# *could* be routed to
an upstream bridge (as shown in the 5.3.3.2 implementation note), but
it doesn't have to be.  I think we need to allow WAKE# to be described
by an Endpoint directly (which I think this patch does).

I'm not sure about searching upstream PCI bridges.  I don't think
there's anything in the PCIe spec about a connection between WAKE#
routing and the PCI topology.  Maybe we need to search enclosing DT
scopes?  I'm not really sure how DT works in this respect.  WAKE#
could be routed to some GPIO completely unrelated to the PCI host
bridge.

I don't see anything that would prevent a Switch Port from asserting a
WAKE# interrupt, so I'm not sure we should restrict it to Endpoints.

> For example, in a switch-based topology, the
> WAKE# can be defined in the DSP of the switch. In a direct connection
> scenario, the WAKE# can be defined in the root port. If all endpoints share
> a single WAKE# line, the GPIO should be defined in the root port.
> 
> During endpoint probe, the driver searches for the WAKE# in its immediate
> upstream bridge. If not found, it continues walking up the hierarchy until
> it either finds a WAKE# or reaches the root port. Once found, the driver
> registers the wake IRQ in shared mode, as the WAKE# may be shared among
> multiple endpoints.
> 
> When the IRQ is asserted, the wake handler triggers a pm_runtime_resume().

I guess "wake handler" refers to handle_threaded_wake_irq()?  If so,
just use the name directly to make it easier for people to follow
this.

> The PM framework ensures that the parent device is resumed before the
> child i.e controller driver which can bring back link to D0.

Nit: a *device* can be in D0.  Links would be in L0, etc.

> WAKE# is added in dts schema and merged based on this link.
> 
> Link: https://lore.kernel.org/all/20250515090517.3506772-1-krishna.chundru@oss.qualcomm.com/
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ...

> +void pci_parse_of_wake_gpio(struct pci_dev *dev)
> +{
> +	struct device_node *dn __free(device_node) = pci_device_to_OF_node(dev);

I'm still trying to wrap my head around __free().  Why are we using
__free() and no_free_ptr() here?  AFAICS we're not allocating anything
here.

> +	struct gpio_desc *gpio;
> +
> +	if (!dn)
> +		return;
> +
> +	gpio = fwnode_gpiod_get_index(of_fwnode_handle(no_free_ptr(dn)),
> +				      "wake", 0, GPIOD_IN, NULL);
> +	if (!IS_ERR(gpio))
> +		dev->wake = gpio;
> +}
> +
> +void pci_remove_of_wake_gpio(struct pci_dev *dev)
> +{
> +	if (!dev->wake)
> +		return;
> +
> +	gpiod_put(dev->wake);
> +	dev->wake = NULL;
> +}
>  #endif	/* CONFIG_OF_IRQ */
>  
>  static int pci_parse_request_of_pci_ranges(struct device *dev,
> @@ -1010,3 +1035,44 @@ int of_pci_get_equalization_presets(struct device *dev,
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(of_pci_get_equalization_presets);
> +
> +int pci_configure_wake_irq(struct pci_dev *pdev)
> +{
> +	struct pci_dev *bridge = pdev;
> +	struct gpio_desc *wake;
> +	int ret, wake_irq;
> +
> +	while (bridge) {
> +		wake = bridge->wake;
> +		if (wake)
> +			break;
> +		bridge = pci_upstream_bridge(bridge);  // Move to upstream bridge

If we need to search more scopes, I think we should be searching DT
scopes, not PCI bridges.

> +	}
> +
> +	if (!wake)
> +		return 0;
> +
> +	wake_irq = gpiod_to_irq(wake);
> +	if (wake_irq < 0) {
> +		dev_err(&pdev->dev, "Failed to get wake irq: %d\n", wake_irq);
> +		return wake_irq;
> +	}
> +
> +	device_init_wakeup(&pdev->dev, true);
> +
> +	ret = dev_pm_set_dedicated_wake_irq_flags(&pdev->dev, wake_irq,
> +						  IRQF_SHARED | IRQ_TYPE_EDGE_FALLING);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to set wake IRQ: %d\n", ret);
> +		device_init_wakeup(&pdev->dev, false);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +void pci_remove_wake_irq(struct pci_dev *pdev)
> +{
> +	dev_pm_clear_wake_irq(&pdev->dev);
> +	device_init_wakeup(&pdev->dev, false);
> +}
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index b853585cb1f87216981bde2a7782b8ed9c337636..2a1dca1d19b914d21b300ea78be0e0dce418cc88 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -447,10 +447,19 @@ static int pci_device_probe(struct device *dev)
>  	if (error < 0)
>  		return error;
>  
> +	if (pci_pcie_type(pci_dev) == PCI_EXP_TYPE_ENDPOINT) {

I guess there's a policy question here: configuring this in
pci_device_probe() implies that we only pay attention to WAKE# when a
driver is bound to the device.  Or, since WAKE# may be shared, I guess
we pay attention to it if any device sharing this WAKE# IRQ has a
driver?

And since we check for Endpoint, we ignore any potential WAKE# IRQs
from Switches?

ACPI has corresponding wakeup mechanisms.  Are they limited to devices
with drivers or to Endpoints?  Seems like this OF-based mechanism
should work similarly if possible.

> +		error =  pci_configure_wake_irq(pci_dev);
> +		if (error) {
> +			pcibios_free_irq(pci_dev);

As far as I can tell, pcibios_free_irq() is a no-op and I should have
removed it completely at the time of 6c777e8799a9 ("Revert "PCI, x86:
Implement pcibios_alloc_irq() and pcibios_free_irq()"").

I think we should remove it before this series rather than add new
calls.

> +			return error;
> +		}
> +	}
> +
>  	pci_dev_get(pci_dev);
>  	error = __pci_device_probe(drv, pci_dev);
>  	if (error) {
>  		pcibios_free_irq(pci_dev);
> +		pci_remove_wake_irq(pci_dev);
>  		pci_dev_put(pci_dev);
>  	}
>  
> @@ -475,6 +484,7 @@ static void pci_device_remove(struct device *dev)
>  		pm_runtime_put_noidle(dev);
>  	}
>  	pcibios_free_irq(pci_dev);
> +	pci_remove_wake_irq(pci_dev);
>  	pci_dev->driver = NULL;
>  	pci_iov_remove(pci_dev);
>  
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 12215ee72afb682b669c0e3a582b5379828e70c4..c8cf0b404a4f31b271f187dddd75a007c7566982 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -920,6 +920,11 @@ void pci_release_of_node(struct pci_dev *dev);
>  void pci_set_bus_of_node(struct pci_bus *bus);
>  void pci_release_bus_of_node(struct pci_bus *bus);
>  
> +void pci_parse_of_wake_gpio(struct pci_dev *dev);
> +void pci_remove_of_wake_gpio(struct pci_dev *dev);
> +int pci_configure_wake_irq(struct pci_dev *pdev);
> +void pci_remove_wake_irq(struct pci_dev *pdev);
> +
>  int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge);
>  bool of_pci_supply_present(struct device_node *np);
>  int of_pci_get_equalization_presets(struct device *dev,
> @@ -965,6 +970,11 @@ static inline int devm_of_pci_bridge_init(struct device *dev, struct pci_host_br
>  	return 0;
>  }
>  
> +static inline void pci_parse_of_wake_gpio(struct pci_dev *dev) { }
> +static inline void pci_remove_of_wake_gpio(struct pci_dev *dev) { }
> +static inline int pci_configure_wake_irq(struct pci_dev *pdev) { return 0; }
> +static inline void pci_remove_wake_irq(struct pci_dev *pdev) { }
> +
>  static inline bool of_pci_supply_present(struct device_node *np)
>  {
>  	return false;
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index e6a34db778266862564532becc2a30aec09bab22..4fb9d8df19bc41cb84dcd1886546076bcc867a43 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2717,6 +2717,8 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
>  	/* Set up MSI IRQ domain */
>  	pci_set_msi_domain(dev);
>  
> +	pci_parse_of_wake_gpio(dev);
> +
>  	/* Notifier could use PCI capabilities */
>  	ret = device_add(&dev->dev);
>  	WARN_ON(ret < 0);
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index 445afdfa6498edc88f1ef89df279af1419025495..1910f7c18b8f9b11c8136fea970788aaf834c97f 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -52,6 +52,7 @@ static void pci_destroy_dev(struct pci_dev *dev)
>  	if (pci_dev_test_and_set_removed(dev))
>  		return;
>  
> +	pci_remove_of_wake_gpio(dev);
>  	pci_doe_sysfs_teardown(dev);
>  	pci_npem_remove(dev);
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 05e68f35f39238f8b9ce08df97b384d1c1e89bbe..8f861298e41d2f0d2dd0fc3f5778fe0e77a93511 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -548,6 +548,8 @@ struct pci_dev {
>  	/* These methods index pci_reset_fn_methods[] */
>  	u8 reset_methods[PCI_NUM_RESET_METHODS]; /* In priority order */
>  
> +	struct gpio_desc *wake; /* Holds WAKE# gpio */
> +
>  #ifdef CONFIG_PCIE_TPH
>  	u16		tph_cap;	/* TPH capability offset */
>  	u8		tph_mode;	/* TPH mode */
> 
> -- 
> 2.34.1
> 


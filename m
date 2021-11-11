Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D198C44DDC0
	for <lists+linux-pci@lfdr.de>; Thu, 11 Nov 2021 23:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbhKKWPs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Nov 2021 17:15:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:58804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231407AbhKKWPl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Nov 2021 17:15:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D486761108;
        Thu, 11 Nov 2021 22:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636668772;
        bh=BVxM0aEH8q8XqnuKdqHEyKu9G3ojqkJGHwsOPE6ioyk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ONWrFHluQFI83EJbYqF+tX4N3pyVZGdwZvbiIOITbNxQQPW6fy8sHhRohA+vJUeGh
         6kXq9qSp/uqUrQGD1EqbDmP7cS50DGpm8i7v+8rttx7kvMXDCpcUz07jjtixjD9zpv
         TGOzZ3bwc6L1KEhYQ5M0AO6upvI66E+TucAPMLmpdG/4zfCYjiGoDwHJl/TkFzlMyB
         9MEml0AFytOfV1Lgt5hdCJutZ8++k5TYXi0IJZ/4HdP/lozs1veJhAOY/0735qlJij
         aqnGLTjoyt1a4wwRAGtuATv9fmZjo8fAp3DchDt6rLevVd86KID3BIZ6dixpLS50DN
         Rc9RuT3LpR8SQ==
Date:   Thu, 11 Nov 2021 16:12:50 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Sean V Kelley <sean.v.kelley@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Keith Busch <kbusch@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 5/8] PCI/portdrv: add mechanism to turn on subdev
 regulators
Message-ID: <20211111221250.GA1353701@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110221456.11977-6-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Capitalize "Add" in subject.

On Wed, Nov 10, 2021 at 05:14:45PM -0500, Jim Quinlan wrote:
> Adds a mechanism inside the root port device to identify standard PCIe
> regulators in the DT, allocate them, and turn them on before the rest of
> the bus is scanned during pci_host_probe().  A root complex driver can
> leverage this mechanism by setting the pci_ops methods add_bus and
> remove_bus to pci_subdev_regulators_{add,remove}_bus.

s/Adds a/Add a/

> The allocated structure that contains the regulators is stored in
> dev.driver_data.
> 
> The unabridged reason for doing this is as follows.  We would like the
> Broadcom STB PCIe root complex driver (and others) to be able to turn
> off/on regulators[1] that provide power to endpoint[2] devices.  Typically,
> the drivers of these endpoint devices are stock Linux drivers that are not
> aware that these regulator(s) exist and must be turned on for the driver to
> be probed.  The simple solution of course is to turn these regulators on at
> boot and keep them on.  However, this solution does not satisfy at least
> three of our usage modes:
> 
> 1. For example, one customer uses multiple PCIe controllers, but wants the
> ability to, by script invoking and unbind, turn any or all of them by and
> their subdevices off to save power, e.g. when in battery mode.
> 
> 2. Another example is when a watchdog script discovers that an endpoint
> device is in an unresponsive state and would like to unbind, power toggle,
> and re-bind just the PCIe endpoint and controller.
> 
> 3. Of course we also want power turned off during suspend mode.  However,
> some endpoint devices may be able to "wake" during suspend and we need to
> recognise this case and veto the nominal act of turning off its regulator.
> Such is the case with Wake-on-LAN and Wake-on-WLAN support where PCIe
> end-point device needs to be kept powered on in order to receive network
> packets and wake-up the system.
> 
> In all of these cases it is advantageous for the PCIe controller to govern
> the turning off/on the regulators needed by the endpoint device.  The first
> two cases can be done by simply unbinding and binding the PCIe controller,
> if the controller has control of these regulators.
> 
> [1] These regulators typically govern the actual power supply to the
>     endpoint chip.  Sometimes they may be a the official PCIe socket
>     power -- such as 3.3v or aux-3.3v.  Sometimes they are truly
>     the regulator(s) that supply power to the EP chip.

s/may be a the/may be the/

> [2] The 99% configuration of our boards is a single endpoint device
>     attached to the PCIe controller.  I use the term endpoint but it could
>     possible mean a switch as well.

s/possible/possibly/

This adds generic code, so it needs some connection to the generic DT
binding for these things, e.g., a commit in this series that adds it
(I see commits that touch brcm,stb-pcie.yaml, but not a generic
place).

> +static void *alloc_subdev_regulators(struct device *dev)
> +{
> +	static const char * const supplies[] = {
> +		"vpcie3v3",
> +		"vpcie3v3aux",
> +		"vpcie12v",
> +	};
> +	const size_t size = sizeof(struct subdev_regulators)
> +		+ sizeof(struct regulator_bulk_data) * ARRAY_SIZE(supplies);
> +	struct subdev_regulators *sr;
> +	int i;
> +
> +	sr = devm_kzalloc(dev, size, GFP_KERNEL);
> +
> +	if (sr) {
> +		sr->num_supplies = ARRAY_SIZE(supplies);
> +		for (i = 0; i < ARRAY_SIZE(supplies); i++)
> +			sr->supplies[i].supply = supplies[i];
> +	}
> +
> +	return sr;
> +}
> +
> +

Spurious blank line.

> +int pci_subdev_regulators_add_bus(struct pci_bus *bus)
> ...

> @@ -131,6 +155,13 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
>  	if (status)
>  		return status;
>  
> +	if (dev->bus->ops &&
> +	    dev->bus->ops->add_bus &&
> +	    dev->bus->dev.driver_data) {
> +		pcie_portdriver.resume = subdev_regulator_resume;
> +		pcie_portdriver.suspend = subdev_regulator_suspend;

The pci_driver.resume() and pci_driver.suspend() methods are going
away, so we shouldn't add new uses like this.

Doesn't this trigger the warning in pci_has_legacy_pm_support() about
supporting both legacy PM and the new PM?

Bjorn

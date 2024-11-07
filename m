Return-Path: <linux-pci+bounces-16283-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B2A9C0FC8
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 21:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79E131F23AB4
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 20:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35A51D5CCF;
	Thu,  7 Nov 2024 20:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RT0L2w+7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5DE195FE8;
	Thu,  7 Nov 2024 20:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731011574; cv=none; b=F9X7dswfkbFu+cnE5USsnOmdDJzPB2XENMMVTK8WFsNbKt9swVm7lus1r5/bZ089zbTAG/rzoZWSa46EXKUAKc/1cfIyDjIY/aBDnRkufFJpLGAgWaLwW1vropUFFdHYmWs/i0QoQ9mLQ5hfWyVDL5c0w4YcMD4c9fhuM/4gl2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731011574; c=relaxed/simple;
	bh=/VKLG9ZssjgBYteVEXpiKEX9bT8mHEulWP8vHOPAros=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=s9znKoU3R5OZ5/xbN603NVxxpteGvO1hh6mCHYpr8xensxeIQeh6Dy1qzl21FnbpSsZM/2/pqKgoJQZJB4InaSIiRYYMAj3Sx3bevnS5BRqjI+cn9FYAq1BmFXgo2jtHRtqXctGsnm9Mov3S3JCOTTCZouMQxV+gPx9O5mzEduU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RT0L2w+7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08282C4CECE;
	Thu,  7 Nov 2024 20:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731011574;
	bh=/VKLG9ZssjgBYteVEXpiKEX9bT8mHEulWP8vHOPAros=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=RT0L2w+74MzSa7cQYf3SjO9jw1bMU3KWpwW05vTQJ1urJp3p6oyeNpGWiMu3wqaQ9
	 SV4g/kV0uwTtavhfWS2vhatdmzibnLwG+z+Ccw8Z2exnPJDKSQv08kIVKTq7erovG+
	 Y4zG9FJvVlKlHAQPoAxWzAfZViE//xCHB2UsfM4HMgd6X/ig1KxjrForHl3AhBO5i7
	 t4ZuTIB71M9xJBuXWiPAEBOOam5Ue3pMl0cPdHGTbk/5v6yJZxi2uwsXTZI/m6FhrC
	 gC5UvR7WX35HW2zChA96ZG0yHBB92I6UccE+ifKWWzVDtt+S9nT4UQB3BIz2gWOawi
	 PwqNVuI3nACbA==
Date: Thu, 7 Nov 2024 14:32:52 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shijith Thotton <sthotton@marvell.com>
Cc: bhelgaas@google.com, ilpo.jarvinen@linux.intel.com,
	Jonathan.Cameron@huawei.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, rafael@kernel.org,
	scott@os.amperecomputing.com, jerinj@marvell.com,
	schalla@marvell.com, vattunuru@marvell.com
Subject: Re: [PATCH v3] PCI: hotplug: Add OCTEON PCI hotplug controller driver
Message-ID: <20241107203252.GA1623581@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826104531.1232136-1-sthotton@marvell.com>

On Mon, Aug 26, 2024 at 04:15:03PM +0530, Shijith Thotton wrote:
> This patch introduces a PCI hotplug controller driver for the OCTEON
> PCIe device, a multi-function PCIe device where the first function acts
> as a hotplug controller. It is equipped with MSI-x interrupts to notify
> the host of hotplug events from the OCTEON firmware.

s/MSI-x/MSI-X/ to match spec and other uses

> The driver facilitates the hotplugging of non-controller functions
> within the same device. During probe, non-controller functions are
> removed and registered as PCI hotplug slots. The slots are added back
> only upon request from the device firmware. The driver also allows the
> enabling and disabling of the slots via sysfs slot entries, provided by
> the PCI hotplug framework.
> 
> Signed-off-by: Shijith Thotton <sthotton@marvell.com>
> Co-developed-by: Vamsi Attunuru <vattunuru@marvell.com>
> Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>

This order is incorrect because the handler (Shijith in this case)
should be last in the chain; see
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v6.11#n396

> This patch introduces a PCI hotplug controller driver for OCTEON PCIe hotplug
> controller. The OCTEON PCIe device is a multi-function device where the first
> function acts as a PCI hotplug controller.
> 
>               +--------------------------------+
>               |           Root Port            |
>               +--------------------------------+
>                               |
>                              PCIe
>                               |
> +---------------------------------------------------------------+
> |              OCTEON PCIe Multifunction Device                 |
> +---------------------------------------------------------------+
>             |                    |              |            |
>             |                    |              |            |
> +---------------------+  +----------------+  +-----+  +----------------+
> |      Function 0     |  |   Function 1   |  | ... |  |   Function 7   |
> | (Hotplug controller)|  | (Hotplug slot) |  |     |  | (Hotplug slot) |
> +---------------------+  +----------------+  +-----+  +----------------+
>             |
>             |
> +-------------------------+
> |   Controller Firmware   |
> +-------------------------+
> 
> The hotplug controller driver facilitates the hotplugging of non-controller
> functions in the same device. During the probe of the driver, the non-controller
> function are removed and registered as PCI hotplug slots. They are added back
> only upon request from the device firmware. The driver also allows the user to
> enable/disable the functions using sysfs slot entries provided by PCI hotplug
> framework.

I think the diagram and this text would be useful in the commit log.

I would rephrase "functions are removed ..." as "the driver removes
functions" to make it clear that this is purely a software thing and
there's no PCIe-level change.  Similar for adding them back.

> This solution adopts a hardware + software approach for several reasons:
> 
> 1. To reduce hardware implementation cost. Supporting complete hotplug
>    capability within the card would require a PCI switch implemented within.
> 
> 2. In the multi-function device, non-controller functions can act as emulated
>    devices. The firmware can dynamically enable or disable them at runtime.
> 
> 3. Not all root ports support PCI hotplug. This approach provides greater
>    flexibility and compatibility across different hardware configurations.

The downside of all this is the need for special-purpose software,
which slows things down (you need to develop it, others need to review
it) and burdens everybody with ongoing maintenance, e.g., changes to
PCI device removal, resource assignment, slot registration, etc. now
have to consider another case.

> The hotplug controller function is lightweight and is equipped with MSI-x
> interrupts to notify the host about hotplug events. Upon receiving an
> interrupt, the hotplug register is read, and the required function is enabled
> or disabled.
> 
> This driver will be beneficial for managing PCI hotplug events on the OCTEON
> PCIe device without requiring complex hardware solutions.

> +config HOTPLUG_PCI_OCTEONEP
> +	bool "OCTEON PCI device Hotplug controller driver"

s/Marvell PCI device/Cavium OCTEON PCI/ to match other entries.

This Kconfig file isn't completely sorted, but if you move this above
SHPC, it will at least be closer.

> +static int octep_hp_pci_probe(struct pci_dev *pdev,
> +			      const struct pci_device_id *id)
> +{
> +	struct octep_hp_controller *hp_ctrl;
> +	struct pci_dev *tmp_pdev = NULL;
> +	struct octep_hp_slot *hp_slot;
> +	u16 slot_number = 0;
> +	int ret;
> +
> +	hp_ctrl = devm_kzalloc(&pdev->dev, sizeof(*hp_ctrl), GFP_KERNEL);
> +	if (!hp_ctrl)
> +		return -ENOMEM;
> +
> +	ret = octep_hp_controller_setup(pdev, hp_ctrl);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Register all hotplug slots. Hotplug controller is the first function
> +	 * of the PCI device. The hotplug slots are the remaining functions of
> +	 * the PCI device. They are removed from the bus and are added back when
> +	 * the hotplug event is triggered.

"Logically removed," I guess?  Obviously the PCIe Link remains up
since function 0 is still alive, and I assume these other functions
would still respond to config accesses.

> +	 */
> +	for_each_pci_dev(tmp_pdev) {

Ugh.  We should avoid for_each_pci_dev() when possible.

IIUC you only care about other functions of *this* device, and those
functions should all be on the bus->devices list.  There are many
instances of this, which I think would be sufficient:

  list_for_each_entry(dev, &bus->devices, bus_list)

> +		if (!octep_hp_is_slot(hp_ctrl, tmp_pdev))
> +			continue;

Which would make this check mostly unnecessary.

> +		hp_slot = octep_hp_register_slot(hp_ctrl, tmp_pdev, slot_number);
> +		if (IS_ERR(hp_slot))
> +			return dev_err_probe(&pdev->dev, PTR_ERR(hp_slot),
> +					     "Failed to register hotplug slot %u\n",
> +					     slot_number);
> +
> +		ret = devm_add_action(&pdev->dev, octep_hp_deregister_slot,
> +				      hp_slot);
> +		if (ret)
> +			return dev_err_probe(&pdev->dev, ret,
> +					     "Failed to add action for deregistering slot %u\n",
> +					     slot_number);
> +		slot_number++;
> +	}

AFAICS this driver logs nothing at all in dmesg (except for errors and
a few dev_dbg() uses).  Seems like it might be useful to have some
hints there about the hotplug controller existence, possibly the
connection between the slot name used in sysfs and the PCI function,
and maybe even hot-add and hot-remove events.

> +	return 0;
> +}
> +
> +#define OCTEP_DEVID_HP_CONTROLLER 0xa0e3

Even though this is a private #define, I think something like
PCI_DEVICE_ID_CAVIUM_OCTEP_HP_CTLR would be nice because that's the
typical pattern of include/linux/pci_ids.h.

> +static struct pci_device_id octep_hp_pci_map[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, OCTEP_DEVID_HP_CONTROLLER) },
> +	{ },
> +};


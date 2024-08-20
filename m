Return-Path: <linux-pci+bounces-11901-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24289958C9B
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 18:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F353728135C
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 16:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686141AD9D9;
	Tue, 20 Aug 2024 16:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UMGFOOjr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C7F7E59A;
	Tue, 20 Aug 2024 16:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724172769; cv=none; b=YrhEP5RGwfMY48TUB5zaHZk/AEHmbDJutopX3TRiBhUHqubcy6v5gSDQkvZBSRJeuGy9eBcDs7MlU1Vrw2vtV8r7krGmxCIqMytSSYEYbRDHEtbIkgc9SroNyUL3mYIVvLJN4M7aigjQtgLtwmpXHNAVPllp7guJtyT/TqBWAh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724172769; c=relaxed/simple;
	bh=NlYNuj77RW4xi3kBphLwoCz3PVZ/TF0jGAboZbdM4T8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BsMzLdwjwG6/C5uBWmEt9aJl1rIyI2fzZtG+SDpbvyTvz33pbUUbg7mde5wLXj2l/nrOSA/RNbub7ja/03TT1DDmsjK5nq+Mickrgtx+wWth5HXUYlwhZNgRfYh+dyXeI0v+HE8q8wcJwEKvPePdB+SsOYbfY7KB0qNRX+Fzpaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UMGFOOjr; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724172768; x=1755708768;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=NlYNuj77RW4xi3kBphLwoCz3PVZ/TF0jGAboZbdM4T8=;
  b=UMGFOOjrdyJp/9I62W5iIhct/iQzjEKu5jN1QGZIqVk1dHQL0gQ9ohKG
   7yco1SBRHhh5G2wh0K3fQt2sA+ffpurkjd3phwPFKTieyu0oyQZ3mfXXa
   WIuJMkGk2UPlfHTVn+a3wa+biP3O8KeDB+qHjGrmo6Z4ajkJrm/Hp2I1q
   v5WH0azxOXgg2LzF9Q4IsPQKwyhw6DQlGWCxYdGefn7A6aDSDQ0gwPDiP
   IGu6/DnZKTmrBPy35fFcC8VQoZsSO53HNBVh2VDOl6MCArLJqEy+ciyrd
   zZRvRUb+6WfaYzI30lS3Jh3OhguFwqcj7JGi2NOJtdAx1rB2q0NTxrnQk
   w==;
X-CSE-ConnectionGUID: ahLQn+mLRpWaL2ar7wXtDg==
X-CSE-MsgGUID: cLpQQl2KR5yhYTIOxWgzzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="22637561"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="22637561"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 09:52:47 -0700
X-CSE-ConnectionGUID: l6W+vooGRTyFvORgPw9iRg==
X-CSE-MsgGUID: Nh8kro5tSTKj50Bg7dMRjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="65134665"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.102])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 09:52:43 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 20 Aug 2024 19:52:39 +0300 (EEST)
To: Shijith Thotton <sthotton@marvell.com>
cc: bhelgaas@google.com, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, jerinj@marvell.com, 
    schalla@marvell.com, vattunuru@marvell.com, 
    "Rafael J. Wysocki" <rafael@kernel.org>, 
    D Scott Phillips <scott@os.amperecomputing.com>
Subject: Re: [PATCH] PCI: hotplug: Add OCTEON PCI hotplug controller driver
In-Reply-To: <20240820152734.642533-1-sthotton@marvell.com>
Message-ID: <d4a5ad63-cb4e-a725-a7dd-3ac52fff25fb@linux.intel.com>
References: <20240820152734.642533-1-sthotton@marvell.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 20 Aug 2024, Shijith Thotton wrote:

> This patch introduces a PCI hotplug controller driver for the OCTEON
> PCIe device, a multi-function PCIe device where the first function acts
> as a hotplug controller. It is equipped with MSI-x interrupts to notify
> the host of hotplug events from the OCTEON firmware.
> 
> The driver facilitates the hotplugging of non-controller functions
> within the same device. During probe, non-controller functions are
> removed and registered as PCI hotplug slots. The slots are added back
> only upon request from the device firmware. The driver also allows the
> enabling and disabling of the slots via sysfs slot entries, provided by
> the PCI hotplug framework.
> 
> Signed-off-by: Shijith Thotton <sthotton@marvell.com>
> Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
> ---
> 
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
> 
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
> 
> The hotplug controller function is lightweight and is equipped with MSI-x
> interrupts to notify the host about hotplug events. Upon receiving an
> interrupt, the hotplug register is read, and the required function is enabled
> or disabled.
> 
> This driver will be beneficial for managing PCI hotplug events on the OCTEON
> PCIe device without requiring complex hardware solutions.
> 
>  MAINTAINERS                    |   6 +
>  drivers/pci/hotplug/Kconfig    |  10 +
>  drivers/pci/hotplug/Makefile   |   1 +
>  drivers/pci/hotplug/octep_hp.c | 351 +++++++++++++++++++++++++++++++++
>  4 files changed, 368 insertions(+)
>  create mode 100644 drivers/pci/hotplug/octep_hp.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 42decde38320..7b5a618eed1c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13677,6 +13677,12 @@ R:	schalla@marvell.com
>  R:	vattunuru@marvell.com
>  F:	drivers/vdpa/octeon_ep/
>  
> +MARVELL OCTEON HOTPLUG CONTROLLER DRIVER
> +R:	Shijith Thotton <sthotton@marvell.com>
> +R:	Vamsi Attunuru <vattunuru@marvell.com>
> +S:	Supported
> +F:	drivers/pci/hotplug/octep_hp.c
> +
>  MATROX FRAMEBUFFER DRIVER
>  L:	linux-fbdev@vger.kernel.org
>  S:	Orphan
> diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
> index 1472aef0fb81..2e38fd25f7ef 100644
> --- a/drivers/pci/hotplug/Kconfig
> +++ b/drivers/pci/hotplug/Kconfig
> @@ -173,4 +173,14 @@ config HOTPLUG_PCI_S390
>  
>  	  When in doubt, say Y.
>  
> +config HOTPLUG_PCI_OCTEONEP
> +	bool "OCTEON PCI device Hotplug controller driver"
> +	depends on HOTPLUG_PCI
> +	help
> +	  Say Y here if you have an OCTEON PCIe device with a hotplug
> +	  controller. This driver enables the non-controller functions of the
> +	  device to be registered as hotplug slots.
> +
> +	  When in doubt, say N.
> +
>  endif # HOTPLUG_PCI
> diff --git a/drivers/pci/hotplug/Makefile b/drivers/pci/hotplug/Makefile
> index 240c99517d5e..40aaf31fe338 100644
> --- a/drivers/pci/hotplug/Makefile
> +++ b/drivers/pci/hotplug/Makefile
> @@ -20,6 +20,7 @@ obj-$(CONFIG_HOTPLUG_PCI_RPA)		+= rpaphp.o
>  obj-$(CONFIG_HOTPLUG_PCI_RPA_DLPAR)	+= rpadlpar_io.o
>  obj-$(CONFIG_HOTPLUG_PCI_ACPI)		+= acpiphp.o
>  obj-$(CONFIG_HOTPLUG_PCI_S390)		+= s390_pci_hpc.o
> +obj-$(CONFIG_HOTPLUG_PCI_OCTEONEP)	+= octep_hp.o
>  
>  # acpiphp_ibm extends acpiphp, so should be linked afterwards.
>  
> diff --git a/drivers/pci/hotplug/octep_hp.c b/drivers/pci/hotplug/octep_hp.c
> new file mode 100644
> index 000000000000..efeb542d4993
> --- /dev/null
> +++ b/drivers/pci/hotplug/octep_hp.c
> @@ -0,0 +1,351 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (C) 2024 Marvell. */
> +
> +#include <linux/delay.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/pci_hotplug.h>
> +#include <linux/slab.h>
> +
> +#define OCTEP_HP_INTR_OFFSET(x) (0x20400 + ((x) << 4))
> +#define OCTEP_HP_INTR_VECTOR(x) (16 + (x))
> +#define OCTEP_HP_DRV_NAME       "octep_hp"
> +
> +/* Interrupt vectors for hotplug enable and disable events. */
> +enum octep_hp_vec_type {
> +	OCTEP_HP_VEC_ENA,
> +	OCTEP_HP_VEC_DIS,

If I understand your code right, these cannot be arbitrary numbers but has 
to be specific numbers to match the vector number so you should explicitly 
set them to those values.

> +};
> +
> +struct octep_hp_cmd {
> +	struct list_head list;

Missing include for list_head.

> +	enum octep_hp_vec_type vec_type;
> +	u64 slot_mask;
> +};
> +
> +struct octep_hp_slot {
> +	struct list_head list;
> +	struct hotplug_slot slot;
> +	u16 slot_number;
> +	struct pci_dev *hp_pdev;
> +	unsigned int hp_devfn;
> +	struct octep_hp_controller *ctrl;
> +};
> +
> +struct octep_hp_controller {
> +	void __iomem *base;
> +	struct pci_dev *pdev;
> +	struct work_struct work;

Missing include.

> +	struct list_head slot_list;
> +	struct mutex slot_lock; /* Protects slot_list */

Missing include.

> +	struct list_head hp_cmd_list;
> +	spinlock_t hp_cmd_lock; /* Protects hp_cmd_list */
> +};
> +
> +static void octep_hp_enable_pdev(struct octep_hp_controller *hp_ctrl, struct octep_hp_slot *hp_slot)
> +{
> +	mutex_lock(&hp_ctrl->slot_lock);

Use guard().

> +	if (hp_slot->hp_pdev) {
> +		dev_dbg(&hp_slot->hp_pdev->dev, "Slot %u already enabled\n", hp_slot->slot_number);
> +		mutex_unlock(&hp_ctrl->slot_lock);
> +		return;
> +	}
> +
> +	/* Scan the device and add it to the bus */
> +	hp_slot->hp_pdev = pci_scan_single_device(hp_ctrl->pdev->bus, hp_slot->hp_devfn);
> +	pci_bus_assign_resources(hp_ctrl->pdev->bus);
> +	pci_bus_add_device(hp_slot->hp_pdev);
> +
> +	dev_dbg(&hp_slot->hp_pdev->dev, "Enabled slot %u\n", hp_slot->slot_number);

Missing include for dev_dbg().

> +	mutex_unlock(&hp_ctrl->slot_lock);
> +}
> +
> +static void octep_hp_disable_pdev(struct octep_hp_controller *hp_ctrl,
> +				  struct octep_hp_slot *hp_slot)
> +{
> +	mutex_lock(&hp_ctrl->slot_lock);

Use guard().

> +	if (!hp_slot->hp_pdev) {
> +		dev_dbg(&hp_ctrl->pdev->dev, "Slot %u already disabled\n", hp_slot->slot_number);
> +		mutex_unlock(&hp_ctrl->slot_lock);
> +		return;
> +	}
> +
> +	dev_dbg(&hp_slot->hp_pdev->dev, "Disabling slot %u\n", hp_slot->slot_number);
> +
> +	/* Remove the device from the bus */
> +	pci_stop_and_remove_bus_device_locked(hp_slot->hp_pdev);
> +	hp_slot->hp_pdev = NULL;
> +	mutex_unlock(&hp_ctrl->slot_lock);
> +}
> +
> +static int octep_hp_enable_slot(struct hotplug_slot *slot)
> +{
> +	struct octep_hp_slot *hp_slot = container_of(slot, struct octep_hp_slot, slot);

Missing include for container_of().

> +
> +	octep_hp_enable_pdev(hp_slot->ctrl, hp_slot);
> +	return 0;
> +}
> +
> +static int octep_hp_disable_slot(struct hotplug_slot *slot)
> +{
> +	struct octep_hp_slot *hp_slot = container_of(slot, struct octep_hp_slot, slot);
> +
> +	octep_hp_disable_pdev(hp_slot->ctrl, hp_slot);
> +	return 0;
> +}
> +
> +static struct hotplug_slot_ops octep_hp_slot_ops = {
> +	.enable_slot = octep_hp_enable_slot,
> +	.disable_slot = octep_hp_disable_slot,
> +};
> +
> +#define SLOT_NAME_SIZE 16
> +static int octep_hp_register_slot(struct octep_hp_controller *hp_ctrl, struct pci_dev *pdev,
> +				  u16 slot_number)
> +{
> +	char slot_name[SLOT_NAME_SIZE];
> +	struct octep_hp_slot *hp_slot;
> +	int ret;
> +
> +	hp_slot = kzalloc(sizeof(*hp_slot), GFP_KERNEL);
> +	if (!hp_slot)
> +		return -ENOMEM;
> +
> +	hp_slot->ctrl = hp_ctrl;
> +	hp_slot->hp_pdev = pdev;
> +	hp_slot->hp_devfn = pdev->devfn;
> +	hp_slot->slot_number = slot_number;
> +	hp_slot->slot.ops = &octep_hp_slot_ops;
> +
> +	snprintf(slot_name, SLOT_NAME_SIZE, "octep_hp_%u", slot_number);

SLOT_NAME_SIZE -> sizeof(slot_name)

> +	ret = pci_hp_register(&hp_slot->slot, hp_ctrl->pdev->bus, PCI_SLOT(pdev->devfn), slot_name);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to register hotplug slot %u\n", slot_number);
> +		kfree(hp_slot);
> +		return ret;
> +	}
> +
> +	octep_hp_disable_pdev(hp_ctrl, hp_slot);
> +	list_add_tail(&hp_slot->list, &hp_ctrl->slot_list);
> +
> +	return 0;
> +}
> +
> +static bool octep_hp_slot(struct octep_hp_controller *hp_ctrl, struct pci_dev *pdev)
> +{
> +	/* Check if the PCI device can be hotplugged */
> +	return pdev != hp_ctrl->pdev && pdev->bus == hp_ctrl->pdev->bus &&
> +		PCI_SLOT(pdev->devfn) == PCI_SLOT(hp_ctrl->pdev->devfn);
> +}
> +
> +static void octep_hp_cmd_handler(struct octep_hp_controller *hp_ctrl, struct octep_hp_cmd *hp_cmd)
> +{
> +	struct octep_hp_slot *hp_slot;
> +
> +	/* Enable or disable the slots based on the slot mask */
> +	list_for_each_entry(hp_slot, &hp_ctrl->slot_list, list) {
> +		if (hp_cmd->slot_mask & BIT(hp_slot->slot_number)) {

Reverse logic & use continue ?

> +			if (hp_cmd->vec_type == OCTEP_HP_VEC_ENA)
> +				octep_hp_enable_pdev(hp_ctrl, hp_slot);
> +			else
> +				octep_hp_disable_pdev(hp_ctrl, hp_slot);
> +		}
> +	}
> +}
> +
> +static void octep_hp_work_handler(struct work_struct *work)
> +{
> +	struct octep_hp_controller *hp_ctrl = container_of(work, struct octep_hp_controller, work);
> +	struct octep_hp_cmd *hp_cmd;
> +	unsigned long flags;
> +
> +	/* Process all the hotplug commands */
> +	spin_lock_irqsave(&hp_ctrl->hp_cmd_lock, flags);
> +	while (!list_empty(&hp_ctrl->hp_cmd_list)) {
> +		hp_cmd = list_first_entry(&hp_ctrl->hp_cmd_list, struct octep_hp_cmd, list);
> +		list_del(&hp_cmd->list);
> +		spin_unlock_irqrestore(&hp_ctrl->hp_cmd_lock, flags);
> +
> +		octep_hp_cmd_handler(hp_ctrl, hp_cmd);
> +		kfree(hp_cmd);
> +
> +		spin_lock_irqsave(&hp_ctrl->hp_cmd_lock, flags);
> +	}
> +	spin_unlock_irqrestore(&hp_ctrl->hp_cmd_lock, flags);
> +}
> +
> +static irqreturn_t octep_hp_intr_handler(int irq, void *data)
> +{
> +	struct octep_hp_controller *hp_ctrl = data;
> +	struct pci_dev *pdev = hp_ctrl->pdev;
> +	enum octep_hp_vec_type vec_type;
> +	struct octep_hp_cmd *hp_cmd;
> +	u64 slot_mask;
> +
> +	vec_type = pci_irq_vector(pdev, OCTEP_HP_INTR_VECTOR(OCTEP_HP_VEC_ENA)) == irq ?
> +		OCTEP_HP_VEC_ENA : OCTEP_HP_VEC_DIS;

This is a bit unusual and complicated to do all this in one statement. But 
can't you just store that ena irq number into struct octep_hp_controller 
so you don't need to make the call here every time?

> +	slot_mask = readq(hp_ctrl->base + OCTEP_HP_INTR_OFFSET(vec_type));
> +	if (!slot_mask) {
> +		dev_err(&pdev->dev, "Invalid slot mask %llx\n", slot_mask);
> +		return IRQ_HANDLED;
> +	}
> +
> +	hp_cmd = kzalloc(sizeof(*hp_cmd), GFP_ATOMIC);
> +	if (!hp_cmd)
> +		return IRQ_HANDLED;
> +
> +	hp_cmd->slot_mask = slot_mask;
> +	hp_cmd->vec_type = vec_type;
> +
> +	/* Add the command to the list and schedule the work */
> +	spin_lock(&hp_ctrl->hp_cmd_lock);
> +	list_add_tail(&hp_cmd->list, &hp_ctrl->hp_cmd_list);
> +	spin_unlock(&hp_ctrl->hp_cmd_lock);
> +	schedule_work(&hp_ctrl->work);
> +
> +	/* Clear the interrupt */
> +	writeq(slot_mask, hp_ctrl->base + OCTEP_HP_INTR_OFFSET(vec_type));
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void octep_hp_deregister_slots(struct octep_hp_controller *hp_ctrl)
> +{
> +	struct octep_hp_slot *hp_slot, *tmp;
> +
> +	/* Deregister all the hotplug slots */
> +	list_for_each_entry_safe(hp_slot, tmp, &hp_ctrl->slot_list, list) {
> +		pci_hp_deregister(&hp_slot->slot);
> +		octep_hp_enable_pdev(hp_ctrl, hp_slot);
> +		list_del(&hp_slot->list);
> +		kfree(hp_slot);
> +	}
> +}
> +
> +static void octep_hp_controller_cleanup(void *data)
> +{
> +	struct octep_hp_controller *hp_ctrl = data;
> +
> +	pci_free_irq_vectors(hp_ctrl->pdev);
> +	flush_work(&hp_ctrl->work);
> +	octep_hp_deregister_slots(hp_ctrl);
> +}
> +
> +static int octep_hp_controller_setup(struct pci_dev *pdev, struct octep_hp_controller *hp_ctrl)
> +{
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	ret = pcim_enable_device(pdev);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable PCI device\n");
> +		return ret;
> +	}
> +
> +	ret = pcim_iomap_regions(pdev, BIT(0), OCTEP_HP_DRV_NAME);
> +	if (ret) {
> +		dev_err(dev, "Failed to request MMIO region\n");
> +		return ret;
> +	}
> +
> +	pci_set_master(pdev);
> +	pci_set_drvdata(pdev, hp_ctrl);
> +
> +	INIT_LIST_HEAD(&hp_ctrl->slot_list);
> +	INIT_LIST_HEAD(&hp_ctrl->hp_cmd_list);
> +	mutex_init(&hp_ctrl->slot_lock);
> +	spin_lock_init(&hp_ctrl->hp_cmd_lock);
> +	INIT_WORK(&hp_ctrl->work, octep_hp_work_handler);
> +
> +	hp_ctrl->pdev = pdev;
> +	hp_ctrl->base = pcim_iomap_table(pdev)[0];
> +	if (!hp_ctrl->base) {
> +		dev_err(dev, "Failed to get device resource map\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = pci_alloc_irq_vectors(pdev, 1, OCTEP_HP_INTR_VECTOR(OCTEP_HP_VEC_DIS) + 1,
> +				    PCI_IRQ_MSIX);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to alloc MSI-X vectors");
> +		return ret;
> +	}
> +
> +	ret = devm_add_action(dev, octep_hp_controller_cleanup, hp_ctrl);
> +	if (ret) {
> +		dev_err(dev, "Failed to add action for controller cleanup\n");
> +		return ret;
> +	}
> +
> +	ret = devm_request_irq(dev, pci_irq_vector(pdev, OCTEP_HP_INTR_VECTOR(OCTEP_HP_VEC_ENA)),
> +			       octep_hp_intr_handler, 0, "octep_hp_ena", hp_ctrl);
> +	if (ret) {
> +		dev_err(dev, "Failed to register slot enable interrupt handle\n");
> +		return ret;
> +	}
> +
> +	ret = devm_request_irq(dev, pci_irq_vector(pdev, OCTEP_HP_INTR_VECTOR(OCTEP_HP_VEC_DIS)),
> +			       octep_hp_intr_handler, 0, "octep_hp_dis", hp_ctrl);
> +	if (ret) {
> +		dev_err(dev, "Failed to register slot disable interrupt handle\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int octep_hp_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +{
> +	struct octep_hp_controller *hp_ctrl;
> +	struct pci_dev *tmp_pdev = NULL;
> +	u16 slot_number = 0;
> +	int ret;
> +
> +	hp_ctrl = devm_kzalloc(&pdev->dev, sizeof(*hp_ctrl), GFP_KERNEL);
> +	if (!hp_ctrl)
> +		return -ENOMEM;
> +
> +	ret = octep_hp_controller_setup(pdev, hp_ctrl);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to setup octep controller\n");

So both octep_hp_controller_setup() and this function print an error? 
Wouldn't the one from octep_hp_controller_setup() suffice?

-- 
 i.

> +		return ret;
> +	}
> +
> +	/*
> +	 * Register all hotplug slots. Hotplug controller is the first function of the PCI device.
> +	 * The hotplug slots are the remaining functions of the PCI device. They are removed from
> +	 * the bus and are added back when the hotplug event is triggered.

Reflow the comment to 80 chars.

> +	 */
> +	for_each_pci_dev(tmp_pdev) {
> +		if (octep_hp_slot(hp_ctrl, tmp_pdev)) {

Reverse logic & use continue.

> +			ret = octep_hp_register_slot(hp_ctrl, tmp_pdev, slot_number++);
> +			if (ret) {
> +				dev_err(&pdev->dev, "Failed to register hotplug slots.\n");
> +				return ret;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +#define OCTEP_DEVID_HP_CONTROLLER 0xa0e3
> +static struct pci_device_id octep_hp_pci_map[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, OCTEP_DEVID_HP_CONTROLLER) },
> +	{ 0 },
> +};
> +
> +static struct pci_driver octep_hp = {
> +	.name     = OCTEP_HP_DRV_NAME,
> +	.id_table = octep_hp_pci_map,
> +	.probe    = octep_hp_pci_probe,
> +};
> +
> +module_pci_driver(octep_hp);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Marvell");
> +MODULE_DESCRIPTION("OCTEON PCIe device hotplug controller driver");
> 


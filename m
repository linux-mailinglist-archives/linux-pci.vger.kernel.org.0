Return-Path: <linux-pci+bounces-11943-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD142959A85
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 13:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66EE428164C
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 11:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B181B2515;
	Wed, 21 Aug 2024 11:24:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082F1192D81;
	Wed, 21 Aug 2024 11:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724239457; cv=none; b=sPb3RiHWCmTPxDULpRlIsAEI3cpYtXbq5y7XHa2qxgNzZxb5+hVEzzq4EAaROWCP1GLNcCCbAiuND6EEnttQCMtAjbe3Nxet93xJUIn9j5czOLp3luNIGNfG9MCuppyOUFEJ2ULFgHRKhTre/ZPkvw4UlkXRumuSbDWAvVfFDN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724239457; c=relaxed/simple;
	bh=Vv5b6IR/Y6okpE2hQ0fTrckCYoKzUxTTe+QktVKVSQ4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ea1nSGxFNHZRL6+bCh1zX6R5A0uyqJPRHUkOgyi9rRgUs+Y3cL157bYxGzeuZWMiPdNxHeu6U/c0k9ZqbSOdLxg7j+RfApZTMlb0Wi5AlzX5QsxIp+IGZXFsugMRSxa3iUdhYQGn/6gorVHdDLxvjXN/Ld6UruX1oOgcCaz5S5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WpkRP38Ttz6D8XR;
	Wed, 21 Aug 2024 19:21:05 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 42D35140A36;
	Wed, 21 Aug 2024 19:24:11 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 21 Aug
 2024 12:24:05 +0100
Date: Wed, 21 Aug 2024 12:24:04 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Shijith Thotton <sthotton@marvell.com>
CC: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jerinj@marvell.com>, <schalla@marvell.com>,
	<vattunuru@marvell.com>, "Rafael J. Wysocki" <rafael@kernel.org>, D Scott
 Phillips <scott@os.amperecomputing.com>, Philipp Stanner
	<pstanner@redhat.com>
Subject: Re: [PATCH] PCI: hotplug: Add OCTEON PCI hotplug controller driver
Message-ID: <20240821122404.00001a71@Huawei.com>
In-Reply-To: <20240820152734.642533-1-sthotton@marvell.com>
References: <20240820152734.642533-1-sthotton@marvell.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 20 Aug 2024 20:57:20 +0530
Shijith Thotton <sthotton@marvell.com> wrote:

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
I was curious, so drive by review.

What was Vamsi's involvement?  Given Shijith sent this
I'd guess co developer?  In which Co-developed-by tag
should be used.

Various random comments on things inline.

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


> diff --git a/drivers/pci/hotplug/octep_hp.c b/drivers/pci/hotplug/octep_hp.c
> new file mode 100644
> index 000000000000..efeb542d4993
> --- /dev/null
> +++ b/drivers/pci/hotplug/octep_hp.c
> @@ -0,0 +1,351 @@

> +struct octep_hp_controller {
> +	void __iomem *base;
> +	struct pci_dev *pdev;
> +	struct work_struct work;
> +	struct list_head slot_list;
> +	struct mutex slot_lock; /* Protects slot_list */
> +	struct list_head hp_cmd_list;
> +	spinlock_t hp_cmd_lock; /* Protects hp_cmd_list */
> +};

> +static void octep_hp_disable_pdev(struct octep_hp_controller *hp_ctrl,
> +				  struct octep_hp_slot *hp_slot)
> +{
> +	mutex_lock(&hp_ctrl->slot_lock);

guard(mutex)(&hp_ctrl->slot_lock);

Same for other simple cases where we can avoid explicit unlock in error paths
+ main path.


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
> +	ret = pci_hp_register(&hp_slot->slot, hp_ctrl->pdev->bus, PCI_SLOT(pdev->devfn), slot_name);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to register hotplug slot %u\n", slot_number);
> +		kfree(hp_slot);
> +		return ret;
		return dev_err_probe() in here as well.

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

Line break as that's getting long for little reason.

> +{
> +	struct octep_hp_slot *hp_slot;
> +
> +	/* Enable or disable the slots based on the slot mask */
> +	list_for_each_entry(hp_slot, &hp_ctrl->slot_list, list) {
> +		if (hp_cmd->slot_mask & BIT(hp_slot->slot_number)) {
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

Add a line break.

> +	struct octep_hp_cmd *hp_cmd;
> +	unsigned long flags;

...

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

As below, maybe just register cleanup for one slot at a time.
That will need a bit of magic to get form the slot to the hp_ctrl though.

Plus point is simpler logic to follow.


> +	}
> +}
> +
> +static void octep_hp_controller_cleanup(void *data)
> +{
> +	struct octep_hp_controller *hp_ctrl = data;
> +
> +	pci_free_irq_vectors(hp_ctrl->pdev);
> +	flush_work(&hp_ctrl->work);
I'd prefer to see this broken up so we have
simple steps.
1. Add action 1 in probe.
2. Add cleanup for action 1 in probe
3. Add action 2 in probe etc.

Otherwise it can be a bit tricky to review.

> +	octep_hp_deregister_slots(hp_ctrl);

This is particular is no where near the place where the
slots are registered.
May be better to register one cleanup function call
per slot as then it will also be nice and simple to follow.


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
Only called from probe, so
		return dev_err_probe()

> +		return ret;
> +	}
> +
> +	ret = pcim_iomap_regions(pdev, BIT(0), OCTEP_HP_DRV_NAME);
Given there is a patch on list deprecating this, reconsider.
https://lore.kernel.org/all/20240807083018.8734-2-pstanner@redhat.com/
+CC Philipp


> +	if (ret) {
> +		dev_err(dev, "Failed to request MMIO region\n");
> +		return ret;

Same thing on return dev_err_probe here and later.

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
> +		return ret;
return dev_err_probe()
actually no. Drop it. There are more informative error prints for all the
conditions. We probably don't care that the end result is this specific
function fails (more than an irq request failed etc).


> +	}
> +
> +	/*
> +	 * Register all hotplug slots. Hotplug controller is the first function of the PCI device.
> +	 * The hotplug slots are the remaining functions of the PCI device. They are removed from
> +	 * the bus and are added back when the hotplug event is triggered.
> +	 */
> +	for_each_pci_dev(tmp_pdev) {
> +		if (octep_hp_slot(hp_ctrl, tmp_pdev)) {
What IIpo said on this.  No one likes deep indent ;)
> +			ret = octep_hp_register_slot(hp_ctrl, tmp_pdev, slot_number++);
> +			if (ret) {
> +				dev_err(&pdev->dev, "Failed to register hotplug slots.\n");
> +				return ret;

return dev_err_probe();

Cleaner in general even if no chance of deferral.



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

{ }
Is sufficient. I can't remember if that's common style in PCI or not though.

> +};



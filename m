Return-Path: <linux-pci+bounces-12197-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F154795EF1D
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 12:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22CB11C21358
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 10:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEA7157A6C;
	Mon, 26 Aug 2024 10:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="YDjO5HGK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6341553A1;
	Mon, 26 Aug 2024 10:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724669715; cv=none; b=UIZ5BjYBm0b2mnPjxGXSLOqtxIsus9aP7dzeR/EL/iLAY14tiYVB57UKQXx6B/dyfN9fEtk4Opu75Svk7Odl14bFuzoF/Mpx9/BEfCjWHlxqqO2n7MuGmzQ/vFITeRz9QL/MxYLto5USwHzEiqZN3mpzt+WzpUpq/Gh04UZSQLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724669715; c=relaxed/simple;
	bh=yJ0fSzD5hEXDdWCWCfIUtYJ0J+CwyRQ8L5w3w0iNSSk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PSnZ0qusk901qPW4iOCn3Rx61AQZ3XRJUZtiiSGIOx0vj7/dZcTg0iBpYYqCB/cixmsNZmBpg/FSlYmJ1ED38Hp8K+vsue3keKg1QQHEOA5JM7tDbw60uATn4sk9NzWi8C0d+ms7LqJOL6NIZARVFfkTGKOJc9npPOBjFOYRWJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=YDjO5HGK; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47Q9uEgI006183;
	Mon, 26 Aug 2024 03:54:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=z
	eDzsoGqdTRe2LCUE8TzcQLBhehwsfMocQHpNgOopcA=; b=YDjO5HGKp5gYofjXe
	XOf4yXLXpGsfC7c3kviKl4jaRreqQRGwXNYrT5/83haOoqZBU5Jt+hFuahj7O8d6
	6SQvx6DIPnyh6z5jXURD27vNrWaVF6d5gPe5x+v4gWJVO0Q2SzF3jPlxOK4LeyKl
	NHRwLcZ2BRp7vxPVrcK0HjHk7qXG1y/DLKiShmbPlIIYvy+LRc/lMt7OPXpKNHgq
	jfcOvKNApP4grHciBSuk26wY7kURi0jT65c1I53Q7D3u46+70SsWOo3ngSpUMp+5
	wt+Fa/U7ypLq9XhMeyuMxiaPYc9JA4iQ3VtsTeH3ApK677wGgPmoIzb7Y31CWEiJ
	sZ5qA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 418qgw84vu-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Aug 2024 03:54:42 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 26 Aug 2024 03:46:30 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 26 Aug 2024 03:46:30 -0700
Received: from localhost.localdomain (unknown [10.28.34.29])
	by maili.marvell.com (Postfix) with ESMTP id 834B73F70A0;
	Mon, 26 Aug 2024 03:46:26 -0700 (PDT)
From: Shijith Thotton <sthotton@marvell.com>
To: <bhelgaas@google.com>
CC: Shijith Thotton <sthotton@marvell.com>, <ilpo.jarvinen@linux.intel.com>,
        <Jonathan.Cameron@Huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <rafael@kernel.org>,
        <scott@os.amperecomputing.com>, <jerinj@marvell.com>,
        <schalla@marvell.com>, <vattunuru@marvell.com>
Subject: [PATCH v3] PCI: hotplug: Add OCTEON PCI hotplug controller driver
Date: Mon, 26 Aug 2024 16:15:03 +0530
Message-ID: <20240826104531.1232136-1-sthotton@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240823052251.1087505-1-sthotton@marvell.com>
References: <20240823052251.1087505-1-sthotton@marvell.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: q1Qf59mqh8Qn0ANnyzFbVyVOu9MdwhY4
X-Proofpoint-ORIG-GUID: q1Qf59mqh8Qn0ANnyzFbVyVOu9MdwhY4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-26_08,2024-08-23_01,2024-05-17_01

This patch introduces a PCI hotplug controller driver for the OCTEON
PCIe device, a multi-function PCIe device where the first function acts
as a hotplug controller. It is equipped with MSI-x interrupts to notify
the host of hotplug events from the OCTEON firmware.

The driver facilitates the hotplugging of non-controller functions
within the same device. During probe, non-controller functions are
removed and registered as PCI hotplug slots. The slots are added back
only upon request from the device firmware. The driver also allows the
enabling and disabling of the slots via sysfs slot entries, provided by
the PCI hotplug framework.

Signed-off-by: Shijith Thotton <sthotton@marvell.com>
Co-developed-by: Vamsi Attunuru <vattunuru@marvell.com>
Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
---

This patch introduces a PCI hotplug controller driver for OCTEON PCIe hotplug
controller. The OCTEON PCIe device is a multi-function device where the first
function acts as a PCI hotplug controller.

              +--------------------------------+
              |           Root Port            |
              +--------------------------------+
                              |
                             PCIe
                              |
+---------------------------------------------------------------+
|              OCTEON PCIe Multifunction Device                 |
+---------------------------------------------------------------+
            |                    |              |            |
            |                    |              |            |
+---------------------+  +----------------+  +-----+  +----------------+
|      Function 0     |  |   Function 1   |  | ... |  |   Function 7   |
| (Hotplug controller)|  | (Hotplug slot) |  |     |  | (Hotplug slot) |
+---------------------+  +----------------+  +-----+  +----------------+
            |
            |
+-------------------------+
|   Controller Firmware   |
+-------------------------+

The hotplug controller driver facilitates the hotplugging of non-controller
functions in the same device. During the probe of the driver, the non-controller
function are removed and registered as PCI hotplug slots. They are added back
only upon request from the device firmware. The driver also allows the user to
enable/disable the functions using sysfs slot entries provided by PCI hotplug
framework.

This solution adopts a hardware + software approach for several reasons:

1. To reduce hardware implementation cost. Supporting complete hotplug
   capability within the card would require a PCI switch implemented within.

2. In the multi-function device, non-controller functions can act as emulated
   devices. The firmware can dynamically enable or disable them at runtime.

3. Not all root ports support PCI hotplug. This approach provides greater
   flexibility and compatibility across different hardware configurations.

The hotplug controller function is lightweight and is equipped with MSI-x
interrupts to notify the host about hotplug events. Upon receiving an
interrupt, the hotplug register is read, and the required function is enabled
or disabled.

This driver will be beneficial for managing PCI hotplug events on the OCTEON
PCIe device without requiring complex hardware solutions.

Changes in v2:
- Added missing include files.
- Used dev_err_probe() for error handling.
- Used guard() for mutex locking.
- Splited cleanup actions and added per-slot cleanup action.
- Fixed coding style issues.
- Added co-developed-by tag.

Changes in v3:
- Explicit assignment of enum values.
- Use pcim_iomap_region() instead of pcim_iomap_regions().

 MAINTAINERS                    |   6 +
 drivers/pci/hotplug/Kconfig    |  10 +
 drivers/pci/hotplug/Makefile   |   1 +
 drivers/pci/hotplug/octep_hp.c | 409 +++++++++++++++++++++++++++++++++
 4 files changed, 426 insertions(+)
 create mode 100644 drivers/pci/hotplug/octep_hp.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 42decde38320..7b5a618eed1c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13677,6 +13677,12 @@ R:	schalla@marvell.com
 R:	vattunuru@marvell.com
 F:	drivers/vdpa/octeon_ep/
 
+MARVELL OCTEON HOTPLUG CONTROLLER DRIVER
+R:	Shijith Thotton <sthotton@marvell.com>
+R:	Vamsi Attunuru <vattunuru@marvell.com>
+S:	Supported
+F:	drivers/pci/hotplug/octep_hp.c
+
 MATROX FRAMEBUFFER DRIVER
 L:	linux-fbdev@vger.kernel.org
 S:	Orphan
diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
index 1472aef0fb81..2e38fd25f7ef 100644
--- a/drivers/pci/hotplug/Kconfig
+++ b/drivers/pci/hotplug/Kconfig
@@ -173,4 +173,14 @@ config HOTPLUG_PCI_S390
 
 	  When in doubt, say Y.
 
+config HOTPLUG_PCI_OCTEONEP
+	bool "OCTEON PCI device Hotplug controller driver"
+	depends on HOTPLUG_PCI
+	help
+	  Say Y here if you have an OCTEON PCIe device with a hotplug
+	  controller. This driver enables the non-controller functions of the
+	  device to be registered as hotplug slots.
+
+	  When in doubt, say N.
+
 endif # HOTPLUG_PCI
diff --git a/drivers/pci/hotplug/Makefile b/drivers/pci/hotplug/Makefile
index 240c99517d5e..40aaf31fe338 100644
--- a/drivers/pci/hotplug/Makefile
+++ b/drivers/pci/hotplug/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_HOTPLUG_PCI_RPA)		+= rpaphp.o
 obj-$(CONFIG_HOTPLUG_PCI_RPA_DLPAR)	+= rpadlpar_io.o
 obj-$(CONFIG_HOTPLUG_PCI_ACPI)		+= acpiphp.o
 obj-$(CONFIG_HOTPLUG_PCI_S390)		+= s390_pci_hpc.o
+obj-$(CONFIG_HOTPLUG_PCI_OCTEONEP)	+= octep_hp.o
 
 # acpiphp_ibm extends acpiphp, so should be linked afterwards.
 
diff --git a/drivers/pci/hotplug/octep_hp.c b/drivers/pci/hotplug/octep_hp.c
new file mode 100644
index 000000000000..77dc2740f43e
--- /dev/null
+++ b/drivers/pci/hotplug/octep_hp.c
@@ -0,0 +1,409 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2024 Marvell. */
+
+#include <linux/cleanup.h>
+#include <linux/container_of.h>
+#include <linux/delay.h>
+#include <linux/dev_printk.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pci.h>
+#include <linux/pci_hotplug.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/workqueue.h>
+
+#define OCTEP_HP_INTR_OFFSET(x) (0x20400 + ((x) << 4))
+#define OCTEP_HP_INTR_VECTOR(x) (16 + (x))
+#define OCTEP_HP_DRV_NAME "octep_hp"
+
+/*
+ * Type of MSI-X interrupts.
+ * The macros OCTEP_HP_INTR_VECTOR and OCTEP_HP_INTR_OFFSET are used to
+ * generate the vector and offset for an interrupt type.
+ */
+enum octep_hp_intr_type {
+	OCTEP_HP_INTR_INVALID = -1,
+	OCTEP_HP_INTR_ENA = 0,
+	OCTEP_HP_INTR_DIS = 1,
+	OCTEP_HP_INTR_MAX = 2,
+};
+
+struct octep_hp_cmd {
+	struct list_head list;
+	enum octep_hp_intr_type intr_type;
+	u64 intr_val;
+};
+
+struct octep_hp_slot {
+	struct list_head list;
+	struct hotplug_slot slot;
+	u16 slot_number;
+	struct pci_dev *hp_pdev;
+	unsigned int hp_devfn;
+	struct octep_hp_controller *ctrl;
+};
+
+struct octep_hp_intr_info {
+	enum octep_hp_intr_type type;
+	int number;
+	char name[16];
+};
+
+struct octep_hp_controller {
+	void __iomem *base;
+	struct pci_dev *pdev;
+	struct octep_hp_intr_info intr[OCTEP_HP_INTR_MAX];
+	struct work_struct work;
+	struct list_head slot_list;
+	struct mutex slot_lock; /* Protects slot_list */
+	struct list_head hp_cmd_list;
+	spinlock_t hp_cmd_lock; /* Protects hp_cmd_list */
+};
+
+static void octep_hp_enable_pdev(struct octep_hp_controller *hp_ctrl,
+				 struct octep_hp_slot *hp_slot)
+{
+	guard(mutex)(&hp_ctrl->slot_lock);
+	if (hp_slot->hp_pdev) {
+		dev_dbg(&hp_slot->hp_pdev->dev, "Slot %u already enabled\n",
+			hp_slot->slot_number);
+		return;
+	}
+
+	/* Scan the device and add it to the bus */
+	hp_slot->hp_pdev = pci_scan_single_device(hp_ctrl->pdev->bus,
+						  hp_slot->hp_devfn);
+	pci_bus_assign_resources(hp_ctrl->pdev->bus);
+	pci_bus_add_device(hp_slot->hp_pdev);
+
+	dev_dbg(&hp_slot->hp_pdev->dev, "Enabled slot %u\n",
+		hp_slot->slot_number);
+}
+
+static void octep_hp_disable_pdev(struct octep_hp_controller *hp_ctrl,
+				  struct octep_hp_slot *hp_slot)
+{
+	guard(mutex)(&hp_ctrl->slot_lock);
+	if (!hp_slot->hp_pdev) {
+		dev_dbg(&hp_ctrl->pdev->dev, "Slot %u already disabled\n",
+			hp_slot->slot_number);
+		return;
+	}
+
+	dev_dbg(&hp_slot->hp_pdev->dev, "Disabling slot %u\n",
+		hp_slot->slot_number);
+
+	/* Remove the device from the bus */
+	pci_stop_and_remove_bus_device_locked(hp_slot->hp_pdev);
+	hp_slot->hp_pdev = NULL;
+}
+
+static int octep_hp_enable_slot(struct hotplug_slot *slot)
+{
+	struct octep_hp_slot *hp_slot =
+		container_of(slot, struct octep_hp_slot, slot);
+
+	octep_hp_enable_pdev(hp_slot->ctrl, hp_slot);
+	return 0;
+}
+
+static int octep_hp_disable_slot(struct hotplug_slot *slot)
+{
+	struct octep_hp_slot *hp_slot =
+		container_of(slot, struct octep_hp_slot, slot);
+
+	octep_hp_disable_pdev(hp_slot->ctrl, hp_slot);
+	return 0;
+}
+
+static struct hotplug_slot_ops octep_hp_slot_ops = {
+	.enable_slot = octep_hp_enable_slot,
+	.disable_slot = octep_hp_disable_slot,
+};
+
+#define SLOT_NAME_SIZE 16
+static struct octep_hp_slot *
+octep_hp_register_slot(struct octep_hp_controller *hp_ctrl,
+		       struct pci_dev *pdev, u16 slot_number)
+{
+	char slot_name[SLOT_NAME_SIZE];
+	struct octep_hp_slot *hp_slot;
+	int ret;
+
+	hp_slot = kzalloc(sizeof(*hp_slot), GFP_KERNEL);
+	if (!hp_slot)
+		return ERR_PTR(-ENOMEM);
+
+	hp_slot->ctrl = hp_ctrl;
+	hp_slot->hp_pdev = pdev;
+	hp_slot->hp_devfn = pdev->devfn;
+	hp_slot->slot_number = slot_number;
+	hp_slot->slot.ops = &octep_hp_slot_ops;
+
+	snprintf(slot_name, sizeof(slot_name), "octep_hp_%u", slot_number);
+	ret = pci_hp_register(&hp_slot->slot, hp_ctrl->pdev->bus,
+			      PCI_SLOT(pdev->devfn), slot_name);
+	if (ret) {
+		kfree(hp_slot);
+		return ERR_PTR(ret);
+	}
+
+	list_add_tail(&hp_slot->list, &hp_ctrl->slot_list);
+	octep_hp_disable_pdev(hp_ctrl, hp_slot);
+
+	return hp_slot;
+}
+
+static void octep_hp_deregister_slot(void *data)
+{
+	struct octep_hp_slot *hp_slot = data;
+	struct octep_hp_controller *hp_ctrl = hp_slot->ctrl;
+
+	pci_hp_deregister(&hp_slot->slot);
+	octep_hp_enable_pdev(hp_ctrl, hp_slot);
+	list_del(&hp_slot->list);
+	kfree(hp_slot);
+}
+
+static bool octep_hp_is_slot(struct octep_hp_controller *hp_ctrl,
+			     struct pci_dev *pdev)
+{
+	/* Check if the PCI device can be hotplugged */
+	return pdev != hp_ctrl->pdev && pdev->bus == hp_ctrl->pdev->bus &&
+	       PCI_SLOT(pdev->devfn) == PCI_SLOT(hp_ctrl->pdev->devfn);
+}
+
+static void octep_hp_cmd_handler(struct octep_hp_controller *hp_ctrl,
+				 struct octep_hp_cmd *hp_cmd)
+{
+	struct octep_hp_slot *hp_slot;
+
+	/*
+	 * Enable or disable the slots based on the slot mask.
+	 * intr_val is a bit mask where each bit represents a slot.
+	 */
+	list_for_each_entry(hp_slot, &hp_ctrl->slot_list, list) {
+		if (!(hp_cmd->intr_val & BIT(hp_slot->slot_number)))
+			continue;
+
+		if (hp_cmd->intr_type == OCTEP_HP_INTR_ENA)
+			octep_hp_enable_pdev(hp_ctrl, hp_slot);
+		else
+			octep_hp_disable_pdev(hp_ctrl, hp_slot);
+	}
+}
+
+static void octep_hp_work_handler(struct work_struct *work)
+{
+	struct octep_hp_controller *hp_ctrl;
+	struct octep_hp_cmd *hp_cmd;
+	unsigned long flags;
+
+	hp_ctrl = container_of(work, struct octep_hp_controller, work);
+
+	/* Process all the hotplug commands */
+	spin_lock_irqsave(&hp_ctrl->hp_cmd_lock, flags);
+	while (!list_empty(&hp_ctrl->hp_cmd_list)) {
+		hp_cmd = list_first_entry(&hp_ctrl->hp_cmd_list,
+					  struct octep_hp_cmd, list);
+		list_del(&hp_cmd->list);
+		spin_unlock_irqrestore(&hp_ctrl->hp_cmd_lock, flags);
+
+		octep_hp_cmd_handler(hp_ctrl, hp_cmd);
+		kfree(hp_cmd);
+
+		spin_lock_irqsave(&hp_ctrl->hp_cmd_lock, flags);
+	}
+	spin_unlock_irqrestore(&hp_ctrl->hp_cmd_lock, flags);
+}
+
+static enum octep_hp_intr_type octep_hp_intr_type(struct octep_hp_intr_info *intr,
+						  int irq)
+{
+	enum octep_hp_intr_type type;
+
+	for (type = OCTEP_HP_INTR_ENA; type < OCTEP_HP_INTR_MAX; type++) {
+		if (intr[type].number == irq)
+			return type;
+	}
+
+	return OCTEP_HP_INTR_INVALID;
+}
+
+static irqreturn_t octep_hp_intr_handler(int irq, void *data)
+{
+	struct octep_hp_controller *hp_ctrl = data;
+	struct pci_dev *pdev = hp_ctrl->pdev;
+	enum octep_hp_intr_type type;
+	struct octep_hp_cmd *hp_cmd;
+	u64 intr_val;
+
+	type = octep_hp_intr_type(hp_ctrl->intr, irq);
+	if (type == OCTEP_HP_INTR_INVALID) {
+		dev_err(&pdev->dev, "Invalid interrupt %d\n", irq);
+		return IRQ_HANDLED;
+	}
+
+	/* Read and clear the interrupt */
+	intr_val = readq(hp_ctrl->base + OCTEP_HP_INTR_OFFSET(type));
+	writeq(intr_val, hp_ctrl->base + OCTEP_HP_INTR_OFFSET(type));
+
+	hp_cmd = kzalloc(sizeof(*hp_cmd), GFP_ATOMIC);
+	if (!hp_cmd)
+		return IRQ_HANDLED;
+
+	hp_cmd->intr_val = intr_val;
+	hp_cmd->intr_type = type;
+
+	/* Add the command to the list and schedule the work */
+	spin_lock(&hp_ctrl->hp_cmd_lock);
+	list_add_tail(&hp_cmd->list, &hp_ctrl->hp_cmd_list);
+	spin_unlock(&hp_ctrl->hp_cmd_lock);
+	schedule_work(&hp_ctrl->work);
+
+	return IRQ_HANDLED;
+}
+
+static void octep_hp_irq_cleanup(void *data)
+{
+	struct octep_hp_controller *hp_ctrl = data;
+
+	pci_free_irq_vectors(hp_ctrl->pdev);
+	flush_work(&hp_ctrl->work);
+}
+
+static int octep_hp_request_irq(struct octep_hp_controller *hp_ctrl,
+				enum octep_hp_intr_type type)
+{
+	struct pci_dev *pdev = hp_ctrl->pdev;
+	struct octep_hp_intr_info *intr;
+	int irq;
+
+	irq = pci_irq_vector(pdev, OCTEP_HP_INTR_VECTOR(type));
+	if (irq < 0)
+		return irq;
+
+	intr = &hp_ctrl->intr[type];
+	intr->number = irq;
+	intr->type = type;
+	snprintf(intr->name, sizeof(intr->name), "octep_hp_%d", type);
+
+	return devm_request_irq(&pdev->dev, irq, octep_hp_intr_handler,
+				IRQF_SHARED, intr->name, hp_ctrl);
+}
+
+static int octep_hp_controller_setup(struct pci_dev *pdev,
+				     struct octep_hp_controller *hp_ctrl)
+{
+	struct device *dev = &pdev->dev;
+	enum octep_hp_intr_type type;
+	int ret;
+
+	ret = pcim_enable_device(pdev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable PCI device\n");
+
+	hp_ctrl->base = pcim_iomap_region(pdev, 0, OCTEP_HP_DRV_NAME);
+	if (IS_ERR(hp_ctrl->base))
+		return dev_err_probe(dev, PTR_ERR(hp_ctrl->base),
+				     "Failed to map PCI device region\n");
+
+	pci_set_master(pdev);
+	pci_set_drvdata(pdev, hp_ctrl);
+
+	INIT_LIST_HEAD(&hp_ctrl->slot_list);
+	INIT_LIST_HEAD(&hp_ctrl->hp_cmd_list);
+	mutex_init(&hp_ctrl->slot_lock);
+	spin_lock_init(&hp_ctrl->hp_cmd_lock);
+	INIT_WORK(&hp_ctrl->work, octep_hp_work_handler);
+	hp_ctrl->pdev = pdev;
+
+	ret = pci_alloc_irq_vectors(pdev, 1,
+				    OCTEP_HP_INTR_VECTOR(OCTEP_HP_INTR_MAX),
+				    PCI_IRQ_MSIX);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to alloc MSI-X vectors\n");
+
+	ret = devm_add_action(&pdev->dev, octep_hp_irq_cleanup, hp_ctrl);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Failed to add IRQ cleanup action\n");
+
+	for (type = OCTEP_HP_INTR_ENA; type < OCTEP_HP_INTR_MAX; type++) {
+		ret = octep_hp_request_irq(hp_ctrl, type);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to request IRQ for vector %d\n",
+					     OCTEP_HP_INTR_VECTOR(type));
+	}
+
+	return 0;
+}
+
+static int octep_hp_pci_probe(struct pci_dev *pdev,
+			      const struct pci_device_id *id)
+{
+	struct octep_hp_controller *hp_ctrl;
+	struct pci_dev *tmp_pdev = NULL;
+	struct octep_hp_slot *hp_slot;
+	u16 slot_number = 0;
+	int ret;
+
+	hp_ctrl = devm_kzalloc(&pdev->dev, sizeof(*hp_ctrl), GFP_KERNEL);
+	if (!hp_ctrl)
+		return -ENOMEM;
+
+	ret = octep_hp_controller_setup(pdev, hp_ctrl);
+	if (ret)
+		return ret;
+
+	/*
+	 * Register all hotplug slots. Hotplug controller is the first function
+	 * of the PCI device. The hotplug slots are the remaining functions of
+	 * the PCI device. They are removed from the bus and are added back when
+	 * the hotplug event is triggered.
+	 */
+	for_each_pci_dev(tmp_pdev) {
+		if (!octep_hp_is_slot(hp_ctrl, tmp_pdev))
+			continue;
+
+		hp_slot = octep_hp_register_slot(hp_ctrl, tmp_pdev, slot_number);
+		if (IS_ERR(hp_slot))
+			return dev_err_probe(&pdev->dev, PTR_ERR(hp_slot),
+					     "Failed to register hotplug slot %u\n",
+					     slot_number);
+
+		ret = devm_add_action(&pdev->dev, octep_hp_deregister_slot,
+				      hp_slot);
+		if (ret)
+			return dev_err_probe(&pdev->dev, ret,
+					     "Failed to add action for deregistering slot %u\n",
+					     slot_number);
+		slot_number++;
+	}
+
+	return 0;
+}
+
+#define OCTEP_DEVID_HP_CONTROLLER 0xa0e3
+static struct pci_device_id octep_hp_pci_map[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, OCTEP_DEVID_HP_CONTROLLER) },
+	{ },
+};
+
+static struct pci_driver octep_hp = {
+	.name = OCTEP_HP_DRV_NAME,
+	.id_table = octep_hp_pci_map,
+	.probe = octep_hp_pci_probe,
+};
+
+module_pci_driver(octep_hp);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Marvell");
+MODULE_DESCRIPTION("OCTEON PCIe device hotplug controller driver");
-- 
2.25.1



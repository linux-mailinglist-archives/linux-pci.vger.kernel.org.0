Return-Path: <linux-pci+bounces-16446-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D979C3FCA
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 14:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 750801C21923
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 13:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D648C153BF6;
	Mon, 11 Nov 2024 13:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="AsBoE7Zt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95301DA53;
	Mon, 11 Nov 2024 13:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731332852; cv=none; b=bLC+LbGv+oPRjqNIrNEOXKOz52PF+1RRkTH4OoEy7MfdDYxmwRGS66HrWpDtWDicFKKtbH0Ca5IJDuB/2hLwwubecmXzcW1AjMPfL3YHpgColDueh+icptcpI/xKKhKi8UkwoG6+EcWYorcQQ4FIkwJUsf6bCB1VM0+k/U9CxaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731332852; c=relaxed/simple;
	bh=L8QoZtTB7AbXEqQmAnLjc/IAFlAnVukuPHsW3t6rSFo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jX1Dvl0M67mMK1NNSVjqrvT4HjotoOZ0IuuJzOZmefpuewQeQW3q5oMsAepFIPYqTtQd4yMLYiBXOMziAKF42KnHPjHzd9LEnA3C6jEexDjixGFPGQ1R6xClYsXlGJoc7GXeNB8wU3WKR1+D9HYRMlLIGbJUWFtrK93jvDrd+xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=AsBoE7Zt; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AB9kHiB009743;
	Mon, 11 Nov 2024 05:47:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=x
	7l/vJ8mD4csTGHSm6d7bhvC4Kru/VCs6l8eQTP0tm0=; b=AsBoE7ZtuvVXWYSTH
	jEnsoc66ZmpD26NfEElGS2fzUXbH8Agq+WCXG1dwYsQTfK0k08PyQH7+PyT4lVmA
	j0WebC+v9Xr7/IGpT64JdtkC2RG57QCdPyPaqXvS5pHQp9YuI36iKzzLT/Oku6pU
	88ofmiUME7d/Q7n43y7/dtpMp/mrq7Q9fU1KmFaDQzMSOh1CPXGS6tjMxXtB6M6a
	HA9HvGsTVLSWjOcRYX9yjnK6I//ExLqZAD1hPvDK+6j9+rl3fK/ow1EIFyGSiBJW
	/3NINvL+miMEAGyFcZfbrzGdVwvd+brbXWR5gY0wqzsyHxTwdOHsYp1FIgnmASRO
	sblAg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42t84pjyyp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Nov 2024 05:47:10 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 11 Nov 2024 05:47:08 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 11 Nov 2024 05:47:08 -0800
Received: from localhost.localdomain (unknown [10.28.34.29])
	by maili.marvell.com (Postfix) with ESMTP id EBCC55B692C;
	Mon, 11 Nov 2024 05:47:04 -0800 (PST)
From: Shijith Thotton <sthotton@marvell.com>
To: <bhelgaas@google.com>
CC: Shijith Thotton <sthotton@marvell.com>, <ilpo.jarvinen@linux.intel.com>,
        <Jonathan.Cameron@Huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <rafael@kernel.org>,
        <scott@os.amperecomputing.com>, <jerinj@marvell.com>,
        <schalla@marvell.com>, <vattunuru@marvell.com>
Subject: [PATCH v4] PCI: hotplug: Add OCTEON PCI hotplug controller driver
Date: Mon, 11 Nov 2024 19:15:11 +0530
Message-ID: <20241111134523.2796699-1-sthotton@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240826104531.1232136-1-sthotton@marvell.com>
References: <20240826104531.1232136-1-sthotton@marvell.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 8kz9jCabhvDq93VBwQeMASQI1Fs0w7D9
X-Proofpoint-GUID: 8kz9jCabhvDq93VBwQeMASQI1Fs0w7D9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

This patch introduces a PCI hotplug controller driver for the OCTEON
PCIe device. The OCTEON PCIe device is a multi-function device where the
first function serves as the PCI hotplug controller.

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

The hotplug controller driver enables hotplugging of non-controller
functions within the same device. During probing, the driver removes
the non-controller functions and registers them as PCI hotplug slots.
These slots are added back by the driver, only upon request from the
device firmware.

The controller uses MSI-X interrupts to notify the host of hotplug
events initiated by the OCTEON firmware. Additionally, the driver
allows users to enable or disable individual functions via sysfs slot
entries, as provided by the PCI hotplug framework.

Co-developed-by: Vamsi Attunuru <vattunuru@marvell.com>
Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
Signed-off-by: Shijith Thotton <sthotton@marvell.com>
---
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

Changes in v4:
- Updated the commit message.
- Improved wordings and added new log messages.
- Modified device ID define to match namespace.
- Avoided use of for_each_pci_dev().

 MAINTAINERS                    |   6 +
 drivers/pci/hotplug/Kconfig    |  10 +
 drivers/pci/hotplug/Makefile   |   1 +
 drivers/pci/hotplug/octep_hp.c | 427 +++++++++++++++++++++++++++++++++
 4 files changed, 444 insertions(+)
 create mode 100644 drivers/pci/hotplug/octep_hp.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 42decde38320..2258f1459440 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13677,6 +13677,12 @@ R:	schalla@marvell.com
 R:	vattunuru@marvell.com
 F:	drivers/vdpa/octeon_ep/
 
+MARVELL OCTEON HOTPLUG DRIVER
+R:	Shijith Thotton <sthotton@marvell.com>
+R:	Vamsi Attunuru <vattunuru@marvell.com>
+S:	Supported
+F:	drivers/pci/hotplug/octep_hp.c
+
 MATROX FRAMEBUFFER DRIVER
 L:	linux-fbdev@vger.kernel.org
 S:	Orphan
diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
index 1472aef0fb81..123c4c7c2ab5 100644
--- a/drivers/pci/hotplug/Kconfig
+++ b/drivers/pci/hotplug/Kconfig
@@ -118,6 +118,16 @@ config HOTPLUG_PCI_CPCI_GENERIC
 
 	  When in doubt, say N.
 
+config HOTPLUG_PCI_OCTEONEP
+	bool "Marvell OCTEON PCI Hotplug driver"
+	depends on HOTPLUG_PCI
+	help
+	  Say Y here if you have an OCTEON PCIe device with a hotplug
+	  controller. This driver enables the non-controller functions of the
+	  device to be registered as hotplug slots.
+
+	  When in doubt, say N.
+
 config HOTPLUG_PCI_SHPC
 	bool "SHPC PCI Hotplug driver"
 	help
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
index 000000000000..d2475feb44cc
--- /dev/null
+++ b/drivers/pci/hotplug/octep_hp.c
@@ -0,0 +1,427 @@
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
+		dev_dbg(&hp_slot->hp_pdev->dev, "Slot %s is already enabled\n",
+			hotplug_slot_name(&hp_slot->slot));
+		return;
+	}
+
+	/* Scan the device and add it to the bus */
+	hp_slot->hp_pdev = pci_scan_single_device(hp_ctrl->pdev->bus,
+						  hp_slot->hp_devfn);
+	pci_bus_assign_resources(hp_ctrl->pdev->bus);
+	pci_bus_add_device(hp_slot->hp_pdev);
+
+	dev_dbg(&hp_slot->hp_pdev->dev, "Enabled slot %s\n",
+		hotplug_slot_name(&hp_slot->slot));
+}
+
+static void octep_hp_disable_pdev(struct octep_hp_controller *hp_ctrl,
+				  struct octep_hp_slot *hp_slot)
+{
+	guard(mutex)(&hp_ctrl->slot_lock);
+	if (!hp_slot->hp_pdev) {
+		dev_dbg(&hp_ctrl->pdev->dev, "Slot %s is already disabled\n",
+			hotplug_slot_name(&hp_slot->slot));
+		return;
+	}
+
+	dev_dbg(&hp_slot->hp_pdev->dev, "Disabling slot %s\n",
+		hotplug_slot_name(&hp_slot->slot));
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
+	dev_info(&pdev->dev, "Registered slot %s for device %s\n",
+		 slot_name, pci_name(pdev));
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
+static const char *octep_hp_cmd_name(enum octep_hp_intr_type type)
+{
+	switch (type) {
+	case OCTEP_HP_INTR_ENA:
+		return "hotplug enable";
+	case OCTEP_HP_INTR_DIS:
+		return "hotplug disable";
+	default:
+		return "invalid";
+	}
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
+		dev_info(&hp_ctrl->pdev->dev, "Received %s command for slot %s\n",
+			 octep_hp_cmd_name(hp_cmd->intr_type),
+			 hotplug_slot_name(&hp_slot->slot));
+
+		switch (hp_cmd->intr_type) {
+		case OCTEP_HP_INTR_ENA:
+			octep_hp_enable_pdev(hp_ctrl, hp_slot);
+			break;
+		case OCTEP_HP_INTR_DIS:
+			octep_hp_disable_pdev(hp_ctrl, hp_slot);
+			break;
+		default:
+			break;
+		}
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
+	struct pci_dev *tmp_pdev, *next;
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
+	 * the PCI device. The hotplug slot functions are logically removed from
+	 * the bus during probing and are re-enabled by the driver when a
+	 * hotplug event is received.
+	 */
+	list_for_each_entry_safe(tmp_pdev, next, &pdev->bus->devices, bus_list) {
+		if (tmp_pdev == pdev)
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
+#define PCI_DEVICE_ID_CAVIUM_OCTEP_HP_CTLR  0xa0e3
+static struct pci_device_id octep_hp_pci_map[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, PCI_DEVICE_ID_CAVIUM_OCTEP_HP_CTLR) },
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
+MODULE_DESCRIPTION("Marvell OCTEON PCI Hotplug driver");
-- 
2.25.1



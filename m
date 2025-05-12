Return-Path: <linux-pci+bounces-27578-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C97AB3796
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 14:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91845188EB10
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 12:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0901A3175;
	Mon, 12 May 2025 12:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WLSDAeyd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C439E2AE68;
	Mon, 12 May 2025 12:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747053978; cv=none; b=jblF6JnIJU8f+qhIpTsaJsLHsZiV3+lbr1WAVPuBv0/FCNtNopHdaml+9psNri45VLGREb8A4+LB+uMkPKJzZ2dhgGxg2im4AMl7rEQNVOhHRuEvRior1AFUQ+Xj6/SdKGyjIjUFxn+ymMVPsJ+tui87UCAzb6GJgfGBsQSjX28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747053978; c=relaxed/simple;
	bh=E1iWNMmhwafFciiVkky4XKB0WnNsyHslZ0eqwmUvx6g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=in/vNZ2mV8yj7eUJnMRvMBm8FI8tLLyMvN9Bp2R+S8hebuBqaN507kVg+7iGkl5eyUnjuU6U4FCarT1W9SX+3wOe0cqffznckZC8DxCSKb8XNFMnzP8EqfybixhSIIsUkAc03y6n8474KhN55vakUoh8jEOVy1YaovcCg8+gr+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WLSDAeyd; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747053973; x=1778589973;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=E1iWNMmhwafFciiVkky4XKB0WnNsyHslZ0eqwmUvx6g=;
  b=WLSDAeydhPPQv5j7UcQIVZjwPKrXa+oqOgHVGRlw5SlOx/mmkZcuyqhw
   wfHCKogmEFM8UXjQxlgHg96I2B/66uaW7siE9GbK0KYT7UEl0IiMOWzMZ
   Z+EJbNFmULSZYFPdsV6Pz7n45AEk7OWmBgkINSnNb4hUKCkVjAdxnKcbi
   PUxTgNjfvslMAgrmzLxmsL9vbJ0W3riJdHOOt10xwj+gr+j5+BXik4s23
   lttQEfmCyxV7Hp3GKWFza/NDy4xodoNaqooSVjxwsqZJjhW9um2VVqX+w
   C36VLt0ayPFdesoTcZ01TbnxSLvPcAYHsGr6P42Y1VDypsWG96AfP7NEm
   Q==;
X-CSE-ConnectionGUID: E/Nec0+jRAaXVZGSgykExQ==
X-CSE-MsgGUID: 4QPinEOcRN6IywutBZpuXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="49000037"
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; 
   d="scan'208";a="49000037"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 05:46:11 -0700
X-CSE-ConnectionGUID: XCXoMCpuQ9qYGpq1I7Giiw==
X-CSE-MsgGUID: 5jXL77l8TXyiGp6dljLrEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; 
   d="scan'208";a="138295246"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.245])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 05:46:06 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>,
	Shawn Anastasio <sanastasio@raptorengineering.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/1] PCI: pciehp: Consolidate code files
Date: Mon, 12 May 2025 15:45:28 +0300
Message-Id: <20250512124531.8937-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The code in the pciehp driver is a bit painful to read because of the
criss-cross calls that cross file boundaries making the split to
multiple files feel quite artificial.

Consolidate the code into single pciehp.c. The split files are not
simply merged as is but the functions are grouped based on
functionality and order that avoids most forward declarations.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

Based on top of pci/hotplug. Has a minor conflict with the LBMS reset
change in the pci/bwctrl branch.

The move is generated with a script to avoid copy-paste errors. It might
help review to check diff pre/post change with e.g. command like this
to see what truly was changed (after applying the patch):

 "diff -u <(git diff-tree -p HEAD | grep '^[-]' | cut -b 2- | rev | sort | rev) <(cat drivers/pci/hotplug/pciehp.c | rev | sort | rev)"

I've a few cleanup already on my TODO list wrt. this code but with the
merge window coming up, it seems better to just try to get the move
done now that it shouldn't have major conflicts and leave the cleanups
later.

 drivers/pci/hotplug/Makefile      |    5 -
 drivers/pci/hotplug/pciehp.c      | 2151 +++++++++++++++++++++++++++++
 drivers/pci/hotplug/pciehp.h      |  212 ---
 drivers/pci/hotplug/pciehp_core.c |  383 -----
 drivers/pci/hotplug/pciehp_ctrl.c |  445 ------
 drivers/pci/hotplug/pciehp_hpc.c  | 1123 ---------------
 drivers/pci/hotplug/pciehp_pci.c  |  141 --
 7 files changed, 2151 insertions(+), 2309 deletions(-)
 create mode 100644 drivers/pci/hotplug/pciehp.c
 delete mode 100644 drivers/pci/hotplug/pciehp.h
 delete mode 100644 drivers/pci/hotplug/pciehp_core.c
 delete mode 100644 drivers/pci/hotplug/pciehp_ctrl.c
 delete mode 100644 drivers/pci/hotplug/pciehp_hpc.c
 delete mode 100644 drivers/pci/hotplug/pciehp_pci.c

diff --git a/drivers/pci/hotplug/Makefile b/drivers/pci/hotplug/Makefile
index 40aaf31fe338..44735b82c0af 100644
--- a/drivers/pci/hotplug/Makefile
+++ b/drivers/pci/hotplug/Makefile
@@ -62,11 +62,6 @@ rpaphp-objs		:=	rpaphp_core.o	\
 rpadlpar_io-objs	:=	rpadlpar_core.o \
 				rpadlpar_sysfs.o
 
-pciehp-objs		:=	pciehp_core.o	\
-				pciehp_ctrl.o	\
-				pciehp_pci.o	\
-				pciehp_hpc.o
-
 shpchp-objs		:=	shpchp_core.o	\
 				shpchp_ctrl.o	\
 				shpchp_pci.o	\
diff --git a/drivers/pci/hotplug/pciehp.c b/drivers/pci/hotplug/pciehp.c
new file mode 100644
index 000000000000..d7d434cefae9
--- /dev/null
+++ b/drivers/pci/hotplug/pciehp.c
@@ -0,0 +1,2151 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * PCI Express Hot Plug Driver
+ *
+ * Copyright (C) 1995,2001 Compaq Computer Corporation
+ * Copyright (C) 2001 Greg Kroah-Hartman (greg@kroah.com)
+ * Copyright (C) 2001 IBM Corp.
+ * Copyright (C) 2003-2004 Intel Corporation
+ *
+ * All rights reserved.
+ */
+
+#define pr_fmt(fmt) "pciehp: " fmt
+#define dev_fmt pr_fmt
+
+#include <linux/bitfield.h>
+#include <linux/dmi.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/kthread.h>
+#include <linux/moduleparam.h>
+#include <linux/mutex.h>
+#include <linux/pci.h>
+#include <linux/pci_hotplug.h>
+#include <linux/pm_runtime.h>
+#include <linux/rwsem.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/workqueue.h>
+
+#include "../pcie/portdrv.h"
+#include "../pci.h"
+
+/*
+ * Set CONFIG_DYNAMIC_DEBUG=y and boot with 'dyndbg="file pciehp* +p"' to
+ * enable debug messages.
+ */
+#define ctrl_dbg(ctrl, format, arg...)					\
+	pci_dbg(ctrl->pcie->port, format, ## arg)
+#define ctrl_err(ctrl, format, arg...)					\
+	pci_err(ctrl->pcie->port, format, ## arg)
+#define ctrl_info(ctrl, format, arg...)					\
+	pci_info(ctrl->pcie->port, format, ## arg)
+#define ctrl_warn(ctrl, format, arg...)					\
+	pci_warn(ctrl->pcie->port, format, ## arg)
+
+#define SLOT_NAME_SIZE 10
+
+/**
+ * struct controller - PCIe hotplug controller
+ * @pcie: pointer to the controller's PCIe port service device
+ * @dsn: cached copy of Device Serial Number of Function 0 in the hotplug slot
+ *	(PCIe r6.2 sec 7.9.3); used to determine whether a hotplugged device
+ *	was replaced with a different one during system sleep
+ * @slot_cap: cached copy of the Slot Capabilities register
+ * @inband_presence_disabled: In-Band Presence Detect Disable supported by
+ *	controller and disabled per spec recommendation (PCIe r5.0, appendix I
+ *	implementation note)
+ * @slot_ctrl: cached copy of the Slot Control register
+ * @ctrl_lock: serializes writes to the Slot Control register
+ * @cmd_started: jiffies when the Slot Control register was last written;
+ *	the next write is allowed 1 second later, absent a Command Completed
+ *	interrupt (PCIe r4.0, sec 6.7.3.2)
+ * @cmd_busy: flag set on Slot Control register write, cleared by IRQ handler
+ *	on reception of a Command Completed event
+ * @queue: wait queue to wake up on reception of a Command Completed event,
+ *	used for synchronous writes to the Slot Control register
+ * @pending_events: used by the IRQ handler to save events retrieved from the
+ *	Slot Status register for later consumption by the IRQ thread
+ * @notification_enabled: whether the IRQ was requested successfully
+ * @power_fault_detected: whether a power fault was detected by the hardware
+ *	that has not yet been cleared by the user
+ * @poll_thread: thread to poll for slot events if no IRQ is available,
+ *	enabled with pciehp_poll_mode module parameter
+ * @state: current state machine position
+ * @state_lock: protects reads and writes of @state;
+ *	protects scheduling, execution and cancellation of @button_work
+ * @button_work: work item to turn the slot on or off after 5 seconds
+ *	in response to an Attention Button press
+ * @hotplug_slot: structure registered with the PCI hotplug core
+ * @reset_lock: prevents access to the Data Link Layer Link Active bit in the
+ *	Link Status register and to the Presence Detect State bit in the Slot
+ *	Status register during a slot reset which may cause them to flap
+ * @depth: Number of additional hotplug ports in the path to the root bus,
+ *	used as lock subclass for @reset_lock
+ * @ist_running: flag to keep user request waiting while IRQ thread is running
+ * @request_result: result of last user request submitted to the IRQ thread
+ * @requester: wait queue to wake up on completion of user request,
+ *	used for synchronous slot enable/disable request via sysfs
+ *
+ * PCIe hotplug has a 1:1 relationship between controller and slot, hence
+ * unlike other drivers, the two aren't represented by separate structures.
+ */
+struct controller {
+	struct pcie_device *pcie;
+	u64 dsn;
+
+	u32 slot_cap;				/* capabilities and quirks */
+	unsigned int inband_presence_disabled:1;
+
+	u16 slot_ctrl;				/* control register access */
+	struct mutex ctrl_lock;
+	unsigned long cmd_started;
+	unsigned int cmd_busy:1;
+	wait_queue_head_t queue;
+
+	atomic_t pending_events;		/* event handling */
+	unsigned int notification_enabled:1;
+	unsigned int power_fault_detected;
+	struct task_struct *poll_thread;
+
+	u8 state;				/* state machine */
+	struct mutex state_lock;
+	struct delayed_work button_work;
+
+	struct hotplug_slot hotplug_slot;	/* hotplug core interface */
+	struct rw_semaphore reset_lock;
+	unsigned int depth;
+	unsigned int ist_running;
+	int request_result;
+	wait_queue_head_t requester;
+};
+
+/**
+ * DOC: Slot state
+ *
+ * @OFF_STATE: slot is powered off, no subordinate devices are enumerated
+ * @BLINKINGON_STATE: slot will be powered on after the 5 second delay,
+ *	Power Indicator is blinking
+ * @BLINKINGOFF_STATE: slot will be powered off after the 5 second delay,
+ *	Power Indicator is blinking
+ * @POWERON_STATE: slot is currently powering on
+ * @POWEROFF_STATE: slot is currently powering off
+ * @ON_STATE: slot is powered on, subordinate devices have been enumerated
+ */
+#define OFF_STATE			0
+#define BLINKINGON_STATE		1
+#define BLINKINGOFF_STATE		2
+#define POWERON_STATE			3
+#define POWEROFF_STATE			4
+#define ON_STATE			5
+
+/**
+ * DOC: Flags to request an action from the IRQ thread
+ *
+ * These are stored together with events read from the Slot Status register,
+ * hence must be greater than its 16-bit width.
+ *
+ * %DISABLE_SLOT: Disable the slot in response to a user request via sysfs or
+ *	an Attention Button press after the 5 second delay
+ * %RERUN_ISR: Used by the IRQ handler to inform the IRQ thread that the
+ *	hotplug port was inaccessible when the interrupt occurred, requiring
+ *	that the IRQ handler is rerun by the IRQ thread after it has made the
+ *	hotplug port accessible by runtime resuming its parents to D0
+ */
+#define DISABLE_SLOT		(1 << 16)
+#define RERUN_ISR		(1 << 17)
+
+#define ATTN_BUTTN(ctrl)	((ctrl)->slot_cap & PCI_EXP_SLTCAP_ABP)
+#define POWER_CTRL(ctrl)	((ctrl)->slot_cap & PCI_EXP_SLTCAP_PCP)
+#define MRL_SENS(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_MRLSP)
+#define ATTN_LED(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_AIP)
+#define PWR_LED(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_PIP)
+#define NO_CMD_CMPL(ctrl)	((ctrl)->slot_cap & PCI_EXP_SLTCAP_NCCS)
+#define PSN(ctrl)		(((ctrl)->slot_cap & PCI_EXP_SLTCAP_PSN) >> 19)
+
+#define INDICATOR_NOOP -1	/* Leave indicator unchanged */
+
+#define FLAG(x, y)	(((x) & (y)) ? '+' : '-')
+
+#define SAFE_REMOVAL	 true
+#define SURPRISE_REMOVAL false
+
+static const struct dmi_system_id inband_presence_disabled_dmi_table[] = {
+	/*
+	 * Match all Dell systems, as some Dell systems have inband
+	 * presence disabled on NVMe slots (but don't support the bit to
+	 * report it). Setting inband presence disabled should have no
+	 * negative effect, except on broken hotplug slots that never
+	 * assert presence detect--and those will still work, they will
+	 * just have a bit of extra delay before being probed.
+	 */
+	{
+		.ident = "Dell System",
+		.matches = {
+			DMI_MATCH(DMI_OEM_STRING, "Dell System"),
+		},
+	},
+	{}
+};
+
+/* Global variables */
+static bool pciehp_poll_mode;
+static int pciehp_poll_time;
+
+/*
+ * not really modular, but the easiest way to keep compat with existing
+ * bootargs behaviour is to continue using module_param here.
+ */
+module_param(pciehp_poll_mode, bool, 0644);
+module_param(pciehp_poll_time, int, 0644);
+MODULE_PARM_DESC(pciehp_poll_mode, "Using polling mechanism for hot-plug events or not");
+MODULE_PARM_DESC(pciehp_poll_time, "Polling mechanism frequency, in seconds");
+
+static inline const char *slot_name(struct controller *ctrl)
+{
+	return hotplug_slot_name(&ctrl->hotplug_slot);
+}
+
+static inline struct controller *to_ctrl(struct hotplug_slot *hotplug_slot)
+{
+	return container_of(hotplug_slot, struct controller, hotplug_slot);
+}
+
+static inline struct pci_dev *ctrl_dev(struct controller *ctrl)
+{
+	return ctrl->pcie->port;
+}
+
+static inline void dbg_ctrl(struct controller *ctrl)
+{
+	struct pci_dev *pdev = ctrl->pcie->port;
+	u16 reg16;
+
+	ctrl_dbg(ctrl, "Slot Capabilities      : 0x%08x\n", ctrl->slot_cap);
+	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &reg16);
+	ctrl_dbg(ctrl, "Slot Status            : 0x%04x\n", reg16);
+	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &reg16);
+	ctrl_dbg(ctrl, "Slot Control           : 0x%04x\n", reg16);
+}
+
+static inline int pcie_hotplug_depth(struct pci_dev *dev)
+{
+	struct pci_bus *bus = dev->bus;
+	int depth = 0;
+
+	while (bus->parent) {
+		bus = bus->parent;
+		if (bus->self && bus->self->is_hotplug_bridge)
+			depth++;
+	}
+
+	return depth;
+}
+
+/**
+ * pciehp_configure_device() - enumerate PCI devices below a hotplug bridge
+ * @ctrl: PCIe hotplug controller
+ *
+ * Enumerate PCI devices below a hotplug bridge and add them to the system.
+ * Return 0 on success, %-EEXIST if the devices are already enumerated or
+ * %-ENODEV if enumeration failed.
+ */
+static int pciehp_configure_device(struct controller *ctrl)
+{
+	struct pci_dev *dev;
+	struct pci_dev *bridge = ctrl->pcie->port;
+	struct pci_bus *parent = bridge->subordinate;
+	int num, ret = 0;
+
+	pci_lock_rescan_remove();
+
+	dev = pci_get_slot(parent, PCI_DEVFN(0, 0));
+	if (dev) {
+		/*
+		 * The device is already there. Either configured by the
+		 * boot firmware or a previous hotplug event.
+		 */
+		ctrl_dbg(ctrl, "Device %s already exists at %04x:%02x:00, skipping hot-add\n",
+			 pci_name(dev), pci_domain_nr(parent), parent->number);
+		pci_dev_put(dev);
+		ret = -EEXIST;
+		goto out;
+	}
+
+	num = pci_scan_slot(parent, PCI_DEVFN(0, 0));
+	if (num == 0) {
+		ctrl_err(ctrl, "No new device found\n");
+		ret = -ENODEV;
+		goto out;
+	}
+
+	for_each_pci_bridge(dev, parent)
+		pci_hp_add_bridge(dev);
+
+	pci_assign_unassigned_bridge_resources(bridge);
+	pcie_bus_configure_settings(parent);
+
+	/*
+	 * Release reset_lock during driver binding
+	 * to avoid AB-BA deadlock with device_lock.
+	 */
+	up_read(&ctrl->reset_lock);
+	pci_bus_add_devices(parent);
+	down_read_nested(&ctrl->reset_lock, ctrl->depth);
+
+	dev = pci_get_slot(parent, PCI_DEVFN(0, 0));
+	ctrl->dsn = pci_get_dsn(dev);
+	pci_dev_put(dev);
+
+ out:
+	pci_unlock_rescan_remove();
+	return ret;
+}
+
+/**
+ * pciehp_unconfigure_device() - remove PCI devices below a hotplug bridge
+ * @ctrl: PCIe hotplug controller
+ * @presence: whether the card is still present in the slot;
+ *	true for safe removal via sysfs or an Attention Button press,
+ *	false for surprise removal
+ *
+ * Unbind PCI devices below a hotplug bridge from their drivers and remove
+ * them from the system.  Safely removed devices are quiesced.  Surprise
+ * removed devices are marked as such to prevent further accesses.
+ */
+static void pciehp_unconfigure_device(struct controller *ctrl, bool presence)
+{
+	struct pci_dev *dev, *temp;
+	struct pci_bus *parent = ctrl->pcie->port->subordinate;
+	u16 command;
+
+	ctrl_dbg(ctrl, "%s: domain:bus:dev = %04x:%02x:00\n",
+		 __func__, pci_domain_nr(parent), parent->number);
+
+	if (!presence)
+		pci_walk_bus(parent, pci_dev_set_disconnected, NULL);
+
+	pci_lock_rescan_remove();
+
+	/*
+	 * Stopping an SR-IOV PF device removes all the associated VFs,
+	 * which will update the bus->devices list and confuse the
+	 * iterator.  Therefore, iterate in reverse so we remove the VFs
+	 * first, then the PF.  We do the same in pci_stop_bus_device().
+	 */
+	list_for_each_entry_safe_reverse(dev, temp, &parent->devices,
+					 bus_list) {
+		pci_dev_get(dev);
+
+		/*
+		 * Release reset_lock during driver unbinding
+		 * to avoid AB-BA deadlock with device_lock.
+		 */
+		up_read(&ctrl->reset_lock);
+		pci_stop_and_remove_bus_device(dev);
+		down_read_nested(&ctrl->reset_lock, ctrl->depth);
+
+		/*
+		 * Ensure that no new Requests will be generated from
+		 * the device.
+		 */
+		if (presence) {
+			pci_read_config_word(dev, PCI_COMMAND, &command);
+			command &= ~(PCI_COMMAND_MASTER | PCI_COMMAND_SERR);
+			command |= PCI_COMMAND_INTX_DISABLE;
+			pci_write_config_word(dev, PCI_COMMAND, command);
+		}
+		pci_dev_put(dev);
+	}
+
+	pci_unlock_rescan_remove();
+}
+
+static bool pciehp_device_replaced(struct controller *ctrl)
+{
+	struct pci_dev *pdev __free(pci_dev_put) = NULL;
+	u32 reg;
+
+	if (pci_dev_is_disconnected(ctrl->pcie->port))
+		return false;
+
+	pdev = pci_get_slot(ctrl->pcie->port->subordinate, PCI_DEVFN(0, 0));
+	if (!pdev)
+		return true;
+
+	if (pci_read_config_dword(pdev, PCI_VENDOR_ID, &reg) ||
+	    reg != (pdev->vendor | (pdev->device << 16)) ||
+	    pci_read_config_dword(pdev, PCI_CLASS_REVISION, &reg) ||
+	    reg != (pdev->revision | (pdev->class << 8)))
+		return true;
+
+	if (pdev->hdr_type == PCI_HEADER_TYPE_NORMAL &&
+	    (pci_read_config_dword(pdev, PCI_SUBSYSTEM_VENDOR_ID, &reg) ||
+	     reg != (pdev->subsystem_vendor | (pdev->subsystem_device << 16))))
+		return true;
+
+	if (pci_get_dsn(pdev) != ctrl->dsn)
+		return true;
+
+	return false;
+}
+
+static int pcie_poll_cmd(struct controller *ctrl, int timeout)
+{
+	struct pci_dev *pdev = ctrl_dev(ctrl);
+	u16 slot_status;
+
+	do {
+		pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
+		if (PCI_POSSIBLE_ERROR(slot_status)) {
+			ctrl_info(ctrl, "%s: no response from device\n",
+				  __func__);
+			return 0;
+		}
+
+		if (slot_status & PCI_EXP_SLTSTA_CC) {
+			pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
+						   PCI_EXP_SLTSTA_CC);
+			ctrl->cmd_busy = 0;
+			smp_mb();
+			return 1;
+		}
+		msleep(10);
+		timeout -= 10;
+	} while (timeout >= 0);
+	return 0;	/* timeout */
+}
+
+static void pcie_wait_cmd(struct controller *ctrl)
+{
+	unsigned int msecs = pciehp_poll_mode ? 2500 : 1000;
+	unsigned long duration = msecs_to_jiffies(msecs);
+	unsigned long cmd_timeout = ctrl->cmd_started + duration;
+	unsigned long now, timeout;
+	int rc;
+
+	/*
+	 * If the controller does not generate notifications for command
+	 * completions, we never need to wait between writes.
+	 */
+	if (NO_CMD_CMPL(ctrl))
+		return;
+
+	if (!ctrl->cmd_busy)
+		return;
+
+	/*
+	 * Even if the command has already timed out, we want to call
+	 * pcie_poll_cmd() so it can clear PCI_EXP_SLTSTA_CC.
+	 */
+	now = jiffies;
+	if (time_before_eq(cmd_timeout, now))
+		timeout = 1;
+	else
+		timeout = cmd_timeout - now;
+
+	if (ctrl->slot_ctrl & PCI_EXP_SLTCTL_HPIE &&
+	    ctrl->slot_ctrl & PCI_EXP_SLTCTL_CCIE)
+		rc = wait_event_timeout(ctrl->queue, !ctrl->cmd_busy, timeout);
+	else
+		rc = pcie_poll_cmd(ctrl, jiffies_to_msecs(timeout));
+
+	if (!rc)
+		ctrl_info(ctrl, "Timeout on hotplug command %#06x (issued %u msec ago)\n",
+			  ctrl->slot_ctrl,
+			  jiffies_to_msecs(jiffies - ctrl->cmd_started));
+}
+
+#define CC_ERRATUM_MASK		(PCI_EXP_SLTCTL_PCC |	\
+				 PCI_EXP_SLTCTL_PIC |	\
+				 PCI_EXP_SLTCTL_AIC |	\
+				 PCI_EXP_SLTCTL_EIC)
+
+static void pcie_do_write_cmd(struct controller *ctrl, u16 cmd,
+			      u16 mask, bool wait)
+{
+	struct pci_dev *pdev = ctrl_dev(ctrl);
+	u16 slot_ctrl_orig, slot_ctrl;
+
+	mutex_lock(&ctrl->ctrl_lock);
+
+	/*
+	 * Always wait for any previous command that might still be in progress
+	 */
+	pcie_wait_cmd(ctrl);
+
+	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
+	if (PCI_POSSIBLE_ERROR(slot_ctrl)) {
+		ctrl_info(ctrl, "%s: no response from device\n", __func__);
+		goto out;
+	}
+
+	slot_ctrl_orig = slot_ctrl;
+	slot_ctrl &= ~mask;
+	slot_ctrl |= (cmd & mask);
+	ctrl->cmd_busy = 1;
+	smp_mb();
+	ctrl->slot_ctrl = slot_ctrl;
+	pcie_capability_write_word(pdev, PCI_EXP_SLTCTL, slot_ctrl);
+	ctrl->cmd_started = jiffies;
+
+	/*
+	 * Controllers with the Intel CF118 and similar errata advertise
+	 * Command Completed support, but they only set Command Completed
+	 * if we change the "Control" bits for power, power indicator,
+	 * attention indicator, or interlock.  If we only change the
+	 * "Enable" bits, they never set the Command Completed bit.
+	 */
+	if (pdev->broken_cmd_compl &&
+	    (slot_ctrl_orig & CC_ERRATUM_MASK) == (slot_ctrl & CC_ERRATUM_MASK))
+		ctrl->cmd_busy = 0;
+
+	/*
+	 * Optionally wait for the hardware to be ready for a new command,
+	 * indicating completion of the above issued command.
+	 */
+	if (wait)
+		pcie_wait_cmd(ctrl);
+
+out:
+	mutex_unlock(&ctrl->ctrl_lock);
+}
+
+/**
+ * pcie_write_cmd - Issue controller command
+ * @ctrl: controller to which the command is issued
+ * @cmd:  command value written to slot control register
+ * @mask: bitmask of slot control register to be modified
+ */
+static void pcie_write_cmd(struct controller *ctrl, u16 cmd, u16 mask)
+{
+	pcie_do_write_cmd(ctrl, cmd, mask, true);
+}
+
+/* Same as above without waiting for the hardware to latch */
+static void pcie_write_cmd_nowait(struct controller *ctrl, u16 cmd, u16 mask)
+{
+	pcie_do_write_cmd(ctrl, cmd, mask, false);
+}
+
+static void pciehp_request(struct controller *ctrl, int action)
+{
+	atomic_or(action, &ctrl->pending_events);
+	if (!pciehp_poll_mode)
+		irq_wake_thread(ctrl->pcie->irq, ctrl);
+}
+
+/**
+ * pciehp_check_link_active() - Is the link active
+ * @ctrl: PCIe hotplug controller
+ *
+ * Check whether the downstream link is currently active. Note it is
+ * possible that the card is removed immediately after this so the
+ * caller may need to take it into account.
+ *
+ * If the hotplug controller itself is not available anymore returns
+ * %-ENODEV.
+ */
+static int pciehp_check_link_active(struct controller *ctrl)
+{
+	struct pci_dev *pdev = ctrl_dev(ctrl);
+	u16 lnk_status;
+	int ret;
+
+	ret = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
+	if (ret == PCIBIOS_DEVICE_NOT_FOUND || PCI_POSSIBLE_ERROR(lnk_status))
+		return -ENODEV;
+
+	ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
+	ctrl_dbg(ctrl, "%s: lnk_status = %x\n", __func__, lnk_status);
+
+	return ret;
+}
+
+/**
+ * pciehp_card_present() - Is the card present
+ * @ctrl: PCIe hotplug controller
+ *
+ * Function checks whether the card is currently present in the slot and
+ * in that case returns true. Note it is possible that the card is
+ * removed immediately after the check so the caller may need to take
+ * this into account.
+ *
+ * If the hotplug controller itself is not available anymore returns
+ * %-ENODEV.
+ */
+static int pciehp_card_present(struct controller *ctrl)
+{
+	struct pci_dev *pdev = ctrl_dev(ctrl);
+	u16 slot_status;
+	int ret;
+
+	ret = pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
+	if (ret == PCIBIOS_DEVICE_NOT_FOUND || PCI_POSSIBLE_ERROR(slot_status))
+		return -ENODEV;
+
+	return !!(slot_status & PCI_EXP_SLTSTA_PDS);
+}
+
+/**
+ * pciehp_card_present_or_link_active() - whether given slot is occupied
+ * @ctrl: PCIe hotplug controller
+ *
+ * Unlike pciehp_card_present(), which determines presence solely from the
+ * Presence Detect State bit, this helper also returns true if the Link Active
+ * bit is set.  This is a concession to broken hotplug ports which hardwire
+ * Presence Detect State to zero, such as Wilocity's [1ae9:0200].
+ *
+ * Returns: %1 if the slot is occupied and %0 if it is not. If the hotplug
+ *	    port is not present anymore returns %-ENODEV.
+ */
+static int pciehp_card_present_or_link_active(struct controller *ctrl)
+{
+	int ret;
+
+	ret = pciehp_card_present(ctrl);
+	if (ret)
+		return ret;
+
+	return pciehp_check_link_active(ctrl);
+}
+
+static bool pci_bus_check_dev(struct pci_bus *bus, int devfn)
+{
+	u32 l;
+	int count = 0;
+	int delay = 1000, step = 20;
+	bool found = false;
+
+	do {
+		found = pci_bus_read_dev_vendor_id(bus, devfn, &l, 0);
+		count++;
+
+		if (found)
+			break;
+
+		msleep(step);
+		delay -= step;
+	} while (delay > 0);
+
+	if (count > 1)
+		pr_debug("pci %04x:%02x:%02x.%d id reading try %d times with interval %d ms to get %08x\n",
+			pci_domain_nr(bus), bus->number, PCI_SLOT(devfn),
+			PCI_FUNC(devfn), count, step, l);
+
+	return found;
+}
+
+static void pcie_wait_for_presence(struct pci_dev *pdev)
+{
+	int timeout = 1250;
+	u16 slot_status;
+
+	do {
+		pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
+		if (slot_status & PCI_EXP_SLTSTA_PDS)
+			return;
+		msleep(10);
+		timeout -= 10;
+	} while (timeout > 0);
+}
+
+static int pciehp_check_link_status(struct controller *ctrl)
+{
+	struct pci_dev *pdev = ctrl_dev(ctrl);
+	bool found;
+	u16 lnk_status, linksta2;
+
+	if (!pcie_wait_for_link(pdev, true)) {
+		ctrl_info(ctrl, "Slot(%s): No link\n", slot_name(ctrl));
+		return -1;
+	}
+
+	if (ctrl->inband_presence_disabled)
+		pcie_wait_for_presence(pdev);
+
+	found = pci_bus_check_dev(ctrl->pcie->port->subordinate,
+					PCI_DEVFN(0, 0));
+
+	/* ignore link or presence changes up to this point */
+	if (found)
+		atomic_and(~(PCI_EXP_SLTSTA_DLLSC | PCI_EXP_SLTSTA_PDC),
+			   &ctrl->pending_events);
+
+	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
+	ctrl_dbg(ctrl, "%s: lnk_status = %x\n", __func__, lnk_status);
+	if ((lnk_status & PCI_EXP_LNKSTA_LT) ||
+	    !(lnk_status & PCI_EXP_LNKSTA_NLW)) {
+		ctrl_info(ctrl, "Slot(%s): Cannot train link: status %#06x\n",
+			  slot_name(ctrl), lnk_status);
+		return -1;
+	}
+
+	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA2, &linksta2);
+	__pcie_update_link_speed(ctrl->pcie->port->subordinate, lnk_status, linksta2);
+
+	if (!found) {
+		ctrl_info(ctrl, "Slot(%s): No device found\n",
+			  slot_name(ctrl));
+		return -1;
+	}
+
+	return 0;
+}
+
+static int get_adapter_status(struct hotplug_slot *hotplug_slot, u8 *value)
+{
+	struct controller *ctrl = to_ctrl(hotplug_slot);
+	struct pci_dev *pdev = ctrl->pcie->port;
+	int ret;
+
+	pci_config_pm_runtime_get(pdev);
+	ret = pciehp_card_present_or_link_active(ctrl);
+	pci_config_pm_runtime_put(pdev);
+	if (ret < 0)
+		return ret;
+
+	*value = ret;
+	return 0;
+}
+
+/**
+ * pciehp_check_presence() - synthesize event if presence has changed
+ * @ctrl: controller to check
+ *
+ * On probe and resume, an explicit presence check is necessary to bring up an
+ * occupied slot or bring down an unoccupied slot.  This can't be triggered by
+ * events in the Slot Status register, they may be stale and are therefore
+ * cleared.  Secondly, sending an interrupt for "events that occur while
+ * interrupt generation is disabled [when] interrupt generation is subsequently
+ * enabled" is optional per PCIe r4.0, sec 6.7.3.4.
+ */
+static void pciehp_check_presence(struct controller *ctrl)
+{
+	int occupied;
+
+	down_read_nested(&ctrl->reset_lock, ctrl->depth);
+	mutex_lock(&ctrl->state_lock);
+
+	occupied = pciehp_card_present_or_link_active(ctrl);
+	if ((occupied > 0 && (ctrl->state == OFF_STATE ||
+			  ctrl->state == BLINKINGON_STATE)) ||
+	    (!occupied && (ctrl->state == ON_STATE ||
+			   ctrl->state == BLINKINGOFF_STATE)))
+		pciehp_request(ctrl, PCI_EXP_SLTSTA_PDC);
+
+	mutex_unlock(&ctrl->state_lock);
+	up_read(&ctrl->reset_lock);
+}
+
+static int __pciehp_link_set(struct controller *ctrl, bool enable)
+{
+	struct pci_dev *pdev = ctrl_dev(ctrl);
+
+	pcie_capability_clear_and_set_word(pdev, PCI_EXP_LNKCTL,
+					   PCI_EXP_LNKCTL_LD,
+					   enable ? 0 : PCI_EXP_LNKCTL_LD);
+
+	return 0;
+}
+
+static int pciehp_link_enable(struct controller *ctrl)
+{
+	return __pciehp_link_set(ctrl, true);
+}
+
+static int pciehp_get_raw_indicator_status(struct hotplug_slot *hotplug_slot,
+				    u8 *status)
+{
+	struct controller *ctrl = to_ctrl(hotplug_slot);
+	struct pci_dev *pdev = ctrl_dev(ctrl);
+	u16 slot_ctrl;
+
+	pci_config_pm_runtime_get(pdev);
+	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
+	pci_config_pm_runtime_put(pdev);
+	*status = (slot_ctrl & (PCI_EXP_SLTCTL_AIC | PCI_EXP_SLTCTL_PIC)) >> 6;
+	return 0;
+}
+
+static int pciehp_set_raw_indicator_status(struct hotplug_slot *hotplug_slot,
+				    u8 status)
+{
+	struct controller *ctrl = to_ctrl(hotplug_slot);
+	struct pci_dev *pdev = ctrl_dev(ctrl);
+
+	pci_config_pm_runtime_get(pdev);
+
+	/* Attention and Power Indicator Control bits are supported */
+	pcie_write_cmd_nowait(ctrl, FIELD_PREP(PCI_EXP_SLTCTL_AIC | PCI_EXP_SLTCTL_PIC, status),
+			      PCI_EXP_SLTCTL_AIC | PCI_EXP_SLTCTL_PIC);
+	pci_config_pm_runtime_put(pdev);
+	return 0;
+}
+
+/**
+ * pciehp_set_indicators() - set attention indicator, power indicator, or both
+ * @ctrl: PCIe hotplug controller
+ * @pwr: one of:
+ *	PCI_EXP_SLTCTL_PWR_IND_ON
+ *	PCI_EXP_SLTCTL_PWR_IND_BLINK
+ *	PCI_EXP_SLTCTL_PWR_IND_OFF
+ * @attn: one of:
+ *	PCI_EXP_SLTCTL_ATTN_IND_ON
+ *	PCI_EXP_SLTCTL_ATTN_IND_BLINK
+ *	PCI_EXP_SLTCTL_ATTN_IND_OFF
+ *
+ * Either @pwr or @attn can also be INDICATOR_NOOP to leave that indicator
+ * unchanged.
+ */
+static void pciehp_set_indicators(struct controller *ctrl, int pwr, int attn)
+{
+	u16 cmd = 0, mask = 0;
+
+	if (PWR_LED(ctrl) && pwr != INDICATOR_NOOP) {
+		cmd |= (pwr & PCI_EXP_SLTCTL_PIC);
+		mask |= PCI_EXP_SLTCTL_PIC;
+	}
+
+	if (ATTN_LED(ctrl) && attn != INDICATOR_NOOP) {
+		cmd |= (attn & PCI_EXP_SLTCTL_AIC);
+		mask |= PCI_EXP_SLTCTL_AIC;
+	}
+
+	if (cmd) {
+		pcie_write_cmd_nowait(ctrl, cmd, mask);
+		ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
+			 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, cmd);
+	}
+}
+
+static int pciehp_get_attention_status(struct hotplug_slot *hotplug_slot, u8 *status)
+{
+	struct controller *ctrl = to_ctrl(hotplug_slot);
+	struct pci_dev *pdev = ctrl_dev(ctrl);
+	u16 slot_ctrl;
+
+	pci_config_pm_runtime_get(pdev);
+	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
+	pci_config_pm_runtime_put(pdev);
+	ctrl_dbg(ctrl, "%s: SLOTCTRL %x, value read %x\n", __func__,
+		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, slot_ctrl);
+
+	switch (slot_ctrl & PCI_EXP_SLTCTL_AIC) {
+	case PCI_EXP_SLTCTL_ATTN_IND_ON:
+		*status = 1;	/* On */
+		break;
+	case PCI_EXP_SLTCTL_ATTN_IND_BLINK:
+		*status = 2;	/* Blink */
+		break;
+	case PCI_EXP_SLTCTL_ATTN_IND_OFF:
+		*status = 0;	/* Off */
+		break;
+	default:
+		*status = 0xFF;
+		break;
+	}
+
+	return 0;
+}
+
+/*
+ * set_attention_status - Turns the Attention Indicator on, off or blinking
+ */
+static int set_attention_status(struct hotplug_slot *hotplug_slot, u8 status)
+{
+	struct controller *ctrl = to_ctrl(hotplug_slot);
+	struct pci_dev *pdev = ctrl->pcie->port;
+
+	if (status)
+		status = FIELD_PREP(PCI_EXP_SLTCTL_AIC, status);
+	else
+		status = PCI_EXP_SLTCTL_ATTN_IND_OFF;
+
+	pci_config_pm_runtime_get(pdev);
+	pciehp_set_indicators(ctrl, INDICATOR_NOOP, status);
+	pci_config_pm_runtime_put(pdev);
+	return 0;
+}
+
+/**
+ * pciehp_slot_reset() - ignore link event caused by error-induced hot reset
+ * @dev: PCI Express port service device
+ *
+ * Called from pcie_portdrv_slot_reset() after AER or DPC initiated a reset
+ * further up in the hierarchy to recover from an error.  The reset was
+ * propagated down to this hotplug port.  Ignore the resulting link flap.
+ * If the link failed to retrain successfully, synthesize the ignored event.
+ * Surprise removal during reset is detected through Presence Detect Changed.
+ */
+static int pciehp_slot_reset(struct pcie_device *dev)
+{
+	struct controller *ctrl = get_service_data(dev);
+
+	if (ctrl->state != ON_STATE)
+		return 0;
+
+	pcie_capability_write_word(dev->port, PCI_EXP_SLTSTA,
+				   PCI_EXP_SLTSTA_DLLSC);
+
+	if (!pciehp_check_link_active(ctrl))
+		pciehp_request(ctrl, PCI_EXP_SLTSTA_DLLSC);
+
+	return 0;
+}
+
+/*
+ * pciehp has a 1:1 bus:slot relationship so we ultimately want a secondary
+ * bus reset of the bridge, but at the same time we want to ensure that it is
+ * not seen as a hot-unplug, followed by the hot-plug of the device. Thus,
+ * disable link state notification and presence detection change notification
+ * momentarily, if we see that they could interfere. Also, clear any spurious
+ * events after.
+ */
+static int pciehp_reset_slot(struct hotplug_slot *hotplug_slot, bool probe)
+{
+	struct controller *ctrl = to_ctrl(hotplug_slot);
+	struct pci_dev *pdev = ctrl_dev(ctrl);
+	int rc;
+
+	if (probe)
+		return 0;
+
+	down_write_nested(&ctrl->reset_lock, ctrl->depth);
+
+	pci_hp_ignore_link_change(pdev);
+
+	rc = pci_bridge_secondary_bus_reset(ctrl->pcie->port);
+
+	pci_hp_unignore_link_change(pdev);
+
+	up_write(&ctrl->reset_lock);
+	return rc;
+}
+
+static void pciehp_get_latch_status(struct controller *ctrl, u8 *status)
+{
+	struct pci_dev *pdev = ctrl_dev(ctrl);
+	u16 slot_status;
+
+	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
+	*status = !!(slot_status & PCI_EXP_SLTSTA_MRLSS);
+}
+
+static int get_latch_status(struct hotplug_slot *hotplug_slot, u8 *value)
+{
+	struct controller *ctrl = to_ctrl(hotplug_slot);
+	struct pci_dev *pdev = ctrl->pcie->port;
+
+	pci_config_pm_runtime_get(pdev);
+	pciehp_get_latch_status(ctrl, value);
+	pci_config_pm_runtime_put(pdev);
+	return 0;
+}
+
+static int pciehp_query_power_fault(struct controller *ctrl)
+{
+	struct pci_dev *pdev = ctrl_dev(ctrl);
+	u16 slot_status;
+
+	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
+	return !!(slot_status & PCI_EXP_SLTSTA_PFD);
+}
+
+static void pciehp_get_power_status(struct controller *ctrl, u8 *status)
+{
+	struct pci_dev *pdev = ctrl_dev(ctrl);
+	u16 slot_ctrl;
+
+	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
+	ctrl_dbg(ctrl, "%s: SLOTCTRL %x value read %x\n", __func__,
+		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, slot_ctrl);
+
+	switch (slot_ctrl & PCI_EXP_SLTCTL_PCC) {
+	case PCI_EXP_SLTCTL_PWR_ON:
+		*status = 1;	/* On */
+		break;
+	case PCI_EXP_SLTCTL_PWR_OFF:
+		*status = 0;	/* Off */
+		break;
+	default:
+		*status = 0xFF;
+		break;
+	}
+}
+
+static int get_power_status(struct hotplug_slot *hotplug_slot, u8 *value)
+{
+	struct controller *ctrl = to_ctrl(hotplug_slot);
+	struct pci_dev *pdev = ctrl->pcie->port;
+
+	pci_config_pm_runtime_get(pdev);
+	pciehp_get_power_status(ctrl, value);
+	pci_config_pm_runtime_put(pdev);
+	return 0;
+}
+
+static int pciehp_power_on_slot(struct controller *ctrl)
+{
+	struct pci_dev *pdev = ctrl_dev(ctrl);
+	u16 slot_status;
+	int retval;
+
+	/* Clear power-fault bit from previous power failures */
+	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
+	if (slot_status & PCI_EXP_SLTSTA_PFD)
+		pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
+					   PCI_EXP_SLTSTA_PFD);
+	ctrl->power_fault_detected = 0;
+
+	pcie_write_cmd(ctrl, PCI_EXP_SLTCTL_PWR_ON, PCI_EXP_SLTCTL_PCC);
+	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
+		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL,
+		 PCI_EXP_SLTCTL_PWR_ON);
+
+	retval = pciehp_link_enable(ctrl);
+	if (retval)
+		ctrl_err(ctrl, "%s: Can not enable the link!\n", __func__);
+
+	return retval;
+}
+
+static void pciehp_power_off_slot(struct controller *ctrl)
+{
+	pcie_write_cmd(ctrl, PCI_EXP_SLTCTL_PWR_OFF, PCI_EXP_SLTCTL_PCC);
+	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
+		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL,
+		 PCI_EXP_SLTCTL_PWR_OFF);
+}
+
+static void set_slot_off(struct controller *ctrl)
+{
+	/*
+	 * Turn off slot, turn on attention indicator, turn off power
+	 * indicator
+	 */
+	if (POWER_CTRL(ctrl)) {
+		pciehp_power_off_slot(ctrl);
+
+		/*
+		 * After turning power off, we must wait for at least 1 second
+		 * before taking any action that relies on power having been
+		 * removed from the slot/adapter.
+		 */
+		msleep(1000);
+	}
+
+	pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF,
+			      PCI_EXP_SLTCTL_ATTN_IND_ON);
+}
+
+/**
+ * board_added - Called after a board has been added to the system.
+ * @ctrl: PCIe hotplug controller where board is added
+ *
+ * Turns power on for the board.
+ * Configures board.
+ */
+static int board_added(struct controller *ctrl)
+{
+	int retval = 0;
+	struct pci_bus *parent = ctrl->pcie->port->subordinate;
+
+	if (POWER_CTRL(ctrl)) {
+		/* Power on slot */
+		retval = pciehp_power_on_slot(ctrl);
+		if (retval)
+			return retval;
+	}
+
+	pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_BLINK,
+			      INDICATOR_NOOP);
+
+	/* Check link training status */
+	retval = pciehp_check_link_status(ctrl);
+	if (retval)
+		goto err_exit;
+
+	/* Check for a power fault */
+	if (ctrl->power_fault_detected || pciehp_query_power_fault(ctrl)) {
+		ctrl_err(ctrl, "Slot(%s): Power fault\n", slot_name(ctrl));
+		retval = -EIO;
+		goto err_exit;
+	}
+
+	retval = pciehp_configure_device(ctrl);
+	if (retval) {
+		if (retval != -EEXIST) {
+			ctrl_err(ctrl, "Cannot add device at %04x:%02x:00\n",
+				 pci_domain_nr(parent), parent->number);
+			goto err_exit;
+		}
+	}
+
+	pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_ON,
+			      PCI_EXP_SLTCTL_ATTN_IND_OFF);
+	return 0;
+
+err_exit:
+	set_slot_off(ctrl);
+	return retval;
+}
+
+/**
+ * remove_board - Turn off slot and Power Indicator
+ * @ctrl: PCIe hotplug controller where board is being removed
+ * @safe_removal: whether the board is safely removed (versus surprise removed)
+ */
+static void remove_board(struct controller *ctrl, bool safe_removal)
+{
+	pciehp_unconfigure_device(ctrl, safe_removal);
+
+	if (POWER_CTRL(ctrl)) {
+		pciehp_power_off_slot(ctrl);
+
+		/*
+		 * After turning power off, we must wait for at least 1 second
+		 * before taking any action that relies on power having been
+		 * removed from the slot/adapter.
+		 */
+		msleep(1000);
+
+		/* Ignore link or presence changes caused by power off */
+		atomic_and(~(PCI_EXP_SLTSTA_DLLSC | PCI_EXP_SLTSTA_PDC),
+			   &ctrl->pending_events);
+	}
+
+	pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF,
+			      INDICATOR_NOOP);
+
+	/* Don't carry LBMS indications across */
+	pcie_reset_lbms_count(ctrl->pcie->port);
+}
+
+static int __pciehp_enable_slot(struct controller *ctrl)
+{
+	u8 getstatus = 0;
+
+	if (MRL_SENS(ctrl)) {
+		pciehp_get_latch_status(ctrl, &getstatus);
+		if (getstatus) {
+			ctrl_info(ctrl, "Slot(%s): Latch open\n",
+				  slot_name(ctrl));
+			return -ENODEV;
+		}
+	}
+
+	if (POWER_CTRL(ctrl)) {
+		pciehp_get_power_status(ctrl, &getstatus);
+		if (getstatus) {
+			ctrl_info(ctrl, "Slot(%s): Already enabled\n",
+				  slot_name(ctrl));
+			return 0;
+		}
+	}
+
+	return board_added(ctrl);
+}
+
+static int pciehp_enable_slot(struct controller *ctrl)
+{
+	int ret;
+
+	pm_runtime_get_sync(&ctrl->pcie->port->dev);
+	ret = __pciehp_enable_slot(ctrl);
+	if (ret && ATTN_BUTTN(ctrl))
+		/* may be blinking */
+		pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF,
+				      INDICATOR_NOOP);
+	pm_runtime_put(&ctrl->pcie->port->dev);
+
+	mutex_lock(&ctrl->state_lock);
+	ctrl->state = ret ? OFF_STATE : ON_STATE;
+	mutex_unlock(&ctrl->state_lock);
+
+	return ret;
+}
+
+static int __pciehp_disable_slot(struct controller *ctrl, bool safe_removal)
+{
+	u8 getstatus = 0;
+
+	if (POWER_CTRL(ctrl)) {
+		pciehp_get_power_status(ctrl, &getstatus);
+		if (!getstatus) {
+			ctrl_info(ctrl, "Slot(%s): Already disabled\n",
+				  slot_name(ctrl));
+			return -EINVAL;
+		}
+	}
+
+	remove_board(ctrl, safe_removal);
+	return 0;
+}
+
+static int pciehp_disable_slot(struct controller *ctrl, bool safe_removal)
+{
+	int ret;
+
+	pm_runtime_get_sync(&ctrl->pcie->port->dev);
+	ret = __pciehp_disable_slot(ctrl, safe_removal);
+	pm_runtime_put(&ctrl->pcie->port->dev);
+
+	mutex_lock(&ctrl->state_lock);
+	ctrl->state = OFF_STATE;
+	mutex_unlock(&ctrl->state_lock);
+
+	return ret;
+}
+
+static int pciehp_sysfs_enable_slot(struct hotplug_slot *hotplug_slot)
+{
+	struct controller *ctrl = to_ctrl(hotplug_slot);
+
+	mutex_lock(&ctrl->state_lock);
+	switch (ctrl->state) {
+	case BLINKINGON_STATE:
+	case OFF_STATE:
+		mutex_unlock(&ctrl->state_lock);
+		/*
+		 * The IRQ thread becomes a no-op if the user pulls out the
+		 * card before the thread wakes up, so initialize to -ENODEV.
+		 */
+		ctrl->request_result = -ENODEV;
+		pciehp_request(ctrl, PCI_EXP_SLTSTA_PDC);
+		wait_event(ctrl->requester,
+			   !atomic_read(&ctrl->pending_events) &&
+			   !ctrl->ist_running);
+		return ctrl->request_result;
+	case POWERON_STATE:
+		ctrl_info(ctrl, "Slot(%s): Already in powering on state\n",
+			  slot_name(ctrl));
+		break;
+	case BLINKINGOFF_STATE:
+	case ON_STATE:
+	case POWEROFF_STATE:
+		ctrl_info(ctrl, "Slot(%s): Already enabled\n",
+			  slot_name(ctrl));
+		break;
+	default:
+		ctrl_err(ctrl, "Slot(%s): Invalid state %#x\n",
+			 slot_name(ctrl), ctrl->state);
+		break;
+	}
+	mutex_unlock(&ctrl->state_lock);
+
+	return -ENODEV;
+}
+
+static int pciehp_sysfs_disable_slot(struct hotplug_slot *hotplug_slot)
+{
+	struct controller *ctrl = to_ctrl(hotplug_slot);
+
+	mutex_lock(&ctrl->state_lock);
+	switch (ctrl->state) {
+	case BLINKINGOFF_STATE:
+	case ON_STATE:
+		mutex_unlock(&ctrl->state_lock);
+		pciehp_request(ctrl, DISABLE_SLOT);
+		wait_event(ctrl->requester,
+			   !atomic_read(&ctrl->pending_events) &&
+			   !ctrl->ist_running);
+		return ctrl->request_result;
+	case POWEROFF_STATE:
+		ctrl_info(ctrl, "Slot(%s): Already in powering off state\n",
+			  slot_name(ctrl));
+		break;
+	case BLINKINGON_STATE:
+	case OFF_STATE:
+	case POWERON_STATE:
+		ctrl_info(ctrl, "Slot(%s): Already disabled\n",
+			  slot_name(ctrl));
+		break;
+	default:
+		ctrl_err(ctrl, "Slot(%s): Invalid state %#x\n",
+			 slot_name(ctrl), ctrl->state);
+		break;
+	}
+	mutex_unlock(&ctrl->state_lock);
+
+	return -ENODEV;
+}
+
+static void pciehp_queue_pushbutton_work(struct work_struct *work)
+{
+	struct controller *ctrl = container_of(work, struct controller,
+					       button_work.work);
+
+	mutex_lock(&ctrl->state_lock);
+	switch (ctrl->state) {
+	case BLINKINGOFF_STATE:
+		pciehp_request(ctrl, DISABLE_SLOT);
+		break;
+	case BLINKINGON_STATE:
+		pciehp_request(ctrl, PCI_EXP_SLTSTA_PDC);
+		break;
+	default:
+		break;
+	}
+	mutex_unlock(&ctrl->state_lock);
+}
+
+static void pciehp_handle_button_press(struct controller *ctrl)
+{
+	mutex_lock(&ctrl->state_lock);
+	switch (ctrl->state) {
+	case OFF_STATE:
+	case ON_STATE:
+		if (ctrl->state == ON_STATE) {
+			ctrl->state = BLINKINGOFF_STATE;
+			ctrl_info(ctrl, "Slot(%s): Button press: will power off in 5 sec\n",
+				  slot_name(ctrl));
+		} else {
+			ctrl->state = BLINKINGON_STATE;
+			ctrl_info(ctrl, "Slot(%s): Button press: will power on in 5 sec\n",
+				  slot_name(ctrl));
+		}
+		/* blink power indicator and turn off attention */
+		pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_BLINK,
+				      PCI_EXP_SLTCTL_ATTN_IND_OFF);
+		schedule_delayed_work(&ctrl->button_work, 5 * HZ);
+		break;
+	case BLINKINGOFF_STATE:
+	case BLINKINGON_STATE:
+		/*
+		 * Cancel if we are still blinking; this means that we
+		 * press the attention again before the 5 sec. limit
+		 * expires to cancel hot-add or hot-remove
+		 */
+		cancel_delayed_work(&ctrl->button_work);
+		if (ctrl->state == BLINKINGOFF_STATE) {
+			ctrl->state = ON_STATE;
+			pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_ON,
+					      PCI_EXP_SLTCTL_ATTN_IND_OFF);
+			ctrl_info(ctrl, "Slot(%s): Button press: canceling request to power off\n",
+				  slot_name(ctrl));
+		} else {
+			ctrl->state = OFF_STATE;
+			pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF,
+					      PCI_EXP_SLTCTL_ATTN_IND_OFF);
+			ctrl_info(ctrl, "Slot(%s): Button press: canceling request to power on\n",
+				  slot_name(ctrl));
+		}
+		break;
+	default:
+		ctrl_err(ctrl, "Slot(%s): Button press: ignoring invalid state %#x\n",
+			 slot_name(ctrl), ctrl->state);
+		break;
+	}
+	mutex_unlock(&ctrl->state_lock);
+}
+
+static void pciehp_handle_disable_request(struct controller *ctrl)
+{
+	mutex_lock(&ctrl->state_lock);
+	switch (ctrl->state) {
+	case BLINKINGON_STATE:
+	case BLINKINGOFF_STATE:
+		cancel_delayed_work(&ctrl->button_work);
+		break;
+	}
+	ctrl->state = POWEROFF_STATE;
+	mutex_unlock(&ctrl->state_lock);
+
+	ctrl->request_result = pciehp_disable_slot(ctrl, SAFE_REMOVAL);
+}
+
+static void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
+{
+	int present, link_active;
+
+	/*
+	 * If the slot is on and presence or link has changed, turn it off.
+	 * Even if it's occupied again, we cannot assume the card is the same.
+	 */
+	mutex_lock(&ctrl->state_lock);
+	switch (ctrl->state) {
+	case BLINKINGOFF_STATE:
+		cancel_delayed_work(&ctrl->button_work);
+		fallthrough;
+	case ON_STATE:
+		ctrl->state = POWEROFF_STATE;
+		mutex_unlock(&ctrl->state_lock);
+		if (events & PCI_EXP_SLTSTA_DLLSC)
+			ctrl_info(ctrl, "Slot(%s): Link Down\n",
+				  slot_name(ctrl));
+		if (events & PCI_EXP_SLTSTA_PDC)
+			ctrl_info(ctrl, "Slot(%s): Card not present\n",
+				  slot_name(ctrl));
+		pciehp_disable_slot(ctrl, SURPRISE_REMOVAL);
+		break;
+	default:
+		mutex_unlock(&ctrl->state_lock);
+		break;
+	}
+
+	/* Turn the slot on if it's occupied or link is up */
+	mutex_lock(&ctrl->state_lock);
+	present = pciehp_card_present(ctrl);
+	link_active = pciehp_check_link_active(ctrl);
+	if (present <= 0 && link_active <= 0) {
+		if (ctrl->state == BLINKINGON_STATE) {
+			ctrl->state = OFF_STATE;
+			cancel_delayed_work(&ctrl->button_work);
+			pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF,
+					      INDICATOR_NOOP);
+			ctrl_info(ctrl, "Slot(%s): Card not present\n",
+				  slot_name(ctrl));
+		}
+		mutex_unlock(&ctrl->state_lock);
+		return;
+	}
+
+	switch (ctrl->state) {
+	case BLINKINGON_STATE:
+		cancel_delayed_work(&ctrl->button_work);
+		fallthrough;
+	case OFF_STATE:
+		ctrl->state = POWERON_STATE;
+		mutex_unlock(&ctrl->state_lock);
+		if (present)
+			ctrl_info(ctrl, "Slot(%s): Card present\n",
+				  slot_name(ctrl));
+		if (link_active)
+			ctrl_info(ctrl, "Slot(%s): Link Up\n",
+				  slot_name(ctrl));
+		ctrl->request_result = pciehp_enable_slot(ctrl);
+		break;
+	default:
+		mutex_unlock(&ctrl->state_lock);
+		break;
+	}
+}
+
+static void pciehp_ignore_link_change(struct controller *ctrl,
+				      struct pci_dev *pdev, int irq,
+				      u16 ignored_events)
+{
+	/*
+	 * Ignore link changes which occurred while waiting for DPC recovery.
+	 * Could be several if DPC triggered multiple times consecutively.
+	 * Also ignore link changes caused by Secondary Bus Reset, etc.
+	 */
+	synchronize_hardirq(irq);
+	atomic_and(~ignored_events, &ctrl->pending_events);
+	if (pciehp_poll_mode)
+		pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
+					   ignored_events);
+	ctrl_info(ctrl, "Slot(%s): Link Down/Up ignored\n", slot_name(ctrl));
+
+	/*
+	 * If the link is unexpectedly down after successful recovery,
+	 * the corresponding link change may have been ignored above.
+	 * Synthesize it to ensure that it is acted on.
+	 */
+	down_read_nested(&ctrl->reset_lock, ctrl->depth);
+	if (!pciehp_check_link_active(ctrl) || pciehp_device_replaced(ctrl))
+		pciehp_request(ctrl, ignored_events);
+	up_read(&ctrl->reset_lock);
+}
+
+static irqreturn_t pciehp_isr(int irq, void *dev_id)
+{
+	struct controller *ctrl = (struct controller *)dev_id;
+	struct pci_dev *pdev = ctrl_dev(ctrl);
+	struct device *parent = pdev->dev.parent;
+	u16 status, events = 0;
+
+	/*
+	 * Interrupts only occur in D3hot or shallower and only if enabled
+	 * in the Slot Control register (PCIe r4.0, sec 6.7.3.4).
+	 */
+	if (pdev->current_state == PCI_D3cold ||
+	    (!(ctrl->slot_ctrl & PCI_EXP_SLTCTL_HPIE) && !pciehp_poll_mode))
+		return IRQ_NONE;
+
+	/*
+	 * Keep the port accessible by holding a runtime PM ref on its parent.
+	 * Defer resume of the parent to the IRQ thread if it's suspended.
+	 * Mask the interrupt until then.
+	 */
+	if (parent) {
+		pm_runtime_get_noresume(parent);
+		if (!pm_runtime_active(parent)) {
+			pm_runtime_put(parent);
+			disable_irq_nosync(irq);
+			atomic_or(RERUN_ISR, &ctrl->pending_events);
+			return IRQ_WAKE_THREAD;
+		}
+	}
+
+read_status:
+	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &status);
+	if (PCI_POSSIBLE_ERROR(status)) {
+		ctrl_info(ctrl, "%s: no response from device\n", __func__);
+		if (parent)
+			pm_runtime_put(parent);
+		return IRQ_NONE;
+	}
+
+	/*
+	 * Slot Status contains plain status bits as well as event
+	 * notification bits; right now we only want the event bits.
+	 */
+	status &= PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD |
+		  PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_CC |
+		  PCI_EXP_SLTSTA_DLLSC;
+
+	/*
+	 * If we've already reported a power fault, don't report it again
+	 * until we've done something to handle it.
+	 */
+	if (ctrl->power_fault_detected)
+		status &= ~PCI_EXP_SLTSTA_PFD;
+	else if (status & PCI_EXP_SLTSTA_PFD)
+		ctrl->power_fault_detected = true;
+
+	events |= status;
+	if (!events) {
+		if (parent)
+			pm_runtime_put(parent);
+		return IRQ_NONE;
+	}
+
+	if (status) {
+		pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, status);
+
+		/*
+		 * In MSI mode, all event bits must be zero before the port
+		 * will send a new interrupt (PCIe Base Spec r5.0 sec 6.7.3.4).
+		 * So re-read the Slot Status register in case a bit was set
+		 * between read and write.
+		 */
+		if (pci_dev_msi_enabled(pdev) && !pciehp_poll_mode)
+			goto read_status;
+	}
+
+	ctrl_dbg(ctrl, "pending interrupts %#06x from Slot Status\n", events);
+	if (parent)
+		pm_runtime_put(parent);
+
+	/*
+	 * Command Completed notifications are not deferred to the
+	 * IRQ thread because it may be waiting for their arrival.
+	 */
+	if (events & PCI_EXP_SLTSTA_CC) {
+		ctrl->cmd_busy = 0;
+		smp_mb();
+		wake_up(&ctrl->queue);
+
+		if (events == PCI_EXP_SLTSTA_CC)
+			return IRQ_HANDLED;
+
+		events &= ~PCI_EXP_SLTSTA_CC;
+	}
+
+	if (pdev->ignore_hotplug) {
+		ctrl_dbg(ctrl, "ignoring hotplug event %#06x\n", events);
+		return IRQ_HANDLED;
+	}
+
+	/* Save pending events for consumption by IRQ thread. */
+	atomic_or(events, &ctrl->pending_events);
+	return IRQ_WAKE_THREAD;
+}
+
+static irqreturn_t pciehp_ist(int irq, void *dev_id)
+{
+	struct controller *ctrl = (struct controller *)dev_id;
+	struct pci_dev *pdev = ctrl_dev(ctrl);
+	irqreturn_t ret;
+	u32 events;
+
+	ctrl->ist_running = true;
+	pci_config_pm_runtime_get(pdev);
+
+	/* rerun pciehp_isr() if the port was inaccessible on interrupt */
+	if (atomic_fetch_and(~RERUN_ISR, &ctrl->pending_events) & RERUN_ISR) {
+		ret = pciehp_isr(irq, dev_id);
+		enable_irq(irq);
+		if (ret != IRQ_WAKE_THREAD)
+			goto out;
+	}
+
+	synchronize_hardirq(irq);
+	events = atomic_xchg(&ctrl->pending_events, 0);
+	if (!events) {
+		ret = IRQ_NONE;
+		goto out;
+	}
+
+	/* Check Attention Button Pressed */
+	if (events & PCI_EXP_SLTSTA_ABP)
+		pciehp_handle_button_press(ctrl);
+
+	/* Check Power Fault Detected */
+	if (events & PCI_EXP_SLTSTA_PFD) {
+		ctrl_err(ctrl, "Slot(%s): Power fault\n", slot_name(ctrl));
+		pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF,
+				      PCI_EXP_SLTCTL_ATTN_IND_ON);
+	}
+
+	/*
+	 * Ignore Link Down/Up events caused by Downstream Port Containment
+	 * if recovery succeeded, or caused by Secondary Bus Reset,
+	 * suspend to D3cold, firmware update, FPGA reconfiguration, etc.
+	 */
+	if ((events & (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC)) &&
+	    (pci_dpc_recovered(pdev) || pci_hp_spurious_link_change(pdev)) &&
+	    ctrl->state == ON_STATE) {
+		u16 ignored_events = PCI_EXP_SLTSTA_DLLSC;
+
+		if (!ctrl->inband_presence_disabled)
+			ignored_events |= events & PCI_EXP_SLTSTA_PDC;
+
+		events &= ~ignored_events;
+		pciehp_ignore_link_change(ctrl, pdev, irq, ignored_events);
+	}
+
+	/*
+	 * Disable requests have higher priority than Presence Detect Changed
+	 * or Data Link Layer State Changed events.
+	 */
+	down_read_nested(&ctrl->reset_lock, ctrl->depth);
+	if (events & DISABLE_SLOT)
+		pciehp_handle_disable_request(ctrl);
+	else if (events & (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC))
+		pciehp_handle_presence_or_link_change(ctrl, events);
+	up_read(&ctrl->reset_lock);
+
+	ret = IRQ_HANDLED;
+out:
+	pci_config_pm_runtime_put(pdev);
+	ctrl->ist_running = false;
+	wake_up(&ctrl->requester);
+	return ret;
+}
+
+static int pciehp_poll(void *data)
+{
+	struct controller *ctrl = data;
+
+	schedule_timeout_idle(10 * HZ); /* start with 10 sec delay */
+
+	while (!kthread_should_stop()) {
+		/* poll for interrupt events or user requests */
+		while (pciehp_isr(IRQ_NOTCONNECTED, ctrl) == IRQ_WAKE_THREAD ||
+		       atomic_read(&ctrl->pending_events))
+			pciehp_ist(IRQ_NOTCONNECTED, ctrl);
+
+		if (pciehp_poll_time <= 0 || pciehp_poll_time > 60)
+			pciehp_poll_time = 2; /* clamp to sane value */
+
+		schedule_timeout_idle(pciehp_poll_time * HZ);
+	}
+
+	return 0;
+}
+
+static inline int pciehp_request_irq(struct controller *ctrl)
+{
+	int retval, irq = ctrl->pcie->irq;
+
+	if (pciehp_poll_mode) {
+		ctrl->poll_thread = kthread_run(&pciehp_poll, ctrl,
+						"pciehp_poll-%s",
+						slot_name(ctrl));
+		return PTR_ERR_OR_ZERO(ctrl->poll_thread);
+	}
+
+	/* Installs the interrupt handler */
+	retval = request_threaded_irq(irq, pciehp_isr, pciehp_ist,
+				      IRQF_SHARED, "pciehp", ctrl);
+	if (retval)
+		ctrl_err(ctrl, "Cannot get irq %d for the hotplug controller\n",
+			 irq);
+	return retval;
+}
+
+static inline void pciehp_free_irq(struct controller *ctrl)
+{
+	if (pciehp_poll_mode)
+		kthread_stop(ctrl->poll_thread);
+	else
+		free_irq(ctrl->pcie->irq, ctrl);
+}
+
+static void pcie_enable_notification(struct controller *ctrl)
+{
+	u16 cmd, mask;
+
+	/*
+	 * TBD: Power fault detected software notification support.
+	 *
+	 * Power fault detected software notification is not enabled
+	 * now, because it caused power fault detected interrupt storm
+	 * on some machines. On those machines, power fault detected
+	 * bit in the slot status register was set again immediately
+	 * when it is cleared in the interrupt service routine, and
+	 * next power fault detected interrupt was notified again.
+	 */
+
+	/*
+	 * Always enable link events: thus link-up and link-down shall
+	 * always be treated as hotplug and unplug respectively. Enable
+	 * presence detect only if Attention Button is not present.
+	 */
+	cmd = PCI_EXP_SLTCTL_DLLSCE;
+	if (ATTN_BUTTN(ctrl))
+		cmd |= PCI_EXP_SLTCTL_ABPE;
+	else
+		cmd |= PCI_EXP_SLTCTL_PDCE;
+	if (!pciehp_poll_mode)
+		cmd |= PCI_EXP_SLTCTL_HPIE;
+	if (!pciehp_poll_mode && !NO_CMD_CMPL(ctrl))
+		cmd |= PCI_EXP_SLTCTL_CCIE;
+
+	mask = (PCI_EXP_SLTCTL_PDCE | PCI_EXP_SLTCTL_ABPE |
+		PCI_EXP_SLTCTL_PFDE |
+		PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_CCIE |
+		PCI_EXP_SLTCTL_DLLSCE);
+
+	pcie_write_cmd_nowait(ctrl, cmd, mask);
+	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
+		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, cmd);
+}
+
+static void pcie_disable_notification(struct controller *ctrl)
+{
+	u16 mask;
+
+	mask = (PCI_EXP_SLTCTL_PDCE | PCI_EXP_SLTCTL_ABPE |
+		PCI_EXP_SLTCTL_MRLSCE | PCI_EXP_SLTCTL_PFDE |
+		PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_CCIE |
+		PCI_EXP_SLTCTL_DLLSCE);
+	pcie_write_cmd(ctrl, 0, mask);
+	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
+		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, 0);
+}
+
+static int pcie_init_notification(struct controller *ctrl)
+{
+	if (pciehp_request_irq(ctrl))
+		return -1;
+	pcie_enable_notification(ctrl);
+	ctrl->notification_enabled = 1;
+	return 0;
+}
+
+static void pcie_shutdown_notification(struct controller *ctrl)
+{
+	if (ctrl->notification_enabled) {
+		pcie_disable_notification(ctrl);
+		pciehp_free_irq(ctrl);
+		ctrl->notification_enabled = 0;
+	}
+}
+
+static int init_slot(struct controller *ctrl)
+{
+	struct hotplug_slot_ops *ops;
+	char name[SLOT_NAME_SIZE];
+	int retval;
+
+	/* Setup hotplug slot ops */
+	ops = kzalloc(sizeof(*ops), GFP_KERNEL);
+	if (!ops)
+		return -ENOMEM;
+
+	ops->enable_slot = pciehp_sysfs_enable_slot;
+	ops->disable_slot = pciehp_sysfs_disable_slot;
+	ops->get_power_status = get_power_status;
+	ops->get_adapter_status = get_adapter_status;
+	ops->reset_slot = pciehp_reset_slot;
+	if (MRL_SENS(ctrl))
+		ops->get_latch_status = get_latch_status;
+	if (ATTN_LED(ctrl)) {
+		ops->get_attention_status = pciehp_get_attention_status;
+		ops->set_attention_status = set_attention_status;
+	} else if (ctrl->pcie->port->hotplug_user_indicators) {
+		ops->get_attention_status = pciehp_get_raw_indicator_status;
+		ops->set_attention_status = pciehp_set_raw_indicator_status;
+	}
+
+	/* register this slot with the hotplug pci core */
+	ctrl->hotplug_slot.ops = ops;
+	snprintf(name, SLOT_NAME_SIZE, "%u", PSN(ctrl));
+
+	retval = pci_hp_initialize(&ctrl->hotplug_slot,
+				   ctrl->pcie->port->subordinate, 0, name);
+	if (retval) {
+		ctrl_err(ctrl, "pci_hp_initialize failed: error %d\n", retval);
+		kfree(ops);
+	}
+	return retval;
+}
+
+static void cleanup_slot(struct controller *ctrl)
+{
+	struct hotplug_slot *hotplug_slot = &ctrl->hotplug_slot;
+
+	pci_hp_destroy(hotplug_slot);
+	kfree(hotplug_slot->ops);
+}
+
+static struct controller *pcie_init(struct pcie_device *dev)
+{
+	struct controller *ctrl;
+	u32 slot_cap, slot_cap2;
+	u8 poweron;
+	struct pci_dev *pdev = dev->port;
+	struct pci_bus *subordinate = pdev->subordinate;
+
+	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
+	if (!ctrl)
+		return NULL;
+
+	ctrl->pcie = dev;
+	ctrl->depth = pcie_hotplug_depth(dev->port);
+	pcie_capability_read_dword(pdev, PCI_EXP_SLTCAP, &slot_cap);
+
+	if (pdev->hotplug_user_indicators)
+		slot_cap &= ~(PCI_EXP_SLTCAP_AIP | PCI_EXP_SLTCAP_PIP);
+
+	/*
+	 * We assume no Thunderbolt controllers support Command Complete events,
+	 * but some controllers falsely claim they do.
+	 */
+	if (pdev->is_thunderbolt)
+		slot_cap |= PCI_EXP_SLTCAP_NCCS;
+
+	ctrl->slot_cap = slot_cap;
+	mutex_init(&ctrl->ctrl_lock);
+	mutex_init(&ctrl->state_lock);
+	init_rwsem(&ctrl->reset_lock);
+	init_waitqueue_head(&ctrl->requester);
+	init_waitqueue_head(&ctrl->queue);
+	INIT_DELAYED_WORK(&ctrl->button_work, pciehp_queue_pushbutton_work);
+	dbg_ctrl(ctrl);
+
+	down_read(&pci_bus_sem);
+	ctrl->state = list_empty(&subordinate->devices) ? OFF_STATE : ON_STATE;
+	up_read(&pci_bus_sem);
+
+	pcie_capability_read_dword(pdev, PCI_EXP_SLTCAP2, &slot_cap2);
+	if (slot_cap2 & PCI_EXP_SLTCAP2_IBPD) {
+		pcie_write_cmd_nowait(ctrl, PCI_EXP_SLTCTL_IBPD_DISABLE,
+				      PCI_EXP_SLTCTL_IBPD_DISABLE);
+		ctrl->inband_presence_disabled = 1;
+	}
+
+	if (dmi_first_match(inband_presence_disabled_dmi_table))
+		ctrl->inband_presence_disabled = 1;
+
+	/* Clear all remaining event bits in Slot Status register. */
+	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
+		PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD |
+		PCI_EXP_SLTSTA_MRLSC | PCI_EXP_SLTSTA_CC |
+		PCI_EXP_SLTSTA_DLLSC | PCI_EXP_SLTSTA_PDC);
+
+	ctrl_info(ctrl, "Slot #%d AttnBtn%c PwrCtrl%c MRL%c AttnInd%c PwrInd%c HotPlug%c Surprise%c Interlock%c NoCompl%c IbPresDis%c LLActRep%c%s\n",
+		FIELD_GET(PCI_EXP_SLTCAP_PSN, slot_cap),
+		FLAG(slot_cap, PCI_EXP_SLTCAP_ABP),
+		FLAG(slot_cap, PCI_EXP_SLTCAP_PCP),
+		FLAG(slot_cap, PCI_EXP_SLTCAP_MRLSP),
+		FLAG(slot_cap, PCI_EXP_SLTCAP_AIP),
+		FLAG(slot_cap, PCI_EXP_SLTCAP_PIP),
+		FLAG(slot_cap, PCI_EXP_SLTCAP_HPC),
+		FLAG(slot_cap, PCI_EXP_SLTCAP_HPS),
+		FLAG(slot_cap, PCI_EXP_SLTCAP_EIP),
+		FLAG(slot_cap, PCI_EXP_SLTCAP_NCCS),
+		FLAG(slot_cap2, PCI_EXP_SLTCAP2_IBPD),
+		FLAG(pdev->link_active_reporting, true),
+		pdev->broken_cmd_compl ? " (with Cmd Compl erratum)" : "");
+
+	/*
+	 * If empty slot's power status is on, turn power off.  The IRQ isn't
+	 * requested yet, so avoid triggering a notification with this command.
+	 */
+	if (POWER_CTRL(ctrl)) {
+		pciehp_get_power_status(ctrl, &poweron);
+		if (!pciehp_card_present_or_link_active(ctrl) && poweron) {
+			pcie_disable_notification(ctrl);
+			pciehp_power_off_slot(ctrl);
+		}
+	}
+
+	pdev = pci_get_slot(subordinate, PCI_DEVFN(0, 0));
+	if (pdev)
+		ctrl->dsn = pci_get_dsn(pdev);
+	pci_dev_put(pdev);
+
+	return ctrl;
+}
+
+static void pciehp_release_ctrl(struct controller *ctrl)
+{
+	cancel_delayed_work_sync(&ctrl->button_work);
+	kfree(ctrl);
+}
+
+static int pciehp_probe(struct pcie_device *dev)
+{
+	int rc;
+	struct controller *ctrl;
+
+	/* If this is not a "hotplug" service, we have no business here. */
+	if (dev->service != PCIE_PORT_SERVICE_HP)
+		return -ENODEV;
+
+	if (!dev->port->subordinate) {
+		/* Can happen if we run out of bus numbers during probe */
+		pci_err(dev->port,
+			"Hotplug bridge without secondary bus, ignoring\n");
+		return -ENODEV;
+	}
+
+	ctrl = pcie_init(dev);
+	if (!ctrl) {
+		pci_err(dev->port, "Controller initialization failed\n");
+		return -ENODEV;
+	}
+	set_service_data(dev, ctrl);
+
+	/* Setup the slot information structures */
+	rc = init_slot(ctrl);
+	if (rc) {
+		if (rc == -EBUSY)
+			ctrl_warn(ctrl, "Slot already registered by another hotplug driver\n");
+		else
+			ctrl_err(ctrl, "Slot initialization failed (%d)\n", rc);
+		goto err_out_release_ctlr;
+	}
+
+	/* Enable events after we have setup the data structures */
+	rc = pcie_init_notification(ctrl);
+	if (rc) {
+		ctrl_err(ctrl, "Notification initialization failed (%d)\n", rc);
+		goto err_out_free_ctrl_slot;
+	}
+
+	/* Publish to user space */
+	rc = pci_hp_add(&ctrl->hotplug_slot);
+	if (rc) {
+		ctrl_err(ctrl, "Publication to user space failed (%d)\n", rc);
+		goto err_out_shutdown_notification;
+	}
+
+	pciehp_check_presence(ctrl);
+
+	return 0;
+
+err_out_shutdown_notification:
+	pcie_shutdown_notification(ctrl);
+err_out_free_ctrl_slot:
+	cleanup_slot(ctrl);
+err_out_release_ctlr:
+	pciehp_release_ctrl(ctrl);
+	return -ENODEV;
+}
+
+static void pciehp_remove(struct pcie_device *dev)
+{
+	struct controller *ctrl = get_service_data(dev);
+
+	pci_hp_del(&ctrl->hotplug_slot);
+	pcie_shutdown_notification(ctrl);
+	cleanup_slot(ctrl);
+	pciehp_release_ctrl(ctrl);
+}
+
+#ifdef CONFIG_PM
+static void pcie_clear_hotplug_events(struct controller *ctrl)
+{
+	pcie_capability_write_word(ctrl_dev(ctrl), PCI_EXP_SLTSTA,
+				   PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC);
+}
+
+static void pcie_enable_interrupt(struct controller *ctrl)
+{
+	u16 mask;
+
+	mask = PCI_EXP_SLTCTL_DLLSCE;
+	if (!pciehp_poll_mode)
+		mask |= PCI_EXP_SLTCTL_HPIE;
+	pcie_write_cmd(ctrl, mask, mask);
+}
+
+static void pcie_disable_interrupt(struct controller *ctrl)
+{
+	u16 mask;
+
+	/*
+	 * Mask hot-plug interrupt to prevent it triggering immediately
+	 * when the link goes inactive (we still get PME when any of the
+	 * enabled events is detected). Same goes with Link Layer State
+	 * changed event which generates PME immediately when the link goes
+	 * inactive so mask it as well.
+	 */
+	mask = PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_DLLSCE;
+	pcie_write_cmd(ctrl, 0, mask);
+}
+
+static bool pme_is_native(struct pcie_device *dev)
+{
+	const struct pci_host_bridge *host;
+
+	host = pci_find_host_bridge(dev->port->bus);
+	return pcie_ports_native || host->native_pme;
+}
+
+static void pciehp_disable_interrupt(struct pcie_device *dev)
+{
+	/*
+	 * Disable hotplug interrupt so that it does not trigger
+	 * immediately when the downstream link goes down.
+	 */
+	if (pme_is_native(dev))
+		pcie_disable_interrupt(get_service_data(dev));
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int pciehp_suspend(struct pcie_device *dev)
+{
+	/*
+	 * If the port is already runtime suspended we can keep it that
+	 * way.
+	 */
+	if (dev_pm_skip_suspend(&dev->port->dev))
+		return 0;
+
+	pciehp_disable_interrupt(dev);
+	return 0;
+}
+
+static int pciehp_resume_noirq(struct pcie_device *dev)
+{
+	struct controller *ctrl = get_service_data(dev);
+
+	/* pci_restore_state() just wrote to the Slot Control register */
+	ctrl->cmd_started = jiffies;
+	ctrl->cmd_busy = true;
+
+	/* clear spurious events from rediscovery of inserted card */
+	if (ctrl->state == ON_STATE || ctrl->state == BLINKINGOFF_STATE) {
+		pcie_clear_hotplug_events(ctrl);
+
+		/*
+		 * If hotplugged device was replaced with a different one
+		 * during system sleep, mark the old device disconnected
+		 * (to prevent its driver from accessing the new device)
+		 * and synthesize a Presence Detect Changed event.
+		 */
+		if (pciehp_device_replaced(ctrl)) {
+			ctrl_dbg(ctrl, "device replaced during system sleep\n");
+			pci_walk_bus(ctrl->pcie->port->subordinate,
+				     pci_dev_set_disconnected, NULL);
+			pciehp_request(ctrl, PCI_EXP_SLTSTA_PDC);
+		}
+	}
+
+	return 0;
+}
+#endif
+
+static int pciehp_resume(struct pcie_device *dev)
+{
+	struct controller *ctrl = get_service_data(dev);
+
+	if (pme_is_native(dev))
+		pcie_enable_interrupt(ctrl);
+
+	pciehp_check_presence(ctrl);
+
+	return 0;
+}
+
+static int pciehp_runtime_suspend(struct pcie_device *dev)
+{
+	pciehp_disable_interrupt(dev);
+	return 0;
+}
+
+static int pciehp_runtime_resume(struct pcie_device *dev)
+{
+	struct controller *ctrl = get_service_data(dev);
+
+	/* pci_restore_state() just wrote to the Slot Control register */
+	ctrl->cmd_started = jiffies;
+	ctrl->cmd_busy = true;
+
+	/* clear spurious events from rediscovery of inserted card */
+	if ((ctrl->state == ON_STATE || ctrl->state == BLINKINGOFF_STATE) &&
+	     pme_is_native(dev))
+		pcie_clear_hotplug_events(ctrl);
+
+	return pciehp_resume(dev);
+}
+#endif /* PM */
+
+static struct pcie_port_service_driver hpdriver_portdrv = {
+	.name		= "pciehp",
+	.port_type	= PCIE_ANY_PORT,
+	.service	= PCIE_PORT_SERVICE_HP,
+
+	.probe		= pciehp_probe,
+	.remove		= pciehp_remove,
+
+#ifdef	CONFIG_PM
+#ifdef	CONFIG_PM_SLEEP
+	.suspend	= pciehp_suspend,
+	.resume_noirq	= pciehp_resume_noirq,
+	.resume		= pciehp_resume,
+#endif
+	.runtime_suspend = pciehp_runtime_suspend,
+	.runtime_resume	= pciehp_runtime_resume,
+#endif	/* PM */
+
+	.slot_reset	= pciehp_slot_reset,
+};
+
+int __init pcie_hp_init(void)
+{
+	int retval = 0;
+
+	retval = pcie_port_service_register(&hpdriver_portdrv);
+	pr_debug("pcie_port_service_register = %d\n", retval);
+	if (retval)
+		pr_debug("Failure to register service\n");
+
+	return retval;
+}
+
+static void quirk_cmd_compl(struct pci_dev *pdev)
+{
+	u32 slot_cap;
+
+	if (pci_is_pcie(pdev)) {
+		pcie_capability_read_dword(pdev, PCI_EXP_SLTCAP, &slot_cap);
+		if (slot_cap & PCI_EXP_SLTCAP_HPC &&
+		    !(slot_cap & PCI_EXP_SLTCAP_NCCS))
+			pdev->broken_cmd_compl = 1;
+	}
+}
+
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
+			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_QCOM, 0x010e,
+			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_QCOM, 0x0110,
+			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_QCOM, 0x0400,
+			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_QCOM, 0x0401,
+			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_HXT, 0x0401,
+			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
deleted file mode 100644
index debc79b0adfb..000000000000
--- a/drivers/pci/hotplug/pciehp.h
+++ /dev/null
@@ -1,212 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * PCI Express Hot Plug Controller Driver
- *
- * Copyright (C) 1995,2001 Compaq Computer Corporation
- * Copyright (C) 2001 Greg Kroah-Hartman (greg@kroah.com)
- * Copyright (C) 2001 IBM Corp.
- * Copyright (C) 2003-2004 Intel Corporation
- *
- * All rights reserved.
- *
- * Send feedback to <greg@kroah.com>, <kristen.c.accardi@intel.com>
- *
- */
-#ifndef _PCIEHP_H
-#define _PCIEHP_H
-
-#include <linux/types.h>
-#include <linux/pci.h>
-#include <linux/pci_hotplug.h>
-#include <linux/delay.h>
-#include <linux/mutex.h>
-#include <linux/rwsem.h>
-#include <linux/workqueue.h>
-
-#include "../pcie/portdrv.h"
-
-extern bool pciehp_poll_mode;
-extern int pciehp_poll_time;
-
-/*
- * Set CONFIG_DYNAMIC_DEBUG=y and boot with 'dyndbg="file pciehp* +p"' to
- * enable debug messages.
- */
-#define ctrl_dbg(ctrl, format, arg...)					\
-	pci_dbg(ctrl->pcie->port, format, ## arg)
-#define ctrl_err(ctrl, format, arg...)					\
-	pci_err(ctrl->pcie->port, format, ## arg)
-#define ctrl_info(ctrl, format, arg...)					\
-	pci_info(ctrl->pcie->port, format, ## arg)
-#define ctrl_warn(ctrl, format, arg...)					\
-	pci_warn(ctrl->pcie->port, format, ## arg)
-
-#define SLOT_NAME_SIZE 10
-
-/**
- * struct controller - PCIe hotplug controller
- * @pcie: pointer to the controller's PCIe port service device
- * @dsn: cached copy of Device Serial Number of Function 0 in the hotplug slot
- *	(PCIe r6.2 sec 7.9.3); used to determine whether a hotplugged device
- *	was replaced with a different one during system sleep
- * @slot_cap: cached copy of the Slot Capabilities register
- * @inband_presence_disabled: In-Band Presence Detect Disable supported by
- *	controller and disabled per spec recommendation (PCIe r5.0, appendix I
- *	implementation note)
- * @slot_ctrl: cached copy of the Slot Control register
- * @ctrl_lock: serializes writes to the Slot Control register
- * @cmd_started: jiffies when the Slot Control register was last written;
- *	the next write is allowed 1 second later, absent a Command Completed
- *	interrupt (PCIe r4.0, sec 6.7.3.2)
- * @cmd_busy: flag set on Slot Control register write, cleared by IRQ handler
- *	on reception of a Command Completed event
- * @queue: wait queue to wake up on reception of a Command Completed event,
- *	used for synchronous writes to the Slot Control register
- * @pending_events: used by the IRQ handler to save events retrieved from the
- *	Slot Status register for later consumption by the IRQ thread
- * @notification_enabled: whether the IRQ was requested successfully
- * @power_fault_detected: whether a power fault was detected by the hardware
- *	that has not yet been cleared by the user
- * @poll_thread: thread to poll for slot events if no IRQ is available,
- *	enabled with pciehp_poll_mode module parameter
- * @state: current state machine position
- * @state_lock: protects reads and writes of @state;
- *	protects scheduling, execution and cancellation of @button_work
- * @button_work: work item to turn the slot on or off after 5 seconds
- *	in response to an Attention Button press
- * @hotplug_slot: structure registered with the PCI hotplug core
- * @reset_lock: prevents access to the Data Link Layer Link Active bit in the
- *	Link Status register and to the Presence Detect State bit in the Slot
- *	Status register during a slot reset which may cause them to flap
- * @depth: Number of additional hotplug ports in the path to the root bus,
- *	used as lock subclass for @reset_lock
- * @ist_running: flag to keep user request waiting while IRQ thread is running
- * @request_result: result of last user request submitted to the IRQ thread
- * @requester: wait queue to wake up on completion of user request,
- *	used for synchronous slot enable/disable request via sysfs
- *
- * PCIe hotplug has a 1:1 relationship between controller and slot, hence
- * unlike other drivers, the two aren't represented by separate structures.
- */
-struct controller {
-	struct pcie_device *pcie;
-	u64 dsn;
-
-	u32 slot_cap;				/* capabilities and quirks */
-	unsigned int inband_presence_disabled:1;
-
-	u16 slot_ctrl;				/* control register access */
-	struct mutex ctrl_lock;
-	unsigned long cmd_started;
-	unsigned int cmd_busy:1;
-	wait_queue_head_t queue;
-
-	atomic_t pending_events;		/* event handling */
-	unsigned int notification_enabled:1;
-	unsigned int power_fault_detected;
-	struct task_struct *poll_thread;
-
-	u8 state;				/* state machine */
-	struct mutex state_lock;
-	struct delayed_work button_work;
-
-	struct hotplug_slot hotplug_slot;	/* hotplug core interface */
-	struct rw_semaphore reset_lock;
-	unsigned int depth;
-	unsigned int ist_running;
-	int request_result;
-	wait_queue_head_t requester;
-};
-
-/**
- * DOC: Slot state
- *
- * @OFF_STATE: slot is powered off, no subordinate devices are enumerated
- * @BLINKINGON_STATE: slot will be powered on after the 5 second delay,
- *	Power Indicator is blinking
- * @BLINKINGOFF_STATE: slot will be powered off after the 5 second delay,
- *	Power Indicator is blinking
- * @POWERON_STATE: slot is currently powering on
- * @POWEROFF_STATE: slot is currently powering off
- * @ON_STATE: slot is powered on, subordinate devices have been enumerated
- */
-#define OFF_STATE			0
-#define BLINKINGON_STATE		1
-#define BLINKINGOFF_STATE		2
-#define POWERON_STATE			3
-#define POWEROFF_STATE			4
-#define ON_STATE			5
-
-/**
- * DOC: Flags to request an action from the IRQ thread
- *
- * These are stored together with events read from the Slot Status register,
- * hence must be greater than its 16-bit width.
- *
- * %DISABLE_SLOT: Disable the slot in response to a user request via sysfs or
- *	an Attention Button press after the 5 second delay
- * %RERUN_ISR: Used by the IRQ handler to inform the IRQ thread that the
- *	hotplug port was inaccessible when the interrupt occurred, requiring
- *	that the IRQ handler is rerun by the IRQ thread after it has made the
- *	hotplug port accessible by runtime resuming its parents to D0
- */
-#define DISABLE_SLOT		(1 << 16)
-#define RERUN_ISR		(1 << 17)
-
-#define ATTN_BUTTN(ctrl)	((ctrl)->slot_cap & PCI_EXP_SLTCAP_ABP)
-#define POWER_CTRL(ctrl)	((ctrl)->slot_cap & PCI_EXP_SLTCAP_PCP)
-#define MRL_SENS(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_MRLSP)
-#define ATTN_LED(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_AIP)
-#define PWR_LED(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_PIP)
-#define NO_CMD_CMPL(ctrl)	((ctrl)->slot_cap & PCI_EXP_SLTCAP_NCCS)
-#define PSN(ctrl)		(((ctrl)->slot_cap & PCI_EXP_SLTCAP_PSN) >> 19)
-
-void pciehp_request(struct controller *ctrl, int action);
-void pciehp_handle_button_press(struct controller *ctrl);
-void pciehp_handle_disable_request(struct controller *ctrl);
-void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events);
-int pciehp_configure_device(struct controller *ctrl);
-void pciehp_unconfigure_device(struct controller *ctrl, bool presence);
-void pciehp_queue_pushbutton_work(struct work_struct *work);
-struct controller *pcie_init(struct pcie_device *dev);
-int pcie_init_notification(struct controller *ctrl);
-void pcie_shutdown_notification(struct controller *ctrl);
-void pcie_clear_hotplug_events(struct controller *ctrl);
-void pcie_enable_interrupt(struct controller *ctrl);
-void pcie_disable_interrupt(struct controller *ctrl);
-int pciehp_power_on_slot(struct controller *ctrl);
-void pciehp_power_off_slot(struct controller *ctrl);
-void pciehp_get_power_status(struct controller *ctrl, u8 *status);
-
-#define INDICATOR_NOOP -1	/* Leave indicator unchanged */
-void pciehp_set_indicators(struct controller *ctrl, int pwr, int attn);
-
-void pciehp_get_latch_status(struct controller *ctrl, u8 *status);
-int pciehp_query_power_fault(struct controller *ctrl);
-int pciehp_card_present(struct controller *ctrl);
-int pciehp_card_present_or_link_active(struct controller *ctrl);
-int pciehp_check_link_status(struct controller *ctrl);
-int pciehp_check_link_active(struct controller *ctrl);
-bool pciehp_device_replaced(struct controller *ctrl);
-void pciehp_release_ctrl(struct controller *ctrl);
-
-int pciehp_sysfs_enable_slot(struct hotplug_slot *hotplug_slot);
-int pciehp_sysfs_disable_slot(struct hotplug_slot *hotplug_slot);
-int pciehp_reset_slot(struct hotplug_slot *hotplug_slot, bool probe);
-int pciehp_get_attention_status(struct hotplug_slot *hotplug_slot, u8 *status);
-int pciehp_set_raw_indicator_status(struct hotplug_slot *h_slot, u8 status);
-int pciehp_get_raw_indicator_status(struct hotplug_slot *h_slot, u8 *status);
-
-int pciehp_slot_reset(struct pcie_device *dev);
-
-static inline const char *slot_name(struct controller *ctrl)
-{
-	return hotplug_slot_name(&ctrl->hotplug_slot);
-}
-
-static inline struct controller *to_ctrl(struct hotplug_slot *hotplug_slot)
-{
-	return container_of(hotplug_slot, struct controller, hotplug_slot);
-}
-
-#endif				/* _PCIEHP_H */
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
deleted file mode 100644
index f59baa912970..000000000000
--- a/drivers/pci/hotplug/pciehp_core.c
+++ /dev/null
@@ -1,383 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * PCI Express Hot Plug Controller Driver
- *
- * Copyright (C) 1995,2001 Compaq Computer Corporation
- * Copyright (C) 2001 Greg Kroah-Hartman (greg@kroah.com)
- * Copyright (C) 2001 IBM Corp.
- * Copyright (C) 2003-2004 Intel Corporation
- *
- * All rights reserved.
- *
- * Send feedback to <greg@kroah.com>, <kristen.c.accardi@intel.com>
- *
- * Authors:
- *   Dan Zink <dan.zink@compaq.com>
- *   Greg Kroah-Hartman <greg@kroah.com>
- *   Dely Sy <dely.l.sy@intel.com>"
- */
-
-#define pr_fmt(fmt) "pciehp: " fmt
-#define dev_fmt pr_fmt
-
-#include <linux/bitfield.h>
-#include <linux/moduleparam.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/types.h>
-#include <linux/pci.h>
-#include "pciehp.h"
-
-#include "../pci.h"
-
-/* Global variables */
-bool pciehp_poll_mode;
-int pciehp_poll_time;
-
-/*
- * not really modular, but the easiest way to keep compat with existing
- * bootargs behaviour is to continue using module_param here.
- */
-module_param(pciehp_poll_mode, bool, 0644);
-module_param(pciehp_poll_time, int, 0644);
-MODULE_PARM_DESC(pciehp_poll_mode, "Using polling mechanism for hot-plug events or not");
-MODULE_PARM_DESC(pciehp_poll_time, "Polling mechanism frequency, in seconds");
-
-static int set_attention_status(struct hotplug_slot *slot, u8 value);
-static int get_power_status(struct hotplug_slot *slot, u8 *value);
-static int get_latch_status(struct hotplug_slot *slot, u8 *value);
-static int get_adapter_status(struct hotplug_slot *slot, u8 *value);
-
-static int init_slot(struct controller *ctrl)
-{
-	struct hotplug_slot_ops *ops;
-	char name[SLOT_NAME_SIZE];
-	int retval;
-
-	/* Setup hotplug slot ops */
-	ops = kzalloc(sizeof(*ops), GFP_KERNEL);
-	if (!ops)
-		return -ENOMEM;
-
-	ops->enable_slot = pciehp_sysfs_enable_slot;
-	ops->disable_slot = pciehp_sysfs_disable_slot;
-	ops->get_power_status = get_power_status;
-	ops->get_adapter_status = get_adapter_status;
-	ops->reset_slot = pciehp_reset_slot;
-	if (MRL_SENS(ctrl))
-		ops->get_latch_status = get_latch_status;
-	if (ATTN_LED(ctrl)) {
-		ops->get_attention_status = pciehp_get_attention_status;
-		ops->set_attention_status = set_attention_status;
-	} else if (ctrl->pcie->port->hotplug_user_indicators) {
-		ops->get_attention_status = pciehp_get_raw_indicator_status;
-		ops->set_attention_status = pciehp_set_raw_indicator_status;
-	}
-
-	/* register this slot with the hotplug pci core */
-	ctrl->hotplug_slot.ops = ops;
-	snprintf(name, SLOT_NAME_SIZE, "%u", PSN(ctrl));
-
-	retval = pci_hp_initialize(&ctrl->hotplug_slot,
-				   ctrl->pcie->port->subordinate, 0, name);
-	if (retval) {
-		ctrl_err(ctrl, "pci_hp_initialize failed: error %d\n", retval);
-		kfree(ops);
-	}
-	return retval;
-}
-
-static void cleanup_slot(struct controller *ctrl)
-{
-	struct hotplug_slot *hotplug_slot = &ctrl->hotplug_slot;
-
-	pci_hp_destroy(hotplug_slot);
-	kfree(hotplug_slot->ops);
-}
-
-/*
- * set_attention_status - Turns the Attention Indicator on, off or blinking
- */
-static int set_attention_status(struct hotplug_slot *hotplug_slot, u8 status)
-{
-	struct controller *ctrl = to_ctrl(hotplug_slot);
-	struct pci_dev *pdev = ctrl->pcie->port;
-
-	if (status)
-		status = FIELD_PREP(PCI_EXP_SLTCTL_AIC, status);
-	else
-		status = PCI_EXP_SLTCTL_ATTN_IND_OFF;
-
-	pci_config_pm_runtime_get(pdev);
-	pciehp_set_indicators(ctrl, INDICATOR_NOOP, status);
-	pci_config_pm_runtime_put(pdev);
-	return 0;
-}
-
-static int get_power_status(struct hotplug_slot *hotplug_slot, u8 *value)
-{
-	struct controller *ctrl = to_ctrl(hotplug_slot);
-	struct pci_dev *pdev = ctrl->pcie->port;
-
-	pci_config_pm_runtime_get(pdev);
-	pciehp_get_power_status(ctrl, value);
-	pci_config_pm_runtime_put(pdev);
-	return 0;
-}
-
-static int get_latch_status(struct hotplug_slot *hotplug_slot, u8 *value)
-{
-	struct controller *ctrl = to_ctrl(hotplug_slot);
-	struct pci_dev *pdev = ctrl->pcie->port;
-
-	pci_config_pm_runtime_get(pdev);
-	pciehp_get_latch_status(ctrl, value);
-	pci_config_pm_runtime_put(pdev);
-	return 0;
-}
-
-static int get_adapter_status(struct hotplug_slot *hotplug_slot, u8 *value)
-{
-	struct controller *ctrl = to_ctrl(hotplug_slot);
-	struct pci_dev *pdev = ctrl->pcie->port;
-	int ret;
-
-	pci_config_pm_runtime_get(pdev);
-	ret = pciehp_card_present_or_link_active(ctrl);
-	pci_config_pm_runtime_put(pdev);
-	if (ret < 0)
-		return ret;
-
-	*value = ret;
-	return 0;
-}
-
-/**
- * pciehp_check_presence() - synthesize event if presence has changed
- * @ctrl: controller to check
- *
- * On probe and resume, an explicit presence check is necessary to bring up an
- * occupied slot or bring down an unoccupied slot.  This can't be triggered by
- * events in the Slot Status register, they may be stale and are therefore
- * cleared.  Secondly, sending an interrupt for "events that occur while
- * interrupt generation is disabled [when] interrupt generation is subsequently
- * enabled" is optional per PCIe r4.0, sec 6.7.3.4.
- */
-static void pciehp_check_presence(struct controller *ctrl)
-{
-	int occupied;
-
-	down_read_nested(&ctrl->reset_lock, ctrl->depth);
-	mutex_lock(&ctrl->state_lock);
-
-	occupied = pciehp_card_present_or_link_active(ctrl);
-	if ((occupied > 0 && (ctrl->state == OFF_STATE ||
-			  ctrl->state == BLINKINGON_STATE)) ||
-	    (!occupied && (ctrl->state == ON_STATE ||
-			   ctrl->state == BLINKINGOFF_STATE)))
-		pciehp_request(ctrl, PCI_EXP_SLTSTA_PDC);
-
-	mutex_unlock(&ctrl->state_lock);
-	up_read(&ctrl->reset_lock);
-}
-
-static int pciehp_probe(struct pcie_device *dev)
-{
-	int rc;
-	struct controller *ctrl;
-
-	/* If this is not a "hotplug" service, we have no business here. */
-	if (dev->service != PCIE_PORT_SERVICE_HP)
-		return -ENODEV;
-
-	if (!dev->port->subordinate) {
-		/* Can happen if we run out of bus numbers during probe */
-		pci_err(dev->port,
-			"Hotplug bridge without secondary bus, ignoring\n");
-		return -ENODEV;
-	}
-
-	ctrl = pcie_init(dev);
-	if (!ctrl) {
-		pci_err(dev->port, "Controller initialization failed\n");
-		return -ENODEV;
-	}
-	set_service_data(dev, ctrl);
-
-	/* Setup the slot information structures */
-	rc = init_slot(ctrl);
-	if (rc) {
-		if (rc == -EBUSY)
-			ctrl_warn(ctrl, "Slot already registered by another hotplug driver\n");
-		else
-			ctrl_err(ctrl, "Slot initialization failed (%d)\n", rc);
-		goto err_out_release_ctlr;
-	}
-
-	/* Enable events after we have setup the data structures */
-	rc = pcie_init_notification(ctrl);
-	if (rc) {
-		ctrl_err(ctrl, "Notification initialization failed (%d)\n", rc);
-		goto err_out_free_ctrl_slot;
-	}
-
-	/* Publish to user space */
-	rc = pci_hp_add(&ctrl->hotplug_slot);
-	if (rc) {
-		ctrl_err(ctrl, "Publication to user space failed (%d)\n", rc);
-		goto err_out_shutdown_notification;
-	}
-
-	pciehp_check_presence(ctrl);
-
-	return 0;
-
-err_out_shutdown_notification:
-	pcie_shutdown_notification(ctrl);
-err_out_free_ctrl_slot:
-	cleanup_slot(ctrl);
-err_out_release_ctlr:
-	pciehp_release_ctrl(ctrl);
-	return -ENODEV;
-}
-
-static void pciehp_remove(struct pcie_device *dev)
-{
-	struct controller *ctrl = get_service_data(dev);
-
-	pci_hp_del(&ctrl->hotplug_slot);
-	pcie_shutdown_notification(ctrl);
-	cleanup_slot(ctrl);
-	pciehp_release_ctrl(ctrl);
-}
-
-#ifdef CONFIG_PM
-static bool pme_is_native(struct pcie_device *dev)
-{
-	const struct pci_host_bridge *host;
-
-	host = pci_find_host_bridge(dev->port->bus);
-	return pcie_ports_native || host->native_pme;
-}
-
-static void pciehp_disable_interrupt(struct pcie_device *dev)
-{
-	/*
-	 * Disable hotplug interrupt so that it does not trigger
-	 * immediately when the downstream link goes down.
-	 */
-	if (pme_is_native(dev))
-		pcie_disable_interrupt(get_service_data(dev));
-}
-
-#ifdef CONFIG_PM_SLEEP
-static int pciehp_suspend(struct pcie_device *dev)
-{
-	/*
-	 * If the port is already runtime suspended we can keep it that
-	 * way.
-	 */
-	if (dev_pm_skip_suspend(&dev->port->dev))
-		return 0;
-
-	pciehp_disable_interrupt(dev);
-	return 0;
-}
-
-static int pciehp_resume_noirq(struct pcie_device *dev)
-{
-	struct controller *ctrl = get_service_data(dev);
-
-	/* pci_restore_state() just wrote to the Slot Control register */
-	ctrl->cmd_started = jiffies;
-	ctrl->cmd_busy = true;
-
-	/* clear spurious events from rediscovery of inserted card */
-	if (ctrl->state == ON_STATE || ctrl->state == BLINKINGOFF_STATE) {
-		pcie_clear_hotplug_events(ctrl);
-
-		/*
-		 * If hotplugged device was replaced with a different one
-		 * during system sleep, mark the old device disconnected
-		 * (to prevent its driver from accessing the new device)
-		 * and synthesize a Presence Detect Changed event.
-		 */
-		if (pciehp_device_replaced(ctrl)) {
-			ctrl_dbg(ctrl, "device replaced during system sleep\n");
-			pci_walk_bus(ctrl->pcie->port->subordinate,
-				     pci_dev_set_disconnected, NULL);
-			pciehp_request(ctrl, PCI_EXP_SLTSTA_PDC);
-		}
-	}
-
-	return 0;
-}
-#endif
-
-static int pciehp_resume(struct pcie_device *dev)
-{
-	struct controller *ctrl = get_service_data(dev);
-
-	if (pme_is_native(dev))
-		pcie_enable_interrupt(ctrl);
-
-	pciehp_check_presence(ctrl);
-
-	return 0;
-}
-
-static int pciehp_runtime_suspend(struct pcie_device *dev)
-{
-	pciehp_disable_interrupt(dev);
-	return 0;
-}
-
-static int pciehp_runtime_resume(struct pcie_device *dev)
-{
-	struct controller *ctrl = get_service_data(dev);
-
-	/* pci_restore_state() just wrote to the Slot Control register */
-	ctrl->cmd_started = jiffies;
-	ctrl->cmd_busy = true;
-
-	/* clear spurious events from rediscovery of inserted card */
-	if ((ctrl->state == ON_STATE || ctrl->state == BLINKINGOFF_STATE) &&
-	     pme_is_native(dev))
-		pcie_clear_hotplug_events(ctrl);
-
-	return pciehp_resume(dev);
-}
-#endif /* PM */
-
-static struct pcie_port_service_driver hpdriver_portdrv = {
-	.name		= "pciehp",
-	.port_type	= PCIE_ANY_PORT,
-	.service	= PCIE_PORT_SERVICE_HP,
-
-	.probe		= pciehp_probe,
-	.remove		= pciehp_remove,
-
-#ifdef	CONFIG_PM
-#ifdef	CONFIG_PM_SLEEP
-	.suspend	= pciehp_suspend,
-	.resume_noirq	= pciehp_resume_noirq,
-	.resume		= pciehp_resume,
-#endif
-	.runtime_suspend = pciehp_runtime_suspend,
-	.runtime_resume	= pciehp_runtime_resume,
-#endif	/* PM */
-
-	.slot_reset	= pciehp_slot_reset,
-};
-
-int __init pcie_hp_init(void)
-{
-	int retval = 0;
-
-	retval = pcie_port_service_register(&hpdriver_portdrv);
-	pr_debug("pcie_port_service_register = %d\n", retval);
-	if (retval)
-		pr_debug("Failure to register service\n");
-
-	return retval;
-}
diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
deleted file mode 100644
index d603a7aa7483..000000000000
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ /dev/null
@@ -1,445 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * PCI Express Hot Plug Controller Driver
- *
- * Copyright (C) 1995,2001 Compaq Computer Corporation
- * Copyright (C) 2001 Greg Kroah-Hartman (greg@kroah.com)
- * Copyright (C) 2001 IBM Corp.
- * Copyright (C) 2003-2004 Intel Corporation
- *
- * All rights reserved.
- *
- * Send feedback to <greg@kroah.com>, <kristen.c.accardi@intel.com>
- *
- */
-
-#define dev_fmt(fmt) "pciehp: " fmt
-
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/pm_runtime.h>
-#include <linux/pci.h>
-
-#include "../pci.h"
-#include "pciehp.h"
-
-/* The following routines constitute the bulk of the
-   hotplug controller logic
- */
-
-#define SAFE_REMOVAL	 true
-#define SURPRISE_REMOVAL false
-
-static void set_slot_off(struct controller *ctrl)
-{
-	/*
-	 * Turn off slot, turn on attention indicator, turn off power
-	 * indicator
-	 */
-	if (POWER_CTRL(ctrl)) {
-		pciehp_power_off_slot(ctrl);
-
-		/*
-		 * After turning power off, we must wait for at least 1 second
-		 * before taking any action that relies on power having been
-		 * removed from the slot/adapter.
-		 */
-		msleep(1000);
-	}
-
-	pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF,
-			      PCI_EXP_SLTCTL_ATTN_IND_ON);
-}
-
-/**
- * board_added - Called after a board has been added to the system.
- * @ctrl: PCIe hotplug controller where board is added
- *
- * Turns power on for the board.
- * Configures board.
- */
-static int board_added(struct controller *ctrl)
-{
-	int retval = 0;
-	struct pci_bus *parent = ctrl->pcie->port->subordinate;
-
-	if (POWER_CTRL(ctrl)) {
-		/* Power on slot */
-		retval = pciehp_power_on_slot(ctrl);
-		if (retval)
-			return retval;
-	}
-
-	pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_BLINK,
-			      INDICATOR_NOOP);
-
-	/* Check link training status */
-	retval = pciehp_check_link_status(ctrl);
-	if (retval)
-		goto err_exit;
-
-	/* Check for a power fault */
-	if (ctrl->power_fault_detected || pciehp_query_power_fault(ctrl)) {
-		ctrl_err(ctrl, "Slot(%s): Power fault\n", slot_name(ctrl));
-		retval = -EIO;
-		goto err_exit;
-	}
-
-	retval = pciehp_configure_device(ctrl);
-	if (retval) {
-		if (retval != -EEXIST) {
-			ctrl_err(ctrl, "Cannot add device at %04x:%02x:00\n",
-				 pci_domain_nr(parent), parent->number);
-			goto err_exit;
-		}
-	}
-
-	pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_ON,
-			      PCI_EXP_SLTCTL_ATTN_IND_OFF);
-	return 0;
-
-err_exit:
-	set_slot_off(ctrl);
-	return retval;
-}
-
-/**
- * remove_board - Turn off slot and Power Indicator
- * @ctrl: PCIe hotplug controller where board is being removed
- * @safe_removal: whether the board is safely removed (versus surprise removed)
- */
-static void remove_board(struct controller *ctrl, bool safe_removal)
-{
-	pciehp_unconfigure_device(ctrl, safe_removal);
-
-	if (POWER_CTRL(ctrl)) {
-		pciehp_power_off_slot(ctrl);
-
-		/*
-		 * After turning power off, we must wait for at least 1 second
-		 * before taking any action that relies on power having been
-		 * removed from the slot/adapter.
-		 */
-		msleep(1000);
-
-		/* Ignore link or presence changes caused by power off */
-		atomic_and(~(PCI_EXP_SLTSTA_DLLSC | PCI_EXP_SLTSTA_PDC),
-			   &ctrl->pending_events);
-	}
-
-	pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF,
-			      INDICATOR_NOOP);
-
-	/* Don't carry LBMS indications across */
-	pcie_reset_lbms_count(ctrl->pcie->port);
-}
-
-static int pciehp_enable_slot(struct controller *ctrl);
-static int pciehp_disable_slot(struct controller *ctrl, bool safe_removal);
-
-void pciehp_request(struct controller *ctrl, int action)
-{
-	atomic_or(action, &ctrl->pending_events);
-	if (!pciehp_poll_mode)
-		irq_wake_thread(ctrl->pcie->irq, ctrl);
-}
-
-void pciehp_queue_pushbutton_work(struct work_struct *work)
-{
-	struct controller *ctrl = container_of(work, struct controller,
-					       button_work.work);
-
-	mutex_lock(&ctrl->state_lock);
-	switch (ctrl->state) {
-	case BLINKINGOFF_STATE:
-		pciehp_request(ctrl, DISABLE_SLOT);
-		break;
-	case BLINKINGON_STATE:
-		pciehp_request(ctrl, PCI_EXP_SLTSTA_PDC);
-		break;
-	default:
-		break;
-	}
-	mutex_unlock(&ctrl->state_lock);
-}
-
-void pciehp_handle_button_press(struct controller *ctrl)
-{
-	mutex_lock(&ctrl->state_lock);
-	switch (ctrl->state) {
-	case OFF_STATE:
-	case ON_STATE:
-		if (ctrl->state == ON_STATE) {
-			ctrl->state = BLINKINGOFF_STATE;
-			ctrl_info(ctrl, "Slot(%s): Button press: will power off in 5 sec\n",
-				  slot_name(ctrl));
-		} else {
-			ctrl->state = BLINKINGON_STATE;
-			ctrl_info(ctrl, "Slot(%s): Button press: will power on in 5 sec\n",
-				  slot_name(ctrl));
-		}
-		/* blink power indicator and turn off attention */
-		pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_BLINK,
-				      PCI_EXP_SLTCTL_ATTN_IND_OFF);
-		schedule_delayed_work(&ctrl->button_work, 5 * HZ);
-		break;
-	case BLINKINGOFF_STATE:
-	case BLINKINGON_STATE:
-		/*
-		 * Cancel if we are still blinking; this means that we
-		 * press the attention again before the 5 sec. limit
-		 * expires to cancel hot-add or hot-remove
-		 */
-		cancel_delayed_work(&ctrl->button_work);
-		if (ctrl->state == BLINKINGOFF_STATE) {
-			ctrl->state = ON_STATE;
-			pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_ON,
-					      PCI_EXP_SLTCTL_ATTN_IND_OFF);
-			ctrl_info(ctrl, "Slot(%s): Button press: canceling request to power off\n",
-				  slot_name(ctrl));
-		} else {
-			ctrl->state = OFF_STATE;
-			pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF,
-					      PCI_EXP_SLTCTL_ATTN_IND_OFF);
-			ctrl_info(ctrl, "Slot(%s): Button press: canceling request to power on\n",
-				  slot_name(ctrl));
-		}
-		break;
-	default:
-		ctrl_err(ctrl, "Slot(%s): Button press: ignoring invalid state %#x\n",
-			 slot_name(ctrl), ctrl->state);
-		break;
-	}
-	mutex_unlock(&ctrl->state_lock);
-}
-
-void pciehp_handle_disable_request(struct controller *ctrl)
-{
-	mutex_lock(&ctrl->state_lock);
-	switch (ctrl->state) {
-	case BLINKINGON_STATE:
-	case BLINKINGOFF_STATE:
-		cancel_delayed_work(&ctrl->button_work);
-		break;
-	}
-	ctrl->state = POWEROFF_STATE;
-	mutex_unlock(&ctrl->state_lock);
-
-	ctrl->request_result = pciehp_disable_slot(ctrl, SAFE_REMOVAL);
-}
-
-void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
-{
-	int present, link_active;
-
-	/*
-	 * If the slot is on and presence or link has changed, turn it off.
-	 * Even if it's occupied again, we cannot assume the card is the same.
-	 */
-	mutex_lock(&ctrl->state_lock);
-	switch (ctrl->state) {
-	case BLINKINGOFF_STATE:
-		cancel_delayed_work(&ctrl->button_work);
-		fallthrough;
-	case ON_STATE:
-		ctrl->state = POWEROFF_STATE;
-		mutex_unlock(&ctrl->state_lock);
-		if (events & PCI_EXP_SLTSTA_DLLSC)
-			ctrl_info(ctrl, "Slot(%s): Link Down\n",
-				  slot_name(ctrl));
-		if (events & PCI_EXP_SLTSTA_PDC)
-			ctrl_info(ctrl, "Slot(%s): Card not present\n",
-				  slot_name(ctrl));
-		pciehp_disable_slot(ctrl, SURPRISE_REMOVAL);
-		break;
-	default:
-		mutex_unlock(&ctrl->state_lock);
-		break;
-	}
-
-	/* Turn the slot on if it's occupied or link is up */
-	mutex_lock(&ctrl->state_lock);
-	present = pciehp_card_present(ctrl);
-	link_active = pciehp_check_link_active(ctrl);
-	if (present <= 0 && link_active <= 0) {
-		if (ctrl->state == BLINKINGON_STATE) {
-			ctrl->state = OFF_STATE;
-			cancel_delayed_work(&ctrl->button_work);
-			pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF,
-					      INDICATOR_NOOP);
-			ctrl_info(ctrl, "Slot(%s): Card not present\n",
-				  slot_name(ctrl));
-		}
-		mutex_unlock(&ctrl->state_lock);
-		return;
-	}
-
-	switch (ctrl->state) {
-	case BLINKINGON_STATE:
-		cancel_delayed_work(&ctrl->button_work);
-		fallthrough;
-	case OFF_STATE:
-		ctrl->state = POWERON_STATE;
-		mutex_unlock(&ctrl->state_lock);
-		if (present)
-			ctrl_info(ctrl, "Slot(%s): Card present\n",
-				  slot_name(ctrl));
-		if (link_active)
-			ctrl_info(ctrl, "Slot(%s): Link Up\n",
-				  slot_name(ctrl));
-		ctrl->request_result = pciehp_enable_slot(ctrl);
-		break;
-	default:
-		mutex_unlock(&ctrl->state_lock);
-		break;
-	}
-}
-
-static int __pciehp_enable_slot(struct controller *ctrl)
-{
-	u8 getstatus = 0;
-
-	if (MRL_SENS(ctrl)) {
-		pciehp_get_latch_status(ctrl, &getstatus);
-		if (getstatus) {
-			ctrl_info(ctrl, "Slot(%s): Latch open\n",
-				  slot_name(ctrl));
-			return -ENODEV;
-		}
-	}
-
-	if (POWER_CTRL(ctrl)) {
-		pciehp_get_power_status(ctrl, &getstatus);
-		if (getstatus) {
-			ctrl_info(ctrl, "Slot(%s): Already enabled\n",
-				  slot_name(ctrl));
-			return 0;
-		}
-	}
-
-	return board_added(ctrl);
-}
-
-static int pciehp_enable_slot(struct controller *ctrl)
-{
-	int ret;
-
-	pm_runtime_get_sync(&ctrl->pcie->port->dev);
-	ret = __pciehp_enable_slot(ctrl);
-	if (ret && ATTN_BUTTN(ctrl))
-		/* may be blinking */
-		pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF,
-				      INDICATOR_NOOP);
-	pm_runtime_put(&ctrl->pcie->port->dev);
-
-	mutex_lock(&ctrl->state_lock);
-	ctrl->state = ret ? OFF_STATE : ON_STATE;
-	mutex_unlock(&ctrl->state_lock);
-
-	return ret;
-}
-
-static int __pciehp_disable_slot(struct controller *ctrl, bool safe_removal)
-{
-	u8 getstatus = 0;
-
-	if (POWER_CTRL(ctrl)) {
-		pciehp_get_power_status(ctrl, &getstatus);
-		if (!getstatus) {
-			ctrl_info(ctrl, "Slot(%s): Already disabled\n",
-				  slot_name(ctrl));
-			return -EINVAL;
-		}
-	}
-
-	remove_board(ctrl, safe_removal);
-	return 0;
-}
-
-static int pciehp_disable_slot(struct controller *ctrl, bool safe_removal)
-{
-	int ret;
-
-	pm_runtime_get_sync(&ctrl->pcie->port->dev);
-	ret = __pciehp_disable_slot(ctrl, safe_removal);
-	pm_runtime_put(&ctrl->pcie->port->dev);
-
-	mutex_lock(&ctrl->state_lock);
-	ctrl->state = OFF_STATE;
-	mutex_unlock(&ctrl->state_lock);
-
-	return ret;
-}
-
-int pciehp_sysfs_enable_slot(struct hotplug_slot *hotplug_slot)
-{
-	struct controller *ctrl = to_ctrl(hotplug_slot);
-
-	mutex_lock(&ctrl->state_lock);
-	switch (ctrl->state) {
-	case BLINKINGON_STATE:
-	case OFF_STATE:
-		mutex_unlock(&ctrl->state_lock);
-		/*
-		 * The IRQ thread becomes a no-op if the user pulls out the
-		 * card before the thread wakes up, so initialize to -ENODEV.
-		 */
-		ctrl->request_result = -ENODEV;
-		pciehp_request(ctrl, PCI_EXP_SLTSTA_PDC);
-		wait_event(ctrl->requester,
-			   !atomic_read(&ctrl->pending_events) &&
-			   !ctrl->ist_running);
-		return ctrl->request_result;
-	case POWERON_STATE:
-		ctrl_info(ctrl, "Slot(%s): Already in powering on state\n",
-			  slot_name(ctrl));
-		break;
-	case BLINKINGOFF_STATE:
-	case ON_STATE:
-	case POWEROFF_STATE:
-		ctrl_info(ctrl, "Slot(%s): Already enabled\n",
-			  slot_name(ctrl));
-		break;
-	default:
-		ctrl_err(ctrl, "Slot(%s): Invalid state %#x\n",
-			 slot_name(ctrl), ctrl->state);
-		break;
-	}
-	mutex_unlock(&ctrl->state_lock);
-
-	return -ENODEV;
-}
-
-int pciehp_sysfs_disable_slot(struct hotplug_slot *hotplug_slot)
-{
-	struct controller *ctrl = to_ctrl(hotplug_slot);
-
-	mutex_lock(&ctrl->state_lock);
-	switch (ctrl->state) {
-	case BLINKINGOFF_STATE:
-	case ON_STATE:
-		mutex_unlock(&ctrl->state_lock);
-		pciehp_request(ctrl, DISABLE_SLOT);
-		wait_event(ctrl->requester,
-			   !atomic_read(&ctrl->pending_events) &&
-			   !ctrl->ist_running);
-		return ctrl->request_result;
-	case POWEROFF_STATE:
-		ctrl_info(ctrl, "Slot(%s): Already in powering off state\n",
-			  slot_name(ctrl));
-		break;
-	case BLINKINGON_STATE:
-	case OFF_STATE:
-	case POWERON_STATE:
-		ctrl_info(ctrl, "Slot(%s): Already disabled\n",
-			  slot_name(ctrl));
-		break;
-	default:
-		ctrl_err(ctrl, "Slot(%s): Invalid state %#x\n",
-			 slot_name(ctrl), ctrl->state);
-		break;
-	}
-	mutex_unlock(&ctrl->state_lock);
-
-	return -ENODEV;
-}
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
deleted file mode 100644
index ebd342bda235..000000000000
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ /dev/null
@@ -1,1123 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * PCI Express PCI Hot Plug Driver
- *
- * Copyright (C) 1995,2001 Compaq Computer Corporation
- * Copyright (C) 2001 Greg Kroah-Hartman (greg@kroah.com)
- * Copyright (C) 2001 IBM Corp.
- * Copyright (C) 2003-2004 Intel Corporation
- *
- * All rights reserved.
- *
- * Send feedback to <greg@kroah.com>,<kristen.c.accardi@intel.com>
- */
-
-#define dev_fmt(fmt) "pciehp: " fmt
-
-#include <linux/bitfield.h>
-#include <linux/dmi.h>
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/jiffies.h>
-#include <linux/kthread.h>
-#include <linux/pci.h>
-#include <linux/pm_runtime.h>
-#include <linux/interrupt.h>
-#include <linux/slab.h>
-
-#include "../pci.h"
-#include "pciehp.h"
-
-static const struct dmi_system_id inband_presence_disabled_dmi_table[] = {
-	/*
-	 * Match all Dell systems, as some Dell systems have inband
-	 * presence disabled on NVMe slots (but don't support the bit to
-	 * report it). Setting inband presence disabled should have no
-	 * negative effect, except on broken hotplug slots that never
-	 * assert presence detect--and those will still work, they will
-	 * just have a bit of extra delay before being probed.
-	 */
-	{
-		.ident = "Dell System",
-		.matches = {
-			DMI_MATCH(DMI_OEM_STRING, "Dell System"),
-		},
-	},
-	{}
-};
-
-static inline struct pci_dev *ctrl_dev(struct controller *ctrl)
-{
-	return ctrl->pcie->port;
-}
-
-static irqreturn_t pciehp_isr(int irq, void *dev_id);
-static irqreturn_t pciehp_ist(int irq, void *dev_id);
-static int pciehp_poll(void *data);
-
-static inline int pciehp_request_irq(struct controller *ctrl)
-{
-	int retval, irq = ctrl->pcie->irq;
-
-	if (pciehp_poll_mode) {
-		ctrl->poll_thread = kthread_run(&pciehp_poll, ctrl,
-						"pciehp_poll-%s",
-						slot_name(ctrl));
-		return PTR_ERR_OR_ZERO(ctrl->poll_thread);
-	}
-
-	/* Installs the interrupt handler */
-	retval = request_threaded_irq(irq, pciehp_isr, pciehp_ist,
-				      IRQF_SHARED, "pciehp", ctrl);
-	if (retval)
-		ctrl_err(ctrl, "Cannot get irq %d for the hotplug controller\n",
-			 irq);
-	return retval;
-}
-
-static inline void pciehp_free_irq(struct controller *ctrl)
-{
-	if (pciehp_poll_mode)
-		kthread_stop(ctrl->poll_thread);
-	else
-		free_irq(ctrl->pcie->irq, ctrl);
-}
-
-static int pcie_poll_cmd(struct controller *ctrl, int timeout)
-{
-	struct pci_dev *pdev = ctrl_dev(ctrl);
-	u16 slot_status;
-
-	do {
-		pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
-		if (PCI_POSSIBLE_ERROR(slot_status)) {
-			ctrl_info(ctrl, "%s: no response from device\n",
-				  __func__);
-			return 0;
-		}
-
-		if (slot_status & PCI_EXP_SLTSTA_CC) {
-			pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
-						   PCI_EXP_SLTSTA_CC);
-			ctrl->cmd_busy = 0;
-			smp_mb();
-			return 1;
-		}
-		msleep(10);
-		timeout -= 10;
-	} while (timeout >= 0);
-	return 0;	/* timeout */
-}
-
-static void pcie_wait_cmd(struct controller *ctrl)
-{
-	unsigned int msecs = pciehp_poll_mode ? 2500 : 1000;
-	unsigned long duration = msecs_to_jiffies(msecs);
-	unsigned long cmd_timeout = ctrl->cmd_started + duration;
-	unsigned long now, timeout;
-	int rc;
-
-	/*
-	 * If the controller does not generate notifications for command
-	 * completions, we never need to wait between writes.
-	 */
-	if (NO_CMD_CMPL(ctrl))
-		return;
-
-	if (!ctrl->cmd_busy)
-		return;
-
-	/*
-	 * Even if the command has already timed out, we want to call
-	 * pcie_poll_cmd() so it can clear PCI_EXP_SLTSTA_CC.
-	 */
-	now = jiffies;
-	if (time_before_eq(cmd_timeout, now))
-		timeout = 1;
-	else
-		timeout = cmd_timeout - now;
-
-	if (ctrl->slot_ctrl & PCI_EXP_SLTCTL_HPIE &&
-	    ctrl->slot_ctrl & PCI_EXP_SLTCTL_CCIE)
-		rc = wait_event_timeout(ctrl->queue, !ctrl->cmd_busy, timeout);
-	else
-		rc = pcie_poll_cmd(ctrl, jiffies_to_msecs(timeout));
-
-	if (!rc)
-		ctrl_info(ctrl, "Timeout on hotplug command %#06x (issued %u msec ago)\n",
-			  ctrl->slot_ctrl,
-			  jiffies_to_msecs(jiffies - ctrl->cmd_started));
-}
-
-#define CC_ERRATUM_MASK		(PCI_EXP_SLTCTL_PCC |	\
-				 PCI_EXP_SLTCTL_PIC |	\
-				 PCI_EXP_SLTCTL_AIC |	\
-				 PCI_EXP_SLTCTL_EIC)
-
-static void pcie_do_write_cmd(struct controller *ctrl, u16 cmd,
-			      u16 mask, bool wait)
-{
-	struct pci_dev *pdev = ctrl_dev(ctrl);
-	u16 slot_ctrl_orig, slot_ctrl;
-
-	mutex_lock(&ctrl->ctrl_lock);
-
-	/*
-	 * Always wait for any previous command that might still be in progress
-	 */
-	pcie_wait_cmd(ctrl);
-
-	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
-	if (PCI_POSSIBLE_ERROR(slot_ctrl)) {
-		ctrl_info(ctrl, "%s: no response from device\n", __func__);
-		goto out;
-	}
-
-	slot_ctrl_orig = slot_ctrl;
-	slot_ctrl &= ~mask;
-	slot_ctrl |= (cmd & mask);
-	ctrl->cmd_busy = 1;
-	smp_mb();
-	ctrl->slot_ctrl = slot_ctrl;
-	pcie_capability_write_word(pdev, PCI_EXP_SLTCTL, slot_ctrl);
-	ctrl->cmd_started = jiffies;
-
-	/*
-	 * Controllers with the Intel CF118 and similar errata advertise
-	 * Command Completed support, but they only set Command Completed
-	 * if we change the "Control" bits for power, power indicator,
-	 * attention indicator, or interlock.  If we only change the
-	 * "Enable" bits, they never set the Command Completed bit.
-	 */
-	if (pdev->broken_cmd_compl &&
-	    (slot_ctrl_orig & CC_ERRATUM_MASK) == (slot_ctrl & CC_ERRATUM_MASK))
-		ctrl->cmd_busy = 0;
-
-	/*
-	 * Optionally wait for the hardware to be ready for a new command,
-	 * indicating completion of the above issued command.
-	 */
-	if (wait)
-		pcie_wait_cmd(ctrl);
-
-out:
-	mutex_unlock(&ctrl->ctrl_lock);
-}
-
-/**
- * pcie_write_cmd - Issue controller command
- * @ctrl: controller to which the command is issued
- * @cmd:  command value written to slot control register
- * @mask: bitmask of slot control register to be modified
- */
-static void pcie_write_cmd(struct controller *ctrl, u16 cmd, u16 mask)
-{
-	pcie_do_write_cmd(ctrl, cmd, mask, true);
-}
-
-/* Same as above without waiting for the hardware to latch */
-static void pcie_write_cmd_nowait(struct controller *ctrl, u16 cmd, u16 mask)
-{
-	pcie_do_write_cmd(ctrl, cmd, mask, false);
-}
-
-/**
- * pciehp_check_link_active() - Is the link active
- * @ctrl: PCIe hotplug controller
- *
- * Check whether the downstream link is currently active. Note it is
- * possible that the card is removed immediately after this so the
- * caller may need to take it into account.
- *
- * If the hotplug controller itself is not available anymore returns
- * %-ENODEV.
- */
-int pciehp_check_link_active(struct controller *ctrl)
-{
-	struct pci_dev *pdev = ctrl_dev(ctrl);
-	u16 lnk_status;
-	int ret;
-
-	ret = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
-	if (ret == PCIBIOS_DEVICE_NOT_FOUND || PCI_POSSIBLE_ERROR(lnk_status))
-		return -ENODEV;
-
-	ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
-	ctrl_dbg(ctrl, "%s: lnk_status = %x\n", __func__, lnk_status);
-
-	return ret;
-}
-
-static bool pci_bus_check_dev(struct pci_bus *bus, int devfn)
-{
-	u32 l;
-	int count = 0;
-	int delay = 1000, step = 20;
-	bool found = false;
-
-	do {
-		found = pci_bus_read_dev_vendor_id(bus, devfn, &l, 0);
-		count++;
-
-		if (found)
-			break;
-
-		msleep(step);
-		delay -= step;
-	} while (delay > 0);
-
-	if (count > 1)
-		pr_debug("pci %04x:%02x:%02x.%d id reading try %d times with interval %d ms to get %08x\n",
-			pci_domain_nr(bus), bus->number, PCI_SLOT(devfn),
-			PCI_FUNC(devfn), count, step, l);
-
-	return found;
-}
-
-static void pcie_wait_for_presence(struct pci_dev *pdev)
-{
-	int timeout = 1250;
-	u16 slot_status;
-
-	do {
-		pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
-		if (slot_status & PCI_EXP_SLTSTA_PDS)
-			return;
-		msleep(10);
-		timeout -= 10;
-	} while (timeout > 0);
-}
-
-int pciehp_check_link_status(struct controller *ctrl)
-{
-	struct pci_dev *pdev = ctrl_dev(ctrl);
-	bool found;
-	u16 lnk_status, linksta2;
-
-	if (!pcie_wait_for_link(pdev, true)) {
-		ctrl_info(ctrl, "Slot(%s): No link\n", slot_name(ctrl));
-		return -1;
-	}
-
-	if (ctrl->inband_presence_disabled)
-		pcie_wait_for_presence(pdev);
-
-	found = pci_bus_check_dev(ctrl->pcie->port->subordinate,
-					PCI_DEVFN(0, 0));
-
-	/* ignore link or presence changes up to this point */
-	if (found)
-		atomic_and(~(PCI_EXP_SLTSTA_DLLSC | PCI_EXP_SLTSTA_PDC),
-			   &ctrl->pending_events);
-
-	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
-	ctrl_dbg(ctrl, "%s: lnk_status = %x\n", __func__, lnk_status);
-	if ((lnk_status & PCI_EXP_LNKSTA_LT) ||
-	    !(lnk_status & PCI_EXP_LNKSTA_NLW)) {
-		ctrl_info(ctrl, "Slot(%s): Cannot train link: status %#06x\n",
-			  slot_name(ctrl), lnk_status);
-		return -1;
-	}
-
-	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA2, &linksta2);
-	__pcie_update_link_speed(ctrl->pcie->port->subordinate, lnk_status, linksta2);
-
-	if (!found) {
-		ctrl_info(ctrl, "Slot(%s): No device found\n",
-			  slot_name(ctrl));
-		return -1;
-	}
-
-	return 0;
-}
-
-static int __pciehp_link_set(struct controller *ctrl, bool enable)
-{
-	struct pci_dev *pdev = ctrl_dev(ctrl);
-
-	pcie_capability_clear_and_set_word(pdev, PCI_EXP_LNKCTL,
-					   PCI_EXP_LNKCTL_LD,
-					   enable ? 0 : PCI_EXP_LNKCTL_LD);
-
-	return 0;
-}
-
-static int pciehp_link_enable(struct controller *ctrl)
-{
-	return __pciehp_link_set(ctrl, true);
-}
-
-int pciehp_get_raw_indicator_status(struct hotplug_slot *hotplug_slot,
-				    u8 *status)
-{
-	struct controller *ctrl = to_ctrl(hotplug_slot);
-	struct pci_dev *pdev = ctrl_dev(ctrl);
-	u16 slot_ctrl;
-
-	pci_config_pm_runtime_get(pdev);
-	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
-	pci_config_pm_runtime_put(pdev);
-	*status = (slot_ctrl & (PCI_EXP_SLTCTL_AIC | PCI_EXP_SLTCTL_PIC)) >> 6;
-	return 0;
-}
-
-int pciehp_get_attention_status(struct hotplug_slot *hotplug_slot, u8 *status)
-{
-	struct controller *ctrl = to_ctrl(hotplug_slot);
-	struct pci_dev *pdev = ctrl_dev(ctrl);
-	u16 slot_ctrl;
-
-	pci_config_pm_runtime_get(pdev);
-	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
-	pci_config_pm_runtime_put(pdev);
-	ctrl_dbg(ctrl, "%s: SLOTCTRL %x, value read %x\n", __func__,
-		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, slot_ctrl);
-
-	switch (slot_ctrl & PCI_EXP_SLTCTL_AIC) {
-	case PCI_EXP_SLTCTL_ATTN_IND_ON:
-		*status = 1;	/* On */
-		break;
-	case PCI_EXP_SLTCTL_ATTN_IND_BLINK:
-		*status = 2;	/* Blink */
-		break;
-	case PCI_EXP_SLTCTL_ATTN_IND_OFF:
-		*status = 0;	/* Off */
-		break;
-	default:
-		*status = 0xFF;
-		break;
-	}
-
-	return 0;
-}
-
-void pciehp_get_power_status(struct controller *ctrl, u8 *status)
-{
-	struct pci_dev *pdev = ctrl_dev(ctrl);
-	u16 slot_ctrl;
-
-	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
-	ctrl_dbg(ctrl, "%s: SLOTCTRL %x value read %x\n", __func__,
-		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, slot_ctrl);
-
-	switch (slot_ctrl & PCI_EXP_SLTCTL_PCC) {
-	case PCI_EXP_SLTCTL_PWR_ON:
-		*status = 1;	/* On */
-		break;
-	case PCI_EXP_SLTCTL_PWR_OFF:
-		*status = 0;	/* Off */
-		break;
-	default:
-		*status = 0xFF;
-		break;
-	}
-}
-
-void pciehp_get_latch_status(struct controller *ctrl, u8 *status)
-{
-	struct pci_dev *pdev = ctrl_dev(ctrl);
-	u16 slot_status;
-
-	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
-	*status = !!(slot_status & PCI_EXP_SLTSTA_MRLSS);
-}
-
-/**
- * pciehp_card_present() - Is the card present
- * @ctrl: PCIe hotplug controller
- *
- * Function checks whether the card is currently present in the slot and
- * in that case returns true. Note it is possible that the card is
- * removed immediately after the check so the caller may need to take
- * this into account.
- *
- * If the hotplug controller itself is not available anymore returns
- * %-ENODEV.
- */
-int pciehp_card_present(struct controller *ctrl)
-{
-	struct pci_dev *pdev = ctrl_dev(ctrl);
-	u16 slot_status;
-	int ret;
-
-	ret = pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
-	if (ret == PCIBIOS_DEVICE_NOT_FOUND || PCI_POSSIBLE_ERROR(slot_status))
-		return -ENODEV;
-
-	return !!(slot_status & PCI_EXP_SLTSTA_PDS);
-}
-
-/**
- * pciehp_card_present_or_link_active() - whether given slot is occupied
- * @ctrl: PCIe hotplug controller
- *
- * Unlike pciehp_card_present(), which determines presence solely from the
- * Presence Detect State bit, this helper also returns true if the Link Active
- * bit is set.  This is a concession to broken hotplug ports which hardwire
- * Presence Detect State to zero, such as Wilocity's [1ae9:0200].
- *
- * Returns: %1 if the slot is occupied and %0 if it is not. If the hotplug
- *	    port is not present anymore returns %-ENODEV.
- */
-int pciehp_card_present_or_link_active(struct controller *ctrl)
-{
-	int ret;
-
-	ret = pciehp_card_present(ctrl);
-	if (ret)
-		return ret;
-
-	return pciehp_check_link_active(ctrl);
-}
-
-int pciehp_query_power_fault(struct controller *ctrl)
-{
-	struct pci_dev *pdev = ctrl_dev(ctrl);
-	u16 slot_status;
-
-	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
-	return !!(slot_status & PCI_EXP_SLTSTA_PFD);
-}
-
-int pciehp_set_raw_indicator_status(struct hotplug_slot *hotplug_slot,
-				    u8 status)
-{
-	struct controller *ctrl = to_ctrl(hotplug_slot);
-	struct pci_dev *pdev = ctrl_dev(ctrl);
-
-	pci_config_pm_runtime_get(pdev);
-
-	/* Attention and Power Indicator Control bits are supported */
-	pcie_write_cmd_nowait(ctrl, FIELD_PREP(PCI_EXP_SLTCTL_AIC | PCI_EXP_SLTCTL_PIC, status),
-			      PCI_EXP_SLTCTL_AIC | PCI_EXP_SLTCTL_PIC);
-	pci_config_pm_runtime_put(pdev);
-	return 0;
-}
-
-/**
- * pciehp_set_indicators() - set attention indicator, power indicator, or both
- * @ctrl: PCIe hotplug controller
- * @pwr: one of:
- *	PCI_EXP_SLTCTL_PWR_IND_ON
- *	PCI_EXP_SLTCTL_PWR_IND_BLINK
- *	PCI_EXP_SLTCTL_PWR_IND_OFF
- * @attn: one of:
- *	PCI_EXP_SLTCTL_ATTN_IND_ON
- *	PCI_EXP_SLTCTL_ATTN_IND_BLINK
- *	PCI_EXP_SLTCTL_ATTN_IND_OFF
- *
- * Either @pwr or @attn can also be INDICATOR_NOOP to leave that indicator
- * unchanged.
- */
-void pciehp_set_indicators(struct controller *ctrl, int pwr, int attn)
-{
-	u16 cmd = 0, mask = 0;
-
-	if (PWR_LED(ctrl) && pwr != INDICATOR_NOOP) {
-		cmd |= (pwr & PCI_EXP_SLTCTL_PIC);
-		mask |= PCI_EXP_SLTCTL_PIC;
-	}
-
-	if (ATTN_LED(ctrl) && attn != INDICATOR_NOOP) {
-		cmd |= (attn & PCI_EXP_SLTCTL_AIC);
-		mask |= PCI_EXP_SLTCTL_AIC;
-	}
-
-	if (cmd) {
-		pcie_write_cmd_nowait(ctrl, cmd, mask);
-		ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
-			 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, cmd);
-	}
-}
-
-int pciehp_power_on_slot(struct controller *ctrl)
-{
-	struct pci_dev *pdev = ctrl_dev(ctrl);
-	u16 slot_status;
-	int retval;
-
-	/* Clear power-fault bit from previous power failures */
-	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
-	if (slot_status & PCI_EXP_SLTSTA_PFD)
-		pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
-					   PCI_EXP_SLTSTA_PFD);
-	ctrl->power_fault_detected = 0;
-
-	pcie_write_cmd(ctrl, PCI_EXP_SLTCTL_PWR_ON, PCI_EXP_SLTCTL_PCC);
-	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
-		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL,
-		 PCI_EXP_SLTCTL_PWR_ON);
-
-	retval = pciehp_link_enable(ctrl);
-	if (retval)
-		ctrl_err(ctrl, "%s: Can not enable the link!\n", __func__);
-
-	return retval;
-}
-
-void pciehp_power_off_slot(struct controller *ctrl)
-{
-	pcie_write_cmd(ctrl, PCI_EXP_SLTCTL_PWR_OFF, PCI_EXP_SLTCTL_PCC);
-	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
-		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL,
-		 PCI_EXP_SLTCTL_PWR_OFF);
-}
-
-bool pciehp_device_replaced(struct controller *ctrl)
-{
-	struct pci_dev *pdev __free(pci_dev_put) = NULL;
-	u32 reg;
-
-	if (pci_dev_is_disconnected(ctrl->pcie->port))
-		return false;
-
-	pdev = pci_get_slot(ctrl->pcie->port->subordinate, PCI_DEVFN(0, 0));
-	if (!pdev)
-		return true;
-
-	if (pci_read_config_dword(pdev, PCI_VENDOR_ID, &reg) ||
-	    reg != (pdev->vendor | (pdev->device << 16)) ||
-	    pci_read_config_dword(pdev, PCI_CLASS_REVISION, &reg) ||
-	    reg != (pdev->revision | (pdev->class << 8)))
-		return true;
-
-	if (pdev->hdr_type == PCI_HEADER_TYPE_NORMAL &&
-	    (pci_read_config_dword(pdev, PCI_SUBSYSTEM_VENDOR_ID, &reg) ||
-	     reg != (pdev->subsystem_vendor | (pdev->subsystem_device << 16))))
-		return true;
-
-	if (pci_get_dsn(pdev) != ctrl->dsn)
-		return true;
-
-	return false;
-}
-
-static void pciehp_ignore_link_change(struct controller *ctrl,
-				      struct pci_dev *pdev, int irq,
-				      u16 ignored_events)
-{
-	/*
-	 * Ignore link changes which occurred while waiting for DPC recovery.
-	 * Could be several if DPC triggered multiple times consecutively.
-	 * Also ignore link changes caused by Secondary Bus Reset, etc.
-	 */
-	synchronize_hardirq(irq);
-	atomic_and(~ignored_events, &ctrl->pending_events);
-	if (pciehp_poll_mode)
-		pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
-					   ignored_events);
-	ctrl_info(ctrl, "Slot(%s): Link Down/Up ignored\n", slot_name(ctrl));
-
-	/*
-	 * If the link is unexpectedly down after successful recovery,
-	 * the corresponding link change may have been ignored above.
-	 * Synthesize it to ensure that it is acted on.
-	 */
-	down_read_nested(&ctrl->reset_lock, ctrl->depth);
-	if (!pciehp_check_link_active(ctrl) || pciehp_device_replaced(ctrl))
-		pciehp_request(ctrl, ignored_events);
-	up_read(&ctrl->reset_lock);
-}
-
-static irqreturn_t pciehp_isr(int irq, void *dev_id)
-{
-	struct controller *ctrl = (struct controller *)dev_id;
-	struct pci_dev *pdev = ctrl_dev(ctrl);
-	struct device *parent = pdev->dev.parent;
-	u16 status, events = 0;
-
-	/*
-	 * Interrupts only occur in D3hot or shallower and only if enabled
-	 * in the Slot Control register (PCIe r4.0, sec 6.7.3.4).
-	 */
-	if (pdev->current_state == PCI_D3cold ||
-	    (!(ctrl->slot_ctrl & PCI_EXP_SLTCTL_HPIE) && !pciehp_poll_mode))
-		return IRQ_NONE;
-
-	/*
-	 * Keep the port accessible by holding a runtime PM ref on its parent.
-	 * Defer resume of the parent to the IRQ thread if it's suspended.
-	 * Mask the interrupt until then.
-	 */
-	if (parent) {
-		pm_runtime_get_noresume(parent);
-		if (!pm_runtime_active(parent)) {
-			pm_runtime_put(parent);
-			disable_irq_nosync(irq);
-			atomic_or(RERUN_ISR, &ctrl->pending_events);
-			return IRQ_WAKE_THREAD;
-		}
-	}
-
-read_status:
-	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &status);
-	if (PCI_POSSIBLE_ERROR(status)) {
-		ctrl_info(ctrl, "%s: no response from device\n", __func__);
-		if (parent)
-			pm_runtime_put(parent);
-		return IRQ_NONE;
-	}
-
-	/*
-	 * Slot Status contains plain status bits as well as event
-	 * notification bits; right now we only want the event bits.
-	 */
-	status &= PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD |
-		  PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_CC |
-		  PCI_EXP_SLTSTA_DLLSC;
-
-	/*
-	 * If we've already reported a power fault, don't report it again
-	 * until we've done something to handle it.
-	 */
-	if (ctrl->power_fault_detected)
-		status &= ~PCI_EXP_SLTSTA_PFD;
-	else if (status & PCI_EXP_SLTSTA_PFD)
-		ctrl->power_fault_detected = true;
-
-	events |= status;
-	if (!events) {
-		if (parent)
-			pm_runtime_put(parent);
-		return IRQ_NONE;
-	}
-
-	if (status) {
-		pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, status);
-
-		/*
-		 * In MSI mode, all event bits must be zero before the port
-		 * will send a new interrupt (PCIe Base Spec r5.0 sec 6.7.3.4).
-		 * So re-read the Slot Status register in case a bit was set
-		 * between read and write.
-		 */
-		if (pci_dev_msi_enabled(pdev) && !pciehp_poll_mode)
-			goto read_status;
-	}
-
-	ctrl_dbg(ctrl, "pending interrupts %#06x from Slot Status\n", events);
-	if (parent)
-		pm_runtime_put(parent);
-
-	/*
-	 * Command Completed notifications are not deferred to the
-	 * IRQ thread because it may be waiting for their arrival.
-	 */
-	if (events & PCI_EXP_SLTSTA_CC) {
-		ctrl->cmd_busy = 0;
-		smp_mb();
-		wake_up(&ctrl->queue);
-
-		if (events == PCI_EXP_SLTSTA_CC)
-			return IRQ_HANDLED;
-
-		events &= ~PCI_EXP_SLTSTA_CC;
-	}
-
-	if (pdev->ignore_hotplug) {
-		ctrl_dbg(ctrl, "ignoring hotplug event %#06x\n", events);
-		return IRQ_HANDLED;
-	}
-
-	/* Save pending events for consumption by IRQ thread. */
-	atomic_or(events, &ctrl->pending_events);
-	return IRQ_WAKE_THREAD;
-}
-
-static irqreturn_t pciehp_ist(int irq, void *dev_id)
-{
-	struct controller *ctrl = (struct controller *)dev_id;
-	struct pci_dev *pdev = ctrl_dev(ctrl);
-	irqreturn_t ret;
-	u32 events;
-
-	ctrl->ist_running = true;
-	pci_config_pm_runtime_get(pdev);
-
-	/* rerun pciehp_isr() if the port was inaccessible on interrupt */
-	if (atomic_fetch_and(~RERUN_ISR, &ctrl->pending_events) & RERUN_ISR) {
-		ret = pciehp_isr(irq, dev_id);
-		enable_irq(irq);
-		if (ret != IRQ_WAKE_THREAD)
-			goto out;
-	}
-
-	synchronize_hardirq(irq);
-	events = atomic_xchg(&ctrl->pending_events, 0);
-	if (!events) {
-		ret = IRQ_NONE;
-		goto out;
-	}
-
-	/* Check Attention Button Pressed */
-	if (events & PCI_EXP_SLTSTA_ABP)
-		pciehp_handle_button_press(ctrl);
-
-	/* Check Power Fault Detected */
-	if (events & PCI_EXP_SLTSTA_PFD) {
-		ctrl_err(ctrl, "Slot(%s): Power fault\n", slot_name(ctrl));
-		pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF,
-				      PCI_EXP_SLTCTL_ATTN_IND_ON);
-	}
-
-	/*
-	 * Ignore Link Down/Up events caused by Downstream Port Containment
-	 * if recovery succeeded, or caused by Secondary Bus Reset,
-	 * suspend to D3cold, firmware update, FPGA reconfiguration, etc.
-	 */
-	if ((events & (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC)) &&
-	    (pci_dpc_recovered(pdev) || pci_hp_spurious_link_change(pdev)) &&
-	    ctrl->state == ON_STATE) {
-		u16 ignored_events = PCI_EXP_SLTSTA_DLLSC;
-
-		if (!ctrl->inband_presence_disabled)
-			ignored_events |= events & PCI_EXP_SLTSTA_PDC;
-
-		events &= ~ignored_events;
-		pciehp_ignore_link_change(ctrl, pdev, irq, ignored_events);
-	}
-
-	/*
-	 * Disable requests have higher priority than Presence Detect Changed
-	 * or Data Link Layer State Changed events.
-	 */
-	down_read_nested(&ctrl->reset_lock, ctrl->depth);
-	if (events & DISABLE_SLOT)
-		pciehp_handle_disable_request(ctrl);
-	else if (events & (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC))
-		pciehp_handle_presence_or_link_change(ctrl, events);
-	up_read(&ctrl->reset_lock);
-
-	ret = IRQ_HANDLED;
-out:
-	pci_config_pm_runtime_put(pdev);
-	ctrl->ist_running = false;
-	wake_up(&ctrl->requester);
-	return ret;
-}
-
-static int pciehp_poll(void *data)
-{
-	struct controller *ctrl = data;
-
-	schedule_timeout_idle(10 * HZ); /* start with 10 sec delay */
-
-	while (!kthread_should_stop()) {
-		/* poll for interrupt events or user requests */
-		while (pciehp_isr(IRQ_NOTCONNECTED, ctrl) == IRQ_WAKE_THREAD ||
-		       atomic_read(&ctrl->pending_events))
-			pciehp_ist(IRQ_NOTCONNECTED, ctrl);
-
-		if (pciehp_poll_time <= 0 || pciehp_poll_time > 60)
-			pciehp_poll_time = 2; /* clamp to sane value */
-
-		schedule_timeout_idle(pciehp_poll_time * HZ);
-	}
-
-	return 0;
-}
-
-static void pcie_enable_notification(struct controller *ctrl)
-{
-	u16 cmd, mask;
-
-	/*
-	 * TBD: Power fault detected software notification support.
-	 *
-	 * Power fault detected software notification is not enabled
-	 * now, because it caused power fault detected interrupt storm
-	 * on some machines. On those machines, power fault detected
-	 * bit in the slot status register was set again immediately
-	 * when it is cleared in the interrupt service routine, and
-	 * next power fault detected interrupt was notified again.
-	 */
-
-	/*
-	 * Always enable link events: thus link-up and link-down shall
-	 * always be treated as hotplug and unplug respectively. Enable
-	 * presence detect only if Attention Button is not present.
-	 */
-	cmd = PCI_EXP_SLTCTL_DLLSCE;
-	if (ATTN_BUTTN(ctrl))
-		cmd |= PCI_EXP_SLTCTL_ABPE;
-	else
-		cmd |= PCI_EXP_SLTCTL_PDCE;
-	if (!pciehp_poll_mode)
-		cmd |= PCI_EXP_SLTCTL_HPIE;
-	if (!pciehp_poll_mode && !NO_CMD_CMPL(ctrl))
-		cmd |= PCI_EXP_SLTCTL_CCIE;
-
-	mask = (PCI_EXP_SLTCTL_PDCE | PCI_EXP_SLTCTL_ABPE |
-		PCI_EXP_SLTCTL_PFDE |
-		PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_CCIE |
-		PCI_EXP_SLTCTL_DLLSCE);
-
-	pcie_write_cmd_nowait(ctrl, cmd, mask);
-	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
-		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, cmd);
-}
-
-static void pcie_disable_notification(struct controller *ctrl)
-{
-	u16 mask;
-
-	mask = (PCI_EXP_SLTCTL_PDCE | PCI_EXP_SLTCTL_ABPE |
-		PCI_EXP_SLTCTL_MRLSCE | PCI_EXP_SLTCTL_PFDE |
-		PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_CCIE |
-		PCI_EXP_SLTCTL_DLLSCE);
-	pcie_write_cmd(ctrl, 0, mask);
-	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
-		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, 0);
-}
-
-void pcie_clear_hotplug_events(struct controller *ctrl)
-{
-	pcie_capability_write_word(ctrl_dev(ctrl), PCI_EXP_SLTSTA,
-				   PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC);
-}
-
-void pcie_enable_interrupt(struct controller *ctrl)
-{
-	u16 mask;
-
-	mask = PCI_EXP_SLTCTL_DLLSCE;
-	if (!pciehp_poll_mode)
-		mask |= PCI_EXP_SLTCTL_HPIE;
-	pcie_write_cmd(ctrl, mask, mask);
-}
-
-void pcie_disable_interrupt(struct controller *ctrl)
-{
-	u16 mask;
-
-	/*
-	 * Mask hot-plug interrupt to prevent it triggering immediately
-	 * when the link goes inactive (we still get PME when any of the
-	 * enabled events is detected). Same goes with Link Layer State
-	 * changed event which generates PME immediately when the link goes
-	 * inactive so mask it as well.
-	 */
-	mask = PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_DLLSCE;
-	pcie_write_cmd(ctrl, 0, mask);
-}
-
-/**
- * pciehp_slot_reset() - ignore link event caused by error-induced hot reset
- * @dev: PCI Express port service device
- *
- * Called from pcie_portdrv_slot_reset() after AER or DPC initiated a reset
- * further up in the hierarchy to recover from an error.  The reset was
- * propagated down to this hotplug port.  Ignore the resulting link flap.
- * If the link failed to retrain successfully, synthesize the ignored event.
- * Surprise removal during reset is detected through Presence Detect Changed.
- */
-int pciehp_slot_reset(struct pcie_device *dev)
-{
-	struct controller *ctrl = get_service_data(dev);
-
-	if (ctrl->state != ON_STATE)
-		return 0;
-
-	pcie_capability_write_word(dev->port, PCI_EXP_SLTSTA,
-				   PCI_EXP_SLTSTA_DLLSC);
-
-	if (!pciehp_check_link_active(ctrl))
-		pciehp_request(ctrl, PCI_EXP_SLTSTA_DLLSC);
-
-	return 0;
-}
-
-/*
- * pciehp has a 1:1 bus:slot relationship so we ultimately want a secondary
- * bus reset of the bridge, but at the same time we want to ensure that it is
- * not seen as a hot-unplug, followed by the hot-plug of the device. Thus,
- * disable link state notification and presence detection change notification
- * momentarily, if we see that they could interfere. Also, clear any spurious
- * events after.
- */
-int pciehp_reset_slot(struct hotplug_slot *hotplug_slot, bool probe)
-{
-	struct controller *ctrl = to_ctrl(hotplug_slot);
-	struct pci_dev *pdev = ctrl_dev(ctrl);
-	int rc;
-
-	if (probe)
-		return 0;
-
-	down_write_nested(&ctrl->reset_lock, ctrl->depth);
-
-	pci_hp_ignore_link_change(pdev);
-
-	rc = pci_bridge_secondary_bus_reset(ctrl->pcie->port);
-
-	pci_hp_unignore_link_change(pdev);
-
-	up_write(&ctrl->reset_lock);
-	return rc;
-}
-
-int pcie_init_notification(struct controller *ctrl)
-{
-	if (pciehp_request_irq(ctrl))
-		return -1;
-	pcie_enable_notification(ctrl);
-	ctrl->notification_enabled = 1;
-	return 0;
-}
-
-void pcie_shutdown_notification(struct controller *ctrl)
-{
-	if (ctrl->notification_enabled) {
-		pcie_disable_notification(ctrl);
-		pciehp_free_irq(ctrl);
-		ctrl->notification_enabled = 0;
-	}
-}
-
-static inline void dbg_ctrl(struct controller *ctrl)
-{
-	struct pci_dev *pdev = ctrl->pcie->port;
-	u16 reg16;
-
-	ctrl_dbg(ctrl, "Slot Capabilities      : 0x%08x\n", ctrl->slot_cap);
-	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &reg16);
-	ctrl_dbg(ctrl, "Slot Status            : 0x%04x\n", reg16);
-	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &reg16);
-	ctrl_dbg(ctrl, "Slot Control           : 0x%04x\n", reg16);
-}
-
-#define FLAG(x, y)	(((x) & (y)) ? '+' : '-')
-
-static inline int pcie_hotplug_depth(struct pci_dev *dev)
-{
-	struct pci_bus *bus = dev->bus;
-	int depth = 0;
-
-	while (bus->parent) {
-		bus = bus->parent;
-		if (bus->self && bus->self->is_hotplug_bridge)
-			depth++;
-	}
-
-	return depth;
-}
-
-struct controller *pcie_init(struct pcie_device *dev)
-{
-	struct controller *ctrl;
-	u32 slot_cap, slot_cap2;
-	u8 poweron;
-	struct pci_dev *pdev = dev->port;
-	struct pci_bus *subordinate = pdev->subordinate;
-
-	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
-	if (!ctrl)
-		return NULL;
-
-	ctrl->pcie = dev;
-	ctrl->depth = pcie_hotplug_depth(dev->port);
-	pcie_capability_read_dword(pdev, PCI_EXP_SLTCAP, &slot_cap);
-
-	if (pdev->hotplug_user_indicators)
-		slot_cap &= ~(PCI_EXP_SLTCAP_AIP | PCI_EXP_SLTCAP_PIP);
-
-	/*
-	 * We assume no Thunderbolt controllers support Command Complete events,
-	 * but some controllers falsely claim they do.
-	 */
-	if (pdev->is_thunderbolt)
-		slot_cap |= PCI_EXP_SLTCAP_NCCS;
-
-	ctrl->slot_cap = slot_cap;
-	mutex_init(&ctrl->ctrl_lock);
-	mutex_init(&ctrl->state_lock);
-	init_rwsem(&ctrl->reset_lock);
-	init_waitqueue_head(&ctrl->requester);
-	init_waitqueue_head(&ctrl->queue);
-	INIT_DELAYED_WORK(&ctrl->button_work, pciehp_queue_pushbutton_work);
-	dbg_ctrl(ctrl);
-
-	down_read(&pci_bus_sem);
-	ctrl->state = list_empty(&subordinate->devices) ? OFF_STATE : ON_STATE;
-	up_read(&pci_bus_sem);
-
-	pcie_capability_read_dword(pdev, PCI_EXP_SLTCAP2, &slot_cap2);
-	if (slot_cap2 & PCI_EXP_SLTCAP2_IBPD) {
-		pcie_write_cmd_nowait(ctrl, PCI_EXP_SLTCTL_IBPD_DISABLE,
-				      PCI_EXP_SLTCTL_IBPD_DISABLE);
-		ctrl->inband_presence_disabled = 1;
-	}
-
-	if (dmi_first_match(inband_presence_disabled_dmi_table))
-		ctrl->inband_presence_disabled = 1;
-
-	/* Clear all remaining event bits in Slot Status register. */
-	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
-		PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD |
-		PCI_EXP_SLTSTA_MRLSC | PCI_EXP_SLTSTA_CC |
-		PCI_EXP_SLTSTA_DLLSC | PCI_EXP_SLTSTA_PDC);
-
-	ctrl_info(ctrl, "Slot #%d AttnBtn%c PwrCtrl%c MRL%c AttnInd%c PwrInd%c HotPlug%c Surprise%c Interlock%c NoCompl%c IbPresDis%c LLActRep%c%s\n",
-		FIELD_GET(PCI_EXP_SLTCAP_PSN, slot_cap),
-		FLAG(slot_cap, PCI_EXP_SLTCAP_ABP),
-		FLAG(slot_cap, PCI_EXP_SLTCAP_PCP),
-		FLAG(slot_cap, PCI_EXP_SLTCAP_MRLSP),
-		FLAG(slot_cap, PCI_EXP_SLTCAP_AIP),
-		FLAG(slot_cap, PCI_EXP_SLTCAP_PIP),
-		FLAG(slot_cap, PCI_EXP_SLTCAP_HPC),
-		FLAG(slot_cap, PCI_EXP_SLTCAP_HPS),
-		FLAG(slot_cap, PCI_EXP_SLTCAP_EIP),
-		FLAG(slot_cap, PCI_EXP_SLTCAP_NCCS),
-		FLAG(slot_cap2, PCI_EXP_SLTCAP2_IBPD),
-		FLAG(pdev->link_active_reporting, true),
-		pdev->broken_cmd_compl ? " (with Cmd Compl erratum)" : "");
-
-	/*
-	 * If empty slot's power status is on, turn power off.  The IRQ isn't
-	 * requested yet, so avoid triggering a notification with this command.
-	 */
-	if (POWER_CTRL(ctrl)) {
-		pciehp_get_power_status(ctrl, &poweron);
-		if (!pciehp_card_present_or_link_active(ctrl) && poweron) {
-			pcie_disable_notification(ctrl);
-			pciehp_power_off_slot(ctrl);
-		}
-	}
-
-	pdev = pci_get_slot(subordinate, PCI_DEVFN(0, 0));
-	if (pdev)
-		ctrl->dsn = pci_get_dsn(pdev);
-	pci_dev_put(pdev);
-
-	return ctrl;
-}
-
-void pciehp_release_ctrl(struct controller *ctrl)
-{
-	cancel_delayed_work_sync(&ctrl->button_work);
-	kfree(ctrl);
-}
-
-static void quirk_cmd_compl(struct pci_dev *pdev)
-{
-	u32 slot_cap;
-
-	if (pci_is_pcie(pdev)) {
-		pcie_capability_read_dword(pdev, PCI_EXP_SLTCAP, &slot_cap);
-		if (slot_cap & PCI_EXP_SLTCAP_HPC &&
-		    !(slot_cap & PCI_EXP_SLTCAP_NCCS))
-			pdev->broken_cmd_compl = 1;
-	}
-}
-DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
-			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
-DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_QCOM, 0x010e,
-			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
-DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_QCOM, 0x0110,
-			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
-DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_QCOM, 0x0400,
-			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
-DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_QCOM, 0x0401,
-			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
-DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_HXT, 0x0401,
-			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
deleted file mode 100644
index 65e50bee1a8c..000000000000
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ /dev/null
@@ -1,141 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * PCI Express Hot Plug Controller Driver
- *
- * Copyright (C) 1995,2001 Compaq Computer Corporation
- * Copyright (C) 2001 Greg Kroah-Hartman (greg@kroah.com)
- * Copyright (C) 2001 IBM Corp.
- * Copyright (C) 2003-2004 Intel Corporation
- *
- * All rights reserved.
- *
- * Send feedback to <greg@kroah.com>, <kristen.c.accardi@intel.com>
- *
- */
-
-#define dev_fmt(fmt) "pciehp: " fmt
-
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/pci.h>
-#include "../pci.h"
-#include "pciehp.h"
-
-/**
- * pciehp_configure_device() - enumerate PCI devices below a hotplug bridge
- * @ctrl: PCIe hotplug controller
- *
- * Enumerate PCI devices below a hotplug bridge and add them to the system.
- * Return 0 on success, %-EEXIST if the devices are already enumerated or
- * %-ENODEV if enumeration failed.
- */
-int pciehp_configure_device(struct controller *ctrl)
-{
-	struct pci_dev *dev;
-	struct pci_dev *bridge = ctrl->pcie->port;
-	struct pci_bus *parent = bridge->subordinate;
-	int num, ret = 0;
-
-	pci_lock_rescan_remove();
-
-	dev = pci_get_slot(parent, PCI_DEVFN(0, 0));
-	if (dev) {
-		/*
-		 * The device is already there. Either configured by the
-		 * boot firmware or a previous hotplug event.
-		 */
-		ctrl_dbg(ctrl, "Device %s already exists at %04x:%02x:00, skipping hot-add\n",
-			 pci_name(dev), pci_domain_nr(parent), parent->number);
-		pci_dev_put(dev);
-		ret = -EEXIST;
-		goto out;
-	}
-
-	num = pci_scan_slot(parent, PCI_DEVFN(0, 0));
-	if (num == 0) {
-		ctrl_err(ctrl, "No new device found\n");
-		ret = -ENODEV;
-		goto out;
-	}
-
-	for_each_pci_bridge(dev, parent)
-		pci_hp_add_bridge(dev);
-
-	pci_assign_unassigned_bridge_resources(bridge);
-	pcie_bus_configure_settings(parent);
-
-	/*
-	 * Release reset_lock during driver binding
-	 * to avoid AB-BA deadlock with device_lock.
-	 */
-	up_read(&ctrl->reset_lock);
-	pci_bus_add_devices(parent);
-	down_read_nested(&ctrl->reset_lock, ctrl->depth);
-
-	dev = pci_get_slot(parent, PCI_DEVFN(0, 0));
-	ctrl->dsn = pci_get_dsn(dev);
-	pci_dev_put(dev);
-
- out:
-	pci_unlock_rescan_remove();
-	return ret;
-}
-
-/**
- * pciehp_unconfigure_device() - remove PCI devices below a hotplug bridge
- * @ctrl: PCIe hotplug controller
- * @presence: whether the card is still present in the slot;
- *	true for safe removal via sysfs or an Attention Button press,
- *	false for surprise removal
- *
- * Unbind PCI devices below a hotplug bridge from their drivers and remove
- * them from the system.  Safely removed devices are quiesced.  Surprise
- * removed devices are marked as such to prevent further accesses.
- */
-void pciehp_unconfigure_device(struct controller *ctrl, bool presence)
-{
-	struct pci_dev *dev, *temp;
-	struct pci_bus *parent = ctrl->pcie->port->subordinate;
-	u16 command;
-
-	ctrl_dbg(ctrl, "%s: domain:bus:dev = %04x:%02x:00\n",
-		 __func__, pci_domain_nr(parent), parent->number);
-
-	if (!presence)
-		pci_walk_bus(parent, pci_dev_set_disconnected, NULL);
-
-	pci_lock_rescan_remove();
-
-	/*
-	 * Stopping an SR-IOV PF device removes all the associated VFs,
-	 * which will update the bus->devices list and confuse the
-	 * iterator.  Therefore, iterate in reverse so we remove the VFs
-	 * first, then the PF.  We do the same in pci_stop_bus_device().
-	 */
-	list_for_each_entry_safe_reverse(dev, temp, &parent->devices,
-					 bus_list) {
-		pci_dev_get(dev);
-
-		/*
-		 * Release reset_lock during driver unbinding
-		 * to avoid AB-BA deadlock with device_lock.
-		 */
-		up_read(&ctrl->reset_lock);
-		pci_stop_and_remove_bus_device(dev);
-		down_read_nested(&ctrl->reset_lock, ctrl->depth);
-
-		/*
-		 * Ensure that no new Requests will be generated from
-		 * the device.
-		 */
-		if (presence) {
-			pci_read_config_word(dev, PCI_COMMAND, &command);
-			command &= ~(PCI_COMMAND_MASTER | PCI_COMMAND_SERR);
-			command |= PCI_COMMAND_INTX_DISABLE;
-			pci_write_config_word(dev, PCI_COMMAND, command);
-		}
-		pci_dev_put(dev);
-	}
-
-	pci_unlock_rescan_remove();
-}

base-commit: d46b3918fac499f60b7df1cb1437af7344480576
-- 
2.39.5



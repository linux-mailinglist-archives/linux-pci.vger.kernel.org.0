Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF19881961
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2019 14:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfHEMfl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Aug 2019 08:35:41 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4175 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726315AbfHEMfk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 5 Aug 2019 08:35:40 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9529CF5475D42B202018;
        Mon,  5 Aug 2019 20:35:34 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Mon, 5 Aug 2019 20:35:27 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <helgaas@kernel.org>, <lukas@wunner.de>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangxiongfeng2@huawei.com>
Subject: [PATCH v2] pciehp: fix a race between pciehp and removing operations by sysfs
Date:   Mon, 5 Aug 2019 20:32:58 +0800
Message-ID: <1565008378-4733-1-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When I unplug a pcie slot and remove the pcie device by 'sysfs' at the
same time, I got the following calltrace.

 INFO: task irq/746-pciehp:41551 blocked for more than 120 seconds.
       Tainted: P        W  OE     4.19.25-vhulk1901.1.0.h111.aarch64 #1
 "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
 irq/746-pciehp  D    0 41551      2 0x00000228
 Call trace:
  __switch_to+0x94/0xe8
  __schedule+0x270/0x8b0
  schedule+0x2c/0x88
  schedule_preempt_disabled+0x14/0x20
  __mutex_lock.isra.1+0x1fc/0x540
  __mutex_lock_slowpath+0x24/0x30
  mutex_lock+0x80/0xa8
  pci_lock_rescan_remove+0x20/0x28
  pciehp_configure_device+0x30/0x140
  pciehp_handle_presence_or_link_change+0x35c/0x4b0
  pciehp_ist+0x1cc/0x1d0
  irq_thread_fn+0x30/0x80
  irq_thread+0x128/0x200
  kthread+0x134/0x138
  ret_from_fork+0x10/0x18
 INFO: task bash:6424 blocked for more than 120 seconds.
       Tainted: P        W  OE     4.19.25-vhulk1901.1.0.h111.aarch64 #1
 "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
 bash            D    0  6424   2231 0x00000200
 Call trace:
  __switch_to+0x94/0xe8
  __schedule+0x270/0x8b0
  schedule+0x2c/0x88
  schedule_timeout+0x224/0x448
  wait_for_common+0x198/0x2a0
  wait_for_completion+0x28/0x38
  kthread_stop+0x60/0x190
  __free_irq+0x1c0/0x348
  free_irq+0x40/0x88
  pcie_shutdown_notification+0x54/0x80
  pciehp_remove+0x30/0x50
  pcie_port_remove_service+0x3c/0x58
  device_release_driver_internal+0x1b4/0x250
  device_release_driver+0x28/0x38
  bus_remove_device+0xd4/0x160
  device_del+0x128/0x348
  device_unregister+0x24/0x78
  remove_iter+0x48/0x58
  device_for_each_child+0x6c/0xb8
  pcie_port_device_remove+0x2c/0x48
  pcie_portdrv_remove+0x5c/0x68
  pci_device_remove+0x48/0xd8
  device_release_driver_internal+0x1b4/0x250
  device_release_driver+0x28/0x38
  pci_stop_bus_device+0x84/0xb8
  pci_stop_and_remove_bus_device_locked+0x24/0x40
  remove_store+0xa4/0xb8
  dev_attr_store+0x44/0x60
  sysfs_kf_write+0x58/0x80
  kernfs_fop_write+0xe8/0x1f0
  __vfs_write+0x60/0x190
  vfs_write+0xac/0x1c0
  ksys_write+0x6c/0xd8
  __arm64_sys_write+0x24/0x30
  el0_svc_common+0xa0/0x180
  el0_svc_handler+0x38/0x78
  el0_svc+0x8/0xc

When we remove a slot by sysfs.
'pci_stop_and_remove_bus_device_locked()' will be called. This function
will get the global mutex lock 'pci_rescan_remove_lock', and remove the
slot. If the irq thread 'pciehp_ist' is still running, we will wait
until it exits.

If a pciehp interrupt happens immediately after we remove the slot by
sysfs, but before we free the pciehp irq in
'pci_stop_and_remove_bus_device_locked()'. 'pciehp_ist' will hung
because the global mutex lock 'pci_rescan_remove_lock' is held by the
sysfs operation. But the sysfs operation is waiting for the pciehp irq
thread 'pciehp_ist' ends. Then a hung task occurs.

So this two kinds of operation, removing the slot triggered by pciehp
interrupt and removing through 'sysfs', should not be excuted at the
same time. This patch add a global variable to mark that one of these
operations is under processing. When this variable is set,  if another
operation is requested, it will be rejected.

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/pci/hotplug/pciehp.h      |  3 +++
 drivers/pci/hotplug/pciehp_ctrl.c | 13 ++++++++++
 drivers/pci/hotplug/pciehp_hpc.c  | 52 +++++++++++++++++++++++++++++++++++----
 drivers/pci/pci-sysfs.c           |  7 ++++++
 drivers/pci/remove.c              |  5 ++++
 include/linux/pci.h               |  3 +++
 6 files changed, 78 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 8c51a04..b8983c1 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -58,6 +58,8 @@
  *	used for synchronous writes to the Slot Control register
  * @pending_events: used by the IRQ handler to save events retrieved from the
  *	Slot Status register for later consumption by the IRQ thread
+ * @delayed_events: when we delay an event handling because the slot is being
+ *	removed or rescanned, we use this member to pass the delayed event
  * @notification_enabled: whether the IRQ was requested successfully
  * @power_fault_detected: whether a power fault was detected by the hardware
  *	that has not yet been cleared by the user
@@ -91,6 +93,7 @@ struct controller {
 	wait_queue_head_t queue;
 
 	atomic_t pending_events;		/* event handling */
+	int delayed_events;
 	unsigned int notification_enabled:1;
 	unsigned int power_fault_detected;
 	struct task_struct *poll_thread;
diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 631ced0..f8b1212 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -141,6 +141,7 @@ void pciehp_queue_pushbutton_work(struct work_struct *work)
 {
 	struct controller *ctrl = container_of(work, struct controller,
 					       button_work.work);
+	int events = ctrl->delayed_events;
 
 	mutex_lock(&ctrl->state_lock);
 	switch (ctrl->state) {
@@ -151,6 +152,12 @@ void pciehp_queue_pushbutton_work(struct work_struct *work)
 		pciehp_request(ctrl, PCI_EXP_SLTSTA_PDC);
 		break;
 	default:
+		if (events) {
+			atomic_or(events, &ctrl->pending_events);
+			if (!pciehp_poll_mode)
+				irq_wake_thread(ctrl->pcie->irq, ctrl);
+		} else
+			slot_being_removed_rescanned = 0;
 		break;
 	}
 	mutex_unlock(&ctrl->state_lock);
@@ -174,6 +181,7 @@ void pciehp_handle_button_press(struct controller *ctrl)
 		/* blink green LED and turn off amber */
 		pciehp_green_led_blink(ctrl);
 		pciehp_set_attention_status(ctrl, 0);
+		ctrl->delayed_events = 0;
 		schedule_delayed_work(&ctrl->button_work, 5 * HZ);
 		break;
 	case BLINKINGOFF_STATE:
@@ -195,10 +203,12 @@ void pciehp_handle_button_press(struct controller *ctrl)
 		pciehp_set_attention_status(ctrl, 0);
 		ctrl_info(ctrl, "Slot(%s): Action canceled due to button press\n",
 			  slot_name(ctrl));
+		slot_being_removed_rescanned = 0;
 		break;
 	default:
 		ctrl_err(ctrl, "Slot(%s): Ignoring invalid state %#x\n",
 			 slot_name(ctrl), ctrl->state);
+		slot_being_removed_rescanned = 0;
 		break;
 	}
 	mutex_unlock(&ctrl->state_lock);
@@ -217,6 +227,7 @@ void pciehp_handle_disable_request(struct controller *ctrl)
 	mutex_unlock(&ctrl->state_lock);
 
 	ctrl->request_result = pciehp_disable_slot(ctrl, SAFE_REMOVAL);
+	slot_being_removed_rescanned = 0;
 }
 
 void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
@@ -254,6 +265,7 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 	link_active = pciehp_check_link_active(ctrl);
 	if (!present && !link_active) {
 		mutex_unlock(&ctrl->state_lock);
+		slot_being_removed_rescanned = 0;
 		return;
 	}
 
@@ -276,6 +288,7 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 		mutex_unlock(&ctrl->state_lock);
 		break;
 	}
+	slot_being_removed_rescanned = 0;
 }
 
 static int __pciehp_enable_slot(struct controller *ctrl)
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index bd990e3..2db4731 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -631,7 +631,16 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
 	if (events & PCI_EXP_SLTSTA_ABP) {
 		ctrl_info(ctrl, "Slot(%s): Attention button pressed\n",
 			  slot_name(ctrl));
-		pciehp_handle_button_press(ctrl);
+		if (!test_and_set_bit(0, &slot_being_removed_rescanned))
+			pciehp_handle_button_press(ctrl);
+		else {
+			if (ctrl->state == BLINKINGOFF_STATE ||
+			    ctrl->state == BLINKINGON_STATE)
+				pciehp_handle_button_press(ctrl);
+			else
+				ctrl_info(ctrl, "Slot(%s): Slot operation failed because a remove or rescan operation is under processing, please try later!\n",
+					  slot_name(ctrl));
+		}
 	}
 
 	/* Check Power Fault Detected */
@@ -647,10 +656,43 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
 	 * or Data Link Layer State Changed events.
 	 */
 	down_read(&ctrl->reset_lock);
-	if (events & DISABLE_SLOT)
-		pciehp_handle_disable_request(ctrl);
-	else if (events & (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC))
-		pciehp_handle_presence_or_link_change(ctrl, events);
+	if (events & DISABLE_SLOT) {
+		if (!test_and_set_bit(0, &slot_being_removed_rescanned))
+			pciehp_handle_disable_request(ctrl);
+		else {
+			if (ctrl->state == BLINKINGOFF_STATE ||
+			    ctrl->state == BLINKINGON_STATE)
+				pciehp_handle_disable_request(ctrl);
+			/*
+			 * If 'button_work.timer' is pending, delay the work
+			 * will cause BUG_ON() in add_timer().
+			 */
+			else if (!timer_pending(&ctrl->button_work.timer)) {
+
+				ctrl->delayed_events = DISABLE_SLOT;
+				schedule_delayed_work(&ctrl->button_work,
+						      3 * HZ);
+			}
+		}
+	} else if (events & (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC)) {
+		if (!test_and_set_bit(0, &slot_being_removed_rescanned))
+			pciehp_handle_presence_or_link_change(ctrl, events);
+		else {
+			if (ctrl->state == BLINKINGOFF_STATE ||
+			    ctrl->state == BLINKINGON_STATE)
+				pciehp_handle_presence_or_link_change(ctrl,
+						events);
+			else if (!timer_pending(&ctrl->button_work.timer)) {
+				ctrl_info(ctrl, "Slot(%s): Surprise link down/up in remove or rescan process!\n",
+					  slot_name(ctrl));
+				ctrl->delayed_events = events &
+							(PCI_EXP_SLTSTA_PDC |
+							PCI_EXP_SLTSTA_DLLSC);
+				schedule_delayed_work(&ctrl->button_work,
+						      3 * HZ);
+			}
+		}
+	}
 	up_read(&ctrl->reset_lock);
 
 	pci_config_pm_runtime_put(pdev);
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 965c721..8ddfd0d 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -473,11 +473,18 @@ static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
 {
 	unsigned long val;
 
+	if (test_and_set_bit(0, &slot_being_removed_rescanned)) {
+		pr_info("Slot is being removed or rescanned, please try later!\n");
+		return -EINVAL;
+	}
+
 	if (kstrtoul(buf, 0, &val) < 0)
 		return -EINVAL;
 
 	if (val && device_remove_file_self(dev, attr))
 		pci_stop_and_remove_bus_device_locked(to_pci_dev(dev));
+
+	slot_being_removed_rescanned = 0;
 	return count;
 }
 static struct device_attribute dev_remove_attr = __ATTR_IGNORE_LOCKDEP(remove,
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index e9c6b12..6d15ad0 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -3,6 +3,11 @@
 #include <linux/module.h>
 #include "pci.h"
 
+/*
+ * When a slot is being removed/rescanned, this flag is set.
+ */
+unsigned long slot_being_removed_rescanned;
+
 static void pci_free_resources(struct pci_dev *dev)
 {
 	int i;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 9e700d9..92575ee 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -952,6 +952,9 @@ enum pcie_bus_config_types {
 /* Do NOT directly access these two variables, unless you are arch-specific PCI
  * code, or PCI core code. */
 extern struct list_head pci_root_buses;	/* List of all known PCI buses */
+
+extern unsigned long slot_being_removed_rescanned;
+
 /* Some device drivers need know if PCI is initiated */
 int no_pci_devices(void);
 
-- 
1.7.12.4


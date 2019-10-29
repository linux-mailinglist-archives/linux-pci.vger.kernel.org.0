Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE5DE8D87
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2019 18:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390855AbfJ2RAl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Oct 2019 13:00:41 -0400
Received: from mga04.intel.com ([192.55.52.120]:3128 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390436AbfJ2RAk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Oct 2019 13:00:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 10:00:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,244,1569308400"; 
   d="scan'208";a="283296169"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 29 Oct 2019 10:00:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 11F6645; Tue, 29 Oct 2019 19:00:23 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Frederick Lawler <fred@fredlawl.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] PCI: pciehp: Prevent deadlock on disconnect
Date:   Tue, 29 Oct 2019 20:00:22 +0300
Message-Id: <20191029170022.57528-2-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191029170022.57528-1-mika.westerberg@linux.intel.com>
References: <20191029170022.57528-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If there are more than one PCIe switch with hotplug downstream ports
hot-removing them leads to a following deadlock:

 INFO: task irq/126-pciehp:198 blocked for more than 120 seconds.
 "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
 irq/126-pciehp  D    0   198      2 0x80000000
 Call Trace:
  __schedule+0x2a2/0x880
  schedule+0x2c/0x80
  schedule_timeout+0x246/0x350
  ? ttwu_do_activate+0x67/0x90
  wait_for_completion+0xb7/0x140
  ? wake_up_q+0x80/0x80
  kthread_stop+0x49/0x110
  __free_irq+0x15c/0x2a0
  free_irq+0x32/0x70
  pcie_shutdown_notification+0x2f/0x50
  pciehp_remove+0x27/0x50
  pcie_port_remove_service+0x36/0x50
  device_release_driver_internal+0x18c/0x250
  device_release_driver+0x12/0x20
  bus_remove_device+0xec/0x160
  device_del+0x13b/0x350
  ? pcie_port_find_device+0x60/0x60
  device_unregister+0x1a/0x60
  remove_iter+0x1e/0x30
  device_for_each_child+0x56/0x90
  pcie_port_device_remove+0x22/0x40
  pcie_portdrv_remove+0x20/0x60
  pci_device_remove+0x3e/0xc0
  device_release_driver_internal+0x18c/0x250
  device_release_driver+0x12/0x20
  pci_stop_bus_device+0x6f/0x90
  pci_stop_bus_device+0x31/0x90
  pci_stop_and_remove_bus_device+0x12/0x20
  pciehp_unconfigure_device+0x88/0x140
  pciehp_disable_slot+0x6a/0x110
  pciehp_handle_presence_or_link_change+0x263/0x400
  pciehp_ist+0x1c9/0x1d0
  ? irq_forced_thread_fn+0x80/0x80
  irq_thread_fn+0x24/0x60
  irq_thread+0xeb/0x190
  ? irq_thread_fn+0x60/0x60
  kthread+0x120/0x140
  ? irq_thread_check_affinity+0xf0/0xf0
  ? kthread_park+0x90/0x90
  ret_from_fork+0x35/0x40
 INFO: task irq/190-pciehp:2288 blocked for more than 120 seconds.
 irq/190-pciehp  D    0  2288      2 0x80000000
 Call Trace:
  __schedule+0x2a2/0x880
  schedule+0x2c/0x80
  schedule_preempt_disabled+0xe/0x10
  __mutex_lock.isra.9+0x2e0/0x4d0
  ? __mutex_lock_slowpath+0x13/0x20
  __mutex_lock_slowpath+0x13/0x20
  mutex_lock+0x2c/0x30
  pci_lock_rescan_remove+0x15/0x20
  pciehp_unconfigure_device+0x4d/0x140
  pciehp_disable_slot+0x6a/0x110
  pciehp_handle_presence_or_link_change+0x263/0x400
  pciehp_ist+0x1c9/0x1d0
  ? irq_forced_thread_fn+0x80/0x80
  irq_thread_fn+0x24/0x60
  irq_thread+0xeb/0x190
  ? irq_thread_fn+0x60/0x60
  kthread+0x120/0x140
  ? irq_thread_check_affinity+0xf0/0xf0
  ? kthread_park+0x90/0x90
  ret_from_fork+0x35/0x40

What happens here is that the whole hierarchy is runtime resumed and the
parent PCIe downstream port, who got the hot-remove event, starts
removing devices below it taking pci_lock_rescan_remove() lock. When the
child PCIe port is runtime resumed it calls pciehp_check_presence()
which ends up calling pciehp_card_present() and pciehp_check_link_active().
Both of these read their parts of PCIe config space by calling helper
function pcie_capability_read_word(). Now, this function notices that
the underlying device is already gone and returns PCIBIOS_DEVICE_NOT_FOUND
with the capability value set to 0. When pciehp gets this value it
thinks that its child device is also hot-removed and schedules its IRQ
thread to handle the event.

The deadlock happens when the child's IRQ thread runs and tries to
acquire pci_lock_rescan_remove() which is already taken by the parent
and the parent waits for the child's IRQ thread to finish.

We can prevent this from happening by checking the return value of
pcie_capability_read_word() and if it is PCIBIOS_DEVICE_NOT_FOUND stop
performing any hot-removal activities.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
Changes from v2 (https://patchwork.kernel.org/patch/11089973/):

  * Check for ~0 as well
  * Added tag from Kai-Heng
  * Always log lnk_status in pciehp_check_link_active()
  * I also experimented renaming the two functions to pciehp_card_absent()
    and pciehp_check_link_down() but it ended up looking odd because now we
    check for !pciehp_card_absent() and so on and we still need to take
    into account the possible error return value (since we need to deal
    with that to avoid accessing hardware upon resume). So instead I added
    kernel-doc to both functions mentioning that the card may not be
    present after the function has returned.

 drivers/pci/hotplug/pciehp.h      |  6 ++--
 drivers/pci/hotplug/pciehp_core.c | 11 ++++--
 drivers/pci/hotplug/pciehp_ctrl.c |  4 +--
 drivers/pci/hotplug/pciehp_hpc.c  | 59 +++++++++++++++++++++++++------
 4 files changed, 61 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 654c972b8ea0..afea59a3aad2 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -172,10 +172,10 @@ void pciehp_set_indicators(struct controller *ctrl, int pwr, int attn);
 
 void pciehp_get_latch_status(struct controller *ctrl, u8 *status);
 int pciehp_query_power_fault(struct controller *ctrl);
-bool pciehp_card_present(struct controller *ctrl);
-bool pciehp_card_present_or_link_active(struct controller *ctrl);
+int pciehp_card_present(struct controller *ctrl);
+int pciehp_card_present_or_link_active(struct controller *ctrl);
 int pciehp_check_link_status(struct controller *ctrl);
-bool pciehp_check_link_active(struct controller *ctrl);
+int pciehp_check_link_active(struct controller *ctrl);
 void pciehp_release_ctrl(struct controller *ctrl);
 
 int pciehp_sysfs_enable_slot(struct hotplug_slot *hotplug_slot);
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index 56daad828c9e..312cc45c44c7 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -139,10 +139,15 @@ static int get_adapter_status(struct hotplug_slot *hotplug_slot, u8 *value)
 {
 	struct controller *ctrl = to_ctrl(hotplug_slot);
 	struct pci_dev *pdev = ctrl->pcie->port;
+	int ret;
 
 	pci_config_pm_runtime_get(pdev);
-	*value = pciehp_card_present_or_link_active(ctrl);
+	ret = pciehp_card_present_or_link_active(ctrl);
 	pci_config_pm_runtime_put(pdev);
+	if (ret < 0)
+		return ret;
+
+	*value = ret;
 	return 0;
 }
 
@@ -158,13 +163,13 @@ static int get_adapter_status(struct hotplug_slot *hotplug_slot, u8 *value)
  */
 static void pciehp_check_presence(struct controller *ctrl)
 {
-	bool occupied;
+	int occupied;
 
 	down_read(&ctrl->reset_lock);
 	mutex_lock(&ctrl->state_lock);
 
 	occupied = pciehp_card_present_or_link_active(ctrl);
-	if ((occupied && (ctrl->state == OFF_STATE ||
+	if ((occupied > 0 && (ctrl->state == OFF_STATE ||
 			  ctrl->state == BLINKINGON_STATE)) ||
 	    (!occupied && (ctrl->state == ON_STATE ||
 			   ctrl->state == BLINKINGOFF_STATE)))
diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 21af7b16d7a4..c760a13ec7b1 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -226,7 +226,7 @@ void pciehp_handle_disable_request(struct controller *ctrl)
 
 void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 {
-	bool present, link_active;
+	int present, link_active;
 
 	/*
 	 * If the slot is on and presence or link has changed, turn it off.
@@ -257,7 +257,7 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 	mutex_lock(&ctrl->state_lock);
 	present = pciehp_card_present(ctrl);
 	link_active = pciehp_check_link_active(ctrl);
-	if (!present && !link_active) {
+	if (present <= 0 && link_active <= 0) {
 		mutex_unlock(&ctrl->state_lock);
 		return;
 	}
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 1a522c1c4177..526a8f70bac5 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -201,17 +201,29 @@ static void pcie_write_cmd_nowait(struct controller *ctrl, u16 cmd, u16 mask)
 	pcie_do_write_cmd(ctrl, cmd, mask, false);
 }
 
-bool pciehp_check_link_active(struct controller *ctrl)
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
+int pciehp_check_link_active(struct controller *ctrl)
 {
 	struct pci_dev *pdev = ctrl_dev(ctrl);
 	u16 lnk_status;
-	bool ret;
+	int ret;
 
-	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
-	ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
+	ret = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
+	if (ret == PCIBIOS_DEVICE_NOT_FOUND || lnk_status == (u16)~0)
+		return -ENODEV;
 
-	if (ret)
-		ctrl_dbg(ctrl, "%s: lnk_status = %x\n", __func__, lnk_status);
+	ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
+	ctrl_dbg(ctrl, "%s: lnk_status = %x\n", __func__, lnk_status);
 
 	return ret;
 }
@@ -373,13 +385,29 @@ void pciehp_get_latch_status(struct controller *ctrl, u8 *status)
 	*status = !!(slot_status & PCI_EXP_SLTSTA_MRLSS);
 }
 
-bool pciehp_card_present(struct controller *ctrl)
+/**
+ * pciehp_card_present() - Is the card present
+ * @ctrl: PCIe hotplug controller
+ *
+ * Function checks whether the card is currently present in the slot and
+ * in that case returns true. Note it is possible that the card is
+ * removed immediately after the check so the caller may need to take
+ * this into account.
+ *
+ * It the hotplug controller itself is not available anymore returns
+ * %-ENODEV.
+ */
+int pciehp_card_present(struct controller *ctrl)
 {
 	struct pci_dev *pdev = ctrl_dev(ctrl);
 	u16 slot_status;
+	int ret;
 
-	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
-	return slot_status & PCI_EXP_SLTSTA_PDS;
+	ret = pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
+	if (ret == PCIBIOS_DEVICE_NOT_FOUND || slot_status == (u16)~0)
+		return -ENODEV;
+
+	return !!(slot_status & PCI_EXP_SLTSTA_PDS);
 }
 
 /**
@@ -390,10 +418,19 @@ bool pciehp_card_present(struct controller *ctrl)
  * Presence Detect State bit, this helper also returns true if the Link Active
  * bit is set.  This is a concession to broken hotplug ports which hardwire
  * Presence Detect State to zero, such as Wilocity's [1ae9:0200].
+ *
+ * Returns: %1 if the slot is occupied and %0 if it is not. If the hotplug
+ *	    port is not present anymore returns %-ENODEV.
  */
-bool pciehp_card_present_or_link_active(struct controller *ctrl)
+int pciehp_card_present_or_link_active(struct controller *ctrl)
 {
-	return pciehp_card_present(ctrl) || pciehp_check_link_active(ctrl);
+	int ret;
+
+	ret = pciehp_card_present(ctrl);
+	if (ret)
+		return ret;
+
+	return pciehp_check_link_active(ctrl);
 }
 
 int pciehp_query_power_fault(struct controller *ctrl)
-- 
2.23.0


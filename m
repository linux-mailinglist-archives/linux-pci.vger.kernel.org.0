Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4C71AF0D4
	for <lists+linux-pci@lfdr.de>; Sat, 18 Apr 2020 16:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbgDROwn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 18 Apr 2020 10:52:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:52064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728267AbgDROmM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 18 Apr 2020 10:42:12 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D180221F4;
        Sat, 18 Apr 2020 14:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587220930;
        bh=3JzdYpCqmji0rTehDTJoWII9UNX10mUkDZQu7QunwRA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RyMNqm6zuTen0HuwCBlaPV4sk1L786h5u5ZJig23E0o68MpgSo/P0UbLkh2fhayG9
         MNsVw0liauB1Bw6jCORHG+/yx4LdxOKWfBlFyGiARkK/fm57enT7nPVesq2Y3Z8F+U
         0X563qrxJbfspBiuSeTV1/PbdwE4O1cRu7MoFb+I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 67/78] PCI: pciehp: Prevent deadlock on disconnect
Date:   Sat, 18 Apr 2020 10:40:36 -0400
Message-Id: <20200418144047.9013-67-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418144047.9013-1-sashal@kernel.org>
References: <20200418144047.9013-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Mika Westerberg <mika.westerberg@linux.intel.com>

[ Upstream commit 87d0f2a5536fdf5053a6d341880f96135549a644 ]

This addresses deadlocks in these common cases in hierarchies containing
two switches:

  - All involved ports are runtime suspended and they are unplugged. This
    can happen easily if the drivers involved automatically enable runtime
    PM (xHCI for example does that).

  - System is suspended (e.g., closing the lid on a laptop) with a dock +
    something else connected, and the dock is unplugged while suspended.

These cases lead to the following deadlock:

  INFO: task irq/126-pciehp:198 blocked for more than 120 seconds.
  irq/126-pciehp  D    0   198      2 0x80000000
  Call Trace:
   schedule+0x2c/0x80
   schedule_timeout+0x246/0x350
   wait_for_completion+0xb7/0x140
   kthread_stop+0x49/0x110
   free_irq+0x32/0x70
   pcie_shutdown_notification+0x2f/0x50
   pciehp_remove+0x27/0x50
   pcie_port_remove_service+0x36/0x50
   device_release_driver+0x12/0x20
   bus_remove_device+0xec/0x160
   device_del+0x13b/0x350
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
   irq_thread_fn+0x24/0x60
   irq_thread+0xeb/0x190
   kthread+0x120/0x140

  INFO: task irq/190-pciehp:2288 blocked for more than 120 seconds.
  irq/190-pciehp  D    0  2288      2 0x80000000
  Call Trace:
   __schedule+0x2a2/0x880
   schedule+0x2c/0x80
   schedule_preempt_disabled+0xe/0x10
   mutex_lock+0x2c/0x30
   pci_lock_rescan_remove+0x15/0x20
   pciehp_unconfigure_device+0x4d/0x140
   pciehp_disable_slot+0x6a/0x110
   pciehp_handle_presence_or_link_change+0x263/0x400
   pciehp_ist+0x1c9/0x1d0
   irq_thread_fn+0x24/0x60
   irq_thread+0xeb/0x190
   kthread+0x120/0x140

What happens here is that the whole hierarchy is runtime resumed and the
parent PCIe downstream port, which got the hot-remove event, starts
removing devices below it, taking pci_lock_rescan_remove() lock. When the
child PCIe port is runtime resumed it calls pciehp_check_presence() which
ends up calling pciehp_card_present() and pciehp_check_link_active().  Both
of these use pcie_capability_read_word(), which notices that the underlying
device is already gone and returns PCIBIOS_DEVICE_NOT_FOUND with the
capability value set to 0. When pciehp gets this value it thinks that its
child device is also hot-removed and schedules its IRQ thread to handle the
event.

The deadlock happens when the child's IRQ thread runs and tries to acquire
pci_lock_rescan_remove() which is already taken by the parent and the
parent waits for the child's IRQ thread to finish.

Prevent this from happening by checking the return value of
pcie_capability_read_word() and if it is PCIBIOS_DEVICE_NOT_FOUND stop
performing any hot-removal activities.

[bhelgaas: add common scenarios to commit log]
Link: https://lore.kernel.org/r/20191029170022.57528-2-mika.westerberg@linux.intel.com
Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/hotplug/pciehp.h      |  6 ++--
 drivers/pci/hotplug/pciehp_core.c | 11 ++++--
 drivers/pci/hotplug/pciehp_ctrl.c |  4 +--
 drivers/pci/hotplug/pciehp_hpc.c  | 59 +++++++++++++++++++++++++------
 4 files changed, 61 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 882ce82c46990..aa61d4c219d7b 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -174,10 +174,10 @@ void pciehp_set_indicators(struct controller *ctrl, int pwr, int attn);
 
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
index 56daad828c9e0..312cc45c44c78 100644
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
index dd8e4a5fb2826..6503d15effbbd 100644
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
index 86d97f3112f02..a2a263764ef88 100644
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
2.20.1


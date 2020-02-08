Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED711561AB
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2020 01:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgBHAAT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Feb 2020 19:00:19 -0500
Received: from mga03.intel.com ([134.134.136.65]:58200 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727491AbgBHAAT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Feb 2020 19:00:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2020 16:00:18 -0800
X-IronPort-AV: E=Sophos;i="5.70,415,1574150400"; 
   d="scan'208";a="225545754"
Received: from nsgsw-rhel7p6.lm.intel.com ([10.232.116.83])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2020 16:00:17 -0800
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Pawel Baldysiak <pawel.baldysiak@intel.com>,
        Sinan Kaya <okaya@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <kbusch@kernel.org>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [RFC 4/9] PCI: pciehp: Indirect slot register operations
Date:   Fri,  7 Feb 2020 17:00:02 -0700
Message-Id: <1581120007-5280-5-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1581120007-5280-1-git-send-email-jonathan.derrick@intel.com>
References: <1581120007-5280-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Allow another driver to provide alternative operations when doing
capability register reads and writes to the Slot Capabilities, Slot
Control, and Slot Status registers. Add handlers to pciehp to read/write
the slot registers.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/hotplug/pciehp.h     |   8 +++
 drivers/pci/hotplug/pciehp_hpc.c | 116 ++++++++++++++++++++++++++++-----------
 2 files changed, 93 insertions(+), 31 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index aa61d4c..c898c75 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -28,6 +28,12 @@
 extern bool pciehp_poll_mode;
 extern int pciehp_poll_time;
 
+/* Capability reads/writes but only for SLTCAP, SLTCTL, and SLTSTA. */
+struct slot_ecap_ops {
+	int (*read)(struct pci_dev *dev, int pos, int len, u32 *val);
+	int (*write)(struct pci_dev *dev, int pos, int len, u32 val);
+};
+
 /*
  * Set CONFIG_DYNAMIC_DEBUG=y and boot with 'dyndbg="file pciehp* +p"' to
  * enable debug messages.
@@ -76,6 +82,7 @@
  * @request_result: result of last user request submitted to the IRQ thread
  * @requester: wait queue to wake up on completion of user request,
  *	used for synchronous slot enable/disable request via sysfs
+ * @slot_ops: slot config registers read/write operations
  *
  * PCIe hotplug has a 1:1 relationship between controller and slot, hence
  * unlike other drivers, the two aren't represented by separate structures.
@@ -105,6 +112,7 @@ struct controller {
 	unsigned int ist_running;
 	int request_result;
 	wait_queue_head_t requester;
+	struct slot_ecap_ops *slot_ops;
 };
 
 /**
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 8a2cb17..ce1e8c7 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -35,6 +35,52 @@ static inline struct pci_dev *ctrl_dev(struct controller *ctrl)
 static irqreturn_t pciehp_ist(int irq, void *dev_id);
 static int pciehp_poll(void *data);
 
+static int pcie_read_slot_capabilities(struct controller *ctrl, u32 *sltcap)
+{
+	return ctrl->slot_ops->read(ctrl_dev(ctrl), PCI_EXP_SLTCAP,
+				    sizeof(*sltcap), sltcap);
+}
+
+static int pcie_read_slot_control(struct controller *ctrl, u16 *sltctl)
+{
+	int ret;
+	u32 l;
+
+	ret = ctrl->slot_ops->read(ctrl_dev(ctrl), PCI_EXP_SLTCTL,
+				   sizeof(*sltctl), &l);
+	if (ret)
+		return ret;
+
+	*sltctl = l;
+	return 0;
+}
+
+static int pcie_write_slot_control(struct controller *ctrl, u16 sltctl)
+{
+	return ctrl->slot_ops->write(ctrl_dev(ctrl), PCI_EXP_SLTCTL,
+				     sizeof(sltctl), sltctl);
+}
+
+static int pcie_read_slot_status(struct controller *ctrl, u16 *sltsta)
+{
+	int ret;
+	u32 l;
+
+	ret = ctrl->slot_ops->read(ctrl_dev(ctrl), PCI_EXP_SLTSTA,
+				   sizeof(*sltsta), &l);
+	if (ret)
+		return ret;
+
+	*sltsta = l;
+	return 0;
+}
+
+static int pcie_write_slot_status(struct controller *ctrl, u16 sltsta)
+{
+	return ctrl->slot_ops->write(ctrl_dev(ctrl), PCI_EXP_SLTSTA,
+				     sizeof(sltsta), sltsta);
+}
+
 static inline int pciehp_request_irq(struct controller *ctrl)
 {
 	int retval, irq = ctrl->pcie->irq;
@@ -65,11 +111,10 @@ static inline void pciehp_free_irq(struct controller *ctrl)
 
 static int pcie_poll_cmd(struct controller *ctrl, int timeout)
 {
-	struct pci_dev *pdev = ctrl_dev(ctrl);
 	u16 slot_status;
 
 	do {
-		pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
+		pcie_read_slot_status(ctrl, &slot_status);
 		if (slot_status == (u16) ~0) {
 			ctrl_info(ctrl, "%s: no response from device\n",
 				  __func__);
@@ -77,8 +122,7 @@ static int pcie_poll_cmd(struct controller *ctrl, int timeout)
 		}
 
 		if (slot_status & PCI_EXP_SLTSTA_CC) {
-			pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
-						   PCI_EXP_SLTSTA_CC);
+			pcie_write_slot_status(ctrl, PCI_EXP_SLTSTA_CC);
 			return 1;
 		}
 		msleep(10);
@@ -145,7 +189,7 @@ static void pcie_do_write_cmd(struct controller *ctrl, u16 cmd,
 	 */
 	pcie_wait_cmd(ctrl);
 
-	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
+	pcie_read_slot_control(ctrl, &slot_ctrl);
 	if (slot_ctrl == (u16) ~0) {
 		ctrl_info(ctrl, "%s: no response from device\n", __func__);
 		goto out;
@@ -157,7 +201,7 @@ static void pcie_do_write_cmd(struct controller *ctrl, u16 cmd,
 	ctrl->cmd_busy = 1;
 	smp_mb();
 	ctrl->slot_ctrl = slot_ctrl;
-	pcie_capability_write_word(pdev, PCI_EXP_SLTCTL, slot_ctrl);
+	pcie_write_slot_control(ctrl, slot_ctrl);
 	ctrl->cmd_started = jiffies;
 
 	/*
@@ -316,7 +360,7 @@ int pciehp_get_raw_indicator_status(struct hotplug_slot *hotplug_slot,
 	u16 slot_ctrl;
 
 	pci_config_pm_runtime_get(pdev);
-	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
+	pcie_read_slot_control(ctrl, &slot_ctrl);
 	pci_config_pm_runtime_put(pdev);
 	*status = (slot_ctrl & (PCI_EXP_SLTCTL_AIC | PCI_EXP_SLTCTL_PIC)) >> 6;
 	return 0;
@@ -329,7 +373,7 @@ int pciehp_get_attention_status(struct hotplug_slot *hotplug_slot, u8 *status)
 	u16 slot_ctrl;
 
 	pci_config_pm_runtime_get(pdev);
-	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
+	pcie_read_slot_control(ctrl, &slot_ctrl);
 	pci_config_pm_runtime_put(pdev);
 	ctrl_dbg(ctrl, "%s: SLOTCTRL %x, value read %x\n", __func__,
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, slot_ctrl);
@@ -354,10 +398,9 @@ int pciehp_get_attention_status(struct hotplug_slot *hotplug_slot, u8 *status)
 
 void pciehp_get_power_status(struct controller *ctrl, u8 *status)
 {
-	struct pci_dev *pdev = ctrl_dev(ctrl);
 	u16 slot_ctrl;
 
-	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
+	pcie_read_slot_control(ctrl, &slot_ctrl);
 	ctrl_dbg(ctrl, "%s: SLOTCTRL %x value read %x\n", __func__,
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, slot_ctrl);
 
@@ -376,10 +419,9 @@ void pciehp_get_power_status(struct controller *ctrl, u8 *status)
 
 void pciehp_get_latch_status(struct controller *ctrl, u8 *status)
 {
-	struct pci_dev *pdev = ctrl_dev(ctrl);
 	u16 slot_status;
 
-	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
+	pcie_read_slot_status(ctrl, &slot_status);
 	*status = !!(slot_status & PCI_EXP_SLTSTA_MRLSS);
 }
 
@@ -397,11 +439,10 @@ void pciehp_get_latch_status(struct controller *ctrl, u8 *status)
  */
 int pciehp_card_present(struct controller *ctrl)
 {
-	struct pci_dev *pdev = ctrl_dev(ctrl);
 	u16 slot_status;
 	int ret;
 
-	ret = pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
+	ret = pcie_read_slot_status(ctrl, &slot_status);
 	if (ret == PCIBIOS_DEVICE_NOT_FOUND || slot_status == (u16)~0)
 		return -ENODEV;
 
@@ -433,10 +474,9 @@ int pciehp_card_present_or_link_active(struct controller *ctrl)
 
 int pciehp_query_power_fault(struct controller *ctrl)
 {
-	struct pci_dev *pdev = ctrl_dev(ctrl);
 	u16 slot_status;
 
-	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
+	pcie_read_slot_status(ctrl, &slot_status);
 	return !!(slot_status & PCI_EXP_SLTSTA_PFD);
 }
 
@@ -491,15 +531,13 @@ void pciehp_set_indicators(struct controller *ctrl, int pwr, int attn)
 
 int pciehp_power_on_slot(struct controller *ctrl)
 {
-	struct pci_dev *pdev = ctrl_dev(ctrl);
 	u16 slot_status;
 	int retval;
 
 	/* Clear power-fault bit from previous power failures */
-	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
+	pcie_read_slot_status(ctrl, &slot_status);
 	if (slot_status & PCI_EXP_SLTSTA_PFD)
-		pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
-					   PCI_EXP_SLTSTA_PFD);
+		pcie_write_slot_status(ctrl, PCI_EXP_SLTSTA_PFD);
 	ctrl->power_fault_detected = 0;
 
 	pcie_write_cmd(ctrl, PCI_EXP_SLTCTL_PWR_ON, PCI_EXP_SLTCTL_PCC);
@@ -552,7 +590,7 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 		}
 	}
 
-	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &status);
+	pcie_read_slot_status(ctrl, &status);
 	if (status == (u16) ~0) {
 		ctrl_info(ctrl, "%s: no response from device\n", __func__);
 		if (parent)
@@ -581,7 +619,7 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 		return IRQ_NONE;
 	}
 
-	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, events);
+	pcie_write_slot_status(ctrl, events);
 	ctrl_dbg(ctrl, "pending interrupts %#06x from Slot Status\n", events);
 	if (parent)
 		pm_runtime_put(parent);
@@ -744,8 +782,7 @@ static void pcie_disable_notification(struct controller *ctrl)
 
 void pcie_clear_hotplug_events(struct controller *ctrl)
 {
-	pcie_capability_write_word(ctrl_dev(ctrl), PCI_EXP_SLTSTA,
-				   PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC);
+	pcie_write_slot_status(ctrl, PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC);
 }
 
 void pcie_enable_interrupt(struct controller *ctrl)
@@ -782,7 +819,6 @@ void pcie_disable_interrupt(struct controller *ctrl)
 int pciehp_reset_slot(struct hotplug_slot *hotplug_slot, int probe)
 {
 	struct controller *ctrl = to_ctrl(hotplug_slot);
-	struct pci_dev *pdev = ctrl_dev(ctrl);
 	u16 stat_mask = 0, ctrl_mask = 0;
 	int rc;
 
@@ -804,7 +840,7 @@ int pciehp_reset_slot(struct hotplug_slot *hotplug_slot, int probe)
 
 	rc = pci_bridge_secondary_bus_reset(ctrl->pcie->port);
 
-	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, stat_mask);
+	pcie_write_slot_status(ctrl, stat_mask);
 	pcie_write_cmd_nowait(ctrl, ctrl_mask, ctrl_mask);
 	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, ctrl_mask);
@@ -833,16 +869,32 @@ void pcie_shutdown_notification(struct controller *ctrl)
 
 static inline void dbg_ctrl(struct controller *ctrl)
 {
-	struct pci_dev *pdev = ctrl->pcie->port;
 	u16 reg16;
 
 	ctrl_dbg(ctrl, "Slot Capabilities      : 0x%08x\n", ctrl->slot_cap);
-	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &reg16);
+	pcie_read_slot_status(ctrl, &reg16);
 	ctrl_dbg(ctrl, "Slot Status            : 0x%04x\n", reg16);
-	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &reg16);
+	pcie_read_slot_control(ctrl, &reg16);
 	ctrl_dbg(ctrl, "Slot Control           : 0x%04x\n", reg16);
 }
 
+static int pciehp_read_slot(struct pci_dev *dev, int pos, int len, u32 *val)
+{
+	return (len == 2) ? pcie_capability_read_word(dev, pos, (u16 *)val) :
+			    pcie_capability_read_dword(dev, pos, val);
+}
+
+static int pciehp_write_slot(struct pci_dev *dev, int pos, int len, u32 val)
+{
+	return (len == 2) ? pcie_capability_write_word(dev, pos, val) :
+			    pcie_capability_write_dword(dev, pos, val);
+}
+
+static struct slot_ecap_ops pciehp_default_slot_ops = {
+	.read = pciehp_read_slot,
+	.write = pciehp_write_slot,
+};
+
 #define FLAG(x, y)	(((x) & (y)) ? '+' : '-')
 
 struct controller *pcie_init(struct pcie_device *dev)
@@ -858,7 +910,9 @@ struct controller *pcie_init(struct pcie_device *dev)
 		return NULL;
 
 	ctrl->pcie = dev;
-	pcie_capability_read_dword(pdev, PCI_EXP_SLTCAP, &slot_cap);
+
+	ctrl->slot_ops = &pciehp_default_slot_ops;
+	pcie_read_slot_capabilities(ctrl, &slot_cap);
 
 	if (pdev->hotplug_user_indicators)
 		slot_cap &= ~(PCI_EXP_SLTCAP_AIP | PCI_EXP_SLTCAP_PIP);
@@ -887,7 +941,7 @@ struct controller *pcie_init(struct pcie_device *dev)
 	pcie_capability_read_dword(pdev, PCI_EXP_LNKCAP, &link_cap);
 
 	/* Clear all remaining event bits in Slot Status register. */
-	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
+	pcie_write_slot_status(ctrl,
 		PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD |
 		PCI_EXP_SLTSTA_MRLSC | PCI_EXP_SLTSTA_CC |
 		PCI_EXP_SLTSTA_DLLSC | PCI_EXP_SLTSTA_PDC);
-- 
1.8.3.1


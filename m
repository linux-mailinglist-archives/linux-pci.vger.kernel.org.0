Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F15CF2BC303
	for <lists+linux-pci@lfdr.de>; Sun, 22 Nov 2020 02:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgKVBmJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 21 Nov 2020 20:42:09 -0500
Received: from mga14.intel.com ([192.55.52.115]:45385 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726862AbgKVBmI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 21 Nov 2020 20:42:08 -0500
IronPort-SDR: sDTV7WweHfdSQM85vxyNYjlncRk//DNif8/thokN8mUKwIH7wmLHjY38cf+c2JdBMiItkJXr98
 heeTxHMvLmsA==
X-IronPort-AV: E=McAfee;i="6000,8403,9812"; a="170839150"
X-IronPort-AV: E=Sophos;i="5.78,360,1599548400"; 
   d="scan'208";a="170839150"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2020 17:42:07 -0800
IronPort-SDR: x8rt2gW6FNs0ErfjroCYGoJpVzrM2RBK4de4OXfXGz5U7g4bX0C24d6jwx1FJZ3YxBHZ9HBfE+
 OPVx365BLahA==
X-IronPort-AV: E=Sophos;i="5.78,360,1599548400"; 
   d="scan'208";a="360961567"
Received: from araj-mobl1.jf.intel.com (HELO localhost) ([10.252.131.178])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2020 17:42:07 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>
Cc:     Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [Patch v2 1/1] PCI: pciehp: Add support for handling MRL events
Date:   Sat, 21 Nov 2020 17:42:03 -0800
Message-Id: <20201122014203.4706-1-ashok.raj@intel.com>
X-Mailer: git-send-email 2.13.6
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When Mechanical Retention Lock (MRL) is present, Linux doesn't process
those change events.

Support for these can be found starting Icelake Server.

The following changes need to be enabled when MRL is present.

1. Subscribe to MRL change events in SlotControl.
2. When MRL is closed,
   - If there is no ATTN button, then POWER on the slot.
   - If there is ATTN button, and an MRL event pending, ignore
     Presence Detect. Since we want ATTN button to drive the
     hotplug event.
   - If currently slot is powered on, but MRL is open,
     PCIe Base Spec 5.0 Chapter 6.7.1.3 states.
     If an MRL Sensor is implemented without a corresponding
     MRL Sensor input on the Hot-Plug Controller, it is recommended
     that the MRL Sensor be routed to power fault input of the Hot-Plug
     Controller. This allows an active adapter to be powered off when the
     MRL is opened."

     This seems to suggest that the slot should be brought
     down as soon as MRL is opened.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
Changes since v1:
- Changes suggested by Lucas Wunner
  https://lore.kernel.org/linux-pci/20201119223749.GA103783@otc-nc-03/T/#m1f661ae901e7dedad73dea370bb63abd52c610eb
  - Consolidate MRL handling in pciehp_handle_presence_or_link_change()
  - Added helped latch_closed()
  - Add comments why MRL open should function as hot-remove.
  - Don't nuke PDC, it might mask a button PUSH synthesized event after 5
    secs.
- Bjorn: Fix Subject to be consistent with other commits.
---
 drivers/pci/hotplug/pciehp_ctrl.c | 36 +++++++++++++++++++++++++++++++++++-
 drivers/pci/hotplug/pciehp_hpc.c  | 14 ++++++++++++--
 2 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 9f85815b4f53..aa8b187ff769 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -224,9 +224,22 @@ void pciehp_handle_disable_request(struct controller *ctrl)
 	ctrl->request_result = pciehp_disable_slot(ctrl, SAFE_REMOVAL);
 }
 
+static bool latch_closed(struct controller *ctrl)
+{
+	u8 getstatus = 0;
+
+	if (!MRL_SENS(ctrl))
+		return true;
+
+	pciehp_get_latch_status(ctrl, &getstatus);
+
+	return (getstatus == 0 ? true : false);
+}
+
 void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 {
 	int present, link_active;
+	u8 getstatus = 0;
 
 	/*
 	 * If the slot is on and presence or link has changed, turn it off.
@@ -246,6 +259,20 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 		if (events & PCI_EXP_SLTSTA_PDC)
 			ctrl_info(ctrl, "Slot(%s): Card not present\n",
 				  slot_name(ctrl));
+		if (events & PCI_EXP_SLTSTA_MRLSC)
+			ctrl_info(ctrl, "Slot(%s): Latch %s\n",
+				  slot_name(ctrl), getstatus ? "Open" : "Closed");
+		/*
+		 * PCIe Base Spec 5.0 Chapter 6.7.1.3 states.
+		 *
+		 * If an MRL Sensor is implemented without a corresponding MRL Sensor input
+		 * on the Hot-Plug Controller, it is recommended that the MRL Sensor be
+		 * routed to power fault input of the Hot-Plug Controller.
+		 * This allows an active adapter to be powered off when the MRL is opened."
+		 *
+		 * This seems to suggest that the slot should be brought down as soon as MRL
+		 * is opened.
+		 */
 		pciehp_disable_slot(ctrl, SURPRISE_REMOVAL);
 		break;
 	default:
@@ -257,7 +284,7 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 	mutex_lock(&ctrl->state_lock);
 	present = pciehp_card_present(ctrl);
 	link_active = pciehp_check_link_active(ctrl);
-	if (present <= 0 && link_active <= 0) {
+	if ((present <= 0 && link_active <= 0) || !latch_closed(ctrl)) {
 		mutex_unlock(&ctrl->state_lock);
 		return;
 	}
@@ -275,6 +302,13 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 		if (link_active)
 			ctrl_info(ctrl, "Slot(%s): Link Up\n",
 				  slot_name(ctrl));
+		/*
+		 * If slot is closed && ATTN button exists
+		 * don't continue, let the ATTN button
+		 * drive the hot-plug
+		 */
+		if (((events & PCI_EXP_SLTSTA_MRLSC) && ATTN_BUTTN(ctrl)))
+			return;
 		ctrl->request_result = pciehp_enable_slot(ctrl);
 		break;
 	default:
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 53433b37e181..7cfa27bcf951 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -605,7 +605,7 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 	 */
 	status &= PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD |
 		  PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_CC |
-		  PCI_EXP_SLTSTA_DLLSC;
+		  PCI_EXP_SLTSTA_DLLSC | PCI_EXP_SLTSTA_MRLSC;
 
 	/*
 	 * If we've already reported a power fault, don't report it again
@@ -710,8 +710,10 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
 	down_read(&ctrl->reset_lock);
 	if (events & DISABLE_SLOT)
 		pciehp_handle_disable_request(ctrl);
-	else if (events & (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC))
+	else if (events & (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC |
+			   PCI_EXP_SLTSTA_MRLSC))
 		pciehp_handle_presence_or_link_change(ctrl, events);
+
 	up_read(&ctrl->reset_lock);
 
 	ret = IRQ_HANDLED;
@@ -768,6 +770,14 @@ static void pcie_enable_notification(struct controller *ctrl)
 		cmd |= PCI_EXP_SLTCTL_ABPE;
 	else
 		cmd |= PCI_EXP_SLTCTL_PDCE;
+
+	/*
+	 * If MRL sensor is present, then subscribe for MRL
+	 * Changes to be notified as well.
+	 */
+	if (MRL_SENS(ctrl))
+		cmd |= PCI_EXP_SLTCTL_MRLSCE;
+
 	if (!pciehp_poll_mode)
 		cmd |= PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_CCIE;
 
-- 
2.7.4


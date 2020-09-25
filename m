Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDA3279474
	for <lists+linux-pci@lfdr.de>; Sat, 26 Sep 2020 01:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbgIYXBn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Sep 2020 19:01:43 -0400
Received: from mga18.intel.com ([134.134.136.126]:27868 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726744AbgIYXBn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Sep 2020 19:01:43 -0400
IronPort-SDR: np12i0Lg+umKzZpMcV024nvHB6j8OZtmLpH/BHUwoWmnYKik73TN5QnwGU9tSe2u8kOMhNesbF
 115c+qPXeybA==
X-IronPort-AV: E=McAfee;i="6000,8403,9755"; a="149431115"
X-IronPort-AV: E=Sophos;i="5.77,303,1596524400"; 
   d="scan'208";a="149431115"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 16:01:42 -0700
IronPort-SDR: DnFvtUlyNcbLtVAb2CZbgIuGv9s/tiP/0VOsbBo8z7gLpjo+KxWIKMgq3VSM9/GWRn7+++/8/K
 EjsJK/VfMpPQ==
X-IronPort-AV: E=Sophos;i="5.77,303,1596524400"; 
   d="scan'208";a="292008000"
Received: from araj-mobl1.jf.intel.com (HELO localhost) ([10.254.96.12])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 16:01:41 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] pci: pciehp: Handle MRL interrupts to enable slot for hotplug.
Date:   Fri, 25 Sep 2020 16:01:38 -0700
Message-Id: <20200925230138.29011-1-ashok.raj@intel.com>
X-Mailer: git-send-email 2.13.6
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When Mechanical Retention Lock (MRL) is present, Linux doesn't process
those change events.

The following changes need to be enabled when MRL is present.

1. Subscribe to MRL change events in SlotControl.
2. When MRL is closed,
   - If there is no ATTN button, then POWER on the slot.
   - If there is ATTN button, and an MRL event pending, ignore
     Presence Detect. Since we want ATTN button to drive the
     hotplug event.


Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/hotplug/pciehp.h      |  1 +
 drivers/pci/hotplug/pciehp_ctrl.c | 69 +++++++++++++++++++++++++++++++++++++++
 drivers/pci/hotplug/pciehp_hpc.c  | 27 ++++++++++++++-
 3 files changed, 96 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 4fd200d8b0a9..24a1c9c8ac78 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -155,6 +155,7 @@ void pciehp_request(struct controller *ctrl, int action);
 void pciehp_handle_button_press(struct controller *ctrl);
 void pciehp_handle_disable_request(struct controller *ctrl);
 void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events);
+void pciehp_handle_mrl_change(struct controller *ctrl);
 int pciehp_configure_device(struct controller *ctrl);
 void pciehp_unconfigure_device(struct controller *ctrl, bool presence);
 void pciehp_queue_pushbutton_work(struct work_struct *work);
diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 9f85815b4f53..c4310ee3678b 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -227,6 +227,7 @@ void pciehp_handle_disable_request(struct controller *ctrl)
 void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 {
 	int present, link_active;
+	u8 getstatus = 0;
 
 	/*
 	 * If the slot is on and presence or link has changed, turn it off.
@@ -275,6 +276,16 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 		if (link_active)
 			ctrl_info(ctrl, "Slot(%s): Link Up\n",
 				  slot_name(ctrl));
+		if (MRL_SENS(ctrl)) {
+			pciehp_get_latch_status(ctrl, &getstatus);
+			/*
+			 * If slot is closed && ATTN button exists
+			 * don't continue, let the ATTN button
+			 * drive the hot-plug
+			 */
+			if (!getstatus && ATTN_BUTTN(ctrl))
+				return;
+		}
 		ctrl->request_result = pciehp_enable_slot(ctrl);
 		break;
 	default:
@@ -283,6 +294,64 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 	}
 }
 
+void pciehp_handle_mrl_change(struct controller *ctrl)
+{
+	u8 getstatus = 0;
+	int present, link_active;
+
+	pciehp_get_latch_status(ctrl, &getstatus);
+
+	present = pciehp_card_present(ctrl);
+	link_active = pciehp_check_link_active(ctrl);
+
+	ctrl_info(ctrl, "Slot(%s): Card %spresent\n",
+		  slot_name(ctrl), present ? "" : "not ");
+
+	ctrl_info(ctrl, "Slot(%s): Link %s\n",
+		  slot_name(ctrl), link_active ? "Up" : "Down");
+
+	ctrl_info(ctrl, "Slot(%s): Latch %s\n",
+			  slot_name(ctrl), getstatus ? "Open" : "Closed");
+
+	/*
+	 * Need to handle only MRL Open. When MRL is closed with
+	 * a Card Present, either the ATTN button, or the PDC indication
+	 * should power the slot and add the card in the slot
+	 */
+	if (getstatus) {
+		/*
+		 * If slot was powered on, time to power off
+		 * and remove the card
+		 */
+		mutex_lock(&ctrl->state_lock);
+		if (ctrl->state == ON_STATE) {
+			mutex_unlock(&ctrl->state_lock);
+			pciehp_handle_disable_request(ctrl);
+		} else
+			mutex_unlock(&ctrl->state_lock);
+	} else {
+		/*
+		 * If latch is closed, and previous state is OFF
+		 * Then enable the slot
+		 */
+		mutex_lock(&ctrl->state_lock);
+		if (ctrl->state == OFF_STATE) {
+			/*
+			 * Only continue to power on the slot when the
+			 * Attention button is not present. When button
+			 * present, button press event will process the
+			 * hot-add part of the flow.
+			 */
+			if ((present || link_active) && !ATTN_BUTTN(ctrl)) {
+				ctrl->state = POWERON_STATE;
+				mutex_unlock(&ctrl->state_lock);
+				ctrl->request_result = pciehp_enable_slot(ctrl);
+			} else
+				mutex_unlock(&ctrl->state_lock);
+		}
+	}
+}
+
 static int __pciehp_enable_slot(struct controller *ctrl)
 {
 	u8 getstatus = 0;
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 53433b37e181..5a4b5cfbfe48 100644
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
@@ -658,6 +658,12 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 		return IRQ_HANDLED;
 	}
 
+	/*
+	 * If MRL is triggered, if ATTN button exists, ignore the event.
+	 */
+	if (ATTN_BUTTN(ctrl) && (events & PCI_EXP_SLTSTA_MRLSC))
+		events &= ~PCI_EXP_SLTSTA_PDC;
+
 	/* Save pending events for consumption by IRQ thread. */
 	atomic_or(events, &ctrl->pending_events);
 	return IRQ_WAKE_THREAD;
@@ -688,6 +694,13 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
 		goto out;
 	}
 
+	/*
+	 * If ATTN is present and MRL is triggered
+	 * ignore the Presence Change Event.
+	 */
+	if (ATTN_BUTTN(ctrl) && (events & PCI_EXP_SLTSTA_MRLSC))
+		events &= ~PCI_EXP_SLTSTA_PDC;
+
 	/* Check Attention Button Pressed */
 	if (events & PCI_EXP_SLTSTA_ABP) {
 		ctrl_info(ctrl, "Slot(%s): Attention button pressed\n",
@@ -712,6 +725,10 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
 		pciehp_handle_disable_request(ctrl);
 	else if (events & (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC))
 		pciehp_handle_presence_or_link_change(ctrl, events);
+
+	if (events & PCI_EXP_SLTSTA_MRLSC)
+		pciehp_handle_mrl_change(ctrl);
+
 	up_read(&ctrl->reset_lock);
 
 	ret = IRQ_HANDLED;
@@ -768,6 +785,14 @@ static void pcie_enable_notification(struct controller *ctrl)
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


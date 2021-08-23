Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC9A13F50BA
	for <lists+linux-pci@lfdr.de>; Mon, 23 Aug 2021 20:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbhHWSuR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Aug 2021 14:50:17 -0400
Received: from mga03.intel.com ([134.134.136.65]:50795 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229969AbhHWSuQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 23 Aug 2021 14:50:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10085"; a="217192169"
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="217192169"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 11:49:33 -0700
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="425853326"
Received: from wps-jon.lm.intel.com (HELO localhost.localdomain) ([10.232.117.157])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 11:49:33 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Cc:     Ashok Raj <ashok.raj@intel.com>, Lukas Wunner <lukas@wunner.de>,
        jonathan.derrick@linux.dev,
        James Puthukattukaran <james.puthukattukaran@oracle.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH v2] PCI: pciehp: Quirk to ignore spurious DLLSC when off
Date:   Mon, 23 Aug 2021 12:49:19 -0600
Message-Id: <20210823184919.3412-1-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: James Puthukattukaran <james.puthukattukaran@oracle.com>

When a specific x8 CEM card is bifurcated into x4x4 mode, and the
upstream ports both support hotplugging on each respective x4 device, a
slot management system for the CEM card requires both x4 devices to be
sysfs removed from the OS before it can safely turn-off physical power.
The implications are that Slot Control will display Powered Off status
for the device where the device is actually powered until both ports
have powered off.

When power is removed from the first half, real power and link remains
active while waiting for the second half to have power removed. When
power is then removed from the second half, the first half starts
shutdown sequence and will trigger a DLLSC event. This is misinterpreted
as an enabling event and causes the first half to be re-enabled.

The spurious enable can be resolved by ignoring link status change
events when no link is active when in the off state. This patch adds a
quirk for the card.

Acked-by: Jon Derrick <jonathan.derrick@intel.com>
Signed-off-by: James Puthukattukaran <james.puthukattukaran@oracle.com>
---
v1->v2: Device-specific quirk

 drivers/pci/hotplug/pciehp_ctrl.c |  7 +++++++
 drivers/pci/quirks.c              | 30 ++++++++++++++++++++++++++++++
 include/linux/pci.h               |  1 +
 3 files changed, 38 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 529c34808440..db41f78bfac8 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -225,6 +225,7 @@ void pciehp_handle_disable_request(struct controller *ctrl)
 void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 {
 	int present, link_active;
+	struct pci_dev *pdev = ctrl->pcie->port;
 
 	/*
 	 * If the slot is on and presence or link has changed, turn it off.
@@ -265,6 +266,12 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 		cancel_delayed_work(&ctrl->button_work);
 		fallthrough;
 	case OFF_STATE:
+		if (pdev->shared_pcc_and_link_slot &&
+		    (events & PCI_EXP_SLTSTA_DLLSC) && !link_active) {
+			mutex_unlock(&ctrl->state_lock);
+			break;
+		}
+
 		ctrl->state = POWERON_STATE;
 		mutex_unlock(&ctrl->state_lock);
 		if (present)
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 43fbf55871ef..92a5bae8926e 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5749,3 +5749,33 @@ static void apex_pci_fixup_class(struct pci_dev *pdev)
 }
 DECLARE_PCI_FIXUP_CLASS_HEADER(0x1ac1, 0x089a,
 			       PCI_CLASS_NOT_DEFINED, 8, apex_pci_fixup_class);
+
+/*
+ * This is a special card that sits in a x8 pciehp slot but is bifurcated as
+ * a x4x4 and manifests as two slots with respect to PCIe hot plug register
+ * states. However, the hotplug controller treats these slots as a single x8
+ * slot for link and power. Either one of the two slots can be powered down
+ * separately but real power and link will be active till the last of the two
+ * slots is powered down. When the last of the two x4 slots is turned off,
+ * power and link will be turned off for the x8 slot by the HP controller.
+ * This configuration causes some interesting behavior in bringup sequence
+ *
+ * When the second slot is powered off to remove the card, this will cause
+ * the link to go down for both x4 slots. So, the x4 that is already powered
+ * down earlier will see a DLLSC event and attempt to bring itself up (card
+ * present, link change event, link state is down). Special handling is
+ * required in pciehp_handle_presence_or_link_change to prevent this unintended
+ * bring up
+ *
+ */
+static void shared_pcc_and_link_slot(struct pci_dev *pdev)
+{
+	struct pci_dev *parent = pci_upstream_bridge(pdev);
+
+	if (pdev->subsystem_vendor == 0x108e &&
+	    pdev->subsystem_device == 0x487d) {
+		if (parent)
+			parent->shared_pcc_and_link_slot = 1;
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0B60, shared_pcc_and_link_slot);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e752cc39a1fe..ba84f7c93c31 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -469,6 +469,7 @@ struct pci_dev {
 
 #ifdef CONFIG_HOTPLUG_PCI_PCIE
 	unsigned int	broken_cmd_compl:1;	/* No compl for some cmds */
+	unsigned int	shared_pcc_and_link_slot:1;
 #endif
 #ifdef CONFIG_PCIE_PTM
 	unsigned int	ptm_root:1;
-- 
2.27.0


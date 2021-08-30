Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3CD3FB978
	for <lists+linux-pci@lfdr.de>; Mon, 30 Aug 2021 17:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237690AbhH3P5b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Aug 2021 11:57:31 -0400
Received: from mga12.intel.com ([192.55.52.136]:49629 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237646AbhH3P5b (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Aug 2021 11:57:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10092"; a="197863102"
X-IronPort-AV: E=Sophos;i="5.84,363,1620716400"; 
   d="scan'208";a="197863102"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 08:56:37 -0700
X-IronPort-AV: E=Sophos;i="5.84,363,1620716400"; 
   d="scan'208";a="530480613"
Received: from wps-jon.lm.intel.com (HELO localhost.localdomain) ([10.232.117.157])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 08:56:37 -0700
From:   Jon Derrick <jonathan.derrick@linux.dev>
To:     <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Cc:     Ashok Raj <ashok.raj@intel.com>, Lukas Wunner <lukas@wunner.de>,
        jonathan.derrick@linux.dev,
        James Puthukattukaran <james.puthukattukaran@oracle.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH v3] PCI: pciehp: Add quirk to handle spurious DLLSC on a x4x4 SSD
Date:   Mon, 30 Aug 2021 09:56:28 -0600
Message-Id: <20210830155628.130054-1-jonathan.derrick@linux.dev>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: James Puthukattukaran <james.puthukattukaran@oracle.com>

When an Intel P5608 SSD is bifurcated into x4x4 mode, and the upstream
ports both support hotplugging on each respective x4 device, a slot
management system for the SSD requires both x4 slots to have power
removed via sysfs (echo 0 > slot/N/power), from the OS before it can
safely turn-off physical power for the whole x8 device. The implications
are that slot status will display powered off and link inactive statuses
for the x4 devices where the devices are actually powered until both
ports have powered off.

The issue with the SSD manifests when power is removed from the
first-half and then the second-half. During the first-half removal, slot
status shows the slot as powered-down and link-inactive, while internal
power and link remain active while waiting for the second-half to have
power removed. When power is then removed from the second-half, the
first-half starts shutdown sequence and will trigger a DLLSC event. This
is misinterpreted as an enabling event and causes the first-half to be
re-enabled.

The spurious enable can be resolved by ignoring link status change
events when no link is active when in the off state. This patch adds a
quirk for specific P5608 SSDs which have been tested for compatibility.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
Signed-off-by: James Puthukattukaran <james.puthukattukaran@oracle.com>
---
v2->v3: Clarified commit message and comment block
	Added second supported subdevice ID
	Added hotplug ifdef blocks

 drivers/pci/hotplug/pciehp_ctrl.c |  7 +++++++
 drivers/pci/quirks.c              | 34 +++++++++++++++++++++++++++++++
 include/linux/pci.h               |  1 +
 3 files changed, 42 insertions(+)

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
index 10122e3318cf..c6b48ddc5c3d 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5750,3 +5750,37 @@ static void apex_pci_fixup_class(struct pci_dev *pdev)
 }
 DECLARE_PCI_FIXUP_CLASS_HEADER(0x1ac1, 0x089a,
 			       PCI_CLASS_NOT_DEFINED, 8, apex_pci_fixup_class);
+
+#ifdef CONFIG_HOTPLUG_PCI_PCIE
+/*
+ * This is an Intel NVMe SSD which sits in a x8 pciehp slot but is bifurcated
+ * as a x4x4 and manifests as two slots with respect to PCIe hot plug register
+ * states. However, the hotplug controller treats these slots as a single x8
+ * slot for link and power. Either one of the two slots can be powered down
+ * separately and the slot status will show negative power and link states, but
+ * internal power and link will be active until the last of the two slots is
+ * powered down. When the last of the two x4 slots is turned off, power and
+ * link will be turned off for the x8 slot by the HP controller. This
+ * configuration causes some interesting behavior in bringup sequence
+ *
+ * When the second slot is powered off to remove the card, this will cause the
+ * link to go down for both x4 slots. So, the x4 that is already powered down
+ * earlier will see a DLLSC event and attempt to bring itself up (card present,
+ * link change event, link state is down). Special handling is required in
+ * pciehp_handle_presence_or_link_change to prevent this unintended bring up
+ */
+static void quirk_shared_pcc_and_link_slot(struct pci_dev *pdev)
+{
+	struct pci_dev *parent = pci_upstream_bridge(pdev);
+
+	if (parent && pdev->subsystem_vendor == 0x108e) {
+		switch (pdev->subsystem_device) {
+		/* P5608 */
+		case 0x487d:
+		case 0x488d:
+			parent->shared_pcc_and_link_slot = 1;
+		}
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0b60, quirk_shared_pcc_and_link_slot);
+#endif /* CONFIG_HOTPLUG_PCI_PCIE */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 7ed95f11c6bd..bcef73209487 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -463,6 +463,7 @@ struct pci_dev {
 
 #ifdef CONFIG_HOTPLUG_PCI_PCIE
 	unsigned int	broken_cmd_compl:1;	/* No compl for some cmds */
+	unsigned int	shared_pcc_and_link_slot:1;
 #endif
 #ifdef CONFIG_PCIE_PTM
 	unsigned int	ptm_root:1;
-- 
2.27.0


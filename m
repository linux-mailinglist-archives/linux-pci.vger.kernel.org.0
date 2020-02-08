Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBB461561B2
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2020 01:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbgBHAA1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Feb 2020 19:00:27 -0500
Received: from mga03.intel.com ([134.134.136.65]:58200 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727573AbgBHAA0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Feb 2020 19:00:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2020 16:00:26 -0800
X-IronPort-AV: E=Sophos;i="5.70,415,1574150400"; 
   d="scan'208";a="225545840"
Received: from nsgsw-rhel7p6.lm.intel.com ([10.232.116.83])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2020 16:00:24 -0800
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
Subject: [RFC 9/9] PCI: pciehp: Wire up pcie_port_emulate_slot and pciehp_emul
Date:   Fri,  7 Feb 2020 17:00:07 -0700
Message-Id: <1581120007-5280-10-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1581120007-5280-1-git-send-email-jonathan.derrick@intel.com>
References: <1581120007-5280-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add pcie_port_slot_emulated hook and wire it up to pciehp_emul. Add
pciehp_emul_{attach,detach} calls in pciehp and move the management
check into the attach caller.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/hotplug/pciehp.h      | 18 ++++++++++++++++++
 drivers/pci/hotplug/pciehp_emul.c | 11 ++++++++---
 drivers/pci/hotplug/pciehp_hpc.c  |  4 ++++
 drivers/pci/pcie/portdrv_core.c   |  3 +++
 include/linux/pci.h               |  4 ++++
 5 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 48fdd62..035d44d 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -197,6 +197,24 @@ struct controller {
 int pciehp_set_raw_indicator_status(struct hotplug_slot *h_slot, u8 status);
 int pciehp_get_raw_indicator_status(struct hotplug_slot *h_slot, u8 *status);
 
+#ifdef CONFIG_HOTPLUG_PCI_PCIE_EMUL
+bool pciehp_emul_will_manage(struct pci_dev *dev);
+int pciehp_emul_attach(struct controller *ctrl);
+void pciehp_emul_detach(struct controller *ctrl);
+#else
+static inline bool pciehp_emul_will_manage(struct pci_dev *dev)
+{
+	return false;
+};
+
+static inline int pciehp_emul_attach(struct controller *ctrl)
+{
+	return 0;
+};
+
+static inline void pciehp_emul_detach(struct controller *ctrl) {};
+#endif
+
 static inline const char *slot_name(struct controller *ctrl)
 {
 	return hotplug_slot_name(&ctrl->hotplug_slot);
diff --git a/drivers/pci/hotplug/pciehp_emul.c b/drivers/pci/hotplug/pciehp_emul.c
index 1a1fb51..b41bbae 100644
--- a/drivers/pci/hotplug/pciehp_emul.c
+++ b/drivers/pci/hotplug/pciehp_emul.c
@@ -281,9 +281,6 @@ int pciehp_emul_attach(struct controller *ctrl)
 	u32 slotcap = 0;
 	int ret;
 
-	if (!pciehp_emul_will_manage(dev))
-		return 0;
-
 	emul = kzalloc(sizeof(*emul), GFP_KERNEL);
 	if (!emul)
 		return -ENOMEM;
@@ -371,3 +368,11 @@ void pciehp_emul_detach(struct controller *ctrl)
 
 	kfree(emul);
 }
+
+static int __init pciehp_emul_init(void)
+{
+	pcie_port_slot_emulated = &pciehp_emul_will_manage;
+
+	return 0;
+}
+postcore_initcall(pciehp_emul_init);
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index e46f177..e034ab0 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -922,6 +922,10 @@ struct controller *pcie_init(struct pcie_device *dev)
 	ctrl->pcie = dev;
 
 	ctrl->slot_ops = &pciehp_default_slot_ops;
+
+	if (pciehp_emul_will_manage(pdev) && pciehp_emul_attach(ctrl))
+		return NULL;
+
 	pcie_read_slot_capabilities(ctrl, &slot_cap);
 
 	if (pdev->hotplug_user_indicators)
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 5979bb7..a1efaf7 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -19,6 +19,9 @@
 #include "../pci.h"
 #include "portdrv.h"
 
+/* Hook for hotplug emulation driver */
+bool (*pcie_port_slot_emulated)(struct pci_dev *dev);
+
 struct portdrv_service_data {
 	struct pcie_port_service_driver *drv;
 	struct device *dev;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c5c9bb5..3b48968 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1538,7 +1538,11 @@ static inline int pci_irqd_intx_xlate(struct irq_domain *d,
 #define pcie_ports_native	false
 #endif
 
+#ifdef CONFIG_HOTPLUG_PCI_PCIE_EMUL
+extern bool (*pcie_port_slot_emulated)(struct pci_dev *dev);
+#else
 #define pcie_port_slot_emulated(dev) false
+#endif
 
 #define PCIE_LINK_STATE_L0S		BIT(0)
 #define PCIE_LINK_STATE_L1		BIT(1)
-- 
1.8.3.1


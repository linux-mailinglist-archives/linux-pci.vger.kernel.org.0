Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAF391561AE
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2020 01:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbgBHAAV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Feb 2020 19:00:21 -0500
Received: from mga03.intel.com ([134.134.136.65]:58200 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727524AbgBHAAU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Feb 2020 19:00:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2020 16:00:20 -0800
X-IronPort-AV: E=Sophos;i="5.70,415,1574150400"; 
   d="scan'208";a="225545780"
Received: from nsgsw-rhel7p6.lm.intel.com ([10.232.116.83])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2020 16:00:18 -0800
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
Subject: [RFC 5/9] PCI: Add pcie_port_slot_emulated stub
Date:   Fri,  7 Feb 2020 17:00:03 -0700
Message-Id: <1581120007-5280-6-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1581120007-5280-1-git-send-email-jonathan.derrick@intel.com>
References: <1581120007-5280-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add the checks to allow an emulated slot. An emulated slot will use
native Hotplug, AER, and PME services. It also needs to specify itself
as a hotplug bridge in order for bridge sizing to account for hotplug
reserved windows.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/pci-acpi.c          |  3 +++
 drivers/pci/pcie/portdrv_core.c | 11 ++++++++---
 drivers/pci/probe.c             |  2 +-
 include/linux/pci.h             |  2 ++
 4 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 0c02d50..b693e9f 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -796,6 +796,9 @@ bool pciehp_is_native(struct pci_dev *bridge)
 	if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
 		return false;
 
+	if (pcie_port_slot_emulated(bridge))
+		return true;
+
 	pcie_capability_read_dword(bridge, PCI_EXP_SLTCAP, &slot_cap);
 	if (!(slot_cap & PCI_EXP_SLTCAP_HPC))
 		return false;
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 5075cb9..5979bb7 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -193,6 +193,11 @@ static int pcie_init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
 	return 0;
 }
 
+static inline bool is_port_native_or_emulated(struct pci_dev *dev)
+{
+	return pcie_ports_native || pcie_port_slot_emulated(dev);
+}
+
 /**
  * get_port_device_capability - discover capabilities of a PCI Express port
  * @dev: PCI Express port to examine
@@ -209,7 +214,7 @@ static int get_port_device_capability(struct pci_dev *dev)
 	int services = 0;
 
 	if (dev->is_hotplug_bridge &&
-	    (pcie_ports_native || host->native_pcie_hotplug)) {
+	    (is_port_native_or_emulated(dev) || host->native_pcie_hotplug)) {
 		services |= PCIE_PORT_SERVICE_HP;
 
 		/*
@@ -222,7 +227,7 @@ static int get_port_device_capability(struct pci_dev *dev)
 
 #ifdef CONFIG_PCIEAER
 	if (dev->aer_cap && pci_aer_available() &&
-	    (pcie_ports_native || host->native_aer)) {
+	    (is_port_native_or_emulated(dev) || host->native_aer)) {
 		services |= PCIE_PORT_SERVICE_AER;
 
 		/*
@@ -239,7 +244,7 @@ static int get_port_device_capability(struct pci_dev *dev)
 	 * those yet.
 	 */
 	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
-	    (pcie_ports_native || host->native_pme)) {
+	    (is_port_native_or_emulated(dev) || host->native_pme)) {
 		services |= PCIE_PORT_SERVICE_PME;
 
 		/*
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 512cb43..b04b0c2 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1477,7 +1477,7 @@ void set_pcie_hotplug_bridge(struct pci_dev *pdev)
 	u32 reg32;
 
 	pcie_capability_read_dword(pdev, PCI_EXP_SLTCAP, &reg32);
-	if (reg32 & PCI_EXP_SLTCAP_HPC)
+	if (reg32 & PCI_EXP_SLTCAP_HPC || pcie_port_slot_emulated(pdev))
 		pdev->is_hotplug_bridge = 1;
 }
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 3840a54..0391e39 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1536,6 +1536,8 @@ static inline int pci_irqd_intx_xlate(struct irq_domain *d,
 #define pcie_ports_native	false
 #endif
 
+#define pcie_port_slot_emulated(dev) false
+
 #define PCIE_LINK_STATE_L0S		BIT(0)
 #define PCIE_LINK_STATE_L1		BIT(1)
 #define PCIE_LINK_STATE_CLKPM		BIT(2)
-- 
1.8.3.1


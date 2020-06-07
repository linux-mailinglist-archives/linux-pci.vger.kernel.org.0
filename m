Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D0F1F0CE1
	for <lists+linux-pci@lfdr.de>; Sun,  7 Jun 2020 18:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgFGQUT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 7 Jun 2020 12:20:19 -0400
Received: from mga02.intel.com ([134.134.136.20]:61715 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726571AbgFGQUQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 7 Jun 2020 12:20:16 -0400
IronPort-SDR: QpdGchc7ub3czMFS8jGxPmV0cEpjoGafTgmkSlTPI1+XcnSjs1vgXmXxbo+k1HRP1NgFxZJPy3
 dggluJYhwYsQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2020 09:20:13 -0700
IronPort-SDR: QBR4s0P+WWnV/gYYWVx6vYGywMvnT0Rm/ATQmbka3KokuHMhLAag3O3Fukye4ajjX6JCcwCB+S
 oEuUcZVb/SFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,484,1583222400"; 
   d="scan'208";a="348938496"
Received: from skaushal-mobl5.gar.corp.intel.com (HELO localhost.localdomain) ([10.255.229.193])
  by orsmga001.jf.intel.com with ESMTP; 07 Jun 2020 09:20:13 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v5 2/4] ACPI/PCI: Ignore _OSC DPC negotiation result if pcie_ports_dpc_native is set.
Date:   Sun,  7 Jun 2020 09:19:59 -0700
Message-Id: <08cc31120b04925313b51e93ee2305bca62151b4.1591545462.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1591545462.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1591545462.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

pcie_ports_dpc_native is set only if user requests native handling
of PCIe DPC capability via pcie_port_setup command line option.
User input takes precedence over _OSC based control negotiation
result. So consider the _OSC negotiated result for DPC ownership
only if pcie_ports_dpc_native is unset.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/acpi/pci_root.c         | 2 ++
 drivers/pci/pcie/dpc.c          | 3 ++-
 drivers/pci/pcie/portdrv.h      | 2 --
 drivers/pci/pcie/portdrv_core.c | 2 +-
 include/linux/pci.h             | 2 ++
 5 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index e0039ad3480a..f90dba464ec2 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -925,6 +925,8 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 			host_bridge->native_pme = 0;
 		if (!(root->osc_control_set & OSC_PCI_EXPRESS_LTR_CONTROL))
 			host_bridge->native_ltr = 0;
+	}
+	if (!pcie_ports_native && !pcie_ports_dpc_native) {
 		if (!(root->osc_control_set & OSC_PCI_EXPRESS_DPC_CONTROL))
 			host_bridge->native_dpc = 0;
 	}
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index daa9a4153776..5b1025a2994d 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -280,11 +280,12 @@ void pci_dpc_init(struct pci_dev *pdev)
 static int dpc_probe(struct pcie_device *dev)
 {
 	struct pci_dev *pdev = dev->port;
+	struct pci_host_bridge *host = pci_find_host_bridge(pdev->bus);
 	struct device *device = &dev->device;
 	int status;
 	u16 ctl, cap;
 
-	if (!pcie_aer_is_native(pdev) && !pcie_ports_dpc_native)
+	if (!pcie_aer_is_native(pdev) && !host->native_dpc)
 		return -ENOTSUPP;
 
 	status = devm_request_threaded_irq(device, dev->irq, dpc_irq,
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index af7cf237432a..0ac20feef24e 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -25,8 +25,6 @@
 
 #define PCIE_PORT_DEVICE_MAXSERVICES   5
 
-extern bool pcie_ports_dpc_native;
-
 #ifdef CONFIG_PCIEAER
 int pcie_aer_init(void);
 int pcie_aer_is_native(struct pci_dev *dev);
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index ccd5e0ce5605..2c0278f0fdcc 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -253,7 +253,7 @@ static int get_port_device_capability(struct pci_dev *dev)
 	 */
 	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
 	    pci_aer_available() &&
-	    (pcie_ports_dpc_native || (services & PCIE_PORT_SERVICE_AER)))
+	    (host->native_dpc || (services & PCIE_PORT_SERVICE_AER)))
 		services |= PCIE_PORT_SERVICE_DPC;
 
 	if (pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 83ce1cdf5676..07d4db97f5f4 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1547,9 +1547,11 @@ static inline int pci_irqd_intx_xlate(struct irq_domain *d,
 #ifdef CONFIG_PCIEPORTBUS
 extern bool pcie_ports_disabled;
 extern bool pcie_ports_native;
+extern bool pcie_ports_dpc_native;
 #else
 #define pcie_ports_disabled	true
 #define pcie_ports_native	false
+#define pcie_ports_dpc_native	false
 #endif
 
 #define PCIE_LINK_STATE_L0S		BIT(0)
-- 
2.17.1


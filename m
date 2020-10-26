Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCCC299643
	for <lists+linux-pci@lfdr.de>; Mon, 26 Oct 2020 19:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404845AbgJZS6J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Oct 2020 14:58:09 -0400
Received: from mga03.intel.com ([134.134.136.65]:52496 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1791034AbgJZS6I (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 26 Oct 2020 14:58:08 -0400
IronPort-SDR: izhcpVhi6/A1flr+SSETk4SAyD/mv7y71LjRv21GSjEqzdr8ovifkgyjyITwuLYRkCUofnRkjF
 pYFBIf3p89bQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="168073146"
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; 
   d="scan'208";a="168073146"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 11:58:07 -0700
IronPort-SDR: kJptICTORocKSpd+1KYAZnDxqXiyahack5hyPgctizKbJIs0BHtUkqX7aMViZHqOBh2wmoBTyW
 QGgfp45Mg/kQ==
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; 
   d="scan'208";a="525607459"
Received: from dhrubajy-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.101.53])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 11:58:06 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        knsathya@kernel.org
Subject: [PATCH v10 3/5] ACPI/PCI: Ignore _OSC DPC negotiation result if pcie_ports_dpc_native is set.
Date:   Mon, 26 Oct 2020 11:56:41 -0700
Message-Id: <9aa4dde872ccde6e90d286bf13b8478076ddec40.1603738449.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1603738449.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1603738449.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <cover.1603738449.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1603738449.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pcie_ports_dpc_native is set only if user requests native handling
of PCIe DPC capability via pcie_port_setup command line option.
User input takes precedence over _OSC based control negotiation
result. So consider the _OSC negotiated result for DPC ownership
only if pcie_ports_dpc_native is unset.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/acpi/pci_root.c         | 8 ++++++--
 drivers/pci/pcie/dpc.c          | 3 ++-
 drivers/pci/pcie/portdrv.h      | 2 --
 drivers/pci/pcie/portdrv_core.c | 2 +-
 include/linux/pci.h             | 2 ++
 5 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index da925bef5bcf..b5230643e50a 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -933,8 +933,12 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 			    host_bridge->native_ltr);
 		  OSC_OWNER(ctrl, OSC_PCI_EXPRESS_DPC_CONTROL,
 			    host_bridge->native_dpc);
-	  }
-
+		  if (pcie_ports_dpc_native)
+			  dev_warn(&bus->dev, "OS forcibly taking over DPC\n");
+		  else
+			  OSC_OWNER(ctrl, OSC_PCI_EXPRESS_DPC_CONTROL,
+				    host_bridge->native_dpc);
+		}
 	if (!(root->osc_control_set & OSC_PCI_SHPC_NATIVE_HP_CONTROL))
 		host_bridge->native_shpc_hotplug = 0;
 
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index e05aba86a317..21f77420632b 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -283,11 +283,12 @@ void pci_dpc_init(struct pci_dev *pdev)
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
index 22207a79762c..388121ec88b5 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1559,9 +1559,11 @@ static inline int pci_irqd_intx_xlate(struct irq_domain *d,
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


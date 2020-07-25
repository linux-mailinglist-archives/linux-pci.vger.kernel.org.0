Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C53222D48B
	for <lists+linux-pci@lfdr.de>; Sat, 25 Jul 2020 05:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgGYD7R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jul 2020 23:59:17 -0400
Received: from mga06.intel.com ([134.134.136.31]:58731 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbgGYD7K (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Jul 2020 23:59:10 -0400
IronPort-SDR: gp9ihb3T4NibmM9qWfLfRQJBsXk7WgQQb5r++ZF/1MylBN1hGoYJDMGGbAVQyQdNMCf1mKIE3b
 xP1LsEhLjpGg==
X-IronPort-AV: E=McAfee;i="6000,8403,9692"; a="212351102"
X-IronPort-AV: E=Sophos;i="5.75,392,1589266800"; 
   d="scan'208";a="212351102"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2020 20:59:09 -0700
IronPort-SDR: UwLvFqOlXXypkRle/n0MkqzBGGB5nHmQNfeTUe2U28k6bxJ/JSNCOunLeagK6JQcXZC7FJRY97
 QBBEybBZw9IQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,392,1589266800"; 
   d="scan'208";a="489405387"
Received: from pittner-mobl1.amr.corp.intel.com (HELO localhost.localdomain) ([10.254.77.166])
  by fmsmga005.fm.intel.com with ESMTP; 24 Jul 2020 20:59:08 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v8 3/5] ACPI/PCI: Ignore _OSC DPC negotiation result if pcie_ports_dpc_native is set.
Date:   Fri, 24 Jul 2020 20:58:54 -0700
Message-Id: <875836a97c46fe918e0250cd424841ebadeb3989.1595649348.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1595649348.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1595649348.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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
 drivers/acpi/pci_root.c         | 2 +-
 drivers/pci/pcie/dpc.c          | 3 ++-
 drivers/pci/pcie/portdrv.h      | 2 --
 drivers/pci/pcie/portdrv_core.c | 2 +-
 include/linux/pci.h             | 2 ++
 5 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index f8981d4e044d..3942bb42cb93 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -961,7 +961,7 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 	}
 
 	if (!(root->osc_control_set & OSC_PCI_EXPRESS_DPC_CONTROL)) {
-		if (!pcie_ports_native)
+		if (!pcie_ports_native && !pcie_ports_dpc_native)
 			host_bridge->native_dpc = 0;
 		else
 			dev_warn(&bus->dev, "OS overrides %s firmware control",
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
index 34c1c4f45288..fe7ce06a4f40 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1556,9 +1556,11 @@ static inline int pci_irqd_intx_xlate(struct irq_domain *d,
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


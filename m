Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15D6D1E032C
	for <lists+linux-pci@lfdr.de>; Sun, 24 May 2020 23:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387879AbgEXVcn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 24 May 2020 17:32:43 -0400
Received: from mga02.intel.com ([134.134.136.20]:9322 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388381AbgEXVcm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 24 May 2020 17:32:42 -0400
IronPort-SDR: XD4idGvpp3Q9IwO2+wOlmm2rTKkS06BUvsrR1z3Pjl8OqPpfpgrggHKu+d0/3vgPhatg6i5rPq
 wfTF8i630TCA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2020 14:32:38 -0700
IronPort-SDR: rtGKi7aDCpE8uf/+8ZX3cgnpyh5SY/4bvVVGILvBwX2VW9p5UpEjWSJlze0ZMEpfRW+0Fx1LZV
 9BmFASHf54OQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,431,1583222400"; 
   d="scan'208";a="467875407"
Received: from tjrondo-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.251.20.235])
  by fmsmga006.fm.intel.com with ESMTP; 24 May 2020 14:32:38 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v3 5/5] PCI/AER: Replace pcie_aer_get_firmware_first() with pcie_aer_is_native()
Date:   Sun, 24 May 2020 14:32:34 -0700
Message-Id: <f77c04f58b92a317edac1b65a70f40a453caa9a2.1590355824.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1590355824.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1590355824.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Commit c100beb9ccfb ("PCI/AER: Use only _OSC to determine AER ownership")
removed the dependency of HEST table in determining the status of AER
ownership. But AER driver still uses HEST table parsed result in
verifying the AER ownership status in some of its API's. So remove HEST
table dependency, and instead use pcie_aer_is_native() to verify the AER
native ownership status.

Also remove unused HEST table parsing helper functions from AER driver.

We can reintroduce HEST table parser once the usage of FIRMWARE_FIRST bit
is clarified in PCI/AER specification.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/pcie/aer.c     | 113 ++++---------------------------------
 drivers/pci/pcie/dpc.c     |   2 +-
 drivers/pci/pcie/portdrv.h |  13 +----
 3 files changed, 13 insertions(+), 115 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 5f5ffe2f0986..12fa67c9ed9c 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -211,115 +211,22 @@ void pcie_ecrc_get_policy(char *str)
 }
 #endif	/* CONFIG_PCIE_ECRC */
 
-#ifdef CONFIG_ACPI_APEI
-static inline int hest_match_pci(struct acpi_hest_aer_common *p,
-				 struct pci_dev *pci)
-{
-	return   ACPI_HEST_SEGMENT(p->bus) == pci_domain_nr(pci->bus) &&
-		 ACPI_HEST_BUS(p->bus)     == pci->bus->number &&
-		 p->device                 == PCI_SLOT(pci->devfn) &&
-		 p->function               == PCI_FUNC(pci->devfn);
-}
-
-static inline bool hest_match_type(struct acpi_hest_header *hest_hdr,
-				struct pci_dev *dev)
-{
-	u16 hest_type = hest_hdr->type;
-	u8 pcie_type = pci_pcie_type(dev);
-
-	if ((hest_type == ACPI_HEST_TYPE_AER_ROOT_PORT &&
-		pcie_type == PCI_EXP_TYPE_ROOT_PORT) ||
-	    (hest_type == ACPI_HEST_TYPE_AER_ENDPOINT &&
-		pcie_type == PCI_EXP_TYPE_ENDPOINT) ||
-	    (hest_type == ACPI_HEST_TYPE_AER_BRIDGE &&
-		(dev->class >> 16) == PCI_BASE_CLASS_BRIDGE))
-		return true;
-	return false;
-}
-
-struct aer_hest_parse_info {
-	struct pci_dev *pci_dev;
-	int firmware_first;
-};
-
-static int hest_source_is_pcie_aer(struct acpi_hest_header *hest_hdr)
-{
-	if (hest_hdr->type == ACPI_HEST_TYPE_AER_ROOT_PORT ||
-	    hest_hdr->type == ACPI_HEST_TYPE_AER_ENDPOINT ||
-	    hest_hdr->type == ACPI_HEST_TYPE_AER_BRIDGE)
-		return 1;
-	return 0;
-}
-
-static int aer_hest_parse(struct acpi_hest_header *hest_hdr, void *data)
-{
-	struct aer_hest_parse_info *info = data;
-	struct acpi_hest_aer_common *p;
-	int ff;
-
-	if (!hest_source_is_pcie_aer(hest_hdr))
-		return 0;
-
-	p = (struct acpi_hest_aer_common *)(hest_hdr + 1);
-	ff = !!(p->flags & ACPI_HEST_FIRMWARE_FIRST);
-
-	/*
-	 * If no specific device is supplied, determine whether
-	 * FIRMWARE_FIRST is set for *any* PCIe device.
-	 */
-	if (!info->pci_dev) {
-		info->firmware_first |= ff;
-		return 0;
-	}
-
-	/* Otherwise, check the specific device */
-	if (p->flags & ACPI_HEST_GLOBAL) {
-		if (hest_match_type(hest_hdr, info->pci_dev))
-			info->firmware_first = ff;
-	} else
-		if (hest_match_pci(p, info->pci_dev))
-			info->firmware_first = ff;
-
-	return 0;
-}
+#define	PCI_EXP_AER_FLAGS	(PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE | \
+				 PCI_EXP_DEVCTL_FERE | PCI_EXP_DEVCTL_URRE)
 
-static void aer_set_firmware_first(struct pci_dev *pci_dev)
+int pcie_aer_is_native(struct pci_dev *dev)
 {
-	int rc;
-	struct aer_hest_parse_info info = {
-		.pci_dev	= pci_dev,
-		.firmware_first	= 0,
-	};
-
-	rc = apei_hest_parse(aer_hest_parse, &info);
+	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
 
-	if (rc)
-		pci_dev->__aer_firmware_first = 0;
-	else
-		pci_dev->__aer_firmware_first = info.firmware_first;
-	pci_dev->__aer_firmware_first_valid = 1;
-}
-
-int pcie_aer_get_firmware_first(struct pci_dev *dev)
-{
 	if (!dev->aer_cap)
 		return 0;
 
-	if (pcie_ports_native)
-		return 0;
-
-	if (!dev->__aer_firmware_first_valid)
-		aer_set_firmware_first(dev);
-	return dev->__aer_firmware_first;
+	return host->native_aer;
 }
-#endif
-
-#define	PCI_EXP_AER_FLAGS	(PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE | \
-				 PCI_EXP_DEVCTL_FERE | PCI_EXP_DEVCTL_URRE)
 
 int pci_enable_pcie_error_reporting(struct pci_dev *dev)
 {
-	if (pcie_aer_get_firmware_first(dev))
+	if (!pcie_aer_is_native(dev))
 		return -EIO;
 
 	return pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_AER_FLAGS);
@@ -328,7 +235,7 @@ EXPORT_SYMBOL_GPL(pci_enable_pcie_error_reporting);
 
 int pci_disable_pcie_error_reporting(struct pci_dev *dev)
 {
-	if (pcie_aer_get_firmware_first(dev))
+	if (!pcie_aer_is_native(dev))
 		return -EIO;
 
 	return pcie_capability_clear_word(dev, PCI_EXP_DEVCTL,
@@ -349,7 +256,7 @@ int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 	int pos = dev->aer_cap;
 	u32 status, sev;
 
-	if (pcie_aer_get_firmware_first(dev))
+	if (!pcie_aer_is_native(dev))
 		return -EIO;
 
 	/* Clear status bits for ERR_NONFATAL errors only */
@@ -368,7 +275,7 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
 	int pos = dev->aer_cap;
 	u32 status, sev;
 
-	if (pcie_aer_get_firmware_first(dev))
+	if (!pcie_aer_is_native(dev))
 		return;
 
 	/* Clear status bits for ERR_FATAL errors only */
@@ -415,7 +322,7 @@ int pci_aer_raw_clear_status(struct pci_dev *dev)
 
 int pci_aer_clear_status(struct pci_dev *dev)
 {
-	if (pcie_aer_get_firmware_first(dev))
+	if (!pcie_aer_is_native(dev))
 		return -EIO;
 
 	return pci_aer_raw_clear_status(dev);
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 762170423fdd..0993d51abf03 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -284,7 +284,7 @@ static int dpc_probe(struct pcie_device *dev)
 	int status;
 	u16 ctl, cap;
 
-	if (pcie_aer_get_firmware_first(pdev) && !pcie_ports_dpc_native)
+	if (!pcie_aer_is_native(pdev) && !pcie_ports_dpc_native)
 		return -ENOTSUPP;
 
 	status = devm_request_threaded_irq(device, dev->irq, dpc_irq,
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index 64b5e081cdb2..5bc1fcb21543 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -29,8 +29,10 @@ extern bool pcie_ports_dpc_native;
 
 #ifdef CONFIG_PCIEAER
 int pcie_aer_init(void);
+int pcie_aer_is_native(struct pci_dev *dev);
 #else
 static inline int pcie_aer_init(void) { return 0; }
+statuc inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
 #endif
 
 #ifdef CONFIG_HOTPLUG_PCI_PCIE
@@ -147,16 +149,5 @@ static inline bool pcie_pme_no_msi(void) { return false; }
 static inline void pcie_pme_interrupt_enable(struct pci_dev *dev, bool en) {}
 #endif /* !CONFIG_PCIE_PME */
 
-#ifdef CONFIG_ACPI_APEI
-int pcie_aer_get_firmware_first(struct pci_dev *pci_dev);
-#else
-static inline int pcie_aer_get_firmware_first(struct pci_dev *pci_dev)
-{
-	if (pci_dev->__aer_firmware_first_valid)
-		return pci_dev->__aer_firmware_first;
-	return 0;
-}
-#endif
-
 struct device *pcie_port_find_device(struct pci_dev *dev, u32 service);
 #endif /* _PORTDRV_H_ */
-- 
2.17.1


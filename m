Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E997A1B92CC
	for <lists+linux-pci@lfdr.de>; Sun, 26 Apr 2020 20:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgDZSaK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 Apr 2020 14:30:10 -0400
Received: from mga05.intel.com ([192.55.52.43]:31275 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbgDZSaK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 26 Apr 2020 14:30:10 -0400
IronPort-SDR: suxoLI3oCzUDcdrYqvYlFpZ+qQLHVMC3TdFWZls2W3haXgadRRxOStYCgfs9hkk51QVdGdlYgc
 6Czsw5ATQbuw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2020 11:30:10 -0700
IronPort-SDR: BB+8VjD4ADH6Xh/OGK6nsDVkvqlRUBelc4IPjUuTVWupSQ5qjp6hb7dX6hvPhFNVkXi1eNo/Ay
 aQPOOYTm7QAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,321,1583222400"; 
   d="scan'208";a="247165024"
Received: from rajavish-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.251.2.159])
  by fmsmga007.fm.intel.com with ESMTP; 26 Apr 2020 11:30:09 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v1 1/1] PCI/AER: Use _OSC negotiation to determine AER ownership
Date:   Sun, 26 Apr 2020 11:30:06 -0700
Message-Id: <67af2931705bed9a588b5a39d369cb70b9942190.1587925636.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Currently PCIe AER driver uses HEST FIRMWARE_FIRST bit to
determine the PCIe AER Capability ownership between OS and
firmware. This support is added based on following spec
reference.

Per ACPI spec r6.3, table 18-387, 18-388, 18-389, HEST table
flags field BIT-0 and BIT-1 can be used to expose the
ownership of error source between firmware and OSPM.

Bit [0] - FIRMWARE_FIRST: If set, indicates that system
          firmware will handle errors from this source
          first.
Bit [1] – GLOBAL: If set, indicates that the settings
          contained in this structure apply globally to all
          PCI Express Bridges.

Although above spec reference states that setting
FIRMWARE_FIRST bit means firmware will handle the error source
first, it does not explicitly state anything about AER
ownership. So using HEST to determine AER ownership is
incorrect.

Also, as per following specification references, _OSC can be
used to negotiate the AER ownership between firmware and OS.
Details are,

Per ACPI spec r6.3, sec 6.2.11.3, table titled “Interpretation
of _OSC Control Field” and as per PCI firmware specification r3.2,
sec 4.5.1, table 4-5, OS can set bit 3 of _OSC control field
to request control over PCI Express AER. If the OS successfully
receives control of this feature, it must handle error reporting
through the AER Capability as described in the PCI Express Base
Specification.

Since above spec references clearly states _OSC can be used to
determine AER ownership, don't depend on HEST FIRMWARE_FIRST bit.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/acpi/pci_root.c    |   9 +--
 drivers/pci/pcie/aer.c     | 122 ++-----------------------------------
 drivers/pci/pcie/portdrv.h |   9 ---
 include/linux/pci-acpi.h   |   6 --
 include/linux/pci.h        |   2 -
 5 files changed, 6 insertions(+), 142 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index ac8ad6cb82aa..9e235c1a75ff 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -483,13 +483,8 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_SHPC))
 		control |= OSC_PCI_SHPC_NATIVE_HP_CONTROL;
 
-	if (pci_aer_available()) {
-		if (aer_acpi_firmware_first())
-			dev_info(&device->dev,
-				 "PCIe AER handled by firmware\n");
-		else
-			control |= OSC_PCI_EXPRESS_AER_CONTROL;
-	}
+	if (pci_aer_available())
+		control |= OSC_PCI_EXPRESS_AER_CONTROL;
 
 	/*
 	 * Per the Downstream Port Containment Related Enhancements ECN to
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index f4274d301235..85d73d28ec26 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -217,133 +217,19 @@ void pcie_ecrc_get_policy(char *str)
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
-
-static void aer_set_firmware_first(struct pci_dev *pci_dev)
-{
-	int rc;
-	struct aer_hest_parse_info info = {
-		.pci_dev	= pci_dev,
-		.firmware_first	= 0,
-	};
-
-	rc = apei_hest_parse(aer_hest_parse, &info);
-
-	if (rc)
-		pci_dev->__aer_firmware_first = 0;
-	else
-		pci_dev->__aer_firmware_first = info.firmware_first;
-	pci_dev->__aer_firmware_first_valid = 1;
-}
-
 int pcie_aer_get_firmware_first(struct pci_dev *dev)
 {
+	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
+
 	if (!pci_is_pcie(dev))
 		return 0;
 
 	if (pcie_ports_native)
 		return 0;
 
-	if (!dev->__aer_firmware_first_valid)
-		aer_set_firmware_first(dev);
-	return dev->__aer_firmware_first;
+	return !host->native_aer;
 }
 
-static bool aer_firmware_first;
-
-/**
- * aer_acpi_firmware_first - Check if APEI should control AER.
- */
-bool aer_acpi_firmware_first(void)
-{
-	static bool parsed = false;
-	struct aer_hest_parse_info info = {
-		.pci_dev	= NULL,	/* Check all PCIe devices */
-		.firmware_first	= 0,
-	};
-
-	if (pcie_ports_native)
-		return false;
-
-	if (!parsed) {
-		apei_hest_parse(aer_hest_parse, &info);
-		aer_firmware_first = info.firmware_first;
-		parsed = true;
-	}
-	return aer_firmware_first;
-}
-#endif
-
 #define	PCI_EXP_AER_FLAGS	(PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE | \
 				 PCI_EXP_DEVCTL_FERE | PCI_EXP_DEVCTL_URRE)
 
@@ -1523,7 +1409,7 @@ static struct pcie_port_service_driver aerdriver = {
  */
 int __init pcie_aer_init(void)
 {
-	if (!pci_aer_available() || aer_acpi_firmware_first())
+	if (!pci_aer_available())
 		return -ENXIO;
 	return pcie_port_service_register(&aerdriver);
 }
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index 64b5e081cdb2..c05b49d740f4 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -147,16 +147,7 @@ static inline bool pcie_pme_no_msi(void) { return false; }
 static inline void pcie_pme_interrupt_enable(struct pci_dev *dev, bool en) {}
 #endif /* !CONFIG_PCIE_PME */
 
-#ifdef CONFIG_ACPI_APEI
 int pcie_aer_get_firmware_first(struct pci_dev *pci_dev);
-#else
-static inline int pcie_aer_get_firmware_first(struct pci_dev *pci_dev)
-{
-	if (pci_dev->__aer_firmware_first_valid)
-		return pci_dev->__aer_firmware_first;
-	return 0;
-}
-#endif
 
 struct device *pcie_port_find_device(struct pci_dev *dev, u32 service);
 #endif /* _PORTDRV_H_ */
diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
index 2d155bfb8fbf..11c98875538a 100644
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -125,10 +125,4 @@ static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
 static inline void acpi_pci_remove_bus(struct pci_bus *bus) { }
 #endif	/* CONFIG_ACPI */
 
-#ifdef CONFIG_ACPI_APEI
-extern bool aer_acpi_firmware_first(void);
-#else
-static inline bool aer_acpi_firmware_first(void) { return false; }
-#endif
-
 #endif	/* _PCI_ACPI_H_ */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 83ce1cdf5676..43f265830eca 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -420,8 +420,6 @@ struct pci_dev {
 	 * mappings to make sure they cannot access arbitrary memory.
 	 */
 	unsigned int	untrusted:1;
-	unsigned int	__aer_firmware_first_valid:1;
-	unsigned int	__aer_firmware_first:1;
 	unsigned int	broken_intx_masking:1;	/* INTx masking can't be used */
 	unsigned int	io_window_1k:1;		/* Intel bridge 1K I/O windows */
 	unsigned int	irq_managed:1;
-- 
2.17.1


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 180741902DE
	for <lists+linux-pci@lfdr.de>; Tue, 24 Mar 2020 01:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbgCXA01 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Mar 2020 20:26:27 -0400
Received: from mga14.intel.com ([192.55.52.115]:60461 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727740AbgCXA00 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 23 Mar 2020 20:26:26 -0400
IronPort-SDR: dA1Z3CEPkwyO3I6lBrS0I5o1I1N9gPKMjiQKcqwMwQvWy+djKw9MKqyc2rA8a7l0bILmQRYdg7
 HvnhTMpUGXcQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 17:26:25 -0700
IronPort-SDR: buuuFhYsQg9X4PzAfI8WE4B2nWqa5UVmnw/5UlJ4MyzN+QC6SWjIRI7q1WsDENzyTtxGr8n3Bl
 H11PIKVU3hBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,298,1580803200"; 
   d="scan'208";a="419692251"
Received: from bhaveshm-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.134.88.197])
  by orsmga005.jf.intel.com with ESMTP; 23 Mar 2020 17:26:25 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v18 08/11] PCI/AER: Add pci_aer_raw_clear_status() to unconditionally clear Error Status
Date:   Mon, 23 Mar 2020 17:26:05 -0700
Message-Id: <c19ad28f3633cce67448609e89a75635da0da07d.1585000084.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1585000084.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1585000084.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Per the SFI _OSC and DPC Updates ECN [1] implementation note flowchart, the
OS seems to be expected to clear AER status even if it doesn't have
ownership of the AER capability.  Unlike the DPC capability, where a DPC
ECN [2] specifies a window when the OS is allowed to access DPC registers
even if it doesn't have ownership, there is no clear model for AER.

Add pci_aer_raw_clear_status() to clear the AER error status registers
unconditionally.  This is intended for use only by the EDR path (see [2]).

[1] System Firmware Intermediary (SFI) _OSC and DPC Updates ECN, Feb 24,
    2020, affecting PCI Firmware Specification, Rev. 3.2
    https://members.pcisig.com/wg/PCI-SIG/document/14076
[2] Downstream Port Containment Related Enhancements ECN, Jan 28, 2019,
    affecting PCI Firmware Specification, Rev. 3.2
    https://members.pcisig.com/wg/PCI-SIG/document/12888
[bhelgaas: changelog]
Link: https://lore.kernel.org/r/29fb514a0d86e9bcc75cec4ea8474cd4db33adbf.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.h      |  2 ++
 drivers/pci/pcie/aer.c | 22 ++++++++++++++++++----
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index e48677a0ba42..6d09bb22b73d 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -654,12 +654,14 @@ void pci_aer_exit(struct pci_dev *dev);
 extern const struct attribute_group aer_stats_attr_group;
 void pci_aer_clear_fatal_status(struct pci_dev *dev);
 void pci_aer_clear_device_status(struct pci_dev *dev);
+int pci_aer_raw_clear_status(struct pci_dev *dev);
 #else
 static inline void pci_no_aer(void) { }
 static inline void pci_aer_init(struct pci_dev *d) { }
 static inline void pci_aer_exit(struct pci_dev *d) { }
 static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
 static inline void pci_aer_clear_device_status(struct pci_dev *dev) { }
+static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL; }
 #endif
 
 #ifdef CONFIG_ACPI
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index c0540c3761dc..bd9f122165e0 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -420,7 +420,16 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
 		pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, status);
 }
 
-int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
+/**
+ * pci_aer_raw_clear_status - Clear AER error registers.
+ * @dev: the PCI device
+ *
+ * Clearing AER error status registers unconditionally, regardless of
+ * whether they're owned by firmware or the OS.
+ *
+ * Returns 0 on success, or negative on failure.
+ */
+int pci_aer_raw_clear_status(struct pci_dev *dev)
 {
 	int pos;
 	u32 status;
@@ -433,9 +442,6 @@ int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
 	if (!pos)
 		return -EIO;
 
-	if (pcie_aer_get_firmware_first(dev))
-		return -EIO;
-
 	port_type = pci_pcie_type(dev);
 	if (port_type == PCI_EXP_TYPE_ROOT_PORT) {
 		pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, &status);
@@ -451,6 +457,14 @@ int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
 	return 0;
 }
 
+int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
+{
+	if (pcie_aer_get_firmware_first(dev))
+		return -EIO;
+
+	return pci_aer_raw_clear_status(dev);
+}
+
 void pci_save_aer_state(struct pci_dev *dev)
 {
 	struct pci_cap_saved_state *save_state;
-- 
2.17.1


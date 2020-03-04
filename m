Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01B3317887D
	for <lists+linux-pci@lfdr.de>; Wed,  4 Mar 2020 03:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387664AbgCDCjM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Mar 2020 21:39:12 -0500
Received: from mga07.intel.com ([134.134.136.100]:56585 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387631AbgCDCjM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Mar 2020 21:39:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2020 18:39:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,511,1574150400"; 
   d="scan'208";a="233866908"
Received: from skuppusw-desk.jf.intel.com ([10.7.201.16])
  by orsmga008.jf.intel.com with ESMTP; 03 Mar 2020 18:39:06 -0800
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v17 07/12] PCI/ERR: Return status of pcie_do_recovery()
Date:   Tue,  3 Mar 2020 18:36:30 -0800
Message-Id: <a795fe1f1f42f5aa1d334768d4e719d8c147894e.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

As per the Downstream Port Containment Related Enhancements ECN to the
PCI Firmware Specification r3.2, sec 4.5.1, table 4-4, Support for Error
Disconnect Recover (EDR) implies that the OS will invalidate the
software state associated with child devices of the port without
attempting to access the child device hardware. If the OS supports
Downstream Port Containment (DPC), as indicated by the OS setting bit 7
of _OSC control field, the OS shall attempt to recover the child devices
if the port implements the Downstream Port Containment Extended
Capability. If the OS continues operation, the OS must inform the
Firmware of the status of the recovery operation via the _OST method.

So in adding EDR support, to report status of error recovery via _OST,
we need to know the status of error recovery. So add support to return
the status of pcie_do_recovery() function.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/pci.h      |  5 +++--
 drivers/pci/pcie/err.c | 10 ++++++----
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 2962200bfe35..c2c35f152cde 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -547,8 +547,9 @@ static inline int pci_dev_specific_disable_acs_redir(struct pci_dev *dev)
 #endif
 
 /* PCI error reporting and recovery */
-void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
-		      pci_ers_result_t (*reset_cb)(struct pci_dev *pdev));
+pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
+			enum pci_channel_state state,
+			pci_ers_result_t (*reset_cb)(struct pci_dev *pdev));
 
 bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
 #ifdef CONFIG_PCIEASPM
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 05f87bc9d011..b560f0096a70 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -186,9 +186,9 @@ static pci_ers_result_t reset_link(struct pci_dev *dev,
 	return status;
 }
 
-void pcie_do_recovery(struct pci_dev *dev,
-		      enum pci_channel_state state,
-		      pci_ers_result_t (*reset_cb)(struct pci_dev *pdev))
+pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
+			enum pci_channel_state state,
+			pci_ers_result_t (*reset_cb)(struct pci_dev *pdev))
 {
 	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
 	struct pci_bus *bus;
@@ -240,11 +240,13 @@ void pcie_do_recovery(struct pci_dev *dev,
 	pci_aer_clear_device_status(dev);
 	pci_cleanup_aer_uncorrect_error_status(dev);
 	pci_info(dev, "device recovery successful\n");
-	return;
+	return status;
 
 failed:
 	pci_uevent_ers(dev, PCI_ERS_RESULT_DISCONNECT);
 
 	/* TODO: Should kernel panic here? */
 	pci_info(dev, "device recovery failed\n");
+
+	return status;
 }
-- 
2.25.1


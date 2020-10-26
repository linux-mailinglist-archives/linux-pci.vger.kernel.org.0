Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F91029971E
	for <lists+linux-pci@lfdr.de>; Mon, 26 Oct 2020 20:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1785801AbgJZThQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Oct 2020 15:37:16 -0400
Received: from mga09.intel.com ([134.134.136.24]:62399 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1785797AbgJZThQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 26 Oct 2020 15:37:16 -0400
IronPort-SDR: SdwEKtwep6p2jsUtZ2XWzE6rGUSW5y1RQhahJj2Y4AtIg94Qcr057XDN8DIognXgHM7CotE3Aj
 AZ7YDNfEw+6Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="168103001"
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; 
   d="scan'208";a="168103001"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 12:37:15 -0700
IronPort-SDR: BwRXwHffXsu5PTF55A/osnA/AiRlgDlS+eyGbfdxCl0w9/ceYV+73CPM20gDpNolzL1IagSMwU
 /n6fUdb20xdQ==
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; 
   d="scan'208";a="350023268"
Received: from dhrubajy-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.101.53])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 12:37:14 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        knsathya@kernel.org
Subject: [PATCH v8 1/2] PCI/ERR: Call pci_bus_reset() before calling ->slot_reset() callback
Date:   Mon, 26 Oct 2020 12:37:11 -0700
Message-Id: <b464e4c8b3022ce3e0c69e64456619fc86378c15.1603740826.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently if report_error_detected() or report_mmio_enabled()
functions requests PCI_ERS_RESULT_NEED_RESET, current
pcie_do_recovery() implementation does not do the requested
explicit device reset, but instead just calls the
report_slot_reset() on all affected devices. Notifying about the
reset via report_slot_reset() without doing the actual device
reset is incorrect. So call pci_bus_reset() before triggering
->slot_reset() callback.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Sinan Kaya <okaya@kernel.org>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
---
 Changes since v7:
  * Rebased on top of v5.10-rc1.

 Changes since v6:
  * None.

 Changes since v5:
  * Added Ashok's Reviewed-by tag.

 Changes since v4:
  * Added check for pci_reset_bus() return value.

 drivers/pci/pcie/err.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index c543f419d8f9..315a4d559c4c 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -152,6 +152,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 {
 	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
 	struct pci_bus *bus;
+	int ret;
 
 	/*
 	 * Error recovery runs on all subordinates of the first downstream port.
@@ -181,11 +182,12 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	}
 
 	if (status == PCI_ERS_RESULT_NEED_RESET) {
-		/*
-		 * TODO: Should call platform-specific
-		 * functions to reset slot before calling
-		 * drivers' slot_reset callbacks?
-		 */
+		ret = pci_reset_bus(dev);
+		if (ret < 0) {
+			pci_err(dev, "Failed to reset %d\n", ret);
+			status = PCI_ERS_RESULT_DISCONNECT;
+			goto failed;
+		}
 		status = PCI_ERS_RESULT_RECOVERED;
 		pci_dbg(dev, "broadcast slot_reset message\n");
 		pci_walk_bus(bus, report_slot_reset, &status);
-- 
2.17.1


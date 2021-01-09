Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 915872EFC8E
	for <lists+linux-pci@lfdr.de>; Sat,  9 Jan 2021 02:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbhAIBCW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Jan 2021 20:02:22 -0500
Received: from mga11.intel.com ([192.55.52.93]:37225 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbhAIBCV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Jan 2021 20:02:21 -0500
IronPort-SDR: 5xsQrE1X6E0z/o/pTl1k3kYxSuJZl26Fl39oHUhC9eHj7/BHpZuBcbEBU1llNoz2uzhxRJvIEn
 5iqhiimwUR+w==
X-IronPort-AV: E=McAfee;i="6000,8403,9858"; a="174166644"
X-IronPort-AV: E=Sophos;i="5.79,333,1602572400"; 
   d="scan'208";a="174166644"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2021 17:00:34 -0800
IronPort-SDR: Trq7pdzsOZ/IpVIvI4aoODGktcF/ONJlvGcp7PPi/PcMAZZYUNMw+f75U0cEGP6/KsJ7ZxOQi3
 Q5JEoP1I++9Q==
X-IronPort-AV: E=Sophos;i="5.79,333,1602572400"; 
   d="scan'208";a="423126447"
Received: from tanmingy-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.247.214])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2021 17:00:24 -0800
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        knsathya@kernel.org
Subject: [PATCH v9 1/2] PCI/ERR: Call pci_bus_reset() before calling ->slot_reset() callback
Date:   Fri,  8 Jan 2021 17:00:00 -0800
Message-Id: <c7ec55f92d97b237adae0ee4694dbfc1a766600c.1610153755.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
  * Rebased on top of v5.11-rc1.

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
index 510f31f0ef6d..6c19e9948232 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -177,6 +177,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	struct pci_dev *bridge;
 	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
 	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
+	int ret;
 
 	/*
 	 * If the error was detected by a Root Port, Downstream Port, RCEC,
@@ -214,11 +215,12 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	}
 
 	if (status == PCI_ERS_RESULT_NEED_RESET) {
-		/*
-		 * TODO: Should call platform-specific
-		 * functions to reset slot before calling
-		 * drivers' slot_reset callbacks?
-		 */
+		ret = pci_reset_bus(bridge);
+		if (ret < 0) {
+			pci_err(dev, "Failed to reset %d\n", ret);
+			status = PCI_ERS_RESULT_DISCONNECT;
+			goto failed;
+		}
 		status = PCI_ERS_RESULT_RECOVERED;
 		pci_dbg(bridge, "broadcast slot_reset message\n");
 		pci_walk_bridge(bridge, report_slot_reset, &status);
-- 
2.25.1


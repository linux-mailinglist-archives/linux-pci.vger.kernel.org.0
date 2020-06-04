Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBF051EED80
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jun 2020 23:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgFDVuR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Jun 2020 17:50:17 -0400
Received: from mga06.intel.com ([134.134.136.31]:51375 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbgFDVuQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Jun 2020 17:50:16 -0400
IronPort-SDR: /j1t3sHS4vz4aksmJx4kPCcGx76S2x1C5xFSAD6P4tV9EsDAWHxS5qm1OYe/rVa2VXHQN+uOf9
 Fv+mNVn+p6kQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2020 14:50:15 -0700
IronPort-SDR: Ugz5LZYBjpvfRGCIR4ijK/ILuN55zOSwrie98TaKaVI++HwJ9SGaajqx1cTr+2HNMNdArRSJaD
 VnVUMUQVrFRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,472,1583222400"; 
   d="scan'208";a="313018643"
Received: from unknown (HELO localhost.localdomain) ([10.254.105.50])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Jun 2020 14:50:15 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v2 2/2] PCI/ERR: Add reset support for non fatal errors
Date:   Thu,  4 Jun 2020 14:50:02 -0700
Message-Id: <18ab6cc7b34dab7630978195248ea031540ba9f1.1591307288.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <ce417fbf81a8a46a89535f44b9224ee9fbb55a29.1591307288.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <ce417fbf81a8a46a89535f44b9224ee9fbb55a29.1591307288.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

PCI_ERS_RESULT_NEED_RESET error status implies the device is
requesting a slot reset and a notification about slot reset
completion via ->slot_reset() callback.

But in non-fatal errors case, if report_error_detected() or
report_mmio_enabled() functions requests PCI_ERS_RESULT_NEED_RESET
then current pcie_do_recovery() implementation does not do the
requested explicit slot reset, instead just calls the ->slot_reset()
callback on all affected devices. Notifying about the slot reset
completion without resetting it incorrect. So add this support.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/pcie/err.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 5fe8561c7185..94d1c2ff7b40 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -206,6 +206,9 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 		 * functions to reset slot before calling
 		 * drivers' slot_reset callbacks?
 		 */
+		if (state != pci_channel_io_frozen)
+			pci_reset_bus(dev);
+
 		status = PCI_ERS_RESULT_RECOVERED;
 		pci_dbg(dev, "broadcast slot_reset message\n");
 		pci_walk_bus(bus, report_slot_reset, &status);
-- 
2.17.1


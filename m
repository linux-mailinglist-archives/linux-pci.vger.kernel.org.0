Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 061BE9F1AA
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2019 19:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730611AbfH0RdF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Aug 2019 13:33:05 -0400
Received: from mga18.intel.com ([134.134.136.126]:62462 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730438AbfH0Rcm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Aug 2019 13:32:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 10:32:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,438,1559545200"; 
   d="scan'208";a="171269785"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by orsmga007.jf.intel.com with ESMTP; 27 Aug 2019 10:32:38 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v8 1/8] PCI/ERR: Update error status after reset_link()
Date:   Tue, 27 Aug 2019 10:29:23 -0700
Message-Id: <a3476743748d06a3bb4ee45b45538870d90cbe98.1566865502.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1566865502.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1566865502.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Commit bdb5ac85777d ("PCI/ERR: Handle fatal error recovery") uses
reset_link() to recover from fatal errors. But, if the reset is
successful there is no need to continue the rest of the error recovery
checks. Also, during fatal error recovery, if the initial value of error
status is PCI_ERS_RESULT_DISCONNECT or PCI_ERS_RESULT_NO_AER_DRIVER then
even after successful recovery (using reset_link()) pcie_do_recovery()
will report the recovery result as failure. So update the status of
error after reset_link().

Fixes: bdb5ac85777d ("PCI/ERR: Handle fatal error recovery")
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Keith Busch <keith.busch@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/err.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 773197a12568..c3e883d47675 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -204,9 +204,12 @@ void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
 	else
 		pci_walk_bus(bus, report_normal_detected, &status);
 
-	if (state == pci_channel_io_frozen &&
-	    reset_link(dev, service) != PCI_ERS_RESULT_RECOVERED)
-		goto failed;
+	if (state == pci_channel_io_frozen) {
+		status = reset_link(dev, service);
+		if (status != PCI_ERS_RESULT_RECOVERED)
+			goto failed;
+		goto done;
+	}
 
 	if (status == PCI_ERS_RESULT_CAN_RECOVER) {
 		status = PCI_ERS_RESULT_RECOVERED;
@@ -228,6 +231,7 @@ void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
 	if (status != PCI_ERS_RESULT_RECOVERED)
 		goto failed;
 
+done:
 	pci_dbg(dev, "broadcast resume message\n");
 	pci_walk_bus(bus, report_resume, &status);
 
-- 
2.21.0


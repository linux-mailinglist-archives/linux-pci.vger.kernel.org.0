Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA21351E70
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2019 00:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfFXWhc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jun 2019 18:37:32 -0400
Received: from mga01.intel.com ([192.55.52.88]:1686 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbfFXWhc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Jun 2019 18:37:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jun 2019 15:37:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,413,1557212400"; 
   d="scan'208";a="172143160"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by orsmga002.jf.intel.com with ESMTP; 24 Jun 2019 15:37:31 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v1 1/1] PCI/ERR: Update error status after reset_link()
Date:   Mon, 24 Jun 2019 15:35:23 -0700
Message-Id: <20190624223523.115019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.21.0
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
---
 drivers/pci/pcie/err.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 773197a12568..aecec124a829 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -204,9 +204,13 @@ void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
 	else
 		pci_walk_bus(bus, report_normal_detected, &status);
 
-	if (state == pci_channel_io_frozen &&
-	    reset_link(dev, service) != PCI_ERS_RESULT_RECOVERED)
-		goto failed;
+	if (state == pci_channel_io_frozen) {
+		status = reset_link(dev, service);
+		if (status != PCI_ERS_RESULT_RECOVERED)
+			goto failed;
+		else
+			goto done;
+	}
 
 	if (status == PCI_ERS_RESULT_CAN_RECOVER) {
 		status = PCI_ERS_RESULT_RECOVERED;
@@ -228,6 +232,7 @@ void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
 	if (status != PCI_ERS_RESULT_RECOVERED)
 		goto failed;
 
+done:
 	pci_dbg(dev, "broadcast resume message\n");
 	pci_walk_bus(bus, report_resume, &status);
 
-- 
2.21.0


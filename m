Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97450178875
	for <lists+linux-pci@lfdr.de>; Wed,  4 Mar 2020 03:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387597AbgCDCjH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Mar 2020 21:39:07 -0500
Received: from mga12.intel.com ([192.55.52.136]:44650 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387589AbgCDCjH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Mar 2020 21:39:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2020 18:39:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,511,1574150400"; 
   d="scan'208";a="233866892"
Received: from skuppusw-desk.jf.intel.com ([10.7.201.16])
  by orsmga008.jf.intel.com with ESMTP; 03 Mar 2020 18:39:06 -0800
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH v17 01/12] PCI/ERR: Update error status after reset_link()
Date:   Tue,  3 Mar 2020 18:36:24 -0800
Message-Id: <15e702a33cc27314f9d43a06ccb408086a229cef.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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

Commit bdb5ac85777d ("PCI/ERR: Handle fatal error recovery") uses
reset_link() to recover from fatal errors. But during fatal error
recovery, if the initial value of error status is
PCI_ERS_RESULT_DISCONNECT or PCI_ERS_RESULT_NO_AER_DRIVER then
even after successful recovery (using reset_link()) pcie_do_recovery()
will report the recovery result as failure. So update the status of
error after reset_link().

You can reproduce this issue by triggering a SW DPC using "DPC
Software Trigger" bit in "DPC Control Register". You should see recovery
failed dmesg log as below.

[  164.659982] pcieport 0000:00:16.0: DPC: containment event,
status:0x1f27 source:0x0000
[  164.659989] pcieport 0000:00:16.0: DPC: software trigger detected
[  164.659994] pci 0000:04:00.0: AER: can't recover (no error_detected
callback)
[  164.794300] pcieport 0000:00:16.0: AER: device recovery failed

Fixes: bdb5ac85777d ("PCI/ERR: Handle fatal error recovery")
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Keith Busch <keith.busch@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/err.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 01dfc8bb7ca0..eefefe03857a 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -208,9 +208,11 @@ void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
 	else
 		pci_walk_bus(bus, report_normal_detected, &status);
 
-	if (state == pci_channel_io_frozen &&
-	    reset_link(dev, service) != PCI_ERS_RESULT_RECOVERED)
-		goto failed;
+	if (state == pci_channel_io_frozen) {
+		status = reset_link(dev, service);
+		if (status != PCI_ERS_RESULT_RECOVERED)
+			goto failed;
+	}
 
 	if (status == PCI_ERS_RESULT_CAN_RECOVER) {
 		status = PCI_ERS_RESULT_RECOVERED;
-- 
2.25.1


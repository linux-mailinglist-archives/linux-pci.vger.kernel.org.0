Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8621902EB
	for <lists+linux-pci@lfdr.de>; Tue, 24 Mar 2020 01:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgCXA0u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Mar 2020 20:26:50 -0400
Received: from mga14.intel.com ([192.55.52.115]:60458 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727394AbgCXA0W (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 23 Mar 2020 20:26:22 -0400
IronPort-SDR: 9/J+Vw41vUhMScZgIGWFh4JeBt99QHjcQqNNWQaSsAyUcUlDPAF9QkLlq+1TNBrCY4BJa1v3oR
 tvBY/9NjUhEA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 17:26:21 -0700
IronPort-SDR: ljk1IodYw9smEo4oNfaBB72RR7098dIoxhT8+w4AGSUM71k7dtR8du8sYcuWIpsf0lbQDAMgap
 Gl4m0wNgJaPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,298,1580803200"; 
   d="scan'208";a="419692225"
Received: from bhaveshm-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.134.88.197])
  by orsmga005.jf.intel.com with ESMTP; 23 Mar 2020 17:26:20 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v18 01/11] PCI/ERR: Update error status after reset_link()
Date:   Mon, 23 Mar 2020 17:25:58 -0700
Message-Id: <a255fcb3a3fdebcd90f84e08b555f1786eb8eba2.1585000084.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1585000084.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1585000084.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Commit bdb5ac85777d ("PCI/ERR: Handle fatal error recovery") uses
reset_link() to recover from fatal errors. But during fatal error recovery,
if the initial value of error status is PCI_ERS_RESULT_DISCONNECT or
PCI_ERS_RESULT_NO_AER_DRIVER then even after successful recovery (using
reset_link()) pcie_do_recovery() will report the recovery result as
failure. So update the status of error after reset_link().

You can reproduce this issue by triggering a SW DPC using "DPC
Software Trigger" bit in "DPC Control Register". You should see recovery
failed dmesg log as below.

  pcieport 0000:00:16.0: DPC: containment event, status:0x1f27 source:0x0000
  pcieport 0000:00:16.0: DPC: software trigger detected
  pci 0000:04:00.0: AER: can't recover (no error_detected callback)
  pcieport 0000:00:16.0: AER: device recovery failed

Fixes: bdb5ac85777d ("PCI/ERR: Handle fatal error recovery")
Link: https://lore.kernel.org/r/15e702a33cc27314f9d43a06ccb408086a229cef.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Keith Busch <keith.busch@intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
---
 drivers/pci/pcie/err.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 01dfc8bb7ca0..1ac57e9e1e71 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -203,14 +203,14 @@ void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
 	bus = dev->subordinate;
 
 	pci_dbg(dev, "broadcast error_detected message\n");
-	if (state == pci_channel_io_frozen)
+	if (state == pci_channel_io_frozen) {
 		pci_walk_bus(bus, report_frozen_detected, &status);
-	else
+		status = reset_link(dev, service);
+		if (status != PCI_ERS_RESULT_RECOVERED)
+			goto failed;
+	} else {
 		pci_walk_bus(bus, report_normal_detected, &status);
-
-	if (state == pci_channel_io_frozen &&
-	    reset_link(dev, service) != PCI_ERS_RESULT_RECOVERED)
-		goto failed;
+	}
 
 	if (status == PCI_ERS_RESULT_CAN_RECOVER) {
 		status = PCI_ERS_RESULT_RECOVERED;
-- 
2.17.1


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFB802DD5DB
	for <lists+linux-pci@lfdr.de>; Thu, 17 Dec 2020 18:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbgLQRPN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Dec 2020 12:15:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:40494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728166AbgLQRPN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Dec 2020 12:15:13 -0500
From:   Keith Busch <kbusch@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc:     Keith Busch <kbusch@kernel.org>
Subject: [PATCH 1/3] PCI/ERR: Clear status of the reporting device
Date:   Thu, 17 Dec 2020 09:14:29 -0800
Message-Id: <20201217171431.502030-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Error handling operates on the first downstream port above the detected
error, but the error may have been reported by a downstream device.
Clear the AER status of the device that reported the error rather than
the first downstream port.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/pci/pcie/err.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 510f31f0ef6d..a84f0bf4c1e2 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -231,15 +231,14 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	pci_walk_bridge(bridge, report_resume, &status);
 
 	/*
-	 * If we have native control of AER, clear error status in the Root
-	 * Port or Downstream Port that signaled the error.  If the
-	 * platform retained control of AER, it is responsible for clearing
-	 * this status.  In that case, the signaling device may not even be
-	 * visible to the OS.
+	 * If we have native control of AER, clear error status in the device
+	 * that detected the error.  If the platform retained control of AER,
+	 * it is responsible for clearing this status.  In that case, the
+	 * signaling device may not even be visible to the OS.
 	 */
 	if (host->native_aer || pcie_ports_native) {
-		pcie_clear_device_status(bridge);
-		pci_aer_clear_nonfatal_status(bridge);
+		pcie_clear_device_status(dev);
+		pci_aer_clear_nonfatal_status(dev);
 	}
 	pci_info(bridge, "device recovery successful\n");
 	return status;
-- 
2.24.1


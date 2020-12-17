Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B234A2DD5DD
	for <lists+linux-pci@lfdr.de>; Thu, 17 Dec 2020 18:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbgLQRPO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Dec 2020 12:15:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:40522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729056AbgLQRPO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Dec 2020 12:15:14 -0500
From:   Keith Busch <kbusch@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc:     Keith Busch <kbusch@kernel.org>,
        Hinko Kocevar <hinko.kocevar@ess.eu>
Subject: [PATCH 3/3] PCI/ERR: Retain status from error notification
Date:   Thu, 17 Dec 2020 09:14:31 -0800
Message-Id: <20201217171431.502030-3-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201217171431.502030-1-kbusch@kernel.org>
References: <20201217171431.502030-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Overwriting the frozen detected status with the result of the link reset
loses the NEED_RESET result that drivers are depending on for error
handling to report the .slot_reset() callback. Retain this status so
that subsequent error handling has the correct flow.

Reported-by: Hinko Kocevar <hinko.kocevar@ess.eu>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/pci/pcie/err.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index a84f0bf4c1e2..b576aa890c76 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -198,8 +198,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	pci_dbg(bridge, "broadcast error_detected message\n");
 	if (state == pci_channel_io_frozen) {
 		pci_walk_bridge(bridge, report_frozen_detected, &status);
-		status = reset_subordinates(bridge);
-		if (status != PCI_ERS_RESULT_RECOVERED) {
+		if (reset_subordinates(bridge) != PCI_ERS_RESULT_RECOVERED) {
 			pci_warn(bridge, "subordinate device reset failed\n");
 			goto failed;
 		}
-- 
2.24.1


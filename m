Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5294D2EA052
	for <lists+linux-pci@lfdr.de>; Tue,  5 Jan 2021 00:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbhADXDv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Jan 2021 18:03:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:52514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727234AbhADXDs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Jan 2021 18:03:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 95A0B22583;
        Mon,  4 Jan 2021 23:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609801388;
        bh=Rk+0p05fTxUh6B0JyVhxlzcGbXRv8aBfkyR+1TUo9FE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l7r12fkR/8diSMYYSDPqctIad2jXUPe6PjL0oBU8MSXKjutta2SH+Cb0tvHhy6EPn
         u8PS9uQDcKK/DJQ1KRPLcsaPX9gc76g/Mvx2ycP3WjT9scUhmRm7PQSeh6aAVtlH9l
         /v+8XtbKrykr8GU3M4o1a0bdny34V6/6rBN1JJ+fOmGpkkQy+1ZjRwbclZ9DIJO/Cf
         eqdhaOPcH0apalyRdCZGpMOhcAfu9E+PAPy3gtA0Rr9nZ+qAVS6OofeGkhRC7/mGk9
         x/8zXjSlAcpcHJ/cWiITC0UOXRngZ98K/tuNDWiyvh89Kzjw+HMu5yX5EHU16LKRyQ
         nM5T6yKKNulgg==
From:   Keith Busch <kbusch@kernel.org>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Cc:     Keith Busch <kbusch@kernel.org>,
        Hinko Kocevar <hinko.kocevar@ess.eu>,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCHv2 3/5] PCI/ERR: Retain status from error notification
Date:   Mon,  4 Jan 2021 15:02:58 -0800
Message-Id: <20210104230300.1277180-4-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210104230300.1277180-1-kbusch@kernel.org>
References: <20210104230300.1277180-1-kbusch@kernel.org>
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
Acked-by: Sean V Kelley <sean.v.kelley@intel.com>
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


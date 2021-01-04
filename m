Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 647032EA065
	for <lists+linux-pci@lfdr.de>; Tue,  5 Jan 2021 00:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbhADXE1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Jan 2021 18:04:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:52646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbhADXE1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Jan 2021 18:04:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C4DEC22795;
        Mon,  4 Jan 2021 23:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609801389;
        bh=utzC49E4z7mpZXi2qCX/fLaIrr9rys9rA/mzLO41B20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vNWgeGqROopzVPiVH/PE3reyE/6ZRkHA0GGNFU92zz2rc6DOl0ktqZuvcqOdkWYAF
         yazfpJrfjirXvip6ajyfoHyzmKCIoUchnD3MFgjv5cAW2KGgkca8GfXMdtSWmAuehN
         iHy1umhmtz7/YZqkreGyM6BfqCjGN8xi5oAJP3HnLn3fVHuFGMEvrM/VNI5+0SPfH1
         Z1dAEgFHFA0m7+PpxZ465fCBDzOF37NG/JdUeOzjtn0XHr3TGN/43EujQwd30fWa7d
         ckqcJ3UTKpH7ZFM4SFLg/pRYLKHuZsXgs24ynojpu0MgKE20mNpN3W2/xqHfXLPClN
         /Mn0qOoBuQTHg==
From:   Keith Busch <kbusch@kernel.org>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Cc:     Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 5/5] PCI/portdrv: Report reset for frozen channel
Date:   Mon,  4 Jan 2021 15:03:00 -0800
Message-Id: <20210104230300.1277180-6-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210104230300.1277180-1-kbusch@kernel.org>
References: <20210104230300.1277180-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCI error recovery always resets the link for a frozen state, so the
port driver should return that a reset is required for its result. This
will get the .slot_reset() callback invoked, which is necessary to
restore the port's config space. Without this, the driver had been
relying on downstream drivers to return this status.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/pci/pcie/portdrv_pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 0b250bc5f405..de141bfb0bc2 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -153,7 +153,8 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
 static pci_ers_result_t pcie_portdrv_error_detected(struct pci_dev *dev,
 					pci_channel_state_t error)
 {
-	/* Root Port has no impact. Always recovers. */
+	if (error == pci_channel_io_frozen)
+		return PCI_ERS_RESULT_NEED_RESET;
 	return PCI_ERS_RESULT_CAN_RECOVER;
 }
 
-- 
2.24.1


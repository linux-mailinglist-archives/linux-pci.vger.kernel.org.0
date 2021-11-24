Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C77FA45C968
	for <lists+linux-pci@lfdr.de>; Wed, 24 Nov 2021 17:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347867AbhKXQD0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Nov 2021 11:03:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:57622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347849AbhKXQDZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Nov 2021 11:03:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 55C576108E;
        Wed, 24 Nov 2021 16:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637769615;
        bh=PZyyQQxVBHKPs4NzfewlxUERce2SHAqvb2qqk/d1sGM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ABOx0YVV236if5mMBU5Jwb/HPw8NjNdf6/9ERUwRxDp0+wj5x4Ny6PuD9t4od/say
         ThmAWC/Dv1QkkFcEQfvY7oa59l3/K6BGlbnaWpdM42M6YW4IMWeNEHa1LaneHk9wuI
         WrLpxKlY8OY8NvCEBB7XTBp7Msaj99Sk4pepiRvL5oGRRFk/B4Zd88LnsFXnC97XhQ
         s7Rt5Ql5au7ig/y8LWJU8Pc9QIOFJikKv8LevhCFBPEMfiTDlD8g9WAk+oiVe2nTbC
         2QnvEosKg/m9Lh352RJKgTpC5MPPhXeukIGnieEu4yQfQ+TJkaLVhj+oRdoYkKDzYs
         qaCV5YgpvSmYQ==
Received: by pali.im (Postfix)
        id 1751C56D; Wed, 24 Nov 2021 17:00:15 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] PCI: pci-bridge-emul: Fix definitions of reserved bits
Date:   Wed, 24 Nov 2021 16:59:42 +0100
Message-Id: <20211124155944.1290-5-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211124155944.1290-1-pali@kernel.org>
References: <20211124155944.1290-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some bits in PCI_EXP registers are reserved for non-root ports. Driver
pci-bridge-emul.c implements PCIe Root Port device therefore it should not
allow setting reserved bits of registers.

Properly define non-reserved bits for all PCI_EXP registers.

Signed-off-by: Pali Rohár <pali@kernel.org>
Fixes: 23a5fba4d941 ("PCI: Introduce PCI bridge emulated config space common logic")
Cc: stable@vger.kernel.org
---
 drivers/pci/pci-bridge-emul.c | 36 ++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
index 31ff7448bded..9a348f99641b 100644
--- a/drivers/pci/pci-bridge-emul.c
+++ b/drivers/pci/pci-bridge-emul.c
@@ -176,41 +176,55 @@ struct pci_bridge_reg_behavior pcie_cap_regs_behavior[PCI_CAP_PCIE_SIZEOF / 4] =
 	[PCI_CAP_LIST_ID / 4] = {
 		/*
 		 * Capability ID, Next Capability Pointer and
-		 * Capabilities register are all read-only.
+		 * bits [14:0] of Capabilities register are all read-only.
+		 * Bit 15 of Capabilities register is reserved.
 		 */
-		.ro = ~0,
+		.ro = GENMASK(30, 0),
 	},
 
 	[PCI_EXP_DEVCAP / 4] = {
-		.ro = ~0,
+		/*
+		 * Bits [31:29] and [17:16] are reserved.
+		 * Bits [27:18] are reserved for non-upstream ports.
+		 * Bits 28 and [14:6] are reserved for non-endpoint devices.
+		 * Other bits are read-only.
+		 */
+		.ro = BIT(15) | GENMASK(5, 0),
 	},
 
 	[PCI_EXP_DEVCTL / 4] = {
-		/* Device control register is RW */
-		.rw = GENMASK(15, 0),
+		/*
+		 * Device control register is RW, except bit 15 which is
+		 * reserved for non-endpoints or non-PCIe-to-PCI/X bridges.
+		 */
+		.rw = GENMASK(14, 0),
 
 		/*
 		 * Device status register has bits 6 and [3:0] W1C, [5:4] RO,
-		 * the rest is reserved
+		 * the rest is reserved. Also bit 6 is reserved for non-upstream
+		 * ports.
 		 */
-		.w1c = (BIT(6) | GENMASK(3, 0)) << 16,
+		.w1c = GENMASK(3, 0) << 16,
 		.ro = GENMASK(5, 4) << 16,
 	},
 
 	[PCI_EXP_LNKCAP / 4] = {
-		/* All bits are RO, except bit 23 which is reserved */
-		.ro = lower_32_bits(~BIT(23)),
+		/*
+		 * All bits are RO, except bit 23 which is reserved and
+		 * bit 18 which is reserved for non-upstream ports.
+		 */
+		.ro = lower_32_bits(~(BIT(23) | PCI_EXP_LNKCAP_CLKPM)),
 	},
 
 	[PCI_EXP_LNKCTL / 4] = {
 		/*
 		 * Link control has bits [15:14], [11:3] and [1:0] RW, the
-		 * rest is reserved.
+		 * rest is reserved. Bit 8 is reserved for non-upstream ports.
 		 *
 		 * Link status has bits [13:0] RO, and bits [15:14]
 		 * W1C.
 		 */
-		.rw = GENMASK(15, 14) | GENMASK(11, 3) | GENMASK(1, 0),
+		.rw = GENMASK(15, 14) | GENMASK(11, 9) | GENMASK(7, 3) | GENMASK(1, 0),
 		.ro = GENMASK(13, 0) << 16,
 		.w1c = GENMASK(15, 14) << 16,
 	},
-- 
2.20.1


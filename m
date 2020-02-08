Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0391561A9
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2020 01:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbgBHAAQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Feb 2020 19:00:16 -0500
Received: from mga03.intel.com ([134.134.136.65]:58200 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727032AbgBHAAP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Feb 2020 19:00:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2020 16:00:15 -0800
X-IronPort-AV: E=Sophos;i="5.70,415,1574150400"; 
   d="scan'208";a="225545699"
Received: from nsgsw-rhel7p6.lm.intel.com ([10.232.116.83])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2020 16:00:14 -0800
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Pawel Baldysiak <pawel.baldysiak@intel.com>,
        Sinan Kaya <okaya@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <kbusch@kernel.org>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [RFC 2/9] PCI: pci-bridge-emul: Eliminate reserved member
Date:   Fri,  7 Feb 2020 17:00:00 -0700
Message-Id: <1581120007-5280-3-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1581120007-5280-1-git-send-email-jonathan.derrick@intel.com>
References: <1581120007-5280-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Assume any bit not in the Read-Only, Read-Write, or Write-1-to-Clear
behavior masks is a Reserved bit and should return 0 on reads.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/pci-bridge-emul.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
index d065c2a..e0567ca 100644
--- a/drivers/pci/pci-bridge-emul.c
+++ b/drivers/pci/pci-bridge-emul.c
@@ -24,6 +24,15 @@
 #define PCI_CAP_PCIE_START	PCI_BRIDGE_CONF_END
 #define PCI_CAP_PCIE_END	(PCI_CAP_PCIE_START + PCI_EXP_SLTSTA2 + 2)
 
+/**
+ * struct pci_bridge_reg_behavior - register bits behaviors
+ * @ro:		Read-Only bits
+ * @rw:		Read-Write bits
+ * @w1c:	Write-1-to-Clear bits
+ *
+ * Reads and Writes will be filtered by specified behavior. All other bits not
+ * declared are assumed 'Reserved' and will return 0 on reads.
+ */
 struct pci_bridge_reg_behavior {
 	/* Read-only bits */
 	u32 ro;
@@ -33,9 +42,6 @@ struct pci_bridge_reg_behavior {
 
 	/* Write-1-to-clear bits */
 	u32 w1c;
-
-	/* Reserved bits (hardwired to 0) */
-	u32 rsvd;
 };
 
 static const struct pci_bridge_reg_behavior pci_regs_behavior[] = {
@@ -49,7 +55,6 @@ struct pci_bridge_reg_behavior {
 			PCI_COMMAND_FAST_BACK) |
 		       (PCI_STATUS_CAP_LIST | PCI_STATUS_66MHZ |
 			PCI_STATUS_FAST_BACK | PCI_STATUS_DEVSEL_MASK) << 16),
-		.rsvd = GENMASK(15, 10) | ((BIT(6) | GENMASK(3, 0)) << 16),
 		.w1c = (PCI_STATUS_PARITY |
 			PCI_STATUS_SIG_TARGET_ABORT |
 			PCI_STATUS_REC_TARGET_ABORT |
@@ -106,8 +111,6 @@ struct pci_bridge_reg_behavior {
 			PCI_STATUS_REC_MASTER_ABORT |
 			PCI_STATUS_SIG_SYSTEM_ERROR |
 			PCI_STATUS_DETECTED_PARITY) << 16,
-
-		.rsvd = ((BIT(6) | GENMASK(4, 0)) << 16),
 	},
 
 	[PCI_MEMORY_BASE / 4] = {
@@ -140,12 +143,10 @@ struct pci_bridge_reg_behavior {
 
 	[PCI_CAPABILITY_LIST / 4] = {
 		.ro = GENMASK(7, 0),
-		.rsvd = GENMASK(31, 8),
 	},
 
 	[PCI_ROM_ADDRESS1 / 4] = {
 		.rw = GENMASK(31, 11) | BIT(0),
-		.rsvd = GENMASK(10, 1),
 	},
 
 	/*
@@ -168,8 +169,6 @@ struct pci_bridge_reg_behavior {
 		.ro = (GENMASK(15, 8) | ((PCI_BRIDGE_CTL_FAST_BACK) << 16)),
 
 		.w1c = BIT(10) << 16,
-
-		.rsvd = (GENMASK(15, 12) | BIT(4)) << 16,
 	},
 };
 
@@ -196,13 +195,11 @@ struct pci_bridge_reg_behavior {
 		 */
 		.w1c = (BIT(6) | GENMASK(3, 0)) << 16,
 		.ro = GENMASK(5, 4) << 16,
-		.rsvd = GENMASK(15, 7) << 16,
 	},
 
 	[PCI_EXP_LNKCAP / 4] = {
 		/* All bits are RO, except bit 23 which is reserved */
 		.ro = lower_32_bits(~BIT(23)),
-		.rsvd = BIT(23),
 	},
 
 	[PCI_EXP_LNKCTL / 4] = {
@@ -216,7 +213,6 @@ struct pci_bridge_reg_behavior {
 		.rw = GENMASK(15, 14) | GENMASK(11, 3) | GENMASK(1, 0),
 		.ro = GENMASK(13, 0) << 16,
 		.w1c = GENMASK(15, 14) << 16,
-		.rsvd = GENMASK(13, 12) | BIT(2),
 	},
 
 	[PCI_EXP_SLTCAP / 4] = {
@@ -234,7 +230,6 @@ struct pci_bridge_reg_behavior {
 		.rw = GENMASK(14, 0),
 		.w1c = (BIT(8) | GENMASK(4, 0)) << 16,
 		.ro = GENMASK(7, 5) << 16,
-		.rsvd = BIT(15) | (GENMASK(15, 9) << 16),
 	},
 
 	[PCI_EXP_RTCTL / 4] = {
@@ -246,7 +241,6 @@ struct pci_bridge_reg_behavior {
 		 */
 		.rw = GENMASK(4, 0),
 		.ro = BIT(0) << 16,
-		.rsvd = GENMASK(15, 5) | (GENMASK(15, 1) << 16),
 	},
 
 	[PCI_EXP_RTSTA / 4] = {
@@ -256,7 +250,6 @@ struct pci_bridge_reg_behavior {
 		 */
 		.ro = BIT(17) | GENMASK(15, 0),
 		.w1c = BIT(16),
-		.rsvd = GENMASK(31, 18),
 	},
 };
 
@@ -364,7 +357,8 @@ int pci_bridge_emul_conf_read(struct pci_bridge_emul *bridge, int where,
 	 * Make sure we never return any reserved bit with a value
 	 * different from 0.
 	 */
-	*value &= ~behavior[reg / 4].rsvd;
+	*value &= behavior[reg / 4].ro | behavior[reg / 4].rw |
+		  behavior[reg / 4].w1c;
 
 	if (size == 1)
 		*value = (*value >> (8 * (where & 3))) & 0xff;
-- 
1.8.3.1


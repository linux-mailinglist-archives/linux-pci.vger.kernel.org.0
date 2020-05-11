Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68C4B1CE0A1
	for <lists+linux-pci@lfdr.de>; Mon, 11 May 2020 18:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbgEKQh2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 May 2020 12:37:28 -0400
Received: from mga04.intel.com ([192.55.52.120]:7552 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729120AbgEKQh2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 May 2020 12:37:28 -0400
IronPort-SDR: xSoF0r7Kfsvf9Q419bXkEH1fXSnHFt/7tVQ9xvn5jT2678KEFaCkefCFb9k5URS3X8a2i3GGdo
 kiprAtwKl9pQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2020 09:37:28 -0700
IronPort-SDR: Xe3Em+ZJSFme2trjTaj1HSot0bXet2xKiPCOWRKj88Pgj7HSlqbwemJhmoTRJ+QdkgCaRL5MnM
 /cyvl1FBG01g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,380,1583222400"; 
   d="scan'208";a="286334390"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.116.74])
  by fmsmga004.fm.intel.com with ESMTP; 11 May 2020 09:37:10 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <linux-pci@vger.kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Rob Herring <robh@kernel.org>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH v2 4/4] PCI: pci-bridge-emul: Eliminate the 'reserved' member
Date:   Mon, 11 May 2020 12:21:17 -0400
Message-Id: <20200511162117.6674-5-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20200511162117.6674-1-jonathan.derrick@intel.com>
References: <20200511162117.6674-1-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Per PCIe 5.0 r1.0, Terms and Acronyms, Page 80:

  Reserved register fields must be read only and must return 0 (all 0's
  for multi-bit fields) when read. Reserved encodings for register and
  packet fields must not be used. Any implementation dependence on a
  Reserved field value or encoding will result in an implementation that
  is not PCI Express-compliant.

This patch ensures reads will return 0 for any bit not in the Read-Only,
Read-Write, or Write-1-to-Clear bitmasks.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/pci-bridge-emul.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
index 6b1949995dee..ccf26d12ec61 100644
--- a/drivers/pci/pci-bridge-emul.c
+++ b/drivers/pci/pci-bridge-emul.c
@@ -24,6 +24,17 @@
 #define PCI_CAP_PCIE_START	PCI_BRIDGE_CONF_END
 #define PCI_CAP_PCIE_END	(PCI_CAP_PCIE_START + PCI_EXP_SLTSTA2 + 2)
 
+/**
+ * struct pci_bridge_reg_behavior - register bits behaviors
+ * @ro:		Read-Only bits
+ * @rw:		Read-Write bits
+ * @w1c:	Write-1-to-Clear bits
+ *
+ * Reads and Writes will be filtered by specified behavior. All other bits not
+ * declared are assumed 'Reserved' and will return 0 on reads, per PCIe 5.0:
+ * "Reserved register fields must be read only and must return 0 (all 0's for
+ * multi-bit fields) when read".
+ */
 struct pci_bridge_reg_behavior {
 	/* Read-only bits */
 	u32 ro;
@@ -33,9 +44,6 @@ struct pci_bridge_reg_behavior {
 
 	/* Write-1-to-clear bits */
 	u32 w1c;
-
-	/* Reserved bits (hardwired to 0) */
-	u32 rsvd;
 };
 
 static const struct pci_bridge_reg_behavior pci_regs_behavior[] = {
@@ -49,7 +57,6 @@ static const struct pci_bridge_reg_behavior pci_regs_behavior[] = {
 			PCI_COMMAND_FAST_BACK) |
 		       (PCI_STATUS_CAP_LIST | PCI_STATUS_66MHZ |
 			PCI_STATUS_FAST_BACK | PCI_STATUS_DEVSEL_MASK) << 16),
-		.rsvd = GENMASK(15, 10) | ((BIT(6) | GENMASK(3, 0)) << 16),
 		.w1c = PCI_STATUS_ERROR_BITS << 16,
 	},
 	[PCI_CLASS_REVISION / 4] = { .ro = ~0 },
@@ -96,8 +103,6 @@ static const struct pci_bridge_reg_behavior pci_regs_behavior[] = {
 		       GENMASK(11, 8) | GENMASK(3, 0)),
 
 		.w1c = PCI_STATUS_ERROR_BITS << 16,
-
-		.rsvd = ((BIT(6) | GENMASK(4, 0)) << 16),
 	},
 
 	[PCI_MEMORY_BASE / 4] = {
@@ -130,12 +135,10 @@ static const struct pci_bridge_reg_behavior pci_regs_behavior[] = {
 
 	[PCI_CAPABILITY_LIST / 4] = {
 		.ro = GENMASK(7, 0),
-		.rsvd = GENMASK(31, 8),
 	},
 
 	[PCI_ROM_ADDRESS1 / 4] = {
 		.rw = GENMASK(31, 11) | BIT(0),
-		.rsvd = GENMASK(10, 1),
 	},
 
 	/*
@@ -158,8 +161,6 @@ static const struct pci_bridge_reg_behavior pci_regs_behavior[] = {
 		.ro = (GENMASK(15, 8) | ((PCI_BRIDGE_CTL_FAST_BACK) << 16)),
 
 		.w1c = BIT(10) << 16,
-
-		.rsvd = (GENMASK(15, 12) | BIT(4)) << 16,
 	},
 };
 
@@ -186,13 +187,11 @@ static const struct pci_bridge_reg_behavior pcie_cap_regs_behavior[] = {
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
@@ -206,7 +205,6 @@ static const struct pci_bridge_reg_behavior pcie_cap_regs_behavior[] = {
 		.rw = GENMASK(15, 14) | GENMASK(11, 3) | GENMASK(1, 0),
 		.ro = GENMASK(13, 0) << 16,
 		.w1c = GENMASK(15, 14) << 16,
-		.rsvd = GENMASK(13, 12) | BIT(2),
 	},
 
 	[PCI_EXP_SLTCAP / 4] = {
@@ -227,7 +225,6 @@ static const struct pci_bridge_reg_behavior pcie_cap_regs_behavior[] = {
 			PCI_EXP_SLTSTA_CC | PCI_EXP_SLTSTA_DLLSC) << 16,
 		.ro = (PCI_EXP_SLTSTA_MRLSS | PCI_EXP_SLTSTA_PDS |
 		       PCI_EXP_SLTSTA_EIS) << 16,
-		.rsvd = GENMASK(15) | (GENMASK(15, 9) << 16),
 	},
 
 	[PCI_EXP_RTCTL / 4] = {
@@ -241,7 +238,6 @@ static const struct pci_bridge_reg_behavior pcie_cap_regs_behavior[] = {
 		       PCI_EXP_RTCTL_SEFEE | PCI_EXP_RTCTL_PMEIE |
 		       PCI_EXP_RTCTL_CRSSVE),
 		.ro = PCI_EXP_RTCAP_CRSVIS << 16,
-		.rsvd = GENMASK(15, 5) | (GENMASK(15, 1) << 16),
 	},
 
 	[PCI_EXP_RTSTA / 4] = {
@@ -251,7 +247,6 @@ static const struct pci_bridge_reg_behavior pcie_cap_regs_behavior[] = {
 		 */
 		.ro = GENMASK(15, 0) | PCI_EXP_RTSTA_PENDING,
 		.w1c = PCI_EXP_RTSTA_PME,
-		.rsvd = GENMASK(31, 18),
 	},
 };
 
@@ -359,7 +354,8 @@ int pci_bridge_emul_conf_read(struct pci_bridge_emul *bridge, int where,
 	 * Make sure we never return any reserved bit with a value
 	 * different from 0.
 	 */
-	*value &= ~behavior[reg / 4].rsvd;
+	*value &= behavior[reg / 4].ro | behavior[reg / 4].rw |
+		  behavior[reg / 4].w1c;
 
 	if (size == 1)
 		*value = (*value >> (8 * (where & 3))) & 0xff;
-- 
2.18.1


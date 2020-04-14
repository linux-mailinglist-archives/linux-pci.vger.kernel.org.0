Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C28B1A8CC4
	for <lists+linux-pci@lfdr.de>; Tue, 14 Apr 2020 22:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633341AbgDNUpG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Apr 2020 16:45:06 -0400
Received: from mga17.intel.com ([192.55.52.151]:48103 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2633345AbgDNUpF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Apr 2020 16:45:05 -0400
IronPort-SDR: J+z7a+3DyXdiyxzF/nKoE+pPo9exdTjAXWs5YRD0ofjOJagoPJz4xX1C42pKfl+3rkENEP9vsO
 u8iyXQjnyJ5w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 13:45:04 -0700
IronPort-SDR: Od3wKOvvm2XfIik7dQToX+ra090layg+GZGhfiNvrgYdbOFNCGdjBtETpQrUu90HkTFTFfWeGx
 DC/eaYhztnWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,384,1580803200"; 
   d="scan'208";a="288336381"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.116.40])
  by fmsmga002.fm.intel.com with ESMTP; 14 Apr 2020 13:45:04 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <linux-pci@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH 4/5] PCI: pci-bridge-emul: Update for PCIe 5.0 r1.0
Date:   Tue, 14 Apr 2020 16:30:04 -0400
Message-Id: <20200414203005.5166-5-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20200414203005.5166-1-jonathan.derrick@intel.com>
References: <20200414203005.5166-1-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add missing bits from PCIe 4.0 and updates for PCIe 5.0 r1.0.

PCIe 4.0:
Device Status bit 6 - W1C - Emergency Power Reduction Detected
Link Control bits 15:14 - RW - DRS Signaling Control
Slot Control bit 13 - RW - Auto Slow Power Limit Disable

PCIe 5.0:
Slot Control bit 14 - RW - In-Band PD Disable

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/pci-bridge-emul.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
index bbcccadca85e..5c0dffa601f3 100644
--- a/drivers/pci/pci-bridge-emul.c
+++ b/drivers/pci/pci-bridge-emul.c
@@ -181,12 +181,12 @@ static const struct pci_bridge_reg_behavior pcie_cap_regs_behavior[] = {
 		.rw = GENMASK(15, 0),
 
 		/*
-		 * Device status register has 4 bits W1C, then 2 bits
-		 * RO, the rest is reserved
+		 * Device status register has bits 6 and [3:0] W1C, [5:4] RO,
+		 * the rest is reserved
 		 */
-		.w1c = GENMASK(19, 16),
-		.ro = GENMASK(21, 20),
-		.rsvd = GENMASK(31, 22),
+		.w1c = (BIT(6) | GENMASK(3, 0)) << 16,
+		.ro = GENMASK(5, 4) << 16,
+		.rsvd = GENMASK(15, 7) << 16,
 	},
 
 	[PCI_EXP_LNKCAP / 4] = {
@@ -197,15 +197,16 @@ static const struct pci_bridge_reg_behavior pcie_cap_regs_behavior[] = {
 
 	[PCI_EXP_LNKCTL / 4] = {
 		/*
-		 * Link control has bits [1:0] and [11:3] RW, the
-		 * other bits are reserved.
-		 * Link status has bits [13:0] RO, and bits [14:15]
+		 * Link control has bits [15:14], [11:3] and [1:0] RW, the
+		 * rest is reserved.
+		 *
+		 * Link status has bits [13:0] RO, and bits [15:14]
 		 * W1C.
 		 */
-		.rw = GENMASK(11, 3) | GENMASK(1, 0),
+		.rw = GENMASK(15, 14) | GENMASK(11, 3) | GENMASK(1, 0),
 		.ro = GENMASK(13, 0) << 16,
 		.w1c = GENMASK(15, 14) << 16,
-		.rsvd = GENMASK(15, 12) | BIT(2),
+		.rsvd = GENMASK(13, 12) | BIT(2),
 	},
 
 	[PCI_EXP_SLTCAP / 4] = {
@@ -214,16 +215,16 @@ static const struct pci_bridge_reg_behavior pcie_cap_regs_behavior[] = {
 
 	[PCI_EXP_SLTCTL / 4] = {
 		/*
-		 * Slot control has bits [12:0] RW, the rest is
+		 * Slot control has bits [14:0] RW, the rest is
 		 * reserved.
 		 *
-		 * Slot status has a mix of W1C and RO bits, as well
-		 * as reserved bits.
+		 * Slot status has bits 8 and [4:0] W1C, bits [7:5] RO, the
+		 * rest is reserved.
 		 */
-		.rw = GENMASK(12, 0),
+		.rw = GENMASK(14, 0),
 		.w1c = (BIT(8) | GENMASK(4, 0)) << 16,
 		.ro = GENMASK(7, 5) << 16,
-		.rsvd = GENMASK(15, 13) | (GENMASK(15, 9) << 16),
+		.rsvd = BIT(15) | (GENMASK(15, 9) << 16),
 	},
 
 	[PCI_EXP_RTCTL / 4] = {
-- 
2.18.1


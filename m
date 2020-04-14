Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4A11A8CC5
	for <lists+linux-pci@lfdr.de>; Tue, 14 Apr 2020 22:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730657AbgDNUpI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Apr 2020 16:45:08 -0400
Received: from mga17.intel.com ([192.55.52.151]:48105 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2633343AbgDNUpF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Apr 2020 16:45:05 -0400
IronPort-SDR: 9T5urCGPGOKdSV6kjTQKQ73B9ftsGjbcu+nkJigpV67E1QMKR9hHoJnHPalBhVSzJdxK8+9GoV
 VizjI1I4+gbw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 13:45:04 -0700
IronPort-SDR: r1OErjyVz/Uf3pbjJWtls2b0aSYVi8LXLWedBhEELM4u8lH0Sr9XAKRHZCrDOhwzv+RCVsXqa3
 5QSkfIeQITFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,384,1580803200"; 
   d="scan'208";a="288336376"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.116.40])
  by fmsmga002.fm.intel.com with ESMTP; 14 Apr 2020 13:45:03 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <linux-pci@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH 3/5] PCI: pci-bridge-emul: Convert to GENMASK and BIT
Date:   Tue, 14 Apr 2020 16:30:03 -0400
Message-Id: <20200414203005.5166-4-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20200414203005.5166-1-jonathan.derrick@intel.com>
References: <20200414203005.5166-1-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In order to make pci-bridge-emul easier to keep up-to-date with new PCIe
features, convert all named register bits to GENMASK and BIT pairs. This
patch doesn't alter any of the PCI configuration space as these bits are
fully defined.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/pci-bridge-emul.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
index c00c30ffb198..bbcccadca85e 100644
--- a/drivers/pci/pci-bridge-emul.c
+++ b/drivers/pci/pci-bridge-emul.c
@@ -221,11 +221,8 @@ static const struct pci_bridge_reg_behavior pcie_cap_regs_behavior[] = {
 		 * as reserved bits.
 		 */
 		.rw = GENMASK(12, 0),
-		.w1c = (PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD |
-			PCI_EXP_SLTSTA_MRLSC | PCI_EXP_SLTSTA_PDC |
-			PCI_EXP_SLTSTA_CC | PCI_EXP_SLTSTA_DLLSC) << 16,
-		.ro = (PCI_EXP_SLTSTA_MRLSS | PCI_EXP_SLTSTA_PDS |
-		       PCI_EXP_SLTSTA_EIS) << 16,
+		.w1c = (BIT(8) | GENMASK(4, 0)) << 16,
+		.ro = GENMASK(7, 5) << 16,
 		.rsvd = GENMASK(15, 13) | (GENMASK(15, 9) << 16),
 	},
 
@@ -236,10 +233,8 @@ static const struct pci_bridge_reg_behavior pcie_cap_regs_behavior[] = {
 		 *
 		 * Root capabilities has bit 0 RO, the rest is reserved.
 		 */
-		.rw = (PCI_EXP_RTCTL_SECEE | PCI_EXP_RTCTL_SENFEE |
-		       PCI_EXP_RTCTL_SEFEE | PCI_EXP_RTCTL_PMEIE |
-		       PCI_EXP_RTCTL_CRSSVE),
-		.ro = PCI_EXP_RTCAP_CRSVIS << 16,
+		.rw = GENMASK(4, 0),
+		.ro = BIT(0) << 16,
 		.rsvd = GENMASK(15, 5) | (GENMASK(15, 1) << 16),
 	},
 
@@ -248,8 +243,8 @@ static const struct pci_bridge_reg_behavior pcie_cap_regs_behavior[] = {
 		 * Root status has bits 17 and [15:0] RO, bit 16 W1C, the rest
 		 * is reserved.
 		 */
-		.ro = GENMASK(15, 0) | PCI_EXP_RTSTA_PENDING,
-		.w1c = PCI_EXP_RTSTA_PME,
+		.ro = BIT(17) | GENMASK(15, 0),
+		.w1c = BIT(16),
 		.rsvd = GENMASK(31, 18),
 	},
 };
-- 
2.18.1


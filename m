Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF1021561B8
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2020 01:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgBHAAP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Feb 2020 19:00:15 -0500
Received: from mga03.intel.com ([134.134.136.65]:58200 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727032AbgBHAAO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Feb 2020 19:00:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2020 16:00:14 -0800
X-IronPort-AV: E=Sophos;i="5.70,415,1574150400"; 
   d="scan'208";a="225545684"
Received: from nsgsw-rhel7p6.lm.intel.com ([10.232.116.83])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2020 16:00:13 -0800
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
Subject: [RFC 1/9] PCI: pci-bridge-emul: Update PCIe register behaviors
Date:   Fri,  7 Feb 2020 16:59:59 -0700
Message-Id: <1581120007-5280-2-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1581120007-5280-1-git-send-email-jonathan.derrick@intel.com>
References: <1581120007-5280-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Update the PCIe register behaviors and comments for PCIe v5.0.
Replace the specific bit definitions with BIT and GENMASK to make
updating easier in the future.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/pci-bridge-emul.c | 54 +++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
index fffa770..d065c2a 100644
--- a/drivers/pci/pci-bridge-emul.c
+++ b/drivers/pci/pci-bridge-emul.c
@@ -191,12 +191,12 @@ struct pci_bridge_reg_behavior {
 		.rw = GENMASK(15, 0),
 
 		/*
-		 * Device status register has 4 bits W1C, then 2 bits
-		 * RO, the rest is reserved
+		 * Device status register has bits 6 and [3:0] W1C, [5:4] RO,
+		 * the rest is reserved
 		 */
-		.w1c = GENMASK(19, 16),
-		.ro = GENMASK(20, 19),
-		.rsvd = GENMASK(31, 21),
+		.w1c = (BIT(6) | GENMASK(3, 0)) << 16,
+		.ro = GENMASK(5, 4) << 16,
+		.rsvd = GENMASK(15, 7) << 16,
 	},
 
 	[PCI_EXP_LNKCAP / 4] = {
@@ -207,15 +207,16 @@ struct pci_bridge_reg_behavior {
 
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
@@ -224,19 +225,16 @@ struct pci_bridge_reg_behavior {
 
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
-		.w1c = (PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD |
-			PCI_EXP_SLTSTA_MRLSC | PCI_EXP_SLTSTA_PDC |
-			PCI_EXP_SLTSTA_CC | PCI_EXP_SLTSTA_DLLSC) << 16,
-		.ro = (PCI_EXP_SLTSTA_MRLSS | PCI_EXP_SLTSTA_PDS |
-		       PCI_EXP_SLTSTA_EIS) << 16,
-		.rsvd = GENMASK(15, 12) | (GENMASK(15, 9) << 16),
+		.rw = GENMASK(14, 0),
+		.w1c = (BIT(8) | GENMASK(4, 0)) << 16,
+		.ro = GENMASK(7, 5) << 16,
+		.rsvd = BIT(15) | (GENMASK(15, 9) << 16),
 	},
 
 	[PCI_EXP_RTCTL / 4] = {
@@ -244,18 +242,20 @@ struct pci_bridge_reg_behavior {
 		 * Root control has bits [4:0] RW, the rest is
 		 * reserved.
 		 *
-		 * Root status has bit 0 RO, the rest is reserved.
+		 * Root capabilities has bit 0 RO, the rest is reserved.
 		 */
-		.rw = (PCI_EXP_RTCTL_SECEE | PCI_EXP_RTCTL_SENFEE |
-		       PCI_EXP_RTCTL_SEFEE | PCI_EXP_RTCTL_PMEIE |
-		       PCI_EXP_RTCTL_CRSSVE),
-		.ro = PCI_EXP_RTCAP_CRSVIS << 16,
+		.rw = GENMASK(4, 0),
+		.ro = BIT(0) << 16,
 		.rsvd = GENMASK(15, 5) | (GENMASK(15, 1) << 16),
 	},
 
 	[PCI_EXP_RTSTA / 4] = {
-		.ro = GENMASK(15, 0) | PCI_EXP_RTSTA_PENDING,
-		.w1c = PCI_EXP_RTSTA_PME,
+		/*
+		 * Root status has bits 17 and [15:0] RO, bit 16 W1C, the rest
+		 * is reserved.
+		 */
+		.ro = BIT(17) | GENMASK(15, 0),
+		.w1c = BIT(16),
 		.rsvd = GENMASK(31, 18),
 	},
 };
-- 
1.8.3.1


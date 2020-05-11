Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89CA81CE0A3
	for <lists+linux-pci@lfdr.de>; Mon, 11 May 2020 18:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729971AbgEKQh3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 May 2020 12:37:29 -0400
Received: from mga04.intel.com ([192.55.52.120]:7552 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729120AbgEKQh3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 May 2020 12:37:29 -0400
IronPort-SDR: Tg/qE/lkDT+fmgo/ZbPcBmv9QGRrY/PlSMTjgrIvScVC9/HaakPUWtu4B2XP5SBS0vG18lITLp
 wavekiizrulw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2020 09:37:28 -0700
IronPort-SDR: vpKRGS7Mzs820TfRvTRcKl28gEixTEj9dPThq0vvz4KV6q5+WZGTcfvt92pD82Wmg/+kVaDdta
 45plCyVCuusQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,380,1583222400"; 
   d="scan'208";a="286334377"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.116.74])
  by fmsmga004.fm.intel.com with ESMTP; 11 May 2020 09:37:08 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <linux-pci@vger.kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Rob Herring <robh@kernel.org>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH v2 1/4] PCI: pci-bridge-emul: Fix PCIe bit conflicts
Date:   Mon, 11 May 2020 12:21:14 -0400
Message-Id: <20200511162117.6674-2-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20200511162117.6674-1-jonathan.derrick@intel.com>
References: <20200511162117.6674-1-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch fixes two bit conflicts in the pci-bridge-emul driver:

1. Bit 3 of Device Status (19 of Device Control) is marked as both
   Write-1-to-Clear and Read-Only. It should be Write-1-to-Clear.
   The Read-Only and Reserved bitmasks are shifted by 1 bit due to this
   error.

2. Bit 12 of Slot Control is marked as both Read-Write and Reserved.
   It should be Read-Write.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/pci-bridge-emul.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
index 4f4f54bc732e..faa414655f33 100644
--- a/drivers/pci/pci-bridge-emul.c
+++ b/drivers/pci/pci-bridge-emul.c
@@ -185,8 +185,8 @@ static const struct pci_bridge_reg_behavior pcie_cap_regs_behavior[] = {
 		 * RO, the rest is reserved
 		 */
 		.w1c = GENMASK(19, 16),
-		.ro = GENMASK(20, 19),
-		.rsvd = GENMASK(31, 21),
+		.ro = GENMASK(21, 20),
+		.rsvd = GENMASK(31, 22),
 	},
 
 	[PCI_EXP_LNKCAP / 4] = {
@@ -226,7 +226,7 @@ static const struct pci_bridge_reg_behavior pcie_cap_regs_behavior[] = {
 			PCI_EXP_SLTSTA_CC | PCI_EXP_SLTSTA_DLLSC) << 16,
 		.ro = (PCI_EXP_SLTSTA_MRLSS | PCI_EXP_SLTSTA_PDS |
 		       PCI_EXP_SLTSTA_EIS) << 16,
-		.rsvd = GENMASK(15, 12) | (GENMASK(15, 9) << 16),
+		.rsvd = GENMASK(15, 13) | (GENMASK(15, 9) << 16),
 	},
 
 	[PCI_EXP_RTCTL / 4] = {
-- 
2.18.1


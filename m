Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C816290C2
	for <lists+linux-pci@lfdr.de>; Fri, 24 May 2019 08:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388260AbfEXGHm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 May 2019 02:07:42 -0400
Received: from mga18.intel.com ([134.134.136.126]:13073 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388070AbfEXGHm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 May 2019 02:07:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 May 2019 23:07:41 -0700
X-ExtLoop1: 1
Received: from lftan-mobl.gar.corp.intel.com (HELO ubuntu) ([10.226.248.59])
  by orsmga004.jf.intel.com with SMTP; 23 May 2019 23:07:38 -0700
Received: by ubuntu (sSMTP sendmail emulation); Fri, 24 May 2019 14:07:36 +0800
From:   Ley Foon Tan <ley.foon.tan@intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lftan.linux@gmail.com, Ley Foon Tan <ley.foon.tan@intel.com>
Subject: [PATCH 2/2] PCI: altera: Remove cfgrdX and cfgwrX
Date:   Fri, 24 May 2019 14:07:26 +0800
Message-Id: <1558678046-4052-3-git-send-email-ley.foon.tan@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558678046-4052-1-git-send-email-ley.foon.tan@intel.com>
References: <1558678046-4052-1-git-send-email-ley.foon.tan@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

No longer need cfgrdX and cfgwrX since we have separate defines for
TLP_CFG*_DW0 and S10_TLP_CFG*_DW0, so remove them.

Signed-off-by: Ley Foon Tan <ley.foon.tan@intel.com>
---
 drivers/pci/controller/pcie-altera.c | 33 +++++++---------------------
 1 file changed, 8 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
index 047bcc214f9b..d96980a4e327 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -58,20 +58,20 @@
 #define RP_DEVFN			0
 #define TLP_REQ_ID(bus, devfn)		(((bus) << 8) | (devfn))
 #define TLP_CFGRD_DW0(pcie, bus)					\
-	((((bus == pcie->root_bus_nr) ? pcie->pcie_data->cfgrd0		\
-				: pcie->pcie_data->cfgrd1) << 24) |	\
+	((((bus == pcie->root_bus_nr) ? TLP_FMTTYPE_CFGRD0		\
+				: TLP_FMTTYPE_CFGRD1) << 24) |	\
 				TLP_PAYLOAD_SIZE)
 #define TLP_CFGWR_DW0(pcie, bus)					\
-	((((bus == pcie->root_bus_nr) ? pcie->pcie_data->cfgwr0		\
-				: pcie->pcie_data->cfgwr1) << 24) |	\
+	((((bus == pcie->root_bus_nr) ? TLP_FMTTYPE_CFGWR0		\
+				: TLP_FMTTYPE_CFGWR1) << 24) |	\
 				TLP_PAYLOAD_SIZE)
 #define S10_TLP_CFGRD_DW0(pcie, bus)					\
-	(((((bus) > S10_RP_SECONDARY(pcie)) ? pcie->pcie_data->cfgrd0	\
-				: pcie->pcie_data->cfgrd1) << 24) |	\
+	(((((bus) > S10_RP_SECONDARY(pcie)) ? TLP_FMTTYPE_CFGRD1	\
+				: TLP_FMTTYPE_CFGRD0) << 24) |	\
 				TLP_PAYLOAD_SIZE)
 #define S10_TLP_CFGWR_DW0(pcie, bus)					\
-	(((((bus) > S10_RP_SECONDARY(pcie)) ? pcie->pcie_data->cfgwr0	\
-				: pcie->pcie_data->cfgwr1) << 24) |	\
+	(((((bus) > S10_RP_SECONDARY(pcie)) ? TLP_FMTTYPE_CFGWR1	\
+				: TLP_FMTTYPE_CFGWR0) << 24) |	\
 				TLP_PAYLOAD_SIZE)
 #define TLP_CFG_DW1(pcie, tag, be)	\
 	(((TLP_REQ_ID(pcie->root_bus_nr,  RP_DEVFN)) << 16) | (tag << 8) | (be))
@@ -87,11 +87,6 @@
 
 #define DWORD_MASK			3
 
-#define S10_TLP_FMTTYPE_CFGRD0		0x05
-#define S10_TLP_FMTTYPE_CFGRD1		0x04
-#define S10_TLP_FMTTYPE_CFGWR0		0x45
-#define S10_TLP_FMTTYPE_CFGWR1		0x44
-
 enum altera_pcie_version {
 	ALTERA_PCIE_V1 = 0,
 	ALTERA_PCIE_V2,
@@ -124,10 +119,6 @@ struct altera_pcie_data {
 	const struct altera_pcie_ops *ops;
 	enum altera_pcie_version version;
 	u32 cap_offset;		/* PCIe capability structure register offset */
-	u32 cfgrd0;
-	u32 cfgrd1;
-	u32 cfgwr0;
-	u32 cfgwr1;
 };
 
 struct tlp_rp_regpair_t {
@@ -784,20 +775,12 @@ static const struct altera_pcie_data altera_pcie_1_0_data = {
 	.ops = &altera_pcie_ops_1_0,
 	.cap_offset = 0x80,
 	.version = ALTERA_PCIE_V1,
-	.cfgrd0 = TLP_FMTTYPE_CFGRD0,
-	.cfgrd1 = TLP_FMTTYPE_CFGRD1,
-	.cfgwr0 = TLP_FMTTYPE_CFGWR0,
-	.cfgwr1 = TLP_FMTTYPE_CFGWR1,
 };
 
 static const struct altera_pcie_data altera_pcie_2_0_data = {
 	.ops = &altera_pcie_ops_2_0,
 	.version = ALTERA_PCIE_V2,
 	.cap_offset = 0x70,
-	.cfgrd0 = S10_TLP_FMTTYPE_CFGRD0,
-	.cfgrd1 = S10_TLP_FMTTYPE_CFGRD1,
-	.cfgwr0 = S10_TLP_FMTTYPE_CFGWR0,
-	.cfgwr1 = S10_TLP_FMTTYPE_CFGWR1,
 };
 
 static const struct of_device_id altera_pcie_of_match[] = {
-- 
2.19.0


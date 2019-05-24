Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86F96290C0
	for <lists+linux-pci@lfdr.de>; Fri, 24 May 2019 08:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388232AbfEXGHi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 May 2019 02:07:38 -0400
Received: from mga11.intel.com ([192.55.52.93]:11205 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387622AbfEXGHh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 May 2019 02:07:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 May 2019 23:07:37 -0700
X-ExtLoop1: 1
Received: from lftan-mobl.gar.corp.intel.com (HELO ubuntu) ([10.226.248.59])
  by fmsmga007.fm.intel.com with SMTP; 23 May 2019 23:07:33 -0700
Received: by ubuntu (sSMTP sendmail emulation); Fri, 24 May 2019 14:07:31 +0800
From:   Ley Foon Tan <ley.foon.tan@intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lftan.linux@gmail.com, Ley Foon Tan <ley.foon.tan@intel.com>
Subject: [PATCH 1/2] PCI: altera: Fix configuration type based on secondary number
Date:   Fri, 24 May 2019 14:07:25 +0800
Message-Id: <1558678046-4052-2-git-send-email-ley.foon.tan@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558678046-4052-1-git-send-email-ley.foon.tan@intel.com>
References: <1558678046-4052-1-git-send-email-ley.foon.tan@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This fix issue when access config from PCIe switch.

Stratix 10 PCIe controller does not support Type 1 to Type 0 conversion
as previous version (V1) does.

The PCIe controller need to send Type 0 config TLP if the targeting bus
matches with the secondary bus number, which is when the TLP is targeting
the immediate device on the link.

The PCIe controller send Type 1 config TLP if the targeting bus is
larger than the secondary bus, which is when the TLP is targeting the
device not immediate on the link.

Signed-off-by: Ley Foon Tan <ley.foon.tan@intel.com>
---
 drivers/pci/controller/pcie-altera.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
index 27222071ace7..047bcc214f9b 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -44,6 +44,8 @@
 #define S10_RP_RXCPL_STATUS		0x200C
 #define S10_RP_CFG_ADDR(pcie, reg)	\
 	(((pcie)->hip_base) + (reg) + (1 << 20))
+#define S10_RP_SECONDARY(pcie)		\
+	readb(S10_RP_CFG_ADDR(pcie, PCI_SECONDARY_BUS))
 
 /* TLP configuration type 0 and 1 */
 #define TLP_FMTTYPE_CFGRD0		0x04	/* Configuration Read Type 0 */
@@ -63,6 +65,14 @@
 	((((bus == pcie->root_bus_nr) ? pcie->pcie_data->cfgwr0		\
 				: pcie->pcie_data->cfgwr1) << 24) |	\
 				TLP_PAYLOAD_SIZE)
+#define S10_TLP_CFGRD_DW0(pcie, bus)					\
+	(((((bus) > S10_RP_SECONDARY(pcie)) ? pcie->pcie_data->cfgrd0	\
+				: pcie->pcie_data->cfgrd1) << 24) |	\
+				TLP_PAYLOAD_SIZE)
+#define S10_TLP_CFGWR_DW0(pcie, bus)					\
+	(((((bus) > S10_RP_SECONDARY(pcie)) ? pcie->pcie_data->cfgwr0	\
+				: pcie->pcie_data->cfgwr1) << 24) |	\
+				TLP_PAYLOAD_SIZE)
 #define TLP_CFG_DW1(pcie, tag, be)	\
 	(((TLP_REQ_ID(pcie->root_bus_nr,  RP_DEVFN)) << 16) | (tag << 8) | (be))
 #define TLP_CFG_DW2(bus, devfn, offset)	\
@@ -327,7 +337,11 @@ static int tlp_cfg_dword_read(struct altera_pcie *pcie, u8 bus, u32 devfn,
 {
 	u32 headers[TLP_HDR_SIZE];
 
-	headers[0] = TLP_CFGRD_DW0(pcie, bus);
+	if (pcie->pcie_data->version == ALTERA_PCIE_V1)
+		headers[0] = TLP_CFGRD_DW0(pcie, bus);
+	else
+		headers[0] = S10_TLP_CFGRD_DW0(pcie, bus);
+
 	headers[1] = TLP_CFG_DW1(pcie, TLP_READ_TAG, byte_en);
 	headers[2] = TLP_CFG_DW2(bus, devfn, where);
 
@@ -342,7 +356,11 @@ static int tlp_cfg_dword_write(struct altera_pcie *pcie, u8 bus, u32 devfn,
 	u32 headers[TLP_HDR_SIZE];
 	int ret;
 
-	headers[0] = TLP_CFGWR_DW0(pcie, bus);
+	if (pcie->pcie_data->version == ALTERA_PCIE_V1)
+		headers[0] = TLP_CFGWR_DW0(pcie, bus);
+	else
+		headers[0] = S10_TLP_CFGWR_DW0(pcie, bus);
+
 	headers[1] = TLP_CFG_DW1(pcie, TLP_WRITE_TAG, byte_en);
 	headers[2] = TLP_CFG_DW2(bus, devfn, where);
 
-- 
2.19.0


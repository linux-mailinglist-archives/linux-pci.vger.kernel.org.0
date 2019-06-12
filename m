Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5C641C5E
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2019 08:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730957AbfFLGmI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jun 2019 02:42:08 -0400
Received: from mga03.intel.com ([134.134.136.65]:46990 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbfFLGmI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Jun 2019 02:42:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2019 23:42:06 -0700
X-ExtLoop1: 1
Received: from lftan-mobl.gar.corp.intel.com (HELO ubuntu) ([10.226.248.70])
  by FMSMGA003.fm.intel.com with SMTP; 11 Jun 2019 23:42:04 -0700
Received: by ubuntu (sSMTP sendmail emulation); Wed, 12 Jun 2019 14:42:02 +0800
From:   Ley Foon Tan <ley.foon.tan@intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lftan.linux@gmail.com, Ley Foon Tan <ley.foon.tan@intel.com>
Subject: [PATCH v2] PCI: altera: Fix configuration type based on secondary number
Date:   Wed, 12 Jun 2019 14:42:00 +0800
Message-Id: <1560321720-4083-1-git-send-email-ley.foon.tan@intel.com>
X-Mailer: git-send-email 2.7.4
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
v2:
- Add get_tlp_header() function.
---
 drivers/pci/controller/pcie-altera.c | 41 ++++++++++++++++++----------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
index 27222071ace7..d2497ca43828 100644
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
@@ -55,14 +57,9 @@
 #define TLP_WRITE_TAG			0x10
 #define RP_DEVFN			0
 #define TLP_REQ_ID(bus, devfn)		(((bus) << 8) | (devfn))
-#define TLP_CFGRD_DW0(pcie, bus)					\
-	((((bus == pcie->root_bus_nr) ? pcie->pcie_data->cfgrd0		\
-				: pcie->pcie_data->cfgrd1) << 24) |	\
-				TLP_PAYLOAD_SIZE)
-#define TLP_CFGWR_DW0(pcie, bus)					\
-	((((bus == pcie->root_bus_nr) ? pcie->pcie_data->cfgwr0		\
-				: pcie->pcie_data->cfgwr1) << 24) |	\
-				TLP_PAYLOAD_SIZE)
+#define TLP_CFG_DW0(pcie, cfg)		\
+		(((cfg) << 24) |	\
+		  TLP_PAYLOAD_SIZE)
 #define TLP_CFG_DW1(pcie, tag, be)	\
 	(((TLP_REQ_ID(pcie->root_bus_nr,  RP_DEVFN)) << 16) | (tag << 8) | (be))
 #define TLP_CFG_DW2(bus, devfn, offset)	\
@@ -322,14 +319,31 @@ static void s10_tlp_write_packet(struct altera_pcie *pcie, u32 *headers,
 	s10_tlp_write_tx(pcie, data, RP_TX_EOP);
 }
 
+static void get_tlp_header(struct altera_pcie *pcie, u8 bus, u32 devfn,
+			   int where, u8 byte_en, bool read, u32 *headers)
+{
+	u8 cfg;
+	u8 cfg0 = read ? pcie->pcie_data->cfgrd0 : pcie->pcie_data->cfgwr0;
+	u8 cfg1 = read ? pcie->pcie_data->cfgrd1 : pcie->pcie_data->cfgwr1;
+	u8 tag = read ? TLP_READ_TAG : TLP_WRITE_TAG;
+
+	if (pcie->pcie_data->version == ALTERA_PCIE_V1)
+		cfg = (bus == pcie->root_bus_nr) ? cfg0 : cfg1;
+	else
+		cfg = (bus > S10_RP_SECONDARY(pcie)) ? cfg0 : cfg1;
+
+	headers[0] = TLP_CFG_DW0(pcie, cfg);
+	headers[1] = TLP_CFG_DW1(pcie, tag, byte_en);
+	headers[2] = TLP_CFG_DW2(bus, devfn, where);
+}
+
 static int tlp_cfg_dword_read(struct altera_pcie *pcie, u8 bus, u32 devfn,
 			      int where, u8 byte_en, u32 *value)
 {
 	u32 headers[TLP_HDR_SIZE];
 
-	headers[0] = TLP_CFGRD_DW0(pcie, bus);
-	headers[1] = TLP_CFG_DW1(pcie, TLP_READ_TAG, byte_en);
-	headers[2] = TLP_CFG_DW2(bus, devfn, where);
+	get_tlp_header(pcie, bus, devfn, where, byte_en, true,
+		       headers);
 
 	pcie->pcie_data->ops->tlp_write_pkt(pcie, headers, 0, false);
 
@@ -342,9 +356,8 @@ static int tlp_cfg_dword_write(struct altera_pcie *pcie, u8 bus, u32 devfn,
 	u32 headers[TLP_HDR_SIZE];
 	int ret;
 
-	headers[0] = TLP_CFGWR_DW0(pcie, bus);
-	headers[1] = TLP_CFG_DW1(pcie, TLP_WRITE_TAG, byte_en);
-	headers[2] = TLP_CFG_DW2(bus, devfn, where);
+	get_tlp_header(pcie, bus, devfn, where, byte_en, false,
+		       headers);
 
 	/* check alignment to Qword */
 	if ((where & 0x7) == 0)
-- 
2.19.0


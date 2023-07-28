Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E18D766DE7
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jul 2023 15:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236416AbjG1NOR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jul 2023 09:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233825AbjG1NOP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Jul 2023 09:14:15 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA1C3A99
        for <linux-pci@vger.kernel.org>; Fri, 28 Jul 2023 06:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690550054; x=1722086054;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D9GXduwijQK2bxnbxUdIwGcNUgABIPbcfCI5pRehEFA=;
  b=smTmCfBG0/bbwPor7MdopAWkpO46VPbaYAgj6IvjmMJ+6xyi9zxjirQl
   AEKIQdKIcdI7gT/Pep28a8PTymT3agQLqgLCC4Wh0Zh0w2FF4sCNJzv/C
   kBfKn29vxItv6EW74NLGSotarz6Xmy0uLnPycN2S2IBTvufKW0m2U52bl
   Irn4hMbHzMx1d2cSimfWVRp7KyKmzksPNANo6gjZG0IjtQTOutUiOF5FQ
   2q448KgIbnAxZHjEd7aapHSVK+QzdgoWRKPgfF5dVgi7Iw2DW7h1o4slJ
   AyCBRelibSLOQFXKjBAlNIKQ2hUsLl2Q+wPJxyorA4lCzMOmfAB9cEKvQ
   g==;
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="238431561"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jul 2023 06:14:14 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 28 Jul 2023 06:14:14 -0700
Received: from daire-X570.amer.actel.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 28 Jul 2023 06:14:12 -0700
From:   <daire.mcnamara@microchip.com>
To:     <conor.dooley@microchip.com>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <linux-riscv@lists.infradead.org>, <linux-pci@vger.kernel.org>
CC:     Daire McNamara <daire.mcnamara@microchip.com>
Subject: [PATCH v3 4/7] PCI: microchip: Enable event handlers to access bridge and ctrl ptrs
Date:   Fri, 28 Jul 2023 14:13:58 +0100
Message-ID: <20230728131401.1615724-5-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230728131401.1615724-1-daire.mcnamara@microchip.com>
References: <20230728131401.1615724-1-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Daire McNamara <daire.mcnamara@microchip.com>

Minor re-organisation so that event handlers can access both a pointer
to the bridge area of the PCIe Root Port and the ctrl area of the PCIe
Root Port.

Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/pci/controller/pcie-microchip-host.c | 31 ++++++++++----------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
index 30153fd1a2b3..a81e6d25e347 100644
--- a/drivers/pci/controller/pcie-microchip-host.c
+++ b/drivers/pci/controller/pcie-microchip-host.c
@@ -654,9 +654,10 @@ static inline u32 reg_to_event(u32 reg, struct event_map field)
 	return (reg & field.reg_mask) ? BIT(field.event_bit) : 0;
 }
 
-static u32 pcie_events(void __iomem *addr)
+static u32 pcie_events(struct mc_pcie *port)
 {
-	u32 reg = readl_relaxed(addr);
+	void __iomem *ctrl_base_addr = port->axi_base_addr + MC_PCIE_CTRL_ADDR;
+	u32 reg = readl_relaxed(ctrl_base_addr + PCIE_EVENT_INT);
 	u32 val = 0;
 	int i;
 
@@ -666,9 +667,10 @@ static u32 pcie_events(void __iomem *addr)
 	return val;
 }
 
-static u32 sec_errors(void __iomem *addr)
+static u32 sec_errors(struct mc_pcie *port)
 {
-	u32 reg = readl_relaxed(addr);
+	void __iomem *ctrl_base_addr = port->axi_base_addr + MC_PCIE_CTRL_ADDR;
+	u32 reg = readl_relaxed(ctrl_base_addr + SEC_ERROR_INT);
 	u32 val = 0;
 	int i;
 
@@ -678,9 +680,10 @@ static u32 sec_errors(void __iomem *addr)
 	return val;
 }
 
-static u32 ded_errors(void __iomem *addr)
+static u32 ded_errors(struct mc_pcie *port)
 {
-	u32 reg = readl_relaxed(addr);
+	void __iomem *ctrl_base_addr = port->axi_base_addr + MC_PCIE_CTRL_ADDR;
+	u32 reg = readl_relaxed(ctrl_base_addr + DED_ERROR_INT);
 	u32 val = 0;
 	int i;
 
@@ -690,9 +693,10 @@ static u32 ded_errors(void __iomem *addr)
 	return val;
 }
 
-static u32 local_events(void __iomem *addr)
+static u32 local_events(struct mc_pcie *port)
 {
-	u32 reg = readl_relaxed(addr);
+	void __iomem *bridge_base_addr = port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
+	u32 reg = readl_relaxed(bridge_base_addr + ISTATUS_LOCAL);
 	u32 val = 0;
 	int i;
 
@@ -704,15 +708,12 @@ static u32 local_events(void __iomem *addr)
 
 static u32 get_events(struct mc_pcie *port)
 {
-	void __iomem *bridge_base_addr =
-		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
-	void __iomem *ctrl_base_addr = port->axi_base_addr + MC_PCIE_CTRL_ADDR;
 	u32 events = 0;
 
-	events |= pcie_events(ctrl_base_addr + PCIE_EVENT_INT);
-	events |= sec_errors(ctrl_base_addr + SEC_ERROR_INT);
-	events |= ded_errors(ctrl_base_addr + DED_ERROR_INT);
-	events |= local_events(bridge_base_addr + ISTATUS_LOCAL);
+	events |= pcie_events(port);
+	events |= sec_errors(port);
+	events |= ded_errors(port);
+	events |= local_events(port);
 
 	return events;
 }
-- 
2.25.1


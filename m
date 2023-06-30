Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47EC743F2D
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jun 2023 17:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbjF3PtQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jun 2023 11:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbjF3PtO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Jun 2023 11:49:14 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B68B3A87
        for <linux-pci@vger.kernel.org>; Fri, 30 Jun 2023 08:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1688140153; x=1719676153;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D9GXduwijQK2bxnbxUdIwGcNUgABIPbcfCI5pRehEFA=;
  b=VKVdfwWx69Zw6x7tkGxHIspbof85qGtFyU2fB5bVRERejx8x07HvHrKJ
   Z1N2rtsDG0t6+UUsUMmj9gsfDuHmmobuhh41xUQjz2YxV2ssOBmJnwjPy
   X9+F+/5h+/wY8betzX6+cg8cc1eG+mDp8iClLTyJqZqcArhOaRVA1nqti
   L+aLvu6mgoNJ4295F2Lc/6CZU0WGkPyTaXatyIa60D5HlhFl7NgPIfVY+
   ddle8ZY9xNtFOuTIVHpp0HudLLJ1TKaRmE5VqKfAJ/UPjY8KhEfTNPCRM
   yZdYbLDO+2BJFxr3XCqIbw16fplAHTJ1QdQGim5z2wBvFWp6ZQvXQyd7p
   g==;
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="220736206"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Jun 2023 08:49:12 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 30 Jun 2023 08:49:12 -0700
Received: from daire-X570.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 30 Jun 2023 08:49:11 -0700
From:   <daire.mcnamara@microchip.com>
To:     <conor@kernel.org>
CC:     Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-riscv@lists.infradead.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v2 4/8] PCI: microchip: Enable event handlers to access bridge and ctrl ptrs
Date:   Fri, 30 Jun 2023 16:48:55 +0100
Message-ID: <20230630154859.2049521-5-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230630154859.2049521-1-daire.mcnamara@microchip.com>
References: <20230630154859.2049521-1-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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


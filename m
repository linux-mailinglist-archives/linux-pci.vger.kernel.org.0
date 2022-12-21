Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8B46533EB
	for <lists+linux-pci@lfdr.de>; Wed, 21 Dec 2022 17:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbiLUQ1B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Dec 2022 11:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234448AbiLUQ04 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Dec 2022 11:26:56 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06AB23BD6;
        Wed, 21 Dec 2022 08:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1671640010; x=1703176010;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D9GXduwijQK2bxnbxUdIwGcNUgABIPbcfCI5pRehEFA=;
  b=mc6Bl56pl5qMiaU4X5eu4mpck5uT2kaeiDbrsr2gSJH5/6/ZZuP4LF+7
   SfLyYjGfXYvB7WpxVoo+utVt+4RaBoJVKNf8Ub0/jEPJQvXXSs/9UBuSY
   iQy3CLFIokyMTLD5trB8nnrF2hWJ0t38IIE317mZJ36VXC05Uh9tfezMs
   VHkP1YhX7M6PyC251rntFFAuT/KFJRnF0DTjM3pZPZAFbZGIRPWpZGpn+
   uUVZxj8xXinAT3klODsWWqnbsYAM079n3gy1Ek1HDfoWgN9t0j/H94Jeg
   EEbuAAaOH0wDZ/AjjGsLAIYVjkN7cco/S3QbVQvsnK0jQQVdtX7IrZKtG
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,262,1665471600"; 
   d="scan'208";a="189198869"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Dec 2022 09:26:47 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 21 Dec 2022 09:26:44 -0700
Received: from daire-X570.emdalo.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Wed, 21 Dec 2022 09:26:41 -0700
From:   <daire.mcnamara@microchip.com>
To:     <conor.dooley@microchip.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <bhelgaas@google.com>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
CC:     Daire McNamara <daire.mcnamara@microchip.com>
Subject: [PATCH v2 3/9] PCI: microchip: Enable event handlers to access bridge and ctrl ptrs
Date:   Wed, 21 Dec 2022 16:26:24 +0000
Message-ID: <20221221162630.3632486-4-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221221162630.3632486-1-daire.mcnamara@microchip.com>
References: <20221221162630.3632486-1-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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


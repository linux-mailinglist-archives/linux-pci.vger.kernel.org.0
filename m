Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E9352300C
	for <lists+linux-pci@lfdr.de>; Wed, 11 May 2022 11:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbiEKJ5g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 May 2022 05:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243367AbiEKJ5H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 May 2022 05:57:07 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAB84BFCB
        for <linux-pci@vger.kernel.org>; Wed, 11 May 2022 02:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652263012; x=1683799012;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Pk5l4FdODNKsLNR9zYi1dbD3+3DoqS1g/UOPM0PVLpU=;
  b=gT2WAio2mSXfi53IVOMLNoGbKzBDbkdTY24ZNNCgE7gy0ByHe6i8RwqG
   hn+F7w0NwxQACsM1aLbkVNPww6MC8GX/k7jxPcFRTBwKXUM22wX3c+4wc
   8/EdZSKT2YOCE8PakTRurRSlMsnh2KUiYEkiy4SEypX4gNzw85Pbz+j+F
   JmCZSNvBjy3lszZzMZJHiA2mzIhv7j3n5MY06nXFVDhU/5onAq4hflMW2
   jwzEREp761ZDSgbd/1DuMn0uA2WNtV1A0X3OUtQVxr7QQAd8Y/IuXY4og
   srv+DClAe9DG6EndSEuBMHx7M9y+AJai1UdcVLkzSp6P3NyV36AWvbUEO
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="158591843"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 May 2022 02:56:50 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 11 May 2022 02:56:50 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Wed, 11 May 2022 02:56:47 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <helgaas@kernel.org>, <Daire.McNamara@microchip.com>,
        <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>
CC:     <Conor.Dooley@microchip.com>, <Cyril.Jean@microchip.com>,
        <david.abdurachmanov@gmail.com>, <linux-pci@vger.kernel.org>,
        <maz@kernel.org>, <robh@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH] PCI: microchip: add missing chained_irq enter/exit calls
Date:   Wed, 11 May 2022 10:55:05 +0100
Message-ID: <20220511095504.2273799-1-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn spotted that two of the chained irq handlers were missing their
chained_irq_enter()/chained_irq_exit() calls, so add them in to avoid
potentially lost interrupts.

Reported by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/linux-pci/87h76b8nxc.wl-maz@kernel.org
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/pci/controller/pcie-microchip-host.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
index 29d8e81e4181..8175abed0f05 100644
--- a/drivers/pci/controller/pcie-microchip-host.c
+++ b/drivers/pci/controller/pcie-microchip-host.c
@@ -406,6 +406,7 @@ static void mc_pcie_enable_msi(struct mc_pcie *port, void __iomem *base)
 static void mc_handle_msi(struct irq_desc *desc)
 {
 	struct mc_pcie *port = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct device *dev = port->dev;
 	struct mc_msi *msi = &port->msi;
 	void __iomem *bridge_base_addr =
@@ -414,6 +415,8 @@ static void mc_handle_msi(struct irq_desc *desc)
 	u32 bit;
 	int ret;
 
+	chained_irq_enter(chip, desc);
+
 	status = readl_relaxed(bridge_base_addr + ISTATUS_LOCAL);
 	if (status & PM_MSI_INT_MSI_MASK) {
 		status = readl_relaxed(bridge_base_addr + ISTATUS_MSI);
@@ -424,6 +427,8 @@ static void mc_handle_msi(struct irq_desc *desc)
 						    bit);
 		}
 	}
+
+	chained_irq_exit(chip, desc);
 }
 
 static void mc_msi_bottom_irq_ack(struct irq_data *data)
@@ -563,6 +568,7 @@ static int mc_allocate_msi_domains(struct mc_pcie *port)
 static void mc_handle_intx(struct irq_desc *desc)
 {
 	struct mc_pcie *port = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct device *dev = port->dev;
 	void __iomem *bridge_base_addr =
 		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
@@ -570,6 +576,8 @@ static void mc_handle_intx(struct irq_desc *desc)
 	u32 bit;
 	int ret;
 
+	chained_irq_enter(chip, desc);
+
 	status = readl_relaxed(bridge_base_addr + ISTATUS_LOCAL);
 	if (status & PM_MSI_INT_INTX_MASK) {
 		status &= PM_MSI_INT_INTX_MASK;
@@ -581,6 +589,8 @@ static void mc_handle_intx(struct irq_desc *desc)
 						    bit);
 		}
 	}
+
+	chained_irq_exit(chip, desc);
 }
 
 static void mc_ack_intx_irq(struct irq_data *data)
-- 
2.36.1


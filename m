Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5A3743F2A
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jun 2023 17:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbjF3PtL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jun 2023 11:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjF3PtK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Jun 2023 11:49:10 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874BE35A5
        for <linux-pci@vger.kernel.org>; Fri, 30 Jun 2023 08:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1688140149; x=1719676149;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iQVdQ5/Fd7A+l93rxa4YuqFXIveaFWB1LxC6Y87vXmk=;
  b=hVFHbktXoTCsQqMFleBBqumOan/HFIjWKmCBgt+XMZ1VtdsAZhBokcVd
   KjT5+wHrh1oybYmrMdJ9u09+VzltLOb9EU2TARZzekERiPa6YM/BvdPOQ
   G8IdWY3V+Dd/u8DauygrHr5XZKcJGiDWx1rHUad8O7RKODi9IJWt8jicx
   ushf7O3485hSv+aCl94Uf+bxOX0VQ1u2xeDAST0dLvO9szdXMenzgD1lq
   xGu4lf2Fyhp8SsasNf1y05NymipUH1IBRRLQpCvQc3kzP+Ra5IXgA+6Mg
   mdEQkqUSu2/ybWL6ux3PThV3lkB97gj94XfoRiNb1b21T1Bnclx/KYARf
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="159339679"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Jun 2023 08:49:09 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 30 Jun 2023 08:49:06 -0700
Received: from daire-X570.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 30 Jun 2023 08:49:04 -0700
From:   <daire.mcnamara@microchip.com>
To:     <conor@kernel.org>
CC:     Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-riscv@lists.infradead.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v2 1/8] PCI: microchip: Correct the DED and SEC interrupt bit offsets
Date:   Fri, 30 Jun 2023 16:48:52 +0100
Message-ID: <20230630154859.2049521-2-daire.mcnamara@microchip.com>
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

The SEC and DED interrupt bits were the wrong way round so the SEC
interrupt handler attempted to mask, unmask, and clear the DED interrupt
and vice versa. Correct the bit offsets so each interrupt handler
operates properly.

Fixes: 6f15a9c9f941 ("PCI: microchip: Add Microchip PolarFire PCIe controller driver")
Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/pci/controller/pcie-microchip-host.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
index 5e710e485464..dd5245904c87 100644
--- a/drivers/pci/controller/pcie-microchip-host.c
+++ b/drivers/pci/controller/pcie-microchip-host.c
@@ -167,12 +167,12 @@
 #define EVENT_PCIE_DLUP_EXIT			2
 #define EVENT_SEC_TX_RAM_SEC_ERR		3
 #define EVENT_SEC_RX_RAM_SEC_ERR		4
-#define EVENT_SEC_AXI2PCIE_RAM_SEC_ERR		5
-#define EVENT_SEC_PCIE2AXI_RAM_SEC_ERR		6
+#define EVENT_SEC_PCIE2AXI_RAM_SEC_ERR		5
+#define EVENT_SEC_AXI2PCIE_RAM_SEC_ERR		6
 #define EVENT_DED_TX_RAM_DED_ERR		7
 #define EVENT_DED_RX_RAM_DED_ERR		8
-#define EVENT_DED_AXI2PCIE_RAM_DED_ERR		9
-#define EVENT_DED_PCIE2AXI_RAM_DED_ERR		10
+#define EVENT_DED_PCIE2AXI_RAM_DED_ERR		9
+#define EVENT_DED_AXI2PCIE_RAM_DED_ERR		10
 #define EVENT_LOCAL_DMA_END_ENGINE_0		11
 #define EVENT_LOCAL_DMA_END_ENGINE_1		12
 #define EVENT_LOCAL_DMA_ERROR_ENGINE_0		13
-- 
2.25.1


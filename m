Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7026533E7
	for <lists+linux-pci@lfdr.de>; Wed, 21 Dec 2022 17:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbiLUQ0r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Dec 2022 11:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234274AbiLUQ0p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Dec 2022 11:26:45 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4B620998;
        Wed, 21 Dec 2022 08:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1671640004; x=1703176004;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tjYAUBvEM8+Wf4xoxFJC9XV4VgaUv7rhhatptjLYPZA=;
  b=g1JhzMfl0vQehMFt03cixYZSLlF78AoJHxFoKgsuDO/3xO2HTC3mR1zG
   CnLqBYkKBSbYQIdAtTDzYoyhAma0WCMaGvEBx7Bo8v0KSk5aPI7SZFvGG
   nJCrXVnV2HvXDXG+Nk6fYqPXkXMeLot1pE74LfBW2X/kl26HK2OZIfOx4
   rB3IGvTpevRhAoYtGbnTvwmL+HWas2j9k0qEehaOnHLSkfCcRw+hNsR4B
   ZSrlCSJaXtDuo1+Mcui4W7SNMYvBrJk3aEFg284d9jSfntxNnGhYC/3tG
   FlRgA9eNXRjH2GpryLPW+OBQDOMmfWzyPpwMTXuP5r7uwJSiL73vHZM4o
   w==;
X-IronPort-AV: E=Sophos;i="5.96,262,1665471600"; 
   d="scan'208";a="204941782"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Dec 2022 09:26:44 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 21 Dec 2022 09:26:38 -0700
Received: from daire-X570.emdalo.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Wed, 21 Dec 2022 09:26:36 -0700
From:   <daire.mcnamara@microchip.com>
To:     <conor.dooley@microchip.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <bhelgaas@google.com>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
CC:     Daire McNamara <daire.mcnamara@microchip.com>
Subject: [PATCH v2 1/9] PCI: microchip: Correct the DED and SEC interrupt bit offsets
Date:   Wed, 21 Dec 2022 16:26:22 +0000
Message-ID: <20221221162630.3632486-2-daire.mcnamara@microchip.com>
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
index 0ebf7015e9af..5c89caaab8c9 100644
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


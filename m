Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D899730453
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jun 2023 17:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245051AbjFNP4v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Jun 2023 11:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245169AbjFNP4r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Jun 2023 11:56:47 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872E1E3
        for <linux-pci@vger.kernel.org>; Wed, 14 Jun 2023 08:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686758205; x=1718294205;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t0VLlU5N6re3pNoF7YVhEoPU3Oi/i8z/lOc/SQ76fqc=;
  b=iaU9kqTuff8X2gL9YvyHzX3bTGkgswRvoX2KPy6YIAV3hdhHyvDp86y8
   QF3Chxo117JvqIBvQ0SWM15+Fwxv8QdPk4VJ71weGrVW8YiT4vvBoNtP6
   /zVntTJF2J0fAcRfUSRTQOWU8y61Op+1Z1IjrJ8vzk3a+UrhlsF/gqfvZ
   Bx+68YAXKBFebGCtUIIh03h6pORoSUAVLUbjsR4z2szl90d6tc7YFQrb9
   niDDh9y/Kn/wkNyAnl4Rw27RGe7UuGLrGTtZyI9mkz5JERnKMA1rKE412
   8JYLZH5CeCaSaaEMV2ItfVwZjshNNtjNc5yOT+g9RMoz1zz2WYBiHQJDs
   g==;
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="216048426"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Jun 2023 08:56:44 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 14 Jun 2023 08:56:07 -0700
Received: from daire-X570.emdalo.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Wed, 14 Jun 2023 08:56:05 -0700
From:   <daire.mcnamara@microchip.com>
To:     <conor.dooley@microchip.com>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC:     Daire McNamara <daire.mcnamara@microchip.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v1 3/8] PCI: microchip: enable building this driver as a module
Date:   Wed, 14 Jun 2023 16:55:51 +0100
Message-ID: <20230614155556.4095526-4-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230614155556.4095526-1-daire.mcnamara@microchip.com>
References: <20230614155556.4095526-1-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

Enable building this driver as a module. The expected use case is the
driver is built as a module, is installed when needed, and cannot be
removed once installed.

The remove() callback is not implemented as removing a driver with
INTx and MSI interrupt handling is inherently unsafe.

Link: https://lore.kernel.org/linux-pci/87y1wgbah8.wl-maz@kernel.org/
Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/pci/controller/Kconfig               | 2 +-
 drivers/pci/controller/pcie-microchip-host.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 8d49bad7f847..f4ad0e9cca45 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -217,7 +217,7 @@ config PCIE_MT7621
 	  This selects a driver for the MediaTek MT7621 PCIe Controller.
 
 config PCIE_MICROCHIP_HOST
-	bool "Microchip AXI PCIe controller"
+	tristate "Microchip AXI PCIe controller"
 	depends on PCI_MSI && OF
 	select PCI_HOST_COMMON
 	help
diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
index 73046bad1521..5efd480e42fa 100644
--- a/drivers/pci/controller/pcie-microchip-host.c
+++ b/drivers/pci/controller/pcie-microchip-host.c
@@ -1141,5 +1141,6 @@ static struct platform_driver mc_pcie_driver = {
 };
 
 builtin_platform_driver(mc_pcie_driver);
+MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Microchip PCIe host controller driver");
 MODULE_AUTHOR("Daire McNamara <daire.mcnamara@microchip.com>");
-- 
2.25.1


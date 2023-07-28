Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D11766DE6
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jul 2023 15:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236364AbjG1NOO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jul 2023 09:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233825AbjG1NOL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Jul 2023 09:14:11 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93623A96
        for <linux-pci@vger.kernel.org>; Fri, 28 Jul 2023 06:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690550050; x=1722086050;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1wJYS/t9aNrnjqOOsSV5jOkrGngLW9L3uxJDr/wqxEA=;
  b=eZJQHQXfjcaaqIxMdrOvNzqLk6RutHC7CshQrjvsjTNrls9NY9lZOiWi
   Y5pzWrOalzEu1aaRUYN9hk6rSqh6nRwu0OR/es3bEY/6uYsRv0Apwt6J9
   B38GER//bZQ9r3SKr48zaQhQVqMwfuOZBGxptJLkTsh+HUpsHcOus4f0T
   7MdbgqX2zQyQYiTDEcMeiqsNw8cVQizMiF3kLmS/z7UyxXEK6G6BP6Mrr
   3DA1viRxqRBbzy15Bgw6fLztE/sqLLFHhf/lfQ+2pR7/IwuyxDUq0tBzS
   d/EYVIBwDf23jb9mBmfuWCSAAhv+myr8wKN+RZBVudg5mLkvhgKkT55Oz
   w==;
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="238431506"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jul 2023 06:14:10 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 28 Jul 2023 06:14:10 -0700
Received: from daire-X570.amer.actel.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 28 Jul 2023 06:14:08 -0700
From:   <daire.mcnamara@microchip.com>
To:     <conor.dooley@microchip.com>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <linux-riscv@lists.infradead.org>, <linux-pci@vger.kernel.org>
CC:     Daire McNamara <daire.mcnamara@microchip.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v3 2/7] PCI: microchip: Enable building driver as a module
Date:   Fri, 28 Jul 2023 14:13:56 +0100
Message-ID: <20230728131401.1615724-3-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230728131401.1615724-1-daire.mcnamara@microchip.com>
References: <20230728131401.1615724-1-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

Enable building driver as a module. The expected use case is the
driver is built as a module, is installed when needed, and cannot be
removed once installed.

The driver has .suppress_bind_attrs set to true.

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
index dd5245904c87..5c89caaab8c9 100644
--- a/drivers/pci/controller/pcie-microchip-host.c
+++ b/drivers/pci/controller/pcie-microchip-host.c
@@ -1135,5 +1135,6 @@ static struct platform_driver mc_pcie_driver = {
 };
 
 builtin_platform_driver(mc_pcie_driver);
+MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Microchip PCIe host controller driver");
 MODULE_AUTHOR("Daire McNamara <daire.mcnamara@microchip.com>");
-- 
2.25.1


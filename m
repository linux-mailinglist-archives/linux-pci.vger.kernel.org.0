Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC03966165E
	for <lists+linux-pci@lfdr.de>; Sun,  8 Jan 2023 16:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjAHP6X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 8 Jan 2023 10:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjAHP6V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 8 Jan 2023 10:58:21 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C67BCB8;
        Sun,  8 Jan 2023 07:58:20 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 308Fvxd8086520;
        Sun, 8 Jan 2023 09:57:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1673193479;
        bh=RXQWbFwTRI1d7toE/Mabr2p1LXDd7wglaC5Brhy3z1g=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Bka8Ckn/MgejWPxM9xHg/PUtPR4BzaCYpGB/wU/H8o9M9BtReaQ6KhE+jhIgABbZG
         4arHu6xxkrFEiSGVvQvyRiGuegryfd4Cz0j3L0P/H+/VjEgJsMcSVeraYO8GAxVPJy
         3hGrFYQZluWT1xguhCIbpgoXmOlXSW8vhiTotW0U=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 308FvxEc072677
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 8 Jan 2023 09:57:59 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Sun, 8
 Jan 2023 09:57:59 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Sun, 8 Jan 2023 09:57:59 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 308FvwCv097922;
        Sun, 8 Jan 2023 09:57:58 -0600
From:   Achal Verma <a-verma1@ti.com>
To:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Achal Verma <a-verma1@ti.com>,
        Milind Parab <mparab@cadence.com>
Subject: [PATCH v2 2/2] PCI: j721e: Add support to build pci-j721e as module.
Date:   Sun, 8 Jan 2023 21:27:55 +0530
Message-ID: <20230108155755.2614147-3-a-verma1@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230108155755.2614147-1-a-verma1@ti.com>
References: <20230108155755.2614147-1-a-verma1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support to build pci-j721e as module.

Signed-off-by: Achal Verma <a-verma1@ti.com>
---
 drivers/pci/controller/cadence/Kconfig     | 10 +++++-----
 drivers/pci/controller/cadence/pci-j721e.c |  6 +++++-
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
index 693c41fe32ce..51edf723586c 100644
--- a/drivers/pci/controller/cadence/Kconfig
+++ b/drivers/pci/controller/cadence/Kconfig
@@ -43,12 +43,13 @@ config PCIE_CADENCE_PLAT_EP
 	  different vendors SoCs.
 
 config PCI_J721E
-	bool
+	tristate
+	select PCIE_CADENCE_HOST
+	select PCIE_CADENCE_EP
 
 config PCI_J721E_HOST
-	bool "TI J721E PCIe platform host controller"
+	tristate "TI J721E PCIe platform host controller"
 	depends on OF
-	select PCIE_CADENCE_HOST
 	select PCI_J721E
 	help
 	  Say Y here if you want to support the TI J721E PCIe platform
@@ -56,10 +57,9 @@ config PCI_J721E_HOST
 	  core.
 
 config PCI_J721E_EP
-	bool "TI J721E PCIe platform endpoint controller"
+	tristate "TI J721E PCIe platform endpoint controller"
 	depends on OF
 	depends on PCI_ENDPOINT
-	select PCIE_CADENCE_EP
 	select PCI_J721E
 	help
 	  Say Y here if you want to support the TI J721E PCIe platform
diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index cc83a8925ce0..c4017fa6ae61 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -13,6 +13,7 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/mfd/syscon.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/pci.h>
@@ -565,4 +566,7 @@ static struct platform_driver j721e_pcie_driver = {
 		.suppress_bind_attrs = true,
 	},
 };
-builtin_platform_driver(j721e_pcie_driver);
+module_platform_driver(j721e_pcie_driver);
+
+MODULE_AUTHOR("Kishon Vijay Abraham I <kishon@ti.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.25.1


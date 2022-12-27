Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFF4656981
	for <lists+linux-pci@lfdr.de>; Tue, 27 Dec 2022 11:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbiL0KmR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Dec 2022 05:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiL0KmQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Dec 2022 05:42:16 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E081DD7B;
        Tue, 27 Dec 2022 02:42:14 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2BRAfwDe043730;
        Tue, 27 Dec 2022 04:41:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1672137718;
        bh=MUAVMn74IGXYLv7Q++PQxdFGnFfhRT4Sr3sH7enrpNA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=vBHHD6WqfoaJLLLY67B3L5ch54N7XF//vCunanQ9pXA1KUHpGcf/QEDKOcYXeTiPq
         iC+3pHS4HbLphA6cpnmAdMHMyZaz8iyQnG+FDoldDoHzZzirpNCJ5/PS1SG+6OZia4
         SmfSJUVpjqZwQx0P6889NzSg+k8G01M1lfRUvJoA=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2BRAfwww005331
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Dec 2022 04:41:58 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 27
 Dec 2022 04:41:58 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 27 Dec 2022 04:41:58 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2BRAfvhm085478;
        Tue, 27 Dec 2022 04:41:58 -0600
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
Subject: [PATCH 2/2] PCI: j721e: Add support to build pci-j721e as module.
Date:   Tue, 27 Dec 2022 16:11:54 +0530
Message-ID: <20221227104154.1022426-3-a-verma1@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221227104154.1022426-1-a-verma1@ti.com>
References: <20221227104154.1022426-1-a-verma1@ti.com>
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
 drivers/pci/controller/cadence/Kconfig     | 6 +++---
 drivers/pci/controller/cadence/pci-j721e.c | 6 +++++-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
index 693c41fe32ce..54464c9b3b29 100644
--- a/drivers/pci/controller/cadence/Kconfig
+++ b/drivers/pci/controller/cadence/Kconfig
@@ -43,10 +43,10 @@ config PCIE_CADENCE_PLAT_EP
 	  different vendors SoCs.
 
 config PCI_J721E
-	bool
+	tristate
 
 config PCI_J721E_HOST
-	bool "TI J721E PCIe platform host controller"
+	tristate "TI J721E PCIe platform host controller"
 	depends on OF
 	select PCIE_CADENCE_HOST
 	select PCI_J721E
@@ -56,7 +56,7 @@ config PCI_J721E_HOST
 	  core.
 
 config PCI_J721E_EP
-	bool "TI J721E PCIe platform endpoint controller"
+	tristate "TI J721E PCIe platform endpoint controller"
 	depends on OF
 	depends on PCI_ENDPOINT
 	select PCIE_CADENCE_EP
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


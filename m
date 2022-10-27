Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31AAD60F2F3
	for <lists+linux-pci@lfdr.de>; Thu, 27 Oct 2022 10:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbiJ0I5i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Oct 2022 04:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233815AbiJ0I5h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Oct 2022 04:57:37 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA31CCABCF;
        Thu, 27 Oct 2022 01:57:36 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29R8vNHe012991;
        Thu, 27 Oct 2022 03:57:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666861043;
        bh=gFm8sp5qf1A44g2gxMYqAMGX+E0SVtEIzHzqkRWo0No=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=O2HbS3KP16Z42F1Ss5oASFT6z5Uf7Yhj7kVSPDrzXSbuP7htGC9EieYhDKxkVTr4c
         59pwnI9HXNxiru1GNhZRSOdgwF0JYsWflwJKd64FSS2OJTxzURxVGvavxJuMVoa2UV
         0n2k1GH9EcQUMncoFkTDKc1fGh08IiPsuphWvak4=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29R8vNL2006154
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Oct 2022 03:57:23 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 27
 Oct 2022 03:57:22 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 27 Oct 2022 03:57:22 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29R8vLos082245;
        Thu, 27 Oct 2022 03:57:22 -0500
From:   Achal Verma <a-verma1@ti.com>
To:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Achal Verma <a-verma1@ti.com>,
        Milind Parab <mparab@cadence.com>
Subject: [PATCH 2/2] PCI: j721e: Add support to build pci-j721e as module.
Date:   Thu, 27 Oct 2022 14:27:18 +0530
Message-ID: <20221027085718.291510-3-a-verma1@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221027085718.291510-1-a-verma1@ti.com>
References: <20221027085718.291510-1-a-verma1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index a82f845cc4b5..48c6e5b8da53 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -13,6 +13,7 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/mfd/syscon.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
@@ -566,4 +567,7 @@ static struct platform_driver j721e_pcie_driver = {
 		.suppress_bind_attrs = true,
 	},
 };
-builtin_platform_driver(j721e_pcie_driver);
+module_platform_driver(j721e_pcie_driver);
+
+MODULE_AUTHOR("Kishon Vijay Abraham I <kishon@ti.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1


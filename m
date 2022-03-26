Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFA44E7EC6
	for <lists+linux-pci@lfdr.de>; Sat, 26 Mar 2022 04:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbiCZD3U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Mar 2022 23:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiCZD3S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Mar 2022 23:29:18 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8089515E8BF;
        Fri, 25 Mar 2022 20:27:41 -0700 (PDT)
X-UUID: 0e9932cd26824c4883750dfecb4a2a30-20220326
X-UUID: 0e9932cd26824c4883750dfecb4a2a30-20220326
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 121017082; Sat, 26 Mar 2022 11:27:35 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 26 Mar 2022 11:27:34 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 26 Mar 2022 11:27:33 +0800
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] PCI: mediatek: Update entries to distinguish MediaTek PCIe controller
Date:   Sat, 26 Mar 2022 11:27:08 +0800
Message-ID: <20220326032708.3626-1-jianjun.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add model numbers in Kconfig and update driver name in
pcie-mediatek-gen3.c to distinguish the MediaTek PCIe controllers.

Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
---
 drivers/pci/controller/Kconfig              | 11 +++++++----
 drivers/pci/controller/pcie-mediatek-gen3.c | 12 ++++++------
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 601f2531ee91..dd7a2caf8da9 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -237,8 +237,11 @@ config PCIE_MEDIATEK
 	depends on OF
 	depends on PCI_MSI_IRQ_DOMAIN
 	help
-	  Say Y here if you want to enable PCIe controller support on
-	  MediaTek SoCs.
+	  Adds support for PCIe MAC controller for MediaTek SoCs.
+
+	  The following SoCs are supported for this PCIe controller:
+	  MT2701 and MT7623 with no MSI supported.
+	  MT2712, MT7622 and MT7629 support up to 32 MSI interrupt numbers.
 
 config PCIE_MEDIATEK_GEN3
 	tristate "MediaTek Gen3 PCIe controller"
@@ -250,8 +253,8 @@ config PCIE_MEDIATEK_GEN3
 	  and support up to 256 MSI interrupt numbers for
 	  multi-function devices.
 
-	  Say Y here if you want to enable Gen3 PCIe controller support on
-	  MediaTek SoCs.
+	  The following SoCs are supported for this PCIe controller:
+	  MT8192 and MT8195.
 
 config VMD
 	depends on PCI_MSI && X86_64 && SRCU && !UML
diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 7705d61fba4c..6745076a02b9 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -1011,21 +1011,21 @@ static const struct dev_pm_ops mtk_pcie_pm_ops = {
 				      mtk_pcie_resume_noirq)
 };
 
-static const struct of_device_id mtk_pcie_of_match[] = {
+static const struct of_device_id mtk_pcie_gen3_of_match[] = {
 	{ .compatible = "mediatek,mt8192-pcie" },
 	{},
 };
-MODULE_DEVICE_TABLE(of, mtk_pcie_of_match);
+MODULE_DEVICE_TABLE(of, mtk_pcie_gen3_of_match);
 
-static struct platform_driver mtk_pcie_driver = {
+static struct platform_driver mtk_pcie_driver_gen3 = {
 	.probe = mtk_pcie_probe,
 	.remove = mtk_pcie_remove,
 	.driver = {
-		.name = "mtk-pcie",
-		.of_match_table = mtk_pcie_of_match,
+		.name = "mtk-pcie-gen3",
+		.of_match_table = mtk_pcie_gen3_of_match,
 		.pm = &mtk_pcie_pm_ops,
 	},
 };
 
-module_platform_driver(mtk_pcie_driver);
+module_platform_driver(mtk_pcie_driver_gen3);
 MODULE_LICENSE("GPL v2");
-- 
2.18.0


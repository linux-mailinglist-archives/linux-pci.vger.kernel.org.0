Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9264950B11E
	for <lists+linux-pci@lfdr.de>; Fri, 22 Apr 2022 09:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241054AbiDVHMO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Apr 2022 03:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiDVHMO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Apr 2022 03:12:14 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334E438DA7;
        Fri, 22 Apr 2022 00:09:20 -0700 (PDT)
X-UUID: 3cad76fe5ec3463e83bd949fb039c8cc-20220422
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:7ef536aa-c7c2-404c-981f-8fb8c2c424ed,OB:0,LO
        B:0,IP:0,URL:8,TC:0,Content:-20,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:-12
X-CID-META: VersionHash:faefae9,CLOUDID:efb1bfef-06b0-4305-bfbf-554bfc9d151a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 3cad76fe5ec3463e83bd949fb039c8cc-20220422
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1589918534; Fri, 22 Apr 2022 15:09:15 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 22 Apr 2022 15:09:14 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 22 Apr
 2022 15:09:12 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 22 Apr 2022 15:09:10 +0800
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2] PCI: mediatek-gen3: Update entries to distinguish MediaTek PCIe controller
Date:   Fri, 22 Apr 2022 15:09:08 +0800
Message-ID: <20220422070908.14043-1-jianjun.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Update driver entries in pcie-mediatek-gen3.c to distinguish the
MediaTek PCIe controllers.

Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
---
Changes in v2:
Remove the changes in Kconfig description and update the commit message.
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

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


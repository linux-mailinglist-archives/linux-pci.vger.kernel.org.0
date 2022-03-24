Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEF84E5F54
	for <lists+linux-pci@lfdr.de>; Thu, 24 Mar 2022 08:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347519AbiCXH1e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Mar 2022 03:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbiCXH1c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Mar 2022 03:27:32 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D50198F5A;
        Thu, 24 Mar 2022 00:26:00 -0700 (PDT)
X-UUID: 3d572a62549e4be9af2a25521a0c819d-20220324
X-UUID: 3d572a62549e4be9af2a25521a0c819d-20220324
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 616016198; Thu, 24 Mar 2022 15:25:55 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 24 Mar 2022 15:25:54 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 24 Mar
 2022 15:25:54 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 24 Mar 2022 15:25:53 +0800
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Ryder Lee <ryder.lee@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     Jianjun Wang <jianjun.wang@mediatek.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <jieyy.yang@mediatek.com>,
        <chuanjia.liu@mediatek.com>, <qizhong.cheng@mediatek.com>,
        <jian.yang@mediatek.com>
Subject: [PATCH] PCI: mediatek-gen3: Print LTSSM state when PCIe link down
Date:   Thu, 24 Mar 2022 15:25:48 +0800
Message-ID: <20220324072548.11408-1-jianjun.wang@mediatek.com>
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

Print current LTSSM state when PCIe link down instead of the register
value, make it easier to get the link status.

Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 40 ++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 7705d61fba4c..54663f025e27 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -153,6 +153,37 @@ struct mtk_gen3_pcie {
 	DECLARE_BITMAP(msi_irq_in_use, PCIE_MSI_IRQS_NUM);
 };
 
+/* LTSSM state in PCIE_LTSSM_STATUS_REG bit[28:24] */
+static const char *const ltssm_str[] = {
+	"detect.quiet",			/* 0x00 */
+	"detect.active",		/* 0x01 */
+	"polling.active",		/* 0x02 */
+	"polling.compliance",		/* 0x03 */
+	"polling.configuration",	/* 0x04 */
+	"config.linkwidthstart",	/* 0x05 */
+	"config.linkwidthaccept",	/* 0x06 */
+	"config.lanenumwait",		/* 0x07 */
+	"config.lanenumaccept",		/* 0x08 */
+	"config.complete",		/* 0x09 */
+	"config.idle",			/* 0x0A */
+	"recovery.receiverlock",	/* 0x0B */
+	"recovery.equalization",	/* 0x0C */
+	"recovery.speed",		/* 0x0D */
+	"recovery.receiverconfig",	/* 0x0E */
+	"recovery.idle",		/* 0x0F */
+	"L0",				/* 0x10 */
+	"L0s",				/* 0x11 */
+	"L1.entry",			/* 0x12 */
+	"L1.idle",			/* 0x13 */
+	"L2.idle",			/* 0x14 */
+	"L2.transmitwake",		/* 0x15 */
+	"disable",			/* 0x16 */
+	"loopback.entry",		/* 0x17 */
+	"loopback.active",		/* 0x18 */
+	"loopback.exit",		/* 0x19 */
+	"hotreset",			/* 0x1A */
+};
+
 /**
  * mtk_pcie_config_tlp_header() - Configure a configuration TLP header
  * @bus: PCI bus to query
@@ -327,8 +358,15 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
 				 !!(val & PCIE_PORT_LINKUP), 20,
 				 PCI_PM_D3COLD_WAIT * USEC_PER_MSEC);
 	if (err) {
+		const char *ltssm_state;
+		int ltssm_index;
+
 		val = readl_relaxed(pcie->base + PCIE_LTSSM_STATUS_REG);
-		dev_err(pcie->dev, "PCIe link down, ltssm reg val: %#x\n", val);
+		ltssm_index = PCIE_LTSSM_STATE(val);
+		ltssm_state = ltssm_index >= ARRAY_SIZE(ltssm_str) ?
+			      "Unknown state" : ltssm_str[ltssm_index];
+		dev_err(pcie->dev, "PCIe link down, current ltssm state: %s\n",
+			ltssm_state);
 		return err;
 	}
 
-- 
2.18.0


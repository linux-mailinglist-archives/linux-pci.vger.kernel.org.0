Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F144EA5B6
	for <lists+linux-pci@lfdr.de>; Tue, 29 Mar 2022 05:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiC2DJK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Mar 2022 23:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiC2DJI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Mar 2022 23:09:08 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24FD23D585;
        Mon, 28 Mar 2022 20:07:24 -0700 (PDT)
X-UUID: 4ec0f3a111b64b12bd33f018795d3e71-20220329
X-UUID: 4ec0f3a111b64b12bd33f018795d3e71-20220329
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1172233676; Tue, 29 Mar 2022 11:07:20 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 29 Mar 2022 11:07:19 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 29 Mar 2022 11:07:16 +0800
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Ryder Lee <ryder.lee@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <jieyy.yang@mediatek.com>,
        <chuanjia.liu@mediatek.com>, <qizhong.cheng@mediatek.com>,
        <jian.yang@mediatek.com>
Subject: [PATCH v2] PCI: mediatek-gen3: Print LTSSM state when PCIe link down
Date:   Tue, 29 Mar 2022 11:07:15 +0800
Message-ID: <20220329030715.7975-1-jianjun.wang@mediatek.com>
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
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
Changes in v2:
Print both of the register value and the LTSSM state.
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 41 ++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 6745076a02b9..c24e03c198b7 100644
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
@@ -327,8 +358,16 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
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
+		dev_err(pcie->dev,
+			"PCIe link down, current ltssm state: %s (%#x)\n",
+			ltssm_state, val);
 		return err;
 	}
 
-- 
2.18.0


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8093B7BED
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jun 2021 04:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbhF3Cwb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Jun 2021 22:52:31 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:43464 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232922AbhF3Cw2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jun 2021 22:52:28 -0400
X-UUID: 7366555a74d84cbc81042b1fe9813542-20210630
X-UUID: 7366555a74d84cbc81042b1fe9813542-20210630
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 926979926; Wed, 30 Jun 2021 10:49:56 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 30 Jun 2021 10:49:55 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 30 Jun 2021 10:49:53 +0800
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        <youlin.pei@mediatek.com>, <chuanjia.liu@mediatek.com>,
        <qizhong.cheng@mediatek.com>, <ot_jieyang@mediatek.com>,
        <drinkcat@chromium.org>, <Rex-BC.Chen@mediatek.com>,
        Krzysztof Wilczyski <kw@linux.com>, <Ryan-JH.Yu@mediatek.com>
Subject: [PATCH v3 2/2] PCI: mediatek-gen3: Add support for disable dvfsrc voltage request
Date:   Wed, 30 Jun 2021 10:49:34 +0800
Message-ID: <20210630024934.18903-3-jianjun.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210630024934.18903-1-jianjun.wang@mediatek.com>
References: <20210630024934.18903-1-jianjun.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe Gen3 PHY layer cannot work properly when the requested voltage
is lower than a specific level(e.g. 0.55V, it's depends on
the chip manufacturing process).

When the dvfsrc feature is implemented, the requested voltage
may be reduced to a lower level in suspend mode, hence that
the MAC layer will assert a HW signal to request the dvfsrc
to raise voltage to normal mode, and it will wait the voltage
ready signal from dvfsrc to decide if the LTSSM can start normally.

When the dvfsrc feature is not implemented, the MAC layer still
assert the voltage request to dvfsrc when exit suspend mode,
but will not receive the voltage ready signal, in this case,
the LTSSM cannot start normally, and the PCIe link will be failed.

Add support for disable dvfsrc voltage request, if the property of
"disable-dvfsrc-vlt-req" is presented in device node, we assume that
the requested voltage is always higher enough to keep the PCIe Gen3
PHY active, and the voltage request to dvfsrc should be disabled.

Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 31 +++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 3c5b97716d40..028014707588 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -79,6 +79,9 @@
 #define PCIE_ICMD_PM_REG		0x198
 #define PCIE_TURN_OFF_LINK		BIT(4)
 
+#define PCIE_MISC_CTRL_REG		0x348
+#define PCIE_DISABLE_DVFSRC_VLT_REQ	BIT(1)
+
 #define PCIE_TRANS_TABLE_BASE_REG	0x800
 #define PCIE_ATR_SRC_ADDR_MSB_OFFSET	0x4
 #define PCIE_ATR_TRSL_ADDR_LSB_OFFSET	0x8
@@ -297,6 +300,34 @@ static int mtk_pcie_startup_port(struct mtk_pcie_port *port)
 	val &= ~PCIE_INTX_ENABLE;
 	writel_relaxed(val, port->base + PCIE_INT_ENABLE_REG);
 
+	/*
+	 * PCIe Gen3 PHY layer can not work properly when the requested voltage
+	 * is lower than a specific level(e.g. 0.55V, it's depends on
+	 * the chip manufacturing process).
+	 *
+	 * When the dvfsrc feature is implemented, the requested voltage
+	 * might be reduced to a lower level in suspend mode, hence that
+	 * the MAC layer will assert a HW signal to request the dvfsrc
+	 * to raise voltage to normal mode, and it will wait the voltage
+	 * ready signal from dvfsrc to start the LTSSM normally.
+	 *
+	 * When the dvfsrc feature is not implemented, the MAC layer still
+	 * assert the voltage request to dvfsrc when exit suspend mode,
+	 * but will not get the voltage ready signal, in this case, the LTSSM
+	 * cannot start normally, and the PCIe link will be failed.
+	 *
+	 * If the property of "disable-dvfsrc-vlt-req" is presented
+	 * in device node, we assume that the requested voltage is always
+	 * higher enough to keep the PCIe Gen3 PHY active, and the voltage
+	 * request to dvfsrc should be disabled.
+	 */
+	val = readl_relaxed(port->base + PCIE_MISC_CTRL_REG);
+	val &= ~PCIE_DISABLE_DVFSRC_VLT_REQ;
+	if (of_property_read_bool(port->dev->of_node, "disable-dvfsrc-vlt-req"))
+		val |= PCIE_DISABLE_DVFSRC_VLT_REQ;
+
+	writel_relaxed(val, port->base + PCIE_MISC_CTRL_REG);
+
 	/* Assert all reset signals */
 	val = readl_relaxed(port->base + PCIE_RST_CTRL_REG);
 	val |= PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB | PCIE_PE_RSTB;
-- 
2.18.0


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA293A4175
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jun 2021 13:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbhFKLum (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Jun 2021 07:50:42 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:46616 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231515AbhFKLul (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Jun 2021 07:50:41 -0400
X-UUID: e7a8619f62b14f6e928aa38f597d859f-20210611
X-UUID: e7a8619f62b14f6e928aa38f597d859f-20210611
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1610950520; Fri, 11 Jun 2021 19:48:39 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 11 Jun 2021 19:48:38 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 11 Jun 2021 19:48:37 +0800
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        <youlin.pei@mediatek.com>, <chuanjia.liu@mediatek.com>,
        <qizhong.cheng@mediatek.com>, <sin_jieyang@mediatek.com>,
        <drinkcat@chromium.org>, <Rex-BC.Chen@mediatek.com>,
        Krzysztof Wilczyski <kw@linux.com>, <Ryan-JH.Yu@mediatek.com>
Subject: [PATCH v2 2/2] PCI: mediatek-gen3: Add support for disable dvfsrc voltage request
Date:   Fri, 11 Jun 2021 19:48:24 +0800
Message-ID: <20210611114824.14537-3-jianjun.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210611114824.14537-1-jianjun.wang@mediatek.com>
References: <20210611114824.14537-1-jianjun.wang@mediatek.com>
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
Reviewed-by: Qizhong Cheng <qizhong.cheng@mediatek.com>
Tested-by: Qizhong Cheng <qizhong.cheng@mediatek.com>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 31 +++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 3c5b97716d40..b3e442bc4c8f 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -68,6 +68,9 @@
 #define PCIE_MSI_SET_ENABLE_REG		0x190
 #define PCIE_MSI_SET_ENABLE		GENMASK(PCIE_MSI_SET_NUM - 1, 0)
 
+#define PCIE_MISC_CTRL_REG		0x348
+#define PCIE_DISABLE_DVFSRC_VLT_REQ	BIT(1)
+
 #define PCIE_MSI_SET_BASE_REG		0xc00
 #define PCIE_MSI_SET_OFFSET		0x10
 #define PCIE_MSI_SET_STATUS_OFFSET	0x04
@@ -297,6 +300,34 @@ static int mtk_pcie_startup_port(struct mtk_pcie_port *port)
 	val &= ~PCIE_INTX_ENABLE;
 	writel_relaxed(val, port->base + PCIE_INT_ENABLE_REG);
 
+	/*
+	 * PCIe Gen3 PHY layer can not work properly when the requested voltage
+	 * is lower than a specific level(e.g. 0.55V, it's depends on
+	 * the chip manufacturing process).
+	 *
+	 * When the dvfsrc feature is implemented, the requested voltage
+	 * may be reduced to a lower level in suspend mode, hence that
+	 * the MAC layer will assert a HW signal to request the dvfsrc
+	 * to raise voltage to normal mode, and it will wait the voltage
+	 * ready signal from dvfsrc to decide if the LTSSM can start normally.
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
2.25.1


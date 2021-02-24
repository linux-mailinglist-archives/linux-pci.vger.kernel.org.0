Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 495D4323737
	for <lists+linux-pci@lfdr.de>; Wed, 24 Feb 2021 07:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbhBXGNf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Feb 2021 01:13:35 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:34615 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230234AbhBXGNU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Feb 2021 01:13:20 -0500
X-UUID: 0070d911e420495ba96d4b23f3a67225-20210224
X-UUID: 0070d911e420495ba96d4b23f3a67225-20210224
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1529753573; Wed, 24 Feb 2021 14:12:35 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 24 Feb 2021 14:12:34 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 24 Feb 2021 14:12:33 +0800
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Sj Huang <sj.huang@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        <youlin.pei@mediatek.com>, <chuanjia.liu@mediatek.com>,
        <qizhong.cheng@mediatek.com>, <sin_jieyang@mediatek.com>,
        <drinkcat@chromium.org>, <Rex-BC.Chen@mediatek.com>,
        <anson.chuang@mediatek.com>
Subject: [v8,6/7] PCI: mediatek-gen3: Add system PM support
Date:   Wed, 24 Feb 2021 14:11:31 +0800
Message-ID: <20210224061132.26526-7-jianjun.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210224061132.26526-1-jianjun.wang@mediatek.com>
References: <20210224061132.26526-1-jianjun.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add suspend_noirq and resume_noirq callback functions to implement
PM system suspend hooks for MediaTek Gen3 PCIe controller.

When system suspend, trigger the PCIe link to L2 state and pull down
the PERST# pin, gating the clocks of MAC layer and power off the
physical layer for the sake of power saving.

When system resum, the PCIe link should be re-established and the
related control register values should be restored.

Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
Acked-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 84 +++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index fde9de591888..fd13540d37fe 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -45,6 +45,9 @@
 #define PCIE_PE_RSTB			BIT(3)
 
 #define PCIE_LTSSM_STATUS_REG		0x150
+#define PCIE_LTSSM_STATE_MASK		GENMASK(28, 24)
+#define PCIE_LTSSM_STATE(val)		((val & PCIE_LTSSM_STATE_MASK) >> 24)
+#define PCIE_LTSSM_STATE_L2_IDLE	0x14
 
 #define PCIE_LINK_STATUS_REG		0x154
 #define PCIE_PORT_LINKUP		BIT(8)
@@ -73,6 +76,9 @@
 #define PCIE_MSI_SET_ADDR_HI_BASE	0xc80
 #define PCIE_MSI_SET_ADDR_HI_OFFSET	0x04
 
+#define PCIE_ICMD_PM_REG		0x198
+#define PCIE_TURN_OFF_LINK		BIT(4)
+
 #define PCIE_TRANS_TABLE_BASE_REG	0x800
 #define PCIE_ATR_SRC_ADDR_MSB_OFFSET	0x4
 #define PCIE_ATR_TRSL_ADDR_LSB_OFFSET	0x8
@@ -892,6 +898,83 @@ static int mtk_pcie_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused mtk_pcie_turn_off_link(struct mtk_pcie_port *port)
+{
+	u32 val;
+
+	val = readl_relaxed(port->base + PCIE_ICMD_PM_REG);
+	val |= PCIE_TURN_OFF_LINK;
+	writel_relaxed(val, port->base + PCIE_ICMD_PM_REG);
+
+	/* Check the link is L2 */
+	return readl_poll_timeout(port->base + PCIE_LTSSM_STATUS_REG, val,
+				  (PCIE_LTSSM_STATE(val) ==
+				   PCIE_LTSSM_STATE_L2_IDLE), 20,
+				   50 * USEC_PER_MSEC);
+}
+
+static int __maybe_unused mtk_pcie_suspend_noirq(struct device *dev)
+{
+	struct mtk_pcie_port *port = dev_get_drvdata(dev);
+	int err;
+	u32 val;
+
+	/* Trigger link to L2 state */
+	err = mtk_pcie_turn_off_link(port);
+	if (err) {
+		dev_err(port->dev, "can not enter L2 state\n");
+		return err;
+	}
+
+	/* Pull down the PERST# pin */
+	val = readl_relaxed(port->base + PCIE_RST_CTRL_REG);
+	val |= PCIE_PE_RSTB;
+	writel_relaxed(val, port->base + PCIE_RST_CTRL_REG);
+
+	dev_dbg(port->dev, "enter L2 state success");
+
+	clk_bulk_disable_unprepare(port->num_clks, port->clks);
+
+	reset_control_assert(port->mac_reset);
+
+	phy_power_off(port->phy);
+	reset_control_assert(port->phy_reset);
+
+	return 0;
+}
+
+static int __maybe_unused mtk_pcie_resume_noirq(struct device *dev)
+{
+	struct mtk_pcie_port *port = dev_get_drvdata(dev);
+	int err;
+
+	reset_control_deassert(port->phy_reset);
+	phy_power_on(port->phy);
+
+	reset_control_deassert(port->mac_reset);
+
+	err = clk_bulk_prepare_enable(port->num_clks, port->clks);
+	if (err) {
+		dev_dbg(dev, "failed to enable PCIe clocks\n");
+		return err;
+	}
+
+	err = mtk_pcie_startup_port(port);
+	if (err) {
+		dev_err(port->dev, "resume failed\n");
+		return err;
+	}
+
+	dev_dbg(port->dev, "resume done\n");
+
+	return 0;
+}
+
+static const struct dev_pm_ops mtk_pcie_pm_ops = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(mtk_pcie_suspend_noirq,
+				      mtk_pcie_resume_noirq)
+};
+
 static const struct of_device_id mtk_pcie_of_match[] = {
 	{ .compatible = "mediatek,mt8192-pcie" },
 	{},
@@ -903,6 +986,7 @@ static struct platform_driver mtk_pcie_driver = {
 	.driver = {
 		.name = "mtk-pcie",
 		.of_match_table = mtk_pcie_of_match,
+		.pm = &mtk_pcie_pm_ops,
 	},
 };
 
-- 
2.25.1


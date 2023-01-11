Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58956665250
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jan 2023 04:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjAKD02 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Jan 2023 22:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235140AbjAKD0W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jan 2023 22:26:22 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C012DF19;
        Tue, 10 Jan 2023 19:26:17 -0800 (PST)
X-UUID: b43e3bce915f11eda06fc9ecc4dadd91-20230111
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=mbHqNJkSdR1rCR9KdCc2/hI6jI6Bavtsh5EvXljRiSY=;
        b=Yyt9KLWoTR957uQaMxj3N+z0wARJDwemIejKu7atqV+tLagg0wcHErtlbbsPw/mQP4cbSYOfzzEssGyyDQjn/BHWDlR+M20sfRi7hRswLmJamZFfvUnTMbsUwQGyQwXPnahYvDKGNHU0I4JczcQQneFs7oZntmfN/K8UMHOvfSA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:01b2d061-dd8a-4f74-b8b4-78af5d8d2350,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:543e81c,CLOUDID:2f194c54-dd49-462e-a4be-2143a3ddc739,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0
X-UUID: b43e3bce915f11eda06fc9ecc4dadd91-20230111
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <jian.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 152184516; Wed, 11 Jan 2023 11:26:15 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 11 Jan 2023 11:26:13 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 11 Jan 2023 11:26:12 +0800
From:   Jian Yang <jian.yang@mediatek.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
CC:     <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <jian.yang@mediatek.com>, <chuanjia.liu@mediatek.com>,
        <jieyy.yang@mediatek.com>, <qizhong.cheng@mediatek.com>,
        <rex-bc.chen@mediatek.com>, <david-yh.chiu@mediatek.com>
Subject: [PATCH 1/2] PCI: mediatek-gen3: Add power and reset control feature for downstream component
Date:   Wed, 11 Jan 2023 11:25:41 +0800
Message-ID: <20230111032542.20306-2-jian.yang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230111032542.20306-1-jian.yang@mediatek.com>
References: <20230111032542.20306-1-jian.yang@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: "jian.yang" <jian.yang@mediatek.com>

Make MediaTek's controller driver capable of controlling power
supplies and reset pin of a downstream component in power-on and
power-off flow.

Some downstream components (e.g., a WIFI chip) may need an extra
reset other than of PERST# and their power supplies, depending on
the requirements of platform, may need to controlled by their
parent's driver. To meet the requirements described above, I add this
feature to MediaTek's PCIe controller driver as a optional feature.

Signed-off-by: jian.yang <jian.yang@mediatek.com>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 114 +++++++++++++++++++-
 1 file changed, 113 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index b8612ce5f4d0..5ddbc2a0c020 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -8,6 +8,8 @@
 
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/iopoll.h>
 #include <linux/irq.h>
 #include <linux/irqchip/chained_irq.h>
@@ -15,11 +17,13 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/msi.h>
+#include <linux/of_gpio.h>
 #include <linux/pci.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 
 #include "../pci.h"
@@ -100,6 +104,13 @@
 #define PCIE_ATR_TLP_TYPE_MEM		PCIE_ATR_TLP_TYPE(0)
 #define PCIE_ATR_TLP_TYPE_IO		PCIE_ATR_TLP_TYPE(2)
 
+/* Downstream Component power supplies used by MediaTek PCIe */
+static const char *const dsc_power_supplies[] = {
+	"pcie1v8",
+	"pcie3v3",
+	"pcie12v",
+};
+
 /**
  * struct mtk_msi_set - MSI information for each set
  * @base: IO mapped register base
@@ -122,6 +133,10 @@ struct mtk_msi_set {
  * @phy: PHY controller block
  * @clks: PCIe clocks
  * @num_clks: PCIe clocks count for this port
+ * @supplies: Downstream Component power supplies
+ * @num_supplies: Downstream Component power supplies count
+ * @dsc_reset: The GPIO pin to reset Downstream component
+ * @dsc_reset_delay_ms: Delay in ms before the deassertion of reset GPIO
  * @irq: PCIe controller interrupt number
  * @saved_irq_state: IRQ enable state saved at suspend time
  * @irq_lock: lock protecting IRQ register access
@@ -141,6 +156,10 @@ struct mtk_gen3_pcie {
 	struct phy *phy;
 	struct clk_bulk_data *clks;
 	int num_clks;
+	struct regulator_bulk_data *supplies;
+	int num_supplies;
+	struct gpio_desc *dsc_reset;
+	u32 dsc_reset_delay_ms;
 
 	int irq;
 	u32 saved_irq_state;
@@ -763,7 +782,9 @@ static int mtk_pcie_parse_port(struct mtk_gen3_pcie *pcie)
 	struct device *dev = pcie->dev;
 	struct platform_device *pdev = to_platform_device(dev);
 	struct resource *regs;
-	int ret;
+	enum of_gpio_flags flags;
+	enum gpiod_flags dsc_reset_init_flags;
+	int ret, i;
 
 	regs = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pcie-mac");
 	if (!regs)
@@ -809,14 +830,103 @@ static int mtk_pcie_parse_port(struct mtk_gen3_pcie *pcie)
 		return pcie->num_clks;
 	}
 
+	pcie->num_supplies = ARRAY_SIZE(dsc_power_supplies);
+	pcie->supplies = devm_kcalloc(dev, pcie->num_supplies,
+				      sizeof(*pcie->supplies),
+				      GFP_KERNEL);
+	if (!pcie->supplies)
+		return -ENOMEM;
+
+	for (i = 0; i < pcie->num_supplies; i++)
+		pcie->supplies[i].supply = dsc_power_supplies[i];
+
+	ret = devm_regulator_bulk_get(dev, pcie->num_supplies, pcie->supplies);
+	if (ret)
+		return ret;
+
+	ret = of_get_named_gpio_flags(dev->of_node, "dsc-reset-gpios", 0,
+				      &flags);
+	if (ret < 0) {
+		if (ret == -EPROBE_DEFER)
+			return ret;
+
+		/*
+		 * It's okay that the reset GPIO of a downstream component not
+		 * defined in related devicetree node since it's an optional
+		 * property.
+		 */
+		return 0;
+	}
+
+	dsc_reset_init_flags = (flags & OF_GPIO_ACTIVE_LOW) ? GPIOD_OUT_HIGH :
+			       GPIOD_OUT_LOW;
+	pcie->dsc_reset = devm_gpiod_get_optional(dev, "dsc-reset",
+						  dsc_reset_init_flags);
+	if (IS_ERR(pcie->dsc_reset)) {
+		ret = PTR_ERR(pcie->dsc_reset);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "failed to request DSC reset gpio\n");
+
+		return ret;
+	}
+
+	ret = of_property_read_u32(dev->of_node, "dsc-reset-msleep",
+				   &pcie->dsc_reset_delay_ms);
+	if (ret) {
+		dev_info(dev, "Failed to get delay time of DSC, set it to default 5ms\n");
+		pcie->dsc_reset_delay_ms = 5;
+	}
+
 	return 0;
 }
 
+static int mtk_pcie_dsc_power_up(struct mtk_gen3_pcie *pcie)
+{
+	struct device *dev = pcie->dev;
+	int ret;
+
+	/* Assert Downstream Component reset */
+	if (pcie->dsc_reset)
+		gpiod_set_value_cansleep(pcie->dsc_reset, 1);
+
+	ret = regulator_bulk_enable(pcie->num_supplies, pcie->supplies);
+	if (ret)
+		dev_err(dev, "failed to enable DSC power supplies: %d\n", ret);
+
+	/* De-assert Downstream Component reset */
+	if (pcie->dsc_reset) {
+		/*
+		 * Wait for a short time before we de-assert the reset GPIO.
+		 * Depends on the requirement of a specific Downstream
+		 * Component.
+		 */
+		usleep_range(1000 * pcie->dsc_reset_delay_ms,
+			     1000 * pcie->dsc_reset_delay_ms + 100);
+		gpiod_set_value_cansleep(pcie->dsc_reset, 0);
+	}
+
+	return ret;
+}
+
+static void mtk_pcie_dsc_power_down(struct mtk_gen3_pcie *pcie)
+{
+	/* Assert Downstream Component reset */
+	if (pcie->dsc_reset)
+		gpiod_set_value_cansleep(pcie->dsc_reset, 1);
+
+	regulator_bulk_disable(pcie->num_supplies, pcie->supplies);
+}
+
 static int mtk_pcie_power_up(struct mtk_gen3_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
 	int err;
 
+	/* Downstream Component power up before RC */
+	err = mtk_pcie_dsc_power_up(pcie);
+	if (err)
+		return err;
+
 	/* PHY power on and enable pipe clock */
 	reset_control_deassert(pcie->phy_reset);
 
@@ -855,6 +965,7 @@ static int mtk_pcie_power_up(struct mtk_gen3_pcie *pcie)
 	phy_exit(pcie->phy);
 err_phy_init:
 	reset_control_assert(pcie->phy_reset);
+	mtk_pcie_dsc_power_down(pcie);
 
 	return err;
 }
@@ -870,6 +981,7 @@ static void mtk_pcie_power_down(struct mtk_gen3_pcie *pcie)
 	phy_power_off(pcie->phy);
 	phy_exit(pcie->phy);
 	reset_control_assert(pcie->phy_reset);
+	mtk_pcie_dsc_power_down(pcie);
 }
 
 static int mtk_pcie_setup(struct mtk_gen3_pcie *pcie)
-- 
2.18.0


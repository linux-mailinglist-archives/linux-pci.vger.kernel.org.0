Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DA37B68A4
	for <lists+linux-pci@lfdr.de>; Tue,  3 Oct 2023 14:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjJCMJz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Oct 2023 08:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbjJCMJy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Oct 2023 08:09:54 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02678BF;
        Tue,  3 Oct 2023 05:09:50 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 393BOd8a032148;
        Tue, 3 Oct 2023 12:09:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=XxUO/qbrT5ElNvWaahYF67kV3a8t5H6ry31/gpptWUc=;
 b=cpmIzTdf2onTxVXxR3HR1leboaL9VpPFtL4gQLr21BucSn9buLvMVHDm7MWI8sEmR/hL
 y3kQbJSnYX4wj4bM6af8z8l4sxUlNkiDjLgod7mB8rdOuIvDKK/Ayn/N6bEznS9WCzjq
 5BerOReq09Zb7iuDvUbUlG01XfGCfP1+LBk6fmkbcyoLw9N2oEUJfd9xwI7tvxOKOGwI
 CAizGw0Lv5o3Njk7wxupfY+pQidaOzWxVjUQkuoXMlah9kBozVCbCwGtjWUxgrrpmVt9
 anfTDauDnZmVjkLbzMrjVYjP0AWA2JLkgrOQ4uMy/IOvW3h5xOTmWqqivnTXGZ1g76Bn vg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tg77es8rv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Oct 2023 12:09:37 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 393C9ZcI017389
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 3 Oct 2023 12:09:35 GMT
Received: from nsekar-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 3 Oct 2023 05:09:27 -0700
From:   Nitheesh Sekar <quic_nsekar@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <vkoul@kernel.org>, <kishon@kernel.org>, <mani@kernel.org>,
        <p.zabel@pengutronix.de>, <quic_nsekar@quicinc.com>,
        <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>,
        <quic_ipkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>
Subject: [PATCH 3/6] phy: qcom: Introduce PCIe UNIPHY 28LP driver
Date:   Tue, 3 Oct 2023 17:38:43 +0530
Message-ID: <20231003120846.28626-4-quic_nsekar@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231003120846.28626-1-quic_nsekar@quicinc.com>
References: <20231003120846.28626-1-quic_nsekar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: IPyUCgX5TdJhzppoSnldHwUoCzvCu-Gt
X-Proofpoint-GUID: IPyUCgX5TdJhzppoSnldHwUoCzvCu-Gt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_08,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxscore=0 bulkscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 spamscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310030087
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add Qualcomm PCIe UNIPHY 28LP driver support present
in Qualcomm IPQ5018 SoC and the phy init sequence.

Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
---
 drivers/phy/qualcomm/Kconfig                  |  12 +
 drivers/phy/qualcomm/Makefile                 |   1 +
 .../phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c  | 336 ++++++++++++++++++
 3 files changed, 349 insertions(+)
 create mode 100644 drivers/phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c

diff --git a/drivers/phy/qualcomm/Kconfig b/drivers/phy/qualcomm/Kconfig
index d891058b7c39..b7d37cd98f02 100644
--- a/drivers/phy/qualcomm/Kconfig
+++ b/drivers/phy/qualcomm/Kconfig
@@ -154,6 +154,18 @@ config PHY_QCOM_M31_USB
 	  management. This driver is required even for peripheral only or
 	  host only mode configurations.
 
+config PHY_QCOM_UNIPHY_PCIE_28LP
+	bool "PCIE UNIPHY 28LP PHY driver"
+	depends on ARCH_QCOM
+	depends on HAS_IOMEM
+	depends on OF
+	select GENERIC_PHY
+	help
+	  Enable this to support the PCIe UNIPHY 28LP phy transceiver that
+	  is used with PCIe controllers on Qualcomm IPQ5018 chips. It
+	  handles PHY initialization, clock management required after
+	  resetting the hardware and power management.
+
 config PHY_QCOM_USB_HS
 	tristate "Qualcomm USB HS PHY module"
 	depends on USB_ULPI_BUS
diff --git a/drivers/phy/qualcomm/Makefile b/drivers/phy/qualcomm/Makefile
index ffd609ac6233..31105cd17bc9 100644
--- a/drivers/phy/qualcomm/Makefile
+++ b/drivers/phy/qualcomm/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_PHY_QCOM_QMP_USB_LEGACY)	+= phy-qcom-qmp-usb-legacy.o
 obj-$(CONFIG_PHY_QCOM_QUSB2)		+= phy-qcom-qusb2.o
 obj-$(CONFIG_PHY_QCOM_SNPS_EUSB2)	+= phy-qcom-snps-eusb2.o
 obj-$(CONFIG_PHY_QCOM_EUSB2_REPEATER)	+= phy-qcom-eusb2-repeater.o
+obj-$(CONFIG_PHY_QCOM_UNIPHY_PCIE_28LP)	+= phy-qcom-uniphy-pcie-28lp.o
 obj-$(CONFIG_PHY_QCOM_USB_HS) 		+= phy-qcom-usb-hs.o
 obj-$(CONFIG_PHY_QCOM_USB_HSIC) 	+= phy-qcom-usb-hsic.o
 obj-$(CONFIG_PHY_QCOM_USB_HS_28NM)	+= phy-qcom-usb-hs-28nm.o
diff --git a/drivers/phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c b/drivers/phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c
new file mode 100644
index 000000000000..5ef6ae7276cf
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c
@@ -0,0 +1,336 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2023, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/phy/phy.h>
+#include <linux/reset.h>
+#include <linux/of_device.h>
+#include <linux/delay.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+
+#define PIPE_CLK_DELAY_MIN_US			5000
+#define PIPE_CLK_DELAY_MAX_US			5100
+#define CDR_CTRL_REG_1		0x80
+#define CDR_CTRL_REG_2		0x84
+#define CDR_CTRL_REG_3		0x88
+#define CDR_CTRL_REG_4		0x8C
+#define CDR_CTRL_REG_5		0x90
+#define CDR_CTRL_REG_6		0x94
+#define CDR_CTRL_REG_7		0x98
+#define SSCG_CTRL_REG_1		0x9c
+#define SSCG_CTRL_REG_2		0xa0
+#define SSCG_CTRL_REG_3		0xa4
+#define SSCG_CTRL_REG_4		0xa8
+#define SSCG_CTRL_REG_5		0xac
+#define SSCG_CTRL_REG_6		0xb0
+#define PCS_INTERNAL_CONTROL_2	0x2d8
+
+#define PHY_MODE_FIXED		0x1
+
+enum qcom_uniphy_pcie_type {
+	PHY_TYPE_PCIE = 1,
+	PHY_TYPE_PCIE_GEN2,
+	PHY_TYPE_PCIE_GEN3,
+};
+
+struct uniphy_regs {
+	unsigned int offset;
+	unsigned int val;
+};
+
+struct uniphy_pcie_data {
+	int lanes;
+	/* 2nd lane offset */
+	int lane_offset;
+	unsigned int phy_type;
+	const struct uniphy_regs *init_seq;
+	unsigned int init_seq_num;
+};
+
+struct qcom_uniphy_pcie {
+	struct phy phy;
+	struct device *dev;
+	const struct uniphy_pcie_data *data;
+	struct clk_bulk_data *clks;
+	int num_clks;
+	struct reset_control *resets;
+	void __iomem *base;
+};
+
+#define	phy_to_dw_phy(x)	container_of((x), struct qca_uni_pcie_phy, phy)
+
+static const struct uniphy_regs ipq5018_regs[] = {
+	{
+		.offset = SSCG_CTRL_REG_4,
+		.val = 0x1cb9,
+	},
+	{
+		.offset = SSCG_CTRL_REG_5,
+		.val = 0x023a,
+	},
+	{
+		.offset = SSCG_CTRL_REG_3,
+		.val = 0xd360,
+	},
+	{
+		.offset = SSCG_CTRL_REG_1,
+		.val = 0x1,
+	},
+	{
+		.offset = SSCG_CTRL_REG_2,
+		.val = 0xeb,
+	},
+	{
+		.offset = CDR_CTRL_REG_4,
+		.val = 0x3f9,
+	},
+	{
+		.offset = CDR_CTRL_REG_5,
+		.val = 0x1c9,
+	},
+	{
+		.offset = CDR_CTRL_REG_2,
+		.val = 0x419,
+	},
+	{
+		.offset = CDR_CTRL_REG_1,
+		.val = 0x200,
+	},
+	{
+		.offset = PCS_INTERNAL_CONTROL_2,
+		.val = 0xf101,
+	},
+};
+
+static const struct uniphy_pcie_data ipq5018_2x2_data = {
+	.lanes		= 2,
+	.lane_offset	= 0x800,
+	.phy_type	= PHY_TYPE_PCIE_GEN2,
+	.init_seq	= ipq5018_regs,
+	.init_seq_num	= ARRAY_SIZE(ipq5018_regs),
+};
+
+static void qcom_uniphy_pcie_init(struct qcom_uniphy_pcie *phy)
+{
+	const struct uniphy_pcie_data *data = phy->data;
+	const struct uniphy_regs *init_seq;
+	void __iomem *base = phy->base;
+	int lane = 0;
+	int i;
+
+	while (lane != data->lanes) {
+		init_seq = data->init_seq;
+
+		for (i = 0; i < data->init_seq_num; i++, init_seq++)
+			writel(init_seq->val, base + init_seq->offset);
+
+		if (data->lanes == 2)
+			base = base + data->lane_offset;
+
+		lane++;
+	}
+}
+
+static int qcom_uniphy_pcie_power_off(struct phy *x)
+{
+	struct qcom_uniphy_pcie *phy = phy_get_drvdata(x);
+
+	reset_control_assert(phy->resets);
+
+	clk_bulk_disable_unprepare(phy->num_clks, phy->clks);
+
+	return 0;
+}
+
+static int qcom_uniphy_pcie_power_on(struct phy *x)
+{
+	int ret;
+	struct qcom_uniphy_pcie *phy = phy_get_drvdata(x);
+
+	ret = reset_control_assert(phy->resets);
+	if (ret) {
+		dev_err(phy->dev, "reset assert failed (%d)\n", ret);
+		return ret;
+	}
+
+	/*
+	 * Delay periods before and after reset deassert are working values
+	 * from downstream Codeaurora kernel
+	 */
+	usleep_range(100, 150);
+
+	ret = reset_control_deassert(phy->resets);
+	if (ret) {
+		dev_err(phy->dev, "reset deassert failed (%d)\n", ret);
+		return ret;
+	}
+
+	usleep_range(PIPE_CLK_DELAY_MIN_US, PIPE_CLK_DELAY_MAX_US);
+
+	ret = clk_bulk_prepare_enable(phy->num_clks, phy->clks);
+	if (ret) {
+		dev_err(phy->dev, "clk prepare and enable failed %d\n", ret);
+		return ret;
+	}
+
+	usleep_range(30, 50);
+
+	qcom_uniphy_pcie_init(phy);
+	return 0;
+}
+
+static int qcom_uniphy_pcie_get_resources(struct platform_device *pdev,
+					  struct qcom_uniphy_pcie *phy)
+{
+	struct resource *res;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	phy->base = devm_ioremap_resource(phy->dev, res);
+	if (IS_ERR(phy->base)) {
+		dev_err(phy->dev, "cannot get phy registers\n");
+		return PTR_ERR(phy->base);
+	}
+
+	phy->num_clks = devm_clk_bulk_get_all(phy->dev, &phy->clks);
+	if (phy->num_clks < 0)
+		return phy->num_clks;
+
+	phy->resets = devm_reset_control_array_get_exclusive(phy->dev);
+	if (IS_ERR(phy->resets))
+		return PTR_ERR(phy->resets);
+
+	return 0;
+}
+
+/*
+ * Register a fixed rate pipe clock.
+ *
+ * The <s>_pipe_clksrc generated by PHY goes to the GCC that gate
+ * controls it. The <s>_pipe_clk coming out of the GCC is requested
+ * by the PHY driver for its operations.
+ * We register the <s>_pipe_clksrc here. The gcc driver takes care
+ * of assigning this <s>_pipe_clksrc as parent to <s>_pipe_clk.
+ * Below picture shows this relationship.
+ *
+ *         +---------------+
+ *         |   PHY block   |<<---------------------------------------+
+ *         |               |                                         |
+ *         |   +-------+   |                   +-----+               |
+ *   I/P---^-->|  PLL  |---^--->pipe_clksrc--->| GCC |--->pipe_clk---+
+ *    clk  |   +-------+   |                   +-----+
+ *         +---------------+
+ */
+static int phy_pipe_clk_register(struct qcom_uniphy_pcie  *phy,
+				 struct device_node *np)
+{
+	struct clk_fixed_rate *fixed;
+	struct clk_init_data init = { };
+	int ret;
+
+	ret = of_property_read_string(np, "clock-output-names", &init.name);
+	if (ret) {
+		dev_err(phy->dev, "%pOFn: No clock-output-names\n", np);
+		return ret;
+	}
+
+	fixed = devm_kzalloc(phy->dev, sizeof(*fixed), GFP_KERNEL);
+	if (!fixed)
+		return -ENOMEM;
+
+	init.ops = &clk_fixed_rate_ops;
+	fixed->fixed_rate = 125000000;
+	fixed->hw.init = &init;
+
+	ret = devm_clk_hw_register(phy->dev, &fixed->hw);
+	if (ret)
+		return ret;
+
+	ret = devm_of_clk_add_hw_provider(phy->dev, of_clk_hw_simple_get,
+					  &fixed->hw);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const struct of_device_id qcom_uniphy_pcie_id_table[] = {
+	{
+		.compatible = "qcom,ipq5018-uniphy-pcie-gen2x2",
+		.data = &ipq5018_2x2_data,
+	},
+	{ /* Sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, qcom_uniphy_pcie_id_table);
+
+static const struct phy_ops pcie_ops = {
+	.power_on	= qcom_uniphy_pcie_power_on,
+	.power_off	= qcom_uniphy_pcie_power_off,
+	.owner          = THIS_MODULE,
+};
+
+static int qcom_uniphy_pcie_probe(struct platform_device *pdev)
+{
+	struct qcom_uniphy_pcie *phy;
+	int ret;
+	struct phy *generic_phy;
+	struct phy_provider *phy_provider;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = of_node_get(dev->of_node);
+
+	phy = devm_kzalloc(&pdev->dev, sizeof(*phy), GFP_KERNEL);
+	if (!phy)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, phy);
+	phy->dev = &pdev->dev;
+
+	phy->data = of_device_get_match_data(dev);
+	if (!phy->data)
+		return -EINVAL;
+
+	ret = qcom_uniphy_pcie_get_resources(pdev, phy);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to get resources: %d\n", ret);
+		return ret;
+	}
+
+	ret = phy_pipe_clk_register(phy, np);
+	if (ret)
+		dev_err(&pdev->dev, "failed to register phy pipe clk\n");
+
+	generic_phy = devm_phy_create(phy->dev, NULL, &pcie_ops);
+	if (IS_ERR(generic_phy))
+		return PTR_ERR(generic_phy);
+
+	phy_set_drvdata(generic_phy, phy);
+	phy_provider = devm_of_phy_provider_register(phy->dev,
+						     of_phy_simple_xlate);
+	if (IS_ERR(phy_provider))
+		return PTR_ERR(phy_provider);
+
+	return 0;
+}
+
+static struct platform_driver qcom_uniphy_pcie_driver = {
+	.probe		= qcom_uniphy_pcie_probe,
+	.driver		= {
+		.name	= "qcom-uniphy-pcie",
+		.owner	= THIS_MODULE,
+		.of_match_table = qcom_uniphy_pcie_id_table,
+	},
+};
+
+module_platform_driver(qcom_uniphy_pcie_driver);
+
+MODULE_ALIAS("platform:qcom-uniphy-pcie");
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_DESCRIPTION("PCIE QCOM UNIPHY driver");
-- 
2.17.1


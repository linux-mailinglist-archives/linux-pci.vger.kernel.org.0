Return-Path: <linux-pci+bounces-12497-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA139659BB
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 10:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45BB31F23E2A
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 08:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F84616EB5D;
	Fri, 30 Aug 2024 08:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bHi9Pfck"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6219716DC05;
	Fri, 30 Aug 2024 08:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725005556; cv=none; b=SJwvB49uy5iH76jevXPv+pbtSoArQvnSmF8Z6p7h3GVkHB5R7bCFBA8HjDNzrHZRCqilzr+jVjzEky6oTH/3Kd6xs8plDFZGwwLY8mQ3yxSSLZvfixzLJvawvrGAP63Py9EzIgbLy+InCejsDevttlzxLKKqbEE203OixhJ3UiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725005556; c=relaxed/simple;
	bh=doiRo+4xpLqi3/J8du8Ey+L9M2tpVMBziSZ0WENn0Eo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uHjOz3KgiOKseTVqyP6qUq5/NeXCOFCv0rQrTIyI+v/jIRcBgzIvKfhXlugRef5kyEkW1cUmlp8+9rmuzgok0cBUqcDcclAHCs6d/J0ctIKOpZzdthbxSVAT5LXdHAyRQ3vGU2X6RcbSK8O/J5JaD/DviVT9qLsgfkVmNtNayXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bHi9Pfck; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47TI2G1G017915;
	Fri, 30 Aug 2024 08:12:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/9JpxaEZqnCfjNc2p4D9KUroT+pXKOHxKyfXfgGls5c=; b=bHi9PfckNu6mHmxN
	ZFkg+0LLAYQuMagIPNz6Y2jzmfxSyca0M/9MXZeX32h9hXcMFo52rk5EvPcKI+Uf
	hGA4CdUZgqVW3YkJ+QNhhj1vbuewOV/Dt9e/gJNrWSSFwWdyNP04iAy4kzxACiTy
	r0ulWQ5v6nxTBWjbIf89zPlQvx9KA6wt+Jq/Nnuw8BQk2LY5SQkIfxJr5Ri2VvF4
	wY3tocgabuz4a+adWcK2jOQHI+Q5Hc2qX/8xEczhJWbwUCu0dbiWXEr+gWmlPsSc
	spWeWfF3t6FO557fAAu/69gnulYucLiwh4Rgg8ajy2okPRyBHvDyP4h/hodl293i
	p3uGoA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 419putqxth-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 08:12:12 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47U8CBlA002215
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 08:12:11 GMT
Received: from hu-srichara-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 30 Aug 2024 01:12:04 -0700
From: Sricharan R <quic_srichara@quicinc.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <andersson@kernel.org>, <konradybcio@kernel.org>,
        <p.zabel@pengutronix.de>, <dmitry.baryshkov@linaro.org>,
        <quic_nsekar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <robimarko@gmail.com>, <quic_srichara@quicinc.com>
Subject: [PATCH V3 3/6] phy: qcom: Introduce PCIe UNIPHY 28LP driver
Date: Fri, 30 Aug 2024 13:41:29 +0530
Message-ID: <20240830081132.4016860-4-quic_srichara@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830081132.4016860-1-quic_srichara@quicinc.com>
References: <20240830081132.4016860-1-quic_srichara@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pMjdbRu5xSM54C7nqjskbLQT6ajG9XGT
X-Proofpoint-ORIG-GUID: pMjdbRu5xSM54C7nqjskbLQT6ajG9XGT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_04,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 phishscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408300060

From: Nitheesh Sekar <quic_nsekar@quicinc.com>

Add Qualcomm PCIe UNIPHY 28LP driver support present
in Qualcomm IPQ5018 SoC and the phy init sequence.

Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
---
 [V3] Fixed dev_err_probe usage

 drivers/phy/qualcomm/Kconfig                  |  12 +
 drivers/phy/qualcomm/Makefile                 |   1 +
 .../phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c  | 346 ++++++++++++++++++
 3 files changed, 359 insertions(+)
 create mode 100644 drivers/phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c

diff --git a/drivers/phy/qualcomm/Kconfig b/drivers/phy/qualcomm/Kconfig
index 846f8c99547f..8f043e8cb71c 100644
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
index eb60e950ad53..42038bc30974 100644
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
index 000000000000..95740850bdc0
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c
@@ -0,0 +1,346 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2024, The Linux Foundation. All rights reserved.
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
+struct qcom_uniphy_regs {
+	unsigned int offset;
+	unsigned int val;
+};
+
+struct qcom_uniphy_pcie_data {
+	int lanes;
+	/* 2nd lane offset */
+	int lane_offset;
+	unsigned int phy_type;
+	const struct qcom_uniphy_regs *init_seq;
+	unsigned int init_seq_num;
+};
+
+struct qcom_uniphy_pcie {
+	struct phy phy;
+	struct device *dev;
+	const struct qcom_uniphy_pcie_data *data;
+	struct clk_bulk_data *clks;
+	int num_clks;
+	struct reset_control *resets;
+	void __iomem *base;
+};
+
+#define	phy_to_dw_phy(x)	container_of((x), struct qca_uni_pcie_phy, phy)
+
+static const struct qcom_uniphy_regs ipq5018_regs[] = {
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
+static const struct qcom_uniphy_pcie_data ipq5018_2x1_data = {
+	.lanes		= 1,
+	.lane_offset	= 0x800,
+	.phy_type	= PHY_TYPE_PCIE_GEN2,
+	.init_seq	= ipq5018_regs,
+	.init_seq_num	= ARRAY_SIZE(ipq5018_regs),
+};
+
+static const struct qcom_uniphy_pcie_data ipq5018_2x2_data = {
+	.lanes		= 2,
+	.lane_offset	= 0x800,
+	.phy_type	= PHY_TYPE_PCIE_GEN2,
+	.init_seq	= ipq5018_regs,
+	.init_seq_num	= ARRAY_SIZE(ipq5018_regs),
+};
+
+static void qcom_uniphy_pcie_init(struct qcom_uniphy_pcie *phy)
+{
+	const struct qcom_uniphy_pcie_data *data = phy->data;
+	const struct qcom_uniphy_regs *init_seq;
+	void __iomem *base = phy->base;
+	int lane = 0;
+	int i;
+
+	for (lane = 0; lane < data->lanes; lane++) {
+		init_seq = data->init_seq;
+
+		for (i = 0; i < data->init_seq_num; i++, init_seq++)
+			writel(init_seq->val, base + init_seq->offset);
+
+		base += data->lane_offset;
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
+	ret = clk_bulk_prepare_enable(phy->num_clks, phy->clks);
+	if (ret) {
+		dev_err(phy->dev, "clk prepare and enable failed %d\n", ret);
+		return ret;
+	}
+
+	usleep_range(30, 50);
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
+	usleep_range(5000, 5100);
+
+	qcom_uniphy_pcie_init(phy);
+
+	return 0;
+}
+
+static inline int qcom_uniphy_pcie_get_resources(struct platform_device *pdev,
+						 struct qcom_uniphy_pcie *phy)
+{
+	struct resource *res;
+
+	phy->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
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
+static inline int phy_pipe_clk_register(struct qcom_uniphy_pcie  *phy,
+					struct device_node *np)
+{
+	struct clk_init_data init = { };
+	struct clk_fixed_rate *fixed;
+	struct clk_hw *hw;
+	char name[64];
+	int ret;
+
+	snprintf(name, sizeof(name), "%s::pipe_clk", dev_name(phy->dev));
+
+	fixed = devm_kzalloc(phy->dev, sizeof(*fixed), GFP_KERNEL);
+	if (!fixed)
+		return -ENOMEM;
+
+	init.ops = &clk_fixed_rate_ops;
+	fixed->fixed_rate = 125000000;
+	fixed->hw.init = &init;
+	hw = &fixed->hw;
+
+	hw = devm_clk_hw_register_fixed_rate(phy->dev, name, NULL,
+					     0, 125000000);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+
+	ret = devm_of_clk_add_hw_provider(phy->dev, of_clk_hw_simple_get, hw);
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
+	{
+		.compatible = "qcom,ipq5018-uniphy-pcie-gen2x1",
+		.data = &ipq5018_2x1_data,
+	},
+
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
+	struct phy_provider *phy_provider;
+	struct device *dev = &pdev->dev;
+	struct qcom_uniphy_pcie *phy;
+	struct phy *generic_phy;
+	struct device_node *np;
+	int ret;
+
+	np = of_node_get(dev->of_node);
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
+		return dev_err_probe(&pdev->dev, PTR_ERR(phy->data),
+				     "Failed to get data\n");
+
+	ret = qcom_uniphy_pcie_get_resources(pdev, phy);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Failed to get resources:\n");
+
+	ret = phy_pipe_clk_register(phy, np);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "pipe clk register failed\n");
+
+	generic_phy = devm_phy_create(phy->dev, NULL, &pcie_ops);
+	if (IS_ERR(generic_phy))
+		return dev_err_probe(&pdev->dev, PTR_ERR(generic_phy),
+				     "phy create failed\n");
+
+	phy_set_drvdata(generic_phy, phy);
+	phy_provider = devm_of_phy_provider_register(phy->dev,
+						     of_phy_simple_xlate);
+	if (IS_ERR(phy_provider))
+		return dev_err_probe(&pdev->dev, PTR_ERR(phy_provider),
+				     "phy register failed\n");
+
+	return 0;
+}
+
+static struct platform_driver qcom_uniphy_pcie_driver = {
+	.probe		= qcom_uniphy_pcie_probe,
+	.driver		= {
+		.name	= "qcom-uniphy-pcie",
+		.of_match_table = qcom_uniphy_pcie_id_table,
+	},
+};
+
+module_platform_driver(qcom_uniphy_pcie_driver);
+
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_DESCRIPTION("PCIE QCOM UNIPHY driver");
-- 
2.34.1



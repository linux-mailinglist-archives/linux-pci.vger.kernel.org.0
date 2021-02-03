Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 653D130D3AB
	for <lists+linux-pci@lfdr.de>; Wed,  3 Feb 2021 08:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbhBCHDI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Feb 2021 02:03:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:34088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231722AbhBCHCl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Feb 2021 02:02:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7546E64F67;
        Wed,  3 Feb 2021 07:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612335720;
        bh=Ak/SRsEmbodWMQWHFspw9muj+HO1Me4jb6bnXOYqzhE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MqG0svQLWL7rHYbDeySYu4wgCVEuodKSDui116khReRU58QCixf8ZBSBO8bGNlJQV
         pR/ss9sTK1VDSUj/yv7yBT+3BUTGXPUE0jOCZ3kPZUmrnPcMerlaxpwOXTeTNeMQ+V
         aq3oqEqI1htL2PQOMw+uuUN2esIJyzvQkn8GC7sajNMm7Cc2TlWBix5lcSUagpZsTh
         EQh7LlXejZxF4ysQyNoujMNhyLYkQ2zuTYb5dFVFS1a+Cn30UjZwPOAZ5pm/P/+vao
         BQwshIEhIRI8SEi5dKC2371Q2wh9sLyt8RBOsNJpuyo0RS8vodg9NlNmUORMkVvE1H
         4sYS54piqf6lQ==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l7CAo-001CAi-8c; Wed, 03 Feb 2021 08:01:58 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v2 09/11] PCI: dwc: pcie-kirin: allow using multiple reset GPIOs
Date:   Wed,  3 Feb 2021 08:01:53 +0100
Message-Id: <4fb97b1fc3fe6df9a2fea8f96bdef433e75463a6.1612335031.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1612335031.git.mchehab+huawei@kernel.org>
References: <cover.1612335031.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On HiKey 970, the PCI hardware contains a bridge (PEX 8606), an Ethernet
controller (RTL8169), a M.2 connector and a mini 1X connector.

They work out of the box, but each of them requires its own reset line,
which should be initialized when the PCI hardware is reset.

So, add support for the DTS to contain multiple reset lines.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/pci/controller/dwc/pcie-kirin.c | 148 +++++++++++++-----------
 1 file changed, 79 insertions(+), 69 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index 005fc4c2ad7f..4124c6ace349 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -139,6 +139,7 @@
 #define TIME_PHY_PD_MIN		10
 #define TIME_PHY_PD_MAX		11
 
+#define MAX_GPIO_RESETS		4
 struct kirin_pcie {
 	struct dw_pcie	*pci;
 	void __iomem	*apb_base;
@@ -151,8 +152,10 @@ struct kirin_pcie {
 	struct clk	*phy_ref_clk;
 	struct clk	*pcie_aclk;
 	struct clk	*pcie_aux_clk;
-	int		gpio_id_reset[4];
+	int		n_gpio_resets;
 	int		gpio_id_clkreq[3];
+	int		gpio_id_reset[MAX_GPIO_RESETS];
+	const char	*reset_names[MAX_GPIO_RESETS];
 	u32		eye_param[5];
 };
 
@@ -296,6 +299,24 @@ static void kirin970_pcie_set_eyeparam(struct kirin_pcie *kirin_pcie)
 static long kirin_common_pcie_get_resource(struct kirin_pcie *kirin_pcie,
 					   struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct regulator *reg;
+	char name[32];
+	int ret, i;
+
+	reg = devm_regulator_get_optional(dev, "pci");
+	if (IS_ERR_OR_NULL(reg)) {
+		if (PTR_ERR(reg) == -EPROBE_DEFER)
+		    return PTR_ERR(reg);
+	} else {
+		ret = regulator_enable(reg);
+		if (ret) {
+			dev_err(dev, "Failed to enable regulator\n");
+			return ret;
+		}
+	}
+
 	kirin_pcie->apb_base = devm_platform_ioremap_resource_byname(pdev,
 								     "apb");
 	if (IS_ERR(kirin_pcie->apb_base))
@@ -306,14 +327,47 @@ static long kirin_common_pcie_get_resource(struct kirin_pcie *kirin_pcie,
 	if (IS_ERR(kirin_pcie->phy_base))
 		return PTR_ERR(kirin_pcie->phy_base);
 
+	kirin_pcie->n_gpio_resets = of_gpio_named_count(np, "reset-gpios");
+	if (kirin_pcie->n_gpio_resets > MAX_GPIO_RESETS) {
+		dev_err(dev, "Too many GPIO resets!\n");
+		return -EINVAL;
+	}
+	for (i = 0; i < kirin_pcie->n_gpio_resets; i++) {
+		kirin_pcie->gpio_id_reset[i] = of_get_named_gpio(dev->of_node,
+							    "reset-gpios", i);
+		if (kirin_pcie->gpio_id_reset[i] < 0)
+			return kirin_pcie->gpio_id_reset[i];
+
+		sprintf(name, "pcie_perst_%d", i);
+		kirin_pcie->reset_names[i] = devm_kstrdup_const(dev, name,
+								GFP_KERNEL);
+		if (!kirin_pcie->reset_names[i])
+			return -ENOMEM;
+	}
+
 	return 0;
 }
 
+static int kirin_gpio_request(struct kirin_pcie *kirin_pcie,
+			      struct device *dev)
+{
+	int ret, i;
+
+	for (i = 0; i < kirin_pcie->n_gpio_resets; i++) {
+		ret = devm_gpio_request(dev, kirin_pcie->gpio_id_reset[i],
+					kirin_pcie->reset_names[i]);
+		if (ret)
+			return ret;
+	}
+
+
+	return ret;
+}
+
+
 static long kirin960_pcie_get_resource(struct kirin_pcie *kirin_pcie,
 				       struct platform_device *pdev)
 {
-	struct device *dev = &pdev->dev;
-
 	kirin_pcie->crgctrl =
 		syscon_regmap_lookup_by_compatible("hisilicon,hi3660-crgctrl");
 	if (IS_ERR(kirin_pcie->crgctrl))
@@ -324,16 +378,11 @@ static long kirin960_pcie_get_resource(struct kirin_pcie *kirin_pcie,
 	if (IS_ERR(kirin_pcie->sysctrl))
 		return PTR_ERR(kirin_pcie->sysctrl);
 
-	kirin_pcie->gpio_id_reset[0] = of_get_named_gpio(dev->of_node,
-						      "reset-gpios", 0);
-	if (kirin_pcie->gpio_id_reset[0] < 0)
-		return kirin_pcie->gpio_id_reset[0];
-
 	return 0;
 }
 
 static long kirin970_pcie_get_resource(struct kirin_pcie *kirin_pcie,
-				      struct platform_device *pdev)
+				       struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct regulator *reg;
@@ -353,40 +402,7 @@ static long kirin970_pcie_get_resource(struct kirin_pcie *kirin_pcie,
 
 	kirin970_pcie_get_eyeparam(kirin_pcie);
 
-	kirin_pcie->gpio_id_reset[0] = of_get_named_gpio(dev->of_node,
-						"switch,reset-gpios", 0);
-	if (kirin_pcie->gpio_id_reset[0] < 0)
-		return kirin_pcie->gpio_id_reset[0];
-
-	kirin_pcie->gpio_id_reset[1] = of_get_named_gpio(dev->of_node,
-						"eth,reset-gpios", 0);
-	if (kirin_pcie->gpio_id_reset[1] < 0)
-		return kirin_pcie->gpio_id_reset[1];
-
-	kirin_pcie->gpio_id_reset[2] = of_get_named_gpio(dev->of_node,
-						"m_2,reset-gpios", 0);
-	if (kirin_pcie->gpio_id_reset[2] < 0)
-		return kirin_pcie->gpio_id_reset[2];
-
-	kirin_pcie->gpio_id_reset[3] = of_get_named_gpio(dev->of_node,
-						"mini1,reset-gpios", 0);
-	if (kirin_pcie->gpio_id_reset[3] < 0)
-		return kirin_pcie->gpio_id_reset[3];
-
-	ret = devm_gpio_request(dev, kirin_pcie->gpio_id_reset[0],
-				    "pcie_switch_reset");
-	if (ret)
-		return ret;
-	ret = devm_gpio_request(dev, kirin_pcie->gpio_id_reset[1],
-				    "pcie_eth_reset");
-	if (ret)
-		return ret;
-	ret = devm_gpio_request(dev, kirin_pcie->gpio_id_reset[2],
-				    "pcie_m_2_reset");
-	if (ret)
-		return ret;
-	ret = devm_gpio_request(dev, kirin_pcie->gpio_id_reset[3],
-				    "pcie_mini1_reset");
+	ret = kirin_gpio_request(kirin_pcie, dev);
 	if (ret)
 		return ret;
 
@@ -846,7 +862,7 @@ static int kirin970_pcie_noc_power(struct kirin_pcie *kirin_pcie, bool enable)
 static int kirin970_pcie_power_on(struct kirin_pcie *kirin_pcie)
 {
 	struct device *dev = kirin_pcie->pci->dev;
-	int ret;
+	int ret, i;
 	u32 val;
 
 	/* Power supply for Host */
@@ -898,22 +914,11 @@ static int kirin970_pcie_power_on(struct kirin_pcie *kirin_pcie)
 
 	/* perst assert Endpoints */
 	usleep_range(21000, 23000);
-	ret = gpio_direction_output(kirin_pcie->gpio_id_reset[0], 1);
-	if (ret)
-		goto close_clk;
-
-	ret = gpio_direction_output(kirin_pcie->gpio_id_reset[1], 1);
-	if (ret)
-		goto close_clk;
-
-	ret = gpio_direction_output(kirin_pcie->gpio_id_reset[2], 1);
-	if (ret)
-		goto close_clk;
-
-	ret = gpio_direction_output(kirin_pcie->gpio_id_reset[3], 1);
-	if (ret)
-		goto close_clk;
-
+	for (i = 0; i < kirin_pcie->n_gpio_resets; i++) {
+		ret = gpio_direction_output(kirin_pcie->gpio_id_reset[i], 1);
+		if (ret)
+			return ret;
+	}
 	usleep_range(10000, 11000);
 
 	ret = is_pipe_clk_stable(kirin_pcie);
@@ -934,6 +939,7 @@ static int kirin970_pcie_power_on(struct kirin_pcie *kirin_pcie)
 
 static int kirin960_pcie_power_on(struct kirin_pcie *kirin_pcie)
 {
+	struct device *dev = kirin_pcie->pci->dev;
 	int ret;
 
 	/* Power supply for Host */
@@ -959,15 +965,19 @@ static int kirin960_pcie_power_on(struct kirin_pcie *kirin_pcie)
 		goto close_clk;
 
 	/* perst assert Endpoint */
-	if (!gpio_request(kirin_pcie->gpio_id_reset[0], "pcie_perst")) {
-		usleep_range(REF_2_PERST_MIN, REF_2_PERST_MAX);
-		ret = gpio_direction_output(kirin_pcie->gpio_id_reset[0], 1);
-		if (ret)
-			goto close_clk;
-		usleep_range(PERST_2_ACCESS_MIN, PERST_2_ACCESS_MAX);
-
-		return 0;
-	}
+	ret = kirin_gpio_request(kirin_pcie, dev);
+	if (ret)
+		goto close_clk;
+
+	usleep_range(REF_2_PERST_MIN, REF_2_PERST_MAX);
+
+	ret = gpio_direction_output(kirin_pcie->gpio_id_reset[0], 1);
+	if (ret)
+		goto close_clk;
+
+	usleep_range(PERST_2_ACCESS_MIN, PERST_2_ACCESS_MAX);
+
+	return 0;
 
 close_clk:
 	kirin_pcie_clk_ctrl(kirin_pcie, false);
-- 
2.29.2


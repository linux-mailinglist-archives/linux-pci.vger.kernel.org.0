Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2F230BF74
	for <lists+linux-pci@lfdr.de>; Tue,  2 Feb 2021 14:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbhBBNbm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Feb 2021 08:31:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:59326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231497AbhBBNan (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Feb 2021 08:30:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB27D64F51;
        Tue,  2 Feb 2021 13:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612272602;
        bh=P1//vV/xroxOXJR5AGgK3kzXgaxmA/blRDvzebBehs0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tWe0qKCTLyT4TQ9Sm3MwTBggyxoKebyKgItKTLs1renNkPlyRIpGhiX9QXUjQpSJd
         9P2B/BAUYlEyF8VrPI9njuv9t02PXnLwGDyxm2AM7kyvGkN0pKewKw/kWLzm5Mlvzv
         tV5qJ0Ra6+CtjuXWh+5efxLX4oftI8mJKDFUU/+0k/ldg+02u6KUk6xmeSXeoamZv/
         NSnbGY+lVwyqIaTp0imp0ZQESTuzWeo+wWN3I+EWZxWm70tCbi+a4lvKy5UZ3naADl
         iFocacv/tyvhTLIcF8u3GpJDuUJBCx2DBfMhmGKw+meCZ5XfNWzN13yvV8WJ/o2U/d
         VZYc0eL/Yl+iQ==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l6vkl-0011z7-Ql; Tue, 02 Feb 2021 14:29:59 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 10/13] pci: dwc: pcie-kirin: allow using multiple reset GPIOs
Date:   Tue,  2 Feb 2021 14:29:55 +0100
Message-Id: <39d125c8d033ca961bbaa77c9c2b0df3f0bd7ef1.1612271903.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1612271903.git.mchehab+huawei@kernel.org>
References: <cover.1612271903.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Hikey 970, the PCI hardware contains a bridge (PEX 8606),
an Ethernet controller (RTL8169), a M.2 connector and a
mini 1X connector.

They work out of the box, but each of them requires its
own reset line, which should be initialized when the PCI
hardware is reset.

So, add support for the DTS to contain multiple reset lines.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/pci/controller/dwc/pcie-kirin.c | 134 +++++++++++-------------
 1 file changed, 64 insertions(+), 70 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index 42aea34dff4d..faf711366309 100644
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
 
@@ -297,8 +300,10 @@ static long kirin_common_pcie_get_resource(struct kirin_pcie *kirin_pcie,
 					   struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 	struct regulator *reg;
-	int ret;
+	char name[32];
+	int ret, i;
 
 	reg = devm_regulator_get_optional(dev, "pci");
 	if (IS_ERR_OR_NULL(reg)) {
@@ -322,14 +327,47 @@ static long kirin_common_pcie_get_resource(struct kirin_pcie *kirin_pcie,
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
@@ -340,56 +378,18 @@ static long kirin960_pcie_get_resource(struct kirin_pcie *kirin_pcie,
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
 	int ret;
 
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
 
@@ -849,7 +849,7 @@ static int kirin970_pcie_noc_power(struct kirin_pcie *kirin_pcie, bool enable)
 static int kirin970_pcie_power_on(struct kirin_pcie *kirin_pcie)
 {
 	struct device *dev = kirin_pcie->pci->dev;
-	int ret;
+	int ret, i;
 	u32 val;
 
 	/* Power supply for Host */
@@ -901,22 +901,11 @@ static int kirin970_pcie_power_on(struct kirin_pcie *kirin_pcie)
 
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
@@ -937,6 +926,7 @@ static int kirin970_pcie_power_on(struct kirin_pcie *kirin_pcie)
 
 static int kirin960_pcie_power_on(struct kirin_pcie *kirin_pcie)
 {
+	struct device *dev = kirin_pcie->pci->dev;
 	int ret;
 
 	/* Power supply for Host */
@@ -962,15 +952,19 @@ static int kirin960_pcie_power_on(struct kirin_pcie *kirin_pcie)
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


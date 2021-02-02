Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F366D30BF77
	for <lists+linux-pci@lfdr.de>; Tue,  2 Feb 2021 14:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbhBBNbv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Feb 2021 08:31:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:59580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232345AbhBBNb1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Feb 2021 08:31:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DAFFD64EDA;
        Tue,  2 Feb 2021 13:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612272602;
        bh=erwwnvc97xuvNb/GIafHSr71dHfEPwM5oq3L6s8voRc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H9Cb5xpnVcE+fWV4E2SuBYbqZ1Aeb/4PHUCK++GkCu8iRb0oYQMpvUa0c2LzvUF7d
         eW+cIuEVY6wbjcuNYUI0gZlrWskMit2+jBfUGwTaABlv/97pO0Sf3Kekcs1UQvDAhC
         8RLE6790jLzYOQj9NsDALz3qqs6uPeGnZ+LMWIMSZomHhCQ0G6lQNfDco/hq1Je48S
         HwJxpZBg725ixI8rESo+bOm+gTxKDVvU+bw0tM/zCIll2WB6gkEyTSUV3TFzdN/p7A
         yWagAEIhd6X1HNvPXCF/bZFNespphPZFNVQ7l3neuIlPJ5U+hf6saEBQtQ2K+3xEPp
         bKQau2+0EKu8Q==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l6vkl-0011zA-S1; Tue, 02 Feb 2021 14:29:59 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 11/13] pci: dwc: pcie-kirin: add support for clkreq GPIOs
Date:   Tue,  2 Feb 2021 14:29:56 +0100
Message-Id: <d6a54284f50b74dd3249e79b65e060d1982e7100.1612271903.git.mchehab+huawei@kernel.org>
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

The PCI hardware on Hikey 970 also need to enable clock
lines for PCI bridge, Ethernet and M.2 connector.

Those should be enabled during PCI hardware power on logic.

Add support for them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/pci/controller/dwc/pcie-kirin.c | 77 +++++++++++--------------
 1 file changed, 34 insertions(+), 43 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index faf711366309..37b964386d21 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -140,6 +140,8 @@
 #define TIME_PHY_PD_MAX		11
 
 #define MAX_GPIO_RESETS		4
+#define MAX_GPIO_CLKREQ		3
+
 struct kirin_pcie {
 	struct dw_pcie	*pci;
 	void __iomem	*apb_base;
@@ -153,9 +155,11 @@ struct kirin_pcie {
 	struct clk	*pcie_aclk;
 	struct clk	*pcie_aux_clk;
 	int		n_gpio_resets;
-	int		gpio_id_clkreq[3];
+	int		n_gpio_clkreq;
 	int		gpio_id_reset[MAX_GPIO_RESETS];
 	const char	*reset_names[MAX_GPIO_RESETS];
+	int		gpio_id_clkreq[MAX_GPIO_CLKREQ];
+	const char	*clkreq_names[MAX_GPIO_CLKREQ];
 	u32		eye_param[5];
 };
 
@@ -345,6 +349,24 @@ static long kirin_common_pcie_get_resource(struct kirin_pcie *kirin_pcie,
 			return -ENOMEM;
 	}
 
+	kirin_pcie->n_gpio_clkreq = of_gpio_named_count(np, "clkreq-gpios");
+	if (kirin_pcie->n_gpio_clkreq > MAX_GPIO_CLKREQ) {
+		dev_err(dev, "Too many GPIO clock requests!\n");
+		return -EINVAL;
+	}
+	for (i = 0; i < kirin_pcie->n_gpio_clkreq; i++) {
+		kirin_pcie->gpio_id_clkreq[i] = of_get_named_gpio(dev->of_node,
+							    "clkreq-gpios", i);
+		if (kirin_pcie->gpio_id_clkreq[i] < 0)
+			return kirin_pcie->gpio_id_clkreq[i];
+
+		sprintf(name, "pcie_clkreq_%d", i);
+		kirin_pcie->clkreq_names[i] = devm_kstrdup_const(dev, name,
+								GFP_KERNEL);
+		if (!kirin_pcie->clkreq_names[i])
+			return -ENOMEM;
+	}
+
 	return 0;
 }
 
@@ -360,6 +382,12 @@ static int kirin_gpio_request(struct kirin_pcie *kirin_pcie,
 			return ret;
 	}
 
+	for (i = 0; i < kirin_pcie->n_gpio_clkreq; i++) {
+		ret = devm_gpio_request(dev, kirin_pcie->gpio_id_clkreq[i],
+					kirin_pcie->clkreq_names[i]);
+		if (ret)
+			return ret;
+	}
 
 	return ret;
 }
@@ -393,36 +421,6 @@ static long kirin970_pcie_get_resource(struct kirin_pcie *kirin_pcie,
 	if (ret)
 		return ret;
 
-	kirin_pcie->gpio_id_clkreq[0] = of_get_named_gpio(dev->of_node,
-						"eth,clkreq-gpios", 0);
-	if (kirin_pcie->gpio_id_clkreq[0] < 0)
-		return -ENODEV;
-
-	kirin_pcie->gpio_id_clkreq[1] = of_get_named_gpio(dev->of_node,
-						"m_2,clkreq-gpios", 0);
-	if (kirin_pcie->gpio_id_clkreq[1] < 0)
-		return -ENODEV;
-
-	kirin_pcie->gpio_id_clkreq[2] = of_get_named_gpio(dev->of_node,
-						"mini1,clkreq-gpios", 0);
-	if (kirin_pcie->gpio_id_clkreq[2] < 0)
-		return -ENODEV;
-
-	ret = devm_gpio_request(dev, kirin_pcie->gpio_id_clkreq[0],
-				    "pcie_eth_clkreq");
-	if (ret)
-		return ret;
-
-	ret = devm_gpio_request(dev, kirin_pcie->gpio_id_clkreq[1],
-				    "pcie_m_2_clkreq");
-	if (ret)
-		return ret;
-
-	ret = devm_gpio_request(dev, kirin_pcie->gpio_id_clkreq[2],
-				    "pcie_mini1_clkreq");
-	if (ret)
-		return ret;
-
 	kirin_pcie->crgctrl =
 		syscon_regmap_lookup_by_compatible("hisilicon,hi3670-crgctrl");
 	if (IS_ERR(kirin_pcie->crgctrl))
@@ -848,7 +846,6 @@ static int kirin970_pcie_noc_power(struct kirin_pcie *kirin_pcie, bool enable)
 
 static int kirin970_pcie_power_on(struct kirin_pcie *kirin_pcie)
 {
-	struct device *dev = kirin_pcie->pci->dev;
 	int ret, i;
 	u32 val;
 
@@ -858,17 +855,11 @@ static int kirin970_pcie_power_on(struct kirin_pcie *kirin_pcie)
 	usleep_range(TIME_CMOS_MIN, TIME_CMOS_MAX);
 	kirin_pcie_oe_enable(kirin_pcie);
 
-	ret = gpio_direction_output(kirin_pcie->gpio_id_clkreq[0], 0);
-	if (ret)
-		dev_err(dev, "Failed to pulse eth clkreq signal\n");
-
-	ret = gpio_direction_output(kirin_pcie->gpio_id_clkreq[1], 0);
-	if (ret)
-		dev_err(dev, "Failed to pulse m.2 clkreq signal\n");
-
-	ret = gpio_direction_output(kirin_pcie->gpio_id_clkreq[2], 0);
-	if (ret)
-		dev_err(dev, "Failed to pulse mini1 clkreq signal\n");
+	for (i = 0; i < kirin_pcie->n_gpio_clkreq; i++) {
+		ret = gpio_direction_output(kirin_pcie->gpio_id_clkreq[i], 0);
+		if (ret)
+			return ret;
+	}
 
 	ret = kirin_pcie_clk_ctrl(kirin_pcie, true);
 	if (ret)
-- 
2.29.2


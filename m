Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 179A130D3A3
	for <lists+linux-pci@lfdr.de>; Wed,  3 Feb 2021 08:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbhBCHCo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Feb 2021 02:02:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:34070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231717AbhBCHCl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Feb 2021 02:02:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6ECAD64F65;
        Wed,  3 Feb 2021 07:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612335720;
        bh=XAT5CRmZyM1W+2vKcepEc3Mh6Y6JxLba1gm5DIqVQzI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b51BQW+x2mDzibQWPXp2txL/bv8XIVj+oH4Rz+XR2O+/Id84d2Ex0ZcSWKxBbAUgz
         VZe9wfwHRNp6LETZoMkS6uw6UgC59rD6N1OpJ73LOD1mPZ/80O/KNnFMZbWpyiPTkA
         EWyg74VZfXfJokAjrIL4C2d1yzHe4Vgh8ZlrID5nlrela7uMgd4jQEtEzriAtD03/G
         hsPbJUSAngzPYrSGmbxwavipMAnbKZNRQVhmpQMiFMeabbCJYJ/xXM8niVR0RrfnS5
         b8HuJTxll6nkUOyLE1hRLOHjbziw6SOcbMMqxHKHXZjHXJl9pUW2xbmONsidQjDZWr
         ZGe3wTgcIYQbA==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l7CAo-001CAl-9W; Wed, 03 Feb 2021 08:01:58 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v2 10/11] PCI: dwc: pcie-kirin: add support for clkreq GPIOs
Date:   Wed,  3 Feb 2021 08:01:54 +0100
Message-Id: <ddb27a9f45c1c7532237ddd77f1deeda47951f44.1612335031.git.mchehab+huawei@kernel.org>
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

The hardware on Kirin 970 designs use external components as part of
their PCIe hardware support.

Fo instance, in the case of HiKey 970, it has separate clkreq lines that
are needed to be enabled on its PCIe bridge, Ethernet chip and even at
the M.2 connector hardware.

Those should be enabled during PCIe hardware power on logic, as
otherwise the resource allocation will fail.

Add support for them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/pci/controller/dwc/pcie-kirin.c | 77 +++++++++++--------------
 1 file changed, 34 insertions(+), 43 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index 4124c6ace349..c5404f1eca28 100644
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
@@ -406,36 +434,6 @@ static long kirin970_pcie_get_resource(struct kirin_pcie *kirin_pcie,
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
@@ -861,7 +859,6 @@ static int kirin970_pcie_noc_power(struct kirin_pcie *kirin_pcie, bool enable)
 
 static int kirin970_pcie_power_on(struct kirin_pcie *kirin_pcie)
 {
-	struct device *dev = kirin_pcie->pci->dev;
 	int ret, i;
 	u32 val;
 
@@ -871,17 +868,11 @@ static int kirin970_pcie_power_on(struct kirin_pcie *kirin_pcie)
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


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F82741A9C0
	for <lists+linux-pci@lfdr.de>; Tue, 28 Sep 2021 09:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239352AbhI1HgG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Sep 2021 03:36:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:55868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239313AbhI1HgF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Sep 2021 03:36:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 42DF060F46;
        Tue, 28 Sep 2021 07:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632814466;
        bh=DcrQyHSmyIMHU4UvUo1WQVZfImDpmzpTYq/ihCjHvCw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QngQg21rJ/xWZsSTPtYbPDVFyU1vsvsKHWpXIhgFLC52yuNuseBNiNQBZCrOIdWO8
         fb008FnISrJBsFoteUvbiTA2UNgU4Zhz6EALmh9D6BXVhuIXWjB2Ipl28JiNGM2NPq
         25eHSETPqUhDPYdGxlH3mXmdYtErUaGJuJhhIb5eIkDtGydg7hcAXqyuBwLS9L6zBF
         X9Wf8aBS2sx8O/IXUz3fALezNULw/Gz/a+ixetMdKAz5t+5Y54nmg2J189BH6t/SdY
         icVmJe1V8bQAyEv1mfnmmawlynT7QKd6R2f07SUBGg6o58bLUnGKzjRXnXFMZHrFQt
         I+l3ScyYGUFcg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mV7dA-000RPj-EU; Tue, 28 Sep 2021 09:34:24 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v12 03/11] PCI: kirin: Add support for a PHY layer
Date:   Tue, 28 Sep 2021 09:34:13 +0200
Message-Id: <8a6d353145c0ec169d212094f5d534f93e2597f8.1632814194.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632814194.git.mchehab+huawei@kernel.org>
References: <cover.1632814194.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pcie-kirin driver contains both PHY and generic PCI driver
on it.

The best would be, instead, to support a PCI PHY driver, making
the driver more generic.

However, it is too late to remove the Kirin 960 PHY, as a change
like that would make the DT schema incompatible with past versions.

So, add support for an external PHY driver without removing the
existing Kirin 960 PHY from it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

To mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v12 00/11] at: https://lore.kernel.org/all/cover.1632814194.git.mchehab+huawei@kernel.org/

 drivers/pci/controller/dwc/pcie-kirin.c | 95 +++++++++++++++++++++----
 1 file changed, 80 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index b4063a3434df..31514a5d4bb4 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -8,16 +8,18 @@
  * Author: Xiaowei Song <songxiaowei@huawei.com>
  */
 
-#include <linux/compiler.h>
 #include <linux/clk.h>
+#include <linux/compiler.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/mfd/syscon.h>
 #include <linux/of_address.h>
+#include <linux/of_device.h>
 #include <linux/of_gpio.h>
 #include <linux/of_pci.h>
+#include <linux/phy/phy.h>
 #include <linux/pci.h>
 #include <linux/pci_regs.h>
 #include <linux/platform_device.h>
@@ -50,11 +52,18 @@
 #define PCIE_DEBOUNCE_PARAM	0xF0F400
 #define PCIE_OE_BYPASS		(0x3 << 28)
 
+enum pcie_kirin_phy_type {
+	PCIE_KIRIN_INTERNAL_PHY,
+	PCIE_KIRIN_EXTERNAL_PHY
+};
+
 struct kirin_pcie {
+	enum pcie_kirin_phy_type	type;
+
 	struct dw_pcie	*pci;
 	struct phy	*phy;
 	void __iomem	*apb_base;
-	void		*phy_priv;	/* Needed for Kirin 960 PHY */
+	void		*phy_priv;	/* only for PCIE_KIRIN_INTERNAL_PHY */
 };
 
 /*
@@ -476,8 +485,63 @@ static const struct dw_pcie_host_ops kirin_pcie_host_ops = {
 	.host_init = kirin_pcie_host_init,
 };
 
+static int kirin_pcie_power_on(struct platform_device *pdev,
+			       struct kirin_pcie *kirin_pcie)
+{
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	if (kirin_pcie->type == PCIE_KIRIN_INTERNAL_PHY) {
+		ret = hi3660_pcie_phy_init(pdev, kirin_pcie);
+		if (ret)
+			return ret;
+
+		return hi3660_pcie_phy_power_on(kirin_pcie);
+	}
+
+	kirin_pcie->phy = devm_of_phy_get(dev, dev->of_node, NULL);
+	if (IS_ERR(kirin_pcie->phy))
+		return PTR_ERR(kirin_pcie->phy);
+
+	ret = phy_init(kirin_pcie->phy);
+	if (ret)
+		goto err;
+
+	ret = phy_power_on(kirin_pcie->phy);
+	if (ret)
+		goto err;
+
+	return 0;
+err:
+	phy_exit(kirin_pcie->phy);
+	return ret;
+}
+
+static int __exit kirin_pcie_remove(struct platform_device *pdev)
+{
+	struct kirin_pcie *kirin_pcie = platform_get_drvdata(pdev);
+
+	if (kirin_pcie->type == PCIE_KIRIN_INTERNAL_PHY)
+		return 0;
+
+	phy_power_off(kirin_pcie->phy);
+	phy_exit(kirin_pcie->phy);
+
+	return 0;
+}
+
+static const struct of_device_id kirin_pcie_match[] = {
+	{
+		.compatible = "hisilicon,kirin960-pcie",
+		.data = (void *)PCIE_KIRIN_INTERNAL_PHY
+	},
+	{},
+};
+
 static int kirin_pcie_probe(struct platform_device *pdev)
 {
+	enum pcie_kirin_phy_type phy_type;
+	const struct of_device_id *of_id;
 	struct device *dev = &pdev->dev;
 	struct kirin_pcie *kirin_pcie;
 	struct dw_pcie *pci;
@@ -488,6 +552,14 @@ static int kirin_pcie_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	of_id = of_match_device(kirin_pcie_match, dev);
+	if (!of_id) {
+		dev_err(dev, "OF data missing\n");
+		return -EINVAL;
+	}
+
+	phy_type = (enum pcie_kirin_phy_type)of_id->data;
+
 	kirin_pcie = devm_kzalloc(dev, sizeof(struct kirin_pcie), GFP_KERNEL);
 	if (!kirin_pcie)
 		return -ENOMEM;
@@ -500,31 +572,24 @@ static int kirin_pcie_probe(struct platform_device *pdev)
 	pci->ops = &kirin_dw_pcie_ops;
 	pci->pp.ops = &kirin_pcie_host_ops;
 	kirin_pcie->pci = pci;
-
-	ret = hi3660_pcie_phy_init(pdev, kirin_pcie);
-	if (ret)
-		return ret;
+	kirin_pcie->type = phy_type;
 
 	ret = kirin_pcie_get_resource(kirin_pcie, pdev);
 	if (ret)
 		return ret;
 
-	ret = hi3660_pcie_phy_power_on(kirin_pcie);
-	if (ret)
-		return ret;
-
 	platform_set_drvdata(pdev, kirin_pcie);
 
+	ret = kirin_pcie_power_on(pdev, kirin_pcie);
+	if (ret)
+		return ret;
+
 	return dw_pcie_host_init(&pci->pp);
 }
 
-static const struct of_device_id kirin_pcie_match[] = {
-	{ .compatible = "hisilicon,kirin960-pcie" },
-	{},
-};
-
 static struct platform_driver kirin_pcie_driver = {
 	.probe			= kirin_pcie_probe,
+	.remove	        	= __exit_p(kirin_pcie_remove),
 	.driver			= {
 		.name			= "kirin-pcie",
 		.of_match_table		= kirin_pcie_match,
-- 
2.31.1


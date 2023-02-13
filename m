Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7FE694ED7
	for <lists+linux-pci@lfdr.de>; Mon, 13 Feb 2023 19:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjBMSIk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Feb 2023 13:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbjBMSIh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Feb 2023 13:08:37 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F359116ACD;
        Mon, 13 Feb 2023 10:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676311692; x=1707847692;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=I4wUWVAt0JgAPkaj+v7ozUILvduaN+KtQYgpaSCliyY=;
  b=T0yluZQj8cKJxVAmD1O175l2qGF8jUbO+0Dyjwk2PUXHCOLoVW6MYTLV
   uQ461CuDnJ67Vqc9tORoeuci1aaZ2LDhjlIN6dyO1du3hkr4xsWzaqQ+4
   lh0YM4dYky010JamVMz8XSOF4zLqqfZv9COFCPtkznOMvmNdQt1lGjNB3
   TLla2hux/FYQZrC4XWhQlSEiRpncSbuZuylyiZ2kkY2cOhGvlPVvQ8pzK
   GveyfxNVcdLBfm/iq6yOwtYS9ZwdxzKCZu2gwwAVuT4kKs7t0vFFAiLgC
   NzHSTO+nlxNgRKbopCxK2/zKKnh53FnHihhLHz0rGDbPa1qcIexRhloB9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="310587469"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="310587469"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 10:07:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="792817488"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="792817488"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 13 Feb 2023 10:07:04 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C02701A6; Mon, 13 Feb 2023 20:07:43 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v1 1/1] PCI: dwc: Convert to agnostic GPIO API
Date:   Mon, 13 Feb 2023 20:07:35 +0200
Message-Id: <20230213180735.42117-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The of_gpio.h is going to be removed. In preparation of that convert
the driver to the agnostic API.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pci/controller/dwc/pcie-kirin.c | 105 ++++++++----------------
 1 file changed, 35 insertions(+), 70 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index d09507f822a7..89cbbe97e79d 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -12,13 +12,11 @@
 #include <linux/compiler.h>
 #include <linux/delay.h>
 #include <linux/err.h>
-#include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/mfd/syscon.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
-#include <linux/of_gpio.h>
 #include <linux/of_pci.h>
 #include <linux/phy/phy.h>
 #include <linux/pci.h>
@@ -79,16 +77,16 @@ struct kirin_pcie {
 	void		*phy_priv;	/* only for PCIE_KIRIN_INTERNAL_PHY */
 
 	/* DWC PERST# */
-	int		gpio_id_dwc_perst;
+	struct gpio_desc *id_dwc_perst_gpio;
 
 	/* Per-slot PERST# */
 	int		num_slots;
-	int		gpio_id_reset[MAX_PCI_SLOTS];
+	struct gpio_desc *id_reset_gpio[MAX_PCI_SLOTS];
 	const char	*reset_names[MAX_PCI_SLOTS];
 
 	/* Per-slot clkreq */
 	int		n_gpio_clkreq;
-	int		gpio_id_clkreq[MAX_PCI_SLOTS];
+	struct gpio_desc *id_clkreq_gpio[MAX_PCI_SLOTS];
 	const char	*clkreq_names[MAX_PCI_SLOTS];
 };
 
@@ -383,16 +381,21 @@ static int kirin_pcie_get_gpio_enable(struct kirin_pcie *pcie,
 	pcie->n_gpio_clkreq = ret;
 
 	for (i = 0; i < pcie->n_gpio_clkreq; i++) {
-		pcie->gpio_id_clkreq[i] = of_get_named_gpio(dev->of_node,
-						    "hisilicon,clken-gpios", i);
-		if (pcie->gpio_id_clkreq[i] < 0)
-			return pcie->gpio_id_clkreq[i];
+		pcie->id_clkreq_gpio[i] = devm_gpiod_get_index(dev,
+							"hisilicon,clken", i,
+							GPIOD_ASIS);
+		if (IS_ERR(pcie->id_clkreq_gpio[i]))
+			return dev_err_probe(dev, PTR_ERR(pcie->id_clkreq_gpio[i]),
+					     "unable to get a valid clken gpio\n");
 
 		sprintf(name, "pcie_clkreq_%d", i);
 		pcie->clkreq_names[i] = devm_kstrdup_const(dev, name,
 							    GFP_KERNEL);
 		if (!pcie->clkreq_names[i])
 			return -ENOMEM;
+
+		gpiod_set_consumer_name(pcie->id_clkreq_gpio[i],
+					pcie->clkreq_names[i]);
 	}
 
 	return 0;
@@ -411,10 +414,16 @@ static int kirin_pcie_parse_port(struct kirin_pcie *pcie,
 		for_each_available_child_of_node(parent, child) {
 			i = pcie->num_slots;
 
-			pcie->gpio_id_reset[i] = of_get_named_gpio(child,
-							"reset-gpios", 0);
-			if (pcie->gpio_id_reset[i] < 0)
-				continue;
+			pcie->id_reset_gpio[i] = devm_fwnode_gpiod_get_index(dev,
+							 of_fwnode_handle(child),
+							 "reset", 0, GPIOD_ASIS,
+							 NULL);
+			if (IS_ERR(pcie->id_reset_gpio[i])) {
+				if (PTR_ERR(pcie->id_reset_gpio[i]) == -ENOENT)
+					continue;
+				return dev_err_probe(dev, PTR_ERR(pcie->id_reset_gpio[i]),
+						     "unable to get a valid reset gpio\n");
+			}
 
 			pcie->num_slots++;
 			if (pcie->num_slots > MAX_PCI_SLOTS) {
@@ -438,6 +447,9 @@ static int kirin_pcie_parse_port(struct kirin_pcie *pcie,
 				ret = -ENOMEM;
 				goto put_node;
 			}
+
+			gpiod_set_consumer_name(pcie->id_reset_gpio[i],
+						pcie->reset_names[i]);
 		}
 	}
 
@@ -467,14 +479,11 @@ static long kirin_pcie_get_resource(struct kirin_pcie *kirin_pcie,
 		return PTR_ERR(kirin_pcie->apb);
 
 	/* pcie internal PERST# gpio */
-	kirin_pcie->gpio_id_dwc_perst = of_get_named_gpio(dev->of_node,
-							  "reset-gpios", 0);
-	if (kirin_pcie->gpio_id_dwc_perst == -EPROBE_DEFER) {
-		return -EPROBE_DEFER;
-	} else if (!gpio_is_valid(kirin_pcie->gpio_id_dwc_perst)) {
-		dev_err(dev, "unable to get a valid gpio pin\n");
-		return -ENODEV;
-	}
+	kirin_pcie->id_dwc_perst_gpio = devm_gpiod_get(dev, "reset", GPIOD_ASIS);
+	if (IS_ERR(kirin_pcie->id_dwc_perst_gpio))
+		return dev_err_probe(dev, PTR_ERR(kirin_pcie->id_dwc_perst_gpio),
+				     "unable to get a valid gpio pin\n");
+	gpiod_set_consumer_name(kirin_pcie->id_dwc_perst_gpio, "pcie_perst_bridge");
 
 	ret = kirin_pcie_get_gpio_enable(kirin_pcie, pdev);
 	if (ret)
@@ -557,7 +566,7 @@ static int kirin_pcie_add_bus(struct pci_bus *bus)
 
 	/* Send PERST# to each slot */
 	for (i = 0; i < kirin_pcie->num_slots; i++) {
-		ret = gpio_direction_output(kirin_pcie->gpio_id_reset[i], 1);
+		ret = gpiod_direction_output_raw(kirin_pcie->id_reset_gpio[i], 1);
 		if (ret) {
 			dev_err(pci->dev, "PERST# %s error: %d\n",
 				kirin_pcie->reset_names[i], ret);
@@ -627,44 +636,6 @@ static int kirin_pcie_host_init(struct dw_pcie_rp *pp)
 	return 0;
 }
 
-static int kirin_pcie_gpio_request(struct kirin_pcie *kirin_pcie,
-				   struct device *dev)
-{
-	int ret, i;
-
-	for (i = 0; i < kirin_pcie->num_slots; i++) {
-		if (!gpio_is_valid(kirin_pcie->gpio_id_reset[i])) {
-			dev_err(dev, "unable to get a valid %s gpio\n",
-				kirin_pcie->reset_names[i]);
-			return -ENODEV;
-		}
-
-		ret = devm_gpio_request(dev, kirin_pcie->gpio_id_reset[i],
-					kirin_pcie->reset_names[i]);
-		if (ret)
-			return ret;
-	}
-
-	for (i = 0; i < kirin_pcie->n_gpio_clkreq; i++) {
-		if (!gpio_is_valid(kirin_pcie->gpio_id_clkreq[i])) {
-			dev_err(dev, "unable to get a valid %s gpio\n",
-				kirin_pcie->clkreq_names[i]);
-			return -ENODEV;
-		}
-
-		ret = devm_gpio_request(dev, kirin_pcie->gpio_id_clkreq[i],
-					kirin_pcie->clkreq_names[i]);
-		if (ret)
-			return ret;
-
-		ret = gpio_direction_output(kirin_pcie->gpio_id_clkreq[i], 0);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
 static const struct dw_pcie_ops kirin_dw_pcie_ops = {
 	.read_dbi = kirin_pcie_read_dbi,
 	.write_dbi = kirin_pcie_write_dbi,
@@ -684,7 +655,7 @@ static int kirin_pcie_power_off(struct kirin_pcie *kirin_pcie)
 		return hi3660_pcie_phy_power_off(kirin_pcie);
 
 	for (i = 0; i < kirin_pcie->n_gpio_clkreq; i++)
-		gpio_direction_output(kirin_pcie->gpio_id_clkreq[i], 1);
+		gpiod_direction_output_raw(kirin_pcie->id_clkreq_gpio[i], 1);
 
 	phy_power_off(kirin_pcie->phy);
 	phy_exit(kirin_pcie->phy);
@@ -711,10 +682,6 @@ static int kirin_pcie_power_on(struct platform_device *pdev,
 		if (IS_ERR(kirin_pcie->phy))
 			return PTR_ERR(kirin_pcie->phy);
 
-		ret = kirin_pcie_gpio_request(kirin_pcie, dev);
-		if (ret)
-			return ret;
-
 		ret = phy_init(kirin_pcie->phy);
 		if (ret)
 			goto err;
@@ -727,11 +694,9 @@ static int kirin_pcie_power_on(struct platform_device *pdev,
 	/* perst assert Endpoint */
 	usleep_range(REF_2_PERST_MIN, REF_2_PERST_MAX);
 
-	if (!gpio_request(kirin_pcie->gpio_id_dwc_perst, "pcie_perst_bridge")) {
-		ret = gpio_direction_output(kirin_pcie->gpio_id_dwc_perst, 1);
-		if (ret)
-			goto err;
-	}
+	ret = gpiod_direction_output_raw(kirin_pcie->id_dwc_perst_gpio, 1);
+	if (ret)
+		goto err;
 
 	usleep_range(PERST_2_ACCESS_MIN, PERST_2_ACCESS_MAX);
 
-- 
2.39.1


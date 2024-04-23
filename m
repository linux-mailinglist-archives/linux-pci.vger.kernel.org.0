Return-Path: <linux-pci+bounces-6588-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 595018AF55B
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 19:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DDF11C220FC
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 17:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D0A13E8B8;
	Tue, 23 Apr 2024 17:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wdn4A8IU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCFA13DBBC;
	Tue, 23 Apr 2024 17:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713892943; cv=none; b=RUw5LSuMQAZqmjiESBZVhls2moePSQ00PE/xBqHsttmwB+jdrMV0NKrX2T8+SjKFgdZOHhWiaX+tJZxS/Uu8Oxw1Iv04MmA+qId925odi6sk8yYA4An2zBR2MnuMAZA8PailjcVWdGvYcNQfS9H+Js2qETyv6D2DXUhPKG1iZeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713892943; c=relaxed/simple;
	bh=HQ0CAMpENoxRAc45GVnSnQeccFUmQ6Kcw6VpvHptE3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nFOycIKP64202lGXUj3LJ2guQNflxafuu1nobYaAbPpPJA6A4DDiyUTk/gRwBO9bbQiSc6GrkQklMqL2uNPi5vPR9sX7/RAhOWE9jw3hmyHFFEJ6PjhtuXP46CiQp12rTHFiztMXlawPPVL2GZBLhN3RqXT+Nd7LJHrgMooWoBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wdn4A8IU; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713892942; x=1745428942;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HQ0CAMpENoxRAc45GVnSnQeccFUmQ6Kcw6VpvHptE3E=;
  b=Wdn4A8IU8h6wQ3tNKkAob0g0MtX967bWidFVjxRxyJJbHYpuAnrfSwsC
   7pnns5AUyagClPW4SzNbmb6b21ptj301ktuxTxAFCLjdcfj1HwU8x4SzL
   eOdA9vQY2HhgpRnYlQINQ45rrV3LxdHXrzNPdJu1Y3R4G2vYa6k6Z6FMo
   ZJKHj8aRSu4ZDkC9wLIEuh6Y5hyuGldCEhWwEyt4drcgW8vlmh5fVz3YR
   ewm225JBVWRcVfr2JWPkjy7CmqVKV8giVK+OOpfkULxBMUh66y/TTq4Ka
   Ikd2xg1aqgBkvYljKjEim2V3/7A/G/4IgH7wQlLr/iMKAqiHIUbzaR07c
   w==;
X-CSE-ConnectionGUID: 5LzHQR05SqW6Xcqr/s06fg==
X-CSE-MsgGUID: 3GMLPa4wRGqA9GIwlaFRkg==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="20911805"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="20911805"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 10:22:20 -0700
X-CSE-ConnectionGUID: D2LsbMA/T0SHx+Ukn/Iubg==
X-CSE-MsgGUID: 3YywkTJMRTOlXe+oPfquJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="25051426"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 23 Apr 2024 10:22:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id A611D51E; Tue, 23 Apr 2024 20:22:10 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Frank Li <Frank.Li@nxp.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-omap@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-amlogic@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-tegra@vger.kernel.org
Cc: Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Yue Wang <yue.wang@Amlogic.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Xiaowei Song <songxiaowei@hisilicon.com>,
	Binghui Wang <wangbinghui@hisilicon.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Subject: [PATCH v2 4/4] PCI: kirin: Convert to agnostic GPIO API
Date: Tue, 23 Apr 2024 20:19:07 +0300
Message-ID: <20240423172208.2723892-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240423172208.2723892-1-andriy.shevchenko@linux.intel.com>
References: <20240423172208.2723892-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The of_gpio.h is going to be removed. In preparation of that convert
the driver to the agnostic API.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pcie-kirin.c | 105 ++++++++----------------
 1 file changed, 35 insertions(+), 70 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index d5523f302102..1753ab63a541 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -12,12 +12,10 @@
 #include <linux/compiler.h>
 #include <linux/delay.h>
 #include <linux/err.h>
-#include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/mfd/syscon.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/of_pci.h>
 #include <linux/phy/phy.h>
 #include <linux/pci.h>
@@ -78,16 +76,16 @@ struct kirin_pcie {
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
 
@@ -381,15 +379,20 @@ static int kirin_pcie_get_gpio_enable(struct kirin_pcie *pcie,
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
 
 		pcie->clkreq_names[i] = devm_kasprintf(dev, GFP_KERNEL,
 						       "pcie_clkreq_%d", i);
 		if (!pcie->clkreq_names[i])
 			return -ENOMEM;
+
+		gpiod_set_consumer_name(pcie->id_clkreq_gpio[i],
+					pcie->clkreq_names[i]);
 	}
 
 	return 0;
@@ -407,10 +410,16 @@ static int kirin_pcie_parse_port(struct kirin_pcie *pcie,
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
@@ -434,6 +443,9 @@ static int kirin_pcie_parse_port(struct kirin_pcie *pcie,
 				ret = -ENOMEM;
 				goto put_node;
 			}
+
+			gpiod_set_consumer_name(pcie->id_reset_gpio[i],
+						pcie->reset_names[i]);
 		}
 	}
 
@@ -463,14 +475,11 @@ static long kirin_pcie_get_resource(struct kirin_pcie *kirin_pcie,
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
@@ -553,7 +562,7 @@ static int kirin_pcie_add_bus(struct pci_bus *bus)
 
 	/* Send PERST# to each slot */
 	for (i = 0; i < kirin_pcie->num_slots; i++) {
-		ret = gpio_direction_output(kirin_pcie->gpio_id_reset[i], 1);
+		ret = gpiod_direction_output_raw(kirin_pcie->id_reset_gpio[i], 1);
 		if (ret) {
 			dev_err(pci->dev, "PERST# %s error: %d\n",
 				kirin_pcie->reset_names[i], ret);
@@ -623,44 +632,6 @@ static int kirin_pcie_host_init(struct dw_pcie_rp *pp)
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
@@ -680,7 +651,7 @@ static int kirin_pcie_power_off(struct kirin_pcie *kirin_pcie)
 		return hi3660_pcie_phy_power_off(kirin_pcie);
 
 	for (i = 0; i < kirin_pcie->n_gpio_clkreq; i++)
-		gpio_direction_output(kirin_pcie->gpio_id_clkreq[i], 1);
+		gpiod_direction_output_raw(kirin_pcie->id_clkreq_gpio[i], 1);
 
 	phy_power_off(kirin_pcie->phy);
 	phy_exit(kirin_pcie->phy);
@@ -707,10 +678,6 @@ static int kirin_pcie_power_on(struct platform_device *pdev,
 		if (IS_ERR(kirin_pcie->phy))
 			return PTR_ERR(kirin_pcie->phy);
 
-		ret = kirin_pcie_gpio_request(kirin_pcie, dev);
-		if (ret)
-			return ret;
-
 		ret = phy_init(kirin_pcie->phy);
 		if (ret)
 			goto err;
@@ -723,11 +690,9 @@ static int kirin_pcie_power_on(struct platform_device *pdev,
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
2.43.0.rc1.1336.g36b5255a03ac



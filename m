Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 389E145A6A3
	for <lists+linux-pci@lfdr.de>; Tue, 23 Nov 2021 16:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237091AbhKWPlz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Nov 2021 10:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235579AbhKWPlz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Nov 2021 10:41:55 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED68C061574
        for <linux-pci@vger.kernel.org>; Tue, 23 Nov 2021 07:38:46 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id y196so19093960wmc.3
        for <linux-pci@vger.kernel.org>; Tue, 23 Nov 2021 07:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wh0t/nsEHRHzz0cZsWKJSUP5tQmkKZLzbQrhPq++SSA=;
        b=akzt58KULwtXIlClMnq8hPC+4eelEZxdlwOrpWE40nI6/wviijgqjKjwGkcd5+8xKS
         zG5VBIDj2tSwT8rbN9Uyg244BIAJybDe4ERG+3gtpq8Fk4ASuqxyFHD2Zje7TS7AypGY
         BvFgNIPDO+gaKlg8qFLsXVTowF1aPivwuvl7FJk6pNCPoD0BsrzKd5J9xeYi/SwHkcyA
         WqFbhnwX157069mLpGnaQeTD28a3obUr5IPjKqPuGdoXReO/OXKxbeSySIwsMUo7PRxw
         I788eMCDEwFklpdQNGoZUyIoJuUHFWOPo3HxnECZlW/j3U5AwdJ93Wd7z0vzxTheopHX
         0pAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wh0t/nsEHRHzz0cZsWKJSUP5tQmkKZLzbQrhPq++SSA=;
        b=cZwdzukWx79ZU6+8wDojo45T2WKlhYWxdpz/lJrlYnk3Efrioh0WSNr8SmTvhnLMFd
         44E0DQoD5qdu5PsN8R87JKTZYGf3BIoasRHSGqYrliqiRAQfQ8GyAaOa4021hxfPCXbM
         zFDD5lGJ/WuPO+5mps0QW24Q51NBOY3Vb3t5UvcR/2S0hn9WeqHWFBGWq0YSmEtTpAKS
         BT4QVMWJPKiVY1TICtquMqWD+Tbv/nMkFujGeD4Du2wZNX7/TpdacRZ3TFAKimVJZuJz
         bZ8tF4hkneawkOmuySklykcdzsjmZciWOc4dV4wxGvzdtMmOF/qm5FMKc9r3NVXF7XFo
         WfWw==
X-Gm-Message-State: AOAM532Fj3PnD2erlIWamk0dp+/aa7gXGUUkaIkjRS0i/XApEgwzmcql
        /5y6JwFemb5c5dgxxLudgqo=
X-Google-Smtp-Source: ABdhPJzSAJDkqdy4/QH27YmxiaaMMv7cuMtk/YcFw8ou3LsbGyXnTlMd1pi90aRV8KxUU0aA4jmqDw==
X-Received: by 2002:a05:600c:2c4a:: with SMTP id r10mr4282332wmg.125.1637681925101;
        Tue, 23 Nov 2021 07:38:45 -0800 (PST)
Received: from claire-ThinkPad-T470.localdomain (dynamic-2a01-0c23-b916-4400-b786-57bd-b8fa-4b8b.c23.pool.telefonica.de. [2a01:c23:b916:4400:b786:57bd:b8fa:4b8b])
        by smtp.gmail.com with ESMTPSA id g5sm18281696wri.45.2021.11.23.07.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 07:38:44 -0800 (PST)
From:   Fan Fei <ffclaire1224@gmail.com>
To:     bjorn@helgaas.com
Cc:     Fan Fei <ffclaire1224@gmail.com>, linux-pci@vger.kernel.org
Subject: [PATCH 2/4] PCI: tegra194: Remove device * in struct
Date:   Tue, 23 Nov 2021 16:38:36 +0100
Message-Id: <d2d185497d7045cbeda813bc107195c35b2336c2.1637533108.git.ffclaire1224@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1637533108.git.ffclaire1224@gmail.com>
References: <cover.1637533108.git.ffclaire1224@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove "device *" in struct tegra194_pcie because it refers struct dw_pcie,
which contains a "device *" already.

Signed-off-by: Fan Fei <ffclaire1224@gmail.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 109 +++++++++++----------
 1 file changed, 59 insertions(+), 50 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 9e4f140f8aff..44eba86b700c 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -246,7 +246,6 @@ static const unsigned int pcie_gen_freq[] = {
 };
 
 struct tegra194_pcie {
-	struct device *dev;
 	struct resource *appl_res;
 	struct resource *dbi_res;
 	struct resource *atu_dma_res;
@@ -486,7 +485,7 @@ static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
 			usleep_range(1000, 1100);
 		}
 		if (val & APPL_LTR_MSG_2_LTR_MSG_REQ_STATE)
-			dev_err(pcie->dev, "Failed to send LTR message\n");
+			dev_err(pcie->pci.dev, "Failed to send LTR message\n");
 	}
 
 	return IRQ_HANDLED;
@@ -495,6 +494,7 @@ static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
 static irqreturn_t tegra_pcie_ep_hard_irq(int irq, void *arg)
 {
 	struct tegra194_pcie *pcie = arg;
+	struct device *dev = pcie->pci.dev;
 	struct dw_pcie_ep *ep = &pcie->pci.ep;
 	int spurious = 1;
 	u32 status_l0, status_l1, link_status;
@@ -510,7 +510,7 @@ static irqreturn_t tegra_pcie_ep_hard_irq(int irq, void *arg)
 		if (status_l1 & APPL_INTR_STATUS_L1_0_0_RDLH_LINK_UP_CHGED) {
 			link_status = appl_readl(pcie, APPL_LINK_STATUS);
 			if (link_status & APPL_LINK_STATUS_RDLH_LINK_UP) {
-				dev_dbg(pcie->dev, "Link is up with Host\n");
+				dev_dbg(dev, "Link is up with Host\n");
 				dw_pcie_ep_linkup(ep);
 			}
 		}
@@ -529,7 +529,7 @@ static irqreturn_t tegra_pcie_ep_hard_irq(int irq, void *arg)
 	}
 
 	if (spurious) {
-		dev_warn(pcie->dev, "Random interrupt (STATUS = 0x%08X)\n",
+		dev_warn(dev, "Random interrupt (STATUS = 0x%08X)\n",
 			 status_l0);
 		appl_writel(pcie, status_l0, APPL_INTR_STATUS_L0);
 	}
@@ -690,7 +690,7 @@ static void init_host_aspm(struct tegra194_pcie *pcie)
 
 static void init_debugfs(struct tegra194_pcie *pcie)
 {
-	debugfs_create_devm_seqfile(pcie->dev, "aspm_state_cnt", pcie->debugfs,
+	debugfs_create_devm_seqfile(pcie->pci.dev, "aspm_state_cnt", pcie->debugfs,
 				    aspm_state_cnt);
 }
 #else
@@ -1062,49 +1062,50 @@ static int tegra_pcie_enable_phy(struct tegra194_pcie *pcie)
 
 static int tegra_pcie_dw_parse_dt(struct tegra194_pcie *pcie)
 {
-	struct platform_device *pdev = to_platform_device(pcie->dev);
-	struct device_node *np = pcie->dev->of_node;
+	struct device *dev = pcie->pci.dev;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct device_node *np = dev->of_node;
 	int ret;
 
 	pcie->dbi_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
 	if (!pcie->dbi_res) {
-		dev_err(pcie->dev, "Failed to find \"dbi\" region\n");
+		dev_err(dev, "Failed to find \"dbi\" region\n");
 		return -ENODEV;
 	}
 
 	ret = of_property_read_u32(np, "nvidia,aspm-cmrt-us", &pcie->aspm_cmrt);
 	if (ret < 0) {
-		dev_info(pcie->dev, "Failed to read ASPM T_cmrt: %d\n", ret);
+		dev_info(dev, "Failed to read ASPM T_cmrt: %d\n", ret);
 		return ret;
 	}
 
 	ret = of_property_read_u32(np, "nvidia,aspm-pwr-on-t-us",
 				   &pcie->aspm_pwr_on_t);
 	if (ret < 0)
-		dev_info(pcie->dev, "Failed to read ASPM Power On time: %d\n",
+		dev_info(dev, "Failed to read ASPM Power On time: %d\n",
 			 ret);
 
 	ret = of_property_read_u32(np, "nvidia,aspm-l0s-entrance-latency-us",
 				   &pcie->aspm_l0s_enter_lat);
 	if (ret < 0)
-		dev_info(pcie->dev,
+		dev_info(dev,
 			 "Failed to read ASPM L0s Entrance latency: %d\n", ret);
 
 	ret = of_property_read_u32(np, "num-lanes", &pcie->num_lanes);
 	if (ret < 0) {
-		dev_err(pcie->dev, "Failed to read num-lanes: %d\n", ret);
+		dev_err(dev, "Failed to read num-lanes: %d\n", ret);
 		return ret;
 	}
 
 	ret = of_property_read_u32_index(np, "nvidia,bpmp", 1, &pcie->cid);
 	if (ret) {
-		dev_err(pcie->dev, "Failed to read Controller-ID: %d\n", ret);
+		dev_err(dev, "Failed to read Controller-ID: %d\n", ret);
 		return ret;
 	}
 
 	ret = of_property_count_strings(np, "phy-names");
 	if (ret < 0) {
-		dev_err(pcie->dev, "Failed to find PHY entries: %d\n",
+		dev_err(dev, "Failed to find PHY entries: %d\n",
 			ret);
 		return ret;
 	}
@@ -1114,7 +1115,7 @@ static int tegra_pcie_dw_parse_dt(struct tegra194_pcie *pcie)
 		pcie->update_fc_fixup = true;
 
 	pcie->supports_clkreq =
-		of_property_read_bool(pcie->dev->of_node, "supports-clkreq");
+		of_property_read_bool(dev->of_node, "supports-clkreq");
 
 	pcie->enable_cdm_check =
 		of_property_read_bool(np, "snps,enable-cdm-check");
@@ -1123,7 +1124,7 @@ static int tegra_pcie_dw_parse_dt(struct tegra194_pcie *pcie)
 		return 0;
 
 	/* Endpoint mode specific DT entries */
-	pcie->pex_rst_gpiod = devm_gpiod_get(pcie->dev, "reset", GPIOD_IN);
+	pcie->pex_rst_gpiod = devm_gpiod_get(dev, "reset", GPIOD_IN);
 	if (IS_ERR(pcie->pex_rst_gpiod)) {
 		int err = PTR_ERR(pcie->pex_rst_gpiod);
 		const char *level = KERN_ERR;
@@ -1131,13 +1132,13 @@ static int tegra_pcie_dw_parse_dt(struct tegra194_pcie *pcie)
 		if (err == -EPROBE_DEFER)
 			level = KERN_DEBUG;
 
-		dev_printk(level, pcie->dev,
+		dev_printk(level, dev,
 			   dev_fmt("Failed to get PERST GPIO: %d\n"),
 			   err);
 		return err;
 	}
 
-	pcie->pex_refclk_sel_gpiod = devm_gpiod_get(pcie->dev,
+	pcie->pex_refclk_sel_gpiod = devm_gpiod_get(dev,
 						    "nvidia,refclk-select",
 						    GPIOD_OUT_HIGH);
 	if (IS_ERR(pcie->pex_refclk_sel_gpiod)) {
@@ -1147,7 +1148,7 @@ static int tegra_pcie_dw_parse_dt(struct tegra194_pcie *pcie)
 		if (err == -EPROBE_DEFER)
 			level = KERN_DEBUG;
 
-		dev_printk(level, pcie->dev,
+		dev_printk(level, dev,
 			   dev_fmt("Failed to get REFCLK select GPIOs: %d\n"),
 			   err);
 		pcie->pex_refclk_sel_gpiod = NULL;
@@ -1215,6 +1216,7 @@ static int tegra_pcie_bpmp_set_pll_state(struct tegra194_pcie *pcie,
 static void tegra_pcie_downstream_dev_to_D0(struct tegra194_pcie *pcie)
 {
 	struct pcie_port *pp = &pcie->pci.pp;
+	struct device *dev = pcie->pci.dev;
 	struct pci_bus *child, *root_bus = NULL;
 	struct pci_dev *pdev;
 
@@ -1236,23 +1238,25 @@ static void tegra_pcie_downstream_dev_to_D0(struct tegra194_pcie *pcie)
 	}
 
 	if (!root_bus) {
-		dev_err(pcie->dev, "Failed to find downstream devices\n");
+		dev_err(dev, "Failed to find downstream devices\n");
 		return;
 	}
 
 	list_for_each_entry(pdev, &root_bus->devices, bus_list) {
 		if (PCI_SLOT(pdev->devfn) == 0) {
 			if (pci_set_power_state(pdev, PCI_D0))
-				dev_err(pcie->dev,
+				dev_err(dev,
 					"Failed to transition %s to D0 state\n",
-					dev_name(&pdev->dev));
+					dev_name(dev));
 		}
 	}
 }
 
 static int tegra_pcie_get_slot_regulators(struct tegra194_pcie *pcie)
 {
-	pcie->slot_ctl_3v3 = devm_regulator_get_optional(pcie->dev, "vpcie3v3");
+	struct device *dev = pcie->pci.dev;
+
+	pcie->slot_ctl_3v3 = devm_regulator_get_optional(dev, "vpcie3v3");
 	if (IS_ERR(pcie->slot_ctl_3v3)) {
 		if (PTR_ERR(pcie->slot_ctl_3v3) != -ENODEV)
 			return PTR_ERR(pcie->slot_ctl_3v3);
@@ -1260,7 +1264,7 @@ static int tegra_pcie_get_slot_regulators(struct tegra194_pcie *pcie)
 		pcie->slot_ctl_3v3 = NULL;
 	}
 
-	pcie->slot_ctl_12v = devm_regulator_get_optional(pcie->dev, "vpcie12v");
+	pcie->slot_ctl_12v = devm_regulator_get_optional(dev, "vpcie12v");
 	if (IS_ERR(pcie->slot_ctl_12v)) {
 		if (PTR_ERR(pcie->slot_ctl_12v) != -ENODEV)
 			return PTR_ERR(pcie->slot_ctl_12v);
@@ -1273,12 +1277,13 @@ static int tegra_pcie_get_slot_regulators(struct tegra194_pcie *pcie)
 
 static int tegra_pcie_enable_slot_regulators(struct tegra194_pcie *pcie)
 {
+	struct device *dev = pcie->pci.dev;
 	int ret;
 
 	if (pcie->slot_ctl_3v3) {
 		ret = regulator_enable(pcie->slot_ctl_3v3);
 		if (ret < 0) {
-			dev_err(pcie->dev,
+			dev_err(dev,
 				"Failed to enable 3.3V slot supply: %d\n", ret);
 			return ret;
 		}
@@ -1287,7 +1292,7 @@ static int tegra_pcie_enable_slot_regulators(struct tegra194_pcie *pcie)
 	if (pcie->slot_ctl_12v) {
 		ret = regulator_enable(pcie->slot_ctl_12v);
 		if (ret < 0) {
-			dev_err(pcie->dev,
+			dev_err(dev,
 				"Failed to enable 12V slot supply: %d\n", ret);
 			goto fail_12v_enable;
 		}
@@ -1322,10 +1327,11 @@ static int tegra_pcie_config_controller(struct tegra194_pcie *pcie,
 {
 	int ret;
 	u32 val;
+	struct device *dev = pcie->pci.dev;
 
 	ret = tegra_pcie_bpmp_set_ctrl_state(pcie, true);
 	if (ret) {
-		dev_err(pcie->dev,
+		dev_err(dev,
 			"Failed to enable controller %u: %d\n", pcie->cid, ret);
 		return ret;
 	}
@@ -1336,19 +1342,19 @@ static int tegra_pcie_config_controller(struct tegra194_pcie *pcie,
 
 	ret = regulator_enable(pcie->pex_ctl_supply);
 	if (ret < 0) {
-		dev_err(pcie->dev, "Failed to enable regulator: %d\n", ret);
+		dev_err(dev, "Failed to enable regulator: %d\n", ret);
 		goto fail_reg_en;
 	}
 
 	ret = clk_prepare_enable(pcie->core_clk);
 	if (ret) {
-		dev_err(pcie->dev, "Failed to enable core clock: %d\n", ret);
+		dev_err(dev, "Failed to enable core clock: %d\n", ret);
 		goto fail_core_clk;
 	}
 
 	ret = reset_control_deassert(pcie->core_apb_rst);
 	if (ret) {
-		dev_err(pcie->dev, "Failed to deassert core APB reset: %d\n",
+		dev_err(dev, "Failed to deassert core APB reset: %d\n",
 			ret);
 		goto fail_core_apb_rst;
 	}
@@ -1364,7 +1370,7 @@ static int tegra_pcie_config_controller(struct tegra194_pcie *pcie,
 
 	ret = tegra_pcie_enable_phy(pcie);
 	if (ret) {
-		dev_err(pcie->dev, "Failed to enable PHY: %d\n", ret);
+		dev_err(dev, "Failed to enable PHY: %d\n", ret);
 		goto fail_phy;
 	}
 
@@ -1417,28 +1423,29 @@ static int tegra_pcie_config_controller(struct tegra194_pcie *pcie,
 static void tegra_pcie_unconfig_controller(struct tegra194_pcie *pcie)
 {
 	int ret;
+	struct device *dev = pcie->pci.dev;
 
 	ret = reset_control_assert(pcie->core_rst);
 	if (ret)
-		dev_err(pcie->dev, "Failed to assert \"core\" reset: %d\n", ret);
+		dev_err(dev, "Failed to assert \"core\" reset: %d\n", ret);
 
 	tegra_pcie_disable_phy(pcie);
 
 	ret = reset_control_assert(pcie->core_apb_rst);
 	if (ret)
-		dev_err(pcie->dev, "Failed to assert APB reset: %d\n", ret);
+		dev_err(dev, "Failed to assert APB reset: %d\n", ret);
 
 	clk_disable_unprepare(pcie->core_clk);
 
 	ret = regulator_disable(pcie->pex_ctl_supply);
 	if (ret)
-		dev_err(pcie->dev, "Failed to disable regulator: %d\n", ret);
+		dev_err(dev, "Failed to disable regulator: %d\n", ret);
 
 	tegra_pcie_disable_slot_regulators(pcie);
 
 	ret = tegra_pcie_bpmp_set_ctrl_state(pcie, false);
 	if (ret)
-		dev_err(pcie->dev, "Failed to disable controller %d: %d\n",
+		dev_err(dev, "Failed to disable controller %d: %d\n",
 			pcie->cid, ret);
 }
 
@@ -1456,7 +1463,7 @@ static int tegra_pcie_init_controller(struct tegra194_pcie *pcie)
 
 	ret = dw_pcie_host_init(pp);
 	if (ret < 0) {
-		dev_err(pcie->dev, "Failed to add PCIe port: %d\n", ret);
+		dev_err(pci->dev, "Failed to add PCIe port: %d\n", ret);
 		goto fail_host_init;
 	}
 
@@ -1485,11 +1492,12 @@ static int tegra_pcie_try_link_l2(struct tegra194_pcie *pcie)
 
 static void tegra_pcie_dw_pme_turnoff(struct tegra194_pcie *pcie)
 {
+	struct device *dev = pcie->pci.dev;
 	u32 data;
 	int err;
 
 	if (!tegra_pcie_dw_link_up(&pcie->pci)) {
-		dev_dbg(pcie->dev, "PCIe link is not up...!\n");
+		dev_dbg(dev, "PCIe link is not up...!\n");
 		return;
 	}
 
@@ -1504,7 +1512,7 @@ static void tegra_pcie_dw_pme_turnoff(struct tegra194_pcie *pcie)
 	appl_writel(pcie, 0x0, APPL_INTR_EN_L0_0);
 
 	if (tegra_pcie_try_link_l2(pcie)) {
-		dev_info(pcie->dev, "Link didn't transition to L2 state\n");
+		dev_info(dev, "Link didn't transition to L2 state\n");
 		/*
 		 * TX lane clock freq will reset to Gen1 only if link is in L2
 		 * or detect state.
@@ -1531,7 +1539,7 @@ static void tegra_pcie_dw_pme_turnoff(struct tegra194_pcie *pcie)
 						LTSSM_STATE_PRE_DETECT,
 						1, LTSSM_TIMEOUT);
 		if (err)
-			dev_info(pcie->dev, "Link didn't go to detect state\n");
+			dev_info(dev, "Link didn't go to detect state\n");
 	}
 	/*
 	 * DBI registers may not be accessible after this as PLL-E would be
@@ -1555,7 +1563,7 @@ static void tegra_pcie_deinit_controller(struct tegra194_pcie *pcie)
 
 static int tegra_pcie_config_rp(struct tegra194_pcie *pcie)
 {
-	struct device *dev = pcie->dev;
+	struct device *dev = pcie->pci.dev;
 	char *name;
 	int ret;
 
@@ -1609,6 +1617,7 @@ static void pex_ep_event_pex_rst_assert(struct tegra194_pcie *pcie)
 {
 	u32 val;
 	int ret;
+	struct device *dev = pcie->pci.dev;
 
 	if (pcie->ep_state == EP_STATE_DISABLED)
 		return;
@@ -1624,7 +1633,7 @@ static void pex_ep_event_pex_rst_assert(struct tegra194_pcie *pcie)
 				 LTSSM_STATE_PRE_DETECT,
 				 1, LTSSM_TIMEOUT);
 	if (ret)
-		dev_err(pcie->dev, "Failed to go Detect state: %d\n", ret);
+		dev_err(dev, "Failed to go Detect state: %d\n", ret);
 
 	reset_control_assert(pcie->core_rst);
 
@@ -1634,21 +1643,21 @@ static void pex_ep_event_pex_rst_assert(struct tegra194_pcie *pcie)
 
 	clk_disable_unprepare(pcie->core_clk);
 
-	pm_runtime_put_sync(pcie->dev);
+	pm_runtime_put_sync(dev);
 
 	ret = tegra_pcie_bpmp_set_pll_state(pcie, false);
 	if (ret)
-		dev_err(pcie->dev, "Failed to turn off UPHY: %d\n", ret);
+		dev_err(dev, "Failed to turn off UPHY: %d\n", ret);
 
 	pcie->ep_state = EP_STATE_DISABLED;
-	dev_dbg(pcie->dev, "Uninitialization of endpoint is completed\n");
+	dev_dbg(dev, "Uninitialization of endpoint is completed\n");
 }
 
 static void pex_ep_event_pex_rst_deassert(struct tegra194_pcie *pcie)
 {
 	struct dw_pcie *pci = &pcie->pci;
 	struct dw_pcie_ep *ep = &pci->ep;
-	struct device *dev = pcie->dev;
+	struct device *dev = pcie->pci.dev;
 	u32 val;
 	int ret;
 
@@ -1900,7 +1909,7 @@ static int tegra_pcie_config_ep(struct tegra194_pcie *pcie,
 				struct platform_device *pdev)
 {
 	struct dw_pcie *pci = &pcie->pci;
-	struct device *dev = pcie->dev;
+	struct device *dev = pci->dev;
 	struct dw_pcie_ep *ep;
 	char *name;
 	int ret;
@@ -1977,7 +1986,7 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	pci = &pcie->pci;
-	pci->dev = &pdev->dev;
+	pci->dev = dev;
 	pci->ops = &tegra_dw_pcie_ops;
 	pci->n_fts[0] = N_FTS_VAL;
 	pci->n_fts[1] = FTS_VAL;
@@ -1985,7 +1994,6 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 
 	pp = &pci->pp;
 	pp->num_vectors = MAX_MSI_IRQS;
-	pcie->dev = &pdev->dev;
 	pcie->mode = (enum dw_pcie_device_mode)data->mode;
 
 	ret = tegra_pcie_dw_parse_dt(pcie);
@@ -2148,6 +2156,7 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 
 static int tegra_pcie_dw_remove(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct tegra194_pcie *pcie = platform_get_drvdata(pdev);
 
 	if (!pcie->link_state)
@@ -2155,8 +2164,8 @@ static int tegra_pcie_dw_remove(struct platform_device *pdev)
 
 	debugfs_remove_recursive(pcie->debugfs);
 	tegra_pcie_deinit_controller(pcie);
-	pm_runtime_put_sync(pcie->dev);
-	pm_runtime_disable(pcie->dev);
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
 	tegra_bpmp_put(pcie->bpmp);
 	if (pcie->pex_refclk_sel_gpiod)
 		gpiod_set_value(pcie->pex_refclk_sel_gpiod, 0);
-- 
2.25.1


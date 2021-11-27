Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1530745FF03
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 15:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244582AbhK0OKQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Nov 2021 09:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237867AbhK0OIQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Nov 2021 09:08:16 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC73C061758
        for <linux-pci@vger.kernel.org>; Sat, 27 Nov 2021 06:05:01 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id p27-20020a05600c1d9b00b0033bf8532855so8678242wms.3
        for <linux-pci@vger.kernel.org>; Sat, 27 Nov 2021 06:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U3uaYTgTa9MjvCZttNhR23oLmD89ZxoFQWsGmvmVB9A=;
        b=KwPdTrOc06mYEaZ0eQSd2Wfy9ZzImQVg9kcoDDqxV6HRmXqXkpOlx+nZxClWUyrO86
         sd/qqviF766IXk0BgQEBTI9njhBjErWBiKcTPPI17DPEvCrPJarALA3bCwnq11UAOY9L
         KaTqeQOKUZnNuHjcZIpPFeDCFhh/CCWaycD+AVRUyNb7lCayC821HmIqMtDh3lJAWyz3
         +25Xq4X1wDa7r98z87No7x8p+tfeP/espe4zEjrq/pKAVAFu3pGI03XihKQeKYcNRGDf
         ftN6nmqtm6xvpEFYM4YpWQqSYgYE97IUV93MAmrzpfmMrkRXBZmCsYV7OVGRNTwxdFhF
         m8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U3uaYTgTa9MjvCZttNhR23oLmD89ZxoFQWsGmvmVB9A=;
        b=zBRx32l3S/SsxpirW2Wbv8tOiJFAJ4oORZTSixPO0q3nl/UfYV03Ilikn2inb0WqBH
         BuNSIHGhmpXzO01z+CLQzE2JjqnPY9kW5WvsKY1Whz+esr7T1oYjgCCXw59VeOKRQWZw
         iAmeJgI5Tah3z0NV/wHuoh/keZun+UZ8GIvXdVVTLXgpoTZWphRbuiHo+W7H+gjtwqHX
         mOOxi+OfLuijikZUYwj/3z7cOgXZgQeAzoCPUu6GnxHTVYIWfUp1kbBmMb5T37P6+32N
         AD+c0krZ5JTnNx2V4gViPKYFCkrPyN7dvgaqOjAxKaUORklJ42bgJ936W8iXTIDm9lT3
         DfKw==
X-Gm-Message-State: AOAM5306Q7gkMQn5I5fJhfVgH7Rlb071wvNKcMV+D4ZuLhwUddVleLbB
        1Owh+3ZnOB6OS4vk3+Bqk88=
X-Google-Smtp-Source: ABdhPJysLmEmfGq4Cplt1ZsXMqDWewO5F6XJaGDRyGSNwxcfLMJ7k4V6xs56M72S3L5rLzRC1mWsBQ==
X-Received: by 2002:a7b:c084:: with SMTP id r4mr22965419wmh.107.1638021900362;
        Sat, 27 Nov 2021 06:05:00 -0800 (PST)
Received: from claire-ThinkPad-T470.localdomain (dynamic-2a01-0c22-7349-1000-d163-c2fa-698a-934f.c22.pool.telefonica.de. [2a01:c22:7349:1000:d163:c2fa:698a:934f])
        by smtp.gmail.com with ESMTPSA id w7sm8447071wru.51.2021.11.27.06.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 06:05:00 -0800 (PST)
From:   Fan Fei <ffclaire1224@gmail.com>
To:     bjorn@helgaas.com
Cc:     Fan Fei <ffclaire1224@gmail.com>, linux-pci@vger.kernel.org
Subject: [PATCH 2/6] PCI: intel-gw: Rename struct intel_pcie_port to intel_pcie
Date:   Sat, 27 Nov 2021 15:04:39 +0100
Message-Id: <2e0c1e981e412179a27148e116d3cd5cdd9946e0.1638021831.git.ffclaire1224@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1638021831.git.ffclaire1224@gmail.com>
References: <cover.1638021831.git.ffclaire1224@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Rename struct intel_pcie_port to intel_pcie to match the convention of
<driver>_pcie. No functional change intended.

Signed-off-by: Fan Fei <ffclaire1224@gmail.com>
---
 drivers/pci/controller/dwc/pcie-intel-gw.c | 204 ++++++++++-----------
 1 file changed, 102 insertions(+), 102 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
index d15cf35fa7f2..5ba144924ff8 100644
--- a/drivers/pci/controller/dwc/pcie-intel-gw.c
+++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
@@ -62,7 +62,7 @@ struct intel_pcie_soc {
 	unsigned int	pcie_ver;
 };
 
-struct intel_pcie_port {
+struct intel_pcie {
 	struct dw_pcie		pci;
 	void __iomem		*app_base;
 	struct gpio_desc	*reset_gpio;
@@ -83,53 +83,53 @@ static void pcie_update_bits(void __iomem *base, u32 ofs, u32 mask, u32 val)
 		writel(val, base + ofs);
 }
 
-static inline void pcie_app_wr(struct intel_pcie_port *lpp, u32 ofs, u32 val)
+static inline void pcie_app_wr(struct intel_pcie *pcie, u32 ofs, u32 val)
 {
-	writel(val, lpp->app_base + ofs);
+	writel(val, pcie->app_base + ofs);
 }
 
-static void pcie_app_wr_mask(struct intel_pcie_port *lpp, u32 ofs,
+static void pcie_app_wr_mask(struct intel_pcie *pcie, u32 ofs,
 			     u32 mask, u32 val)
 {
-	pcie_update_bits(lpp->app_base, ofs, mask, val);
+	pcie_update_bits(pcie->app_base, ofs, mask, val);
 }
 
-static inline u32 pcie_rc_cfg_rd(struct intel_pcie_port *lpp, u32 ofs)
+static inline u32 pcie_rc_cfg_rd(struct intel_pcie *pcie, u32 ofs)
 {
-	return dw_pcie_readl_dbi(&lpp->pci, ofs);
+	return dw_pcie_readl_dbi(&pcie->pci, ofs);
 }
 
-static inline void pcie_rc_cfg_wr(struct intel_pcie_port *lpp, u32 ofs, u32 val)
+static inline void pcie_rc_cfg_wr(struct intel_pcie *pcie, u32 ofs, u32 val)
 {
-	dw_pcie_writel_dbi(&lpp->pci, ofs, val);
+	dw_pcie_writel_dbi(&pcie->pci, ofs, val);
 }
 
-static void pcie_rc_cfg_wr_mask(struct intel_pcie_port *lpp, u32 ofs,
+static void pcie_rc_cfg_wr_mask(struct intel_pcie *pcie, u32 ofs,
 				u32 mask, u32 val)
 {
-	pcie_update_bits(lpp->pci.dbi_base, ofs, mask, val);
+	pcie_update_bits(pcie->pci.dbi_base, ofs, mask, val);
 }
 
-static void intel_pcie_ltssm_enable(struct intel_pcie_port *lpp)
+static void intel_pcie_ltssm_enable(struct intel_pcie *pcie)
 {
-	pcie_app_wr_mask(lpp, PCIE_APP_CCR, PCIE_APP_CCR_LTSSM_ENABLE,
+	pcie_app_wr_mask(pcie, PCIE_APP_CCR, PCIE_APP_CCR_LTSSM_ENABLE,
 			 PCIE_APP_CCR_LTSSM_ENABLE);
 }
 
-static void intel_pcie_ltssm_disable(struct intel_pcie_port *lpp)
+static void intel_pcie_ltssm_disable(struct intel_pcie *pcie)
 {
-	pcie_app_wr_mask(lpp, PCIE_APP_CCR, PCIE_APP_CCR_LTSSM_ENABLE, 0);
+	pcie_app_wr_mask(pcie, PCIE_APP_CCR, PCIE_APP_CCR_LTSSM_ENABLE, 0);
 }
 
-static void intel_pcie_link_setup(struct intel_pcie_port *lpp)
+static void intel_pcie_link_setup(struct intel_pcie *pcie)
 {
 	u32 val;
-	u8 offset = dw_pcie_find_capability(&lpp->pci, PCI_CAP_ID_EXP);
+	u8 offset = dw_pcie_find_capability(&pcie->pci, PCI_CAP_ID_EXP);
 
-	val = pcie_rc_cfg_rd(lpp, offset + PCI_EXP_LNKCTL);
+	val = pcie_rc_cfg_rd(pcie, offset + PCI_EXP_LNKCTL);
 
 	val &= ~(PCI_EXP_LNKCTL_LD | PCI_EXP_LNKCTL_ASPMC);
-	pcie_rc_cfg_wr(lpp, offset + PCI_EXP_LNKCTL, val);
+	pcie_rc_cfg_wr(pcie, offset + PCI_EXP_LNKCTL, val);
 }
 
 static void intel_pcie_init_n_fts(struct dw_pcie *pci)
@@ -148,14 +148,14 @@ static void intel_pcie_init_n_fts(struct dw_pcie *pci)
 	pci->n_fts[0] = PORT_AFR_N_FTS_GEN12_DFT;
 }
 
-static int intel_pcie_ep_rst_init(struct intel_pcie_port *lpp)
+static int intel_pcie_ep_rst_init(struct intel_pcie *pcie)
 {
-	struct device *dev = lpp->pci.dev;
+	struct device *dev = pcie->pci.dev;
 	int ret;
 
-	lpp->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
-	if (IS_ERR(lpp->reset_gpio)) {
-		ret = PTR_ERR(lpp->reset_gpio);
+	pcie->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(pcie->reset_gpio)) {
+		ret = PTR_ERR(pcie->reset_gpio);
 		if (ret != -EPROBE_DEFER)
 			dev_err(dev, "Failed to request PCIe GPIO: %d\n", ret);
 		return ret;
@@ -167,19 +167,19 @@ static int intel_pcie_ep_rst_init(struct intel_pcie_port *lpp)
 	return 0;
 }
 
-static void intel_pcie_core_rst_assert(struct intel_pcie_port *lpp)
+static void intel_pcie_core_rst_assert(struct intel_pcie *pcie)
 {
-	reset_control_assert(lpp->core_rst);
+	reset_control_assert(pcie->core_rst);
 }
 
-static void intel_pcie_core_rst_deassert(struct intel_pcie_port *lpp)
+static void intel_pcie_core_rst_deassert(struct intel_pcie *pcie)
 {
 	/*
 	 * One micro-second delay to make sure the reset pulse
 	 * wide enough so that core reset is clean.
 	 */
 	udelay(1);
-	reset_control_deassert(lpp->core_rst);
+	reset_control_deassert(pcie->core_rst);
 
 	/*
 	 * Some SoC core reset also reset PHY, more delay needed
@@ -188,58 +188,58 @@ static void intel_pcie_core_rst_deassert(struct intel_pcie_port *lpp)
 	usleep_range(1000, 2000);
 }
 
-static void intel_pcie_device_rst_assert(struct intel_pcie_port *lpp)
+static void intel_pcie_device_rst_assert(struct intel_pcie *pcie)
 {
-	gpiod_set_value_cansleep(lpp->reset_gpio, 1);
+	gpiod_set_value_cansleep(pcie->reset_gpio, 1);
 }
 
-static void intel_pcie_device_rst_deassert(struct intel_pcie_port *lpp)
+static void intel_pcie_device_rst_deassert(struct intel_pcie *pcie)
 {
-	msleep(lpp->rst_intrvl);
-	gpiod_set_value_cansleep(lpp->reset_gpio, 0);
+	msleep(pcie->rst_intrvl);
+	gpiod_set_value_cansleep(pcie->reset_gpio, 0);
 }
 
-static void intel_pcie_core_irq_disable(struct intel_pcie_port *lpp)
+static void intel_pcie_core_irq_disable(struct intel_pcie *pcie)
 {
-	pcie_app_wr(lpp, PCIE_APP_IRNEN, 0);
-	pcie_app_wr(lpp, PCIE_APP_IRNCR, PCIE_APP_IRN_INT);
+	pcie_app_wr(pcie, PCIE_APP_IRNEN, 0);
+	pcie_app_wr(pcie, PCIE_APP_IRNCR, PCIE_APP_IRN_INT);
 }
 
 static int intel_pcie_get_resources(struct platform_device *pdev)
 {
-	struct intel_pcie_port *lpp = platform_get_drvdata(pdev);
-	struct dw_pcie *pci = &lpp->pci;
+	struct intel_pcie *pcie = platform_get_drvdata(pdev);
+	struct dw_pcie *pci = &pcie->pci;
 	struct device *dev = pci->dev;
 	int ret;
 
-	lpp->core_clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(lpp->core_clk)) {
-		ret = PTR_ERR(lpp->core_clk);
+	pcie->core_clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(pcie->core_clk)) {
+		ret = PTR_ERR(pcie->core_clk);
 		if (ret != -EPROBE_DEFER)
 			dev_err(dev, "Failed to get clks: %d\n", ret);
 		return ret;
 	}
 
-	lpp->core_rst = devm_reset_control_get(dev, NULL);
-	if (IS_ERR(lpp->core_rst)) {
-		ret = PTR_ERR(lpp->core_rst);
+	pcie->core_rst = devm_reset_control_get(dev, NULL);
+	if (IS_ERR(pcie->core_rst)) {
+		ret = PTR_ERR(pcie->core_rst);
 		if (ret != -EPROBE_DEFER)
 			dev_err(dev, "Failed to get resets: %d\n", ret);
 		return ret;
 	}
 
 	ret = device_property_read_u32(dev, "reset-assert-ms",
-				       &lpp->rst_intrvl);
+				       &pcie->rst_intrvl);
 	if (ret)
-		lpp->rst_intrvl = RESET_INTERVAL_MS;
+		pcie->rst_intrvl = RESET_INTERVAL_MS;
 
-	lpp->app_base = devm_platform_ioremap_resource_byname(pdev, "app");
-	if (IS_ERR(lpp->app_base))
-		return PTR_ERR(lpp->app_base);
+	pcie->app_base = devm_platform_ioremap_resource_byname(pdev, "app");
+	if (IS_ERR(pcie->app_base))
+		return PTR_ERR(pcie->app_base);
 
-	lpp->phy = devm_phy_get(dev, "pcie");
-	if (IS_ERR(lpp->phy)) {
-		ret = PTR_ERR(lpp->phy);
+	pcie->phy = devm_phy_get(dev, "pcie");
+	if (IS_ERR(pcie->phy)) {
+		ret = PTR_ERR(pcie->phy);
 		if (ret != -EPROBE_DEFER)
 			dev_err(dev, "Couldn't get pcie-phy: %d\n", ret);
 		return ret;
@@ -248,137 +248,137 @@ static int intel_pcie_get_resources(struct platform_device *pdev)
 	return 0;
 }
 
-static int intel_pcie_wait_l2(struct intel_pcie_port *lpp)
+static int intel_pcie_wait_l2(struct intel_pcie *pcie)
 {
 	u32 value;
 	int ret;
-	struct dw_pcie *pci = &lpp->pci;
+	struct dw_pcie *pci = &pcie->pci;
 
 	if (pci->link_gen < 3)
 		return 0;
 
 	/* Send PME_TURN_OFF message */
-	pcie_app_wr_mask(lpp, PCIE_APP_MSG_CR, PCIE_APP_MSG_XMT_PM_TURNOFF,
+	pcie_app_wr_mask(pcie, PCIE_APP_MSG_CR, PCIE_APP_MSG_XMT_PM_TURNOFF,
 			 PCIE_APP_MSG_XMT_PM_TURNOFF);
 
 	/* Read PMC status and wait for falling into L2 link state */
-	ret = readl_poll_timeout(lpp->app_base + PCIE_APP_PMC, value,
+	ret = readl_poll_timeout(pcie->app_base + PCIE_APP_PMC, value,
 				 value & PCIE_APP_PMC_IN_L2, 20,
 				 jiffies_to_usecs(5 * HZ));
 	if (ret)
-		dev_err(lpp->pci.dev, "PCIe link enter L2 timeout!\n");
+		dev_err(pcie->pci.dev, "PCIe link enter L2 timeout!\n");
 
 	return ret;
 }
 
-static void intel_pcie_turn_off(struct intel_pcie_port *lpp)
+static void intel_pcie_turn_off(struct intel_pcie *pcie)
 {
-	if (dw_pcie_link_up(&lpp->pci))
-		intel_pcie_wait_l2(lpp);
+	if (dw_pcie_link_up(&pcie->pci))
+		intel_pcie_wait_l2(pcie);
 
 	/* Put endpoint device in reset state */
-	intel_pcie_device_rst_assert(lpp);
-	pcie_rc_cfg_wr_mask(lpp, PCI_COMMAND, PCI_COMMAND_MEMORY, 0);
+	intel_pcie_device_rst_assert(pcie);
+	pcie_rc_cfg_wr_mask(pcie, PCI_COMMAND, PCI_COMMAND_MEMORY, 0);
 }
 
-static int intel_pcie_host_setup(struct intel_pcie_port *lpp)
+static int intel_pcie_host_setup(struct intel_pcie *pcie)
 {
 	int ret;
-	struct dw_pcie *pci = &lpp->pci;
+	struct dw_pcie *pci = &pcie->pci;
 
-	intel_pcie_core_rst_assert(lpp);
-	intel_pcie_device_rst_assert(lpp);
+	intel_pcie_core_rst_assert(pcie);
+	intel_pcie_device_rst_assert(pcie);
 
-	ret = phy_init(lpp->phy);
+	ret = phy_init(pcie->phy);
 	if (ret)
 		return ret;
 
-	intel_pcie_core_rst_deassert(lpp);
+	intel_pcie_core_rst_deassert(pcie);
 
-	ret = clk_prepare_enable(lpp->core_clk);
+	ret = clk_prepare_enable(pcie->core_clk);
 	if (ret) {
-		dev_err(lpp->pci.dev, "Core clock enable failed: %d\n", ret);
+		dev_err(pcie->pci.dev, "Core clock enable failed: %d\n", ret);
 		goto clk_err;
 	}
 
 	pci->atu_base = pci->dbi_base + 0xC0000;
 
-	intel_pcie_ltssm_disable(lpp);
-	intel_pcie_link_setup(lpp);
+	intel_pcie_ltssm_disable(pcie);
+	intel_pcie_link_setup(pcie);
 	intel_pcie_init_n_fts(pci);
 	dw_pcie_setup_rc(&pci->pp);
 	dw_pcie_upconfig_setup(pci);
 
-	intel_pcie_device_rst_deassert(lpp);
-	intel_pcie_ltssm_enable(lpp);
+	intel_pcie_device_rst_deassert(pcie);
+	intel_pcie_ltssm_enable(pcie);
 
 	ret = dw_pcie_wait_for_link(pci);
 	if (ret)
 		goto app_init_err;
 
 	/* Enable integrated interrupts */
-	pcie_app_wr_mask(lpp, PCIE_APP_IRNEN, PCIE_APP_IRN_INT,
+	pcie_app_wr_mask(pcie, PCIE_APP_IRNEN, PCIE_APP_IRN_INT,
 			 PCIE_APP_IRN_INT);
 
 	return 0;
 
 app_init_err:
-	clk_disable_unprepare(lpp->core_clk);
+	clk_disable_unprepare(pcie->core_clk);
 clk_err:
-	intel_pcie_core_rst_assert(lpp);
-	phy_exit(lpp->phy);
+	intel_pcie_core_rst_assert(pcie);
+	phy_exit(pcie->phy);
 
 	return ret;
 }
 
-static void __intel_pcie_remove(struct intel_pcie_port *lpp)
+static void __intel_pcie_remove(struct intel_pcie *pcie)
 {
-	intel_pcie_core_irq_disable(lpp);
-	intel_pcie_turn_off(lpp);
-	clk_disable_unprepare(lpp->core_clk);
-	intel_pcie_core_rst_assert(lpp);
-	phy_exit(lpp->phy);
+	intel_pcie_core_irq_disable(pcie);
+	intel_pcie_turn_off(pcie);
+	clk_disable_unprepare(pcie->core_clk);
+	intel_pcie_core_rst_assert(pcie);
+	phy_exit(pcie->phy);
 }
 
 static int intel_pcie_remove(struct platform_device *pdev)
 {
-	struct intel_pcie_port *lpp = platform_get_drvdata(pdev);
-	struct pcie_port *pp = &lpp->pci.pp;
+	struct intel_pcie *pcie = platform_get_drvdata(pdev);
+	struct pcie_port *pp = &pcie->pci.pp;
 
 	dw_pcie_host_deinit(pp);
-	__intel_pcie_remove(lpp);
+	__intel_pcie_remove(pcie);
 
 	return 0;
 }
 
 static int __maybe_unused intel_pcie_suspend_noirq(struct device *dev)
 {
-	struct intel_pcie_port *lpp = dev_get_drvdata(dev);
+	struct intel_pcie *pcie = dev_get_drvdata(dev);
 	int ret;
 
-	intel_pcie_core_irq_disable(lpp);
-	ret = intel_pcie_wait_l2(lpp);
+	intel_pcie_core_irq_disable(pcie);
+	ret = intel_pcie_wait_l2(pcie);
 	if (ret)
 		return ret;
 
-	phy_exit(lpp->phy);
-	clk_disable_unprepare(lpp->core_clk);
+	phy_exit(pcie->phy);
+	clk_disable_unprepare(pcie->core_clk);
 	return ret;
 }
 
 static int __maybe_unused intel_pcie_resume_noirq(struct device *dev)
 {
-	struct intel_pcie_port *lpp = dev_get_drvdata(dev);
+	struct intel_pcie *pcie = dev_get_drvdata(dev);
 
-	return intel_pcie_host_setup(lpp);
+	return intel_pcie_host_setup(pcie);
 }
 
 static int intel_pcie_rc_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct intel_pcie_port *lpp = dev_get_drvdata(pci->dev);
+	struct intel_pcie *pcie = dev_get_drvdata(pci->dev);
 
-	return intel_pcie_host_setup(lpp);
+	return intel_pcie_host_setup(pcie);
 }
 
 static u64 intel_pcie_cpu_addr(struct dw_pcie *pcie, u64 cpu_addr)
@@ -402,17 +402,17 @@ static int intel_pcie_probe(struct platform_device *pdev)
 {
 	const struct intel_pcie_soc *data;
 	struct device *dev = &pdev->dev;
-	struct intel_pcie_port *lpp;
+	struct intel_pcie *pcie;
 	struct pcie_port *pp;
 	struct dw_pcie *pci;
 	int ret;
 
-	lpp = devm_kzalloc(dev, sizeof(*lpp), GFP_KERNEL);
-	if (!lpp)
+	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
+	if (!pcie)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, lpp);
-	pci = &lpp->pci;
+	platform_set_drvdata(pdev, pcie);
+	pci = &pcie->pci;
 	pci->dev = dev;
 	pp = &pci->pp;
 
@@ -420,7 +420,7 @@ static int intel_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = intel_pcie_ep_rst_init(lpp);
+	ret = intel_pcie_ep_rst_init(pcie);
 	if (ret)
 		return ret;
 
-- 
2.25.1


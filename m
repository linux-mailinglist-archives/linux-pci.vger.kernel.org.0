Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2CE57A96D
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jul 2022 23:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240623AbiGSVv1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jul 2022 17:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240613AbiGSVvR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jul 2022 17:51:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FB832B95;
        Tue, 19 Jul 2022 14:51:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D349961AEF;
        Tue, 19 Jul 2022 21:51:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE822C341C6;
        Tue, 19 Jul 2022 21:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658267475;
        bh=pV1f79ifV18cQrL4IhtFY8tYlhC3UPxb2O7R83XaElA=;
        h=From:To:Cc:Subject:Date:From;
        b=B627e0ibdGjyE0jgnXvs6G2wE9ws5/CI6GKeWoFAAiDl5Ib6JtRzlPoXsetzyRzHg
         5Gpq2JYSya+mywZtHM5r0fPluB+oqNhnjE2LHqfxQySN/EEtnOqE59lPGYUnJVcjBE
         HkC2YKrVQ2suSTCMgCo23zZIK/BUfswIzGSb3+GX2lwzm8OtM+Urf2YZxhpNvEf+mJ
         GOXDscNyd0ooc9pIFfbZo+ihTBB5CQYtP319g0R/nTtM4hsBWOuWimiw7yp4tFX95m
         5991sOA/Il7LkCNw6ibrfZ3E4g32uVKXhBlS5hVOikR9eRhTSKVsQBIMy5cnZH9PH2
         8zv9LGb1HWBPg==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Tom Joseph <tjoseph@cadence.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Rahul Tanwar <rtanwar@maxlinear.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: Convert to new *_PM_OPS macros
Date:   Tue, 19 Jul 2022 16:51:08 -0500
Message-Id: <20220719215108.1583108-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Replace SET_*_PM_OPS with *_PM_OPS, which which have the advantage that the
compiler always sees the PM callbacks as referenced, so they don't need to
be wrapped with "#ifdef CONFIG_PM_SLEEP" or tagged with "__maybe_unused" to
avoid "defined but not used" warnings.

See 1a3c7bb08826 ("PM: core: Add new *_PM_OPS macros, deprecate old ones").

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/cadence/pcie-cadence.c |  6 ++----
 drivers/pci/controller/dwc/pci-dra7xx.c       |  8 +++-----
 drivers/pci/controller/dwc/pci-exynos.c       |  8 ++++----
 drivers/pci/controller/dwc/pcie-intel-gw.c    |  8 ++++----
 drivers/pci/controller/pci-mvebu.c            |  4 +---
 drivers/pci/controller/pci-tegra.c            |  9 ++++-----
 drivers/pci/controller/pcie-mediatek-gen3.c   | 14 +++++++-------
 drivers/pci/controller/pcie-mediatek.c        |  8 ++++----
 drivers/pci/controller/pcie-rcar-host.c       |  4 ++--
 drivers/pci/controller/pcie-rockchip-host.c   |  8 ++++----
 10 files changed, 35 insertions(+), 42 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
index 52767f26048f..13c4032ca379 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.c
+++ b/drivers/pci/controller/cadence/pcie-cadence.c
@@ -243,7 +243,6 @@ int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
 	return ret;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int cdns_pcie_suspend_noirq(struct device *dev)
 {
 	struct cdns_pcie *pcie = dev_get_drvdata(dev);
@@ -266,9 +265,8 @@ static int cdns_pcie_resume_noirq(struct device *dev)
 
 	return 0;
 }
-#endif
 
 const struct dev_pm_ops cdns_pcie_pm_ops = {
-	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(cdns_pcie_suspend_noirq,
-				      cdns_pcie_resume_noirq)
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(cdns_pcie_suspend_noirq,
+				  cdns_pcie_resume_noirq)
 };
diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index dfcdeb432dc8..60e33fe1a75a 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -862,7 +862,6 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
 	return ret;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int dra7xx_pcie_suspend(struct device *dev)
 {
 	struct dra7xx_pcie *dra7xx = dev_get_drvdata(dev);
@@ -919,7 +918,6 @@ static int dra7xx_pcie_resume_noirq(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static void dra7xx_pcie_shutdown(struct platform_device *pdev)
 {
@@ -940,9 +938,9 @@ static void dra7xx_pcie_shutdown(struct platform_device *pdev)
 }
 
 static const struct dev_pm_ops dra7xx_pcie_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(dra7xx_pcie_suspend, dra7xx_pcie_resume)
-	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(dra7xx_pcie_suspend_noirq,
-				      dra7xx_pcie_resume_noirq)
+	SYSTEM_SLEEP_PM_OPS(dra7xx_pcie_suspend, dra7xx_pcie_resume)
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(dra7xx_pcie_suspend_noirq,
+				  dra7xx_pcie_resume_noirq)
 };
 
 static struct platform_driver dra7xx_pcie_driver = {
diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index 467c8d1cd7e4..c59923da4a67 100644
--- a/drivers/pci/controller/dwc/pci-exynos.c
+++ b/drivers/pci/controller/dwc/pci-exynos.c
@@ -390,7 +390,7 @@ static int __exit exynos_pcie_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int __maybe_unused exynos_pcie_suspend_noirq(struct device *dev)
+static int exynos_pcie_suspend_noirq(struct device *dev)
 {
 	struct exynos_pcie *ep = dev_get_drvdata(dev);
 
@@ -402,7 +402,7 @@ static int __maybe_unused exynos_pcie_suspend_noirq(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused exynos_pcie_resume_noirq(struct device *dev)
+static int exynos_pcie_resume_noirq(struct device *dev)
 {
 	struct exynos_pcie *ep = dev_get_drvdata(dev);
 	struct dw_pcie *pci = &ep->pci;
@@ -421,8 +421,8 @@ static int __maybe_unused exynos_pcie_resume_noirq(struct device *dev)
 }
 
 static const struct dev_pm_ops exynos_pcie_pm_ops = {
-	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(exynos_pcie_suspend_noirq,
-				      exynos_pcie_resume_noirq)
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(exynos_pcie_suspend_noirq,
+				  exynos_pcie_resume_noirq)
 };
 
 static const struct of_device_id exynos_pcie_of_match[] = {
diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
index 5ba144924ff8..415edb44b55f 100644
--- a/drivers/pci/controller/dwc/pcie-intel-gw.c
+++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
@@ -351,7 +351,7 @@ static int intel_pcie_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int __maybe_unused intel_pcie_suspend_noirq(struct device *dev)
+static int intel_pcie_suspend_noirq(struct device *dev)
 {
 	struct intel_pcie *pcie = dev_get_drvdata(dev);
 	int ret;
@@ -366,7 +366,7 @@ static int __maybe_unused intel_pcie_suspend_noirq(struct device *dev)
 	return ret;
 }
 
-static int __maybe_unused intel_pcie_resume_noirq(struct device *dev)
+static int intel_pcie_resume_noirq(struct device *dev)
 {
 	struct intel_pcie *pcie = dev_get_drvdata(dev);
 
@@ -442,8 +442,8 @@ static int intel_pcie_probe(struct platform_device *pdev)
 }
 
 static const struct dev_pm_ops intel_pcie_pm_ops = {
-	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(intel_pcie_suspend_noirq,
-				      intel_pcie_resume_noirq)
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(intel_pcie_suspend_noirq,
+				  intel_pcie_resume_noirq)
 };
 
 static const struct of_device_id of_intel_pcie_match[] = {
diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index c1ffdb06c971..af915c951f06 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -1216,7 +1216,6 @@ static int mvebu_get_tgt_attr(struct device_node *np, int devfn,
 	return -ENOENT;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int mvebu_pcie_suspend(struct device *dev)
 {
 	struct mvebu_pcie *pcie;
@@ -1249,7 +1248,6 @@ static int mvebu_pcie_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static void mvebu_pcie_port_clk_put(void *data)
 {
@@ -1737,7 +1735,7 @@ static const struct of_device_id mvebu_pcie_of_match_table[] = {
 };
 
 static const struct dev_pm_ops mvebu_pcie_pm_ops = {
-	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(mvebu_pcie_suspend, mvebu_pcie_resume)
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(mvebu_pcie_suspend, mvebu_pcie_resume)
 };
 
 static struct platform_driver mvebu_pcie_driver = {
diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 0457ec02ab70..8e323e93be91 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -2707,7 +2707,7 @@ static int tegra_pcie_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int __maybe_unused tegra_pcie_pm_suspend(struct device *dev)
+static int tegra_pcie_pm_suspend(struct device *dev)
 {
 	struct tegra_pcie *pcie = dev_get_drvdata(dev);
 	struct tegra_pcie_port *port;
@@ -2742,7 +2742,7 @@ static int __maybe_unused tegra_pcie_pm_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused tegra_pcie_pm_resume(struct device *dev)
+static int tegra_pcie_pm_resume(struct device *dev)
 {
 	struct tegra_pcie *pcie = dev_get_drvdata(dev);
 	int err;
@@ -2798,9 +2798,8 @@ static int __maybe_unused tegra_pcie_pm_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops tegra_pcie_pm_ops = {
-	SET_RUNTIME_PM_OPS(tegra_pcie_pm_suspend, tegra_pcie_pm_resume, NULL)
-	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(tegra_pcie_pm_suspend,
-				      tegra_pcie_pm_resume)
+	RUNTIME_PM_OPS(tegra_pcie_pm_suspend, tegra_pcie_pm_resume, NULL)
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(tegra_pcie_pm_suspend, tegra_pcie_pm_resume)
 };
 
 static struct platform_driver tegra_pcie_driver = {
diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 5d9fd36b02d1..b5c85216ec7e 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -917,7 +917,7 @@ static int mtk_pcie_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static void __maybe_unused mtk_pcie_irq_save(struct mtk_gen3_pcie *pcie)
+static void mtk_pcie_irq_save(struct mtk_gen3_pcie *pcie)
 {
 	int i;
 
@@ -935,7 +935,7 @@ static void __maybe_unused mtk_pcie_irq_save(struct mtk_gen3_pcie *pcie)
 	raw_spin_unlock(&pcie->irq_lock);
 }
 
-static void __maybe_unused mtk_pcie_irq_restore(struct mtk_gen3_pcie *pcie)
+static void mtk_pcie_irq_restore(struct mtk_gen3_pcie *pcie)
 {
 	int i;
 
@@ -953,7 +953,7 @@ static void __maybe_unused mtk_pcie_irq_restore(struct mtk_gen3_pcie *pcie)
 	raw_spin_unlock(&pcie->irq_lock);
 }
 
-static int __maybe_unused mtk_pcie_turn_off_link(struct mtk_gen3_pcie *pcie)
+static int mtk_pcie_turn_off_link(struct mtk_gen3_pcie *pcie)
 {
 	u32 val;
 
@@ -968,7 +968,7 @@ static int __maybe_unused mtk_pcie_turn_off_link(struct mtk_gen3_pcie *pcie)
 				   50 * USEC_PER_MSEC);
 }
 
-static int __maybe_unused mtk_pcie_suspend_noirq(struct device *dev)
+static int mtk_pcie_suspend_noirq(struct device *dev)
 {
 	struct mtk_gen3_pcie *pcie = dev_get_drvdata(dev);
 	int err;
@@ -994,7 +994,7 @@ static int __maybe_unused mtk_pcie_suspend_noirq(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused mtk_pcie_resume_noirq(struct device *dev)
+static int mtk_pcie_resume_noirq(struct device *dev)
 {
 	struct mtk_gen3_pcie *pcie = dev_get_drvdata(dev);
 	int err;
@@ -1015,8 +1015,8 @@ static int __maybe_unused mtk_pcie_resume_noirq(struct device *dev)
 }
 
 static const struct dev_pm_ops mtk_pcie_pm_ops = {
-	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(mtk_pcie_suspend_noirq,
-				      mtk_pcie_resume_noirq)
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(mtk_pcie_suspend_noirq,
+				  mtk_pcie_resume_noirq)
 };
 
 static const struct of_device_id mtk_pcie_of_match[] = {
diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index be8bd919cb88..ae5ad05ddc1d 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -1150,7 +1150,7 @@ static int mtk_pcie_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int __maybe_unused mtk_pcie_suspend_noirq(struct device *dev)
+static int mtk_pcie_suspend_noirq(struct device *dev)
 {
 	struct mtk_pcie *pcie = dev_get_drvdata(dev);
 	struct mtk_pcie_port *port;
@@ -1174,7 +1174,7 @@ static int __maybe_unused mtk_pcie_suspend_noirq(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused mtk_pcie_resume_noirq(struct device *dev)
+static int mtk_pcie_resume_noirq(struct device *dev)
 {
 	struct mtk_pcie *pcie = dev_get_drvdata(dev);
 	struct mtk_pcie_port *port, *tmp;
@@ -1195,8 +1195,8 @@ static int __maybe_unused mtk_pcie_resume_noirq(struct device *dev)
 }
 
 static const struct dev_pm_ops mtk_pcie_pm_ops = {
-	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(mtk_pcie_suspend_noirq,
-				      mtk_pcie_resume_noirq)
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(mtk_pcie_suspend_noirq,
+				  mtk_pcie_resume_noirq)
 };
 
 static const struct mtk_pcie_soc mtk_pcie_soc_v1 = {
diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index 997c4df6a1e7..e4faf90feaf5 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -1072,7 +1072,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int __maybe_unused rcar_pcie_resume(struct device *dev)
+static int rcar_pcie_resume(struct device *dev)
 {
 	struct rcar_pcie_host *host = dev_get_drvdata(dev);
 	struct rcar_pcie *pcie = &host->pcie;
@@ -1127,7 +1127,7 @@ static int rcar_pcie_resume_noirq(struct device *dev)
 }
 
 static const struct dev_pm_ops rcar_pcie_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(NULL, rcar_pcie_resume)
+	SYSTEM_SLEEP_PM_OPS(NULL, rcar_pcie_resume)
 	.resume_noirq = rcar_pcie_resume_noirq,
 };
 
diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 7f56f99b4116..7352b5ff8d35 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -864,7 +864,7 @@ static int rockchip_pcie_wait_l2(struct rockchip_pcie *rockchip)
 	return 0;
 }
 
-static int __maybe_unused rockchip_pcie_suspend_noirq(struct device *dev)
+static int rockchip_pcie_suspend_noirq(struct device *dev)
 {
 	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
 	int ret;
@@ -889,7 +889,7 @@ static int __maybe_unused rockchip_pcie_suspend_noirq(struct device *dev)
 	return ret;
 }
 
-static int __maybe_unused rockchip_pcie_resume_noirq(struct device *dev)
+static int rockchip_pcie_resume_noirq(struct device *dev)
 {
 	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
 	int err;
@@ -1035,8 +1035,8 @@ static int rockchip_pcie_remove(struct platform_device *pdev)
 }
 
 static const struct dev_pm_ops rockchip_pcie_pm_ops = {
-	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(rockchip_pcie_suspend_noirq,
-				      rockchip_pcie_resume_noirq)
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(rockchip_pcie_suspend_noirq,
+				  rockchip_pcie_resume_noirq)
 };
 
 static const struct of_device_id rockchip_pcie_of_match[] = {
-- 
2.25.1


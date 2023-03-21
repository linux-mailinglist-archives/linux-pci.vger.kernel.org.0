Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3EC96C3AA5
	for <lists+linux-pci@lfdr.de>; Tue, 21 Mar 2023 20:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjCUTdu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Mar 2023 15:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjCUTdr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Mar 2023 15:33:47 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2671574F2
        for <linux-pci@vger.kernel.org>; Tue, 21 Mar 2023 12:32:49 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pehiW-0008EF-GO; Tue, 21 Mar 2023 20:32:20 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pehiU-005l64-Uv; Tue, 21 Mar 2023 20:32:18 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pehiU-006qxz-Au; Tue, 21 Mar 2023 20:32:18 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Rahul Tanwar <rtanwar@maxlinear.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Vidya Sagar <vidyas@nvidia.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Miaoqian Lin <linmq006@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        kernel@pengutronix.de, linux-arm-msm@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH 06/15] PCI: dwc/*: Convert to platform remove callback returning void
Date:   Tue, 21 Mar 2023 20:31:59 +0100
Message-Id: <20230321193208.366561-7-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230321193208.366561-1-u.kleine-koenig@pengutronix.de>
References: <20230321193208.366561-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6565; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=5K3iqpNqflnwgUplfDS7tn4+EN+yS5W2zvIdkqbS3JM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkGgYS37kTLTlIMhlyj5NjMF8wxSLVTLifxX0ac W0JOQbfrMKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZBoGEgAKCRCPgPtYfRL+ TlDBB/9reIW9UmLLehQvYzz4jvUEwhJV3Hhxx3rgN6+/qXzmVTOW9XGlpjiNh4lWdenqLv/k1MN dupbSlb7qr5mEA1umO68UiPR2PH+qd0Sbvmj+IC9GOB4X1Zz91X6MSyhYyDn3s+L5sZ2i7dTFXO FDwt889y9t9R+rq9iHIWZWjy49AqU5SCo89dUqnbh+a7jrQ01l8BK4LCLATUf+tiyB64s8rwfmx MKG5SCXoLWCJRSPixlsaj8TDNMW76I1wd+y1kEY4YPPiOqLwFsh5/ACOEsp6ePE+q3sf4OJxw7Y 1s4qmwBTbtkYBZeXFzwLgv2yjCwN3oJNXpU0KiEniSCWYbeC
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

Trivially convert the dwc drivers from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pci/controller/dwc/pcie-bt1.c      | 6 ++----
 drivers/pci/controller/dwc/pcie-histb.c    | 6 ++----
 drivers/pci/controller/dwc/pcie-intel-gw.c | 6 ++----
 drivers/pci/controller/dwc/pcie-qcom-ep.c  | 8 +++-----
 drivers/pci/controller/dwc/pcie-tegra194.c | 8 +++-----
 5 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-bt1.c b/drivers/pci/controller/dwc/pcie-bt1.c
index 95a723a6fd46..17e696797ff5 100644
--- a/drivers/pci/controller/dwc/pcie-bt1.c
+++ b/drivers/pci/controller/dwc/pcie-bt1.c
@@ -617,13 +617,11 @@ static int bt1_pcie_probe(struct platform_device *pdev)
 	return bt1_pcie_add_port(btpci);
 }
 
-static int bt1_pcie_remove(struct platform_device *pdev)
+static void bt1_pcie_remove(struct platform_device *pdev)
 {
 	struct bt1_pcie *btpci = platform_get_drvdata(pdev);
 
 	bt1_pcie_del_port(btpci);
-
-	return 0;
 }
 
 static const struct of_device_id bt1_pcie_of_match[] = {
@@ -634,7 +632,7 @@ MODULE_DEVICE_TABLE(of, bt1_pcie_of_match);
 
 static struct platform_driver bt1_pcie_driver = {
 	.probe = bt1_pcie_probe,
-	.remove = bt1_pcie_remove,
+	.remove_new = bt1_pcie_remove,
 	.driver = {
 		.name	= "bt1-pcie",
 		.of_match_table = bt1_pcie_of_match,
diff --git a/drivers/pci/controller/dwc/pcie-histb.c b/drivers/pci/controller/dwc/pcie-histb.c
index 927ae05dc920..fd484cc7c481 100644
--- a/drivers/pci/controller/dwc/pcie-histb.c
+++ b/drivers/pci/controller/dwc/pcie-histb.c
@@ -421,7 +421,7 @@ static int histb_pcie_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int histb_pcie_remove(struct platform_device *pdev)
+static void histb_pcie_remove(struct platform_device *pdev)
 {
 	struct histb_pcie *hipcie = platform_get_drvdata(pdev);
 
@@ -429,8 +429,6 @@ static int histb_pcie_remove(struct platform_device *pdev)
 
 	if (hipcie->phy)
 		phy_exit(hipcie->phy);
-
-	return 0;
 }
 
 static const struct of_device_id histb_pcie_of_match[] = {
@@ -441,7 +439,7 @@ MODULE_DEVICE_TABLE(of, histb_pcie_of_match);
 
 static struct platform_driver histb_pcie_platform_driver = {
 	.probe	= histb_pcie_probe,
-	.remove	= histb_pcie_remove,
+	.remove_new = histb_pcie_remove,
 	.driver = {
 		.name = "histb-pcie",
 		.of_match_table = histb_pcie_of_match,
diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
index 333c33d98a70..9c7caed9e706 100644
--- a/drivers/pci/controller/dwc/pcie-intel-gw.c
+++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
@@ -340,15 +340,13 @@ static void __intel_pcie_remove(struct intel_pcie *pcie)
 	phy_exit(pcie->phy);
 }
 
-static int intel_pcie_remove(struct platform_device *pdev)
+static void intel_pcie_remove(struct platform_device *pdev)
 {
 	struct intel_pcie *pcie = platform_get_drvdata(pdev);
 	struct dw_pcie_rp *pp = &pcie->pci.pp;
 
 	dw_pcie_host_deinit(pp);
 	__intel_pcie_remove(pcie);
-
-	return 0;
 }
 
 static int intel_pcie_suspend_noirq(struct device *dev)
@@ -443,7 +441,7 @@ static const struct of_device_id of_intel_pcie_match[] = {
 
 static struct platform_driver intel_pcie_driver = {
 	.probe = intel_pcie_probe,
-	.remove = intel_pcie_remove,
+	.remove_new = intel_pcie_remove,
 	.driver = {
 		.name = "intel-gw-pcie",
 		.of_match_table = of_intel_pcie_match,
diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 19b32839ea26..3e5f1b637aeb 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -784,7 +784,7 @@ static int qcom_pcie_ep_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int qcom_pcie_ep_remove(struct platform_device *pdev)
+static void qcom_pcie_ep_remove(struct platform_device *pdev)
 {
 	struct qcom_pcie_ep *pcie_ep = platform_get_drvdata(pdev);
 
@@ -794,11 +794,9 @@ static int qcom_pcie_ep_remove(struct platform_device *pdev)
 	debugfs_remove_recursive(pcie_ep->debugfs);
 
 	if (pcie_ep->link_status == QCOM_PCIE_EP_LINK_DISABLED)
-		return 0;
+		return;
 
 	qcom_pcie_disable_resources(pcie_ep);
-
-	return 0;
 }
 
 static const struct of_device_id qcom_pcie_ep_match[] = {
@@ -810,7 +808,7 @@ MODULE_DEVICE_TABLE(of, qcom_pcie_ep_match);
 
 static struct platform_driver qcom_pcie_ep_driver = {
 	.probe	= qcom_pcie_ep_probe,
-	.remove = qcom_pcie_ep_remove,
+	.remove_new = qcom_pcie_ep_remove,
 	.driver	= {
 		.name = "qcom-pcie-ep",
 		.of_match_table	= qcom_pcie_ep_match,
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 09825b4a075e..f373a00e2ea3 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2268,13 +2268,13 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int tegra_pcie_dw_remove(struct platform_device *pdev)
+static void tegra_pcie_dw_remove(struct platform_device *pdev)
 {
 	struct tegra_pcie_dw *pcie = platform_get_drvdata(pdev);
 
 	if (pcie->of_data->mode == DW_PCIE_RC_TYPE) {
 		if (!pcie->link_state)
-			return 0;
+			return;
 
 		debugfs_remove_recursive(pcie->debugfs);
 		tegra_pcie_deinit_controller(pcie);
@@ -2288,8 +2288,6 @@ static int tegra_pcie_dw_remove(struct platform_device *pdev)
 	tegra_bpmp_put(pcie->bpmp);
 	if (pcie->pex_refclk_sel_gpiod)
 		gpiod_set_value(pcie->pex_refclk_sel_gpiod, 0);
-
-	return 0;
 }
 
 static int tegra_pcie_dw_suspend_late(struct device *dev)
@@ -2483,7 +2481,7 @@ static const struct dev_pm_ops tegra_pcie_dw_pm_ops = {
 
 static struct platform_driver tegra_pcie_dw_driver = {
 	.probe = tegra_pcie_dw_probe,
-	.remove = tegra_pcie_dw_remove,
+	.remove_new = tegra_pcie_dw_remove,
 	.shutdown = tegra_pcie_dw_shutdown,
 	.driver = {
 		.name	= "tegra194-pcie",
-- 
2.39.2


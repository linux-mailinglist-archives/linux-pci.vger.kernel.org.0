Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E0F6C3AA1
	for <lists+linux-pci@lfdr.de>; Tue, 21 Mar 2023 20:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjCUTdq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Mar 2023 15:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjCUTdo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Mar 2023 15:33:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA830570BF
        for <linux-pci@vger.kernel.org>; Tue, 21 Mar 2023 12:32:48 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pehiW-0008EE-GG; Tue, 21 Mar 2023 20:32:20 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pehiU-005l63-UX; Tue, 21 Mar 2023 20:32:18 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pehiT-006qxt-QY; Tue, 21 Mar 2023 20:32:17 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Jim Quinlan <jim2101024@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh@kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 04/15] PCI: brcmstb: Convert to platform remove callback returning void
Date:   Tue, 21 Mar 2023 20:31:57 +0100
Message-Id: <20230321193208.366561-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230321193208.366561-1-u.kleine-koenig@pengutronix.de>
References: <20230321193208.366561-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1895; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=LYBGZGW40OZnRbX51iSFrWuG85rmJlZ6nzAXmI6Ei6w=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkGgYPQwR9aF+IaHssY/wQGVUbPlhDvNkgY132c HVVvfpYmjCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZBoGDwAKCRCPgPtYfRL+ Tk25B/9r905dZ1CMs+zl+s62zWehNigf45KLTPf6Vu5rnejf1EusFS931fE7lnk8VY4768ybaNM KOkHypsGiytRcjxdhj9No8hWDFsW97Fp2Xq3Luv/TrEERNmYW5eUWaXQytbIK1TsoOMw8JMSiGI sOB6HR7R9A/A5MLq0ATGwXb+Slbj0QMxY0xCUPq6aI09pQHWc76QSWHJ5OeH5eTMc+hpv/Gjxhe xHdVBiK3eEh8Col/EcOr5AGcHNGKsQ7XyOufAZVrGdr0T9Nmuf48Dpf03iE8+znJ4Xxq+uLogI4 kvwLhIhrvLv2INr9tFXAN2ew4UmD54DynwJMTslrT6ieAC8E
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

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pci/controller/pcie-brcmstb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index edf283e2b5dd..f593a422bd63 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1396,7 +1396,7 @@ static void __brcm_pcie_remove(struct brcm_pcie *pcie)
 	clk_disable_unprepare(pcie->clk);
 }
 
-static int brcm_pcie_remove(struct platform_device *pdev)
+static void brcm_pcie_remove(struct platform_device *pdev)
 {
 	struct brcm_pcie *pcie = platform_get_drvdata(pdev);
 	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
@@ -1404,8 +1404,6 @@ static int brcm_pcie_remove(struct platform_device *pdev)
 	pci_stop_root_bus(bridge->bus);
 	pci_remove_root_bus(bridge->bus);
 	__brcm_pcie_remove(pcie);
-
-	return 0;
 }
 
 static const int pcie_offsets[] = {
@@ -1612,7 +1610,7 @@ static const struct dev_pm_ops brcm_pcie_pm_ops = {
 
 static struct platform_driver brcm_pcie_driver = {
 	.probe = brcm_pcie_probe,
-	.remove = brcm_pcie_remove,
+	.remove_new = brcm_pcie_remove,
 	.driver = {
 		.name = "brcm-pcie",
 		.of_match_table = brcm_pcie_match,
-- 
2.39.2


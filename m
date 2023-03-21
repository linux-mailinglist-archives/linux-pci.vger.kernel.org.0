Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3DA6C3A96
	for <lists+linux-pci@lfdr.de>; Tue, 21 Mar 2023 20:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjCUTd3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Mar 2023 15:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjCUTd1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Mar 2023 15:33:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49246574E8
        for <linux-pci@vger.kernel.org>; Tue, 21 Mar 2023 12:32:29 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pehiU-0008Dx-Eu; Tue, 21 Mar 2023 20:32:18 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pehiT-005l5l-Fv; Tue, 21 Mar 2023 20:32:17 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pehiS-006qxi-RX; Tue, 21 Mar 2023 20:32:16 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 01/15] PCI: aardvark: Convert to platform remove callback returning void
Date:   Tue, 21 Mar 2023 20:31:54 +0100
Message-Id: <20230321193208.366561-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230321193208.366561-1-u.kleine-koenig@pengutronix.de>
References: <20230321193208.366561-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1826; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=VU8AjyDLbWZ5dqbt4iquWcUdOksnVkBSV+/E2xpJ7XA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkGgYMe8hHIINwAJXwV0g3+hkCe50iFo5TcCjOW FF9FY8qdNGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZBoGDAAKCRCPgPtYfRL+ TrPiB/9Cr48o7v2D92yY9Ucz4v+coWwl7NN3FpOZz5seMKIw2oui8ukSNtrf/TDlIAFiYUoRXy8 S3tX7Mk6ztaE9OnEWyxS1pQSrYiQEp72/NGbvcYzkQHBQOi3aqfd/GQfCbL/yRxyt0nJCmyp4pT P29Uee/RJfW9irKdc51XrslR2qIy+VljgBSpFNSIcRQI7+hM4YNTYstT48BeCV4raZUQ7ve/iGA CP/Ur4sFICxB2KwoIk+FvlyCBIuGFZBtuqvP5aAPEGtPqEdUUMazEKoXW0TItT4lIHqzDDwTxqT h1B30eGGT3xQgl4hbbBz679DzCTB/IS865sMIYW8lgn71S5S
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
 drivers/pci/controller/pci-aardvark.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 513d8edf3a5c..71ecd7ddcc8a 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1927,7 +1927,7 @@ static int advk_pcie_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int advk_pcie_remove(struct platform_device *pdev)
+static void advk_pcie_remove(struct platform_device *pdev)
 {
 	struct advk_pcie *pcie = platform_get_drvdata(pdev);
 	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
@@ -1989,8 +1989,6 @@ static int advk_pcie_remove(struct platform_device *pdev)
 
 	/* Disable phy */
 	advk_pcie_disable_phy(pcie);
-
-	return 0;
 }
 
 static const struct of_device_id advk_pcie_of_match_table[] = {
@@ -2005,7 +2003,7 @@ static struct platform_driver advk_pcie_driver = {
 		.of_match_table = advk_pcie_of_match_table,
 	},
 	.probe = advk_pcie_probe,
-	.remove = advk_pcie_remove,
+	.remove_new = advk_pcie_remove,
 };
 module_platform_driver(advk_pcie_driver);
 
-- 
2.39.2


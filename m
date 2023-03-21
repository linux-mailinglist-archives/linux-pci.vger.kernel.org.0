Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF956C3A9A
	for <lists+linux-pci@lfdr.de>; Tue, 21 Mar 2023 20:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjCUTdd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Mar 2023 15:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjCUTdb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Mar 2023 15:33:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BE556518
        for <linux-pci@vger.kernel.org>; Tue, 21 Mar 2023 12:32:34 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pehiW-0008EC-MA; Tue, 21 Mar 2023 20:32:20 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pehiU-005l5z-QE; Tue, 21 Mar 2023 20:32:18 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pehiU-006qxw-20; Tue, 21 Mar 2023 20:32:18 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Rob Herring <robh@kernel.org>, linux-omap@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH 05/15] PCI: cadence/j721e: Convert to platform remove callback returning void
Date:   Tue, 21 Mar 2023 20:31:58 +0100
Message-Id: <20230321193208.366561-6-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230321193208.366561-1-u.kleine-koenig@pengutronix.de>
References: <20230321193208.366561-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1766; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=QxQuCPkBX+gmn0DsDFMazRFbmA+rrNRdxWImQT9rru0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkGgYQ1j3K5rYmdgPYi1zdHVXsFc9Ws6RX4oYjT S1lZTdeizeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZBoGEAAKCRCPgPtYfRL+ Tg0pCAChO/xohQuyvJzoG0F/9IkpLTb7vcvjZRFygLGbIhNQwl4fglw2bdYVH/FOcM6Wn4u+ZJV xcA2Lgcq+OXNlCqT3U1AJhJ5JPGu80t3C2WoRuk8hllnSkv+PTWWRDge9BW0blQvyIWeaPZUjpq CehhqW25molXb72kuGuyIhm7fNEiY2Cm4IfCYdxLIRMeQMfnPPHORYMuhbqJriAywh+KQHV5yXx QDtOGyQ3yLLiP9q/xopEgd/lALZgam8YeJ8VwTRFPoZyn7baPkGt6FaOs1980yua2KzsfPIjam/ r7lcLIYgIsS1/XEXYv/JuaZUK5GCoMDFENHAecJa/gl9lzoy
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 drivers/pci/controller/cadence/pci-j721e.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index cc83a8925ce0..e70213c9060a 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -542,7 +542,7 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int j721e_pcie_remove(struct platform_device *pdev)
+static void j721e_pcie_remove(struct platform_device *pdev)
 {
 	struct j721e_pcie *pcie = platform_get_drvdata(pdev);
 	struct cdns_pcie *cdns_pcie = pcie->cdns_pcie;
@@ -552,13 +552,11 @@ static int j721e_pcie_remove(struct platform_device *pdev)
 	cdns_pcie_disable_phy(cdns_pcie);
 	pm_runtime_put(dev);
 	pm_runtime_disable(dev);
-
-	return 0;
 }
 
 static struct platform_driver j721e_pcie_driver = {
 	.probe  = j721e_pcie_probe,
-	.remove = j721e_pcie_remove,
+	.remove_new = j721e_pcie_remove,
 	.driver = {
 		.name	= "j721e-pcie",
 		.of_match_table = of_j721e_pcie_match,
-- 
2.39.2


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957D06C3AA4
	for <lists+linux-pci@lfdr.de>; Tue, 21 Mar 2023 20:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjCUTdt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Mar 2023 15:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjCUTdq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Mar 2023 15:33:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDB8570A4
        for <linux-pci@vger.kernel.org>; Tue, 21 Mar 2023 12:32:46 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pehiY-0008HH-7m; Tue, 21 Mar 2023 20:32:22 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pehiX-005l6j-HY; Tue, 21 Mar 2023 20:32:21 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pehiW-006qyX-Op; Tue, 21 Mar 2023 20:32:20 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Rob Herring <robh@kernel.org>, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 14/15] PCI: tegra: Convert to platform remove callback returning void
Date:   Tue, 21 Mar 2023 20:32:07 +0100
Message-Id: <20230321193208.366561-15-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230321193208.366561-1-u.kleine-koenig@pengutronix.de>
References: <20230321193208.366561-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1827; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=IOfMDN0R4tYk9zN39BOVlRkyokU7Y+GXqJ9ovSkiLyw=; b=owGbwMvMwMXY3/A7olbonx/jabUkhhQpNulFczP0VXgWiSy4805Nt3Ox495rXZ6Oep5bb/OVW 85lvx/eyWjMwsDIxSArpshi37gm06pKLrJz7b/LMINYmUCmMHBxCsBEXM9yMHTe3m315Utkb1Be uPGCjrQPTv1a2Xp3ZFj2fYwIkBBpm6QYvl5O5Kfr6tjivL31nce7pstcUT+naHTcS9NY4qKnlLf mlSCRd3/r7BuyWqcu+nnczezMVc4/3epTz/52Cs5ew9rYVnxq78RCoVifO0KnTsVt+85rGbvRSk MiSmCSbs+b0N3t32dNM2yZbnlMa47TkelNXvn9bu3vzlQvu3V4st2EvtpwIb7zaxN+9iZmzJJ// 9dWkyvUruqRgu+aimNBz9es+5RsmvCQh8f8yOIk9g7ng0L6S82aEq8YWvXI7pq8sMgwT93+w55p jQk9K3QWxWf/c2k+sTaRNfFbv27K3gW3Ut9NeXfZJK0CAA==
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
 drivers/pci/controller/pci-tegra.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 74c109f14ff0..59a107ed99dc 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -2680,7 +2680,7 @@ static int tegra_pcie_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int tegra_pcie_remove(struct platform_device *pdev)
+static void tegra_pcie_remove(struct platform_device *pdev)
 {
 	struct tegra_pcie *pcie = platform_get_drvdata(pdev);
 	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
@@ -2701,8 +2701,6 @@ static int tegra_pcie_remove(struct platform_device *pdev)
 
 	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
 		tegra_pcie_port_free(port);
-
-	return 0;
 }
 
 static int tegra_pcie_pm_suspend(struct device *dev)
@@ -2808,6 +2806,6 @@ static struct platform_driver tegra_pcie_driver = {
 		.pm = &tegra_pcie_pm_ops,
 	},
 	.probe = tegra_pcie_probe,
-	.remove = tegra_pcie_remove,
+	.remove_new = tegra_pcie_remove,
 };
 module_platform_driver(tegra_pcie_driver);
-- 
2.39.2


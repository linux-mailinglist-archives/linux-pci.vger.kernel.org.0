Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478657B48B1
	for <lists+linux-pci@lfdr.de>; Sun,  1 Oct 2023 19:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235208AbjJARDW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 1 Oct 2023 13:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235161AbjJARDW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 1 Oct 2023 13:03:22 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BD4D9
        for <linux-pci@vger.kernel.org>; Sun,  1 Oct 2023 10:03:19 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmzqR-0005BH-U7; Sun, 01 Oct 2023 19:03:03 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmzqM-00AKTc-Rp; Sun, 01 Oct 2023 19:02:58 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmzqM-0079nX-IU; Sun, 01 Oct 2023 19:02:58 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Santosh Shilimkar <santosh.shilimkar@ti.com>,
        Murali Karicheri <m-karicheri2@ti.com>
Cc:     Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 3/4] PCI: keystone: Don't put .remove callback in .exit.text section
Date:   Sun,  1 Oct 2023 19:02:53 +0200
Message-Id: <20231001170254.2506508-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231001170254.2506508-1-u.kleine-koenig@pengutronix.de>
References: <20231001170254.2506508-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1715; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Hr/QfLimX+7UJqAy4q3JH1FtTfAFH7k/Ct+ixkgZYDU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlGaY6TD9wyR6mM92C8zolvynMcsMsHL8QMH5y8 XWEVYn44TqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRmmOgAKCRCPgPtYfRL+ ThJOB/9viY7JtyDZIhDNMYVrNTAltrR4nHZu/azOkmjnVcr96o35Ago+Dx9YZe2J0Go68sZuL7/ ICCUJeuG4gCPqgsmhe1gGuHiujrF9IZCf6Xrm73tFmyBc8ZoZUnwFnh/p8LmKErpFrcLT+nlQ6U Bc9K6fcnmLvIm+2LcP3EWVCLsRJGIJx7wOv6JdhQi4e4Q7JJxk1HsblMxQ4l9J5k8GCEeAamGI1 UpG6NZbumq1D7VndNhxz3OZBUChgsvLcgrV2nj2yW3Kj4sTk8UfLlV6S1vCVM4SgycXcJtpyu+3 CEGPIpXixzTTwHJFG6g0rYZx34iNkoCSbU2/SXj8Ppi03emt
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

With CONFIG_PCIE_KEYSTONE=y and ks_pcie_remove() marked with __exit, the
function is discarded from the driver. In this case a bound device can
still get unbound, e.g via sysfs. Then no cleanup code is run resulting
in resource leaks or worse.

The right thing to do is do always have the remove callback available.
Note that this driver cannot be compiled as a module, so
ks_pcie_remove() was always discarded before this change and modpost
couldn't warn about this issue. Further more the __ref annotation also
prevents a warning.

Fixes: 0c4ffcfe1fbc ("PCI: keystone: Add TI Keystone PCIe driver")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pci/controller/dwc/pci-keystone.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 49aea6ce3e87..eb3fa17b243f 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -1302,7 +1302,7 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __exit ks_pcie_remove(struct platform_device *pdev)
+static int ks_pcie_remove(struct platform_device *pdev)
 {
 	struct keystone_pcie *ks_pcie = platform_get_drvdata(pdev);
 	struct device_link **link = ks_pcie->link;
@@ -1320,7 +1320,7 @@ static int __exit ks_pcie_remove(struct platform_device *pdev)
 
 static struct platform_driver ks_pcie_driver __refdata = {
 	.probe  = ks_pcie_probe,
-	.remove = __exit_p(ks_pcie_remove),
+	.remove = ks_pcie_remove,
 	.driver = {
 		.name	= "keystone-pcie",
 		.of_match_table = ks_pcie_of_match,
-- 
2.40.1


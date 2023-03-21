Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FFC6C3A97
	for <lists+linux-pci@lfdr.de>; Tue, 21 Mar 2023 20:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjCUTda (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Mar 2023 15:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjCUTd3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Mar 2023 15:33:29 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2725551F
        for <linux-pci@vger.kernel.org>; Tue, 21 Mar 2023 12:32:31 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pehiW-0008ES-GI; Tue, 21 Mar 2023 20:32:20 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pehiV-005l6F-P1; Tue, 21 Mar 2023 20:32:19 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pehiU-006qy7-U2; Tue, 21 Mar 2023 20:32:18 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     Rob Herring <robh@kernel.org>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 08/15] PCI: iproc: Convert to platform remove callback returning void
Date:   Tue, 21 Mar 2023 20:32:01 +0100
Message-Id: <20230321193208.366561-9-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230321193208.366561-1-u.kleine-koenig@pengutronix.de>
References: <20230321193208.366561-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3129; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=AbjymvMRf/21gg3dFf/LJ8mfhoO6t0bYbQgCjssNDSk=; b=owGbwMvMwMXY3/A7olbonx/jabUkhhQpNpHvWeEJset99E+8+2IS+tpO+pabyJXpRjcypuwz8 W1ZGxXWyWjMwsDIxSArpshi37gm06pKLrJz7b/LMINYmUCmMHBxCsBE2lrY/2dPiDRem+DXEapf MSVYlfm9g/Ji4VeFkXalyudncFQ35/5N/a9UufLTs9cWIQtMlfRtTyTwK8oLTzu44d2Hg395Pe6 GegWte/bd63SBe/tew3s+lb4uz3Y/kxEKtlrUtKR/M49c+gKDHmYriwrTK6bnFA/VFk+zN7wbE8 TqeeNWle4/B763l0POBD6aamit6ReS9sXOXeakKl/kvi/xL/xnLQ3jFt2qUqz3vmHOpZKK0LKGI iXVu4L7fv7xc5batG7eNDmjb9dPv7KZoxydeXdlwfMbm7dN+WL/4G/i/ZZ+rfidQiFdxkoRgSuP bNR+NFFeOlJlW/H+Xe9rPCelu+y152KN+qFVHJzO8lsCAA==
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
and this typically results in resource leaks.

The iproc driver always returns 0, it's just a bit hidden. So make
iproc_pcie_remove() return void instead of always zero and convert the
platform driver to the alternative remove callback that returns void and
eventually replaces the int returning callback.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pci/controller/pcie-iproc-platform.c | 6 +++---
 drivers/pci/controller/pcie-iproc.c          | 4 +---
 drivers/pci/controller/pcie-iproc.h          | 2 +-
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/pcie-iproc-platform.c b/drivers/pci/controller/pcie-iproc-platform.c
index 4142a73e611d..acdc583d2980 100644
--- a/drivers/pci/controller/pcie-iproc-platform.c
+++ b/drivers/pci/controller/pcie-iproc-platform.c
@@ -114,11 +114,11 @@ static int iproc_pltfm_pcie_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int iproc_pltfm_pcie_remove(struct platform_device *pdev)
+static void iproc_pltfm_pcie_remove(struct platform_device *pdev)
 {
 	struct iproc_pcie *pcie = platform_get_drvdata(pdev);
 
-	return iproc_pcie_remove(pcie);
+	iproc_pcie_remove(pcie);
 }
 
 static void iproc_pltfm_pcie_shutdown(struct platform_device *pdev)
@@ -134,7 +134,7 @@ static struct platform_driver iproc_pltfm_pcie_driver = {
 		.of_match_table = of_match_ptr(iproc_pcie_of_match_table),
 	},
 	.probe = iproc_pltfm_pcie_probe,
-	.remove = iproc_pltfm_pcie_remove,
+	.remove_new = iproc_pltfm_pcie_remove,
 	.shutdown = iproc_pltfm_pcie_shutdown,
 };
 module_platform_driver(iproc_pltfm_pcie_driver);
diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index 83029bdfd884..bd1c98b68851 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -1537,7 +1537,7 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
 }
 EXPORT_SYMBOL(iproc_pcie_setup);
 
-int iproc_pcie_remove(struct iproc_pcie *pcie)
+void iproc_pcie_remove(struct iproc_pcie *pcie)
 {
 	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
 
@@ -1548,8 +1548,6 @@ int iproc_pcie_remove(struct iproc_pcie *pcie)
 
 	phy_power_off(pcie->phy);
 	phy_exit(pcie->phy);
-
-	return 0;
 }
 EXPORT_SYMBOL(iproc_pcie_remove);
 
diff --git a/drivers/pci/controller/pcie-iproc.h b/drivers/pci/controller/pcie-iproc.h
index dcca315897c8..969ded03b8c2 100644
--- a/drivers/pci/controller/pcie-iproc.h
+++ b/drivers/pci/controller/pcie-iproc.h
@@ -111,7 +111,7 @@ struct iproc_pcie {
 };
 
 int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res);
-int iproc_pcie_remove(struct iproc_pcie *pcie);
+void iproc_pcie_remove(struct iproc_pcie *pcie);
 int iproc_pcie_shutdown(struct iproc_pcie *pcie);
 
 #ifdef CONFIG_PCIE_IPROC_MSI
-- 
2.39.2


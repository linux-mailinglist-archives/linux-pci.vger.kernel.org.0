Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40107D0B7E
	for <lists+linux-pci@lfdr.de>; Fri, 20 Oct 2023 11:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376812AbjJTJWY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Oct 2023 05:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376586AbjJTJWE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Oct 2023 05:22:04 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB6D1732
        for <linux-pci@vger.kernel.org>; Fri, 20 Oct 2023 02:21:21 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qtlgv-0000Zd-Kk; Fri, 20 Oct 2023 11:21:13 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qtlgv-002zak-1L; Fri, 20 Oct 2023 11:21:13 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qtlgu-002QqD-O0; Fri, 20 Oct 2023 11:21:12 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Will Deacon <will@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH] PCI: host-generic: Convert to platform remove callback returning void
Date:   Fri, 20 Oct 2023 11:21:07 +0200
Message-ID: <20231020092107.2148311-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.0.353.g56adddaa06d3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2867; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=qj6z6vB2KX6cuvhKy1RcC/hSLUWPjnuM56r5qbHHE38=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlMkaCACAKoAsqjssG4om0jR94C/pJ9B3UCmPcB kc7kri05MqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZTJGggAKCRCPgPtYfRL+ Tl0HCACN+0kOuf6RiyN24L/OKHLCNQs2v/9LlBN2qWFTVxde8LdH/686c5xLUlWSP4DD/emllKU v4O+wwHZ8CPSwE8VaIpMIpoiQJx1cQgm1+g50twEr0oy3HMFAkEU/FzbIwRI9fu8b4NDdwPnHia CMg3h8cdZ3FDs+kmz45fIyJ1D7OGEWep0awzrBi9AVZxf+1L+D9FWyYKlefnl027QdcbQh87XMb 4z24CYykXd4yyHUCLUJ42AW5ftnhQesADMLIthZ5IFl4oum2luLxv7kODFbPuKm6zOWaDJyPm+D 7KwTYpJO+BEdx8yu24X+yhyIfxGWbecELapwybyFphCfsLta
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code.  However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

pci_host_common_remove() returned zero unconditionally. With that
converted to return void instead, the generic pci host driver can be
switched to .remove_new trivially.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pci/controller/pci-host-common.c  | 4 +---
 drivers/pci/controller/pci-host-generic.c | 2 +-
 include/linux/pci-ecam.h                  | 2 +-
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index 6be3266cd7b5..45b71806182d 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -85,7 +85,7 @@ int pci_host_common_probe(struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(pci_host_common_probe);
 
-int pci_host_common_remove(struct platform_device *pdev)
+void pci_host_common_remove(struct platform_device *pdev)
 {
 	struct pci_host_bridge *bridge = platform_get_drvdata(pdev);
 
@@ -93,8 +93,6 @@ int pci_host_common_remove(struct platform_device *pdev)
 	pci_stop_root_bus(bridge->bus);
 	pci_remove_root_bus(bridge->bus);
 	pci_unlock_rescan_remove();
-
-	return 0;
 }
 EXPORT_SYMBOL_GPL(pci_host_common_remove);
 
diff --git a/drivers/pci/controller/pci-host-generic.c b/drivers/pci/controller/pci-host-generic.c
index 63865aeb636b..41cb6a057f6e 100644
--- a/drivers/pci/controller/pci-host-generic.c
+++ b/drivers/pci/controller/pci-host-generic.c
@@ -82,7 +82,7 @@ static struct platform_driver gen_pci_driver = {
 		.of_match_table = gen_pci_of_match,
 	},
 	.probe = pci_host_common_probe,
-	.remove = pci_host_common_remove,
+	.remove_new = pci_host_common_remove,
 };
 module_platform_driver(gen_pci_driver);
 
diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
index 6b1301e2498e..3a4860bd2758 100644
--- a/include/linux/pci-ecam.h
+++ b/include/linux/pci-ecam.h
@@ -93,6 +93,6 @@ extern const struct pci_ecam_ops loongson_pci_ecam_ops; /* Loongson PCIe */
 #if IS_ENABLED(CONFIG_PCI_HOST_COMMON)
 /* for DT-based PCI controllers that support ECAM */
 int pci_host_common_probe(struct platform_device *pdev);
-int pci_host_common_remove(struct platform_device *pdev);
+void pci_host_common_remove(struct platform_device *pdev);
 #endif
 #endif

base-commit: 2030579113a1b1b5bfd7ff24c0852847836d8fd1
-- 
2.40.0.353.g56adddaa06d3


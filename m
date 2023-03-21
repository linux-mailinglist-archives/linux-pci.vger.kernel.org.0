Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B496C3A99
	for <lists+linux-pci@lfdr.de>; Tue, 21 Mar 2023 20:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjCUTdc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Mar 2023 15:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjCUTdb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Mar 2023 15:33:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A247356164
        for <linux-pci@vger.kernel.org>; Tue, 21 Mar 2023 12:32:30 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pehiX-0008GA-Px; Tue, 21 Mar 2023 20:32:21 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pehiW-005l6S-KJ; Tue, 21 Mar 2023 20:32:20 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pehiV-006qyK-MY; Tue, 21 Mar 2023 20:32:19 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pci@vger.kernel.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 11/15] PCI: mt7621: Convert to platform remove callback returning void
Date:   Tue, 21 Mar 2023 20:32:04 +0100
Message-Id: <20230321193208.366561-12-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230321193208.366561-1-u.kleine-koenig@pengutronix.de>
References: <20230321193208.366561-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1768; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=XIs1m3pob3y8U3JDqdDB0F399dkIu3Xz7ps7Nn8DeQo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkGgYXsgcJ2ulde0UGwO1bCPx5jrsNrNECByn/+ JqPq845BOqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZBoGFwAKCRCPgPtYfRL+ TqqMB/9ISFGGASsk4hij7f9GVng8JBFLx4hkxt8tP3dVXtzaEpJsrW43rj+GMIzWNujRUPUAk5d uxGzbOYhPOTduIaZ/55aj1K4+LZlaVIxkENJfukq0K/93WfUjxXTsR32lgf8fM/iJR1FQ2xhoGD Hk5R/h3+3tg5Rk0UeREiYjSnJovr70hHnFX4FjpGO6fX7yFkqABZ5gA4ZMHzpJUtcdsJhJNM+dU GTHRzKcrk4LwqBWK9XkV7SkPme9GwzjbVa/a4vLg4cR5oGiqNPEQOeAbsZL6YEqp6J10On3J6tg Hv8rVdRa1MVU+sGvGGIPPWSIW+4JbWTob5/KCrLGVbYbs9pu
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
 drivers/pci/controller/pcie-mt7621.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controller/pcie-mt7621.c
index 63a5f4463a9f..a6df50a945d1 100644
--- a/drivers/pci/controller/pcie-mt7621.c
+++ b/drivers/pci/controller/pcie-mt7621.c
@@ -524,15 +524,13 @@ static int mt7621_pcie_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int mt7621_pcie_remove(struct platform_device *pdev)
+static void mt7621_pcie_remove(struct platform_device *pdev)
 {
 	struct mt7621_pcie *pcie = platform_get_drvdata(pdev);
 	struct mt7621_pcie_port *port;
 
 	list_for_each_entry(port, &pcie->ports, list)
 		reset_control_put(port->pcie_rst);
-
-	return 0;
 }
 
 static const struct of_device_id mt7621_pcie_ids[] = {
@@ -543,7 +541,7 @@ MODULE_DEVICE_TABLE(of, mt7621_pcie_ids);
 
 static struct platform_driver mt7621_pcie_driver = {
 	.probe = mt7621_pcie_probe,
-	.remove = mt7621_pcie_remove,
+	.remove_new = mt7621_pcie_remove,
 	.driver = {
 		.name = "mt7621-pci",
 		.of_match_table = mt7621_pcie_ids,
-- 
2.39.2


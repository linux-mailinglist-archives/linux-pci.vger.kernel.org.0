Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CAF6C3AA2
	for <lists+linux-pci@lfdr.de>; Tue, 21 Mar 2023 20:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjCUTdr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Mar 2023 15:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjCUTdp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Mar 2023 15:33:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF3A1F919
        for <linux-pci@vger.kernel.org>; Tue, 21 Mar 2023 12:32:42 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pehiZ-0008H0-Li; Tue, 21 Mar 2023 20:32:23 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pehiX-005l6g-9d; Tue, 21 Mar 2023 20:32:21 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pehiW-006qyT-H9; Tue, 21 Mar 2023 20:32:20 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 13/15] PCI: rockchip-host: Convert to platform remove callback returning void
Date:   Tue, 21 Mar 2023 20:32:06 +0100
Message-Id: <20230321193208.366561-14-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230321193208.366561-1-u.kleine-koenig@pengutronix.de>
References: <20230321193208.366561-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1911; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=ofg5jFyTz9TdBxGAvLkoTuHqV4U6+M5kLCVHC2oN85w=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkGgYaEVenR+PbZmv1vqyaQaldvtjlCJf2NK7Xb RzAKqhDjLiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZBoGGgAKCRCPgPtYfRL+ To+OB/9fjegMCZsidNokCfKIS2VY0NiiY64ungPOLTfd4v+zmDT8anQS2ZlnmQuywnWUBiyM2ci MwGV2W8/hjaRK4VxmreBZBm2lGRhAKS11SqwkmKojJTTxSHJirKrBDtu6tg/IlcBS6dOgboFG81 qkLTxU0KZAdC23KCxQSluDJQfkVq/h3nuwRgSIejPDe5te/p9f2iH4spXS/fWWeU1YK7Up+liLp UGGiDWgK2Np2MZ0x8DGnNi/Z69xN4zP/D65UFRAvCHPbKnjpdGP1kiULJHbzXyRHLzfbrN+50+V 9k5vXDKt/Ol4Sh+R8eolaLfWP9XZvi1GyHI5dkmBWJvU04BR
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
 drivers/pci/controller/pcie-rockchip-host.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index c96c0f454570..2438bc9b3a1a 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -1009,7 +1009,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int rockchip_pcie_remove(struct platform_device *pdev)
+static void rockchip_pcie_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
@@ -1029,8 +1029,6 @@ static int rockchip_pcie_remove(struct platform_device *pdev)
 		regulator_disable(rockchip->vpcie3v3);
 	regulator_disable(rockchip->vpcie1v8);
 	regulator_disable(rockchip->vpcie0v9);
-
-	return 0;
 }
 
 static const struct dev_pm_ops rockchip_pcie_pm_ops = {
@@ -1051,7 +1049,7 @@ static struct platform_driver rockchip_pcie_driver = {
 		.pm = &rockchip_pcie_pm_ops,
 	},
 	.probe = rockchip_pcie_probe,
-	.remove = rockchip_pcie_remove,
+	.remove_new = rockchip_pcie_remove,
 };
 module_platform_driver(rockchip_pcie_driver);
 
-- 
2.39.2


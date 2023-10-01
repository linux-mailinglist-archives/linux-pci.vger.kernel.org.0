Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D69F7B48B2
	for <lists+linux-pci@lfdr.de>; Sun,  1 Oct 2023 19:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235161AbjJARDX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 1 Oct 2023 13:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233932AbjJARDW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 1 Oct 2023 13:03:22 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2487CC9
        for <linux-pci@vger.kernel.org>; Sun,  1 Oct 2023 10:03:19 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmzqR-0005BI-U6; Sun, 01 Oct 2023 19:03:03 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmzqN-00AKTf-3E; Sun, 01 Oct 2023 19:02:59 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmzqM-0079nb-QF; Sun, 01 Oct 2023 19:02:58 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Santosh Shilimkar <santosh.shilimkar@ti.com>,
        Murali Karicheri <m-karicheri2@ti.com>
Cc:     Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 4/4] PCI: keystone: Don't put .probe callback in .init.text section
Date:   Sun,  1 Oct 2023 19:02:54 +0200
Message-Id: <20231001170254.2506508-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231001170254.2506508-1-u.kleine-koenig@pengutronix.de>
References: <20231001170254.2506508-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1494; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=vOH7g+tbMQ4dYt2SBya6p0hmx6B+kmvB8lPboaAFr4A=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlGaY7enKEbo/xSSagMJnGYbF8H5deeiqcwcIlX lRjMfgS2NGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRmmOwAKCRCPgPtYfRL+ Tg2cCAC07wKbQPAI/g+j7hS6ay7yt5CsJvHsocC3iOrkQcpWMmBbMH4HrNbS1U2IqXjXZjp3WgS jecUR6XnplBUHe2lB9L5q6Q8Gx+pqLIRd25WpJHk+RKmq1GsaTuaFnhGh1jWJ59w/3fUoW+MO0d pWip256y5jO4xkAvgp3I2h5VGDQVz3p6gEOmvqEG9ahqj9NUtaQ6J5SHyMPx3E3BwWhD2z7i22S 184sXROxNwuae/9x4X7vyUDKUAmHpy9HSIzUWii3jwH0NZWnxqL3wfJCE1ZXvYMvwtT1m168zwa hzwyd2C81fiescfjzmolE24p7bUIwXDha6z8XlkQncXnHyJU
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

The __init annotation makes the ks_pcie_probe() function disappear after
booting completes. However a device can also be bound later. In that
case ks_pcie_probe() is tried to be called but the backing memory is
likely already overwritten.

The right thing to do is do always have the probe callback available.
Note that the (wrong) __refdata annotation prevented this issue to be
noticed by modpost.

Fixes: 0c4ffcfe1fbc ("PCI: keystone: Add TI Keystone PCIe driver")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pci/controller/dwc/pci-keystone.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index eb3fa17b243f..0def919f89fa 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -1100,7 +1100,7 @@ static const struct of_device_id ks_pcie_of_match[] = {
 	{ },
 };
 
-static int __init ks_pcie_probe(struct platform_device *pdev)
+static int ks_pcie_probe(struct platform_device *pdev)
 {
 	const struct dw_pcie_host_ops *host_ops;
 	const struct dw_pcie_ep_ops *ep_ops;
@@ -1318,7 +1318,7 @@ static int ks_pcie_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_driver ks_pcie_driver __refdata = {
+static struct platform_driver ks_pcie_driver = {
 	.probe  = ks_pcie_probe,
 	.remove = ks_pcie_remove,
 	.driver = {
-- 
2.40.1


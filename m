Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65A47B48B4
	for <lists+linux-pci@lfdr.de>; Sun,  1 Oct 2023 19:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbjJARDb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 1 Oct 2023 13:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235209AbjJARDa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 1 Oct 2023 13:03:30 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01684DA
        for <linux-pci@vger.kernel.org>; Sun,  1 Oct 2023 10:03:26 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmzqR-0005BG-U6; Sun, 01 Oct 2023 19:03:03 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmzqM-00AKTZ-Ki; Sun, 01 Oct 2023 19:02:58 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmzqM-0079nT-BJ; Sun, 01 Oct 2023 19:02:58 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 2/4] PCI: kirin: Don't put .remove callback in .exit.text section
Date:   Sun,  1 Oct 2023 19:02:52 +0200
Message-Id: <20231001170254.2506508-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231001170254.2506508-1-u.kleine-koenig@pengutronix.de>
References: <20231001170254.2506508-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1699; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=CWtdoFVKXqYzImyGIFt1yeoCIVYWiEHMUBw7PGKiOJk=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlTJZZZiJ/lXbPb4lXu6tcVtrcEidfa1zduVP0n+2bNsp yNvTuP+TkZjFgZGLgZZMUUW+8Y1mVZVcpGda/9dhhnEygQyhYGLUwAm4uXPwTDtTO+LswU8W9+5 yuw6HCtj45O/V4fPvWPCwQlSC/52c3L95L0sk69oK2sRX9Nqfdgn2SEw/ePW/9di94rw33roOkH Tqjic3ypIzO/M7nSthaKT1lfulO5Lslgo+1N6onUn16RLPfuSlk6XObZq2bq2xQ+/fFOc6eXnvf /Y/iSFjYb8kfnGsSUfWaKcq3yUdEv6CjS2JdTfYu7SNWAwfNuQ+0Kw/vrWCq35u7N1DjWIvrqW9 +F78uejj465Kkc+Zc/0+hbAq8l5Syss4bee76H07eLdVqlHStRKlcyPxC+2VQjzVA/bzP8lOqkp L03WSX+t1qL2hILVuqvUbj5+s2J5rdvkCr4fZerTnSoB
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

With CONFIG_PCIE_KIRIN=y and kirin_pcie_remove() marked with __exit, the
function is discarded from the driver. In this case a bound device can
still get unbound, e.g via sysfs. Then no cleanup code is run resulting
in resource leaks or worse.

The right thing to do is do always have the remove callback available.
This fixes the following warning by modpost:

	drivers/pci/controller/dwc/pcie-kirin: section mismatch in reference: kirin_pcie_driver+0x8 (section: .data) -> kirin_pcie_remove (section: .exit.text)

(with ARCH=x86_64 W=1 allmodconfig).

Fixes: 000f60db784b ("PCI: kirin: Add support for a PHY layer")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pci/controller/dwc/pcie-kirin.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index d93bc2906950..2ee146767971 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -741,7 +741,7 @@ static int kirin_pcie_power_on(struct platform_device *pdev,
 	return ret;
 }
 
-static int __exit kirin_pcie_remove(struct platform_device *pdev)
+static int kirin_pcie_remove(struct platform_device *pdev)
 {
 	struct kirin_pcie *kirin_pcie = platform_get_drvdata(pdev);
 
@@ -818,7 +818,7 @@ static int kirin_pcie_probe(struct platform_device *pdev)
 
 static struct platform_driver kirin_pcie_driver = {
 	.probe			= kirin_pcie_probe,
-	.remove	        	= __exit_p(kirin_pcie_remove),
+	.remove	        	= kirin_pcie_remove,
 	.driver			= {
 		.name			= "kirin-pcie",
 		.of_match_table		= kirin_pcie_match,
-- 
2.40.1


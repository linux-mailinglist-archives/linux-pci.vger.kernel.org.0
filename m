Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7656C50850F
	for <lists+linux-pci@lfdr.de>; Wed, 20 Apr 2022 11:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377254AbiDTJiI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Apr 2022 05:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377262AbiDTJiG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Apr 2022 05:38:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBF719281
        for <linux-pci@vger.kernel.org>; Wed, 20 Apr 2022 02:35:18 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nh6jx-0008CZ-K9; Wed, 20 Apr 2022 11:35:13 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nh6jx-0048aY-Bz; Wed, 20 Apr 2022 11:35:11 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nh6jv-004S7K-Ak; Wed, 20 Apr 2022 11:35:11 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Daire McNamara <daire.mcnamara@microchip.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, Ian Cowan <ian@linux.cowan.aero>,
        kernel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Conor.Dooley@microchip.com
Subject: [PATCH] PCI: microchip: Allow driver to be built as a module
Date:   Wed, 20 Apr 2022 11:34:49 +0200
Message-Id: <20220420093449.38054-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=892; h=from:subject; bh=+GAShF90LXprtlgfT/ht0KRsfC02fLvQ7/Vg+vV9Q+4=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBiX9O1F1wk8+VgQYzQpGBIiIn53ZiMcAulex74oSv6 ljalSTWJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYl/TtQAKCRDB/BR4rcrsCQHSB/ 9pHfrGsjzF7yHdpmOdJOv9foMAaftBc9KinzUGAzKdktqLYKLclKQCZO1CrxQZLaTgII81bdvgFuZ6 zz3sSFqA0c6Ap/uIhG7abSggLIuWasty5KBaOEgi+GmSdlkk83C6nuRjHgBSH6o7rf6QN3Fdsgh7Yp 4oaDSS5qJbntYRzNI6Q+NLZnB1vvJp2oKc9XK4oMbmTqaK3WY0mTxCpwY/3sRUaAH2ByjvoPlL3Lna 4ktaRXIn07rE9dmlu3akptfNeilymIbTIVyry1z28kiIjx861rFatzAmYZypGUyTUU7LXuZhf73H5B jOec6BrMCzuT3ZDtyDZdm538MXh0Uk
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

There are no known reasons to not use this driver as a module, so allow
to configure PCIE_MICROCHIP_HOST=m.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pci/controller/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index b8d96d38064d..6eae2289410a 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -301,7 +301,7 @@ config PCI_LOONGSON
 	  Loongson systems.
 
 config PCIE_MICROCHIP_HOST
-	bool "Microchip AXI PCIe host bridge support"
+	tristate "Microchip AXI PCIe host bridge support"
 	depends on PCI_MSI && OF
 	select PCI_MSI_IRQ_DOMAIN
 	select GENERIC_MSI_IRQ_DOMAIN

base-commit: 3123109284176b1532874591f7c81f3837bbdc17
prerequisite-patch-id: e8aad0ef8193038684bc2e10d387a7b74da1116a
-- 
2.35.1


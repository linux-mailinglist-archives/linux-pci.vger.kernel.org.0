Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D714BD10A
	for <lists+linux-pci@lfdr.de>; Sun, 20 Feb 2022 20:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244652AbiBTTe6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 20 Feb 2022 14:34:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244649AbiBTTe5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 20 Feb 2022 14:34:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820B64507D
        for <linux-pci@vger.kernel.org>; Sun, 20 Feb 2022 11:34:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B627B80DC1
        for <linux-pci@vger.kernel.org>; Sun, 20 Feb 2022 19:34:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2327DC36AE2;
        Sun, 20 Feb 2022 19:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645385674;
        bh=Yk4h7+6wOvhJPfvPdF/6j11Ecoy3msqIfaKocxRvsyA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c2O5paZfjIqr9KmrrhqvUKnxdmaa0wPzAODPkX7SAOnrIYl09uLJaEjTib1Nky3GL
         +i9Ahri204IGa3IG+pBEqyNCj/h7ISO3NOb3axU0vloT9vASJbythfcpN7zd6Bna80
         PCeUoEyqLIdQLG6/F6g57XstrY/ryFhkjPxDu9BWp3vA+5DnDQOIXLV/fnoQo/DtFm
         I/VnuIui2zFetFljgdjAqkQbvwsr6a1P5OxKlFv51bMD9LYNgwkIyuc+73Z3YDOgzM
         lMWBckMDA7nHHVzzW9GCoEWpKv3edCJm97+RH2MGqtRkKz+bRfRknuL5LcpRxTlFkA
         eH7bU3lAlwggg==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Marc Zyngier <maz@kernel.org>, pali@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 18/18] PCI: aardvark: Optimize PCIe card reset via GPIO
Date:   Sun, 20 Feb 2022 20:33:46 +0100
Message-Id: <20220220193346.23789-19-kabel@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220220193346.23789-1-kabel@kernel.org>
References: <20220220193346.23789-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

Currently we always assert reset GPIO (if it is available) for ~10ms.
But if the GPIO was asserted before driver probe (by bootloader for
example), we do not need to wait these 10ms.

Assert reset GPIO for 10ms only if it wasn't asserted.

We need to get the GPIO with flag GPIOD_FLAGS_BIT_DIR_OUT instead of
GPIOD_OUT_LOW, so that it's value isn't changed when getting it.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 056f49d0e3a4..80eb6e98923f 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -431,10 +431,17 @@ static void advk_pcie_issue_perst(struct advk_pcie *pcie)
 	if (!pcie->reset_gpio)
 		return;
 
-	/* 10ms delay is needed for some cards */
-	dev_info(&pcie->pdev->dev, "issuing PERST via reset GPIO for 10ms\n");
-	gpiod_set_value_cansleep(pcie->reset_gpio, 1);
-	usleep_range(10000, 11000);
+	/*
+	 * Assert PERST# for at least 10ms if it wasn't asserted yet (it could
+	 * have been asserted by bootloader or by GPIO driver, for example).
+	 */
+	if (!gpiod_get_value(pcie->reset_gpio)) {
+		dev_info(&pcie->pdev->dev, "issuing PERST via reset GPIO for 10ms\n");
+		gpiod_set_value_cansleep(pcie->reset_gpio, 1);
+		usleep_range(10000, 11000);
+	}
+
+	/* De-assert PERST# */
 	gpiod_set_value_cansleep(pcie->reset_gpio, 0);
 }
 
@@ -2049,7 +2056,7 @@ static int advk_pcie_probe(struct platform_device *pdev)
 
 	pcie->reset_gpio = devm_gpiod_get_from_of_node(dev, dev->of_node,
 						       "reset-gpios", 0,
-						       GPIOD_OUT_LOW,
+						       GPIOD_FLAGS_BIT_DIR_OUT,
 						       "pcie1-reset");
 	ret = PTR_ERR_OR_ZERO(pcie->reset_gpio);
 	if (ret) {
-- 
2.34.1


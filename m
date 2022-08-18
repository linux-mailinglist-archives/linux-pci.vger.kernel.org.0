Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B4A5984CA
	for <lists+linux-pci@lfdr.de>; Thu, 18 Aug 2022 15:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245312AbiHRNwG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Aug 2022 09:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245314AbiHRNwD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Aug 2022 09:52:03 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BC061B28
        for <linux-pci@vger.kernel.org>; Thu, 18 Aug 2022 06:52:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7D2A9CE205A
        for <linux-pci@vger.kernel.org>; Thu, 18 Aug 2022 13:52:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 459DFC433C1;
        Thu, 18 Aug 2022 13:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660830718;
        bh=snynf6vI9g6lx4We//tC0xZE+ub4KkCEIjZQ8UQE3RI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L/7pdxeGNMAk4J8yYcb0RTyZGxVMXMzjs0sxRBwb4aRaQfFqEqtv1UrnIpwVSeaMg
         LywldMtf6NTx9JHk7GIWJgZTnvz6SvkpPNRvfOrVc6P50OU2Ff3Ph6NZeW775Q1CkO
         exaWocxgWtcsSm+5yAJdj2Ctq+Ghh3le1dzaPkeYVcSUgaGhWBqIaFFZuaAydhH8bX
         T/Oqtt1CTsYpyzGRU7PrJk5SeyQWdxRgknh14G0L/U0IcvS1t1wiZf6VPFlSg6nrnl
         D5VG6ALHVVa/Io8nw9pyTQK8Ivfy46WAAaloqg5JjGELPNRQBX6lKLYtSMHdxtRNQq
         g59mm+Lwt1Y4Q==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        pali@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 07/11] PCI: aardvark: Add suspend to RAM support
Date:   Thu, 18 Aug 2022 15:51:36 +0200
Message-Id: <20220818135140.5996-8-kabel@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220818135140.5996-1-kabel@kernel.org>
References: <20220818135140.5996-1-kabel@kernel.org>
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

From: Miquel Raynal <miquel.raynal@bootlin.com>

Add suspend and resume callbacks. We need to use the NOIRQ variants to
ensure the controller's IRQ handlers are not run during suspend() /
resume(), which could cause races.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
Changes since batch 5:
- clarified commit message
- changed to new macro NOIRQ_SYSTEM_SLEEP_PM_OPS, as was done for many
  PCI controller drivers with commit 19b7858c3357 ("PCI: Convert to new
  *_PM_OPS macros")
---
 drivers/pci/controller/pci-aardvark.c | 34 +++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 3beafc893969..e30a33a4ecc6 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1890,6 +1890,39 @@ static int advk_pcie_setup_phy(struct advk_pcie *pcie)
 	return ret;
 }
 
+static int advk_pcie_suspend(struct device *dev)
+{
+	struct advk_pcie *pcie = dev_get_drvdata(dev);
+
+	advk_pcie_disable_phy(pcie);
+
+	clk_disable_unprepare(pcie->clk);
+
+	return 0;
+}
+
+static int advk_pcie_resume(struct device *dev)
+{
+	struct advk_pcie *pcie = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(pcie->clk);
+	if (ret)
+		return ret;
+
+	ret = advk_pcie_enable_phy(pcie);
+	if (ret)
+		return ret;
+
+	advk_pcie_setup_hw(pcie);
+
+	return 0;
+}
+
+static const struct dev_pm_ops advk_pcie_dev_pm_ops = {
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(advk_pcie_suspend, advk_pcie_resume)
+};
+
 static int advk_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -2167,6 +2200,7 @@ static struct platform_driver advk_pcie_driver = {
 	.driver = {
 		.name = "advk-pcie",
 		.of_match_table = advk_pcie_of_match_table,
+		.pm = &advk_pcie_dev_pm_ops,
 	},
 	.probe = advk_pcie_probe,
 	.remove = advk_pcie_remove,
-- 
2.35.1


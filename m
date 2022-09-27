Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B8E5EC5D7
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 16:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbiI0OUZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 10:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232183AbiI0OUC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 10:20:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57809AEDB5
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 07:19:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8EB0B81C06
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 14:19:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D273AC433B5;
        Tue, 27 Sep 2022 14:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664288383;
        bh=o7J6npk2M1p2mUy6ywvZZk3hCCRvaTeij5XETt0TETY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T1HO6/4WY5vpwoo/AiwFbL9VjHuxwuwsvzU/GUUE2GZNJNnCCOHy+51Au7JZuDG6R
         QfmlncIE0R9axvANVT8IXj3G+pUaOYUrAZT0YdkqVeckAO1tKpyOK0wzITSTYaM6GQ
         UvmI5IoVY7sdZnv4uDqYCvWlEYu3/f56qq1dGMzjK3rGTzUxiH2IvuwSwVT45F6OXX
         kKq1T8IATC/JOjuJtJFqrfQsS+rKuKGvAjoDRX7uEMeX6Y1BL3HrZBqibrfeQ01Tii
         tFiajoZ8pTnhFmLZGSVmTYHPqWCSAyRcqtlFZUwX8wSDvnlKzGqWticllasEazd1M7
         9VlYmSYYeqLBQ==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>, pali@kernel.org,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 06/10] PCI: aardvark: Add suspend to RAM support
Date:   Tue, 27 Sep 2022 16:19:22 +0200
Message-Id: <20220927141926.8895-7-kabel@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220927141926.8895-1-kabel@kernel.org>
References: <20220927141926.8895-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

Add suspend and resume callbacks. We need to use the _noirq variants
via
  NOIRQ_SYSTEM_SLEEP_PM_OPS(),
because these are called when IRQ handlers are disabled, as explained
in Documentation/driver-api/pm/devices.rst. This ensures that the
PCIe controller's IRQ handler is not called during suspend/resume
handler, as this could cause races, as explained in the above
mentioned file, section Entering System Suspend.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
Changes since batch 6 v1:
- more explicit commit message
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


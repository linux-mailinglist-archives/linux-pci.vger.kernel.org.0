Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E476F9EBC
	for <lists+linux-pci@lfdr.de>; Mon,  8 May 2023 06:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjEHElT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 May 2023 00:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjEHElS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2023 00:41:18 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76561569E;
        Sun,  7 May 2023 21:41:16 -0700 (PDT)
Received: from amy-vm.localdomain ([10.12.169.124])
        (user=yejunyan@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 3484bSF4021609-3484bSF5021609
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 8 May 2023 12:37:33 +0800
From:   Junyan Ye <yejunyan@hust.edu.cn>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Junyan Ye <yejunyan@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] pci: controller: pci-ftpci100: Release the clock resources
Date:   Mon,  8 May 2023 12:36:41 +0800
Message-Id: <20230508043641.23807-1-yejunyan@hust.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: yejunyan@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Smatch reported:
1. drivers/pci/controller/pci-ftpci100.c:526 faraday_pci_probe() warn:
'clk' from clk_prepare_enable() not released on lines: 442,451,462,478,512,517.
2. drivers/pci/controller/pci-ftpci100.c:526 faraday_pci_probe() warn:
'p->bus_clk' from clk_prepare_enable() not released on lines: 451,462,478,512,517.

The clock resource is obtained by devm_clk_get(), and then
clk_prepare_enable() makes the clock resource ready for use. After that,
clk_disable_unprepare() should be called to release the clock resource
when it is no longer needed. However, while doing some error handling
in faraday_pci_probe(), clk_disable_unprepare() is not called to release
clk and p->bus_clk before returning. These return lines are exactly 442,
451, 462, 478, 512, 517.

Fix this warning by replacing devm_clk_get() with devm_clk_get_enabled(),
which is equivalent to devm_clk_get() + clk_prepare_enable(). And with
devm_clk_get_enabled(), the clock will automatically be disabled,
unprepared and freed when the device is unbound from the bus.

Fixes: b3c433efb8a3 ("PCI: faraday: Fix wrong pointer passed to PTR_ERR()")
Fixes: 2eeb02b28579 ("PCI: faraday: Add clock handling")
Fixes: 783a862563f7 ("PCI: faraday: Use pci_parse_request_of_pci_ranges()")
Fixes: d3c68e0a7e34 ("PCI: faraday: Add Faraday Technology FTPCI100 PCI Host Bridge driver")
Fixes: f1e8bd21e39e ("PCI: faraday: Convert IRQ masking to raw PCI config accessors")
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
Signed-off-by: Junyan Ye <yejunyan@hust.edu.cn>
---
v2 -> v3: Rebase to v6.4-rc1 and modify commit message.
v1 -> v2: Switch from clk_disable_unprepare() to devm_clk_get_enabled() to release the clock.
This issue is found by static analyzer.

 drivers/pci/controller/pci-ftpci100.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/pci-ftpci100.c b/drivers/pci/controller/pci-ftpci100.c
index ecd3009df586..6e7981d2ed5e 100644
--- a/drivers/pci/controller/pci-ftpci100.c
+++ b/drivers/pci/controller/pci-ftpci100.c
@@ -429,22 +429,12 @@ static int faraday_pci_probe(struct platform_device *pdev)
 	p->dev = dev;
 
 	/* Retrieve and enable optional clocks */
-	clk = devm_clk_get(dev, "PCLK");
+	clk = devm_clk_get_enabled(dev, "PCLK");
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
-	ret = clk_prepare_enable(clk);
-	if (ret) {
-		dev_err(dev, "could not prepare PCLK\n");
-		return ret;
-	}
-	p->bus_clk = devm_clk_get(dev, "PCICLK");
+	p->bus_clk = devm_clk_get_enabled(dev, "PCICLK");
 	if (IS_ERR(p->bus_clk))
 		return PTR_ERR(p->bus_clk);
-	ret = clk_prepare_enable(p->bus_clk);
-	if (ret) {
-		dev_err(dev, "could not prepare PCICLK\n");
-		return ret;
-	}
 
 	p->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(p->base))
-- 
2.25.1


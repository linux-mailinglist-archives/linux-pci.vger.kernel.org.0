Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F636EBD33
	for <lists+linux-pci@lfdr.de>; Sun, 23 Apr 2023 07:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjDWFec (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Apr 2023 01:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjDWFec (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 23 Apr 2023 01:34:32 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A371736;
        Sat, 22 Apr 2023 22:34:30 -0700 (PDT)
Received: from amy-vm.localdomain ([10.12.183.232])
        (user=yejunyan@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 33N5XPSO011752-33N5XPSP011752
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Sun, 23 Apr 2023 13:33:30 +0800
From:   Junyan Ye <yejunyan@hust.edu.cn>
To:     christophe.jaillet@wanadoo.fr,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
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
Subject: [PATCH v2] pci: controller: pci-ftpci100: Release the clock resources
Date:   Sun, 23 Apr 2023 13:32:07 +0800
Message-Id: <20230423053208.2348-1-yejunyan@hust.edu.cn>
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
1. drivers/pci/controller/pci-ftpci100.c:526 faraday_pci_probe()
warn: 'clk' from clk_prepare_enable() not released on lines:
442,451,462,478,512,517.
2. drivers/pci/controller/pci-ftpci100.c:526 faraday_pci_probe()
warn: 'p->bus_clk' from clk_prepare_enable() not released on lines:
451,462,478,512,517.

The clock resource is obtained by the devm_clk_get function. The
clk_prepare_enable function then makes the clock resource ready for use,
notifying the system that the clock resource should be run. After that,
the clock resource should be released when it is no longer needed. The
corresponding function is clk_disable_unprepare. However, while doing
some error handling in the faraday_pci_probe function, the
clk_disable_unprepare function is not called to release the clk and
p->bus_clk resources.

Fix this warning by changing the devm_clk_get function to
devm_clk_get_enabled, which is equivalent to
devm_clk_get() + clk_prepare_enable(). And with the
devm_clk_get_enabled function, the clock will automatically be
disabled, unprepared and freed when the device is unbound from the bus.

Fixes: b3c433efb8a3 ("PCI: faraday: Fix wrong pointer passed to PTR_ERR()")
Fixes: 2eeb02b28579 ("PCI: faraday: Add clock handling")
Fixes: 783a862563f7 ("PCI: faraday: Use pci_parse_request_of_pci_ranges()")
Fixes: d3c68e0a7e34 ("PCI: faraday: Add Faraday Technology FTPCI100 PCI Host Bridge driver")
Fixes: f1e8bd21e39e ("PCI: faraday: Convert IRQ masking to raw PCI config accessors")
Signed-off-by: Junyan Ye <yejunyan@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
---
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


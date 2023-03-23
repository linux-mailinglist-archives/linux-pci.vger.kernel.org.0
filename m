Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6386C610E
	for <lists+linux-pci@lfdr.de>; Thu, 23 Mar 2023 08:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjCWHq1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Mar 2023 03:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjCWHqW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Mar 2023 03:46:22 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA041ADDE;
        Thu, 23 Mar 2023 00:45:58 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VeTWy0P_1679557554;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VeTWy0P_1679557554)
          by smtp.aliyun-inc.com;
          Thu, 23 Mar 2023 15:45:55 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     hongxing.zhu@nxp.com
Cc:     l.stach@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, lpieralisi@kernel.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] PCI: imx6: Use devm_platform_get_and_ioremap_resource()
Date:   Thu, 23 Mar 2023 15:45:53 +0800
Message-Id: <20230323074553.90372-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

According to commit 890cc39a8799 ("drivers: provide
devm_platform_get_and_ioremap_resource()"), convert
platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 55a0405b921d..c61c85e09c4b 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1259,8 +1259,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 			return PTR_ERR(imx6_pcie->phy_base);
 	}
 
-	dbi_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pci->dbi_base = devm_ioremap_resource(dev, dbi_base);
+	pci->dbi_base = devm_platform_get_and_ioremap_resource(pdev, 0, &dbi_base);
 	if (IS_ERR(pci->dbi_base))
 		return PTR_ERR(pci->dbi_base);
 
-- 
2.20.1.7.g153144c


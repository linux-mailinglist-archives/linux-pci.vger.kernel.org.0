Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F629545EF1
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jun 2022 10:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245289AbiFJI3Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jun 2022 04:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347597AbiFJI1o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2022 04:27:44 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E513826F7;
        Fri, 10 Jun 2022 01:25:53 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 0ACF6BD8;
        Fri, 10 Jun 2022 11:26:34 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 0ACF6BD8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1654849594;
        bh=TKeiPw73UkAdUU+xrZ/SQHx4mLKyI2VePVBMGJJK00k=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=Rk22/SLo6im/ovg/qWwA92XNLN1NQd2erZGOzu6lrdwI4ZzCuftIhHPlyIteo8qm6
         QdDUlkHR5yHMqECaKHq4Bch/XK8pGuJBmrCFu53SB0BzaFW8W82tbpThCs4x/x1q+l
         pD86goE4jsUVZdgpmS7SC2kd+qjtdn3w8J/jSRRw=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 10 Jun 2022 11:25:41 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 07/18] PCI: dwc: Add braces to the multi-line if-else statements
Date:   Fri, 10 Jun 2022 11:25:23 +0300
Message-ID: <20220610082535.12802-8-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220610082535.12802-1-Sergey.Semin@baikalelectronics.ru>
References: <20220610082535.12802-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In accordance with [1] if there is at least one multi-line if-else
clause in the statement, then each clause will need to be surrounded by
the braces. The driver code violates that coding style rule in a few
places. Let's fix it.

[1] Documentation/process/coding-style.rst

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 4 ++--
 drivers/pci/controller/dwc/pcie-designware.c    | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 13c2e73f0eaf..7ad349c32082 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -699,9 +699,9 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 
 	if (!pci->dbi_base2) {
 		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi2");
-		if (!res)
+		if (!res) {
 			pci->dbi_base2 = pci->dbi_base + SZ_4K;
-		else {
+		} else {
 			pci->dbi_base2 = devm_pci_remap_cfg_resource(dev, res);
 			if (IS_ERR(pci->dbi_base2))
 				return PTR_ERR(pci->dbi_base2);
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 5848cc520b52..d0061735b434 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -699,8 +699,9 @@ void dw_pcie_iatu_detect(struct dw_pcie *pci)
 			pci->atu_size = SZ_4K;
 
 		dw_pcie_iatu_detect_regions_unroll(pci);
-	} else
+	} else {
 		dw_pcie_iatu_detect_regions(pci);
+	}
 
 	dev_info(pci->dev, "iATU unroll: %s\n", pci->iatu_unroll_enabled ?
 		"enabled" : "disabled");
-- 
2.35.1


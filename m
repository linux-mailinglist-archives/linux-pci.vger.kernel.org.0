Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDAA7519030
	for <lists+linux-pci@lfdr.de>; Tue,  3 May 2022 23:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242888AbiECV1W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 May 2022 17:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242807AbiECV1G (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 May 2022 17:27:06 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 50CF041628;
        Tue,  3 May 2022 14:23:32 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 4C90D16D1;
        Wed,  4 May 2022 00:24:05 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 4C90D16D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1651613045;
        bh=4OLkEPnNiaEYM2Le/qmF6TkXVnEMMKdL6uK97mFME5Y=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=eN16idtFtSgSZMQPsnxUgL+JvjevtGUBpGQ3Rg8C97ZRLUb4f8J3Nwnsga6Ra5CJy
         1NSyXJzuzbnXzss9NBbQn04eY2nZ0H/o4eHBneZOHfdj7tC/jXlJ+pOMstNen/bGXO
         wznZ6/Vpsjmog7HfzreJ9hCjOUf3TpNc61AojtfU=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 4 May 2022 00:23:31 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 06/13] PCI: dwc: Add braces to the multi-line if-else statements
Date:   Wed, 4 May 2022 00:22:53 +0300
Message-ID: <20220503212300.30105-7-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220503212300.30105-1-Sergey.Semin@baikalelectronics.ru>
References: <20220503212300.30105-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 4 ++--
 drivers/pci/controller/dwc/pcie-designware.c    | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 0eda8236c125..7c9315fffe24 100644
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
index d737af058903..9f4d2b44612b 100644
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


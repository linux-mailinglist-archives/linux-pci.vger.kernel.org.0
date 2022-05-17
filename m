Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC4752A205
	for <lists+linux-pci@lfdr.de>; Tue, 17 May 2022 14:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346495AbiEQMvz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 May 2022 08:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346464AbiEQMvw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 May 2022 08:51:52 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D7DD3A72C;
        Tue, 17 May 2022 05:51:45 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 3FF74BD9;
        Tue, 17 May 2022 15:52:41 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 3FF74BD9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1652791961;
        bh=MBFfEYWBn9NnwWI6fHyW8yfe6AKk/ZfnrvWbq2mNjbE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=CajE4rL1xH31fJIgayx2K2Ar1MzU/xvx0llhqeNCl4mkZSgesvo7RGwC5Q5/hdfHE
         1icQBuBUlRqRiBB2HTNAY5azXxl3p3nv4wFmZiEtxbAio4nL5oOyDfqMl7qOauRWJ/
         j0ZFIVTujoyunj6JXFC1gbt8Yxn3H2VUi0sR9qTs=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 17 May 2022 15:51:44 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 08/13] PCI: dwc: Discard IP-core version checking on unrolled iATU detection
Date:   Tue, 17 May 2022 15:50:53 +0300
Message-ID: <20220517125058.18488-9-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220517125058.18488-1-Sergey.Semin@baikalelectronics.ru>
References: <20220517125058.18488-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_XBL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

It's pretty much pointless. Even though unrolled version of the internal
ATU has been indeed available since DWC PCIe v4.80a IP-core, there is no
guarantee it was enabled during the IP-core configuration (Synopsys
suggests to contact the Solvnet support for guidance of how to do that for
the newer IP-cores). So the only reliable way to find out the unrolled
iATU feature availability is indeed to check the iATU viewport register
content. In accordance with the reference manual [1] if the register
doesn't exist (unrolled iATU is enabled) it's content is fixed with
0xff-s, otherwise it will contain some zeros. So we can freely drop the
IP-core version checking in this matter then and use the
dw_pcie_iatu_unroll_enabled() method only to detect whether iATU/eDMA
space is unrolled.

[1] DesignWare Cores, PCI Express Controller, Register Desciptions,
v.4.90a, December 2016, p.855

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 62382eda5533..f4d9184258c4 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -600,15 +600,15 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 link_gen)
 
 }
 
-static u8 dw_pcie_iatu_unroll_enabled(struct dw_pcie *pci)
+static bool dw_pcie_iatu_unroll_enabled(struct dw_pcie *pci)
 {
 	u32 val;
 
 	val = dw_pcie_readl_dbi(pci, PCIE_ATU_VIEWPORT);
 	if (val == 0xffffffff)
-		return 1;
+		return true;
 
-	return 0;
+	return false;
 }
 
 static void dw_pcie_iatu_detect_regions_unroll(struct dw_pcie *pci)
@@ -680,9 +680,8 @@ void dw_pcie_iatu_detect(struct dw_pcie *pci)
 	struct device *dev = pci->dev;
 	struct platform_device *pdev = to_platform_device(dev);
 
-	if (pci->version >= 0x480A || (!pci->version &&
-				       dw_pcie_iatu_unroll_enabled(pci))) {
-		pci->iatu_unroll_enabled = true;
+	pci->iatu_unroll_enabled = dw_pcie_iatu_unroll_enabled(pci);
+	if (pci->iatu_unroll_enabled) {
 		if (!pci->atu_base) {
 			struct resource *res =
 				platform_get_resource_byname(pdev, IORESOURCE_MEM, "atu");
-- 
2.35.1


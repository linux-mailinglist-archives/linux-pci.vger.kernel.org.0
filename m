Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A180A545F00
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jun 2022 10:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347370AbiFJI3e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jun 2022 04:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347644AbiFJI1q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2022 04:27:46 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3CE202A3;
        Fri, 10 Jun 2022 01:25:56 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 6F41EBD1;
        Fri, 10 Jun 2022 11:26:35 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 6F41EBD1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1654849595;
        bh=JD1oPiZAWSH2srGkuCaPH6/N1KlUYxj06tr7sZo7uHc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=ZFCvQhLR9bcyCG62CYwX4FaoB8JSBFaP9g7/dHLhYgzylWYVjUAKA1oZAt3xczJGn
         jzhPL0xmcrepKsFcP3QoL9c7E1Bnp0FircPTgCix8kfTqWYJchE/PsTmhqWClSPPJz
         3NQvVr0VATBppHTRWa93ZmsR1IRbML5n+FtVfLMI=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 10 Jun 2022 11:25:43 +0300
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
Subject: [PATCH v4 09/18] PCI: dwc: Discard IP-core version checking on unrolled iATU detection
Date:   Fri, 10 Jun 2022 11:25:25 +0300
Message-ID: <20220610082535.12802-10-Sergey.Semin@baikalelectronics.ru>
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
index ac966ed28c5b..e5c30695f664 100644
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


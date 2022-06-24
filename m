Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88556559BAF
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 16:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbiFXOfX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jun 2022 10:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbiFXOfF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jun 2022 10:35:05 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D69656389;
        Fri, 24 Jun 2022 07:34:48 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 40B6916D9;
        Fri, 24 Jun 2022 17:35:59 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 40B6916D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1656081359;
        bh=BDFvVhP/Qr6UDGMcQeWUZZadOHGLxnTuzPCd2YfNAn8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=AIVzDbgiQ+Vy7LS6ymjRldQXwaqPX4Gpzq5olsC+R4RHe4Vezsz0YTjItYl7aV2JC
         hgaMmKRLrI8biWEWmtpM9QjwtK0NXLabxpP8Vu5Yytj3ymRoHOtKuMkZcHlWMt0qVs
         FWbmojdl78qZqKw4dOBG3RjLo/gepZdH0S5QE67E=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 24 Jun 2022 17:34:39 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND v5 11/18] PCI: dwc: Organize local variables usage
Date:   Fri, 24 Jun 2022 17:34:21 +0300
Message-ID: <20220624143428.8334-12-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220624143428.8334-1-Sergey.Semin@baikalelectronics.ru>
References: <20220624143428.8334-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There are several places in the common DW PCIe code with incoherent local
variables usage: a variable is defined and initialized with a structure
field, but the structure pointer is de-referenced to access that field
anyway; the local variable is defined and initialized but either used just
once or not used afterwards in the main part of the subsequent method.
It's mainly concerns the pcie_port.dev field. Let's fix that in the
relevant places.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changelog v4:
- This is a new patch created on the v4 lap of the series.
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 12 ++++++------
 drivers/pci/controller/dwc/pcie-designware.c      |  8 +++-----
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 9a4922b714e5..54257874c154 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -296,7 +296,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	struct resource *cfg_res;
 	int ret;
 
-	raw_spin_lock_init(&pci->pp.lock);
+	raw_spin_lock_init(&pp->lock);
 
 	cfg_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
 	if (cfg_res) {
@@ -388,15 +388,15 @@ int dw_pcie_host_init(struct pcie_port *pp)
 							    dw_chained_msi_isr,
 							    pp);
 
-			ret = dma_set_mask(pci->dev, DMA_BIT_MASK(32));
+			ret = dma_set_mask(dev, DMA_BIT_MASK(32));
 			if (ret)
-				dev_warn(pci->dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
+				dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
 
-			pp->msi_data = dma_map_single_attrs(pci->dev, &pp->msi_msg,
+			pp->msi_data = dma_map_single_attrs(dev, &pp->msi_msg,
 						      sizeof(pp->msi_msg),
 						      DMA_FROM_DEVICE,
 						      DMA_ATTR_SKIP_CPU_SYNC);
-			ret = dma_mapping_error(pci->dev, pp->msi_data);
+			ret = dma_mapping_error(dev, pp->msi_data);
 			if (ret) {
 				dev_err(pci->dev, "Failed to map MSI data\n");
 				pp->msi_data = 0;
@@ -633,7 +633,7 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 		}
 
 		if (pci->num_ob_windows <= atu_idx)
-			dev_warn(pci->dev, "Resources exceed number of ATU entries (%d)\n",
+			dev_warn(dev, "Resources exceed number of ATU entries (%d)\n",
 				 pci->num_ob_windows);
 	}
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index f9613835212b..ce01187947c9 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -677,8 +677,7 @@ static void dw_pcie_iatu_detect_regions(struct dw_pcie *pci)
 
 void dw_pcie_iatu_detect(struct dw_pcie *pci)
 {
-	struct device *dev = pci->dev;
-	struct platform_device *pdev = to_platform_device(dev);
+	struct platform_device *pdev = to_platform_device(pci->dev);
 
 	pci->iatu_unroll_enabled = dw_pcie_iatu_unroll_enabled(pci);
 	if (pci->iatu_unroll_enabled) {
@@ -687,7 +686,7 @@ void dw_pcie_iatu_detect(struct dw_pcie *pci)
 				platform_get_resource_byname(pdev, IORESOURCE_MEM, "atu");
 			if (res) {
 				pci->atu_size = resource_size(res);
-				pci->atu_base = devm_ioremap_resource(dev, res);
+				pci->atu_base = devm_ioremap_resource(pci->dev, res);
 			}
 			if (!pci->atu_base || IS_ERR(pci->atu_base))
 				pci->atu_base = pci->dbi_base + DEFAULT_DBI_ATU_OFFSET;
@@ -711,9 +710,8 @@ void dw_pcie_iatu_detect(struct dw_pcie *pci)
 
 void dw_pcie_setup(struct dw_pcie *pci)
 {
+	struct device_node *np = pci->dev->of_node;
 	u32 val;
-	struct device *dev = pci->dev;
-	struct device_node *np = dev->of_node;
 
 	if (pci->link_gen > 0)
 		dw_pcie_link_set_max_speed(pci, pci->link_gen);
-- 
2.35.1


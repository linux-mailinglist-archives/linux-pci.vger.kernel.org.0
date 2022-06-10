Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC6C545FA6
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jun 2022 10:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348090AbiFJIpK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jun 2022 04:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347963AbiFJIpC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2022 04:45:02 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F3FBC3B02E;
        Fri, 10 Jun 2022 01:45:00 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 1F06716A8;
        Fri, 10 Jun 2022 11:45:42 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 1F06716A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1654850742;
        bh=HNzyGB75vOKBf/KQS7MyNy2Qi9SJ0rp02cRFk+21zK8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=ozvoGfVjaOekUGl00m4rpwvT2hn9NHNH3ntxWlePdMJWR4HA8/AKBEqL5Ot3b2xLU
         pVrWeJNqEHEqzIEG2li6zLf9DJwJIW7FBeIJiIEKo4lyAxpohxITfeaK+UT5EmdYkD
         +2Jwht48ncoX2MZpnN+wGi2fiS5K9LukqXvwEt/g=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 10 Jun 2022 11:44:49 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rahul Tanwar <rtanwar@maxlinear.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 06/15] PCI: intel-gw: Drop manual DW PCIe controller version setup
Date:   Fri, 10 Jun 2022 11:44:34 +0300
Message-ID: <20220610084444.14549-7-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220610084444.14549-1-Sergey.Semin@baikalelectronics.ru>
References: <20220610084444.14549-1-Sergey.Semin@baikalelectronics.ru>
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

Since the DW PCIe common code now supports the IP-core version
auto-detection there is no point manually setting the version up for the
controllers newer than v4.70a. In particular Intel GW PCIe platform code
can be set free from the manual version setup, which as a positive side
effect causes the private device data removal too.

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Folks, I don't have Intel GW PCIe hw instance to test it out. Could you
please make sure this patch doesn't brake anything?

Changelog v3:
- This is a new patch create as a result of the discussion:
  https://lore.kernel.org/linux-pci/20220503214638.1895-6-Sergey.Semin@baikalelectronics.ru/
---
 drivers/pci/controller/dwc/pcie-intel-gw.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
index 371b5aa189d1..a44f685ec94d 100644
--- a/drivers/pci/controller/dwc/pcie-intel-gw.c
+++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
@@ -58,10 +58,6 @@
 #define BUS_IATU_OFFSET			SZ_256M
 #define RESET_INTERVAL_MS		100
 
-struct intel_pcie_soc {
-	u32	pcie_ver;
-};
-
 struct intel_pcie {
 	struct dw_pcie		pci;
 	void __iomem		*app_base;
@@ -394,13 +390,8 @@ static const struct dw_pcie_host_ops intel_pcie_dw_ops = {
 	.host_init =		intel_pcie_rc_init,
 };
 
-static const struct intel_pcie_soc pcie_data = {
-	.pcie_ver =		DW_PCIE_VER_520A,
-};
-
 static int intel_pcie_probe(struct platform_device *pdev)
 {
-	const struct intel_pcie_soc *data;
 	struct device *dev = &pdev->dev;
 	struct intel_pcie *pcie;
 	struct dw_pcie_rp *pp;
@@ -424,12 +415,7 @@ static int intel_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	data = device_get_match_data(dev);
-	if (!data)
-		return -ENODEV;
-
 	pci->ops = &intel_pcie_ops;
-	pci->version = data->pcie_ver;
 	pp->ops = &intel_pcie_dw_ops;
 
 	ret = dw_pcie_host_init(pp);
@@ -447,7 +433,7 @@ static const struct dev_pm_ops intel_pcie_pm_ops = {
 };
 
 static const struct of_device_id of_intel_pcie_match[] = {
-	{ .compatible = "intel,lgm-pcie", .data = &pcie_data },
+	{ .compatible = "intel,lgm-pcie" },
 	{}
 };
 
-- 
2.35.1


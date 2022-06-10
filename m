Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1C1545F03
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jun 2022 10:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347445AbiFJI3h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jun 2022 04:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347738AbiFJI1r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2022 04:27:47 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 783DA659E;
        Fri, 10 Jun 2022 01:25:59 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 68BBED5D;
        Fri, 10 Jun 2022 11:26:37 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 68BBED5D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1654849597;
        bh=wWJFJIoXIY9cJZYXUnF0posJc3lGCD8JeUSP5WNNlrw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=h9JYzX73XVSlESpq9hwVMobTgpG+aMSMxnhp3hvamE1nz3eTDUPrgl5Tru7OV7qIf
         nm0Z2zcSJZ1DVsLYqk4a5nQx1zuM0e3BsLS2EpSwbUxuxIwbCR21qe/zJv0QRbHBlT
         8x1/nDixWML6Tecn7gymAXb7/Vd3i2Ua8IeNyhd4=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 10 Jun 2022 11:25:45 +0300
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
Subject: [PATCH v4 12/18] PCI: dwc: Re-use local pointer to the resource data
Date:   Fri, 10 Jun 2022 11:25:28 +0300
Message-ID: <20220610082535.12802-13-Sergey.Semin@baikalelectronics.ru>
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

The dw_pcie_host_init() method has two instances of the resource structure
pointers used in non-related places of the method. It's pointless to have
two different local storages for them since the corresponding code is
small and having resource specific names doesn't make it more readable.
Let's convert these parts of the function to using just a common pointer
to the resource structure instance. That shall make the code a bit nicer
looking.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Changelog v4:
- This is a new patch created on the v4 lap of the series.
---
 .../pci/controller/dwc/pcie-designware-host.c    | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 24123f647fa9..fa107e8dd2ab 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -293,17 +293,17 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct resource_entry *win;
 	struct pci_host_bridge *bridge;
-	struct resource *cfg_res;
+	struct resource *res;
 	int ret;
 
 	raw_spin_lock_init(&pp->lock);
 
-	cfg_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
-	if (cfg_res) {
-		pp->cfg0_size = resource_size(cfg_res);
-		pp->cfg0_base = cfg_res->start;
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
+	if (res) {
+		pp->cfg0_size = resource_size(res);
+		pp->cfg0_base = res->start;
 
-		pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, cfg_res);
+		pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
 		if (IS_ERR(pp->va_cfg0_base))
 			return PTR_ERR(pp->va_cfg0_base);
 	} else {
@@ -312,8 +312,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	}
 
 	if (!pci->dbi_base) {
-		struct resource *dbi_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
-		pci->dbi_base = devm_pci_remap_cfg_resource(dev, dbi_res);
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
+		pci->dbi_base = devm_pci_remap_cfg_resource(dev, res);
 		if (IS_ERR(pci->dbi_base))
 			return PTR_ERR(pci->dbi_base);
 	}
-- 
2.35.1


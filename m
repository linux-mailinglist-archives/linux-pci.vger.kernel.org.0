Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F225B545FD1
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jun 2022 10:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348100AbiFJIpK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jun 2022 04:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348083AbiFJIpA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2022 04:45:00 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5680E3980D;
        Fri, 10 Jun 2022 01:44:59 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 78C8E16A7;
        Fri, 10 Jun 2022 11:45:41 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 78C8E16A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1654850741;
        bh=9U2WClu82BJWbbQgRZJ1z49ymt89672SnfrQ5iGsWQ8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=BI0eGAacRV66WdSQ8YWSZHUosIGIFg3NYmzXyS3z05JTkyLaT2QExx4Fx6S7oIOpC
         vh9BLC7FzgEmHInUtsuqna2uf+Ar8+5VG4ygof3Dfyw6Bsl+01GJEzXFlUgTU6txKG
         4D46mbyEvFlM6Pbt1q3/ni8gLK/jg8f3o06hwprM=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 10 Jun 2022 11:44:49 +0300
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
        Rob Herring <robh+dt@kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 05/15] PCI: dwc: Introduce Synopsys IP-core versions/types interface
Date:   Fri, 10 Jun 2022 11:44:33 +0300
Message-ID: <20220610084444.14549-6-Sergey.Semin@baikalelectronics.ru>
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

Instead of manual DW PCIe data version field comparison let's use a handy
macro-based interface in order to shorten out the statements, simplify the
corresponding parts, improve the code readability and maintainability in
perspective when more complex version-based dependencies need to
implemented. Similar approaches have already been implemented in the DWC
USB3 and DW SPI drivers (though with some IP-core evolution specifics).

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pci-keystone.c    |  2 +-
 drivers/pci/controller/dwc/pcie-designware.c |  8 ++++----
 drivers/pci/controller/dwc/pcie-designware.h | 15 +++++++++++++++
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index c4ab3d775a18..2a9bbde224af 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -1233,7 +1233,7 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 		goto err_get_sync;
 	}
 
-	if (pci->version >= DW_PCIE_VER_480A)
+	if (dw_pcie_ver_is_ge(pci, 480A))
 		ret = ks_pcie_am654_set_mode(dev, mode);
 	else
 		ret = ks_pcie_set_mode(dev);
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index cbb36ccaa48b..bd575ad32bc4 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -313,7 +313,7 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
 	val = type | PCIE_ATU_FUNC_NUM(func_no);
 	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr))
 		val |= PCIE_ATU_INCREASE_REGION_SIZE;
-	if (pci->version == DW_PCIE_VER_490A)
+	if (dw_pcie_ver_is(pci, 490A))
 		val = dw_pcie_enable_ecrc(val);
 	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1, val);
 	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL2,
@@ -360,7 +360,7 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
 			   upper_32_bits(cpu_addr));
 	dw_pcie_writel_dbi(pci, PCIE_ATU_LIMIT,
 			   lower_32_bits(limit_addr));
-	if (pci->version >= DW_PCIE_VER_460A)
+	if (dw_pcie_ver_is_ge(pci, 460A))
 		dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_LIMIT,
 				   upper_32_bits(limit_addr));
 	dw_pcie_writel_dbi(pci, PCIE_ATU_LOWER_TARGET,
@@ -369,9 +369,9 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
 			   upper_32_bits(pci_addr));
 	val = type | PCIE_ATU_FUNC_NUM(func_no);
 	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr) &&
-	    pci->version >= DW_PCIE_VER_460A)
+	    dw_pcie_ver_is_ge(pci, 460A))
 		val |= PCIE_ATU_INCREASE_REGION_SIZE;
-	if (pci->version == DW_PCIE_VER_490A)
+	if (dw_pcie_ver_is(pci, 490A))
 		val = dw_pcie_enable_ecrc(val);
 	dw_pcie_writel_dbi(pci, PCIE_ATU_CR1, val);
 	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, PCIE_ATU_ENABLE);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 7899808bdbc6..d247f227464c 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -28,6 +28,21 @@
 #define DW_PCIE_VER_490A		0x3439302a
 #define DW_PCIE_VER_520A		0x3532302a
 
+#define __dw_pcie_ver_cmp(_pci, _ver, _op) \
+	((_pci)->version _op DW_PCIE_VER_ ## _ver)
+
+#define dw_pcie_ver_is(_pci, _ver) __dw_pcie_ver_cmp(_pci, _ver, ==)
+
+#define dw_pcie_ver_is_ge(_pci, _ver) __dw_pcie_ver_cmp(_pci, _ver, >=)
+
+#define dw_pcie_ver_type_is(_pci, _ver, _type) \
+	(__dw_pcie_ver_cmp(_pci, _ver, ==) && \
+	 __dw_pcie_ver_cmp(_pci, TYPE_ ## _type, ==))
+
+#define dw_pcie_ver_type_is_ge(_pci, _ver, _type) \
+	(__dw_pcie_ver_cmp(_pci, _ver, ==) && \
+	 __dw_pcie_ver_cmp(_pci, TYPE_ ## _type, >=))
+
 /* Parameters for the waiting for link up routine */
 #define LINK_WAIT_MAX_RETRIES		10
 #define LINK_WAIT_USLEEP_MIN		90000
-- 
2.35.1


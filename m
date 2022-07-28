Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B55B5841AC
	for <lists+linux-pci@lfdr.de>; Thu, 28 Jul 2022 16:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbiG1OgQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Jul 2022 10:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbiG1Ofm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jul 2022 10:35:42 -0400
Received: from mail.baikalelectronics.com (unknown [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F66C2DFB;
        Thu, 28 Jul 2022 07:35:09 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 6670016D8;
        Thu, 28 Jul 2022 17:37:26 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 6670016D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1659019046;
        bh=ZnrlpdE2ZIaJgTACaplYrUmpkR9zwKpxB1fWOXXAwFM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=eaQJLYFra1kZWnXOY7grAA3O5iyr6okB3tJNQnql+llfBA43qNlOwzLwKGQaJm//U
         4tnvc920Do0UBeDVUt5bnIgwlhgKFnvuCbcudZ9H2RNESXYIcq1kFBGMKT+M5MzFLK
         zLSCCZ7OAcDzVvMihmU55DvMvfY+aJTmlt7tydTg=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 28 Jul 2022 17:35:01 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
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
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 13/17] PCI: dwc: Introduce generic controller capabilities interface
Date:   Thu, 28 Jul 2022 17:34:23 +0300
Message-ID: <20220728143427.13617-14-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220728143427.13617-1-Sergey.Semin@baikalelectronics.ru>
References: <20220728143427.13617-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,T_SPF_PERMERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since in addition to the already available iATU unrolled mapping we are
about to add a few more DW PCIe platform-specific capabilities (CDM-check
and generic clocks/resets resources) let's add a generic interface to set
and get the flags indicating their availability. The new interface shall
improve maintainability of the platform-specific code.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Note the DW_PCIE_CAP_IATU_UNROLL macro is intentionally set to 1 since
being added afterwards capability will be more suitable to be identified
with position 0.

Changelog v3:
- This is a new patch created on v3 lap of the series.
---
 drivers/pci/controller/dwc/pcie-designware.c | 11 ++++++-----
 drivers/pci/controller/dwc/pcie-designware.h | 12 +++++++++++-
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 7a5be3c4f8e0..479eafcdbcb7 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -213,7 +213,7 @@ static inline void __iomem *dw_pcie_select_atu(struct dw_pcie *pci, u32 dir,
 {
 	void __iomem *base = pci->atu_base;
 
-	if (pci->iatu_unroll_enabled)
+	if (dw_pcie_cap_is(pci, IATU_UNROLL))
 		base += PCIE_ATU_UNROLL_BASE(dir, index);
 	else
 		dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, dir | index);
@@ -594,7 +594,7 @@ static void dw_pcie_iatu_detect_regions(struct dw_pcie *pci)
 	u32 val, min, dir;
 	u64 max;
 
-	if (pci->iatu_unroll_enabled) {
+	if (dw_pcie_cap_is(pci, IATU_UNROLL)) {
 		max_region = min((int)pci->atu_size / 512, 256);
 	} else {
 		dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, 0xFF);
@@ -644,8 +644,9 @@ void dw_pcie_iatu_detect(struct dw_pcie *pci)
 {
 	struct platform_device *pdev = to_platform_device(pci->dev);
 
-	pci->iatu_unroll_enabled = dw_pcie_iatu_unroll_enabled(pci);
-	if (pci->iatu_unroll_enabled) {
+	if (dw_pcie_iatu_unroll_enabled(pci)) {
+		dw_pcie_cap_set(pci, IATU_UNROLL);
+
 		if (!pci->atu_base) {
 			struct resource *res =
 				platform_get_resource_byname(pdev, IORESOURCE_MEM, "atu");
@@ -667,7 +668,7 @@ void dw_pcie_iatu_detect(struct dw_pcie *pci)
 
 	dw_pcie_iatu_detect_regions(pci);
 
-	dev_info(pci->dev, "iATU unroll: %s\n", pci->iatu_unroll_enabled ?
+	dev_info(pci->dev, "iATU unroll: %s\n", dw_pcie_cap_is(pci, IATU_UNROLL) ?
 		"enabled" : "disabled");
 
 	dev_info(pci->dev, "iATU regions: %u ob, %u ib, align %uK, limit %lluG\n",
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 5954e8cf9eec..e3b839ec0ccf 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -12,6 +12,7 @@
 #define _PCIE_DESIGNWARE_H
 
 #include <linux/bitfield.h>
+#include <linux/bitops.h>
 #include <linux/dma-mapping.h>
 #include <linux/irq.h>
 #include <linux/msi.h>
@@ -43,6 +44,15 @@
 	(__dw_pcie_ver_cmp(_pci, _ver, ==) && \
 	 __dw_pcie_ver_cmp(_pci, TYPE_ ## _type, >=))
 
+/* DWC PCIe controller capabilities */
+#define DW_PCIE_CAP_IATU_UNROLL		1
+
+#define dw_pcie_cap_is(_pci, _cap) \
+	test_bit(DW_PCIE_CAP_ ## _cap, &(_pci)->caps)
+
+#define dw_pcie_cap_set(_pci, _cap) \
+	set_bit(DW_PCIE_CAP_ ## _cap, &(_pci)->caps)
+
 /* Parameters for the waiting for link up routine */
 #define LINK_WAIT_MAX_RETRIES		10
 #define LINK_WAIT_USLEEP_MIN		90000
@@ -279,10 +289,10 @@ struct dw_pcie {
 	const struct dw_pcie_ops *ops;
 	u32			version;
 	u32			type;
+	unsigned long		caps;
 	int			num_lanes;
 	int			link_gen;
 	u8			n_fts[2];
-	bool			iatu_unroll_enabled: 1;
 };
 
 #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
-- 
2.35.1


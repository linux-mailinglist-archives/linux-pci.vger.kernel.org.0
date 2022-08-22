Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8332859C714
	for <lists+linux-pci@lfdr.de>; Mon, 22 Aug 2022 20:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237790AbiHVSsz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Aug 2022 14:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236522AbiHVSsL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Aug 2022 14:48:11 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D1D63B949;
        Mon, 22 Aug 2022 11:47:50 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 8D16EDA2;
        Mon, 22 Aug 2022 21:50:52 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 8D16EDA2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1661194252;
        bh=v4UefZd8PovFu/gZ7MMCsyHA2wWU19+KOtA55/LEBuQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=GhU3wfIqy1oluum/QheZUvDObXN6ngJPD4X8BWQOA3ZH+Xiy120hMuE+QbJ9ROyeI
         Zh6ky4YhxZxLFEuiAkU1u88OOKcWtnMI+YVwtL847Ph160Vcp/0W00YAuht7B3N5+8
         pdMdlXBMUnYfNDMR1L/NTT52rUqnMFzdpLFEDr7U=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 22 Aug 2022 21:47:38 +0300
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
Subject: [PATCH v5 16/20] PCI: dwc: Introduce generic controller capabilities interface
Date:   Mon, 22 Aug 2022 21:46:57 +0300
Message-ID: <20220822184701.25246-17-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220822184701.25246-1-Sergey.Semin@baikalelectronics.ru>
References: <20220822184701.25246-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
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
index ca830ee794a7..9d78e7ca61e1 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -211,7 +211,7 @@ void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 val)
 static inline void __iomem *dw_pcie_select_atu(struct dw_pcie *pci, u32 dir,
 					       u32 index)
 {
-	if (pci->iatu_unroll_enabled)
+	if (dw_pcie_cap_is(pci, IATU_UNROLL))
 		return pci->atu_base + PCIE_ATU_UNROLL_BASE(dir, index);
 
 	dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, dir | index);
@@ -591,7 +591,7 @@ static void dw_pcie_iatu_detect_regions(struct dw_pcie *pci)
 	u32 val, min, dir;
 	u64 max;
 
-	if (pci->iatu_unroll_enabled) {
+	if (dw_pcie_cap_is(pci, IATU_UNROLL)) {
 		max_region = min((int)pci->atu_size / 512, 256);
 	} else {
 		dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, 0xFF);
@@ -641,8 +641,9 @@ void dw_pcie_iatu_detect(struct dw_pcie *pci)
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
@@ -664,7 +665,7 @@ void dw_pcie_iatu_detect(struct dw_pcie *pci)
 
 	dw_pcie_iatu_detect_regions(pci);
 
-	dev_info(pci->dev, "iATU unroll: %s\n", pci->iatu_unroll_enabled ?
+	dev_info(pci->dev, "iATU unroll: %s\n", dw_pcie_cap_is(pci, IATU_UNROLL) ?
 		"enabled" : "disabled");
 
 	dev_info(pci->dev, "iATU regions: %u ob, %u ib, align %uK, limit %lluG\n",
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index f1a7f7ef4126..33250d5788e8 100644
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
@@ -318,10 +328,10 @@ struct dw_pcie {
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


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4DE54610A
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jun 2022 11:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348589AbiFJJG1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jun 2022 05:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348418AbiFJJGK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2022 05:06:10 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1EEF027A917;
        Fri, 10 Jun 2022 02:05:13 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 664D416D2;
        Fri, 10 Jun 2022 11:58:13 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 664D416D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1654851493;
        bh=pqoqXzMavBCYAPLJkl+pFIXq0zfuKYvEM8NPGIeiPwc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=dS03H/K7f3CMtZKXdhZ/zUphtYi7ZP/pqmq5GMV3miuws4O2yFIs3iaOrsOzfvmHg
         TvrB4UuWNSpL5vKaDaINKsQa7A179VtOKj++StZ4eONQIB+HN/DvF7mHMZj/jUtbEu
         sXK71lxGKjGkaq0JN6DPhS55Us3BCyYVNw9QX/sE=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 10 Jun 2022 11:57:21 +0300
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
Subject: [PATCH v3 15/17] PCI: dwc: Combine iATU detection procedures
Date:   Fri, 10 Jun 2022 11:57:03 +0300
Message-ID: <20220610085706.15741-16-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220610085706.15741-1-Sergey.Semin@baikalelectronics.ru>
References: <20220610085706.15741-1-Sergey.Semin@baikalelectronics.ru>
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

Since the iATU CSR region is now retrieved in the DW PCIe resources getter
there is no much benefits in the iATU detection procedures splitting up.
Therefore let's join the iATU unroll/viewport detection procedure with the
rest of the iATU parameters detection code. The resultant method will be
as coherent as before, while the redundant functions will be eliminated
thus producing more readable code.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Changelog v3:
- This is a new patch created on v3 lap of the series.
---
 drivers/pci/controller/dwc/pcie-designware.c | 39 +++++---------------
 1 file changed, 10 insertions(+), 29 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 747eb1ac5f3c..3d3129e1fb88 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -631,26 +631,21 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 link_gen)
 
 }
 
-static bool dw_pcie_iatu_unroll_enabled(struct dw_pcie *pci)
-{
-	u32 val;
-
-	val = dw_pcie_readl_dbi(pci, PCIE_ATU_VIEWPORT);
-	if (val == 0xffffffff)
-		return true;
-
-	return false;
-}
-
-static void dw_pcie_iatu_detect_regions(struct dw_pcie *pci)
+void dw_pcie_iatu_detect(struct dw_pcie *pci)
 {
 	int max_region, ob, ib;
 	u32 val, min, dir;
 	u64 max;
 
-	if (dw_pcie_cap_is(pci, IATU_UNROLL)) {
+	val = dw_pcie_readl_dbi(pci, PCIE_ATU_VIEWPORT);
+	if (val == 0xFFFFFFFF) {
+		dw_pcie_cap_set(pci, IATU_UNROLL);
+
 		max_region = min((int)pci->atu_size / 512, 256);
 	} else {
+		pci->atu_base = pci->dbi_base + PCIE_ATU_VIEWPORT_BASE;
+		pci->atu_size = PCIE_ATU_VIEWPORT_SIZE;
+
 		dw_pcie_writel_dbi(pci, PCIE_ATU_VIEWPORT, 0xFF);
 		max_region = dw_pcie_readl_dbi(pci, PCIE_ATU_VIEWPORT) + 1;
 	}
@@ -692,23 +687,9 @@ static void dw_pcie_iatu_detect_regions(struct dw_pcie *pci)
 	pci->num_ib_windows = ib;
 	pci->region_align = 1 << fls(min);
 	pci->region_limit = (max << 32) | (SZ_4G - 1);
-}
-
-void dw_pcie_iatu_detect(struct dw_pcie *pci)
-{
-	if (dw_pcie_iatu_unroll_enabled(pci)) {
-		dw_pcie_cap_set(pci, IATU_UNROLL);
-	} else {
-		pci->atu_base = pci->dbi_base + PCIE_ATU_VIEWPORT_BASE;
-		pci->atu_size = PCIE_ATU_VIEWPORT_SIZE;
-	}
-
-	dw_pcie_iatu_detect_regions(pci);
-
-	dev_info(pci->dev, "iATU unroll: %s\n", dw_pcie_cap_is(pci, IATU_UNROLL) ?
-		"enabled" : "disabled");
 
-	dev_info(pci->dev, "iATU regions: %u ob, %u ib, align %uK, limit %lluG\n",
+	dev_info(pci->dev, "iATU: unroll %s, %u ob, %u ib, align %uK, limit %lluG\n",
+		 dw_pcie_cap_is(pci, IATU_UNROLL) ? "T" : "F",
 		 pci->num_ob_windows, pci->num_ib_windows,
 		 pci->region_align / SZ_1K, (pci->region_limit + 1) / SZ_1G);
 }
-- 
2.35.1


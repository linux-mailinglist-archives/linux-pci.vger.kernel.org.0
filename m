Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9535762008C
	for <lists+linux-pci@lfdr.de>; Mon,  7 Nov 2022 22:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbiKGVLd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Nov 2022 16:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbiKGVKk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Nov 2022 16:10:40 -0500
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F15F2EF1D;
        Mon,  7 Nov 2022 13:07:32 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 84692E0EC6;
        Mon,  7 Nov 2022 23:50:33 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=uTaJVnBQCVho34bEIQW4LI3oXUiWeZL1YbD9SQeQ2ao=; b=mpPBgDeyv/uN
        v91RjmT7+cH1y6czQmGqjos8hLrLJWZd8gSqbsZveC1ncDoj569nE7ROl4u0/pg8
        IO0UsN1w4mRHbkNwFVxewvlRdhwKeWzNg6vWncWMV5dNke1jLj6FiSmJNwfsEB9l
        zSY0VTl7A5TB2nXkKc4EAqeNkHsN+ds=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 714EFE0E1D;
        Mon,  7 Nov 2022 23:50:33 +0300 (MSK)
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 7 Nov 2022 23:50:32 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
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
        caihuoqing <caihuoqing@baidu.com>, Vinod Koul <vkoul@kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 18/20] PCI: dwc: Combine iATU detection procedures
Date:   Mon, 7 Nov 2022 23:49:32 +0300
Message-ID: <20221107204934.32655-19-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221107204934.32655-1-Sergey.Semin@baikalelectronics.ru>
References: <20221107204934.32655-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.168.10]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changelog v3:
- This is a new patch created on v3 lap of the series.
---
 drivers/pci/controller/dwc/pcie-designware.c | 39 +++++---------------
 1 file changed, 10 insertions(+), 29 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index a8436027434d..d31f9d41d5cb 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -628,26 +628,21 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 link_gen)
 
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
@@ -689,23 +684,9 @@ static void dw_pcie_iatu_detect_regions(struct dw_pcie *pci)
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
2.38.0



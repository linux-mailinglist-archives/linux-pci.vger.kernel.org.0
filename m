Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F76B7AA967
	for <lists+linux-pci@lfdr.de>; Fri, 22 Sep 2023 08:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjIVGxu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Sep 2023 02:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjIVGxr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Sep 2023 02:53:47 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 50461195;
        Thu, 21 Sep 2023 23:53:41 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.03,167,1694703600"; 
   d="scan'208";a="180618015"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 22 Sep 2023 15:53:39 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id D5F77400F799;
        Fri, 22 Sep 2023 15:53:38 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mani@kernel.org
Cc:     marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v21 05/16] PCI: dwc: Add EDMA_UNROLL capability flag
Date:   Fri, 22 Sep 2023 15:53:20 +0900
Message-Id: <20230922065331.3806925-6-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230922065331.3806925-1-yoshihiro.shimoda.uh@renesas.com>
References: <20230922065331.3806925-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Renesas R-Car Gen4 PCIe controllers have an unexpected register value in
the eDMA CTRL register.

So, add a new capability flag "EDMA_UNROLL" which would force the unrolled
eDMA mapping for the problematic device.

[kwilczynski: commit log]
Link: https://lore.kernel.org/linux-pci/20230825093219.2685912-10-yoshihiro.shimoda.uh@renesas.com
Suggested-by: Serge Semin <fancer.lancer@gmail.com>
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware.c | 8 +++++++-
 drivers/pci/controller/dwc/pcie-designware.h | 5 +++--
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 2b60d20dfdf5..1f900be94556 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -887,8 +887,14 @@ static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
 	 * Indirect eDMA CSRs access has been completely removed since v5.40a
 	 * thus no space is now reserved for the eDMA channels viewport and
 	 * former DMA CTRL register is no longer fixed to FFs.
+	 *
+	 * Note that Renesas R-Car S4-8's PCIe controllers for unknown reason
+	 * have zeros in the eDMA CTRL register even though the HW-manual
+	 * explicitly states there must FFs if the unrolled mapping is enabled.
+	 * For such cases the low-level drivers are supposed to manually
+	 * activate the unrolled mapping to bypass the auto-detection procedure.
 	 */
-	if (dw_pcie_ver_is_ge(pci, 540A))
+	if (dw_pcie_ver_is_ge(pci, 540A) || dw_pcie_cap_is(pci, EDMA_UNROLL))
 		val = 0xFFFFFFFF;
 	else
 		val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 6189884b4efa..e10f7e18b13a 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -51,8 +51,9 @@
 
 /* DWC PCIe controller capabilities */
 #define DW_PCIE_CAP_REQ_RES		0
-#define DW_PCIE_CAP_IATU_UNROLL		1
-#define DW_PCIE_CAP_CDM_CHECK		2
+#define DW_PCIE_CAP_EDMA_UNROLL		1
+#define DW_PCIE_CAP_IATU_UNROLL		2
+#define DW_PCIE_CAP_CDM_CHECK		3
 
 #define dw_pcie_cap_is(_pci, _cap) \
 	test_bit(DW_PCIE_CAP_ ## _cap, &(_pci)->caps)
-- 
2.25.1


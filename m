Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65136788395
	for <lists+linux-pci@lfdr.de>; Fri, 25 Aug 2023 11:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244282AbjHYJcn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Aug 2023 05:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240282AbjHYJc1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Aug 2023 05:32:27 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD7041FD7;
        Fri, 25 Aug 2023 02:32:24 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,195,1688396400"; 
   d="scan'208";a="173961353"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 25 Aug 2023 18:32:23 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4ADAB40071FF;
        Fri, 25 Aug 2023 18:32:23 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
        kishon@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     marek.vasut+renesas@gmail.com, fancer.lancer@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v20 03/19] PCI: dwc: Add outbound MSG TLPs support
Date:   Fri, 25 Aug 2023 18:32:03 +0900
Message-Id: <20230825093219.2685912-4-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230825093219.2685912-1-yoshihiro.shimoda.uh@renesas.com>
References: <20230825093219.2685912-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add "code" and "routing" into struct dw_pcie_ob_atu_cfg for triggering
INTx IRQs by iATU in the PCIe endpoint mode in near the future.
PCIE_ATU_INHIBIT_PAYLOAD is set to issue TLP type of Msg instead of
MsgD. So, this implementation supports the data-less messages only
for now.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware.c | 9 +++++++--
 drivers/pci/controller/dwc/pcie-designware.h | 4 ++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 49b785509576..2d0f816fa0ab 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -498,7 +498,7 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_TARGET,
 			      upper_32_bits(atu->pci_addr));
 
-	val = atu->type | PCIE_ATU_FUNC_NUM(atu->func_no);
+	val = atu->type | atu->routing | PCIE_ATU_FUNC_NUM(atu->func_no);
 	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr) &&
 	    dw_pcie_ver_is_ge(pci, 460A))
 		val |= PCIE_ATU_INCREASE_REGION_SIZE;
@@ -506,7 +506,12 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 		val = dw_pcie_enable_ecrc(val);
 	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val);
 
-	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2, PCIE_ATU_ENABLE);
+	val = PCIE_ATU_ENABLE;
+	if (atu->type == PCIE_ATU_TYPE_MSG) {
+		/* The data-less messages only for now */
+		val |= PCIE_ATU_INHIBIT_PAYLOAD | atu->code;
+	}
+	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2, val);
 
 	/*
 	 * Make sure ATU enable takes effect before any subsequent config
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 296c5b1ddc91..8f22a7bc0523 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -147,11 +147,13 @@
 #define PCIE_ATU_TYPE_IO		0x2
 #define PCIE_ATU_TYPE_CFG0		0x4
 #define PCIE_ATU_TYPE_CFG1		0x5
+#define PCIE_ATU_TYPE_MSG		0x10
 #define PCIE_ATU_TD			BIT(8)
 #define PCIE_ATU_FUNC_NUM(pf)           ((pf) << 20)
 #define PCIE_ATU_REGION_CTRL2		0x004
 #define PCIE_ATU_ENABLE			BIT(31)
 #define PCIE_ATU_BAR_MODE_ENABLE	BIT(30)
+#define PCIE_ATU_INHIBIT_PAYLOAD	BIT(22)
 #define PCIE_ATU_FUNC_NUM_MATCH_EN      BIT(19)
 #define PCIE_ATU_LOWER_BASE		0x008
 #define PCIE_ATU_UPPER_BASE		0x00C
@@ -302,6 +304,8 @@ struct dw_pcie_ob_atu_cfg {
 	int index;
 	int type;
 	u8 func_no;
+	u8 code;
+	u8 routing;
 	u64 cpu_addr;
 	u64 pci_addr;
 	u64 size;
-- 
2.25.1


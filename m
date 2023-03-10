Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816CA6B3F43
	for <lists+linux-pci@lfdr.de>; Fri, 10 Mar 2023 13:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjCJMfQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Mar 2023 07:35:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjCJMfQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Mar 2023 07:35:16 -0500
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1332310C100;
        Fri, 10 Mar 2023 04:35:13 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.98,249,1673881200"; 
   d="scan'208";a="152181156"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 10 Mar 2023 21:35:13 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4BD52423B048;
        Fri, 10 Mar 2023 21:35:13 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com
Cc:     Sergey.Semin@baikalelectronics.ru, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v11 01/13] PCI: dwc: Fix writing wrong value if snps,enable-cdm-check
Date:   Fri, 10 Mar 2023 21:34:58 +0900
Message-Id: <20230310123510.675685-2-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230310123510.675685-1-yoshihiro.shimoda.uh@renesas.com>
References: <20230310123510.675685-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The "val" of PCIE_PORT_LINK_CONTROL will be reused on the
"Set the number of lanes". But, if snps,enable-cdm-check" exists,
the "val" will be set to PCIE_PL_CHK_REG_CONTROL_STATUS.
Therefore, unexpected register value is possible to be used
to PCIE_PORT_LINK_CONTROL register if snps,enable-cdm-check" exists.
So, change reading timing of PCIE_PORT_LINK_CONTROL register to fix
the issue.

Fixes: ec7b952f453c ("PCI: dwc: Always enable CDM check if "snps,enable-cdm-check" exists")
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 53a16b8b6ac2..8e33e6e59e68 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -1001,11 +1001,6 @@ void dw_pcie_setup(struct dw_pcie *pci)
 		dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
 	}
 
-	val = dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
-	val &= ~PORT_LINK_FAST_LINK_MODE;
-	val |= PORT_LINK_DLL_LINK_EN;
-	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
-
 	if (dw_pcie_cap_is(pci, CDM_CHECK)) {
 		val = dw_pcie_readl_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS);
 		val |= PCIE_PL_CHK_REG_CHK_REG_CONTINUOUS |
@@ -1013,6 +1008,11 @@ void dw_pcie_setup(struct dw_pcie *pci)
 		dw_pcie_writel_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS, val);
 	}
 
+	val = dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
+	val &= ~PORT_LINK_FAST_LINK_MODE;
+	val |= PORT_LINK_DLL_LINK_EN;
+	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
+
 	if (!pci->num_lanes) {
 		dev_dbg(pci->dev, "Using h/w default number of lanes\n");
 		return;
-- 
2.25.1


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643CC698F9E
	for <lists+linux-pci@lfdr.de>; Thu, 16 Feb 2023 10:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjBPJUd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Feb 2023 04:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjBPJUc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2023 04:20:32 -0500
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D32D1EBD1
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 01:20:31 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.97,302,1669042800"; 
   d="scan'208";a="153084432"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 16 Feb 2023 18:20:30 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 465E441C0FE2;
        Thu, 16 Feb 2023 18:20:30 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        Sergey.Semin@baikalelectronics.ru, lpieralisi@kernel.org,
        kw@linux.com, robh@kernel.org, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH] PCI: dwc: Fix writing wrong value if snps,enable-cdm-check
Date:   Thu, 16 Feb 2023 18:20:12 +0900
Message-Id: <20230216092012.3256440-1-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
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
So, read PCIE_PORT_LINK_CONTROL register again to fix the issue.

Fixes: ec7b952f453c ("PCI: dwc: Always enable CDM check if "snps,enable-cdm-check" exists")
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 6d5d619ab2e9..3bb9ca14fb9c 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -824,6 +824,7 @@ void dw_pcie_setup(struct dw_pcie *pci)
 	}
 
 	/* Set the number of lanes */
+	val = dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
 	val &= ~PORT_LINK_FAST_LINK_MODE;
 	val &= ~PORT_LINK_MODE_MASK;
 	switch (pci->num_lanes) {
-- 
2.25.1


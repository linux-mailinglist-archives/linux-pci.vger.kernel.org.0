Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1377C4B6B
	for <lists+linux-pci@lfdr.de>; Wed, 11 Oct 2023 09:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjJKHOg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Oct 2023 03:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjJKHOd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Oct 2023 03:14:33 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4674FAC;
        Wed, 11 Oct 2023 00:14:32 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.03,214,1694703600"; 
   d="scan'208";a="182667757"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 11 Oct 2023 16:14:29 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id A6FC241B2644;
        Wed, 11 Oct 2023 16:14:29 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mani@kernel.org
Cc:     marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v24 08/16] PCI: dwc: Disable two BARs to avoid unnecessary memory assignment
Date:   Wed, 11 Oct 2023 16:14:15 +0900
Message-Id: <20231011071423.249458-9-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231011071423.249458-1-yoshihiro.shimoda.uh@renesas.com>
References: <20231011071423.249458-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

According to the section 3.5.7.2 "RC Mode" in DWC PCIe Dual Mode
Rev.5.20a, we should disable two BARs to avoid unnecessary memory
assignment during device enumeration. Otherwise, Renesas R-Car Gen4
PCIe controllers cannot work correctly in host mode.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index a7170fd0e847..56cc7ff6d508 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -737,6 +737,14 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
 	u32 val, ctrl, num_ctrls;
 	int ret;
 
+	/*
+	 * According to the section 3.5.7.2 "RC Mode" in DWC PCIe Dual Mode
+	 * Rev.5.20a, we should disable two BARs to avoid unnecessary memory
+	 * assignment during device enumeration.
+	 */
+	dw_pcie_writel_dbi2(pci, PCI_BASE_ADDRESS_0, 0x0);
+	dw_pcie_writel_dbi2(pci, PCI_BASE_ADDRESS_1, 0x0);
+
 	/*
 	 * Enable DBI read-only registers for writing/updating configuration.
 	 * Write permission gets disabled towards the end of this function.
-- 
2.25.1


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDA05984C8
	for <lists+linux-pci@lfdr.de>; Thu, 18 Aug 2022 15:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245311AbiHRNwF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Aug 2022 09:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245313AbiHRNwC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Aug 2022 09:52:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8916172B
        for <linux-pci@vger.kernel.org>; Thu, 18 Aug 2022 06:52:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47C24616DC
        for <linux-pci@vger.kernel.org>; Thu, 18 Aug 2022 13:52:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475CEC433D7;
        Thu, 18 Aug 2022 13:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660830720;
        bh=ftDwjJuJM+DkNC+0FTyMWCZEExUs1HVzpUV1moRdYIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h5qRu244x3gmBpOTSglilkSDjxheuXCv6Hf2GUBjZWje/wjR5fPZK4u07TR/W9xzi
         sBOcsRuXe9JErxzLW0KTlLrS9AmrxaP4tFKF8MLrLEgwsClDpeZ7CU6flRJ8ZG6kNh
         DQW8Vc08a6/kqM7QjhV1tXdTw5Y7UZwWZGOAAIquFGyClT/vSJyjU2DL6Ue6h7Knuv
         GUrIY+2Q6asuQ37OtLYH1q6dVAvEVOhb++BXRf4LH3QsjBVbx+egUtIT6VWoLdBs/p
         f3VSvkPVHElMYborDtZ7c10pzXEid0yuCFt3ehz4OwdPhcJRPbZuJMt6jBdfheTSYt
         Q3ecT9Ql6ok0g==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        pali@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 08/11] PCI: aardvark: Replace custom PCIE_CORE_ERR_CAPCTL_* macros by linux/pci_regs.h macros
Date:   Thu, 18 Aug 2022 15:51:37 +0200
Message-Id: <20220818135140.5996-9-kabel@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220818135140.5996-1-kabel@kernel.org>
References: <20220818135140.5996-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

Kernel already has these macros defined under different names.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index e30a33a4ecc6..4855ac733484 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -37,11 +37,7 @@
 #define PCIE_CORE_DEV_REV_REG					0x8
 #define PCIE_CORE_PCIEXP_CAP					0xc0
 #define PCIE_CORE_PCIERR_CAP					0x100
-#define PCIE_CORE_ERR_CAPCTL_REG				0x118
-#define     PCIE_CORE_ERR_CAPCTL_ECRC_CHK_TX			BIT(5)
-#define     PCIE_CORE_ERR_CAPCTL_ECRC_CHK_TX_EN			BIT(6)
-#define     PCIE_CORE_ERR_CAPCTL_ECRC_CHCK			BIT(7)
-#define     PCIE_CORE_ERR_CAPCTL_ECRC_CHCK_RCV			BIT(8)
+
 /* PIO registers base address and register offsets */
 #define PIO_BASE_ADDR				0x4000
 #define PIO_CTRL				(PIO_BASE_ADDR + 0x0)
@@ -589,11 +585,9 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 	advk_writel(pcie, reg, PCIE_CORE_CMD_STATUS_REG);
 
 	/* Set Advanced Error Capabilities and Control PF0 register */
-	reg = PCIE_CORE_ERR_CAPCTL_ECRC_CHK_TX |
-		PCIE_CORE_ERR_CAPCTL_ECRC_CHK_TX_EN |
-		PCIE_CORE_ERR_CAPCTL_ECRC_CHCK |
-		PCIE_CORE_ERR_CAPCTL_ECRC_CHCK_RCV;
-	advk_writel(pcie, reg, PCIE_CORE_ERR_CAPCTL_REG);
+	reg = PCI_ERR_CAP_ECRC_GENC | PCI_ERR_CAP_ECRC_GENE |
+	      PCI_ERR_CAP_ECRC_CHKC | PCI_ERR_CAP_ECRC_CHKE;
+	advk_writel(pcie, reg, PCIE_CORE_PCIERR_CAP + PCI_ERR_CAP);
 
 	/* Set PCIe Device Control register */
 	reg = advk_readl(pcie, PCIE_CORE_PCIEXP_CAP + PCI_EXP_DEVCTL);
-- 
2.35.1


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7062C5EAF43
	for <lists+linux-pci@lfdr.de>; Mon, 26 Sep 2022 20:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiIZSKM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 14:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiIZSJn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 14:09:43 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E051D31A
        for <linux-pci@vger.kernel.org>; Mon, 26 Sep 2022 10:55:59 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 28QHtpZs084272;
        Mon, 26 Sep 2022 12:55:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1664214951;
        bh=kHWCgMdOKoMsZm8pDsiNpeyhIn2XCulJkNOgm7a/zfc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=NL1Ju6RNMyve1Ag6uCuFAJHacchufPHK02vLX0nGMZ3N1WZw7Q7if7WtS6VsYC/Hv
         zm/M0fP2eZdbe3Xb/eeGW7kSZsyMsY0sVLaq7fbj4cGJo2n2UEz5vNuPkGMO2K3Ct8
         HQi5VG4jMwiny90X3XwObjOSiC3gRTBo/biIkz0s=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 28QHtp32017486
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Sep 2022 12:55:51 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 26
 Sep 2022 12:55:51 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 26 Sep 2022 12:55:51 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 28QHtmnH012623;
        Mon, 26 Sep 2022 12:55:50 -0500
From:   Matt Ranostay <mranostay@ti.com>
To:     <kishon@ti.com>, <vigneshr@ti.com>, <bhelgaas@google.com>,
        <robh@kernel.org>, <lpieralisi@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <nm@ti.com>,
        Matt Ranostay <mranostay@ti.com>
Subject: [PATCH v2 2/3] PCI: j721e: Add per platform maximum lane settings
Date:   Mon, 26 Sep 2022 10:55:37 -0700
Message-ID: <20220926175538.362018-3-mranostay@ti.com>
X-Mailer: git-send-email 2.38.0.rc0.52.gdda7228a83
In-Reply-To: <20220926175538.362018-1-mranostay@ti.com>
References: <20220926175538.362018-1-mranostay@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Various platforms have different maximum amount of lanes that
can be selected. Add max_lanes to struct j721e_pcie to allow
for error checking on num-lanes selection from device tree.

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Matt Ranostay <mranostay@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/pci/controller/cadence/pci-j721e.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index d9b1527421c3..0a537f2d5078 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -47,8 +47,6 @@ enum link_status {
 
 #define GENERATION_SEL_MASK		GENMASK(1, 0)
 
-#define MAX_LANES			2
-
 struct j721e_pcie {
 	struct cdns_pcie	*cdns_pcie;
 	struct clk		*refclk;
@@ -71,6 +69,7 @@ struct j721e_pcie_data {
 	unsigned int		quirk_disable_flr:1;
 	u32			linkdown_irq_regfield;
 	unsigned int		byte_access_allowed:1;
+	unsigned int		max_lanes;
 };
 
 static inline u32 j721e_pcie_user_readl(struct j721e_pcie *pcie, u32 offset)
@@ -294,11 +293,13 @@ static const struct j721e_pcie_data j721e_pcie_rc_data = {
 	.quirk_retrain_flag = true,
 	.byte_access_allowed = false,
 	.linkdown_irq_regfield = LINK_DOWN,
+	.max_lanes = 2,
 };
 
 static const struct j721e_pcie_data j721e_pcie_ep_data = {
 	.mode = PCI_MODE_EP,
 	.linkdown_irq_regfield = LINK_DOWN,
+	.max_lanes = 2,
 };
 
 static const struct j721e_pcie_data j7200_pcie_rc_data = {
@@ -306,23 +307,27 @@ static const struct j721e_pcie_data j7200_pcie_rc_data = {
 	.quirk_detect_quiet_flag = true,
 	.linkdown_irq_regfield = J7200_LINK_DOWN,
 	.byte_access_allowed = true,
+	.max_lanes = 4,
 };
 
 static const struct j721e_pcie_data j7200_pcie_ep_data = {
 	.mode = PCI_MODE_EP,
 	.quirk_detect_quiet_flag = true,
 	.quirk_disable_flr = true,
+	.max_lanes = 4,
 };
 
 static const struct j721e_pcie_data am64_pcie_rc_data = {
 	.mode = PCI_MODE_RC,
 	.linkdown_irq_regfield = J7200_LINK_DOWN,
 	.byte_access_allowed = true,
+	.max_lanes = 1,
 };
 
 static const struct j721e_pcie_data am64_pcie_ep_data = {
 	.mode = PCI_MODE_EP,
 	.linkdown_irq_regfield = J7200_LINK_DOWN,
+	.max_lanes = 1,
 };
 
 static const struct of_device_id of_j721e_pcie_match[] = {
@@ -436,7 +441,7 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 	pcie->user_cfg_base = base;
 
 	ret = of_property_read_u32(node, "num-lanes", &num_lanes);
-	if (ret || num_lanes > MAX_LANES)
+	if (ret || num_lanes > data->max_lanes)
 		num_lanes = 1;
 	pcie->num_lanes = num_lanes;
 
-- 
2.38.0.rc0.52.gdda7228a83


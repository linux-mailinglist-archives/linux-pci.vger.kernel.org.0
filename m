Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31EE6BE234
	for <lists+linux-pci@lfdr.de>; Fri, 17 Mar 2023 08:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjCQHvs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Mar 2023 03:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjCQHvo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Mar 2023 03:51:44 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DC7A0B0C;
        Fri, 17 Mar 2023 00:51:41 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32H7pTnA080563;
        Fri, 17 Mar 2023 02:51:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679039489;
        bh=GGrsVB2NuWgQ/IDsTg782FJLIK98IZjp/7pCe7Mspxs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=FXCck0WNRTOp1AK+AE0LChA4TqpQ4mIUjrsqHRqyVp3zllhqHXDZxxomeFpclpZvG
         XFbx0cixfGdyuQpPlsIBHlGScWDGs46nPAwLnpby8tIteW9rIbKNgAzbSwG2004vTv
         KLGmewHVwhx8bplK2Ar4AXs7eMzAGuKKmwVRkdBM=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32H7pTfV004757
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Mar 2023 02:51:29 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 17
 Mar 2023 02:51:29 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 17 Mar 2023 02:51:29 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32H7pSdZ005839;
        Fri, 17 Mar 2023 02:51:29 -0500
From:   Achal Verma <a-verma1@ti.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Dhananjay Vilasrao Kangude <dkangude@cadence.com>,
        Anindita Das <dasa@cadence.com>,
        Yuan Zhao <yuanzhao@cadence.com>,
        Milind Parab <mparab@cadence.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Achal Verma <a-verma1@ti.com>
Subject: [PATCH v11 5/5] PCI: j721e: add j784s4 PCIe configuration
Date:   Fri, 17 Mar 2023 13:21:20 +0530
Message-ID: <20230317075120.506267-6-a-verma1@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230317075120.506267-1-a-verma1@ti.com>
References: <20230317075120.506267-1-a-verma1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Matt Ranostay <mranostay@ti.com>

Add PCIe configuration for j784s4 platform which has 4x lane support.

Tested-by: Achal Verma <a-verma1@ti.com>
Signed-off-by: Matt Ranostay <mranostay@ti.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
Signed-off-by: Achal Verma <a-verma1@ti.com>
---
 drivers/pci/controller/cadence/pci-j721e.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 58dcac9021e4..cce7b391f931 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -330,6 +330,20 @@ static const struct j721e_pcie_data am64_pcie_ep_data = {
 	.max_lanes = 1,
 };
 
+static const struct j721e_pcie_data j784s4_pcie_rc_data = {
+	.mode = PCI_MODE_RC,
+	.quirk_retrain_flag = true,
+	.byte_access_allowed = false,
+	.linkdown_irq_regfield = LINK_DOWN,
+	.max_lanes = 4,
+};
+
+static const struct j721e_pcie_data j784s4_pcie_ep_data = {
+	.mode = PCI_MODE_EP,
+	.linkdown_irq_regfield = LINK_DOWN,
+	.max_lanes = 4,
+};
+
 static const struct of_device_id of_j721e_pcie_match[] = {
 	{
 		.compatible = "ti,j721e-pcie-host",
@@ -355,6 +369,14 @@ static const struct of_device_id of_j721e_pcie_match[] = {
 		.compatible = "ti,am64-pcie-ep",
 		.data = &am64_pcie_ep_data,
 	},
+	{
+		.compatible = "ti,j784s4-pcie-host",
+		.data = &j784s4_pcie_rc_data,
+	},
+	{
+		.compatible = "ti,j784s4-pcie-ep",
+		.data = &j784s4_pcie_ep_data,
+	},
 	{},
 };
 
-- 
2.25.1


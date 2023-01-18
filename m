Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC720671DEA
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jan 2023 14:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjARNdv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Jan 2023 08:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjARNdB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jan 2023 08:33:01 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8287E58960;
        Wed, 18 Jan 2023 05:00:03 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30ICxjJg079768;
        Wed, 18 Jan 2023 06:59:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1674046785;
        bh=GGrsVB2NuWgQ/IDsTg782FJLIK98IZjp/7pCe7Mspxs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=fyegISrHOR3VLzHGX4VOcPbatNpOqZXzkGjMvx1y9GCuZiLHPClz5NAJyevYEHomy
         QDC5oI9VBCqGbK2t4OHivYP+cEHS1QJkOwlqHxSLMm4pvkr+qzwKqyKO/KE/4GL/fN
         57E0x5O/Q/CK1T/zuoBaU0a0tLU6Mf+ZE5UH+06c=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30ICxjLn010120
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Jan 2023 06:59:45 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 18
 Jan 2023 06:59:45 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 18 Jan 2023 06:59:45 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30ICxi51003334;
        Wed, 18 Jan 2023 06:59:45 -0600
From:   Achal Verma <a-verma1@ti.com>
To:     <mranostay@ti.com>, <rogerq@kernel.org>, <lpieralisi@kernel.org>,
        <robh@kernel.org>, <kw@linux.com>, <bhelgaas@google.com>,
        <krzysztof.kozlowski@linaro.org>, <vigneshr@ti.com>,
        <tjoseph@cadence.com>, <sergio.paracuellos@gmail.com>,
        <pthombar@cadence.com>, <linux-pci@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 5/5] PCI: j721e: add j784s4 PCIe configuration
Date:   Wed, 18 Jan 2023 18:29:36 +0530
Message-ID: <20230118125936.3456716-6-a-verma1@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230118125936.3456716-1-a-verma1@ti.com>
References: <20230118125936.3456716-1-a-verma1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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


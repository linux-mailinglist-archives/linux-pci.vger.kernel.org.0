Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D005B4066
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 22:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbiIIUQg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 16:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiIIUQf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 16:16:35 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945831116D7
        for <linux-pci@vger.kernel.org>; Fri,  9 Sep 2022 13:16:34 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 289KGVCf002111;
        Fri, 9 Sep 2022 15:16:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1662754591;
        bh=Ej1VcoiKdukno5aziwP7ZZIK+k6bFZAG7kuQFhTT7tw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=YXTs9NLnbDNdzPNz+Dbh1ArDmf3puTpBXb/BGF+SFCmWsncBm3/OjjZZ14wB6CP1G
         teIUTEZlac+zNH0BxjZwGZmjhZXgxBzR/GXZ/NpJ4WRL+zoXJFOIFkGiVViNYZJj32
         yx0/J4ZlYvhl6muMWhMas4a3ZhSROLF2Xamfv2gI=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 289KGVwF028350
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 9 Sep 2022 15:16:31 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 9 Sep
 2022 15:16:30 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 9 Sep 2022 15:16:31 -0500
Received: from ubuntu.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 289KGDp3071511;
        Fri, 9 Sep 2022 15:16:26 -0500
From:   Matt Ranostay <mranostay@ti.com>
To:     <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     <tjoseph@cadence.com>, <vigneshr@ti.com>, <kishon@ti.com>,
        Matt Ranostay <mranostay@ti.com>
Subject: [PATCH 2/3] PCI: j721e: Add per platform maximum lane settings
Date:   Fri, 9 Sep 2022 13:16:06 -0700
Message-ID: <20220909201607.3835-3-mranostay@ti.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220909201607.3835-1-mranostay@ti.com>
References: <20220909201607.3835-1-mranostay@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index 62c2c70256b8..4c6c677fab54 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -48,8 +48,6 @@ enum link_status {
 
 #define GENERATION_SEL_MASK		GENMASK(1, 0)
 
-#define MAX_LANES			2
-
 struct j721e_pcie {
 	struct cdns_pcie	*cdns_pcie;
 	struct clk		*refclk;
@@ -72,6 +70,7 @@ struct j721e_pcie_data {
 	unsigned int		quirk_disable_flr:1;
 	u32			linkdown_irq_regfield;
 	unsigned int		byte_access_allowed:1;
+	unsigned int		max_lanes;
 };
 
 static inline u32 j721e_pcie_user_readl(struct j721e_pcie *pcie, u32 offset)
@@ -291,11 +290,13 @@ static const struct j721e_pcie_data j721e_pcie_rc_data = {
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
@@ -303,23 +304,27 @@ static const struct j721e_pcie_data j7200_pcie_rc_data = {
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
@@ -433,7 +438,7 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 	pcie->user_cfg_base = base;
 
 	ret = of_property_read_u32(node, "num-lanes", &num_lanes);
-	if (ret || num_lanes > MAX_LANES)
+	if (ret || num_lanes > data->max_lanes)
 		num_lanes = 1;
 	pcie->num_lanes = num_lanes;
 
-- 
2.37.2


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE2C5B4067
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 22:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbiIIUQr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 16:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiIIUQo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 16:16:44 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4961A12111A
        for <linux-pci@vger.kernel.org>; Fri,  9 Sep 2022 13:16:42 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 289KGawX102987;
        Fri, 9 Sep 2022 15:16:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1662754596;
        bh=d7h1ii8RB7amlGIvD2koUMEVIsu75+Do+WM0ca4Qs/8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=POxCuNqN4UStvVW9UtnmzuI6dpV3BTTDJwtvwrwacDaweCvlhj1HY4vVbRzhXDgsd
         EtbUz0x1tV8Mz1iYZ2/oNDqFg1z9UkTFnYQuJeHkU7MoGg6kXjwjdzG7bUszY1uOh/
         U+5MAFk/zD3eSdsy1hhYLwE6IQwhohBEzO/1A4N0=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 289KGa3n088344
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 9 Sep 2022 15:16:36 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 9 Sep
 2022 15:16:36 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 9 Sep 2022 15:16:36 -0500
Received: from ubuntu.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 289KGDp4071511;
        Fri, 9 Sep 2022 15:16:32 -0500
From:   Matt Ranostay <mranostay@ti.com>
To:     <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     <tjoseph@cadence.com>, <vigneshr@ti.com>, <kishon@ti.com>,
        Matt Ranostay <mranostay@ti.com>
Subject: [PATCH 3/3] PCI: j721e: Add warnings on num-lanes misconfiguration
Date:   Fri, 9 Sep 2022 13:16:07 -0700
Message-ID: <20220909201607.3835-4-mranostay@ti.com>
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

Added dev_warn messages to alert of devicetree misconfigurations
for incorrect num-lanes setting, or the lack of one being defined.

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Matt Ranostay <mranostay@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/pci/controller/cadence/pci-j721e.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 4c6c677fab54..4f0464371e80 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -438,8 +438,17 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 	pcie->user_cfg_base = base;
 
 	ret = of_property_read_u32(node, "num-lanes", &num_lanes);
-	if (ret || num_lanes > data->max_lanes)
+	if (ret) {
+		dev_warn(dev, "no num-lanes defined, defaulting to 1\n");
 		num_lanes = 1;
+	}
+
+	if (num_lanes > data->max_lanes) {
+		dev_warn(dev, "defined num-lanes %d is greater than the "
+			      "allowed maximum of %d, defaulting to 1\n",
+			      num_lanes, data->max_lanes);
+		num_lanes = 1;
+	}
 	pcie->num_lanes = num_lanes;
 
 	if (dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48)))
-- 
2.37.2


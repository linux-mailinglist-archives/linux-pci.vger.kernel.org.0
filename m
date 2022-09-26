Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE2A5EAF44
	for <lists+linux-pci@lfdr.de>; Mon, 26 Sep 2022 20:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiIZSKN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 14:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbiIZSJn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 14:09:43 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD57D4E62F
        for <linux-pci@vger.kernel.org>; Mon, 26 Sep 2022 10:56:01 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 28QHtl5S109936;
        Mon, 26 Sep 2022 12:55:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1664214947;
        bh=ohT/Xt+gQdamRFphhGmgt8mEN9/4WnQBb8A+NOnxztw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=AyIbIWyM+J9K9A0y6PRqWOgNLZkegbdQ3ZMgp12NdrmUl44cvVeDhGt+nqu/rjr5r
         aXwRRaxioKfGgtlbNDpSpaWch5TRh+urVKKpTl4eoewLtK804PQD+QQSrZATL4CTtX
         JmuEvZJiihlUeaLP9zAIkBFJ6EIe5i99XcqSND7A=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 28QHtlSl061117
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Sep 2022 12:55:47 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 26
 Sep 2022 12:55:47 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 26 Sep 2022 12:55:47 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 28QHtjnw037500;
        Mon, 26 Sep 2022 12:55:46 -0500
From:   Matt Ranostay <mranostay@ti.com>
To:     <kishon@ti.com>, <vigneshr@ti.com>, <bhelgaas@google.com>,
        <robh@kernel.org>, <lpieralisi@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <nm@ti.com>,
        Matt Ranostay <mranostay@ti.com>
Subject: [PATCH v2 1/3] PCI: j721e: Add PCIe 4x lane selection support
Date:   Mon, 26 Sep 2022 10:55:36 -0700
Message-ID: <20220926175538.362018-2-mranostay@ti.com>
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

Add support for setting of two-bit field that allows selection of 4x
lane PCIe which was previously limited to only 2x lanes.

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Matt Ranostay <mranostay@ti.com>
---
 drivers/pci/controller/cadence/pci-j721e.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index a82f845cc4b5..d9b1527421c3 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -43,7 +43,6 @@ enum link_status {
 };
 
 #define J721E_MODE_RC			BIT(7)
-#define LANE_COUNT_MASK			BIT(8)
 #define LANE_COUNT(n)			((n) << 8)
 
 #define GENERATION_SEL_MASK		GENMASK(1, 0)
@@ -207,11 +206,15 @@ static int j721e_pcie_set_lane_count(struct j721e_pcie *pcie,
 {
 	struct device *dev = pcie->cdns_pcie->dev;
 	u32 lanes = pcie->num_lanes;
+	u32 mask = GENMASK(8, 8);
 	u32 val = 0;
 	int ret;
 
+	if (lanes == 4)
+		mask = GENMASK(9, 8);
+
 	val = LANE_COUNT(lanes - 1);
-	ret = regmap_update_bits(syscon, offset, LANE_COUNT_MASK, val);
+	ret = regmap_update_bits(syscon, offset, mask, val);
 	if (ret)
 		dev_err(dev, "failed to set link count\n");
 
-- 
2.38.0.rc0.52.gdda7228a83


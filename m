Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6895EAF41
	for <lists+linux-pci@lfdr.de>; Mon, 26 Sep 2022 20:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiIZSKL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 14:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiIZSJn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 14:09:43 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC0E4623F
        for <linux-pci@vger.kernel.org>; Mon, 26 Sep 2022 10:56:01 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 28QHttwu097082;
        Mon, 26 Sep 2022 12:55:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1664214955;
        bh=sWx2wPx8jCdiJkLyI83h46G/mn17QkErirFk1IPmVPI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=yreYnYHN8L4/gyn2L/OgITwRSE/HKodDaU+r7pvxEgp13W10cUuiJW37WJSTlb6J4
         0wP+LKAJH0s14y93uw5sfsnMhVZ+ukvNK7rrRjtUCKtJ2LSsrBSNJv/B6xIbuqBUKJ
         lHpcqvkI42VefGpmjjgKozFPJpHhgireXZ+kB9iA=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 28QHttNU061291
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Sep 2022 12:55:55 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 26
 Sep 2022 12:55:55 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 26 Sep 2022 12:55:55 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 28QHtqhN037777;
        Mon, 26 Sep 2022 12:55:54 -0500
From:   Matt Ranostay <mranostay@ti.com>
To:     <kishon@ti.com>, <vigneshr@ti.com>, <bhelgaas@google.com>,
        <robh@kernel.org>, <lpieralisi@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <nm@ti.com>,
        Matt Ranostay <mranostay@ti.com>
Subject: [PATCH v2 3/3] PCI: j721e: Add warnings on num-lanes misconfiguration
Date:   Mon, 26 Sep 2022 10:55:38 -0700
Message-ID: <20220926175538.362018-4-mranostay@ti.com>
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

Added dev_warn messages to alert of devicetree misconfigurations
for incorrect num-lanes setting, or the lack of one being defined.

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Matt Ranostay <mranostay@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/pci/controller/cadence/pci-j721e.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 0a537f2d5078..ee0ab04ca66e 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -441,8 +441,17 @@ static int j721e_pcie_probe(struct platform_device *pdev)
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
2.38.0.rc0.52.gdda7228a83


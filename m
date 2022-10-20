Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBCA3605583
	for <lists+linux-pci@lfdr.de>; Thu, 20 Oct 2022 04:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbiJTC0t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Oct 2022 22:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbiJTC0j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Oct 2022 22:26:39 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05B71285F5
        for <linux-pci@vger.kernel.org>; Wed, 19 Oct 2022 19:26:35 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29K1TUgr078079;
        Wed, 19 Oct 2022 20:29:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666229370;
        bh=vAU1N0qfuq8uKZms4zsWz2Cb9edAam1xn+w+BPX5ePA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ru3dZh6mGN9MdRjkWd8GKlypLYQdLZRasOLe0sP+hEdTjSjwicbFugIcrnyngbaIm
         cOYbjIc6RwxNbNiZvmsi9eM9NnhBc5cHi56JOmxssTW0KlRyISFjmTNfI9DyTbWYUX
         VMB1Bu8IrRUtQYWOxMHV4RbuzEyTpPAJTn16EGVs=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29K1TUC3092424
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Oct 2022 20:29:30 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Wed, 19
 Oct 2022 20:29:30 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Wed, 19 Oct 2022 20:29:30 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29K1TR8c064133;
        Wed, 19 Oct 2022 20:29:29 -0500
From:   Matt Ranostay <mranostay@ti.com>
To:     <robh@kernel.org>, <tjoseph@cadence.com>, <nm@ti.com>,
        <a-verma1@ti.com>, <vigneshr@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, Matt Ranostay <mranostay@ti.com>
Subject: [PATCH v3 3/3] PCI: j721e: Add warnings on num-lanes misconfiguration
Date:   Wed, 19 Oct 2022 18:29:11 -0700
Message-ID: <20221020012911.305139-4-mranostay@ti.com>
X-Mailer: git-send-email 2.38.GIT
In-Reply-To: <20221020012911.305139-1-mranostay@ti.com>
References: <20221020012911.305139-1-mranostay@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Added dev_warn messages to alert of devicetree misconfigurations
for incorrect num-lanes setting, or the lack of one being defined.

Signed-off-by: Matt Ranostay <mranostay@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/pci/controller/cadence/pci-j721e.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 0a537f2d5078..2922be2ac4e1 100644
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
+		dev_warn(dev, "defined num-lanes %u is greater than the "
+			      "allowed maximum of %u, defaulting to 1\n",
+			      num_lanes, data->max_lanes);
+		num_lanes = 1;
+	}
 	pcie->num_lanes = num_lanes;
 
 	if (dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48)))
-- 
2.38.GIT


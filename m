Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D8460D903
	for <lists+linux-pci@lfdr.de>; Wed, 26 Oct 2022 03:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbiJZB7l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 21:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbiJZB7j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 21:59:39 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7EB95
        for <linux-pci@vger.kernel.org>; Tue, 25 Oct 2022 18:59:29 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29Q1xJ2Y046355;
        Tue, 25 Oct 2022 20:59:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666749559;
        bh=L/iYrKU14tcjE8iWVPNSLkK7DEnDJN6/AKjlSRE0Yd0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=N87YnfUOeARHm8hon+TUFnMElzMEKV3yqmIdtiqzQXmAP6SRgKMnWTmqGMj/a/0Fw
         IlfDM3cLOyEH5HublbHK0z+6/pIinT9XVNz5hvkQC3NYw6rHkQQz1kMJGdTgpZcLP0
         Kq36QDCmTegFtUWllMpfMqklWK+rJcOgn67Jyq6k=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29Q1xJWQ017758
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Oct 2022 20:59:19 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 25
 Oct 2022 20:59:18 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 25 Oct 2022 20:59:18 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29Q1xEaC058277;
        Tue, 25 Oct 2022 20:59:17 -0500
From:   Matt Ranostay <mranostay@ti.com>
To:     <vigneshr@ti.com>, <lpieralisi@kernel.org>, <robh@kernel.org>,
        <kw@linux.com>, <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Matt Ranostay <mranostay@ti.com>
Subject: [PATCH v4 3/3] PCI: j721e: Add warnings on num-lanes misconfiguration
Date:   Tue, 25 Oct 2022 18:58:50 -0700
Message-ID: <20221026015850.591044-4-mranostay@ti.com>
X-Mailer: git-send-email 2.38.GIT
In-Reply-To: <20221026015850.591044-1-mranostay@ti.com>
References: <20221026015850.591044-1-mranostay@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
---
 drivers/pci/controller/cadence/pci-j721e.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 397e456af439..5a3e257055e4 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -442,9 +442,16 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 	pcie->user_cfg_base = base;
 
 	ret = of_property_read_u32(node, "num-lanes", &num_lanes);
-	if (ret || num_lanes > data->max_lanes)
+	if (ret) {
+		dev_warn(dev, "no num-lanes defined, defaulting to 1\n");
 		num_lanes = 1;
+	}
 
+	if (num_lanes > data->max_lanes) {
+		dev_warn(dev, "defined num-lanes %u is greater than the allowed maximum of %u, defaulting to 1\n",
+			 num_lanes, data->max_lanes);
+		num_lanes = 1;
+	}
 	pcie->max_lanes = data->max_lanes;
 	pcie->num_lanes = num_lanes;
 
-- 
2.38.GIT


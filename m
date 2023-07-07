Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5DA74AE19
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jul 2023 11:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbjGGJvv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jul 2023 05:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbjGGJvu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jul 2023 05:51:50 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD46F2125;
        Fri,  7 Jul 2023 02:51:43 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3679pLQh006874;
        Fri, 7 Jul 2023 04:51:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1688723481;
        bh=qDLhtas3u/8HJM6Jwdk+LzFdFPztFG/DMXDGaDAWII0=;
        h=From:To:CC:Subject:Date;
        b=MIP1BVgEKJ3bX0GOsyL3+CLm/36bOVpOLMOlA+t2ueKoSH3kSoI6v4OT5iYIdTY+Z
         qSc+uq/OmHBJTrTmKdCu2DgUBv33JkgA2UzFyvEz75VJ4rbQtPt3Jv+iCvR5Q2LRZy
         4VWCnwlR6FZv0uLO3dQId7Rp3/5NGB360RLzzDWA=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3679pLSh122036
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 7 Jul 2023 04:51:21 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 7
 Jul 2023 04:51:20 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 7 Jul 2023 04:51:20 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3679pKTB065814;
        Fri, 7 Jul 2023 04:51:20 -0500
From:   Achal Verma <a-verma1@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Achal Verma <a-verma1@ti.com>
Subject: [PATCH v3] PCI: j721e: Delay 100ms T_PVPERL from power stable to PERST# inactive
Date:   Fri, 7 Jul 2023 15:21:19 +0530
Message-ID: <20230707095119.447952-1-a-verma1@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

As per the PCIe Card Electromechanical specification REV. 5.0, PERST#
signal should be de-asserted after minimum 100ms from the time power-rails
become stable. So, to ensure 100ms delay to give sufficient time for
power-rails and refclk to become stable, change delay from 100us to 100ms.

From PCIe Card Electromechanical specification REV. 5.0 section 2.9.2:
TPVPERL: Power stable to PERST# inactive - 100ms

Fixes: f3e25911a430 ("PCI: j721e: Add TI J721E PCIe driver")
Signed-off-by: Achal Verma <a-verma1@ti.com>
---

Changes from v2:
* Fix commit message.

Change from v1:
* Add macro for delay value.

 drivers/pci/controller/cadence/pci-j721e.c | 11 +++++------
 drivers/pci/pci.h                          |  2 ++
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index e70213c9060a..32b6a7dc3cff 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -498,14 +498,13 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 
 		/*
 		 * "Power Sequencing and Reset Signal Timings" table in
-		 * PCI EXPRESS CARD ELECTROMECHANICAL SPECIFICATION, REV. 3.0
-		 * indicates PERST# should be deasserted after minimum of 100us
-		 * once REFCLK is stable. The REFCLK to the connector in RC
-		 * mode is selected while enabling the PHY. So deassert PERST#
-		 * after 100 us.
+		 * PCI EXPRESS CARD ELECTROMECHANICAL SPECIFICATION, REV. 5.0
+		 * indicates PERST# should be deasserted after minimum of 100ms
+		 * after power rails achieve specified operating limits and
+		 * within this period reference clock should also become stable.
 		 */
 		if (gpiod) {
-			usleep_range(100, 200);
+			msleep(PCIE_TPVPERL_DELAY_MS);
 			gpiod_set_value_cansleep(gpiod, 1);
 		}
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index a4c397434057..6ab2367e5867 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -13,6 +13,8 @@
 
 #define PCIE_LINK_RETRAIN_TIMEOUT_MS	1000
 
+#define PCIE_TPVPERL_DELAY_MS	100	/* see PCIe CEM r5.0, sec 2.9.2 */
+
 extern const unsigned char pcie_link_speed[];
 extern bool pci_early_dump;
 
-- 
2.25.1


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92B37494B9
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jul 2023 06:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbjGFEe4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jul 2023 00:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjGFEe4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jul 2023 00:34:56 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0DF1BD0;
        Wed,  5 Jul 2023 21:34:53 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3664YemF011160;
        Wed, 5 Jul 2023 23:34:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1688618080;
        bh=/7cX9tOZWVlh0hZDtrY+9qt2WdQ1rRynHG3OqkhVaQ8=;
        h=From:To:CC:Subject:Date;
        b=QxxF7N9XbQ8nL2PCfO4CIQdYm2fhsZcaCQg7fIKMA2Iocq/EOGYBohrgtjlWUIDpE
         a+0CKh8b1yqAaIo5nkchaaMsIJjrHZxHbBgCpQCGkIQwOmPuEzsA907Xw+cee98Inz
         IRX+uvUTZE7MEUUh/y4gOZPu7mAc2xjUVxTzrDKc=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3664YdL0111329
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 5 Jul 2023 23:34:40 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 5
 Jul 2023 23:34:39 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 5 Jul 2023 23:34:39 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3664Yc6j061311;
        Wed, 5 Jul 2023 23:34:39 -0500
From:   Achal Verma <a-verma1@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Achal Verma <a-verma1@ti.com>
Subject: [PATCH v2] PCI: j721e: Delay 100ms T_PVPERL from power stable to PERST# inactive
Date:   Thu, 6 Jul 2023 10:04:38 +0530
Message-ID: <20230706043438.407600-1-a-verma1@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

As per the PCIe Card Electromechanical specification REV. 5.0, PERST#
signal should be de-asserted after minimum 100ms from the time power-rails
become stable.
So, to ensure 100ms delay to give sufficient time for power-rails and
refclk to become stable, change delay from 100us to 100ms.

From PCIe Card Electromechanical specification REV. 5.0 section 2.9.2:
TPVPERL: Power stable to PERST# inactive - 100ms
T-PERST-CLK: REFCLK stable before PERST# inactive - 100 usec.

Fixes: f3e25911a430 ("PCI: j721e: Add TI J721E PCIe driver")
Signed-off-by: Achal Verma <a-verma1@ti.com>
---
 drivers/pci/controller/cadence/pci-j721e.c | 11 +++++------
 drivers/pci/pci.h                          |  2 ++
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index e70213c9060a..a3c8273b7320 100644
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
+			msleep(PCI_TPVPERL_DELAY);
 			gpiod_set_value_cansleep(gpiod, 1);
 		}
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index a4c397434057..7482cff16fef 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -13,6 +13,8 @@
 
 #define PCIE_LINK_RETRAIN_TIMEOUT_MS	1000
 
+#define PCI_TPVPERL_DELAY	100	/* msec; see PCIe r5.0, sec 2.9.2 */
+
 extern const unsigned char pcie_link_speed[];
 extern bool pci_early_dump;
 
-- 
2.25.1


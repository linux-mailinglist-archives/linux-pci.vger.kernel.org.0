Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0723677F398
	for <lists+linux-pci@lfdr.de>; Thu, 17 Aug 2023 11:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349773AbjHQJhL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Aug 2023 05:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349916AbjHQJgh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Aug 2023 05:36:37 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950DB2724;
        Thu, 17 Aug 2023 02:36:35 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37H9aMbv130389;
        Thu, 17 Aug 2023 04:36:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1692264982;
        bh=cM2v5idW6LPns03CXo999YFb/jfLx+ptnb6APGeD3xc=;
        h=From:To:CC:Subject:Date;
        b=JCpoUKTSRGM3I9svuYGs0nI+tSY9C83ZPgI4YIT+b4Mls6wBNs55eiR7Dg93VZB2C
         YN8M0nrmEAOY8U7lQyCWcHLkfTBPTx6uQEUCEr83L/Fhp7hbUgfHXV4DcoGSuFMMde
         HasRk0xKB45E/33Mi0GYhPDzeRcb0lamgZEgjH0s=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37H9aM5T048780
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Aug 2023 04:36:22 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 17
 Aug 2023 04:36:21 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 17 Aug 2023 04:36:21 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37H9aK5Y007933;
        Thu, 17 Aug 2023 04:36:20 -0500
From:   Achal Verma <a-verma1@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Achal Verma <a-verma1@ti.com>
Subject: [PATCH v5] PCI: j721e: Delay T_PVPERL+TPERST_CLK before PERST# inactive
Date:   Thu, 17 Aug 2023 15:06:19 +0530
Message-ID: <20230817093619.1079267-1-a-verma1@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

As per the PCIe Card Electromechanical specification REV. 5.0, PERST#
signal should be de-asserted after minimum 100ms from the time power-rails
achieve specified operating limits and 100us after reference clock gets
stable.

From PCIe Card Electromechanical specification REV. 5.0 section 2.9.2:
TPVPERL: Power stable to PERST# inactive - 100ms
TPERST_CLK: REFCLK stable before PERST# inactive - 100us

Fixes: f3e25911a430 ("PCI: j721e: Add TI J721E PCIe driver")
Signed-off-by: Achal Verma <a-verma1@ti.com>
---
 drivers/pci/controller/cadence/pci-j721e.c | 30 +++++++++++-----------
 drivers/pci/pci.h                          |  3 +++
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index e70213c9060a..b09924b010ab 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -34,6 +34,8 @@
 #define J721E_PCIE_USER_LINKSTATUS	0x14
 #define LINK_STATUS			GENMASK(1, 0)
 
+#define PERST_INACTIVE_US (PCIE_TPVPERL_MS*USEC_PER_MSEC + PCIE_TPERST_CLK_US)
+
 enum link_status {
 	NO_RECEIVERS_DETECTED,
 	LINK_TRAINING_IN_PROGRESS,
@@ -359,7 +361,7 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 	struct j721e_pcie *pcie;
 	struct cdns_pcie_rc *rc = NULL;
 	struct cdns_pcie_ep *ep = NULL;
-	struct gpio_desc *gpiod;
+	struct gpio_desc *perst_gpiod;
 	void __iomem *base;
 	struct clk *clk;
 	u32 num_lanes;
@@ -468,11 +470,10 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 
 	switch (mode) {
 	case PCI_MODE_RC:
-		gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
-		if (IS_ERR(gpiod)) {
-			ret = PTR_ERR(gpiod);
-			if (ret != -EPROBE_DEFER)
-				dev_err(dev, "Failed to get reset GPIO\n");
+		perst_gpiod = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+		if (IS_ERR(perst_gpiod)) {
+			ret = PTR_ERR(perst_gpiod);
+			dev_err(dev, "Failed to get reset GPIO\n");
 			goto err_get_sync;
 		}
 
@@ -498,16 +499,15 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 
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
+		 * 100us after reference clock gets stable.
+		 * PERST_INACTIVE_US accounts for both delays.
 		 */
-		if (gpiod) {
-			usleep_range(100, 200);
-			gpiod_set_value_cansleep(gpiod, 1);
-		}
+
+		fsleep(PERST_INACTIVE_US);
+		gpiod_set_value_cansleep(perst_gpiod, 1);
 
 		ret = cdns_pcie_host_setup(rc);
 		if (ret < 0) {
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index a4c397434057..80d520be34e6 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -13,6 +13,9 @@
 
 #define PCIE_LINK_RETRAIN_TIMEOUT_MS	1000
 
+#define PCIE_TPVPERL_MS		100	/* see PCIe CEM r5.0, sec 2.9.2 */
+#define PCIE_TPERST_CLK_US	100
+
 extern const unsigned char pcie_link_speed[];
 extern bool pci_early_dump;
 
-- 
2.25.1


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3DF7259DB
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jun 2023 11:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235293AbjFGJPX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Jun 2023 05:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239944AbjFGJOu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Jun 2023 05:14:50 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D3519BA;
        Wed,  7 Jun 2023 02:14:48 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3579EWjW094829;
        Wed, 7 Jun 2023 04:14:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686129272;
        bh=bedDUpRHU1I2zUEj6vuIlNfA4kkWDYv24G4OlTw6Dd0=;
        h=From:To:CC:Subject:Date;
        b=j4UmrmOs90MEX7Yb67RcVWwSESrVKb+bckrhJiwY1n+IEt6P02F9gywr12zVbsrPl
         FFCxitY2XYQ+WIeZNn44uHHjn4ilvsKu399hfWlTc4XaUbj9Oa2rQAUJPnGySoiTq7
         2JQEP8/pgD7eVD4s0wKRiO/E1M2gD1d1LdUkBoDs=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3579EWhP015018
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 7 Jun 2023 04:14:32 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Jun 2023 04:14:32 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Jun 2023 04:14:32 -0500
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3579ESXf056801;
        Wed, 7 Jun 2023 04:14:28 -0500
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <tjoseph@cadence.com>, <lpieralisi@kernel.org>, <robh@kernel.org>,
        <kw@linux.com>, <bhelgaas@google.com>, <nadeem@cadence.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
        <srk@ti.com>, <nm@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v3] PCI: cadence: Fix Gen2 Link Retraining process
Date:   Wed, 7 Jun 2023 14:44:27 +0530
Message-ID: <20230607091427.852473-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Link Retraining process is initiated to account for the Gen2 defect in
the Cadence PCIe controller in J721E SoC. The errata corresponding to this
is i2085, documented at:
https://www.ti.com/lit/er/sprz455c/sprz455c.pdf

The existing workaround implemented for the errata waits for the Data Link
initialization to complete and assumes that the link retraining process
at the Physical Layer has completed. However, it is possible that the
Physical Layer training might be ongoing as indicated by the
PCI_EXP_LNKSTA_LT bit in the PCI_EXP_LNKSTA register.

Fix the existing workaround, to ensure that the Physical Layer training
has also completed, in addition to the Data Link initialization.

Fixes: 4740b969aaf5 ("PCI: cadence: Retrain Link to work around Gen2 training defect")
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
---

Hello,

This patch is based on linux-next tagged next-20230606.

v2:
https://lore.kernel.org/r/20230315070800.1615527-1-s-vadapalli@ti.com/
Changes since v2:
- Merge the cdns_pcie_host_training_complete() function with the
  cdns_pcie_host_wait_for_link() function, as suggested by Bjorn
  for the v2 patch.
- Add dev_err() to notify when Link Training fails, since this is a
  fatal error and proceeding from this point will almost always crash
  the kernel.

v1:
https://lore.kernel.org/r/20230102075656.260333-1-s-vadapalli@ti.com/
Changes since v1:
- Collect Reviewed-by tag from Vignesh Raghavendra.
- Rebase on next-20230315.

Regards,
Siddharth.

 .../controller/cadence/pcie-cadence-host.c    | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index 940c7dd701d6..70a5f581ff4f 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -12,6 +12,8 @@
 
 #include "pcie-cadence.h"
 
+#define LINK_RETRAIN_TIMEOUT HZ
+
 static u64 bar_max_size[] = {
 	[RP_BAR0] = _ULL(128 * SZ_2G),
 	[RP_BAR1] = SZ_2G,
@@ -80,8 +82,26 @@ static struct pci_ops cdns_pcie_host_ops = {
 static int cdns_pcie_host_wait_for_link(struct cdns_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
+	unsigned long end_jiffies;
+	u16 link_status;
 	int retries;
 
+	/* Wait for link training to complete */
+	end_jiffies = jiffies + LINK_RETRAIN_TIMEOUT;
+	do {
+		link_status = cdns_pcie_rp_readw(pcie, CDNS_PCIE_RP_CAP_OFFSET + PCI_EXP_LNKSTA);
+		if (!(link_status & PCI_EXP_LNKSTA_LT))
+			break;
+		usleep_range(0, 1000);
+	} while (time_before(jiffies, end_jiffies));
+
+	if (!(link_status & PCI_EXP_LNKSTA_LT)) {
+		dev_info(dev, "Link training complete\n");
+	} else {
+		dev_err(dev, "Fatal! Link training incomplete\n");
+		return -ETIMEDOUT;
+	}
+
 	/* Check if the link is up or not */
 	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
 		if (cdns_pcie_link_up(pcie)) {
-- 
2.25.1


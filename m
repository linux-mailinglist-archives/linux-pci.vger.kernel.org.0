Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA6A65ADD4
	for <lists+linux-pci@lfdr.de>; Mon,  2 Jan 2023 08:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjABH5X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Jan 2023 02:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjABH5W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Jan 2023 02:57:22 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFEB111E;
        Sun,  1 Jan 2023 23:57:21 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3027v12q122744;
        Mon, 2 Jan 2023 01:57:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1672646221;
        bh=eZNdl8Zg2jniUj40iGn+2YXnfest+hfG4/Jhm6+RTH8=;
        h=From:To:CC:Subject:Date;
        b=oeImrmQUaMmLCEZG+eMls7OYNh2Os/OFBaoOyapVxSTzRFZkIfTGBOhJhfayCg2T4
         yqIBpcsA/sTl8a7GqsNnM3P19ecvRzZaXz/6IrD/lvW5lGZppZOB6mElSim9KAytvD
         e3aV3gulvkTBdQIgn/8bqj0Mo4iHoUaitp2IUnPo=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3027v1XI105780
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Jan 2023 01:57:01 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 2
 Jan 2023 01:57:00 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 2 Jan 2023 01:57:00 -0600
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3027uuJD021994;
        Mon, 2 Jan 2023 01:56:57 -0600
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <tjoseph@cadence.com>, <lpieralisi@kernel.org>, <robh@kernel.org>,
        <kw@linux.com>, <bhelgaas@google.com>, <nadeem@cadence.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
        <srk@ti.com>, <nm@ti.com>, <s-vadapalli@ti.com>
Subject: [RESEND PATCH] PCI: cadence: Fix Gen2 Link Retraining process
Date:   Mon, 2 Jan 2023 13:26:56 +0530
Message-ID: <20230102075656.260333-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
---
 .../controller/cadence/pcie-cadence-host.c    | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index 940c7dd701d6..5b14f7ee3c79 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -12,6 +12,8 @@
 
 #include "pcie-cadence.h"
 
+#define LINK_RETRAIN_TIMEOUT HZ
+
 static u64 bar_max_size[] = {
 	[RP_BAR0] = _ULL(128 * SZ_2G),
 	[RP_BAR1] = SZ_2G,
@@ -77,6 +79,27 @@ static struct pci_ops cdns_pcie_host_ops = {
 	.write		= pci_generic_config_write,
 };
 
+static int cdns_pcie_host_training_complete(struct cdns_pcie *pcie)
+{
+	u32 pcie_cap_off = CDNS_PCIE_RP_CAP_OFFSET;
+	unsigned long end_jiffies;
+	u16 lnk_stat;
+
+	/* Wait for link training to complete. Exit after timeout. */
+	end_jiffies = jiffies + LINK_RETRAIN_TIMEOUT;
+	do {
+		lnk_stat = cdns_pcie_rp_readw(pcie, pcie_cap_off + PCI_EXP_LNKSTA);
+		if (!(lnk_stat & PCI_EXP_LNKSTA_LT))
+			break;
+		usleep_range(0, 1000);
+	} while (time_before(jiffies, end_jiffies));
+
+	if (!(lnk_stat & PCI_EXP_LNKSTA_LT))
+		return 0;
+
+	return -ETIMEDOUT;
+}
+
 static int cdns_pcie_host_wait_for_link(struct cdns_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
@@ -118,6 +141,10 @@ static int cdns_pcie_retrain(struct cdns_pcie *pcie)
 		cdns_pcie_rp_writew(pcie, pcie_cap_off + PCI_EXP_LNKCTL,
 				    lnk_ctl);
 
+		ret = cdns_pcie_host_training_complete(pcie);
+		if (ret)
+			return ret;
+
 		ret = cdns_pcie_host_wait_for_link(pcie);
 	}
 	return ret;
-- 
2.25.1


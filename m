Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F867AF9BB
	for <lists+linux-pci@lfdr.de>; Wed, 27 Sep 2023 06:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjI0EyD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Sep 2023 00:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjI0ExU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Sep 2023 00:53:20 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8907B3A85;
        Tue, 26 Sep 2023 21:19:08 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38R4Ipcg064494;
        Tue, 26 Sep 2023 23:18:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695788331;
        bh=b+v0kXcbL/x8WGX8epMNqGlxkmAzB2Gr+GgRtU6z/Ss=;
        h=From:To:CC:Subject:Date;
        b=S9GWVUfNGSqeP/G8Qrr/cqRFpqfWiEQzfZnOBvNqahHcM0KzNmshQ/YkGq0sH7hWp
         2CbsAodbidGI1QRDp0dVfhe4kW51h9vEYQGaV3CxD2BQ/pAmCxlhInEOJLX/031Y4D
         /HJ0/5Mu3DpNTEU34336ORjh9LjvYufc4ws4rQDA=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38R4IoWx003148
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Sep 2023 23:18:51 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Sep 2023 23:18:50 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Sep 2023 23:18:50 -0500
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38R4IkJp057625;
        Tue, 26 Sep 2023 23:18:46 -0500
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <ilpo.jarvinen@linux.intel.com>, <vigneshr@ti.com>,
        <r-gunasekaran@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v3] PCI: keystone: Fix race condition when initializing PHYs
Date:   Wed, 27 Sep 2023 09:48:45 +0530
Message-ID: <20230927041845.1222080-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCI driver invokes the PHY APIs using the ks_pcie_enable_phy()
function. The PHY in this case is the Serdes. It is possible that the
PCI instance is configured for 2 lane operation across two different
Serdes instances, using 1 lane of each Serdes. In such a configuration,
if the reference clock for one Serdes is provided by the other Serdes,
it results in a race condition. After the Serdes providing the reference
clock is initialized by the PCI driver by invoking its PHY APIs, it is
not guaranteed that this Serdes remains powered on long enough for the
PHY APIs based initialization of the dependent Serdes. In such cases,
the PLL of the dependent Serdes fails to lock due to the absence of the
reference clock from the former Serdes which has been powered off by the
PM Core.

Fix this by obtaining reference to the PHYs before invoking the PHY
initialization APIs and releasing reference after the initialization is
complete.

Fixes: 49229238ab47 ("PCI: keystone: Cleanup PHY handling")
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

NOTE: This patch is based on linux-next tagged next-20230927.

v2:
https://lore.kernel.org/r/20230926063638.1005124-1-s-vadapalli@ti.com/

Changes since v2:
- Implement suggestion by Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
  moving the phy_pm_runtime_put_sync() For-Loop section before the
  return value of ks_pcie_enable_phy(ks_pcie) is checked, thereby
  preventing duplication of the For-Loop.
- Rebase patch on next-20230927.

v1:
https://lore.kernel.org/r/20230926054200.963803-1-s-vadapalli@ti.com/

Changes since v1:
- Add code to release reference(s) to the phy(s) when
  ks_pcie_enable_phy(ks_pcie) fails.

Regards,
Siddharth.

 drivers/pci/controller/dwc/pci-keystone.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 49aea6ce3e87..0ec6720cc2df 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -1218,7 +1218,16 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 		goto err_link;
 	}
 
+	/* Obtain reference(s) to the phy(s) */
+	for (i = 0; i < num_lanes; i++)
+		phy_pm_runtime_get_sync(ks_pcie->phy[i]);
+
 	ret = ks_pcie_enable_phy(ks_pcie);
+
+	/* Release reference(s) to the phy(s) */
+	for (i = 0; i < num_lanes; i++)
+		phy_pm_runtime_put_sync(ks_pcie->phy[i]);
+
 	if (ret) {
 		dev_err(dev, "failed to enable phy\n");
 		goto err_link;
-- 
2.34.1


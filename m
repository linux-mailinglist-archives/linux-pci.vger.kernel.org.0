Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809767CD5AF
	for <lists+linux-pci@lfdr.de>; Wed, 18 Oct 2023 09:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjJRHvE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Oct 2023 03:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344584AbjJRHvD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Oct 2023 03:51:03 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2A0EA;
        Wed, 18 Oct 2023 00:50:59 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39I7ohxW077421;
        Wed, 18 Oct 2023 02:50:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697615443;
        bh=/Pn+j+SGy0Pf87LvUcY7SLTOVYLU/WbWc24R3v0wvWc=;
        h=From:To:CC:Subject:Date;
        b=tp6wxbdp86ZnMpNI3cW9dgf5y/qagJEp7+LUwrU5dWkwrUIGvJnnDgS+3VyjLoE4K
         7wMH4Bpy/igBoyEoNCyO8x2hsKVePs/wETgfHkuRdQTnBfCYU+Ban6t2t2YNqsgCIG
         XRh3ULEJHKXUyKKI9cIMI2xf7YM6fOOdUpwUxxYA=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39I7ohAr074316
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Oct 2023 02:50:43 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 18
 Oct 2023 02:50:42 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 18 Oct 2023 02:50:42 -0500
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39I7odjM030544;
        Wed, 18 Oct 2023 02:50:40 -0500
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <r-gunasekaran@ti.com>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v2] PCI: keystone: Fix ks_pcie_v3_65_add_bus() for AM654x SoC
Date:   Wed, 18 Oct 2023 13:20:38 +0530
Message-ID: <20231018075038.2740534-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The ks_pcie_v3_65_add_bus() member of "ks_pcie_ops" was added for
platforms using DW PCIe IP-core version 3.65a. The AM654x SoC uses
DW PCIe IP-core version 4.90a and ks_pcie_v3_65_add_bus() is not
applicable to it.

The commit which added support for the AM654x SoC has reused majority
of the functions with the help of the "is_am6" flag to handle AM654x
separately where applicable. Thus, make use of the "is_am6" flag and
change ks_pcie_v3_65_add_bus() to no-op for AM654x SoC.

Fixes: 18b0415bc802 ("PCI: keystone: Add support for PCIe RC in AM654x Platforms")
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
Hello,

This patch is based on linux-next tagged next-20231018.

The v1 of this patch is at:
https://lore.kernel.org/r/20231011123451.34827-1-s-vadapalli@ti.com/

While there are a lot of changes since v1 and this patch could have been
posted as a v1 patch itself, I decided to post it as the v2 of the patch
mentioned above since it aims to address the issue described by the v1
patch and is similar in that sense. However, the solution to the issue
described in the v1 patch appears to be completely different from what
was implemented in the v1 patch. Thus, the commit message and subject of
this patch have been modified accordingly.

Changes since v1:
- Updated patch subject and commit message.
- Determined that issue is not with the absence of Link as mentioned in
  v1 patch. Even with Link up and endpoint device connected, if
  ks_pcie_v3_65_add_bus() is invoked and executed, all reads to the
  MSI-X offsets return 0xffffffff when pcieport driver attempts to setup
  AER and PME services. The all Fs return value indicates that the MSI-X
  configuration is failing even if Endpoint device is connected. This is
  because the ks_pcie_v3_65_add_bus() function is not applicable to the
  AM654x SoC which uses DW PCIe IP-core version 4.90a.

Regards,
Siddharth.

 drivers/pci/controller/dwc/pci-keystone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 0def919f89fa..3abd59335574 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -459,7 +459,7 @@ static int ks_pcie_v3_65_add_bus(struct pci_bus *bus)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
 
-	if (!pci_is_root_bus(bus))
+	if (!pci_is_root_bus(bus) || ks_pcie->is_am6)
 		return 0;
 
 	/* Configure and set up BAR0 */
-- 
2.34.1


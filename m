Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F437CF228
	for <lists+linux-pci@lfdr.de>; Thu, 19 Oct 2023 10:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235247AbjJSIN7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Oct 2023 04:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbjJSIN6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Oct 2023 04:13:58 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EBE12F;
        Thu, 19 Oct 2023 01:13:54 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39J8DYM2129962;
        Thu, 19 Oct 2023 03:13:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697703214;
        bh=0qE8V70UAtb0s2FCvY0TJ7HyrnlN4XuaTojCP/DiH5k=;
        h=From:To:CC:Subject:Date;
        b=VKH0H5pJ6IaUlMQbBm5IwFvd1NuE8jebHXM+jrmUvnZCIUvkuOtWbt8WRHkzyVJ3J
         SOoYcMBbqN8Xj9nGswAzjgYJ4kcd3b/b9pPYnzj8ZImsPmmuHn2fLf84FxPCkEhnvi
         52Z+Hakd7vUqBnnVWVYcGP/sZq0xxYUl/X2SOEAg=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39J8DYMY080854
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Oct 2023 03:13:34 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 19
 Oct 2023 03:13:34 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 19 Oct 2023 03:13:34 -0500
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39J8DUhM103191;
        Thu, 19 Oct 2023 03:13:31 -0500
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>
CC:     <fancer.lancer@gmail.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <r-gunasekaran@ti.com>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v3] PCI: keystone: Fix pci_ops for AM654x SoC
Date:   Thu, 19 Oct 2023 13:43:30 +0530
Message-ID: <20231019081330.2975470-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In the process of converting .scan_bus() callbacks to .add_bus(), the
ks_pcie_v3_65_scan_bus() function was changed to ks_pcie_v3_65_add_bus().
The .scan_bus() method belonged to ks_pcie_host_ops which was specific
to controller version 3.65a, while the .add_bus() method had been added
to ks_pcie_ops which is shared between the controller versions 3.65a and
4.90a. Neither the older ks_pcie_v3_65_scan_bus() method, nor the newer
ks_pcie_v3_65_add_bus() method are applicable to the controller version
4.90a which is present in AM654x SoCs.

Thus, fix this by creating ks_pcie_am6_ops for the AM654x SoC which uses DW
PCIe IP-core version 4.90a controller and omitting the .add_bus() method
which is not applicable to the 4.90a controller. Update ks_pcie_host_init()
accordingly in order to set the pci_ops to ks_pcie_am6_ops if the platform
is AM654x SoC and to ks_pcie_ops otherwise, by making use of the "is_am6"
flag.

Fixes: 6ab15b5e7057 ("PCI: dwc: keystone: Convert .scan_bus() callback to use add_bus")
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
Hello,

This patch is based on linux-next tagged next-20231018.

The v2 of this patch is at:
https://lore.kernel.org/r/20231018075038.2740534-1-s-vadapalli@ti.com/

Changes since v2:
- Implemented Serge's suggestion of adding a new pci_ops structure for
  AM654x SoC using DWC PCIe IP-core version 4.90a controller.
- Created struct pci_ops ks_pcie_am6_ops for AM654x SoC without the
  .add_bus method while retaining other ops from ks_pcie_ops.
- Updated ks_pcie_host_init() to set pci_ops to ks_pcie_am6_ops if the
  platform is AM654x and to ks_pcie_ops otherwise by making use of the
  already existing "is_am6" flag.
- Combined the section:
	if (!ks_pcie->is_am6)
 		pp->bridge->child_ops = &ks_child_pcie_ops;
  into the newly added ELSE condition.

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

 drivers/pci/controller/dwc/pci-keystone.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 49aea6ce3e87..66341a0b6c6b 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -487,6 +487,12 @@ static struct pci_ops ks_pcie_ops = {
 	.add_bus = ks_pcie_v3_65_add_bus,
 };
 
+static struct pci_ops ks_pcie_am6_ops = {
+	.map_bus = dw_pcie_own_conf_map_bus,
+	.read = pci_generic_config_read,
+	.write = pci_generic_config_write,
+};
+
 /**
  * ks_pcie_link_up() - Check if link up
  * @pci: A pointer to the dw_pcie structure which holds the DesignWare PCIe host
@@ -804,9 +810,12 @@ static int __init ks_pcie_host_init(struct dw_pcie_rp *pp)
 	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
 	int ret;
 
-	pp->bridge->ops = &ks_pcie_ops;
-	if (!ks_pcie->is_am6)
+	if (ks_pcie->is_am6) {
+		pp->bridge->ops = &ks_pcie_am6_ops;
+	} else {
+		pp->bridge->ops = &ks_pcie_ops;
 		pp->bridge->child_ops = &ks_child_pcie_ops;
+	}
 
 	ret = ks_pcie_config_legacy_irq(ks_pcie);
 	if (ret)
-- 
2.34.1


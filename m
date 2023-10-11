Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645BE7C5409
	for <lists+linux-pci@lfdr.de>; Wed, 11 Oct 2023 14:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjJKMfQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Oct 2023 08:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjJKMfP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Oct 2023 08:35:15 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B2C94;
        Wed, 11 Oct 2023 05:35:14 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39BCYtnb064043;
        Wed, 11 Oct 2023 07:34:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697027695;
        bh=u7XL/tD7jBNy4Mf5LMc4cpgvoGhfSpXlJeuIF3bc84w=;
        h=From:To:CC:Subject:Date;
        b=wsmGMhx1UCGi1Lyebwn3dqqIq5R75oBcDVWJ0nAGZq5qEIVONM1xcBXdzt4obMEFX
         /n3eBiulwSqZu0V9DTlHWWj68svXpB4qKMaPsn2XKjjwZazQIymw3CSJt3QacCWfI8
         /HB02ZANCrpOWpIXgu0xNT+5yiklGW5HL74iRWs8=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39BCYtQE079026
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Oct 2023 07:34:55 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 11
 Oct 2023 07:34:55 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 11 Oct 2023 07:34:55 -0500
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39BCYpQG066928;
        Wed, 11 Oct 2023 07:34:52 -0500
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <r-gunasekaran@ti.com>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH] PCI: keystone: Don't enable BAR0 if link is not detected
Date:   Wed, 11 Oct 2023 18:04:51 +0530
Message-ID: <20231011123451.34827-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since the function dw_pcie_host_init() ignores the absence of link under
the assumption that link can come up later, it is possible that the
pci_host_probe(bridge) function is invoked even when no endpoint device
is connected. In such a situation, the ks_pcie_v3_65_add_bus() function
configures BAR0 when the link is not up, resulting in Completion Timeouts
during the MSI configuration performed later by the PCI Express Port driver
to setup AER, PME and other services. Thus, leave BAR0 disabled if link is
not yet detected when the ks_pcie_v3_65_add_bus() function is invoked.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on linux-next tagged next-20231011.

Regards,
Siddharth.

 drivers/pci/controller/dwc/pci-keystone.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 49aea6ce3e87..ac2ad112d616 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -459,7 +459,8 @@ static int ks_pcie_v3_65_add_bus(struct pci_bus *bus)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
 
-	if (!pci_is_root_bus(bus))
+	/* Don't enable BAR0 if link is not yet up at this point */
+	if (!pci_is_root_bus(bus) || !dw_pcie_link_up(pci))
 		return 0;
 
 	/* Configure and set up BAR0 */
-- 
2.34.1


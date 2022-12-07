Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3CDB64558B
	for <lists+linux-pci@lfdr.de>; Wed,  7 Dec 2022 09:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbiLGIkw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Dec 2022 03:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiLGIku (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Dec 2022 03:40:50 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676676355
        for <linux-pci@vger.kernel.org>; Wed,  7 Dec 2022 00:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670402449; x=1701938449;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7NtTfeVSAJ0A19i3BpouK3ejyDYa4fyT4PDvnn77SNk=;
  b=Z6HPVXwB8KS13TPQW0fty83YpL5gtaB3qRfTg42cANnKMRdxCOOfi9aS
   Fe3LcKexmRbO9DzvdrPRXk7nkh9zr9tN1S9vR/V7mr1VFdITOuBA7lxh7
   ZXoUJWqLj5bzeyrtECCnjehMsw1ivHazQKViRejqnkWuyHel309WKfXpx
   gKJVKZGCRPPY8eR8NV8s88UXPCzWWcauzdWGyMi0/ryKeWBK5z9ug1pyE
   VyfeInA+r4jjPyRx+9Mzr/BQ2B7dU0rIsGevJBL+UZOfkAvDsTUx3msjP
   J7Isct5ETP+VuDM4tyVVXR9ABUIPgl8Bvl0xrjSeIKWvm4CDU/flX5zVl
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="304468033"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="304468033"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 00:40:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="735322707"
X-IronPort-AV: E=Sophos;i="5.96,223,1665471600"; 
   d="scan'208";a="735322707"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Dec 2022 00:40:38 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 0E365F4; Wed,  7 Dec 2022 10:41:05 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH v2] PCI/portdrv: Do not require an interrupt for all AER capable ports
Date:   Wed,  7 Dec 2022 10:41:05 +0200
Message-Id: <20221207084105.84947-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Only Root Ports and Event Collectors use MSI for AER. PCIe Switch ports
or endpoints on the other hand only send messages (that get collected by
the former). For this reason do not require PCIe switch ports and
endpoints to use interrupt if they support AER.

This allows portdrv to attach PCIe switch ports of Intel DG1 and DG2
discrete graphics cards. These do not declare MSI or legacy interrupts.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
Changes from v1:

 * Updated commit message to be more specific on which hardware this is
   needed.

 drivers/pci/pcie/portdrv_core.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 1ac7fec47d6f..1b1c386e50c4 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -164,7 +164,7 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
  */
 static int pcie_init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
 {
-	int ret, i;
+	int ret, i, type;
 
 	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++)
 		irqs[i] = -1;
@@ -177,6 +177,19 @@ static int pcie_init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
 	if ((mask & PCIE_PORT_SERVICE_PME) && pcie_pme_no_msi())
 		goto legacy_irq;
 
+	/*
+	 * Only root ports and event collectors use MSI for errors. Endpoints,
+	 * switch ports send messages to them but don't use MSI for that (PCIe
+	 * 5.0 sec 6.2.3.2).
+	 */
+	type = pci_pcie_type(dev);
+	if ((mask & PCIE_PORT_SERVICE_AER) &&
+	    type != PCI_EXP_TYPE_ROOT_PORT && type != PCI_EXP_TYPE_RC_EC)
+		mask &= ~PCIE_PORT_SERVICE_AER;
+
+	if (!mask)
+		return 0;
+
 	/* Try to use MSI-X or MSI if supported */
 	if (pcie_port_enable_irq_vec(dev, irqs, mask) == 0)
 		return 0;
-- 
2.35.1


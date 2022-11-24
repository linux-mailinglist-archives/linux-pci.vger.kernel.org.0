Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C49163753A
	for <lists+linux-pci@lfdr.de>; Thu, 24 Nov 2022 10:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiKXJfA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 04:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKXJfA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 04:35:00 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CD828718
        for <linux-pci@vger.kernel.org>; Thu, 24 Nov 2022 01:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669282497; x=1700818497;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0xYbEpL+IFj58Bv/+I9mstI1nkwmltbvPfaH7RUZy8g=;
  b=Z2oNhztmP1/pMN1gtD/gMIUEB2FCHXAkgaiLqkH9nPOocs9wnr4evPN3
   aBXlCEzNtHl9mBrllF6IErvioQ6dghdEF4jOJVN7nGj3TFkKaZmsAgJWc
   5GBPVXGAsPICnm8unnImFdgsi7c9KQcip7XiZVh0dfkNOJqIbhxB7A/gg
   /v2wEOBa9RX2FK5IghUevU1QiE9jp9v//CEf9CnLzMZbl1RnyF4g8Vw+i
   bqJYahOctMBXDHJ+zs6AluCaQ/9NvlfWqWijnmfY4qe+zxoKMQDbIzCiN
   Ib/fWfLUqRsAuLkHbl2CO2G2FR3lgott8/JxxYUTbV2UKPMEEeyNHDj8v
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="314297473"
X-IronPort-AV: E=Sophos;i="5.96,190,1665471600"; 
   d="scan'208";a="314297473"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2022 01:34:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="642261983"
X-IronPort-AV: E=Sophos;i="5.96,190,1665471600"; 
   d="scan'208";a="642261983"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 24 Nov 2022 01:34:53 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 07019128; Thu, 24 Nov 2022 11:35:19 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH] PCI/portdrv: Do not require an interrupt for all AER capable ports
Date:   Thu, 24 Nov 2022 11:35:19 +0200
Message-Id: <20221124093519.85363-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Only Root Ports and Event Collectors use MSI for AER. PCIe Switch ports
or endpoints on the other hand only send messages (that get collected by
the former). For this reason do not require PCIe switch ports and
endpoints to use interrupt if they support AER.

This allows portdrv to attach to recent Intel PCIe switch ports that
don't declare MSI or legacy interrupts.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
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


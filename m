Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DFB6E87BC
	for <lists+linux-pci@lfdr.de>; Thu, 20 Apr 2023 03:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbjDTB7g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Apr 2023 21:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjDTB7e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Apr 2023 21:59:34 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DE559F7;
        Wed, 19 Apr 2023 18:59:32 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 85DCD41ABE;
        Thu, 20 Apr 2023 01:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1681955971;
        bh=l7qV65a1Ex7JimCTQ70xlboGGlA6oTb+7PSGlAKXVZY=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=JA/W3MZnZs8oMCb27sG0qP7Lqyw+YrWx9VLJ8GmTzHl1Gi+C1NDmxi22GikzwmZY6
         ftq9VmOYoMOfdQyB0vnGwxq8vGP/AsB9pTxd+Cod2XRQ1NhFeXKhjRmWPlDw1HGBA6
         noUqUUg3Sxe/igXl3K0K6BKJfANPD3Yjcsig6BO1Sv9nBJuC2BbQ9WMTWEXsomsoM+
         Onr3nwZVHCxndNi8CriRRd9lS4fjIxXjmYkricY31kHkGO3M7O1g3CGnMGesWp99kX
         V3afaJ5m3g0y2GCH20MB13SZ09aKj0YupHxq5jptYnLJjX4LkP+Gj2E2td2ES1+TRA
         3xUd9QrKluUsg==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     bhelgaas@google.com
Cc:     mika.westerberg@linux.intel.com, koba.ko@canonical.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] PCI/DPC: Disable DPC interrupt during suspend
Date:   Thu, 20 Apr 2023 09:58:30 +0800
Message-Id: <20230420015830.309845-4-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230420015830.309845-1-kai.heng.feng@canonical.com>
References: <20230420015830.309845-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe service that shares IRQ with PME may cause spurious wakeup on
system suspend.

Since AER is conditionally disabled in previous patch, also apply the
same logic to disable DPC which depends on AER to work.

PCIe Base Spec 5.0, section 5.2 "Link State Power Management" states
that TLP and DLLP transmission is disabled for a Link in L2/L3 Ready
(D3hot), L2 (D3cold with aux power) and L3 (D3cold), so we don't lose
much here to disable DPC during system suspend.

This is very similar to previous attempts to suspend AER and DPC [1],
but with a different reason.

[1] https://lore.kernel.org/linux-pci/20220408153159.106741-1-kai.heng.feng@canonical.com/
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216295

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
 - Only disable DPC IRQ.
 - No more check on PME IRQ#.

 drivers/pci/pcie/dpc.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index a5d7c69b764e..98bdefde6df1 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -385,6 +385,30 @@ static int dpc_probe(struct pcie_device *dev)
 	return status;
 }
 
+static int dpc_suspend(struct pcie_device *dev)
+{
+	struct pci_dev *pdev = dev->port;
+	u16 ctl;
+
+	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, &ctl);
+	ctl &= ~PCI_EXP_DPC_CTL_INT_EN;
+	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, ctl);
+
+	return 0;
+}
+
+static int dpc_resume(struct pcie_device *dev)
+{
+	struct pci_dev *pdev = dev->port;
+	u16 ctl;
+
+	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, &ctl);
+	ctl |= PCI_EXP_DPC_CTL_INT_EN;
+	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, ctl);
+
+	return 0;
+}
+
 static void dpc_remove(struct pcie_device *dev)
 {
 	struct pci_dev *pdev = dev->port;
@@ -400,6 +424,8 @@ static struct pcie_port_service_driver dpcdriver = {
 	.port_type	= PCIE_ANY_PORT,
 	.service	= PCIE_PORT_SERVICE_DPC,
 	.probe		= dpc_probe,
+	.suspend	= dpc_suspend,
+	.resume		= dpc_resume,
 	.remove		= dpc_remove,
 };
 
-- 
2.34.1


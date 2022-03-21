Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3114E300B
	for <lists+linux-pci@lfdr.de>; Mon, 21 Mar 2022 19:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352206AbiCUSgR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Mar 2022 14:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352200AbiCUSgQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Mar 2022 14:36:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16EB7CB06;
        Mon, 21 Mar 2022 11:34:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C43A6150F;
        Mon, 21 Mar 2022 18:34:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B009DC340E8;
        Mon, 21 Mar 2022 18:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647887689;
        bh=kgra0CAocbBKZH5l7sW9tWA/4tkAHfrOA+Ct9aMcUYo=;
        h=From:To:Cc:Subject:Date:From;
        b=bOEW+z/cwkIw6lobBNDLTAoOGiUniqR96EG/FBdltdddffubYP8snr9JgQGJM/R4S
         ILJbzIunRgf/uOsRalY2Wpd/+cjTV0DgM1v7Pta5tCXhpKdgfa7xtgXPtuNWWzAmmr
         SvmXF4EEzv10SaKGFQ8DSp53SyyFv9LAJwPA+zqFd+YBdLwUdSRL9TcCSXaq83Pm3d
         yvm8qyEs2sEclaWghwY2iv+w3xcXky5MX6oqypCxk5My9wyrs78eNNdQxRlDNkRDrb
         TtsHL0XGyaHIaF7Ns90+OuzmV7svDprsKd1ttkIoj4X9CN3NGiwEGzsXzI5xg/Ihce
         SgPixyodlZXXQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org,
        Mick Lorain <micklorain@protonmail.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: Avoid broken MSI on SB600 USB devices
Date:   Mon, 21 Mar 2022 13:34:46 -0500
Message-Id: <20220321183446.1108325-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Some ATI SB600 USB adapters advertise MSI, but if INTx is disabled by
setting PCI_COMMAND_INTX_DISABLE, MSI doesn't work either.  The PCI/PCIe
specs do not require software to set PCI_COMMAND_INTX_DISABLE when enabling
MSI, but Linux has done that for many years.

Mick reported that 306c54d0edb6 ("usb: hcd: Try MSI interrupts on PCI
devices") broke these devices.  Prior to 306c54d0edb6, they used INTx.
Starting with 306c54d0edb6, they use MSI, and and the fact that Linux sets
PCI_COMMAND_INTX_DISABLE means both INTx and MSI are disabled on these
devices.

Avoid this SB600 defect by disabling MSI so we use INTx as before.

Fixes: 306c54d0edb6 ("usb: hcd: Try MSI interrupts on PCI devices")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=215690
Link: https://lore.kernel.org/all/PxIByDyBRcsbpcmVhGSNDFAoUcMmb78ctXCkw6fbpx25TGlCHvA6SJjjFkNr1FfQZMntYPTNyvEnblxzAZ8a6jP9ddLpKeCN6Chi_2FuexU=@protonmail.com/
BugLink: https://lore.kernel.org/all/20200702143045.23429-1-andriy.shevchenko@linux.intel.com/
Link: https://lore.kernel.org/r/20220314101448.90074-1-andriy.shevchenko@linux.intel.com
Reported-by: Mick Lorain <micklorain@protonmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/quirks.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index d2dd6a6cda60..5f46fed01e6c 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1811,6 +1811,18 @@ static void quirk_alder_ioapic(struct pci_dev *pdev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_EESSC,	quirk_alder_ioapic);
 #endif
 
+static void quirk_no_msi(struct pci_dev *dev)
+{
+	pci_info(dev, "avoiding MSI to work around a hardware defect\n");
+	dev->no_msi = 1;
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x4386, quirk_no_msi);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x4387, quirk_no_msi);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x4388, quirk_no_msi);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x4389, quirk_no_msi);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x438a, quirk_no_msi);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x438b, quirk_no_msi);
+
 static void quirk_pcie_mch(struct pci_dev *pdev)
 {
 	pdev->no_msi = 1;
-- 
2.25.1


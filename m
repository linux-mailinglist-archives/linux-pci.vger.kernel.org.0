Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC44648BA5
	for <lists+linux-pci@lfdr.de>; Sat, 10 Dec 2022 01:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiLJA3a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Dec 2022 19:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiLJA33 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Dec 2022 19:29:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00C83C6CD;
        Fri,  9 Dec 2022 16:29:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8BB63B82A05;
        Sat, 10 Dec 2022 00:29:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4ECC433D2;
        Sat, 10 Dec 2022 00:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670632166;
        bh=hW1DqHTzOHvlgcWc3MSYFJfu4vFFxRHBy5gbBcigwQE=;
        h=From:To:Cc:Subject:Date:From;
        b=F8iE/C4c3p1jNJdbKQPIRo7M84dtAKyFcN8Swz4cJx9alJcr3PvZLke13XuvGqobV
         gSyue/tqCV+SZgvbWx2PD+Ah/xlsDqemjR1hL1kDczt4AT1nHX3WVoKgWQlKrMhSFs
         ++fr6bJVCgVE6Gc0KeIDr3y5WyfkOQT7WcnpIZq3rwH5zLaL00S0j6WJ95GlmnSghr
         WEeaEmxmFtZ8UzMloY7SsT6kASsJkWDv9Q6c6llWLwiwFh30CwlJMoLVO8nF9Qwm2I
         l7aOuCjluG+MStw6egAcSSiEUiNKlb+75qmd4AaqpZYuVlLae75iYRB0+1xZiR25vN
         QHb/toRwq1IyQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3] PCI/portdrv: Allow AER service only for Root Ports & RCECs
Date:   Fri,  9 Dec 2022 18:29:22 -0600
Message-Id: <20221210002922.1749403-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Previously portdrv allowed the AER service for any device with an AER
capability (assuming Linux had control of AER) even though the AER service
driver only attaches to Root Port and RCECs.

Because get_port_device_capability() included AER for non-RP, non-RCEC
devices, we tried to initialize the AER IRQ even though these devices
don't generate AER interrupts.

Intel DG1 and DG2 discrete graphics cards contain a switch leading to a
GPU.  The switch supports AER but not MSI, so initializing an AER IRQ
failed, and portdrv failed to claim the switch port at all.  The GPU itself
could be suspended, but the switch could not be put in a low-power state
because it had no driver.

Don't allow the AER service on non-Root Port, non-Root Complex Event
Collector devices.  This means we won't enable Bus Mastering if the device
doesn't require MSI, the AER service will not appear in sysfs, and the AER
service driver will not bind to the device.

Link: https://lore.kernel.org/r/20221207084105.84947-1-mika.westerberg@linux.intel.com
Based-on-patch-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---

This is a v3 based on Mika's patch at
https://lore.kernel.org/r/20221207084105.84947-1-mika.westerberg@linux.intel.com

I wouldn't normally kibbitz like this, but I'm hoping to squeeze this into
the v6.2 merge window.

Changes from v2:

  * Test the device type in get_port_device_capability() instead of
    pcie_init_service_irqs().  The benefits are to keep the device type
    checking together (this is similar to the PME test), avoid enabling Bus
    Mastering unnecessarily, avoid exposing the portdrv AER service in
    sysfs, and preventing the AER service driver from binding to devices it
    doesn't need to.

 drivers/pci/pcie/portdrv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index a6c4225505d5..8b16e96ec15c 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -232,7 +232,9 @@ static int get_port_device_capability(struct pci_dev *dev)
 	}
 
 #ifdef CONFIG_PCIEAER
-	if (dev->aer_cap && pci_aer_available() &&
+	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
+             pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
+	    dev->aer_cap && pci_aer_available() &&
 	    (pcie_ports_native || host->native_aer))
 		services |= PCIE_PORT_SERVICE_AER;
 #endif
-- 
2.25.1


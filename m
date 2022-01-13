Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5EDB48D6BC
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jan 2022 12:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbiAMLgN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jan 2022 06:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiAMLgN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jan 2022 06:36:13 -0500
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [IPv6:2001:67c:2050:1::465:107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2490CC06173F
        for <linux-pci@vger.kernel.org>; Thu, 13 Jan 2022 03:36:13 -0800 (PST)
Received: from smtp2.mailbox.org (unknown [91.198.250.124])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4JZMnl2H2MzQlJP;
        Thu, 13 Jan 2022 12:36:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
From:   Stefan Roese <sr@denx.de>
To:     linux-pci@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Yao Hongbo <yaohongbo@linux.alibaba.com>,
        Naveen Naidu <naveennaidu479@gmail.com>
Subject: [PATCH] PCI/portdrv: Don't disable AER reporting in get_port_device_capability()
Date:   Thu, 13 Jan 2022 12:36:04 +0100
Message-Id: <20220113113604.1652425-1-sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Testing has shown, that AER reporting is currently disabled in the
DevCtl registers of all non Root Port PCIe devices on systems using
pcie_ports_native || host->native_aer. Practically disabling AER
completely in such systems. This is due to the fact that with commit
2bd50dd800b5 ("PCI: PCIe: Disable PCIe port services during port
initialization"), a call to pci_disable_pcie_error_reporting() was
added *after* the PCIe AER setup was completed for the PCIe device
tree.

This patch now removes this call to pci_disable_pcie_error_reporting()
from get_port_device_capability(), leaving the already enabled AER
configuration intact. With this change, I'm able to fully use the
Kernel AER infrastructure on a ZynqMP system which has a PCIe switch
connected to the host CPU PCIe Root Port.

Fixes: 2bd50dd800b5 ("PCI: PCIe: Disable PCIe port services during port initialization")
Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Bjorn Helgaas <helgaas@kernel.org>
Cc: Pali Rohár <pali@kernel.org>
Cc: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: Yao Hongbo <yaohongbo@linux.alibaba.com>
Cc: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/pcie/portdrv_core.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 4dab74ff4368..48f5e67709f7 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -244,15 +244,8 @@ static int get_port_device_capability(struct pci_dev *dev)
 
 #ifdef CONFIG_PCIEAER
 	if (dev->aer_cap && pci_aer_available() &&
-	    (pcie_ports_native || host->native_aer)) {
+	    (pcie_ports_native || host->native_aer))
 		services |= PCIE_PORT_SERVICE_AER;
-
-		/*
-		 * Disable AER on this port in case it's been enabled by the
-		 * BIOS (the AER service driver will enable it when necessary).
-		 */
-		pci_disable_pcie_error_reporting(dev);
-	}
 #endif
 
 	/* Root Ports and Root Complex Event Collectors may generate PMEs */
-- 
2.34.1


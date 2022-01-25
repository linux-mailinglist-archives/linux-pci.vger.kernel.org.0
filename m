Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A17E249AE59
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jan 2022 09:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379386AbiAYIrn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jan 2022 03:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1451860AbiAYIn4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jan 2022 03:43:56 -0500
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [IPv6:2001:67c:2050:1::465:107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D802C06B5AF
        for <linux-pci@vger.kernel.org>; Mon, 24 Jan 2022 23:18:29 -0800 (PST)
Received: from smtp202.mailbox.org (unknown [91.198.250.118])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4JjdVq3zN0z9smG;
        Tue, 25 Jan 2022 08:18:27 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
From:   Stefan Roese <sr@denx.de>
To:     linux-pci@vger.kernel.org
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Yao Hongbo <yaohongbo@linux.alibaba.com>,
        Naveen Naidu <naveennaidu479@gmail.com>
Subject: [PATCH v4 2/3] PCI/portdrv: Don't disable AER reporting in get_port_device_capability()
Date:   Tue, 25 Jan 2022 08:18:19 +0100
Message-Id: <20220125071820.2247260-3-sr@denx.de>
In-Reply-To: <20220125071820.2247260-1-sr@denx.de>
References: <20220125071820.2247260-1-sr@denx.de>
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

Here a longer analysis about the currect status of AER enaling /
disabling upon bootup provided by Bjorn:

  pcie_portdrv_probe
    pcie_port_device_register
      get_port_device_capability
        pci_disable_pcie_error_reporting
          clear CERE NFERE FERE URRE               # <-- disable for RP USP DSP
      pcie_device_init
        device_register                            # new AER service device
          aer_probe
            aer_enable_rootport                    # RP only
              set_downstream_devices_error_reporting
                set_device_error_reporting         # self (RP)
                  if (RP || USP || DSP)
                    pci_enable_pcie_error_reporting
                      set CERE NFERE FERE URRE     # <-- enable for RP
                pci_walk_bus
                  set_device_error_reporting
                    if (RP || USP || DSP)
                      pci_enable_pcie_error_reporting
                        set CERE NFERE FERE URRE   # <-- enable for USP DSP

In a typical Root Port -> Endpoint hierarchy, the above:
  - Disables Error Reporting for the Root Port,
  - Enables Error Reporting for the Root Port,
  - Does NOT enable Error Reporting for the Endpoint because it is not
    a Root Port or Switch Port.

In a deeper Root Port -> Upstream Switch Port -> Downstream Switch
Port -> Endpoint hierarchy:
  - Disables Error Reporting for the Root Port,
  - Enables Error Reporting for the Root Port,
  - Enables Error Reporting for both Switch Ports,
  - Does NOT enable Error Reporting for the Endpoint because it is not
    a Root Port or Switch Port,
  - Disables Error Reporting for the Switch Ports when
    pcie_portdrv_probe() claims them.  AER does not re-enable it
    because these are not Root Ports.

This patch now removes this call to pci_disable_pcie_error_reporting()
from get_port_device_capability(), leaving the already enabled AER
configuration intact. With this change, AER is enabled in the Root Port
and the PCIe switch upstream and downstream ports. Only the PCIe
Endpoints don't have AER enabled yet. A follow-up patch will take
care of this Endpoint enabling.

Fixes: 2bd50dd800b5 ("PCI: PCIe: Disable PCIe port services during port initialization")
Signed-off-by: Stefan Roese <sr@denx.de>
Reviewed-by: Pali Rohár <pali@kernel.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Bjorn Helgaas <helgaas@kernel.org>
Cc: Pali Rohár <pali@kernel.org>
Cc: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: Yao Hongbo <yaohongbo@linux.alibaba.com>
Cc: Naveen Naidu <naveennaidu479@gmail.com>
---
v4:
- No change

v3:
- Added RB tag from Pali

v2:
- Enhance commit message as suggested by Bjorn

 drivers/pci/pcie/portdrv_core.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index f81c7be4d7d8..27b990cedb4c 100644
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
2.35.0


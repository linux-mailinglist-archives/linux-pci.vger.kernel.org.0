Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9876C1B18F5
	for <lists+linux-pci@lfdr.de>; Tue, 21 Apr 2020 00:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbgDTWBQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Apr 2020 18:01:16 -0400
Received: from mga02.intel.com ([134.134.136.20]:16270 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbgDTWBM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 20 Apr 2020 18:01:12 -0400
IronPort-SDR: NcL4+SkEHL/QSArFK4VXYoLYWEvMyGptOjbs3d3ih755ENT1GUXVLmWWAHJoCpKNvxxIub7Q/a
 Kwf/vWuau0tg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 15:01:12 -0700
IronPort-SDR: NaBAspYZuGnSTQEfEZz9R/EbojjS+9L7WFqbqEMeVWAABLhwoBVpCJ/CdN5nfrfXocev3M49EF
 hB6ewiUK3MTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,407,1580803200"; 
   d="scan'208";a="455848368"
Received: from unknown (HELO nsgsw-wilsonpoint.lm.intel.com) ([10.232.116.102])
  by fmsmga005.fm.intel.com with ESMTP; 20 Apr 2020 15:01:10 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     <linux-pci@vger.kernel.org>, Keith Busch <kbusch@kernel.org>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Frederick Lawler <fred@fredlawl.com>,
        Rajat Jain <rajatja@google.com>,
        "Patel, Mayurkumar" <mayurkumar.patel@intel.com>,
        Olof Johansson <olof@lixom.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] PCI/DPC: Allow Native DPC Host Bridges to use DPC
Date:   Mon, 20 Apr 2020 15:37:10 -0600
Message-Id: <1587418630-13562-3-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1587418630-13562-1-git-send-email-jonathan.derrick@intel.com>
References: <1587418630-13562-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The existing portdrv model prevents DPC services without either OS
control (_OSC) granted to AER services, a Host Bridge requesting Native
AER, or using one of the 'pcie_ports=' parameters of 'native' or
'dpc-native'.

The DPC port service driver itself will also fail to probe if the kernel
assumes the port is using Firmware-First AER. It's a reasonable
expectation that a port using Firmware-First AER will also be using
Firmware-First DPC, however if a Host Bridge requests Native DPC, the
DPC driver should allow it and not fail to bind due to AER capability
settings.

Host Bridges which request Native DPC port services will also likely
request Native AER, however it shouldn't be a requirement. This patch
allows ports on those Host Bridges to have DPC port services.

This will avoid the unlikely situation where the port is Firmware-First
AER and Native DPC, and a BIOS or switch firmware preconfiguration of
the DPC trigger could result in unhandled DPC events.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/pcie/dpc.c          | 3 ++-
 drivers/pci/pcie/portdrv_core.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 7621704..3f3106f 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -284,7 +284,8 @@ static int dpc_probe(struct pcie_device *dev)
 	int status;
 	u16 ctl, cap;
 
-	if (pcie_aer_get_firmware_first(pdev) && !pcie_ports_dpc_native)
+	if (pcie_aer_get_firmware_first(pdev) && !pcie_ports_dpc_native &&
+	    !pci_find_host_bridge(pdev->bus)->native_dpc)
 		return -ENOTSUPP;
 
 	status = devm_request_threaded_irq(device, dev->irq, dpc_irq,
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 50a9522..f2139a1 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -256,7 +256,8 @@ static int get_port_device_capability(struct pci_dev *dev)
 	 */
 	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
 	    pci_aer_available() &&
-	    (pcie_ports_dpc_native || (services & PCIE_PORT_SERVICE_AER)))
+	    (pcie_ports_dpc_native || host->native_dpc ||
+	     (services & PCIE_PORT_SERVICE_AER)))
 		services |= PCIE_PORT_SERVICE_DPC;
 
 	if (pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
-- 
1.8.3.1


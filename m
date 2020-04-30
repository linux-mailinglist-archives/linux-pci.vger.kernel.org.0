Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A7D1C0579
	for <lists+linux-pci@lfdr.de>; Thu, 30 Apr 2020 20:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgD3S7q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Apr 2020 14:59:46 -0400
Received: from mga12.intel.com ([192.55.52.136]:41232 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbgD3S7n (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Apr 2020 14:59:43 -0400
IronPort-SDR: f+JVJqGl3CccVGCz6TnxUKiX9jkkPek5dmsOHS7i8+O8L0m8kNh/P55zfvTEu6KUqUS56hjDaK
 aumrb+Qhet5g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2020 11:59:40 -0700
IronPort-SDR: xIousQdCakj5qzDffySPNPf1vENkrFZqPZ4ULQbIhtimZt+hZabOaIuFeH/zX6RrqwAJhcgQvi
 4WAg5L+SjLQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,336,1583222400"; 
   d="scan'208";a="303360012"
Received: from unknown (HELO nsgsw-wilsonpoint.lm.intel.com) ([10.232.116.102])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Apr 2020 11:59:39 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     <linux-pci@vger.kernel.org>,
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
Subject: [PATCH v3 2/2] PCI/DPC: Use _OSC to determine DPC support
Date:   Thu, 30 Apr 2020 12:46:09 -0600
Message-Id: <1588272369-2145-3-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588272369-2145-1-git-send-email-jonathan.derrick@intel.com>
References: <1588272369-2145-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

After a5bf8719af: "PCI/AER: Use only _OSC to determine AER ownership",
_OSC is the primary determiner of ownership of Firmware First error
handling rather than HEST.

With the addition of DPC to _OSC [1], OSPM is able to negotiate DPC
services from Firmware. ACPI Root Bus enumeration sets the Host Bridge's
Native DPC flag on negotiation of those service. This patch changes DPC
probing to check DPC control as determined by _OSC, by checking the Host
Bridge's Native DPC member.

As most older platforms won't have DPC negotiable by _OSC, this patch
doesn't attempt to change behavior that assumes if OSPM has negotiated
AER by _OSC, OSPM will also want DPC control.

[1] https://members.pcisig.com/wg/PCI-SIG/document/12888

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/pcie/dpc.c          | 3 ---
 drivers/pci/pcie/portdrv_core.c | 3 ++-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 7621704..9104929 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -284,9 +284,6 @@ static int dpc_probe(struct pcie_device *dev)
 	int status;
 	u16 ctl, cap;
 
-	if (pcie_aer_get_firmware_first(pdev) && !pcie_ports_dpc_native)
-		return -ENOTSUPP;
-
 	status = devm_request_threaded_irq(device, dev->irq, dpc_irq,
 					   dpc_handler, IRQF_SHARED,
 					   "pcie-dpc", pdev);
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


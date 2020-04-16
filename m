Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 544E31AD0E3
	for <lists+linux-pci@lfdr.de>; Thu, 16 Apr 2020 22:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgDPUMk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Apr 2020 16:12:40 -0400
Received: from mga02.intel.com ([134.134.136.20]:9825 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbgDPUMj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Apr 2020 16:12:39 -0400
IronPort-SDR: 6ZMKpcZC414a1BKAgO2Y1kEStRKkdheTB2pyluIjuy9/Wsq9vIwO4HtZd80EqTDcrcCQbwLyuP
 3rotnZAB3NGQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 13:12:39 -0700
IronPort-SDR: r7Og5Oq2XCEbwNdn2DsqVN0NlTMRI+7z5XW0KToc2Tr/tmkoUXOe5tkG+DfeBCdZdzt5gajFsu
 V5/GechOGFhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,392,1580803200"; 
   d="scan'208";a="257345226"
Received: from unknown (HELO nsgsw-wilsonpoint.lm.intel.com) ([10.232.116.102])
  by orsmga006.jf.intel.com with ESMTP; 16 Apr 2020 13:12:38 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jon Derrick <jonathan.derrick@intel.com>,
        Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Olof Johansson <olof@lixom.net>,
        Keith Busch <keith.busch@intel.com>,
        Frederick Lawler <fred@fredlawl.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI/DPC: Allow Non-ACPI Native ports to use DPC
Date:   Thu, 16 Apr 2020 13:59:15 -0600
Message-Id: <1587067157-2291-1-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some platforms have a mix of ports whose capabilities can be negotiated
by _OSC, and some ports which are not described by ACPI and instead
managed by Native drivers. The existing Firmware-First HEST model can
incorrectly tag these Native, Non-ACPI ports as Firmware-First capable
ports by advertising the HEST Global flag and specifying the type and
class (aer_hest_parse).

This ultimately can lead to bad situations if the BIOS or port firmware
leaves DPC preconfigured and the Linux DPC driver is unable to bind to
the port to handle DPC events.

This patch adds the check for Native DPC in the port's host bridge in
order to allow DPC services to bind to the port.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/pcie/dpc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 7621704..a1e355d 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -281,10 +281,12 @@ static int dpc_probe(struct pcie_device *dev)
 {
 	struct pci_dev *pdev = dev->port;
 	struct device *device = &dev->device;
+	struct pci_host_bridge *host = pci_find_host_bridge(pdev->bus);
 	int status;
 	u16 ctl, cap;
 
-	if (pcie_aer_get_firmware_first(pdev) && !pcie_ports_dpc_native)
+	if (pcie_aer_get_firmware_first(pdev) && !pcie_ports_dpc_native &&
+	    !host->native_dpc)
 		return -ENOTSUPP;
 
 	status = devm_request_threaded_irq(device, dev->irq, dpc_irq,
-- 
1.8.3.1


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22B0D1B18F4
	for <lists+linux-pci@lfdr.de>; Tue, 21 Apr 2020 00:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbgDTWBN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Apr 2020 18:01:13 -0400
Received: from mga02.intel.com ([134.134.136.20]:16270 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgDTWBL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 20 Apr 2020 18:01:11 -0400
IronPort-SDR: ZOwC7V/bHnN92J1YgDnKPOCU0m2i9cZkK+Q/t0oDjCLkewrNRcpRQg/PuEZJuWY7R8znFt+cDY
 t5Tj7bSdKALQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 15:01:11 -0700
IronPort-SDR: B5K5EbZN/GSr4XUuymvuYRrd7HCa5RqMAPti5a6kXncsbreRaatYMRh8I0XZNELFVQPRkBhfRk
 7rLmNZUQ5B5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,407,1580803200"; 
   d="scan'208";a="455848343"
Received: from unknown (HELO nsgsw-wilsonpoint.lm.intel.com) ([10.232.116.102])
  by fmsmga005.fm.intel.com with ESMTP; 20 Apr 2020 15:01:09 -0700
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
Subject: [PATCH v2 1/2] PCI/AER: Allow Native AER Host Bridges to use AER
Date:   Mon, 20 Apr 2020 15:37:09 -0600
Message-Id: <1587418630-13562-2-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1587418630-13562-1-git-send-email-jonathan.derrick@intel.com>
References: <1587418630-13562-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some platforms have a mix of ports whose capabilities can be negotiated
by _OSC, and some ports which are not described by ACPI and instead
managed by Native drivers. The existing Firmware-First HEST model can
incorrectly tag these Native, Non-ACPI ports as Firmware-First managed
ports by advertising the HEST Global Flag and matching the type and
class of the port (aer_hest_parse).

If the port requests Native AER through the Host Bridge's capability
settings, the AER driver should honor those settings and allow the port
to bind. This patch changes the definition of Firmware-First to exclude
ports whose Host Bridges request Native AER.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/pcie/aer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index f4274d3..30fbd1f 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -314,6 +314,9 @@ int pcie_aer_get_firmware_first(struct pci_dev *dev)
 	if (pcie_ports_native)
 		return 0;
 
+	if (pci_find_host_bridge(dev->bus)->native_aer)
+		return 0;
+
 	if (!dev->__aer_firmware_first_valid)
 		aer_set_firmware_first(dev);
 	return dev->__aer_firmware_first;
-- 
1.8.3.1


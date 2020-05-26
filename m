Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E080E1E3393
	for <lists+linux-pci@lfdr.de>; Wed, 27 May 2020 01:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390481AbgEZXSq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 May 2020 19:18:46 -0400
Received: from mga02.intel.com ([134.134.136.20]:56936 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389971AbgEZXSn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 May 2020 19:18:43 -0400
IronPort-SDR: w4+hfCeKI2n2LRCjMmVdCLFVgQ2PnRYKE9pgl9hWwgYwriYJcI9dTzB8/D8v+1vFRHlnz1vqGO
 Na69BJ45xXNA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2020 16:18:43 -0700
IronPort-SDR: sGE4RSjPhO/OScXkA5AOzoo4Rsqmpb3GQXMS2gyDavRHu6/lpx+gNA0YTOw7Htg2W7X8r6l6n6
 ghITOqgGr6ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,439,1583222400"; 
   d="scan'208";a="291378687"
Received: from zalvear-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.254.67.58])
  by fmsmga004.fm.intel.com with ESMTP; 26 May 2020 16:18:42 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v4 3/5] ACPI/PCI: Ignore _OSC negotiation result if pcie_ports_native is set.
Date:   Tue, 26 May 2020 16:18:27 -0700
Message-Id: <969d4f083f445532bd1cdd98e3ce110574a461b0.1590534843.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1590534843.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1590534843.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

pcie_ports_native is set only if user requests native handling
of PCIe capabilities via pcie_port_setup command line option.
User input takes precedence over _OSC based control negotiation
result. So consider the _OSC negotiated result only if
pcie_ports_native is unset.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/acpi/pci_root.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 9e235c1a75ff..e0039ad3480a 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -914,18 +914,20 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 		goto out_release_info;
 
 	host_bridge = to_pci_host_bridge(bus->bridge);
-	if (!(root->osc_control_set & OSC_PCI_EXPRESS_NATIVE_HP_CONTROL))
-		host_bridge->native_pcie_hotplug = 0;
-	if (!(root->osc_control_set & OSC_PCI_SHPC_NATIVE_HP_CONTROL))
-		host_bridge->native_shpc_hotplug = 0;
-	if (!(root->osc_control_set & OSC_PCI_EXPRESS_AER_CONTROL))
-		host_bridge->native_aer = 0;
-	if (!(root->osc_control_set & OSC_PCI_EXPRESS_PME_CONTROL))
-		host_bridge->native_pme = 0;
-	if (!(root->osc_control_set & OSC_PCI_EXPRESS_LTR_CONTROL))
-		host_bridge->native_ltr = 0;
-	if (!(root->osc_control_set & OSC_PCI_EXPRESS_DPC_CONTROL))
-		host_bridge->native_dpc = 0;
+	if (!pcie_ports_native) {
+		if (!(root->osc_control_set & OSC_PCI_EXPRESS_NATIVE_HP_CONTROL))
+			host_bridge->native_pcie_hotplug = 0;
+		if (!(root->osc_control_set & OSC_PCI_SHPC_NATIVE_HP_CONTROL))
+			host_bridge->native_shpc_hotplug = 0;
+		if (!(root->osc_control_set & OSC_PCI_EXPRESS_AER_CONTROL))
+			host_bridge->native_aer = 0;
+		if (!(root->osc_control_set & OSC_PCI_EXPRESS_PME_CONTROL))
+			host_bridge->native_pme = 0;
+		if (!(root->osc_control_set & OSC_PCI_EXPRESS_LTR_CONTROL))
+			host_bridge->native_ltr = 0;
+		if (!(root->osc_control_set & OSC_PCI_EXPRESS_DPC_CONTROL))
+			host_bridge->native_dpc = 0;
+	}
 
 	/*
 	 * Evaluate the "PCI Boot Configuration" _DSM Function.  If it
-- 
2.17.1


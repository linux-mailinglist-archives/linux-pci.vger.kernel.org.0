Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 656581E3394
	for <lists+linux-pci@lfdr.de>; Wed, 27 May 2020 01:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390302AbgEZXSq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 May 2020 19:18:46 -0400
Received: from mga02.intel.com ([134.134.136.20]:56937 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389991AbgEZXSn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 May 2020 19:18:43 -0400
IronPort-SDR: xhNlXPNh4LPQs8+ZtkzzrlygKhNdW9UoV7u8+3xYFn8vfnWXTA7Rg036nmubmun2jQgoDz+42X
 Fg/65c0OWbBw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2020 16:18:43 -0700
IronPort-SDR: HF/yELcmakY37m+rXtJFzD4v6oXssZ0ZO67tsEiynzy8aWy2L5wkPRjCXR7bEKpMK/25DIhOMw
 Gr8P++MF+eoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,439,1583222400"; 
   d="scan'208";a="291378691"
Received: from zalvear-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.254.67.58])
  by fmsmga004.fm.intel.com with ESMTP; 26 May 2020 16:18:43 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v4 4/5] ACPI/PCI: Ignore _OSC DPC negotiation result if pcie_ports_dpc_native is set.
Date:   Tue, 26 May 2020 16:18:28 -0700
Message-Id: <7b283734fd6ff7c7a59f5b4afbf416589f0a4f82.1590534843.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1590534843.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1590534843.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

pcie_ports_dpc_native is set only if user requests native handling
of PCIe DPC capability via pcie_port_setup command line option.
User input takes precedence over _OSC based control negotiation
result. So consider the _OSC negotiated result for DPC ownership
only if pcie_ports_dpc_native is unset.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/acpi/pci_root.c    | 2 ++
 drivers/pci/pcie/portdrv.h | 2 --
 include/linux/pci.h        | 2 ++
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index e0039ad3480a..f90dba464ec2 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -925,6 +925,8 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 			host_bridge->native_pme = 0;
 		if (!(root->osc_control_set & OSC_PCI_EXPRESS_LTR_CONTROL))
 			host_bridge->native_ltr = 0;
+	}
+	if (!pcie_ports_native && !pcie_ports_dpc_native) {
 		if (!(root->osc_control_set & OSC_PCI_EXPRESS_DPC_CONTROL))
 			host_bridge->native_dpc = 0;
 	}
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index 64b5e081cdb2..e4999f24ad92 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -25,8 +25,6 @@
 
 #define PCIE_PORT_DEVICE_MAXSERVICES   5
 
-extern bool pcie_ports_dpc_native;
-
 #ifdef CONFIG_PCIEAER
 int pcie_aer_init(void);
 #else
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 83ce1cdf5676..07d4db97f5f4 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1547,9 +1547,11 @@ static inline int pci_irqd_intx_xlate(struct irq_domain *d,
 #ifdef CONFIG_PCIEPORTBUS
 extern bool pcie_ports_disabled;
 extern bool pcie_ports_native;
+extern bool pcie_ports_dpc_native;
 #else
 #define pcie_ports_disabled	true
 #define pcie_ports_native	false
+#define pcie_ports_dpc_native	false
 #endif
 
 #define PCIE_LINK_STATE_L0S		BIT(0)
-- 
2.17.1


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA481E032F
	for <lists+linux-pci@lfdr.de>; Sun, 24 May 2020 23:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387970AbgEXVct (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 24 May 2020 17:32:49 -0400
Received: from mga02.intel.com ([134.134.136.20]:9322 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388366AbgEXVci (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 24 May 2020 17:32:38 -0400
IronPort-SDR: TA5rq53X6IAkvOdUQLjlGMOShdR4O3ShWe+/UNulPTGR2ZfuLJZ4mtPvfxSqPH9mmll4hoqsxu
 /s5IYrwn/yHg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2020 14:32:38 -0700
IronPort-SDR: nbtipfaB6XTYrlwV5jNTOOCxoKi2kDM6Bu7GMicDDJVzFaVx8Ea2KNhBUbaIfrxEKQ5/zsf1Bk
 1TUdzCirlWxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,431,1583222400"; 
   d="scan'208";a="467875404"
Received: from tjrondo-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.251.20.235])
  by fmsmga006.fm.intel.com with ESMTP; 24 May 2020 14:32:37 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v3 4/5] ACPI/PCI: Ignore _OSC DPC negotiation result if pcie_ports_dpc_native is set.
Date:   Sun, 24 May 2020 14:32:33 -0700
Message-Id: <d458d4f4e7db645af6c00e10f4c3f517aa4d4209.1590355824.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1590355824.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1590355824.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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
 drivers/acpi/pci_root.c | 2 ++
 include/linux/pci.h     | 2 ++
 2 files changed, 4 insertions(+)

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


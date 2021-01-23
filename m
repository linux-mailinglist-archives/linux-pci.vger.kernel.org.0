Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 057FB3011E6
	for <lists+linux-pci@lfdr.de>; Sat, 23 Jan 2021 02:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbhAWBPP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Jan 2021 20:15:15 -0500
Received: from mga04.intel.com ([192.55.52.120]:26962 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbhAWBPD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Jan 2021 20:15:03 -0500
IronPort-SDR: JoP23lSQdWTqlM+9hMC+QxnFSew9SMqO2Jk5IjxtrjLvyL9FyhnnDkvW4a9sDON3zIzAFvFjTu
 mEnO9t4WVdHg==
X-IronPort-AV: E=McAfee;i="6000,8403,9872"; a="176962180"
X-IronPort-AV: E=Sophos;i="5.79,368,1602572400"; 
   d="scan'208";a="176962180"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 17:11:21 -0800
IronPort-SDR: AkKQ+ylDEuVf0i74UmVvl2w0wyYdRVUEowftbRYcFvjXNfPvGrDDfqRtxMWcf4Dd9priEb8a6V
 i3kD7cXJ+riw==
X-IronPort-AV: E=Sophos;i="5.79,368,1602572400"; 
   d="scan'208";a="386084690"
Received: from usundar-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.36.142])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 17:11:21 -0800
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v13 3/5] PCI/ACPI: Tidy _OSC control bit checking
Date:   Fri, 22 Jan 2021 17:11:11 -0800
Message-Id: <5c08e4433ec142f3b9dba1279edf15f31b2f9181.1611364025.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1611364024.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1611364024.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add OSC_OWNER() helper to prettify checking the _OSC control bits to learn
whether the platform has granted us control of PCI features.  No functional
change intended.

[bhelgaas: split to separate patch, commit log]
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/acpi/pci_root.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 0bf072cef6cf..601fbe905993 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -874,6 +874,12 @@ static void acpi_pci_root_release_info(struct pci_host_bridge *bridge)
 	__acpi_pci_root_release_info(bridge->release_data);
 }
 
+#define OSC_OWNER(ctrl, bit, flag)	\
+	do {				\
+		if (!(ctrl & bit))	\
+			flag = 0;	\
+	} while (0)
+
 struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 				     struct acpi_pci_root_ops *ops,
 				     struct acpi_pci_root_info *info,
@@ -885,6 +891,7 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 	struct pci_bus *bus;
 	struct pci_host_bridge *host_bridge;
 	union acpi_object *obj;
+	u32 ctrl;
 
 	info->root = root;
 	info->bridge = device;
@@ -910,18 +917,16 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
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
+
+	ctrl = root->osc_control_set;
+	OSC_OWNER(ctrl, OSC_PCI_EXPRESS_NATIVE_HP_CONTROL,
+		  host_bridge->native_pcie_hotplug);
+	OSC_OWNER(ctrl, OSC_PCI_SHPC_NATIVE_HP_CONTROL,
+		  host_bridge->native_shpc_hotplug);
+	OSC_OWNER(ctrl, OSC_PCI_EXPRESS_AER_CONTROL, host_bridge->native_aer);
+	OSC_OWNER(ctrl, OSC_PCI_EXPRESS_PME_CONTROL, host_bridge->native_pme);
+	OSC_OWNER(ctrl, OSC_PCI_EXPRESS_LTR_CONTROL, host_bridge->native_ltr);
+	OSC_OWNER(ctrl, OSC_PCI_EXPRESS_DPC_CONTROL, host_bridge->native_dpc);
 
 	/*
 	 * Evaluate the "PCI Boot Configuration" _DSM Function.  If it
-- 
2.25.1


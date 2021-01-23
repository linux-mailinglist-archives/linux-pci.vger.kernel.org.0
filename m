Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C57423011E4
	for <lists+linux-pci@lfdr.de>; Sat, 23 Jan 2021 02:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbhAWBOi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Jan 2021 20:14:38 -0500
Received: from mga04.intel.com ([192.55.52.120]:26863 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbhAWBOh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Jan 2021 20:14:37 -0500
IronPort-SDR: M3bJx8jdn3uKaaIBlt6J6fofktA9EYxgAIKiSm3Enwl09pBPTDz+af0R770vZ3bvoI1bdjKqe5
 376w942t/oCQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9872"; a="176962182"
X-IronPort-AV: E=Sophos;i="5.79,368,1602572400"; 
   d="scan'208";a="176962182"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 17:11:23 -0800
IronPort-SDR: vHq+tV2FCqA9buX0G4W7+Ddrnb2VhIoxkQPPxvBVwHBMLkerxcWhQnbDo0U0LiLcX3q+J3F5vZ
 /Fw4wQ2j9pzA==
X-IronPort-AV: E=Sophos;i="5.79,368,1602572400"; 
   d="scan'208";a="386084704"
Received: from usundar-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.36.142])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 17:11:22 -0800
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v13 5/5] PCI/ACPI: Centralize pci_aer_available() checking
Date:   Fri, 22 Jan 2021 17:11:13 -0800
Message-Id: <8a9580c420e6e8f0a863a20c80fcbf2107cb0c0f.1611364025.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1611364024.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1611364024.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Check pci_aer_available() in acpi_pci_root_create() when we're interpreting
_OSC results so host_bridge->native_aer becomes the single way to determine
whether we control AER capabilities.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/acpi/pci_root.c         | 3 +++
 drivers/pci/pcie/portdrv_core.c | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 16ca58d58fef..f7d2eed3975c 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -939,6 +939,9 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 		host_bridge->native_dpc = 1;
 	}
 
+	if (!pci_aer_available())
+		host_bridge->native_aer = 0;
+
 	dev_info(&root->device->dev, "OS native features: SHPCHotplug%c PCIeHotplug%c PME%c AER%c DPC%c LTR%c\n",
 		FLAG(host_bridge->native_shpc_hotplug),
 		FLAG(host_bridge->native_pcie_hotplug),
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index ea1099908d5d..a2b8a4bc91fa 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -220,7 +220,7 @@ static int get_port_device_capability(struct pci_dev *dev)
 	}
 
 #ifdef CONFIG_PCIEAER
-	if (host->native_aer && dev->aer_cap && pci_aer_available()) {
+	if (host->native_aer && dev->aer_cap) {
 		services |= PCIE_PORT_SERVICE_AER;
 
 		/*
-- 
2.25.1


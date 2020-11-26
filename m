Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE09D2C4C8D
	for <lists+linux-pci@lfdr.de>; Thu, 26 Nov 2020 02:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731403AbgKZBSm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Nov 2020 20:18:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:39078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729679AbgKZBSl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Nov 2020 20:18:41 -0500
Received: from localhost (129.sub-72-107-112.myvzw.com [72.107.112.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAEF1206C0;
        Thu, 26 Nov 2020 01:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606353521;
        bh=fog10W20ZnIu55AcNV7BiDI5Wh8kOel1mDnmrzT6wIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xaAJkYKYC6amA26QUYRADxqBXArBDibtJAKAbIoQ6txu7BH8K38JeLpuW5xo8SLh9
         9ZbqTSMX9KaCstt58b3jI1R4Lyj1RBuFjk1dJ3qsaTeLFwe9JwHDrsDfgRWnA7ISUq
         AyhvbKB/54XbkZ2wlKNKfQ9awAq6Kw8JwQVWuREA=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     ashok.raj@intel.com, knsathya@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 5/5] PCI/ACPI: Centralize pci_aer_available() checking
Date:   Wed, 25 Nov 2020 19:18:16 -0600
Message-Id: <20201126011816.711106-6-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126011816.711106-1-helgaas@kernel.org>
References: <20201126011816.711106-1-helgaas@kernel.org>
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
index 36142ed7b8f8..f9969b86d3b6 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -941,6 +941,9 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 		host_bridge->native_dpc = 1;
 	}
 
+	if (!pci_aer_available())
+		host_bridge->native_aer = 0;
+
 	dev_info(&root->device->dev, "OS native features: SHPCHotplug%c PCIeHotplug%c PME%c AER%c DPC%c LTR%c\n",
 		FLAG(host_bridge->native_shpc_hotplug),
 		FLAG(host_bridge->native_pcie_hotplug),
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 2a1190e8db60..48c14c2471ef 100644
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


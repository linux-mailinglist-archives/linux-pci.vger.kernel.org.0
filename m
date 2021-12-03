Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C8946709C
	for <lists+linux-pci@lfdr.de>; Fri,  3 Dec 2021 04:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbhLCDTz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Dec 2021 22:19:55 -0500
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:35626
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231585AbhLCDTy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Dec 2021 22:19:54 -0500
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 820B54007C;
        Fri,  3 Dec 2021 03:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638501390;
        bh=Ugxulh7BMZxGlTFeVZ7SV3BB1ydn8nF9gDW7rGrY2pk=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=KTZyLMv3nhUmRJc84SPrGaHoBtv+NfznQKqz/uF+2zw1tvGXHdxY+c1jbCe/n0VL4
         x0MoPpTqVRPGmc6QIuSP6bzaEVttyTF3RIWbhb4I8QVXjBLUsqgk0Vmjkv8ZSpy4gq
         RYWFFhGjwjpiaf87zxacNEGB3NpvJAFg8yurr/LHqVk6x/KbJX6bDzbY2RRV48nzTx
         25Xfx2ZswClWHlz76OsFDMv85OmSWK9d/iyTV9nV8H9FRFOFcdZ1p/C1t9/KGA0H7l
         WyB5OK+3uKyqSQ+og1MonaMC+cZ1dagDJBOcDivRJCIUnRPV9j2bpILaOZ4wKUHner
         BGlG2n1xTbaAA==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     bhelgaas@google.com
Cc:     linux-pm@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] PCI: vmd: Honor ACPI _OSC on PCIe features
Date:   Fri,  3 Dec 2021 11:15:41 +0800
Message-Id: <20211203031541.1428904-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When Samsung PCIe Gen4 NVMe is connected to Intel ADL VMD, the
combination causes AER message flood and drags the system performance
down.

The issue doesn't happen when VMD mode is disabled in BIOS, since AER
isn't enabled by acpi_pci_root_create() . When VMD mode is enabled, AER
is enabled regardless of _OSC:
[    0.410076] acpi PNP0A08:00: _OSC: platform does not support [AER]
...
[    1.486704] pcieport 10000:e0:06.0: AER: enabled with IRQ 146

Since VMD is an aperture to regular PCIe root ports, honor ACPI _OSC to
disable PCIe features accordingly to resolve the issue.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=215027
Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v3:
 - Use a new helper function.

v2:
 - Use pci_find_host_bridge() instead of open coding.

 drivers/pci/controller/vmd.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index a45e8e59d3d48..691765e6c12aa 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -661,6 +661,21 @@ static int vmd_alloc_irqs(struct vmd_dev *vmd)
 	return 0;
 }
 
+/*
+ * Since VMD is an aperture to regular PCIe root ports, only allow it to
+ * control features that the OS is allowed to control on the physical PCI bus.
+ */
+static void vmd_copy_host_bridge_flags(struct pci_host_bridge *root_bridge,
+				       struct pci_host_bridge *vmd_bridge)
+{
+	vmd_bridge->native_pcie_hotplug = root_bridge->native_pcie_hotplug;
+	vmd_bridge->native_shpc_hotplug = root_bridge->native_shpc_hotplug;
+	vmd_bridge->native_aer = root_bridge->native_aer;
+	vmd_bridge->native_pme = root_bridge->native_pme;
+	vmd_bridge->native_ltr = root_bridge->native_ltr;
+	vmd_bridge->native_dpc = root_bridge->native_dpc;
+}
+
 static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 {
 	struct pci_sysdata *sd = &vmd->sysdata;
@@ -798,6 +813,9 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 		return -ENODEV;
 	}
 
+	vmd_copy_host_bridge_flags(pci_find_host_bridge(vmd->dev->bus),
+				   to_pci_host_bridge(vmd->bus->bridge));
+
 	vmd_attach_resources(vmd);
 	if (vmd->irq_domain)
 		dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
-- 
2.32.0


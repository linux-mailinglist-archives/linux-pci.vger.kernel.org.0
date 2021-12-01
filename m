Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9E1464724
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 07:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346866AbhLAG2h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 01:28:37 -0500
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:58114
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231871AbhLAG2g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Dec 2021 01:28:36 -0500
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 4BAB03FFDF;
        Wed,  1 Dec 2021 06:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638339911;
        bh=ZuTbVzRuXq+1BXK11qhbZ9L2S3ttVt8+EAIqTiNSJ7M=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=aFyflSTQHTTxruerqZG6VEZvaphkDHFxHvaH5Qt0dXnFfDV5TRrSKSSiKNMWhVfeG
         81dnrkmodHI91oVeoJ/Gmo5paY3BV2Cu7HngFmfR/hns1uY06kyB41U5OZMBnjZdDv
         fz2lD4Ej0wOrMC2smTPsjvnVCwpTVQ3elYL/ygzCTD4zdVlQGPnLQtYhpDtdoUywGq
         +7kWyltzhyk48GwcQh7JRb62Tuv0g1SiXnvDHRG5nTufwdsnV3/Np+nsB8x7/fnWEB
         L7xLqcumvodDi98D4h4bMFaglWelfwIo/ieaqkUL/xv5vR0+bD0PF1bMiKCFMW6SVA
         3GEOWHiqKp2kQ==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     bhelgaas@google.com
Cc:     linux-pm@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: vmd: Honor ACPI _OSC on PCIe features
Date:   Wed,  1 Dec 2021 14:24:22 +0800
Message-Id: <20211201062423.1313114-1-kai.heng.feng@canonical.com>
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
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/pci/controller/vmd.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index a45e8e59d3d48..8298862417e84 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -670,7 +670,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	LIST_HEAD(resources);
 	resource_size_t offset[2] = {0};
 	resource_size_t membar2_offset = 0x2000;
-	struct pci_bus *child;
+	struct pci_bus *child, *bus;
+	struct pci_host_bridge *root_bridge, *vmd_bridge;
 	int ret;
 
 	/*
@@ -798,6 +799,21 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 		return -ENODEV;
 	}
 
+	vmd_bridge = to_pci_host_bridge(vmd->bus->bridge);
+
+	bus = vmd->dev->bus;
+	while (bus->parent)
+		bus = bus->parent;
+
+	root_bridge = to_pci_host_bridge(bus->bridge);
+
+	vmd_bridge->native_pcie_hotplug = root_bridge->native_pcie_hotplug;
+	vmd_bridge->native_shpc_hotplug = root_bridge->native_shpc_hotplug;
+	vmd_bridge->native_aer = root_bridge->native_aer;
+	vmd_bridge->native_pme = root_bridge->native_pme;
+	vmd_bridge->native_ltr = root_bridge->native_ltr;
+	vmd_bridge->native_dpc = root_bridge->native_dpc;
+
 	vmd_attach_resources(vmd);
 	if (vmd->irq_domain)
 		dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
-- 
2.32.0


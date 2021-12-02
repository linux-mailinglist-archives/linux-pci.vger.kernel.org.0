Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69712465C6C
	for <lists+linux-pci@lfdr.de>; Thu,  2 Dec 2021 04:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236142AbhLBDJD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 22:09:03 -0500
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:50420
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235861AbhLBDJA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Dec 2021 22:09:00 -0500
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 06DAD40078;
        Thu,  2 Dec 2021 03:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638414337;
        bh=Ie+b2r1u5uIazpBAlpisU1cFz7IeUiJ95ouwCQDSAKw=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=pQU7iIs7kvBxS2bzEaRke+AbEvwgRGBRnI2hcmz3HHXBOq+LTMAhvRJVQtCLqd5+v
         BRhSvdHdQcykZ5/L/mac+1R3MAAJoMMRfyaTjMkhRH6OeE/LisCItFDnP/o+Vs696r
         giuZ3b/wcRJFF7jFiY09K3TfEWAmjurroKFUQk0S290AaWKrTLoR9/g5drW0pLYIHL
         4mcKhUlTfvZ8FGUQYxhPkHKjqpYRBWdmuBTn38lL5SbPTIU6EjfJ8ZXyNBbMXZFHMC
         z8bMk6uBqUicaecFuV6JWu0KEmhfhIMdTuGvQeXsFIYTUz7YeEIBjyh/BVxVY3kFLc
         rd/kIwmTvQgeg==
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
Subject: [PATCH v2] PCI: vmd: Honor ACPI _OSC on PCIe features
Date:   Thu,  2 Dec 2021 11:04:49 +0800
Message-Id: <20211202030450.1355821-1-kai.heng.feng@canonical.com>
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
v2:
 - Use pci_find_host_bridge() instead of open coding.

 drivers/pci/controller/vmd.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index a45e8e59d3d48..acf847cb825c0 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -671,6 +671,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	resource_size_t offset[2] = {0};
 	resource_size_t membar2_offset = 0x2000;
 	struct pci_bus *child;
+	struct pci_host_bridge *root_bridge, *vmd_bridge;
 	int ret;
 
 	/*
@@ -798,6 +799,17 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 		return -ENODEV;
 	}
 
+	vmd_bridge = to_pci_host_bridge(vmd->bus->bridge);
+
+	root_bridge = pci_find_host_bridge(vmd->dev->bus);
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


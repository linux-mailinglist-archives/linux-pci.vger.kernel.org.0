Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B78446D35
	for <lists+linux-pci@lfdr.de>; Sat, 15 Jun 2019 02:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfFOAaJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jun 2019 20:30:09 -0400
Received: from gate.crashing.org ([63.228.1.57]:46454 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbfFOAaJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Jun 2019 20:30:09 -0400
Received: from ufdda393ec48b57.ant.amazon.com (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5F0TfFT010961;
        Fri, 14 Jun 2019 19:29:54 -0500
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sinan Kaya <okaya@kernel.org>, Ali Saidi <alisaidi@amazon.com>,
        Zeev Zilberman <zeev@amazon.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 4/4] arm64: pci: acpi: Preserve PCI resources configuration when asked by ACPI
Date:   Sat, 15 Jun 2019 10:23:59 +1000
Message-Id: <20190615002359.29577-4-benh@kernel.crashing.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190615002359.29577-1-benh@kernel.crashing.org>
References: <20190615002359.29577-1-benh@kernel.crashing.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When _DSM #5 returns 0 for a host bridge, we need to claim the existing
resources rather than reassign everything.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/arm64/kernel/pci.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 1419b1b4e9b9..a2c608a3fc41 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -168,6 +168,7 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 	struct acpi_pci_generic_root_info *ri;
 	struct pci_bus *bus, *child;
 	struct acpi_pci_root_ops *root_ops;
+	struct pci_host_bridge *hb;
 
 	ri = kzalloc(sizeof(*ri), GFP_KERNEL);
 	if (!ri)
@@ -193,6 +194,16 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 	if (!bus)
 		return NULL;
 
+	hb = pci_find_host_bridge(bus);
+
+	/* If ACPI tells us to preserve the resource configuration, claim now */
+	if (hb->preserve_config)
+		pci_bus_claim_resources(bus);
+
+	/*
+	 * Assign whatever was left unassigned. If we didn't claim above, this will
+	 * reassign everything.
+	 */
 	pci_assign_unassigned_root_bus_resources(bus);
 
 	list_for_each_entry(child, &bus->children, node)
-- 
2.17.1


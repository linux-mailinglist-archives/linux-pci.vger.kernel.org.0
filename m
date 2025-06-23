Return-Path: <linux-pci+bounces-30432-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8096DAE4BA5
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 19:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 517751899D37
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 17:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6AB2376E1;
	Mon, 23 Jun 2025 17:14:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [176.9.242.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B500E253F1D
	for <linux-pci@vger.kernel.org>; Mon, 23 Jun 2025 17:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750698896; cv=none; b=bFh0tyMPj1kVWY47ruNQofOfOuyXwPts33yDrf4YXm9Bm/Ic8IgI4QCN8FJGxn8YvZj382QhVYhMggzCGur7/QQ1p1lDu6xmiF+NolcQBV1+020AAf+Eh2lu1NE5B7hmGTiKEkHmv3hhInHJS8MuUvdJpbjmz8F6vtWtcrUx8c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750698896; c=relaxed/simple;
	bh=Y+a5MEO4grdR/P78FGCS0VqGF+up3KBrwhIY433726I=;
	h=Message-ID:From:Date:Subject:To:Cc; b=GoCFinZuIZ4/JkjBsVZj0AEFABRNFYApx+OJZg7xDAGgHFPLFmnQatQLXWgbryxv4YxzPWuEihcyQMWQRx7N/2YC0evARCZzjsONBIZEgr94yGdfT21dKDr5+7WWlFGyyZYO6UXjcsQw9yx+DnC8Xc+GgqaVahSllvJQyS/PO+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=176.9.242.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout3.hostsharing.net (Postfix) with UTF8SMTPS id 11E713006ADA;
	Mon, 23 Jun 2025 19:08:38 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with UTF8SMTPSA id C55B9603E106;
	Mon, 23 Jun 2025 19:08:37 +0200 (CEST)
X-Mailbox-Line: From 86c3bd52bda4552d63ffb48f8a30343167e85271 Mon Sep 17 00:00:00 2001
Message-ID: <86c3bd52bda4552d63ffb48f8a30343167e85271.1750698221.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Mon, 23 Jun 2025 19:08:20 +0200
Subject: [PATCH] PCI/ACPI: Fix runtime PM ref imbalance on hot-plug capable
 ports
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Laurent Bigonville <bigon@bigon.be>, Mario Limonciello <mario.limonciello@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Mika Westerberg <westeri@kernel.org>, linux-pci@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

pcie_portdrv_probe() and pcie_portdrv_remove() both call
pci_bridge_d3_possible() to determine whether to use runtime power
management.  The underlying assumption is that pci_bridge_d3_possible()
always returns the same value because otherwise a runtime PM reference
imbalance occurs.

That assumption falls apart if the device is inaccessible on ->remove()
due to hot-unplug:  pci_bridge_d3_possible() calls pciehp_is_native(),
which accesses Config Space to determine whether the device is Hot-Plug
Capable.   An inaccessible device returns "all ones", which is converted
to "all zeroes" by pcie_capability_read_dword().  Hence the device no
longer seems Hot-Plug Capable on ->remove() even though it was on
->probe().

The resulting runtime PM ref imbalance causes errors such as:

  pcieport 0000:02:04.0: Runtime PM usage count underflow!

The Hot-Plug Capable bit is cached in pci_dev->is_hotplug_bridge.
pci_bridge_d3_possible() only calls pciehp_is_native() if that flag is
set.  Re-checking the bit in pciehp_is_native() is thus unnecessary.

However pciehp_is_native() is also called from hotplug_is_native().  Move
the Config Space access to that function.  The function is only invoked
from acpiphp_glue.c, so move it there instead of keeping it in a publicly
visible header.

Fixes: 5352a44a561d ("PCI: pciehp: Make pciehp_is_native() stricter")
Reported-by: Laurent Bigonville <bigon@bigon.be>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220216
Reported-by: Mario Limonciello <mario.limonciello@amd.com>
Closes: https://lore.kernel.org/r/20250609020223.269407-3-superm1@kernel.org/
Link: https://lore.kernel.org/all/20250620025535.3425049-3-superm1@kernel.org/T/#u
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v4.18+
---
 drivers/pci/hotplug/acpiphp_glue.c | 15 +++++++++++++++
 drivers/pci/pci-acpi.c             |  5 -----
 include/linux/pci_hotplug.h        |  4 ----
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index 5b1f271c6034..ae2bb8970f63 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -50,6 +50,21 @@ static void acpiphp_sanitize_bus(struct pci_bus *bus);
 static void hotplug_event(u32 type, struct acpiphp_context *context);
 static void free_bridge(struct kref *kref);
 
+static bool hotplug_is_native(struct pci_dev *bridge)
+{
+	u32 slot_cap;
+
+	pcie_capability_read_dword(bridge, PCI_EXP_SLTCAP, &slot_cap);
+
+	if (slot_cap & PCI_EXP_SLTCAP_HPC && pciehp_is_native(bridge))
+		return true;
+
+	if (shpchp_is_native(bridge))
+		return true;
+
+	return false;
+}
+
 /**
  * acpiphp_init_context - Create hotplug context and grab a reference to it.
  * @adev: ACPI device object to create the context for.
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index b78e0e417324..57bce9cc8a38 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -816,15 +816,10 @@ int pci_acpi_program_hp_params(struct pci_dev *dev)
 bool pciehp_is_native(struct pci_dev *bridge)
 {
 	const struct pci_host_bridge *host;
-	u32 slot_cap;
 
 	if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
 		return false;
 
-	pcie_capability_read_dword(bridge, PCI_EXP_SLTCAP, &slot_cap);
-	if (!(slot_cap & PCI_EXP_SLTCAP_HPC))
-		return false;
-
 	if (pcie_ports_native)
 		return true;
 
diff --git a/include/linux/pci_hotplug.h b/include/linux/pci_hotplug.h
index ec77ccf1fc4d..02efeea62b25 100644
--- a/include/linux/pci_hotplug.h
+++ b/include/linux/pci_hotplug.h
@@ -102,8 +102,4 @@ static inline bool pciehp_is_native(struct pci_dev *bridge) { return true; }
 static inline bool shpchp_is_native(struct pci_dev *bridge) { return true; }
 #endif
 
-static inline bool hotplug_is_native(struct pci_dev *bridge)
-{
-	return pciehp_is_native(bridge) || shpchp_is_native(bridge);
-}
 #endif
-- 
2.47.2



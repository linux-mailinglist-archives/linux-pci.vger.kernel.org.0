Return-Path: <linux-pci+bounces-32027-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BE1B031B2
	for <lists+linux-pci@lfdr.de>; Sun, 13 Jul 2025 17:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DD7B3ABC92
	for <lists+linux-pci@lfdr.de>; Sun, 13 Jul 2025 15:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FB722D4F9;
	Sun, 13 Jul 2025 15:13:21 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0826D8F58
	for <linux-pci@vger.kernel.org>; Sun, 13 Jul 2025 15:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752419600; cv=none; b=sbaoLH2wWlg7VHTPAfUlhd0datxBOKBoHFgSb4FdlAL0WaPDnsUgTytRh9FLv7n6HNdQSvIMfZ4tObK4AFwoY+hTFoTa+AtLtEI+eChmFxMRtMRJ2vOmtApAo1YsnwLhUQJjKw+ySCm3+MEDStGP2yXiJw/WFta7dBCC5zKLUM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752419600; c=relaxed/simple;
	bh=7+UA/484LOrlFcs8+Org530l+8lLVr3gcZhL5JjBUrI=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=mjVOvxSotkt6kpIlkKuRCiAo6tzlvOOkKQ79qwzG+tCibirf9qqr9993VGvHR1DiXhD72A1aBLhOZLtWoZMaTaL0mPIQ3EcEIFjsSV/6J3M1VN8E8FxTFG7fetCNX18l1LQJwTmODE1BqgKPmFr1O6ZTk8rH3GwoXpGNIp1WcQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout1.hostsharing.net (Postfix) with UTF8SMTPS id 273B318D0D;
	Sun, 13 Jul 2025 17:12:55 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with UTF8SMTPSA id EFF7561C4D94;
	Sun, 13 Jul 2025 17:12:54 +0200 (CEST)
X-Mailbox-Line: From 18b2c2110ad0f27a34b189d793310b9c4f2f24a0 Mon Sep 17 00:00:00 2001
Message-ID: <18b2c2110ad0f27a34b189d793310b9c4f2f24a0.1752390102.git.lukas@wunner.de>
In-Reply-To: <cover.1752390101.git.lukas@wunner.de>
References: <cover.1752390101.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 13 Jul 2025 16:31:04 +0200
Subject: [PATCH v2 4/5] PCI: Move is_pciehp check out of pciehp_is_native()
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Laurent Bigonville <bigon@bigon.be>, Mario Limonciello <mario.limonciello@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Mika Westerberg <westeri@kernel.org>, Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>, Gil Fine <gil.fine@linux.intel.com>, Rene Sapiens <rene.sapiens@intel.com>, linux-pci@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

pci_bridge_d3_possible() seeks to forbid runtime power management on:

* Non Hot-Plug Capable PCIe ports which are nevertheless ACPI slots
  (recognizable as: bridge->is_hotplug_bridge && !bridge->is_pciehp)

* Hot-Plug Capable PCIe ports for which platform firmware has not granted
  PCIe Native Hot-Plug control to the operating system
  (recognizable as: bridge->is_pciehp && !pciehp_is_native(bridge))

Somewhat confusingly, the check for is_hotplug_bridge is in
pci_bridge_d3_possible(), whereas the one for is_pciehp is in
pciehp_is_native().

For clarity, check is_pciehp directly in pci_bridge_d3_possible()
(and in the other caller of pciehp_is_native(), hotplug_is_native()).

Rephrase the code comment preceding these checks to no longer mention
"System Management Mode", which is an x86 term inappropriate in generic
PCI code.  Likewise no longer mention "Thunderbolt on non-Macs", because
there is nothing Thunderbolt-specific about these checks.  It used to be
the case that non-Macs relied on the platform for Thunderbolt tunnel
management and hotplug, but they've since moved to OS-native tunnel
management (as Macs always have), hence the code comment is no longer
accurate.

There is a subsequent check for is_hotplug_bridge further down in
pci_bridge_d3_possible().  Change the check to is_pciehp because any
ports matching "bridge->is_hotplug_bridge && !bridge->is_pciehp" are
already filtered out at the top of the function.

Do the same for another check in acpi_pci_bridge_d3(), which is called
from pci_bridge_d3_possible() via platform_pci_bridge_d3().

No functional change intended.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/pci-acpi.c      |  5 +----
 drivers/pci/pci.c           | 12 ++++++++----
 include/linux/pci_hotplug.h |  3 ++-
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index efe478e5073e..ed7ed66a595b 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -820,9 +820,6 @@ bool pciehp_is_native(struct pci_dev *bridge)
 	if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
 		return false;
 
-	if (!bridge->is_pciehp)
-		return false;
-
 	if (pcie_ports_native)
 		return true;
 
@@ -1000,7 +997,7 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
 	struct acpi_device *adev, *rpadev;
 	const union acpi_object *obj;
 
-	if (acpi_pci_disabled || !dev->is_hotplug_bridge)
+	if (acpi_pci_disabled || !dev->is_pciehp)
 		return false;
 
 	adev = ACPI_COMPANION(&dev->dev);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 23d8fe98ddf9..749994dad9dc 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3050,10 +3050,14 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
 			return false;
 
 		/*
-		 * Hotplug ports handled by firmware in System Management Mode
-		 * may not be put into D3 by the OS (Thunderbolt on non-Macs).
+		 * Hotplug ports handled by platform firmware may not be put
+		 * into D3 by the OS, e.g. ACPI slots ...
 		 */
-		if (bridge->is_hotplug_bridge && !pciehp_is_native(bridge))
+		if (bridge->is_hotplug_bridge && !bridge->is_pciehp)
+			return false;
+
+		/* ... or PCIe hotplug ports not handled natively by the OS. */
+		if (bridge->is_pciehp && !pciehp_is_native(bridge))
 			return false;
 
 		if (pci_bridge_d3_force)
@@ -3072,7 +3076,7 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
 		 * by vendors for runtime D3 at least until 2018 because there
 		 * was no OS support.
 		 */
-		if (bridge->is_hotplug_bridge)
+		if (bridge->is_pciehp)
 			return false;
 
 		if (dmi_check_system(bridge_d3_blacklist))
diff --git a/include/linux/pci_hotplug.h b/include/linux/pci_hotplug.h
index ec77ccf1fc4d..ddf79641917f 100644
--- a/include/linux/pci_hotplug.h
+++ b/include/linux/pci_hotplug.h
@@ -104,6 +104,7 @@ static inline bool shpchp_is_native(struct pci_dev *bridge) { return true; }
 
 static inline bool hotplug_is_native(struct pci_dev *bridge)
 {
-	return pciehp_is_native(bridge) || shpchp_is_native(bridge);
+	return (bridge->is_pciehp && pciehp_is_native(bridge)) ||
+	       shpchp_is_native(bridge);
 }
 #endif
-- 
2.47.2



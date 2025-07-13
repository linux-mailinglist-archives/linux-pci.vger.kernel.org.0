Return-Path: <linux-pci+bounces-32028-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5CCB031B4
	for <lists+linux-pci@lfdr.de>; Sun, 13 Jul 2025 17:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 356021889228
	for <lists+linux-pci@lfdr.de>; Sun, 13 Jul 2025 15:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB8C276046;
	Sun, 13 Jul 2025 15:19:06 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [176.9.242.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E10920326
	for <linux-pci@vger.kernel.org>; Sun, 13 Jul 2025 15:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752419946; cv=none; b=JCpPbRSgHEf1Yx9TDgfp6ttHVM5afE+NQfleVATuZGBxMkBjX69to+cGJUL47+O4G+e0+npQ/nN25el6nLD3vv7bAIFwM2ih6BWooDtQLNSuCa9r3PeRUcvTx+PDhaBDSWUCuvj2jXGzYw+U9lqeS7rpBUytz8+KmQhUa/4KQgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752419946; c=relaxed/simple;
	bh=jd2E4EYl85++GdEx5Oj1p7/++nnE5xYg6OPYko2DjyA=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=NPPmNEKJsKofv8FGtJ/lzSpGqy7y/zmaXCHYxPATcwYBXxaJDihB4RrtuE7icqfxrXuxVBlDqgkZYPOyrV3J5k4wesAEXjCnzjaXXhpMDXQXM+weF9L+ISx8/SbB6KQlZ3vzLVuaoF/b4NxzGrs+lW4JKUHMk52ztX3H/5sQVmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=176.9.242.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout3.hostsharing.net (Postfix) with UTF8SMTPS id E31D53006794;
	Sun, 13 Jul 2025 17:19:01 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with UTF8SMTPSA id 9058061C7FB0;
	Sun, 13 Jul 2025 17:19:01 +0200 (CEST)
X-Mailbox-Line: From 5eae82776d695e589b89aad500d8208b980347e5 Mon Sep 17 00:00:00 2001
Message-ID: <5eae82776d695e589b89aad500d8208b980347e5.1752390102.git.lukas@wunner.de>
In-Reply-To: <cover.1752390101.git.lukas@wunner.de>
References: <cover.1752390101.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 13 Jul 2025 16:31:05 +0200
Subject: [PATCH v2 5/5] PCI: Set native_pcie_hotplug up front based on
 pcie_ports_native
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Laurent Bigonville <bigon@bigon.be>, Mario Limonciello <mario.limonciello@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Mika Westerberg <westeri@kernel.org>, Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>, Gil Fine <gil.fine@linux.intel.com>, Rene Sapiens <rene.sapiens@intel.com>, linux-pci@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Bjorn suggests to "set host->native_pcie_hotplug up front based on
CONFIG_HOTPLUG_PCI_PCIE and pcie_ports_native, and pciehp_is_native()
would collapse to just an accessor for host->native_pcie_hotplug".

Unfortunately only half of this is possible:

The check for pcie_ports_native can indeed be moved out of
pciehp_is_native() and into acpi_pci_root_create().

The check for CONFIG_HOTPLUG_PCI_PCIE however cannot be eliminated:

get_port_device_capability() needs to know whether platform firmware has
granted PCIe Native Hot-Plug control to the operating system.  If it has
and CONFIG_HOTPLUG_PCI_PCIE is disabled, the function disables hotplug
interrupts in case BIOS left them enabled.

If host->native_pcie_hotplug would be set up front based on
CONFIG_HOTPLUG_PCI_PCIE, it would later on be impossible for
get_port_device_capability() to tell whether it can safely disable hotplug
interrupts:  It wouldn't know whether Native Hot-Plug control was granted.

Link: https://lore.kernel.org/r/20250627025607.GA1650254@bhelgaas/
Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/acpi/pci_root.c    | 3 ++-
 drivers/pci/pci-acpi.c     | 3 ---
 drivers/pci/pcie/portdrv.c | 2 +-
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 74ade4160314..f3de0dc9c533 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -1028,7 +1028,8 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 		goto out_release_info;
 
 	host_bridge = to_pci_host_bridge(bus->bridge);
-	if (!(root->osc_control_set & OSC_PCI_EXPRESS_NATIVE_HP_CONTROL))
+	if (!pcie_ports_native &&
+	    !(root->osc_control_set & OSC_PCI_EXPRESS_NATIVE_HP_CONTROL))
 		host_bridge->native_pcie_hotplug = 0;
 	if (!(root->osc_control_set & OSC_PCI_SHPC_NATIVE_HP_CONTROL))
 		host_bridge->native_shpc_hotplug = 0;
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index ed7ed66a595b..b513826ea293 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -820,9 +820,6 @@ bool pciehp_is_native(struct pci_dev *bridge)
 	if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
 		return false;
 
-	if (pcie_ports_native)
-		return true;
-
 	host = pci_find_host_bridge(bridge->bus);
 	return host->native_pcie_hotplug;
 }
diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index d1b68c18444f..fa83ebdcfecb 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -223,7 +223,7 @@ static int get_port_device_capability(struct pci_dev *dev)
 	if (dev->is_pciehp &&
 	    (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
 	     pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM) &&
-	    (pcie_ports_native || host->native_pcie_hotplug)) {
+	    host->native_pcie_hotplug) {
 		services |= PCIE_PORT_SERVICE_HP;
 
 		/*
-- 
2.47.2



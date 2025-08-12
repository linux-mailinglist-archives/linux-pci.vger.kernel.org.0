Return-Path: <linux-pci+bounces-33861-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E9AB2295D
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 15:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 707BA1B65F34
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 13:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DAD259CA3;
	Tue, 12 Aug 2025 13:44:03 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A63127FD78;
	Tue, 12 Aug 2025 13:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755006243; cv=none; b=R/26pPhPLMlRMN6/rlS8H7fJLs3yzt5fHQ1ShuhgBxKMUfbobotuH3urnOEwKN8/GENnlG/Ty+1hvqpM78q93Uws69gtp7BMpzEggrGCcQItGx8i9pPzEmwcjgW+hWV9aGtnZxdQ18CC4fLphc/oSO2YXjZuTq4mvVBDVYP/PeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755006243; c=relaxed/simple;
	bh=QjHE0Hz1SkP5EcpMJwvmq6a+NsisCUNB7cXfhRrLTfA=;
	h=Message-Id:From:Date:Subject:To:Cc; b=J+ImJbwUfGisPjQtMFFc0umgRgV2niEXG0FA9lKZq9zlP8A+k3LF5wtVtlRMy1NxI4qgE0LH2GN12/f5DTL4LGfqyP1iF4W/yQv06/qbIZrnqbTwucyXJf6TaBPvVQkEpwI4YOCXT+7PAIcw1+sNbgmvIfeaSKrlCCTy8FxSpwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 17B8D2C0667F;
	Tue, 12 Aug 2025 15:43:51 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 030D84A155; Tue, 12 Aug 2025 15:43:50 +0200 (CEST)
Message-Id: <5632086b8436bc2f9a43e3573acf7a090615b52f.1755005459.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 12 Aug 2025 15:42:29 +0200
Subject: [PATCH] thunderbolt: Use is_pciehp instead of is_hotplug_bridge
To: Mika Westerberg <westeri@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Andreas Noever <andreas.noever@gmail.com>, Michael Jamet <michael.jamet@intel.com>, Yehezkel Bernat <YehezkelShB@gmail.com>, linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The thunderbolt driver sets up device link dependencies from hotplug ports
to the Host Router (aka Native Host Interface, NHI).  When resuming from
system sleep, this allows the Host Router to re-establish tunnels to
attached Thunderbolt devices before the hotplug ports resume.

To identify the hotplug ports, the driver utilizes the is_hotplug_bridge
flag which also encompasses ACPI slots handled by the ACPI hotplug driver.

Thunderbolt hotplug ports are always Hot-Plug Capable PCIe ports, so it is
more apt to identify them with the is_pciehp flag.

Similarly, hotplug ports on older Thunderbolt controllers have broken MSI
support and are quirked to use legacy INTx interrupts instead.  The quirk
identifies them with is_hotplug_bridge, even though all affected ports are
also matched by is_pciehp.  So use is_pciehp here as well.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
The is_pciehp flag was introduced by commit 6cff20ce3b92 ("PCI/ACPI: Fix
runtime PM ref imbalance on Hot-Plug Capable ports"), which appeared in
v6.17-rc1.  This patch is submitted separately because it is intended
to be applied through thunderbolt.git instead of pci.git.  Thanks!

 drivers/pci/quirks.c     | 2 +-
 drivers/thunderbolt/tb.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index d97335a..17315a8 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3829,7 +3829,7 @@ static void quirk_no_pm_reset(struct pci_dev *dev)
  */
 static void quirk_thunderbolt_hotplug_msi(struct pci_dev *pdev)
 {
-	if (pdev->is_hotplug_bridge &&
+	if (pdev->is_pciehp &&
 	    (pdev->device != PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C ||
 	     pdev->revision <= 1))
 		pdev->no_msi = 1;
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index c14ab1f..83a33fc 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -3336,7 +3336,7 @@ static bool tb_apple_add_links(struct tb_nhi *nhi)
 		if (!pci_is_pcie(pdev))
 			continue;
 		if (pci_pcie_type(pdev) != PCI_EXP_TYPE_DOWNSTREAM ||
-		    !pdev->is_hotplug_bridge)
+		    !pdev->is_pciehp)
 			continue;
 
 		link = device_link_add(&pdev->dev, &nhi->pdev->dev,
-- 
2.47.2



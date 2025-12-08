Return-Path: <linux-pci+bounces-42755-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 843D9CAD1AB
	for <lists+linux-pci@lfdr.de>; Mon, 08 Dec 2025 13:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C34E0301FA6B
	for <lists+linux-pci@lfdr.de>; Mon,  8 Dec 2025 12:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E343148A1;
	Mon,  8 Dec 2025 12:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZj7lVaq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7474931283F;
	Mon,  8 Dec 2025 12:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765196003; cv=none; b=Vr0C6W+BZ2rJGi9iQ0QM8kNXIX8jCW31HqnZEDhxUtNQ0Z8g4YRL32NULtg3X3tEmLjlGAX/FDAHrNYU/HMURjJkSvmkGz1YQwtdLmsik5CPmCxnNbWzK4jUViOItK2RXONRKNNXOWT8YQnoHZUMjuYeU59Nhq0TLuI1d7EJK1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765196003; c=relaxed/simple;
	bh=ASVeNch6NVSrs2aabRZhcx75igT46batyF3W0+Gk/TA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cyhv8f1H3cDY9dRvp8yYBLk0KHhTY8kLgDmi7+4qXhDLZiWgj5ZsIBN3eXkRTPgHW6qOzKdOzptkZ5N/n7Uyv4fP8srHuMDdHYRtT+UvaNX60SkymIBJhjmYqy6X/MIcKPdB59HEr9gyQ8PXu7UDkuw/PT7dA+ZfjQkoq7Dde7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZj7lVaq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58FEBC16AAE;
	Mon,  8 Dec 2025 12:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765196003;
	bh=ASVeNch6NVSrs2aabRZhcx75igT46batyF3W0+Gk/TA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EZj7lVaqTp9ahV8EbipyvwBP9KJvYlypBKDCfcGIZoQ7NrkDfUNxgKW/TaRGLOJ8e
	 svJIpS2i7dIi0z1ChJQOphknS+CK1p/OZOI15w9SKhCqu8wAPdJq7567FJjYoGiGU1
	 fW4CEGHWsxqebxWniBNVfKO3slsmP3Ar31/J+fT01nP89iahEGF5nbrr7wswhLvVBQ
	 /8dJftVESid7Hcpjo5cHioKfaZKXmQcK4d6MVpbUJdznPgjTTF0nz2xwTFclkiPlby
	 OImCEFvrqWbwdHQArddPio/O5NbjCfSe469TT+eJ1qAm0XRVZ1usvzwfRARppXwrLy
	 5oPDYHx4IZ5EQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Bjorn Helgaas <helgaas@kernel.org>, Armin Wolf <w_armin@gmx.de>
Subject: [PATCH v1 1/2] PCI: ACPI: PM: Rework root bus notification setup
Date: Mon, 08 Dec 2025 13:11:58 +0100
Message-ID: <2249851.irdbgypaU6@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <2395536.ElGaqSPkdT@rafael.j.wysocki>
References: <2395536.ElGaqSPkdT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since pci_acpi_add_bus_pm_notifier() is only suitable for adding ACPI
PM notifiers to root buses, rename it to pci_acpi_add_root_pm_notifier()
and modify it to take an additional "root" argument, which is then used
for passing a PCI root bridge device pointer to acpi_add_pm_notifier().

That function uses it to populate the "dev" field in the context
structure attached to the ACPI device object that will receive the
ACPI "wake" notifications on behalf of the given PCI root bus.  The
context structure in question is passed to pci_acpi_wake_bus(), so
the latter can be simplified quite a bit now because the target PCI
host bridge structure address can be derived from "dev".

No intentional functional impact.

This change will also facilitate a subsequent update related to the
registration of wakeup sources.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/pci_root.c  |    2 +-
 drivers/pci/pci-acpi.c   |   15 ++++++---------
 include/linux/pci-acpi.h |    3 ++-
 3 files changed, 9 insertions(+), 11 deletions(-)

--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -738,7 +738,7 @@ static int acpi_pci_root_add(struct acpi
 	if (no_aspm)
 		pcie_no_aspm();
 
-	pci_acpi_add_bus_pm_notifier(device);
+	pci_acpi_add_root_pm_notifier(device, root);
 	device_set_wakeup_capable(root->bus->bridge, device->wakeup.flags.valid);
 
 	if (hotadd) {
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -847,12 +847,7 @@ bool shpchp_is_native(struct pci_dev *br
  */
 static void pci_acpi_wake_bus(struct acpi_device_wakeup_context *context)
 {
-	struct acpi_device *adev;
-	struct acpi_pci_root *root;
-
-	adev = container_of(context, struct acpi_device, wakeup.context);
-	root = acpi_driver_data(adev);
-	pci_pme_wakeup_bus(root->bus);
+	pci_pme_wakeup_bus(to_pci_host_bridge(context->dev)->bus);
 }
 
 /**
@@ -885,12 +880,14 @@ static void pci_acpi_wake_dev(struct acp
 }
 
 /**
- * pci_acpi_add_bus_pm_notifier - Register PM notifier for root PCI bus.
+ * pci_acpi_add_root_pm_notifier - Register PM notifier for root PCI bus.
  * @dev: PCI root bridge ACPI device.
+ * @pci_root: PCI root corresponding to @dev.
  */
-acpi_status pci_acpi_add_bus_pm_notifier(struct acpi_device *dev)
+acpi_status pci_acpi_add_root_pm_notifier(struct acpi_device *dev,
+					  struct acpi_pci_root *root)
 {
-	return acpi_add_pm_notifier(dev, NULL, pci_acpi_wake_bus);
+	return acpi_add_pm_notifier(dev, root->bus->bridge, pci_acpi_wake_bus);
 }
 
 /**
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -12,7 +12,8 @@
 #include <linux/acpi.h>
 
 #ifdef CONFIG_ACPI
-extern acpi_status pci_acpi_add_bus_pm_notifier(struct acpi_device *dev);
+extern acpi_status pci_acpi_add_root_pm_notifier(struct acpi_device *dev,
+						 struct acpi_pci_root *pci_root);
 static inline acpi_status pci_acpi_remove_bus_pm_notifier(struct acpi_device *dev)
 {
 	return acpi_remove_pm_notifier(dev);





Return-Path: <linux-pci+bounces-43046-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB30CBDE4C
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 13:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E40F23031344
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 12:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD25B3375DC;
	Mon, 15 Dec 2025 12:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXrOqXaB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BECC3375CD;
	Mon, 15 Dec 2025 12:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765802993; cv=none; b=T6BhkJ1mdTPE9ErhbsC6UFRHJtB5S0pdUtZ35Pzy5KAO9DYzu728DEvXeVOXgCZcP4jKpirDwDwsqahgVquKPXwbNN84XKmysz/SiS2FYsJh2kYkV+y3GHEEQXGAIFn/MnjzMF/f+jAAd0wSI5VT4OmhESCoVK2XXBsuSVIUOqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765802993; c=relaxed/simple;
	bh=ZpgXvvRauo5EzGje6i25ZBBhvXZeZO7iRrLVEHCbTIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iWV6icm/hinIVcw+6Ri8x9tXwX98tc4U3F/QJ8IigcUAo2zjHiBRXAyB2t5+wGdGYxPNNOB3zaK0/At5eBc8zoQRwP+l5asYFEbm0CcIB+AhlqkQdfrX1JJ6R99pD2nSWndvQcEtkk7iAj/xv95z2YJhMnF10kpVQ7J7qVysS0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXrOqXaB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA18BC4CEF5;
	Mon, 15 Dec 2025 12:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765802993;
	bh=ZpgXvvRauo5EzGje6i25ZBBhvXZeZO7iRrLVEHCbTIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FXrOqXaB6nzIeL5ohpMF8vri0sHUhzgjCecZL5BDXXajpDb5yn5QmsHsE4SE7GXNj
	 BBOhHmDKJr6wMBLCSGWAchIuBLBYB/I+pLmAFm6kjm40Jgw5laONt3V8o8oHZ/FGBR
	 jQBvNUp1QmGKVT/uK6aCje/5qxHAp0TqNFdj0ihz6vRZ1zN6v1vHKPJu4hSkadTDPZ
	 gKmbtNeX2HG8yBsF3xbcPmsNI/FuZQ8z7oiIuRqnHmL1tcVc8hHneCM16QWy98ALrm
	 eof4HdA2QoVn6+Va+EmRxek+Hg2d5rZfQ+bEEieCcU9iEklIzC7JhblSoHSJp+nLgI
	 9MGlnuadTJBHg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Bjorn Helgaas <helgaas@kernel.org>, Armin Wolf <w_armin@gmx.de>
Subject:
 [RESEND][PATCH v1 1/2] ACPI: PCI: PM: Rework root bus notification setup
Date: Mon, 15 Dec 2025 13:48:14 +0100
Message-ID: <2395263.ElGaqSPkdT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <6223429.lOV4Wx5bFT@rafael.j.wysocki>
References: <6223429.lOV4Wx5bFT@rafael.j.wysocki>
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
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
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





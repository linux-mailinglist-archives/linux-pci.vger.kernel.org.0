Return-Path: <linux-pci+bounces-31284-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E44E5AF5CDB
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 17:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16FB016BD91
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 15:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59EC2D46BB;
	Wed,  2 Jul 2025 15:25:11 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [176.9.242.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9752D94B7
	for <linux-pci@vger.kernel.org>; Wed,  2 Jul 2025 15:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751469911; cv=none; b=Zbf18K1Wk0iLANPNOnLnrCvRY0oT/i+F8bcXpWg2PIAbzHUaa/ambmAEa0gqe/vQZq6g3IS/NAOqKHpJdvyifX74nUGDqiSuEtXhKgtpstLIAIp2sZn2KuKtsXPvUZebrjTsEqsOHtlScLa8QgHlDJwWHq+tGXcEn396rZg0nc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751469911; c=relaxed/simple;
	bh=h2ukEMsYMEfcOGW8DvmR58gHGk8vdeaTlECjogs0Hag=;
	h=Message-ID:From:Date:Subject:To:Cc; b=uZLwuP+1wBdiFSXCS/TADcoZpW5vrTacuZJgJptC3zUu/MoXd8m6h5COpW/cSPY7ZpDRM6yBnxO60QexWEW/xPbU5vKstc7lq0QJrsGtfbKd4rUxTqubjKnao4W1n3xd4ENsyYb6+bLRGhh0mX8Wz6hMui5DpKXjpQ55s+/k5ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=176.9.242.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout3.hostsharing.net (Postfix) with UTF8SMTPS id 62BAE3006AD5;
	Wed,  2 Jul 2025 17:15:09 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with UTF8SMTPSA id 15F9C619FB4D;
	Wed,  2 Jul 2025 17:15:09 +0200 (CEST)
X-Mailbox-Line: From b29e7fbfc6d146f947603d0ebaef44cbd2f0d754 Mon Sep 17 00:00:00 2001
Message-ID: <b29e7fbfc6d146f947603d0ebaef44cbd2f0d754.1751468802.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 2 Jul 2025 17:15:15 +0200
Subject: [PATCH v2] agp/amd64: Check AGP Capability before binding to
 unsupported devices
To: David Airlie <airlied@redhat.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Ben Hutchings <ben@decadent.org.uk>, Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Andi Kleen <ak@linux.intel.com>, Ahmed Salem <x0rw3ll@gmail.com>, Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, linux-pci@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Since commit 172efbb40333 ("AGP: Try unsupported AGP chipsets on x86-64
by default"), the AGP driver for AMD Opteron/Athlon64 CPUs has attempted
to bind to any PCI device possessing an AGP Capability.

Commit 6fd024893911 ("amd64-agp: Probe unknown AGP devices the right
way") subsequently reworked the driver to perform a bind attempt to
any PCI device (regardless of AGP Capability) and reject a device in
the driver's ->probe() hook if it lacks the AGP Capability.

On modern CPUs exposing an AMD IOMMU, this subtle change results in an
annoying message with KERN_CRIT severity:

  pci 0000:00:00.2: Resources present before probing

The message is emitted by the driver core prior to invoking a driver's
->probe() hook.  The check for an AGP Capability in the ->probe() hook
happens too late to prevent the message.

The message has appeared only recently with commit 3be5fa236649 (Revert
"iommu/amd: Prevent binding other PCI drivers to IOMMU PCI devices").
Prior to the commit, no driver could bind to AMD IOMMUs.

The reason for the message is that an MSI is requested early on for the
AMD IOMMU, which results in a call from msi_sysfs_create_group() to
devm_device_add_group().  A devres resource is thus attached to the
driver-less AMD IOMMU, which is normally not allowed, but presumably
cannot be avoided because requesting the MSI from a regular PCI driver
might be too late.

Avoid the message by once again checking for an AGP Capability *before*
binding to an unsupported device.  Achieve that by way of the PCI core's
dynid functionality.

pci_add_dynid() can fail only with -ENOMEM (on allocation failure) or
-EINVAL (on bus_to_subsys() failure).  It doesn't seem worth the extra
code to propagate those error codes out of the for_each_pci_dev() loop,
so simply error out with -ENODEV if there was no successful bind attempt.
In the -ENOMEM case, a splat is emitted anyway, and the -EINVAL case can
never happen because it requires failure of bus_register(&pci_bus_type),
in which case there's no driver probing of PCI devices.

Hans has voiced a preference to no longer probe unsupported devices by
default (i.e. set agp_try_unsupported = 0).  In fact, the help text for
CONFIG_AGP_AMD64 pretends this to be the default.  Alternatively, he
proposes probing only devices with PCI_CLASS_BRIDGE_HOST.  However these
approaches risk regressing users who depend on the existing behavior.

Fixes: 3be5fa236649 (Revert "iommu/amd: Prevent binding other PCI drivers to IOMMU PCI devices")
Reported-by: Fedor Pchelkin <pchelkin@ispras.ru>
Closes: https://lore.kernel.org/r/wpoivftgshz5b5aovxbkxl6ivvquinukqfvb5z6yi4mv7d25ew@edtzr2p74ckg/
Reported-by: Hans de Goede <hansg@kernel.org>
Closes: https://lore.kernel.org/r/20250625112411.4123-1-hansg@kernel.org/
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
Changes v1 -> v2:
 * Use pci_add_dynid() to bind only to devices with AGP Capability
   (based on a suggestion from Ben).
 * Rephrase commit message to hopefully explain the history more accurately.
   Explain why resources are attached to the driver-less AMD IOMMU
   (requested by Ben).
 * Acknowledge Hans as reporter.

 drivers/char/agp/amd64-agp.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/char/agp/amd64-agp.c b/drivers/char/agp/amd64-agp.c
index bf490967241a..2505df1f4e69 100644
--- a/drivers/char/agp/amd64-agp.c
+++ b/drivers/char/agp/amd64-agp.c
@@ -720,11 +720,6 @@ static const struct pci_device_id agp_amd64_pci_table[] = {
 
 MODULE_DEVICE_TABLE(pci, agp_amd64_pci_table);
 
-static const struct pci_device_id agp_amd64_pci_promisc_table[] = {
-	{ PCI_DEVICE_CLASS(0, 0) },
-	{ }
-};
-
 static DEFINE_SIMPLE_DEV_PM_OPS(agp_amd64_pm_ops, NULL, agp_amd64_resume);
 
 static struct pci_driver agp_amd64_pci_driver = {
@@ -739,6 +734,7 @@ static struct pci_driver agp_amd64_pci_driver = {
 /* Not static due to IOMMU code calling it early. */
 int __init agp_amd64_init(void)
 {
+	struct pci_dev *pdev = NULL;
 	int err = 0;
 
 	if (agp_off)
@@ -767,9 +763,13 @@ int __init agp_amd64_init(void)
 		}
 
 		/* Look for any AGP bridge */
-		agp_amd64_pci_driver.id_table = agp_amd64_pci_promisc_table;
-		err = driver_attach(&agp_amd64_pci_driver.driver);
-		if (err == 0 && agp_bridges_found == 0) {
+		for_each_pci_dev(pdev)
+			if (pci_find_capability(pdev, PCI_CAP_ID_AGP))
+				pci_add_dynid(&agp_amd64_pci_driver,
+					      pdev->vendor, pdev->device,
+					      pdev->subsystem_vendor,
+					      pdev->subsystem_device, 0, 0, 0);
+		if (agp_bridges_found == 0) {
 			pci_unregister_driver(&agp_amd64_pci_driver);
 			err = -ENODEV;
 		}
-- 
2.47.2



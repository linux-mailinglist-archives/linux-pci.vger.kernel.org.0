Return-Path: <linux-pci+bounces-32021-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B66B03199
	for <lists+linux-pci@lfdr.de>; Sun, 13 Jul 2025 16:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42A563BEE12
	for <lists+linux-pci@lfdr.de>; Sun, 13 Jul 2025 14:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46640275B1C;
	Sun, 13 Jul 2025 14:40:31 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [176.9.242.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD3E8836
	for <linux-pci@vger.kernel.org>; Sun, 13 Jul 2025 14:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752417631; cv=none; b=N4Q1lM4mlYCIiam1sjEvDd0BhJk5z9f/owiQGe4PjGFmVsbUB6J9nbzFLmbz924lD7T+z/XS7BpZL7eQyMJLNuc+GzEz96VXJFrU/i0erK7XKiUrEVhZTnt3erdy3cIl09aNlSt8toDUggiuiug/IPkKrESAWK+G1ca2Xq7OvlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752417631; c=relaxed/simple;
	bh=d+lKVoxp1EkIlmT9U15RjaRRKIYfugQOF+/k1UwQavA=;
	h=Message-ID:From:Date:Subject:To:Cc; b=ZY74rByGWoW/8NAuVXClkcA6z048wFmvAgrY+d3aAZtYpPvYxnysICyIYGsDRdWxFn8X4RvdXEo7jCo49laf45Hej3RUDwJtz+4WC0rSjYOi011IdTLAkXM/MR3njDdpPhSQQm1a8Wp4NA5fDUYlLXolQyYNwO8gbJJNwx9/S7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=176.9.242.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout3.hostsharing.net (Postfix) with UTF8SMTPS id CE8A73006794;
	Sun, 13 Jul 2025 16:31:37 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with UTF8SMTPSA id 8FCC561B9C5B;
	Sun, 13 Jul 2025 16:31:37 +0200 (CEST)
X-Mailbox-Line: From 5eae82776d695e589b89aad500d8208b980347e5 Mon Sep 17 00:00:00 2001
Message-ID: <cover.1752390101.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 13 Jul 2025 16:31:00 +0200
Subject: [PATCH v2 0/5] PCI: Clean up and fix is_hotplug_bridge usage
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Laurent Bigonville <bigon@bigon.be>, Mario Limonciello <mario.limonciello@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Mika Westerberg <westeri@kernel.org>, Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>, Gil Fine <gil.fine@linux.intel.com>, Rene Sapiens <rene.sapiens@intel.com>, linux-pci@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The original impetus of this series is to fix a runtime PM ref imbalance
on hot-removal of PCIe hotplug ports (patch [1/5]).

That is achieved by adding an is_pciehp flag to struct pci_dev.
The new flag is only set on PCIe Hot-Plug Capable ports, unlike the
existing is_hotplug_bridge flag, which is also set on ACPI slots and
Conventional PCI hotplug bridges (via quirk_hotplug_bridge()).

Patches [2/5] to [4/5] replace is_hotplug_bridge with is_pciehp in a
number of places for clarity and to fix some actual bugs.

Optional patch [5/5] follows a suggestion from Bjorn to set
host->native_pcie_hotplug up front based on pcie_ports_native.
That patch needs an ack from Rafael because it touches ACPI code.
Up to Bjorn whether it is a worthwhile improvement or not.

I'm open to suggestions for a different name than is_pciehp,
e.g. is_pciehp_bridge.

I've reviewed this a couple of times, but would appreciate further
reviewing and testing by others to raise the confidence.  Mika is
out of office until July 28, so I'm cc'ing thunderbolt developers
Alan, Gil and Rene.

I've got an additional patch to replace is_hotplug_bridge with is_pciehp
in quirk_thunderbolt_hotplug_msi() and tb_apple_add_links().  I intend
to submit it to Mika separately if/when this series is accepted.

Link to v1, which consisted only of a (problematic) variant of patch [1/5]:
https://lore.kernel.org/r/86c3bd52bda4552d63ffb48f8a30343167e85271.1750698221.git.lukas@wunner.de/

Lukas Wunner (5):
  PCI/ACPI: Fix runtime PM ref imbalance on Hot-Plug Capable ports
  PCI/portdrv: Use is_pciehp instead of is_hotplug_bridge
  PCI: pciehp: Use is_pciehp instead of is_hotplug_bridge
  PCI: Move is_pciehp check out of pciehp_is_native()
  PCI: Set native_pcie_hotplug up front based on pcie_ports_native

 drivers/acpi/pci_root.c          |  3 ++-
 drivers/pci/hotplug/pciehp_hpc.c |  2 +-
 drivers/pci/pci-acpi.c           | 10 +---------
 drivers/pci/pci.c                | 18 +++++++++++++-----
 drivers/pci/pcie/portdrv.c       |  4 ++--
 drivers/pci/probe.c              |  2 +-
 include/linux/pci.h              |  6 ++++++
 include/linux/pci_hotplug.h      |  3 ++-
 8 files changed, 28 insertions(+), 20 deletions(-)

-- 
2.47.2



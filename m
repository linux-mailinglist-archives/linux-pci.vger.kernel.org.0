Return-Path: <linux-pci+bounces-24444-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A132A6CBEA
	for <lists+linux-pci@lfdr.de>; Sat, 22 Mar 2025 19:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 638113B2118
	for <lists+linux-pci@lfdr.de>; Sat, 22 Mar 2025 18:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A5822F3BD;
	Sat, 22 Mar 2025 18:58:43 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDC41C84B6
	for <linux-pci@vger.kernel.org>; Sat, 22 Mar 2025 18:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742669923; cv=none; b=qP76S6j2axiHdML1qv7PZz7fY1ejUUHZ3MhJxBEtwhbk7D+Kmv/Yd29sefy5sVIJDP3XCavV+iM+jjwep+gmWIBw7DtFNquc5AGK5Mss9VzH8UV4BjQwL521XVBpe8CE+FGtAbnpwlW6uv2OTtEyohWkeC6M2J12xTa5MB5yNOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742669923; c=relaxed/simple;
	bh=zoqr9ai99hcygtVL96nWOUsIchoRveYwqRfvVwrFSvk=;
	h=Message-ID:From:Date:Subject:To:Cc; b=gPUwldjTQcaitU1PSy2RX2O8/oSdPD1vq+ovmXZPAu2gjQw6+SkGzU85z7uH+wFYYqVzz0LBcRc18TfV79PfF/A2qGeXDd0OGmOryb1hcpe8kkWV9qptFhzOBJbc/E8x2c5r7ZMiLcux/WQz0/Jya4OTLoZPtoqr1jGD2HV5qew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 36D4A10192631;
	Sat, 22 Mar 2025 19:52:11 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with ESMTPSA id 04EDF603DF46;
	Sat, 22 Mar 2025 19:52:10 +0100 (CET)
X-Mailbox-Line: From 3b6c8d973aedc48860640a9d75d20528336f1f3c Mon Sep 17 00:00:00 2001
Message-ID: <3b6c8d973aedc48860640a9d75d20528336f1f3c.1742669372.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 22 Mar 2025 19:52:08 +0100
Subject: [PATCH] PCI/bwctrl: Fix NULL pointer deref on bus number exhaustion
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Wouter Bijlsma <wouter@wouterbijlsma.nl>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

When BIOS neglects to assign bus numbers to PCI bridges, the kernel
attempts to correct that during PCI device enumeration.  If it runs out
of bus numbers, no pci_bus is allocated and the "subordinate" pointer in
the bridge's pci_dev remains NULL.

The PCIe bandwidth controller erroneously does not check for a NULL
subordinate pointer and dereferences it on probe.

Bandwidth control of unusable devices below the bridge is of questionable
utility, so simply error out instead.  This mirrors what PCIe hotplug does
since commit 62e4492c3063 ("PCI: Prevent NULL dereference during pciehp
probe").

The PCI core emits a message with KERN_INFO severity if it has run out of
bus numbers.  PCIe hotplug emits an additional message with KERN_ERR
severity to inform the user that hotplug functionality is disabled at the
bridge.  A similar message for bandwidth control does not seem merited,
given that its only purpose so far is to expose an up-to-date link speed
in sysfs and throttle the link speed on certain laptops with limited
Thermal Design Power.  So error out silently.

User-visible messages:

  pci 0000:16:02.0: bridge configuration invalid ([bus 00-00]), reconfiguring
  [...]
  pci_bus 0000:45: busn_res: [bus 45-74] end is updated to 74
  pci 0000:16:02.0: devices behind bridge are unusable because [bus 45-74] cannot be assigned for them
  [...]
  pcieport 0000:16:02.0: pciehp: Hotplug bridge without secondary bus, ignoring
  [...]
  BUG: kernel NULL pointer dereference
  RIP: pcie_update_link_speed
  pcie_bwnotif_enable
  pcie_bwnotif_probe
  pcie_port_probe_service
  really_probe

Fixes: 665745f27487 ("PCI/bwctrl: Re-add BW notification portdrv as PCIe BW controller")
Reported-by: Wouter Bijlsma <wouter@wouterbijlsma.nl>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219906
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v6.13+
---
 drivers/pci/pcie/bwctrl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
index 0a5e7efbce2c..0e5807ae4083 100644
--- a/drivers/pci/pcie/bwctrl.c
+++ b/drivers/pci/pcie/bwctrl.c
@@ -294,6 +294,10 @@ static int pcie_bwnotif_probe(struct pcie_device *srv)
 	struct pci_dev *port = srv->port;
 	int ret;
 
+	/* Can happen if we run out of bus numbers during enumeration */
+	if (!port->subordinate)
+		return -ENODEV;
+
 	struct pcie_bwctrl_data *data = devm_kzalloc(&srv->device,
 						     sizeof(*data), GFP_KERNEL);
 	if (!data)
-- 
2.43.0



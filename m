Return-Path: <linux-pci+bounces-32024-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8560BB031A2
	for <lists+linux-pci@lfdr.de>; Sun, 13 Jul 2025 16:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3ECA189843A
	for <lists+linux-pci@lfdr.de>; Sun, 13 Jul 2025 14:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557601804A;
	Sun, 13 Jul 2025 14:55:13 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9004E18D
	for <linux-pci@vger.kernel.org>; Sun, 13 Jul 2025 14:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752418513; cv=none; b=R4X8ZdgFl51OU57PleIXjZ0m7bHR9jrh3FZ7Fos6PGiuPhL0q9vrnp6wuWd7poqdAx0ChBG3zOtdhawYf1loOi7RzJNWYsebRlTqfGq+TtsSNm3FTUi0xZvJ9tImHbNWVzDE3tlTGMznhAqKM4xfipDcmr6DBQJbw6A+WR+dTx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752418513; c=relaxed/simple;
	bh=hPrV9C6RN5hAMSadR2wGaFj3ofGZCPb4xxEx0LOYK/M=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=W8p1uZvQMc+Wxr1wmo2Y7ljYe46n/241WUSzq7EgKqPmuuTrzIEzIIJcNccjo41mxX6ItonH4pJqGq4k2WfnZuX033K/IhQXrTjduKvt/CyK5tEkuuxL1NeX6MdxhP5tRqmVgQsb8VA7rzgBofj34ptZdfU0j+oeFoQVaJLT+OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout2.hostsharing.net (Postfix) with UTF8SMTPS id 952EB2C1E4C6;
	Sun, 13 Jul 2025 16:55:09 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with UTF8SMTPSA id 4395A61C19A4;
	Sun, 13 Jul 2025 16:55:09 +0200 (CEST)
X-Mailbox-Line: From 40d5a5fe8d40595d505949c620a067fa110ee85e Mon Sep 17 00:00:00 2001
Message-ID: <40d5a5fe8d40595d505949c620a067fa110ee85e.1752390102.git.lukas@wunner.de>
In-Reply-To: <cover.1752390101.git.lukas@wunner.de>
References: <cover.1752390101.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 13 Jul 2025 16:31:02 +0200
Subject: [PATCH v2 2/5] PCI/portdrv: Use is_pciehp instead of
 is_hotplug_bridge
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Laurent Bigonville <bigon@bigon.be>, Mario Limonciello <mario.limonciello@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Mika Westerberg <westeri@kernel.org>, Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>, Gil Fine <gil.fine@linux.intel.com>, Rene Sapiens <rene.sapiens@intel.com>, linux-pci@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The PCIe port driver erroneously creates a subdevice for hotplug on ACPI
slots which are handled by the ACPI hotplug driver.

Avoid by checking the is_pciehp flag instead of is_hotplug_bridge when
deciding whether to create a subdevice.  The latter encompasses ACPI slots
whereas the former doesn't.

The superfluous subdevice has no real negative impact, it occupies memory
and interrupt resources but otherwise just sits there waiting for
interrupts from the slot that are never signaled.

Fixes: f8415222837b ("PCI: Use cached copy of PCI_EXP_SLTCAP_HPC bit")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v4.7+
---
 drivers/pci/pcie/portdrv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index e8318fd5f6ed..d1b68c18444f 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -220,7 +220,7 @@ static int get_port_device_capability(struct pci_dev *dev)
 	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
 	int services = 0;
 
-	if (dev->is_hotplug_bridge &&
+	if (dev->is_pciehp &&
 	    (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
 	     pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM) &&
 	    (pcie_ports_native || host->native_pcie_hotplug)) {
-- 
2.47.2



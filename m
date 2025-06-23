Return-Path: <linux-pci+bounces-30347-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D47AAE371A
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 09:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 567FB1881D32
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 07:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0242E1DF97F;
	Mon, 23 Jun 2025 07:37:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10A61DF75A;
	Mon, 23 Jun 2025 07:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750664238; cv=none; b=pQ492ju3K+IQGZKiHXcTrDGoRDSObIqkIHmhirLRcfyj11WCf3zjDUXOEBSN/GvGr2Jn8Vyh4zDjYg2NdnN2Vl/kC4o+UBUDyxirG+De7zc6QfSD7rK/+AKKHkIbhTLeWFezJF11kqrxLjxTX8UdTLfnaKr1BLV6YqaSOaWckl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750664238; c=relaxed/simple;
	bh=xJ/gXqto3EIebLFfpIC3qZpCkGpaBSkeexK+rR8liEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SuZpS8ZrYCCglaFHGhoHJp61zj40Q74FwDVJ1ipmlt+NvLpq7cV3sXtQJ4M5Uq+JJ3/SYcy7n8i2gp8LZxR8gnstShwf9KJmdH5G2zCnS/dtBV1jJtdplMz2at4J/p/nvOF6VylchCyyd300+ua26jIz0oK5XWY5Phbs7IYsaSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id AAF3F200A45B;
	Mon, 23 Jun 2025 09:37:07 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id A14A8100F4; Mon, 23 Jun 2025 09:37:07 +0200 (CEST)
Date: Mon, 23 Jun 2025 09:37:07 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Mario Limonciello <superm1@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v3 2/2] PCI: Fix runtime PM usage count underflow on
 device unplug
Message-ID: <aFkEI2jXg7YiwL7b@wunner.de>
References: <20250620025535.3425049-1-superm1@kernel.org>
 <20250620025535.3425049-3-superm1@kernel.org>
 <aFcCaw_IZr-JuUYY@wunner.de>
 <8d4d98b6-fec5-466f-bd2c-059d702c7860@kernel.org>
 <aFeJ83O9PRUrM2Ir@wunner.de>
 <295bf182-7fed-4ffd-93a4-fb5ddf5f1bb4@kernel.org>
 <aFj3jUAM42lSyfpe@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFj3jUAM42lSyfpe@wunner.de>

On Mon, Jun 23, 2025 at 08:43:25AM +0200, Lukas Wunner wrote:
> On Sun, Jun 22, 2025 at 01:39:26PM -0500, Mario Limonciello wrote:
> > > > On 6/21/25 2:05 PM, Lukas Wunner wrote:
> > > > > So the refcount decrement happens in pcie_portdrv_probe() and
> > > > > the refcount increment happens in pcie_portdrv_remove().
> > > > > Both times it's conditional on pci_bridge_d3_possible().
> > > > > Does that return a different value on probe versus remove?
> > 
> > I did this check and yes specifically on this PCIe port with the underflow
> > the d3 possible lookup returns false during pcie_portdrv_remove().  It
> > returns true during pcie_portdrv_probe().
> 
> That's not supposed to happen.  The expectation is that
> pci_bridge_d3_possible() always returns the same value.

I'm wondering if the patch below fixes the issue?

Normally the "is_thunderbolt" check in pci_bridge_d3_possible()
should return true for this particular device.

But there's a check for pciehp_is_native() before that and
it accesses config space to check if the Hot-Plug Capable bit
is set.  The device is inaccessible, so the expectation is that
"all ones" is returned, which implies a set HPC bit.

But maybe for some reason "all ones" isn't returned anymore?
If the patch below does help, could you check what the read
of the Slot Capabilities register returns?

Thanks!

-- >8 --

From: Lukas Wunner <lukas@wunner.de>
Subject: [PATCH] PCI/ACPI: Use cached is_hotplug_bridge value in
 pciehp_is_native()

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/pci-acpi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index b78e0e4..909ca4a 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -821,8 +821,7 @@ bool pciehp_is_native(struct pci_dev *bridge)
 	if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
 		return false;
 
-	pcie_capability_read_dword(bridge, PCI_EXP_SLTCAP, &slot_cap);
-	if (!(slot_cap & PCI_EXP_SLTCAP_HPC))
+	if (!bridge->is_hotplug_bridge)
 		return false;
 
 	if (pcie_ports_native)
-- 
2.47.2



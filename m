Return-Path: <linux-pci+bounces-30358-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36987AE3BB8
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 12:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6D9C188DE98
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 10:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C107E23A9BE;
	Mon, 23 Jun 2025 10:05:42 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CE623A9BD;
	Mon, 23 Jun 2025 10:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750673142; cv=none; b=dFgjXuKPL//iEgDP4X7trs8RCkDKtzuUYHKXCosKHloFP3KeBpFYBi1b0LMPvvR9XgmW5cx+hasTGQELz0gpNFSpiIQSymzKxYZ9CE+LqzLNViiF5jn1KQJxjLlGyrlBFo4xjrSyuoWXLSZqnodpQ4RF6XuQTuRW5FRJdWDuuvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750673142; c=relaxed/simple;
	bh=+kTCOP1WhjuszCcIK+r3LNOvbWb67HPONHc5xMq0s3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n3gxgwQSokOt0IAAr38pzsrpu+UJ+UxQks0hgPkfnbjAuMspZ1lyPAbbJtmrtjdWe40cYQueedfeXvaDYitYGPLlbHUS5Ca/r1D7Ub6oQk80UhbTT2PABSi+MGQEf6JUVDt/CH7VKniUQYJRJLkuHnAU14wOnMgd+mQ6U4Sqonc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 4F5432C000BF;
	Mon, 23 Jun 2025 12:05:38 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 1CE943AA69A; Mon, 23 Jun 2025 12:05:38 +0200 (CEST)
Date: Mon, 23 Jun 2025 12:05:38 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Mario Limonciello <superm1@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v3 2/2] PCI: Fix runtime PM usage count underflow on
 device unplug
Message-ID: <aFkm8njX-NEIiTcv@wunner.de>
References: <20250620025535.3425049-1-superm1@kernel.org>
 <20250620025535.3425049-3-superm1@kernel.org>
 <aFcCaw_IZr-JuUYY@wunner.de>
 <8d4d98b6-fec5-466f-bd2c-059d702c7860@kernel.org>
 <aFeJ83O9PRUrM2Ir@wunner.de>
 <295bf182-7fed-4ffd-93a4-fb5ddf5f1bb4@kernel.org>
 <aFj3jUAM42lSyfpe@wunner.de>
 <aFkEI2jXg7YiwL7b@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFkEI2jXg7YiwL7b@wunner.de>

On Mon, Jun 23, 2025 at 09:37:07AM +0200, Lukas Wunner wrote:
> On Mon, Jun 23, 2025 at 08:43:25AM +0200, Lukas Wunner wrote:
> > On Sun, Jun 22, 2025 at 01:39:26PM -0500, Mario Limonciello wrote:
> > > > > On 6/21/25 2:05 PM, Lukas Wunner wrote:
> > > > > > So the refcount decrement happens in pcie_portdrv_probe() and
> > > > > > the refcount increment happens in pcie_portdrv_remove().
> > > > > > Both times it's conditional on pci_bridge_d3_possible().
> > > > > > Does that return a different value on probe versus remove?
> > > 
> > > I did this check and yes specifically on this PCIe port with the underflow
> > > the d3 possible lookup returns false during pcie_portdrv_remove().  It
> > > returns true during pcie_portdrv_probe().
> > 
> > That's not supposed to happen.  The expectation is that
> > pci_bridge_d3_possible() always returns the same value.
> 
> I'm wondering if the patch below fixes the issue?

Refined patch below with proper commit message,
also avoids a compiler warning caused by an unused variable.

-- >8 --

From: Lukas Wunner <lukas@wunner.de>
Subject: [PATCH] PCI/ACPI: Fix runtime PM ref imbalance on hot-plug capable
 ports

pcie_portdrv_probe() and pcie_portdrv_remove() both call
pci_bridge_d3_possible() to determine whether to use runtime power
management.  The underlying assumption is that pci_bridge_d3_possible()
always returns the same value because otherwise a runtime PM reference
imbalance occurs.

That assumption falls apart if the device is inaccessible on ->remove()
due to hot-unplug:  pci_bridge_d3_possible() calls pciehp_is_native(),
which accesses Config Space to determine whether the device is Hot-Plug
Capable.   An inaccessible device generally returns "all ones" for such
Config Read Requests.  Hence the device may seem Hot-Plug Capable on
->remove() even though it wasn't on ->probe().

Use the cached copy of the Hot-Plug Capable bit to avoid the Config Space
access and the resulting runtime PM ref imbalance.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/pci-acpi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index b78e0e4..8859cce 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -816,13 +816,11 @@ int pci_acpi_program_hp_params(struct pci_dev *dev)
 bool pciehp_is_native(struct pci_dev *bridge)
 {
 	const struct pci_host_bridge *host;
-	u32 slot_cap;
 
 	if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
 		return false;
 
-	pcie_capability_read_dword(bridge, PCI_EXP_SLTCAP, &slot_cap);
-	if (!(slot_cap & PCI_EXP_SLTCAP_HPC))
+	if (!bridge->is_hotplug_bridge)
 		return false;
 
 	if (pcie_ports_native)
-- 
2.47.2



Return-Path: <linux-pci+bounces-30683-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F465AE952B
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 07:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC82A3BB909
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 05:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F962628C;
	Thu, 26 Jun 2025 05:30:52 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBE54C83
	for <linux-pci@vger.kernel.org>; Thu, 26 Jun 2025 05:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750915852; cv=none; b=hXtOnbOB7iHVR74g6Lzrm9hMXxVfDotjvYWjqnd1MS/xuRNboQw0It5E9NEu8O9D6Yc0sOnR6FTS7ez0t3+l9MBQbLbYK/8HJAJyit0UmKvMjB9AgCdlIf1ML7F6QER7g1kjmCMNcNNN46OT17R2fUpSkgzS8WVtUuuThqOCN8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750915852; c=relaxed/simple;
	bh=0XftaOIIG/7/jWFKukKmWhX8B6a0haQqyFKygO5wK4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PekacE6001Kti3FuVoG2W8ZgVf+9P6wUGRialHCwJxL3y7q1PG9YsnJdXyaxYcl341PS0gACGLExHdUA6gEQEHirG+FPQt24iEJ0SoLR5CjV7Eks0LHG91gRK8TmqFt/nAnA9iZTKeeZ8s9IUVloB6tNxVu1TYGwej7J23Ci/W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id C9AA72009D10;
	Thu, 26 Jun 2025 07:30:40 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id B751D12D3CA; Thu, 26 Jun 2025 07:30:40 +0200 (CEST)
Date: Thu, 26 Jun 2025 07:30:40 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Laurent Bigonville <bigon@bigon.be>,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mika Westerberg <westeri@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/ACPI: Fix runtime PM ref imbalance on hot-plug
 capable ports
Message-ID: <aFzbALxN4jliWtmb@wunner.de>
References: <86c3bd52bda4552d63ffb48f8a30343167e85271.1750698221.git.lukas@wunner.de>
 <20250624142407.GA1473261@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624142407.GA1473261@bhelgaas>

On Tue, Jun 24, 2025 at 09:24:07AM -0500, Bjorn Helgaas wrote:
> On Mon, Jun 23, 2025 at 07:08:20PM +0200, Lukas Wunner wrote:
> > pcie_portdrv_probe() and pcie_portdrv_remove() both call
> > pci_bridge_d3_possible() to determine whether to use runtime power
> > management.  The underlying assumption is that pci_bridge_d3_possible()
> > always returns the same value because otherwise a runtime PM reference
> > imbalance occurs.
> > 
> > That assumption falls apart if the device is inaccessible on ->remove()
> > due to hot-unplug:  pci_bridge_d3_possible() calls pciehp_is_native(),
> > which accesses Config Space to determine whether the device is Hot-Plug
> > Capable.   An inaccessible device returns "all ones", which is converted
> > to "all zeroes" by pcie_capability_read_dword().  Hence the device no
> > longer seems Hot-Plug Capable on ->remove() even though it was on
> > ->probe().
> 
> This is pretty subtle; thanks for chasing it down.
> 
> It doesn't look like anything in pci_bridge_d3_possible() should 
> change over the life of the device, although acpi_pci_bridge_d3() is
> non-trivial.
> 
> Should we consider calling pci_bridge_d3_possible() only once and
> caching the result?  We already call it in pci_pm_init() and save the
> result in dev->bridge_d3.  That member can be changed by
> pci_bridge_d3_update(), but we could add another copy that we never
> update after pci_pm_init().
> 
> I worry a little that the fix is equally subtle and we could easily
> reintroduce this issue with future code reorganization.

I think this fix makes sense regardless of whether or not
the return value of pci_bridge_d3_possible() is cached:

Right now pciehp_is_native() reads the Hot-Plug	Capable	bit from
the register even though the bit is cached in pci_dev->is_hotplug_bridge
and pci_bridge_d3_possible() only calls pciehp_is_native() if that flag
is set.  In other words, pciehp_is_native() is re-checking the condition
under which it was called.  That's just nonsensical and superfluous.

There's only one other caller of pciehp_is_native() and that's
hotplug_is_native().  Only that other caller needs the register read,
so it should be moved there.

So I think the question of whether the pci_bridge_d3_possible() return
value should be cached is orthogonal to this patch.

Thanks,

Lukas


Return-Path: <linux-pci+bounces-30577-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90545AE78CE
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 09:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C6CE189388B
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 07:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7D71DC198;
	Wed, 25 Jun 2025 07:37:50 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14A272626
	for <linux-pci@vger.kernel.org>; Wed, 25 Jun 2025 07:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750837070; cv=none; b=gwOpCJA1zlG5IT9kyZImHXbHeKy67MiJWnA83fET0JW7RZO4Qcoz62+1JL/qi23IRumhnrFJmwnM/2JqYRHKHW92tiXa7RDTccFtda8CMwkk2GY+E6xQFxYJsUo+iarEV3dXqEeifyHx+06lkt35LZ3MUP4bmCUgLyFlUBwWBJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750837070; c=relaxed/simple;
	bh=B3TDpSRtafxe1v6Rt4x+cYS2KtQSCfonWa8o0vaGG7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDZRiQYIFcbd2M2fFQ7XjobeOOr8Tv6goHNVW8lDMBRn8mwmgkZozBjYDjkaXrpZ8A1hh/wXhZAybrInE/aYBU3OZ/DTub4uii6kT7g34X3MqN2KuRNY++P+mWTSDr4q3P7RdXH0uhtqmMH1Ltr5IVZiv4EN6cOdqhRnfyn7da0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 05E1C2C051CF;
	Wed, 25 Jun 2025 09:37:39 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id C84843C7E4; Wed, 25 Jun 2025 09:37:38 +0200 (CEST)
Date: Wed, 25 Jun 2025 09:37:38 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Laurent Bigonville <bigon@bigon.be>,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mika Westerberg <westeri@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/ACPI: Fix runtime PM ref imbalance on hot-plug
 capable ports
Message-ID: <aFunQlDHNyQV4S_W@wunner.de>
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

If we did that, I think we'd still want to have a WARN_ON() like this in
pcie_portdrv_remove():

+	WARN_ON(dev->bridge_d3_orig != pci_bridge_d3_possible(dev));
+
+	if (dev->bridge_d3_orig) {
-	if (pci_bridge_d3_possible(dev)) {

Because without the WARN_ON(), such bugs would fly under the radar.

However currently we get the WARN_ON() for free because of the runtime PM
refcount underflow.

So caching the original return value of pci_bridge_d3_possible(dev)
wouldn't be a net positive.

Also note that the bug isn't catastrophic:  The struct device is about
to be free()'d anyway because it's been hot-removed.  It's just the
annoying warning message that we want to get rid of.

But maybe we should amend the kernel-doc of pci_bridge_d3_possible()
to clearly state that the return value must be constant across the
entire lifetime of the device.  For me that's obvious because I was
involved when the code was originally conceived, but I realized upon
seeing Mario's attempts to solve this that it may not be obvious at all
for anyone else.

Thanks,

Lukas


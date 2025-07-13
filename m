Return-Path: <linux-pci+bounces-32029-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C8EB031BE
	for <lists+linux-pci@lfdr.de>; Sun, 13 Jul 2025 17:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC19A7A9C45
	for <lists+linux-pci@lfdr.de>; Sun, 13 Jul 2025 15:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FF613BC0C;
	Sun, 13 Jul 2025 15:31:41 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7C2279917
	for <linux-pci@vger.kernel.org>; Sun, 13 Jul 2025 15:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752420701; cv=none; b=s2H0FqS0I7icFahj7d1V1oZVH47xxOw+aUur2AcrDAGSPKf0oOJz50FTJ0+/0BsnieA/VJUsKunmfIiiT9nE7ZoerxuKVFrkA5vESB40EBGDJgifg2YgKoH2sQWq4TFLS/b7UUoAnvQRFM5eNrMs+q89qrcr1jxRT2iXtkOVpO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752420701; c=relaxed/simple;
	bh=4hUlsIltl12wYULCw3+yi/8DyIsMWroKLMDgYoc9U6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/EjCg/ev9cC5fKKpUEu56xmyBfM09wwdRvPx115ExSy1i6fWnJ1FZycbVoTq0W2QPoaX8PxlJJgopnzFCGzdxjOYOjQnjt/Iqsxg6aVNvewgcuvl1GXXMCQ7QaON+8BZZ5zVXRbGmO/uYf5ZpHF7E4vlGoX18nvHgfCDivZhFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id CDC0C2C0664A;
	Sun, 13 Jul 2025 17:20:56 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id BC8B041881E; Sun, 13 Jul 2025 17:20:56 +0200 (CEST)
Date: Sun, 13 Jul 2025 17:20:56 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Laurent Bigonville <bigon@bigon.be>,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mika Westerberg <westeri@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/ACPI: Fix runtime PM ref imbalance on hot-plug
 capable ports
Message-ID: <aHPO2Ci6nhjdb7Uu@wunner.de>
References: <86c3bd52bda4552d63ffb48f8a30343167e85271.1750698221.git.lukas@wunner.de>
 <20250627025607.GA1650254@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627025607.GA1650254@bhelgaas>

On Thu, Jun 26, 2025 at 09:56:07PM -0500, Bjorn Helgaas wrote:
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
> > 
> > The resulting runtime PM ref imbalance causes errors such as:
> > 
> >   pcieport 0000:02:04.0: Runtime PM usage count underflow!
> > 
> > The Hot-Plug Capable bit is cached in pci_dev->is_hotplug_bridge.
> 
> pci_dev->is_hotplug_bridge is not just a cache of PCI_EXP_SLTCAP_HPC;
> it can also be set in two other cases.  Example below.
[...]
> If we have a bridge where bridge->is_hotplug_bridge=1 from the acpiphp
> check_hotplug_bridge() or quirk_hotplug_bridge(), and the bridge has
> no Slot or a Slot with PCI_EXP_SLTCAP_HPC=0, we previously returned
> false here but may now return true.  That seems like a problem, but
> maybe I'm missing the reason why it is not an issue.

You're absolutely right, thanks for spotting this.
I'm respinning the patch as part of a larger series:

https://lore.kernel.org/r/cover.1752390101.git.lukas@wunner.de

It seems to me we should cache PCI_EXP_SLTCAP_HPC, rather than
the result of pci_bridge_d3_possible().  That allows cleaning up
is_hotplug_bridge usage and fix a few bugs in that area.

(As an aside, quirk_hotplug_bridge() is for a Conventional PCI hotplug
bridge.  Hence I'm mentioning Conventional PCI in addition to ACPI slots
in a number of code comments and commit messages in the above-linked
series.)

> If the new semantics are what we want, that would be great because I
> think we could probably set host->native_pcie_hotplug up front based
> on CONFIG_HOTPLUG_PCI_PCIE and pcie_ports_native, and
> pciehp_is_native() would collapse to just an accessor for
> host->native_pcie_hotplug.

I've looked into it, see patch [5/5] of the series.  It turns out,
we can get rid of the pcie_ports_native check in pciehp_is_native(),
but not the CONFIG_HOTPLUG_PCI_PCIE check.  So it's only a partial
solution.  And it has the downside that the pcie_ports_native
variable is no longer confined to the PCI core, it now leaks into
ACPI PCI code.  Which means future canges in that area will involve
ACPI and require an ack from Rafael.  Your decision whether that's a
net-positive.  Feel free to ignore the patch if you think it's not!

Thanks!

Lukas


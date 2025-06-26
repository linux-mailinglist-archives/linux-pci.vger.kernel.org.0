Return-Path: <linux-pci+bounces-30682-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7D1AE9521
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 07:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E9F0189C9B0
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 05:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89F181724;
	Thu, 26 Jun 2025 05:20:32 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD6920DD49
	for <linux-pci@vger.kernel.org>; Thu, 26 Jun 2025 05:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750915232; cv=none; b=ow32fhFY4jo1eX4o9kmKW7MPgMg3ptE3irIY6e5mGZfYfOHmoF8GOXIBoCccT7D477qz+ZnHSNbm8rDbjXDqERTko0ReiNANtJ3mt7vP2ZMEhwAf5ZgLpSdfcvWWtkEAAEEkqYAoGMCyNEg8OgM+bfp9dAqH75YrDNE8RxgXL4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750915232; c=relaxed/simple;
	bh=AU2Pkd6jkeKcPI8C2zotJHO76VMpjZnLTawYMufv+XU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ersn0791NkGCNUAkJYvTd9G6XAD1L5LB1WtdxNd+qobu8cyhFH23wQi0G2QT+dlDrGkZJBrKHNJX6DCi/l65inOtkAQqpNPAIa5I8xPdJK52Fnja6KInafrBAosX381XAoQI2cp8/Y7+866JYimICHqyDkD0EVrQqhk41iZWj3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 952752C0666F;
	Thu, 26 Jun 2025 07:20:26 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 7ED793BEE0B; Thu, 26 Jun 2025 07:20:26 +0200 (CEST)
Date: Thu, 26 Jun 2025 07:20:26 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Laurent Bigonville <bigon@bigon.be>,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mika Westerberg <westeri@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/ACPI: Fix runtime PM ref imbalance on hot-plug
 capable ports
Message-ID: <aFzYmpxOlRdRFTfl@wunner.de>
References: <aFunQlDHNyQV4S_W@wunner.de>
 <20250625193231.GA1582741@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625193231.GA1582741@bhelgaas>

On Wed, Jun 25, 2025 at 02:32:31PM -0500, Bjorn Helgaas wrote:
> On Wed, Jun 25, 2025 at 09:37:38AM +0200, Lukas Wunner wrote:
> > On Tue, Jun 24, 2025 at 09:24:07AM -0500, Bjorn Helgaas wrote:
> > > It doesn't look like anything in pci_bridge_d3_possible() should 
> > > change over the life of the device, although acpi_pci_bridge_d3() is
> > > non-trivial.
> > > 
> > > Should we consider calling pci_bridge_d3_possible() only once and
> > > caching the result?  We already call it in pci_pm_init() and save the
> > > result in dev->bridge_d3.  That member can be changed by
> > > pci_bridge_d3_update(), but we could add another copy that we never
> > > update after pci_pm_init().
> > 
> > If we did that, I think we'd still want to have a WARN_ON() like this in
> > pcie_portdrv_remove():
> > 
> > +	WARN_ON(dev->bridge_d3_orig != pci_bridge_d3_possible(dev));
> > +
> > +	if (dev->bridge_d3_orig) {
> > -	if (pci_bridge_d3_possible(dev)) {
> > 
> > Because without the WARN_ON(), such bugs would fly under the radar.
> > 
> > However currently we get the WARN_ON() for free because of the runtime PM
> > refcount underflow.
> > 
> > So caching the original return value of pci_bridge_d3_possible(dev)
> > wouldn't be a net positive.
[...]
> But I feel like I'm missing your point about bugs flying under the
> radar.  Having portdrv keep track of whether it did runtime PM setup
> (i.e., the pci_bridge_d3_possible() state at .probe()-time) is
> functionally the same as having struct pci_dev keep track of it, so
> the bugs you're referring to could still fly under the radar.

So the return value of pci_bridge_d3_possible() should never change
over the lifetime of a device.  We're also invoking that function
from pci_bridge_d3_update() and the logic would no longer work
if the return value changed.

My point is that we're currently verifying that the return value
hasn't changed by regenerating it in pcie_portdrv_remove().
If it *has* changed, the runtime PM ref imbalance occurs and we get
a warning message.
If we instead cached the value in pcie_portdrv_probe(), we wouldn't
have found this bug.

Does that make sense?

Thanks,

Lukas


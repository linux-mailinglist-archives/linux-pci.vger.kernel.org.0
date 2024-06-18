Return-Path: <linux-pci+bounces-8924-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B39C990DA1A
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 18:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 895F928AC83
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 16:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40ED7D3E2;
	Tue, 18 Jun 2024 16:56:52 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6BF1CA80
	for <linux-pci@vger.kernel.org>; Tue, 18 Jun 2024 16:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718729812; cv=none; b=HNJU3hLFu8p3ZycAi1oY2g5X0teAFocNsM2/Wn43QWZyLxL23AogEjA9Hj1G4TAdKENVdFYy7TJhdvA6VZhwyeBROxzFULYbC4iNiLYkRP7YNGIOBW9pffCTJtvyc29aWEAvZkr/B0FU8pWOuG9UyyzXL97yi9KoTi0+DQL+s4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718729812; c=relaxed/simple;
	bh=gfnpfJUbLmEGrIUXUC9d2daegto3A3iAWhjsr1/ovFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RuWiOzZivi/MyOEZAlIVJvrrGKJafAUAG71vS/q45Q+rFDlGxU/nH6TPwNdH/+880un4KxjMwx5DzDENxkHLY2ERRjzO8hk1aLDn6zBYT2tN0VpgTCs83RLeObnTytz+AS454AJSAT5i/gMnOrbIJHi/3Tfwi4ddPqXa0D1h7YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 624A0300018D6;
	Tue, 18 Jun 2024 18:56:40 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 4E72B3072D9; Tue, 18 Jun 2024 18:56:40 +0200 (CEST)
Date: Tue, 18 Jun 2024 18:56:40 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/DPC: Fix use-after-free on concurrent DPC and
 hot-removal
Message-ID: <ZnG8SHwGbot1JmHn@wunner.de>
References: <8e4bcd4116fd94f592f2bf2749f168099c480ddf.1718707743.git.lukas@wunner.de>
 <ZnGx8PN6CWGmUC6J@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnGx8PN6CWGmUC6J@kbusch-mbp.dhcp.thefacebook.com>

On Tue, Jun 18, 2024 at 10:12:32AM -0600, Keith Busch wrote:
> On Tue, Jun 18, 2024 at 12:54:55PM +0200, Lukas Wunner wrote:
> > However starting with v6.3, pci_bridge_wait_for_secondary_bus() is also
> > called on a DPC event.  Commit 53b54ad074de ("PCI/DPC: Await readiness
> > of secondary bus after reset"), which introduced that, failed to
> > appreciate that pci_bridge_wait_for_secondary_bus() now needs to hold a
> > reference on the child device because dpc_handler() and pciehp may
> > indeed run concurrently.  The commit was backported to v5.10+ stable
> > kernels, so that's the oldest one affected.
> 
> Caution on applying this to 5.10 and 5.15 stable branches: they don't
> have the fancy "__free" cleanup you're using here. The newer active
> stables are okay, though.

I'll let Greg & Sasha know when they start applying this to stable
kernels that ced085ef369a is a prerequisite for v5.10-stable and
v5.15-stable.  I can rework the patch if they don't want to apply
ced085ef369a to these older versions.

Thanks,

Lukas


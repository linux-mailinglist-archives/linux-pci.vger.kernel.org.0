Return-Path: <linux-pci+bounces-44919-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D67AFD23478
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 09:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 119F3300FBD5
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 08:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1014B33E375;
	Thu, 15 Jan 2026 08:52:16 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EA532AAD8;
	Thu, 15 Jan 2026 08:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768467136; cv=none; b=a9Jjpp5/YcI00nF/MOTHBe1apfaEOHclu5qqNdUKdPbqeln72msmStjsNq9qyJ1wTfCKyj8EKIxq0hCz6Yrsdo37euzejz12FGxe6yLkABCWMRVeGS2zjll+CgeILMpICEKFPjSBomf8Mt9UJunHwl+YBEXG3hBeLHMVzM3NrxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768467136; c=relaxed/simple;
	bh=1dsGClL/O2ryNZ3pwYlswDwkNBWNCemZ+YBASejNmRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=djlIg9bB9yVQzm8ngwmoNIMH2Wn+kapVLyZmepD8z4DssFYs39bb6vlwahO/GxAoOD4+ZzUflgROdRXH/1l2MRyj4G/SWr3cG5gnh0J49iZKd8tes7L4AJ5zGUbFrdyboKVTDJJzrShaiH/71X301Sy3JzM8tsP9ymfu4o3oiU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 023A42008018;
	Thu, 15 Jan 2026 09:44:41 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id DC6A010A9F; Thu, 15 Jan 2026 09:44:40 +0100 (CET)
Date: Thu, 15 Jan 2026 09:44:40 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH] PCI/portdrv: Allow probing even without child services
Message-ID: <aWio-NB1csIhZJen@wunner.de>
References: <20260109152013.1.I5fd5d83f518681b3949d8ab2f16ba8244fd3e774@changeid>
 <aWHtbGzVRRpa9kd0@wunner.de>
 <aWfuyw3JHD-1F5uZ@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWfuyw3JHD-1F5uZ@google.com>

On Wed, Jan 14, 2026 at 11:30:19AM -0800, Brian Norris wrote:
> On Sat, Jan 10, 2026 at 07:10:52AM +0100, Lukas Wunner wrote:
> > On Fri, Jan 09, 2026 at 03:20:13PM -0800, Brian Norris wrote:
> > > @@ -355,29 +355,18 @@ static int pcie_port_device_register(struct pci_dev *dev)
> > >  	if (status) {
> > >  		capabilities &= PCIE_PORT_SERVICE_HP;
> > >  		if (!capabilities)
> > > -			goto error_disable;
> > > +			return 0;
> > >  	}
> > 
> > This will keep the Bus Master Enable bit set (see call to
> > pci_set_master() further up in the function), even though
> > no MSIs are expected from the device.  (I *think* these
> > would be the only memory writes that a port would perform.)
> > 
> > That doesn't seem right.  If there are no services, it seems
> > prudent to clear Bus Master Enable again (as is done by
> > pci_disable_device() right now).
> 
> Seems like a reasonable suggestion. I'll try pci_clear_master() in some
> of these no-op non-failure cases.
> 
> Do you have the same concerns if pcie_init_service_irqs() falls back to
> INTx but does not fail? It seems like a potentially fraught exercise to
> guess what child services might need bus mastering though, so maybe it's
> better to limit this only to nr_service==0 cases?

Sounds reasonable to me to constrain to nr_service==0.
Basically just retain the existing behavior.

I note that pcie_portdrv_remove() calls pci_disable_device()
unconditionally.  You may need an extra struct with an extra flag
to remember whether pci_disable_device() needs to be called on remove.

Thanks,

Lukas


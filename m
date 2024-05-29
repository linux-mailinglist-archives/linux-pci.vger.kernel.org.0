Return-Path: <linux-pci+bounces-8011-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE3B8D3331
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 11:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EB9D1F26949
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 09:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAB616A36F;
	Wed, 29 May 2024 09:38:24 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E609716DEB1
	for <linux-pci@vger.kernel.org>; Wed, 29 May 2024 09:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716975504; cv=none; b=hsqGvruCLXV1rxDqUMt9KceIvbb7FPwBgFzhdEVgEkZZynBgJS7rdY5WlRzncfrWlMdA0oQhrvTpUHEduRqHb8FdOaHVVCLbndj2oYDJskAvkYWyKOH/mZo97qGNPRZFPBENVmR7Lc9EwVUBspKeW27tY8k7OCH5fUOig1ZocWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716975504; c=relaxed/simple;
	bh=4XJJgGtWpKIBlEPyJagbdvOUmbd+0hW1lFDdf6ixBtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JW0nCyoMn3x0yHXj0pRZHbyEE/ZuzX8AjnVg3tS4e80Wp4DzrJTDoc7Dx79Xsy8t7qW4peF/Rd0Yd18ifytW8b6j8icybKfsuZQ9w+2hgBG6H0aNmuKziICLA65KYm4NOqhg1dKxaAw9MG67MRRQjzrCqwb9KD+KeswpRXD6j+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 8DE6D2800C983;
	Wed, 29 May 2024 11:38:12 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 5F7E770E9C8; Wed, 29 May 2024 11:38:12 +0200 (CEST)
Date: Wed, 29 May 2024 11:38:12 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
	linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Keith Busch <kbusch@kernel.org>, Marek Behun <marek.behun@nic.cz>,
	Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: Re: [PATCH v2 2/3] PCI/NPEM: Add Native PCIe Enclosure Management
 support
Message-ID: <Zlb3hGR45SWJ1KuL@wunner.de>
References: <20240528131940.16924-1-mariusz.tkaczyk@linux.intel.com>
 <20240528131940.16924-3-mariusz.tkaczyk@linux.intel.com>
 <6656bb4654a65_16687294c0@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6656bb4654a65_16687294c0@dwillia2-mobl3.amr.corp.intel.com.notmuch>

On Tue, May 28, 2024 at 10:21:10PM -0700, Dan Williams wrote:
> Mariusz Tkaczyk wrote:
> > +config PCI_NPEM
> > +	bool "Native PCIe Enclosure Management"
> > +	depends on LEDS_CLASS=y
> 
> I would have expected
> 
>     depends on NEW_LEDS
>     select LEDS_CLASS

Hm, a quick "git grep -C 2 'depends on NEW_LEDS'" shows that noone else
does that.  Everyone else either selects both NEW_LEDS and LEDS_CLASS
or depends on both or depends on just LEDS_CLASS.

(Since LEDS_CLASS is constrained to "if NEW_LEDS", depending on both
seems pointless, so I'm not sure why some people do that.)

I guess it would be good to get guidance from leds maintainers what
the preferred modus operandi is.


> > +#define for_each_indication(ind, inds) \
> > +	for (ind = inds; ind->bit; ind++)
> > +
> > +/* To avoid confusion, do not keep any special bits in indications */
> 
> I am confused by this comment. What "special bits" is this referring to?

I think it's referring to bit 0 in the Status and Control register,
which is a master "NPEM Capable" and "NPEM Enable" bit.


> > +struct npem_ops {
> > +	const struct indication *inds;
> 
> @inds is not an operation, it feels like something that belongs as
> another member in 'struct npem'. What drove this data to join 'struct
> npem_ops'?

The native NPEM register interface supports enclosure-specific indications
which the DSM interface does not support.  So those indications are
present in the native npem_ops->inds and not present in the DSM
npem_ops->inds.


> > --- a/include/uapi/linux/pci_regs.h
> > +++ b/include/uapi/linux/pci_regs.h
[...]
> > +#define  PCI_NPEM_IND_SPEC_0		0x00800000
> > +#define  PCI_NPEM_IND_SPEC_1		0x01000000
> > +#define  PCI_NPEM_IND_SPEC_2		0x02000000
> > +#define  PCI_NPEM_IND_SPEC_3		0x04000000
> > +#define  PCI_NPEM_IND_SPEC_4		0x08000000
> > +#define  PCI_NPEM_IND_SPEC_5		0x10000000
> > +#define  PCI_NPEM_IND_SPEC_6		0x20000000
> > +#define  PCI_NPEM_IND_SPEC_7		0x40000000
> 
> Given no other driver needs this, I would define them locally in
> drivers/pci/npem.c.

This is a uapi header, so could be used not just by other drivers
but by user space.

It's common to add spec-defined register bits to this header file
even if they're only used by a single source file in the kernel.

Thanks,

Lukas


Return-Path: <linux-pci+bounces-8667-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B21905182
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 13:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85F121C21DC7
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 11:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA80F155CA3;
	Wed, 12 Jun 2024 11:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U47etS04"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46096F2F0
	for <linux-pci@vger.kernel.org>; Wed, 12 Jun 2024 11:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718192419; cv=none; b=PJF7M29en8ZYjBbEPtULe5APeGZxdi3rJzlr3tTIBI+iuPUDQgsSxd/RNzZy0ViWrfgB4SSZtUmABHcgYfmsOCdS9Aq9Al10v/qUjcoxBq8dXLDZQghwLAPa4eeZkTj0SxIk183d/rMitS1YjQnALa4gxRBBwfeQT9LKXKbkvpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718192419; c=relaxed/simple;
	bh=qWc6IWUqvUtsUxluQZqNVaVEuW//Soei/XfWLqMeUJo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T7ZXpDRmwXa2Oey0Ut/rLbBWow2JoP0ALlpPSx3+p/l8L7BZR1DYwheSwtXDNfJCjkQbAcr0RcajEj3zppQ6JEQqqU6ocOEr5d8dT1HgeHdOp3iYFMV1OOuWeo0lJzFexs6iGYL+3XGUbSdbdAtmA+w0PjtErOlgcHDnyskY3AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U47etS04; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718192417; x=1749728417;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qWc6IWUqvUtsUxluQZqNVaVEuW//Soei/XfWLqMeUJo=;
  b=U47etS04fAAEZ7R7MlZG9x+EF+kRPlaMS7kd6iE41G2ZoJcR55yvu7JF
   RCEF7R004q2TAFosS/BoC6UDt5EcabwUlpV+1iinA6h82tKi8skwZEiQW
   PIiMQ9fSYCTUau0YXq+ssogUM8+hKmQKLNallOoEUFBeYusFBvc5TM3K+
   4v2vJmqR/ktm6KBE1JvpB0VMqIjbSnE49EZqbGSPR/5dvLRysOp0tGemJ
   YjV1iMaLgLL+Uo3kWZFmrY9demxcDcBs00LjX/g9fUKCGbwF2kGdTD2vT
   fE1/7BbiZiKa3nbHcNZdNEIczNTW5Nt7z0HVMyPjJgj0mGEFZtMHLPAmJ
   g==;
X-CSE-ConnectionGUID: B+UycZ5RSB+TEnlIdgAUrQ==
X-CSE-MsgGUID: wiRKlRTAQZWxPUNXUNmkYw==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="26371329"
X-IronPort-AV: E=Sophos;i="6.08,233,1712646000"; 
   d="scan'208";a="26371329"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 04:40:17 -0700
X-CSE-ConnectionGUID: zdJkeAKJStS/mBRXKljp5Q==
X-CSE-MsgGUID: u2ikoIaIQtmiIp8SvSrD4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,233,1712646000"; 
   d="scan'208";a="40238502"
Received: from mtkaczyk-mobl.ger.corp.intel.com (HELO localhost) ([10.245.112.252])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 04:40:14 -0700
Date: Wed, 12 Jun 2024 13:40:09 +0200
From: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>, Pavel Machek <pavel@ucw.cz>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-pci@vger.kernel.org, Arnd
 Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Ilpo Jarvinen
 <ilpo.jarvinen@linux.intel.com>, Keith Busch <kbusch@kernel.org>, Marek
 Behun <marek.behun@nic.cz>, Randy Dunlap <rdunlap@infradead.org>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Stuart Hayes
 <stuart.w.hayes@gmail.com>
Subject: Re: [PATCH v2 2/3] PCI/NPEM: Add Native PCIe Enclosure Management
 support
Message-ID: <20240612134009.00002864@linux.intel.com>
In-Reply-To: <Zlb3hGR45SWJ1KuL@wunner.de>
References: <20240528131940.16924-1-mariusz.tkaczyk@linux.intel.com>
	<20240528131940.16924-3-mariusz.tkaczyk@linux.intel.com>
	<6656bb4654a65_16687294c0@dwillia2-mobl3.amr.corp.intel.com.notmuch>
	<Zlb3hGR45SWJ1KuL@wunner.de>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,
Thanks for feedback Dan!

On Wed, 29 May 2024 11:38:12 +0200
Lukas Wunner <lukas@wunner.de> wrote:

> On Tue, May 28, 2024 at 10:21:10PM -0700, Dan Williams wrote:
> > Mariusz Tkaczyk wrote:  
> > > +config PCI_NPEM
> > > +	bool "Native PCIe Enclosure Management"
> > > +	depends on LEDS_CLASS=y  
> > 
> > I would have expected
> > 
> >     depends on NEW_LEDS
> >     select LEDS_CLASS  
> 
> Hm, a quick "git grep -C 2 'depends on NEW_LEDS'" shows that noone else
> does that.  Everyone else either selects both NEW_LEDS and LEDS_CLASS
> or depends on both or depends on just LEDS_CLASS.
> 
> (Since LEDS_CLASS is constrained to "if NEW_LEDS", depending on both
> seems pointless, so I'm not sure why some people do that.)
> 
> I guess it would be good to get guidance from leds maintainers what
> the preferred modus operandi is.

Pavel, could you please advice?
I have no clue which way I should take so I prefer to keep current approach.

> 
> 
> > > +#define for_each_indication(ind, inds) \
> > > +	for (ind = inds; ind->bit; ind++)
> > > +
> > > +/* To avoid confusion, do not keep any special bits in indications */  
> > 
> > I am confused by this comment. What "special bits" is this referring to?  
> 
> I think it's referring to bit 0 in the Status and Control register,
> which is a master "NPEM Capable" and "NPEM Enable" bit.

Yes, there are 2 special bits for capability/control
NPEM_CAP_CAPABLE/NPEM_ENABLE and NPEM_CAP_RESET/NPEM_RESET.

I wanted to highlight that these bits are not included in the cache. I will try
to make it more precise in v3.

> 
> 
> > > +struct npem_ops {
> > > +	const struct indication *inds;  
> > 
> > @inds is not an operation, it feels like something that belongs as
> > another member in 'struct npem'. What drove this data to join 'struct
> > npem_ops'?  
> 
> The native NPEM register interface supports enclosure-specific indications
> which the DSM interface does not support.  So those indications are
> present in the native npem_ops->inds and not present in the DSM
> npem_ops->inds.

Yes, I need to differentiate DSM and NPEM indications. DSM has own indications
list.

> 
> 
> > > --- a/include/uapi/linux/pci_regs.h
> > > +++ b/include/uapi/linux/pci_regs.h  
> [...]
> > > +#define  PCI_NPEM_IND_SPEC_0		0x00800000
> > > +#define  PCI_NPEM_IND_SPEC_1		0x01000000
> > > +#define  PCI_NPEM_IND_SPEC_2		0x02000000
> > > +#define  PCI_NPEM_IND_SPEC_3		0x04000000
> > > +#define  PCI_NPEM_IND_SPEC_4		0x08000000
> > > +#define  PCI_NPEM_IND_SPEC_5		0x10000000
> > > +#define  PCI_NPEM_IND_SPEC_6		0x20000000
> > > +#define  PCI_NPEM_IND_SPEC_7		0x40000000  
> > 
> > Given no other driver needs this, I would define them locally in
> > drivers/pci/npem.c.  
> 
> This is a uapi header, so could be used not just by other drivers
> but by user space.
> 
> It's common to add spec-defined register bits to this header file
> even if they're only used by a single source file in the kernel.
> 

I will stay with current state while waiting for Bjorn's voice here.

I will send v3 with fixes requested by Dan and Ilpo but I still need Stuart
feedback on DSM patch.

Thanks,
Mariusz


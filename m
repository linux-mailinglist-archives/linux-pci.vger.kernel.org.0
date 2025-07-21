Return-Path: <linux-pci+bounces-32626-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F47B0BEB0
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 10:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9702B160A05
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 08:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87311283FE1;
	Mon, 21 Jul 2025 08:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eM8nxIZe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2535218593;
	Mon, 21 Jul 2025 08:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753086056; cv=none; b=cas9GNFMn260N1RdH9c4sGB8tHWNzNryq9YCtxY6vBrypMYrP2MPqgLwbEOMJ7xEskCziKoOG8UQS7FjVxf7mt1Nzb2z6340PJONxV0i0THwBFgYU5ShNMR68fjwU65YoQHUbac+8fzYn6db3i3VdwnSlZZ1/c1WK0lD9TGhGno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753086056; c=relaxed/simple;
	bh=mwwy26YuAuU7rP6YljFYLkH6SdwYhat+AAosw36Hj2s=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=meMyAxoEi38qEsxlQRj25bG0fSpV+Lbkccq+CHO50vjneOgxQ+2VlTSWQSbk8DQbKUoGuOSzTw8MLqK+TRgbzkjeTV9/C5lzgTEJOULhR1mblgCH9ye8Bp9FdaEV+E3H+zmrKfGGZDc0loSmJCPCG05KWsoU1j3oSJ2YBqAIr24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eM8nxIZe; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753086054; x=1784622054;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=mwwy26YuAuU7rP6YljFYLkH6SdwYhat+AAosw36Hj2s=;
  b=eM8nxIZeuVjDojRXOeMTjideALP6fqYCjdGPgt0ULPi/IXrMz9Sed7/G
   ZaVDJAzobPRZiNE3eMOb3ijtVk611LeI0/tuFd15u2QKl3VXna77R6ySJ
   rjUoKgRcnDn0Km1rSDlbgPPSK9c5m0Aix95/GTLjlooqVRYfbqT78g2U6
   F4B+1j8hT1LYzqZ4MLv1F6eP6CFHljZb0YebzJ8CBBIb8O0YyB6GnYAoP
   b7MggwatOcDU3XUkg5KFPcriW+FYgWzzlaJs6RXNjcwFeGvMEaeSpbUWa
   T8Gloryo4tntE0fmzwFIrXSgzIFhNuUXIB7H0v6U5PonaRs9LLEB9rGLo
   Q==;
X-CSE-ConnectionGUID: /JguQsw9TnSfTNT7i7gCZg==
X-CSE-MsgGUID: F7XzyhbUT6qg91tYEU7tVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11498"; a="66642059"
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="66642059"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 01:20:54 -0700
X-CSE-ConnectionGUID: X9h7F1+/T4merf/BTnL3Jg==
X-CSE-MsgGUID: 3aLyU92KSAaJwQXh+yAuPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="182479935"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 01:20:50 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 21 Jul 2025 11:20:46 +0300 (EEST)
To: Hans Zhang <18255117159@163.com>
cc: Bjorn Helgaas <helgaas@kernel.org>, lpieralisi@kernel.org, 
    bhelgaas@google.com, mani@kernel.org, kwilczynski@kernel.org, 
    robh@kernel.org, jingoohan1@gmail.com, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v13 3/6] PCI: Refactor capability search into common
 macros
In-Reply-To: <903ea9c4-87d6-45a8-9825-4a0d45ec608f@163.com>
Message-ID: <d59fde6e-3e4a-248a-ae56-c35b4c6ec44c@linux.intel.com>
References: <20250715224705.GA2504490@bhelgaas> <903ea9c4-87d6-45a8-9825-4a0d45ec608f@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 17 Jul 2025, Hans Zhang wrote:

> 
> 
> On 2025/7/16 06:47, Bjorn Helgaas wrote:
> > On Sun, Jun 08, 2025 at 12:14:02AM +0800, Hans Zhang wrote:
> > > The PCI Capability search functionality is duplicated across the PCI core
> > > and several controller drivers. The core's current implementation requires
> > > fully initialized PCI device and bus structures, which prevents controller
> > > drivers from using it during early initialization phases before these
> > > structures are available.
> > > 
> > > Move the Capability search logic into a header-based macro that accepts a
> > > config space accessor function as an argument. This enables controller
> > > drivers to perform Capability discovery using their early access
> > > mechanisms prior to full device initialization while sharing the
> > > Capability search code.
> > > 
> > > Convert the existing PCI core Capability search implementation to use this
> > > new macro. Controller drivers can later use the same macros with their
> > > early access mechanisms while maintaining the existing protection against
> > > infinite loops through preserved TTL checks.
> > > 
> > > The ttl parameter was originally an additional safeguard to prevent
> > > infinite loops in corrupted config space. However, the
> > > PCI_FIND_NEXT_CAP_TTL() macro already enforces a TTL limit internally.
> > > Removing redundant ttl handling simplifies the interface while maintaining
> > > the safety guarantee. This aligns with the macro's design intent of
> > > encapsulating TTL management.
> > 
> > This is a big gulp, but I think I like it :)  It really enables some
> > nice cleanups later.
> > 
> > > -static u8 __pci_find_next_cap_ttl(struct pci_bus *bus, unsigned int
> > > devfn,
> > > -				  u8 pos, int cap, int *ttl)
> > > -{
> > > -	u8 id;
> > > -	u16 ent;
> > > -
> > > -	pci_bus_read_config_byte(bus, devfn, pos, &pos);
> > > -
> > > -	while ((*ttl)--) {
> > > -		if (pos < PCI_STD_HEADER_SIZEOF)
> > > -			break;
> > > -		pos = ALIGN_DOWN(pos, 4);
> > > -		pci_bus_read_config_word(bus, devfn, pos, &ent);
> > > -
> > > -		id = FIELD_GET(PCI_CAP_ID_MASK, ent);
> > > -		if (id == 0xff)
> > > -			break;
> > > -		if (id == cap)
> > > -			return pos;
> > > -		pos = FIELD_GET(PCI_CAP_LIST_NEXT_MASK, ent);
> > > -	}
> > > -	return 0;
> > > -}
> > > -
> > >   static u8 __pci_find_next_cap(struct pci_bus *bus, unsigned int devfn,
> > >   			      u8 pos, int cap)
> > >   {
> > > -	int ttl = PCI_FIND_CAP_TTL;
> > > -
> > > -	return __pci_find_next_cap_ttl(bus, devfn, pos, cap, &ttl);
> > > +	return PCI_FIND_NEXT_CAP_TTL(pci_bus_read_config, pos, cap, bus,
> > > devfn);
> > >   }
> > >     u8 pci_find_next_capability(struct pci_dev *dev, u8 pos, int cap)
> > > @@ -554,42 +527,11 @@ EXPORT_SYMBOL(pci_bus_find_capability);
> > >    */
> > >   u16 pci_find_next_ext_capability(struct pci_dev *dev, u16 start, int
> > > cap)
> > >   {
> > > -	u32 header;
> > > -	int ttl;
> > > -	u16 pos = PCI_CFG_SPACE_SIZE;
> > > -
> > > -	/* minimum 8 bytes per capability */
> > > -	ttl = (PCI_CFG_SPACE_EXP_SIZE - PCI_CFG_SPACE_SIZE) / 8;
> > > -
> > >   	if (dev->cfg_size <= PCI_CFG_SPACE_SIZE)
> > >   		return 0;
> > >   -	if (start)
> > > -		pos = start;
> > > -
> > > -	if (pci_read_config_dword(dev, pos, &header) != PCIBIOS_SUCCESSFUL)
> > > -		return 0;
> > > -
> > > -	/*
> > > -	 * If we have no capabilities, this is indicated by cap ID,
> > > -	 * cap version and next pointer all being 0.
> > > -	 */
> > > -	if (header == 0)
> > > -		return 0;
> > > -
> > > -	while (ttl-- > 0) {
> > > -		if (PCI_EXT_CAP_ID(header) == cap && pos != start)
> > > -			return pos;
> > > -
> > > -		pos = PCI_EXT_CAP_NEXT(header);
> > > -		if (pos < PCI_CFG_SPACE_SIZE)
> > > -			break;
> > > -
> > > -		if (pci_read_config_dword(dev, pos, &header) !=
> > > PCIBIOS_SUCCESSFUL)
> > > -			break;
> > > -	}
> > > -
> > > -	return 0;
> > > +	return PCI_FIND_NEXT_EXT_CAPABILITY(pci_bus_read_config, start, cap,
> > > +					    dev->bus, dev->devfn);
> > >   }
> > >   EXPORT_SYMBOL_GPL(pci_find_next_ext_capability);
> > >   @@ -649,7 +591,7 @@ EXPORT_SYMBOL_GPL(pci_get_dsn);
> > >     static u8 __pci_find_next_ht_cap(struct pci_dev *dev, u8 pos, int
> > > ht_cap)
> > >   {
> > > -	int rc, ttl = PCI_FIND_CAP_TTL;
> > > +	int rc;
> > >   	u8 cap, mask;
> > >     	if (ht_cap == HT_CAPTYPE_SLAVE || ht_cap == HT_CAPTYPE_HOST)
> > > @@ -657,8 +599,8 @@ static u8 __pci_find_next_ht_cap(struct pci_dev *dev,
> > > u8 pos, int ht_cap)
> > >   	else
> > >   		mask = HT_5BIT_CAP_MASK;
> > >   -	pos = __pci_find_next_cap_ttl(dev->bus, dev->devfn, pos,
> > > -				      PCI_CAP_ID_HT, &ttl);
> > > +	pos = PCI_FIND_NEXT_CAP_TTL(pci_bus_read_config, pos,
> > > +				    PCI_CAP_ID_HT, dev->bus, dev->devfn);
> > >   	while (pos) {
> > >   		rc = pci_read_config_byte(dev, pos + 3, &cap);
> > >   		if (rc != PCIBIOS_SUCCESSFUL)
> > > @@ -667,9 +609,10 @@ static u8 __pci_find_next_ht_cap(struct pci_dev *dev,
> > > u8 pos, int ht_cap)
> > >   		if ((cap & mask) == ht_cap)
> > >   			return pos;
> > >   -		pos = __pci_find_next_cap_ttl(dev->bus, dev->devfn,
> > > -					      pos + PCI_CAP_LIST_NEXT,
> > > -					      PCI_CAP_ID_HT, &ttl);
> > > +		pos = PCI_FIND_NEXT_CAP_TTL(pci_bus_read_config,
> > > +					    pos + PCI_CAP_LIST_NEXT,
> > > +					    PCI_CAP_ID_HT, dev->bus,
> > > +					    dev->devfn);
> > >   	}
> > >     	return 0;
> > > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > > index e7d31ed56731..46fb6b5a854e 100644
> > > --- a/drivers/pci/pci.h
> > > +++ b/drivers/pci/pci.h
> > > @@ -2,6 +2,8 @@
> > >   #ifndef DRIVERS_PCI_H
> > >   #define DRIVERS_PCI_H
> > >   +#include <linux/align.h>
> > > +#include <linux/bitfield.h>
> > >   #include <linux/pci.h>
> > >     struct pcie_tlp_log;
> > > @@ -93,6 +95,89 @@ bool pcie_cap_has_rtctl(const struct pci_dev *dev);
> > >   int pci_bus_read_config(void *priv, unsigned int devfn, int where, u32
> > > size,
> > >   			u32 *val);
> > >   +/* Standard Capability finder */
> > > +/**
> > > + * PCI_FIND_NEXT_CAP_TTL - Find a PCI standard capability
> > 
> > I don't think "_TTL" is relevant in the macro name here.  I see it
> > copied the previous __pci_find_next_cap_ttl() name; "ttl" *was*
> > relevant there, but it isn't anymore.
> > 
> 
> Dear Bjorn,
> 
> Thank you very much for your reply.
> 
> The _TTL suffix will be removed.
> 
> 
> > I would like this a lot better if it could be implemented as a
> > function, but I assume it has to be a macro for some varargs reason.
> > 
> 
> Yes. The macro definitions used in combination with the previous review
> opinions of Ilpo.

The other option would be to standardize the accessor interface signature 
and pass the function as a pointer. One might immediately think of generic 
PCI core accessors making it sound simpler than it is but here the 
complication is the controller drivers want to pass some internal 
structure due to lack of pci_dev so it would need to be void 
*read_cfg_data. Then we'd need to deal with those voids also in some 
generic PCI accessors which is a bit ugly.

> > > + * @read_cfg: Function pointer for reading PCI config space
> > > + * @start: Starting position to begin search
> > > + * @cap: Capability ID to find
> > > + * @args: Arguments to pass to read_cfg function
> > > + *
> > > + * Iterates through the capability list in PCI config space to find
> > > + * @cap. Implements TTL (time-to-live) protection against infinite loops.
> > > + *
> > > + * Returns: Position of the capability if found, 0 otherwise.
> > > + */
> > > +#define PCI_FIND_NEXT_CAP_TTL(read_cfg, start, cap, args...)
> > > \
> > > +({									\
> > > +	int __ttl = PCI_FIND_CAP_TTL;					\
> > > +	u8 __id, __found_pos = 0;					\
> > > +	u8 __pos = (start);						\
> > > +	u16 __ent;							\
> > > +									\
> > > +	read_cfg(args, __pos, 1, (u32 *)&__pos);			\
> > > +									\
> > > +	while (__ttl--) {						\
> > > +		if (__pos < PCI_STD_HEADER_SIZEOF)			\
> > > +			break;						\
> > 
> > I guess this is just lifted directly from __pci_find_next_cap_ttl(),
> > but wow, I wish it weren't quite *so* subtle.  Totally fine though.
> > 
> > Maybe this could be split into one patch for standard capabilities and
> > a second for extended capabilities, just so the connection between
> > this and __pci_find_next_cap_ttl() would be clearer.
> > 
> 
> I will split the two patches.
> 
> > > +									\
> > > +		__pos = ALIGN_DOWN(__pos, 4);				\
> > > +		read_cfg(args, __pos, 2, (u32 *)&__ent);		\
> > > +									\
> > > +		__id = FIELD_GET(PCI_CAP_ID_MASK, __ent);		\
> > > +		if (__id == 0xff)					\
> > > +			break;						\
> > > +									\
> > > +		if (__id == (cap)) {					\
> > > +			__found_pos = __pos;				\
> > > +			break;						\
> > > +		}							\
> > > +									\
> > > +		__pos = FIELD_GET(PCI_CAP_LIST_NEXT_MASK, __ent);	\
> > > +	}								\
> > > +	__found_pos;							\
> > > +})


-- 
 i.



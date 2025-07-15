Return-Path: <linux-pci+bounces-32205-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 079FAB06965
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 00:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 370CA1AA609B
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 22:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9C71FE455;
	Tue, 15 Jul 2025 22:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYD26XGz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DE6EC2;
	Tue, 15 Jul 2025 22:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752619627; cv=none; b=SEwAHueSFRvBvO362ZGDmnasNEctuHB+b3iigtAfMkeHvxJqYIkO4vU6KA9kxIEcT0zxust2vvbaifSAbwMhSr/siw+jKO3x6IzTFKdLXhiTR2weKjn73bzzpAWQD6MgwDAeYELaGU8IDFQmQC/NgV1TJfFvlhOrK9Z1hwtEW6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752619627; c=relaxed/simple;
	bh=CHR/M2RFCtLCyy6fcS0oKCS07JlZifYfkh47v7dyxIA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=iuMKEmjJYiwu3k18DEfco0Rmv3tkyVTwE/U0Fai72ONw4LGIq9yKWiLUeUORt86aTJ3w/RS4FBcP+9InkR1IQfJBAROtffpVBO3ujvZx7U73hI5HEGNjQKST3+d5FF/5gHN/TL5GFcIEUBBUTi/92i05MEh34MKiP67KaBQhEzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYD26XGz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C6EBC4CEE3;
	Tue, 15 Jul 2025 22:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752619627;
	bh=CHR/M2RFCtLCyy6fcS0oKCS07JlZifYfkh47v7dyxIA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=kYD26XGzzHxyqUlkE/k1kWdbsQX7ojgTrSzNGlqaBT6Xp2QDV0O2xAP0Jlejx9L9X
	 J/tot786q1cYZhw5+/jdNVxXUrHAxnghrfBmBwd4V0hgsQkwoAX9EshI4Qux0t4/Q7
	 xo7eFzpiJBbpTaNBjo4wqcFJhrVxwr3jNsE/h0q8m9b6HGCFu4DGl5odTsQn8VH6zd
	 NAt7qKfRbsy6Ij+rY5Z7h0BlSEusAT/177pBEINKFd/PXYp7G3jU2b/ooEBEdvxBlL
	 k/Kgzdy926QGJxAkDsKutTop3x40yH8tuA8XNA/7QZfhAMsKxRqoslt0bLhKjXvtqG
	 BCXH2NsCPscCQ==
Date: Tue, 15 Jul 2025 17:47:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, bhelgaas@google.com, mani@kernel.org,
	ilpo.jarvinen@linux.intel.com, kwilczynski@kernel.org,
	robh@kernel.org, jingoohan1@gmail.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 3/6] PCI: Refactor capability search into common
 macros
Message-ID: <20250715224705.GA2504490@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250607161405.808585-4-18255117159@163.com>

On Sun, Jun 08, 2025 at 12:14:02AM +0800, Hans Zhang wrote:
> The PCI Capability search functionality is duplicated across the PCI core
> and several controller drivers. The core's current implementation requires
> fully initialized PCI device and bus structures, which prevents controller
> drivers from using it during early initialization phases before these
> structures are available.
> 
> Move the Capability search logic into a header-based macro that accepts a
> config space accessor function as an argument. This enables controller
> drivers to perform Capability discovery using their early access
> mechanisms prior to full device initialization while sharing the
> Capability search code.
> 
> Convert the existing PCI core Capability search implementation to use this
> new macro. Controller drivers can later use the same macros with their
> early access mechanisms while maintaining the existing protection against
> infinite loops through preserved TTL checks.
> 
> The ttl parameter was originally an additional safeguard to prevent
> infinite loops in corrupted config space. However, the
> PCI_FIND_NEXT_CAP_TTL() macro already enforces a TTL limit internally.
> Removing redundant ttl handling simplifies the interface while maintaining
> the safety guarantee. This aligns with the macro's design intent of
> encapsulating TTL management.

This is a big gulp, but I think I like it :)  It really enables some
nice cleanups later.

> -static u8 __pci_find_next_cap_ttl(struct pci_bus *bus, unsigned int devfn,
> -				  u8 pos, int cap, int *ttl)
> -{
> -	u8 id;
> -	u16 ent;
> -
> -	pci_bus_read_config_byte(bus, devfn, pos, &pos);
> -
> -	while ((*ttl)--) {
> -		if (pos < PCI_STD_HEADER_SIZEOF)
> -			break;
> -		pos = ALIGN_DOWN(pos, 4);
> -		pci_bus_read_config_word(bus, devfn, pos, &ent);
> -
> -		id = FIELD_GET(PCI_CAP_ID_MASK, ent);
> -		if (id == 0xff)
> -			break;
> -		if (id == cap)
> -			return pos;
> -		pos = FIELD_GET(PCI_CAP_LIST_NEXT_MASK, ent);
> -	}
> -	return 0;
> -}
> -
>  static u8 __pci_find_next_cap(struct pci_bus *bus, unsigned int devfn,
>  			      u8 pos, int cap)
>  {
> -	int ttl = PCI_FIND_CAP_TTL;
> -
> -	return __pci_find_next_cap_ttl(bus, devfn, pos, cap, &ttl);
> +	return PCI_FIND_NEXT_CAP_TTL(pci_bus_read_config, pos, cap, bus, devfn);
>  }
>  
>  u8 pci_find_next_capability(struct pci_dev *dev, u8 pos, int cap)
> @@ -554,42 +527,11 @@ EXPORT_SYMBOL(pci_bus_find_capability);
>   */
>  u16 pci_find_next_ext_capability(struct pci_dev *dev, u16 start, int cap)
>  {
> -	u32 header;
> -	int ttl;
> -	u16 pos = PCI_CFG_SPACE_SIZE;
> -
> -	/* minimum 8 bytes per capability */
> -	ttl = (PCI_CFG_SPACE_EXP_SIZE - PCI_CFG_SPACE_SIZE) / 8;
> -
>  	if (dev->cfg_size <= PCI_CFG_SPACE_SIZE)
>  		return 0;
>  
> -	if (start)
> -		pos = start;
> -
> -	if (pci_read_config_dword(dev, pos, &header) != PCIBIOS_SUCCESSFUL)
> -		return 0;
> -
> -	/*
> -	 * If we have no capabilities, this is indicated by cap ID,
> -	 * cap version and next pointer all being 0.
> -	 */
> -	if (header == 0)
> -		return 0;
> -
> -	while (ttl-- > 0) {
> -		if (PCI_EXT_CAP_ID(header) == cap && pos != start)
> -			return pos;
> -
> -		pos = PCI_EXT_CAP_NEXT(header);
> -		if (pos < PCI_CFG_SPACE_SIZE)
> -			break;
> -
> -		if (pci_read_config_dword(dev, pos, &header) != PCIBIOS_SUCCESSFUL)
> -			break;
> -	}
> -
> -	return 0;
> +	return PCI_FIND_NEXT_EXT_CAPABILITY(pci_bus_read_config, start, cap,
> +					    dev->bus, dev->devfn);
>  }
>  EXPORT_SYMBOL_GPL(pci_find_next_ext_capability);
>  
> @@ -649,7 +591,7 @@ EXPORT_SYMBOL_GPL(pci_get_dsn);
>  
>  static u8 __pci_find_next_ht_cap(struct pci_dev *dev, u8 pos, int ht_cap)
>  {
> -	int rc, ttl = PCI_FIND_CAP_TTL;
> +	int rc;
>  	u8 cap, mask;
>  
>  	if (ht_cap == HT_CAPTYPE_SLAVE || ht_cap == HT_CAPTYPE_HOST)
> @@ -657,8 +599,8 @@ static u8 __pci_find_next_ht_cap(struct pci_dev *dev, u8 pos, int ht_cap)
>  	else
>  		mask = HT_5BIT_CAP_MASK;
>  
> -	pos = __pci_find_next_cap_ttl(dev->bus, dev->devfn, pos,
> -				      PCI_CAP_ID_HT, &ttl);
> +	pos = PCI_FIND_NEXT_CAP_TTL(pci_bus_read_config, pos,
> +				    PCI_CAP_ID_HT, dev->bus, dev->devfn);
>  	while (pos) {
>  		rc = pci_read_config_byte(dev, pos + 3, &cap);
>  		if (rc != PCIBIOS_SUCCESSFUL)
> @@ -667,9 +609,10 @@ static u8 __pci_find_next_ht_cap(struct pci_dev *dev, u8 pos, int ht_cap)
>  		if ((cap & mask) == ht_cap)
>  			return pos;
>  
> -		pos = __pci_find_next_cap_ttl(dev->bus, dev->devfn,
> -					      pos + PCI_CAP_LIST_NEXT,
> -					      PCI_CAP_ID_HT, &ttl);
> +		pos = PCI_FIND_NEXT_CAP_TTL(pci_bus_read_config,
> +					    pos + PCI_CAP_LIST_NEXT,
> +					    PCI_CAP_ID_HT, dev->bus,
> +					    dev->devfn);
>  	}
>  
>  	return 0;
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index e7d31ed56731..46fb6b5a854e 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -2,6 +2,8 @@
>  #ifndef DRIVERS_PCI_H
>  #define DRIVERS_PCI_H
>  
> +#include <linux/align.h>
> +#include <linux/bitfield.h>
>  #include <linux/pci.h>
>  
>  struct pcie_tlp_log;
> @@ -93,6 +95,89 @@ bool pcie_cap_has_rtctl(const struct pci_dev *dev);
>  int pci_bus_read_config(void *priv, unsigned int devfn, int where, u32 size,
>  			u32 *val);
>  
> +/* Standard Capability finder */
> +/**
> + * PCI_FIND_NEXT_CAP_TTL - Find a PCI standard capability

I don't think "_TTL" is relevant in the macro name here.  I see it
copied the previous __pci_find_next_cap_ttl() name; "ttl" *was*
relevant there, but it isn't anymore.

I would like this a lot better if it could be implemented as a
function, but I assume it has to be a macro for some varargs reason.

> + * @read_cfg: Function pointer for reading PCI config space
> + * @start: Starting position to begin search
> + * @cap: Capability ID to find
> + * @args: Arguments to pass to read_cfg function
> + *
> + * Iterates through the capability list in PCI config space to find
> + * @cap. Implements TTL (time-to-live) protection against infinite loops.
> + *
> + * Returns: Position of the capability if found, 0 otherwise.
> + */
> +#define PCI_FIND_NEXT_CAP_TTL(read_cfg, start, cap, args...)		\
> +({									\
> +	int __ttl = PCI_FIND_CAP_TTL;					\
> +	u8 __id, __found_pos = 0;					\
> +	u8 __pos = (start);						\
> +	u16 __ent;							\
> +									\
> +	read_cfg(args, __pos, 1, (u32 *)&__pos);			\
> +									\
> +	while (__ttl--) {						\
> +		if (__pos < PCI_STD_HEADER_SIZEOF)			\
> +			break;						\

I guess this is just lifted directly from __pci_find_next_cap_ttl(),
but wow, I wish it weren't quite *so* subtle.  Totally fine though.

Maybe this could be split into one patch for standard capabilities and
a second for extended capabilities, just so the connection between
this and __pci_find_next_cap_ttl() would be clearer.

> +									\
> +		__pos = ALIGN_DOWN(__pos, 4);				\
> +		read_cfg(args, __pos, 2, (u32 *)&__ent);		\
> +									\
> +		__id = FIELD_GET(PCI_CAP_ID_MASK, __ent);		\
> +		if (__id == 0xff)					\
> +			break;						\
> +									\
> +		if (__id == (cap)) {					\
> +			__found_pos = __pos;				\
> +			break;						\
> +		}							\
> +									\
> +		__pos = FIELD_GET(PCI_CAP_LIST_NEXT_MASK, __ent);	\
> +	}								\
> +	__found_pos;							\
> +})
> +
> +/* Extended Capability finder */
> +/**
> + * PCI_FIND_NEXT_EXT_CAPABILITY - Find a PCI extended capability

Can this be named similarly to the above?  PCI_FIND_NEXT_CAP_TTL() and
PCI_FIND_NEXT_EXT_CAPABILITY() seem needlessly different.

PCI_FIND_NEXT_CAP() and PCI_FIND_NEXT_EXT_CAP()?

> + * @read_cfg: Function pointer for reading PCI config space
> + * @start: Starting position to begin search (0 for initial search)
> + * @cap: Extended capability ID to find
> + * @args: Arguments to pass to read_cfg function
> + *
> + * Searches the extended capability space in PCI config registers
> + * for @cap. Implements TTL protection against infinite loops using
> + * a calculated maximum search count.
> + *
> + * Returns: Position of the capability if found, 0 otherwise.
> + */
> +#define PCI_FIND_NEXT_EXT_CAPABILITY(read_cfg, start, cap, args...)		\

It would be *really* nice if you could make this fit nicely in 80
columns as PCI_FIND_NEXT_CAP_TTL() does.

> +({										\
> +	u16 __pos = (start) ?: PCI_CFG_SPACE_SIZE;				\
> +	u16 __found_pos = 0;							\
> +	int __ttl, __ret;							\
> +	u32 __header;								\
> +										\
> +	__ttl = (PCI_CFG_SPACE_EXP_SIZE - PCI_CFG_SPACE_SIZE) / 8;		\
> +	while (__ttl-- > 0 && __pos >= PCI_CFG_SPACE_SIZE) {			\
> +		__ret = read_cfg(args, __pos, 4, &__header);			\
> +		if (__ret != PCIBIOS_SUCCESSFUL)				\
> +			break;							\
> +										\
> +		if (__header == 0)						\
> +			break;							\
> +										\
> +		if (PCI_EXT_CAP_ID(__header) == (cap) && __pos != start) {	\
> +			__found_pos = __pos;					\
> +			break;							\
> +		}								\
> +										\
> +		__pos = PCI_EXT_CAP_NEXT(__header);				\
> +	}									\
> +	__found_pos;								\
> +})
> +
>  /* Functions internal to the PCI core code */
>  
>  #ifdef CONFIG_DMI
> -- 
> 2.25.1
> 


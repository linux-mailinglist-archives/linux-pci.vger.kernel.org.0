Return-Path: <linux-pci+bounces-25166-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2AEA78EBF
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 14:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34371166767
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 12:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F79239797;
	Wed,  2 Apr 2025 12:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R6WvudVl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8624E21ADBA;
	Wed,  2 Apr 2025 12:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743597526; cv=none; b=GpiAh/MZXcJE2m5qq5OLUuvVsL8IG5z2/QXDggNbLRH14MVs2Zy/jxkdjhmGVkyuU3fW2xnemiEGP1oDOq78s3ylDHC9Nr7CNuLsZWpLeT9kgn2Tl20VlIBHMFX6Id3hw+QEKw7fgiK986k8z0+OVqLKDpGte+9Q8wo7AFP3jCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743597526; c=relaxed/simple;
	bh=ntSGthceh1axne9kdZkUoY1sOxOCEaqebzvgZxhB2G8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=i9nFwNmmhtij4wA9UjIUynrTd6v+p/56c8DeUz9CNv1SuGviH+OJLg+MNJpW08I2Cr/8GMgZVgQ+mfjVricZsaaqQ/LzSwaAGE8Ua/rQZrz0x6XSDcK1DfwYyOjp3RhkRazL9FXW2UB2tGPOH1MeWqDLFCZSCAUtyknSZuqfNDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R6WvudVl; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743597525; x=1775133525;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ntSGthceh1axne9kdZkUoY1sOxOCEaqebzvgZxhB2G8=;
  b=R6WvudVlWLSUDPnUauz0xQ945uJ69lcBe75EiM8GKmbciQojp1QMTw+c
   RBasJbsuq0XfP8RN04HSXnV99Q5W2H2TWnHrUXPKl2zwc0N1xec/700tL
   LiAbWSz7q8VQM+ot/PUJhKAUBgPorbob1AEnpZww6APwc0HFuLsSvA4SS
   msI0TzPrVlWv3Xm1r5IOTITjt/6IMS6htBFu8DBha+SetDa2vPIBby67O
   0TSt8XgPSaEoyN+LHWgsx6A7AXmdqtltfXC58pISwcqFyjn9WAxA1ZJJM
   bPT8QvMncYcX58iy9WikCvFTuFBK23FIw9i9sCuLimfoshrF1YOfdnmqC
   A==;
X-CSE-ConnectionGUID: LZwTlMp5RGSzqMSC0PJYjw==
X-CSE-MsgGUID: Qa93n+D7QXm7v6Bq/TAWpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="55952211"
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="55952211"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 05:38:44 -0700
X-CSE-ConnectionGUID: NAPjVEhzS6agEIspfzhw8g==
X-CSE-MsgGUID: 7iag25pxQuuKAxHYVVIh+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="126644787"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.40])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 05:38:41 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 2 Apr 2025 15:38:37 +0300 (EEST)
To: Hans Zhang <18255117159@163.com>
cc: lpieralisi@kernel.org, bhelgaas@google.com, kw@linux.com, 
    manivannan.sadhasivam@linaro.org, robh@kernel.org, jingoohan1@gmail.com, 
    thomas.richard@bootlin.com, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [v7 2/5] PCI: Refactor capability search functions to eliminate
 code duplication
In-Reply-To: <20250402042020.48681-3-18255117159@163.com>
Message-ID: <8b693bfc-73e0-2956-2ba3-1bfd639660b6@linux.intel.com>
References: <20250402042020.48681-1-18255117159@163.com> <20250402042020.48681-3-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 2 Apr 2025, Hans Zhang wrote:

> Refactor the PCI capability and extended capability search functions
> by consolidating common code patterns into reusable macros
> (PCI_FIND_NEXT_CAP_TTL and PCI_FIND_NEXT_EXT_CAPABILITY). The main
> changes include:
> 
> 1. Introducing a unified config space read helper (__pci_bus_read_config).
> 2. Removing duplicate search logic from __pci_find_next_cap_ttl and
>    pci_find_next_ext_capability.
> 3. Implementing consistent capability discovery using the new macros.
> 4. Simplifying HyperTransport capability lookup by leveraging the
>    refactored code.
> 
> The refactoring maintains existing functionality while reducing code
> duplication and improving maintainability. By centralizing the search
> logic, we achieve better code consistency and make future updates easier.
> 
> This change has been verified to maintain backward compatibility with
> existing capability discovery patterns through thorough testing of PCI
> device enumeration and capability probing.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>  drivers/pci/pci.c | 79 +++++++++++++----------------------------------
>  1 file changed, 22 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 869d204a70a3..521096c73686 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -423,36 +423,33 @@ static int pci_dev_str_match(struct pci_dev *dev, const char *p,
>  	return 1;
>  }
>  
> -static u8 __pci_find_next_cap_ttl(struct pci_bus *bus, unsigned int devfn,
> -				  u8 pos, int cap, int *ttl)
> +static int __pci_bus_read_config(void *priv, unsigned int devfn, int where,
> +				 u32 size, u32 *val)

This probably should be where the other accessors are so in access.c. I'd 
put its prototype into drivers/pci/pci.h only for now.

>  {
> -	u8 id;
> -	u16 ent;
> +	struct pci_bus *bus = priv;
> +	int ret;
>  
> -	pci_bus_read_config_byte(bus, devfn, pos, &pos);
> +	if (size == 1)
> +		ret = pci_bus_read_config_byte(bus, devfn, where, (u8 *)val);
> +	else if (size == 2)
> +		ret = pci_bus_read_config_word(bus, devfn, where, (u16 *)val);
> +	else
> +		ret = pci_bus_read_config_dword(bus, devfn, where, val);
>  
> -	while ((*ttl)--) {
> -		if (pos < 0x40)
> -			break;
> -		pos &= ~3;
> -		pci_bus_read_config_word(bus, devfn, pos, &ent);
> +	return ret;
> +}
>  
> -		id = ent & 0xff;
> -		if (id == 0xff)
> -			break;
> -		if (id == cap)
> -			return pos;
> -		pos = (ent >> 8);
> -	}
> -	return 0;
> +static u8 __pci_find_next_cap_ttl(struct pci_bus *bus, unsigned int devfn,
> +				  u8 pos, int cap)
> +{
> +	return PCI_FIND_NEXT_CAP_TTL(__pci_bus_read_config, pos, cap, bus,
> +				     devfn);
>  }
>  
>  static u8 __pci_find_next_cap(struct pci_bus *bus, unsigned int devfn,
>  			      u8 pos, int cap)
>  {
> -	int ttl = PCI_FIND_CAP_TTL;
> -
> -	return __pci_find_next_cap_ttl(bus, devfn, pos, cap, &ttl);
> +	return __pci_find_next_cap_ttl(bus, devfn, pos, cap);
>  }
>  
>  u8 pci_find_next_capability(struct pci_dev *dev, u8 pos, int cap)
> @@ -553,42 +550,11 @@ EXPORT_SYMBOL(pci_bus_find_capability);
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
> +	return PCI_FIND_NEXT_EXT_CAPABILITY(__pci_bus_read_config, start, cap,
> +					    dev->bus, dev->devfn);

I don't like how 1 & 2 patches are split into two. IMO, they mostly belong 
together. However, (IMO) you can introduce the new all-size config space 
accessor in a separate patch before the combined patch.

>  }
>  EXPORT_SYMBOL_GPL(pci_find_next_ext_capability);
>  
> @@ -648,7 +614,6 @@ EXPORT_SYMBOL_GPL(pci_get_dsn);
>  
>  static u8 __pci_find_next_ht_cap(struct pci_dev *dev, u8 pos, int ht_cap)
>  {
> -	int rc, ttl = PCI_FIND_CAP_TTL;
>  	u8 cap, mask;
>  
>  	if (ht_cap == HT_CAPTYPE_SLAVE || ht_cap == HT_CAPTYPE_HOST)
> @@ -657,7 +622,7 @@ static u8 __pci_find_next_ht_cap(struct pci_dev *dev, u8 pos, int ht_cap)
>  		mask = HT_5BIT_CAP_MASK;
>  
>  	pos = __pci_find_next_cap_ttl(dev->bus, dev->devfn, pos,
> -				      PCI_CAP_ID_HT, &ttl);
> +				      PCI_CAP_ID_HT);
>  	while (pos) {
>  		rc = pci_read_config_byte(dev, pos + 3, &cap);
>  		if (rc != PCIBIOS_SUCCESSFUL)
> @@ -668,7 +633,7 @@ static u8 __pci_find_next_ht_cap(struct pci_dev *dev, u8 pos, int ht_cap)
>  
>  		pos = __pci_find_next_cap_ttl(dev->bus, dev->devfn,
>  					      pos + PCI_CAP_LIST_NEXT,
> -					      PCI_CAP_ID_HT, &ttl);
> +					      PCI_CAP_ID_HT);

This function kind of had the idea to share the ttl but I suppose that was
just a final safeguard to make sure the loop will always terminate in case 
the config space is corrupted so the unsharing is not a big issue.

>  	}
>  
>  	return 0;
> 

-- 
 i.



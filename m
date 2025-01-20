Return-Path: <linux-pci+bounces-20161-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EB3A16FE3
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 17:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6206D7A23C8
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 16:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031461E9B0A;
	Mon, 20 Jan 2025 16:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G5MwxjeC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CAD1E8855;
	Mon, 20 Jan 2025 16:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737389422; cv=none; b=dqj3kQstu6Zo7DskWSiSsBAlmOLubTesdcj0h0GCNRF74Bmxcjtl+xKvkt+XfSKEBe+pwroOPW0YofGyCiKHOq6HbIxjiGTrhVJNkLGOAK/C8SIwVumAp/tlNj8hewa+N6SzMC3eiTYuzsG1Mqq8npw73OoS92G1DaiH4zLupkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737389422; c=relaxed/simple;
	bh=YYGlsLQm0QGugbLate5oWgFAHtuh7RBkbwgLYXHgr78=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Aax59/visixhn4zualIH7G3poNBcJkIuNRcWGINvTA/sTSfTPMtreignBqmpCUXEgMju7f3JyrUUuuhpzV8CmWfpHb/wm/SXV6LyBIfGbCZHNj6NGVcsSGmCPsfhl4axuJohpyJNeymEweMh8Ctq7L+SF1ms5Gnx4sAngqrFOBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G5MwxjeC; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737389420; x=1768925420;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=YYGlsLQm0QGugbLate5oWgFAHtuh7RBkbwgLYXHgr78=;
  b=G5MwxjeCmm0WTHrH+tSp2VtWb4/8sLnr4o4vCQJs/eTWkt912kHi2w9W
   QVDZIYm+DkVBtZnTABSOf9Ar5ZpaEsUdK8L7lgSKdV4b3QXMV1J5M6v5y
   xlI2Mtx9SF+6D1aEqZR+XJmVTmcleAvLj/UU7tZLmStFtc2N4WediZpCE
   GdMcf/biv8YncADsx/vwmcSXqwIWoy/73cDHstT8fzwuNBlER/zvTKUHt
   JWlPe/0+wCN08qTRKSGQCaMnqWZnxXqCUnsP1RjicfkvlaRyI5pPXN0mQ
   yCyC5hpuwkeIBtp9w491/eGrSgit8JX7Ng8rjALl4qI+a+9S6XpjuHETK
   g==;
X-CSE-ConnectionGUID: 24VMdTAmSueZI44qLPJ9Cw==
X-CSE-MsgGUID: 24OK5Or0R++pO5/mW1IoAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11321"; a="48455825"
X-IronPort-AV: E=Sophos;i="6.13,219,1732608000"; 
   d="scan'208";a="48455825"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2025 08:10:19 -0800
X-CSE-ConnectionGUID: GxdzvOv3RuqJJINHZ5sdkw==
X-CSE-MsgGUID: yImLPtmNS2uocYboGib2UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="106392316"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.8])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2025 08:10:17 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 20 Jan 2025 18:10:14 +0200 (EET)
To: Alex Williamson <alex.williamson@redhat.com>
cc: bhelgaas@google.com, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, mitchell.augustin@canonical.com
Subject: Re: [PATCH] PCI: Batch BAR sizing operations
In-Reply-To: <20250111210652.402845-1-alex.williamson@redhat.com>
Message-ID: <d635d3b0-92bf-5a96-c64e-fe2aae8a522f@linux.intel.com>
References: <20250111210652.402845-1-alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 11 Jan 2025, Alex Williamson wrote:

> Toggling memory enable is free on bare metal, but potentially expensive
> in virtualized environments as the device MMIO spaces are added and
> removed from the VM address space, including DMA mapping of those spaces
> through the IOMMU where peer-to-peer is supported.  Currently memory
> decode is disabled around sizing each individual BAR, even for SR-IOV
> BARs while VF Enable is cleared.
> 
> This can be better optimized for virtual environments by sizing a set
> of BARs at once, stashing the resulting mask into an array, while only
> toggling memory enable once.  This also naturally improves the SR-IOV
> path as the caller becomes responsible for any necessary decode disables
> while sizing BARs, therefore SR-IOV BARs are sized relying only on the
> VF Enable rather than toggling the PF memory enable in the command
> register.
> 
> Reported-by: Mitchell Augustin <mitchell.augustin@canonical.com>
> Link: https://lore.kernel.org/all/CAHTA-uYp07FgM6T1OZQKqAdSA5JrZo0ReNEyZgQZub4mDRrV5w@mail.gmail.com
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
> 
> This is an alternative to the patch proposed by Mitchell[1] and more
> in line with my suggestion in the original report thread[2].  It makes
> more sense to me to stash all the BAR sizing values into an array on
> the front end of parsing them into resources than it does to pass
> multiple arrays on the backend for status printing purposes.  We can
> discuss in either of these patches which is the better approach or
> if someone has a better yet alternative.
> 
> I don't have quite the config Mitchell has for testing, but this
> should make effectively the same improvement and does show a
> significant improvement in guest boot time even with a single 24GB
> GPU attached.  There are of course further improvements to investigate
> in the VMM, but disabling memory decode per BAR is a good start to
> making Linux be a friendlier guest.  Further testing appreciate.
> Thanks,
> 
> Alex
> 
> [1]https://lore.kernel.org/all/20241218224258.2225210-1-mitchell.augustin@canonical.com/
> [2]https://lore.kernel.org/all/20241203150620.15431c5c.alex.williamson@redhat.com/
> 
>  drivers/pci/iov.c   |   8 ++-
>  drivers/pci/pci.h   |   4 +-
>  drivers/pci/probe.c | 132 +++++++++++++++++++++++++++++---------------
>  3 files changed, 97 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 4be402fe9ab9..9e4770cdd4d5 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -747,6 +747,7 @@ static int sriov_init(struct pci_dev *dev, int pos)
>  	struct resource *res;
>  	const char *res_name;
>  	struct pci_dev *pdev;
> +	u32 sriovbars[PCI_SRIOV_NUM_BARS];
>  
>  	pci_read_config_word(dev, pos + PCI_SRIOV_CTRL, &ctrl);
>  	if (ctrl & PCI_SRIOV_CTRL_VFE) {
> @@ -783,6 +784,10 @@ static int sriov_init(struct pci_dev *dev, int pos)
>  	if (!iov)
>  		return -ENOMEM;
>  
> +	/* Sizing SR-IOV BARs with VF Enable cleared - no decode */
> +	__pci_size_stdbars(dev, PCI_SRIOV_NUM_BARS,
> +			   pos + PCI_SRIOV_BAR, sriovbars);
> +
>  	nres = 0;
>  	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
>  		res = &dev->resource[i + PCI_IOV_RESOURCES];
> @@ -796,7 +801,8 @@ static int sriov_init(struct pci_dev *dev, int pos)
>  			bar64 = (res->flags & IORESOURCE_MEM_64) ? 1 : 0;
>  		else
>  			bar64 = __pci_read_base(dev, pci_bar_unknown, res,
> -						pos + PCI_SRIOV_BAR + i * 4);
> +						pos + PCI_SRIOV_BAR + i * 4,
> +						&sriovbars[i]);
>  		if (!res->flags)
>  			continue;
>  		if (resource_size(res) & (PAGE_SIZE - 1)) {
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 2e40fc63ba31..6f27651c2a70 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -315,8 +315,10 @@ bool pci_bus_generic_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *pl,
>  int pci_idt_bus_quirk(struct pci_bus *bus, int devfn, u32 *pl, int rrs_timeout);
>  
>  int pci_setup_device(struct pci_dev *dev);
> +void __pci_size_stdbars(struct pci_dev *dev, int count,
> +			unsigned int pos, u32 *sizes);
>  int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
> -		    struct resource *res, unsigned int reg);
> +		    struct resource *res, unsigned int reg, u32 *sizes);
>  void pci_configure_ari(struct pci_dev *dev);
>  void __pci_bus_size_bridges(struct pci_bus *bus,
>  			struct list_head *realloc_head);
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 2e81ab0f5a25..5ca96280d698 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -164,50 +164,75 @@ static inline unsigned long decode_bar(struct pci_dev *dev, u32 bar)
>  
>  #define PCI_COMMAND_DECODE_ENABLE	(PCI_COMMAND_MEMORY | PCI_COMMAND_IO)
>  
> +/**
> + * __pci_size_bars - Read the raw BAR mask for a range of PCI BARs
> + * @dev: the PCI device
> + * @count: number of BARs to size
> + * @pos: starting config space position
> + * @sizes: array to store mask values
> + * @rom: indicate whether to use ROM mask, which avoids enabling ROM BARs
> + *
> + * Provided @sizes array must be sufficiently sized to store results for
> + * @count u32 BARs.  Caller is responsible for disabling decode to specified
> + * BAR range around calling this function.  This function is intended to avoid
> + * disabling decode around sizing each BAR individually, which can result in
> + * non-trivial overhead in virtualized environments with very large PCI BARs.
> + */
> +static void __pci_size_bars(struct pci_dev *dev, int count,
> +			    unsigned int pos, u32 *sizes, bool rom)
> +{
> +	u32 orig, mask = rom ? PCI_ROM_ADDRESS_MASK : ~0;
> +	int i;
> +
> +	for (i = 0; i < count; i++, pos += 4, sizes++) {
> +		pci_read_config_dword(dev, pos, &orig);
> +		pci_write_config_dword(dev, pos, mask);
> +		pci_read_config_dword(dev, pos, sizes);
> +		pci_write_config_dword(dev, pos, orig);
> +
> +		/*
> +		 * All bits set in size means the device isn't working properly.
> +		 * If the BAR isn't implemented, all bits must be 0.  If it's a
> +		 * memory BAR or a ROM, bit 0 must be clear; if it's an io BAR,
> +		 * bit 1 must be clear.
> +		 */
> +		if (PCI_POSSIBLE_ERROR(*sizes))
> +			*sizes = 0;
> +	}
> +}

I'm trying to understand how 64-bit BARs are supposed to work here. The 
*sizes is being filled inside this function for both lower and upper 
u32, right? So why can PCI_POSSIBLE_ERROR() be used for the upper part? 
Can't the upper u32 of a 64-bit BAR have all bits as 1?

> +void __pci_size_stdbars(struct pci_dev *dev, int count,
> +			unsigned int pos, u32 *sizes)
> +{
> +	__pci_size_bars(dev, count, pos, sizes, false);
> +}
> +
> +static void __pci_size_rom(struct pci_dev *dev, unsigned int pos, u32 *sizes)
> +{
> +	__pci_size_bars(dev, 1, pos, sizes, true);
> +}
> +
>  /**
>   * __pci_read_base - Read a PCI BAR
>   * @dev: the PCI device
>   * @type: type of the BAR
>   * @res: resource buffer to be filled in
>   * @pos: BAR position in the config space
> + * @sizes: array of one or more pre-read BAR masks
>   *
>   * Returns 1 if the BAR is 64-bit, or 0 if 32-bit.
>   */
>  int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
> -		    struct resource *res, unsigned int pos)
> +		    struct resource *res, unsigned int pos, u32 *sizes)
>  {
> -	u32 l = 0, sz = 0, mask;
> +	u32 l = 0;
>  	u64 l64, sz64, mask64;
> -	u16 orig_cmd;
>  	struct pci_bus_region region, inverted_region;
>  	const char *res_name = pci_resource_name(dev, res - dev->resource);
>  
> -	mask = type ? PCI_ROM_ADDRESS_MASK : ~0;
> -
> -	/* No printks while decoding is disabled! */
> -	if (!dev->mmio_always_on) {
> -		pci_read_config_word(dev, PCI_COMMAND, &orig_cmd);
> -		if (orig_cmd & PCI_COMMAND_DECODE_ENABLE) {
> -			pci_write_config_word(dev, PCI_COMMAND,
> -				orig_cmd & ~PCI_COMMAND_DECODE_ENABLE);
> -		}
> -	}
> -
>  	res->name = pci_name(dev);
>  
>  	pci_read_config_dword(dev, pos, &l);
> -	pci_write_config_dword(dev, pos, l | mask);
> -	pci_read_config_dword(dev, pos, &sz);
> -	pci_write_config_dword(dev, pos, l);
> -
> -	/*
> -	 * All bits set in sz means the device isn't working properly.
> -	 * If the BAR isn't implemented, all bits must be 0.  If it's a
> -	 * memory BAR or a ROM, bit 0 must be clear; if it's an io BAR, bit
> -	 * 1 must be clear.
> -	 */
> -	if (PCI_POSSIBLE_ERROR(sz))
> -		sz = 0;
>  
>  	/*
>  	 * I don't know how l can have all bits set.  Copied from old code.
> @@ -221,35 +246,30 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
>  		res->flags |= IORESOURCE_SIZEALIGN;
>  		if (res->flags & IORESOURCE_IO) {
>  			l64 = l & PCI_BASE_ADDRESS_IO_MASK;
> -			sz64 = sz & PCI_BASE_ADDRESS_IO_MASK;
> +			sz64 = *sizes & PCI_BASE_ADDRESS_IO_MASK;
>  			mask64 = PCI_BASE_ADDRESS_IO_MASK & (u32)IO_SPACE_LIMIT;
>  		} else {
>  			l64 = l & PCI_BASE_ADDRESS_MEM_MASK;
> -			sz64 = sz & PCI_BASE_ADDRESS_MEM_MASK;
> +			sz64 = *sizes & PCI_BASE_ADDRESS_MEM_MASK;
>  			mask64 = (u32)PCI_BASE_ADDRESS_MEM_MASK;
> +
> +			if (res->flags & IORESOURCE_MEM_64) {
> +				pci_read_config_dword(dev, pos + 4, &l);
> +				sizes++;
> +
> +				l64 |= ((u64)l << 32);
> +				sz64 |= ((u64)*sizes << 32);
> +				mask64 |= ((u64)~0 << 32);
> +			}
>  		}
>  	} else {
>  		if (l & PCI_ROM_ADDRESS_ENABLE)
>  			res->flags |= IORESOURCE_ROM_ENABLE;
>  		l64 = l & PCI_ROM_ADDRESS_MASK;
> -		sz64 = sz & PCI_ROM_ADDRESS_MASK;
> +		sz64 = *sizes & PCI_ROM_ADDRESS_MASK;
>  		mask64 = PCI_ROM_ADDRESS_MASK;
>  	}
>  
> -	if (res->flags & IORESOURCE_MEM_64) {
> -		pci_read_config_dword(dev, pos + 4, &l);
> -		pci_write_config_dword(dev, pos + 4, ~0);
> -		pci_read_config_dword(dev, pos + 4, &sz);
> -		pci_write_config_dword(dev, pos + 4, l);
> -
> -		l64 |= ((u64)l << 32);
> -		sz64 |= ((u64)sz << 32);
> -		mask64 |= ((u64)~0 << 32);
> -	}

No PCI_POSSIBLE_ERROR() check here for the upper u32 in the previous 
code.

-- 
 i.

> -
> -	if (!dev->mmio_always_on && (orig_cmd & PCI_COMMAND_DECODE_ENABLE))
> -		pci_write_config_word(dev, PCI_COMMAND, orig_cmd);
> -
>  	if (!sz64)
>  		goto fail;
>  
> @@ -320,7 +340,11 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
>  
>  static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
>  {
> +	u32 rombar, stdbars[PCI_STD_NUM_BARS];
>  	unsigned int pos, reg;
> +	u16 orig_cmd;
> +
> +	BUILD_BUG_ON(howmany > PCI_STD_NUM_BARS);
>  
>  	if (dev->non_compliant_bars)
>  		return;
> @@ -329,10 +353,28 @@ static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
>  	if (dev->is_virtfn)
>  		return;
>  
> +	/* No printks while decoding is disabled! */
> +	if (!dev->mmio_always_on) {
> +		pci_read_config_word(dev, PCI_COMMAND, &orig_cmd);
> +		if (orig_cmd & PCI_COMMAND_DECODE_ENABLE) {
> +			pci_write_config_word(dev, PCI_COMMAND,
> +				orig_cmd & ~PCI_COMMAND_DECODE_ENABLE);
> +		}
> +	}
> +
> +	__pci_size_stdbars(dev, howmany, PCI_BASE_ADDRESS_0, stdbars);
> +	if (rom)
> +		__pci_size_rom(dev, rom, &rombar);
> +
> +	if (!dev->mmio_always_on &&
> +	    (orig_cmd & PCI_COMMAND_DECODE_ENABLE))
> +		pci_write_config_word(dev, PCI_COMMAND, orig_cmd);
> +
>  	for (pos = 0; pos < howmany; pos++) {
>  		struct resource *res = &dev->resource[pos];
>  		reg = PCI_BASE_ADDRESS_0 + (pos << 2);
> -		pos += __pci_read_base(dev, pci_bar_unknown, res, reg);
> +		pos += __pci_read_base(dev, pci_bar_unknown,
> +				       res, reg, &stdbars[pos]);
>  	}
>  
>  	if (rom) {
> @@ -340,7 +382,7 @@ static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
>  		dev->rom_base_reg = rom;
>  		res->flags = IORESOURCE_MEM | IORESOURCE_PREFETCH |
>  				IORESOURCE_READONLY | IORESOURCE_SIZEALIGN;
> -		__pci_read_base(dev, pci_bar_mem32, res, rom);
> +		__pci_read_base(dev, pci_bar_mem32, res, rom, &rombar);
>  	}
>  }
>  
> 


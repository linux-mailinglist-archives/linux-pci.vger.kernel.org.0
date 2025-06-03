Return-Path: <linux-pci+bounces-28847-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2E3ACC346
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 11:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDB4A16BC81
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 09:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E627262D;
	Tue,  3 Jun 2025 09:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KuUcRoka"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A8728150E;
	Tue,  3 Jun 2025 09:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748943518; cv=none; b=Krs/ehSMdPkKLdG80hBLeUc9swttnknW3OJkHcrqIpiJ8D4ROwSKdFdYwUukUXnlTG5HWevWz+Jthh2xJtikQllCWA+P7rE4Nx7bvvKKVh5Y4SNettBhAPY4VoH+gwPxE2KGpriC8MZY6IAg0IGHW4dfX19VyNckIfJ8QD+sJhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748943518; c=relaxed/simple;
	bh=hw3MRVfKLIS2l/PXiDtZ7wSrs1MFRdIk2FoiKj7CJmg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jq3UjCCHmKjuzWnBqaLIuEBZxem/Q+6ousdzMlBnfZiFOFznKYiFGKC+6bYS+wTY8I68hkb9lroWHbF2DF1cyJU4XBu9UzU56qd2ZyBGRqaFXed8DRzy97giep31qlcMkoY5e+Hfkk7WeDYT5o4pFLdjVEx7UxXv2lVhk11dZ2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KuUcRoka; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748943517; x=1780479517;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=hw3MRVfKLIS2l/PXiDtZ7wSrs1MFRdIk2FoiKj7CJmg=;
  b=KuUcRokazUv3h7NqXd337KjMIAxdPKAUZMa+LFlQ4C2rCMilWU5tIoh0
   OCmcAYwesox5owxjpBHKJNrZ+V4dHmmBHOTwGi7WtUykPqKcJR5skGqBb
   1jpHjzOLpWyDxz+gPjVyXqTI//ADX7xM5wao+6hvt5itO3//zSV8RRvwc
   Pgnh2GyM0Tztk5Mxwe6FiPlpb2dxLBwOoG0gP7W4ph44LSX56LsoCY8vr
   ahDMO8+qAhyw+KB/1hgYk8qANsPERhsxGx+SBSW1P8l2nbfgGS3hBYhNc
   7Q7wnBc4mSz0kXf4d7WBrzHSMsdAuFnm9zZ/sjV6CCA7Q5h8GdWx7CJNh
   g==;
X-CSE-ConnectionGUID: nm1e6oHzQ7qS3TocnsIALQ==
X-CSE-MsgGUID: 1t4t7MRFSCGpfH2LKuAJiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="68528818"
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="68528818"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 02:38:35 -0700
X-CSE-ConnectionGUID: V4xPetfKSA6ncuCBv3q+ag==
X-CSE-MsgGUID: BnXyzXw5RB6bqxCKeWAd7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="144689312"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.141])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 02:38:31 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 3 Jun 2025 12:38:27 +0300 (EEST)
To: Hans Zhang <18255117159@163.com>
cc: lpieralisi@kernel.org, bhelgaas@google.com, 
    manivannan.sadhasivam@linaro.org, kw@linux.com, cassel@kernel.org, 
    robh@kernel.org, jingoohan1@gmail.com, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 3/6] PCI: Refactor capability search into common
 macros
In-Reply-To: <20250514161258.93844-4-18255117159@163.com>
Message-ID: <cb70dfc1-d576-110b-66f2-173e9bdf86dd@linux.intel.com>
References: <20250514161258.93844-1-18255117159@163.com> <20250514161258.93844-4-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 15 May 2025, Hans Zhang wrote:

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
> infinite loops in corrupted config space.  However, the
> PCI_FIND_NEXT_CAP_TTL macro already enforces a TTL limit internally.

PCI_FIND_NEXT_CAP_TTL()

> Removing redundant ttl handling simplifies the interface while maintaining
> the safety guarantee. This aligns with the macro's design intent of
> encapsulating TTL management.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
> Changes since v11:
> - Add #include <linux/bitfield.h>, solve the compilation warnings caused by the subsequent patch calls.
> 
> Changes since v10:
> - Remove #include <uapi/linux/pci_regs.h>.
> - The patch commit message were modified.
> 
> Changes since v9:
> - None
> 
> Changes since v8:
> - The patch commit message were modified.
> ---
>  drivers/pci/pci.c | 69 +++++--------------------------------
>  drivers/pci/pci.h | 86 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 95 insertions(+), 60 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 27d2adb18a30..271d922abdcc 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -9,7 +9,6 @@
>   */
>  
>  #include <linux/acpi.h>
> -#include <linux/align.h>
>  #include <linux/kernel.h>
>  #include <linux/delay.h>
>  #include <linux/dmi.h>
> @@ -425,35 +424,16 @@ static int pci_dev_str_match(struct pci_dev *dev, const char *p,
>  }
>  
>  static u8 __pci_find_next_cap_ttl(struct pci_bus *bus, unsigned int devfn,
> -				  u8 pos, int cap, int *ttl)
> +				  u8 pos, int cap)
>  {
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
> +	return PCI_FIND_NEXT_CAP_TTL(pci_bus_read_config, pos, cap, bus,
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

Please just get rid of the ttl variant, use PCI_FIND_NEXT_CAP_TTL() 
directly here, and adjust the other callers of the ttl variable to call 
this one instead.

>  
>  u8 pci_find_next_capability(struct pci_dev *dev, u8 pos, int cap)
> @@ -554,42 +534,11 @@ EXPORT_SYMBOL(pci_bus_find_capability);
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
> @@ -649,7 +598,7 @@ EXPORT_SYMBOL_GPL(pci_get_dsn);
>  
>  static u8 __pci_find_next_ht_cap(struct pci_dev *dev, u8 pos, int ht_cap)
>  {
> -	int rc, ttl = PCI_FIND_CAP_TTL;
> +	int rc;
>  	u8 cap, mask;
>  
>  	if (ht_cap == HT_CAPTYPE_SLAVE || ht_cap == HT_CAPTYPE_HOST)
> @@ -658,7 +607,7 @@ static u8 __pci_find_next_ht_cap(struct pci_dev *dev, u8 pos, int ht_cap)
>  		mask = HT_5BIT_CAP_MASK;
>  
>  	pos = __pci_find_next_cap_ttl(dev->bus, dev->devfn, pos,
> -				      PCI_CAP_ID_HT, &ttl);
> +				      PCI_CAP_ID_HT);
>  	while (pos) {
>  		rc = pci_read_config_byte(dev, pos + 3, &cap);
>  		if (rc != PCIBIOS_SUCCESSFUL)
> @@ -669,7 +618,7 @@ static u8 __pci_find_next_ht_cap(struct pci_dev *dev, u8 pos, int ht_cap)
>  
>  		pos = __pci_find_next_cap_ttl(dev->bus, dev->devfn,
>  					      pos + PCI_CAP_LIST_NEXT,
> -					      PCI_CAP_ID_HT, &ttl);
> +					      PCI_CAP_ID_HT);
>  	}
>  
>  	return 0;
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 5e1477d6e254..f9cf45026e6e 100644
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
> @@ -91,6 +93,90 @@ bool pcie_cap_has_rtctl(const struct pci_dev *dev);
>  int pci_bus_read_config(void *priv, unsigned int devfn, int where, u32 size,
>  			u32 *val);
>  
> +/* Standard Capability finder */
> +/**
> + * PCI_FIND_NEXT_CAP_TTL - Find a PCI standard capability
> + * @read_cfg: Function pointer for reading PCI config space
> + * @start: Starting position to begin search
> + * @cap: Capability ID to find
> + * @args: Arguments to pass to read_cfg function
> + *
> + * Iterates through the capability list in PCI config space to find
> + * the specified capability. Implements TTL (time-to-live) protection

to find @cap.

> + * against infinite loops.
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
> + * @read_cfg: Function pointer for reading PCI config space
> + * @start: Starting position to begin search (0 for initial search)
> + * @cap: Extended capability ID to find
> + * @args: Arguments to pass to read_cfg function
> + *
> + * Searches the extended capability space in PCI config registers
> + * for the specified capability. Implements TTL protection against

for @cap.

> + * infinite loops using a calculated maximum search count.
> + *
> + * Returns: Position of the capability if found, 0 otherwise.
> + */
> +#define PCI_FIND_NEXT_EXT_CAPABILITY(read_cfg, start, cap, args...)		\
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
> 

-- 
 i.



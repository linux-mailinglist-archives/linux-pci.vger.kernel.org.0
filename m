Return-Path: <linux-pci+bounces-25168-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9880A78ED1
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 14:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14D6F1894604
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 12:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F265C2397B9;
	Wed,  2 Apr 2025 12:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Az4ghRa+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C6C23906B;
	Wed,  2 Apr 2025 12:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743597742; cv=none; b=PlWNkCuPhg4sOSU3gFmITfDXldpQVgxUR5tFoCid/MTNY9tY9fwK2AQp9UlMlChFYrA0uZqeKBYjiBN0+q4avGSWrUJJHKzJIlDyoLUn9a18SKC4QFMi7fJxPT1MufhKvA3hsK/t0zgX6+aaQxvR+2ojvNc60nHhH5KKPikW4zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743597742; c=relaxed/simple;
	bh=kA+wEg5U0TxgdVyJVb+RwCusLFTybNSYT0oSVkCtVEA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FdnLm/BvfnuX3+pr6uX/ofWrZXVBPgwsyjeUlp1lrSXSUXJfpPwFGi/9pRLdWUUaV+IE/y08KNSq0A3jRLOo+ctMx9GyslcHfY4fO/bMwv0xm1ZFPV+sRuuy7Xsj2AK5AAWujPEX/SKz2GbrTwAHk8U40/0h55w2RsNcX13QEVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Az4ghRa+; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743597742; x=1775133742;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=kA+wEg5U0TxgdVyJVb+RwCusLFTybNSYT0oSVkCtVEA=;
  b=Az4ghRa+ZbsrEZ3Qo/s2qzPLaAvle185Vbqb/HUSbWT3GZzIQuITnj99
   r1pFENALNf72Zk+KbxcgHKJZkuVK70l8ZvO0+aSGpE6oVIqVCy9NqYQNB
   NwF04ykkGQQhIiYgKbORKuKUiuh9OOATupXrxDmhkn9n1kKxQpKhVJ4DU
   oCuMuFpMTdyhIbjj9dlDL77Xv0LLyS6WRgKedvneXiocpe4it33BxMZi/
   Vc24mAWdmjgj54Pe58EaiMyLanc4GA3oRj4oK2tIaPa6DB9q5YJccNyBf
   8EyBU0g/2MHVeGLmLfApU4ZQqeK4oMM0c8yVKhxBBWzicI+1CF3b6zF8t
   g==;
X-CSE-ConnectionGUID: JPZAaG5sS1K2n4OJkQx+ug==
X-CSE-MsgGUID: trxvzifXSBii/wz0Ne/lYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="56332973"
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="56332973"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 05:42:21 -0700
X-CSE-ConnectionGUID: CJGdjtZQT3qulREk/avKUg==
X-CSE-MsgGUID: C30gUxmxRByxqRNI10HYyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="131407407"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.40])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 05:42:17 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 2 Apr 2025 15:42:14 +0300 (EEST)
To: Hans Zhang <18255117159@163.com>
cc: lpieralisi@kernel.org, bhelgaas@google.com, kw@linux.com, 
    manivannan.sadhasivam@linaro.org, robh@kernel.org, jingoohan1@gmail.com, 
    thomas.richard@bootlin.com, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [v7 1/5] PCI: Refactor capability search into common macros
In-Reply-To: <20250402042020.48681-2-18255117159@163.com>
Message-ID: <909653ac-7ba2-9da7-f519-3d849146f433@linux.intel.com>
References: <20250402042020.48681-1-18255117159@163.com> <20250402042020.48681-2-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 2 Apr 2025, Hans Zhang wrote:

> Introduce PCI_FIND_NEXT_CAP_TTL and PCI_FIND_NEXT_EXT_CAPABILITY macros
> to consolidate duplicate PCI capability search logic found throughout the
> driver tree. This refactoring:
> 
>   1. Eliminates code duplication in capability scanning routines
>   2. Provides a standardized, maintainable implementation
>   3. Reduces error-prone copy-paste implementations
>   4. Maintains identical functionality to existing code
> 
> The macros abstract the low-level capability register scanning while
> preserving the existing PCI configuration space access patterns. They will
> enable future conversions of multiple capability search implementations
> across various drivers (e.g., PCI core, controller drivers) to use
> this centralized logic.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>  drivers/pci/pci.h             | 81 +++++++++++++++++++++++++++++++++++
>  include/uapi/linux/pci_regs.h |  2 +
>  2 files changed, 83 insertions(+)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 2e9cf26a9ee9..f705b8bd3084 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -89,6 +89,87 @@ bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
>  bool pcie_cap_has_lnkctl2(const struct pci_dev *dev);
>  bool pcie_cap_has_rtctl(const struct pci_dev *dev);
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
> + * against infinite loops.
> + *
> + * Returns: Position of the capability if found, 0 otherwise.
> + */
> +#define PCI_FIND_NEXT_CAP_TTL(read_cfg, start, cap, args...)		\
> +({									\
> +	u8 __pos = (start);						\
> +	int __ttl = PCI_FIND_CAP_TTL;					\
> +	u16 __ent;							\
> +	u8 __found_pos = 0;						\
> +	u8 __id;							\
> +									\
> +	read_cfg(args, __pos, 1, (u32 *)&__pos);			\
> +									\
> +	while (__ttl--) {						\
> +		if (__pos < PCI_STD_HEADER_SIZEOF)			\
> +			break;						\
> +		__pos = ALIGN_DOWN(__pos, 4);				\
> +		read_cfg(args, __pos, 2, (u32 *)&__ent);		\
> +		__id = FIELD_GET(PCI_CAP_ID_MASK, __ent);		\
> +		if (__id == 0xff)					\
> +			break;						\
> +		if (__id == (cap)) {					\
> +			__found_pos = __pos;				\
> +			break;						\
> +		}							\
> +		__pos = FIELD_GET(PCI_CAP_LIST_NEXT_MASK, __ent);	\

Could you please separate the coding style cleanups into own patch that 
is before the actual move patch. IMO, all those cleanups can be in the 
same patch.

You also need to add #includes for the defines you now started to use.

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
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 3445c4970e4d..a11ebbab99fc 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -206,6 +206,8 @@
>  /* 0x48-0x7f reserved */
>  
>  /* Capability lists */
> +#define PCI_CAP_ID_MASK		0x00ff
> +#define PCI_CAP_LIST_NEXT_MASK	0xff00
>  
>  #define PCI_CAP_LIST_ID		0	/* Capability ID */
>  #define  PCI_CAP_ID_PM		0x01	/* Power Management */
> 

-- 
 i.



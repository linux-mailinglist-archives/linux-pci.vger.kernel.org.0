Return-Path: <linux-pci+bounces-24527-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E809A6DB70
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 14:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6F127A2BAD
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 13:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4824825EF81;
	Mon, 24 Mar 2025 13:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mFjUYwnT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F791C5D59;
	Mon, 24 Mar 2025 13:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742822944; cv=none; b=UA7iFWoDBsYxyJVuy4os5HrhP8NE+SHlNZwA/cDSchBERS3g0PYwRViB1JpliUVRPsScDoooGtVWu21nCsQn+AXnctDFmGNvUctEUV2230ixntvsEcDtqsuFRhWKd3qVWnpk4pv/6Uxy3nqS1JPo32V+Myiw5OPyD20vDmuXsQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742822944; c=relaxed/simple;
	bh=Y46iSW+LggtctaAZhopKw9PxNLiHWQLWxsy0lpN4BA0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fvYaQP/5U7H8MY8LCMcQUu6uVqh+iUaVfwmMZtA8+MHvt6UgCSyjp4wiv534O9uErPzpgHQWYnfxSjqPo/vSDRK5sy4rjb7nZU0UPI3oN5Al4QJMw6Ssq2DlQkaYD9hyqD1Gw81pYFotjMqFhN48LV0SZvfDA1R+/IkvfUsyGW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mFjUYwnT; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742822942; x=1774358942;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Y46iSW+LggtctaAZhopKw9PxNLiHWQLWxsy0lpN4BA0=;
  b=mFjUYwnTvZfhsnh4U/JUBi3KF3DvV6orhdb9qy0ke/y4tLYkGeAEWWLP
   +YHv42X/vh2TibCVayGhpQpwavYEqAmPVDKz1KOUrFflSIzo84/y7elKC
   /i0rk1LV6SuZ8mYi8/2BoRaB5QELh1mr2KBQMylrbhDZmIitDb0xoZq31
   Z7T1qh6U6xM5OHsO+uXEh+qpcIwAKTP0maNsZoRv4pnHUlo9B3SZbz4bG
   GSwLp7jo8psJmjVKd9HBMH+bSmjlVh9NEaPzm0tF00QYu/UHOE8BIjbrx
   Is05H9xun1+O+Vu+Ng8NAUIeQmcfheVkCOY0+4mfQWE3xHj/Ii3EPjbJM
   w==;
X-CSE-ConnectionGUID: oscZYqJZSbmGO0Z87ak5kQ==
X-CSE-MsgGUID: /Mon8GBET3CRBJsEwruFAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11383"; a="55024490"
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="55024490"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 06:29:01 -0700
X-CSE-ConnectionGUID: edUV5faiTliZm7AoBf2oBQ==
X-CSE-MsgGUID: 5UO6frbsRq248I0YRPwwmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="124033273"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.251])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 06:28:58 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 24 Mar 2025 15:28:55 +0200 (EET)
To: Hans Zhang <18255117159@163.com>
cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, 
    robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com, 
    thomas.richard@bootlin.com, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [v6 1/5] PCI: Introduce generic capability search functions
In-Reply-To: <20250323164852.430546-2-18255117159@163.com>
Message-ID: <f89f3d00-4423-f65d-293e-8aec3be14418@linux.intel.com>
References: <20250323164852.430546-1-18255117159@163.com> <20250323164852.430546-2-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 24 Mar 2025, Hans Zhang wrote:

> Existing controller drivers (e.g., DWC, custom out-of-tree drivers)
> duplicate logic for scanning PCI capability lists. This creates
> maintenance burdens and risks inconsistencies.
> 
> To resolve this:
> 
> Add pci_host_bridge_find_*capability() in pci-host-helpers.c, accepting
> controller-specific read functions and device data as parameters.
> 
> This approach:
> - Centralizes critical PCI capability scanning logic
> - Allows flexible adaptation to varied hardware access methods
> - Reduces future maintenance overhead
> - Aligns with kernel code reuse best practices
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
> Changes since v5:
> https://lore.kernel.org/linux-pci/20250321163803.391056-2-18255117159@163.com
> 
> - If you put the helpers in drivers/pci/pci.c, they unnecessarily enlarge
>   the kernel's .text section even if it's known already at compile time
>   that they're never going to be used (e.g. on x86).
> 
> - Move the API for find capabilitys to a new file called
>   pci-host-helpers.c.
> 
> Changes since v4:
> https://lore.kernel.org/linux-pci/20250321101710.371480-2-18255117159@163.com
> 
> - Resolved [v4 1/4] compilation warning.
> - The patch commit message were modified.
> ---
>  drivers/pci/controller/Kconfig            | 17 ++++
>  drivers/pci/controller/Makefile           |  1 +
>  drivers/pci/controller/pci-host-helpers.c | 98 +++++++++++++++++++++++
>  drivers/pci/pci.h                         |  7 ++
>  4 files changed, 123 insertions(+)
>  create mode 100644 drivers/pci/controller/pci-host-helpers.c
> 
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 9800b7681054..0020a892a55b 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -132,6 +132,23 @@ config PCI_HOST_GENERIC
>  	  Say Y here if you want to support a simple generic PCI host
>  	  controller, such as the one emulated by kvmtool.
>  
> +config PCI_HOST_HELPERS
> +	bool
> +	prompt "PCI Host Controller Helper Functions" if EXPERT
> + 	help
> +	  This provides common infrastructure for PCI host controller drivers to
> +	  handle PCI capability scanning and other shared operations. The helper
> +	  functions eliminate code duplication across controller drivers.
> +
> +	  These functions are used by PCI controller drivers that need to scan
> +	  PCI capabilities using controller-specific access methods (e.g. when
> +	  the controller is behind a non-standard configuration space).
> +
> +	  If you are using any PCI host controller drivers that require these
> +	  helpers (such as DesignWare, Cadence, etc), this will be
> +	  automatically selected. Say N unless you are developing a custom PCI
> +	  host controller driver.

Hi,

Does this need to be user selectable at all? What's the benefit? If 
somebody is developing a driver, they can just as well add the select 
clause in that driver to get it built.

--
 i.

> +
>  config PCIE_HISI_ERR
>  	depends on ACPI_APEI_GHES && (ARM64 || COMPILE_TEST)
>  	bool "HiSilicon HIP PCIe controller error handling driver"
> diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
> index 038ccbd9e3ba..e80091eb7597 100644
> --- a/drivers/pci/controller/Makefile
> +++ b/drivers/pci/controller/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_PCIE_RCAR_HOST) += pcie-rcar.o pcie-rcar-host.o
>  obj-$(CONFIG_PCIE_RCAR_EP) += pcie-rcar.o pcie-rcar-ep.o
>  obj-$(CONFIG_PCI_HOST_COMMON) += pci-host-common.o
>  obj-$(CONFIG_PCI_HOST_GENERIC) += pci-host-generic.o
> +obj-$(CONFIG_PCI_HOST_HELPERS) += pci-host-helpers.o
>  obj-$(CONFIG_PCI_HOST_THUNDER_ECAM) += pci-thunder-ecam.o
>  obj-$(CONFIG_PCI_HOST_THUNDER_PEM) += pci-thunder-pem.o
>  obj-$(CONFIG_PCIE_XILINX) += pcie-xilinx.o
> diff --git a/drivers/pci/controller/pci-host-helpers.c b/drivers/pci/controller/pci-host-helpers.c
> new file mode 100644
> index 000000000000..cd261a281c60
> --- /dev/null
> +++ b/drivers/pci/controller/pci-host-helpers.c
> @@ -0,0 +1,98 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PCI Host Controller Helper Functions
> + *
> + * Copyright (C) 2025 Hans Zhang
> + *
> + * Author: Hans Zhang <18255117159@163.com>
> + */
> +
> +#include <linux/pci.h>
> +
> +#include "../pci.h"
> +
> +/*
> + * These interfaces resemble the pci_find_*capability() interfaces, but these
> + * are for configuring host controllers, which are bridges *to* PCI devices but
> + * are not PCI devices themselves.
> + */
> +static u8 __pci_host_bridge_find_next_cap(void *priv,
> +					  pci_host_bridge_read_cfg read_cfg,
> +					  u8 cap_ptr, u8 cap)
> +{
> +	u8 cap_id, next_cap_ptr;
> +	u16 reg;
> +
> +	if (!cap_ptr)
> +		return 0;
> +
> +	reg = read_cfg(priv, cap_ptr, 2);
> +	cap_id = (reg & 0x00ff);
> +
> +	if (cap_id > PCI_CAP_ID_MAX)
> +		return 0;
> +
> +	if (cap_id == cap)
> +		return cap_ptr;
> +
> +	next_cap_ptr = (reg & 0xff00) >> 8;
> +	return __pci_host_bridge_find_next_cap(priv, read_cfg, next_cap_ptr,
> +					       cap);

This is doing (tail) recursion?? Why??

What should be done, IMO, is that code in __pci_find_next_cap_ttl() 
refactored such that it can be reused instead of duplicating it in a 
slightly different form here and the functions below.

The capability list parser should be the same?

> +}
> +
> +u8 pci_host_bridge_find_capability(void *priv,
> +				   pci_host_bridge_read_cfg read_cfg, u8 cap)
> +{
> +	u8 next_cap_ptr;
> +	u16 reg;
> +
> +	reg = read_cfg(priv, PCI_CAPABILITY_LIST, 2);
> +	next_cap_ptr = (reg & 0x00ff);
> +
> +	return __pci_host_bridge_find_next_cap(priv, read_cfg, next_cap_ptr,
> +					       cap);
> +}
> +EXPORT_SYMBOL_GPL(pci_host_bridge_find_capability);
> +
> +static u16 pci_host_bridge_find_next_ext_capability(
> +	void *priv, pci_host_bridge_read_cfg read_cfg, u16 start, u8 cap)
> +{
> +	u32 header;
> +	int ttl;
> +	int pos = PCI_CFG_SPACE_SIZE;
> +
> +	/* minimum 8 bytes per capability */
> +	ttl = (PCI_CFG_SPACE_EXP_SIZE - PCI_CFG_SPACE_SIZE) / 8;
> +
> +	if (start)
> +		pos = start;
> +
> +	header = read_cfg(priv, pos, 4);
> +	/*
> +	 * If we have no capabilities, this is indicated by cap ID,
> +	 * cap version and next pointer all being 0.
> +	 */
> +	if (header == 0)
> +		return 0;
> +
> +	while (ttl-- > 0) {
> +		if (PCI_EXT_CAP_ID(header) == cap && pos != start)
> +			return pos;
> +
> +		pos = PCI_EXT_CAP_NEXT(header);
> +		if (pos < PCI_CFG_SPACE_SIZE)
> +			break;
> +
> +		header = read_cfg(priv, pos, 4);
> +	}
> +
> +	return 0;
> +}
> +
> +u16 pci_host_bridge_find_ext_capability(void *priv,
> +					pci_host_bridge_read_cfg read_cfg,
> +					u8 cap)
> +{
> +	return pci_host_bridge_find_next_ext_capability(priv, read_cfg, 0, cap);
> +}
> +EXPORT_SYMBOL_GPL(pci_host_bridge_find_ext_capability);
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 01e51db8d285..8d1c919cbfef 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -1034,4 +1034,11 @@ void pcim_release_region(struct pci_dev *pdev, int bar);
>  	(PCI_CONF1_ADDRESS(bus, dev, func, reg) | \
>  	 PCI_CONF1_EXT_REG(reg))
>  
> +typedef u32 (*pci_host_bridge_read_cfg)(void *priv, int where, int size);
> +u8 pci_host_bridge_find_capability(void *priv,
> +				   pci_host_bridge_read_cfg read_cfg, u8 cap);
> +u16 pci_host_bridge_find_ext_capability(void *priv,
> +					pci_host_bridge_read_cfg read_cfg,
> +					u8 cap);
> +
>  #endif /* DRIVERS_PCI_H */
> 

-- 
 i.



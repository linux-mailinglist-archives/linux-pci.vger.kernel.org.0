Return-Path: <linux-pci+bounces-24868-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA50A73790
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 17:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC6F9189D646
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 16:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB082192FC;
	Thu, 27 Mar 2025 16:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MDrtgMmt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5780A2192E4
	for <linux-pci@vger.kernel.org>; Thu, 27 Mar 2025 16:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743094702; cv=none; b=kdgd/+YW1Tl1ZUihM5UrSmwo7e/6nbbi2GUw+ELyzLt+j9gCDUhA1j4RQV8hRsyKIfRZptNBDKpWvNpayoxIIw6e1EmuU9kDkG/G6jVsMhQxh120Wc9mQ3pOK0vzdOGwpEr6iSq4BL20PWicRkHeKorUc71rQVQH9wzfmKGOO8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743094702; c=relaxed/simple;
	bh=RT138KMBYvf8p/dIxpN4afKsBebrfEQuxVX6N0QW8Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JDNoG6wulyVNopHI4JwEQYjQdj3hcZYhRuPKndS3cI4MlQLTGNtMJdo5Lj1goMt7qGMcR5267ZfJaCyXdkU+aDIH1/75Az6ilEAdd/j+6kFY4VhGe8qqwbSElUpEbDwjHteawlXtR+sT205FoM/CAnpEXHhMu2psbdbqP70bVDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MDrtgMmt; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22580c9ee0aso27880315ad.2
        for <linux-pci@vger.kernel.org>; Thu, 27 Mar 2025 09:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743094699; x=1743699499; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X69JYKuhz4RcL0yZqHBKQzuXmiTmjL3ropZ+qzIq5VI=;
        b=MDrtgMmtAynrGqubGVIIq04TYGL20X6HwGq/T3U9fEj7J/k18Esk6GZycE4B/RgKRm
         T7VLV2GGqb7blCFrqO2zWv5r4WL6aEhb4EpIhrV3FD59wLQ/nIEyD4QQLef4xyaref5r
         O3+ihFmE8xmHoKq5bMler3ySZkql129fbRibhkXAWDqrKmdxlnsISHavt9OSe5HW4wBd
         hwZbuIIboGcJkzGMvnB7zVfs/Bx9yKAUMDJRFPlx1zBkqld16VMp4LpBjR7im1F+d7xT
         mbqB9cD8jDja5HDjWF6Nil+DvPnCihzHXUoHXfp9H+h+E+AVk4kYab2Ry1ZeimQAq21l
         q/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743094699; x=1743699499;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X69JYKuhz4RcL0yZqHBKQzuXmiTmjL3ropZ+qzIq5VI=;
        b=t97AatGqlg0hjUYwcV4Z6qi7MiKGuRCPHKXsgt3EGgFBlbQXem56D0dnSkcUx+b7t9
         6W7h+7VCL1tBqOVr/Jg0XUjiHvmlxsArokdLjxHUluYfgK1qgBjib9RffxfO59o5OHf8
         KlLjYEZ0Z0GoRy2aRCo+Ga4GBx2vTRs7Y3IV5N+sHha05MdBfqAWJhCLrNNOyPx9wiL3
         XA7Az3KI2Wk4ApJ7IbBD7YdHAGt2KUjSmJJog0I1E47z17KwAFWvuG63oogsHYl/sysm
         ddTRyMtO5IqlxE4B94lHxPGR1R7XGpR0Bt42XWveR7J8m6qpUQfNeg0OpWS76ZdPO5kd
         qM2A==
X-Forwarded-Encrypted: i=1; AJvYcCWKBbFnIU3/OYlxjfJIRESBiBESqqzn47l+iy3hdLtyXyMQF+D6H6ulW6lxAzR2RIeyDahOMncg2QU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+JtAc/X5YdKsa6Ew5gkFmoLaxhqUKMCTqQ5KnnfvbFf66ER3I
	SrDhPOUWJkadQwZLh7G+y3wzwDHlBSVPORH8w4vcGlvexK8WeyF04opq1RMWvA==
X-Gm-Gg: ASbGnct+HO5QX+y3EUhDsQFuHdjArMZlse7/L+CdSHY0SxO9NvWkVDDZ0b1DRPnpelp
	uwv/cfPqhPj4nnrIDGa+NBsPxl5uHjSBrDShBHsug7Jg8Jcf9T7NjL9yxH60TJLeaugEZ9rUw0G
	E7KNTJl2TFWjUwbZyRKwGwn9j0uj/+xjb4BxZrpDptjHnKD2YgPKuBO9E0kisrsL3mOmSsPCxU9
	P2HZygZJHOiO2E+oeqQQWAvl6JyguD7w7GYCALic1MPxIwZajkk4npuEaGts5VgyGh4mxQJO01n
	GHa5NQHXRTp7+QuKc+ks+LISm3bjJcdXKb8L9Q+U814dNd3/5uB+OIY=
X-Google-Smtp-Source: AGHT+IHwuPY0Fx7bxAhLHvSP9n9cJk7C+cgwdhW0NMvfUo8FmmlkrLe6GLIwmYsoS5A7Qo0poTq5fw==
X-Received: by 2002:a17:903:228c:b0:215:b75f:a1cb with SMTP id d9443c01a7336-2280481cce0mr59185335ad.9.1743094699295;
        Thu, 27 Mar 2025 09:58:19 -0700 (PDT)
Received: from thinkpad ([120.60.71.118])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1cf8fesm1848975ad.110.2025.03.27.09.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 09:58:18 -0700 (PDT)
Date: Thu, 27 Mar 2025 22:28:15 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, 
	bhelgaas@google.com, jingoohan1@gmail.com, thomas.richard@bootlin.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [v6 1/5] PCI: Introduce generic capability search functions
Message-ID: <d6bxw26swugn6kmod5faycruzcmz4mbjcck3mhljikhmm7h4y3@o5voponyug2w>
References: <20250323164852.430546-1-18255117159@163.com>
 <20250323164852.430546-2-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250323164852.430546-2-18255117159@163.com>

On Mon, Mar 24, 2025 at 12:48:48AM +0800, Hans Zhang wrote:
> Existing controller drivers (e.g., DWC, custom out-of-tree drivers)

Oh, you should not mention 'out-of-tree drivers' as this patch is not anyway
intented to benefit them. We certainly do not care about out of tree drivers.

- Mani

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
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்


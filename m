Return-Path: <linux-pci+bounces-24528-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A25ACA6DBEF
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 14:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1338C3B09D7
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 13:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1BFCA52;
	Mon, 24 Mar 2025 13:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K6/EF/JJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3A525F790;
	Mon, 24 Mar 2025 13:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742823906; cv=none; b=RLvLD+MuFzsP1lkpD2o6ScYoCeu+DVX/hE7NcITAWO1g9Z/ZsPux4OQrrQMSVsLdMcDjQ95Vfv6pcjtW5v0FDHpnVzDaCEFWE6mWWvGTg9eI3RyzYB/PJzV9H1OWlGYZosvFxVFbFifXJehGKM33pHEA7YMFb63ussuzWxQGj8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742823906; c=relaxed/simple;
	bh=qZzhN5RLrcv7Pqw/OV2MUkyFj+vDFWWDArzJQNCkcw8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=eGC+DDqDXiHNXDlB+aW8Z6Mncho8KG3PVIWNW3QnxTwKtBeXzQW2fSz8BXkhgHlWqLgnzB3WZ8Cku97XyrPf1PtNoOgIIl7FjEZAzs/UDcP4wblosAn+HNaxuC07YG4QTTrMpqoSw1Htt2WCooberLpTm3kAUXroobnvW6LBu14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K6/EF/JJ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742823904; x=1774359904;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qZzhN5RLrcv7Pqw/OV2MUkyFj+vDFWWDArzJQNCkcw8=;
  b=K6/EF/JJ14lIWzu95CeC6wB3Z0IoAvYhjpcqi+p6iXk3VoiiOjD+3Wg+
   2eaSPx8sTAc9pBlERwcGe2jBq7HB2eznXj/uXAaQu3i/Ln5MySC0074Wl
   hczl7MAApZ1EcjQkQymF50uVvOtquD4HrcE8QJSSbqhtFtzebpgxMhKJC
   OT4sQsVc0nOwvmkVFGcZSl2kyB4R5hfSxIfW+o/wcyHNyuBt9zB95UEod
   dFFnpVP82/5svtbmIdWXySzLKAWLQge9jY6HyZicbDAUEu7BqXhcXPdjB
   eK+X+y7L4ctx3AXzBe91EiQCn0Cm0DNo7CBqtdTOKWlznY3aaOTdebRGu
   Q==;
X-CSE-ConnectionGUID: GQsbNXG8TPSO1EEpmGcuEQ==
X-CSE-MsgGUID: 6zzMnwAqR4y5ucashnL4jw==
X-IronPort-AV: E=McAfee;i="6700,10204,11383"; a="43955745"
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="43955745"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 06:45:04 -0700
X-CSE-ConnectionGUID: xJTkbHVMSF2qX9V89ypIZg==
X-CSE-MsgGUID: oIwZvSw6TrC57euv0S4F/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="124040691"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.251])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 06:44:59 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 24 Mar 2025 15:44:56 +0200 (EET)
To: Hans Zhang <18255117159@163.com>
cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, 
    robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com, 
    thomas.richard@bootlin.com, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [v6 3/5] PCI: cadence: Use common PCI host bridge APIs for
 finding the capabilities
In-Reply-To: <20250323164852.430546-4-18255117159@163.com>
Message-ID: <f467056d-8d4a-9dab-2f0a-ca589adfde53@linux.intel.com>
References: <20250323164852.430546-1-18255117159@163.com> <20250323164852.430546-4-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 24 Mar 2025, Hans Zhang wrote:

> Since the PCI core is now exposing generic APIs for the host bridges to

No need to say "since ... is now exposing". Just say "Use ..." as if the 
API has always existed even if you just added it.

> search for the PCIe capabilities, make use of them in the CDNS driver.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
> Changes since v5:
> https://lore.kernel.org/linux-pci/20250321163803.391056-4-18255117159@163.com
> 
> - Kconfig add "select PCI_HOST_HELPERS"
> ---
>  drivers/pci/controller/cadence/Kconfig        |  1 +
>  drivers/pci/controller/cadence/pcie-cadence.c | 25 +++++++++++++++++++
>  drivers/pci/controller/cadence/pcie-cadence.h |  3 +++
>  3 files changed, 29 insertions(+)
> 
> diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
> index 8a0044bb3989..0a4f245bbeb0 100644
> --- a/drivers/pci/controller/cadence/Kconfig
> +++ b/drivers/pci/controller/cadence/Kconfig
> @@ -5,6 +5,7 @@ menu "Cadence-based PCIe controllers"
>  
>  config PCIE_CADENCE
>  	bool
> +	select PCI_HOST_HELPERS
>  
>  config PCIE_CADENCE_HOST
>  	bool
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
> index 204e045aed8c..329dab4ff813 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence.c
> @@ -8,6 +8,31 @@
>  
>  #include "pcie-cadence.h"
>  
> +static u32 cdns_pcie_read_cfg(void *priv, int where, int size)
> +{
> +	struct cdns_pcie *pcie = priv;
> +	u32 val;
> +
> +	if (size == 4)
> +		val = readl(pcie->reg_base + where);

Should this use cdns_pcie_readl() ?

> +	else if (size == 2)
> +		val = readw(pcie->reg_base + where);
> +	else if (size == 1)
> +		val = readb(pcie->reg_base + where);
> +
> +	return val;
> +}
> +
> +u8 cdns_pcie_find_capability(struct cdns_pcie *pcie, u8 cap)
> +{
> +	return pci_host_bridge_find_capability(pcie, cdns_pcie_read_cfg, cap);
> +}
> +
> +u16 cdns_pcie_find_ext_capability(struct cdns_pcie *pcie, u8 cap)
> +{
> +	return pci_host_bridge_find_ext_capability(pcie, cdns_pcie_read_cfg, cap);
> +}

I'm really wondering why the read config function is provided directly as 
an argument. Shouldn't struct pci_host_bridge have some ops that can read 
config so wouldn't it make much more sense to pass it and use the func 
from there? There seems to ops in pci_host_bridge that has read(), does 
that work? If not, why?

> +
>  void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie)
>  {
>  	u32 delay = 0x3;
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> index f5eeff834ec1..6f4981fccb94 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.h
> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> @@ -557,6 +557,9 @@ static inline int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
>  }
>  #endif
>  
> +u8 cdns_pcie_find_capability(struct cdns_pcie *pcie, u8 cap);
> +u16 cdns_pcie_find_ext_capability(struct cdns_pcie *pcie, u8 cap);
> +
>  void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie);
>  
>  void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u8 fn,
> 

-- 
 i.



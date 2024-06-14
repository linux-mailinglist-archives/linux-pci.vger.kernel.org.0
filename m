Return-Path: <linux-pci+bounces-8833-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8708908C5B
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 15:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99EDB1F2249C
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 13:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3977195383;
	Fri, 14 Jun 2024 13:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KIbnr90p"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E175519D88D;
	Fri, 14 Jun 2024 13:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718371082; cv=none; b=hEMabb6ueXd74WVkU4HrpkRyvbi5+w/AmgMrlCwp8nrPfjfOW/Iqbh6jBhKbpkHsPUDIZPsO9Wy7fXSJYwaEj657pEcZNZMEB+fJ92mVOeZXcAlmiXTrl3Qkj2ZS/fPJfJrIPkwNJlSeLOEfcs4nWbmvuHr2gZC9c9gJe62DN/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718371082; c=relaxed/simple;
	bh=B/szTGuEIXbe/8epPrqiJ3Kbj5OfTgwv1AwgTjgi5WY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ld8kbXmBeZinCWqfum3uV7i/hD1oQxWIddOzHHMPwHLsbzsGIK7UXHNaqWQbRDmP4Rpy1pdtm7wpZvhTI7o3koLKaFCZ0wq1fJA0gnkxrBVGNLVgGcQbbnQCVF2bKTXxlyS9k8vTwu+4QptPxD1p70lb9eAivk78VBQYMam+Qy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KIbnr90p; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718371082; x=1749907082;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=B/szTGuEIXbe/8epPrqiJ3Kbj5OfTgwv1AwgTjgi5WY=;
  b=KIbnr90pXHH3k63WmBjPLa6N0+MSU+GtFkpqHeHX4TrO0lISO6188GH3
   3MCVfrVqG6fM4acwFiTKKsfJw5Q1y7PWRXt3b2MGpAhZ1hbvuMhIPLw21
   pHVKGJeH+Osby2C+YaRzuNTVNEnh8nmtEXZiOYWM9R2GdY8BiX038KkTR
   wMs/ecJ3vqjqEFYjW0k079LQNX7Lk2cZ3B+1XyKKSRawEV0f5fZB47E2S
   vxAYDYg2UeN8mqNKYuWqWeH8GW9wfOmQjoQ9J5vf6mbonlzYhBirSel8v
   /2vhzrSeh+PvooBiNQodGB9pBIH+yenwG+gNeiyEDawUA+pde6sbM4jrl
   g==;
X-CSE-ConnectionGUID: lg+bqW4uQr24rC74n29CqQ==
X-CSE-MsgGUID: cXzSQavTQPKOlXoMTSZ7/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="15089936"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="15089936"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 06:18:01 -0700
X-CSE-ConnectionGUID: 2MiM/vp9TiOzq8Zrdxi7qQ==
X-CSE-MsgGUID: R1elhJSqTf6qenCl6V9I7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="44911915"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.222])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 06:17:56 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 14 Jun 2024 16:17:53 +0300 (EEST)
To: daire.mcnamara@microchip.com
cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
    conor.dooley@microchip.com, lpieralisi@kernel.org, kw@linux.com, 
    robh@kernel.org, bhelgaas@google.com, LKML <linux-kernel@vger.kernel.org>, 
    linux-riscv@lists.infradead.org, krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v3 1/3] PCI: microchip: Fix outbound address translation
 tables
In-Reply-To: <20240612112213.2734748-2-daire.mcnamara@microchip.com>
Message-ID: <77415307-f80c-a34b-b84f-a0febe6f2641@linux.intel.com>
References: <20240612112213.2734748-1-daire.mcnamara@microchip.com> <20240612112213.2734748-2-daire.mcnamara@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 12 Jun 2024, daire.mcnamara@microchip.com wrote:

> From: Daire McNamara <daire.mcnamara@microchip.com>
> 
> On Microchip PolarFire SoC (MPFS) the PCIe Root Port can be behind one of
> three general-purpose Fabric Interface Controller (FIC) buses that
> encapsulate an AXI-M interface. That FIC is responsible for managing
> the translations of the upper 32-bits of the AXI-M address. On MPFS,
> the Root Port driver needs to take account of that outbound address
> translation done by the parent FIC bus before setting up its own
> outbound address translation tables.  In all cases on MPFS,
> the remaining outbound address translation tables are 32-bit only.
> 
> Limit the outbound address translation tables to 32-bit only.
> 
> Fixes: 6f15a9c9f941 ("PCI: microchip: Add Microchip Polarfire PCIe controller driver")
> 
> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>

Don't leave spaces between tag lines.

> ---
>  drivers/pci/controller/pcie-microchip-host.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
> index 137fb8570ba2..853adce24492 100644
> --- a/drivers/pci/controller/pcie-microchip-host.c
> +++ b/drivers/pci/controller/pcie-microchip-host.c
> @@ -933,7 +933,7 @@ static int mc_pcie_init_irq_domains(struct mc_pcie *port)
>  
>  static void mc_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
>  				 phys_addr_t axi_addr, phys_addr_t pci_addr,
> -				 size_t size)
> +				 u64 size)

I don't see how this is related to what is described by the commit 
message.

If there's need for this change it should be justified properly and 
it looks to me that resource_size_t would be more appropriate here given 
the callers use resource_size() to determine this parameter?

>  {
>  	u32 atr_sz = ilog2(size) - 1;
>  	u32 val;
> @@ -983,7 +983,8 @@ static int mc_pcie_setup_windows(struct platform_device *pdev,
>  		if (resource_type(entry->res) == IORESOURCE_MEM) {
>  			pci_addr = entry->res->start - entry->offset;
>  			mc_pcie_setup_window(bridge_base_addr, index,
> -					     entry->res->start, pci_addr,
> +					     entry->res->start & 0xffffffff,
> +					     pci_addr,
>  					     resource_size(entry->res));
>  			index++;
>  		}
> @@ -1117,9 +1118,8 @@ static int mc_platform_init(struct pci_config_window *cfg)
>  	int ret;
>  
>  	/* Configure address translation table 0 for PCIe config space */
> -	mc_pcie_setup_window(bridge_base_addr, 0, cfg->res.start,
> -			     cfg->res.start,
> -			     resource_size(&cfg->res));
> +	mc_pcie_setup_window(bridge_base_addr, 0, cfg->res.start & 0xffffffff,
> +			     0, resource_size(&cfg->res));

Given your commit message, it would be more obvious to the code reader if 
the literal is replaced with something like RP_OUTBOUND_TRANS_TBL_MASK 
(that is GENMASK(31, 0)). Feel free to come up better name if I didn't 
understand all the details right based on your commit message.

-- 
 i.




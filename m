Return-Path: <linux-pci+bounces-9157-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60834913CF3
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jun 2024 19:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA6D128364B
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jun 2024 17:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934A9183068;
	Sun, 23 Jun 2024 17:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j3sAIs2a"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97ED8BE7;
	Sun, 23 Jun 2024 17:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719162165; cv=none; b=QoGCibrtqUc26yxKg6sBc3gmukP9Zc9lHRUiK/AGEP1G6bkSJ7gsINIatWfDpDjwkPMq7N9RlIpd0YZkqv5r/sc6WvzdoVq7LiZtLm61zPzvoaF4T0GA+V5AAARX6VIYPBU+/9YF5FwlKncDwyQIDBQ4YyJ4FZcN0VmcOfBBpvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719162165; c=relaxed/simple;
	bh=zfODlBOh97OBvCy1FrENRxxZBTPeLPsVTYAwdmU+/oU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=h71PRgB1OZiVMwqnLu7PHdfsgO6pXp1raHMnNcZbsVDRXLNsQ6HzdSHgY7QEHWI/icHGqS2fNSlUSRg2NsXq+0Kc5a1nEPg46q1llFwNOjWEbsWfBjT+gNK9eUH8czDwqV9664WGCBjhJgjBXekEEaesIjhLHz9J3u2iH4fj91M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j3sAIs2a; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719162164; x=1750698164;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=zfODlBOh97OBvCy1FrENRxxZBTPeLPsVTYAwdmU+/oU=;
  b=j3sAIs2alwmF/9yEHKMjbVK3x8zNlfxhIvhqLrTyGX6oLD2qNMrAD1N6
   UnYxP//VSDEb9Bys7eqHb9NAJU2QbnMzIQkbpysywnXDUD48o/PsQ99hO
   dYdgSpsN9zBoEYKqWSJ2zk4i0RqF++/HHDF/1z2pcPqEP8aKom+OndRxo
   r2B8SySyK+32qqoBjNgbd3xgtZ/CQUOw/0fz/0ZeXTxZaGPLWBUdTKh/e
   CytIFFeKhwkJmW0xBwQJtraAuBezGf0JwLIvOP2zF6uC1EzNa0jleduFB
   XoNxAUpjBeKQDkFTnnpcpUYzUgXr2VxeiLKG6dNhwGu52teND7OovyXZt
   Q==;
X-CSE-ConnectionGUID: yWGVQgyFSP+14i5oxWsq/A==
X-CSE-MsgGUID: ZWGR+xlPRQa4f3zl9OuhVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11112"; a="26721859"
X-IronPort-AV: E=Sophos;i="6.08,260,1712646000"; 
   d="scan'208";a="26721859"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2024 10:02:43 -0700
X-CSE-ConnectionGUID: tzYSooFGRHKN41oXEJJ4tw==
X-CSE-MsgGUID: lgVTm9aTTAiZOiOe5cfh4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,260,1712646000"; 
   d="scan'208";a="42972002"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.55])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2024 10:02:39 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Sun, 23 Jun 2024 20:02:35 +0300 (EEST)
To: daire.mcnamara@microchip.com
cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
    conor.dooley@microchip.com, lpieralisi@kernel.org, kw@linux.com, 
    robh@kernel.org, bhelgaas@google.com, LKML <linux-kernel@vger.kernel.org>, 
    linux-riscv@lists.infradead.org, krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v4 1/3] PCI: microchip: Fix outbound address translation
 tables
In-Reply-To: <20240621112915.3434402-2-daire.mcnamara@microchip.com>
Message-ID: <395f27f6-d263-71d3-acbd-b1872bc48fa3@linux.intel.com>
References: <20240621112915.3434402-1-daire.mcnamara@microchip.com> <20240621112915.3434402-2-daire.mcnamara@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 21 Jun 2024, daire.mcnamara@microchip.com wrote:

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
>  
>  	/* Need some fixups in config space */
>  	mc_pcie_enable_msi(port, cfg->win);

I had some comments for this patch too none of which are addressed by the 
the v4?

-- 
 i.



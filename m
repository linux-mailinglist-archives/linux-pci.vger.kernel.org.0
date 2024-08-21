Return-Path: <linux-pci+bounces-11976-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F50D95A433
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 19:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88AA6B21EDA
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 17:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8FF1B2EE2;
	Wed, 21 Aug 2024 17:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OL4lhw/O"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2536913E40F;
	Wed, 21 Aug 2024 17:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724262970; cv=none; b=YH8qRPrKW33IjSEOZNYK/3rpHKDuoDkd3QhXPK355oltYERXvh0zxLF+2o8Wd0xjiG+AmVN1s0WmrgBc8PiuE/bnWaRWMXMI7l2RjcgDMMyWZIsJxFZWnugS6awqDJtq1ukNqGvWjLjKV2V8slgWi2PN2/ZjJYwwyE2/ngdNp8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724262970; c=relaxed/simple;
	bh=5rjtecgTLe61TDiP1Qutb2BjskSqEw4NOTWaKKSmqGM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FZD/LmgcOJuqa3mpRGqsvwKe/FwFtOO2urcOY5NO05rpMDx2VImnRnEAC6UXZJTIbqhtyOF/XuN3BIh7FPtDQFuhGHxRW+kbcnP5xG0ylwMg8luyakf4xONvWqEc7O41qs5iGhNjCX3jWrRxMHyUEjjQmfAAtNXzhhtcuPNVpZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OL4lhw/O; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724262969; x=1755798969;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=5rjtecgTLe61TDiP1Qutb2BjskSqEw4NOTWaKKSmqGM=;
  b=OL4lhw/OnISWTZlinPzoIeCPfiywumClGGBgQNNTeZM1ko0YwHRRfzpA
   9jsDZKy3gnWa+9Zq+56WObMUIMnX2Iu51AbUd+OuBLNuBGRGYQHa/hoUL
   Z/i/6dVt+NFYsVwqqV5ZxM6JI2v8VixtlpzxKRVG28k6Rf9k+A75j5zGB
   4fJ6IPehSV3kXyFQIs7S2KPHvB0JutTqsm2I7BDCGqk+ycBr68Uu2A8BN
   Gz92kjUHzFv3Xv9ym/5zyVuVxXcwm74xoN3arm0jBdq8KU1KPUYJRVKaU
   fEeYX7kxIy3xxeXGnxIgoyeAo4cOqHoYLiMdHK6jtEyV6P88J0UZfJor6
   A==;
X-CSE-ConnectionGUID: XdMFfh6hTpuCWxqamMZLEQ==
X-CSE-MsgGUID: 4SpYaQTNRGinUYpB5aB8lQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="48035548"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="48035548"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 10:52:20 -0700
X-CSE-ConnectionGUID: ojB2pnmJT526RXpL0G9esA==
X-CSE-MsgGUID: vzwY+38oRJ6Z3u7wngf2QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="65369743"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.181])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 10:52:16 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 21 Aug 2024 20:52:13 +0300 (EEST)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: daire.mcnamara@microchip.com, linux-pci@vger.kernel.org, 
    devicetree@vger.kernel.org, conor.dooley@microchip.com, 
    lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com, 
    LKML <linux-kernel@vger.kernel.org>, linux-riscv@lists.infradead.org, 
    krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v8 1/3] PCI: microchip: Fix outbound address translation
 tables
In-Reply-To: <20240821170330.GA256147@bhelgaas>
Message-ID: <62e20d95-1ab8-dbc2-41c6-21ca48d56c6f@linux.intel.com>
References: <20240821170330.GA256147@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 21 Aug 2024, Bjorn Helgaas wrote:

> On Wed, Aug 21, 2024 at 02:02:15PM +0100, daire.mcnamara@microchip.com wrote:
> > From: Daire McNamara <daire.mcnamara@microchip.com>
> > 
> > On Microchip PolarFire SoC (MPFS) the PCIe Root Port can be behind one of
> > three general-purpose Fabric Interface Controller (FIC) buses that
> > encapsulate an AXI-M interface. That FIC is responsible for managing
> > the translations of the upper 32-bits of the AXI-M address. On MPFS,
> > the Root Port driver needs to take account of that outbound address
> > translation done by the parent FIC bus before setting up its own
> > outbound address translation tables.  In all cases on MPFS,
> > the remaining outbound address translation tables are 32-bit only.
> > 
> > Limit the outbound address translation tables to 32-bit only.
> > 
> > This necessitates changing a size_t in mc_pcie_setup_window
> > to a u64 to avoid a compile error on 32-bit platforms.
> 
> I don't see this size_t change in this patch.  Add "()" after function
> name if there's a relevant function here.

It looks that change was still present in v7 but also "u64" is not correct 
either because it was changed to resource_size_t.

> > Fixes: 6f15a9c9f941 ("PCI: microchip: Add Microchip Polarfire PCIe controller driver")
> > Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > Reviewed-by: Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  .../pci/controller/plda/pcie-microchip-host.c | 30 ++++++++++++++++---
> >  1 file changed, 26 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
> > index 48f60a04b740..da766de347bd 100644
> > --- a/drivers/pci/controller/plda/pcie-microchip-host.c
> > +++ b/drivers/pci/controller/plda/pcie-microchip-host.c
> > @@ -21,6 +21,8 @@
> >  #include "../../pci.h"
> >  #include "pcie-plda.h"
> >  
> > +#define MC_OUTBOUND_TRANS_TBL_MASK		GENMASK(31, 0)
> > +
> >  /* PCIe Bridge Phy and Controller Phy offsets */
> >  #define MC_PCIE1_BRIDGE_ADDR			0x00008000u
> >  #define MC_PCIE1_CTRL_ADDR			0x0000a000u
> > @@ -612,6 +614,27 @@ static void mc_disable_interrupts(struct mc_pcie *port)
> >  	writel_relaxed(GENMASK(31, 0), bridge_base_addr + ISTATUS_HOST);
> >  }
> >  
> > +int mc_pcie_setup_iomems(struct pci_host_bridge *bridge,
> > +			   struct plda_pcie_rp *port)
> > +{
> > +	void __iomem *bridge_base_addr = port->bridge_addr;
> > +	struct resource_entry *entry;
> > +	u64 pci_addr;
> > +	u32 index = 1;
> > +
> > +	resource_list_for_each_entry(entry, &bridge->windows) {
> > +		if (resource_type(entry->res) == IORESOURCE_MEM) {
> > +			pci_addr = entry->res->start - entry->offset;
> > +			plda_pcie_setup_window(bridge_base_addr, index,
> > +					       entry->res->start & MC_OUTBOUND_TRANS_TBL_MASK,
> > +					       pci_addr, resource_size(entry->res));
> > +			index++;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static int mc_platform_init(struct pci_config_window *cfg)
> >  {
> >  	struct device *dev = cfg->parent;
> > @@ -622,15 +645,14 @@ static int mc_platform_init(struct pci_config_window *cfg)
> >  	int ret;
> >  
> >  	/* Configure address translation table 0 for PCIe config space */
> > -	plda_pcie_setup_window(bridge_base_addr, 0, cfg->res.start,
> > -			       cfg->res.start,
> > -			       resource_size(&cfg->res));
> > +	plda_pcie_setup_window(bridge_base_addr, 0, cfg->res.start & MC_OUTBOUND_TRANS_TBL_MASK,
> > +			       0, resource_size(&cfg->res));
> >  
> >  	/* Need some fixups in config space */
> >  	mc_pcie_enable_msi(port, cfg->win);
> >  
> >  	/* Configure non-config space outbound ranges */
> > -	ret = plda_pcie_setup_iomems(bridge, &port->plda);
> > +	ret = mc_pcie_setup_iomems(bridge, &port->plda);
> >  	if (ret)
> >  		return ret;
> >  
> > -- 
> > 2.34.1
> > 
> 

-- 
 i.



Return-Path: <linux-pci+bounces-32569-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD56B0AB6E
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 23:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0A6A5C010B
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 21:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02B111712;
	Fri, 18 Jul 2025 21:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ToZvlB0o"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D4821D3EF;
	Fri, 18 Jul 2025 21:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752874143; cv=none; b=R7BmIU+pa8Ll3zYrmShN8WIax0Mr+txu4lM0xXOt7J6E3CLw5GOYoGlemBrUZOxlSGjljP+vpy12fNVkQvbSNGsF4w5xrVSy9a4vzCa+fjfke439Uk8fanfr9I7gGTJ14RnV/xy7K6p1668Ae937KbV3MmWH/0SObJWB69sqfRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752874143; c=relaxed/simple;
	bh=vOrb6Yb5DoiO0x4GnHqM3vMMF2dSaJYJ+AB9OGKAJH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FzGx7aNspWdH293Q5v12FadwyffrnuyRABIH008zQVJzvVwBQDZRBxHQvoqK+/8dUAyGRTKZq3bu8Sb6Z64ISn9d6NOYz8+8J+GUV9zlCkDE8RGt3t1FkwFLa08Dk5OqKCxE94g9Xx0VrchEzC4bot7XGGGBJTUnSAnhI6nW6Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ToZvlB0o; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752874141; x=1784410141;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vOrb6Yb5DoiO0x4GnHqM3vMMF2dSaJYJ+AB9OGKAJH8=;
  b=ToZvlB0ofj6UfiwUnVV/mUD4nhhOAqE+6yuvufdQ4fZx35/FCL9SMdxz
   kR46LsxUrURuPAjm01M5ipP1acca7x1x08sritVgqq2+h/ovIgmUnXDAH
   hDh+uzRX5CwdbpDFkMFvBjrgYl+c7p7H7G4OPv6zexl3L4BdJ+AcJRC8Q
   E5xEyVZmOZvxBUFzuIFJ4W592ghsVu6NOCfrbFuK3jI7xSgMWSjtLYPLD
   oZXF8aBKrPtb8DTah1omrfNEdedbCDu5zXHpwjjYy57C2rByZqPvDI58f
   5v3V6r94CYUns4oAZt+iKBo0RYH0i6UhVtLD/m0h0knSvcNbD5uzbZ++x
   g==;
X-CSE-ConnectionGUID: 7Yggw/4eTWyf1LcaqsyxVg==
X-CSE-MsgGUID: k3DNxok8QhKgx8luzEy6Dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="55322460"
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="55322460"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 14:29:00 -0700
X-CSE-ConnectionGUID: DQojZlq0SeaM2PJ0llAT2Q==
X-CSE-MsgGUID: /VQhtCFHSq+w/sVVDTRrqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="158561336"
Received: from unknown (HELO [10.247.118.125]) ([10.247.118.125])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 14:28:51 -0700
Message-ID: <a5b917d5-126e-48a8-b9c3-91d7bb2466e4@intel.com>
Date: Fri, 18 Jul 2025 14:28:46 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 09/17] cxl/pci: Map CXL Endpoint Port and CXL Switch
 Port RAS registers
To: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250626224252.1415009-1-terry.bowman@amd.com>
 <20250626224252.1415009-10-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250626224252.1415009-10-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/26/25 3:42 PM, Terry Bowman wrote:
> CXL Endpoint (EP) Ports may include Root Ports (RP) or Downstream Switch
> Ports (DSP). CXL RPs and DSPs contain RAS registers that require memory
> mapping to enable RAS logging. This initialization is currently missing and
> must be added for CXL RPs and DSPs.
> 
> Update cxl_dport_init_ras_reporting() to support RP and DSP RAS mapping.
> Add alongside the existing Restricted CXL Host Downstream Port RAS mapping.
> 
> Update cxl_endpoint_port_probe() to invoke cxl_dport_init_ras_reporting().
> This will initiate the RAS mapping for CXL RPs and DSPs when each CXL EP is
> created and added to the EP port.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>  drivers/cxl/cxl.h  |  2 ++
>  drivers/cxl/mem.c  |  3 ++-
>  drivers/cxl/port.c | 58 +++++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 61 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index c57c160f3e5e..d696d419bd5a 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -590,6 +590,7 @@ struct cxl_dax_region {
>   * @parent_dport: dport that points to this port in the parent
>   * @decoder_ida: allocator for decoder ids
>   * @reg_map: component and ras register mapping parameters
> + * @uport_regs: mapped component registers
>   * @nr_dports: number of entries in @dports
>   * @hdm_end: track last allocated HDM decoder instance for allocation ordering
>   * @commit_end: cursor to track highest committed decoder for commit ordering
> @@ -610,6 +611,7 @@ struct cxl_port {
>  	struct cxl_dport *parent_dport;
>  	struct ida decoder_ida;
>  	struct cxl_register_map reg_map;
> +	struct cxl_component_regs uport_regs;
>  	int nr_dports;
>  	int hdm_end;
>  	int commit_end;
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 6e6777b7bafb..d2155f45240d 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -166,7 +166,8 @@ static int cxl_mem_probe(struct device *dev)
>  	else
>  		endpoint_parent = &parent_port->dev;
>  
> -	cxl_dport_init_ras_reporting(dport, dev);
> +	if (dport->rch)
> +		cxl_dport_init_ras_reporting(dport, dev);
>  
>  	scoped_guard(device, endpoint_parent) {
>  		if (!endpoint_parent->driver) {
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 021f35145c65..b52f82925891 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -111,6 +111,17 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>  	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
>  }
>  
> +static void cxl_uport_init_ras_reporting(struct cxl_port *port,
> +					 struct device *host)
> +{
> +	struct cxl_register_map *map = &port->reg_map;
> +
> +	map->host = host;
> +	if (cxl_map_component_regs(map, &port->uport_regs,
> +				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
> +		dev_dbg(&port->dev, "Failed to map RAS capability\n");
> +}
> +
>  /**
>   * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
>   * @dport: the cxl_dport that needs to be initialized
> @@ -119,7 +130,6 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>  void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
>  {
>  	dport->reg_map.host = host;
> -	cxl_dport_map_ras(dport);
>  
>  	if (dport->rch) {
>  		struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport->dport_dev);
> @@ -127,12 +137,54 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
>  		if (!host_bridge->native_aer)
>  			return;
>  
> +		cxl_dport_map_ras(dport);
>  		cxl_dport_map_rch_aer(dport);
>  		cxl_disable_rch_root_ints(dport);
> +		return;
>  	}
> +
> +	if (cxl_map_component_regs(&dport->reg_map, &dport->regs.component,
> +				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
> +		dev_dbg(dport->dport_dev, "Failed to map RAS capability\n");
> +
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
>  
> +static void cxl_switch_port_init_ras(struct cxl_port *port)
> +{
> +	if (is_cxl_root(to_cxl_port(port->dev.parent)))
> +		return;
> +
> +	/* May have upstream DSP or RP */
> +	if (port->parent_dport && dev_is_pci(port->parent_dport->dport_dev)) {
> +		struct pci_dev *pdev = to_pci_dev(port->parent_dport->dport_dev);
> +
> +		if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) ||
> +		    (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM))
> +			cxl_dport_init_ras_reporting(port->parent_dport, &port->dev);
> +	}
> +
> +	cxl_uport_init_ras_reporting(port, &port->dev);
> +}
> +
> +static void cxl_endpoint_port_init_ras(struct cxl_port *port)

Maybe rename 'port' to 'ep' to be explicit

> +{
> +	struct cxl_dport *dport;

parent_dport would be clearer. I was thinking why does the endpoint have a dport for a second there.

> +	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
> +	struct cxl_port *parent_port __free(put_cxl_port) =
> +		cxl_mem_find_port(cxlmd, &dport);
> +
> +	if (!dport || !dev_is_pci(dport->dport_dev)) {
> +		dev_err(&port->dev, "CXL port topology not found\n");> +		return;
> +	}
> +
> +	cxl_dport_init_ras_reporting(dport, cxlmd->cxlds->dev);
> +}
> +
> +#else
> +static void cxl_endpoint_port_init_ras(struct cxl_port *port) { }
> +static void cxl_switch_port_init_ras(struct cxl_port *port) { }
>  #endif /* CONFIG_PCIEAER_CXL */

I cc'd you on the new patch to move all the AER stuff to core/pci_aer.c. That should take care of ifdef CONFIG_PCIEAER_CXL in pci.c and port.c.

DJ

>  >  static int cxl_switch_port_probe(struct cxl_port *port)
> @@ -149,6 +201,8 @@ static int cxl_switch_port_probe(struct cxl_port *port)
>  
>  	cxl_switch_parse_cdat(port);
>  
> +	cxl_switch_port_init_ras(port);
> +
>  	cxlhdm = devm_cxl_setup_hdm(port, NULL);
>  	if (!IS_ERR(cxlhdm))
>  		return devm_cxl_enumerate_decoders(cxlhdm, NULL);
> @@ -203,6 +257,8 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  	if (rc)
>  		return rc;
>  
> +	cxl_endpoint_port_init_ras(port);
> +
>  	/*
>  	 * Now that all endpoint decoders are successfully enumerated, try to
>  	 * assemble regions from committed decoders



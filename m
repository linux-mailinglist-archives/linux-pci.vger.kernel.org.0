Return-Path: <linux-pci+bounces-44871-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2DCD216D9
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 22:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0FEAC306C3EA
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 21:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40193A7831;
	Wed, 14 Jan 2026 21:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R45sC9Rk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E9138E128;
	Wed, 14 Jan 2026 21:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768427264; cv=none; b=SXcsJbJImjbatEENkNfiDujhZqdInWI96X9Qgg1jMHv0VX+pbCnrgD4/uPstCkc5ACjrEIaHUQ3YQu6/aHx4baSxvCrJTs2yaGQfn8aehG4srGz6xHPFaLw0URKx7TBaS2dP9CQAHPABTvcGf/uajmTycxaKE4y4CMQLXzsL9iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768427264; c=relaxed/simple;
	bh=n4aNrPU+lkDhdbKcrmV5s1lB/MvXmKpjot+AtwCiI7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WHWOnZ4gUWxJ3WnbGP5VvFNd/GH3iwCUNWLitcZjVIRatWzaMzo38JbDhC+SMPQRoYs4QU9xEQvlwAH1HMIt/Dj8cKfRGzethmTBQ21hXo/7kbmoVthy1lvB/T1KHtM8g0WO8zZ1Y6MLFuR57KYZT2ymYUmQKMcwnFjdeAOGgRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R45sC9Rk; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768427258; x=1799963258;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=n4aNrPU+lkDhdbKcrmV5s1lB/MvXmKpjot+AtwCiI7I=;
  b=R45sC9Rkqu/9sHK7blXF5hdUqbsbA1Jgzrf40Vsle+7YNqSb40A6Reuz
   BnPJ5bG/5mEQgnTQDpo15rwStH7dt9Ls5rcTHmTBFjIPEITefD3RTgGsX
   vIJ2oSeQnVvJkEbcKNsD0WGTXWAwCDH0rR8dU605eOVk5wQDezvGANzc1
   ZlBIsH1m1bqNziN1w6OkO+auzRRPA7Zv291J4V4lmdZYsOYYM/dgnFQ+M
   rM3zKZ3HhYCJ/xU9Lk8U49d1ZBPMCL9CkVzR8HZeshKXdReUBjtzB0Bl2
   PMi4rgcoSz0VRGpT8t9FqpOPUtAiHzZ1wlQV1lO88xuLRLPcpQw3+TPXB
   A==;
X-CSE-ConnectionGUID: wucvu4kJRbGZyttPDPp8Pg==
X-CSE-MsgGUID: LBu99uHnTZ6SpaNf32IyAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="69901778"
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="69901778"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 13:47:31 -0800
X-CSE-ConnectionGUID: CBNQWSXISI2WsCUFXmv4xg==
X-CSE-MsgGUID: 8XY3L6vlRYyKe24FOk7k0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="209251497"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.111.5]) ([10.125.111.5])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 13:47:29 -0800
Message-ID: <ca150f87-84ef-4f5e-b59c-d67f309a9d4f@intel.com>
Date: Wed, 14 Jan 2026 14:47:27 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 21/34] cxl/port: Move dport RAS reporting to a port
 resource
To: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, vishal.l.verma@intel.com, alucerop@amd.com,
 ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260114182055.46029-1-terry.bowman@amd.com>
 <20260114182055.46029-22-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260114182055.46029-22-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/14/26 11:20 AM, Terry Bowman wrote:
> From: Dan Williams <dan.j.williams@intel.com>
> 
> Towards the end goal of making all CXL RAS capability handling uniform
> across upstream host bridges, upstream switch ports, and upstream endpoint
> ports, move dport RAS setup to cxl_endpoint_port_probe(). Rename the RAS
> setup helper to devm_cxl_dport_ras_setup() for symmetry with
> devm_cxl_switch_port_decoders_setup().
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Terry Bowman <terry.bowman@amd.com>

missing sign off tag

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> 
> ---
> 
> Changes in v13 -> v14:
> - New patch
> ---
>  drivers/cxl/core/ras.c        | 12 ++++++------
>  drivers/cxl/cxlpci.h          |  8 ++++----
>  drivers/cxl/mem.c             |  2 --
>  drivers/cxl/port.c            | 12 ++++++++++++
>  tools/testing/cxl/Kbuild      |  2 +-
>  tools/testing/cxl/test/mock.c |  6 +++---
>  6 files changed, 26 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 72908f3ced77..d71fcac31cf2 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -139,17 +139,17 @@ static void cxl_dport_map_ras(struct cxl_dport *dport)
>  }
>  
>  /**
> - * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
> + * devm_cxl_dport_ras_setup - Setup CXL RAS report on this dport
>   * @dport: the cxl_dport that needs to be initialized
> - * @host: host device for devm operations
>   */
> -void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
> +void devm_cxl_dport_ras_setup(struct cxl_dport *dport)
>  {
> -	dport->reg_map.host = host;
> +	dport->reg_map.host = &dport->port->dev;
>  	cxl_dport_map_ras(dport);
>  
>  	if (dport->rch) {
> -		struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport->dport_dev);
> +		struct pci_host_bridge *host_bridge =
> +			to_pci_host_bridge(dport->dport_dev);
>  
>  		if (!host_bridge->native_aer)
>  			return;
> @@ -158,7 +158,7 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
>  		cxl_disable_rch_root_ints(dport);
>  	}
>  }
> -EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_dport_ras_setup, "CXL");
>  
>  void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base)
>  {
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 6f9c78886fd9..e41bb93d583a 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -81,7 +81,7 @@ void read_cdat_data(struct cxl_port *port);
>  void cxl_cor_error_detected(struct pci_dev *pdev);
>  pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  				    pci_channel_state_t state);
> -void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
> +void devm_cxl_dport_ras_setup(struct cxl_dport *dport);
>  #else
>  static inline void cxl_cor_error_detected(struct pci_dev *pdev) { }
>  
> @@ -90,9 +90,9 @@ static inline pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  {
>  	return PCI_ERS_RESULT_NONE;
>  }
> -
> -static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
> -						struct device *host) { }
> +static inline void devm_cxl_dport_ras_setup(struct cxl_dport *dport)
> +{
> +}
>  #endif
>  
>  #endif /* __CXL_PCI_H__ */
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index c2ee7f7f6320..e25c33f8c6cf 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -166,8 +166,6 @@ static int cxl_mem_probe(struct device *dev)
>  	else
>  		endpoint_parent = &parent_port->dev;
>  
> -	cxl_dport_init_ras_reporting(dport, dev);
> -
>  	scoped_guard(device, endpoint_parent) {
>  		if (!endpoint_parent->driver) {
>  			dev_err(dev, "CXL port topology %s not enabled\n",
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 2770bc8520d3..8f8fc98c1428 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -75,6 +75,7 @@ static int cxl_switch_port_probe(struct cxl_port *port)
>  static int cxl_endpoint_port_probe(struct cxl_port *port)
>  {
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
> +	struct cxl_dport *dport = port->parent_dport;
>  	int rc;
>  
>  	/* Cache the data early to ensure is_visible() works */
> @@ -90,6 +91,17 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  	if (rc)
>  		return rc;
>  
> +	/*
> +	 * With VH (CXL Virtual Host) topology the cxl_port::add_dport() method
> +	 * handles RAS setup for downstream ports. With RCH (CXL Restricted CXL
> +	 * Host) topologies the downstream port is enumerated early by platform
> +	 * firmware, but the RCRB (root complex register block) is not mapped
> +	 * until after the cxl_pci driver attaches to the RCIeP (root complex
> +	 * integrated endpoint).
> +	 */
> +	if (dport->rch)
> +		devm_cxl_dport_ras_setup(dport);
> +
>  	/*
>  	 * Now that all endpoint decoders are successfully enumerated, try to
>  	 * assemble regions from committed decoders
> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index 25516728535e..7250bedf0448 100644
> --- a/tools/testing/cxl/Kbuild
> +++ b/tools/testing/cxl/Kbuild
> @@ -8,7 +8,7 @@ ldflags-y += --wrap=cxl_await_media_ready
>  ldflags-y += --wrap=cxl_add_rch_dport
>  ldflags-y += --wrap=cxl_rcd_component_reg_phys
>  ldflags-y += --wrap=cxl_endpoint_parse_cdat
> -ldflags-y += --wrap=cxl_dport_init_ras_reporting
> +ldflags-y += --wrap=devm_cxl_dport_ras_setup
>  ldflags-y += --wrap=devm_cxl_endpoint_decoders_setup
>  ldflags-y += --wrap=hmat_get_extended_linear_cache_size
>  ldflags-y += --wrap=cxl_add_dport_by_dev
> diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
> index 10140a4c5fac..8883357ee50d 100644
> --- a/tools/testing/cxl/test/mock.c
> +++ b/tools/testing/cxl/test/mock.c
> @@ -234,17 +234,17 @@ void __wrap_cxl_endpoint_parse_cdat(struct cxl_port *port)
>  }
>  EXPORT_SYMBOL_NS_GPL(__wrap_cxl_endpoint_parse_cdat, "CXL");
>  
> -void __wrap_cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
> +void __wrap_devm_cxl_dport_ras_setup(struct cxl_dport *dport)
>  {
>  	int index;
>  	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
>  
>  	if (!ops || !ops->is_mock_port(dport->dport_dev))
> -		cxl_dport_init_ras_reporting(dport, host);
> +		devm_cxl_dport_ras_setup(dport);
>  
>  	put_cxl_mock_ops(index);
>  }
> -EXPORT_SYMBOL_NS_GPL(__wrap_cxl_dport_init_ras_reporting, "CXL");
> +EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_dport_ras_setup, "CXL");
>  
>  struct cxl_dport *__wrap_cxl_add_dport_by_dev(struct cxl_port *port,
>  					      struct device *dport_dev)



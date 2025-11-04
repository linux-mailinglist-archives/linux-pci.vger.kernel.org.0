Return-Path: <linux-pci+bounces-40291-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE606C32DF7
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 21:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B63BE18C593B
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 20:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734202E1EE7;
	Tue,  4 Nov 2025 20:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aJqptKPh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF1170809;
	Tue,  4 Nov 2025 20:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762286614; cv=none; b=h+vKTTm1T1HuYbentSTFjD5t5SzoNu2LqCTTCO1jehFkzb0YSF7zY9cupYNKp+tiSFF4wo5M5YOAhtJhEM0dC4IrlbwPpechKjAzO3uye6bporr8M2g14EaziMLs0M1fggZ1c/MspqPB69ZpdEdzUrY0BtjiTO/FbsKKL3TkT8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762286614; c=relaxed/simple;
	bh=aMSWYuKxKNkP/JpW7CtBXOcTrSKT4jxrRxTO3z5bEHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dc4e60DMakVbJhFaPmit48rlNCoagMzd4HsuILUXZhc6YyZS+Pj9uwRQTgL5AHKuVz0ssu3bi6lBcUGp68DcyihVxpYsinHJZEng2/y4CfFrYWkAqcd3+TUvmBsdHiAT7ZrII2Fg27ABdqmX7JgrusGU/N4Y8zx7k+c6Mk1upH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aJqptKPh; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762286613; x=1793822613;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aMSWYuKxKNkP/JpW7CtBXOcTrSKT4jxrRxTO3z5bEHM=;
  b=aJqptKPhT2yhozpuC4nj8IqzwQJ2PSOVTZRvDyBEeIASUwQL+9LgisIn
   vdcffbtH0eHiNGfj0xqcnZH4LGnaXH0A2HYy3Q+zTDSUigEOvl+NiHkHb
   hr5jjGmJbQ1Ln28zFRQvLj48oWEPeDGveVRn49FSfLruqWVvLOL9JtQDg
   Wgn9dOwJTA8ROkTUMp5xH93QRF9zN6VpG6ThjMJVcygXAAopPKUxVrxYt
   ykQYRPXsudQITSsEH3dDFbMPo24YjQ4PIGePNqYr39YyAKd/JG0jJXI+D
   KzqWDGAd++oT3NnraPKMYAjcD/FPpvw5YzWtz7cMAor7B570BJpVRg4q+
   A==;
X-CSE-ConnectionGUID: EMo9qwI8SD67uYRzsOHspQ==
X-CSE-MsgGUID: foxiGj/kT2ehNzMnYAIxEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="67008357"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="67008357"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 12:03:32 -0800
X-CSE-ConnectionGUID: Xgajb5EUQGuV6pPpUpd2zw==
X-CSE-MsgGUID: wcxReKnvSDGf1BBwuVOITg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="187196755"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [10.125.110.201]) ([10.125.110.201])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 12:03:31 -0800
Message-ID: <afac6fc8-cfd4-4525-9613-0d9c9dd77fff@intel.com>
Date: Tue, 4 Nov 2025 13:03:29 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND v13 14/25] cxl/pci: Map CXL Endpoint Port and CXL Switch
 Port RAS registers
To: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20251104170305.4163840-1-terry.bowman@amd.com>
 <20251104170305.4163840-15-terry.bowman@amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251104170305.4163840-15-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/4/25 10:02 AM, Terry Bowman wrote:
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
> Make a call to cxl_port_setup_regs() in cxl_port_add(). This will probe the
> Upstream Port's CXL capabilities' physical location to be used in mapping
> the RAS registers.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>> 
> ---
> 
> Changes in v12->v13:
> - Change as result of dport delay fix. No longer need switchport and
> endport approach. (Terry)
> 
> Changes in v11->v12:
> - Add check for dport_parent->rch before calling cxl_dport_init_ras_reporting().
> RCH dports are initialized from cxl_dport_init_ras_reporting cxl_mem_probe().
> 
> Changes in v10->v11:
> - Use local pointer for readability in cxl_switch_port_init_ras() (Jonathan Cameron)
> - Rename port to be ep in cxl_endpoint_port_init_ras() (Dave Jiang)
> - Rename dport to be parent_dport in cxl_endpoint_port_init_ras()
>   and cxl_switch_port_init_ras() (Dave Jiang)
> - Port helper changes were in cxl/port.c, now in core/ras.c (Dave Jiang)
> ---
>  drivers/cxl/core/port.c |  4 ++++
>  drivers/cxl/core/ras.c  | 12 ++++++++++++
>  drivers/cxl/cxl.h       |  2 ++
>  drivers/cxl/cxlpci.h    |  4 ++++
>  drivers/cxl/mem.c       |  3 ++-
>  5 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 8128fd2b5b31..48f6a1492544 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1194,6 +1194,8 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  			return ERR_PTR(rc);
>  		}
>  		port->component_reg_phys = CXL_RESOURCE_NONE;
> +		if (!is_cxl_endpoint(port) && dev_is_pci(port->uport_dev))
> +			cxl_uport_init_ras_reporting(port, &port->dev);
>  	}
>  
>  	get_device(dport_dev);
> @@ -1623,6 +1625,8 @@ static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
>  
>  	cxl_switch_parse_cdat(new_dport);
>  
> +	cxl_dport_init_ras_reporting(new_dport, &port->dev);
> +
>  	if (ida_is_empty(&port->decoder_ida)) {
>  		rc = devm_cxl_switch_port_decoders_setup(port);
>  		if (rc)
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 246dfe56617a..19d9ffe885bf 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -162,6 +162,18 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
>  
> +void cxl_uport_init_ras_reporting(struct cxl_port *port,
> +				  struct device *host)
> +{
> +	struct cxl_register_map *map = &port->reg_map;
> +
> +	map->host = host;
> +	if (cxl_map_component_regs(map, &port->uport_regs,
> +				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
> +		dev_dbg(&port->dev, "Failed to map RAS capability\n");
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_uport_init_ras_reporting, "CXL");
> +
>  void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>  {
>  	void __iomem *addr;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 259ed4b676e1..b7654d40dc9e 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -599,6 +599,7 @@ struct cxl_dax_region {
>   * @parent_dport: dport that points to this port in the parent
>   * @decoder_ida: allocator for decoder ids
>   * @reg_map: component and ras register mapping parameters
> + * @uport_regs: mapped component registers
>   * @nr_dports: number of entries in @dports
>   * @hdm_end: track last allocated HDM decoder instance for allocation ordering
>   * @commit_end: cursor to track highest committed decoder for commit ordering
> @@ -620,6 +621,7 @@ struct cxl_port {
>  	struct cxl_dport *parent_dport;
>  	struct ida decoder_ida;
>  	struct cxl_register_map reg_map;
> +	struct cxl_component_regs uport_regs;
>  	int nr_dports;
>  	int hdm_end;
>  	int commit_end;
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 0c8b6ee7b6de..a0a491e7b5b9 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -83,6 +83,8 @@ void cxl_cor_error_detected(struct pci_dev *pdev);
>  pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  				    pci_channel_state_t state);
>  void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
> +void cxl_uport_init_ras_reporting(struct cxl_port *port,
> +				  struct device *host);
>  #else
>  static inline void cxl_cor_error_detected(struct pci_dev *pdev) { }
>  
> @@ -94,6 +96,8 @@ static inline pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  
>  static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
>  						struct device *host) { }
> +static inline void cxl_uport_init_ras_reporting(struct cxl_port *port,
> +						struct device *host) { }
>  #endif
>  
>  #endif /* __CXL_PCI_H__ */
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



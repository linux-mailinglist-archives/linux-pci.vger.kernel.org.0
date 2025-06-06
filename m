Return-Path: <linux-pci+bounces-29121-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94567AD0A1A
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 01:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F37211899FCB
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 23:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527FE23D293;
	Fri,  6 Jun 2025 22:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ceew3i7Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0C91FC0EA;
	Fri,  6 Jun 2025 22:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749250789; cv=none; b=Mu2lasNltFWb5NBD/PD11/x7Nb6AH/HV3Oei6NhPtVaHf6E1/vxccppeL4vbcPzET3NuuOfhxHE2mu1V98JSF+MPy55WRpqNLo3s654bgkLcEjmpCL9PvPukSPPN/3RdO13eYmu+g0I5/Lq04wAvS+VYYw8ddinIF/bcNHedjlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749250789; c=relaxed/simple;
	bh=FTFPRAZ267L3VdOADE7/ub60Qc7Ju5XwkBj3SD87vxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WbSUeLNFmVEJGjQKI7XazT9oeVkvvtuumc3K50M5BKocTq6ua0y1rVpC85Ank+0sBb4LRD0toxq5yS4AI7lgCAmjAIPIiV13eej/fzUg8+X5fh8/OdRIACl/8wLGSxCp7dlrb9utnk+e8rz38vDd0+LXzUO7PNCuAANkl6UMs7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ceew3i7Z; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749250787; x=1780786787;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=FTFPRAZ267L3VdOADE7/ub60Qc7Ju5XwkBj3SD87vxM=;
  b=ceew3i7ZGJWNyyyB0o3tiehLwIyYqJh/B+6LxBIlOe9O0JVRl40DEdTv
   2ZJBI+iTAV9Z6x7S8A278CEZVtFnWalEwYlXL63T5QhhnHgf2/QkvrXq9
   cV4s8xkTG6pqOgyGViTGd5QFg2Hiz4lBnZgKL2l2GPqP2ucAhhca9Q4PY
   SJ4Ke/NWFkCsRktMDJ8VJYSTphMyjAfY4+z82kcqD7FT8EDYyVunVg42A
   GzY2af0Tz9XB6VYyRjASSp2qLz5gOmq/o9McQfLGNThkoCa9h4mgyDM5A
   H93gZylCctjZfkFNgrQduf/VU5Q7vfNcq0hQpHh1Mdt5hq1wlIVfw8oUi
   Q==;
X-CSE-ConnectionGUID: NYtEfoO2T46oGQMpcwnbZw==
X-CSE-MsgGUID: l49QNMmNRsmToSk0cYSM3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11456"; a="54039810"
X-IronPort-AV: E=Sophos;i="6.16,216,1744095600"; 
   d="scan'208";a="54039810"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 15:59:46 -0700
X-CSE-ConnectionGUID: juQn6lj6TiGeCPiG7j3dig==
X-CSE-MsgGUID: YGeAIvhdRni60Wi4gzmBBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,216,1744095600"; 
   d="scan'208";a="150959926"
Received: from spandruv-desk1.amr.corp.intel.com (HELO [10.125.111.33]) ([10.125.111.33])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 15:59:44 -0700
Message-ID: <4ed71897-2b04-438c-8b08-006c12a0037f@intel.com>
Date: Fri, 6 Jun 2025 15:59:43 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 16/16] CXL/PCI: Disable CXL protocol error interrupts
 during CXL Port cleanup
To: Terry Bowman <terry.bowman@amd.com>, PradeepVineshReddy.Kodamati@amd.com,
 dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 bhelgaas@google.com, bp@alien8.de, ming.li@zohomail.com,
 shiju.jose@huawei.com, dan.carpenter@linaro.org,
 Smita.KoralahalliChannabasappa@amd.com, kobayashi.da-06@fujitsu.com,
 yanfei.xu@intel.com, rrichter@amd.com, peterz@infradead.org, colyli@suse.de,
 uaisheng.ye@intel.com, fabio.m.de.francesco@linux.intel.com,
 ilpo.jarvinen@linux.intel.com, yazen.ghannam@amd.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250603172239.159260-1-terry.bowman@amd.com>
 <20250603172239.159260-17-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250603172239.159260-17-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/3/25 10:22 AM, Terry Bowman wrote:
> During CXL device cleanup the CXL PCIe Port device interrupts remain
> enabled. This potentially allows unnecessary interrupt processing on
> behalf of the CXL errors while the device is destroyed.
> 
> Disable CXL protocol errors by setting the CXL devices' AER mask register.
> 
> Introduce pci_aer_mask_internal_errors() similar to pci_aer_unmask_internal_errors().
> 
> Introduce cxl_mask_prot_interrupts() to call pci_aer_mask_internal_errors().
> Add calls to cxl_mask_prot_interrupts() within CXL Port teardown for CXL
> Root Ports, CXL Downstream Switch Ports, CXL Upstream Switch Ports, and CXL
> Endpoints. Follow the same "bottom-up" approach used during CXL Port
> teardown.
> 
> Implement cxl_mask_prot_interrupts() in a header file to avoid introducing
> Kconfig ifdefs in cxl/core/port.c.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/port.c |  6 ++++++
>  drivers/cxl/cxl.h       |  8 ++++++++
>  drivers/pci/pcie/aer.c  | 21 +++++++++++++++++++++
>  include/linux/aer.h     |  1 +
>  4 files changed, 36 insertions(+)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 07b9bb0f601f..6aaaad002a7f 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1433,6 +1433,9 @@ EXPORT_SYMBOL_NS_GPL(cxl_endpoint_autoremove, "CXL");
>   */
>  static void delete_switch_port(struct cxl_port *port)
>  {
> +	cxl_mask_prot_interrupts(port->uport_dev);
> +	cxl_mask_prot_interrupts(port->parent_dport->dport_dev);
> +
>  	devm_release_action(port->dev.parent, cxl_unlink_parent_dport, port);
>  	devm_release_action(port->dev.parent, cxl_unlink_uport, port);
>  	devm_release_action(port->dev.parent, unregister_port, port);
> @@ -1446,6 +1449,7 @@ static void reap_dports(struct cxl_port *port)
>  	device_lock_assert(&port->dev);
>  
>  	xa_for_each(&port->dports, index, dport) {
> +		cxl_mask_prot_interrupts(dport->dport_dev);
>  		devm_release_action(&port->dev, cxl_dport_unlink, dport);
>  		devm_release_action(&port->dev, cxl_dport_remove, dport);
>  		devm_kfree(&port->dev, dport);
> @@ -1476,6 +1480,8 @@ static void cxl_detach_ep(void *data)
>  {
>  	struct cxl_memdev *cxlmd = data;
>  
> +	cxl_mask_prot_interrupts(cxlmd->cxlds->dev);
> +
>  	for (int i = cxlmd->depth - 1; i >= 1; i--) {
>  		struct cxl_port *port, *parent_port;
>  		struct detach_ctx ctx = {
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 2c1c00466a25..2753db3d473e 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -12,6 +12,7 @@
>  #include <linux/node.h>
>  #include <linux/io.h>
>  #include <linux/pci.h>
> +#include <linux/aer.h>
>  
>  extern const struct nvdimm_security_ops *cxl_security_ops;
>  
> @@ -771,9 +772,16 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
>  #ifdef CONFIG_PCIEAER_CXL
>  void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport);
>  void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
> +static inline void cxl_mask_prot_interrupts(struct device *dev)
> +{
> +	struct pci_dev *pdev __free(pci_dev_put) = pci_dev_get(to_pci_dev(dev));
> +
> +	pci_aer_mask_internal_errors(pdev);
> +}
>  #else
>  static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
>  						struct device *host) { }
> +static inline void cxl_mask_prot_interrupts(struct device *dev) { }
>  #endif
>  
>  struct cxl_decoder *to_cxl_decoder(struct device *dev);
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 2d202ad1453a..69230cf87d79 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -979,6 +979,27 @@ void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL_NS_GPL(pci_aer_unmask_internal_errors, "CXL");
>  
> +/**
> + * pci_aer_mask_internal_errors - mask internal errors
> + * @dev: pointer to the pcie_dev data structure
> + *
> + * Masks internal errors in the Uncorrectable and Correctable Error
> + * Mask registers.
> + *
> + * Note: AER must be enabled and supported by the device which must be
> + * checked in advance, e.g. with pcie_aer_is_native().
> + */
> +void pci_aer_mask_internal_errors(struct pci_dev *dev)
> +{
> +	int aer = dev->aer_cap;
> +
> +	pci_clear_and_set_config_dword(dev, aer + PCI_ERR_UNCOR_MASK,
> +				       0, PCI_ERR_UNC_INTN);
> +	pci_clear_and_set_config_dword(dev, aer + PCI_ERR_COR_MASK,
> +				       0, PCI_ERR_COR_INTERNAL);
> +}
> +EXPORT_SYMBOL_NS_GPL(pci_aer_mask_internal_errors, "CXL");
> +
>  static bool is_cxl_mem_dev(struct pci_dev *dev)
>  {
>  	/*
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 74600e75705f..41167ad3797a 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -108,5 +108,6 @@ int cper_severity_to_aer(int cper_severity);
>  void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
>  		       int severity, struct aer_capability_regs *aer_regs);
>  void pci_aer_unmask_internal_errors(struct pci_dev *dev);
> +void pci_aer_mask_internal_errors(struct pci_dev *dev);
>  #endif //_AER_H_
>  



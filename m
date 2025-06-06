Return-Path: <linux-pci+bounces-29071-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5E7ACFA82
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 02:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FCAE179E4E
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 00:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8D83B2A0;
	Fri,  6 Jun 2025 00:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yx7m+AUb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AF0219ED;
	Fri,  6 Jun 2025 00:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749171148; cv=none; b=LSFz2KHFAENVPGAeTevgU0GKsXSvuzHZhuL/gyRIK3BtiSAGtrIkR87fay8Ls27BZ2BlwdNXbjsvw1egRauyDmHxNFZNAYCm0YmqxqZEWAaQO+vUeDFJWvvZfVxhYVoxoM69McSZJxTlag3HpYlQcnCTwaJ3ViAH6zyXiWlNOZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749171148; c=relaxed/simple;
	bh=3DRvx+lFIAOZUmOucYVxB4j4OKPo1Gg9f4hnHA6H340=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GE+xqq4x3TI3d4aAZar5NeFco8sKizdlOAXk3kv2MEgbZkO4oMBgSBGFE0RTSuUQSyF//aIO4jpdDFnC91GBqIondf91x+Oi/TEswJF5HWLViiLsmhcrB8mKhp0O64cJ5dR1DLF8qLCEC/EtBT4TDh9TbNRS7sXiqSSTgYOqKV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yx7m+AUb; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749171146; x=1780707146;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=3DRvx+lFIAOZUmOucYVxB4j4OKPo1Gg9f4hnHA6H340=;
  b=Yx7m+AUb7Z5P5RCPswvbZBxNuE1gngFwmACLr4bB8BjpwIJ2b2TTuFqy
   p9PMUJqO9pRbK/hO2MSIjiDsN0144yCFOn41/yC+udmiK7hWaO0eaQUo4
   Sv2pfvx1VAceEK2paNsfRrhacpT1zmId9rg35H2qBVbEH32cq+qiA44sy
   2uA7dxXGGT0maQIy+GDgOmxunHRwEOssEtRJgVs8/gnYGOUDTD4xDgCGV
   jfYxOtJMyoosKecp0hCbKISF54L9fqT3+cA+3NaCZWtiNfixsGKbLqIxK
   hu9H2ppzPyX6n3JiwgybCYYLSPBAL7ZSabk3zB9rE8LLO2DGNnBbxs/ok
   w==;
X-CSE-ConnectionGUID: JQZI+8+xT0aVDQxBAj/HMw==
X-CSE-MsgGUID: V043/yQDTeKCWkYcY4LryA==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="51174765"
X-IronPort-AV: E=Sophos;i="6.16,213,1744095600"; 
   d="scan'208";a="51174765"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 17:52:25 -0700
X-CSE-ConnectionGUID: 8D7J7V8NQMyRfqOFCZYrIg==
X-CSE-MsgGUID: UStmp1LVSa+xLhpZ9WOv5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,213,1744095600"; 
   d="scan'208";a="146636598"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 17:52:25 -0700
Received: from [10.124.222.132] (unknown [10.124.222.132])
	by linux.intel.com (Postfix) with ESMTP id 7934D20B5736;
	Thu,  5 Jun 2025 17:52:23 -0700 (PDT)
Message-ID: <a8d687e4-03d3-4d08-9149-757349704207@linux.intel.com>
Date: Thu, 5 Jun 2025 17:52:23 -0700
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
 dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, bp@alien8.de,
 ming.li@zohomail.com, shiju.jose@huawei.com, dan.carpenter@linaro.org,
 Smita.KoralahalliChannabasappa@amd.com, kobayashi.da-06@fujitsu.com,
 yanfei.xu@intel.com, rrichter@amd.com, peterz@infradead.org, colyli@suse.de,
 uaisheng.ye@intel.com, fabio.m.de.francesco@linux.intel.com,
 ilpo.jarvinen@linux.intel.com, yazen.ghannam@amd.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250603172239.159260-1-terry.bowman@amd.com>
 <20250603172239.159260-17-terry.bowman@amd.com>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250603172239.159260-17-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>   drivers/cxl/core/port.c |  6 ++++++
>   drivers/cxl/cxl.h       |  8 ++++++++
>   drivers/pci/pcie/aer.c  | 21 +++++++++++++++++++++
>   include/linux/aer.h     |  1 +
>   4 files changed, 36 insertions(+)
>
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 07b9bb0f601f..6aaaad002a7f 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1433,6 +1433,9 @@ EXPORT_SYMBOL_NS_GPL(cxl_endpoint_autoremove, "CXL");
>    */
>   static void delete_switch_port(struct cxl_port *port)
>   {
> +	cxl_mask_prot_interrupts(port->uport_dev);
> +	cxl_mask_prot_interrupts(port->parent_dport->dport_dev);
> +
>   	devm_release_action(port->dev.parent, cxl_unlink_parent_dport, port);
>   	devm_release_action(port->dev.parent, cxl_unlink_uport, port);
>   	devm_release_action(port->dev.parent, unregister_port, port);
> @@ -1446,6 +1449,7 @@ static void reap_dports(struct cxl_port *port)
>   	device_lock_assert(&port->dev);
>   
>   	xa_for_each(&port->dports, index, dport) {
> +		cxl_mask_prot_interrupts(dport->dport_dev);
>   		devm_release_action(&port->dev, cxl_dport_unlink, dport);
>   		devm_release_action(&port->dev, cxl_dport_remove, dport);
>   		devm_kfree(&port->dev, dport);
> @@ -1476,6 +1480,8 @@ static void cxl_detach_ep(void *data)
>   {
>   	struct cxl_memdev *cxlmd = data;
>   
> +	cxl_mask_prot_interrupts(cxlmd->cxlds->dev);
> +
>   	for (int i = cxlmd->depth - 1; i >= 1; i--) {
>   		struct cxl_port *port, *parent_port;
>   		struct detach_ctx ctx = {
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 2c1c00466a25..2753db3d473e 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -12,6 +12,7 @@
>   #include <linux/node.h>
>   #include <linux/io.h>
>   #include <linux/pci.h>
> +#include <linux/aer.h>
>   
>   extern const struct nvdimm_security_ops *cxl_security_ops;
>   
> @@ -771,9 +772,16 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
>   #ifdef CONFIG_PCIEAER_CXL
>   void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport);
>   void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
> +static inline void cxl_mask_prot_interrupts(struct device *dev)
> +{
> +	struct pci_dev *pdev __free(pci_dev_put) = pci_dev_get(to_pci_dev(dev));
> +
> +	pci_aer_mask_internal_errors(pdev);
> +}
>   #else
>   static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
>   						struct device *host) { }
> +static inline void cxl_mask_prot_interrupts(struct device *dev) { }
>   #endif
>   
>   struct cxl_decoder *to_cxl_decoder(struct device *dev);
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 2d202ad1453a..69230cf87d79 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -979,6 +979,27 @@ void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>   }
>   EXPORT_SYMBOL_NS_GPL(pci_aer_unmask_internal_errors, "CXL");
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
>   static bool is_cxl_mem_dev(struct pci_dev *dev)
>   {
>   	/*
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 74600e75705f..41167ad3797a 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -108,5 +108,6 @@ int cper_severity_to_aer(int cper_severity);
>   void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
>   		       int severity, struct aer_capability_regs *aer_regs);
>   void pci_aer_unmask_internal_errors(struct pci_dev *dev);
> +void pci_aer_mask_internal_errors(struct pci_dev *dev);
>   #endif //_AER_H_
>   

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer



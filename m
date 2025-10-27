Return-Path: <linux-pci+bounces-39466-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30747C11531
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 21:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 974F246147D
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 20:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54023203A7;
	Mon, 27 Oct 2025 20:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U3IR4U+C"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365903168E0
	for <linux-pci@vger.kernel.org>; Mon, 27 Oct 2025 20:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761595693; cv=none; b=tmbvN2Rul+b7AcpgNW9PfmJ0+9PTp8D7/tKqTWX2TC4ruimdnQddrk8elVslYnaCmA1TxM0xjALj2oOzOp416DwDfLNdz3R+QI8e9dHNWhc9N6DUlqhL2Y58I83laEicgssboSM8MmK38gX3JPkKBb+dKmQ4X9OI6MVXczxYXRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761595693; c=relaxed/simple;
	bh=MdJJ1ynfyQu1hYBwVz0W0Fw7LpTpbxDAQOy2+gKUAzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qh0tjlAc9vMxDW5VluYmKN4s2ONsYCEr5+zfiY4MDRMXqAtoXVv+mVPiW3sSlsG4veoyP6py2QOHJhZVMHOSpXcisi0HCgyzMStYqrLvEmC2adFQriOXclTjjJUFXwcJD7E+cowiUO9Jui3/Xxx3ZcY48Oato8azgrPUEUq1lL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U3IR4U+C; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761595691; x=1793131691;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MdJJ1ynfyQu1hYBwVz0W0Fw7LpTpbxDAQOy2+gKUAzw=;
  b=U3IR4U+CPB3MZnsjd5VkUW2BdA4QWF1AcvipAbZlqwyaa8N131nUfYS7
   b5CFnn0/+x8AuJbI5CwbWtPcbB+mSWv4p3MxD4TxBfrxOoCojMVm54Cuq
   uDSHJrp8oTzegV5Iv/32E3ciNtuPieu4NH/RFsYu8S8qWP1h13olZ1qwI
   R9YgF+mZkO/j0GtnqlXHemp2YJbAq3vSyquTCyUXIwLGf2U9WbGRxsXpr
   zxRGFXrvHeNGoCW+DhLVyKPqA3/DKMMo4RarjrsIGX6YpJ6iPxxnBrIk/
   UYaqZhEWrhwxcBNwG6vz/+2wxZLBHArxCkbd28Svu733hGs9op4lVfsNC
   g==;
X-CSE-ConnectionGUID: PDLimmKsRZq9MPpg9QJhLg==
X-CSE-MsgGUID: yxbX+6vdRya9R78bw2aU5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62718414"
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="62718414"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 13:08:10 -0700
X-CSE-ConnectionGUID: yi6vRZGTRS6mR2TRCQgDKg==
X-CSE-MsgGUID: kB7cUDS0QAOoRmfPy+4Zjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="222346274"
Received: from kcaccard-desk.amr.corp.intel.com (HELO [10.125.109.111]) ([10.125.109.111])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 13:08:09 -0700
Message-ID: <9c6fc6c7-14f0-4551-921d-1a385f96cbd6@intel.com>
Date: Mon, 27 Oct 2025 13:08:07 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] PCI: Enable host bridge emulation for
 PCI_DOMAINS_GENERIC platforms
To: Dan Williams <dan.j.williams@intel.com>, bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, jonathan.derrick@linux.dev,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Michael Kelley <mhklinux@outlook.com>
References: <20251024224622.1470555-1-dan.j.williams@intel.com>
 <20251024224622.1470555-2-dan.j.williams@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251024224622.1470555-2-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/24/25 3:46 PM, Dan Williams wrote:
> The ability to emulate a host bridge is useful not only for hardware PCI
> controllers like CONFIG_VMD, or virtual PCI controllers like
> CONFIG_PCI_HYPERV, but also for test and development scenarios like
> CONFIG_SAMPLES_DEVSEC [1].
> 
> One stumbling block for defining CONFIG_SAMPLES_DEVSEC, a sample
> implementation of a platform TSM for PCI Device Security, is the need to
> accommodate PCI_DOMAINS_GENERIC architectures alongside x86 [2].
> 
> In support of supplementing the existing CONFIG_PCI_BRIDGE_EMUL
> infrastructure for host bridges:
> 
> * Introduce pci_bus_find_emul_domain_nr() as a common way to find a free
>   PCI domain number whether that is to reuse the existing dynamic
>   allocation code in the !ACPI case, or to assign an unused domain above
>   the last ACPI segment.
> 
> * Convert pci-hyperv to the new allocator so that the PCI core can
>   unconditionally assume that bridge->domain_nr != PCI_DOMAIN_NR_NOT_SET
>   is the dynamically allocated case.
> 
> A follow on patch can also convert vmd to the new scheme. Currently vmd
> is limited to CONFIG_PCI_DOMAINS_GENERIC=n (x86) so, unlike pci-hyperv,
> it does not immediately conflict with this new
> pci_bus_find_emul_domain_nr() mechanism.
> 
> Link: http://lore.kernel.org/174107249038.1288555.12362100502109498455.stgit@dwillia2-xfh.jf.intel.com [1]
> Reported-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Closes: http://lore.kernel.org/20250311144601.145736-3-suzuki.poulose@arm.com
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Dexuan Cui <decui@microsoft.com>
> Tested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> [michael: maintain compatibility with userspace that expects 16-bit ids]
> Cc: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>> ---
>  include/linux/pci.h                 |  7 ++++
>  drivers/pci/controller/pci-hyperv.c | 62 +++++------------------------
>  drivers/pci/pci.c                   | 24 ++++++++++-
>  drivers/pci/probe.c                 |  8 +++-
>  4 files changed, 46 insertions(+), 55 deletions(-)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index d1fdf81fbe1e..1ef1535802b0 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1956,10 +1956,17 @@ DEFINE_GUARD(pci_dev, struct pci_dev *, pci_dev_lock(_T), pci_dev_unlock(_T))
>   */
>  #ifdef CONFIG_PCI_DOMAINS
>  extern int pci_domains_supported;
> +int pci_bus_find_emul_domain_nr(u32 hint, u32 min, u32 max);
> +void pci_bus_release_emul_domain_nr(int domain_nr);
>  #else
>  enum { pci_domains_supported = 0 };
>  static inline int pci_domain_nr(struct pci_bus *bus) { return 0; }
>  static inline int pci_proc_domain(struct pci_bus *bus) { return 0; }
> +static inline int pci_bus_find_emul_domain_nr(u32 hint, u32 min, u32 max)
> +{
> +	return 0;
> +}
> +static inline void pci_bus_release_emul_domain_nr(int domain_nr) { }
>  #endif /* CONFIG_PCI_DOMAINS */
>  
>  /*
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 146b43981b27..64f68efaf547 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -3696,48 +3696,6 @@ static int hv_send_resources_released(struct hv_device *hdev)
>  	return 0;
>  }
>  
> -#define HVPCI_DOM_MAP_SIZE (64 * 1024)
> -static DECLARE_BITMAP(hvpci_dom_map, HVPCI_DOM_MAP_SIZE);
> -
> -/*
> - * PCI domain number 0 is used by emulated devices on Gen1 VMs, so define 0
> - * as invalid for passthrough PCI devices of this driver.
> - */
> -#define HVPCI_DOM_INVALID 0
> -
> -/**
> - * hv_get_dom_num() - Get a valid PCI domain number
> - * Check if the PCI domain number is in use, and return another number if
> - * it is in use.
> - *
> - * @dom: Requested domain number
> - *
> - * return: domain number on success, HVPCI_DOM_INVALID on failure
> - */
> -static u16 hv_get_dom_num(u16 dom)
> -{
> -	unsigned int i;
> -
> -	if (test_and_set_bit(dom, hvpci_dom_map) == 0)
> -		return dom;
> -
> -	for_each_clear_bit(i, hvpci_dom_map, HVPCI_DOM_MAP_SIZE) {
> -		if (test_and_set_bit(i, hvpci_dom_map) == 0)
> -			return i;
> -	}
> -
> -	return HVPCI_DOM_INVALID;
> -}
> -
> -/**
> - * hv_put_dom_num() - Mark the PCI domain number as free
> - * @dom: Domain number to be freed
> - */
> -static void hv_put_dom_num(u16 dom)
> -{
> -	clear_bit(dom, hvpci_dom_map);
> -}
> -
>  /**
>   * hv_pci_probe() - New VMBus channel probe, for a root PCI bus
>   * @hdev:	VMBus's tracking struct for this root PCI bus
> @@ -3750,9 +3708,9 @@ static int hv_pci_probe(struct hv_device *hdev,
>  {
>  	struct pci_host_bridge *bridge;
>  	struct hv_pcibus_device *hbus;
> -	u16 dom_req, dom;
> +	int ret, dom;
> +	u16 dom_req;
>  	char *name;
> -	int ret;
>  
>  	bridge = devm_pci_alloc_host_bridge(&hdev->device, 0);
>  	if (!bridge)
> @@ -3779,11 +3737,14 @@ static int hv_pci_probe(struct hv_device *hdev,
>  	 * PCI bus (which is actually emulated by the hypervisor) is domain 0.
>  	 * (2) There will be no overlap between domains (after fixing possible
>  	 * collisions) in the same VM.
> +	 *
> +	 * Because Gen1 VMs use domain 0, don't allow picking domain 0 here,
> +	 * even if bytes 4 and 5 of the instance GUID are both zero. For wider
> +	 * userspace compatibility, limit the domain id to a 16-bit value.
>  	 */
>  	dom_req = hdev->dev_instance.b[5] << 8 | hdev->dev_instance.b[4];
> -	dom = hv_get_dom_num(dom_req);
> -
> -	if (dom == HVPCI_DOM_INVALID) {
> +	dom = pci_bus_find_emul_domain_nr(dom_req, 1, U16_MAX);
> +	if (dom < 0) {
>  		dev_err(&hdev->device,
>  			"Unable to use dom# 0x%x or other numbers", dom_req);
>  		ret = -EINVAL;
> @@ -3917,7 +3878,7 @@ static int hv_pci_probe(struct hv_device *hdev,
>  destroy_wq:
>  	destroy_workqueue(hbus->wq);
>  free_dom:
> -	hv_put_dom_num(hbus->bridge->domain_nr);
> +	pci_bus_release_emul_domain_nr(hbus->bridge->domain_nr);
>  free_bus:
>  	kfree(hbus);
>  	return ret;
> @@ -4042,8 +4003,6 @@ static void hv_pci_remove(struct hv_device *hdev)
>  	irq_domain_remove(hbus->irq_domain);
>  	irq_domain_free_fwnode(hbus->fwnode);
>  
> -	hv_put_dom_num(hbus->bridge->domain_nr);
> -
>  	kfree(hbus);
>  }
>  
> @@ -4217,9 +4176,6 @@ static int __init init_hv_pci_drv(void)
>  	if (ret)
>  		return ret;
>  
> -	/* Set the invalid domain number's bit, so it will not be used */
> -	set_bit(HVPCI_DOM_INVALID, hvpci_dom_map);
> -
>  	/* Initialize PCI block r/w interface */
>  	hvpci_block_ops.read_block = hv_read_config_block;
>  	hvpci_block_ops.write_block = hv_write_config_block;
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b14dd064006c..64aed8705e91 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6656,9 +6656,31 @@ static void pci_no_domains(void)
>  #endif
>  }
>  
> +#ifdef CONFIG_PCI_DOMAINS
> +static DEFINE_IDA(pci_domain_nr_dynamic_ida);
> +
> +/**
> + * pci_bus_find_emul_domain_nr() - allocate a PCI domain number per constraints
> + * @hint: desired domain, 0 if any id in the range of @min to @max is acceptable
> + * @min: minimum allowable domain
> + * @max: maximum allowable domain, no ids higher than INT_MAX will be returned
> + */
> +int pci_bus_find_emul_domain_nr(u32 hint, u32 min, u32 max)
> +{
> +	return ida_alloc_range(&pci_domain_nr_dynamic_ida, max(hint, min), max,
> +			       GFP_KERNEL);
> +}
> +EXPORT_SYMBOL_GPL(pci_bus_find_emul_domain_nr);
> +
> +void pci_bus_release_emul_domain_nr(int domain_nr)
> +{
> +	ida_free(&pci_domain_nr_dynamic_ida, domain_nr);
> +}
> +EXPORT_SYMBOL_GPL(pci_bus_release_emul_domain_nr);
> +#endif
> +
>  #ifdef CONFIG_PCI_DOMAINS_GENERIC
>  static DEFINE_IDA(pci_domain_nr_static_ida);
> -static DEFINE_IDA(pci_domain_nr_dynamic_ida);
>  
>  static void of_pci_reserve_static_domain_nr(void)
>  {
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 0ce98e18b5a8..5e101ced00a5 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -650,6 +650,11 @@ static void pci_release_host_bridge_dev(struct device *dev)
>  
>  	pci_free_resource_list(&bridge->windows);
>  	pci_free_resource_list(&bridge->dma_ranges);
> +
> +	/* Host bridges only have domain_nr set in the emulation case */
> +	if (bridge->domain_nr != PCI_DOMAIN_NR_NOT_SET)
> +		pci_bus_release_emul_domain_nr(bridge->domain_nr);
> +
>  	kfree(bridge);
>  }
>  
> @@ -1130,7 +1135,8 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>  	device_del(&bridge->dev);
>  free:
>  #ifdef CONFIG_PCI_DOMAINS_GENERIC
> -	pci_bus_release_domain_nr(parent, bus->domain_nr);
> +	if (bridge->domain_nr == PCI_DOMAIN_NR_NOT_SET)
> +		pci_bus_release_domain_nr(parent, bus->domain_nr);
>  #endif
>  	if (bus_registered)
>  		put_device(&bus->dev);



Return-Path: <linux-pci+bounces-21757-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBBDA3A687
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 19:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 206FA1884CDD
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 18:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00E31E5207;
	Tue, 18 Feb 2025 18:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jImQJ9W4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91731E51EB;
	Tue, 18 Feb 2025 18:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739905149; cv=none; b=EZVbZwTL6aYMnplh+jTJYIJIJk76XWj1ISq8dzFQuUwjdboACVNXOtFLa8Vh9tUV743tVjJ5AuBMBn8IzMELH59nBWg+lhwSHzxjTbeRhdKokmtB+myjIpFju16UKEZGzb0ZNfdGCWB4D8y3H7BB9o/2aBNH/MEF5MaDYbp9fjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739905149; c=relaxed/simple;
	bh=HOvz2djX1ufWum66Lhttdb/9fZlgLVKNn2dwuXw8S5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jwJhbMDxIsTM7biatIfnmZydZfg1x0LygfOYnme6tjV1DdAH0G2bxmSj/zw0MB430AwYL4pILSCcYFmXENDUwl31YLdFPaRmgzM8makGi8LYDWA08fiodu7YKK8s+znPUBDUFwx7C4+paqhY63vMisuR+7QiMWy2k4tmHV+avTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jImQJ9W4; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739905148; x=1771441148;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HOvz2djX1ufWum66Lhttdb/9fZlgLVKNn2dwuXw8S5Y=;
  b=jImQJ9W4K+mpejdVWw653WTEkhs4C7Nsz08tBAhiUEZ0drTphT6FW4U7
   ARFyHU/iiZMoJtItjKLYoHTJwBeunv5TK5Dm1aKFjecKUx3qFSKAosqBp
   1InKTEK4M2Mz0WKYwcLsGFI9ujJ9WFvSRghjRvCgJdYAHfM4spWrImQf2
   dUizS1lLUkLhSjwDdlXhQIqvPHPn6LbKXnHBCXdLNnqJLQEh1Q8uu4LIF
   Hn+NsEfUx2NdjKQi6WWXkEnSYGgcYNWJAAgKK8Sp00MvUUKYZek39jvpH
   PaNdWY5+/DqGP7sDN0+yztx4ASDpHIy2jYS5paqdlHrD0djOcOkzwQDOv
   A==;
X-CSE-ConnectionGUID: COZAu/jGQd+LyjPm8xkEwQ==
X-CSE-MsgGUID: hVcah1lAR0a0fyjzNaXa9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="43449966"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="43449966"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 10:59:06 -0800
X-CSE-ConnectionGUID: Nwj/VTR5S6qUNX6wYzFm3g==
X-CSE-MsgGUID: 2U+fQULHRPCnIPl2IADiUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119694198"
Received: from philliph-desk.amr.corp.intel.com (HELO [10.124.220.170]) ([10.124.220.170])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 10:59:05 -0800
Message-ID: <99d1cd4d-2526-4ce0-aabd-508fa03cb100@linux.intel.com>
Date: Tue, 18 Feb 2025 10:58:19 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] PCI/portdrv: Add necessary wait for disabling
 hotplug events
To: Feng Tang <feng.tang@linux.alibaba.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
 Liguang Zhang <zhangliguang@linux.alibaba.com>,
 Guanghui Feng <guanghuifeng@linux.alibaba.com>, rafael@kernel.org
Cc: Markus Elfring <Markus.Elfring@web.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250218034859.40397-1-feng.tang@linux.alibaba.com>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250218034859.40397-1-feng.tang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/17/25 7:48 PM, Feng Tang wrote:
> There was problem reported by firmware developers that they received
> 2 pcie link control commands in very short intervals on an ARM server,
> which doesn't comply with pcie spec, and broke their state machine and
> work flow. According to PCIe 6.1 spec, section 6.7.3.2, software needs
> to wait at least 1 second for the command-complete event, before
> resending the cmd or sending a new cmd.
>
> And the first link control command firmware received is from
> get_port_device_capability(), which sends cmd to disable pcie hotplug
> interrupts without waiting for its completion.

Were you able to narrow down the source of the second command? The
reason I am asking is, the commit you are trying to fix seems to have
existed for 10+ years and no one had faced any issues with it. So
I am wondering whether this needs to fixed at this place or before
executing the second command.

>
> Fix it by adding the necessary wait to comply with PCIe spec, referring
> pcie_poll_cmd().
>
> Also make the interrupt disabling not dependent on whether pciehp
> service driver will be loaded as suggested by Lukas.

May be this needs a new patch?

>
> Fixes: 2bd50dd800b5 ("PCI: PCIe: Disable PCIe port services during port initialization")
> Originally-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
> Suggested-by: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
> ---

Code wise it looks fine to me.

> Changlog:
>
>    since v1:
>      * Add the Originally-by for Liguang. The issue was found on a 5.10 kernel,
>        then 6.6. I was initially given a 5.10 kernel tar bar without git info to
>        debug the issue, and made the patch. Thanks to Guanghui who recently pointed
>        me to tree https://gitee.com/anolis/cloud-kernel which show the wait logic
>        in 5.10 was originally from Liguang, and never hit mainline.
>      * Make the irq disabling not dependent on wthether pciehp service driver
>        will be loaded (Lukas Wunner)
>      * Use read_poll_timeout() API to simply the waiting logic (Sathyanarayanan
>        Kuppuswamy)
>      * Add logic to skip irq disabling if it is already disabled.
>
>   drivers/pci/pci.h          |  2 ++
>   drivers/pci/pcie/portdrv.c | 44 +++++++++++++++++++++++++++++++++-----
>   2 files changed, 41 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 01e51db8d285..c1e234d1b81d 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -759,12 +759,14 @@ static inline void pcie_ecrc_get_policy(char *str) { }
>   #ifdef CONFIG_PCIEPORTBUS
>   void pcie_reset_lbms_count(struct pci_dev *port);
>   int pcie_lbms_count(struct pci_dev *port, unsigned long *val);
> +void pcie_disable_hp_interrupts_early(struct pci_dev *dev);
>   #else
>   static inline void pcie_reset_lbms_count(struct pci_dev *port) {}
>   static inline int pcie_lbms_count(struct pci_dev *port, unsigned long *val)
>   {
>   	return -EOPNOTSUPP;
>   }
> +static inline void pcie_disable_hp_interrupts_early(struct pci_dev *dev) {}
>   #endif
>   
>   struct pci_dev_reset_methods {
> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index 02e73099bad0..2470333bba2f 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -18,6 +18,7 @@
>   #include <linux/string.h>
>   #include <linux/slab.h>
>   #include <linux/aer.h>
> +#include <linux/iopoll.h>
>   
>   #include "../pci.h"
>   #include "portdrv.h"
> @@ -205,6 +206,40 @@ static int pcie_init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
>   	return 0;
>   }
>   
> +static int pcie_wait_sltctl_cmd_raw(struct pci_dev *dev)
> +{
> +	u16 slot_status = 0;
> +	int ret, ret1, timeout_us;
> +
> +	/* 1 second, according to PCIe spec 6.1, section 6.7.3.2 */
> +	timeout_us = 1000000;
> +	ret = read_poll_timeout(pcie_capability_read_word, ret1,
> +				(slot_status & PCI_EXP_SLTSTA_CC), 10000,
> +				timeout_us, true, dev, PCI_EXP_SLTSTA,
> +				&slot_status);
> +	if (!ret)
> +		pcie_capability_write_word(dev, PCI_EXP_SLTSTA,
> +						PCI_EXP_SLTSTA_CC);
> +
> +	return  ret;
> +}
> +
> +void pcie_disable_hp_interrupts_early(struct pci_dev *dev)
> +{
> +	u16 slot_ctrl = 0;
> +
> +	pcie_capability_read_word(dev, PCI_EXP_SLTCTL, &slot_ctrl);
> +	/* Bail out early if it is already disabled */
> +	if (!(slot_ctrl & (PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE)))
> +		return;
> +
> +	pcie_capability_clear_word(dev, PCI_EXP_SLTCTL,
> +		  PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE);
> +
> +	if (pcie_wait_sltctl_cmd_raw(dev))
> +		pci_info(dev, "Timeout on disabling PCIE hot-plug interrupt\n");
> +}
> +
>   /**
>    * get_port_device_capability - discover capabilities of a PCI Express port
>    * @dev: PCI Express port to examine
> @@ -222,16 +257,15 @@ static int get_port_device_capability(struct pci_dev *dev)
>   
>   	if (dev->is_hotplug_bridge &&
>   	    (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> -	     pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM) &&
> -	    (pcie_ports_native || host->native_pcie_hotplug)) {
> -		services |= PCIE_PORT_SERVICE_HP;
> +	     pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM)) {
> +		if (pcie_ports_native || host->native_pcie_hotplug)
> +			services |= PCIE_PORT_SERVICE_HP;
>   
>   		/*
>   		 * Disable hot-plug interrupts in case they have been enabled
>   		 * by the BIOS and the hot-plug service driver is not loaded.
>   		 */
> -		pcie_capability_clear_word(dev, PCI_EXP_SLTCTL,
> -			  PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE);
> +		pcie_disable_hp_interrupts_early(dev);
>   	}
>   
>   #ifdef CONFIG_PCIEAER

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer



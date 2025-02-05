Return-Path: <linux-pci+bounces-20772-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3ECAA29900
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 19:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82AF218806B0
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 18:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4AE1FCFE1;
	Wed,  5 Feb 2025 18:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m7edtQC/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471E11FCCE1;
	Wed,  5 Feb 2025 18:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738780039; cv=none; b=Jujpi7DXCaa6+co9OIsxWBBvy62aHMfCuQWJ3t4cIZ1miJ5SYN0bUhe1WEG5KIdOgy9/X69E+XGXxFBVms6RAagz7o+QRs0uGQ6s5elqVKCNh4VjEUmLqwj3oX8KXz5lKS5RZBLRtE1uXBqDUjyM9PKH4+lfrh1GXxTr45nAEuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738780039; c=relaxed/simple;
	bh=XTlhPmk51GDVC6DlWA9yXxy+ISHtOrb+IWkiux/fELw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M+QHBiIpNhl6a74bB6QDxDmQw7dbI+WeNV8D938vW8wh0+cNcuDVyg2OGy4dhwuveQhHntzF72vM50qg9l9llS9KBYbdrSC9b9gck7r3bKgL8FX/GnSDRDaoa1ML0f+rQ/vd8hy3Ax7MS39deWvX/Q+c8YKGXfFDxX1UYU68qiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m7edtQC/; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738780037; x=1770316037;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XTlhPmk51GDVC6DlWA9yXxy+ISHtOrb+IWkiux/fELw=;
  b=m7edtQC/oyshDa6xiUVPV2aEEudl0BIUPlqq4XQkfC9Ik/oWHHm5NGcg
   1G1r3ltMWtKQ3NcH4Yj/RuL1LTqTWtT1ZG7D+VDt1YKNl7ZAge2kFvatf
   34lTEmNEK21ttBVDA0xTOAmLzNOQooB9qK+XefdHlfmmwcmWg/6yob17z
   74nbO4TbH2Y0rUzICRh9t0NRloky3WGgQKtcchzuz3z2nYPB8h2RTkaE7
   p9hzZ7x0ODofCjx/5KmeVBTOrJyfg2JV83q45PVNCfgJ+0R8EGah0Wtt0
   X8hP2tlR1Idq5P53kqGKtHFqdYeb1zjRaXR1wPrnAbc+lh0Fum1hlvYFj
   w==;
X-CSE-ConnectionGUID: 7h97O7OnRZed1KX7+tew/w==
X-CSE-MsgGUID: MS8nEX73TkWf8+MZ0NbjNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39388164"
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; 
   d="scan'208";a="39388164"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 10:27:16 -0800
X-CSE-ConnectionGUID: HyM0g3kIQx2POYoCUoS8FA==
X-CSE-MsgGUID: 0tZY022HQkipK2/4msdY7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; 
   d="scan'208";a="110870664"
Received: from daliomra-mobl3.amr.corp.intel.com (HELO [10.124.220.14]) ([10.124.220.14])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 10:27:16 -0800
Message-ID: <7e5e9bad-b66b-4a7f-8868-af5f1ab2fda1@linux.intel.com>
Date: Wed, 5 Feb 2025 10:26:59 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI/portdrv: Add necessary delay for disabling
 hotplug events
To: Feng Tang <feng.tang@linux.alibaba.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: Jonathan Cameron <Jonthan.Cameron@huawei.com>,
 ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250204053758.6025-1-feng.tang@linux.alibaba.com>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250204053758.6025-1-feng.tang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/3/25 9:37 PM, Feng Tang wrote:
> According to PCIe 6.1 spec, section 6.7.3.2, software need to wait at
> least 1 second for the command-complete event, before resending the cmd
> or sending a new cmd.
>
> Currently get_port_device_capability() sends slot control cmd to disable
> PCIe hotplug interrupts without waiting for its completion and there was
> real problem reported for the lack of waiting.

Can you include the error log associated with this issue? What is the
actual issue you are seeing and in which hardware?

>
> Add the necessary wait to comply with PCIe spec. The waiting logic refers
> existing pcie_poll_cmd().
>
> Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
> ---
>   drivers/pci/pci.h          |  2 ++
>   drivers/pci/pcie/portdrv.c | 33 +++++++++++++++++++++++++++++++--
>   2 files changed, 33 insertions(+), 2 deletions(-)
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
> index 02e73099bad0..16010973bfe2 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -18,6 +18,7 @@
>   #include <linux/string.h>
>   #include <linux/slab.h>
>   #include <linux/aer.h>
> +#include <linux/delay.h>
>   
>   #include "../pci.h"
>   #include "portdrv.h"
> @@ -205,6 +206,35 @@ static int pcie_init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
>   	return 0;
>   }
>   
> +static int pcie_wait_sltctl_cmd_raw(struct pci_dev *pdev)
> +{
> +	u16 slot_status;
> +	/* 1000 ms, according toPCIe spec 6.1, section 6.7.3.2 */
> +	int timeout = 1000;
> +
> +	do {
> +		pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
> +		if (slot_status & PCI_EXP_SLTSTA_CC) {
> +			pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
> +						   PCI_EXP_SLTSTA_CC);
> +			return 0;
> +		}
> +		msleep(10);
> +		timeout -= 10;
> +	} while (timeout);
> +
> +	/* Timeout */
> +	return  -1;
> +}

May be this logic can be simplified using readl_poll_timeout()?

> +
> +void pcie_disable_hp_interrupts_early(struct pci_dev *dev)
> +{
> +	pcie_capability_clear_word(dev, PCI_EXP_SLTCTL,
> +		  PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE);
> +	if (pcie_wait_sltctl_cmd_raw(dev))
> +		pci_info(dev, "Timeout on disabling hot-plug interrupts\n");
> +}
> +
>   /**
>    * get_port_device_capability - discover capabilities of a PCI Express port
>    * @dev: PCI Express port to examine
> @@ -230,8 +260,7 @@ static int get_port_device_capability(struct pci_dev *dev)
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



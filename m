Return-Path: <linux-pci+bounces-22727-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A906A4B6C9
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 04:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 687273A7B67
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 03:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582DF1D54E2;
	Mon,  3 Mar 2025 03:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NSmr829A"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F1E1C860E;
	Mon,  3 Mar 2025 03:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740972925; cv=none; b=n6u9/YLJbT4435nr++9lPUGZ7g5O6XKkdZvsgF/Y9I3KfgSZtJrT65I83qSUK4WQsqJA2f65LixUB+sKKzU1mB1Z2mb/FfGFT1v64lB5bQymimp/HhJUb/+SnwyWOyK60DjY8NKG/Xl4ufil9QCBxOatZpau0+sLGk5BPfBuGHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740972925; c=relaxed/simple;
	bh=3W4Kj1OS8riNLi7beBVmV0A3fCB5lrLvKbFzhsQ/Uo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ozk2czkAVKNyL0q191BnIaEi9BW/6c3dZ498Q8ASoYFHum0z9qC+Eje5zSeLuQFJztbafxtCUMUALJS+19kNyHMo/66ak/w/aDEYwHD75Ruaugp7/bdrKb3X0UfHxPaz6KjYpY4NUNj9Xf3OMdfeDbt7xt7bMZT7tOFndjObB8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NSmr829A; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740972924; x=1772508924;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3W4Kj1OS8riNLi7beBVmV0A3fCB5lrLvKbFzhsQ/Uo0=;
  b=NSmr829AULCe6PSK5Z7CUCV2X06EKDtKOmhOnaNDouJ+LKRXazUape7b
   PMippf1BlCMw/kh22ih3zUPFODaWFuel/HqaWV9MWk0yG6hVZA6Vh9smW
   x/M0Sc0h9QIxhaU2bpVz02GBH/dOzdb2VHOUdkPr8/Hv6TUQ1tmfOwPJ2
   fSskwPfuVLzun6EQr5DuRXEoP1cMdPCIqxmsUwbQ7CMcQ7Wkqjj1RU4Oj
   x3DxflQYtgBPbtDSWCKpGaIIMGfMY/+Fy/eZm2VHqTNaBIaZgVXdXZxEK
   N4Nk/pyqsuRyiN4calTVNc6PohXHaG1BazUf8+X+OxjIszChVRUc/O1Hr
   g==;
X-CSE-ConnectionGUID: zlGC/ShpSIyXZf3ttFqSRg==
X-CSE-MsgGUID: ihtX5vULSDCgZutL51E7ZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="64293192"
X-IronPort-AV: E=Sophos;i="6.13,328,1732608000"; 
   d="scan'208";a="64293192"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 19:35:23 -0800
X-CSE-ConnectionGUID: sZ0MNPXlSmGYYpJLRGrSSQ==
X-CSE-MsgGUID: 450CrA34RXech8fA24R5EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="148791948"
Received: from lbogdanm-mobl3.ger.corp.intel.com (HELO [10.124.221.161]) ([10.124.221.161])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 19:35:22 -0800
Message-ID: <746fed71-f9cd-467c-ba0c-a61acd58da8d@linux.intel.com>
Date: Sun, 2 Mar 2025 19:35:21 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] PCI/portdrv: Only disable hotplug interrupts early
 when needed.
To: Feng Tang <feng.tang@linux.alibaba.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
 Liguang Zhang <zhangliguang@linux.alibaba.com>,
 Guanghui Feng <guanghuifeng@linux.alibaba.com>, rafael@kernel.org
Cc: Markus Elfring <Markus.Elfring@web.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250303023630.78397-1-feng.tang@linux.alibaba.com>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250303023630.78397-1-feng.tang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/2/25 6:36 PM, Feng Tang wrote:
> There was problem reported by firmware developers that they received
> two PCIe hotplug commands in very short intervals on an ARM server,
> which doesn't comply with PCIe spec, and broke their state machine and
> work flow. According to PCIe 6.1 spec, section 6.7.3.2, software needs
> to wait at least 1 second for the command-complete event, before
> resending the command or sending a new command.
>
> In the failure case, the first PCIe hotplug command firmware received
> is from get_port_device_capability(), which sends command to disable
> PCIe hotplug interrupts without waiting for its completion, and the
> second command comes from pcie_enable_notification() of pciehp driver,
> which enables hotplug interrupts again.
>
> One solution is to add the necessary delay after the first command [1],
> while Lukas proposed an optimization that if the pciehp driver will be
> loaded soon and handle the interrupts, then the hotplug and the wait
> are not needed and can be saved, for every root port.

I think above part of the commit message might need some rewording.

The way you are fixing this issue is to make the first command conditional
on hotplug driver not enabled. That way you can skip one of these
commands in both enable/disable hotplug driver case.

I also recommend adding some info about why making this change
should not affect the original intention of commit # 2bd50dd800b5

Code wise looks fine.

Reviewed-by: Kuppuswamy Sathyanarayanan 
<sathyanarayanan.kuppuswamy@linux.intel.com>

>
> So fix it by only disabling the hotplug interrupts when pciehp driver
> is not enabled.
>
> [1]. https://lore.kernel.org/lkml/20250224034500.23024-1-feng.tang@linux.alibaba.com/t/#u
>
> Fixes: 2bd50dd800b5 ("PCI: PCIe: Disable PCIe port services during port initialization")
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
> ---
> Changelog:
>
>    since v3:
>      * Separate this patch from patches dealing with irq storm in nomsi case
>      * Take Lukas's suggestion (Lukas Wunner)
>
>    since v2:
>      * Add patch 0001, which move the waiting logic of pcie_poll_cmd from pciehp
>        driver to PCIe port driver for code reuse (Bjorn Helgaas)
>      * Separate Lucas' suggestion out as patch 0003 (Bjorn and Sathyanarayanan)
>      * Avoid hotplug command waiting for HW without command-complete
>        event support (Bjorn Helgaas)
>      * Fix spell issue in commit log (Bjorn and Markus)
>      * Add cover-letter for whole patchset (Markus Elfring)
>      * Handle a set-but-unused build warning (0Day lkp bot)
>
>    since v1:
>      * Add the Originally-by for Liguang for patch 0002. The issue was found on
>        a 5.10 kernel, then 6.6. I was initially given a 5.10 kernel tar ball
>        without git info to debug the issue, and made the patch. Thanks to Guanghui
>        who recently pointed me to tree https://gitee.com/anolis/cloud-kernel which
>        show the wait logic in 5.10 was originally from Liguang, and never hit
>        mainline.
>      * Make the irq disabling not dependent on wthether pciehp service driver
>        will be loaded (Lukas Wunner)
>      * Use read_poll_timeout() API to simply the waiting logic (Sathyanarayanan
>        Kuppuswamy)
>      * Fix wrong email address (Markus Elfring)
>      * Add logic to skip irq disabling if it is already disabled.
>
>
>   drivers/pci/pcie/portdrv.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index 02e73099bad0..e8318fd5f6ed 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -228,10 +228,12 @@ static int get_port_device_capability(struct pci_dev *dev)
>   
>   		/*
>   		 * Disable hot-plug interrupts in case they have been enabled
> -		 * by the BIOS and the hot-plug service driver is not loaded.
> +		 * by the BIOS and the hot-plug service driver won't be loaded
I think you can use "is not enabled" instead of won't be loaded.

> +		 * to handle them.
>   		 */
> -		pcie_capability_clear_word(dev, PCI_EXP_SLTCTL,
> -			  PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE);
> +		if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
> +			pcie_capability_clear_word(dev, PCI_EXP_SLTCTL,
> +				PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE);
>   	}
>   
>   #ifdef CONFIG_PCIEAER

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer



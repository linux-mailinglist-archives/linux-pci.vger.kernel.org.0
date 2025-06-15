Return-Path: <linux-pci+bounces-29821-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6064ADA133
	for <lists+linux-pci@lfdr.de>; Sun, 15 Jun 2025 09:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4942C16F70F
	for <lists+linux-pci@lfdr.de>; Sun, 15 Jun 2025 07:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D0B3596D;
	Sun, 15 Jun 2025 07:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BVw68QeP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B892E11CF;
	Sun, 15 Jun 2025 07:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749972359; cv=none; b=EwolVtCmYhdKnvNbOY+1zSKCj+D0U9vwUq/DfDees6YDsUWzABRLLsw3ei4lS4lXiV0BziqoU+2RLy9EITVTKyXHI1erJUKpygM9GLX9oOL288Q1dwNzxb1hT4S8gaK0FKBBpdK1XQzgIgxwOZjDWIdt8Sng5GeFJSCfLiGIymY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749972359; c=relaxed/simple;
	bh=csO2QGNbf7nfO26EKC6JcvC7zLNP4dQemn8e0yToBcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qX/gLet/pLK7N0RqJzupdLWvXNt3ZQNWjRVxF3BIsegjfay6Ey3aR7WmK0+3NSMZcYphEb4ZB8pLlr4V2KVDHylRIMjPwgv16egiPCFfRUAwYzi9PWm1DCKylgm430pjPTFnOtVEYMfcok06oAdUkx1OZ9fVGYvRNcS+DLqCwTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BVw68QeP; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749972358; x=1781508358;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=csO2QGNbf7nfO26EKC6JcvC7zLNP4dQemn8e0yToBcE=;
  b=BVw68QePssQY/mAEfWhRDea/0/JKQ7TSUqbJKNtTXIiDsdYKp/jWnW9T
   K+wHoDa9i31G3bb3qICqrji7aq5Z2+G/PH+5+Itju+73Y1xmahi+XjFbj
   GK9ECu7pTYOmU3DryYnm86g0uLIkNWGZk40B2pIY5jUoqZhzo0Pwnh7wJ
   fBO4EEtruiVr8tf0KrMRbU+z9beXCc29m2nZBUhO6WKJFWRfKZlC6mtCx
   max1ofmSXwToBiTz+FUwF4TdZzc3rHm7Y74W4Xmz4TwSAvqZ3itPdHfw+
   suFGS+RJreI3M4a7M5jpi8/4JY+C8H8ZyVkCGWOyarnHQLKt5374YXmEI
   Q==;
X-CSE-ConnectionGUID: Lw9d1J/5RI63SnRLozfshg==
X-CSE-MsgGUID: 4dnyJptpSCuHbjcabZROrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11464"; a="55938975"
X-IronPort-AV: E=Sophos;i="6.16,238,1744095600"; 
   d="scan'208";a="55938975"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2025 00:25:49 -0700
X-CSE-ConnectionGUID: +9pzYl0HRJS2n0TVJY1Jzw==
X-CSE-MsgGUID: Wng3WymvTT2DyoN5s27cMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,238,1744095600"; 
   d="scan'208";a="185445438"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2025 00:25:50 -0700
Received: from [10.124.222.253] (unknown [10.124.222.253])
	by linux.intel.com (Postfix) with ESMTP id DB03B20B5736;
	Sun, 15 Jun 2025 00:25:48 -0700 (PDT)
Message-ID: <0442f060-1e8b-469a-a700-c96d18d5b737@linux.intel.com>
Date: Sun, 15 Jun 2025 00:25:38 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI/pwrctrl: Move pci_pwrctrl_create_device()
 definition to drivers/pci/pwrctrl/
To: Manivannan Sadhasivam <mani@kernel.org>, bhelgaas@google.com,
 brgl@bgdev.pl
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, lukas@wunner.de,
 Jim Quinlan <james.quinlan@broadcom.com>, Bjorn Helgaas <helgaas@kernel.org>
References: <20250614112009.6478-1-mani@kernel.org>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250614112009.6478-1-mani@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/14/25 4:20 AM, Manivannan Sadhasivam wrote:
> pci_pwrctrl_create_device() is a PWRCTRL framework API. So it should be
> built only when CONFIG_PWRCTRL is enabled. Currently, it is built
> independently of CONFIG_PWRCTRL. This creates enumeration failure on
> platforms like brcmstb using out-of-tree devicetree that describes the
> power supplies for endpoints in the PCIe child node, but doesn't use
> PWRCTRL framework to manage the supplies. The controller driver itself
> manages the supplies.
>
> But in any case, the API should be built only when CONFIG_PWRCTRL is
> enabled. So move its definition to drivers/pci/pwrctrl/core.c and provide
> a stub in drivers/pci/pci.h when CONFIG_PWRCTRL is not enabled. This also
> fixes the enumeration issues on the affected platforms.
>
> Fixes: 957f40d039a9 ("PCI/pwrctrl: Move creation of pwrctrl devices to pci_scan_device()")
> Reported-by: Jim Quinlan <james.quinlan@broadcom.com>
> Closes: https://lore.kernel.org/r/CA+-6iNwgaByXEYD3j=-+H_PKAxXRU78svPMRHDKKci8AGXAUPg@mail.gmail.com
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
> ---
>
> Changes in v2:
>
> * Dropped the unused headers from probe.c (Lukas)
>
>   drivers/pci/pci.h          |  8 ++++++++
>   drivers/pci/probe.c        | 32 --------------------------------
>   drivers/pci/pwrctrl/core.c | 36 ++++++++++++++++++++++++++++++++++++
>   3 files changed, 44 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 12215ee72afb..c5efd8b9c96a 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -1159,4 +1159,12 @@ static inline int pci_msix_write_tph_tag(struct pci_dev *pdev, unsigned int inde
>   	(PCI_CONF1_ADDRESS(bus, dev, func, reg) | \
>   	 PCI_CONF1_EXT_REG(reg))
>   
> +#ifdef CONFIG_PCI_PWRCTRL

Use IS_ENABLED?

> +struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus,
> +						  int devfn);
> +#else
> +static inline struct platform_device *
> +pci_pwrctrl_create_device(struct pci_bus *bus, int devfn) { return NULL; }
> +#endif
> +
>   #endif /* DRIVERS_PCI_H */
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 4b8693ec9e4c..478e217928a6 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -9,8 +9,6 @@
>   #include <linux/pci.h>
>   #include <linux/msi.h>
>   #include <linux/of_pci.h>
> -#include <linux/of_platform.h>
> -#include <linux/platform_device.h>
>   #include <linux/pci_hotplug.h>
>   #include <linux/slab.h>
>   #include <linux/module.h>
> @@ -2508,36 +2506,6 @@ bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
>   }
>   EXPORT_SYMBOL(pci_bus_read_dev_vendor_id);
>   
> -static struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, int devfn)
> -{
> -	struct pci_host_bridge *host = pci_find_host_bridge(bus);
> -	struct platform_device *pdev;
> -	struct device_node *np;
> -
> -	np = of_pci_find_child_device(dev_of_node(&bus->dev), devfn);
> -	if (!np || of_find_device_by_node(np))
> -		return NULL;
> -
> -	/*
> -	 * First check whether the pwrctrl device really needs to be created or
> -	 * not. This is decided based on at least one of the power supplies
> -	 * being defined in the devicetree node of the device.
> -	 */
> -	if (!of_pci_supply_present(np)) {
> -		pr_debug("PCI/pwrctrl: Skipping OF node: %s\n", np->name);
> -		return NULL;
> -	}
> -
> -	/* Now create the pwrctrl device */
> -	pdev = of_platform_device_create(np, NULL, &host->dev);
> -	if (!pdev) {
> -		pr_err("PCI/pwrctrl: Failed to create pwrctrl device for node: %s\n", np->name);
> -		return NULL;
> -	}
> -
> -	return pdev;
> -}
> -
>   /*
>    * Read the config data for a PCI device, sanity-check it,
>    * and fill in the dev structure.
> diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
> index 6bdbfed584d6..20585b2c3681 100644
> --- a/drivers/pci/pwrctrl/core.c
> +++ b/drivers/pci/pwrctrl/core.c
> @@ -6,11 +6,47 @@
>   #include <linux/device.h>
>   #include <linux/export.h>
>   #include <linux/kernel.h>
> +#include <linux/of.h>
> +#include <linux/of_pci.h>
> +#include <linux/of_platform.h>
>   #include <linux/pci.h>
>   #include <linux/pci-pwrctrl.h>
> +#include <linux/platform_device.h>
>   #include <linux/property.h>
>   #include <linux/slab.h>
>   
> +#include "../pci.h"
> +
> +struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, int devfn)
> +{
> +	struct pci_host_bridge *host = pci_find_host_bridge(bus);
> +	struct platform_device *pdev;
> +	struct device_node *np;
> +
> +	np = of_pci_find_child_device(dev_of_node(&bus->dev), devfn);
> +	if (!np || of_find_device_by_node(np))
> +		return NULL;
> +
> +	/*
> +	 * First check whether the pwrctrl device really needs to be created or
> +	 * not. This is decided based on at least one of the power supplies
> +	 * being defined in the devicetree node of the device.
> +	 */
> +	if (!of_pci_supply_present(np)) {
> +		pr_debug("PCI/pwrctrl: Skipping OF node: %s\n", np->name);
> +		return NULL;
> +	}
> +
> +	/* Now create the pwrctrl device */
> +	pdev = of_platform_device_create(np, NULL, &host->dev);
> +	if (!pdev) {
> +		pr_err("PCI/pwrctrl: Failed to create pwrctrl device for node: %s\n", np->name);
> +		return NULL;
> +	}
> +
> +	return pdev;
> +}
> +
>   static int pci_pwrctrl_notify(struct notifier_block *nb, unsigned long action,
>   			      void *data)
>   {

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer



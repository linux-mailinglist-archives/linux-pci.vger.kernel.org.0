Return-Path: <linux-pci+bounces-42637-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FB0CA4A3B
	for <lists+linux-pci@lfdr.de>; Thu, 04 Dec 2025 17:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4A40430141D9
	for <lists+linux-pci@lfdr.de>; Thu,  4 Dec 2025 16:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848732FE57B;
	Thu,  4 Dec 2025 16:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FL7fm6WE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3875E2FBDE6;
	Thu,  4 Dec 2025 16:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764867509; cv=none; b=BWvMi/oCjDGbxBy/JKNPqrrjjAyL+y0y9peg7esxk9BfcbpJLQP9/Hwj6EBdwbva65xNrr6VescYyHYKfWYFtFPeK0+dN5LOxzN0JhRQKt60mTunzc1eCStCuVnfeytWN+pjAoWE7TicBQjX46CAZhikBBnXChEiWhAlZtwdYaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764867509; c=relaxed/simple;
	bh=eCaPAd3+E30JAarPCmHS18DfypcC2n7T+u05WxwfOAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BliKFMGii2+M5MaS4v3EHFJ8YFZrfCkut9b9eMvz5cr9R3+90tNHgrMYS10JcJTIOiazp1RObuNGvXMGg3zokReMQ19NXFpwghfBkWdPB7hbhFzHszQ3kiSJtG7vpUkIeJ+FhDeRt+YR/VtKxUD0Q1ArgHTvyZv4bgfxQhbmcZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FL7fm6WE; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764867507; x=1796403507;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eCaPAd3+E30JAarPCmHS18DfypcC2n7T+u05WxwfOAw=;
  b=FL7fm6WEF1ZsPxtK+VjwWM9p2DUc7lWRiRrMLOtXQUCHGOWb+8YnD6SD
   XJ6VCbHfd3eqeiSBiYTygn+lWhn6DbZzEbTffBBZzvsHo5k4k7/ZEbb2+
   3zCYOj1q3aAK9fMM1ZD1YnGTY10ybyYQp1sQysxHcmxLXYxwEmvBqUcnW
   y9OJVCzfK8isdJCSdZlCWZIetpaXU7Eq9bqUbqtfoFfj5pEG4IiMQ5HhH
   9TmayvhyV17nMrRzi1/m2IxinkQU2g5c8FCp1++QF48B69EI5FUzXUaYU
   Q+Up1+E9dnLymhBBGwjp11eBsIDB3IcvthcYvWJmAXG7sBVsplBVsowM2
   A==;
X-CSE-ConnectionGUID: ag02RnjrTIuiL/hvC25J4Q==
X-CSE-MsgGUID: /RmPP+fYT5eiBtfZWmkFCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="66827389"
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; 
   d="scan'208";a="66827389"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 08:58:26 -0800
X-CSE-ConnectionGUID: zMTb+IuRTF+CQRwbULC29w==
X-CSE-MsgGUID: /K6CydfkQZWgnM9oRCXKtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,249,1758610800"; 
   d="scan'208";a="200165002"
Received: from schen9-mobl4.amr.corp.intel.com (HELO [10.125.108.95]) ([10.125.108.95])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 08:58:26 -0800
Message-ID: <ae90c23c-290e-4bc5-9608-6d56d4e83c91@intel.com>
Date: Thu, 4 Dec 2025 09:58:25 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] cxl/mem: Arrange for always-synchronous memdev attach
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Smita.KoralahalliChannabasappa@amd.com, alison.schofield@intel.com,
 terry.bowman@amd.com, alejandro.lucero-palau@amd.com,
 linux-pci@vger.kernel.org, Jonathan.Cameron@huawei.com,
 Alejandro Lucero <alucerop@amd.com>
References: <20251204022136.2573521-1-dan.j.williams@intel.com>
 <20251204022136.2573521-3-dan.j.williams@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251204022136.2573521-3-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/3/25 7:21 PM, Dan Williams wrote:
> In preparation for CXL accelerator drivers that have a hard dependency on
> CXL capability initialization, arrange for cxl_mem_probe() to always run
> synchronous with the device_add() of cxl_memdev instances. I.e.
> cxl_mem_driver registration is always complete before the first memdev
> creation event.
> 
> At present, cxl_pci does not care about the attach state of the cxl_memdev
> because all generic memory expansion functionality can be handled by the
> cxl_core. For accelerators, however, that driver needs to perform driver
> specific initialization if CXL is available, or execute a fallback to PCIe
> only operation.
> 
> This synchronous attach guarantee is also needed for Soft Reserve Recovery,
> which is an effort that needs to assert that devices have had a chance to
> attach before making a go / no-go decision on proceeding with CXL subsystem
> initialization.
> 
> By moving devm_cxl_add_memdev() to cxl_mem.ko it removes async module
> loading as one reason that a memdev may not be attached upon return from
> devm_cxl_add_memdev().
> 
> Cc: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Cc: Alejandro Lucero <alucerop@amd.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/Kconfig       |  2 +-
>  drivers/cxl/cxlmem.h      |  2 ++
>  drivers/cxl/core/memdev.c | 10 +++++++---
>  drivers/cxl/mem.c         | 17 +++++++++++++++++
>  4 files changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 48b7314afdb8..f1361ed6a0d4 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -22,6 +22,7 @@ if CXL_BUS
>  config CXL_PCI
>  	tristate "PCI manageability"
>  	default CXL_BUS
> +	select CXL_MEM
>  	help
>  	  The CXL specification defines a "CXL memory device" sub-class in the
>  	  PCI "memory controller" base class of devices. Device's identified by
> @@ -89,7 +90,6 @@ config CXL_PMEM
>  
>  config CXL_MEM
>  	tristate "CXL: Memory Expansion"
> -	depends on CXL_PCI
>  	default CXL_BUS
>  	help
>  	  The CXL.mem protocol allows a device to act as a provider of "System
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index c12ab4fc9512..012e68acad34 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -95,6 +95,8 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
>  	return is_cxl_memdev(port->uport_dev);
>  }
>  
> +struct cxl_memdev *__devm_cxl_add_memdev(struct device *host,
> +					 struct cxl_dev_state *cxlds);
>  struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>  				       struct cxl_dev_state *cxlds);
>  int devm_cxl_sanitize_setup_notifier(struct device *host,
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 4dff7f44d908..7a4153e1c6a7 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -1050,8 +1050,12 @@ static const struct file_operations cxl_memdev_fops = {
>  	.llseek = noop_llseek,
>  };
>  
> -struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
> -				       struct cxl_dev_state *cxlds)
> +/*
> + * Core helper for devm_cxl_add_memdev() that wants to both create a device and
> + * assert to the caller that upon return cxl_mem::probe() has been invoked.
> + */
> +struct cxl_memdev *__devm_cxl_add_memdev(struct device *host,
> +					 struct cxl_dev_state *cxlds)
>  {
>  	struct cxl_memdev *cxlmd;
>  	struct device *dev;
> @@ -1093,7 +1097,7 @@ struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>  	put_device(dev);
>  	return ERR_PTR(rc);
>  }
> -EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, "CXL");
> +EXPORT_SYMBOL_FOR_MODULES(__devm_cxl_add_memdev, "cxl_mem");
>  
>  static void sanitize_teardown_notifier(void *data)
>  {
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 6e6777b7bafb..55883797ab2d 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -201,6 +201,22 @@ static int cxl_mem_probe(struct device *dev)
>  	return devm_add_action_or_reset(dev, enable_suspend, NULL);
>  }
>  
> +/**
> + * devm_cxl_add_memdev - Add a CXL memory device
> + * @host: devres alloc/release context and parent for the memdev
> + * @cxlds: CXL device state to associate with the memdev
> + *
> + * Upon return the device will have had a chance to attach to the
> + * cxl_mem driver, but may fail if the CXL topology is not ready
> + * (hardware CXL link down, or software platform CXL root not attached)
> + */
> +struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
> +				       struct cxl_dev_state *cxlds)
> +{
> +	return __devm_cxl_add_memdev(host, cxlds);
> +}
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, "CXL");
> +
>  static ssize_t trigger_poison_list_store(struct device *dev,
>  					 struct device_attribute *attr,
>  					 const char *buf, size_t len)
> @@ -248,6 +264,7 @@ static struct cxl_driver cxl_mem_driver = {
>  	.probe = cxl_mem_probe,
>  	.id = CXL_DEVICE_MEMORY_EXPANDER,
>  	.drv = {
> +		.probe_type = PROBE_FORCE_SYNCHRONOUS,
>  		.dev_groups = cxl_mem_groups,
>  	},
>  };



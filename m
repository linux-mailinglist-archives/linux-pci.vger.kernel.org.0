Return-Path: <linux-pci+bounces-19802-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C88BA1160B
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 01:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFFA53A84BE
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 00:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F4CBA3D;
	Wed, 15 Jan 2025 00:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NNU9K6XY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFE622075;
	Wed, 15 Jan 2025 00:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736900477; cv=none; b=BcHHAGm9Iq2QNckfrbwLqd3LoET+Y+S/dpKC16dAGXkkICIddFWe85Qd50eVwLBExd6S4IrG02XsKj/1diw35PoXjaQugQXBPgwxcvKUqS4ccwi1Dt6ScrqfdsF8O/JXKv+CuwwwWqzzHmrTPTAgfwbilA1XTwMDa0okXX5DX/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736900477; c=relaxed/simple;
	bh=nx9s9kTrMVL67EOK+4RC5UR46YOLoRV67W386l/iKoo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=CK2SF9Ce24PQ+cVNC3fB8zWpf1eOcy8H7iIQsyllJfPUkcj/01PWMZWHcXzUb7gKyGl+lLW4Qrr1dChcl7QCoHg3vGiAWePbSiRSP+qj4YAJCADPHca5YqSktwowbNsj18rHwFlNqOuME89VEA79hHjCNfEGFWDi1d1fg5J49ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NNU9K6XY; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736900476; x=1768436476;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=nx9s9kTrMVL67EOK+4RC5UR46YOLoRV67W386l/iKoo=;
  b=NNU9K6XYasGNHRvuGUPnWZwXGLMNPmvPKWBGWyjqTeCXK2EKhI5VsqoF
   hz5Z/xULhXzo0YUg9ugEnQcFAdRPt1wOccBotajriEMaoZBkE0ZDOdCDb
   2WXXWiPIcdcq9mKU/jSOROJrX1bbL6Pk8eee2uoIU0GbDuvKNFEme2Xr2
   dVDbREHS7O4iKgOjee/nPvxxjvSOPHQPUk/MKwR+kN5jcIvDVffIjUS59
   C2amQx/+I0strFF2p1rOpDrx958XYQJqFpqVYUxNnYRhfnVVNOIz0apVc
   lKeQ77czb6EnCkGTE/U08GBpEjy9WaaDlfuO3QG7vdDu1ZYC2VyMAjnU2
   w==;
X-CSE-ConnectionGUID: P3n+dCeETUqq8DXix6t2jQ==
X-CSE-MsgGUID: doP0L6lkR2SbKmO+Vef2ug==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="62591004"
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="62591004"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 16:21:15 -0800
X-CSE-ConnectionGUID: krtHf1x3Ql255B4rZ8sHpQ==
X-CSE-MsgGUID: BgQl6/J9T16DlQulJGFXdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110104210"
Received: from tfalcon-desk.amr.corp.intel.com (HELO [10.124.220.21]) ([10.124.220.21])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 16:21:14 -0800
Message-ID: <2ebc17a9-9065-4488-be3b-7534ab442c22@linux.intel.com>
Date: Tue, 14 Jan 2025 16:21:15 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v2 3/4] PCI: of: Simplify
 devm_of_pci_get_host_bridge_resources() interface
To: Bjorn Helgaas <helgaas@kernel.org>, Rob Herring <robh@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>
References: <20250113231557.441289-1-helgaas@kernel.org>
 <20250113231557.441289-4-helgaas@kernel.org>
Content-Language: en-US
In-Reply-To: <20250113231557.441289-4-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Bjorn,

On 1/13/25 3:15 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Previously pci_parse_request_of_pci_ranges() supplied the default bus range
> to devm_of_pci_get_host_bridge_resources(), but that function is static and
> has no other callers, so there's no reason to complicate its interface by
> passing the default bus range.
>
> Drop the busno and bus_max parameters and use 0x0 and 0xff directly in
> devm_of_pci_get_host_bridge_resources().
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>   drivers/pci/of.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 48b9274b846e..a2acfc52caf4 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -302,8 +302,6 @@ EXPORT_SYMBOL_GPL(of_pci_check_probe_only);
>    * devm_of_pci_get_host_bridge_resources() - Resource-managed parsing of PCI
>    *                                           host bridge resources from DT
>    * @dev: host bridge device
> - * @busno: bus number associated with the bridge root bus
> - * @bus_max: maximum number of buses for this bridge
>    * @resources: list where the range of resources will be added after DT parsing
>    * @ib_resources: list where the range of inbound resources (with addresses
>    *                from 'dma-ranges') will be added after DT parsing
> @@ -319,7 +317,6 @@ EXPORT_SYMBOL_GPL(of_pci_check_probe_only);
>    * value if it failed.
>    */
>   static int devm_of_pci_get_host_bridge_resources(struct device *dev,
> -			unsigned char busno, unsigned char bus_max,
>   			struct list_head *resources,
>   			struct list_head *ib_resources,
>   			resource_size_t *io_base)
> @@ -343,12 +340,15 @@ static int devm_of_pci_get_host_bridge_resources(struct device *dev,
>   
>   	err = of_pci_parse_bus_range(dev_node, bus_range);
>   	if (err) {
> -		bus_range->start = busno;
> -		bus_range->end = bus_max;
> +		bus_range->start = 0;
> +		bus_range->end = 0xff;
>   		bus_range->flags = IORESOURCE_BUS;
>   	} else {
> -		if (bus_range->end > bus_range->start + bus_max)
> -			bus_range->end = bus_range->start + bus_max;
> +		if (bus_range->end > 0xff) {
> +			dev_info(dev, "  Invalid end bus number in %pR, defaulting to 0xff\n",
> +				 bus_range);

Use dev_warn() ? I noticed that dev_info() is used in place of 
warning/errors in this file.
Probably it needs to be cleaned?

> +			bus_range->end = 0xff;
> +		}
>   	}
>   	pci_add_resource(resources, bus_range);
>   
> @@ -595,7 +595,7 @@ static int pci_parse_request_of_pci_ranges(struct device *dev,
>   	INIT_LIST_HEAD(&bridge->windows);
>   	INIT_LIST_HEAD(&bridge->dma_ranges);
>   
> -	err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff, &bridge->windows,
> +	err = devm_of_pci_get_host_bridge_resources(dev, &bridge->windows,
>   						    &bridge->dma_ranges, &iobase);
>   	if (err)
>   		return err;

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer



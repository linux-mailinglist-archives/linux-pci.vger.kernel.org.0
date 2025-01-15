Return-Path: <linux-pci+bounces-19804-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCFEA11618
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 01:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C20F1680AA
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 00:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D378F6D;
	Wed, 15 Jan 2025 00:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d4D/uIIO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D099411CBA;
	Wed, 15 Jan 2025 00:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736901080; cv=none; b=jMRVrfQHrp162ASBG4OSMaikwM8i7Gm3y1r1aThfRVM16WD3IpTibVU6Xa1o8AHNV6k1KlvAi2tVoaHnVmH+vuEC1TqHYIXeHv56GGlhWZTA9PX2zzbjiFkAM7kGOSKLFVHtLdKf68IKDncLnHT0pqD4J2oZbEF0J6SZEyVxKGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736901080; c=relaxed/simple;
	bh=+ko4bm44RDOwrmj8OrLd3yWUVhiO7SM3/wnAyVU5a00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TWl4JOSv+4ZpanabQfeQmxUzSxhQBh/Z0MB6TltMOl+hG86BxhZfdE5/Yicq9ek1yaXDYytgtjkLbJop/86TLLSypdCxyG6cpmNQKfgGkIG6wlCdwkoO1bviBh9cLEPf3EX1PIqoQFiq21xecNNG8kA3NVmHwUDb4WmKMDjLbSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d4D/uIIO; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736901079; x=1768437079;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+ko4bm44RDOwrmj8OrLd3yWUVhiO7SM3/wnAyVU5a00=;
  b=d4D/uIIOOtVZHOCPL4h5NQrQjXYSjUEpKiaL7FFGhMY9lQpg0/axf36m
   aewXeg7MxSjxsGysASljBW5Avs4ySadEG5fjXUmupLQVEWdw+IzGQg7uz
   PShcgWjWr84F5/3oAr9I/MNhDjHgKXQwAnNXkE9Bdsvo1l8gxB+QswUZU
   OIItYPqQ/HRDTHbZ4rd3cxY1pjEAhTiP3RXMkMqj7Fq84rtHSZL+dJRTf
   kooahkxDPCka1OY3yMzBiBtV+K/YgjyGooqCEk5smQL8Q2gV0omcwRvL4
   WAoUHKN/8ntSVVPJNbhnrBiHcorNy0ki6jeVB1AZEeI98EKyBkzrAEvcG
   w==;
X-CSE-ConnectionGUID: K7DkNB/eT527hlEDjbnwQA==
X-CSE-MsgGUID: fumYRuvwRJK+IXC0ufctzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="37099758"
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="37099758"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 16:31:18 -0800
X-CSE-ConnectionGUID: l/5neenfScGge9k6WtSoyA==
X-CSE-MsgGUID: nLQn2w+OTy+rT0Aovwajfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="135806784"
Received: from tfalcon-desk.amr.corp.intel.com (HELO [10.124.220.21]) ([10.124.220.21])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 16:31:18 -0800
Message-ID: <575dc28b-e406-4d1f-b493-aed1b086a696@linux.intel.com>
Date: Tue, 14 Jan 2025 16:31:18 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] PCI: Unexport of_pci_parse_bus_range()
To: Bjorn Helgaas <helgaas@kernel.org>, Rob Herring <robh@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>
References: <20250113231557.441289-1-helgaas@kernel.org>
 <20250113231557.441289-2-helgaas@kernel.org>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250113231557.441289-2-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 1/13/25 3:15 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> of_pci_parse_bus_range() is only used in drivers/pci/of.c, so make it
> static and unexport it.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> ---
Looks good

Reviewed-by: Kuppuswamy Sathyanarayanan 
<sathyanarayanan.kuppuswamy@linux.intel.com>

>   drivers/pci/of.c  | 4 ++--
>   drivers/pci/pci.h | 7 -------
>   2 files changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 52f770bcc481..2f579b691f8e 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -190,7 +190,8 @@ EXPORT_SYMBOL_GPL(of_pci_get_devfn);
>    *
>    * Returns 0 on success or a negative error-code on failure.
>    */
> -int of_pci_parse_bus_range(struct device_node *node, struct resource *res)
> +static int of_pci_parse_bus_range(struct device_node *node,
> +				  struct resource *res)
>   {
>   	u32 bus_range[2];
>   	int error;
> @@ -207,7 +208,6 @@ int of_pci_parse_bus_range(struct device_node *node, struct resource *res)
>   
>   	return 0;
>   }
> -EXPORT_SYMBOL_GPL(of_pci_parse_bus_range);
>   
>   /**
>    * of_get_pci_domain_nr - Find the host bridge domain number
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 2e40fc63ba31..35faf4770a14 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -797,7 +797,6 @@ static inline u64 pci_rebar_size_to_bytes(int size)
>   struct device_node;
>   
>   #ifdef CONFIG_OF
> -int of_pci_parse_bus_range(struct device_node *node, struct resource *res);
>   int of_get_pci_domain_nr(struct device_node *node);
>   int of_pci_get_max_link_speed(struct device_node *node);
>   u32 of_pci_get_slot_power_limit(struct device_node *node,
> @@ -813,12 +812,6 @@ int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge);
>   bool of_pci_supply_present(struct device_node *np);
>   
>   #else
> -static inline int
> -of_pci_parse_bus_range(struct device_node *node, struct resource *res)
> -{
> -	return -EINVAL;
> -}
> -
>   static inline int
>   of_get_pci_domain_nr(struct device_node *node)
>   {

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer



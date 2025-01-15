Return-Path: <linux-pci+bounces-19805-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 135CCA1161A
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 01:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EB843A8AC2
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 00:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBE03C0B;
	Wed, 15 Jan 2025 00:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PTGYMmbq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7190D1798F;
	Wed, 15 Jan 2025 00:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736901098; cv=none; b=O7+lDuDpTePM/KQR4NyFe9QVj1l9vP4lla6k8O8piYPTSDJiHqFOhIn+f/Ji1KMrsrZv9igBCB7Cg6XVuKsRaNHcAVelfMU87vK4GKPWm+6r05vTc4Py8QgbUQKeHuO2Ekp4IH06Q89qeQfm7hFAH3+9wgRgKSrkJVvuXUWObwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736901098; c=relaxed/simple;
	bh=Zk2F5EHfZa6KIIgC/xJ0DxavRidoV3gZ/JJrZtHIVsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SqzEzOIylE0vbOMJieeAEqYIvDv1yBm5ADwgRYmOkcpeAci1inFD8i+Ua38zk4B6hvtKdFnhw7WwXuacR0Nq/Ku/R2Puqb78hsTmcMzfGNrSJCuHm7bvYnaJZtMIVP4R+NfLkuzmX7YxhjjtXoXdqLutB8t6Q14m34cZeCEDwdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PTGYMmbq; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736901096; x=1768437096;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Zk2F5EHfZa6KIIgC/xJ0DxavRidoV3gZ/JJrZtHIVsw=;
  b=PTGYMmbqvivK7MPwDRqRrlifDwjn79vjYP20qogN9YZRKwBYOMDqQH8+
   dqKCRqncoU+KiXtXei1Sd4LLuWjxUG/gUZrRYXHrSFoEhK06/mP/WYCvG
   xIk7RRMAtdQEux4eYPvvJtOf4J2Glpovr+YkHVUX2m8LnqNtL5ZshIJzB
   mAje9Y1i8invPKjbuis9SFcfSU5Cimu3zycWAnpzWp0Gqu78cTpfjqh71
   upfc3vYCTgIlBqxGGiKWQEBs6QcuXTf6ELGN+UWkjZkpsim23QnWqHt2Y
   O/heUoVc6rjuRMTzSsUqji03rplzPsdhQD7Ea94obrMX+sNCuRTiCEIEa
   g==;
X-CSE-ConnectionGUID: LO8RCcigQnKgfFQzUksp7Q==
X-CSE-MsgGUID: Z3pydINwT3uTyYdVx8BtzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="37099782"
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="37099782"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 16:31:36 -0800
X-CSE-ConnectionGUID: ergUAKsIQ5KpjVClc7kAAA==
X-CSE-MsgGUID: /FM3E/nOTomxkrjcv0ahwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="135806966"
Received: from tfalcon-desk.amr.corp.intel.com (HELO [10.124.220.21]) ([10.124.220.21])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 16:31:35 -0800
Message-ID: <cdcf4605-89ac-4631-9b8d-a905d85ef154@linux.intel.com>
Date: Tue, 14 Jan 2025 16:31:36 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] PCI: of: Drop 'No bus range found' message
To: Bjorn Helgaas <helgaas@kernel.org>, Rob Herring <robh@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>
References: <20250113231557.441289-1-helgaas@kernel.org>
 <20250113231557.441289-3-helgaas@kernel.org>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250113231557.441289-3-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 1/13/25 3:15 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> The typical bus range for a host bridge is [bus 00-ff], and
> devm_of_pci_get_host_bridge_resources() defaults to that unless DT contains
> a "bus-range" property.
>
> devm_of_pci_get_host_bridge_resources() previously emitted a message when
> there was no "bus-range" property, but that seems unnecessary for this
> common situation.  Remove the message.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan 
<sathyanarayanan.kuppuswamy@linux.intel.com>

>   drivers/pci/of.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 2f579b691f8e..48b9274b846e 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -346,8 +346,6 @@ static int devm_of_pci_get_host_bridge_resources(struct device *dev,
>   		bus_range->start = busno;
>   		bus_range->end = bus_max;
>   		bus_range->flags = IORESOURCE_BUS;
> -		dev_info(dev, "  No bus range found for %pOF, using %pR\n",
> -			 dev_node, bus_range);
>   	} else {
>   		if (bus_range->end > bus_range->start + bus_max)
>   			bus_range->end = bus_range->start + bus_max;

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer



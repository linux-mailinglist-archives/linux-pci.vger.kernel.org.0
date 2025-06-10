Return-Path: <linux-pci+bounces-29333-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6815AD3B17
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 16:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E07617AC26
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 14:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E1129DB68;
	Tue, 10 Jun 2025 14:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c359impS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA3A226533;
	Tue, 10 Jun 2025 14:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749565620; cv=none; b=ADT+1xHNSWMUcG8kDSa2keqrB46nPqfjQm/2zXbbrW/GcDOVZTeEeZmCLB/yYn1RuqcVCeXQVSd4LFNpXeKyUOynDdSRIWiyQ/UOf4aZDYlCUrONsDD78QEZIsFccBSwsLj9QiCRG7n8qmDs6dvrsTsp7bmI+Bfp+AJ7x2cNS3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749565620; c=relaxed/simple;
	bh=PaxdYGVocIUGlL8yvSo4XBYQWoBsKYP2G+KOhdyOYfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pGQjpdaEZt70TBiGeArBFq+SHdBg8JQ+oLi//NbeEFpG6j6LoG9Gfd15WmCvddxEQsk8p9RVh9yIMI/mmctF/HUFPJytcOvRzCnzOZaeDzLveeIEXF4GHDU83sJvrpNluPfi3+/40VbIgoMmI/4wopEsg1lMCxrn9k3DZdaHn9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c359impS; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749565619; x=1781101619;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=PaxdYGVocIUGlL8yvSo4XBYQWoBsKYP2G+KOhdyOYfU=;
  b=c359impS6trMik0gPAFB7oxDTMCZ+k0AKkdsVVvcsCPmuDlesiXj/KJ1
   vaD9MX2JDH8l9MmPNqPsXmC4CUDsfh0sEBli2p0eD0gbAwv3tmoAfsPeJ
   t8MQEW0zTZzJYLp2EzBF3LajXY9koHIUxFldVDBNegidioXoi9sCv+a5K
   23qMcKI9IfBBpbqVrqTT076lS1BbiYOEBNsywpJ7i9HbkQYhyMt5sbIla
   9Jsy5Gi9gv9zsKX5Ni7l/1rJGxCjGhySTaYEQcgFWKsEIsC6WtC6ssTo+
   RFCyl5NdArNv/YR9OnCIXA215wCi8TfaUoIhYFj63S1rCsKnwBmuyrdp1
   w==;
X-CSE-ConnectionGUID: o7LVc90GSXasw1dnQPqwEA==
X-CSE-MsgGUID: /v7jl3duTNiFBPoNPVQvww==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="51819969"
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="51819969"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 07:26:59 -0700
X-CSE-ConnectionGUID: OY7/Ob8kSlqfoeUdb2R1iQ==
X-CSE-MsgGUID: 5VpQplBLTmyrXIZpXzAnbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="152101743"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 07:26:59 -0700
Received: from [10.124.220.93] (unknown [10.124.220.93])
	by linux.intel.com (Postfix) with ESMTP id 3D07D20B5736;
	Tue, 10 Jun 2025 07:26:58 -0700 (PDT)
Message-ID: <875bccf2-2922-4958-9385-ca1dcd508367@linux.intel.com>
Date: Tue, 10 Jun 2025 07:26:57 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] PCI: Cleanup early_dump_pci_device()
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250610105820.7126-1-ilpo.jarvinen@linux.intel.com>
 <20250610105820.7126-2-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250610105820.7126-2-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 6/10/25 3:58 AM, Ilpo Järvinen wrote:
> Convert 256 to PCI_CFG_SPACE_SIZE and 4 to sizeof(u32) and
> avoid i / 4 construct by changing the iteration.
>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>   drivers/pci/probe.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index c00634e5a2ed..f08e754c404b 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -3,6 +3,7 @@
>    * PCI detection and setup code
>    */
>   
> +#include <linux/array_size.h>
>   #include <linux/kernel.h>
>   #include <linux/delay.h>
>   #include <linux/init.h>
> @@ -1912,16 +1913,16 @@ static int pci_intx_mask_broken(struct pci_dev *dev)
>   
>   static void early_dump_pci_device(struct pci_dev *pdev)
>   {
> -	u32 value[256 / 4];
> +	u32 value[PCI_CFG_SPACE_SIZE / sizeof(u32)];
>   	int i;
>   
>   	pci_info(pdev, "config space:\n");
>   
> -	for (i = 0; i < 256; i += 4)
> -		pci_read_config_dword(pdev, i, &value[i / 4]);
> +	for (i = 0; i < ARRAY_SIZE(value); i++)
> +		pci_read_config_dword(pdev, i * sizeof(u32), &value[i]);
>   
>   	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_OFFSET, 16, 1,
> -		       value, 256, false);
> +		       value, ARRAY_SIZE(value) * sizeof(u32), false);
>   }
>   
>   static const char *pci_type_str(struct pci_dev *dev)

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer



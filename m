Return-Path: <linux-pci+bounces-8763-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 482EC907E29
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 23:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E55341F223CE
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 21:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E85E1494C8;
	Thu, 13 Jun 2024 21:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IHYh6VKk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E6614830F;
	Thu, 13 Jun 2024 21:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718314141; cv=none; b=fjnMmS2bFyFoBDo7OfKdqS0d5REeOyp0CIuOFRgo4SU7787DHDd4CfTChZdRjSUP/HdmKQDMp8+Cdsa2BnDu8gpc2qhXk38Kfo36bN9Dg3kgbsSNYhgKG4c9qbHJaaj/voODiQysDvqVRASIGgvY0uJKm7cOf29U5DmJM0mqn74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718314141; c=relaxed/simple;
	bh=YS29bszp9afz/G0r85TArT7huFYqmbOIu0J0gzVV/eY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TnRyizUyvNPnvzVKsZvjHQeVG/W+r7mW3IhIg/jFYmmBHmYj3GffCHvCXllTnrchTeFMkCF6inCeWLkDqgt40zljE+b4n0OfkohvnwoFkB9XjHnslowE3efL1sAqqRFbn76zuAMc20B9wDLU3afG8whaOot2Bwo8eApULMzBbvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IHYh6VKk; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718314139; x=1749850139;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YS29bszp9afz/G0r85TArT7huFYqmbOIu0J0gzVV/eY=;
  b=IHYh6VKkUVU+gM0Bw1j0vxDzWRcx6II/18q88JugfaSZSx0A2fjZKPMH
   wveYKOPTp+NDPFY/rSy882I0mkWXEMIpXmiEHhudCfWPCTFwE9fAuvit8
   tE8mwb/ykl1YH7mGCmtVWYgS2GC0m+JFgQ/kAfj4/P8HdhTz1kRL9Ph0O
   AbF6zCB6aO1zxFrOUSZla2keiTaP3QSTOB1kg7YnfcI0Y+4zV7N0eB3zt
   1y7ucrgnPGUCVtL9dkYZDJN2Xes4TAtb0aOADmU464KEPQSMrWwA2nU7r
   p9LYxFrajrKxWE2z5zhPeySQpvw+uRJjFDA11fRnC0vzV1VlQV9tM2jGd
   w==;
X-CSE-ConnectionGUID: PvajivFGTPW9M7BeaxY7Ew==
X-CSE-MsgGUID: D+l0qybqTdia4yYxphaGeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="25810066"
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="25810066"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 14:28:57 -0700
X-CSE-ConnectionGUID: uAEz45bZQayb3m06ogpjDg==
X-CSE-MsgGUID: 8wYPM8OIR3aM0UJEbKdGaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="40173275"
Received: from sramkris-mobl1.amr.corp.intel.com (HELO [10.124.223.37]) ([10.124.223.37])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 14:28:56 -0700
Message-ID: <0a93b8bd-c50b-4ffd-8d6c-ba3b20b601b5@linux.intel.com>
Date: Thu, 13 Jun 2024 14:28:55 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] PCI/AER: Print UNCOR_STATUS bits that might be
 ANFE
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, linux-pci@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
 rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
 tony.luck@intel.com, bp@alien8.de, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 bhelgaas@google.com, helgaas@kernel.org, mahesh@linux.ibm.com,
 oohall@gmail.com, linmiaohe@huawei.com, shiju.jose@huawei.com,
 adam.c.preble@intel.com, lukas@wunner.de,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 linux-cxl@vger.kernel.org, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, erwin.tsaur@intel.com,
 sathyanarayanan.kuppuswamy@intel.com, dan.j.williams@intel.com,
 feiting.wanyan@intel.com, yudong.wang@intel.com, chao.p.peng@intel.com,
 qingshun.wang@linux.intel.com
References: <20240509084833.2147767-1-zhenzhong.duan@intel.com>
 <20240509084833.2147767-3-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240509084833.2147767-3-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 5/9/24 1:48 AM, Zhenzhong Duan wrote:
> When an Advisory Non-Fatal error(ANFE) triggers, both correctable error(CE)
> status and ANFE related uncorrectable error(UE) status will be printed:
>
>   AER: Correctable error message received from 0000:b7:02.0
>   PCIe Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
>     device [8086:0db0] error status/mask=00002000/00000000
>      [13] NonFatalErr
>     Uncorrectable errors that may cause Advisory Non-Fatal:
>      [18] TLP
>
> Tested-by: Yudong Wang <yudong.wang@intel.com>
> Co-developed-by: "Wang, Qingshun" <qingshun.wang@linux.intel.com>
> Signed-off-by: "Wang, Qingshun" <qingshun.wang@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---

LGTM

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>  drivers/pci/pcie/aer.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index f2839b51321a..ed435f09ac27 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -681,6 +681,7 @@ static void __aer_print_error(struct pci_dev *dev,
>  {
>  	const char **strings;
>  	unsigned long status = info->status & ~info->mask;
> +	unsigned long anfe_status = info->anfe_status;
>  	const char *level, *errmsg;
>  	int i;
>  
> @@ -701,6 +702,20 @@ static void __aer_print_error(struct pci_dev *dev,
>  				info->first_error == i ? " (First)" : "");
>  	}
>  	pci_dev_aer_stats_incr(dev, info);
> +
> +	if (!anfe_status)
> +		return;
> +
> +	strings = aer_uncorrectable_error_string;
> +	pci_printk(level, dev, "Uncorrectable errors that may cause Advisory Non-Fatal:\n");
> +
> +	for_each_set_bit(i, &anfe_status, 32) {
> +		errmsg = strings[i];
> +		if (!errmsg)
> +			errmsg = "Unknown Error Bit";
> +
> +		pci_printk(level, dev, "   [%2d] %s\n", i, errmsg);
> +	}
>  }
>  
>  void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer



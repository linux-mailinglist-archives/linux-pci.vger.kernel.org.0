Return-Path: <linux-pci+bounces-1721-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8018258C8
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jan 2024 18:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E2301C2339A
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jan 2024 17:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216AC31A78;
	Fri,  5 Jan 2024 17:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MuSUGs8U"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4113B328C9;
	Fri,  5 Jan 2024 17:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704474128; x=1736010128;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FcTzdhBtTOYIP8EuD7whPDY+E/POUXTBvU923+ovZKY=;
  b=MuSUGs8UcT5BIUxZJJoBPfF4/PPbyBuYFp4lX/oFhmm/uDdFQvtg87Mc
   JuTUxjVIgKgDb9Hqv5a+lU4A/rq1SmbFcDsRdpr4LAVNnrl1sbqpjABvd
   jAu6QxqBFB330UK/rIvgMeCqq4UXDrcO6DZeCfQD7+zWp4CjSkXyAC3Hp
   RDaZ2UhHpXyvG9K0zxFMH/38l0k8OtU9FDWOr7lkWLYiQ+KIwVqWaC7CQ
   WcDyvxy7AbUHnvPEbfPMdZfEM3taFBwxSiHp8TN+ux73CXYkCA6FDKHJO
   vMObvjDNbMLZLsxZg0bwm4JL3HlMBJ5iu12xTf9l7OyVtg+4ZNe0fy9jp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="483715041"
X-IronPort-AV: E=Sophos;i="6.04,334,1695711600"; 
   d="scan'208";a="483715041"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 09:02:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="1112132781"
X-IronPort-AV: E=Sophos;i="6.04,334,1695711600"; 
   d="scan'208";a="1112132781"
Received: from liujusti-mobl3.amr.corp.intel.com (HELO [10.212.183.234]) ([10.212.183.234])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 09:02:05 -0800
Message-ID: <e529aafc-7d97-4e38-b994-26ce99f2715d@linux.intel.com>
Date: Fri, 5 Jan 2024 09:02:06 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] PCI/MSI: Fix MSI hwirq truncation
Content-Language: en-US
To: Vidya Sagar <vidyas@nvidia.com>, bhelgaas@google.com,
 rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com, tglx@linutronix.de
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 treding@nvidia.com, jonathanh@nvidia.com, sdonthineni@nvidia.com,
 kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20240105134339.3091497-1-vidyas@nvidia.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240105134339.3091497-1-vidyas@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/5/2024 5:43 AM, Vidya Sagar wrote:
> While calculating the hwirq number for an MSI interrupt, the higher
> bits (i.e. from bit-5 onwards a.k.a domain_nr >= 32) of the PCI domain
> number gets truncated because of the shifted value casting to u32. This
> for example is resulting in same hwirq number for devices 0019:00:00.0
> and 0039:00:00.0.
> 
> So, cast the PCI domain number to u64 before left shifting it to
> calculate hwirq number.

This seems like a bug fix. Why not add Fixes: tag?

Is this issue detected in a platform test? Maybe including the relevant
details about it will help reproduce the issue.

> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  drivers/pci/msi/irqdomain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
> index c8be056c248d..cfd84a899c82 100644
> --- a/drivers/pci/msi/irqdomain.c
> +++ b/drivers/pci/msi/irqdomain.c
> @@ -61,7 +61,7 @@ static irq_hw_number_t pci_msi_domain_calc_hwirq(struct msi_desc *desc)
>  
>  	return (irq_hw_number_t)desc->msi_index |
>  		pci_dev_id(dev) << 11 |
> -		(pci_domain_nr(dev->bus) & 0xFFFFFFFF) << 27;
> +		((irq_hw_number_t)(pci_domain_nr(dev->bus) & 0xFFFFFFFF)) << 27;
>  }
>  
>  static void pci_msi_domain_set_desc(msi_alloc_info_t *arg,

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


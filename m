Return-Path: <linux-pci+bounces-18709-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6182A9F694F
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 16:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD63018961DD
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 15:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26E31F543F;
	Wed, 18 Dec 2024 15:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hzj+WplF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311F31E9B3B
	for <linux-pci@vger.kernel.org>; Wed, 18 Dec 2024 15:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734534011; cv=none; b=aWSRM4gZku0sOcNXoNBPggxxgJU5rYpF/2jLwHZGZ4zMBam6+2x1RRMOeHpH/8VQAHNSTCiRYJJq4jHEFNj8o2RfmoSagErSyxjfUnnDO9JVrIb/P/Cu4Sa+bRuACDIZ8M/DDG1fQpLb28hFHfSE6SfIvGo6i9ZJ5a/eJem2Eno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734534011; c=relaxed/simple;
	bh=9UaZhjhTFl/KNGNFGykIM6ryWVzG/1Fgp++EGtXYMKo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lfHGeMsXuStowAAKOV/CpXPN0pwtZKk1dOQ1rDrymJIwaMoF0l+ikHsVU+Fs8mHD1j0T2wHB7/mgwXVQh8HMK4L1U9nrSAYktVm7QlFO2YRi+JAUSkc+hFjfssWubkCbVDpzRrsxvAHIncsfHav1EOkrzI7SEww9a85M/N2lieY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hzj+WplF; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734534010; x=1766070010;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=9UaZhjhTFl/KNGNFGykIM6ryWVzG/1Fgp++EGtXYMKo=;
  b=Hzj+WplFY6NAxTFpTBhJXUqCjkeFU2gmFOVb1Nk8UfBux/P792cAxYwK
   IUGYuqUBleHUZDBRuNTsefiPjL/sEvKQa6QNETDakr/DPncClnDRfKknr
   0FBGr/i9ewdC05xsop8oeabOnHzvfPai5fMtjdD3bcYbq4bAmIR14PBRo
   VqIQdN/uE8kzTKDfU9HRN9F1LTf2121tzIKqwupLKVvR6rqHtiPMUk2Pw
   pQNABH86AaG0O0Wq5H3dfsf4cMSd63MLpTta3Id+RLp1EcL+obiKkr8cY
   kXYZoxqt15fForpdDk/QAlejsLAPO0JMAAYEMeQhBhdMO/pUV1pZjrqmD
   Q==;
X-CSE-ConnectionGUID: DW7lezY0RlKKGcxwhX49FA==
X-CSE-MsgGUID: y0p6+NRrSC+HqW5bM1g6kg==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="35228556"
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="35228556"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 07:00:09 -0800
X-CSE-ConnectionGUID: dHGZz/WaSRqYr8PuQu+cZg==
X-CSE-MsgGUID: eetvVac9T8yT5rL28fnF4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="97726291"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.138])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 07:00:06 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 18 Dec 2024 17:00:03 +0200 (EET)
To: Hans Zhang <18255117159@163.com>
cc: manivannan.sadhasivam@linaro.org, kw@linux.com, kishon@kernel.org, 
    arnd@arndb.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-pci@vger.kernel.org, inux-kernel@vger.kernel.org, 
    rockswang7@gmail.com
Subject: Re: [PATCH] misc: pci_endpoint_test: fixed pci_resource_len return
 value out of bounds.
In-Reply-To: <20241217121220.19676-1-18255117159@163.com>
Message-ID: <4ed0496c-329b-ae7e-dce4-5d822e652d46@linux.intel.com>
References: <20241217121220.19676-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 17 Dec 2024, Hans Zhang wrote:

> The return type of the API is inconsistent. Inconsistencies may
> result in out-of-bounds.

I'm not sure how out-of-bounds access would happen. On which line you see 
that possibility?

> If the bar size of the EP device exceeds

BAR size

> 4G, this bar_Size will be equal to 0.

bar_size

> For example, there is an EP device, the bar0 size is 16MB, bar1
> size is 32MB, bar2 size is 8GB. When testing bar2, barno equals
> BAR2. Then run pcitest -b 2, console will output "TEST FAILED".

I think bar0 and bar1 information could simply be dropped since they're 
unrelated. I think this would be enough information:

With 8GB BAR2, running pcitest -b 2 fails with "TEST FAILED".

> Variable declaration of bar_size is int, the range less than or
> equal 2G. The return value of pci_resource_len is resource_size_t.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>  drivers/misc/pci_endpoint_test.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 3aaaf47fa4ee..414c4e55fb0a 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -280,10 +280,11 @@ static int pci_endpoint_test_bar_memcmp(struct pci_endpoint_test *test,
>  static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
>  				  enum pci_barno barno)
>  {
> -	int j, bar_size, buf_size, iters, remain;
>  	void *write_buf __free(kfree) = NULL;
>  	void *read_buf __free(kfree) = NULL;
>  	struct pci_dev *pdev = test->pdev;
> +	int j, buf_size, iters, remain;
> +	resource_size_t bar_size;
>  
>  	if (!test->bar[barno])
>  		return false;
> 

The code change itself is good.

-- 
 i.



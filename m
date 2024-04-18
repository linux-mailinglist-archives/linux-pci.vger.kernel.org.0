Return-Path: <linux-pci+bounces-6453-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 737FF8AA160
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 19:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28C3228490F
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 17:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9131442F4;
	Thu, 18 Apr 2024 17:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gFNyJ/EM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4621649D1
	for <linux-pci@vger.kernel.org>; Thu, 18 Apr 2024 17:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713462598; cv=none; b=ffzMsqXYZb48r2plILjLulyKq6GaGaEH4PYt2v2Kp2B/25W/V0IVfUCskIrDUgzPGvZlr5uLkoVTxn7nubZ15EGXp28dwWoFvHIbbzVrUS+gcQB0Hap540oRzpMSz+sJuYXXH45r43skrFWeTJMVtzlgbKN7qODJwm621Nk0xOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713462598; c=relaxed/simple;
	bh=WtpIV39XXc6q4An5xTPTpITgFD1ZSkIwGfjaLSYYKgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RRaveqNtwYDgx1q01XbYlA+gBdGuqFlR7o7j0JlZ0ka6x7piXAU+1gQ6wJ+MSSnS5mht77P3iXs7hOEyg++L8H1YiQUOO4fegoTQlw+Gjn3KSJjowGlrOwY/PU2ryF0CZNBZ+WpzSDhxSKl0bMS/G1N9J8c1z7uVQ49HvYd8gLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gFNyJ/EM; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713462597; x=1744998597;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WtpIV39XXc6q4An5xTPTpITgFD1ZSkIwGfjaLSYYKgw=;
  b=gFNyJ/EMRYaTBd7tExmrCuuE0psSqjmuuxOw2bxM8htE5p6g1oF86Sgt
   HU8nsRShqUxAObMdufdshNzoTPM8uC7ErVZnVo41SF0NzM+bJUqckiwSL
   cZnGETpF5Eetjo8G3COggG5e9CW9KKTTA9pQa4+8VNC7msM5nRlmkJ3w5
   7ypU8W+kYZPtu9VwpDguCJ/5PGsJJBlhWho1YYDutQD9IywzoMe7rcH7t
   /BUbqSAJ35ty+EebOerVpLQwcUfmuvpS5c3oqfOdYtUYoTT5V37JVSSoC
   /+9Ad63eTlDJQK6rcsV1uMEkqUIrl3XHBL5/dExKy81ETB6dUPkyh3fgG
   w==;
X-CSE-ConnectionGUID: iL7lhA/LRLiIWX3frA2ZAg==
X-CSE-MsgGUID: yySYRVecTYeAR36EXQj40w==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="20417661"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="20417661"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 10:49:56 -0700
X-CSE-ConnectionGUID: 7SkLotKDTfaHf+fkbIuRpg==
X-CSE-MsgGUID: A7anORFgSzuKcByE1Ik/2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="23687297"
Received: from naweenan-mobl.amr.corp.intel.com (HELO [10.212.182.68]) ([10.212.182.68])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 10:49:56 -0700
Message-ID: <45246d6e-6739-4cab-8846-b41d0f868a00@linux.intel.com>
Date: Thu, 18 Apr 2024 10:49:55 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] misc: pci_endpoint_test: Use
 memcpy_toio()/memcpy_fromio() for BAR tests
To: Niklas Cassel <cassel@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
References: <20240322164139.678228-1-cassel@kernel.org>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240322164139.678228-1-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 3/22/24 9:41 AM, Niklas Cassel wrote:
> The current code uses writel()/readl(), which has an implicit memory
> barrier for every single readl()/writel().
>
> Additionally, reading 4 bytes at a time over the PCI bus is not really
> optimal, considering that this code is running in an ioctl handler.
>
> Use memcpy_toio()/memcpy_fromio() for BAR tests.
>
> Before patch with a 4MB BAR:
> $ time /usr/bin/pcitest -b 1
> BAR1:           OKAY
> real    0m 1.56s
>
> After patch with a 4MB BAR:
> $ time /usr/bin/pcitest -b 1
> BAR1:           OKAY
> real    0m 0.54s
>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
LGTM

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Changes since v3:
> -Use scope-based resource management __free attribute from cleanup.h to
>  avoid overly verbose gotos and labels for error handling.
> -Added a comment related to why we allocate a buffer of max 1MB.
>  (kmalloc() default upper limit is usually 4 MB on ARM and x86.)
>
>  drivers/misc/pci_endpoint_test.c | 54 +++++++++++++++++++++++++-------
>  1 file changed, 42 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 705029ad8eb5..bf64d3aff7d8 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -7,6 +7,7 @@
>   */
>  
>  #include <linux/crc32.h>
> +#include <linux/cleanup.h>
>  #include <linux/delay.h>
>  #include <linux/fs.h>
>  #include <linux/io.h>
> @@ -272,31 +273,60 @@ static const u32 bar_test_pattern[] = {
>  	0xA5A5A5A5,
>  };
>  
> +static int pci_endpoint_test_bar_memcmp(struct pci_endpoint_test *test,
> +					enum pci_barno barno, int offset,
> +					void *write_buf, void *read_buf,
> +					int size)
> +{
> +	memset(write_buf, bar_test_pattern[barno], size);
> +	memcpy_toio(test->bar[barno] + offset, write_buf, size);
> +
> +	memcpy_fromio(read_buf, test->bar[barno] + offset, size);
> +
> +	return memcmp(write_buf, read_buf, size);
> +}
> +
>  static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
>  				  enum pci_barno barno)
>  {
> -	int j;
> -	u32 val;
> -	int size;
> +	int j, bar_size, buf_size, iters, remain;
> +	void *write_buf __free(kfree) = NULL;
> +	void *read_buf __free(kfree) = NULL;
>  	struct pci_dev *pdev = test->pdev;
>  
>  	if (!test->bar[barno])
>  		return false;
>  
> -	size = pci_resource_len(pdev, barno);
> +	bar_size = pci_resource_len(pdev, barno);
>  
>  	if (barno == test->test_reg_bar)
> -		size = 0x4;
> +		bar_size = 0x4;
>  
> -	for (j = 0; j < size; j += 4)
> -		pci_endpoint_test_bar_writel(test, barno, j,
> -					     bar_test_pattern[barno]);
> +	/*
> +	 * Allocate a buffer of max size 1MB, and reuse that buffer while
> +	 * iterating over the whole BAR size (which might be much larger).
> +	 */
> +	buf_size = min(SZ_1M, bar_size);
>  
> -	for (j = 0; j < size; j += 4) {
> -		val = pci_endpoint_test_bar_readl(test, barno, j);
> -		if (val != bar_test_pattern[barno])
> +	write_buf = kmalloc(buf_size, GFP_KERNEL);
> +	if (!write_buf)
> +		return false;
> +
> +	read_buf = kmalloc(buf_size, GFP_KERNEL);
> +	if (!read_buf)
> +		return false;
> +
> +	iters = bar_size / buf_size;
> +	for (j = 0; j < iters; j++)
> +		if (pci_endpoint_test_bar_memcmp(test, barno, buf_size * j,
> +						 write_buf, read_buf, buf_size))
> +			return false;
> +
> +	remain = bar_size % buf_size;
> +	if (remain)
> +		if (pci_endpoint_test_bar_memcmp(test, barno, buf_size * iters,
> +						 write_buf, read_buf, remain))
>  			return false;
> -	}
>  
>  	return true;
>  }

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer



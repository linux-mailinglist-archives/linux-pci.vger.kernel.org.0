Return-Path: <linux-pci+bounces-4965-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE358814FA
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 16:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABE801F21FB9
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 15:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DDE54FA5;
	Wed, 20 Mar 2024 15:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nQXUxLJN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D199F524D7
	for <linux-pci@vger.kernel.org>; Wed, 20 Mar 2024 15:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710949995; cv=none; b=Hw6FLeqB0CdpYrQ2IeY5g7xavQv2/lXl/7KsFTnq82l8BvD3PcsMk5SfUtNBAm1aDLDBxleRJYbHMseHYU0JLGF+TA3pzMSUS8FJuTmm3pw+dUQEL2o7qHSKumPHSmCq3boCt7OYGUGcNe1bWJdNUs1uPqzYx8UkMv6ogh/8MQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710949995; c=relaxed/simple;
	bh=m9TOjOMVmbXvC1IaOHdRT2+yHfJKUd4Ay6jdN3l8apM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NtrUSZ0/gKz6iini1yVzUowAoY3L2HHMzetbXQSITIV4xDg5jKh3gGPHvijhurZih0hDV7aykufLDwow+93Pq5T8XOuGHfrbIbD5jrzbHNFSs1hKzdd3aDGfVSehvcIBZNHfIuSeKXbVIdy/B1OODPPIxRSLkxMXBSoGa40ebPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nQXUxLJN; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710949993; x=1742485993;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=m9TOjOMVmbXvC1IaOHdRT2+yHfJKUd4Ay6jdN3l8apM=;
  b=nQXUxLJNrJQUJI+l+lWYYhpmEWF5xZVI9x6DCPd4h8/VdDYq4k0Am7gd
   Nt33B01tG+XI6eqP0qNmdAz8oDUvzFvKbm/FzFRVmKEMfuDd8oVb8Gp50
   0hdt7Czk2J3l78qqiSb79MU9OdcCulG67sFSKL5iDorL9kuWbvZvwC0OE
   /zruV+gYpdk4AdWW1PiABlVkKMulj7m+zdqQ4MDai1MR+mXJ/E8VKv02k
   tAfjXyeqpbt79XoxNCGNykd8lQtrB9P7V8cjsn1SVRhZV3EZVUAdlI+TA
   D3GgUlEEOapqWd/ZnKrt7WzzgxNq1AmUwaXJ9qfXhwJAkvH7PIhWrjYFF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="5755896"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="5755896"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 08:53:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="18924566"
Received: from ruihanyi-mobl1.amr.corp.intel.com (HELO [10.209.75.178]) ([10.209.75.178])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 08:53:14 -0700
Message-ID: <4cb86057-f252-4f48-8b76-6cb0d8de2ec4@linux.intel.com>
Date: Wed, 20 Mar 2024 08:53:12 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] misc: pci_endpoint_test: Use
 memcpy_toio()/memcpy_fromio() for BAR tests
Content-Language: en-US
To: Niklas Cassel <cassel@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
References: <20240320090106.310955-1-cassel@kernel.org>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240320090106.310955-1-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 3/20/24 2:01 AM, Niklas Cassel wrote:
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
> Changes since v2:
> -Actually free the allocated memory... (thank you Kuppuswamy)
>
>  drivers/misc/pci_endpoint_test.c | 68 ++++++++++++++++++++++++++------
>  1 file changed, 55 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 705029ad8eb5..1d361589fb61 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -272,33 +272,75 @@ static const u32 bar_test_pattern[] = {
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
> +	void *write_buf;
> +	void *read_buf;
>  	struct pci_dev *pdev = test->pdev;
> +	bool ret;
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
> +	buf_size = min(SZ_1M, bar_size);

Why 1MB  limit?

>  
> -	for (j = 0; j < size; j += 4) {
> -		val = pci_endpoint_test_bar_readl(test, barno, j);
> -		if (val != bar_test_pattern[barno])
> -			return false;
> +	write_buf = kmalloc(buf_size, GFP_KERNEL);
> +	if (!write_buf)
> +		return false;
> +
> +	read_buf = kmalloc(buf_size, GFP_KERNEL);
> +	if (!read_buf) {
> +		ret = false;
> +		goto err;
>  	}
>  
> -	return true;
> +	iters = bar_size / buf_size;
> +	for (j = 0; j < iters; j++) {
> +		if (pci_endpoint_test_bar_memcmp(test, barno, buf_size * j,
> +						 write_buf, read_buf,
> +						 buf_size)) {
> +			ret = false;
> +			goto err;
> +		}
> +	}
> +
> +	remain = bar_size % buf_size;
> +	if (remain) {
> +		if (pci_endpoint_test_bar_memcmp(test, barno, buf_size * iters,
> +						 write_buf, read_buf,
> +						 remain)) {
> +			ret = false;
> +			goto err;
> +		}
> +	}
> +
> +	ret = true;
> +
> +err:
> +	kfree(write_buf);
> +	kfree(read_buf);
> +
> +	return ret;
>  }
>  
>  static bool pci_endpoint_test_intx_irq(struct pci_endpoint_test *test)

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer



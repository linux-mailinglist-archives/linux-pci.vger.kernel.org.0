Return-Path: <linux-pci+bounces-5015-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A51A887182
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 18:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B1AD1C21EE4
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 17:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0D75B693;
	Fri, 22 Mar 2024 17:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gIvOpdna"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91335FBA5
	for <linux-pci@vger.kernel.org>; Fri, 22 Mar 2024 17:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711126996; cv=none; b=DMm0b50b1iiAnPSxGptM6rBaPX9AD2CxeivseX4lwSYHfWMGwIpeGy7SPENOfaqOsThFfe2Svs6XM6jYzmsI4s8maak9s2i6uL3/wdw5sDu6pBMmvWoQqphmMrsNdYlW2ZonRvkJEG7THnlyPNTiBtKT+8MoPXIoNrxuwe6KZ2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711126996; c=relaxed/simple;
	bh=Kz/m1pqAcab5Bkpp0qATcSOodc9jxzM2o22YXF5JEAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GO7Dl/dYWMwhZoShknI8tZMs6co2Y95povQx5NGm9M19wqBr9c0VvtS+JEm/mjHthss6Fo+Aat3wmfhVD2FZmvQynu9tXddAkCIdxFlt9UBh9ul1L4hF9IWiSN90rFgmi8rCVV34+6qGA190JE+1weUdy4BfW7f/OAY7355eRto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gIvOpdna; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711126994; x=1742662994;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Kz/m1pqAcab5Bkpp0qATcSOodc9jxzM2o22YXF5JEAM=;
  b=gIvOpdnaC4zJqpOIafB18S9FAiBR7yxOleTjutmJxI9nVNHALiorcZrH
   oMk1FP3dmPWjG8Ne8dJ+rNl1iivRguSkk2nn6/LErNcvlTNgUGRoVG5yx
   38sRnUaEdH0SPZeRXMCrXo/QEWKVHM2xZdOADkS9ggYlwLpOWi3cl5nuI
   74sxk0v+G8jUwVaidY1FkNOv4E23BpKVYHG7Q46rqzBn5jeQBjHIUYSpS
   TovkS1b4UID1pWEtwOYgamzKPmQMIPf/mL6uaoEMeLE7GXksVXRLgLyFj
   GBth3wxDwR0F2WAe0KK3GDz5TlD4j6ucp7NBN0tCHBStHRAci8SJFVEHZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="17579321"
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="17579321"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 10:03:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="14867296"
Received: from sgreig-mobl1.amr.corp.intel.com (HELO [10.209.63.173]) ([10.209.63.173])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 10:03:13 -0700
Message-ID: <8dcb72ed-ee39-4fd6-a157-b7d889f35056@linux.intel.com>
Date: Fri, 22 Mar 2024 10:03:12 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] misc: pci_endpoint_test: Use
 memcpy_toio()/memcpy_fromio() for BAR tests
Content-Language: en-US
To: Niklas Cassel <cassel@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
References: <20240322164139.678228-1-cassel@kernel.org>
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

Please check the following cleanup doc. Recommendation is to avoid above __free(kfree) = NULL declarations and directly define write_buf/read_buf.

https://lore.kernel.org/lkml/171097196970.1011049.9726486429680041876.stgit@dwillia2-xfh.jf.intel.com/T/#m05d71a668ff0fad46c2055dbdcde55d7381780b7

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



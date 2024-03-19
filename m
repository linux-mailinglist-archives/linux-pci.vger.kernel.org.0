Return-Path: <linux-pci+bounces-4921-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C997E880753
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 23:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 285CD2843A3
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 22:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD84364D4;
	Tue, 19 Mar 2024 22:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BXhB1GGI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAB9125CB
	for <linux-pci@vger.kernel.org>; Tue, 19 Mar 2024 22:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710887952; cv=none; b=WtXBgyzfYMGHhQAXcIQMmI+zIAsjliPZTxkox24UCQLv238yvBRSxEOfeasIye7uOkv70p97VbktytFv6jdSLrHGz0DSjWdKAS9P3XTAAyGaDGMZIWZOHhFGCKKfi31QR4ZFLNZeDZ/HFVmuCwJcB039sZ4zS7+zrVlKTT5mOTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710887952; c=relaxed/simple;
	bh=CUgO4IuFwTly5St4+aU26pjwOuBOueX6lT4XgrO0SQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sfsyM9QmCrqdFi+gIUXw9jguXqxDcTsviC/YV5paYP3Qv2iYoL1jguIrvyNd9LZcGfmHGqaS7urR5FtJZg/FLhG/ux4gibrvGd6yq0of1OdgDE812AvgnOeupB4QT2ygGd6v95KoqU79NolRjkl1c6qKZj3z1GiB5oTWsWDKyG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BXhB1GGI; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710887952; x=1742423952;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CUgO4IuFwTly5St4+aU26pjwOuBOueX6lT4XgrO0SQk=;
  b=BXhB1GGIR+YvfdPH40J/JWOqrEW6Yk8MPi+X+79ivS3AJxKRT93sFIdX
   1lBHFalQUd2XC5wmmf0tdeMZ+vTsGQsuiqJ1MWoWoHfV+aRxTv5eNvsag
   Wql2s51yI6XFbZ/oWiOpguzkvMgiXmleeDTw7l/Ltrgy4NvAAEefWFzMX
   mJ1SRdxG0yinkdFxHiZL/nuXa54/eXvg2qmcAVdhOLKsKiQts4MkvuE2h
   FsLeftSPFjVV3psf699vtWes2G2whbReYr4yZjIwuKXk+c8wp782Q9a/6
   jcVDxw74qkvvvbT7YwEDJypA8SupGpxq13dl9s8Sul0J2j0zmIWJxbP8I
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="5724772"
X-IronPort-AV: E=Sophos;i="6.07,138,1708416000"; 
   d="scan'208";a="5724772"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 15:39:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,138,1708416000"; 
   d="scan'208";a="14387533"
Received: from rksinha-mobl.amr.corp.intel.com (HELO [10.209.76.248]) ([10.209.76.248])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 15:39:10 -0700
Message-ID: <49cb292a-fc84-4f5f-a1cd-8650341c4517@linux.intel.com>
Date: Tue, 19 Mar 2024 15:39:09 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] misc: pci_endpoint_test: Use
 memcpy_toio()/memcpy_fromio() for BAR tests
Content-Language: en-US
To: Niklas Cassel <cassel@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
References: <20240319213807.288550-1-cassel@kernel.org>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240319213807.288550-1-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 3/19/24 2:38 PM, Niklas Cassel wrote:
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
> Changes since v1:
> -Removed mb() memory barrier.
> -Removed variable dev that was set but never used.
>
>  drivers/misc/pci_endpoint_test.c | 49 ++++++++++++++++++++++++--------
>  1 file changed, 37 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 705029ad8eb5..c7b1214499ca 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -272,31 +272,56 @@ static const u32 bar_test_pattern[] = {
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

Not freeing the read_buf/write_buf in return path?

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



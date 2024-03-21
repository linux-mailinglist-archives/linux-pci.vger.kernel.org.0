Return-Path: <linux-pci+bounces-4976-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E0A886068
	for <lists+linux-pci@lfdr.de>; Thu, 21 Mar 2024 19:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3C691C21F22
	for <lists+linux-pci@lfdr.de>; Thu, 21 Mar 2024 18:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E43D85639;
	Thu, 21 Mar 2024 18:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fhkV0cZp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54BA84A28
	for <linux-pci@vger.kernel.org>; Thu, 21 Mar 2024 18:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711044983; cv=none; b=I/Asl7g1r0zVwz9HkHlF32h3Na/CoxWTq5WCUleCZ/ThfeNYxmMtu01wE8oMTP/Bqd57mo04GURqFFXsIRZUgfzIOjeorI0xY+pR9vby7+WtJAVVV21Eo/wXWc6nzJklKtSYc5yl50VG4bGMcwrYYXeGVzBRPv9K2CQg+KLKpmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711044983; c=relaxed/simple;
	bh=zG9idT+cMeUy10qRDJXiQ3ab9wGT0w4QTT5kW8l3bmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pcJXve9ix9ycvACmlycZU4tSEqeRWK+e3F0Su2XlI3yQCuMNMIc9srqUlfZZtBZpiOTTvk+FkSmpFXGdmIIJWcqJo5FE01C7yGwUQkOlLNbL6efjJBPi1VVu3PsHsHYyXolqve0ukGIoU/dqXKJ+3Cldb09uxli6Di52mb8KG5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fhkV0cZp; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711044982; x=1742580982;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zG9idT+cMeUy10qRDJXiQ3ab9wGT0w4QTT5kW8l3bmM=;
  b=fhkV0cZpc1IFBBYVUoPGCVv3tOCeLpxnjjwVsXJy6B29ijoRcCIi5JYz
   fCF3nCYZI/oQ3tJFGSAuYFCQtqrWfN8DpWekWQkdJc7wKhzA9H9NqdHxJ
   MiczZQzC0lAH2lgBYXjLK0XbYN/oJWXJvEgtA9yOfu6UyrljZ2Hrz87V/
   g+UI943ZYYt4A1UFlmhPHt6bUehO1t6qpcf1NkCLasSxvLPkHLflkeFB3
   2bj4LxpGWG9gZ7QP50lt+ZxA3kbZWRNj1r8VbYwUdpsfUynZR0NwRzud2
   sLjlXkpPqGdildXzjatGKRsu/A/LJd4UvnXzr7VAT85pEdek6STk4PSKb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="5953406"
X-IronPort-AV: E=Sophos;i="6.07,143,1708416000"; 
   d="scan'208";a="5953406"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 11:16:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,143,1708416000"; 
   d="scan'208";a="14686630"
Received: from sanchits-mobl2.amr.corp.intel.com (HELO [10.209.87.191]) ([10.209.87.191])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 11:16:20 -0700
Message-ID: <97bb6407-cc14-4bdb-85d8-6c77b6cc3bcf@linux.intel.com>
Date: Thu, 21 Mar 2024 11:16:20 -0700
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
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
References: <20240320090106.310955-1-cassel@kernel.org>
 <4cb86057-f252-4f48-8b76-6cb0d8de2ec4@linux.intel.com>
 <Zfvzq5eQs90n1IUz@ryzen>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <Zfvzq5eQs90n1IUz@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 3/21/24 1:45 AM, Niklas Cassel wrote:
> Hello Kuppuswamy,
>
> On Wed, Mar 20, 2024 at 08:53:12AM -0700, Kuppuswamy Sathyanarayanan wrote:
>> Hi,
>>
>> On 3/20/24 2:01 AM, Niklas Cassel wrote:
>>> The current code uses writel()/readl(), which has an implicit memory
>>> barrier for every single readl()/writel().
>>>
>>> Additionally, reading 4 bytes at a time over the PCI bus is not really
>>> optimal, considering that this code is running in an ioctl handler.
>>>
>>> Use memcpy_toio()/memcpy_fromio() for BAR tests.
>>>
>>> Before patch with a 4MB BAR:
>>> $ time /usr/bin/pcitest -b 1
>>> BAR1:           OKAY
>>> real    0m 1.56s
>>>
>>> After patch with a 4MB BAR:
>>> $ time /usr/bin/pcitest -b 1
>>> BAR1:           OKAY
>>> real    0m 0.54s
>>>
>>> Signed-off-by: Niklas Cassel <cassel@kernel.org>
>>> ---
>>> Changes since v2:
>>> -Actually free the allocated memory... (thank you Kuppuswamy)
>>>
>>>  drivers/misc/pci_endpoint_test.c | 68 ++++++++++++++++++++++++++------
>>>  1 file changed, 55 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
>>> index 705029ad8eb5..1d361589fb61 100644
>>> --- a/drivers/misc/pci_endpoint_test.c
>>> +++ b/drivers/misc/pci_endpoint_test.c
>>> @@ -272,33 +272,75 @@ static const u32 bar_test_pattern[] = {
>>>  	0xA5A5A5A5,
>>>  };
>>>  
>>> +static int pci_endpoint_test_bar_memcmp(struct pci_endpoint_test *test,
>>> +					enum pci_barno barno, int offset,
>>> +					void *write_buf, void *read_buf,
>>> +					int size)
>>> +{
>>> +	memset(write_buf, bar_test_pattern[barno], size);
>>> +	memcpy_toio(test->bar[barno] + offset, write_buf, size);
>>> +
>>> +	memcpy_fromio(read_buf, test->bar[barno] + offset, size);
>>> +
>>> +	return memcmp(write_buf, read_buf, size);
>>> +}
>>> +
>>>  static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
>>>  				  enum pci_barno barno)
>>>  {
>>> -	int j;
>>> -	u32 val;
>>> -	int size;
>>> +	int j, bar_size, buf_size, iters, remain;
>>> +	void *write_buf;
>>> +	void *read_buf;
>>>  	struct pci_dev *pdev = test->pdev;
>>> +	bool ret;
>>>  
>>>  	if (!test->bar[barno])
>>>  		return false;
>>>  
>>> -	size = pci_resource_len(pdev, barno);
>>> +	bar_size = pci_resource_len(pdev, barno);
>>>  
>>>  	if (barno == test->test_reg_bar)
>>> -		size = 0x4;
>>> +		bar_size = 0x4;
>>>  
>>> -	for (j = 0; j < size; j += 4)
>>> -		pci_endpoint_test_bar_writel(test, barno, j,
>>> -					     bar_test_pattern[barno]);
>>> +	buf_size = min(SZ_1M, bar_size);
>> Why 1MB  limit?
> Could you please clarify your concern?

Since you are trying to optimize the number of read/write calls, I
was just wondering why you chose maximum limit of 1MB per
read/write call.  But your following explanation makes sense to
me. I recommend adding some comments about it in commit log
or code.

Code wise, your change looks fine to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>
> A BAR could be several GB, so it does not make sense to always kmalloc()
> a buffer that is of the same size of the BAR.
> (Therefore we copy in to a smaller buffer, iterating over the whole BAR.)
>
> So we have to chose a max limit that we think is likely to succeed even
> when the memory is fragmented, and something that will work on embedded
> systems, etc.
>
> The highest BAR size used by pci-epf-test is by default 1MB, so 1MB
> seemed like a reasonable max limit. (Since we use min(), if the BAR is
> smaller than 1MB, the buffer we allocate will also be smaller than 1MB.
>
> Since we allocate two buffers, we are in the worst case allocating 2x 1MB,
> so I don't think that it is reasonable to have a higher max limit.
>
> If you are using a _very_ resource contained system as RC (and EP) to test
> the pci-epf-test driver, you have probably reduced the default BAR sizes
> defined in pci-epf-test to something smaller already, so 1MB seemed like
> a reasonable max limit.
>
>
> Kind regards,
> Niklas
>
>>>  
>>> -	for (j = 0; j < size; j += 4) {
>>> -		val = pci_endpoint_test_bar_readl(test, barno, j);
>>> -		if (val != bar_test_pattern[barno])
>>> -			return false;
>>> +	write_buf = kmalloc(buf_size, GFP_KERNEL);
>>> +	if (!write_buf)
>>> +		return false;
>>> +
>>> +	read_buf = kmalloc(buf_size, GFP_KERNEL);
>>> +	if (!read_buf) {
>>> +		ret = false;
>>> +		goto err;
>>>  	}
>>>  
>>> -	return true;
>>> +	iters = bar_size / buf_size;
>>> +	for (j = 0; j < iters; j++) {
>>> +		if (pci_endpoint_test_bar_memcmp(test, barno, buf_size * j,
>>> +						 write_buf, read_buf,
>>> +						 buf_size)) {
>>> +			ret = false;
>>> +			goto err;
>>> +		}
>>> +	}
>>> +
>>> +	remain = bar_size % buf_size;
>>> +	if (remain) {
>>> +		if (pci_endpoint_test_bar_memcmp(test, barno, buf_size * iters,
>>> +						 write_buf, read_buf,
>>> +						 remain)) {
>>> +			ret = false;
>>> +			goto err;
>>> +		}
>>> +	}
>>> +
>>> +	ret = true;
>>> +
>>> +err:
>>> +	kfree(write_buf);
>>> +	kfree(read_buf);
>>> +
>>> +	return ret;
>>>  }
>>>  
>>>  static bool pci_endpoint_test_intx_irq(struct pci_endpoint_test *test)
>> -- 
>> Sathyanarayanan Kuppuswamy
>> Linux Kernel Developer
>>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer



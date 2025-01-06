Return-Path: <linux-pci+bounces-19340-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCDCA02A5D
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 16:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0476F164D6F
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 15:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3E316A930;
	Mon,  6 Jan 2025 15:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jWR+rtf4"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250B91547D8;
	Mon,  6 Jan 2025 15:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736177583; cv=none; b=j3NFmrzzaRSKHQXDwUiTjEPTf21FIm1kPe8As/hvUYwHgOh3raIy1StN0NGc7/HE9GQu0ia02GR3TuWGzUns7yKGOQHYhHEekLYeuCQ9H2h1WZpZLORHWIK6hNBUiuRM0xnP6RCmyplrBOy5sagyZWWJbM4US7GAmyvOov8HPE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736177583; c=relaxed/simple;
	bh=QwtfqSO51xO1D9x2yyQfDQcuXwy+Ww+lg+g0rB6i6B0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PnrJ51uQIaoFM8CO/gvhNKhDl0b5ySz8ajg+tgZf7kW6Aqm7E8dL2AN5jHB9bfviEDXtw9T7EGdF1uGlhcP8/x9do/SCr5EI+5bRAYYxq8C2weYl6z40EpVcV61GmPwZsLFtZac/XOhwASIW4KYKN0ROUXoNo2eGOzujFs/Kots=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jWR+rtf4; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=rPCnnRhz7MQDzkIKVe+DqZbqqV0ycd7ImcPXXjEEtNA=;
	b=jWR+rtf4SdZ+TLz0mLQnl8iuuqMdeqNNBRauHrIAU0Qsp256kOLz0OG/3Z4Wy9
	TqQsUdWr2USxBrySGusBpqGOukQ4zbtJ+QkwfOHVOwu+T2oS814c3x7D37hAH6n0
	V0utupTY0NcPdeIBHEEvPgLDwzaHk2m8x1Cx4fvTOSUOc=
Received: from [192.168.71.44] (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3NxaR93tnTqZ+EA--.26530S2;
	Mon, 06 Jan 2025 23:32:34 +0800 (CST)
Message-ID: <d79d5a72-d1b0-4442-a0a3-e53516726204@163.com>
Date: Mon, 6 Jan 2025 23:32:33 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v8] misc: pci_endpoint_test: Fix overflow of bar_size
To: Niklas Cassel <cassel@kernel.org>
Cc: manivannan.sadhasivam@linaro.org, kw@linux.com, kishon@kernel.org,
 arnd@arndb.de, gregkh@linuxfoundation.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, rockswang7@gmail.com
References: <20250104151652.1652181-1-18255117159@163.com>
 <Z3vDLcq9kWL4ueq7@ryzen>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <Z3vDLcq9kWL4ueq7@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3NxaR93tnTqZ+EA--.26530S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJrWxZrWUGr17KF13uw15urg_yoW8Kry3pF
	ZIkF4FyF40qFykGws7W3Z8CF9YyFZrXry7GFWDAw1SvrnxZFn5tF18Kry5Kr98uFnFvr10
	yFnxJan8Z3W2yFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jTQ6dUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiDwvMo2d78gaCxQAAsE



On 2025/1/6 19:49, Niklas Cassel wrote:
> Doing a:
> $ git grep -A 10 "IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT"
> does not show very many hits, which suggests that this is not the proper
> way to solve this.
> 
> I don't know the proper solution to this. How is resource_size_t handled
> in other PCI driver when being built on with 32-bit PHYS_ADDR_T ?
> 
> Can't you just cast the resource_size_t to u64 before doing the division?

Hi Niklas,

Modify as follows, if you have no opinion, I will fix the next version.

>> ---
>>   drivers/misc/pci_endpoint_test.c | 12 +++++++++---
>>   1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
>> index 3aaaf47fa4ee..50d4616119af 100644
>> --- a/drivers/misc/pci_endpoint_test.c
>> +++ b/drivers/misc/pci_endpoint_test.c
>> @@ -280,10 +280,11 @@ static int pci_endpoint_test_bar_memcmp(struct pci_endpoint_test *test,
>>   static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
>>   				  enum pci_barno barno)
>>   {
>> -	int j, bar_size, buf_size, iters, remain;
>>   	void *write_buf __free(kfree) = NULL;
>>   	void *read_buf __free(kfree) = NULL;
>>   	struct pci_dev *pdev = test->pdev;
>> +	int j, buf_size, iters, remain;
>> +	resource_size_t bar_size;

Fix resource_size_t to u64 bar_size.
u64 bar_size;

>>   
>>   	if (!test->bar[barno])
>>   		return false;
>> @@ -307,13 +308,18 @@ static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
>>   	if (!read_buf)
>>   		return false;
>>   
>> -	iters = bar_size / buf_size;
>> +	if (IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT)) {
>> +		remain = do_div(bar_size, buf_size);
>> +		iters = bar_size;
>> +	} else {
>> +		iters = bar_size / buf_size;
>> +		remain = bar_size % buf_size;
>> +	}

Removed IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT), Execute the following code.

remain = do_div(bar_size, buf_size);
iters = bar_size;

>>   	for (j = 0; j < iters; j++)
>>   		if (pci_endpoint_test_bar_memcmp(test, barno, buf_size * j,
>>   						 write_buf, read_buf, buf_size))
>>   			return false;
>>   
>> -	remain = bar_size % buf_size;
>>   	if (remain)
>>   		if (pci_endpoint_test_bar_memcmp(test, barno, buf_size * iters,
>>   						 write_buf, read_buf, remain))
>>
>> base-commit: ccb98ccef0e543c2bd4ef1a72270461957f3d8d0
>> -- 
>> 2.25.1
>>

Best regards
Hans



Return-Path: <linux-pci+bounces-21336-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 394ACA33C93
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 11:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E44BC7A377B
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 10:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F93212B3B;
	Thu, 13 Feb 2025 10:21:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3A920E6E4;
	Thu, 13 Feb 2025 10:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739442116; cv=none; b=AXcdMxOuuBZQP8kfQK/JSP/jQIICthQsbMBtHveymyc9T3SlDLsps2A98BLupwmZzoE2jkAXQZLdx6FDQZxrgDLSFEDDGytKDrUp9bRDLBSIO39jlq7+eOkxI93IyNs0ETqiTqI9B2HqZZ4aSk8Os+NWTV0GsfqrpYuy0mCh2ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739442116; c=relaxed/simple;
	bh=S+kBjmvoybpI0ebF4hDrJMD2AvURdPIZ+RyEvezhIsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YGj3lcKgEmhddsCRXzdTHQ66CTl0EeiCI8GE9eCCqdpVP/8EYmzLJy6vxF2bVM4oPgw2FkHMu2VqjOw5FG1HJQ3Dqu0DKzFm0EaoN766j6rCAibM5rjd8xdDfXGkjvbEwmnshY7CAVzxu4OnExbGuv/nhFD+MvPEH6jv2jN8yeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 13 Feb 2025 19:21:46 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
	by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 48E8B208E56A;
	Thu, 13 Feb 2025 19:21:46 +0900 (JST)
Received: from iyokan2.css.socionext.com ([172.31.9.53]) by m-FILTER with ESMTP; Thu, 13 Feb 2025 19:21:46 +0900
Received: from [10.212.246.222] (unknown [10.212.246.222])
	by iyokan2.css.socionext.com (Postfix) with ESMTP id B81B0388;
	Thu, 13 Feb 2025 19:21:45 +0900 (JST)
Message-ID: <9c465e4c-ed43-4fd1-b7a7-b4c49a996fe4@socionext.com>
Date: Thu, 13 Feb 2025 19:21:45 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] misc: pci_endpoint_test: Fix irq_type to convey
 the correct type
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Krzysztof Wilczynski <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250210075812.3900646-1-hayashi.kunihiko@socionext.com>
 <20250210075812.3900646-4-hayashi.kunihiko@socionext.com>
 <Z6oi7lH7hhA3uN46@ryzen>
Content-Language: en-US
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <Z6oi7lH7hhA3uN46@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Niklas,

On 2025/02/11 1:01, Niklas Cassel wrote:
> On Mon, Feb 10, 2025 at 04:58:10PM +0900, Kunihiko Hayashi wrote:
>> There are two variables that indicate the interrupt type to be used
>> in the next test execution, "irq_type" as global and test->irq_type.
>>
>> The global is referenced from pci_endpoint_test_get_irq() to preserve
>> the current type for ioctl(PCITEST_GET_IRQTYPE).
>>
>> The type set in this function isn't reflected in the global "irq_type",
>> so ioctl(PCITEST_GET_IRQTYPE) returns the previous type.
>> As a result, the wrong type will be displayed in "pcitest" as follows:
>>
>>      # pcitest -i 0
>>      SET IRQ TYPE TO LEGACY:         OKAY
>>      # pcitest -I
>>      GET IRQ TYPE:           MSI
>>
>> Fix this issue by propagating the current type to the global "irq_type".
>>
>> Cc: stable@vger.kernel.org
>> Fixes: b2ba9225e031 ("misc: pci_endpoint_test: Avoid using module
> parameter to determine irqtype")
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> ---
>>   drivers/misc/pci_endpoint_test.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/misc/pci_endpoint_test.c
> b/drivers/misc/pci_endpoint_test.c
>> index f13fa32ef91a..6a0972e7674f 100644
>> --- a/drivers/misc/pci_endpoint_test.c
>> +++ b/drivers/misc/pci_endpoint_test.c
>> @@ -829,6 +829,7 @@ static int pci_endpoint_test_set_irq(struct
> pci_endpoint_test *test,
>>   		return ret;
>>   	}
>>   
>> +	irq_type = test->irq_type;
> 
> It feels a bit silly to add this line, when you remove this exact line in
> the next patch. Perhaps just drop this patch?

This fix will be removed in patch 4/5, so it seems no means.
However, there is an issue in the stable version, as mentioned in the
commit message, so I fix it here.

I'll treat it separately if necessary.

Thank you,

---
Best Regards
Kunihiko Hayashi


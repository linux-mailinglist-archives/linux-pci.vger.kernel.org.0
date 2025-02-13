Return-Path: <linux-pci+bounces-21337-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 582CDA33CAC
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 11:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F9B23AA97C
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 10:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B572A2139C6;
	Thu, 13 Feb 2025 10:22:03 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71280213235;
	Thu, 13 Feb 2025 10:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739442123; cv=none; b=NfZj7vBNIGluUKUsIOULFLaRavD5gv97q9wD6s4DuB84j42PLxB24MS1rk8djh2glYp0zBX30nIn04Ah7dbtXICc2f6TWP30kH9i0xStXI1WA8PrAgj/CqscqhDqnkFccuiK7GKPzNAgZ4ddEVoKnYmrLQWlZNK7Z1x+WxLlza8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739442123; c=relaxed/simple;
	bh=+q53LnfrA6EYakFJ3FWR+JUaxFhluc3CaTr5OLQFS1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L0EYqesmwoeUAGe5GJODEYxgG7iEQh28i81DxaGRHHbzAl6YRBKHU2F+HILBvT8xZfdiFWFKTKnkufEAldivuMqSB9TuPceqcIHsPDJQ2cXn/xzw5uzCx13BACSYniCGIEWhOxk5FYYVX3ox5Cwtb2wVwbF1rNb0IIZBQZB8ocQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 13 Feb 2025 19:22:00 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
	by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 54A8120090C9;
	Thu, 13 Feb 2025 19:22:00 +0900 (JST)
Received: from iyokan2.css.socionext.com ([172.31.9.53]) by m-FILTER with ESMTP; Thu, 13 Feb 2025 19:22:00 +0900
Received: from [10.212.246.222] (unknown [10.212.246.222])
	by iyokan2.css.socionext.com (Postfix) with ESMTP id 8E49E388;
	Thu, 13 Feb 2025 19:21:59 +0900 (JST)
Message-ID: <fe8763e5-2d59-4b14-8a1c-b72e6df95520@socionext.com>
Date: Thu, 13 Feb 2025 19:21:59 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] misc: pci_endpoint_test: Remove global irq_type
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Krzysztof Wilczynski <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250210075812.3900646-1-hayashi.kunihiko@socionext.com>
 <20250210075812.3900646-5-hayashi.kunihiko@socionext.com>
 <Z6opssGJ91MVWgRC@ryzen>
Content-Language: en-US
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <Z6opssGJ91MVWgRC@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Niklas,

On 2025/02/11 1:30, Niklas Cassel wrote:
> On Mon, Feb 10, 2025 at 04:58:11PM +0900, Kunihiko Hayashi wrote:
>> The global variable "irq_type" preserves the current value of
>> ioctl(GET_IRQTYPE), however, it's enough to use test->irq_type.
>> Remove the variable, and replace with test->irq_type.
> 
> I think the commit message is missing the biggest point.
> 
> ioctl(SET_IRQTYPE) sets test->irq_type.
> PCITEST_WRITE/PCITEST_READ/PCITEST_COPY all use test->irq_type when
> writing the PCI_ENDPOINT_TEST_IRQ_TYPE register in test_reg_bar.
> 
> The endpoint function driver (pci-epf-test) will look at
> PCI_ENDPOINT_TEST_IRQ_TYPE register in test_reg_bar when determining
> which type of IRQ it should raise.
> 
> This means that the kernel module parameter is basically useless,
> since it is unused if anyone has called ioctl(SET_IRQTYPE).
> 
> Both the old pcitest.sh and the new pci_endpoint_test kselftest call
> ioctl(SET_IRQTYPE), so in practice the irq_type kernel module parameter
> is dead code.

Thank you for pointing out.

Surely, global "irq_type" is only used for return value of ioctl(GET_IRQTYPE).
It isn't used in the test case, and the test is completed with test->irq_type
and the register.

I'll add this point to the explanation.

>>
>> The ioctl(GET_IRQTYPE) returns an error if test->irq_type has
>> IRQ_TYPE_UNDEFINED.
>>
>> Suggested-by: Niklas Cassel <cassel@kernel.org>
>> Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> ---
>>   drivers/misc/pci_endpoint_test.c | 13 ++++---------
>>   1 file changed, 4 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/misc/pci_endpoint_test.c
> b/drivers/misc/pci_endpoint_test.c
>> index 6a0972e7674f..8d98cd18634d 100644
>> --- a/drivers/misc/pci_endpoint_test.c
>> +++ b/drivers/misc/pci_endpoint_test.c
>> @@ -100,10 +100,6 @@ static bool no_msi;
>>   module_param(no_msi, bool, 0444);
>>   MODULE_PARM_DESC(no_msi, "Disable MSI interrupt in pci_endpoint_test");
> 
> Considering that you are removing the irq_type kernel module parameter,
> it doesn't make sense to keep the no_msi kernel module parameter IMO.
> 
> The exact same argument for why we are removing irq_type, can be made for
> no_msi.

Agreed.
Even if chip doesn't have MSI, test->irq_type starts with IRQ_TYPE_UNDEFINED
and will be changed with ioctl(SET_IRQTYPE).
"no_msi" can also be removed.

Thank you,

---
Best Regards
Kunihiko Hayashi


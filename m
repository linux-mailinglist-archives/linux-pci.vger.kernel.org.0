Return-Path: <linux-pci+bounces-20651-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A42F2A2537B
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2025 09:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B6E13A2F9F
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2025 08:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01B21F5428;
	Mon,  3 Feb 2025 08:03:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3C53594E;
	Mon,  3 Feb 2025 08:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738569788; cv=none; b=ITMf3vZ/sIbVQmSHDaeHwx1BnLytH2sFTVD9vL4JXJoQiOf4E1K03gsXd38P/FwpQDxgxEjK6Ws752QaN2x9FFMybTIMmA8Vgu9nYjgVUX1B5pzM75uVVwpsyskv6/FrdjDh/3NXDEQtsYMbyrwf5FCyiC/9Z6SbfUVHRKEL9Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738569788; c=relaxed/simple;
	bh=HxvnRxsWH1IhQ8Dp10Gb3fAsPQ2pF+y7S0v2qGO8xok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PEc2Abev4h/YPe5wcr/666xquU72Yyx6jpPRdAIPeoZ8n3nhSAf2ApHu+f1xHDGKfIjdnfjKJitMUTDk8fYexo4LUs2dzy1cJSkSQhzyD8nbGgxiYfuGubc9QtPjqb4P0o768OBG6r+0G+JaQgV+x4soc944BMYMgJoQTlxRhmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 03 Feb 2025 17:03:04 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
	by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id EF2EF2006FCC;
	Mon,  3 Feb 2025 17:03:03 +0900 (JST)
Received: from iyokan2.css.socionext.com ([172.31.9.53]) by m-FILTER with ESMTP; Mon, 3 Feb 2025 17:03:03 +0900
Received: from [10.212.246.222] (unknown [10.212.246.222])
	by iyokan2.css.socionext.com (Postfix) with ESMTP id 9C62E1A9;
	Mon,  3 Feb 2025 17:03:03 +0900 (JST)
Message-ID: <b60d845e-5bea-4d85-a400-8a579a3e28b9@socionext.com>
Date: Mon, 3 Feb 2025 17:03:03 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] misc: pci_endpoint_test: Fix irq_type to convey
 the correct type
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250122022446.2898248-1-hayashi.kunihiko@socionext.com>
 <20250122022446.2898248-4-hayashi.kunihiko@socionext.com>
 <20250128143231.ondpjpugft37qwo5@thinkpad> <Z5oX5Fe5FY2Pym0u@ryzen>
 <fe8c2233-fa2a-4356-8005-6cbabf6a0e96@socionext.com> <Z5y9zpFGkBnY2TG1@ryzen>
Content-Language: en-US
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <Z5y9zpFGkBnY2TG1@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Niklas,

On 2025/01/31 21:10, Niklas Cassel wrote:
> On Fri, Jan 31, 2025 at 07:16:54PM +0900, Kunihiko Hayashi wrote:
>> Hi Niklas,
>>
>> On 2025/01/29 20:58, Niklas Cassel wrote:
>>> On Tue, Jan 28, 2025 at 08:02:31PM +0530, Manivannan Sadhasivam wrote:
>>>> On Wed, Jan 22, 2025 at 11:24:46AM +0900, Kunihiko Hayashi wrote:
>>>>> There are two variables that indicate the interrupt type to be
> used
>>>>> in the next test execution, "irq_type" as global and
> test->irq_type.
>>>>>
>>>>> The global is referenced from pci_endpoint_test_get_irq() to
> preserve
>>>>> the current type for ioctl(PCITEST_GET_IRQTYPE).
>>>>>
>>>>> The type set in this function isn't reflected in the global
> "irq_type",
>>>>> so ioctl(PCITEST_GET_IRQTYPE) returns the previous type.
>>>>> As a result, the wrong type will be displayed in "pcitest" as
> follows:
>>>>>
>>>>>       # pcitest -i 0
>>>>>       SET IRQ TYPE TO LEGACY:         OKAY
>>>>>       # pcitest -I
>>>>>       GET IRQ TYPE:           MSI
>>>>>
>>>>> Fix this issue by propagating the current type to the global
> "irq_type".
>>>>>
>>>>
>>>> This is becoming a nuisance. I think we should get rid of the global
>>>> 'irq_type'
>>>> and just stick to the one that is configurable using IOCTL command.
> Even
>>>> if the
>>>> user has configured the global 'irq_type' it is bound to change with
> IOCTL
>>>> command.
>>>
>>> +1
>>
>> After fixing the issue described in this patch,
>> we can replace with a new member of 'struct pci_endpoint_test' instead.
> 
> Sorry, but I don't understand what you mean here.
> You want this patch to be applied.
> Then you want to add a new struct member to struct pci_endpoint_test?
> struct pci_endpoint_test already has a struct member named irq_type,
> so why do you want to add a new member?

Sorry for confusion.

The internal state (test->irq_type) has the state IRQ_TYPE_UNDEFINED and
the global irq_type doesn't. Then I've thought that ioctl(GET_IRQTYPE)
should not return UNDEFINED state.

However, ioctl(GET_IRQTYPE) can return with an error if the state is
UNDEFINED. This is new behavior, but not inconsistent.
So the additional irq_type is no longer necessary.

> Like Mani suggested, I think it would be nice if we could remove the
> global irq_type kernel module parameter, and change so that
> PCITEST_GET_IRQTYPE returns test->irq_type.

I see.
I'll add new patch to remove the global irq_type and replace with
test->irq_type.

> Note that your series does not apply to pci/next, and needs to be rebased.
> (It conflicts with f26d37ee9bda ("misc: pci_endpoint_test: Fix IOCTL
> return value"))

Yes, I've confirmed the conflict and I'll rebase it next.

>>
>>> But I also don't like how since we migrated to selftests:
>>> READ_TEST / WRITE_TEST / COPY_TEST unconditionally call
>>> ioctl(PCITEST_SET_IRQTYPE, MSI) before doing their thing.
>>
>> I think that it's better to prepare new patch series.
> 
> Here, I was pointing out what I think is a regression with the
> migration to selftests. (Which is unrelated to this series.)
> 
> I do suggest a way to improve things futher down (introducing a
> PCITEST_SET_IRQTYPE, AUTO), but I don't think that you need to be
> the one implementing this suggestion, since you did not introduce
> this regression.

Okay, I expect another topic after we remove the global variables.

>>
>>> Will this cause the test case to fail for platforms that only support
> MSI-X?
>>> (See e.g. dwc/pci-layerscape-ep.c where this could be the case.)
>>>
>>>
>>> Sure, before, in pcitest.sh, we would do:
>>>
>>>
>>> pcitest -i 2
>>>           pcitest -x $msix
>>>
>>>
>>> pcitest -i 1
>>>
>>> pcitest -r -s 1
>>> pcitest -r -s 1024
>>> pcitest -r -s 1025
>>> pcitest -r -s 1024000
>>> pcitest -r -s 1024001
>>>
>>>
>>> Which would probably print an error if:
>>> pcitest -i 1
>>> failed.
>>>
>>> but the READ_TEST / WRITE_TEST / COPY_TEST tests themselves
>>> would not fail.
>>>
>>>
>>> Perhaps we should rethink this, and introduce a new
>>> PCITEST_SET_IRQTYPE, AUTO
>>>
>>> I would be fine if
>>> READ_TEST / WRITE_TEST / COPY_TEST
>>> called PCITEST_SET_IRQTYPE, AUTO
>>> before doing their thing.
>>>
>>>
>>>
>>> How I suggest PCITEST_SET_IRQTYPE, AUTO
>>> would work:
>>>
>>> Since we now have capabilties merged:
>>>
> https://lore.kernel.org/linux-pci/20241203063851.695733-4-cassel@kernel.or
> g/
>>>
>>> Add epc_features->msi_capable and epc->features->msix_capable
>>> as two new bits in the PCI_ENDPOINT_TEST_CAPS register.
>>>
>>> If PCITEST_SET_IRQTYPE, AUTO:
>>> if EP CAP has msi_capable set: set IRQ type MSI
>>> else if EP CAP has msix_capable set: set IRQ type MSI-X
>>> else: set legacy/INTx
>>
>> There is something ambiguous about the behavior for me.
>>
>> The test->irq_type has a state "UNDEFINED".
>> After issueing "Clear IRQ", test->irq_type becomes "UNDEFINED"
> currently,
>> and all tests with IRQs will fail until new test->irq_type is set.
> 
> That is fine, no?
> 
> If a user calls PCITEST_CLEAR_IRQ without doing a PCITEST_SET_IRQTYPE
> afterwards, what else can the tests relying on IRQs to other than fail?
> 
> FWIW, tools/testing/selftests/pci_endpoint/pci_endpoint_test.c never does
> an ioctl(PCITEST_CLEAR_IRQ).

As mentioned above, PCITEST_GET_IRQTYPE can fail with an error, and
I understand that this will not affect the test.

Thank you,

>>
>> If SET_IRQTYPE is AUTO, how will test->irq_type be set?
> 
> I was thinking something like this:
> 
> pci_endpoint_test_set_irq()
> {
> 	u32 caps = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CAPS);
> 
> 	...
> 
> 	if (req_irq_type == IRQ_TYPE_AUTO) {
> 		if (caps & MSI_CAPABLE)
> 			test->irq_type = IRQ_TYPE_MSI;
> 		else if (caps & MSIX_CAPABLE)
> 			test->irq_type = IRQ_TYPE_MSIX;
> 		else
> 			test->irq_type = IRQ_TYPE_INTX;
> 
> 	}
> 
> 	...
> }
> 
> 
> Kind regards,
> Niklas

---
Best Regards
Kunihiko Hayashi


Return-Path: <linux-pci+bounces-20582-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67143A23C09
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2025 11:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DED6E188A180
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2025 10:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5F9171092;
	Fri, 31 Jan 2025 10:17:05 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DD9EED8;
	Fri, 31 Jan 2025 10:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738318625; cv=none; b=jyMI1AL8ck4QVhnJHnHC7n4daNoPDFDgLQlFzp3Sadj88UCOVeBs86y8X6iP0rVZm6fial8G7PBES/+SGcplP7uZpThY7Ye4j9FyiyHeeLroThDXYAt3gmnoxzZI1xsH8j4IhEyOcH4O+8cX5rj2hQXFwY5qyMBnRiaTsm+69iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738318625; c=relaxed/simple;
	bh=HW5NlCZ6hpmmzwD/UeYkcnBJqeWue6YDR/Pb1Fco2yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W4fsMZigmDz/frUJhS00aiXS/TY12mgkJX2XCK8M5Cd9ZnPLRu8vJrqx3XfeXvnT38kpgJPnr3D3fr1lEZWdG7Isnb2WI5FH50h5T4Ct2GOxdP76/JHccLjS6oCVLVleZexzvduL6uFXwzpG6JqXtkqGhJroaQEfiTy1Swf147Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 31 Jan 2025 19:16:55 +0900
Received: from mail.mfilter.local (mail-arc01.css.socionext.com [10.213.46.36])
	by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 5D64F20090BC;
	Fri, 31 Jan 2025 19:16:55 +0900 (JST)
Received: from iyokan2.css.socionext.com ([172.31.9.53]) by m-FILTER with ESMTP; Fri, 31 Jan 2025 19:16:55 +0900
Received: from [10.212.246.222] (unknown [10.212.246.222])
	by iyokan2.css.socionext.com (Postfix) with ESMTP id 9C7C4AB186;
	Fri, 31 Jan 2025 19:16:54 +0900 (JST)
Message-ID: <fe8c2233-fa2a-4356-8005-6cbabf6a0e96@socionext.com>
Date: Fri, 31 Jan 2025 19:16:54 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] misc: pci_endpoint_test: Fix irq_type to convey
 the correct type
To: Niklas Cassel <cassel@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250122022446.2898248-1-hayashi.kunihiko@socionext.com>
 <20250122022446.2898248-4-hayashi.kunihiko@socionext.com>
 <20250128143231.ondpjpugft37qwo5@thinkpad> <Z5oX5Fe5FY2Pym0u@ryzen>
Content-Language: en-US
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <Z5oX5Fe5FY2Pym0u@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Niklas,

On 2025/01/29 20:58, Niklas Cassel wrote:
> On Tue, Jan 28, 2025 at 08:02:31PM +0530, Manivannan Sadhasivam wrote:
>> On Wed, Jan 22, 2025 at 11:24:46AM +0900, Kunihiko Hayashi wrote:
>>> There are two variables that indicate the interrupt type to be used
>>> in the next test execution, "irq_type" as global and test->irq_type.
>>>
>>> The global is referenced from pci_endpoint_test_get_irq() to preserve
>>> the current type for ioctl(PCITEST_GET_IRQTYPE).
>>>
>>> The type set in this function isn't reflected in the global "irq_type",
>>> so ioctl(PCITEST_GET_IRQTYPE) returns the previous type.
>>> As a result, the wrong type will be displayed in "pcitest" as follows:
>>>
>>>      # pcitest -i 0
>>>      SET IRQ TYPE TO LEGACY:         OKAY
>>>      # pcitest -I
>>>      GET IRQ TYPE:           MSI
>>>
>>> Fix this issue by propagating the current type to the global "irq_type".
>>>
>>
>> This is becoming a nuisance. I think we should get rid of the global
>> 'irq_type'
>> and just stick to the one that is configurable using IOCTL command. Even
>> if the
>> user has configured the global 'irq_type' it is bound to change with IOCTL
>> command.
> 
> +1

After fixing the issue described in this patch,
we can replace with a new member of 'struct pci_endpoint_test' instead.

> But I also don't like how since we migrated to selftests:
> READ_TEST / WRITE_TEST / COPY_TEST unconditionally call
> ioctl(PCITEST_SET_IRQTYPE, MSI) before doing their thing.

I think that it's better to prepare new patch series.

> Will this cause the test case to fail for platforms that only support MSI-X?
> (See e.g. dwc/pci-layerscape-ep.c where this could be the case.)
> 
> 
> Sure, before, in pcitest.sh, we would do:
> 
> 
> pcitest -i 2
>          pcitest -x $msix
> 
> 
> pcitest -i 1
> 
> pcitest -r -s 1
> pcitest -r -s 1024
> pcitest -r -s 1025
> pcitest -r -s 1024000
> pcitest -r -s 1024001
> 
> 
> Which would probably print an error if:
> pcitest -i 1
> failed.
> 
> but the READ_TEST / WRITE_TEST / COPY_TEST tests themselves
> would not fail.
> 
> 
> Perhaps we should rethink this, and introduce a new
> PCITEST_SET_IRQTYPE, AUTO
> 
> I would be fine if
> READ_TEST / WRITE_TEST / COPY_TEST
> called PCITEST_SET_IRQTYPE, AUTO
> before doing their thing.
> 
> 
> 
> How I suggest PCITEST_SET_IRQTYPE, AUTO
> would work:
> 
> Since we now have capabilties merged:
> https://lore.kernel.org/linux-pci/20241203063851.695733-4-cassel@kernel.org/
> 
> Add epc_features->msi_capable and epc->features->msix_capable
> as two new bits in the PCI_ENDPOINT_TEST_CAPS register.
> 
> If PCITEST_SET_IRQTYPE, AUTO:
> if EP CAP has msi_capable set: set IRQ type MSI
> else if EP CAP has msix_capable set: set IRQ type MSI-X
> else: set legacy/INTx

There is something ambiguous about the behavior for me.

The test->irq_type has a state "UNDEFINED".
After issueing "Clear IRQ", test->irq_type becomes "UNDEFINED" currently,
and all tests with IRQs will fail until new test->irq_type is set.

If SET_IRQTYPE is AUTO, how will test->irq_type be set?

Thank you,

---
Best Regards
Kunihiko Hayashi


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 929803E3F13
	for <lists+linux-pci@lfdr.de>; Mon,  9 Aug 2021 06:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbhHIEhM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Aug 2021 00:37:12 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:60636 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhHIEhM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Aug 2021 00:37:12 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1794aXiv052250;
        Sun, 8 Aug 2021 23:36:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1628483793;
        bh=mwdJPwajBI/YCy7W5nxRVLrJ1fV369nW7F6C3Wctgac=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=nat/TGS45VGMtf3MFt+BWmTgEoT4CPLVqzy/2e/3RCMwi0+ru5oloU3oK+EtNT97u
         XjOBOBQO5c6rJNwgm+wbam9Imcrq/MUVrLSpFe/l6GivFvoatobT1K7aoI0GrDrnqL
         UUZOspgWtsFljnW33+w71+7LkbruTNXsMhTglROU=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1794aXff118997
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 8 Aug 2021 23:36:33 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sun, 8 Aug
 2021 23:36:33 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Sun, 8 Aug 2021 23:36:33 -0500
Received: from [10.250.235.70] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1794aTSd003744;
        Sun, 8 Aug 2021 23:36:30 -0500
Subject: Re: [PATCH v2 5/6] misc: pci_endpoint_test: Do not request or
 allocate IRQs in probe
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tom Joseph <tjoseph@cadence.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <nadeem@cadence.com>
References: <20210803074932.19820-1-kishon@ti.com>
 <20210803074932.19820-6-kishon@ti.com> <20210803095839.GA11252@lpieralisi>
 <02c1ddb7-539e-20a0-1bef-e10e76922a0e@ti.com>
 <20210805112639.GA20438@lpieralisi>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <78b4c4df-0854-fe28-53bd-7629b0357637@ti.com>
Date:   Mon, 9 Aug 2021 10:06:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210805112639.GA20438@lpieralisi>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On 05/08/21 4:56 pm, Lorenzo Pieralisi wrote:
> On Wed, Aug 04, 2021 at 07:32:44PM +0530, Kishon Vijay Abraham I wrote:
>> Hi Lorenzo,
>>
>> On 03/08/21 3:28 pm, Lorenzo Pieralisi wrote:
>>> On Tue, Aug 03, 2021 at 01:19:31PM +0530, Kishon Vijay Abraham I wrote:
>>>> Allocation of IRQ vectors and requesting IRQ is done as part of
>>>> PCITEST_SET_IRQTYPE. Do not request or allocate IRQs in probe for
>>>> AM654 and J721E so that the user space test script has better control
>>>> of the devices for which the IRQs are configured. Since certain user
>>>> space scripts could rely on allocation of IRQ vectors during probe,
>>>> remove allocation of IRQs only for TI's K3 platform.
>>>>
>>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>>> ---
>>>>  drivers/misc/pci_endpoint_test.c | 19 +++++++++++++------
>>>>  1 file changed, 13 insertions(+), 6 deletions(-)
>>>
>>> I don't claim to understand the inner details of the endpoint test
>>> device but it looks like this approach should be redesigned.
>>>
>>> I don't believe using devices quirks is the best approach to
>>> expose/remove a feature to userspace, this can soon become
>>> unmaintenable.
>>>
>>> Maybe you can elaborate a bit more on what the real issue is please ?
>>
>> The actual reason for introducing this patch (affects only AM654 and
>> J721E) is due to Errata ID #i2101 GIC: ITS Misbehavior
>> (https://www.ti.com/lit/er/sprz455a/sprz455a.pdf). So if more than 5
>> devices use GIC ITS simultaneously, GIC fails to raise interrupts.
>>
>> Though this patch is not an actual workaround for the issue (the
>> workaround is in GIC ITS driver provided in the errata document), it
>> helps to keep testing PCIe RC/EP using pci-endpoint-test even when
>> multiple pci-epf-test endpoint devices are connected (Normal test-setup
>> having J721E-J721E back to back connection can support 21 pci-epf-test
>> devices). So this patch lets user to individually enable interrupts for
>> each of the devices and could disable after the interrupt test.
>>
>> Since pci_endpoint_test is used only for testing PCIE RC/EP
>> communication and pci-endpoint-test has already implemented
>> PCITEST_SET_IRQTYPE for the userspace to enable interrupt, tried to not
>> enable the interrupts of all the devices by default in the probe (for
>> AM654 and J721E where this errata applies).
> 
> I understand - what I am asking is:
> 
> is it possible, instead of applying this patch, to make
> 
> pci_endpoint_test_alloc_irq_vectors() and pci_endpoint_test_request_irq()
> 
> fail in the target platforms instead of preventing to call them ?

hmm.. since both the platforms use GIC ITS it would need modifications
in the irq-gic-v3-its.c driver. I could add the workaround mentioned in
the errata document and send the patch for review to see what others think.

Thanks,
Kishon

> 
> My worry is that you may end up with more corner cases in the future
> and peppering code with is_() calls to work around them which does
> not look right.
> 
> Thanks,
> Lorenzo
> 
>> Thanks,
>> Kishon
>>
>>>
>>> Thanks,
>>> Lorenzo
>>>
>>>> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
>>>> index c7ee34013485..9740f2a0e7cd 100644
>>>> --- a/drivers/misc/pci_endpoint_test.c
>>>> +++ b/drivers/misc/pci_endpoint_test.c
>>>> @@ -79,6 +79,9 @@
>>>>  #define PCI_DEVICE_ID_RENESAS_R8A774C0		0x002d
>>>>  #define PCI_DEVICE_ID_RENESAS_R8A774E1		0x0025
>>>>  
>>>> +#define is_j721e_pci_dev(pdev)         \
>>>> +		((pdev)->device == PCI_DEVICE_ID_TI_J721E)
>>>> +
>>>>  static DEFINE_IDA(pci_endpoint_test_ida);
>>>>  
>>>>  #define to_endpoint_test(priv) container_of((priv), struct pci_endpoint_test, \
>>>> @@ -810,9 +813,11 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
>>>>  
>>>>  	pci_set_master(pdev);
>>>>  
>>>> -	if (!pci_endpoint_test_alloc_irq_vectors(test, irq_type)) {
>>>> -		err = -EINVAL;
>>>> -		goto err_disable_irq;
>>>> +	if (!(is_am654_pci_dev(pdev) || is_j721e_pci_dev(pdev))) {
>>>> +		if (!pci_endpoint_test_alloc_irq_vectors(test, irq_type)) {
>>>> +			err = -EINVAL;
>>>> +			goto err_disable_irq;
>>>> +		}
>>>>  	}
>>>>  
>>>>  	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
>>>> @@ -850,9 +855,11 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
>>>>  		goto err_ida_remove;
>>>>  	}
>>>>  
>>>> -	if (!pci_endpoint_test_request_irq(test)) {
>>>> -		err = -EINVAL;
>>>> -		goto err_kfree_test_name;
>>>> +	if (!(is_am654_pci_dev(pdev) || is_j721e_pci_dev(pdev))) {
>>>> +		if (!pci_endpoint_test_request_irq(test)) {
>>>> +			err = -EINVAL;
>>>> +			goto err_kfree_test_name;
>>>> +		}
>>>>  	}
>>>>  
>>>>  	misc_device = &test->miscdev;
>>>> -- 
>>>> 2.17.1
>>>>

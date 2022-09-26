Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363FD5EA8E5
	for <lists+linux-pci@lfdr.de>; Mon, 26 Sep 2022 16:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbiIZOql (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 10:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234625AbiIZOqS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 10:46:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 401DA51405;
        Mon, 26 Sep 2022 06:10:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 837E31042;
        Mon, 26 Sep 2022 06:10:13 -0700 (PDT)
Received: from [10.57.65.170] (unknown [10.57.65.170])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 232453F66F;
        Mon, 26 Sep 2022 06:10:04 -0700 (PDT)
Message-ID: <e8a4d4b0-f8ee-2aa7-de23-9afe21cc9915@arm.com>
Date:   Mon, 26 Sep 2022 14:09:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v5 20/20] PCI: dwc: Add Baikal-T1 PCIe controller support
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, willmcvicker@google.com
References: <20220822184701.25246-1-Sergey.Semin@baikalelectronics.ru>
 <20220822184701.25246-21-Sergey.Semin@baikalelectronics.ru>
 <YwzbARMkb/69+l2d@lpieralisi> <63a54a1b-66ba-9739-8217-13f75e602cd5@arm.com>
 <98179709-1ece-61ab-d43a-fc38a4fd3f67@arm.com>
 <20220912002522.arx4vypiv363qcni@mobilestation>
Content-Language: en-GB
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220912002522.arx4vypiv363qcni@mobilestation>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022-09-12 01:25, Serge Semin wrote:
> On Wed, Aug 31, 2022 at 09:54:14AM +0100, Robin Murphy wrote:
>> On 2022-08-31 09:36, Robin Murphy wrote:
>>> On 2022-08-29 16:28, Lorenzo Pieralisi wrote:
>>> [...]
>>>>> +static int bt1_pcie_add_port(struct bt1_pcie *btpci)
>>>>> +{
>>>>> +ï¿½ï¿½ï¿½ struct device *dev = &btpci->pdev->dev;
>>>>> +ï¿½ï¿½ï¿½ int ret;
>>>>> +
>>>>> +ï¿½ï¿½ï¿½ /*
>>>>> +ï¿½ï¿½ï¿½ï¿½ * DW PCIe Root Port controller is equipped with eDMA capable of
>>>>> +ï¿½ï¿½ï¿½ï¿½ * working with the 64-bit memory addresses.
>>>>> +ï¿½ï¿½ï¿½ï¿½ */
>>>>> +ï¿½ï¿½ï¿½ ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
>>>>> +ï¿½ï¿½ï¿½ if (ret)
>>>>> +ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ return ret;
>>>>
>>>> Is this the right place to set the DMA mask for the host controller
>>>> embedded DMA controller (actually, the dev pointer is the _host_
>>>> controller device) ?
>>>>
>>>> How this is going to play when combined with:
>>>>
>>>> https://lore.kernel.org/linux-pci/1e63a581-14ae-b4b5-a5bf-ca8f09c33af6@arm.com
>>>>
>>>> It is getting a bit confusing. I believe the code in the link
>>>> above sets the mask so that through the DMA API we are capable
>>>> of getting an MSI doorbell virtual address whose physical address
>>>> can be addressed by the endpoint; this through the DMA API.
>>>>
>>>> This patch is setting the DMA mask for a different reason, namely
>>>> setting the host controller embedded DMA controller addressing
>>>> capabilities.
>>>>
>>>> AFAICS - both approaches set the mask for the same device - now
>>>> the question is about which one is legitimate and how to handle
>>>> the other.
>>>
>>> Assuming the dw-edma-pcie driver is the relevant one, that already sets
>>> its own masks on its own device, so I also don't see why this is here.
>>
> 
>> Ah, I just found the patch at [1], which further implies that this is indeed
>> completely bogus.
> 
> Really? Elaborate please. What you said in the comment to that patch
> has nothing to do with the change you comment here.

It has everything to do with it; if the other driver did the right 
thing, this change wouldn't even be here. Everything you've said has 
implied that the DMA engine driver cares about the AXI side of the 
bridge, which is represented by the platform device. Thus it should set 
the platform device's DMA mask, and use the platform device for DMA API 
calls, and thus there should be no conflict with the host controller 
driver's use of the PCI device's DMA mask to reserve a DMA address in 
PCI memory space on the other side of the bridge, nor any translation 
across the bridge itself.

Thanks,
Robin.

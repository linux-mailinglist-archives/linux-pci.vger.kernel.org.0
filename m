Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7ABB20F560
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jun 2020 15:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387933AbgF3NE1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Jun 2020 09:04:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6787 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387492AbgF3NE1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Jun 2020 09:04:27 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 27BDADEC1BEF76A390DF;
        Tue, 30 Jun 2020 21:04:24 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.33) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Tue, 30 Jun 2020
 21:04:21 +0800
Subject: Re: [PATCH v2 01/12] ACPI/IORT: Make iort_match_node_callback walk
 the ACPI namespace for NC
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        <iommu@lists.linux-foundation.org>, <linux-acpi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Makarand Pawagi <makarand.pawagi@nxp.com>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-2-lorenzo.pieralisi@arm.com>
 <718cae1f-2f33-f6d9-f278-157300b73116@huawei.com>
 <20200629090551.GA28873@e121166-lin.cambridge.arm.com>
 <765078e7-b3ec-af5d-0405-7834ba0f120a@huawei.com>
 <20200630102454.GA17556@e121166-lin.cambridge.arm.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <4817d766-0437-5356-a0b9-97b111d4cae2@huawei.com>
Date:   Tue, 30 Jun 2020 21:04:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200630102454.GA17556@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.33]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020/6/30 18:24, Lorenzo Pieralisi wrote:
> On Tue, Jun 30, 2020 at 11:06:41AM +0800, Hanjun Guo wrote:
> 
> [...]
> 
>>> For devices that aren't described in the DSDT - IORT translations
>>> are determined by their ACPI parent device. Do you see/Have you
>>> found any issue with this approach ?
>>
>> The spec says "Describes the IO relationships between devices
>> represented in the ACPI namespace.", and in section 3.1.1.3 Named
>> component node, it says:
> 
> PCI devices aren't necessarily described in the ACPI namespace and we
> still use IORT to describe them - through the RC node.
> 
>> "Named component nodes are used to describe devices that are also
>> included in the Differentiated System Description Table (DSDT). See
>> [ACPI]."
>>
>> So from my understanding, the IORT spec for now, can only do ID
>> translations for devices in the DSDT.
> 
> I think you can read this multiple ways but this patch does not
> change this concept. What changes, is applying parent's node IORT
> mapping to child nodes with no associated DSDT nodes, it is the
> same thing we do with PCI and the _DMA method - we could update
> the wording in the specs if that clarifies but I don't think this
> deliberately disregards the specifications.

I agree, but it's better to update the wording of the spec.

> 
>>>> For a platform device, if I use its parent's full path name for
>>>> its named component entry, then it will match, but this will violate
>>>> the IORT spec.
>>>
>>> Can you elaborate on this please I don't get the point you
>>> are making.
>>
>> For example, device A is not described in DSDT so can't represent
>> as a NC node in IORT. Device B can be described in DSDT and it
>> is the parent of device A, so device B can be represented in IORT
>> with memory access properties and node flags with Substream width
>> and Stall supported info.
>>
>> When we trying to translate device A's ID, we reuse all the memory
>> access properties and node flags from its parent (device B), but
>> will it the same?
> 
> I assume so why wouldn't it be ? Why would be describe them in
> a parent-child relationship if that's not how the system looks like
> in HW ?

The point I'm making is that I'm not sure all the memory access and
stall properties are the same for the parent and the device itself.

> 
> Do you have a specific example in mind that we should be aware of ?
> 
>> So the IORT spec don't support this, at least it's pretty vague
>> I think.
> 
> I think that's a matter of wording, it can be updated if it needs be,
> reach out if you see any issue with the current approach please.

If the all the properties for parent and device itself are the same,
I have no strong opinion for this patch, but it's better to update
the wording of the spec as well.

Thanks
Hanjun


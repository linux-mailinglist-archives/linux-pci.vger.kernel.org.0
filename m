Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE20461607
	for <lists+linux-pci@lfdr.de>; Mon, 29 Nov 2021 14:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239343AbhK2NSi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Nov 2021 08:18:38 -0500
Received: from foss.arm.com ([217.140.110.172]:39060 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243526AbhK2NQh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Nov 2021 08:16:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 616131515;
        Mon, 29 Nov 2021 05:13:19 -0800 (PST)
Received: from [10.57.34.182] (unknown [10.57.34.182])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 317153F766;
        Mon, 29 Nov 2021 05:13:15 -0800 (PST)
Message-ID: <76a1b5c1-01c8-bb30-6105-b4073dc23065@arm.com>
Date:   Mon, 29 Nov 2021 13:13:11 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [patch 33/37] iommu/arm-smmu-v3: Use msi_get_virq()
Content-Language: en-GB
To:     Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc:     Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>,
        Stuart Yoder <stuyoder@gmail.com>, linux-pci@vger.kernel.org,
        Ashok Raj <ashok.raj@intel.com>, Marc Zygnier <maz@kernel.org>,
        x86@kernel.org, Sinan Kaya <okaya@kernel.org>,
        iommu@lists.linux-foundation.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Megha Dey <megha.dey@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Tero Kristo <kristo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
References: <20211126224100.303046749@linutronix.de>
 <20211126230525.885757679@linutronix.de>
 <20211129105506.GA22761@willie-the-truck>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211129105506.GA22761@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-11-29 10:55, Will Deacon wrote:
> Hi Thomas,
> 
> On Sat, Nov 27, 2021 at 02:20:59AM +0100, Thomas Gleixner wrote:
>> Let the core code fiddle with the MSI descriptor retrieval.
>>
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> ---
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |   19 +++----------------
>>   1 file changed, 3 insertions(+), 16 deletions(-)
>>
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -3154,7 +3154,6 @@ static void arm_smmu_write_msi_msg(struc
>>   
>>   static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
>>   {
>> -	struct msi_desc *desc;
>>   	int ret, nvec = ARM_SMMU_MAX_MSIS;
>>   	struct device *dev = smmu->dev;
>>   
>> @@ -3182,21 +3181,9 @@ static void arm_smmu_setup_msis(struct a
>>   		return;
>>   	}
>>   
>> -	for_each_msi_entry(desc, dev) {
>> -		switch (desc->msi_index) {
>> -		case EVTQ_MSI_INDEX:
>> -			smmu->evtq.q.irq = desc->irq;
>> -			break;
>> -		case GERROR_MSI_INDEX:
>> -			smmu->gerr_irq = desc->irq;
>> -			break;
>> -		case PRIQ_MSI_INDEX:
>> -			smmu->priq.q.irq = desc->irq;
>> -			break;
>> -		default:	/* Unknown */
>> -			continue;
>> -		}
>> -	}
>> +	smmu->evtq.q.irq = msi_get_virq(dev, EVTQ_MSI_INDEX);
>> +	smmu->gerr_irq = msi_get_virq(dev, GERROR_MSI_INDEX);
>> +	smmu->priq.q.irq = msi_get_virq(dev, PRIQ_MSI_INDEX);
> 
> Prviously, if retrieval of the MSI failed then we'd fall back to wired
> interrupts. Now, I think we'll clobber the interrupt with 0 instead. Can
> we make the assignments to smmu->*irq here conditional on the MSI being
> valid, please?

I was just looking at that too, but reached the conclusion that it's 
probably OK, since consumption of this value later is gated on 
ARM_SMMU_FEAT_PRI, so the fact that it changes from 0 to an error value 
in the absence of PRI should make no practical difference. If we don't 
have MSIs at all, we'd presumably still fail earlier either at the 
dev->msi_domain check or upon trying to allocate the vectors, so we'll 
still fall back to any previously-set wired values before getting here. 
The only remaining case is if we've *successfully* allocated the 
expected number of vectors yet are then somehow unable to retrieve one 
or more of them - presumably the system has to be massively borked for 
that to happen, at which point do we really want to bother trying to 
reason about anything?

Robin.

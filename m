Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF39F738353
	for <lists+linux-pci@lfdr.de>; Wed, 21 Jun 2023 14:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbjFULay (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Jun 2023 07:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbjFULax (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Jun 2023 07:30:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EDC01E57;
        Wed, 21 Jun 2023 04:30:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7324A1063;
        Wed, 21 Jun 2023 04:31:35 -0700 (PDT)
Received: from [10.57.35.147] (unknown [10.57.35.147])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 410803F663;
        Wed, 21 Jun 2023 04:30:50 -0700 (PDT)
Message-ID: <d35d86c2-76ae-98e9-5c27-c0284c52e15b@arm.com>
Date:   Wed, 21 Jun 2023 12:30:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Question about reserved_regions w/ Intel IOMMU
To:     Alexander Duyck <alexander.duyck@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <b24a6c7b-27fc-41c0-5c82-15696b4a7dc1@arm.com>
 <ZIiRK2Dzl2/9Jqle@ziepe.ca>
 <BN9PR11MB52765C24405D2475CF3CBEBE8C58A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZIxTmGU4a5dniEY3@nvidia.com>
 <CAKgT0UfmdOOPSD5YvpHnh1A02URn9zxVLbyXJM_67On7xojLcA@mail.gmail.com>
 <520e2be4-726f-c680-c010-a308cdddbae0@arm.com> <ZIyxFpzh3WG+ifws@nvidia.com>
 <90823b33-1f44-8789-9a38-282407fd9f15@arm.com> <ZJBf5DP60prFH5R2@nvidia.com>
 <CAKgT0UccM=_D-gJdzjqeUmRZWnSHVaUABjgQBEamLYauE8WTCA@mail.gmail.com>
 <ZJHaE2+XOgQj1q2k@nvidia.com>
 <CAKgT0UdbjDDkwV_uUGCTONGj2Xw_+Tb6J5enAX_+Wq0eKt=nGA@mail.gmail.com>
Content-Language: en-GB
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CAKgT0UdbjDDkwV_uUGCTONGj2Xw_+Tb6J5enAX_+Wq0eKt=nGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2023-06-20 18:47, Alexander Duyck wrote:
> On Tue, Jun 20, 2023 at 9:55 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>>
>> On Tue, Jun 20, 2023 at 07:57:57AM -0700, Alexander Duyck wrote:
>>
>>> I think this may have gone off down a rathole as my original question
>>> wasn't anything about adding extra reserved regions. It was about
>>> exposing what the IOVA is already reserving so it could be user
>>> visible.
>>
>> Your question points out that dma-iommu.c uses a different set of
>> reserved regions than everything else, and its set is closer to
>> functionally correct.
>>
>> IMHO the resolution to what you are talking about is not to add more
>> debugging to dma-iommu but to make the set of reserved regions
>> consistently correct for everyone, which will make them viewable in
>> sysfs.
> 
> Okay, that makes sense to me, and I agree. If we had a consistent set
> of reserved regions then it would make it easier to understand.

It would also be wrong, unfortunately, because it's conflating multiple 
different things (there are overlapping notions of "reserve" at play 
here...). IOMMU API reserved regions are specific things that the IOMMU 
driver knows are special and all IOMMU domain users definitely need to 
be aware of. iommu-dma is merely one of those users; it is another layer 
on top of the API which manages its own IOVA space how it sees fit, just 
like VFIO or other IOMMU-aware drivers. It honours those reserved 
regions (via iommu_group_create_direct_mappings()), but it also carves 
out plenty of IOVA space which is probably perfectly usable - some of 
which is related to possible upstream bus constraints, to save the 
hassle of checking; some purely for its own convenience, like the page 
at IOVA 0 - but it still *doesn't* carve out more IOVA regions which are 
also unusable overall due to other upstream bus or endpoint constraints, 
since those are handled dynamically in its allocator instead (dma_mask, 
bus_dma_limit etc.)

> If
> nothing else my request would be to expose the iova reserved regions
> and then most likely the other ones could be deprecated since they
> seem to all be consolidated in the IOVA anyway.

FWIW there's no upstream provision for debugging iommu-dma from 
userspace since it's not something that anyone other than me has ever 
had any apparent need to do, and you can get an idea of how long it's 
been since even I thought about that from when I seem to have given up 
rebasing my local patches for it[1] :)

Thanks,
Robin.

[1] https://gitlab.arm.com/linux-arm/linux-rm/-/commits/iommu/misc/

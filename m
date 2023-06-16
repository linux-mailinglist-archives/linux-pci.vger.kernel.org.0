Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E299733632
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jun 2023 18:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345632AbjFPQfk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Jun 2023 12:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345076AbjFPQfR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Jun 2023 12:35:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 510F030E7;
        Fri, 16 Jun 2023 09:35:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1AC941FB;
        Fri, 16 Jun 2023 09:35:46 -0700 (PDT)
Received: from [10.57.85.251] (unknown [10.57.85.251])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC6DD3F663;
        Fri, 16 Jun 2023 09:35:00 -0700 (PDT)
Message-ID: <520e2be4-726f-c680-c010-a308cdddbae0@arm.com>
Date:   Fri, 16 Jun 2023 17:34:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Question about reserved_regions w/ Intel IOMMU
Content-Language: en-GB
To:     Alexander Duyck <alexander.duyck@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <CAKgT0UezciLjHacOx372+v8MZkDf22D5Thn82n-07xxKy_0FTQ@mail.gmail.com>
 <CAKgT0UfMeVOz6AOqSvVvzpsedGDiXCNQrjM+4KDv7qJJ1orpsw@mail.gmail.com>
 <a1cff65b-b390-3872-25b5-dd6bbfb3524c@linux.intel.com>
 <b24a6c7b-27fc-41c0-5c82-15696b4a7dc1@arm.com> <ZIiRK2Dzl2/9Jqle@ziepe.ca>
 <BN9PR11MB52765C24405D2475CF3CBEBE8C58A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZIxTmGU4a5dniEY3@nvidia.com>
 <CAKgT0UfmdOOPSD5YvpHnh1A02URn9zxVLbyXJM_67On7xojLcA@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CAKgT0UfmdOOPSD5YvpHnh1A02URn9zxVLbyXJM_67On7xojLcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2023-06-16 16:27, Alexander Duyck wrote:
> On Fri, Jun 16, 2023 at 5:20 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>>
>> On Fri, Jun 16, 2023 at 08:39:46AM +0000, Tian, Kevin wrote:
>>> +Alex
>>>
>>>> From: Jason Gunthorpe <jgg@nvidia.com>
>>>> Sent: Tuesday, June 13, 2023 11:54 PM
>>>>
>>>> On Thu, Jun 08, 2023 at 04:28:24PM +0100, Robin Murphy wrote:
>>>>
>>>>>> The iova_reserve_pci_windows() you've seen is for kernel DMA interfaces
>>>>>> which is not related to peer-to-peer accesses.
>>>>>
>>>>> Right, in general the IOMMU driver cannot be held responsible for
>>>> whatever
>>>>> might happen upstream of the IOMMU input.
>>>>
>>>> The driver yes, but..
>>>>
>>>>> The DMA layer carves PCI windows out of its IOVA space
>>>>> unconditionally because we know that they *might* be problematic,
>>>>> and we don't have any specific constraints on our IOVA layout so
>>>>> it's no big deal to just sacrifice some space for simplicity.
>>>>
>>>> This is a problem for everything using UNMANAGED domains. If the iommu
>>>> API user picks an IOVA it should be able to expect it to work. If the
>>>> intereconnect fails to allow it to work then this has to be discovered
>>>> otherwise UNAMANGED domains are not usable at all.
>>>>
>>>> Eg vfio and iommufd are also in trouble on these configurations.
>>>>
>>>
>>> If those PCI windows are problematic e.g. due to ACS they belong to
>>> a single iommu group. If a vfio user opens all the devices in that group
>>> then it can discover and reserve those windows in its IOVA space.
>>
>> How? We don't even exclude the single device's BAR if there is no ACS?
> 
> The issue here was a defective ACS on a PCIe switch.
> 
>>> The problem is that the user may not open all the devices then
>>> currently there is no way for it to know the windows on those
>>> unopened devices.
>>>
>>> Curious why nobody complains about this gap before this thread...
>>
>> Probably because it only matters if you have a real PCIe switch in the
>> system, which is pretty rare.
> 
> So just FYI I am pretty sure we have a partitioned PCIe switch that
> has FW issues. Specifically it doesn't seem to be honoring the
> Redirect Request bit so what is happening is that we are seeing
> requests that are supposed to be going to the root complex/IOMMU
> getting redirected to an NVMe device that was on the same physical
> PCIe switch. We are in the process of getting that sorted out now and
> are using the forcedac option in the meantime to keep the IOMMU out of
> the 32b address space that was causing the issue.
> 
> The reason for my original request is more about the user experience
> of trying to figure out what is reserved and what isn't. It seems like
> the IOVA will have reservations that are not visible to the end user.
> So when I go looking through the reserved_regions in sysfs it just
> lists the MSI regions that are reserved, and maybe some regions such
> as the memory for USB. while in reality we may be reserving IOVA
> regions in iova_reserve_pci_windows that will not be exposed without
> having to add probes or adding some printk debugging.

lspci -vvv seems to have no problem telling me about what PCI memory 
space is assigned where, even as an unprivileged user, so surely it's 
available to any VFIO user too?

It is not necessarily useful for eeh IOMMU layer to claim to userspace 
that an entire window is unusable if in fact there's nothing in there 
that would be treated as a P2P address so it's actually fine. As I say, 
iommu-dma can make that assumption for itself because iommu-dma doesn't 
need to maintain any particular address space layout, but it could be 
overly restrictive for a userspace process or VMM which does.

If the system has working ACS configured correctly, then this issue 
should be moot; if it doesn't, then a VFIO user is going to get a whole 
group of peer devices if they're getting anything at all, so it doesn't 
seem entirely unreasonable to leave it up to them to check that all 
those devices' resources play well with their expected memory map. And 
the particular case of a system which claims to have working ACS but 
doesn't, doesn't really seem to be something that can or should be 
worked around from userspace; if that switch can't be fixed, it probably 
wants an ACS quirk adding in the kernel.

Thanks,
Robin.

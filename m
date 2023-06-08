Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775937286C7
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jun 2023 20:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjFHSCR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Jun 2023 14:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbjFHSCQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Jun 2023 14:02:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BABA81734;
        Thu,  8 Jun 2023 11:02:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81D5F1FB;
        Thu,  8 Jun 2023 11:02:57 -0700 (PDT)
Received: from [10.57.83.198] (unknown [10.57.83.198])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C8F503F587;
        Thu,  8 Jun 2023 11:02:10 -0700 (PDT)
Message-ID: <7f1797b1-cd50-3c8d-59ff-8ce82ef1adb4@arm.com>
Date:   Thu, 8 Jun 2023 19:02:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: Question about reserved_regions w/ Intel IOMMU
Content-Language: en-GB
To:     Alexander Duyck <alexander.duyck@gmail.com>,
        Ashok Raj <ashok_raj@linux.intel.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>, iommu@lists.linux.dev,
        Ashok Raj <ashok.raj@intel.com>
References: <CAKgT0UezciLjHacOx372+v8MZkDf22D5Thn82n-07xxKy_0FTQ@mail.gmail.com>
 <CAKgT0UfMeVOz6AOqSvVvzpsedGDiXCNQrjM+4KDv7qJJ1orpsw@mail.gmail.com>
 <a1cff65b-b390-3872-25b5-dd6bbfb3524c@linux.intel.com>
 <CAKgT0UcE5bUe7ChytSyUWEkyqdwnNR1k_rcfyykPPWJ=ZzsdRg@mail.gmail.com>
 <ZIH1/e2OcCuD7DEi@araj-dh-work>
 <CAKgT0UfTzExYZGNCEXCJaS7huWDxwoC3Z_2JCzJHAgr9Qyxmsg@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CAKgT0UfTzExYZGNCEXCJaS7huWDxwoC3Z_2JCzJHAgr9Qyxmsg@mail.gmail.com>
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

On 2023-06-08 18:10, Alexander Duyck wrote:
> On Thu, Jun 8, 2023 at 8:40 AM Ashok Raj <ashok_raj@linux.intel.com> wrote:
>>
>> On Thu, Jun 08, 2023 at 07:33:31AM -0700, Alexander Duyck wrote:
>>> On Wed, Jun 7, 2023 at 8:05 PM Baolu Lu <baolu.lu@linux.intel.com> wrote:
>>>>
>>>> On 6/8/23 7:03 AM, Alexander Duyck wrote:
>>>>> On Wed, Jun 7, 2023 at 3:40 PM Alexander Duyck
>>>>> <alexander.duyck@gmail.com> wrote:
>>>>>>
>>>>>> I am running into a DMA issue that appears to be a conflict between
>>>>>> ACS and IOMMU. As per the documentation I can find, the IOMMU is
>>>>>> supposed to create reserved regions for MSI and the memory window
>>>>>> behind the root port. However looking at reserved_regions I am not
>>>>>> seeing that. I only see the reservation for the MSI.
>>>>>>
>>>>>> So for example with an enabled NIC and iommu enabled w/o passthru I am seeing:
>>>>>> # cat /sys/bus/pci/devices/0000\:83\:00.0/iommu_group/reserved_regions
>>>>>> 0x00000000fee00000 0x00000000feefffff msi
>>>>>>
>>>>>> Shouldn't there also be a memory window for the region behind the root
>>>>>> port to prevent any possible peer-to-peer access?
>>>>>
>>>>> Since the iommu portion of the email bounced I figured I would fix
>>>>> that and provide some additional info.
>>>>>
>>>>> I added some instrumentation to the kernel to dump the resources found
>>>>> in iova_reserve_pci_windows. From what I can tell it is finding the
>>>>> correct resources for the Memory and Prefetchable regions behind the
>>>>> root port. It seems to be calling reserve_iova which is successfully
>>>>> allocating an iova to reserve the region.
>>>>>
>>>>> However still no luck on why it isn't showing up in reserved_regions.
>>>>
>>>> Perhaps I can ask the opposite question, why it should show up in
>>>> reserve_regions? Why does the iommu subsystem block any possible peer-
>>>> to-peer DMA access? Isn't that a decision of the device driver.
>>>>
>>>> The iova_reserve_pci_windows() you've seen is for kernel DMA interfaces
>>>> which is not related to peer-to-peer accesses.
>>>
>>> The problem is if the IOVA overlaps with the physical addresses of
>>> other devices that can be routed to via ACS redirect. As such if ACS
>>> redirect is enabled a host IOVA could be directed to another device on
>>> the switch instead. To prevent that we need to reserve those addresses
>>> to avoid address space collisions.
> 
> Our test case is just to perform DMA to/from the host on one device on
> a switch and what we are seeing is that when we hit an IOVA that
> matches up with the physical address of the neighboring devices BAR0
> then we are seeing an AER followed by a hot reset.
> 
>> Any untranslated address from a device must be forwarded to the IOMMU when
>> ACS is enabled correct?I guess if you want true p2p, then you would need
>> to map so that the hpa turns into the peer address.. but its always a round
>> trip to IOMMU.
> 
> This assumes all parts are doing the Request Redirect "correctly". In
> our case there is a PCIe switch we are trying to debug and we have a
> few working theories. One concern I have is that the switch may be
> throwing an ACS violation for us using an address that matches a
> neighboring device instead of redirecting it to the upstream port. If
> we pull the switch and just run on the root complex the issue seems to
> be resolved so I started poking into the code which led me to the
> documentation pointing out what is supposed to be reserved based on
> the root complex and MSI regions.
> 
> As a part of going down that rabbit hole I realized that the
> reserved_regions seems to only list the MSI reservation. However after
> digging a bit deeper it seems like there is code to reserve the memory
> behind the root complex in the IOVA but it doesn't look like that is
> visible anywhere and is the piece I am currently trying to sort out.
> What I am working on is trying to figure out if the system that is
> failing is actually reserving that memory region in the IOVA, or if
> that is somehow not happening in our test setup.

How old's the kernel? Before 5.11, intel-iommu wasn't hooked up to 
iommu-dma so didn't do quite the same thing - it only reserved whatever 
specific PCI memory resources existed at boot, rather than the whole 
window as iommu-dma does. Either way, ftrace on reserve_iova() (or just 
whack a print in there) should suffice to see what's happened.

Robin.

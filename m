Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80D37283BF
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jun 2023 17:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236585AbjFHP2r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Jun 2023 11:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235704AbjFHP2p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Jun 2023 11:28:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E3CAF2D70;
        Thu,  8 Jun 2023 08:28:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32679AB6;
        Thu,  8 Jun 2023 08:29:22 -0700 (PDT)
Received: from [10.57.83.198] (unknown [10.57.83.198])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB8B53F6C4;
        Thu,  8 Jun 2023 08:28:35 -0700 (PDT)
Message-ID: <b24a6c7b-27fc-41c0-5c82-15696b4a7dc1@arm.com>
Date:   Thu, 8 Jun 2023 16:28:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: Question about reserved_regions w/ Intel IOMMU
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>, iommu@lists.linux.dev
References: <CAKgT0UezciLjHacOx372+v8MZkDf22D5Thn82n-07xxKy_0FTQ@mail.gmail.com>
 <CAKgT0UfMeVOz6AOqSvVvzpsedGDiXCNQrjM+4KDv7qJJ1orpsw@mail.gmail.com>
 <a1cff65b-b390-3872-25b5-dd6bbfb3524c@linux.intel.com>
Content-Language: en-GB
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <a1cff65b-b390-3872-25b5-dd6bbfb3524c@linux.intel.com>
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

On 2023-06-08 04:03, Baolu Lu wrote:
> On 6/8/23 7:03 AM, Alexander Duyck wrote:
>> On Wed, Jun 7, 2023 at 3:40 PM Alexander Duyck
>> <alexander.duyck@gmail.com> wrote:
>>>
>>> I am running into a DMA issue that appears to be a conflict between
>>> ACS and IOMMU. As per the documentation I can find, the IOMMU is
>>> supposed to create reserved regions for MSI and the memory window
>>> behind the root port. However looking at reserved_regions I am not
>>> seeing that. I only see the reservation for the MSI.
>>>
>>> So for example with an enabled NIC and iommu enabled w/o passthru I 
>>> am seeing:
>>> # cat /sys/bus/pci/devices/0000\:83\:00.0/iommu_group/reserved_regions
>>> 0x00000000fee00000 0x00000000feefffff msi
>>>
>>> Shouldn't there also be a memory window for the region behind the root
>>> port to prevent any possible peer-to-peer access?
>>
>> Since the iommu portion of the email bounced I figured I would fix
>> that and provide some additional info.
>>
>> I added some instrumentation to the kernel to dump the resources found
>> in iova_reserve_pci_windows. From what I can tell it is finding the
>> correct resources for the Memory and Prefetchable regions behind the
>> root port. It seems to be calling reserve_iova which is successfully
>> allocating an iova to reserve the region.
>>
>> However still no luck on why it isn't showing up in reserved_regions.
> 
> Perhaps I can ask the opposite question, why it should show up in
> reserve_regions? Why does the iommu subsystem block any possible peer-
> to-peer DMA access? Isn't that a decision of the device driver.
> 
> The iova_reserve_pci_windows() you've seen is for kernel DMA interfaces
> which is not related to peer-to-peer accesses.

Right, in general the IOMMU driver cannot be held responsible for 
whatever might happen upstream of the IOMMU input. The DMA layer carves 
PCI windows out of its IOVA space unconditionally because we know that 
they *might* be problematic, and we don't have any specific constraints 
on our IOVA layout so it's no big deal to just sacrifice some space for 
simplicity. We don't want to have to go digging any further into 
bus-specific code to reason about whether the right ACS capabilities are 
present and enabled everywhere to prevent direct P2P or not. Other 
use-cases may have different requirements, though, so it's up to them 
what they want to do.

It's conceptually pretty much the same as the case where the device (or 
indeed a PCI host bridge or other interconnect segment in-between) has a 
constrained DMA address width - the device may not be able to access all 
of the address space that the IOMMU provides, but the IOMMU itself can't 
tell you that.

Thanks,
Robin.

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239994DDB46
	for <lists+linux-pci@lfdr.de>; Fri, 18 Mar 2022 15:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237070AbiCROJn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Mar 2022 10:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237068AbiCROJn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Mar 2022 10:09:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E2CF31FCC6;
        Fri, 18 Mar 2022 07:08:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BFFA1515;
        Fri, 18 Mar 2022 07:08:23 -0700 (PDT)
Received: from [10.57.43.230] (unknown [10.57.43.230])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E7853F7D7;
        Fri, 18 Mar 2022 07:08:21 -0700 (PDT)
Message-ID: <78fc0426-c22a-ec62-f92b-0019bea5947e@arm.com>
Date:   Fri, 18 Mar 2022 14:08:16 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] thunderbolt: Make iommu_dma_protection more accurate
Content-Language: en-GB
To:     "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
Cc:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
        "michael.jamet@intel.com" <michael.jamet@intel.com>,
        "YehezkelShB@gmail.com" <YehezkelShB@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <2d01fa50c2650c730b0244929097737918e302e7.1647533152.git.robin.murphy@arm.com>
 <BL1PR12MB515783C0F998169D49D92A55E2129@BL1PR12MB5157.namprd12.prod.outlook.com>
 <BL1PR12MB51573F55B3C2B3922BAAA7F1E2129@BL1PR12MB5157.namprd12.prod.outlook.com>
 <YjRvMk1kcbMwJvx+@lahna> <65207fdf-c4ab-5165-dbda-8ab55b51adb7@arm.com>
 <YjSCWaq7Ej/2iJPp@lahna>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YjSCWaq7Ej/2iJPp@lahna>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022-03-18 13:25, mika.westerberg@linux.intel.com wrote:
> Hi Robin,
> 
> On Fri, Mar 18, 2022 at 12:01:42PM +0000, Robin Murphy wrote:
>>> This adds quite a lot code and complexity, and honestly I would like to
>>> keep it as simple as possible (and this is not enough because we need to
>>> make sure the DMAR bit is there so that none of the possible connected
>>> devices were able to overwrite our memory already).
>>
>> Shall we forget the standalone sibling check and just make the
>> pdev->untrusted check directly in tb_acpi_add_link() then?
> 
> I think we should leave tb_acpi_add_link() untouched if possible ;-)
> This is because it is used to add the device links from firmware
> description that we need for proper power management of the tunneled
> devices. It has little to do with the identification of the external
> facing DMA-capable PCIe ports.
> 
> Furthermore these links only exists in USB4 software connection manager
> systems so we do not have those in the existing Thunderbolt 3/4 systems
> that use firmware based connection manager (pretty much all out there).
> 
>> On reflection I guess the DMAR bit makes iommu_dma_protection
>> functionally dependent on ACPI already, so we don't actually lose
>> anything (and anyone can come back and revisit firmware-agnostic
>> methods later if a need appears).
> 
> I agree.

OK, so do we have any realistic options for identifying the correct PCI 
devices, if USB4 PCIe adapters might be anywhere relative to their 
associated NHI? Short of maintaining a list of known IDs, the only 
thought I have left is that if we walk the whole PCI segment looking 
specifically for hotplug-capable Gen1 ports, any system modern enough to 
have Thunderbolt is *probably* not going to have any real PCIe Gen1 
hotplug slots, so maybe false negatives might be tolerable, but it still 
feels like a bit of a sketchy heuristic.

I suppose we could just look to see if any device anywhere is marked as 
external-facing, and hope that if firmware's done that much then it's 
done everything right. That's still at least slightly better than what 
we have today, but AFAICS still carries significant risk of a false 
positive for an add-in card that firmware didn't recognise.

I'm satisfied that we've come round to the right conclusion on the DMAR 
opt-in - I'm in the middle or writing up patches for that now - but even 
Microsoft's spec gives that as a separate requirement from the flagging 
of external ports, with both being necessary for Kernel DMA Protection.

Robin.

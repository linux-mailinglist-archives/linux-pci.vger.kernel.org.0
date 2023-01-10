Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A986B663891
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jan 2023 06:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjAJF2k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Jan 2023 00:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjAJF2i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jan 2023 00:28:38 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E481B13DD8;
        Mon,  9 Jan 2023 21:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673328516; x=1704864516;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OStWdT2b7reMp2lZS5TUOHeWnuoo/ewUSJYqEeNwDPw=;
  b=M7okwL7fi6Uqw/WYc1eU5aXcXpE1dKYlhH6ZHPx40oam2bLJ71M9hZSI
   eBFDJjxKNOXErHuK2IjvoKQMFIAJ6N7+ilmy3sH5PfM4+fz4ONUKGqFE5
   jrBUYokjiY5jvIMbecFNzq3bVcvkFl9h/3+AduCoISRIGW2PwD7HOjeBS
   el09K9pk4okdhe7PGL4ydvEquPWXQE3p0xsc3B0XTayTDdtcMvN1JdkrE
   Dt/wU59VllscoBE0hkLVa504DAYF0tob4txF0eG/qvH8X5l4aqV4h4ttq
   TLWHau7hXkLDAyig3/qorWlFJVdj0zd+VsHLl2ArYvg/kGenaPdsONixa
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="324307217"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="324307217"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 21:28:36 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="720200800"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="720200800"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.212.165]) ([10.254.212.165])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 21:28:33 -0800
Message-ID: <ae78b813-34f2-da61-e6c6-f4985c5b6641@linux.intel.com>
Date:   Tue, 10 Jan 2023 13:28:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc:     baolu.lu@linux.intel.com, Vasant Hegde <vasant.hegde@amd.com>,
        Matt Fagnani <matt.fagnani@bell.net>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Joerg Roedel <jroedel@suse.de>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: =?UTF-8?Q?Re=3a_=5bregression=2c_bisected=2c_pci/iommu=5d_Bug=c2=a0?=
 =?UTF-8?Q?216865_-_Black_screen_when_amdgpu_started_during_6=2e2-rc1_boot_w?=
 =?UTF-8?Q?ith_AMD_IOMMU_enabled?=
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <15d0f9ff-2a56-b3e9-5b45-e6b23300ae3b@leemhuis.info>
 <5aa0e698-f715-0481-36e5-46505024ebc1@bell.net>
 <aea57c5f-2d20-c589-ad44-a63f1133a3db@linux.intel.com>
 <157c4ca4-370a-5d7e-fe32-c64d934f6979@amd.com>
 <223ee6d6-70ea-1d53-8bc2-2d22201d8dde@bell.net>
 <6fff9d10-f77f-e55a-9020-8a1bd34cf508@amd.com> <Y7gs0zYKp/VXACBi@nvidia.com>
 <bb865b8f-6f8f-769a-6364-d46b45caca85@linux.intel.com>
 <Y7wZ+SvT455HS2b6@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Y7wZ+SvT455HS2b6@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2023/1/9 21:43, Jason Gunthorpe wrote:
> On Sat, Jan 07, 2023 at 10:44:46AM +0800, Baolu Lu wrote:
>> On 1/6/2023 10:14 PM, Jason Gunthorpe wrote:
>>> On Thu, Jan 05, 2023 at 03:57:28PM +0530, Vasant Hegde wrote:
>>>> Matt,
>>>>
>>>> On 1/5/2023 6:39 AM, Matt Fagnani wrote:
>>>>> I built 6.2-rc2 with the patch applied. The same black screen problem happened
>>>>> with 6.2-rc2 with the patch. I tried to use early kdump with 6.2-rc2 with the
>>>>> patch twice by panicking the kernel with sysrq+alt+c after the black screen
>>>>> happened. The system rebooted after about 10-20 seconds both times, but no kdump
>>>>> and dmesg files were saved in /var/crash. I'm attaching the lspci -vvv output as
>>>>> requested.
>>>>>
>>>>
>>>> Thanks for testing. As mentioned earlier I was not expecting this patch to fix
>>>> the black screen issue. It should fix kernel warnings and IOMMU page fault
>>>> related call traces. By any chance do you have the kernel boot logs?
>>>>
>>>>
>>>> @Baolu,
>>>>     Looking into lspci output, it doesn't list ACS feature for Graphics card. So
>>>> with your fix it didn't enable PASID and hence it failed to boot.
>>>
>>> The ACS checks being done are feature of the path not the end point or
>>> root port.
>>>
>>> If we are expecting ACS on the end port then it is just a bug in how
>>> the test was written.. The test should be a NOP because there are no
>>> switches in this topology.
>>>
>>> Looking at it, this seems to just be because pci_enable_pasid is
>>> calling pci_acs_path_enabled wrong, the only other user is here:
>>>
>>> 	for (bus = pdev->bus; !pci_is_root_bus(bus); bus = bus->parent) {
>>> 		if (!bus->self)
>>> 			continue;
>>>
>>> 		if (pci_acs_path_enabled(bus->self, NULL, REQ_ACS_FLAGS))
>>> 			break;
>>>
>>> 		pdev = bus->self;
>>>
>>> 		group = iommu_group_get(&pdev->dev);
>>> 		if (group)
>>> 			return group;
>>> 	}
>>>
>>> And notice it is calling it on pdev->bus not on pdev itself which
>>> naturally excludes the end point from the ACS validation.
>>>
>>> So try something like:
>>>
>>> 	if (!pci_acs_path_enabled(pdev->bus->self, NULL, PCI_ACS_RR | PCI_ACS_UF))
>>>
>>> (and probably need to check for null ?)
>>
>> Yeah! This really is a misuse of pci_acs_path_enabled().
>>
>> But if @pdev is an endpoint of a multiple function device, perhaps we
>> still need to check acs on it?
> 
> Ah, I don't know anything about what this means from a spec
> perspective.
> 
> Certainly if a function can internalize MMIO and loop it back to
> another function then it surely is not OK for PASID either, nor should
> those functions be in different iommu groups.
> 
> So, either this never happens for some spec reason, or the test in the
> iommu code forming groups is incorrect.

The pci_device_group() path handles this like below:

/*
  * For multifunction devices which are not isolated from each other, find
  * all the other non-isolated functions and look for existing groups.  For
  * each function, we also need to look for aliases to or from other devices
  * that may already have a group.
  */
static struct iommu_group *get_pci_function_alias_group(struct pci_dev 
*pdev,
                                                         unsigned long 
*devfns)
{
         struct pci_dev *tmp = NULL;
         struct iommu_group *group;

         if (!pdev->multifunction || pci_acs_enabled(pdev, REQ_ACS_FLAGS))
                 return NULL;

It seems that all devices of an MFD shares a single iommu group if
there lacks ACS control.

--
Best regards,
baolu

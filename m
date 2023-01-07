Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A923660C02
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jan 2023 03:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjAGCow (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Jan 2023 21:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjAGCov (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Jan 2023 21:44:51 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFD684BFC;
        Fri,  6 Jan 2023 18:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673059490; x=1704595490;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=G0fbwXW0MolWEJ1yoKtJ5qcnQjpT3neE3ClvtGEJC38=;
  b=F/JsXysuwQcxGX0ceSbWWtOqTBIIwouupnC+dOB8MmZH06RDqN0/q/Li
   83vAJaCMsViV6LTqne0m6yoKjQQjuWbfW+iwLBen6v+nzIJXE5VCI89DY
   4KDwaHoYyv3qF+Ezqo1TRdw98mwEyVdmuKIVdQ/Yb7fwHtyje8rJdOW4l
   O6SCFYh0fgIqcA5jLR+u8AWKF7LwBc0q1Nn4ceL0zpQRDNvPpO9rYnQV9
   Qsf/lBQadyokMOMbwxLb7aFnd49QFDLERioVFLI+a64lZS8fc5ndvNAdn
   kBFf0wlJaRlxUYVp0k/9yrGkItwZMQnn0v2MltZN0IpjFyY6E/exi9XwN
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="322678315"
X-IronPort-AV: E=Sophos;i="5.96,307,1665471600"; 
   d="scan'208";a="322678315"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 18:44:50 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="901474463"
X-IronPort-AV: E=Sophos;i="5.96,307,1665471600"; 
   d="scan'208";a="901474463"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.209.158]) ([10.254.209.158])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 18:44:48 -0800
Message-ID: <bb865b8f-6f8f-769a-6364-d46b45caca85@linux.intel.com>
Date:   Sat, 7 Jan 2023 10:44:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: =?UTF-8?Q?Re=3a_=5bregression=2c_bisected=2c_pci/iommu=5d_Bug=c2=a0?=
 =?UTF-8?Q?216865_-_Black_screen_when_amdgpu_started_during_6=2e2-rc1_boot_w?=
 =?UTF-8?Q?ith_AMD_IOMMU_enabled?=
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Vasant Hegde <vasant.hegde@amd.com>
Cc:     Matt Fagnani <matt.fagnani@bell.net>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Joerg Roedel <jroedel@suse.de>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <15d0f9ff-2a56-b3e9-5b45-e6b23300ae3b@leemhuis.info>
 <5aa0e698-f715-0481-36e5-46505024ebc1@bell.net>
 <aea57c5f-2d20-c589-ad44-a63f1133a3db@linux.intel.com>
 <157c4ca4-370a-5d7e-fe32-c64d934f6979@amd.com>
 <223ee6d6-70ea-1d53-8bc2-2d22201d8dde@bell.net>
 <6fff9d10-f77f-e55a-9020-8a1bd34cf508@amd.com> <Y7gs0zYKp/VXACBi@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Y7gs0zYKp/VXACBi@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/6/2023 10:14 PM, Jason Gunthorpe wrote:
> On Thu, Jan 05, 2023 at 03:57:28PM +0530, Vasant Hegde wrote:
>> Matt,
>>
>> On 1/5/2023 6:39 AM, Matt Fagnani wrote:
>>> I built 6.2-rc2 with the patch applied. The same black screen problem happened
>>> with 6.2-rc2 with the patch. I tried to use early kdump with 6.2-rc2 with the
>>> patch twice by panicking the kernel with sysrq+alt+c after the black screen
>>> happened. The system rebooted after about 10-20 seconds both times, but no kdump
>>> and dmesg files were saved in /var/crash. I'm attaching the lspci -vvv output as
>>> requested.
>>>
>>
>> Thanks for testing. As mentioned earlier I was not expecting this patch to fix
>> the black screen issue. It should fix kernel warnings and IOMMU page fault
>> related call traces. By any chance do you have the kernel boot logs?
>>
>>
>> @Baolu,
>>    Looking into lspci output, it doesn't list ACS feature for Graphics card. So
>> with your fix it didn't enable PASID and hence it failed to boot.
> 
> The ACS checks being done are feature of the path not the end point or
> root port.
> 
> If we are expecting ACS on the end port then it is just a bug in how
> the test was written.. The test should be a NOP because there are no
> switches in this topology.
> 
> Looking at it, this seems to just be because pci_enable_pasid is
> calling pci_acs_path_enabled wrong, the only other user is here:
> 
> 	for (bus = pdev->bus; !pci_is_root_bus(bus); bus = bus->parent) {
> 		if (!bus->self)
> 			continue;
> 
> 		if (pci_acs_path_enabled(bus->self, NULL, REQ_ACS_FLAGS))
> 			break;
> 
> 		pdev = bus->self;
> 
> 		group = iommu_group_get(&pdev->dev);
> 		if (group)
> 			return group;
> 	}
> 
> And notice it is calling it on pdev->bus not on pdev itself which
> naturally excludes the end point from the ACS validation.
> 
> So try something like:
> 
> 	if (!pci_acs_path_enabled(pdev->bus->self, NULL, PCI_ACS_RR | PCI_ACS_UF))
> 
> (and probably need to check for null ?)

Yeah! This really is a misuse of pci_acs_path_enabled().

But if @pdev is an endpoint of a multiple function device, perhaps we
still need to check acs on it?

--
Best regards,
baolu


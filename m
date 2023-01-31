Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32F5682D0E
	for <lists+linux-pci@lfdr.de>; Tue, 31 Jan 2023 13:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjAaM4m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Jan 2023 07:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjAaM4U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Jan 2023 07:56:20 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003B94B8B3;
        Tue, 31 Jan 2023 04:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675169779; x=1706705779;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=I8q8o/ZI/4HN/pJZcZMoEMEToapOPQxN7jKgDXKYvQI=;
  b=SOSkIK12lhHCJHWMnTTSNwlQBlO+tQTHDTmESjP6xvhSzQdUU4AjTGsj
   l/kENCWCytaSYnNcBfVUdF9kz9NxR0FtFpbBf++IKBoj/Z8YQuewGvi5A
   oLfSCW6InqVmxv7x9niWocvLA3eSpkYJZ9SxX/+muPaNVK2AVkuGl2e8N
   pmEPdf8cPZPL629fDBM9HtiaywW/PuSgLvz47g2SqnSbhYmrBiVraj+b3
   zacl+w1oeu81t4Yt3tv0aNLDuyfaacUb8besPp1znLHJChTrIQlDzLD+G
   T8ItmMix1kjcnSTb9cLXgx6EAtO8LyUWqcISBdXZ/VFiMrh33MBMoLUWN
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="315791586"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="315791586"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 04:56:18 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="614439953"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="614439953"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.172.41]) ([10.249.172.41])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 04:56:15 -0800
Message-ID: <030e66e0-fb54-b77d-5094-4786684ba97d@linux.intel.com>
Date:   Tue, 31 Jan 2023 20:56:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc:     baolu.lu@linux.intel.com, Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <jroedel@suse.de>,
        Matt Fagnani <matt.fagnani@bell.net>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Tony Zhu <tony.zhu@intel.com>, linux-pci@vger.kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] PCI: Add translated request only flag for
 pci_enable_pasid()
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
References: <20230130183810.GA1692786@bhelgaas>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230130183810.GA1692786@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2023/1/31 2:38, Bjorn Helgaas wrote:
>> PCI: Add translated request only flag for pci_enable_pasid()
>>
>> The PCIe fabric routes Memory Requests based on the TLP address, ignoring
>> the PASID. In order to ensure system integrity, commit 201007ef707a ("PCI:
>> Enable PASID only when ACS RR & UF enabled on upstream path") requires
>> some ACS features being supported on device's upstream path when enabling
>> PCI/PASID.
>>
>> However, above change causes the Linux kernel boots to black screen on a
>> system with below graphic device:
> We need a PCIe concept-level description of the issue first, i.e., in
> terms of DMA, PASID, ACS, etc.  Then we can mention the AMD GPU issue
> as an instance.

How about below description?

PCIe endpoints can use ATS to request DMA remapping hardware to
translate an IOVA to its mapped physical address. If the translation is
missing or the permissions are insufficient, the PRI is used to trigger
an I/O page fault. The IOMMU driver will fill the mapping with desired
permissions and return the translated address to the device.

The translated address is specified by the IOMMU driver. The IOMMU
driver ensures that the address is a DMA buffer address instead of any
P2P address in the PCI fabric. Therefore, any translated memory request
will eventually be routed to IOMMU regardless of whether there is ACS
control in the up-streaming path.

AMD GPU is one of those devices. Furthermore, it always uses translated
memory requests for PASID.

> 
>> 00:01.0 VGA compatible controller: Advanced Micro Devices, Inc.
>>          [AMD/ATI] Wani [Radeon R5/R6/R7 Graphics] (rev ca)
>>          (prog-if 00 [VGA controller])
>>          DeviceName: ATI EG BROADWAY
>>          Subsystem: Hewlett-Packard Company Device 8332
>>
>> The kernel trace looks like below:
>>
>>   Call Trace:
>>    <TASK>
>>    amd_iommu_attach_device+0x2e0/0x300
>>    __iommu_attach_device+0x1b/0x90
>>    iommu_attach_group+0x65/0xa0
>>    amd_iommu_init_device+0x16b/0x250 [iommu_v2]
>>    kfd_iommu_resume+0x4c/0x1a0 [amdgpu]
>>    kgd2kfd_resume_iommu+0x12/0x30 [amdgpu]
>>    kgd2kfd_device_init.cold+0x346/0x49a [amdgpu]
>>    amdgpu_amdkfd_device_init+0x142/0x1d0 [amdgpu]
>>    amdgpu_device_init.cold+0x19f5/0x1e21 [amdgpu]
>>    ? _raw_spin_lock_irqsave+0x23/0x50
>>    amdgpu_driver_load_kms+0x15/0x110 [amdgpu]
>>    amdgpu_pci_probe+0x161/0x370 [amdgpu]
>>    local_pci_probe+0x41/0x80
>>    pci_device_probe+0xb3/0x220
>>    really_probe+0xde/0x380
>>    ? pm_runtime_barrier+0x50/0x90
>>    __driver_probe_device+0x78/0x170
>>    driver_probe_device+0x1f/0x90
>>    __driver_attach+0xce/0x1c0
>>    ? __pfx___driver_attach+0x10/0x10
>>    bus_for_each_dev+0x73/0xa0
>>    bus_add_driver+0x1ae/0x200
>>    driver_register+0x89/0xe0
>>    ? __pfx_init_module+0x10/0x10 [amdgpu]
>>    do_one_initcall+0x59/0x230
>>    do_init_module+0x4a/0x200
>>    __do_sys_init_module+0x157/0x180
>>    do_syscall_64+0x5b/0x80
>>    ? handle_mm_fault+0xff/0x2f0
>>    ? do_user_addr_fault+0x1ef/0x690
>>    ? exc_page_fault+0x70/0x170
>>    entry_SYSCALL_64_after_hwframe+0x72/0xdc
> The stack trace doesn't seem like it shows a failure, so I'm not sure
> it's useful this time.  If it is, we can at least strip out the
> irrelevant pieces.

I will drop above from the commit message.

> 
>> The AMD iommu driver allocates a new domain (called v2 domain) for the
> "v2 domain" needs to be something greppable -- an identifier,
> filename, etc.
> 

The code reads,

2052         if (iommu_feature(iommu, FEATURE_GT) &&
2053             iommu_feature(iommu, FEATURE_PPR)) {
2054                 iommu->is_iommu_v2   = true;

So, how about

..The AMD GPU has a private interface to its own AMD IOMMU, which could
be detected by the FEATURE_GT && FEATURE_PPR features. The AMD iommu
driver allocates a special domain for the GPU device ..

?

Best regards,
baolu

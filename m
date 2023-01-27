Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC4267E441
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jan 2023 12:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbjA0Lys (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Jan 2023 06:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbjA0LyS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Jan 2023 06:54:18 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B826E81B19
        for <linux-pci@vger.kernel.org>; Fri, 27 Jan 2023 03:51:44 -0800 (PST)
Received: from [2a02:8108:963f:de38:4bc7:2566:28bd:b73c]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pLMvy-0001YU-VO; Fri, 27 Jan 2023 12:30:19 +0100
Message-ID: <493cf6bd-6c68-2415-2b24-76ec634df240@leemhuis.info>
Date:   Fri, 27 Jan 2023 12:30:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 1/1] PCI: Add translated request only flag for
 pci_enable_pasid()
Content-Language: en-US, de-DE
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <jroedel@suse.de>,
        Matt Fagnani <matt.fagnani@bell.net>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Tony Zhu <tony.zhu@intel.com>, linux-pci@vger.kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <20230114073420.759989-1-baolu.lu@linux.intel.com>
 <Y8Vwc/bMwvtICv4T@nvidia.com>
From:   "Linux kernel regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <Y8Vwc/bMwvtICv4T@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1674820304;bab9c35c;
X-HE-SMSGID: 1pLMvy-0001YU-VO
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, this is your Linux kernel regression tracker. Top-posting for once,
to make this easily accessible to everyone.

What happened to below patch? It looks like there was no progress since
ten days now. Or did I miss something?

Reminder, the patch is fixing a regression, hence it would be good if
this could be fixed rather sooner than later.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

On 16.01.23 16:42, Jason Gunthorpe wrote:
> On Sat, Jan 14, 2023 at 03:34:20PM +0800, Lu Baolu wrote:
>> The PCIe fabric routes Memory Requests based on the TLP address, ignoring
>> the PASID. In order to ensure system integrity, commit 201007ef707a ("PCI:
>> Enable PASID only when ACS RR & UF enabled on upstream path") requires
>> some ACS features being supported on device's upstream path when enabling
>> PCI/PASID.
>>
>> One alternative is ATS/PRI which lets the device resolve the PASID + addr
>> pair before a memory request is made into a routeable TLB address through
>> the translation agent. Those resolved addresses are then cached on the
>> device instead of in the IOMMU TLB and the device always sets translated
>> bit for PASID. One example of those devices are AMD graphic devices that
>> always have ACS or ATS/PRI enabled together with PASID.
>>
>> This adds a flag parameter in the pci_enable_pasid() helper, with which
>> the device driver could opt-in the fact that device always sets the
>> translated bit for PASID.
>>
>> It also applies this opt-in for AMD graphic devices. Without this change,
>> kernel boots to black screen on a system with below AMD graphic device:
>>
>> 00:01.0 VGA compatible controller: Advanced Micro Devices, Inc.
>>         [AMD/ATI] Wani [Radeon R5/R6/R7 Graphics] (rev ca)
>>         (prog-if 00 [VGA controller])
>> 	DeviceName: ATI EG BROADWAY
>> 	Subsystem: Hewlett-Packard Company Device 8332
>>
>> At present, it is a common practice to enable/disable PCI PASID in the
>> iommu drivers. Considering that the device driver knows more about the
>> specific device, we will follow up by moving pci_enable_pasid() into
>> the specific device drivers.
>>
>> Fixes: 201007ef707a ("PCI: Enable PASID only when ACS RR & UF enabled on upstream path")
>> Reported-and-tested-by: Matt Fagnani <matt.fagnani@bell.net>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216865
>> Link: https://lore.kernel.org/r/15d0f9ff-2a56-b3e9-5b45-e6b23300ae3b@leemhuis.info/
>> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>> Suggested-by: Christian König <christian.koenig@amd.com>
>> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>  include/linux/pci-ats.h                     | 6 ++++--
>>  drivers/iommu/amd/iommu.c                   | 2 +-
>>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
>>  drivers/iommu/intel/iommu.c                 | 3 ++-
>>  drivers/pci/ats.c                           | 8 ++++++--
>>  5 files changed, 14 insertions(+), 7 deletions(-)
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Jason

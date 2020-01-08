Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA6E1134F25
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2020 22:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgAHVxQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jan 2020 16:53:16 -0500
Received: from ale.deltatee.com ([207.54.116.67]:50244 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbgAHVxQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Jan 2020 16:53:16 -0500
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1ipJGL-000176-5O; Wed, 08 Jan 2020 14:53:14 -0700
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Kelvin.Cao@microchip.com, Eric Pilmore <epilmore@gigaio.com>,
        Doug Meyer <dmeyer@gigaio.com>
References: <20200108214728.GA209478@google.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <26a68b91-96ac-e78d-3089-b934f5530269@deltatee.com>
Date:   Wed, 8 Jan 2020 14:53:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200108214728.GA209478@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: dmeyer@gigaio.com, epilmore@gigaio.com, Kelvin.Cao@microchip.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, helgaas@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH 00/12] Switchtec Fixes and Gen4 Support
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2020-01-08 2:47 p.m., Bjorn Helgaas wrote:
> On Mon, Jan 06, 2020 at 12:03:25PM -0700, Logan Gunthorpe wrote:
>> Hi,
>>
>> Please find a bunch of patches for the switchtec driver collected over the
>> last few months.
>>
>> The first 2 patches fix a couple of minor bugs. Patch 3 adds support for
>> a new event that is available in specific firmware versions. Patches 4 and
>> 5 are some code cleanup changes to simplify the logic. And the last 6
>> patches implement support for the new Gen4 hardware.
>>
>> This patchset is based on v5.5-rc5 and a git branch is available here:
>>
>> https://github.com/sbates130272/linux-p2pmem switchtec-next
>>
>> Thanks,
>>
>> Logan
>>
>> --
>>
>> Kelvin Cao (3):
>>   PCI/switchtec: Add gen4 support in struct flash_info_regs
>>   PCI/switchtec: Add permission check for the GAS access MRPC commands
>>   PCI/switchtec: Introduce gen4 variant IDS in the device ID table
>>
>> Logan Gunthorpe (6):
>>   PCI/switchtec: Fix vep_vector_number ioread width
>>   PCI/switchtec: Add support for new events
>>   PCI/switchtec: Introduce Generation Variable
>>   PCI/switchtec: Separate out gen3 specific fields in the sys_info_regs
>>     structure
>>   PCI/switchtec: Add gen4 support in struct sys_info_regs
>>   PCI: Apply switchtec DMA aliasing quirk to GEN4 devices
>>
>> Wesley Sheng (3):
>>   PCI/switchtec: Use dma_set_mask_and_coherent()
>>   PCI/switchtec: Remove redundant valid PFF number count
>>   PCI/switchtec: Move check event id from mask_event() to
>>     switchtec_event_isr()
> 
> Current order is:
> 
>   [PATCH 01/12] PCI/switchtec: Use dma_set_mask_and_coherent()
>   [PATCH 02/12] PCI/switchtec: Fix vep_vector_number ioread width
>   [PATCH 03/12] PCI/switchtec: Add support for new events
>   [PATCH 04/12] PCI/switchtec: Remove redundant valid PFF number count
>   [PATCH 05/12] PCI/switchtec: Move check event id from mask_event() to switchtec_event_isr()
>   [PATCH 06/12] PCI/switchtec: Introduce Generation Variable
>   [PATCH 07/12] PCI/switchtec: Separate out gen3 specific fields in the sys_info_regs structure
>   [PATCH 08/12] PCI/switchtec: Add gen4 support in struct sys_info_regs
>   [PATCH 09/12] PCI/switchtec: Add gen4 support in struct flash_info_regs
>   [PATCH 10/12] PCI/switchtec: Add permission check for the GAS access MRPC commands
> 
> 10/12 looks lonely in the middle of the gen4 stuff, and it looks like
> it's unrelated to gen3/gen4?  Maybe it could be moved up after 05/12?

Yes, sort of: It's related to GEN4 because the GAS access MRPC command
is introduced in GEN4. So it won't really have any effect until after
the GEN4 IDs are added. But there is no harm in applying it earlier.

> I speculatively reordered the permission check patch and applied these
> to my pci/switchtec branch for v5.6 (reverse order from "git log"):
> 
>   b96abab6314f ("PCI/switchtec: Add permission check for the GAS access MRPC commands")
>   5f23367bd4df ("PCI/switchtec: Move check event ID from mask_event() to switchtec_event_isr()")
>   6722d609bc82 ("PCI/switchtec: Remove redundant valid PFF number count")
>   3f3a521ecc81 ("PCI/switchtec: Add support for intercom notify and UEC Port")
>   9375646b4cf0 ("PCI/switchtec: Fix vep_vector_number ioread width")
>   aa82130a22f7 ("PCI/switchtec: Use dma_set_mask_and_coherent()")
> 
> If you rework any of the subsequent ones, you can just post those
> without reposting these first six.

Sounds good, thanks!

Logan

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBE16EE121
	for <lists+linux-pci@lfdr.de>; Tue, 25 Apr 2023 13:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbjDYLhz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Apr 2023 07:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbjDYLhy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Apr 2023 07:37:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 73A5B46AB;
        Tue, 25 Apr 2023 04:37:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0635B4B3;
        Tue, 25 Apr 2023 04:38:37 -0700 (PDT)
Received: from [10.57.23.191] (unknown [10.57.23.191])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B16B03F5A1;
        Tue, 25 Apr 2023 04:37:48 -0700 (PDT)
Message-ID: <1539e760-392f-a33e-436e-bbf043e79bfc@arm.com>
Date:   Tue, 25 Apr 2023 12:37:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [regression] Bug 217218 - Trying to boot Linux version 6-2.2
 kernel with Marvell SATA controller 88SE9235
To:     Jason Adriaanse <jason_a69@yahoo.co.uk>, hch@lst.de
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        regressions@lists.linux.dev
References: <20230416065503.GB6410@lst.de>
 <fc9f4cef-9426-c9d2-3c2c-3ce12fe5f6c3@yahoo.co.uk>
 <5f37b0b0-6cb5-b210-a894-d1e91976126e@arm.com>
 <2a699a99-545c-1324-e052-7d2f41fed1ae@yahoo.co.uk>
 <07ee0cf7-a5c2-f87a-d627-8dd8fb082345@arm.com>
 <9648f668-a3bc-3296-71d1-c91cd4c9980e@yahoo.co.uk>
Content-Language: en-GB
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <9648f668-a3bc-3296-71d1-c91cd4c9980e@yahoo.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2023-04-25 05:17, Jason Adriaanse wrote:
> Ok great,
> 
> I take it a change needs to be made in
> drivers/pci/quirks.c
> ?
> I do not mind making the change locally here and letting you know if it 
> works or not.

Indeed, something like this (make sure the IDs actually match what your
device reports, I'm just guessing):


diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 44cab813bf95..a9166e886b75 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4161,6 +4161,8 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9220,
  /* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c49 */
  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9230,
  			 quirk_dma_func1_alias);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9235,
+			 quirk_dma_func1_alias);
  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TTI, 0x0642,
  			 quirk_dma_func1_alias);
  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TTI, 0x0645,


Marvell themselves seem to lump the 88SE92xx products together as a
closely-related family, so given that we do have quirks for 3 of the 4
already, this one does rather seem conspicuous by its absence...

Thanks,
Robin.

> On 24/04/2023 22:07, Robin Murphy wrote:
>> On 2023-04-24 14:44, Jason Adriaanse wrote:
>>> I took out "iommu=soft" and the server failed to boot, so yes it does 
>>> break.
>>>
>>> The first error was
>>> ata7.00: Failed to IDENTIFY (INIT_DEV_PARAMS failed , err_mask=0x80)
>>
>> OK, great, that confirms the underlying issue existed all along, so 
>> the regression is only a change in who wins a fight between certain 
>> conflicting command-line arguments, which is arguably not so critical.
>>
>> The rest of the evidence points to 88SE9235 wanting the same phantom 
>> function quirk as most other Marvell controllers, since although it's 
>> apparently been half-fixed such that DMA for two of the ports is being 
>> correctly emitted from function 0 - given that you say two of the 
>> disks *are* detected OK - the other two are still claiming to be 
>> function 1 after all.
>>
>> Thanks,
>> Robin.
>>
>>> On 24/04/2023 21:20, Robin Murphy wrote:
>>>> On 2023-04-22 07:25, Jason Adriaanse wrote:
>>>>> Hi Christoph,
>>>>>
>>>>> Sorry for my late reply, I have been on the road.
>>>>>
>>>>> So, if I boot with
>>>>> intel_iommu=off
>>>>> Then the server boots fine..although that is not a solution because 
>>>>> I need Intel iommu for virtualisation.
>>>>>
>>>>> Also, I build all my kernels with CONFIG_INTEL_IOMMU=y
>>>>>
>>>>
>>>> If you boot 5.15 *without* the "iommu=soft" argument, just 
>>>> "intel_iommu=on", does that also break?
>>>>
>>>> Robin.

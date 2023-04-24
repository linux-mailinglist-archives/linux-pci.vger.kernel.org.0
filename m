Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015F86ECFEC
	for <lists+linux-pci@lfdr.de>; Mon, 24 Apr 2023 16:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjDXOH2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Apr 2023 10:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbjDXOH1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Apr 2023 10:07:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 43C1B6181;
        Mon, 24 Apr 2023 07:07:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF52AD75;
        Mon, 24 Apr 2023 07:08:09 -0700 (PDT)
Received: from [10.57.21.60] (unknown [10.57.21.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E5DC93F64C;
        Mon, 24 Apr 2023 07:07:24 -0700 (PDT)
Message-ID: <07ee0cf7-a5c2-f87a-d627-8dd8fb082345@arm.com>
Date:   Mon, 24 Apr 2023 15:07:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [regression] Bug 217218 - Trying to boot Linux version 6-2.2
 kernel with Marvell SATA controller 88SE9235
Content-Language: en-GB
To:     Jason Adriaanse <jason_a69@yahoo.co.uk>, hch@lst.de
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        regressions@lists.linux.dev
References: <20230416065503.GB6410@lst.de>
 <fc9f4cef-9426-c9d2-3c2c-3ce12fe5f6c3@yahoo.co.uk>
 <5f37b0b0-6cb5-b210-a894-d1e91976126e@arm.com>
 <2a699a99-545c-1324-e052-7d2f41fed1ae@yahoo.co.uk>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <2a699a99-545c-1324-e052-7d2f41fed1ae@yahoo.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2023-04-24 14:44, Jason Adriaanse wrote:
> I took out "iommu=soft" and the server failed to boot, so yes it does 
> break.
> 
> The first error was
> ata7.00: Failed to IDENTIFY (INIT_DEV_PARAMS failed , err_mask=0x80)

OK, great, that confirms the underlying issue existed all along, so the 
regression is only a change in who wins a fight between certain 
conflicting command-line arguments, which is arguably not so critical.

The rest of the evidence points to 88SE9235 wanting the same phantom 
function quirk as most other Marvell controllers, since although it's 
apparently been half-fixed such that DMA for two of the ports is being 
correctly emitted from function 0 - given that you say two of the disks 
*are* detected OK - the other two are still claiming to be function 1 
after all.

Thanks,
Robin.

> On 24/04/2023 21:20, Robin Murphy wrote:
>> On 2023-04-22 07:25, Jason Adriaanse wrote:
>>> Hi Christoph,
>>>
>>> Sorry for my late reply, I have been on the road.
>>>
>>> So, if I boot with
>>> intel_iommu=off
>>> Then the server boots fine..although that is not a solution because I 
>>> need Intel iommu for virtualisation.
>>>
>>> Also, I build all my kernels with CONFIG_INTEL_IOMMU=y
>>>
>>
>> If you boot 5.15 *without* the "iommu=soft" argument, just 
>> "intel_iommu=on", does that also break?
>>
>> Robin.

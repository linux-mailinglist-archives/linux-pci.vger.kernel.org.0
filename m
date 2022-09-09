Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F376A5B3B5C
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 17:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiIIPAl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 11:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiIIPAk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 11:00:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F866D5733;
        Fri,  9 Sep 2022 08:00:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3BD1C165C;
        Fri,  9 Sep 2022 08:00:43 -0700 (PDT)
Received: from [10.57.15.197] (unknown [10.57.15.197])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6252E3F73D;
        Fri,  9 Sep 2022 08:00:34 -0700 (PDT)
Message-ID: <6d1da046-1f14-4204-e0c5-8d5b315e3839@arm.com>
Date:   Fri, 9 Sep 2022 16:00:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v5 2/2] PCI: dwc: Add support for 64-bit MSI target
 address
Content-Language: en-GB
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Will McVicker <willmcvicker@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, kernel-team@android.com,
        Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20220825185026.3816331-1-willmcvicker@google.com>
 <20220825185026.3816331-3-willmcvicker@google.com>
 <Yxs/zguOb52tY2C0@infradead.org>
 <5bfd7d4d-d431-6321-89bc-663dcd36e930@arm.com>
 <YxtR8/X4fb9wSYEo@infradead.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YxtR8/X4fb9wSYEo@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022-09-09 15:47, Christoph Hellwig wrote:
> On Fri, Sep 09, 2022 at 02:47:19PM +0100, Robin Murphy wrote:
>> On 2022-09-09 14:29, Christoph Hellwig wrote:
>>> On Thu, Aug 25, 2022 at 06:50:25PM +0000, Will McVicker wrote:
>>>> Since not all devices require a 32-bit MSI address, add support to the
>>>> PCIe host driver to allow setting the DMA mask to 64-bits if the 32-bit
>>>> allocation fails. This allows kernels to disable ZONE_DMA32 and bounce
>>>> buffering (swiotlb) without risking not being able to get a 32-bit address
>>>> during DMA allocation.
>>>
>>> Umm.  You can't just disable ZONE_DMA32.  Linux absolutely requires a
>>> 32-bit dma mask to work, it is in fact the implicit default.
>>
>> Eh, it's behind CONFIG_EXPERT, which makes it enough of a "I think I know
>> what I'm doing and accept responsibility for picking up the pieces if it
>> breaks" thing.
> 
> Seem like indeed on arm64 there is a way to disable it.  The x86 model
> is to just select it unconditionally, which I think is the right way
> if we don't want to get into completely random failures.

IIRC there were reasons for wanting as much ZONE_NORMAL memory as 
possible; for the embedded folks who are already typically running with 
"swiotlb=noforce" to save memory because they know their hardware, we 
may as well let them have the footgun. Distros and other general-purpose 
configs should rightly not be going anywhere near this.

Cheers,
Robin.

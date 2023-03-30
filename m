Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCFA06D0478
	for <lists+linux-pci@lfdr.de>; Thu, 30 Mar 2023 14:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjC3MS4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Mar 2023 08:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbjC3MSz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Mar 2023 08:18:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2988B7A8F;
        Thu, 30 Mar 2023 05:18:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ECBE42F4;
        Thu, 30 Mar 2023 05:19:37 -0700 (PDT)
Received: from [10.57.54.254] (unknown [10.57.54.254])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A06793F73F;
        Thu, 30 Mar 2023 05:18:52 -0700 (PDT)
Message-ID: <01c50370-002d-5e18-3edc-81c9527aedc9@arm.com>
Date:   Thu, 30 Mar 2023 13:18:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [regression] Bug 217218 - Trying to boot Linux version 6-2.2
 kernel with Marvell SATA controller 88SE9235
Content-Language: en-GB
To:     Christoph Hellwig <hch@lst.de>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>, iommu@lists.linux.dev,
        baolu.lu@linux.intel.com
References: <a79ea7f5-6a41-a6c9-cfec-ba01aa2a3cfa@leemhuis.info>
 <20230328012231.GB21977@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230328012231.GB21977@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2023-03-28 02:22, Christoph Hellwig wrote:
> 
> I finally found some real time to look into this:
> 
> On Tue, Mar 21, 2023 at 02:52:00PM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
>>> The man errors I am getting are
>>>
>>> dmar_fault 8 callbacks suppressed
>>> DMAR : DRHD: handling fault status req 2
>>> DMAR : [DMA Write NO_PASID] Request device [07.00.1] fault addr
>>> 0xfffe0000 [fault reason 0x82] Present bit in contect entry is clear
> 
> This clearly indicates that my original idea about the AMD gart was
> completely bonkers, as we're obviously on an Intel platform.
> 
> And this indicates that the device is trying to do a DMA write to
> something that isn't IOMMU mapped.  Getting this from an initialization
> change (commit 78013eaadf6 (x86: remove the IOMMU table infrastructure")
> feels very strange to me.
> 
> Can you maybe post the full dmesg?  I wonder if there is interesting
> initialization error in here.

FWIW "Marvell SATA" instantly makes me suspect the phantom function 
quirk. What *should* happen is the IOMMU driver sees the PCI DMA aliases 
correctly and sets up context entries for both 07.00.0 and 07.00.1, but 
it looks like that may be what's gone awry.

Robin.

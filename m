Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A647D6E46C4
	for <lists+linux-pci@lfdr.de>; Mon, 17 Apr 2023 13:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjDQLtW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Apr 2023 07:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjDQLtV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Apr 2023 07:49:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 69D575FD0;
        Mon, 17 Apr 2023 04:48:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CBD71063;
        Mon, 17 Apr 2023 04:22:47 -0700 (PDT)
Received: from [10.57.80.202] (unknown [10.57.80.202])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 858853F6C4;
        Mon, 17 Apr 2023 04:22:02 -0700 (PDT)
Message-ID: <6a775920-9260-f82e-dace-0b792f5371c4@arm.com>
Date:   Mon, 17 Apr 2023 12:21:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [regression] Bug 217218 - Trying to boot Linux version 6-2.2
 kernel with Marvell SATA controller 88SE9235
Content-Language: en-GB
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>, iommu@lists.linux.dev,
        baolu.lu@linux.intel.com
References: <a79ea7f5-6a41-a6c9-cfec-ba01aa2a3cfa@leemhuis.info>
 <20230328012231.GB21977@lst.de>
 <01c50370-002d-5e18-3edc-81c9527aedc9@arm.com> <20230416064156.GA6410@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230416064156.GA6410@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2023-04-16 07:41, Christoph Hellwig wrote:
> On Thu, Mar 30, 2023 at 01:18:45PM +0100, Robin Murphy wrote:
>> FWIW "Marvell SATA" instantly makes me suspect the phantom function quirk.
>> What *should* happen is the IOMMU driver sees the PCI DMA aliases correctly
>> and sets up context entries for both 07.00.0 and 07.00.1, but it looks like
>> that may be what's gone awry.
> 
> Looking at the bug report it seems this is device 9235, which doesn't
> need the DMA alias quirks.

Indeed that one doesn't appear to be in the quirk list currently. 
However the symptom of DMA traffic from function 1 which the IOMMU 
clearly wasn't expecting firmly suggests that it *does* need the quirk. 
Digging up the original report, the lspci output there suggests that 
07:00.1 isn't a real function, which would further confirm it.

The other thing which catches my interest is the seemingly-conflicting 
"iommu=soft" and "intel_iommu=on" arguments - I could well believe that 
refactoring the x86 IOMMU detection stuff might have subtly changed the 
interaction there, such that previously it ended up not actually using 
the IOMMU for DMA ops, but now it is?

Robin.

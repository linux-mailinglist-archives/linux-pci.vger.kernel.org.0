Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE6E74C496
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2019 02:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbfFTAtt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jun 2019 20:49:49 -0400
Received: from ale.deltatee.com ([207.54.116.67]:42680 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbfFTAts (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Jun 2019 20:49:48 -0400
Received: from s01061831bf6ec98c.cg.shawcable.net ([68.147.80.180] helo=[192.168.6.132])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hdlGs-0007pf-J7; Wed, 19 Jun 2019 18:49:47 -0600
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <SL2P216MB01874DFDDBDE49B935A9B1B380E50@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <e768271e-9455-2a3d-ad76-4a6d9c71d669@deltatee.com>
 <SL2P216MB01872DFDDA9C313CA43C7B3280E40@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <024eec86-dfb9-0a23-6385-9e8dfe9a0381@deltatee.com>
Date:   Wed, 19 Jun 2019 18:49:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <SL2P216MB01872DFDDA9C313CA43C7B3280E40@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.80.180
X-SA-Exim-Rcpt-To: linux-pci@vger.kernel.org, bhelgaas@google.com, benh@kernel.crashing.org, nicholas.johnson-opensource@outlook.com.au
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_FREE autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [nicholas.johnson-opensource@outlook.com.au: [PATCH v6 3/4] PCI:
 Fix bug resulting in double hpmemsize being assigned to MMIO window]
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-06-19 6:44 p.m., Nicholas Johnson wrote:
>> This is all kinds of confusing... the bug report just seems to be a copy
>> of the patch set. The description of the actual symptoms of the problem
>> appears to be missing from all of it.
> I believe everything to be there, but I can take another look and add 
> more details. It is possible I lost track of what I had written where.
> 
> There are common elements which I borrowed from the patchset or 
> vice-versa, like the pin diagram for using the Thunderbolt add-in card 
> for testing.

What's missing are symptoms of the bug or what you are actually seeing
with what hardware. The closest thing to that is the bug's title. But
it's not clear what the problem is with having a double size MMIO window.

The pin diagram and stuff is just noise to me because I don't have that
hardware and am not going to buy it just to try to figure out if there
is a bug there or not.

>>
>>> Currently, the kernel can sometimes assign the MMIO_PREF window
>>> additional size into the MMIO window, resulting in double the MMIO
>>> additional size, even if the MMIO_PREF window was successful.
>>>
>>> This happens if in the first pass, the MMIO_PREF succeeds but the MMIO
>>> fails. In the next pass, because MMIO_PREF is already assigned, the
>>> attempt to assign MMIO_PREF returns an error code instead of success
>>> (nothing more to do, already allocated).
>>>
>>> Example of problem (more context can be found in the bug report URL):
>>>
>>> Mainline kernel:
>>> pci 0000:06:01.0: BAR 14: assigned [mem 0x90100000-0xa00fffff] = 256M
>>> pci 0000:06:04.0: BAR 14: assigned [mem 0xa0200000-0xb01fffff] = 256M
>>>
>>> Patched kernel:
>>> pci 0000:06:01.0: BAR 14: assigned [mem 0x90100000-0x980fffff] = 128M
>>> pci 0000:06:04.0: BAR 14: assigned [mem 0x98200000-0xa01fffff] = 128M
>>>
>>> This was using pci=realloc,hpmemsize=128M,nocrs - on the same machine
>>> with the same configuration, with a Ubuntu mainline kernel and a kernel
>>> patched with this patch series.
>>>
>>> This patch is vital for the next patch in the series. The next patch
>>> allows the user to specify MMIO and MMIO_PREF independently. If the
>>> MMIO_PREF is set to be very large, this bug will end up more than
>>> doubling the MMIO size. The bug results in the MMIO_PREF being added to
>>> the MMIO window, which means doubling if MMIO_PREF size == MMIO size.
>>> With a large MMIO_PREF, without this patch, the MMIO window will likely
>>> fail to be assigned altogether due to lack of 32-bit address space.
>>>
>>> Patch notes
>>> ==========================================================================
>>>
>>> Change find_free_bus_resource() to not skip assigned resources with
>>> non-null parent.
>>>
>>> Add checks in pbus_size_io() and pbus_size_mem() to return success if
>>> resource returned from find_free_bus_resource() is already allocated.
>>>
>>> This avoids pbus_size_io() and pbus_size_mem() returning error code to
>>> __pci_bus_size_bridges() when a resource has been successfully assigned
>>> in a previous pass. This fixes the existing behaviour where space for a
>>> resource could be reserved multiple times in different parent bridge
>>> windows. This also greatly reduces the number of failed BAR messages in
>>> dmesg when Linux assigns resources.
>>
>> This patch looks like the same bug that I tracked down earlier but I
>> solved in a slightly different way. See this patch[1] which is still
>> under review. Can you maybe test it and see if it solves the same problem?
> 
> I read [1] and it is definitely the same bug, without a doubt. This is 
> fantastic because it means I have somebody to back me up on this. I will 
> test the patch as soon as I can - perhaps after work today.
> 
> My initial thoughts of [1] patch are that restricting 64-bit BARs to 
> 64-bit windows might break assigning 64-bit BARs on bridges without the 
> optional prefetchable window. My patch should not have that issue - but 
> after I have tested [1], it might turn out to be fine.
> 
> Correct me if I am wrong about assumptions about windows. My 
> understanding cannot be perfect. As far as I know, 64-bit BARs should 
> always be prefetchable, but I own the Aquantia AQC-107S NIC and it has 
> three 64-bit non-pref BARs. It happens that they are assigned into the 
> 32-bit window. I will see if [1] patch prevents that from happening or 
> not.

As best as I can tell the patches should have identical functionality.
My patch ignores the error returned by pbus_size_mem() your patch forces
the function from returning an error inside it for the same case.

Logan

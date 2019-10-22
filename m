Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42F8EE0598
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2019 15:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729869AbfJVN4C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Oct 2019 09:56:02 -0400
Received: from [217.140.110.172] ([217.140.110.172]:53356 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1727831AbfJVN4C (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Oct 2019 09:56:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7C2A1763;
        Tue, 22 Oct 2019 06:55:37 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3342A3F71A;
        Tue, 22 Oct 2019 06:55:36 -0700 (PDT)
Subject: Re: [PATCH] PCI: Warn about host bridge device when its numa node is
 NO_NODE
To:     Yunsheng Lin <linyunsheng@huawei.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhocko@kernel.org,
        peterz@infradead.org, geert@linux-m68k.org,
        gregkh@linuxfoundation.org, paul.burton@mips.com
References: <1571467543-26125-1-git-send-email-linyunsheng@huawei.com>
 <20191019083431.GA26340@infradead.org>
 <96b8737d-5fbf-7942-bf10-7521cf954d6e@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <e35bd451-bdb7-ec02-d691-aa3720d1e10b@arm.com>
Date:   Tue, 22 Oct 2019 14:55:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <96b8737d-5fbf-7942-bf10-7521cf954d6e@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/10/2019 05:05, Yunsheng Lin wrote:
> On 2019/10/19 16:34, Christoph Hellwig wrote:
>> On Sat, Oct 19, 2019 at 02:45:43PM +0800, Yunsheng Lin wrote:
>>> +	if (nr_node_ids > 1 && dev_to_node(bus->bridge) == NUMA_NO_NODE)
>>> +		dev_err(bus->bridge, FW_BUG "No node assigned on NUMA capable HW by BIOS. Please contact your vendor for updates.\n");
>>> +
>>
>> The whole idea of mentioning a BIOS in architeture indepent code doesn't
>> make sense at all.

[ Come to think of it, I'm sure an increasing number of x86 firmwares 
don't even implement a PC BIOS any more... ]

In all fairness, the server-class Arm-based machines I've come across so 
far do seem to consistently call their EFI firmware images "BIOS" 
despite the clear anachronism. At least the absurdity of conflating a 
system setup program with a semiconductor process seems to have mostly 
died out ;)

> Mentioning the BIOS is to tell user what firmware is broken, so that
> user can report this to their vendor by referring the specific firmware.
> 
> It seems we can specific the node through different ways(DT, ACPI, etc).
> 
> Is there a better name for mentioning instead of BIOS, or we should do
> the checking and warning in the architeture dependent code?
> 
> Or maybe just remove the BIOS from the above log?

Even though there may be some degree of historical convention hanging 
around on ACPI-based systems, that argument almost certainly doesn't 
hold for OF/FDT/etc. - the "[Firmware Bug]:" prefix is hopefully 
indicative enough, so I'd say just drop the "by BIOS" part.

Robin.

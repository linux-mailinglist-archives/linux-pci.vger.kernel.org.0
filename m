Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F129425286
	for <lists+linux-pci@lfdr.de>; Thu,  7 Oct 2021 14:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241121AbhJGMIX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Oct 2021 08:08:23 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:37440
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241180AbhJGMIW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Oct 2021 08:08:22 -0400
Received: from [192.168.0.107] (unknown [123.112.65.32])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 501AD3FFDC;
        Thu,  7 Oct 2021 12:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633608388;
        bh=/LZrfgamGOjokv2Y5Iz/3vR1pIXdK6TLFWNaXQeDSZk=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=gUykpXTMnyZv0mnzm8bBc/i+jkMzDiYFNcaRVZR5dVlcURfd5uAHf9N4d3zSLADvX
         PQ2//6tqwitj3hakvZXQ/6DzzW+x9SGeU807M6jf2GyrT33y6aNlied91JCpuf3/++
         4yvFXjyxWnr8N25svKM1OPlPILFGTKvuaBdEHOodLnSixiUfF5Y9y8JYFtgThrOIqZ
         b9+j8hSe3PtPHyiApDt6A6h7Lqlfo5+0rLYZ3aV+knRlj1V+iei3eilvb1BkvQdAxx
         KFYrhVVuelDVNM1/eVOZKnsS3heKBszCAKn89uTs/kMnp5FWvq8+ad46mhc4i4BMdn
         xLQf45kZdDqkA==
Subject: Re: [PATCH] x86/PCI: Conditionally add a non-e820 mapped window to
 root bridge
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, yinghai@kernel.org, mingo@redhat.com,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        rafael.j.wysocki@intel.com, myron.stowe@redhat.com
References: <20211006205846.GA1179918@bhelgaas>
From:   Hui Wang <hui.wang@canonical.com>
Message-ID: <b9377dd9-87e5-b1ee-7ecb-b980024058de@canonical.com>
Date:   Thu, 7 Oct 2021 20:06:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211006205846.GA1179918@bhelgaas>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 10/7/21 4:58 AM, Bjorn Helgaas wrote:
> [+cc Myron, just FYI]
>
> On Thu, Jun 24, 2021 at 05:53:24PM +0800, Hui Wang wrote:
>> The touchpad can't work on many Lenovo Ideapad S145/BS145 laptops.
>> But it works well under Windows.
>>
>> On those machines, the touchpad is an I2C device, while the I2C host
>> controllers fail to initialize as below shown:
>>   pci 0000:00:15.0: BAR 0: no space for [mem size 0x00001000 64bit]
>>   pci 0000:00:15.0: BAR 0: failed to assign [mem size 0x00001000 64bit]
>>   pci 0000:00:15.1: BAR 0: no space for [mem size 0x00001000 64bit]
>>   pci 0000:00:15.1: BAR 0: failed to assign [mem size 0x00001000 64bit]
>>
>> The BIOS assigns iomem space to host bridge and I2C host controller
>> like this:
>>   pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
>>   pci_bus 0000:00: root bus resource [mem 0x65400000-0xbfffffff window]
>>
>>   pci 0000:00:15.0: [8086:34e8] type 00 class 0x0c8000
>>   pci 0000:00:15.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
>>   pci 0000:00:15.1: [8086:34e9] type 00 class 0x0c8000
>>   pci 0000:00:15.1: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
>>
>> The I2C host controllers need to allocate iomem space from root
>> bridge, but all iomem window of the root bridge are overlapped with
>> BIOS-e820 mapped region, that makes the allocate_resource() fail:
>>   BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable
>>   BIOS-e820: [mem 0x000000000009f000-0x00000000000fffff] reserved
>>   ...
>>   BIOS-e820: [mem 0x000000004bc50000-0x00000000cfffffff] reserved
>>
>> We could add "pci=nocrs" to make the touchpad work, but users expect
>> the touchpad to work out-of-box under Linux distro as under Windows.
>>
>> Here design a generic solution for x86 machines, if host bridge uses
>> crs, we will check if all root bridge iomem windows are overlapped
>> with BIOS-e820 mapped region, if yes, we try to build a non-e820
>> mapped window according to the biggest gap in the e820 mapped region,
>> and we need to clip this window with MMCONFIG region if this region
>> is not mapped by BIOS-e820, then insert this window to the tail of
>> the root bridge.
>>
>> After this change, the I2C host controller could allocate the iomem
>> region from host bridge successfully and the touchpad could work
>> out-of-box.
> I see from
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1931715 that a
> fix has been committed, I assume to the Ubuntu kernel, but I assume
> this is still a problem for upstream and probably other distro
> kernels.
No, the patch is not applied to Ubuntu kernels, Someone set it to 
committed by a mistake, and the bug status was changed back to confirmed 
already.
> The 0-day bot found some issue, which I haven't looked at:
> https://lore.kernel.org/r/20210627143859.GD17986@xsang-OptiPlex-9020
I reread the dmesg today, found all pci root bridges have at least one 
iomem window which is not overlapped with e820 reserved region, that is 
to say, in theory my patch will not assign new iomem window for any pci 
root bridges. So I don't know how my patch introduces the crashing on 
that machine.
> I think this patch might be the wrong approach.  We learned from _CRS
> that [mem 0x65400000-0xbfffffff window] is assigned to the PNP0A08:00
> host bridge.
>
> The e820 "[mem 0x000000004bc50000-0x00000000cfffffff] reserved" region
> certainly includes all of that PCI aperture, and this entry should
> prevent that space from being allocated to devices that haven't
> already been assigned space.
>
> But I don't think that e820 entry should prevent the PCI core from
> managing that PCI aperture.  The platform told us that PNP0A08:00 owns
> the [mem 0x65400000-0xbfffffff window], and the PNP0A08:00 driver
> (pci_root.c) should be able to manage it as needed.

The e820 entry prevent the pci devices from getting the overlapped 
region by the path below:

kernel/resource.c:__find_resource()--->arch/x86/kernel/resource.c:arch_remove_reservations()--->remove_e820_regions()

Maybe we could remove arch_remove_reservations() as other architectures?


Regards,

Hui.

>
>> BugLink: http://bugs.launchpad.net/bugs/1931715
>> BugLink: http://bugs.launchpad.net/bugs/1932069
>> BugLink: http://bugs.launchpad.net/bugs/1921649
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: Yinghai Lu <yinghai@kernel.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Cc: linux-acpi@vger.kernel.org
>> Cc: linux-pci@vger.kernel.org
>> Signed-off-by: Hui Wang <hui.wang@canonical.com>
>> ---
>>   arch/x86/include/asm/e820/api.h |  1 +
>>   arch/x86/include/asm/pci.h      |  2 ++
>>   arch/x86/include/asm/pci_x86.h  |  1 +
>>   arch/x86/kernel/e820.c          |  2 ++
>>   arch/x86/pci/acpi.c             | 46 ++++++++++++++++++++++++++++++++-
>>   arch/x86/pci/mmconfig-shared.c  | 28 ++++++++++++++++++++
>>   6 files changed, 79 insertions(+), 1 deletion(-)
>>

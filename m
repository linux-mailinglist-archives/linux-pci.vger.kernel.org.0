Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD4994B59F
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2019 11:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731557AbfFSJxk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jun 2019 05:53:40 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46688 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727068AbfFSJxj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Jun 2019 05:53:39 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 54310F0CF54E2EF2F43D;
        Wed, 19 Jun 2019 17:53:37 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Wed, 19 Jun 2019
 17:53:28 +0800
Subject: PCI host bridge hotplug test question (was Re: [PATCH v2] bus:
 hisi_lpc: Don't use devm_kzalloc() to allocate logical PIO range)
To:     Bjorn Helgaas <bhelgaas@google.com>
References: <1560507893-42553-1-git-send-email-john.garry@huawei.com>
 <CAErSpo6jRVDaVvH+9XvzUoEUbHi9_6u+5PcVGVDAmre6Qd0WeQ@mail.gmail.com>
 <CAErSpo6qaMc1O7vgcuCwdDbe4QBcOw83wd7PbuUVS+7GDPgK9Q@mail.gmail.com>
 <82840955-6365-0b95-6d69-8a2f7c7880af@huawei.com>
 <CAErSpo5cqJCZjt6QqMNZ6_n=G-_WxFeERnsESOMxsdr1P-6JLg@mail.gmail.com>
 <9e8b6971-3189-9d4b-de9a-ff09f859f4f6@huawei.com>
 <CAErSpo4DemDWtnP2Gtram9tfQ0CaN9Na9_Gxk6Qk+nG5+JLuzA@mail.gmail.com>
 <539835d3-770c-285c-0c49-ae15ceaa3079@huawei.com>
 <CAErSpo576mVAFkF69bxaTpyxELXEG+z_m7CmUE3WGqfCmy57uQ@mail.gmail.com>
CC:     <xuwei5@huawei.com>, <linuxarm@huawei.com>, <arm@kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <4b24fd36-e716-7c5e-31cc-13da727802e7@huawei.com>
Date:   Wed, 19 Jun 2019 10:53:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <CAErSpo576mVAFkF69bxaTpyxELXEG+z_m7CmUE3WGqfCmy57uQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 18/06/2019 18:50, Bjorn Helgaas wrote:
> [+cc Rafael, Mika, Jiang, linux-pci for ACPI host bridge hotplug test question]
>

Resend with bouncing addresses removed/fixed

> On Tue, Jun 18, 2019 at 3:44 AM John Garry <john.garry@huawei.com> wrote:
>
>>>>> Could you just move the logic_pio_register_range() call farther down
>>>>> in hisi_lpc_probe()?  IIUC, once logic_pio_register_range() returns,
>>>>> an inb() with the right port number will try to access that port, so
>>>>> we should be prepared for that, i.e., maybe this in the wrong order to
>>>>> begin with?
>>>>
>>>> No, unfortunately we can't. The reason is that we need the logical PIO
>>>> base for that range before we enumerate the children of that host. We
>>>> need that base address for "translating" the child bus addresses to
>>>> logical PIO addresses.
>
>>> Ah, yeah, that makes sense.  I think.  We do assume that we know all
>>> the MMIO and I/O port translations before enumerating devices.  It's
>>> *conceivable* that could be changed someday since we don't actually
>>> need the translations until a driver claims the device,
>>
>> We actually need them before a driver claims the device.
>>
>> The reason is that when we create that child platform device we set the
>> device's IORESOURCE_IO resources according to the translated logic PIO
>> addresses, and not the host bus address. This is what makes the host
>> transparent to the child device driver.
>
> I think you need it to set pdev->resource[], which is currently done
> long before the driver claims the device (though one could imagine
> delaying it even as far as pci_enable_device()-time).  I don't think
> the translation is actually *used* until the driver claims the device
> because only the driver knows how to do any inb/outb to the device.
>
> But of course, that's all speculative and doesn't change what you need
> to do now.  The current code assumes we know the translations during
> enumeration, so you need to do the logic_pio registration before
> enumerating.
>
>>> and it would
>>> gain some flexibility if we didn't have to program the host bridge
>>> windows until we know how much space is required.  But I don't see
>>> that happening anytime soon.
>
>> My problem is that I need to ensure that the new logical PIO unregister
>> function works ok for hot-pluggable host bridges. I need to get some way
>> to test this. Advice?
>

Hi Bjorn,

> Good question.  The ACPI host bridge driver (drivers/acpi/pci_root.c)
> should support hotplug, but I'm not sure if there's a manual way to
> trigger it via sysfs or something similar.  If there is, and you have
> a machine with more than one host bridge, you might be able to remove
> one that leads to non-essential devices.
>

For one of our earlier boards I don't think that it had any essential 
devices on the host bridge. But I need to find out about possibility of 
removal. Hmmm.

> Bjorn
>

Further to the topic of supporting hotplug and unregistering IO port 
regions, we don't even release IO port regions in the error path of PCI 
host enumeration. We have pci_register_io_range(), but no unregister 
equivalent.

Looking at the history here, pci_register_io_range() was originally in 
OF code. And in the OF code, calling pci_register_io_range() is a 
side-effect of parsing the device tree. As such, I can see why there was 
no unregister function.

It would be worth noting this discussion, where the same was mentioned:
https://lore.kernel.org/linux-pci/20180403140410.GE27789@ulmo/

The tegra PCI host probe can defer, but, since there is no tidy-up of 
pci_register_io_range() when deferring, we need to ensure that the port 
IO management code can handle re-attempts to register the same range.

It looks like this can be cleaned up also.

Thanks,
John

> .
>



Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB57011FE99
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2019 07:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfLPGs6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Dec 2019 01:48:58 -0500
Received: from mx2a.mailbox.org ([80.241.60.219]:60161 "EHLO mx2a.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbfLPGs6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Dec 2019 01:48:58 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id A8A8BA1C9B;
        Mon, 16 Dec 2019 07:48:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id 1OZlxwvBPa5l; Mon, 16 Dec 2019 07:48:51 +0100 (CET)
Subject: Re: PCIe hotplug resource issues with PEX switch (NVMe disks) on AMD
 Epyc system
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
References: <4fc407f8-2a24-4a04-20fb-5d07d5c24be4@denx.de>
 <PSXP216MB0438BE9DA58D0AF9F908070680540@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <c9f154e5-4214-aa46-2ce2-443b508e1643@denx.de>
 <PSXP216MB0438AD1041F6BD7DB51363A380540@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <9aa45b1d-8afe-2d59-4bca-4d2beb983cfc@denx.de>
 <PSXP216MB0438ADAE9B4081B69CABEA7580560@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
From:   Stefan Roese <sr@denx.de>
Message-ID: <1a35d371-9351-fb7d-fa8d-f6e6145c0fea@denx.de>
Date:   Mon, 16 Dec 2019 07:48:49 +0100
MIME-Version: 1.0
In-Reply-To: <PSXP216MB0438ADAE9B4081B69CABEA7580560@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Nicholas,

On 15.12.19 04:16, Nicholas Johnson wrote:
> Hi,
> 
>>>   From the logs, it looks like MMIO_PREF was assigned 1G but not MMIO.
>>>
>>> This looks tricky. Please revert my commit:
>>> c13704f5685deb7d6eb21e293233e0901ed77377
>>>
>>> And see if it is the problem.
>>
>> I reverted this patch and did a few test (some of my test cases). None
>> turned out differently than before. Either the resources are not mapped
>> completely or they are mapped  (with pci=nocrs) and not accessible.
>>
>>> It is entirely possible, but because of
>>> the very old code and how there are multiple passes, it might be
>>> impossible to use realloc without side effects for somebody. If you fix
>>> it for one scenario, it is possible that there is another scenario for
>>> which it will break due to the change. The only way to make everything
>>> work is a near complete rewrite of drivers/pci/setup-bus.c and
>>> potentially others, something I am working on, but is going to take a
>>> long time. And unlikely to ever be accepted.
>>
>> While working on this issue, I looked (again) at this resource (re-)
>> allocation code. This is really confusing (at least to me) and I also think
>> that it needs a "near complete rewrite".
>>> Otherwise, it will take me a lot of grepping through dmesg to find the
>>> cause, which will take more time.
>>
>> Sure.
>>> FYI, "lspci -vvv" is redundant because it can be produced from "lspci
>>> -xxxx" output.
>>
>> I know. Its mainly for me to easily see the PCI devices listed quickly.
>>> A final note, Epyc CPUs can bifurcate x16 slots into x4/x4/x4/x4 in the
>>> BIOS setup, although you will probably not have the hotplug services
>>> provided by the PEX switch.
>>
>> I think it should not matter for my current test with resource assignment,
>> how many PCIe lanes the PEX switch has connected to the PCI root port. Its
>> of course important for the bandwidth, but this is a completely different
>> issue.
> I meant that you can connect 4x NVMe drives to a PCIe x16 slot with a
> cheap passive bifurcation riser. But it sounds like this card is useful
> because of its hotplug support.
> 
> I noticed if you grep your some of your dmesg logs for "add_size", you
> have some lines like this:
> [    0.767652] pci 0000:42:04.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 44] add_size 200000 add_align 100000
> 
> I am not sure if these are the cause or a symptom of the problem, but I
> do not have any when assigning MMIO and MMIO_PREF for Thunderbolt 3.
> 
> I noticed you are using pci=hpmemsize in some of the tests. It should
> not be interfering because you put it first (it is overwritten by
> hpmmiosize and hpmmioprefsize). But I should point out that
> pci=hpmemsize=X is equivalent to pci=hpmmiosize=X,hpmmioprefsize=X so it
> is redundant. When I added hpmmiosize and hpmmioprefsize parameters to
> control them independently, I would have liked to have dropped
> hpmemsize, but needed to leave it around to not disrupt people who are
> already using it.

Thanks. I was aware of keeping the old notation to not break backwards
compatiblity. I'll drop hpmemsize=X from now on.
  
> Please try something like this, which I dug up from a very old attempt
> to overhaul drivers/pci/setup-bus.c that I was working on. It will
> release all the boot resources before the initial allocation, and should
> give the system a chance to cleanly assign all resources on the first
> pass / try. The allocation code works well until you use more than one
> pass - then things get very hairy. I just applied it to mine, and now
> everything applies the first pass, with not a single failure to assign.

Do you have some hot-plug enabled slots in your system?
  
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 22aed6cdb..befaef6a8 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1822,8 +1822,16 @@ void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
>   void __init pci_assign_unassigned_resources(void)
>   {
>   	struct pci_bus *root_bus;
> +	struct pci_dev *dev;
>   
>   	list_for_each_entry(root_bus, &pci_root_buses, node) {
> +		for_each_pci_bridge(dev, root_bus) {
> +			pci_bridge_release_resources(dev->subordinate, IORESOURCE_IO);
> +			pci_bridge_release_resources(dev->subordinate, IORESOURCE_MEM);
> +			pci_bridge_release_resources(dev->subordinate, IORESOURCE_MEM_64);
> +			pci_bridge_release_resources(dev->subordinate, IORESOURCE_MEM_64 | IORESOURCE_PREFETCH);
> +		}
> +
>   		pci_assign_unassigned_root_bus_resources(root_bus);
>   
>   		/* Make sure the root bridge has a companion ACPI device */

Thanks. I've applied this patch to my tree without c13704f5 reverted.

Which parameters should I pass to the kernel? I tested with a few versions
and most are not able to mount the rootfs (most likely SATA controller not
probed correctly). Here is the log from one version that did boot to the
prompt. But the resources are not mapped and NVMe is not probed because of
this:

Test g: pci=realloc,pcie_bus_safe
https://filebin.ca/55U8waihXJVI/logs.tar.bz2

Is there another test parameter set that I should test? I can also provide
the logs of the failing boot tests, since I have connected a serial console
to the system. Just let me know.

Thanks,
Stefan

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C810133820
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2020 01:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbgAHAqp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Jan 2020 19:46:45 -0500
Received: from ale.deltatee.com ([207.54.116.67]:55404 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbgAHAqp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Jan 2020 19:46:45 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1iozUc-0003Wh-Ar; Tue, 07 Jan 2020 17:46:39 -0700
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Kit Chow <kchow@gigaio.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <20200108004137.GA66147@google.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <bd548e6d-4af7-45df-98ca-e16596f0cbe2@deltatee.com>
Date:   Tue, 7 Jan 2020 17:46:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200108004137.GA66147@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: mika.westerberg@linux.intel.com, nicholas.johnson-opensource@outlook.com.au, benh@kernel.crashing.org, kchow@gigaio.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, helgaas@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH v4] PCI: Fix disabling of bridge BARs when assigning bus
 resources
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2020-01-07 5:41 p.m., Bjorn Helgaas wrote:
> On Tue, Jan 07, 2020 at 03:51:28PM -0700, Logan Gunthorpe wrote:
>> On 2020-01-07 2:13 p.m., Bjorn Helgaas wrote:
>>> On Tue, Jan 07, 2020 at 12:09:02PM -0700, Logan Gunthorpe wrote:
>>>> One odd quirk of PLX switches is that their upstream bridge port has
>>>> 256K of space allocated behind its BAR0 (most other bridge
>>>> implementations do not report any BAR space). The lspci for such  device
>>>> looks like:
>>>>
>>>>   04:00.0 PCI bridge: PLX Technology, Inc. PEX 8724 24-Lane, 6-Port PCI
>>>>             Express Gen 3 (8 GT/s) Switch, 19 x 19mm FCBGA (rev ca)
>>>> 	    (prog-if 00 [Normal decode])
>>>>       Physical Slot: 1
>>>>       Flags: bus master, fast devsel, latency 0, IRQ 30, NUMA node 0
>>>>       Memory at 90a00000 (32-bit, non-prefetchable) [size=256K]
>>>>       Bus: primary=04, secondary=05, subordinate=0a, sec-latency=0
>>>>       I/O behind bridge: 00002000-00003fff
>>>>       Memory behind bridge: 90000000-909fffff
>>>>       Prefetchable memory behind bridge: 0000380000800000-0000380000bfffff
>>>>       Kernel driver in use: pcieport
>>>>
>>>> It's not clear what the purpose of the memory at 0x90a00000 is, and
>>>> currently the kernel never actually uses it for anything. In most cases,
>>>> it's safely ignored and does not cause a problem.
>>>>
>>>> However, when the kernel assigns the resource addresses (with the
>>>> pci=realloc command line parameter, for example) it can inadvertently
>>>> disable the struct resource corresponding to the bar. When this happens,
>>>> lspci will report this memory as ignored:
>>>>
>>>>    Region 0: Memory at <ignored> (32-bit, non-prefetchable) [size=256K]
>>>>
>>>> This is because the kernel reports a zero start address and zero flags
>>>> in the corresponding sysfs resource file and in /proc/bus/pci/devices.
>>>> Investigation with 'lspci -x', however shows the bios-assigned address
>>>> will still be programmed in the device's BAR registers.
>>>>
>>>> It's clearly a bug that the kernel's view of the registers differs from
>>>> what's actually programmed in the BAR, but in most cases, this still
>>>> won't result in a visibile issue because nothing uses the memory,
>>>> so nothing is affected. However, a big problem shows up when an IOMMU
>>>> is in use: the IOMMU will not reserve this space in the IOVA because the
>>>> kernel no longer thinks the range is valid. (See
>>>> dmar_init_reserved_ranges() for the Intel implementation of this.)
>>>>
>>>> Without the proper reserved range, we have a situation where a DMA
>>>> mapping may occasionally allocate an IOVA which the PCI bus will actually
>>>> route to a BAR in the PLX switch. This will result in some random DMA
>>>> writes not actually writing to the RAM they are supposed to, or random
>>>> DMA reads returning all FFs from the PLX BAR when it's supposed to have
>>>> read from RAM.
>>>>
>>>> The problem is caused in pci_assign_unassigned_root_bus_resources().
>>>> When any resource from a bridge device fails to get assigned, the code
>>>> sets the resource's flags to zero. This makes sense for bridge resources,
>>>> as they will be re-enabled later, but for regular BARs, it disables them
>>>> permanently.
>>>>
>>>> The code in question seems to indent to check if "dev->subordinate" is
>>>> zero to determine whether a device is a bridge, however this is not
>>>> likely valid as there might be a bridge without a subordinate bus due to
>>>> running out of bus numbers or other cases.
>>>>
>>>> To fix these issues we instead check that the idx is in the
>>>> PCI_BRIDGE_RESOURCES range which are only used for bridge windows and
>>>> thus is sufficient for the "dev->subordinate" check and will also
>>>> prevent the bug above from clobbering PLX devices' regular BARs.
>>>
>>> s/bios/BIOS/
>>> s/bar/BAR/
>>> s/visibile/visible/
>>> s/indent/intend/
>>>
>>>> Reported-by: Kit Chow <kchow@gigaio.com>
>>>> Fixes: da7822e5ad71 ("PCI: update bridge resources to get more big ranges when allocating space (again)")
>>>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>>>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>>>> ---
>>>>  drivers/pci/setup-bus.c | 6 +++++-
>>>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>>>
>>>> This patch was last submitted back in June as part of a series. I've
>>>> dropped the first patch in the series as a similar patch from Nicholas
>>>> takes care of the bug.
>>>>
>>>> As a reminder, the previous discussion on this patch is here[1]. Per the
>>>> feedback, I've updated the patch to remove the check on
>>>> "dev->subordinate" entirely.
>>>>
>>>> The patch is based on v5.5-rc5 and a git branch is available here:
>>>>
>>>> https://github.com/sbates130272/linux-p2pmem pci_realloc_v4
>>>>
>>>> [1] https://lore.kernel.org/linux-pci/20190617135307.GA13533@google.com/
>>>>
>>>> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
>>>> index f279826204eb..23f6c95f3fd7 100644
>>>> --- a/drivers/pci/setup-bus.c
>>>> +++ b/drivers/pci/setup-bus.c
>>>> @@ -1803,11 +1803,15 @@ void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
>>>>  	/* Restore size and flags */
>>>>  	list_for_each_entry(fail_res, &fail_head, list) {
>>>>  		struct resource *res = fail_res->res;
>>>> +		int idx;
>>>>
>>>>  		res->start = fail_res->start;
>>>>  		res->end = fail_res->end;
>>>>  		res->flags = fail_res->flags;
>>>> -		if (fail_res->dev->subordinate)
>>>> +
>>>> +		idx = res - &fail_res->dev->resource[0];
>>>> +		if (idx >= PCI_BRIDGE_RESOURCES &&
>>>> +		    idx <= PCI_BRIDGE_RESOURCE_END)
>>>>  			res->flags = 0;
>>>
>>> So I guess previously, for everything on the fail_head list, we
>>> restored flags/start/end *and* we cleared flags for every BAR and
>>> window of a bridge.
>>>
>>> Now we'll clear flags for only for bridge windows.  I'm sure that was
>>> the original intent, but I don't see why we bother.  The next thing we
>>> do is go back to "again", where we call __pci_bus_size_bridges(),
>>> where we immediately call pci_bridge_check_ranges(), which recomputes
>>> the flags.
>>>
>>> Is there actually any point in clearing res->flags, or could we just
>>> do this:
>>
>> Hmm, well removing the check doesn't seem to cause any problems on my
>> test box. But I'm not very confident that it's not required for some
>> corner case. It was clearly added by someone for a reason that is not
>> clear based on the information I can find in git blame.
>>
>> I don't agree that pci_bridge_check_ranges() recomputes the flags... it
>> only sets specific flags. So zeroing the flags may be intended to clear
>> other flags like IORESOURCE_STARTALIGN or IORESOURCE_SIZEALIGN; though
>> it's not super clear to me how those are used either.
>>
>> So I'd personally prefer to err on the side of caution here and not
>> introduce any new subtle bugs.
> 
> OK, I hate maintaining this sort of black magic code, but that's a
> fair point, and we don't have to fix everything at once.

Yes, I can feel that pain. It's hard enough trying to fix bugs in it.
Seems like we need to get a unit testing suite for it built up so we can
at least have some way to know if changes are acceptable. I keep hearing
about bios bugs that are triggering other bugs in this code (some
fixable and some not) and they're hard to deal with because of the mess.
But that's a ton of work and I don't have the time to tackle it.

> pci_assign_unassigned_root_bus_resources() and
> pci_assign_unassigned_bridge_resources() both have this code fragment,
> and I *assume* both should be changed?

Oh, yes, that's probably true. I'll add that, fix up the nits above and
send a v5 later this week.

Logan


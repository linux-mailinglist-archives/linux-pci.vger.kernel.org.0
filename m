Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20E7258732
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2019 18:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfF0QfQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jun 2019 12:35:16 -0400
Received: from ale.deltatee.com ([207.54.116.67]:36460 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726542AbfF0QfQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Jun 2019 12:35:16 -0400
Received: from s01061831bf6ec98c.cg.shawcable.net ([68.147.80.180] helo=[192.168.6.132])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hgXMg-0002q6-NP; Thu, 27 Jun 2019 10:35:15 -0600
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <SL2P216MB01874DFDDBDE49B935A9B1B380E50@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <e768271e-9455-2a3d-ad76-4a6d9c71d669@deltatee.com>
 <SL2P216MB01872DFDDA9C313CA43C7B3280E40@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <024eec86-dfb9-0a23-6385-9e8dfe9a0381@deltatee.com>
 <SL2P216MB0187340941F03A5A03625F4F80E10@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <442c6b35a1aab9833fd2942b499d4fb082a71a15.camel@kernel.crashing.org>
 <dc631e87-099f-3354-5477-b95e97e55d3f@deltatee.com>
 <SL2P216MB01875C9CB93E6B39846749B280FD0@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <e2eec9dc-5eef-62ba-6251-f420d6579d03@deltatee.com>
Date:   Thu, 27 Jun 2019 10:35:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <SL2P216MB01875C9CB93E6B39846749B280FD0@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.80.180
X-SA-Exim-Rcpt-To: linux-pci@vger.kernel.org, bhelgaas@google.com, benh@kernel.crashing.org, nicholas.johnson-opensource@outlook.com.au
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_EXCLUSIVE autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: Multitude of resource assignment functions
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-06-27 1:40 a.m., Nicholas Johnson wrote:
> On Mon, Jun 24, 2019 at 10:45:17AM -0600, Logan Gunthorpe wrote:
>>
>>
>> On 2019-06-24 3:13 a.m., Benjamin Herrenschmidt wrote:
>>> So I'm staring at these three mostly at this point:
>>>
>>> void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
>>> void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
>>> void pci_assign_unassigned_bus_resources(struct pci_bus *bus)
>>>
>>> Now we have 3 functions that fundamentally have the same purpose,
>>> assign what was left unassigned down a PCI hierarchy, but are going
>>> about it in quite a different manner.
>>>
>>> Now to make things worse, there's little consistency in which one gets
>>> called where. We have PCI controllers calling the first one sometimes,
>>> the last one sometimes, or doing the manual:
>>>
>>> 	pci_bus_size_bridges(bus);
>>> 	pci_bus_assign_resources(bus);
>>>
>>> Or variants with pci_bus_size_bridges sometimes missing etc...
>>
>> I suspect there isn't much rhyme or reason to it. None of this is well
>> documented so developers writing the controller drivers probably didn't
>> have a good idea of what the correct thing to do was, and just stuck
>> with the first thing that worked.
>>
>>> Now I've consolidated a lot of that and removed all of those "manual"
>>> cases in my work-in-progress branch, but I'd like to clarify and
>>> possibly remove the 3 ones above.
>>>
>>> Let's start with the last one, pci_assign_unassigned_bus_resources, as
>>> it's the easiest to remove from users in drivers/pci/controller/* (and
>>> replace with pci_assign_unassigned_root_bus_resources typically).
>>>
>>> This leaves it used in a couple of corner cases, most of them I think
>>> I can kill, and .... sysfs 'rescan'.
>>>
>>> The interesting thing about that function is that it tries to avoid
>>> resizing the bridge of the bus passed as an argument, it will only
>>> resize subordinate bridges. From the changelog it was created for
>>> hotplug bridges, but almost none uses it (some powerpc stuff I can
>>> probably kill) ... and sysfs rescan.
>>>
>>> I wonder what's the remaining purpose of it. sysfs rescan could
>>> probably be cleaned up to use the two first... Also why avoid resizing
>>> the bridge itself ?
>>>
>>> That leads to the difference between
>>> pci_assign_unassigned_root_bus_resources()
>>> and pci_assign_unassigned_bridge_resources().
>>>
>>> The names are misleading. The former isn't just about the root bus
>>> resources. It's about the entire tree underneath the root bus.
>>>
>>> The main difference that I can tell are:
>>>
>>>  - pci_assign_unassigned_root_bus_resources() may or may not try to
>>> realloc, depending on a combination of command line args, config
>>> option, presence of IOV devices etc... while
>>> pci_assign_unassigned_bridge_resources() always will
>>>
>>>  - pci_assign_unassigned_bridge_resources() will call
>>> pci_bridge_distribute_available_resources() to distribute resource to
>>> child hotplug bridges, while pci_assign_unassigned_root_bus_resources()
>>> won't.
>>>
>>> Now, are we 100% confident we want to keep those discrepancies ?
>>>
>>> It feels like the former function is intended for boot time resource
>>> allocation, and the latter for hotplug, but I can't make sense of why
>>> the resources of a device behind a hotplug bridge should be allocated
>>> differently depending on whether that device was plugged at boot or
>>> plugged later.
>>
>> I don't really know, but I kind of assumed reallocing any time but early
>> in boot would be dangerous. It involves un-assigning a bunch of
>> resources without any real check to see if a driver is using them or
>> not. If they were being used by a driver (which is typical) and they
>> were reassigned, everything would break.
>>
>> I mean, in theory the code could/should be the same for both paths and
>> it could just make a single, better decision on whether to realloc or
>> not. But that's going to be challenging to get there.
>>
>>> Also why not distribute available resources at boot between top level
>>> hotplug bridges ?
>>>
>>> I'm not even going into the question of why the resource
>>> sizing/assignment code is so obscure/cryptic/incomprehensible, that's
>>> another kettle of fish, but I'd like to at least clarify the usage
>>> patterns a bit better.
>> I got the impression the code was designed to generally let the firmware
>> set things up -- it just fixed things up if the firmware messed it up
>> somehow. My guess would be it evolved out of a bunch of hacks designed
>> to fix broken bioses into something new platforms used to do full
>> enumeration (because it happened to work).
> Unfortunately, the operating system is designed to let the firmware do 
> things. In my mind, ACPI should not need to exist, and the operating 
> system should start with a clean state with PCI and re-enumerate 
> everything at boot time. The PCI allocation is so broken and 
> inconsistent (as you have noted) because it tries to combine the two, 
> when firmware enumeration and native enumeration should be mutually 
> exclusive. I have attempted to re-write large chunks of probe.c, pci.c 
> and setup-bus.c to completely disregard firmware enumeration and clean 
> everything up. Unfortunately, I get stuck in probe.c with the double 
> recursive loop which assigns bus numbers - I cannot figure out how to 
> re-write it successfully. Plus, I feel like nobody will be ready for 
> such a drastic change - I am having trouble selling minor changes that 
> fix actual use cases, as opposed to code reworking.

My worry would be if the firmware depends on any of those PCI resources
for any of it's calls. For example, laptop firmware often has specific
code for screen blanking/dimming when the special buttons are pressed.
If it implements this by communicating with a PCI device then the kernel
will break things by reassigning all the addresses.

However, having a kernel parameter to ignore the firmware choices might
be a good way for us to start testing whether this is a problem or not
on some systems

Logan

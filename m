Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 591E257E7A
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2019 10:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfF0Isx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jun 2019 04:48:53 -0400
Received: from gate.crashing.org ([63.228.1.57]:41598 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbfF0Isx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Jun 2019 04:48:53 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5R8maeh017918;
        Thu, 27 Jun 2019 03:48:37 -0500
Message-ID: <1a0e2012fd26685819cb1ee83180405717f690be.camel@kernel.crashing.org>
Subject: Re: Multitude of resource assignment functions
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Logan Gunthorpe <logang@deltatee.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Date:   Thu, 27 Jun 2019 18:48:35 +1000
In-Reply-To: <SL2P216MB01875C9CB93E6B39846749B280FD0@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
References: <SL2P216MB01874DFDDBDE49B935A9B1B380E50@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
         <e768271e-9455-2a3d-ad76-4a6d9c71d669@deltatee.com>
         <SL2P216MB01872DFDDA9C313CA43C7B3280E40@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
         <024eec86-dfb9-0a23-6385-9e8dfe9a0381@deltatee.com>
         <SL2P216MB0187340941F03A5A03625F4F80E10@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
         <442c6b35a1aab9833fd2942b499d4fb082a71a15.camel@kernel.crashing.org>
         <dc631e87-099f-3354-5477-b95e97e55d3f@deltatee.com>
         <SL2P216MB01875C9CB93E6B39846749B280FD0@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2019-06-27 at 07:40 +0000, Nicholas Johnson wrote:
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

Well... so a lot of platforms are happy to do a full re-assignment,
though they use the current code today which leads to rather sub
standard results when it comes to hotplug bridges.

All the embedded platforms today are like that,and all of ARM64 though
the latter will somewhat change, all DT based ARM64 will probably
remain that way.

> My next proposal might be a kernel parameter for PCI to set various 
> levels of disregard for firmware

Well, at least ACPI has this _DSM #5 thingy that can tell us that we
are allowed to disregard firmware for selected bits and pieces
(hopefully that tends to be whole hierarchies but I don't know how well
it's used in practice).

> , from none to complete, which can be 
> added to incrementally to do more and more (rather than all in one patch 
> series).

So there are a number of reasons to honor what the firmware did.

First, today (but that's fixable), we suck at setting up reasonable
space for hotplug by default.

But there are more insidious ones. There are platforms where you can't
move things (typically virtualized platforms with specific hypervisors,
such as IBM pseries).

There are platforms where the *runtime* firwmare (SMM or equivalent or
even ACPI AML bits) will be poking at some system devices and those
really must not be moved. (In fact there's a theorical problem with
such devices becoming temporarily inaccessible during BAR sizing today
but we mostly get lucky).

There are other "interesting" cases, like EFI giving us the framebuffer
address to use if we don't have a native driver... which happens to be
off a PCI BAR somewhere. Now we *could* probably try to special case
that and detect when we move that BAR but today we'll probably break if
we move it.

x86 historically has other nasty "hidden" devices. There are historical
cases of devices that break if they move after initial setup, etc...
Most of these things are ancient but we have to ensure we keep today's
policy for old platforms at least.

>  This can supercede pci=realloc. The realloc command is so 
> broken because once the system has loaded drivers, it becomes next to 
> impossible to free and reallocate a resource to fit another device in - 
> because it will upset existing devices. The realloc command is only 
> useful in early boot because nothing is yet assigned, so it works. 
> However, the same effect can be achieved by releasing all the resources 
> on the root port before anything happens. I think it was 
> pci_assign_unassigned_resources(), and I did verify this experimentally. 
> This switch could be part of such a new kernel parameter to ignore 
> firmware influence on PCI.

We should see what ACPI gives us in _DSM #5 on x86 these days.. if it's
meaningful on enough machines we could use that as an indication that a
given tree can be reallocated.

> I hope that somehow we can transition to ignoring the firmware - because 
> firmware and native enumeration need to be mutually exclusive, and we 
> need native enumeration for PCI hotplug. If anybody has any ideas how, I 
> would love to hear.

We'll probably have to live with an "in-between" forever on x86 and
maybe arm64, but with some luck, the static devices will only be the
on-board stuff, and we can go wild below bridges...

BTW: I'd like us to discuss that f2f at Plumbers in a miniconf if
enough of us can go.

Cheers,
Ben.



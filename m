Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97F1337231
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2019 12:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfFFKz3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jun 2019 06:55:29 -0400
Received: from gate.crashing.org ([63.228.1.57]:50408 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbfFFKz3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Jun 2019 06:55:29 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x56At7ja032099;
        Thu, 6 Jun 2019 05:55:08 -0500
Message-ID: <4b956e0679b4b4f4d0f0967522590324d15593fb.camel@kernel.crashing.org>
Subject: Re: [PATCH/RESEND] arm64: acpi/pci: invoke _DSM whether to preserve
 firmware PCI setup
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "Zilberman, Zeev" <zeev@amazon.com>,
        "Saidi, Ali" <alisaidi@amazon.com>
Date:   Thu, 06 Jun 2019 20:55:07 +1000
In-Reply-To: <CAKv+Gu_3Nb5mPZgRfx+wQSz+eWM+FSbw_14fHm+u=v2EbuYoGQ@mail.gmail.com>
References: <56715377f941f1953be43b488c2203ec090079a1.camel@kernel.crashing.org>
         <20190604014945.GE189360@google.com>
         <960c94eb151ba1d066090774621cf6ca6566d135.camel@kernel.crashing.org>
         <20190604124959.GF189360@google.com>
         <e520a4269224ac54798314798a80c080832e68b1.camel@kernel.crashing.org>
         <d53fc77e1e754ddbd9af555ed5b344c5fa523154.camel@kernel.crashing.org>
         <CAKv+Gu_3Nb5mPZgRfx+wQSz+eWM+FSbw_14fHm+u=v2EbuYoGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2019-06-06 at 11:13 +0200, Ard Biesheuvel wrote:
> > Bjorn: I haven't made the claim path the default in absence of _DSM #5 yet.
> > I suggest we do that as a separate patch in case it breaks somebody, thus
> > making bisection more meaningful. It will also make this one more palatable
> > to distros since it won't change the behaviour on systems without _DSM #5,
> > and we verified nobody has it except Seattle which returns 1.
> > 
> 
> FYI Seattle is broken in any case since it returns Package(1) rather
> than just an int.

Great .... not. Do we care ?

> The problem with this patch is that currently, the PCI fw spec permits
> _DSM #5 everywhere *except* on the host bridge device object itself,
> and this is in the process of being changed.

Yes, I'm indirectly aware of that :)

> I will leave it up to the maintainers to decide whether we can take
> this patch in anticipation of that, even though it doesn't deal with
> _DSM #5 on nodes anywhere else in the PCIe tree.

Right, so the problem at this point is that dealing with it elsewhere
in the tree is very fragile and problematic (see my other messages).
Doing it at the host bridge level fixes the immediate problem for us
(provided we are ok anticipating the spec update), and doesn't preclude
also honoring it for individual devices later on.

My thinking is if we converge everybody toward the x86 method of doing
a 2 pass survey of existing resources followed by assign_unassigned,
and have that the main generic code path (with added quirks to force a
full assignment and keeping probe_only around but that's easy, we have
that on powerpc and our code is originally based on the x86 one), then
we'll have a much easier time supporting IORESOURCE_PCI_FIXED on
portions of the tree as well (though it also becomes less critical to
do so since we will no longer reallocate unless we have to).

That said we need to understand what "fixed" means and why we do it.

IE, If an endpoint somehere has "fixed" BARs for example, that means
all parent bridge must be setup to enclose that range.

Now our allocator for bridge windows cannot handle that and probably
never will, so we have to rely on the existing window established by
the FW being reasonable and use it. We can still *extend" bridge
windows (and we have code to do that) if necessary but we cannot move
them if they contain a fixed BAR device.

There is a much bigger discussion to be had around that concept of
fixed device anyway, maybe at Plumbers ? Why is the BAR fixed ? Because
the EFI FB is on it ? Because HW bugs ? Because FW might access it from
SMM or ARM equivalent ? Because ACPI will poke at it based on its
initial address ? etc...

Some of the answers to the above questions imply more than the need to
fix the BAR: Does it also mean that disabling access to that BAR, even
temporarily, isn't safe ? However that's what we do today when we
probe, if anything, to do the BAR sizing...

This isn't a new problem. We had issues like that dating back 15 years
on powerpc for example, where a big ASIC hanging off PCI had all the
Apple gunk including the interrupt controller, which was initialized
from the DT way before PCI probing. If you took an interrupt at the
"wrong" time during BAR sizing, kaboom ! If you had debug printk's in
the wrong place in the PCI probing code, kaboom ! etc....

If we want to solve that properly in the long run, we'll probably want
ACPI to tell us the BAR sizes and use that instead of doing manual
sizing on such "system" devices. We similarily have ways to "construct"
pci_dev's from the OF tree on sparc64 and powerpc, limiting direct
config access to populate stuff we can't get from FW.

Cheers,
Ben.



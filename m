Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9915C44FD7
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2019 01:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfFMXHt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 19:07:49 -0400
Received: from gate.crashing.org ([63.228.1.57]:37646 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727060AbfFMXHt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Jun 2019 19:07:49 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5DN7ZDZ014484;
        Thu, 13 Jun 2019 18:07:36 -0500
Message-ID: <e6c7854ae360be513f6f43729ed6d4052e289376.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH v2] arm64: acpi/pci: invoke _DSM whether to preserve
 firmware PCI setup
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Sinan Kaya <okaya@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Fri, 14 Jun 2019 09:07:35 +1000
In-Reply-To: <20190613190248.GH13533@google.com>
References: <5783e36561bb77a1deb6ba67e5a9824488cc69c6.camel@kernel.crashing.org>
         <20190613190248.GH13533@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2019-06-13 at 14:02 -0500, Bjorn Helgaas wrote:
> 
> PCI FW r3.2 says 0 means "the OS must not ignore config done by
> firmware."  That means we must keep the FW configuration intact.

So I tried implementing what you seem to want and it doesn't make sense
imho.

I think the wording of the spec is terrible and doesn't convey the
intent here.

What is it that _DSM #5 is about ? Is it about telling us that the FW
config shall not be trusted ? That seem to be its original intent based
on the existing wording and the fact that "1" says "may ignore".

Or was it always intended to be some kind of inverted logic with 0
meaning that we *must* preserve what FW did ?

But preserving what FW did was always the default for x86 and
Windows... It's just that we happen to do something wrong today on
Linux/ARM64 which is to always reassign everything.

The way Linux resource assignment works accross platforms has generally
been based on one of these 3 methods:

 - The standard x86 method, which is to claim what's there when it
doesn't look completely busted and has been assigned, then assign
what's left. This allows for FW doing partial assignment, and allows to
work around a number of BIOS bugs.

 - The "probe only" method. This was created independently on powerpc
and some other archs afaik. At least for powerpc, the reason for that
is some interesting virtualization cases where we just cannot touch or
change or move anything. The effect is to not reassign even what we
dont like, and not call pci_assign_unassign_resources().

 - The "reassign everything" method. This is used by almost all
embedded patforms accross archs. All arm32, all arm64 today (but we
agree that's wrong), all embedded powerpc etc... This is basically
meant for us not trusting whatever random uboot or other embedded FW,
if any, and do a full from-scratch assignment. There are issues in how
that is implemented accross the various platforms/archs, some for
example still honor existing bus numbers and some don't, but I doubt
it's intentional etc... but that method is there to stay.

Now, the questions are two fold

  - How do we map _DSM #5 to these, at least on arm64, maybe in the
long run we can also look at affecting x86, but that's less urgent.

  - How do I ensure the above fixes my Amazon platform ? :-)

There's one obvious thing here. If we don't want to break existing
things, then the absence of _DSM #5 must not change our existing
behaviour. I think we can all agree on this.

We might explore changing arm64 default behaviour as a second step
since we all agree it's not doing what it should, but we also know that
it will probably break some things so we need to be careful, understand
the issues and work around them. This isn't the scope of the initial
_DSM #5 patch.

That leaves us with the _DSM #5 present cases.

Now we have two values. What do they mean ? As I already said before,
the wording with "must not ignore" and "may ignore" is completely
useless and doesn't tell us a thing about the intention here. We don't
know why the FW folks may have put a given value here, and what they
expect us to do about it.

What we do know is that Seattle returns 1 and needs reassignment, and
we do know that the Amazon platforms return 0 and will want us to not
touch the existing setup.

However, does 1 means "business as usual" or does it mean "reassign
everything" ?

Does 0 means "probe only" ? Or do we still do an assignment pass for
things that the FW may have left unassigned ?

Today in Linux, the "probe only" logic tends to not call
pci_assign_unassigned_resources for example.

From a pure reading of the spec, there's an argument to be made that
both 0 and 1 values can lead to the same code that reads what's there
and reassign what's missing.

So this is a mess, a usual when it comes to specs written by
committees, but at this stage I'm at a loss as to what you want me to
do.

Cheers,
Ben.
 


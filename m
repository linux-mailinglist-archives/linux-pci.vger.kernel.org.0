Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD2845A7C
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2019 12:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfFNKgk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jun 2019 06:36:40 -0400
Received: from gate.crashing.org ([63.228.1.57]:50788 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbfFNKgk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Jun 2019 06:36:40 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5EAaSLf008838;
        Fri, 14 Jun 2019 05:36:29 -0500
Message-ID: <906b2576756e82a54b584c3de2d8362602de07ce.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH v2] arm64: acpi/pci: invoke _DSM whether to preserve
 firmware PCI setup
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Sinan Kaya <okaya@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 14 Jun 2019 20:36:27 +1000
In-Reply-To: <20190614095742.GA27188@e121166-lin.cambridge.arm.com>
References: <5783e36561bb77a1deb6ba67e5a9824488cc69c6.camel@kernel.crashing.org>
         <20190613190248.GH13533@google.com>
         <e6c7854ae360be513f6f43729ed6d4052e289376.camel@kernel.crashing.org>
         <CAKv+Gu95pQ7_OfLbEXHZ_bhYnqOgTBKCmTgqUY27un-Y708BgQ@mail.gmail.com>
         <d5d3e7b9553438482854c97e09543afb7de23eaa.camel@kernel.crashing.org>
         <20190614095742.GA27188@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 2019-06-14 at 10:57 +0100, Lorenzo Pieralisi wrote:
> > Also using "probe_only" for _DSM #5 = 0 isn't a good idea, at least as
> > implemented today in the rest of the kernel, probe_only also means we
> > shouldn't assign what was left unassigned. However _DSM #5 allows this.
> 
> I am not sure about this. PCI_PROBE_ONLY cannot stop an OS from
> reassigning BARs that are clearly misconfigured, it does not make
> any sense.

PCI_PROBE_ONLY is a linux thing which, as implemented today, implies no
assignment at all. I believe it originates as a merge of variants of
the same thing, at least one of them being one I created for powerpc
back in the days due to our proprietary hypervisor not letting you
touch any of the PCI config space.

If a device looks broken, disable it, don't use it, but don't reassign
either. At least that the semantics we have today. And as such they
don't match _DSM #5 = 0.

> It can't stop an OS from writing those BARs anyway,
> since they must be sized, why firmware would prevent an OS from
> reassigning BARs that are programmed with values that can be
> deemed 100% bogus ? Or put it differently, why must an OS preserve
> those values willy-nilly ?

Don't ask me ... IBM firmware :-) At least that was the idea back then.

That said I suppose some platforms may also have set that flag to
indicate that they aren't sure what other "ghost" things might be
in the address space, ie Linux doesnt have a clear view of what's
free to allocate devices to for example.

> For me, PCI_PROBE_ONLY and _DSM == 0 on a host bridge must be considered
> equivalent.

Well, that's not what PCI_PROBE_ONLY is today in Linux. It might be
what you would like it to be but it's not what it is :-) And I'd like
to avoid making arm64 different than everybody else here because I want
to consolidate things.

Fundamentally, is what _DSM #5 == 0 does any different from our
standard (not PROBE_ONLY) mode of operation on server platforms anyway
? Ie, we read what's there, and we leave it alone unless it's broken or
unassigned ? This is precisely the definition of _DSM #5 == 0 no ?

PROBE_ONLY is .. something else.

> I agree with Bjorn on his reading of _DSM #5 and I think that
> the original patch that claims on _DSM #5 == 0 is a good
> starting point.

The original patch is a good starting point, we agree. The only point
of disagreement with Bjorn at this stage is what the "default" is in
absence of _DSM #5.

The spec says it should be the same as _DSM #5 == 0, but we know today
it will introduce a much wider ranging change to arm64 to treat it that
way. At the very least, changing the default should be a different
patch.

>  I would like to make it a default even without
> _DSM #5 == 0 so that claim and reassign on claim failure works
> irrespective of _DSM #5, it is now or never, I think we can give
> it a shot, with an incremental patch.

We should. In fact, I was thinking about it on the way home tonight and
was going to ask you and Ard to try this out and send me the debug
level log output of anything that looks wrong on any platform:

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index bb85e2f4603f..0af1f1b4e4d8 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -193,8 +193,8 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 	if (!bus)
 		return NULL;
 
-	pci_bus_size_bridges(bus);
-	pci_bus_assign_resources(bus);
+	pci_bus_claim_resources(bus);
+	pci_assign_unassigned_root_bus_resources(bus);
 
 	list_for_each_entry(child, &bus->children, node)
 		pcie_bus_configure_settings(child);

Cheers,
Ben.



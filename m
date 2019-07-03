Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1CBA5E662
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2019 16:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfGCOTN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jul 2019 10:19:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:55100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbfGCOTN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Jul 2019 10:19:13 -0400
Received: from localhost (84.sub-174-234-39.myvzw.com [174.234.39.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 830B521881;
        Wed,  3 Jul 2019 14:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562163551;
        bh=TOI2UbmjAOF7VuL8bRp/vefYCFnzpOnxFE5nZX/jNfA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HEg+SGleVnD+45dm7VkB27F8KnWy/laKKP2i+8GdUEvYSGWz9RcR/op/7UWF4Zgt+
         Pt8ouixOIOhQ9v665SxNA37YYiHPs/q4S+Sx5guNLGEHj4fWCzeaBfmAmtW79xqS0E
         umOj4f2ps3d5L5fPc/HVUXhKlqTrChUz+b/3tszo=
Date:   Wed, 3 Jul 2019 09:19:09 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Multitude of resource assignment functions
Message-ID: <20190703141909.GM128603@google.com>
References: <SL2P216MB01872DFDDA9C313CA43C7B3280E40@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <024eec86-dfb9-0a23-6385-9e8dfe9a0381@deltatee.com>
 <SL2P216MB0187340941F03A5A03625F4F80E10@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <442c6b35a1aab9833fd2942b499d4fb082a71a15.camel@kernel.crashing.org>
 <dc631e87-099f-3354-5477-b95e97e55d3f@deltatee.com>
 <SL2P216MB01875C9CB93E6B39846749B280FD0@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <e2eec9dc-5eef-62ba-6251-f420d6579d03@deltatee.com>
 <SL2P216MB0187E659CFF6F9385E92838680FE0@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <20190702213951.GF128603@google.com>
 <SL2P216MB01878623FC34BC4894EB495280FB0@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SL2P216MB01878623FC34BC4894EB495280FB0@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 03, 2019 at 01:43:52PM +0000, Nicholas Johnson wrote:
> On Tue, Jul 02, 2019 at 04:39:51PM -0500, Bjorn Helgaas wrote:
> > On Sun, Jun 30, 2019 at 02:57:37AM +0000, Nicholas Johnson wrote:
> > 
> > > - Should pci=noacpi imply pci=nocrs? It does not appear to, and I feel 
> > > like it should, as CRS is part of ACPI and relates to PCI.
> > 
> > "pci=noacpi" means "Do not use ACPI for IRQ routing or for PCI
> > scanning."
> > 
> > "pci=nocrs" means "Ignore PCI host bridge windows from ACPI."  If we
> > ignore _CRS, we have no idea what the PCI host bridge apertures are,
> > so we cannot allocate resources for devices on the root bus.
>
> But I use pci=nocrs (it is non-negotiable for assigning massive 
> MMIO_PREF with kernel parameters) and it does work. If I use pci=nocrs, 
> then the whole physical address range of the CPU goes to the root 
> complex (for example, 39-bit physical address lines on quad-core Intel 
> is 512G). I am guessing that the OS makes sure that when assigning root 
> port windows, we do not clobber the physical RAM so that any RAM 
> addresses pass straight through the root complex. I have never had funny 
> crashes that would make me think I have clobbered the RAM with nocrs. If 
> I push the limits then it fails to assign root port resources as 
> expected. Usually I assign 64G size to each Thunderbolt port for total 
> of 256G over four ports. It is total overkill but it gives me 
> satisfaction to know that the firmware is definitely not in control and 
> that if it is needed, it can be requested. For a production system, I 
> would likely tone it down a little.

"pci=nocrs" happens to work on many machines, but the _CRS information
is definitely required on many others.  For example, on any machine
with multiple host bridges, we need to know the actual host bridge
apertures to correctly assign resources to hot-added devices.

> > The "Do not use ACPI for ... PCI scanning" part indeed does suggest
> > that "pci=noacpi" could imply "pci=nocrs", but I don't think there's
> > anything to be gained by changing that now.
> > 
> > We probably *should* remove "or for PCI scanning" from the
> > documentation, because "pci=noacpi" only affects IRQs.
> > 
> > The only reason these exist at all is as a debugging aid to
> > temporarily work around issues in firmware or Linux until we can
> > develop a real fix or quirk that works without the user specifying a
> > kernel parameter.
> > 
> > > - Does anybody know why with pci=noacpi, you get dmesg warnings about 
> > > cannot find PCI int A mapping - but they do not seem to cause the 
> > > devices any issues in functioning? Is it because they are using MSI?
> > 
> > I doubt it.  I think you're just lucky.  In general the information
> > from _PRT and _CRS is essential for correct operation.
>
> Strange, because there are dozens of these warnings on multiple 
> computers and heaps of devices on Thunderbolt. If the BARs are assigned 
> then they work, every time, no questions asked. Maybe this suggests that 
> Thunderbolt is somehow exempt. Perhaps the controller has kept 
> configuration from the firmware setup and everything behind it does not 
> care.

Thunderbolt is not exempt.  _PRT tells us where INTx wires from PCI
are connected.  On systems with multiple host bridges, there are
multiple sets of those wires.  Your many examples of systems where
things seem to work are not arguments for it being safe to ignore _PRT
and _CRS in general.

> > > - Does pci=ignorefw sound good for a future proposal?
> > 
> > No, at least not without more description of what this would
> > accomplish.
> I have not given it much time and thought but basically it will be 
> something that can be added to incrementally. I would start with it 
> implying nocrs and releasing all root complex resources at boot before 
> the initial scan. That way we can see if the particular platform cares 
> if we do everything in the kernel.
> 
> > It sounds like you would want this to turn off _PRT, _CRS, and other
> > information from ACPI.  You may not like ACPI, but that information is
> > there for good reason, and if we didn't get it from ACPI we would have
> > to get it from somewhere else.
>
> The nocrs is vital because the BIOS places pitiful space behind the root 
> complex and will fail for assigning large BARs - hence why Xeon Phi 
> coprocessors with 8G or 16G BARs to map their whole RAM are only 
> supported on certain systems. I consider all BIOS / firmware to be 
> broken at this time, especially with most still catering for 32-bit OS 
> that almost nobody uses. I know not everybody feels that way, but I am 
> an idealist and aim to move things in the right direction.

Fine.  You can boot with "pci=nocrs" all you want, but it's not safe
in general.

The problem of BIOS not reporting enough space for the root complex is
a BIOS issue.  The host bridge _CRS should report all the space routed
to the host bridge.  If it doesn't, that's a BIOS issue.  In principle
Linux could work around that by reading the hardware registers that
control the host bridge apertures, but that would require Linux to
know how to program every host bridge of interest.  We don't have or
want that sort of code in Linux because it would be a huge maintenance
burden.

> I would accept ACPI if it were just a collection of tables, memory 
> mapped like MMCONFIG. I know there are more complicated things that 
> require bytecode to run (although I do assert my belief that it should 
> be avoided if possible) but if the static tables were moved out of ACPI 
> then in my mind, it would be progress.
> 
> Is there a reason why PCI SIG could not add a future extension where all 
> of this information can be accessed with an extended MMCONFIG address 
> range?

For one thing, we don't know where MMCONFIG space lives.  We learn
that from the static MCFG table.

Bjorn

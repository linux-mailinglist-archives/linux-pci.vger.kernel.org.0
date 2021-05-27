Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63821393411
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 18:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236189AbhE0Qg2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 12:36:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:56346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235001AbhE0Qg1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 May 2021 12:36:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 82F8A61077;
        Thu, 27 May 2021 16:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622133293;
        bh=IsdX7aBRh7T+5Cs2YQCUr1eculVqE7cgTlmKcUzghtw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=pW8dEcGvcslftdvA+7SeEV3shWhIBt1vMtAdU2jrFJ0oB5h3Fvh5hmWpF8MoKf70L
         7xEivnA7j+jZ0t57MfE3t7gn5fRR/95frbZ61OqucjNanqwlFuEU9xh/Ru3gq2PXpp
         jb6jcIRF325vcvmXuRiawNXjQ8UUqHrNY5cmMC4k8HWEBvN1PsQFCmf8cLkjqRvzJ0
         bDY5FQQqOJn/te1373BWCf4GrJd29C9XwbGWZ+4JC9K8E+8zcvWkag2ipyw717PfrW
         6s9nyyZi9JTX09x4j+ngJX1f3aJY/RdG/gre9KEfPDBPHW1LJroW4FzPNLwNYvjpPE
         IEmcX21+d414A==
Date:   Thu, 27 May 2021 11:34:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Will Deacon <will@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] Revert "arm64: PCI: Exclude ACPI "consumer"
 resources from host bridge windows"
Message-ID: <20210527163452.GA1402454@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527093200.GA16444@lpieralisi>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 27, 2021 at 10:32:00AM +0100, Lorenzo Pieralisi wrote:
> On Wed, May 26, 2021 at 09:58:36PM +0100, Will Deacon wrote:
> > On Tue, May 11, 2021 at 01:40:20AM +0200, Maximilian Luz wrote:
> > > The Microsoft Surface Pro X has host bridges defined as
> > > 
> > >     Name (_HID, EisaId ("PNP0A08") /* PCI Express Bus */)  // _HID: Hardware ID
> > >     Name (_CID, EisaId ("PNP0A03") /* PCI Bus */)  // _CID: Compatible ID
> > > 
> > >     Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
> > >     {
> > >         Name (RBUF, ResourceTemplate ()
> > >         {
> > >             Memory32Fixed (ReadWrite,
> > >                 0x60200000,         // Address Base
> > >                 0x01DF0000,         // Address Length
> > >                 )
> > >             WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
> > >                 0x0000,             // Granularity
> > >                 0x0000,             // Range Minimum
> > >                 0x0001,             // Range Maximum
> > >                 0x0000,             // Translation Offset
> > >                 0x0002,             // Length
> > >                 ,, )
> > >         })
> > >         Return (RBUF) /* \_SB_.PCI0._CRS.RBUF */
> > >     }
> > > 
> > > meaning that the memory resources aren't (explicitly) defined as
> > > "producers", i.e. host bridge windows.
> > > 
> > > Commit 8fd4391ee717 ("arm64: PCI: Exclude ACPI "consumer" resources from
> > > host bridge windows") introduced a check that removes such resources,
> > > causing BAR allocation failures later on:
> > > 
> > >     [ 0.150731] pci 0002:00:00.0: BAR 14: no space for [mem size 0x00100000]
> > >     [ 0.150744] pci 0002:00:00.0: BAR 14: failed to assign [mem size 0x00100000]
> > >     [ 0.150758] pci 0002:01:00.0: BAR 0: no space for [mem size 0x00004000 64bit]
> > >     [ 0.150769] pci 0002:01:00.0: BAR 0: failed to assign [mem size 0x00004000 64bit]
> > > 
> > > This eventually prevents the PCIe NVME drive from being accessible.
> > > 
> > > On x86 we already skip the check for producer/window due to some history
> > > with negligent firmware. It seems that Microsoft is intent on continuing
> > > that history on their ARM devices, so let's drop that check here too.
> > > 
> > > Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
> > > ---
> > > 
> > > Please note: I am not sure if this is the right way to fix that, e.g. I
> > > don't know if any additional checks like on IA64 or x86 might be
> > > required instead, or if this might break things on other devices. So
> > > please consider this more as a bug report rather than a fix.
> > > 
> > > Apologies for the re-send, I seem to have unintentionally added a blank
> > > line before the subject.
> > > 
> > > ---
> > >  arch/arm64/kernel/pci.c | 14 --------------
> > >  1 file changed, 14 deletions(-)
> > 
> > Adding Lorenzo to cc, as he'll have a much better idea about this than me.
> > 
> > This is:
> > 
> > https://lore.kernel.org/r/20210510234020.1330087-1-luzmaximilian@gmail.com
> 
> Sigh. We can't apply this patch since it would trigger regressions on
> other platforms (IIUC the root complex registers would end up in the
> host bridge memory windows).
> 
> I am not keen on reverting commit 8fd4391ee717 because it does the
> right thing.
> 
> I think this requires a quirk and immediate reporting to Microsoft.
> 
> Bjorn, what are your thoughts on this ?

In retrospect, I think 8fd4391ee717 (which I wrote), was probably a
mistake.

Sure, it's a nice idea to have PNP0A03 _CRS methods that work nicely
as designed, by describing host bridge registers as "consumer"
resources and host bridge windows as "producer" registers, instead of
having the bridge registers in _CRS of an unrelated PNP0C02 device.

But realistically, the PNP0A03/PNP0C02 issue is a solved problem, even
though it's ugly, and I'm not sure why I thought Microsoft would see
value in doing this differently on arm64 than on x86 and ia64.

What would break if we reverted 8fd4391ee717?  I guess any arm64
platforms that described host bridge register space in PNP0A03 _CRS
"consumer" resources?  And Windows probably doesn't work or isn't
supported on those platforms?

Bjorn

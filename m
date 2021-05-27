Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F006392AD3
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 11:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235720AbhE0Jdl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 05:33:41 -0400
Received: from foss.arm.com ([217.140.110.172]:54734 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235820AbhE0Jdk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 May 2021 05:33:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66FED13A1;
        Thu, 27 May 2021 02:32:07 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 13B963F73D;
        Thu, 27 May 2021 02:32:05 -0700 (PDT)
Date:   Thu, 27 May 2021 10:32:00 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Will Deacon <will@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] Revert "arm64: PCI: Exclude ACPI "consumer"
 resources from host bridge windows"
Message-ID: <20210527093200.GA16444@lpieralisi>
References: <20210510234020.1330087-1-luzmaximilian@gmail.com>
 <20210526205836.GA20320@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526205836.GA20320@willie-the-truck>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 26, 2021 at 09:58:36PM +0100, Will Deacon wrote:
> On Tue, May 11, 2021 at 01:40:20AM +0200, Maximilian Luz wrote:
> > The Microsoft Surface Pro X has host bridges defined as
> > 
> >     Name (_HID, EisaId ("PNP0A08") /* PCI Express Bus */)  // _HID: Hardware ID
> >     Name (_CID, EisaId ("PNP0A03") /* PCI Bus */)  // _CID: Compatible ID
> > 
> >     Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
> >     {
> >         Name (RBUF, ResourceTemplate ()
> >         {
> >             Memory32Fixed (ReadWrite,
> >                 0x60200000,         // Address Base
> >                 0x01DF0000,         // Address Length
> >                 )
> >             WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
> >                 0x0000,             // Granularity
> >                 0x0000,             // Range Minimum
> >                 0x0001,             // Range Maximum
> >                 0x0000,             // Translation Offset
> >                 0x0002,             // Length
> >                 ,, )
> >         })
> >         Return (RBUF) /* \_SB_.PCI0._CRS.RBUF */
> >     }
> > 
> > meaning that the memory resources aren't (explicitly) defined as
> > "producers", i.e. host bridge windows.
> > 
> > Commit 8fd4391ee717 ("arm64: PCI: Exclude ACPI "consumer" resources from
> > host bridge windows") introduced a check that removes such resources,
> > causing BAR allocation failures later on:
> > 
> >     [ 0.150731] pci 0002:00:00.0: BAR 14: no space for [mem size 0x00100000]
> >     [ 0.150744] pci 0002:00:00.0: BAR 14: failed to assign [mem size 0x00100000]
> >     [ 0.150758] pci 0002:01:00.0: BAR 0: no space for [mem size 0x00004000 64bit]
> >     [ 0.150769] pci 0002:01:00.0: BAR 0: failed to assign [mem size 0x00004000 64bit]
> > 
> > This eventually prevents the PCIe NVME drive from being accessible.
> > 
> > On x86 we already skip the check for producer/window due to some history
> > with negligent firmware. It seems that Microsoft is intent on continuing
> > that history on their ARM devices, so let's drop that check here too.
> > 
> > Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
> > ---
> > 
> > Please note: I am not sure if this is the right way to fix that, e.g. I
> > don't know if any additional checks like on IA64 or x86 might be
> > required instead, or if this might break things on other devices. So
> > please consider this more as a bug report rather than a fix.
> > 
> > Apologies for the re-send, I seem to have unintentionally added a blank
> > line before the subject.
> > 
> > ---
> >  arch/arm64/kernel/pci.c | 14 --------------
> >  1 file changed, 14 deletions(-)
> 
> Adding Lorenzo to cc, as he'll have a much better idea about this than me.
> 
> This is:
> 
> https://lore.kernel.org/r/20210510234020.1330087-1-luzmaximilian@gmail.com

Sigh. We can't apply this patch since it would trigger regressions on
other platforms (IIUC the root complex registers would end up in the
host bridge memory windows).

I am not keen on reverting commit 8fd4391ee717 because it does the
right thing.

I think this requires a quirk and immediate reporting to Microsoft.

Bjorn, what are your thoughts on this ?

Thanks,
Lorenzo

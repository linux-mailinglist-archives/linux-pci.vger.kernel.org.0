Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498B56476FA
	for <lists+linux-pci@lfdr.de>; Thu,  8 Dec 2022 21:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiLHUHC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Dec 2022 15:07:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiLHUHA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Dec 2022 15:07:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F86771266;
        Thu,  8 Dec 2022 12:06:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9BF88B823DB;
        Thu,  8 Dec 2022 20:06:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D90FC433D2;
        Thu,  8 Dec 2022 20:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670530016;
        bh=0JdI+n8ng00UdgEi/QnaAfoel7rBCSs0S6Kg1jsdyFg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=JQVLcWJ//ZZzDRJUU/xYbj43BhhBeaS5Xj0liW8NpuN62sXbSwHDIf1vcHZ7dOgLU
         XetP7zLXC8OZm01aMfyh4ggeW83zTDjnoFbjDyH0Bbobn/Ti+5N5QhSxqhSZ5tBigm
         yCHhhMVnJY0UA5DVLzHZOCWrrMquf7DFtb3qrPHzBaC1+icDOmJdxLujTuPaHrIrh9
         6RfW+C2JflbfWon19HcPPPjE65cAPGfikNt8sHkv2oyzYOgUEmx1NmbigKtGQ1eVzn
         iu55y5BFjHHIhuFhpOjp6k0vjUJ9isYlediZSirxR6ckkeeIvymvzxBfvSjpiegGbH
         +3RtnmfjV1fJA==
Date:   Thu, 8 Dec 2022 14:06:54 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-pci@vger.kernel.org, Florent DELAHAYE <kernelorg@undead.fr>,
        Konrad J Hambrick <kjhambrick@gmail.com>,
        Matt Hansen <2lprbe78@duck.com>,
        Benoit =?iso-8859-1?Q?Gr=E9goire?= <benoitg@coeus.ca>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        mumblingdrunkard@protonmail.com, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/4] PCI: Continue E820 vs host bridge window saga
Message-ID: <20221208200654.GA1562951@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92359eca-b651-8a1e-6de6-3107d87ac088@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 08, 2022 at 08:16:31PM +0100, Hans de Goede wrote:
> Hi Bjorn,
> 
> On 12/8/22 19:57, Bjorn Helgaas wrote:
> > On Wed, Dec 07, 2022 at 04:31:12PM +0100, Hans de Goede wrote:
> >> On 12/4/22 10:13, Hans de Goede wrote:
> >>
> >> <snip>
> >>
> >>>>> 2. I am afraid that now allowing PCI MMIO space to be allocated
> >>>>> in regions marked as EfiMemoryMappedIO will cause regressions
> >>>>> on some systems. Specifically when I tried something similar
> >>>>> the last time I looked at this (using the BIOS date cut-off
> >>>>> approach IIRC) there was a suspend/resume regression on
> >>>>> a Lenovo ThinkPad X1 carbon (20A7) model:
> >>>>>
> >>>>> https://bugzilla.redhat.com/show_bug.cgi?id=2029207
> >>>>>
> >>>>> Back then I came to the conclusion that the problem is that not
> >>>>> avoiding the EfiMemoryMappedIO regions caused PCI MMIO space to
> >>>>> be allocated in the 0xdfa00000 - 0xdfa10000 range which is
> >>>>> listed in the EFI memmap as:
> >>>>>
> >>>>> [    0.000000] efi: mem46: [MMIO        |RUN|  |  |  |  |  |  |  |  |   |  |  |  |  ] range=[0x00000000dfa00000-0x00000000dfa0ffff] (0MB)
> >>>>>
> >>>>> And with current kernels with the extra logging added for this
> >>>>> the following is logged related to this:
> >>>>>
> >>>>> [    0.326504] acpi PNP0A08:00: clipped [mem 0xdfa00000-0xfebfffff window] to [mem 0xdfa10000-0xfebfffff window] for e820 entry [mem 0xdceff000-0xdfa0ffff]
> >>>>>
> >>>>> I believe patch 1/4 of this set will make this clipping go away,
> >>>>> re-introducing the suspend/resume problem.
> >>>>
> >>>> Yes, I'm afraid you're right.  Comparing the logs at comment #31
> >>>> (fails) and comment #38 (works):
> >>>>
> >>>>   pci_bus 0000:00: root bus resource [mem 0xdfa00000-0xfebfffff window]
> >>>>   pci 0000:00:1c.0: BAR 14: assigned [mem 0xdfa00000-0xdfbfffff] fails
> >>>>   pci 0000:00:1c.0: BAR 14: assigned [mem 0xdfb00000-0xdfcfffff] works
> >>>>
> >>>> Since 0xdfa00000 is included in the host bridge _CRS, but isn't
> >>>> usable, my guess is this is a _CRS bug.
> >>>
> >>> Ack.
> >>>
> >>> So I was thinking to maybe limit the removal of EfiMemoryMappedIO
> >>> regions from the E820 map if they are big enough to cause troubles?
> >>>
> >>> Looking at the EFI map MMIO regions on this Lenovo ThinkPad X1 carbon
> >>> (20A7) model, they are tiny. Where as the ones which we know cause
> >>> problems are huge. So maybe add a bit of heuristics to patch 1/4 based
> >>> on the EfiMemoryMappedIO region size and only remove the big ones
> >>> from the E820 map ?
> >>>
> >>> I know that adding heuristics like this always feels a bit wrong,
> >>> because you end up putting a somewhat arbitrary cut off point in
> >>> the code on which to toggle behavior on/off, but I think that in
> >>> this case it should work nicely given how huge the EfiMemoryMappedIO
> >>> regions which are actually causing problems are.
> > 
> > I'll post a v2 that removes only regions 256KB or larger in a minute.
> 
> Ok, may I ask why 256KB?
> 
> I see that that rules out then troublesome MMIO regions from the X1 carbon from:
> https://bugzilla.redhat.com/show_bug.cgi?id=2029207 :
> efi: mem46: [MMIO|RUN|  ] range=[0xdfa00000-0xdfa0ffff] (0MB) [64K]
> which we know we need to avoid / keep reserved.
> 
> But OTOH the reservations which are causing the problems with assigning
> resources to PCI devices by Linux look like this:
> efi: mem50: [MMIO        |RUN|  |  |  |  |  |  |  |  |   |  |  |  |UC] range=[0x0000000065400000-0x00000000cfffffff] (1708MB)
> which is significantly larger then 256KB.
> 
> So we could e.g. also put the cut-off point at 16MB and still
> remove the above troublesome reservation from the E820 table.
> Note just thinking out loud here. I have no idea if 16MB
> would be better...

No good reason for 256KB.  We know it needs to be at least 64KB for
the X1 Carbon.  I picked 4x bigger just for headroom, since I assume
the 64KB is platform-specific host bridge registers or something.  Do
you think a bigger number would be better, i.e., we would retain more
MMIO things in E820?

ECAM areas would be 1MB per bus, so between 1MB and 256MB.  Those areas
*should* be reserved by PNP0C02 _CRS, but IIRC the early MMCONFIG code
checks E820, and the late code checks for _CRS.  I guess one could
argue that ignoring those, e.g., by retaining anything 256MB or
smaller in E820, would reduce the amount of change.  

But if the host bridge _CRS includes 256MB of legitimate window that
EFI says is MMIO and is hence included in E820, that seems like kind
of a lot of usable window space to give up.

> ...
> Sorry for the confusion. What I was trying to say is that I was interested
> in seeing if we could use the "RUN" flag to differentiate between:
> 
> 1. The big MMIO region which we want to remove from the e820 map:
>    efi: mem50: [MMIO        |RUN|  |  |  |  |  |  |  |  |   |  |  |  |UC] range=[0x0000000065400000-0x00000000cfffffff] (1708MB)
> 
> 2. The small MMIO region which we want to keep to avoid the reported suspend/resume issue:
>    efi: mem46: [MMIO|RUN|  ] range=[0xdfa00000-0xdfa0ffff] (0MB) [64K]
> 
> But unfortunately both have the RUN flag set so the RUN flag is
> of no use to us.

Right, makes sense.

Bjorn

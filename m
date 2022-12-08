Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF8C6475D5
	for <lists+linux-pci@lfdr.de>; Thu,  8 Dec 2022 19:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiLHS6F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Dec 2022 13:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiLHS6E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Dec 2022 13:58:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197A33FBB7;
        Thu,  8 Dec 2022 10:58:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BDFF2B825E5;
        Thu,  8 Dec 2022 18:58:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21017C433EF;
        Thu,  8 Dec 2022 18:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670525880;
        bh=nCQW/TAfu/qWh3tR2O/M4aMAZsexiLEy6mTe/U+oVys=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sDf//vMu6YocNot1R0wlJdzEutvCrQONHgRMwvdZcguqtcQJxFFa3wosBkpdOSQQ0
         qkpJwPqjG8y27wdYUxTket2+jO9tUqn68j8so4xsqHHnm8RXCzIQHWHtocHX/ch6BA
         yRjk2vLj35OLd6xmtM3SzzeyVmpJtSxZWYsbIFHSUJX1n/ihzaLzF6cJC5tMrg8Xhe
         WOETVtP38YhT6WnxFbiRwbliO8pV2G5Wz2kgv68GE/PRISQmcylYgyjYqfvXvKtfBT
         zIAV6NO21Pep2i6pOA6XrUP+7uoKw7hDOGayCGMIgZwj6ZygbqkKa2pKDylN/+/W6z
         1e3dyGFEt/bVg==
Date:   Thu, 8 Dec 2022 12:57:58 -0600
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
Message-ID: <20221208185758.GA1478771@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6da2287f-a2a9-8419-39a5-a3971e4d5499@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 07, 2022 at 04:31:12PM +0100, Hans de Goede wrote:
> On 12/4/22 10:13, Hans de Goede wrote:
> 
> <snip>
> 
> >>> 2. I am afraid that now allowing PCI MMIO space to be allocated
> >>> in regions marked as EfiMemoryMappedIO will cause regressions
> >>> on some systems. Specifically when I tried something similar
> >>> the last time I looked at this (using the BIOS date cut-off
> >>> approach IIRC) there was a suspend/resume regression on
> >>> a Lenovo ThinkPad X1 carbon (20A7) model:
> >>>
> >>> https://bugzilla.redhat.com/show_bug.cgi?id=2029207
> >>>
> >>> Back then I came to the conclusion that the problem is that not
> >>> avoiding the EfiMemoryMappedIO regions caused PCI MMIO space to
> >>> be allocated in the 0xdfa00000 - 0xdfa10000 range which is
> >>> listed in the EFI memmap as:
> >>>
> >>> [    0.000000] efi: mem46: [MMIO        |RUN|  |  |  |  |  |  |  |  |   |  |  |  |  ] range=[0x00000000dfa00000-0x00000000dfa0ffff] (0MB)
> >>>
> >>> And with current kernels with the extra logging added for this
> >>> the following is logged related to this:
> >>>
> >>> [    0.326504] acpi PNP0A08:00: clipped [mem 0xdfa00000-0xfebfffff window] to [mem 0xdfa10000-0xfebfffff window] for e820 entry [mem 0xdceff000-0xdfa0ffff]
> >>>
> >>> I believe patch 1/4 of this set will make this clipping go away,
> >>> re-introducing the suspend/resume problem.
> >>
> >> Yes, I'm afraid you're right.  Comparing the logs at comment #31
> >> (fails) and comment #38 (works):
> >>
> >>   pci_bus 0000:00: root bus resource [mem 0xdfa00000-0xfebfffff window]
> >>   pci 0000:00:1c.0: BAR 14: assigned [mem 0xdfa00000-0xdfbfffff] fails
> >>   pci 0000:00:1c.0: BAR 14: assigned [mem 0xdfb00000-0xdfcfffff] works
> >>
> >> Since 0xdfa00000 is included in the host bridge _CRS, but isn't
> >> usable, my guess is this is a _CRS bug.
> > 
> > Ack.
> > 
> > So I was thinking to maybe limit the removal of EfiMemoryMappedIO
> > regions from the E820 map if they are big enough to cause troubles?
> > 
> > Looking at the EFI map MMIO regions on this Lenovo ThinkPad X1 carbon
> > (20A7) model, they are tiny. Where as the ones which we know cause
> > problems are huge. So maybe add a bit of heuristics to patch 1/4 based
> > on the EfiMemoryMappedIO region size and only remove the big ones
> > from the E820 map ?
> > 
> > I know that adding heuristics like this always feels a bit wrong,
> > because you end up putting a somewhat arbitrary cut off point in
> > the code on which to toggle behavior on/off, but I think that in
> > this case it should work nicely given how huge the EfiMemoryMappedIO
> > regions which are actually causing problems are.

I'll post a v2 that removes only regions 256KB or larger in a minute.

> Looking at the efi=debug output from:
> 
> https://bugzilla-attachments.redhat.com/attachment.cgi?id=1861035
> 
> The small MMIO regions which we most honor as reserved do
> have the "RUN" (runtime) flag set in the EFI mmap.

Just trying to follow along here, so not sure any of the following is
relevant ...

This attachment is from
https://bugzilla.redhat.com/show_bug.cgi?id=2029207, and it shows:

  efi: mem46: [MMIO|RUN|  ] range=[0xdfa00000-0xdfa0ffff] (0MB) [64K]
  efi: mem47: [MMIO|RUN|UC] range=[0xf80f8000-0xf80f8fff] (0MB)  [4K]
  pci_bus 0000:00: root bus resource [mem 0xdfa00000-0xfebfffff window]
  pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed4bfff window]

mem46 is included in the PNP0A08 _CRS, and Ivan has verified
experimentally that we have to avoid it.

mem47 is also included in the _CRS, but I don't have a clue what it
is.  Maybe some hidden device used by BIOS but not visible to us?

> But I'm afraid that the same applies to the troublesome
> MMIO EFI regions which cause the failures to assign
> PCI regions for devices not setup by the firmware:
> 
> https://bugzilla-attachments.redhat.com/attachment.cgi?id=1861407
> 
> So that "RUN" flag is of no use.

I don't know what bug this attachment is from.

Is the point here that you considered doing the E820 removal based on
the EFI_MEMORY_RUNTIME memory *attribute* instead of the
EFI_MEMORY_MAPPED_IO memory *type*?

I don't really know the details of EFI_MEMORY_MAPPED_IO vs
EFI_MEMORY_RUNTIME, but it looks like EFI_MEMORY_RUNTIME can be
applied to things like EFI_RUNTIME_SERVICES_CODE (not MMIO space) that
should stay in E820.

Bjorn

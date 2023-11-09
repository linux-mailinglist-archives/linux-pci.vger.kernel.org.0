Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469DA7E71A8
	for <lists+linux-pci@lfdr.de>; Thu,  9 Nov 2023 19:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344997AbjKISoL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Nov 2023 13:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344906AbjKISoL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Nov 2023 13:44:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD1E3C0B;
        Thu,  9 Nov 2023 10:44:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245BAC433C9;
        Thu,  9 Nov 2023 18:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699555448;
        bh=8UAc8EsCuN5bJr1C+zm8DG80GRdlk02wP4zHZdEQ9JA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=OPDGoCgFacZbFthQ2lOea++r7dB+QHcZ+WMQez35XDIbIFPLKg03hANVi5uhZlSEW
         EQ+2PHEm1DYU+UXyB8KiVuVgpDTNF9EaLAmK9JUKoncwF7hjI4SwmzQaBvwjquFCEQ
         GugfTLXxxitWqhWUBA8P+FewYlXe3o9VjsIXyF/hryySuCNN6aqyoUsygrAcgbBO46
         LuBB7dAVYlNEXkQMjYmbu+EQSjYoL1g1BXq4C5P0oIr5ZBO9AENUwszBf4hkamns2L
         8Is4VkeufR421gGprW69X2chzels9MaFysHN+xpJomYLg5EzfPis4P6YTC28DzfhKn
         oyH1ZNeKQTmxA==
Date:   Thu, 9 Nov 2023 12:44:05 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Tomasz Pala <gotar@polanet.pl>
Cc:     linux-pci@vger.kernel.org,
        Dan J Williams <dan.j.williams@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        David E Box <david.e.box@intel.com>,
        Yunying Sun <yunying.sun@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Hans de Goede <hdegoede@redhat.com>,
        Florent DELAHAYE <linuxkernelml@undead.fr>,
        Konrad J Hambrick <kjhambrick@gmail.com>,
        Matt Hansen <2lprbe78@duck.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Benoit =?utf-8?B?R3LDqWdvaXJl?= <benoitg@coeus.ca>,
        Werner Sembach <wse@tuxedocomputers.com>,
        mumblingdrunkard@protonmail.com, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sebastian Manciulea <manciuleas@protonmail.com>
Subject: Re: [PATCH 2/2] x86/pci: Treat EfiMemoryMappedIO as reservation of
 ECAM space
Message-ID: <20231109184405.GA488882@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103191858.GA163196@bhelgaas>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Sebastian]

On Fri, Nov 03, 2023 at 02:18:58PM -0500, Bjorn Helgaas wrote:
> On Thu, Oct 26, 2023 at 03:53:19PM -0500, Bjorn Helgaas wrote:
> > On Thu, Oct 12, 2023 at 05:33:47PM +0200, Tomasz Pala wrote:
> > > On Tue, Jan 10, 2023 at 12:02:43 -0600, Bjorn Helgaas wrote:
> > > > Normally we reject ECAM space unless it is reported as
> > > > reserved in the E820 table or via a PNP0C02 _CRS method (PCI
> > > > Firmware, r3.3, sec 4.1.2).  This means PCI extended config
> > > > space (offsets 0x100-0xfff) may not be accessible.
> > > > 
> > > > Some firmware doesn't report ECAM space via PNP0C02 _CRS
> > > > methods, but does mention it as an EfiMemoryMappedIO region
> > > > via EFI GetMemoryMap(), which is normally converted to an E820
> > > > entry by a bootloader or EFI stub.
> > > > 
> > > > 07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820
> > > > map"), removes E820 entries that correspond to
> > > > EfiMemoryMappedIO regions because some other firmware uses
> > > > EfiMemoryMappedIO for PCI host bridge windows, and the E820
> > > > entries prevent Linux from allocating BAR space for hot-added
> > > > devices.
> > > > 
> > > > Allow use of ECAM for extended config space when the region is
> > > > covered by an EfiMemoryMappedIO region, even if it's not
> > > > included in E820 or PNP0C02 _CRS.
> > > 
> > > I'm still having a problem initializing ixgbe NICs with pristine
> > > 6.5.7 kernel.
> > 
> > Thanks very much for the report, and sorry for the inconvenience and
> > my delay in looking at it.
> > 
> > > efi: Remove mem63: MMIO range=[0x80000000-0x8fffffff] (256MB) from e820 map
> > > [mem 0x7f800000-0xfed1bfff] available for PCI devices
> > > PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
> > > [Firmware Info]: PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] not reserved in ACPI motherboard resources
> > > PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserved as EfiMemoryMappedIO
> > > ixgbe 0000:02:00.0: enabling device (0140 -> 0142)
> > > ixgbe 0000:02:00.0: BAR 0: can't reserve [mem 0x80000000-0x8007ffff 64bit]
> > > ixgbe 0000:02:00.0: pci_request_selected_regions failed 0xfffffff0
> > > ixgbe: probe of 0000:02:00.0 failed with error -16
> > 
> > Something is wrong with our allocation scheme.  Both the MMCONFIG
> > region and the ixgbe BAR 0 are at 0x80000000, which obviously cannot
> > work.  Maybe the full dmesg log will have a clue about why we didn't
> > move ixgbe out of the way.
> > 
> > > After disabling the code causing this (using always-false condition:
> > > 		if (size >= 256*1024 && 0) {
> > > ) in the chunk:
> > > 
> > > https://lore.kernel.org/lkml/20221208190341.1560157-2-helgaas@kernel.org/
> > > 
> > > the BAR starts at 0x90000000 (not 0x80000000):
> > > 
> > > efi: Not removing mem63: MMIO range=[0x80000000-0x8fffffff] (262144KB) from e820 map
> > > [...]
> > > [mem 0x90000000-0xfed1bfff] available for PCI devices
> > > [...]
> > > PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
> > > PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserved as E820 entry
> > > 
> > > and everything seems to work again.
> > > 
> > > 
> > > I've got full system bootup logs from the upstream and worked around,
> > > but I'm not sure if this is OK to attach them (the CC list is long).
> > 
> > Would you mind opening a new report at https://bugzilla.kernel.org,
> > attaching those logs, and responding here with the URL?
> 
> Thanks for the report and the logs, which are attached at
> https://bugzilla.kernel.org/show_bug.cgi?id=218050
> 
> I think the problem is that the MMCONFIG region is at
> [mem 0x80000000-0x8fffffff], and that is *also* included in one of the
> host bridge windows reported via _CRS:
> 
>   PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
>   pci_bus 0000:00: root bus resource [mem 0x80000000-0xfbffffff window]
> 
> I'll try to figure out how to deal with that.  In the meantime, would
> you mind attaching the contents of /proc/iomem to the bugzilla?  I
> think you have to cat it as root to get the actual values included.

I attached a debug patch to both bugzilla entries.  If you could
attach the "acpidump" output and (if practical) boot a kernel with the
debug patch and attach the dmesg logs, that would be great.

Bjorn

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F2565F5E2
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jan 2023 22:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235556AbjAEVfs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Jan 2023 16:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbjAEVfr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jan 2023 16:35:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645BD63F7F;
        Thu,  5 Jan 2023 13:35:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17639B81BDF;
        Thu,  5 Jan 2023 21:35:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF86C433F0;
        Thu,  5 Jan 2023 21:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672954543;
        bh=J1jmUwTH6dincuSOTR/OwUfYpuEsFtTrqbv5U3W9pYc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=JPNdeFZCCvikdHla0ZygAa51wkbMeDXnfzt+HFZgVweaZx8TXyidw1l5pt9Q6/oU8
         SMxfSdEkna+XLuaBmYOCTznqkug73bStiu+U2W4lBmQumbSb0B0AqgiYtOAEE/hmaL
         3Y4DNHhVjJL6xGCCjfHZoleDGwaUnZfzNKGw7mqB2ZNgOdQVgm8zzmf/V2LaqyH4mR
         hTcW0TUDs9xOIwK4mKIm5qkbKmfEu83nNtuEw6tjOOaSOWf1ZCCJTog89uyE53BRqz
         yIFgwk18LGbh3jBFIpMkNsn6itojvS78za+Orjl2PI2SNvZqBIOje/oCMuDBO2AQ5y
         dBazfx/xVNuFw==
Date:   Thu, 5 Jan 2023 15:35:41 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "kernelorg@undead.fr" <kernelorg@undead.fr>,
        "kjhambrick@gmail.com" <kjhambrick@gmail.com>,
        "2lprbe78@duck.com" <2lprbe78@duck.com>,
        "nicholas.johnson-opensource@outlook.com.au" 
        <nicholas.johnson-opensource@outlook.com.au>,
        "benoitg@coeus.ca" <benoitg@coeus.ca>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "wse@tuxedocomputers.com" <wse@tuxedocomputers.com>,
        "mumblingdrunkard@protonmail.com" <mumblingdrunkard@protonmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Box, David E" <david.e.box@intel.com>,
        "Sun, Yunying" <yunying.sun@intel.com>
Subject: Re: Bug report: the extended PCI config space is missed with 6.2-rc2
Message-ID: <20230105213541.GA1171476@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63b73f24c1a_517412943a@dwillia2-xfh.jf.intel.com.notmuch>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 05, 2023 at 01:20:36PM -0800, Dan Williams wrote:
> Bjorn Helgaas wrote:
> > On Thu, Jan 05, 2023 at 11:44:28AM -0800, Dan Williams wrote:
> > > Bjorn Helgaas wrote:
> > 
> > > > Apparently the only mention of [mem 0x80000000-0x8fffffff] in the
> > > > firmware/kernel interface is as an EfiMemoryMappedIO region.
> > > > 
> > > > I think this is a firmware bug, but obviously we're going to have to
> > > > figure out a way around it.
> > > 
> > > Definitely an ambiguity / conflict, but not sure it is a bug when you
> > > look at from the perspective of how would an EFI runtime service use
> > > ECAM/MMCONFIG space? 
> > 
> > I think it's perfectly fine for firmware to advertise ECAM space as an
> > EfiMemoryMappedIO region via EFI GetMemoryMap() because it certainly
> > makes sense that EFI runtime services would use config space.
> > 
> > My understanding is that the OS should learn about device address
> > space via ACPI _CRS, not GetMemoryMap().  The MCFG spec (PCI Firmware
> > Spec, r3.3, sec 4.1.2) requires ECAM space to be reserved via a
> > PNP0C02 motherboard device _CRS.
> > 
> > So what I think *is* a bug is that this firmware doesn't report the
> > ECAM space via PNP0C02 _CRS.
> > 
> > If somebody thinks the lack of this reservation is not a bug, I would
> > love to hear ideas about how Linux *should* be handling this.  There
> > are many variations on how firmware does things like this, and it's
> > been a nightmare trying to figure out something that works with all of
> > them.
> 
> I am trying to get a statement from a BIOS person, but in the meantime I
> am confused by this lead in sentence of Note 2 in "PCI Firmware Spec
> v3.2 Table 4-2: MCFG Table to Support Enhanced Configuration Space
> Access":
> 
>     If the operating system does not natively comprehend reserving the MMCFG
>     region, the MMCFG region must be reserved by firmware. The address range
>     reported in the MCFG table or by _CBA method (see Section 4.1.3) must be
>     reserved by declaring a motherboard resource...
> 
> Which seems to say it is ok for the OS to treat MMCFG space as reserved
> by default. It certainly fails the Robustness Principle for the BIOS to
> *assume* that the OS can natively comprehend that reservation, but it
> seems Linux is in its rights to make that assumption.

I read "OS natively comprehends MMCFG space" as meaning "the OS has
device-specific knowledge of the PCI host bridge and the associated
MMCFG space." But in that case, the OS wouldn't need MCFG at all, so
maybe I'm not reading it right.

There must have been some reason for that sentence, e.g., some system
that didn't or couldn't report MMCFG via PNP0C02 _CBA, but it sure
makes a mess of what could have been a simple "range must be reserved"
statement.

> > > Would it be enough to add this clarification in "EFI 2.9 Table 7-6
> > > Memory Type Usage after ExitBootServices()"?
> > > 
> > > s/This memory is not used by the OS./This memory is not used by the OS,
> > > unless ACPI declares it for another purpose./
> > 
> > I guess the idea is that MCFG is a form of "ACPI declaring it"?  I
> > don't have an explicit citation for it, but I infer at [1] that ACPI
> > static tables are second-class citizens and not intended as a way of
> > reserving address space because that would lead to problems booting
> > old OSes on firmware that provides new tables unknown to the OS.
> 
> Ah, true, certainly for new stuff, but what about MCFG specifically?
> What harm is there an assuming that MMCONFIG intersecting with
> EfiMemoryMappedIO shall be treated as reserved for MMCONFIG usage.

Probably none, and I think that's what we'll have to do.  Ugh.
Another random special-case rule.

> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/PCI/acpi-info.rst?id=v6.1#n32
> 
> 

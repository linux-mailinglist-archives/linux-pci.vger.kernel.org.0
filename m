Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF26E7E095F
	for <lists+linux-pci@lfdr.de>; Fri,  3 Nov 2023 20:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345902AbjKCTTF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Nov 2023 15:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376824AbjKCTTE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Nov 2023 15:19:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F655D5C;
        Fri,  3 Nov 2023 12:19:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B56E8C433CA;
        Fri,  3 Nov 2023 19:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699039141;
        bh=BdoS7jE6bPtz6cHJb4OOOnvh/m9c3Hkg7gCaP1DpcH0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Smb5QE/gZgORY8VVtStZ9oylS8sVrfWGpKaE+oFHhDDkWihjqzMQM0uZDjmrdDOll
         Mb4y9rmN9pNgMx6+xBXHUmPdtReEzFkcvBS6g1f4TVwKs3rN7s2WjFaPdiYNM3Ee2p
         Jnm8yZsG3U1sEJBylpnEWd2rUeGUp0rhUWQOTM7kywMmXW+mYj+FBc1wNioY/+H/9t
         qoI7Zuh0/v5pKueXhpwZrm5KzlGy93ikBKsE7HNtMwPgMEo49gdc5nfsJjuXFZzG7V
         M7OO1SbGc/0XhHQF4CL3y/+uNQ9igOrx+FpQJqsJVtkj6u8plCwdmbc428SPvnCdRG
         upTo2jHYImc1A==
Date:   Fri, 3 Nov 2023 14:18:58 -0500
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
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] x86/pci: Treat EfiMemoryMappedIO as reservation of
 ECAM space
Message-ID: <20231103191858.GA163196@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026205319.GA1832508@bhelgaas>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 26, 2023 at 03:53:19PM -0500, Bjorn Helgaas wrote:
> On Thu, Oct 12, 2023 at 05:33:47PM +0200, Tomasz Pala wrote:
> > On Tue, Jan 10, 2023 at 12:02:43 -0600, Bjorn Helgaas wrote:
> > > Normally we reject ECAM space unless it is reported as reserved in the E820
> > > table or via a PNP0C02 _CRS method (PCI Firmware, r3.3, sec 4.1.2).  This
> > > means PCI extended config space (offsets 0x100-0xfff) may not be accessible.
> > > 
> > > Some firmware doesn't report ECAM space via PNP0C02 _CRS methods, but does
> > > mention it as an EfiMemoryMappedIO region via EFI GetMemoryMap(), which is
> > > normally converted to an E820 entry by a bootloader or EFI stub.
> > > 
> > > 07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map"), removes
> > > E820 entries that correspond to EfiMemoryMappedIO regions because some
> > > other firmware uses EfiMemoryMappedIO for PCI host bridge windows, and the
> > > E820 entries prevent Linux from allocating BAR space for hot-added devices.
> > > 
> > > Allow use of ECAM for extended config space when the region is covered by
> > > an EfiMemoryMappedIO region, even if it's not included in E820 or PNP0C02
> > > _CRS.
> > 
> > I'm still having a problem initializing ixgbe NICs with pristine 6.5.7 kernel.
> 
> Thanks very much for the report, and sorry for the inconvenience and
> my delay in looking at it.
> 
> > efi: Remove mem63: MMIO range=[0x80000000-0x8fffffff] (256MB) from e820 map
> > [mem 0x7f800000-0xfed1bfff] available for PCI devices
> > PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
> > [Firmware Info]: PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] not reserved in ACPI motherboard resources
> > PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserved as EfiMemoryMappedIO
> > ixgbe 0000:02:00.0: enabling device (0140 -> 0142)
> > ixgbe 0000:02:00.0: BAR 0: can't reserve [mem 0x80000000-0x8007ffff 64bit]
> > ixgbe 0000:02:00.0: pci_request_selected_regions failed 0xfffffff0
> > ixgbe: probe of 0000:02:00.0 failed with error -16
> 
> Something is wrong with our allocation scheme.  Both the MMCONFIG
> region and the ixgbe BAR 0 are at 0x80000000, which obviously cannot
> work.  Maybe the full dmesg log will have a clue about why we didn't
> move ixgbe out of the way.
> 
> > After disabling the code causing this (using always-false condition:
> > 		if (size >= 256*1024 && 0) {
> > ) in the chunk:
> > 
> > https://lore.kernel.org/lkml/20221208190341.1560157-2-helgaas@kernel.org/
> > 
> > the BAR starts at 0x90000000 (not 0x80000000):
> > 
> > efi: Not removing mem63: MMIO range=[0x80000000-0x8fffffff] (262144KB) from e820 map
> > [...]
> > [mem 0x90000000-0xfed1bfff] available for PCI devices
> > [...]
> > PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
> > PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserved as E820 entry
> > 
> > and everything seems to work again.
> > 
> > 
> > I've got full system bootup logs from the upstream and worked around,
> > but I'm not sure if this is OK to attach them (the CC list is long).
> 
> Would you mind opening a new report at https://bugzilla.kernel.org,
> attaching those logs, and responding here with the URL?

Thanks for the report and the logs, which are attached at
https://bugzilla.kernel.org/show_bug.cgi?id=218050

I think the problem is that the MMCONFIG region is at
[mem 0x80000000-0x8fffffff], and that is *also* included in one of the
host bridge windows reported via _CRS:

  PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
  pci_bus 0000:00: root bus resource [mem 0x80000000-0xfbffffff window]

I'll try to figure out how to deal with that.  In the meantime, would
you mind attaching the contents of /proc/iomem to the bugzilla?  I
think you have to cat it as root to get the actual values included.

Bjorn

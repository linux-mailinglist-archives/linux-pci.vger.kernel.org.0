Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484547E5C9C
	for <lists+linux-pci@lfdr.de>; Wed,  8 Nov 2023 18:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjKHRr0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Nov 2023 12:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjKHRrZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Nov 2023 12:47:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E221FFB;
        Wed,  8 Nov 2023 09:47:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E69C433C7;
        Wed,  8 Nov 2023 17:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699465643;
        bh=VWAV8TJNKJJ0IbDxtEuU9YxgDI9IVEGPNAVjz5f6VoQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Pgci0tSfVkzCySV69SUTmOjy/TKsWu4WocWENSzMtM/ICfZ/fZa4OgqGRxVDy6P9M
         z2qszBt+JRDJrkBMjtGNFcD4Pw/tu4fpmHA6SSqYnzQ3QE26bZ9eQD76C0He5v5/L0
         ayKoNt5SZMM3H1f1h8Bc3URqWlQPZYj7MMSII5nTXiAgHrVi6TXLSszxzYyZQyluOz
         JzU59I+/VNNkS+3sKvFCotAae5vC87GE7Ez2YdosCGoFDDInH7Aly8bVBbcDh8/zeX
         clU6ECJ/q9SiUO8KZcogoE75ahWlm2WOVIuLSplXi+u1t9HppBTjCnDdVFR3iM/6qC
         BugL83RnzFQUg==
Date:   Wed, 8 Nov 2023 11:47:21 -0600
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
Message-ID: <20231108174721.GA421447@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012153347.GA26695@polanet.pl>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 12, 2023 at 05:33:47PM +0200, Tomasz Pala wrote:
> On Tue, Jan 10, 2023 at 12:02:43 -0600, Bjorn Helgaas wrote:
> 
> > Normally we reject ECAM space unless it is reported as reserved in the E820
> > table or via a PNP0C02 _CRS method (PCI Firmware, r3.3, sec 4.1.2).  This
> > means PCI extended config space (offsets 0x100-0xfff) may not be accessible.
> > 
> > Some firmware doesn't report ECAM space via PNP0C02 _CRS methods, but does
> > mention it as an EfiMemoryMappedIO region via EFI GetMemoryMap(), which is
> > normally converted to an E820 entry by a bootloader or EFI stub.
> > 
> > 07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map"), removes
> > E820 entries that correspond to EfiMemoryMappedIO regions because some
> > other firmware uses EfiMemoryMappedIO for PCI host bridge windows, and the
> > E820 entries prevent Linux from allocating BAR space for hot-added devices.
> > 
> > Allow use of ECAM for extended config space when the region is covered by
> > an EfiMemoryMappedIO region, even if it's not included in E820 or PNP0C02
> > _CRS.
> 
> I'm still having a problem initializing ixgbe NICs with pristine 6.5.7 kernel.
> 
> efi: Remove mem63: MMIO range=[0x80000000-0x8fffffff] (256MB) from e820 map
> [...]
> [mem 0x7f800000-0xfed1bfff] available for PCI devices
> [...]
> PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
> [Firmware Info]: PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] not reserved in ACPI motherboard resources
> PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserved as EfiMemoryMappedIO
> [...]
> ixgbe 0000:02:00.0: enabling device (0140 -> 0142)
> ixgbe 0000:02:00.0: BAR 0: can't reserve [mem 0x80000000-0x8007ffff 64bit]
> ixgbe 0000:02:00.0: pci_request_selected_regions failed 0xfffffff0
> ixgbe: probe of 0000:02:00.0 failed with error -16
> 
> 
> After disabling the code causing this (using always-false condition:
> 		if (size >= 256*1024 && 0) {
> ) in the chunk:
> 
> https://lore.kernel.org/lkml/20221208190341.1560157-2-helgaas@kernel.org/
> 
> the BAR starts at 0x90000000 (not 0x80000000):
> 
> efi: Not removing mem63: MMIO range=[0x80000000-0x8fffffff] (262144KB) from e820 map
> [...]
> [mem 0x90000000-0xfed1bfff] available for PCI devices
> [...]
> PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
> PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserved as E820 entry
> 
> and everything seems to work again.

Adding to regression tracking:

#regzbot ^introduced: 07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map")
#regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=218107

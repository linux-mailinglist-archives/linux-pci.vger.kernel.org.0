Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489927C71FA
	for <lists+linux-pci@lfdr.de>; Thu, 12 Oct 2023 18:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbjJLQEV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Oct 2023 12:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233085AbjJLQEU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Oct 2023 12:04:20 -0400
X-Greylist: delayed 1827 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 12 Oct 2023 09:04:18 PDT
Received: from pepin.polanet.pl (pepin.polanet.pl [193.34.52.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2116FBB;
        Thu, 12 Oct 2023 09:04:17 -0700 (PDT)
Date:   Thu, 12 Oct 2023 17:33:47 +0200
From:   Tomasz Pala <gotar@polanet.pl>
To:     Bjorn Helgaas <helgaas@kernel.org>
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
        Benoit =?iso-8859-2?Q?Gr=E9goire?= <benoitg@coeus.ca>,
        Werner Sembach <wse@tuxedocomputers.com>,
        mumblingdrunkard@protonmail.com, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] x86/pci: Treat EfiMemoryMappedIO as reservation of
 ECAM space
Message-ID: <20231012153347.GA26695@polanet.pl>
References: <20230110180243.1590045-1-helgaas@kernel.org>
 <20230110180243.1590045-3-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <20230110180243.1590045-3-helgaas@kernel.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

On Tue, Jan 10, 2023 at 12:02:43 -0600, Bjorn Helgaas wrote:

> Normally we reject ECAM space unless it is reported as reserved in the E820
> table or via a PNP0C02 _CRS method (PCI Firmware, r3.3, sec 4.1.2).  This
> means PCI extended config space (offsets 0x100-0xfff) may not be accessible.
> 
> Some firmware doesn't report ECAM space via PNP0C02 _CRS methods, but does
> mention it as an EfiMemoryMappedIO region via EFI GetMemoryMap(), which is
> normally converted to an E820 entry by a bootloader or EFI stub.
> 
> 07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map"), removes
> E820 entries that correspond to EfiMemoryMappedIO regions because some
> other firmware uses EfiMemoryMappedIO for PCI host bridge windows, and the
> E820 entries prevent Linux from allocating BAR space for hot-added devices.
> 
> Allow use of ECAM for extended config space when the region is covered by
> an EfiMemoryMappedIO region, even if it's not included in E820 or PNP0C02
> _CRS.

I'm still having a problem initializing ixgbe NICs with pristine 6.5.7 kernel.

efi: Remove mem63: MMIO range=[0x80000000-0x8fffffff] (256MB) from e820 map
[...]
[mem 0x7f800000-0xfed1bfff] available for PCI devices
[...]
PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
[Firmware Info]: PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] not reserved in ACPI motherboard resources
PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserved as EfiMemoryMappedIO
[...]
ixgbe 0000:02:00.0: enabling device (0140 -> 0142)
ixgbe 0000:02:00.0: BAR 0: can't reserve [mem 0x80000000-0x8007ffff 64bit]
ixgbe 0000:02:00.0: pci_request_selected_regions failed 0xfffffff0
ixgbe: probe of 0000:02:00.0 failed with error -16


After disabling the code causing this (using always-false condition:
		if (size >= 256*1024 && 0) {
) in the chunk:

https://lore.kernel.org/lkml/20221208190341.1560157-2-helgaas@kernel.org/

the BAR starts at 0x90000000 (not 0x80000000):

efi: Not removing mem63: MMIO range=[0x80000000-0x8fffffff] (262144KB) from e820 map
[...]
[mem 0x90000000-0xfed1bfff] available for PCI devices
[...]
PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserved as E820 entry

and everything seems to work again.


I've got full system bootup logs from the upstream and worked around,
but I'm not sure if this is OK to attach them (the CC list is long).

Also, this is my test machine so I can run some experiments.

best regards,
-- 
Tomasz Pala <gotar@pld-linux.org>

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162977F18A2
	for <lists+linux-pci@lfdr.de>; Mon, 20 Nov 2023 17:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjKTQ3k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Nov 2023 11:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjKTQ3j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Nov 2023 11:29:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C087E9E;
        Mon, 20 Nov 2023 08:29:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3457CC433C8;
        Mon, 20 Nov 2023 16:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700497775;
        bh=2KHeNbWYhMcQAXeUJJ39uvRa4Dtfeq52+R1v+4w7+po=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=A3TvIHXdynvxpesKj6UjEEgOfHBSZLggPVyufnrX3DwTVpzVTioThwiSU40qX/HH5
         j6BQHcRoIrhWobP/Vd8Hgc0cf1JhKlALq+iwT3WmQIKwR520knScYknLs80U/fp+7I
         33wTCqqp5NFvnRx4NqYZtYMWXeMiA3Cep/WixSYltEJ6c+/eFlNLF9beNHVcETuqu9
         svOnDiMM9tp62rzapZrBq6na+ow/FMSeq40j6tOeRTk9xLrt6smQ4MX0mpUKKMVwmZ
         jMPGsa4ljH0zh4qhX9Lx/edMvcYdB0P9JYAGBu3Lfv/Fi77gQFz1nAnVioPS9QNGCw
         G/GBp7i6+72Kw==
Date:   Mon, 20 Nov 2023 10:29:33 -0600
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
Message-ID: <20231120162933.GA197390@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231118142143.GA14101@polanet.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Nov 18, 2023 at 03:21:43PM +0100, Tomasz Pala wrote:
> On Thu, Nov 09, 2023 at 12:44:05 -0600, Bjorn Helgaas wrote:
> 
> >> https://bugzilla.kernel.org/show_bug.cgi?id=218050
> >> 
> >> I think the problem is that the MMCONFIG region is at
> >> [mem 0x80000000-0x8fffffff], and that is *also* included in one of the
> >> host bridge windows reported via _CRS:
> >> 
> >>   PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
> >>   pci_bus 0000:00: root bus resource [mem 0x80000000-0xfbffffff window]
> >> 
> >> I'll try to figure out how to deal with that.  In the meantime, would
> >> you mind attaching the contents of /proc/iomem to the bugzilla?  I
> > 
> > I attached a debug patch to both bugzilla entries.  If you could
> > attach the "acpidump" output and (if practical) boot a kernel with the
> > debug patch and attach the dmesg logs, that would be great.
> 
> I've posted the files. There are signs of buggy BIOS, but I don't expect
> any firmware update to be released for this hw anymore.

Thank you!  A BIOS update is almost never the answer because even if
an update exists, we have to assume that most users in the field will
never install the update.

I want to look at the BIOS info in case we can learn about something
*Linux* is doing wrong.  This most likely works fine with Windows, so
I assume Linux is doing something wrong or at least differently than
Windows.

> DMI: Supermicro X9DRi-LN4+/X9DR3-LN4+/X9DRi-LN4+/X9DR3-LN4+, BIOS 3.4 11/20/2019
> 
> .text .data .bss are not marked as E820_TYPE_RAM!

Added by 4eea6aa581ab ("x86, mm: if kernel .text .data .bss are not
marked as E820_RAM, complain and fix").  No idea.  A shame we didn't
include the .text/.data values in the message.

> tboot: non-0 tboot_addr but it is not of type E820_TYPE_RESERVED

Added by 316253406959 ("x86, intel_txt: Intel TXT boot support").  No
idea about this either.

> DMAR: [Firmware Bug]: No firmware reserved region can cover this RMRR [0x00000000df243000-0x00000000df251fff], contact BIOS vendor for fixes
> DMAR: [Firmware Bug]: Your BIOS is broken; bad RMRR [0x00000000df243000-0x00000000df251fff]

Both related to arch_rmrr_sanity_check(), added by f036c7fa0ab6
("iommu/vt-d: Check VT-d RMRR region in BIOS is reported as reserved")
and f5a68bb0752e ("iommu/vt-d: Mark firmware tainted if RMRR fails
sanity check").

No idea about this one either.  The VT-d spec (r1.3, sec 8.4) says
"BIOS must report the RMRR reported memory addresses as reserved in
the system memory map returned through methods such as INT15, EFI
GetMemoryMap etc."

arch_rmrr_sanity_check() only looks at your e820 map, which only has
this:

  BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] usable
  BIOS-e820: [mem 0x0000000000100000-0x00000000d1f36fff] usable

I think Linux basically converts the info from EFI GetMemoryMap
to an e820 format; I think booting with "efi=debug" would show more
details of this.

Anyway, this is all a tangent.

> BTW is there a reason for this logging discrepancy?
> 
> efi: Remove mem173: MMIO range=[0xe0000000-0xefffffff] (256MB) from e820 map
> efi: Not removing mem71: MMIO range=[0xe0000000-0xefffffff] (262144KB) from e820 map
> 
> efi: Not removing mem74: MMIO range=[0xff000000-0xffffffff] (16384KB) from e820 map
> efi: Remove mem176: MMIO range=[0xff000000-0xffffffff] (16MB) from e820 map
> 
> This is arch/x86/platform/efi/efi.c:
> static void __init efi_remove_e820_mmio(void)
> 
> Remove mem%02u: MMIO range=[0x%08llx-0x%08llx] (%lluMB) ... size >> 20
> Not removing mem%02u: MMIO range=[0x%08llx-0x%08llx] (%lluKB) ... size >> 10

You mean the MB vs KB difference?  That's my fault.  I guess I used KB
for the "Not removing" message because those are smaller (< 256KB) so
the size in MB wouldn't be useful there.  We could use KB for both,
but I guess I used MB for the "Remove" case because it's a little
easier to read and I expected "Not removing" to be a relatively
unusual case.

Bjorn

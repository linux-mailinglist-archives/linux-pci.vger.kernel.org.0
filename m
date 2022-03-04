Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A086E4CD7E0
	for <lists+linux-pci@lfdr.de>; Fri,  4 Mar 2022 16:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240341AbiCDPdk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Mar 2022 10:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240331AbiCDPdh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Mar 2022 10:33:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625893ED38;
        Fri,  4 Mar 2022 07:32:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09907B82A4E;
        Fri,  4 Mar 2022 15:32:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8054CC340F0;
        Fri,  4 Mar 2022 15:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646407966;
        bh=jRq3za2/d+Uf8BcRIwBjKrcN43tgaUv1AT681Wo32Jo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Bc92MacZZHtuoF71NdZnRtRobaAqkkVO17do2KT4d0kvp2IShudx1pdzpuCjvF3YA
         0nWHYZ7PNbNYH8TRD4zV2cnoRgsHk8V6X8Hn2QL/mlnogxiry0fYuf4orPqVGeOSTz
         2kr79JvKV53VEsZbkPsp52YqZPJbP05nBEUqFG1f94PymkH5RJRBuQcRcbCbPWqxis
         IDYxv7R0pjRUlXcVITLowOrzDJFRPdFv4jK00JkAcuxBf8BGkFdi60LG5e68rMz8nz
         wQPbs0++QfsvVDCK0EfQKAXs2+bX6zauXCJQJKpdc/z6sDUjhIUTtvt9nP5VIopAv8
         kC80h4fbnQ0qg==
Date:   Fri, 4 Mar 2022 09:32:45 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Benoit =?iso-8859-1?Q?Gr=E9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, wse@tuxedocomputers.com
Subject: Re: [PATCH 3/3] x86/PCI: Preserve host bridge windows completely
 covered by E820
Message-ID: <20220304153245.GA1030861@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c7233c9a-8aa9-edb2-f3a7-1bcaa5a880d2@redhat.com>
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 04, 2022 at 03:16:42PM +0100, Hans de Goede wrote:
> Hi Bjorn,
> 
> On 3/4/22 04:51, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Many folks have reported PCI devices not working.  It could affect any
> > device, but most reports are for Thunderbolt controllers on Lenovo Yoga and
> > Clevo Barebone laptops and the touchpad on Lenovo IdeaPads.
> > 
> > In every report, a region in the E820 table entirely encloses a PCI host
> > bridge window from _CRS, and because of 4dc2287c1805 ("x86: avoid E820
> > regions when allocating address space"), we ignore the entire window,
> > preventing us from assigning space to PCI devices.
> > 
> > For example, the dmesg log [2] from bug report [1] shows:
> > 
> >   BIOS-e820: [mem 0x000000004bc50000-0x00000000cfffffff] reserved
> >   pci_bus 0000:00: root bus resource [mem 0x65400000-0xbfffffff window]
> >   pci 0000:00:15.0: BAR 0: no space for [mem size 0x00001000 64bit]
> > 
> > The efi=debug dmesg log [3] from the same report shows the EFI memory map
> > entries that created the E820 map:
> > 
> >   efi: mem47: [Reserved |   |WB|WT|WC|UC] range=[0x4bc50000-0x5fffffff]
> >   efi: mem48: [Reserved |   |WB|  |  |UC] range=[0x60000000-0x60ffffff]
> >   efi: mem49: [Reserved |   |  |  |  |  ] range=[0x61000000-0x653fffff]
> >   efi: mem50: [MMIO     |RUN|  |  |  |UC] range=[0x65400000-0xcfffffff]
> > 
> > 4dc2287c1805 ("x86: avoid E820 regions when allocating address space")
> > works around issues where _CRS contains non-window address space that can't
> > be used for PCI devices.  It does this by removing E820 regions from host
> > bridge windows.  But in these reports, the E820 region covers the entire
> > window, so 4dc2287c1805 makes it completely unusable.
> > 
> > Per UEFI v2.8, sec 7.2, the EfiMemoryMappedIO type means:
> > 
> >   Used by system firmware to request that a memory-mapped IO region be
> >   mapped by the OS to a virtual address so it can be accessed by EFI
> >   runtime services.
> > 
> > A host bridge window is definitely a memory-mapped IO region, and EFI
> > runtime services may need to access it, so I don't think we can argue that
> > this is a firmware defect.
> > 
> > Instead, change the 4dc2287c1805 strategy so it only removes E820 regions
> > when they overlap *part* of a host bridge window on the assumption that a
> > partial overlap is really register space, not part of the window proper.
> > 
> > If an E820 region covers the entire window from _CRS, assume the _CRS
> > window is correct and do nothing.
> > 
> > [1] https://bugzilla.redhat.com/show_bug.cgi?id=1868899
> > [2] https://bugzilla.redhat.com/attachment.cgi?id=1711424
> > [3] https://bugzilla.redhat.com/attachment.cgi?id=1861407
> > 
> > BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=206459
> > BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=214259
> > BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1868899
> > BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1871793
> > BugLink: https://bugs.launchpad.net/bugs/1878279
> > BugLink: https://bugs.launchpad.net/bugs/1931715
> > BugLink: https://bugs.launchpad.net/bugs/1932069
> > BugLink: https://bugs.launchpad.net/bugs/1921649
> > Fixes: 4dc2287c1805 ("x86: avoid E820 regions when allocating address space")
> > Link: https://lore.kernel.org/r/20220228105259.230903-1-hdegoede@redhat.com
> > Based-on-patch-by: Hans de Goede <hdegoede@redhat.com>
> > Reported-by: Benoit Grégoire <benoitg@coeus.ca>   # BZ 206459
> > Reported-by: wse@tuxedocomputers.com              # BZ 214259
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  arch/x86/kernel/resource.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/arch/x86/kernel/resource.c b/arch/x86/kernel/resource.c
> > index 7378ea146976..405f0af53e3d 100644
> > --- a/arch/x86/kernel/resource.c
> > +++ b/arch/x86/kernel/resource.c
> > @@ -39,6 +39,17 @@ void remove_e820_regions(struct device *dev, struct resource *avail)
> >  		e820_start = entry->addr;
> >  		e820_end = entry->addr + entry->size - 1;
> >  
> > +		/*
> > +		 * If an E820 entry covers just part of the resource, we
> > +		 * assume E820 is telling us about something like host
> > +		 * bridge register space that is unavailable for PCI
> > +		 * devices.  But if it covers the *entire* resource, it's
> > +		 * more likely just telling us that this is MMIO space, and
> > +		 * that doesn't need to be removed.
> > +		 */
> > +		if (e820_start <= avail->start && avail->end <= e820_end)
> > +			continue;
> > +
> 
> IMHO it would be good to add some logging here, since hitting this is
> somewhat of a special case. For the Fedora test kernels I did I changed
> this to:
> 
> 		if (e820_start <= avail->start && avail->end <= e820_end) {
> 			dev_info(dev, "resource %pR fully covered by e820 entry [mem %#010Lx-%#010Lx]\n",
> 				 avail, e820_start, e820_end);
> 			continue;
> 		}
> 
> And I expect/hope to see this new info message on the ideapad with the
> touchpad issue.

Right, I would expect the same.

We could add something like this.  But both the e820 entry and the
host bridge window are already in the dmesg log, so it doesn't really
add new information, and I don't think there's anything *wrong* with
this situation (per the UEFI text above), so I don't think we need to
call attention to it.

I think what might add useful information would be to always log the
EFI "RUN" entries.  IIUC, currently the "efi: mem47: ..." lines are
only emitted when booting with "efi=debug"?

I think the "RUN" lines indicate regions that must be virtually mapped
so EFI runtime services can use them, and it seems like it might be
more generally useful to always mention them.

Bjorn

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39DF51E829
	for <lists+linux-pci@lfdr.de>; Sat,  7 May 2022 17:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238696AbiEGPff (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 7 May 2022 11:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiEGPfe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 7 May 2022 11:35:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C399941323;
        Sat,  7 May 2022 08:31:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45B8EB80AC7;
        Sat,  7 May 2022 15:31:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF87C385A6;
        Sat,  7 May 2022 15:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651937504;
        bh=QJj5Sep2kOlckvNOm3pNvQISPpQfrx8VxV7m3x1RMBg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YNoboC18iI89dXVAYaAOygronZuJQsJ7tougBUGc1+VI8cJTER3CJfliO4hOPeLAR
         0asmSj80caah/B2Nglx4EtXnrs65/t7RmZRCK07JPNXQN+gKlzDodE/N0wIYANgTj3
         K+orCvwBXUdvuukhc/AQ2XVGYQlN+ziyA70KfxEn80yHXAGyQNOmPpDyIhcbj3SxVG
         FlBGOFCCT7KtzyPwF1FHhz94ws/xYzMcEXurJQWs85bnIQCMLJOa1Z5FM+fiKD0Qvu
         waQBAHD1CM7yxbK0f+bmxNNoNUzlN5ChihHpP6OoL0doUB/NmlVaSXBPX9l696ZOsv
         T2ltZvfZFinjg==
Date:   Sat, 7 May 2022 10:31:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Benoit =?iso-8859-1?Q?Gr=E9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/1] x86/PCI: Ignore E820 reservations for bridge
 windows on newer systems
Message-ID: <20220507153142.GA568130@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <94238be8-023e-a70a-45c8-a7096149e752@redhat.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, May 07, 2022 at 12:09:03PM +0200, Hans de Goede wrote:
> Hi Bjorn,
> 
> On 5/6/22 18:51, Bjorn Helgaas wrote:
> > On Thu, May 05, 2022 at 05:20:16PM +0200, Hans de Goede wrote:
> >> Some BIOS-es contain bugs where they add addresses which are already
> >> used in some other manner to the PCI host bridge window returned by
> >> the ACPI _CRS method. To avoid this Linux by default excludes
> >> E820 reservations when allocating addresses since 2010, see:
> >> commit 4dc2287c1805 ("x86: avoid E820 regions when allocating address
> >> space").
> >>
> >> Recently (2019) some systems have shown-up with E820 reservations which
> >> cover the entire _CRS returned PCI bridge memory window, causing all
> >> attempts to assign memory to PCI BARs which have not been setup by the
> >> BIOS to fail. For example here are the relevant dmesg bits from a
> >> Lenovo IdeaPad 3 15IIL 81WE:
> >>
> >>  [mem 0x000000004bc50000-0x00000000cfffffff] reserved
> >>  pci_bus 0000:00: root bus resource [mem 0x65400000-0xbfffffff window]
> >>
> >> The ACPI specifications appear to allow this new behavior:
> >>
> >> The relationship between E820 and ACPI _CRS is not really very clear.
> >> ACPI v6.3, sec 15, table 15-374, says AddressRangeReserved means:
> >>
> >>   This range of addresses is in use or reserved by the system and is
> >>   not to be included in the allocatable memory pool of the operating
> >>   system's memory manager.
> >>
> >> and it may be used when:
> >>
> >>   The address range is in use by a memory-mapped system device.
> >>
> >> Furthermore, sec 15.2 says:
> >>
> >>   Address ranges defined for baseboard memory-mapped I/O devices, such
> >>   as APICs, are returned as reserved.
> >>
> >> A PCI host bridge qualifies as a baseboard memory-mapped I/O device,
> >> and its apertures are in use and certainly should not be included in
> >> the general allocatable pool, so the fact that some BIOS-es reports
> >> the PCI aperture as "reserved" in E820 doesn't seem like a BIOS bug.
> >>
> >> So it seems that the excluding of E820 reserved addresses is a mistake.
> >>
> >> Ideally Linux would fully stop excluding E820 reserved addresses,
> >> but then various old systems will regress.
> >> Instead keep the old behavior for old systems, while ignoring
> >> the E820 reservations for any systems from now on.
> >>
> >> Old systems are defined here as BIOS year < 2018, this was chosen to
> >> make sure that pci_use_e820 will not be set on the currently affected
> >> systems, the oldest known one is from 2019.
> >>
> >> Testing has shown that some newer systems also have a bad _CRS return.
> >> The pci_crs_quirks DMI table is used to keep excluding E820 reservations
> >> from the bridge window on these systems.
> >>
> >> Also add pci=no_e820 and pci=use_e820 options to allow overriding
> >> the BIOS year + DMI matching logic.
> >>
> >> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=206459
> >> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1868899
> >> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1871793
> >> BugLink: https://bugs.launchpad.net/bugs/1878279
> >> BugLink: https://bugs.launchpad.net/bugs/1931715
> >> BugLink: https://bugs.launchpad.net/bugs/1932069
> >> BugLink: https://bugs.launchpad.net/bugs/1921649
> >> Cc: Benoit Grégoire <benoitg@coeus.ca>
> >> Cc: Hui Wang <hui.wang@canonical.com>
> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > 
> >> +	 * Ideally Linux would fully stop using E820 reservations, but then
> >> +	 * various old systems will regress. Instead keep the old behavior for
> >> +	 * old systems + known to be broken newer systems in pci_crs_quirks.
> >> +	 */
> >> +	if (year >= 0 && year < 2018)
> >> +		pci_use_e820 = true;
> > 
> > How did you pick 2018?  Prior to this patch, we used E820 reservations
> > for all machines.  This patch would change that for 2019-2022
> > machines, so there's a risk of breaking some of them.
> 
> Correct. I picked 2018 because the first devices where using E820
> reservations are causing issues (i2c controller not getting resources
> leading to non working touchpad / thunderbolt hotplug issues) have
> BIOS dates starting in 2019. I added a year margin, so we could make
> this 2019.
> 
> > I'm hesitant about changing the behavior for machines already in the
> > field because if they were tested at all with Linux, it was without
> > this patch.  So I would lean toward preserving the current behavior
> > for BIOS year < 2023.
> 
> I see, I presume the idea is to then use DMI to disable E820 clipping
> on current devices where this is known to cause problems ?
> 
> So for v8 I would:
> 
> 1. Change the cut-off check to < 2023
> 2. Drop the DMI quirks I added for models which are known to need E820
>    clipping hit by the < 2018 check
> 3. Add DMI quirks for models for which it is known that we must _not_
>    do E820 clipping
> 
> Is this the direction you want to go / does that sound right?

Yes, I think that's what we should do.  All the machines in the field
will be unaffected, except that we add quirks for known problems.

Bjorn

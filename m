Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E1665F4C3
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jan 2023 20:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235944AbjAETok (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Jan 2023 14:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235735AbjAETod (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jan 2023 14:44:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3F35FEF;
        Thu,  5 Jan 2023 11:44:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B55261C22;
        Thu,  5 Jan 2023 19:44:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B34AC433EF;
        Thu,  5 Jan 2023 19:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672947871;
        bh=F9ytvTqf53Pui3bJMCgwez1qUkcHFn1L1hfgQzkn+7w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Ro/nHfXSWUqGhft9um6BlZ0xoVAXYK4oo/u7rsmsk78Cj96IkyDMOlR0OJfAbB4gP
         sVLhrtAlOpOX0SHvP9MdRxbBw48AwZ8/2n4kaoPwwml/oScDgCe0WFmSoXoYYV/SFK
         fMAYcnSQoVTeQCpgi5zRNDADSNhRmGMczvkRcGm6wsIRkY1e9uVQPh5FPnHtr1uXmx
         L/1slQryJ1998b1ooDBrqI0Dc79xjif6uH4YejUPcPnP1vrk5foMU+jv4tUTHnUxQU
         DiCpPuLGY1j2++XNXsb/QBUjcAADJgDkna7+sOswenwlFNmxOpadmYHGBKq/9UYiOD
         vCdf955Si+sEw==
Date:   Thu, 5 Jan 2023 13:44:29 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
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
Message-ID: <20230105194429.GA1164120@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36dab127-93f9-ad87-26be-cb406fed6212@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 05, 2023 at 02:23:45PM -0500, Liang, Kan wrote:
> On 2023-01-05 1:29 p.m., Bjorn Helgaas wrote:
> > On Thu, Jan 05, 2023 at 06:04:52PM +0000, Luck, Tony wrote:
> >>> Hi Tony, can you share a dmesg log?  Does it look like the same thing
> >>> Kan reported, where the ECAM space is reported only via an
> >>> EfiMemoryMappedIO region and is not otherwise reserved by firmware?
> >>
> >> Attached are serial logs. "broken" is the one from v6.2-rc2, "revert" is the
> >> one with your commit reverted.
> >>
> >> I don't see the string "ECAM" in either of them.
> > 
> > Yeah, "ECAM" is what the PCIe spec calls it, but Linux logging uses
> > "MMCONFIG".  Probably should change that.
> > 
> > Anyway, your dmesg log shows the same problem:
> > 
> >   DMI: Intel Corporation BRICKLAND/BRICKLAND, BIOS BRBDXSD1.86B.0338.V01.1603162127 03/16/2016
> >   efi: Remove mem48: MMIO range=[0x80000000-0x8fffffff] (256MB) from e820 map
> >   PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
> >   [Firmware Info]: PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] not reserved in ACPI motherboard resources
> >   PCI: not using MMCONFIG
> >   acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended configuration space under this bridge
> > 
> > Apparently the only mention of [mem 0x80000000-0x8fffffff] in the
> > firmware/kernel interface is as an EfiMemoryMappedIO region.
> > 
> > I think this is a firmware bug, but obviously we're going to have to
> > figure out a way around it.
> 
> I just want to share that I did more tests on an Ice Lake server (a
> different generation from my original report and Tony's machine).
> 
> The same problem can be found as well.
> 
> [    0.000000] DMI: Intel Corporation M50CYP2SB2U/M50CYP2SB2U, BIOS
> SE5C6200.86B.4018.D65.2010201151 10/20/2020
> [    0.000000] efi: Remove mem375: MMIO range=[0x80000000-0x8fffffff]
> (256MB) from e820 map
> [    0.000000] e820: remove [mem 0x80000000-0x8fffffff] reserved
> 
> [    1.528341] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem
> 0x80000000-0x8fffffff] (base 0x80000000)
> [    1.566605] [Firmware Info]: PCI: MMCONFIG at [mem
> 0x80000000-0x8fffffff] not reserved in ACPI motherboard resources
> [    1.566611] PCI: not using MMCONFIG
> 
> This firmware implementation should exist on the existing platforms for
> a long time.

Yes.  Frustrating, but I think we have no choice but to make Linux
work with the firmware as it is, whether it is buggy or not.  From
your first report, I hoped it was isolated to unreleased firmware that
had a chance of being fixed, but obviously that's not the case.

Bjorn

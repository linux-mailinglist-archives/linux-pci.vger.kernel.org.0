Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B7649FB2F
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jan 2022 15:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245561AbiA1ODd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jan 2022 09:03:33 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39962 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238986AbiA1ODc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Jan 2022 09:03:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00E0EB825D2
        for <linux-pci@vger.kernel.org>; Fri, 28 Jan 2022 14:03:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 982B0C340E0;
        Fri, 28 Jan 2022 14:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643378609;
        bh=JsFKRCg4Jz5RzsSdeE9thJg6K/0Y4CANjZLeLX9U5YY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=mfRVKQ1iHHVWuOHPBZK1JFXpczBdhPjbov+YJv0oGep0yCzjoq0UvPx7BhZtECcIe
         EobGlF8JMJeYrnSgHhahNqbsPMLEcIai9ICWCxT/7CeSQ2R6otg3pJUZCZzNwNeqDt
         1bfpnkGyyomFJ2KQkpUgmGAF5J1a2CGjIDjqex+BUav2mYvSeph75aod9idEh5WPav
         Q0pxplNu66q75859A48EVucDZ/JMqLdnQCL6WySuaAuoM7YvmeltIEiJFnp/ylIDYs
         SDPDV9kIZaoM4Cx6uhb8CXOfryad/UCkTACmo2e2GjOgncVHZQVOaOL2BuijmZ88fE
         fIHNO2BpQ38Xw==
Date:   Fri, 28 Jan 2022 08:03:28 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
        linux-pci@vger.kernel.org, Blazej Kucman <blazej.kucman@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Lukas Wunner <lukas@wunner.de>,
        Naveen Naidu <naveennaidu479@gmail.com>,
        Keith Busch <kbusch@kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Subject: Re: [Bug 215525] New: HotPlug does not work on upstream kernel
 5.17.0-rc1
Message-ID: <20220128140328.GA206121@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAd53p5HJT-UHd-Bm9KhWaEKAhUiWcYerLaM=ztksAe4XdLLCA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 28, 2022 at 09:49:34PM +0800, Kai-Heng Feng wrote:
> On Fri, Jan 28, 2022 at 9:08 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Jan 28, 2022 at 09:29:31AM +0100, Mariusz Tkaczyk wrote:
> > > On Thu, 27 Jan 2022 20:52:12 -0600
> > > Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Thu, Jan 27, 2022 at 03:46:15PM +0100, Mariusz Tkaczyk wrote:
> > > > > ...
> > > > > Thanks for your suggestions. Blazej did some tests and results were
> > > > > inconclusive. He tested it on two same platforms. On the first one
> > > > > it didn't work, even if he reverted all suggested patches. On the
> > > > > second one hotplugs always worked.
> > > > >
> > > > > He noticed that on first platform where issue has been found
> > > > > initally, there was boot parameter "pci=nommconf". After adding
> > > > > this parameter on the second platform, hotplugs stopped working too.
> > > > >
> > > > > Tested on tag pci-v5.17-changes. He have CONFIG_HOTPLUG_PCI_PCIE
> > > > > and CONFIG_DYNAMIC_DEBUG enabled in config. He also attached two
> > > > > dmesg logs to bugzilla with boot parameter 'dyndbg="file pciehp*
> > > > > +p" as requested. One with "pci=nommconf" and one without.
> > > > >
> > > > > Issue seems to related to "pci=nommconf" and it is probably caused
> > > > > by change outside pciehp.
> > > >
> > > > Maybe I'm missing something.  If I understand correctly, the problem
> > > > has nothing to do with the kernel version (correct me if I'm wrong!)
> > >
> > > The problem occurred after the merge commit. It is some kind of
> > > regression.
> >
> > The bug report doesn't yet contain the evidence showing this.  It only
> > contains dmesg logs with "pci=nommconf" where pciehp doesn't work
> > (which is the expected behavior) and a log without "pci=nommconf"
> > where pciehp does work (which is again the expected behavior).
> >
> > > > PCIe native hotplug doesn't work when booted with "pci=nommconf".
> > > > When using "pci=nommconf", obviously we can't access the extended PCI
> > > > config space (offset 0x100-0xfff), so none of the extended
> > > > capabilities are available.
> > > >
> > > > In that case, we don't even ask the platform for control of PCIe
> > > > hotplug via _OSC.  From the dmesg diff from normal (working) to
> > > > "pci=nommconf" (not working):
> > > >
> > > >   -Command line: BOOT_IMAGE=/boot/vmlinuz-smp ...
> > > >   +Command line: BOOT_IMAGE=/boot/vmlinuz-smp pci=nommconf ...
> > > >   ...
> > > >   -acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM
> > > > Segments MSI HPX-Type3] -acpi PNP0A08:00: _OSC: platform does not
> > > > support [AER LTR] -acpi PNP0A08:00: _OSC: OS now controls
> > > > [PCIeHotplug PME PCIeCapability] +acpi PNP0A08:00: _OSC: OS supports
> > > > [ASPM ClockPM Segments MSI HPX-Type3] +acpi PNP0A08:00: _OSC: not
> > > > requesting OS control; OS requires [ExtendedConfig ASPM ClockPM MSI]
> > > > +acpi PNP0A08:00: MMCONFIG is disabled, can't access extended PCI
> > > > configuration space under this bridge.
> > >
> > > So, it shouldn't work from years but it has been broken recently, that
> > > is the only objection I have. Could you tell why it was working?
> > > According to your words- it shouldn't. We are using VMD driver, is that
> > > matter?
> >
> > 04b12ef163d1 ("PCI: vmd: Honor ACPI _OSC on PCIe features") looks like
> > a it could be related.  Try reverting that commit and see whether it
> > makes a difference.
> 
> The affected NVMe is indeed behind VMD domain, so I think the commit
> can make a difference.
> 
> Does VMD behave differently on laptops and servers?
> Anyway, I agree that the issue really lies in "pci=nommconf".

Oh, I have a guess:

  - With "pci=nommconf", prior to v5.17-rc1, pciehp did not work in
    general, but *did* work for NVMe behind a VMD.  As of v5.17-rc1,
    pciehp no longer works for NVMe behind VMD.

  - Without "pci=nommconf", pciehp works as expected for all devices
    including NVMe behind VMD, both before and after v5.17-rc1.

Is that what you're observing?

If so, I doubt there's anything to fix other than getting rid of
"pci=nommconf".

Bjorn

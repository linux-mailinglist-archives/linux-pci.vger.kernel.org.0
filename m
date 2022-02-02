Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD694A7623
	for <lists+linux-pci@lfdr.de>; Wed,  2 Feb 2022 17:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345982AbiBBQnM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Feb 2022 11:43:12 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57130 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232448AbiBBQnL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Feb 2022 11:43:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18BB46175E
        for <linux-pci@vger.kernel.org>; Wed,  2 Feb 2022 16:43:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35324C004E1;
        Wed,  2 Feb 2022 16:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643820190;
        bh=/PCBFaUQfBKvhy51Ibkudp/YON956SY4ZrBf5G05n70=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=iiGwmsDYLBImlW5HI9K7Ip7EztABc0MRlRGcvKLA4z7SxR29EDHPnjwhMwRDevIDD
         r16hPkjJhf6oWniFSUZMX5I1v/JCqh+v4Lc7wCL10uGw5Uk1kppFDXaIw6BcOaMahh
         wLScEEnnGL68bjkLsylAoAa24Z9F55Pl6yT2J3qgV6DHEvQ5Br0BKnMUujEDVKrttE
         Mkrd28xuMR0XLQDXMWvm1fsSioswIN6Kjo9e4Gfol2e0tNTCzGi+6H2o1zHvC1wKML
         2SZA12R7Nn6TEucTLNudYAgW1gMnna8WCxY2nd3sTEjrO3oCb5X+Fm65tWUvYWEALR
         sfFvGd+j62rWw==
Date:   Wed, 2 Feb 2022 10:43:08 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Blazej Kucman <blazej.kucman@linux.intel.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
        linux-pci@vger.kernel.org, Blazej Kucman <blazej.kucman@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Lukas Wunner <lukas@wunner.de>,
        Naveen Naidu <naveennaidu479@gmail.com>,
        Keith Busch <kbusch@kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Subject: Re: [Bug 215525] New: HotPlug does not work on upstream kernel
 5.17.0-rc1
Message-ID: <20220202164308.GA17822@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202164801.00007228@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 02, 2022 at 04:48:01PM +0100, Blazej Kucman wrote:
> On Fri, 28 Jan 2022 08:03:28 -0600
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Jan 28, 2022 at 09:49:34PM +0800, Kai-Heng Feng wrote:
> > > On Fri, Jan 28, 2022 at 9:08 PM Bjorn Helgaas <helgaas@kernel.org>
> > > wrote:  
> > > > On Fri, Jan 28, 2022 at 09:29:31AM +0100, Mariusz Tkaczyk wrote:  
> > > > > On Thu, 27 Jan 2022 20:52:12 -0600
> > > > > Bjorn Helgaas <helgaas@kernel.org> wrote:  
> > > > > > On Thu, Jan 27, 2022 at 03:46:15PM +0100, Mariusz Tkaczyk
> > > > > > wrote:  
> > > > > > > ...
> > > > > > > Thanks for your suggestions. Blazej did some tests and
> > > > > > > results were inconclusive. He tested it on two same
> > > > > > > platforms. On the first one it didn't work, even if he
> > > > > > > reverted all suggested patches. On the second one hotplugs
> > > > > > > always worked.
> > > > > > >
> > > > > > > He noticed that on first platform where issue has been found
> > > > > > > initally, there was boot parameter "pci=nommconf". After
> > > > > > > adding this parameter on the second platform, hotplugs
> > > > > > > stopped working too.
> > > > > > >
> > > > > > > Tested on tag pci-v5.17-changes. He have
> > > > > > > CONFIG_HOTPLUG_PCI_PCIE and CONFIG_DYNAMIC_DEBUG enabled in
> > > > > > > config. He also attached two dmesg logs to bugzilla with
> > > > > > > boot parameter 'dyndbg="file pciehp* +p" as requested. One
> > > > > > > with "pci=nommconf" and one without.
> > > > > > >
> > > > > > > Issue seems to related to "pci=nommconf" and it is probably
> > > > > > > caused by change outside pciehp.  
> > > > > >
> > > > > > Maybe I'm missing something.  If I understand correctly, the
> > > > > > problem has nothing to do with the kernel version (correct me
> > > > > > if I'm wrong!)  
> > > > >
> > > > > The problem occurred after the merge commit. It is some kind of
> > > > > regression.  
> > > >
> > > > The bug report doesn't yet contain the evidence showing this.  It
> > > > only contains dmesg logs with "pci=nommconf" where pciehp doesn't
> > > > work (which is the expected behavior) and a log without
> > > > "pci=nommconf" where pciehp does work (which is again the
> > > > expected behavior). 
> > > > > > PCIe native hotplug doesn't work when booted with
> > > > > > "pci=nommconf". When using "pci=nommconf", obviously we can't
> > > > > > access the extended PCI config space (offset 0x100-0xfff), so
> > > > > > none of the extended capabilities are available.
> > > > > >
> > > > > > In that case, we don't even ask the platform for control of
> > > > > > PCIe hotplug via _OSC.  From the dmesg diff from normal
> > > > > > (working) to "pci=nommconf" (not working):
> > > > > >
> > > > > >   -Command line: BOOT_IMAGE=/boot/vmlinuz-smp ...
> > > > > >   +Command line: BOOT_IMAGE=/boot/vmlinuz-smp pci=nommconf ...
> > > > > >   ...
> > > > > >   -acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM
> > > > > > ClockPM Segments MSI HPX-Type3] -acpi PNP0A08:00: _OSC:
> > > > > > platform does not support [AER LTR] -acpi PNP0A08:00: _OSC:
> > > > > > OS now controls [PCIeHotplug PME PCIeCapability] +acpi
> > > > > > PNP0A08:00: _OSC: OS supports [ASPM ClockPM Segments MSI
> > > > > > HPX-Type3] +acpi PNP0A08:00: _OSC: not requesting OS control;
> > > > > > OS requires [ExtendedConfig ASPM ClockPM MSI] +acpi
> > > > > > PNP0A08:00: MMCONFIG is disabled, can't access extended PCI
> > > > > > configuration space under this bridge.  
> > > > >
> > > > > So, it shouldn't work from years but it has been broken
> > > > > recently, that is the only objection I have. Could you tell why
> > > > > it was working? According to your words- it shouldn't. We are
> > > > > using VMD driver, is that matter?  
> > > >
> > > > 04b12ef163d1 ("PCI: vmd: Honor ACPI _OSC on PCIe features") looks
> > > > like a it could be related.  Try reverting that commit and see
> > > > whether it makes a difference.  
> > > 
> > > The affected NVMe is indeed behind VMD domain, so I think the commit
> > > can make a difference.
> > > 
> > > Does VMD behave differently on laptops and servers?
> > > Anyway, I agree that the issue really lies in "pci=nommconf".  
> > 
> > Oh, I have a guess:
> > 
> >   - With "pci=nommconf", prior to v5.17-rc1, pciehp did not work in
> >     general, but *did* work for NVMe behind a VMD.  As of v5.17-rc1,
> >     pciehp no longer works for NVMe behind VMD.
> > 
> >   - Without "pci=nommconf", pciehp works as expected for all devices
> >     including NVMe behind VMD, both before and after v5.17-rc1.
> > 
> > Is that what you're observing?
> > 
> > If so, I doubt there's anything to fix other than getting rid of
> > "pci=nommconf".
> 
> I haven't tested with VMD disabled earlier. I verified it and my
> observations are as follows:
> 
> OS: RHEL 8.4
> NO - hotplug not working
> YES - hotplug working
> 
> pci=nommconf added:
> +--------------+-------------------+---------------------+--------------+
> |              | pci-v5.17-changes | revert-04b12ef163d1 | inbox kernel
> +--------------+-------------------+---------------------+--------------+
> | VMD enabled  | NO                | YES                 | YES         
> +--------------+-------------------+---------------------+--------------+
> | VMD disabled | NO                | NO                  | NO
> +--------------+-------------------+---------------------+--------------+
> 
> without pci=nommconf:
> +--------------+-------------------+---------------------+--------------+
> |              | pci-v5.17-changes | revert-04b12ef163d1 | inbox kernel
> +--------------+-------------------+---------------------+--------------+
> | VMD enabled  | YES               | YES                 | YES
> +--------------+-------------------+---------------------+--------------+
> | VMD disabled | YES               | YES                 | YES
> +--------------+-------------------+---------------------+--------------+
> 
> So, results confirmed your assumptions, but I also confirmed that
> revert of 04b12ef163d1 ("PCI: vmd: Honor ACPI _OSC on PCIe features")
> makes it to work as in inbox kernel.
> 
> We will drop the legacy parameter in our tests. According to my results
> there is a regression in VMD caused by: 04b12ef163d1 commit, even if it
> is not working for nvme anyway. Should it be fixed?

I don't know what the "inbox kernel" is.  I guess that's unmodified
RHEL 8.4?

And revert-04b12ef163d1 means the pci-v5.17-changes tag plus a revert
of 04b12ef163d1?

I think your "hotplug working" or "hotplug not working" notes refer
specifically to devices behind VMD, right?  They do not refer to
devices outside the VMD hierarchy?

So IIUC, the regression is that hotplug of devices behind VMD used to
work with "pci=nommconf", but it does not work after 04b12ef163d1.
IMO that does not need to be fixed because it was arguably a bug that
it *did* work before.

That said, I'm not 100% confident about 04b12ef163d1 because _OSC is a
way to negotiate ownership of things that could be owned either by
platform firmware or by the OS, and the commit log doesn't make it
clear that's the situation here.  It's more of a "the problem doesn't
happen when we do this" sort of commit log.

If there's anything more to do here, it would be helpful to attach
complete dmesg logs from the scenarios of interest to the bugzilla.
That will help remove ambiguity about what's being tested and what the
results are.

Bjorn

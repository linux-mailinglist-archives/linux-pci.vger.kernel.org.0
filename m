Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49EC449FA5B
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jan 2022 14:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241728AbiA1NIK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jan 2022 08:08:10 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46834 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241382AbiA1NIJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Jan 2022 08:08:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A72EAB825A7
        for <linux-pci@vger.kernel.org>; Fri, 28 Jan 2022 13:08:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F11C340E0;
        Fri, 28 Jan 2022 13:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643375287;
        bh=oCdcX/+qFa3JDt73P3V/OpivLx1JCbzYpsZ7vu4YxKg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nyQhTsuxUUATVDFlXKfpcXsCMGq2SGNOagK9H50LTYFAKSOVeNDyinyG9yeey/zZM
         3LRqCsTZhZTCRdOE+itDXQva9UnNxKLE7zYqpr27bkxJ+9sTa1W4+5Mm1TsA2LPwp/
         TJSW5PNkpNWxwhu0K4SZ6+vlv9k5XPw+zaLCYXIimvK6SvOGgUqFqckTKbNy14JSP0
         jwEjDv9v6yvNEUx5DTruDJie6C93bnaU9qh5+UJJn2GXCTVU9rh8YwQfEpr2am2sP3
         cw/rnAZZex6zigcWythkcPQ5j/RXboWeYUaH/JHa17ge9VrHrtLBk5oTcn3ZZHy6o2
         jKV0F5o2SoaPA==
Date:   Fri, 28 Jan 2022 07:08:05 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, Blazej Kucman <blazej.kucman@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Lukas Wunner <lukas@wunner.de>,
        Naveen Naidu <naveennaidu479@gmail.com>,
        Keith Busch <kbusch@kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [Bug 215525] New: HotPlug does not work on upstream kernel
 5.17.0-rc1
Message-ID: <20220128130805.GA199531@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128092931.00004a24@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Kai-Heng]

On Fri, Jan 28, 2022 at 09:29:31AM +0100, Mariusz Tkaczyk wrote:
> On Thu, 27 Jan 2022 20:52:12 -0600
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Thu, Jan 27, 2022 at 03:46:15PM +0100, Mariusz Tkaczyk wrote:
> > > ...
> > > Thanks for your suggestions. Blazej did some tests and results were
> > > inconclusive. He tested it on two same platforms. On the first one
> > > it didn't work, even if he reverted all suggested patches. On the
> > > second one hotplugs always worked.
> > > 
> > > He noticed that on first platform where issue has been found
> > > initally, there was boot parameter "pci=nommconf". After adding
> > > this parameter on the second platform, hotplugs stopped working too.
> > > 
> > > Tested on tag pci-v5.17-changes. He have CONFIG_HOTPLUG_PCI_PCIE
> > > and CONFIG_DYNAMIC_DEBUG enabled in config. He also attached two
> > > dmesg logs to bugzilla with boot parameter 'dyndbg="file pciehp*
> > > +p" as requested. One with "pci=nommconf" and one without.
> > > 
> > > Issue seems to related to "pci=nommconf" and it is probably caused
> > > by change outside pciehp.  
> > 
> > Maybe I'm missing something.  If I understand correctly, the problem
> > has nothing to do with the kernel version (correct me if I'm wrong!)
> 
> The problem occurred after the merge commit. It is some kind of
> regression.

The bug report doesn't yet contain the evidence showing this.  It only
contains dmesg logs with "pci=nommconf" where pciehp doesn't work
(which is the expected behavior) and a log without "pci=nommconf"
where pciehp does work (which is again the expected behavior).

> > PCIe native hotplug doesn't work when booted with "pci=nommconf".
> > When using "pci=nommconf", obviously we can't access the extended PCI
> > config space (offset 0x100-0xfff), so none of the extended
> > capabilities are available.
> > 
> > In that case, we don't even ask the platform for control of PCIe
> > hotplug via _OSC.  From the dmesg diff from normal (working) to
> > "pci=nommconf" (not working):
> > 
> >   -Command line: BOOT_IMAGE=/boot/vmlinuz-smp ...
> >   +Command line: BOOT_IMAGE=/boot/vmlinuz-smp pci=nommconf ...
> >   ...
> >   -acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM
> > Segments MSI HPX-Type3] -acpi PNP0A08:00: _OSC: platform does not
> > support [AER LTR] -acpi PNP0A08:00: _OSC: OS now controls
> > [PCIeHotplug PME PCIeCapability] +acpi PNP0A08:00: _OSC: OS supports
> > [ASPM ClockPM Segments MSI HPX-Type3] +acpi PNP0A08:00: _OSC: not
> > requesting OS control; OS requires [ExtendedConfig ASPM ClockPM MSI]
> > +acpi PNP0A08:00: MMCONFIG is disabled, can't access extended PCI
> > configuration space under this bridge.
> 
> So, it shouldn't work from years but it has been broken recently, that
> is the only objection I have. Could you tell why it was working?
> According to your words- it shouldn't. We are using VMD driver, is that
> matter?

04b12ef163d1 ("PCI: vmd: Honor ACPI _OSC on PCIe features") looks like
a it could be related.  Try reverting that commit and see whether it
makes a difference.

Bjorn

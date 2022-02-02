Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292744A74EB
	for <lists+linux-pci@lfdr.de>; Wed,  2 Feb 2022 16:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345572AbiBBPsK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Feb 2022 10:48:10 -0500
Received: from mga06.intel.com ([134.134.136.31]:26360 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233239AbiBBPsJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Feb 2022 10:48:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643816889; x=1675352889;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=38SiJR30JRvEH1kPR7i/NbxYyC25bjXvYiqhbNVmb1c=;
  b=IfWzj9t807dZeDAhOSr5kBMI56HIvb0HiyySky+f93rTlw/bex26oryz
   MlGL4L3HX5tFGaOPKMBJkwg8SeAHtnLQregSmtoBTlYfECLuUKwPrMHvB
   WfT70+L4oKw3I+8EQIHKL+6MX4O8RyqSVtv2IOne9FBw5x6Pz1yKoiRdt
   /v8vLOVEFzGSrS/M+n/M2zZVvTdNlh6dXc36/nb93UZDOA1mHvKeQOY7q
   YEIwKQ2KETe3LHDEUYcmDCbyXkTtYtnyVPfNxOKQU+Hytigp83LUyjyBg
   UWAqEPT7Vftr1c6b6piRUM6LrdrLD4zViY/VRb6X9oOKNJgE50BcNy+sc
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="308674476"
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="308674476"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 07:48:09 -0800
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="538303159"
Received: from bkucman-mobl.ger.corp.intel.com (HELO localhost) ([10.249.138.7])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 07:48:06 -0800
Date:   Wed, 2 Feb 2022 16:48:01 +0100
From:   Blazej Kucman <blazej.kucman@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
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
Message-ID: <20220202164801.00007228@linux.intel.com>
In-Reply-To: <20220128140328.GA206121@bhelgaas>
References: <CAAd53p5HJT-UHd-Bm9KhWaEKAhUiWcYerLaM=ztksAe4XdLLCA@mail.gmail.com>
        <20220128140328.GA206121@bhelgaas>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 28 Jan 2022 08:03:28 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Fri, Jan 28, 2022 at 09:49:34PM +0800, Kai-Heng Feng wrote:
> > On Fri, Jan 28, 2022 at 9:08 PM Bjorn Helgaas <helgaas@kernel.org>
> > wrote:  
> > > On Fri, Jan 28, 2022 at 09:29:31AM +0100, Mariusz Tkaczyk wrote:  
> > > > On Thu, 27 Jan 2022 20:52:12 -0600
> > > > Bjorn Helgaas <helgaas@kernel.org> wrote:  
> > > > > On Thu, Jan 27, 2022 at 03:46:15PM +0100, Mariusz Tkaczyk
> > > > > wrote:  
> > > > > > ...
> > > > > > Thanks for your suggestions. Blazej did some tests and
> > > > > > results were inconclusive. He tested it on two same
> > > > > > platforms. On the first one it didn't work, even if he
> > > > > > reverted all suggested patches. On the second one hotplugs
> > > > > > always worked.
> > > > > >
> > > > > > He noticed that on first platform where issue has been found
> > > > > > initally, there was boot parameter "pci=nommconf". After
> > > > > > adding this parameter on the second platform, hotplugs
> > > > > > stopped working too.
> > > > > >
> > > > > > Tested on tag pci-v5.17-changes. He have
> > > > > > CONFIG_HOTPLUG_PCI_PCIE and CONFIG_DYNAMIC_DEBUG enabled in
> > > > > > config. He also attached two dmesg logs to bugzilla with
> > > > > > boot parameter 'dyndbg="file pciehp* +p" as requested. One
> > > > > > with "pci=nommconf" and one without.
> > > > > >
> > > > > > Issue seems to related to "pci=nommconf" and it is probably
> > > > > > caused by change outside pciehp.  
> > > > >
> > > > > Maybe I'm missing something.  If I understand correctly, the
> > > > > problem has nothing to do with the kernel version (correct me
> > > > > if I'm wrong!)  
> > > >
> > > > The problem occurred after the merge commit. It is some kind of
> > > > regression.  
> > >
> > > The bug report doesn't yet contain the evidence showing this.  It
> > > only contains dmesg logs with "pci=nommconf" where pciehp doesn't
> > > work (which is the expected behavior) and a log without
> > > "pci=nommconf" where pciehp does work (which is again the
> > > expected behavior). 
> > > > > PCIe native hotplug doesn't work when booted with
> > > > > "pci=nommconf". When using "pci=nommconf", obviously we can't
> > > > > access the extended PCI config space (offset 0x100-0xfff), so
> > > > > none of the extended capabilities are available.
> > > > >
> > > > > In that case, we don't even ask the platform for control of
> > > > > PCIe hotplug via _OSC.  From the dmesg diff from normal
> > > > > (working) to "pci=nommconf" (not working):
> > > > >
> > > > >   -Command line: BOOT_IMAGE=/boot/vmlinuz-smp ...
> > > > >   +Command line: BOOT_IMAGE=/boot/vmlinuz-smp pci=nommconf ...
> > > > >   ...
> > > > >   -acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM
> > > > > ClockPM Segments MSI HPX-Type3] -acpi PNP0A08:00: _OSC:
> > > > > platform does not support [AER LTR] -acpi PNP0A08:00: _OSC:
> > > > > OS now controls [PCIeHotplug PME PCIeCapability] +acpi
> > > > > PNP0A08:00: _OSC: OS supports [ASPM ClockPM Segments MSI
> > > > > HPX-Type3] +acpi PNP0A08:00: _OSC: not requesting OS control;
> > > > > OS requires [ExtendedConfig ASPM ClockPM MSI] +acpi
> > > > > PNP0A08:00: MMCONFIG is disabled, can't access extended PCI
> > > > > configuration space under this bridge.  
> > > >
> > > > So, it shouldn't work from years but it has been broken
> > > > recently, that is the only objection I have. Could you tell why
> > > > it was working? According to your words- it shouldn't. We are
> > > > using VMD driver, is that matter?  
> > >
> > > 04b12ef163d1 ("PCI: vmd: Honor ACPI _OSC on PCIe features") looks
> > > like a it could be related.  Try reverting that commit and see
> > > whether it makes a difference.  
> > 
> > The affected NVMe is indeed behind VMD domain, so I think the commit
> > can make a difference.
> > 
> > Does VMD behave differently on laptops and servers?
> > Anyway, I agree that the issue really lies in "pci=nommconf".  
> 
> Oh, I have a guess:
> 
>   - With "pci=nommconf", prior to v5.17-rc1, pciehp did not work in
>     general, but *did* work for NVMe behind a VMD.  As of v5.17-rc1,
>     pciehp no longer works for NVMe behind VMD.
> 
>   - Without "pci=nommconf", pciehp works as expected for all devices
>     including NVMe behind VMD, both before and after v5.17-rc1.
> 
> Is that what you're observing?
> 
> If so, I doubt there's anything to fix other than getting rid of
> "pci=nommconf".
> 
> Bjorn

I haven't tested with VMD disabled earlier. I verified it and my
observations are as follows:

OS: RHEL 8.4
NO - hotplug not working
YES - hotplug working

pci=nommconf added:
+--------------+-------------------+---------------------+--------------+
|              | pci-v5.17-changes | revert-04b12ef163d1 | inbox kernel
+--------------+-------------------+---------------------+--------------+
| VMD enabled  | NO                | YES                 | YES         
+--------------+-------------------+---------------------+--------------+
| VMD disabled | NO                | NO                  | NO
+--------------+-------------------+---------------------+--------------+

without pci=nommconf:
+--------------+-------------------+---------------------+--------------+
|              | pci-v5.17-changes | revert-04b12ef163d1 | inbox kernel
+--------------+-------------------+---------------------+--------------+
| VMD enabled  | YES               | YES                 | YES
+--------------+-------------------+---------------------+--------------+
| VMD disabled | YES               | YES                 | YES
+--------------+-------------------+---------------------+--------------+

So, results confirmed your assumptions, but I also confirmed that
revert of 04b12ef163d1 ("PCI: vmd: Honor ACPI _OSC on PCIe features")
makes it to work as in inbox kernel.

We will drop the legacy parameter in our tests. According to my results
there is a regression in VMD caused by: 04b12ef163d1 commit, even if it
is not working for nvme anyway. Should it be fixed?

Thanks,
Blazej

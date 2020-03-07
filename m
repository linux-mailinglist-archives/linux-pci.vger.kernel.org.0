Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F80817D052
	for <lists+linux-pci@lfdr.de>; Sat,  7 Mar 2020 22:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgCGVi5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 7 Mar 2020 16:38:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:59592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbgCGVi5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 7 Mar 2020 16:38:57 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5325D20684;
        Sat,  7 Mar 2020 21:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583617135;
        bh=wRRDVf3Gu6/R5mPXakBzTEOVe5CDIlaU/6Qd7toQ40I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=aom06JkBavFmYYgfaRnEw+EaXp1rdNfkuWnxEnUxLSK9208/Nb1Z9EKYVbyvODCp7
         1XN2KKIbZEXayNrywA61RO8Juhf523XbqTGeK+FrjOKs9ila5yswSql81EvkdODiCb
         2DsJIxGVetkHYzKYKu95HC7QGO/+dtCM15/UagBg=
Date:   Sat, 7 Mar 2020 15:38:53 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     =?iso-8859-1?Q?Lu=EDs?= Mendes <luis.p.mendes@gmail.com>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Problem with PCIe enumeration of Google/Coral TPU Edge module on
 Linux
Message-ID: <20200307213853.GA208095@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEzXK1oukcnjgkY8Y6rkHcBAKwSvTDJsJVCf7nix4eoPPFsNqg@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Mar 07, 2020 at 03:26:49PM +0000, Luís Mendes wrote:
> Hi,
> 
> A quick look at the logs, makes me wonder if BAR0-BAR5 are only being
> assigned to IO space on device by Linux, and BAR6 is the first bar
> index that Linux is assigning on armhf/arm64 for mem space. If so,
> that would be wrong because registers 0x10 and and 0x18 are BAR0 and
> BAR2.

BAR0-5 are the standard BARs and can be either mem or I/O space.
64-bit mem BARs take two slots, e.g.,

  pci 0000:02:00.0: reg 0x18: [mem 0x00000000-0x00000fff 64bit]
  pci 0000:02:00.0: reg 0x20: [mem 0x00000000-0x00003fff 64bit pref]

These are BAR2 (at 0x18 and 0x1c) and BAR4 (at 0x20 and 0x24).

> The TP-Link Gigabit LAN card that is installed on the other PCIe slot
> has BAR 0 enabled but it is IO space and according to the registers
> for the mem space, in that device, seen in dmesg, they are regs 0x18
> and 0x20, or, BAR 2 and BAR 4, but Linux is assigning them to have
> indices BAR 6 and BAR 8, since they are MEM space devices.

Our logging is a little screwed up: sometimes we print "reg 0x10",
other times "BAR 0":

  pci 0000:02:00.0: reg 0x10: [io  0x0000-0x00ff]
  pci 0000:02:00.0: reg 0x18: [mem 0x00000000-0x00000fff 64bit]
  pci 0000:02:00.0: reg 0x20: [mem 0x00000000-0x00003fff 64bit pref]
  pci 0000:02:00.0: BAR 4: assigned [mem 0xd0200000-0xd0203fff 64bit pref]
  pci 0000:02:00.0: BAR 2: assigned [mem 0xd0204000-0xd0204fff 64bit]
  pci 0000:02:00.0: BAR 0: assigned [io  0x10000-0x100ff]

Anyway, we end up with this, which looks fine:

  BAR0 (reg 0x10):       [io  0x10000-0x100ff]
  BAR2 (reg 0x18, 0x1c): [mem 0xd0204000-0xd0204fff 64bit]
  BAR4 (reg 0x20, 0x24): [mem 0xd0200000-0xd0203fff 64bit pref]

"BAR 6" is for option ROMs.  You have bridges with option ROMS (seems
sort of unusual, but legal), and we assign space for them:

  pci 0000:00:01.0: reg 0x38: [mem 0x00000000-0x000007ff pref]
  pci 0000:00:01.0: BAR 6: assigned [mem 0xd0300000-0xd03007ff pref]
  pci 0000:00:01.0: BAR 8: assigned [mem 0xd0000000-0xd01fffff]
  pci 0000:00:01.0: PCI bridge to [bus 01]
  pci 0000:00:01.0:   bridge window [mem 0xd0000000-0xd01fffff]

  pci 0000:00:02.0: reg 0x38: [mem 0x00000000-0x000007ff pref]
  pci 0000:00:02.0: BAR 6: assigned [mem 0xd0400000-0xd04007ff pref]
  pci 0000:00:02.0: BAR 8: assigned [mem 0xd0200000-0xd02fffff]
  pci 0000:00:02.0: PCI bridge to [bus 02]
  pci 0000:00:02.0:   bridge window [io  0x10000-0x10fff]
  pci 0000:00:02.0:   bridge window [mem 0xd0200000-0xd02fffff]

You don't have CONFIG_PCI_IOV enabled (see the enum in <linux/pci.h>),
so "BAR7" is is the bridge I/O window, "BAR8" is the MMIO window, and
"BAR9" is the prefetchable MMIO window.

The problematic device needs 16KB + 1MB of prefetchable memory space:

  pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit pref]
  pci 0000:01:00.0: reg 0x18: [mem 0x00000000-0x000fffff 64bit pref]

The bridge leading to it has a 2MB non-prefetchable window:

  pci 0000:00:01.0: PCI bridge to [bus 01]
  pci 0000:00:01.0:   bridge window [mem 0xd0000000-0xd01fffff]

That *should* work -- it's not prefetchable, but if we don't have
prefetchable space, non-prefetchable space should also work (with poor
performance, of course).  But maybe the fallback from prefetchable to
non-prefetchable space is broken or something.

> That looks wrong.... maybe the TP-Link device is working just because
> BAR 0 does happen to exist in this case, which happens to be the
> minimal requirement that allows pci_enable_device(...) to work,
> passing in the test 'if (!r->parent)' performed by
> pci_enable_resources(...) at drivers/pci/setup-res.c. Since most PCIe
> cards have IO space, this generally works.
> Can it be?
> 
> Luís
> 
> On Sat, Mar 7, 2020 at 12:11 PM Luís Mendes <luis.p.mendes@gmail.com> wrote:
> >
> > Hi Bjorn,
> >
> > Thanks for your help.
> >
> > On Fri, Mar 6, 2020 at 9:47 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >
> > > [+cc Thomas, Jason, Nicholas, Ben]
> > >
> > > On Fri, Mar 06, 2020 at 02:32:59PM +0000, Luís Mendes wrote:
> > > > Hi,
> > > >
> > > > I'm trying to use Google/Coral TPU Edge modules for a project, on
> > > > arm64 and armhf, but BAR0 doesn't get assigned during the enumeration
> > > > of PCIe devices and consequently pci_enable_device(...) fails on BAR0
> > > > resource with value -22 (EINVAL) (resource has null parent) when
> > > > loading gasket/apex driver.
> > > >
> > > > I'm also trying to adapt gasket/apex to run on armhf, but anyhow that
> > > > is not the root cause for this issue.
> > > >
> > > > Relevant Log extracts follow in attachment.
> > >
> > > Hi Luís,
> > >
> > > Thanks for the report, and sorry for the problem you're tripping over.
> > > I cc'd a few folks who might be interested.
> > >
> > > > [    6.983880] mvebu-pcie soc:pcie: /soc/pcie/pcie@1,0: reset gpio is active low
> > > > [    6.993528] hub 4-1:1.0: 4 ports detected
> > > > [    6.993749] mvebu-pcie soc:pcie: /soc/pcie/pcie@2,0: reset gpio is active low
> > > > [    7.106741]  sdb: sdb1
> > > > [    7.109826] sd 2:0:0:0: [sdb] Attached SCSI removable disk
> > > > [    7.242916] mvebu-pcie soc:pcie: PCI host bridge to bus 0000:00
> > > > [    7.248854] pci_bus 0000:00: root bus resource [bus 00-ff]
> > > > [    7.254370] pci_bus 0000:00: root bus resource [mem 0xd0000000-0xefffffff]
> > > > [    7.261267] pci_bus 0000:00: root bus resource [io  0x1000-0xeffff]
> > > > [    7.267621] pci 0000:00:01.0: [11ab:6828] type 01 class 0x060400
> > > > [    7.273662] pci 0000:00:01.0: reg 0x38: [mem 0x00000000-0x000007ff pref]
> > > > [    7.293971] PCI: bus0: Fast back to back transfers disabled
> > > > [    7.299558] pci 0000:00:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> > > > [    7.315694] pci 0000:01:00.0: [1ac1:089a] type 00 class 0x0000ff
> > > > [    7.321749] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit pref]
> > > > [    7.322814] usb 4-1.1: new high-speed USB device number 3 using xhci-hcd
> > > > [    7.329004] pci 0000:01:00.0: reg 0x18: [mem 0x00000000-0x000fffff 64bit pref]
> > > > [    7.343111] pci 0000:01:00.0: 2.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s x1 link at 0000:00:01.0 (capable of 4.000 Gb/s with 5 GT/s x1 link)
> > > > [    7.383442] PCI: bus1: Fast back to back transfers disabled
> > > > [    7.389031] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
> > > > [    7.495604] pci 0000:00:02.0: ASPM: current common clock configuration is broken, reconfiguring
> > > > [    7.552513] pci 0000:00:01.0: BAR 8: assigned [mem 0xe8000000-0xe81fffff]
> > > > [    7.565611] pci 0000:00:01.0: BAR 6: assigned [mem 0xe8200000-0xe82007ff pref]
> > > > [    7.580096] pci 0000:00:01.0: PCI bridge to [bus 01]
> > > > [    7.585079] pci 0000:00:01.0:   bridge window [mem 0xe8000000-0xe81fffff]
> > > > [    7.653228] pcieport 0000:00:01.0: enabling device (0140 -> 0142)
> > > >
> > > >
> > > > [   11.188025] gasket: module is from the staging directory, the quality is unknown, you have been warned.
> > > > [   11.217048] apex: module is from the staging directory, the quality is unknown, you have been warned.
> > > > [   11.217926] apex 0000:01:00.0: can't enable device: BAR 0 [mem 0x00000000-0x00003fff 64bit pref] not claimed
> > > > [   11.227825] apex 0000:01:00.0: error enabling PCI device
> > >
> > > It looks like we did assign space for the bridge window leading to
> > > 01:00.0, but failed to assign space to the 01:00.0 BAR itself.
> > >
> > > I don't know offhand why that would be.  Can you put the entire dmesg
> > > log somewhere we can see?  That will tell us what kernel you're using
> > > and possibly other useful things.
> >
> > Sure, complete dmesg is available at: https://pastebin.ubuntu.com/p/qnzJ56kM7k/
> > This is a custom built machine based on the Armada 388 armhf SoC, that
> > I am using, but I've also tried an arm64 machine from Toradex, an
> > Apalis IMX8QM with the Apalis Eval board, producing similar results
> > with different kernels and also different ARM architectures.
> > >
> > > Does the same problem happen with other devices, or does it only
> > > happen with the gasket/apex combination?  There shouldn't be anything
> > > device-specific in the PCI core resource assignment code.
> >
> > This issue seems to happen only with the Coral Edge TPU device, but it
> > happens independently of whether the gasket/apex driver module is
> > loaded or not. The BAR 0 of the Coral device is not assigned either
> > way.
> >
> > Luís

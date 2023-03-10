Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39FF26B5609
	for <lists+linux-pci@lfdr.de>; Sat, 11 Mar 2023 00:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjCJXxO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Mar 2023 18:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbjCJXxN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Mar 2023 18:53:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB751CBDC
        for <linux-pci@vger.kernel.org>; Fri, 10 Mar 2023 15:53:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16EDC61D85
        for <linux-pci@vger.kernel.org>; Fri, 10 Mar 2023 23:53:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 278C7C433EF;
        Fri, 10 Mar 2023 23:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678492388;
        bh=VTMKs9Fnu8vLRaanAoeNbsMRAgh9P1SVDUSHIBCv4OI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ktcFdJQRo9rdFrztOcXiDQ7YtF2NhB1Du1DDFWg1Eovi6yb1sFg2fCQfVwcZNUzP/
         XmBe9ear72VqJAxmdsafUIVH1TIENIy/Z6NC6LeynhmZ1+D6I0WelFHR6uken38hok
         +jeTwEmfbg7/JvdZ3UKxbwTOXVmixLhbgobPqBoiyPmZDlZ9Sdba1rNfVGNi1LtzIW
         LivWQNUIEr3R7wJmcNAeS41ABMq0SQIMaPC2T4+WFhdXDLG5qucilUAkD2wWl3r5KW
         5UmMVZAiZnanMlQ57E00rihUjAZBvMjhywt/u7YOngrVHr7I0jg0KeXo5yxQVDeXSr
         6YuYQa0My73kg==
Date:   Fri, 10 Mar 2023 17:53:06 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Tushar Dave <tdave@nvidia.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
        kbusch@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: nvme-pci: Disabling device after reset failure: -5 occurs while
 AER recovery
Message-ID: <20230310235306.GA1290793@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <843e2392-9ff0-2286-5f97-659831013c2e@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Lukas, beginning of thread:
https://lore.kernel.org/all/de1b20e5-ded1-0aae-2221-f5d470d91015@nvidia.com/]

On Fri, Mar 10, 2023 at 02:39:19PM -0800, Tushar Dave wrote:
> On 3/9/23 09:53, Bjorn Helgaas wrote:
> > On Wed, Mar 08, 2023 at 07:34:58PM -0800, Tushar Dave wrote:
> > > On 3/7/23 03:59, Sagi Grimberg wrote:
> > > > On 3/2/23 02:09, Tushar Dave wrote:
> > > > > We are observing NVMe device disabled due to reset failure after
> > > > > injecting Malformed TLP. DPC/AER recovery succeed but NVMe fails.
> > > > > I tried this on 2 different system and it is 100% reproducible with 6.2
> > > > > kernel.
> > > > > 
> > > > > On my system, Samsung NVMe SSD Controller PM173X is directly behind the
> > > > > Broadcom PCIe Switch Downstream Port.
> > > > > MalformedTLP is injected by changing MaxPayload Size(MPS) of PCIe switch
> > > > > to 128B (keeping NVMe device MPS 512B).
> > > > > 
> > > > > e.g.
> > > > > # change MPS of PCIe switch (a9:10.0)
> > > > > $ setpci -v -s a9:10.0 cap_exp+0x8.w
> > > > > 0000:a9:10.0 (cap 10 @68) @70 = 0857
> > > > > $ setpci -v -s a9:10.0 cap_exp+0x8.w=0x0817
> > > > > 0000:a9:10.0 (cap 10 @68) @70 0817
> > > > > $ lspci -s a9:10.0 -vvv | grep -w DevCtl -A 2
> > > > >           DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq-
> > > > >               RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
> > > > >               MaxPayload 128 bytes, MaxReadReq 128 bytes
> > > > > 
> > > > > # run some traffic on nvme (ab:00.0)
> > > > > $ dd if=/dev/nvme0n1 of=/tmp/test bs=4K
> > > > > dd: error reading '/dev/nvme0n1': Input/output error
> > > > > 2+0 records in
> > > > > 2+0 records out
> > > > > 8192 bytes (8.2 kB, 8.0 KiB) copied, 0.0115304 s, 710 kB/s
> > > > > 
> > > > > #kernel log:
> > > > > [  163.034889] pcieport 0000:a5:01.0: EDR: EDR event received
> > > > > [  163.041671] pcieport 0000:a5:01.0: EDR: Reported EDR dev: 0000:a9:10.0
> > > > > [  163.049071] pcieport 0000:a9:10.0: DPC: containment event,
> > > > > status:0x2009 source:0x0000
> > > > > [  163.058014] pcieport 0000:a9:10.0: DPC: unmasked uncorrectable error
> > > > > detected
> > > > > [  163.066081] pcieport 0000:a9:10.0: PCIe Bus Error:
> > > > > severity=Uncorrected (Fatal), type=Transaction Layer, (Receiver ID)
> > > > > [  163.078151] pcieport 0000:a9:10.0:   device [1000:c030] error
> > > > > status/mask=00040000/00180000
> > > > > [  163.087613] pcieport 0000:a9:10.0:    [18] MalfTLP
> > > > > (First)
> > > > > [  163.095281] pcieport 0000:a9:10.0: AER:   TLP Header: 60000080
> > > > > ab0000ff 00000001 d1fd0000
> > > > > [  163.104517] pcieport 0000:a9:10.0: AER: broadcast error_detected message
> > > > > [  163.112095] nvme nvme0: frozen state error detected, reset controller
> > > > > [  163.150716] nvme0c0n1: I/O Cmd(0x2) @ LBA 16, 32 blocks, I/O Error
> > > > > (sct 0x3 / sc 0x71)
> > > > > [  163.159802] I/O error, dev nvme0c0n1, sector 16 op 0x0:(READ) flags
> > > > > 0x4080700 phys_seg 4 prio class 2
> > > > > [  163.383661] pcieport 0000:a9:10.0: AER: broadcast slot_reset message
> > > > > [  163.390895] nvme nvme0: restart after slot reset
> > > > > [  163.396230] nvme 0000:ab:00.0: restoring config space at offset 0x3c
> > > > > (was 0x100, writing 0x1ff)
> > > > > [  163.406079] nvme 0000:ab:00.0: restoring config space at offset 0x30
> > > > > (was 0x0, writing 0xe0600000)
> > > > > [  163.416212] nvme 0000:ab:00.0: restoring config space at offset 0x10
> > > > > (was 0x4, writing 0xe0710004)
> > > > > [  163.426326] nvme 0000:ab:00.0: restoring config space at offset 0xc
> > > > > (was 0x0, writing 0x8)
> > > > > [  163.435666] nvme 0000:ab:00.0: restoring config space at offset 0x4
> > > > > (was 0x100000, writing 0x100546)
> > > > > [  163.446026] pcieport 0000:a9:10.0: AER: broadcast resume message
> > > > > [  163.468311] nvme 0000:ab:00.0: saving config space at offset 0x0
> > > > > (reading 0xa824144d)
> > > > > [  163.477209] nvme 0000:ab:00.0: saving config space at offset 0x4
> > > > > (reading 0x100546)
> > > > > [  163.485876] nvme 0000:ab:00.0: saving config space at offset 0x8
> > > > > (reading 0x1080200)
> > > > > [  163.495399] nvme 0000:ab:00.0: saving config space at offset 0xc
> > > > > (reading 0x8)
> > > > > [  163.504149] nvme 0000:ab:00.0: saving config space at offset 0x10
> > > > > (reading 0xe0710004)
> > > > > [  163.513596] nvme 0000:ab:00.0: saving config space at offset 0x14
> > > > > (reading 0x0)
> > > > > [  163.522310] nvme 0000:ab:00.0: saving config space at offset 0x18
> > > > > (reading 0x0)
> > > > > [  163.531013] nvme 0000:ab:00.0: saving config space at offset 0x1c
> > > > > (reading 0x0)
> > > > > [  163.539704] nvme 0000:ab:00.0: saving config space at offset 0x20
> > > > > (reading 0x0)
> > > > > [  163.548353] nvme 0000:ab:00.0: saving config space at offset 0x24
> > > > > (reading 0x0)
> > > > > [  163.556983] nvme 0000:ab:00.0: saving config space at offset 0x28
> > > > > (reading 0x0)
> > > > > [  163.565615] nvme 0000:ab:00.0: saving config space at offset 0x2c
> > > > > (reading 0xa80a144d)
> > > > > [  163.574899] nvme 0000:ab:00.0: saving config space at offset 0x30
> > > > > (reading 0xe0600000)
> > > > > [  163.584215] nvme 0000:ab:00.0: saving config space at offset 0x34
> > > > > (reading 0x40)
> > > > > [  163.592941] nvme 0000:ab:00.0: saving config space at offset 0x38
> > > > > (reading 0x0)
> > > > > [  163.601554] nvme 0000:ab:00.0: saving config space at offset 0x3c
> > > > > (reading 0x1ff)
> > > > > [  210.089132] block nvme0n1: no usable path - requeuing I/O
> > > > > [  223.776595] nvme nvme0: I/O 18 QID 0 timeout, disable controller
> > > > > [  223.825236] nvme nvme0: Identify Controller failed (-4)
> > > > > [  223.832145] nvme nvme0: Disabling device after reset failure: -5
> > > > 
> > > > At this point the device is not going to recover.
> > >
> > > Yes, I agree.
> > > 
> > > I looked little bit more and found that nvme reset failure and second DPC,
> > > both were due to nvme_slot_reset() restoring MPS as part of
> > > pci_restore_state().
> > > 
> > > AFAICT, after the first DPC event occurs, nvme device MPS gets changed to
> > > _default_ value 128B (this is likely due to DPC link retraining). However as
> > > part of software AER recovery, nvme_slot_reset() restores device state, and
> > > that brings the nvme device MPS back to 512B. (MPS of PCIe switch a9:10.0
> > > still remains at 128B).
> > > 
> > > At this point when nvme_reset_ctrl->nvme_reset_work() tries to enable the
> > > device, malformedTLP again getting generated and that causes second DPC,
> > > makes NVMe controller reset to fail as well.
> > 
> > This sounds like the behavior I expect.  IIUC:
> > 
> >    - Switch and NVMe MPS are 512B
> >    - NVMe config space saved (including MPS=512B)
> >    - You change Switch MPS to 128B
> >    - NVMe does DMA with payload > 128B
> >    - Switch reports Malformed TLP because TLP is larger than its MPS
> >    - Recovery resets NVMe, which sets MPS to the default of 128B
> >    - nvme_slot_reset() restores NVMe config space (MPS is now 512B)
> >    - Subsequent NVMe DMA with payload > 128B repeats cycle
> > 
> > What do you think *should* be happening here?  I don't see a PCI
> > problem here.  If you change MPS on the Switch without coordinating
> > with NVMe, things aren't going to work.  Or am I missing something?
> 
> I agree this is expected but there are instances where I do _not_ see the
> issue occurring. That is due to involvement of pciehp, which add and
> configure nvme device - (coordinates MPS with pcie switch, and the new MPS
> will get saved too. So future tests of this kind won't reproduce this issue
> and that is understood).
> 
> IMO though, the result of the test should be consistent.
> Either pciehp/DPC should take care of device recovery 100% all the time;
> Or we consider nvme recovery failure as an expected result because MPS of
> pcie switch got changed without coordinating with nvme.
> 
> What do you think?

In the log below, pciehp obviously is enabled; should I infer that in
the log above, it is not?

Generally we've avoided handling a device reset as a remove/add event
because upper layers can't deal well with that.  But in the log below
it looks like pciehp *did* treat the DPC containment as a remove/add,
which of course involves configuring the "new" device and its MPS
settings.

  [  217.071200] pcieport 0000:a9:10.0: AER: broadcast slot_reset message
  [  217.071217] nvme nvme0: restart after slot reset
  [  217.071234] pcieport 0000:a9:10.0: pciehp: Slot(272): Link Down/Up ignored (recovered by DPC)
  [  217.071250] pcieport 0000:a9:10.0: pciehp: pciehp_check_link_active: lnk_status = 2044
  [  217.071259] pcieport 0000:a9:10.0: pciehp: Slot(272): Card not present
  [  217.071267] pcieport 0000:a9:10.0: pciehp: pciehp_unconfigure_device: domain:bus:dev = 0000:ab:00
  [  217.071320] nvme 0000:ab:00.0: restoring config space at offset 0x3c (was 0x100, writing 0x1ff)
  [  217.071451] nvme 0000:ab:00.0: nvme_slot_reset: after pci_restore_state, DEVCTL: 0x5957

The .slot_reset() method (nvme_slot_reset()) is called *after* the
device has been reset, and the device is supposed to be ready for the
driver to use it.  But here it looks like pciehp thinks ab:00.0 is not
present, so it removes it.  Later ab:00.0 is present again, so we
re-enumerate it:

  [  217.311892] pcieport 0000:a9:10.0: pciehp: Slot(272): Card present
  [  217.311897] pcieport 0000:a9:10.0: pciehp: Slot(272): Link Up
  [  217.455159] pcieport 0000:a9:10.0: pciehp: pciehp_check_link_status: lnk_status = 2044
  [  217.455222] pci 0000:ab:00.0: [144d:a824] type 00 class 0x010802

What kernel are you testing?  53b54ad074de ("PCI/DPC: Await readiness
of secondary bus after reset") looks like it could be related, but
you'd have to be using v6.3-rc1 or later to get it.

> e.g. [ when pciehp takes care of things]
> 
> [  216.608538] pcieport 0000:a9:10.0: pciehp: pending interrupts 0x0108 from
> Slot Status
> [  216.639954] pcieport 0000:a5:01.0: EDR: EDR event received
> [  216.640429] pcieport 0000:a5:01.0: EDR: Reported EDR dev: 0000:a9:10.0
> [  216.640438] pcieport 0000:a9:10.0: DPC: containment event, status:0x2009
> source:0x0000
> [  216.640442] pcieport 0000:a9:10.0: DPC: unmasked uncorrectable error detected
> [  216.640452] pcieport 0000:a9:10.0: PCIe Bus Error: severity=Uncorrected
> (Fatal), type=Transaction Layer, (Receiver ID)
> [  216.652549] pcieport 0000:a9:10.0:   device [1000:c030] error
> status/mask=00040000/00180000
> [  216.661975] pcieport 0000:a9:10.0:    [18] MalfTLP                (First)
> [  216.669647] pcieport 0000:a9:10.0: AER:   TLP Header: 60000080 ab0000ff
> 00000102 276fe000
> [  216.678890] pcieport 0000:a9:10.0: AER: broadcast error_detected message
> [  216.678898] nvme nvme0: frozen state error detected, reset controller
> [  216.842570] nvme0c0n1: I/O Cmd(0x2) @ LBA 16, 32 blocks, I/O Error (sct
> 0x3 / sc 0x71)
> [  216.851684] I/O error, dev nvme0c0n1, sector 16 op 0x0:(READ) flags
> 0x4080700 phys_seg 4 prio class 2
> [  217.071200] pcieport 0000:a9:10.0: AER: broadcast slot_reset message
> [  217.071217] nvme nvme0: restart after slot reset
> [  217.071228] nvme 0000:ab:00.0: nvme_slot_reset: before pci_restore_state
> DEVCTL: 0x2910
> [  217.071234] pcieport 0000:a9:10.0: pciehp: Slot(272): Link Down/Up
> ignored (recovered by DPC)
> [  217.071250] pcieport 0000:a9:10.0: pciehp: pciehp_check_link_active:
> lnk_status = 2044
> [  217.071259] pcieport 0000:a9:10.0: pciehp: Slot(272): Card not present
> [  217.071267] pcieport 0000:a9:10.0: pciehp: pciehp_unconfigure_device:
> domain:bus:dev = 0000:ab:00
> [  217.071320] nvme 0000:ab:00.0: restoring config space at offset 0x3c (was
> 0x100, writing 0x1ff)
> [  217.071346] nvme 0000:ab:00.0: restoring config space at offset 0x30 (was
> 0x0, writing 0xe0600000)
> [  217.071373] nvme 0000:ab:00.0: restoring config space at offset 0x10 (was
> 0x4, writing 0xe0710004)
> [  217.071383] nvme 0000:ab:00.0: restoring config space at offset 0xc (was
> 0x0, writing 0x8)
> [  217.071394] nvme 0000:ab:00.0: restoring config space at offset 0x4 (was
> 0x100000, writing 0x100546)
> [  217.071451] nvme 0000:ab:00.0: nvme_slot_reset: after pci_restore_state,
> DEVCTL: 0x5957
> [  217.071464] pcieport 0000:a9:10.0: AER: broadcast resume message
> [  217.071467] nvme 0000:ab:00.0: PME# disabled
> [  217.071513] pcieport 0000:a9:10.0: AER: device recovery successful
> [  217.071522] pcieport 0000:a9:10.0: EDR: DPC port successfully recovered
> [  217.071526] nvme 0000:ab:00.0: vgaarb: pci_notify
> [  217.071531] pcieport 0000:a5:01.0: EDR: Status for 0000:a9:10.0: 0x80
> [  217.071614] nvme nvme0: ctrl state 6 is not RESETTING
> [  217.103486] Buffer I/O error on dev nvme0n1, logical block 2, async page read
> [  217.308778] pci 0000:ab:00.0: vgaarb: pci_notify
> [  217.308831] pci 0000:ab:00.0: vgaarb: pci_notify
> [  217.311299] pci 0000:ab:00.0: vgaarb: pci_notify
> [  217.311863] pci 0000:ab:00.0: device released
> [  217.311887] pcieport 0000:a9:10.0: pciehp: pciehp_check_link_active:
> lnk_status = 2044
> [  217.311892] pcieport 0000:a9:10.0: pciehp: Slot(272): Card present
> [  217.311897] pcieport 0000:a9:10.0: pciehp: Slot(272): Link Up
> [  217.455159] pcieport 0000:a9:10.0: pciehp: pciehp_check_link_status:
> lnk_status = 2044
> [  217.455222] pci 0000:ab:00.0: [144d:a824] type 00 class 0x010802
> [  217.455275] pci 0000:ab:00.0: reg 0x10: [mem 0xe0710000-0xe0717fff 64bit]
> [  217.455362] pci 0000:ab:00.0: reg 0x30: [mem 0xe0600000-0xe060ffff pref]
> [  217.455380] pci 0000:ab:00.0: Max Payload Size set to 128 (was 512, max 512)
> [  217.455726] pci 0000:ab:00.0: reg 0x20c: [mem 0xe0610000-0xe0617fff 64bit]
> [  217.455732] pci 0000:ab:00.0: VF(n) BAR0 space: [mem
> 0xe0610000-0xe070ffff 64bit] (contains BAR0 for 32 VFs)
> [  217.456307] pci 0000:ab:00.0: vgaarb: pci_notify
> [  217.456404] pcieport 0000:a9:10.0: bridge window [io  0x1000-0x0fff] to
> [bus ab] add_size 1000
> [  217.456413] pcieport 0000:a9:10.0: bridge window [mem
> 0x00100000-0x000fffff 64bit pref] to [bus ab] add_size 200000 add_align
> 100000
> [  217.456430] pcieport 0000:a9:10.0: BAR 15: no space for [mem size
> 0x00200000 64bit pref]
> [  217.456436] pcieport 0000:a9:10.0: BAR 15: failed to assign [mem size
> 0x00200000 64bit pref]
> [  217.456440] pcieport 0000:a9:10.0: BAR 13: no space for [io  size 0x1000]
> [  217.456444] pcieport 0000:a9:10.0: BAR 13: failed to assign [io  size 0x1000]
> [  217.456451] pcieport 0000:a9:10.0: BAR 15: no space for [mem size
> 0x00200000 64bit pref]
> [  217.456457] pcieport 0000:a9:10.0: BAR 15: failed to assign [mem size
> 0x00200000 64bit pref]
> [  217.456464] pcieport 0000:a9:10.0: BAR 13: no space for [io  size 0x1000]
> [  217.456470] pcieport 0000:a9:10.0: BAR 13: failed to assign [io  size 0x1000]
> [  217.456480] pci 0000:ab:00.0: BAR 6: assigned [mem 0xe0600000-0xe060ffff pref]
> [  217.456488] pci 0000:ab:00.0: BAR 0: assigned [mem 0xe0610000-0xe0617fff 64bit]
> [  217.456509] pci 0000:ab:00.0: BAR 7: assigned [mem 0xe0618000-0xe0717fff 64bit]
> [  217.456517] pcieport 0000:a9:10.0: PCI bridge to [bus ab]
> [  217.456526] pcieport 0000:a9:10.0:   bridge window [mem 0xe0600000-0xe07fffff]
> [  217.456614] nvme 0000:ab:00.0: vgaarb: pci_notify
> [  217.456624] nvme 0000:ab:00.0: runtime IRQ mapping not provided by arch
> [  217.457452] nvme nvme10: pci function 0000:ab:00.0
> [  217.458154] nvme 0000:ab:00.0: saving config space at offset 0x0 (reading
> 0xa824144d)
> [  217.458166] nvme 0000:ab:00.0: saving config space at offset 0x4 (reading
> 0x100546)
> [  217.458173] nvme 0000:ab:00.0: saving config space at offset 0x8 (reading
> 0x1080200)
> [  217.458179] nvme 0000:ab:00.0: saving config space at offset 0xc (reading 0x8)
> [  217.458185] nvme 0000:ab:00.0: saving config space at offset 0x10
> (reading 0xe0610004)
> [  217.458192] nvme 0000:ab:00.0: saving config space at offset 0x14 (reading 0x0)
> [  217.458198] nvme 0000:ab:00.0: saving config space at offset 0x18 (reading 0x0)
> [  217.458202] nvme 0000:ab:00.0: saving config space at offset 0x1c (reading 0x0)
> [  217.458207] nvme 0000:ab:00.0: saving config space at offset 0x20 (reading 0x0)
> [  217.458212] nvme 0000:ab:00.0: saving config space at offset 0x24 (reading 0x0)
> [  217.458217] nvme 0000:ab:00.0: saving config space at offset 0x28 (reading 0x0)
> [  217.458222] nvme 0000:ab:00.0: saving config space at offset 0x2c
> (reading 0xa80a144d)
> [  217.458227] nvme 0000:ab:00.0: saving config space at offset 0x30
> (reading 0xe0600000)
> [  217.458237] nvme 0000:ab:00.0: saving config space at offset 0x34 (reading 0x40)
> [  217.458242] nvme 0000:ab:00.0: saving config space at offset 0x38 (reading 0x0)
> [  217.458247] nvme 0000:ab:00.0: saving config space at offset 0x3c (reading 0x1ff)
> [  217.462192] nvme nvme10: Shutdown timeout set to 10 seconds
> [  217.520625] nvme nvme10: 63/0/0 default/read/poll queues

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD5691DDA86
	for <lists+linux-pci@lfdr.de>; Fri, 22 May 2020 00:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730621AbgEUWtv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 May 2020 18:49:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:46982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730690AbgEUWtv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 May 2020 18:49:51 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9982207D8;
        Thu, 21 May 2020 22:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590101388;
        bh=CW4sde9y4e+sWQBZa9C8OuoB+kuyPQmkqE3P5NtaJIc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tOikhfwhHLzAqxOM2AAJdvpbq+JmDADmZvY2U0cDdTQgZr6hDoXl6DWagRWs+V9zj
         6wNTaKvyEezXFBYPs7QWu/aKsjjmEJuboptnvjtMATX4QcOsUZpZplO0jE4S/HogeE
         A/hyglrF/mdRue0jZyrwLG6ZHue8QXojSsuFYcJk=
Date:   Thu, 21 May 2020 17:49:46 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Prabhakar Kushwaha <prabhakar.pkin@gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        kexec mailing list <kexec@lists.infradead.org>,
        linux-pci@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Will Deacon <will@kernel.org>,
        Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Prabhakar Kushwaha <pkushwaha@marvell.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Vijay Mohan Pandarathil <vijaymohan.pandarathil@hp.com>,
        Myron Stowe <myron.stowe@redhat.com>
Subject: Re: [PATCH][v2] iommu: arm-smmu-v3: Copy SMMU table for kdump kernel
Message-ID: <20200521224946.GA1194148@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ2QiJLqaJ+uftEkRZ_n1FGUMigpk6_0wkvUfUDgcyfYNOpx8w@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 21, 2020 at 09:28:20AM +0530, Prabhakar Kushwaha wrote:
> On Wed, May 20, 2020 at 4:52 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Thu, May 14, 2020 at 12:47:02PM +0530, Prabhakar Kushwaha wrote:
> > > On Wed, May 13, 2020 at 3:33 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Mon, May 11, 2020 at 07:46:06PM -0700, Prabhakar Kushwaha wrote:
> > > > > An SMMU Stream table is created by the primary kernel. This table is
> > > > > used by the SMMU to perform address translations for device-originated
> > > > > transactions. Any crash (if happened) launches the kdump kernel which
> > > > > re-creates the SMMU Stream table. New transactions will be translated
> > > > > via this new table..
> > > > >
> > > > > There are scenarios, where devices are still having old pending
> > > > > transactions (configured in the primary kernel). These transactions
> > > > > come in-between Stream table creation and device-driver probe.
> > > > > As new stream table does not have entry for older transactions,
> > > > > it will be aborted by SMMU.
> > > > >
> > > > > Similar observations were found with PCIe-Intel 82576 Gigabit
> > > > > Network card. It sends old Memory Read transaction in kdump kernel.
> > > > > Transactions configured for older Stream table entries, that do not
> > > > > exist any longer in the new table, will cause a PCIe Completion Abort.
> > > >
> > > > That sounds like exactly what we want, doesn't it?
> > > >
> > > > Or do you *want* DMA from the previous kernel to complete?  That will
> > > > read or scribble on something, but maybe that's not terrible as long
> > > > as it's not memory used by the kdump kernel.
> > >
> > > Yes, Abort should happen. But it should happen in context of driver.
> > > But current abort is happening because of SMMU and no driver/pcie
> > > setup present at this moment.
> >
> > I don't understand what you mean by "in context of driver."  The whole
> > problem is that we can't control *when* the abort happens, so it may
> > happen in *any* context.  It may happen when a NIC receives a packet
> > or at some other unpredictable time.
> >
> > > Solution of this issue should be at 2 place
> > > a) SMMU level: I still believe, this patch has potential to overcome
> > > issue till finally driver's probe takeover.
> > > b) Device level: Even if something goes wrong. Driver/device should
> > > able to recover.
> > >
> > > > > Returned PCIe completion abort further leads to AER Errors from APEI
> > > > > Generic Hardware Error Source (GHES) with completion timeout.
> > > > > A network device hang is observed even after continuous
> > > > > reset/recovery from driver, Hence device is no more usable.
> > > >
> > > > The fact that the device is no longer usable is definitely a problem.
> > > > But in principle we *should* be able to recover from these errors.  If
> > > > we could recover and reliably use the device after the error, that
> > > > seems like it would be a more robust solution that having to add
> > > > special cases in every IOMMU driver.
> > > >
> > > > If you have details about this sort of error, I'd like to try to fix
> > > > it because we want to recover from that sort of error in normal
> > > > (non-crash) situations as well.
> > > >
> > > Completion abort case should be gracefully handled.  And device should
> > > always remain usable.
> > >
> > > There are 2 scenario which I am testing with Ethernet card PCIe-Intel
> > > 82576 Gigabit Network card.
> > >
> > > I)  Crash testing using kdump root file system: De-facto scenario
> > >     -  kdump file system does not have Ethernet driver
> > >     -  A lot of AER prints [1], making it impossible to work on shell
> > > of kdump root file system.
> >
> > In this case, I think report_error_detected() is deciding that because
> > the device has no driver, we can't do anything.  The flow is like
> > this:
> >
> >   aer_recover_work_func               # aer_recover_work
> >     kfifo_get(aer_recover_ring, entry)
> >     dev = pci_get_domain_bus_and_slot
> >     cper_print_aer(dev, ...)
> >       pci_err("AER: aer_status:")
> >       pci_err("AER:   [14] CmpltTO")
> >       pci_err("AER: aer_layer=")
> >     if (AER_NONFATAL)
> >       pcie_do_recovery(dev, pci_channel_io_normal)
> >         status = CAN_RECOVER
> >         pci_walk_bus(report_normal_detected)
> >           report_error_detected
> >             if (!dev->driver)
> >               vote = NO_AER_DRIVER
> >               pci_info("can't recover (no error_detected callback)")
> >             *result = merge_result(*, NO_AER_DRIVER)
> >             # always NO_AER_DRIVER
> >         status is now NO_AER_DRIVER
> >
> > So pcie_do_recovery() does not call .report_mmio_enabled() or .slot_reset(),
> > and status is not RECOVERED, so it skips .resume().
> >
> > I don't remember the history there, but if a device has no driver and
> > the device generates errors, it seems like we ought to be able to
> > reset it.
> 
> But how to reset the device considering there is no driver.
> Hypothetically, this case should be taken care by PCIe subsystem to
> perform reset at PCIe level.

I don't understand your question.  The PCI core (not the device
driver) already does the reset.  When pcie_do_recovery() calls
reset_link(), all devices on the other side of the link are reset.

> > We should be able to field one (or a few) AER errors, reset the
> > device, and you should be able to use the shell in the kdump kernel.
> >
> here kdump shell is usable only problem is a "lot of AER Errors". One
> cannot see what they are typing.

Right, that's what I expect.  If the PCI core resets the device, you
should get just a few AER errors, and they should stop after the
device is reset.

> > >     -  Note kdump shell allows to use makedumpfile, vmcore-dmesg applications.
> > >
> > > II) Crash testing using default root file system: Specific case to
> > > test Ethernet driver in second kernel
> > >    -  Default root file system have Ethernet driver
> > >    -  AER error comes even before the driver probe starts.
> > >    -  Driver does reset Ethernet card as part of probe but no success.
> > >    -  AER also tries to recover. but no success.  [2]
> > >    -  I also tries to remove AER errors by using "pci=noaer" bootargs
> > > and commenting ghes_handle_aer() from GHES driver..
> > >           than different set of errors come which also never able to recover [3]
> > >
> 
> Please suggest your view on this case. Here driver is preset.
> (driver/net/ethernet/intel/igb/igb_main.c)
> In this case AER errors starts even before driver probe starts.
> After probe, driver does the device reset with no success and even AER
> recovery does not work.

This case should be the same as the one above.  If we can change the
PCI core so it can reset the device when there's no driver, that would
apply to case I (where there will never be a driver) and to case II
(where there is no driver now, but a driver will probe the device
later).

> Problem mentioned in case I and II goes away if do pci_reset_function
> during enumeration phase of kdump kernel.
> can we thought of doing pci_reset_function for all devices in kdump
> kernel or device specific quirk.
> 
> --pk
> 
> 
> > > As per my understanding, possible solutions are
> > >  - Copy SMMU table i.e. this patch
> > > OR
> > >  - Doing pci_reset_function() during enumeration phase.
> > > I also tried clearing "M" bit using pci_clear_master during
> > > enumeration but it did not help. Because driver re-set M bit causing
> > > same AER error again.
> > >
> > >
> > > -pk
> > >
> > > ---------------------------------------------------------------------------------------------------------------------------
> > > [1] with bootargs having pci=noaer
> > >
> > > [   22.494648] {4}[Hardware Error]: Hardware error from APEI Generic
> > > Hardware Error Source: 1
> > > [   22.512773] {4}[Hardware Error]: event severity: recoverable
> > > [   22.518419] {4}[Hardware Error]:  Error 0, type: recoverable
> > > [   22.544804] {4}[Hardware Error]:   section_type: PCIe error
> > > [   22.550363] {4}[Hardware Error]:   port_type: 0, PCIe end point
> > > [   22.556268] {4}[Hardware Error]:   version: 3.0
> > > [   22.560785] {4}[Hardware Error]:   command: 0x0507, status: 0x4010
> > > [   22.576852] {4}[Hardware Error]:   device_id: 0000:09:00.1
> > > [   22.582323] {4}[Hardware Error]:   slot: 0
> > > [   22.586406] {4}[Hardware Error]:   secondary_bus: 0x00
> > > [   22.591530] {4}[Hardware Error]:   vendor_id: 0x8086, device_id: 0x10c9
> > > [   22.608900] {4}[Hardware Error]:   class_code: 000002
> > > [   22.613938] {4}[Hardware Error]:   serial number: 0xff1b4580, 0x90e2baff
> > > [   22.803534] pci 0000:09:00.1: AER: aer_status: 0x00004000,
> > > aer_mask: 0x00000000
> > > [   22.810838] pci 0000:09:00.1: AER:    [14] CmpltTO                (First)
> > > [   22.817613] pci 0000:09:00.1: AER: aer_layer=Transaction Layer,
> > > aer_agent=Requester ID
> > > [   22.847374] pci 0000:09:00.1: AER: aer_uncor_severity: 0x00062011
> > > [   22.866161] mpt3sas_cm0: 63 BIT PCI BUS DMA ADDRESSING SUPPORTED,
> > > total mem (8153768 kB)
> > > [   22.946178] pci 0000:09:00.0: AER: can't recover (no error_detected callback)
> > > [   22.995142] pci 0000:09:00.1: AER: can't recover (no error_detected callback)
> > > [   23.002300] pcieport 0000:00:09.0: AER: device recovery failed
> > > [   23.027607] pci 0000:09:00.1: AER: aer_status: 0x00004000,
> > > aer_mask: 0x00000000
> > > [   23.044109] pci 0000:09:00.1: AER:    [14] CmpltTO                (First)
> > > [   23.060713] pci 0000:09:00.1: AER: aer_layer=Transaction Layer,
> > > aer_agent=Requester ID
> > > [   23.068616] pci 0000:09:00.1: AER: aer_uncor_severity: 0x00062011
> > > [   23.122056] pci 0000:09:00.0: AER: can't recover (no error_detected callback)
> > >
> > >
> > > ----------------------------------------------------------------------------------------------------------------------------
> > > [2] Normal bootargs.
> > >
> > > [   54.252454] {6}[Hardware Error]: Hardware error from APEI Generic
> > > Hardware Error Source: 1
> > > [   54.265827] {6}[Hardware Error]: event severity: recoverable
> > > [   54.271473] {6}[Hardware Error]:  Error 0, type: recoverable
> > > [   54.281605] {6}[Hardware Error]:   section_type: PCIe error
> > > [   54.287163] {6}[Hardware Error]:   port_type: 0, PCIe end point
> > > [   54.296955] {6}[Hardware Error]:   version: 3.0
> > > [   54.301471] {6}[Hardware Error]:   command: 0x0507, status: 0x4010
> > > [   54.312520] {6}[Hardware Error]:   device_id: 0000:09:00.1
> > > [   54.317991] {6}[Hardware Error]:   slot: 0
> > > [   54.322074] {6}[Hardware Error]:   secondary_bus: 0x00
> > > [   54.327197] {6}[Hardware Error]:   vendor_id: 0x8086, device_id: 0x10c9
> > > [   54.333797] {6}[Hardware Error]:   class_code: 000002
> > > [   54.351312] {6}[Hardware Error]:   serial number: 0xff1b4580, 0x90e2baff
> > > [   54.358001] AER: AER recover: Buffer overflow when recovering AER
> > > for 0000:09:00:1
> > > [   54.376852] pcieport 0000:00:09.0: AER: device recovery successful
> > > [   54.383034] igb 0000:09:00.1: AER: aer_status: 0x00004000,
> > > aer_mask: 0x00000000
> > > [   54.390348] igb 0000:09:00.1: AER:    [14] CmpltTO                (First)
> > > [   54.397144] igb 0000:09:00.1: AER: aer_layer=Transaction Layer,
> > > aer_agent=Requester ID
> > > [   54.409555] igb 0000:09:00.1: AER: aer_uncor_severity: 0x00062011
> > > [   54.551370] AER: AER recover: Buffer overflow when recovering AER
> > > for 0000:09:00:1
> > > [   54.705214] AER: AER recover: Buffer overflow when recovering AER
> > > for 0000:09:00:1
> > > [   54.758703] AER: AER recover: Buffer overflow when recovering AER
> > > for 0000:09:00:1
> > > [   54.865445] AER: AER recover: Buffer overflow when recovering AER
> > > for 0000:09:00:1
> > > [   54.888751] pcieport 0000:00:09.0: AER: device recovery successful
> > > [   54.894933] igb 0000:09:00.1: AER: aer_status: 0x00004000,
> > > aer_mask: 0x00000000
> > > [   54.902228] igb 0000:09:00.1: AER:    [14] CmpltTO                (First)
> > > [   54.916059] igb 0000:09:00.1: AER: aer_layer=Transaction Layer,
> > > aer_agent=Requester ID
> > > [   54.923972] igb 0000:09:00.1: AER: aer_uncor_severity: 0x00062011
> > > [   55.057272] AER: AER recover: Buffer overflow when recovering AER
> > > for 0000:09:00:1
> > > [  274.571401] AER: AER recover: Buffer overflow when recovering AER
> > > for 0000:09:00:1
> > > [  274.686138] AER: AER recover: Buffer overflow when recovering AER
> > > for 0000:09:00:1
> > > [  274.786134] AER: AER recover: Buffer overflow when recovering AER
> > > for 0000:09:00:1
> > > [  274.886141] AER: AER recover: Buffer overflow when recovering AER
> > > for 0000:09:00:1
> > > [  397.792897] Workqueue: events aer_recover_work_func
> > > [  397.797760] Call trace:
> > > [  397.800199]  __switch_to+0xcc/0x108
> > > [  397.803675]  __schedule+0x2c0/0x700
> > > [  397.807150]  schedule+0x58/0xe8
> > > [  397.810283]  schedule_preempt_disabled+0x18/0x28
> > > [  397.810788] AER: AER recover: Buffer overflow when recovering AER
> > > for 0000:09:00:1
> > > [  397.814887]  __mutex_lock.isra.9+0x288/0x5c8
> > > [  397.814890]  __mutex_lock_slowpath+0x1c/0x28
> > > [  397.830962]  mutex_lock+0x4c/0x68
> > > [  397.834264]  report_slot_reset+0x30/0xa0
> > > [  397.838178]  pci_walk_bus+0x68/0xc0
> > > [  397.841653]  pcie_do_recovery+0xe8/0x248
> > > [  397.845562]  aer_recover_work_func+0x100/0x138
> > > [  397.849995]  process_one_work+0x1bc/0x458
> > > [  397.853991]  worker_thread+0x150/0x500
> > > [  397.857727]  kthread+0x114/0x118
> > > [  397.860945]  ret_from_fork+0x10/0x18
> > > [  397.864525] INFO: task kworker/223:2:2939 blocked for more than 122 seconds.
> > > [  397.871564]       Not tainted 5.7.0-rc3+ #68
> > > [  397.875819] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > > disables this message.
> > > [  397.883638] kworker/223:2   D    0  2939      2 0x00000228
> > > [  397.889121] Workqueue: ipv6_addrconf addrconf_verify_work
> > > [  397.894505] Call trace:
> > > [  397.896940]  __switch_to+0xcc/0x108
> > > [  397.900419]  __schedule+0x2c0/0x700
> > > [  397.903894]  schedule+0x58/0xe8
> > > [  397.907023]  schedule_preempt_disabled+0x18/0x28
> > > [  397.910798] AER: AER recover: Buffer overflow when recovering AER
> > > for 0000:09:00:1
> > > [  397.911630]  __mutex_lock.isra.9+0x288/0x5c8
> > > [  397.923440]  __mutex_lock_slowpath+0x1c/0x28
> > > [  397.927696]  mutex_lock+0x4c/0x68
> > > [  397.931005]  rtnl_lock+0x24/0x30
> > > [  397.934220]  addrconf_verify_work+0x18/0x30
> > > [  397.938394]  process_one_work+0x1bc/0x458
> > > [  397.942390]  worker_thread+0x150/0x500
> > > [  397.946126]  kthread+0x114/0x118
> > > [  397.949345]  ret_from_fork+0x10/0x18
> > >
> > > ---------------------------------------------------------------------------------------------------------------------------------
> > > [3] with bootargs as pci=noaer and comment ghes_halder_aer() from AER driver
> > >
> > > [   69.037035] igb 0000:09:00.1 enp9s0f1: Reset adapter
> > > [   69.348446] {9}[Hardware Error]: Hardware error from APEI Generic
> > > Hardware Error Source: 0
> > > [   69.356698] {9}[Hardware Error]: It has been corrected by h/w and
> > > requires no further action
> > > [   69.365121] {9}[Hardware Error]: event severity: corrected
> > > [   69.370593] {9}[Hardware Error]:  Error 0, type: corrected
> > > [   69.376064] {9}[Hardware Error]:   section_type: PCIe error
> > > [   69.381623] {9}[Hardware Error]:   port_type: 4, root port
> > > [   69.387094] {9}[Hardware Error]:   version: 3.0
> > > [   69.391611] {9}[Hardware Error]:   command: 0x0106, status: 0x4010
> > > [   69.397777] {9}[Hardware Error]:   device_id: 0000:00:09.0
> > > [   69.403248] {9}[Hardware Error]:   slot: 0
> > > [   69.407331] {9}[Hardware Error]:   secondary_bus: 0x09
> > > [   69.412455] {9}[Hardware Error]:   vendor_id: 0x177d, device_id: 0xaf84
> > > [   69.419055] {9}[Hardware Error]:   class_code: 000406
> > > [   69.424093] {9}[Hardware Error]:   bridge: secondary_status:
> > > 0x6000, control: 0x0002
> > > [   72.118132] igb 0000:09:00.1 enp9s0f1: igb: enp9s0f1 NIC Link is Up
> > > 1000 Mbps Full Duplex, Flow Control: RX
> > > [   73.995068] igb 0000:09:00.1: Detected Tx Unit Hang
> > > [   73.995068]   Tx Queue             <2>
> > > [   73.995068]   TDH                  <0>
> > > [   73.995068]   TDT                  <1>
> > > [   73.995068]   next_to_use          <1>
> > > [   73.995068]   next_to_clean        <0>
> > > [   73.995068] buffer_info[next_to_clean]
> > > [   73.995068]   time_stamp           <ffff9c1a>
> > > [   73.995068]   next_to_watch        <0000000097d42934>
> > > [   73.995068]   jiffies              <ffff9cd0>
> > > [   73.995068]   desc.status          <168000>
> > > [   75.987323] igb 0000:09:00.1: Detected Tx Unit Hang
> > > [   75.987323]   Tx Queue             <2>
> > > [   75.987323]   TDH                  <0>
> > > [   75.987323]   TDT                  <1>
> > > [   75.987323]   next_to_use          <1>
> > > [   75.987323]   next_to_clean        <0>
> > > [   75.987323] buffer_info[next_to_clean]
> > > [   75.987323]   time_stamp           <ffff9c1a>
> > > [   75.987323]   next_to_watch        <0000000097d42934>
> > > [   75.987323]   jiffies              <ffff9d98>
> > > [   75.987323]   desc.status          <168000>
> > > [   77.952661] {10}[Hardware Error]: Hardware error from APEI Generic
> > > Hardware Error Source: 1
> > > [   77.971790] {10}[Hardware Error]: event severity: recoverable
> > > [   77.977522] {10}[Hardware Error]:  Error 0, type: recoverable
> > > [   77.983254] {10}[Hardware Error]:   section_type: PCIe error
> > > [   77.999930] {10}[Hardware Error]:   port_type: 0, PCIe end point
> > > [   78.005922] {10}[Hardware Error]:   version: 3.0
> > > [   78.010526] {10}[Hardware Error]:   command: 0x0507, status: 0x4010
> > > [   78.016779] {10}[Hardware Error]:   device_id: 0000:09:00.1
> > > [   78.033107] {10}[Hardware Error]:   slot: 0
> > > [   78.037276] {10}[Hardware Error]:   secondary_bus: 0x00
> > > [   78.066253] {10}[Hardware Error]:   vendor_id: 0x8086, device_id: 0x10c9
> > > [   78.072940] {10}[Hardware Error]:   class_code: 000002
> > > [   78.078064] {10}[Hardware Error]:   serial number: 0xff1b4580, 0x90e2baff
> > > [   78.096202] igb 0000:09:00.1: Detected Tx Unit Hang
> > > [   78.096202]   Tx Queue             <2>
> > > [   78.096202]   TDH                  <0>
> > > [   78.096202]   TDT                  <1>
> > > [   78.096202]   next_to_use          <1>
> > > [   78.096202]   next_to_clean        <0>
> > > [   78.096202] buffer_info[next_to_clean]
> > > [   78.096202]   time_stamp           <ffff9c1a>
> > > [   78.096202]   next_to_watch        <0000000097d42934>
> > > [   78.096202]   jiffies              <ffff9e6a>
> > > [   78.096202]   desc.status          <168000>
> > > [   79.587406] {11}[Hardware Error]: Hardware error from APEI Generic
> > > Hardware Error Source: 0
> > > [   79.595744] {11}[Hardware Error]: It has been corrected by h/w and
> > > requires no further action
> > > [   79.604254] {11}[Hardware Error]: event severity: corrected
> > > [   79.609813] {11}[Hardware Error]:  Error 0, type: corrected
> > > [   79.615371] {11}[Hardware Error]:   section_type: PCIe error
> > > [   79.621016] {11}[Hardware Error]:   port_type: 4, root port
> > > [   79.626574] {11}[Hardware Error]:   version: 3.0
> > > [   79.631177] {11}[Hardware Error]:   command: 0x0106, status: 0x4010
> > > [   79.637430] {11}[Hardware Error]:   device_id: 0000:00:09.0
> > > [   79.642988] {11}[Hardware Error]:   slot: 0
> > > [   79.647157] {11}[Hardware Error]:   secondary_bus: 0x09
> > > [   79.652368] {11}[Hardware Error]:   vendor_id: 0x177d, device_id: 0xaf84
> > > [   79.659055] {11}[Hardware Error]:   class_code: 000406
> > > [   79.664180] {11}[Hardware Error]:   bridge: secondary_status:
> > > 0x6000, control: 0x0002
> > > [   79.987052] igb 0000:09:00.1: Detected Tx Unit Hang
> > > [   79.987052]   Tx Queue             <2>
> > > [   79.987052]   TDH                  <0>
> > > [   79.987052]   TDT                  <1>
> > > [   79.987052]   next_to_use          <1>
> > > [   79.987052]   next_to_clean        <0>
> > > [   79.987052] buffer_info[next_to_clean]
> > > [   79.987052]   time_stamp           <ffff9c1a>
> > > [   79.987052]   next_to_watch        <0000000097d42934>
> > > [   79.987052]   jiffies              <ffff9f28>
> > > [   79.987052]   desc.status          <168000>
> > > [   79.987056] igb 0000:09:00.1: Detected Tx Unit Hang
> > > [   79.987056]   Tx Queue             <3>
> > > [   79.987056]   TDH                  <0>
> > > [   79.987056]   TDT                  <1>
> > > [   79.987056]   next_to_use          <1>
> > > [   79.987056]   next_to_clean        <0>
> > > [   79.987056] buffer_info[next_to_clean]
> > > [   79.987056]   time_stamp           <ffff9e43>
> > > [   79.987056]   next_to_watch        <000000008da33deb>
> > > [   79.987056]   jiffies              <ffff9f28>
> > > [   79.987056]   desc.status          <514000>
> > > [   81.986688] igb 0000:09:00.1 enp9s0f1: Reset adapter
> > > [   81.986842] igb 0000:09:00.1: Detected Tx Unit Hang
> > > [   81.986842]   Tx Queue             <2>
> > > [   81.986842]   TDH                  <0>
> > > [   81.986842]   TDT                  <1>
> > > [   81.986842]   next_to_use          <1>
> > > [   81.986842]   next_to_clean        <0>
> > > [   81.986842] buffer_info[next_to_clean]
> > > [   81.986842]   time_stamp           <ffff9c1a>
> > > [   81.986842]   next_to_watch        <0000000097d42934>
> > > [   81.986842]   jiffies              <ffff9ff0>
> > > [   81.986842]   desc.status          <168000>
> > > [   81.986844] igb 0000:09:00.1: Detected Tx Unit Hang
> > > [   81.986844]   Tx Queue             <3>
> > > [   81.986844]   TDH                  <0>
> > > [   81.986844]   TDT                  <1>
> > > [   81.986844]   next_to_use          <1>
> > > [   81.986844]   next_to_clean        <0>
> > > [   81.986844] buffer_info[next_to_clean]
> > > [   81.986844]   time_stamp           <ffff9e43>
> > > [   81.986844]   next_to_watch        <000000008da33deb>
> > > [   81.986844]   jiffies              <ffff9ff0>
> > > [   81.986844]   desc.status          <514000>
> > > [   85.346515] {12}[Hardware Error]: Hardware error from APEI Generic
> > > Hardware Error Source: 0
> > > [   85.354854] {12}[Hardware Error]: It has been corrected by h/w and
> > > requires no further action
> > > [   85.363365] {12}[Hardware Error]: event severity: corrected
> > > [   85.368924] {12}[Hardware Error]:  Error 0, type: corrected
> > > [   85.374483] {12}[Hardware Error]:   section_type: PCIe error
> > > [   85.380129] {12}[Hardware Error]:   port_type: 0, PCIe end point
> > > [   85.386121] {12}[Hardware Error]:   version: 3.0
> > > [   85.390725] {12}[Hardware Error]:   command: 0x0507, status: 0x0010
> > > [   85.396980] {12}[Hardware Error]:   device_id: 0000:09:00.0
> > > [   85.402540] {12}[Hardware Error]:   slot: 0
> > > [   85.406710] {12}[Hardware Error]:   secondary_bus: 0x00
> > > [   85.411921] {12}[Hardware Error]:   vendor_id: 0x8086, device_id: 0x10c9
> > > [   85.418609] {12}[Hardware Error]:   class_code: 000002
> > > [   85.423733] {12}[Hardware Error]:   serial number: 0xff1b4580, 0x90e2baff
> > > [   85.826695] igb 0000:09:00.1 enp9s0f1: igb: enp9s0f1 NIC Link is Up
> > > 1000 Mbps Full Duplex, Flow Control: RX
> > >
> > >
> > >
> > >
> > >
> > > > > So, If we are in a kdump kernel try to copy SMMU Stream table from
> > > > > primary/old kernel to preserve the mappings until the device driver
> > > > > takes over.
> > > > >
> > > > > Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
> > > > > ---
> > > > > Changes for v2: Used memremap in-place of ioremap
> > > > >
> > > > > V2 patch has been sanity tested.
> > > > >
> > > > > V1 patch has been tested with
> > > > > A) PCIe-Intel 82576 Gigabit Network card in following
> > > > > configurations with "no AER error". Each iteration has
> > > > > been tested on both Suse kdump rfs And default Centos distro rfs.
> > > > >
> > > > >  1)  with 2 level stream table
> > > > >        ----------------------------------------------------
> > > > >        SMMU               |  Normal Ping   | Flood Ping
> > > > >        -----------------------------------------------------
> > > > >        Default Operation  |  100 times     | 10 times
> > > > >        -----------------------------------------------------
> > > > >        IOMMU bypass       |  41 times      | 10 times
> > > > >        -----------------------------------------------------
> > > > >
> > > > >  2)  with Linear stream table.
> > > > >        -----------------------------------------------------
> > > > >        SMMU               |  Normal Ping   | Flood Ping
> > > > >        ------------------------------------------------------
> > > > >        Default Operation  |  100 times     | 10 times
> > > > >        ------------------------------------------------------
> > > > >        IOMMU bypass       |  55 times      | 10 times
> > > > >        -------------------------------------------------------
> > > > >
> > > > > B) This patch is also tested with Micron Technology Inc 9200 PRO NVMe
> > > > > SSD card with 2 level stream table using "fio" in mixed read/write and
> > > > > only read configurations. It is tested for both Default Operation and
> > > > > IOMMU bypass mode for minimum 10 iterations across Centos kdump rfs and
> > > > > default Centos ditstro rfs.
> > > > >
> > > > > This patch is not full proof solution. Issue can still come
> > > > > from the point device is discovered and driver probe called.
> > > > > This patch has reduced window of scenario from "SMMU Stream table
> > > > > creation - device-driver" to "device discovery - device-driver".
> > > > > Usually, device discovery to device-driver is very small time. So
> > > > > the probability is very low.
> > > > >
> > > > > Note: device-discovery will overwrite existing stream table entries
> > > > > with both SMMU stage as by-pass.
> > > > >
> > > > >
> > > > >  drivers/iommu/arm-smmu-v3.c | 36 +++++++++++++++++++++++++++++++++++-
> > > > >  1 file changed, 35 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> > > > > index 82508730feb7..d492d92c2dd7 100644
> > > > > --- a/drivers/iommu/arm-smmu-v3.c
> > > > > +++ b/drivers/iommu/arm-smmu-v3.c
> > > > > @@ -1847,7 +1847,13 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
> > > > >                       break;
> > > > >               case STRTAB_STE_0_CFG_S1_TRANS:
> > > > >               case STRTAB_STE_0_CFG_S2_TRANS:
> > > > > -                     ste_live = true;
> > > > > +                     /*
> > > > > +                      * As kdump kernel copy STE table from previous
> > > > > +                      * kernel. It still may have valid stream table entries.
> > > > > +                      * Forcing entry as false to allow overwrite.
> > > > > +                      */
> > > > > +                     if (!is_kdump_kernel())
> > > > > +                             ste_live = true;
> > > > >                       break;
> > > > >               case STRTAB_STE_0_CFG_ABORT:
> > > > >                       BUG_ON(!disable_bypass);
> > > > > @@ -3264,6 +3270,9 @@ static int arm_smmu_init_l1_strtab(struct arm_smmu_device *smmu)
> > > > >               return -ENOMEM;
> > > > >       }
> > > > >
> > > > > +     if (is_kdump_kernel())
> > > > > +             return 0;
> > > > > +
> > > > >       for (i = 0; i < cfg->num_l1_ents; ++i) {
> > > > >               arm_smmu_write_strtab_l1_desc(strtab, &cfg->l1_desc[i]);
> > > > >               strtab += STRTAB_L1_DESC_DWORDS << 3;
> > > > > @@ -3272,6 +3281,23 @@ static int arm_smmu_init_l1_strtab(struct arm_smmu_device *smmu)
> > > > >       return 0;
> > > > >  }
> > > > >
> > > > > +static void arm_smmu_copy_table(struct arm_smmu_device *smmu,
> > > > > +                            struct arm_smmu_strtab_cfg *cfg, u32 size)
> > > > > +{
> > > > > +     struct arm_smmu_strtab_cfg rdcfg;
> > > > > +
> > > > > +     rdcfg.strtab_dma = readq_relaxed(smmu->base + ARM_SMMU_STRTAB_BASE);
> > > > > +     rdcfg.strtab_base_cfg = readq_relaxed(smmu->base
> > > > > +                                           + ARM_SMMU_STRTAB_BASE_CFG);
> > > > > +
> > > > > +     rdcfg.strtab_dma &= STRTAB_BASE_ADDR_MASK;
> > > > > +     rdcfg.strtab = memremap(rdcfg.strtab_dma, size, MEMREMAP_WB);
> > > > > +
> > > > > +     memcpy_fromio(cfg->strtab, rdcfg.strtab, size);
> > > > > +
> > > > > +     cfg->strtab_base_cfg = rdcfg.strtab_base_cfg;
> > > > > +}
> > > > > +
> > > > >  static int arm_smmu_init_strtab_2lvl(struct arm_smmu_device *smmu)
> > > > >  {
> > > > >       void *strtab;
> > > > > @@ -3307,6 +3333,9 @@ static int arm_smmu_init_strtab_2lvl(struct arm_smmu_device *smmu)
> > > > >       reg |= FIELD_PREP(STRTAB_BASE_CFG_SPLIT, STRTAB_SPLIT);
> > > > >       cfg->strtab_base_cfg = reg;
> > > > >
> > > > > +     if (is_kdump_kernel())
> > > > > +             arm_smmu_copy_table(smmu, cfg, l1size);
> > > > > +
> > > > >       return arm_smmu_init_l1_strtab(smmu);
> > > > >  }
> > > > >
> > > > > @@ -3334,6 +3363,11 @@ static int arm_smmu_init_strtab_linear(struct arm_smmu_device *smmu)
> > > > >       reg |= FIELD_PREP(STRTAB_BASE_CFG_LOG2SIZE, smmu->sid_bits);
> > > > >       cfg->strtab_base_cfg = reg;
> > > > >
> > > > > +     if (is_kdump_kernel()) {
> > > > > +             arm_smmu_copy_table(smmu, cfg, size);
> > > > > +             return 0;
> > > > > +     }
> > > > > +
> > > > >       arm_smmu_init_bypass_stes(strtab, cfg->num_l1_ents);
> > > > >       return 0;
> > > > >  }
> > > > > --
> > > > > 2.18.2
> > > > >

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2CB1ED9CC
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jun 2020 02:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbgFDACg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jun 2020 20:02:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:59928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbgFDACg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Jun 2020 20:02:36 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D72820738;
        Thu,  4 Jun 2020 00:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591228954;
        bh=/3H6umELn//UfWpUAQsiZ4/+8lq8t30K7gi9GfxxpIE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=DgSwDscNLVlL95jD6Zn4mCuyZ6nLq/uJ7GBbD2qdgojmmJqjPICtfrt2e7Wq1p7gk
         DPGfYWpDbqKUpvqcOUQL6rdsF/IWpUBJm2U6IsjO2RgKsgICd4UjulvBRpd0PPjdAJ
         Av+BugLocMDQ9n/85QFQ12cx3wIdMY90+O6ROm0Q=
Date:   Wed, 3 Jun 2020 19:02:32 -0500
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
Message-ID: <20200604000232.GA956503@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ2QiJ+fhPWAxZXzHhNFLkHr47e+wTqqz+s5r+utgCP=C6qsjw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 03, 2020 at 11:12:48PM +0530, Prabhakar Kushwaha wrote:
> On Sat, May 30, 2020 at 1:03 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, May 29, 2020 at 07:48:10PM +0530, Prabhakar Kushwaha wrote:
> > > On Thu, May 28, 2020 at 1:48 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > >
> > > > On Wed, May 27, 2020 at 05:14:39PM +0530, Prabhakar Kushwaha wrote:
> > > > > On Fri, May 22, 2020 at 4:19 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > On Thu, May 21, 2020 at 09:28:20AM +0530, Prabhakar Kushwaha wrote:
> > > > > > > On Wed, May 20, 2020 at 4:52 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > > > On Thu, May 14, 2020 at 12:47:02PM +0530, Prabhakar Kushwaha wrote:
> > > > > > > > > On Wed, May 13, 2020 at 3:33 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > > > > > On Mon, May 11, 2020 at 07:46:06PM -0700, Prabhakar Kushwaha wrote:
> > > > > > > > > > > An SMMU Stream table is created by the primary kernel. This table is
> > > > > > > > > > > used by the SMMU to perform address translations for device-originated
> > > > > > > > > > > transactions. Any crash (if happened) launches the kdump kernel which
> > > > > > > > > > > re-creates the SMMU Stream table. New transactions will be translated
> > > > > > > > > > > via this new table..
> > > > > > > > > > >
> > > > > > > > > > > There are scenarios, where devices are still having old pending
> > > > > > > > > > > transactions (configured in the primary kernel). These transactions
> > > > > > > > > > > come in-between Stream table creation and device-driver probe.
> > > > > > > > > > > As new stream table does not have entry for older transactions,
> > > > > > > > > > > it will be aborted by SMMU.
> > > > > > > > > > >
> > > > > > > > > > > Similar observations were found with PCIe-Intel 82576 Gigabit
> > > > > > > > > > > Network card. It sends old Memory Read transaction in kdump kernel.
> > > > > > > > > > > Transactions configured for older Stream table entries, that do not
> > > > > > > > > > > exist any longer in the new table, will cause a PCIe Completion Abort.
> > > > > > > > > >
> > > > > > > > > > That sounds like exactly what we want, doesn't it?
> > > > > > > > > >
> > > > > > > > > > Or do you *want* DMA from the previous kernel to complete?  That will
> > > > > > > > > > read or scribble on something, but maybe that's not terrible as long
> > > > > > > > > > as it's not memory used by the kdump kernel.
> > > > > > > > >
> > > > > > > > > Yes, Abort should happen. But it should happen in context of driver.
> > > > > > > > > But current abort is happening because of SMMU and no driver/pcie
> > > > > > > > > setup present at this moment.
> > > > > > > >
> > > > > > > > I don't understand what you mean by "in context of driver."  The whole
> > > > > > > > problem is that we can't control *when* the abort happens, so it may
> > > > > > > > happen in *any* context.  It may happen when a NIC receives a packet
> > > > > > > > or at some other unpredictable time.
> > > > > > > >
> > > > > > > > > Solution of this issue should be at 2 place
> > > > > > > > > a) SMMU level: I still believe, this patch has potential to overcome
> > > > > > > > > issue till finally driver's probe takeover.
> > > > > > > > > b) Device level: Even if something goes wrong. Driver/device should
> > > > > > > > > able to recover.
> > > > > > > > >
> > > > > > > > > > > Returned PCIe completion abort further leads to AER Errors from APEI
> > > > > > > > > > > Generic Hardware Error Source (GHES) with completion timeout.
> > > > > > > > > > > A network device hang is observed even after continuous
> > > > > > > > > > > reset/recovery from driver, Hence device is no more usable.
> > > > > > > > > >
> > > > > > > > > > The fact that the device is no longer usable is definitely a problem.
> > > > > > > > > > But in principle we *should* be able to recover from these errors.  If
> > > > > > > > > > we could recover and reliably use the device after the error, that
> > > > > > > > > > seems like it would be a more robust solution that having to add
> > > > > > > > > > special cases in every IOMMU driver.
> > > > > > > > > >
> > > > > > > > > > If you have details about this sort of error, I'd like to try to fix
> > > > > > > > > > it because we want to recover from that sort of error in normal
> > > > > > > > > > (non-crash) situations as well.
> > > > > > > > > >
> > > > > > > > > Completion abort case should be gracefully handled.  And device should
> > > > > > > > > always remain usable.
> > > > > > > > >
> > > > > > > > > There are 2 scenario which I am testing with Ethernet card PCIe-Intel
> > > > > > > > > 82576 Gigabit Network card.
> > > > > > > > >
> > > > > > > > > I)  Crash testing using kdump root file system: De-facto scenario
> > > > > > > > >     -  kdump file system does not have Ethernet driver
> > > > > > > > >     -  A lot of AER prints [1], making it impossible to work on shell
> > > > > > > > > of kdump root file system.
> > > > > > > >
> > > > > > > > In this case, I think report_error_detected() is deciding that because
> > > > > > > > the device has no driver, we can't do anything.  The flow is like
> > > > > > > > this:
> > > > > > > >
> > > > > > > >   aer_recover_work_func               # aer_recover_work
> > > > > > > >     kfifo_get(aer_recover_ring, entry)
> > > > > > > >     dev = pci_get_domain_bus_and_slot
> > > > > > > >     cper_print_aer(dev, ...)
> > > > > > > >       pci_err("AER: aer_status:")
> > > > > > > >       pci_err("AER:   [14] CmpltTO")
> > > > > > > >       pci_err("AER: aer_layer=")
> > > > > > > >     if (AER_NONFATAL)
> > > > > > > >       pcie_do_recovery(dev, pci_channel_io_normal)
> > > > > > > >         status = CAN_RECOVER
> > > > > > > >         pci_walk_bus(report_normal_detected)
> > > > > > > >           report_error_detected
> > > > > > > >             if (!dev->driver)
> > > > > > > >               vote = NO_AER_DRIVER
> > > > > > > >               pci_info("can't recover (no error_detected callback)")
> > > > > > > >             *result = merge_result(*, NO_AER_DRIVER)
> > > > > > > >             # always NO_AER_DRIVER
> > > > > > > >         status is now NO_AER_DRIVER
> > > > > > > >
> > > > > > > > So pcie_do_recovery() does not call .report_mmio_enabled() or .slot_reset(),
> > > > > > > > and status is not RECOVERED, so it skips .resume().
> > > > > > > >
> > > > > > > > I don't remember the history there, but if a device has no driver and
> > > > > > > > the device generates errors, it seems like we ought to be able to
> > > > > > > > reset it.
> > > > > > >
> > > > > > > But how to reset the device considering there is no driver.
> > > > > > > Hypothetically, this case should be taken care by PCIe subsystem to
> > > > > > > perform reset at PCIe level.
> > > > > >
> > > > > > I don't understand your question.  The PCI core (not the device
> > > > > > driver) already does the reset.  When pcie_do_recovery() calls
> > > > > > reset_link(), all devices on the other side of the link are reset.
> > > > > >
> > > > > > > > We should be able to field one (or a few) AER errors, reset the
> > > > > > > > device, and you should be able to use the shell in the kdump kernel.
> > > > > > > >
> > > > > > > here kdump shell is usable only problem is a "lot of AER Errors". One
> > > > > > > cannot see what they are typing.
> > > > > >
> > > > > > Right, that's what I expect.  If the PCI core resets the device, you
> > > > > > should get just a few AER errors, and they should stop after the
> > > > > > device is reset.
> > > > > >
> > > > > > > > >     -  Note kdump shell allows to use makedumpfile, vmcore-dmesg applications.
> > > > > > > > >
> > > > > > > > > II) Crash testing using default root file system: Specific case to
> > > > > > > > > test Ethernet driver in second kernel
> > > > > > > > >    -  Default root file system have Ethernet driver
> > > > > > > > >    -  AER error comes even before the driver probe starts.
> > > > > > > > >    -  Driver does reset Ethernet card as part of probe but no success.
> > > > > > > > >    -  AER also tries to recover. but no success.  [2]
> > > > > > > > >    -  I also tries to remove AER errors by using "pci=noaer" bootargs
> > > > > > > > > and commenting ghes_handle_aer() from GHES driver..
> > > > > > > > >           than different set of errors come which also never able to recover [3]
> > > > > > > > >
> > > > > > >
> > > > > > > Please suggest your view on this case. Here driver is preset.
> > > > > > > (driver/net/ethernet/intel/igb/igb_main.c)
> > > > > > > In this case AER errors starts even before driver probe starts.
> > > > > > > After probe, driver does the device reset with no success and even AER
> > > > > > > recovery does not work.
> > > > > >
> > > > > > This case should be the same as the one above.  If we can change the
> > > > > > PCI core so it can reset the device when there's no driver,  that would
> > > > > > apply to case I (where there will never be a driver) and to case II
> > > > > > (where there is no driver now, but a driver will probe the device
> > > > > > later).
> > > > >
> > > > > Does this means change are required in PCI core.
> > > >
> > > > Yes, I am suggesting that the PCI core does not do the right thing
> > > > here.
> > > >
> > > > > I tried following changes in pcie_do_recovery() but it did not help.
> > > > > Same error as before.
> > > > >
> > > > > -- a/drivers/pci/pcie/err.c
> > > > > +++ b/drivers/pci/pcie/err.c
> > > > >         pci_info(dev, "broadcast resume message\n");
> > > > >         pci_walk_bus(bus, report_resume, &status);
> > > > > @@ -203,7 +207,12 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
> > > > >         return status;
> > > > >
> > > > >  failed:
> > > > >         pci_uevent_ers(dev, PCI_ERS_RESULT_DISCONNECT);
> > > > > +       pci_reset_function(dev);
> > > > > +       pci_aer_clear_device_status(dev);
> > > > > +       pci_aer_clear_nonfatal_status(dev);
> > > >
> > > > Did you confirm that this resets the devices in question (0000:09:00.0
> > > > and 0000:09:00.1, I think), and what reset mechanism this uses (FLR,
> > > > PM, etc)?
> > >
> > > Earlier reset  was happening with P2P bridge(0000:00:09.0) this the
> > > reason no effect. After making following changes,  both devices are
> > > now getting reset.
> > > Both devices are using FLR.
> > >
> > > diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> > > index 117c0a2b2ba4..26b908f55aef 100644
> > > --- a/drivers/pci/pcie/err.c
> > > +++ b/drivers/pci/pcie/err.c
> > > @@ -66,6 +66,20 @@ static int report_error_detected(struct pci_dev *dev,
> > >                 if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE) {
> > >                         vote = PCI_ERS_RESULT_NO_AER_DRIVER;
> > >                         pci_info(dev, "can't recover (no
> > > error_detected callback)\n");
> > > +
> > > +                       pci_save_state(dev);
> > > +                       pci_cfg_access_lock(dev);
> > > +
> > > +                       /* Quiesce the device completely */
> > > +                       pci_write_config_word(dev, PCI_COMMAND,
> > > +                             PCI_COMMAND_INTX_DISABLE);
> > > +                       if (!__pci_reset_function_locked(dev)) {
> > > +                               vote = PCI_ERS_RESULT_RECOVERED;
> > > +                               pci_info(dev, "recovered via pci level
> > > reset\n");
> > > +                       }
> >
> > Why do we need to save the state and quiesce the device?  The reset
> > should disable interrupts anyway.  In this particular case where
> > there's no driver, I don't think we should have to restore the state.
> > We maybe should *remove* the device and re-enumerate it after the
> > reset, but the state from before the reset should be irrelevant.
> 
> I tried pci_reset_function_locked without save/restore then I got the
> synchronous abort during igb_probe (case 2 i.e. with driver). This is
> 100% reproducible.
> looks like pci_reset_function_locked is causing PCI configuration
> space random. Same is mentioned here
> https://www.kernel.org/doc/html/latest/driver-api/pci/pci.html

That documentation is poorly worded.  A reset doesn't make the
contents of config space "random," but of course it sets config space
registers to their initialization values, including things like the
device BARs.  After a reset, the device BARs are zero, so it won't
respond at the address we expect, and I'm sure that's what's causing
the external abort.

So I guess we *do* need to save the state before the reset and restore
it (either that or enumerate the device from scratch just like we
would if it had been hot-added).  I'm not really thrilled with trying
to save the state after the device has already reported an error.  I'd
rather do it earlier, maybe during enumeration, like in
pci_init_capabilities().  But I don't understand all the subtleties of
dev->state_saved, so that requires some legwork.

I don't think we should set INTX_DISABLE; the reset will make whatever
we do with it irrelevant anyway.

Remind me why the pci_cfg_access_lock()?

Bjorn

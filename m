Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3357C1F0A82
	for <lists+linux-pci@lfdr.de>; Sun,  7 Jun 2020 10:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgFGIbQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 7 Jun 2020 04:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbgFGIbP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 7 Jun 2020 04:31:15 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C63C08C5C2
        for <linux-pci@vger.kernel.org>; Sun,  7 Jun 2020 01:31:13 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id t18so14146556wru.6
        for <linux-pci@vger.kernel.org>; Sun, 07 Jun 2020 01:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NcQInjX379yPN2NNKpCGE7xltAZE5T6OcAn7HsTnWe8=;
        b=bwIKoagm/JX7q3N69a9o7zEhfsI31SPh9DvabpZp4izCvTgZ0AitxrBLAOR1sg24xr
         OMgvDK2NAUSZMiM156rCtDp5TNNLYYQV8vMOJUS9xkyJ4u0rxs2T0MTaHvTVk5vPCLLO
         T85p9Ctu/n7YfoDv+fjLa0zNsaj2yE+OXXetJKwUu/Qo9S4uasf3VLOxrJnfTW3b8E0e
         sPiGfSRbZrX9+vST8ufDR2z3bPMrCJfGcB5MO5/ldITkmsdOUUFu6fNFyKV+nwa8rxq1
         h9YvTDwtPtOMe+tR7ZVvr+QJ3EzoDtFSnPGvZSR1zXYrh71IVjuJi4+LjhT/0uWbqY/Y
         OE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NcQInjX379yPN2NNKpCGE7xltAZE5T6OcAn7HsTnWe8=;
        b=B3rEUoJeu7iX5rWEgGXSG9tDJIYnMnNktNBaE6C+GT3yb281DNl082RuREiZJAd8EL
         6HrP/xHwYjSL6QJZ/7hfphpefZVjYTGmWx6R84rIUMth5IrCjL7TatIc3xhqtt3NYyaV
         Cf/eH2/3QW/lH7VYTDx+Is4QnKdJU0gDRy7y9of+isoiuKZm1u/uwCyyGsjuZ/11xGoV
         meT66w7IcpIXWeWpXZqrtaqg1s7Di55Mq7S7yTNJo1VQwML9OSB4GyTjWuYYL2umF1DR
         diO69hcTCVFNMpk/O6X1ANC92fR4vcJAPf195KIjkY8HFuhVuOUPIho06Qb2xGl6Cq74
         NwJA==
X-Gm-Message-State: AOAM531Xrgd0qpPc8cnNsAadIuoE+77nUvYU6qHQRaa7f4c1SDLzmi9s
        PyLO3qaJSppBnSKe7MxAdhaLr+oWdZJiJJjb2aw=
X-Google-Smtp-Source: ABdhPJyfuiB0HdqteJjP3gu2AmtliLrb1Lgp3Hf2Nouq1WA2q4FKEVY0TVIX3u7QBYO020sZhoz4OZfLCJwe0Z9r5Yc=
X-Received: by 2002:a5d:44cf:: with SMTP id z15mr19011567wrr.164.1591518672147;
 Sun, 07 Jun 2020 01:31:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ2QiJ+fhPWAxZXzHhNFLkHr47e+wTqqz+s5r+utgCP=C6qsjw@mail.gmail.com>
 <20200604000232.GA956503@bjorn-Precision-5520>
In-Reply-To: <20200604000232.GA956503@bjorn-Precision-5520>
From:   Prabhakar Kushwaha <prabhakar.pkin@gmail.com>
Date:   Sun, 7 Jun 2020 14:00:35 +0530
Message-ID: <CAJ2QiJJ58nWe_vpjLWoFuM7s-7f7H-40q-4r-aGqorKPy9EPQw@mail.gmail.com>
Subject: Re: [PATCH][v2] iommu: arm-smmu-v3: Copy SMMU table for kdump kernel
To:     Bjorn Helgaas <helgaas@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Thu, Jun 4, 2020 at 5:32 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Jun 03, 2020 at 11:12:48PM +0530, Prabhakar Kushwaha wrote:
> > On Sat, May 30, 2020 at 1:03 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Fri, May 29, 2020 at 07:48:10PM +0530, Prabhakar Kushwaha wrote:
> > > > On Thu, May 28, 2020 at 1:48 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > >
> > > > > On Wed, May 27, 2020 at 05:14:39PM +0530, Prabhakar Kushwaha wrote:
> > > > > > On Fri, May 22, 2020 at 4:19 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > > On Thu, May 21, 2020 at 09:28:20AM +0530, Prabhakar Kushwaha wrote:
> > > > > > > > On Wed, May 20, 2020 at 4:52 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > > > > On Thu, May 14, 2020 at 12:47:02PM +0530, Prabhakar Kushwaha wrote:
> > > > > > > > > > On Wed, May 13, 2020 at 3:33 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > > > > > > On Mon, May 11, 2020 at 07:46:06PM -0700, Prabhakar Kushwaha wrote:
> > > > > > > > > > > > An SMMU Stream table is created by the primary kernel. This table is
> > > > > > > > > > > > used by the SMMU to perform address translations for device-originated
> > > > > > > > > > > > transactions. Any crash (if happened) launches the kdump kernel which
> > > > > > > > > > > > re-creates the SMMU Stream table. New transactions will be translated
> > > > > > > > > > > > via this new table..
> > > > > > > > > > > >
> > > > > > > > > > > > There are scenarios, where devices are still having old pending
> > > > > > > > > > > > transactions (configured in the primary kernel). These transactions
> > > > > > > > > > > > come in-between Stream table creation and device-driver probe.
> > > > > > > > > > > > As new stream table does not have entry for older transactions,
> > > > > > > > > > > > it will be aborted by SMMU.
> > > > > > > > > > > >
> > > > > > > > > > > > Similar observations were found with PCIe-Intel 82576 Gigabit
> > > > > > > > > > > > Network card. It sends old Memory Read transaction in kdump kernel.
> > > > > > > > > > > > Transactions configured for older Stream table entries, that do not
> > > > > > > > > > > > exist any longer in the new table, will cause a PCIe Completion Abort.
> > > > > > > > > > >
> > > > > > > > > > > That sounds like exactly what we want, doesn't it?
> > > > > > > > > > >
> > > > > > > > > > > Or do you *want* DMA from the previous kernel to complete?  That will
> > > > > > > > > > > read or scribble on something, but maybe that's not terrible as long
> > > > > > > > > > > as it's not memory used by the kdump kernel.
> > > > > > > > > >
> > > > > > > > > > Yes, Abort should happen. But it should happen in context of driver.
> > > > > > > > > > But current abort is happening because of SMMU and no driver/pcie
> > > > > > > > > > setup present at this moment.
> > > > > > > > >
> > > > > > > > > I don't understand what you mean by "in context of driver."  The whole
> > > > > > > > > problem is that we can't control *when* the abort happens, so it may
> > > > > > > > > happen in *any* context.  It may happen when a NIC receives a packet
> > > > > > > > > or at some other unpredictable time.
> > > > > > > > >
> > > > > > > > > > Solution of this issue should be at 2 place
> > > > > > > > > > a) SMMU level: I still believe, this patch has potential to overcome
> > > > > > > > > > issue till finally driver's probe takeover.
> > > > > > > > > > b) Device level: Even if something goes wrong. Driver/device should
> > > > > > > > > > able to recover.
> > > > > > > > > >
> > > > > > > > > > > > Returned PCIe completion abort further leads to AER Errors from APEI
> > > > > > > > > > > > Generic Hardware Error Source (GHES) with completion timeout.
> > > > > > > > > > > > A network device hang is observed even after continuous
> > > > > > > > > > > > reset/recovery from driver, Hence device is no more usable.
> > > > > > > > > > >
> > > > > > > > > > > The fact that the device is no longer usable is definitely a problem.
> > > > > > > > > > > But in principle we *should* be able to recover from these errors.  If
> > > > > > > > > > > we could recover and reliably use the device after the error, that
> > > > > > > > > > > seems like it would be a more robust solution that having to add
> > > > > > > > > > > special cases in every IOMMU driver.
> > > > > > > > > > >
> > > > > > > > > > > If you have details about this sort of error, I'd like to try to fix
> > > > > > > > > > > it because we want to recover from that sort of error in normal
> > > > > > > > > > > (non-crash) situations as well.
> > > > > > > > > > >
> > > > > > > > > > Completion abort case should be gracefully handled.  And device should
> > > > > > > > > > always remain usable.
> > > > > > > > > >
> > > > > > > > > > There are 2 scenario which I am testing with Ethernet card PCIe-Intel
> > > > > > > > > > 82576 Gigabit Network card.
> > > > > > > > > >
> > > > > > > > > > I)  Crash testing using kdump root file system: De-facto scenario
> > > > > > > > > >     -  kdump file system does not have Ethernet driver
> > > > > > > > > >     -  A lot of AER prints [1], making it impossible to work on shell
> > > > > > > > > > of kdump root file system.
> > > > > > > > >
> > > > > > > > > In this case, I think report_error_detected() is deciding that because
> > > > > > > > > the device has no driver, we can't do anything.  The flow is like
> > > > > > > > > this:
> > > > > > > > >
> > > > > > > > >   aer_recover_work_func               # aer_recover_work
> > > > > > > > >     kfifo_get(aer_recover_ring, entry)
> > > > > > > > >     dev = pci_get_domain_bus_and_slot
> > > > > > > > >     cper_print_aer(dev, ...)
> > > > > > > > >       pci_err("AER: aer_status:")
> > > > > > > > >       pci_err("AER:   [14] CmpltTO")
> > > > > > > > >       pci_err("AER: aer_layer=")
> > > > > > > > >     if (AER_NONFATAL)
> > > > > > > > >       pcie_do_recovery(dev, pci_channel_io_normal)
> > > > > > > > >         status = CAN_RECOVER
> > > > > > > > >         pci_walk_bus(report_normal_detected)
> > > > > > > > >           report_error_detected
> > > > > > > > >             if (!dev->driver)
> > > > > > > > >               vote = NO_AER_DRIVER
> > > > > > > > >               pci_info("can't recover (no error_detected callback)")
> > > > > > > > >             *result = merge_result(*, NO_AER_DRIVER)
> > > > > > > > >             # always NO_AER_DRIVER
> > > > > > > > >         status is now NO_AER_DRIVER
> > > > > > > > >
> > > > > > > > > So pcie_do_recovery() does not call .report_mmio_enabled() or .slot_reset(),
> > > > > > > > > and status is not RECOVERED, so it skips .resume().
> > > > > > > > >
> > > > > > > > > I don't remember the history there, but if a device has no driver and
> > > > > > > > > the device generates errors, it seems like we ought to be able to
> > > > > > > > > reset it.
> > > > > > > >
> > > > > > > > But how to reset the device considering there is no driver.
> > > > > > > > Hypothetically, this case should be taken care by PCIe subsystem to
> > > > > > > > perform reset at PCIe level.
> > > > > > >
> > > > > > > I don't understand your question.  The PCI core (not the device
> > > > > > > driver) already does the reset.  When pcie_do_recovery() calls
> > > > > > > reset_link(), all devices on the other side of the link are reset.
> > > > > > >
> > > > > > > > > We should be able to field one (or a few) AER errors, reset the
> > > > > > > > > device, and you should be able to use the shell in the kdump kernel.
> > > > > > > > >
> > > > > > > > here kdump shell is usable only problem is a "lot of AER Errors". One
> > > > > > > > cannot see what they are typing.
> > > > > > >
> > > > > > > Right, that's what I expect.  If the PCI core resets the device, you
> > > > > > > should get just a few AER errors, and they should stop after the
> > > > > > > device is reset.
> > > > > > >
> > > > > > > > > >     -  Note kdump shell allows to use makedumpfile, vmcore-dmesg applications.
> > > > > > > > > >
> > > > > > > > > > II) Crash testing using default root file system: Specific case to
> > > > > > > > > > test Ethernet driver in second kernel
> > > > > > > > > >    -  Default root file system have Ethernet driver
> > > > > > > > > >    -  AER error comes even before the driver probe starts.
> > > > > > > > > >    -  Driver does reset Ethernet card as part of probe but no success.
> > > > > > > > > >    -  AER also tries to recover. but no success.  [2]
> > > > > > > > > >    -  I also tries to remove AER errors by using "pci=noaer" bootargs
> > > > > > > > > > and commenting ghes_handle_aer() from GHES driver..
> > > > > > > > > >           than different set of errors come which also never able to recover [3]
> > > > > > > > > >
> > > > > > > >
> > > > > > > > Please suggest your view on this case. Here driver is preset.
> > > > > > > > (driver/net/ethernet/intel/igb/igb_main.c)
> > > > > > > > In this case AER errors starts even before driver probe starts.
> > > > > > > > After probe, driver does the device reset with no success and even AER
> > > > > > > > recovery does not work.
> > > > > > >
> > > > > > > This case should be the same as the one above.  If we can change the
> > > > > > > PCI core so it can reset the device when there's no driver,  that would
> > > > > > > apply to case I (where there will never be a driver) and to case II
> > > > > > > (where there is no driver now, but a driver will probe the device
> > > > > > > later).
> > > > > >
> > > > > > Does this means change are required in PCI core.
> > > > >
> > > > > Yes, I am suggesting that the PCI core does not do the right thing
> > > > > here.
> > > > >
> > > > > > I tried following changes in pcie_do_recovery() but it did not help.
> > > > > > Same error as before.
> > > > > >
> > > > > > -- a/drivers/pci/pcie/err.c
> > > > > > +++ b/drivers/pci/pcie/err.c
> > > > > >         pci_info(dev, "broadcast resume message\n");
> > > > > >         pci_walk_bus(bus, report_resume, &status);
> > > > > > @@ -203,7 +207,12 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
> > > > > >         return status;
> > > > > >
> > > > > >  failed:
> > > > > >         pci_uevent_ers(dev, PCI_ERS_RESULT_DISCONNECT);
> > > > > > +       pci_reset_function(dev);
> > > > > > +       pci_aer_clear_device_status(dev);
> > > > > > +       pci_aer_clear_nonfatal_status(dev);
> > > > >
> > > > > Did you confirm that this resets the devices in question (0000:09:00.0
> > > > > and 0000:09:00.1, I think), and what reset mechanism this uses (FLR,
> > > > > PM, etc)?
> > > >
> > > > Earlier reset  was happening with P2P bridge(0000:00:09.0) this the
> > > > reason no effect. After making following changes,  both devices are
> > > > now getting reset.
> > > > Both devices are using FLR.
> > > >
> > > > diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> > > > index 117c0a2b2ba4..26b908f55aef 100644
> > > > --- a/drivers/pci/pcie/err.c
> > > > +++ b/drivers/pci/pcie/err.c
> > > > @@ -66,6 +66,20 @@ static int report_error_detected(struct pci_dev *dev,
> > > >                 if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE) {
> > > >                         vote = PCI_ERS_RESULT_NO_AER_DRIVER;
> > > >                         pci_info(dev, "can't recover (no
> > > > error_detected callback)\n");
> > > > +
> > > > +                       pci_save_state(dev);
> > > > +                       pci_cfg_access_lock(dev);
> > > > +
> > > > +                       /* Quiesce the device completely */
> > > > +                       pci_write_config_word(dev, PCI_COMMAND,
> > > > +                             PCI_COMMAND_INTX_DISABLE);
> > > > +                       if (!__pci_reset_function_locked(dev)) {
> > > > +                               vote = PCI_ERS_RESULT_RECOVERED;
> > > > +                               pci_info(dev, "recovered via pci level
> > > > reset\n");
> > > > +                       }
> > >
> > > Why do we need to save the state and quiesce the device?  The reset
> > > should disable interrupts anyway.  In this particular case where
> > > there's no driver, I don't think we should have to restore the state.
> > > We maybe should *remove* the device and re-enumerate it after the
> > > reset, but the state from before the reset should be irrelevant.
> >
> > I tried pci_reset_function_locked without save/restore then I got the
> > synchronous abort during igb_probe (case 2 i.e. with driver). This is
> > 100% reproducible.
> > looks like pci_reset_function_locked is causing PCI configuration
> > space random. Same is mentioned here
> > https://www.kernel.org/doc/html/latest/driver-api/pci/pci.html
>
> That documentation is poorly worded.  A reset doesn't make the
> contents of config space "random," but of course it sets config space
> registers to their initialization values, including things like the
> device BARs.  After a reset, the device BARs are zero, so it won't
> respond at the address we expect, and I'm sure that's what's causing
> the external abort.
>
> So I guess we *do* need to save the state before the reset and restore
> it (either that or enumerate the device from scratch just like we
> would if it had been hot-added).  I'm not really thrilled with trying
> to save the state after the device has already reported an error.  I'd
> rather do it earlier, maybe during enumeration, like in
> pci_init_capabilities().  But I don't understand all the subtleties of
> dev->state_saved, so that requires some legwork.
>

I tried moving pci_save_state earlier. All observations are the same
as mentioned in earlier discussions.

Some modifications are required in pci_restore_state() as by default
it makes dev->state_saved = false after restore. .
So the next AER causes the earlier mentioned
crash(igb_get_invariants_82575 --> igb_rd32).  It is because
pci_restore_state() returns without restoring any state.

Code changes are below [1]

> I don't think we should set INTX_DISABLE; the reset will make whatever
> we do with it irrelevant anyway.
>
Yes.. It is not required.

> Remind me why the pci_cfg_access_lock()?

I thought of the race conditions between AER (save/restore) and
igb_probe. So I added this.
It is not required as lock is inherently "taken care" in both AER (bus
walk) and igb_probe by the framework.

[1]
root@localhost$ git diff
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 595fcf59843f..35396eb4fd9e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1537,11 +1537,7 @@ static void pci_restore_rebar_state(struct pci_dev *pdev)
        }
 }

-/**
- * pci_restore_state - Restore the saved state of a PCI device
- * @dev: PCI device that we're dealing with
- */
-void pci_restore_state(struct pci_dev *dev)
+void __pci_restore_state(struct pci_dev *dev, int retain_state)
 {
        if (!dev->state_saved)
                return;
@@ -1572,10 +1568,26 @@ void pci_restore_state(struct pci_dev *dev)
        pci_enable_acs(dev);
        pci_restore_iov_state(dev);

-       dev->state_saved = false;
+       if (!retain_state)
+               dev->state_saved = false;
+}
+
+/**
+ * pci_restore_state - Restore the saved state of a PCI device
+ * @dev: PCI device that we're dealing with
+ */
+void pci_restore_state(struct pci_dev *dev)
+{
+       __pci_restore_state(dev, 0);
 }
 EXPORT_SYMBOL(pci_restore_state);

+void pci_restore_retain_state(struct pci_dev *dev)
+{
+       __pci_restore_state(dev, 1);
+}
+EXPORT_SYMBOL(pci_restore_retain_state);
+
 struct pci_saved_state {
        u32 config_space[16];
        struct pci_cap_saved_data cap[0];
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 14bb8f54723e..621eaa34bf9f 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -66,6 +66,13 @@ static int report_error_detected(struct pci_dev *dev,
                if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE) {
                        vote = PCI_ERS_RESULT_NO_AER_DRIVER;
                        pci_info(dev, "can't recover (no
error_detected callback)\n");
+
+                       if (!__pci_reset_function_locked(dev)) {
+                               vote = PCI_ERS_RESULT_RECOVERED;
+                               pci_info(dev, "Recovered via pci level
reset\n");
+                       }
+
+                       pci_restore_retain_state(dev);
                } else {
                        vote = PCI_ERS_RESULT_NONE;
                }
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 77b8a145c39b..af4e27c95421 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2448,6 +2448,8 @@ void pci_device_add(struct pci_dev *dev, struct
pci_bus *bus)

        pci_init_capabilities(dev);

+       pci_save_state(dev);
+
        /*
         * Add the device to our list of discovered devices
         * and the bus list for fixup functions, etc.
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 83ce1cdf5676..42ab7ef850b7 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1234,6 +1234,7 @@ void pci_unmap_rom(struct pci_dev *pdev, void
__iomem *rom);

 /* Power management related routines */
 int pci_save_state(struct pci_dev *dev);
+void pci_restore_retain_state(struct pci_dev *dev);
 void pci_restore_state(struct pci_dev *dev);
 struct pci_saved_state *pci_store_saved_state(struct pci_dev *dev);
 int pci_load_saved_state(struct pci_dev *dev,

--pk

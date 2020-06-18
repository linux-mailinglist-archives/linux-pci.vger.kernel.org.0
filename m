Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C4B1FF898
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jun 2020 18:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731854AbgFRQEt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Jun 2020 12:04:49 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2335 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731848AbgFRQEt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Jun 2020 12:04:49 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id B22742DEFC80839878DA;
        Thu, 18 Jun 2020 17:04:47 +0100 (IST)
Received: from localhost (10.227.96.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Thu, 18 Jun
 2020 17:04:47 +0100
Date:   Thu, 18 Jun 2020 17:04:46 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linux-pci@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-acpi@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        <sean.v.kelley@linux.intel.com>
Subject: Re: [PATCH 2/2] PCI/AER: Add partial initial support for RCiEPs
 using RCEC or firmware first
Message-ID: <20200618170446.000068f2@huawei.com>
In-Reply-To: <20200618094829.00007d46@Huawei.com>
References: <20200616192441.GA1970947@bjorn-Precision-5520>
        <b0b952e26386dc4819726f50c61f86aaa00857b8.camel@linux.intel.com>
        <769c55d1-00dc-95c6-7b5c-3e0ed284bd49@linux.intel.com>
        <20200618094829.00007d46@Huawei.com>
Organization: Huawei tech. R&D (UK)  Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.227.96.57]
X-ClientProxiedBy: lhreml707-chm.china.huawei.com (10.201.108.56) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 18 Jun 2020 09:48:29 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Wed, 17 Jun 2020 11:25:55 -0700
> "Kuppuswamy, Sathyanarayanan"
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> 
> > On 6/17/20 10:36 AM, Sean V Kelley wrote:  
> > > On Tue, 2020-06-16 at 14:24 -0500, Bjorn Helgaas wrote:    
> > >> Bcc:
> > >> Subject: Re: [PATCH 2/2] PCI/AER: Add partial initial support for
> > >> RCiEPs
> > >>   using RCEC or firmware first
> > >> Reply-To:
> > >> In-Reply-To:
> > >> <20200521173134.2456773-3-Jonathan.Cameron@huawei.com>
> > >>
> > >> [+cc Sathy, Sean]
> > >>
> > >> On Fri, May 22, 2020 at 01:31:34AM +0800, Jonathan Cameron
> > >> wrote:    
> > >>> Note this provides complete support for our usecase on an ARM
> > >>> server using
> > >>> Hardware Reduced ACPI and adds appropriate place for an RCEC
> > >>> driver to hook
> > >>> if someone else cares to write one, either for firmware first
> > >>> handling on
> > >>> non Hardware Reduced ACPI or for kernel first AER handling.    
> > >>
> > >> This provides complete support?  I'm really confused, since this
> > >> relies on dev->rcec, which is never set.  And I don't see
> > >> anything about hooks for RCEC drivers.
> > >>    
> > >>> For Root Complex integrated End Points (RCiEPs) there is no root
> > >>> port to
> > >>> discover and hence we cannot walk the bus from the root port to
> > >>> do appropriate resets.
> > >>>
> > >>> The PCI specification provides Root Complex Event Collectors to
> > >>> deal with
> > >>> this circumstance.  These are peer RCiEPs that provide (amongst
> > >>> other
> > >>> things) collection + interrupt facilities for AER reporting for
> > >>> a set of
> > >>> RCiEPs in the same root complex.
> > >>>
> > >>> In the case of a Hardware Reduced ACPI platform, the AER errors
> > >>> are reported via a GHESv2 path using CPER records as defined in
> > >>> the UEFI
> > >>> specification.  These are intended to provide complete
> > >>> information and
> > >>> appropriate hand shake in a fashion that does not require a
> > >>> specific form
> > >>> of error reporting hardware.  This is contrast to AER handling
> > >>> via the
> > >>> various HEST entries for PCI Root Port and PCI Device etc where
> > >>> we do
> > >>> require direct access to the RCEC.    
> > >>
> > >> Can you include pointers to relevant spec sections for these
> > >> differences between hardware-reduced and other platforms?
> > >>
> > >> This patch doesn't seem to depend on anything about ACPI, APEI,
> > >> firmware-first, or hardware-reduced platforms.
> > >>    
> > >>> As such my interpretation of the spec is that a Reduced Hardware
> > >>> ACPI
> > >>> platform should not access the RCEC from the OS at all during
> > >>> AER handling,
> > >>> and in fact is welcome to use non standard hardware interfaces
> > >>> to provide
> > >>> the equivalent functionality in any fashion it wishes (as all
> > >>> hidden beind
> > >>> the firmware).    
> > > 
> > > 
> > > I'm not sure what you mean by Hardware Reduced ACPI platform, but
> > > you seem to be implying that in this case your hardware lacks
> > > RCECs and so are using firmware specific handling.
> > > 
> > > In 1.3.2.3 (Root Complex Integrated Endpoint rules)
> > > 
> > > If an RCiEP is associated with an optional Root Complex Event
> > > Collector it must signal PME and error conditions through a Root
> > > Complex Event Collector.
> > > 
> > > If the RCEC is not supported/present then the expectation prior
> > > to PCIe 5 is that the RCiEP will use the same mechanism as PCI
> > > systems.  However, if the RCiEP asserts say an error signal there
> > > is no Root Port and the OS has no way of knowing what interrupt
> > > the error is conntected to.  Linux doesn't have support for that
> > > and this was discussed prior here:
> > > 
> > > https://lore.kernel.org/lkml/20190709134538.GA35486@google.com/
> > > 
> > > In such a case, are you then implying that the _OSC method is not
> > > granting control of PCIe Native Power Management Events to the OS
> > > and so are falling back to your defined ACPI mechanism on your
> > > platform?
> > > 
> > > I'm currently working on adding support for RCECs in AER that
> > > would make use of the extended capabilities for identifying the
> > > assocated RCeIPs for purposes of the PME and error condition
> > > signaling.    
> > 
> > IIUC, we are trying to solve multiple issues here.
> > 
> > 1. Error detection and recovery support for RCiEPs and RCEC.
> > 2. Firmware first exception for case 1.
> > 3. AEPI based handling for case 1 (I think this is the case
> > Jonathan is trying to handle)  
> 
> I'm not sure it separates that cleanly but the flow I'm interested
> in is firmware first with errors reported using APEI / GHESv2 etc.
> 
> In particular without an RCEC, as it should (I think) play no part
> in that path.  One of the main aims of me bringing this forwards at
> this stage is to establish whether I need to get our hardware teams
> to put an RCEC in place for future hardware or not.  Right now we have
> some work arounds in place as we can reroute some of these errors
> directly to device interrupts.
> 
> We haven't been able to come up with a reason why we need an RCEC
> given our approach to error handling.
> 
> > 
> > For adding support for case 1,
> > 
> > 1. I think we need to first make the AER driver RCEC aware.
> > 2. Once AER driver is modified to receive IRQs for RCEC error
> >     events, then we can modify pcie_do_recovery() to handle
> >     recovery for RCiEPs and RCEC.
> > 
> > I recommend adding support for basic case first and then add
> > exceptions for Firmware First and AEPI based support.  
> 
> Sounds good as long as progress is timely.
> 
> As both Bjorn and yourself have suggested, we can perhaps
> make pci_walk_bus work when it is passed an RCiEP directly.
> 
> If that an be done, the case I care about should work with very
> minimal changes.
> 
> I'll take a look at how cleanly that can be done.
> 
> >   
> > > 
> > > Thanks,
> > > 
> > > Sean
> > > 
> > >     
> > >>
> > >> A pointer to the spec you're interpreting would be helpful here,
> > >> too.
> > >>
> > >> s/Reduced Hardware/Hardware-Reduced/ to match terminology in spec
> > >> (I'm
> > >> looking at ACPI v6.3, sec 4.1).  Also below in code comments.
> > >>
> > >> s/beind/behind/
> > >>    
> > >>> Hence I am making the provision of an RCEC optional.
> > >>>
> > >>> The aim of the rest of the code was to replicate the actions
> > >>> that would
> > >>> have occurred if this had been an EP below a root port. Some of
> > >>> them make
> > >>> absolutely no sense, but I hope this RFC can start a discussion
> > >>> on what
> > >>> we should be doing under these circumstances.
> > >>>
> > >>> It probably makes sense to pull this new block of code out to a
> > >>> separate
> > >>> function but for the RFC I've left it in place to keep it next
> > >>> to the
> > >>> existing path.    
> > >>
> > >> OK, my comment is: I really hope we don't need a separate path.
> > >> If we
> > >> need a test or two for RCiEPs, that's fine.  But two paths sounds
> > >> like
> > >> a nightmare to maintain.
> > >>    
> > >>> It appears that the current kernel first code does not support
> > >>> detecting
> > >>> the multiple error bits being set in the root port error status
> > >>> register.
> > >>> This seems like a limitation both the normal EP / Root Port case
> > >>> and
> > >>> for RCiEPs.    
> > >>
> > >> Is this paragraph supposed to be a bug report?  It doesn't seem
> > >> to say
> > >> anything about what *this* patch does.  Maybe this should be
> > >> part of the commit log for a separate patch?
> > >>    
> > >>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >>> ---
> > >>>   drivers/pci/pcie/err.c | 61
> > >>> ++++++++++++++++++++++++++++++++++++++++++
> > >>>   include/linux/pci.h    |  1 +
> > >>>   2 files changed, 62 insertions(+)
> > >>>
> > >>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> > >>> index 14bb8f54723e..d34be4483f73 100644
> > >>> --- a/drivers/pci/pcie/err.c
> > >>> +++ b/drivers/pci/pcie/err.c
> > >>> @@ -153,6 +153,67 @@ pci_ers_result_t pcie_do_recovery(struct
> > >>> pci_dev *dev,
> > >>>   	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
> > >>>   	struct pci_bus *bus;    
> > I am curious what bus (dev->subordinate) does RCEC and RCiEP
> > belongs to ?  
> 
> I'm not quite sure what you are asking so...
> 
> They are effectively the same as root ports, and so sit on a bus
> specified via ACPI. In our case IORT. The root complex includes a
> bunch of bus numbers on which these devices can be discovered.
> 0, 74, 78, 7a, 7b, 7c, 80, b4, ba, bb, b8, bc on the 2 socket machine
> I have to hand.  Those buses have a mix of root ports, and RCiEPs on
> them.
> 
> As to subordinate (i.e. where they bridge to) I don't think it would
> have any meaning.   For reference I checked one of our RCiEPs and
> it's set to 0 on the config space.
> 
> 
> > Does all RCiEPs are in same bus ?  
> 
> No, though for any given RCiEP the associated RCEC would have to be
> on the same bus. So in the above example we would need quite a few
> of them.

One thing to note is we could minimize the changes to the code by
getting the bus on which a device resides directly rather than
bouncing via the root port and back again.

Something like
-       if (!(pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
-             pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM))
-               dev = dev->bus->self;
-       bus = dev->subordinate;
-
+       if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
+            pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM))
+               bus = dev->subordinate;
+       else
+               bus = dev->bus;
+       if (bus->self)
+               dev = bus->self;

(with some special handling to avoid calling root port specific
parts on the RCiEP)

We could check pci_is_root_bus for that last check and it might be
slightly more informative.

But then an AER error on an RCiEP resets everything on the same bus
within the Root Complex.  

I don't think we want to do this as the same logic about resetting the
PCIe bus and everything below doesn't really apply.

Hence I'll try the pci_walk_bus variant as previously suggested.

Jonathan

> 
> > >>>   
> > >>> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END) {    
> > Also, instead of creating a new path for RCiEPs, I recommend fixing
> > the pci_walk_bus() part. That will reduce code duplication.  
> > >>> +		struct pci_dev *rcec = dev->rcec;
> > >>> +		/* Not clear this makes any sense - we can't
> > >>> reset link anyway...*/
> > >>> +		if (state == pci_channel_io_frozen) {
> > >>> +			report_frozen_detected(dev, &status);
> > >>> +			pci_err(dev, "io is frozen and cannot
> > >>> reset link\n");
> > >>> +			goto failed;
> > >>> +		} else {
> > >>> +			report_normal_detected(dev, &status);
> > >>> +		}    
> > >>
> > >> I don't understand where you're going with this.  I think you're
> > >> adding recovery for RCiEPs (PCI_EXP_TYPE_RC_END).  It's true that
> > >> there's no link leading to them, but we should still be able to
> > >> reset the RCiEP (not the RCEC) via FLR, if it supports that.
> > >>
> > >> And all the driver callbacks should be for the RCiEP, not the
> > >> RCEC, shouldn't they?  I really hope we can avoid duplicating
> > >> this whole path.  It will be hard to keep the two paths in sync.
> > >>    
> > >>> +		if (status == PCI_ERS_RESULT_CAN_RECOVER) {
> > >>> +			status = PCI_ERS_RESULT_RECOVERED;
> > >>> +			pci_dbg(dev, "broadcast mmio_enabled
> > >>> message\n");
> > >>> +			report_mmio_enabled(dev, &status);
> > >>> +		}
> > >>> +
> > >>> +		if (status == PCI_ERS_RESULT_NEED_RESET) {
> > >>> +			/* No actual slot reset possible */
> > >>> +			status = PCI_ERS_RESULT_RECOVERED;
> > >>> +			pci_dbg(dev, "broadcast slot_reset
> > >>> message\n");
> > >>> +			report_slot_reset(dev, &status);
> > >>> +		}
> > >>> +
> > >>> +		if (status != PCI_ERS_RESULT_RECOVERED)
> > >>> +			goto failed;
> > >>> +
> > >>> +		report_resume(dev, &status);
> > >>> +
> > >>> +		/*
> > >>> +		 * These two should be called on the RCEC  -
> > >>> but in case
> > >>> +		 * of firmware first they should be no-ops.
> > >>> Given that
> > >>> +		 * in a reduced hardware ACPI system, it is
> > >>> possible there
> > >>> +		 * is no standard compliant RCEC at all.
> > >>> +		 *
> > >>> +		 * Add some sort of check on what type of HEST
> > >>> entries we have?
> > >>> +		 */
> > >>> +		if (rcec) {
> > >>> +			/*
> > >>> +			 * Unlike the upstream port case for
> > >>> an EP, we have not
> > >>> +			 * issued a reset on all device the
> > >>> RCEC handles, so
> > >>> +			 * perhaps we should be more careful
> > >>> about resetting
> > >>> +			 * the status registers on the RCEC?
> > >>> +			 *
> > >>> +			 * In particular we may need provide a
> > >>> means to handle
> > >>> +			 * the multiple error bits being set in
> > >>> PCI_ERR_ROOT_STATUS
> > >>> +			 */
> > >>> +			pci_aer_clear_device_status(rcec);
> > >>> +			pci_aer_clear_nonfatal_status(rcec);
> > >>> +			/*
> > >>> +			 * Non RCiEP case uses the downstream
> > >>> port above the device
> > >>> +			 * for this message.
> > >>> +			 */
> > >>> +			pci_info(rcec, "device recovery
> > >>> successful\n");
> > >>> +		} else {
> > >>> +			pci_info(dev, "device recovery
> > >>> successful\n");
> > >>> +		}
> > >>> +
> > >>> +		return status;
> > >>> +	}
> > >>> +
> > >>>   	/*
> > >>>   	 * Error recovery runs on all subordinates of the
> > >>> first downstream port.
> > >>>   	 * If the downstream port detected the error, it is
> > >>> cleared at the end.
> > >>> diff --git a/include/linux/pci.h b/include/linux/pci.h
> > >>> index 83ce1cdf5676..cb21dfe05f8c 100644
> > >>> --- a/include/linux/pci.h
> > >>> +++ b/include/linux/pci.h
> > >>> @@ -298,6 +298,7 @@ struct pci_dev {
> > >>>   	struct list_head bus_list;	/* Node in per-bus
> > >>> list */ struct pci_bus	*bus;		/* Bus this
> > >>> device is on */ struct pci_bus	*subordinate;	/*
> > >>> Bus this device bridges to */
> > >>> +	struct pci_dev	*rcec;		/* Root
> > >>> Complex Event Collector used */    
> > >>
> > >> Nothing ever sets this, so I guess the critical connection
> > >> between RCiEP and RCEC is missing?  Each patch needs to make
> > >> sense on its own,
> > >> so the patch that adds this struct member should also add
> > >> something that sets it and uses it.
> > >>    
> > >>>   	void		*sysdata;	/* Hook for
> > >>> sys-specific extension */
> > >>>   	struct proc_dir_entry *procent;	/* Device
> > >>> entry in /proc/bus/pci */
> > >>> -- 
> > >>> 2.19.1
> > >>>    
> > >     
> >   
> 
> 
> _______________________________________________
> Linuxarm mailing list
> Linuxarm@huawei.com
> http://hulk.huawei.com/mailman/listinfo/linuxarm


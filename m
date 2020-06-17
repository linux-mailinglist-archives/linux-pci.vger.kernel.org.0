Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED7E1FCCA9
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jun 2020 13:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgFQLl0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 17 Jun 2020 07:41:26 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2320 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725901AbgFQLl0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Jun 2020 07:41:26 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id D5BFDAB2CADBAB8D75EB;
        Wed, 17 Jun 2020 12:41:24 +0100 (IST)
Received: from localhost (10.52.121.100) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Wed, 17 Jun
 2020 12:41:24 +0100
Date:   Wed, 17 Jun 2020 12:40:36 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linuxarm@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Sean V Kelley <sean.v.kelley@linux.intel.com>
Subject: Re: [PATCH 2/2] PCI/AER: Add partial initial support for RCiEPs
 using RCEC or firmware first
Message-ID: <20200617124036.00006987@Huawei.com>
In-Reply-To: <20200616192441.GA1970947@bjorn-Precision-5520>
References: <20200616192441.GA1970947@bjorn-Precision-5520>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.52.121.100]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 16 Jun 2020 14:24:41 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> Bcc: 
> Subject: Re: [PATCH 2/2] PCI/AER: Add partial initial support for RCiEPs
>  using RCEC or firmware first
> Reply-To: 
> In-Reply-To: <20200521173134.2456773-3-Jonathan.Cameron@huawei.com>
> 
> [+cc Sathy, Sean]
> 
Hi Bjorn,

Thanks for looking at this.  I got a bit carried away in this description
with trying to show that we don't need an RCEC or software support for
one and that has made the description rather confused. Sorry about that!

The complete lack of any consistent diagram of the various options in any
of the related specs has lead me down more than one dead end trying to work
this out.  Looking at the specs today I'm increasingly convinced the
question of Hardware-Reduced vs normal doesn't matter.


Let me try proposing a brief replacement description:

"Root Complex integrate End Points (RCiEPs) are not found below a root port.
 (PCI Express Base Specification 4.0 1.3.2.3, 7.1 for topology)
 As such the error handling needs to perform actions on only the device, rather
 than walking the bus as is done for conventional EPs.

 In firmware-first error handling there is no need to directly access the
 Root Complex Event Collector (RCEC) as the firmware is responsible for all
 actions touching it.  The implementation of the RCEC device may not be compliant
 with the PCIe Spec as the OS does not access it during error handling.
 (RCEC defined in PCI Express Base Specification 4.0 1.3.4)

 (Can drop next bit if we drop the code)
 If kernel-first error handling is in use, handling AER errors for RCiEPs
 requires access to the RCEC they are associated with. Support for this
 is not included in this RFC due to a lack of available test platform." 

> On Fri, May 22, 2020 at 01:31:34AM +0800, Jonathan Cameron wrote:
> > Note this provides complete support for our usecase on an ARM server using
> > Hardware Reduced ACPI and adds appropriate place for an RCEC driver to hook
> > if someone else cares to write one, either for firmware first handling on
> > non Hardware Reduced ACPI or for kernel first AER handling.  
> 
> This provides complete support?  I'm really confused, since this
> relies on dev->rcec, which is never set.  And I don't see anything
> about hooks for RCEC drivers.

In our configuration we only support firmware first.
For that we don't need dev->rcec to be set.

For our case, the OS should not in any way touch the RCEC (in fact, as far as I can
tell, it doesn't actually need to exist - and for some of our platforms it doesn't.
An impdef bit of hardware can do the same job.)

The information that could be read from the RCEC is provided
in a CPER record via GHESv2.  Confirmation that the OS has done everything
it needs to with the error is done via a handshake in the GHESv2 Error Status
Block.

Hence for the particular corner case we care about this code provides everything
necessary.  The stubs of RCEC support are there just to indicate how it
'might' fit with a model where the RCEC is needed to get information about
the error etc.  I'm more than happy to drop them and perhaps put in a comment
to put anyone needing them on the right track.

I put this statement around 'fully support in our case' here to indicate
that the 'partial initial support' in the title is actually sufficient
for some systems.

> 
> > For Root Complex integrated End Points (RCiEPs) there is no root port to
> > discover and hence we cannot walk the bus from the root port to do
> > appropriate resets.
> > 
> > The PCI specification provides Root Complex Event Collectors to deal with
> > this circumstance.  These are peer RCiEPs that provide (amongst other
> > things) collection + interrupt facilities for AER reporting for a set of
> > RCiEPs in the same root complex.
> > 
> > In the case of a Hardware Reduced ACPI platform, the AER errors are
> > reported via a GHESv2 path using CPER records as defined in the UEFI
> > specification.  These are intended to provide complete information and
> > appropriate hand shake in a fashion that does not require a specific form
> > of error reporting hardware.  This is contrast to AER handling via the
> > various HEST entries for PCI Root Port and PCI Device etc where we do
> > require direct access to the RCEC.  
> 
> Can you include pointers to relevant spec sections for these
> differences between hardware-reduced and other platforms?

As mentioned above, I think I went down a dead end on this description.
I think the lack of need for an RCEC in firmware first handling is equally
valid in all Firmware first cases.

I can have a go at highlighting relevant spec entries, though its scattered
across the ACPI spec and UEFI spec.  Focusing just on the elements relevant
to RAS handling...

The very brief version is that in Hardware Reduced ACPI all error
information is gathered via a management processor (or firmware doing
the same job) and presented as a descriptive record. There is also
a generic handshake to acknowledge the error without needing anything
hardware specific.

My confusion lay around the non Hardware-Reduced case.  I'm not totally clear
on what happens in that path and don't have any hardware to look at.
So my assumption was that it used the HEST entries for PCIe Root Port
etc to identify where to find the error.  I now 'think' that isn't true
and it uses GHES records. If anyone can point me to a reference for this
flow that would be great.

HEST can also include GHESv2 entries as defined in ACPI 6.3, section 18.3.2.8
There error flow is the same for all GHESv2 error types:

"These are the steps the OS must take once detecting an error from a particular
GHESv2 error source:
•OSPM detects error (via interrupt/exception or polling the block status)
•OSPM copies the error status block
•OSPM clears the block status field of the error status block
•OSPM acknowledges the error via Read Ack register. For example:
—OSPM reads the Read Ack register  X
—OSPM writes  (( X & ReadAckPreserve) | ReadAckWrite)"

Referring back to the GHES description in ACPI 6.3 18.3.2.7
We have a Generic Error Status Block which has a bunch of
Generic Error Data Entries (18-392). Those contain CPER
records.

CPER record types are defined in the UEFI spec, appendix N.
These are identified by GUID and there is one for PCIE errors.
(table 54)  Definition of that is in N2.7.
It includes the source, plus root port / bridge address and
(potentially) a copy of the PCIe Advanced Error Reporting
Extended Capability Structure

Everything you might otherwise read from the AER registers should
be present in this record.  The basic aim being that you shouldn't
need to read those PCIe registers directly (and may not be able
to).



> 
> This patch doesn't seem to depend on anything about ACPI, APEI,
> firmware-first, or hardware-reduced platforms.

The only thing it really depends on is whether an RCEC is present.
It is possible to have a valid platform that doesn't need one.
The reference to firmware-first etc are about establishing that it
is optional.

> 
> > As such my interpretation of the spec is that a Reduced Hardware ACPI
> > platform should not access the RCEC from the OS at all during AER handling,
> > and in fact is welcome to use non standard hardware interfaces to provide
> > the equivalent functionality in any fashion it wishes (as all hidden beind
> > the firmware).  
> 
> A pointer to the spec you're interpreting would be helpful here, too.

Same info as above.  Good info on what firmware first flow actually means
is hard to come by.  I have docs on our flows, but can't find any on
a typical x86 machine.

> 
> s/Reduced Hardware/Hardware-Reduced/ to match terminology in spec (I'm
> looking at ACPI v6.3, sec 4.1).  Also below in code comments.
> 
> s/beind/behind/

Will fix.

> 
> > Hence I am making the provision of an RCEC optional.
> >
> > The aim of the rest of the code was to replicate the actions that would
> > have occurred if this had been an EP below a root port. Some of them make
> > absolutely no sense, but I hope this RFC can start a discussion on what
> > we should be doing under these circumstances.
> > 
> > It probably makes sense to pull this new block of code out to a separate
> > function but for the RFC I've left it in place to keep it next to the
> > existing path.  
> 
> OK, my comment is: I really hope we don't need a separate path.  If we
> need a test or two for RCiEPs, that's fine.  But two paths sounds like
> a nightmare to maintain.

You can't walk the bus for RCiEPs so its going to be inherently different.
We could do it as a series of special cases though so it's obvious what
is going on. Would you prefer that?

> 
> > It appears that the current kernel first code does not support detecting
> > the multiple error bits being set in the root port error status register.
> > This seems like a limitation both the normal EP / Root Port case and
> > for RCiEPs.  
> 
> Is this paragraph supposed to be a bug report?  It doesn't seem to say
> anything about what *this* patch does.  Maybe this should be part of
> the commit log for a separate patch?

Side note on something we are not trying to support here for anyone who
comes across it! I shouldn't have left that in.  I'll drop it.

> 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  drivers/pci/pcie/err.c | 61 ++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/pci.h    |  1 +
> >  2 files changed, 62 insertions(+)
> > 
> > diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> > index 14bb8f54723e..d34be4483f73 100644
> > --- a/drivers/pci/pcie/err.c
> > +++ b/drivers/pci/pcie/err.c
> > @@ -153,6 +153,67 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
> >  	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
> >  	struct pci_bus *bus;
> >  
> > +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END) {
> > +		struct pci_dev *rcec = dev->rcec;
> > +		/* Not clear this makes any sense - we can't reset link anyway...*/
> > +		if (state == pci_channel_io_frozen) {
> > +			report_frozen_detected(dev, &status);
> > +			pci_err(dev, "io is frozen and cannot reset link\n");
> > +			goto failed;
> > +		} else {
> > +			report_normal_detected(dev, &status);
> > +		}  
> 
> I don't understand where you're going with this.  I think you're
> adding recovery for RCiEPs (PCI_EXP_TYPE_RC_END).  It's true that
> there's no link leading to them, but we should still be able to reset
> the RCiEP (not the RCEC) via FLR, if it supports that.

Agreed.  This code is operating on the RCiEP not the rcec. Only the
block below under the if (rcec) check touches that. 

It might help to think of this as walking a bus of one element. Hence
we are calling directly on the RCiEP rather than the bus walks in
the normal path.

> 
> And all the driver callbacks should be for the RCiEP, not the RCEC,
> shouldn't they?  I really hope we can avoid duplicating this whole
> path.  It will be hard to keep the two paths in sync.

Yes, and they are unless I'm missing something. Except for the one
block below, which mirrors the actions taken on the root port in the
normal path.

> 
> > +		if (status == PCI_ERS_RESULT_CAN_RECOVER) {
> > +			status = PCI_ERS_RESULT_RECOVERED;
> > +			pci_dbg(dev, "broadcast mmio_enabled message\n");
> > +			report_mmio_enabled(dev, &status);
> > +		}
> > +
> > +		if (status == PCI_ERS_RESULT_NEED_RESET) {
> > +			/* No actual slot reset possible */
> > +			status = PCI_ERS_RESULT_RECOVERED;
> > +			pci_dbg(dev, "broadcast slot_reset message\n");
> > +			report_slot_reset(dev, &status);
> > +		}
> > +
> > +		if (status != PCI_ERS_RESULT_RECOVERED)
> > +			goto failed;
> > +
> > +		report_resume(dev, &status);
> > +
> > +		/*
> > +		 * These two should be called on the RCEC  - but in case
> > +		 * of firmware first they should be no-ops. Given that
> > +		 * in a reduced hardware ACPI system, it is possible there
> > +		 * is no standard compliant RCEC at all.
> > +		 *
> > +		 * Add some sort of check on what type of HEST entries we have?
> > +		 */
> > +		if (rcec) {

This is the only bit that related to the RCEC.

> > +			/*
> > +			 * Unlike the upstream port case for an EP, we have not
> > +			 * issued a reset on all device the RCEC handles, so
> > +			 * perhaps we should be more careful about resetting
> > +			 * the status registers on the RCEC?
> > +			 *
> > +			 * In particular we may need provide a means to handle
> > +			 * the multiple error bits being set in PCI_ERR_ROOT_STATUS
> > +			 */
> > +			pci_aer_clear_device_status(rcec);
> > +			pci_aer_clear_nonfatal_status(rcec);
> > +			/*
> > +			 * Non RCiEP case uses the downstream port above the device
> > +			 * for this message.
> > +			 */
> > +			pci_info(rcec, "device recovery successful\n");
> > +		} else {
> > +			pci_info(dev, "device recovery successful\n");
> > +		}
> > +
> > +		return status;
> > +	}
> > +
> >  	/*
> >  	 * Error recovery runs on all subordinates of the first downstream port.
> >  	 * If the downstream port detected the error, it is cleared at the end.
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 83ce1cdf5676..cb21dfe05f8c 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -298,6 +298,7 @@ struct pci_dev {
> >  	struct list_head bus_list;	/* Node in per-bus list */
> >  	struct pci_bus	*bus;		/* Bus this device is on */
> >  	struct pci_bus	*subordinate;	/* Bus this device bridges to */
> > +	struct pci_dev	*rcec;		/* Root Complex Event Collector used */  
> 
> Nothing ever sets this, so I guess the critical connection between
> RCiEP and RCEC is missing?  Each patch needs to make sense on its own,
> so the patch that adds this struct member should also add something
> that sets it and uses it.

I'm happy to drop this. It's here only to try to make the point that the
infra-structure would be needed in the non Firmware-First case.

Intent was to illustrate that what I was defining for firmware first
would also work for kernel-first flows assuming someone actually put in place
infrastructure to hook up the RCEC here.

I was rather hoping someone would jump up and say 'I've got one of those!'.

Thanks again,

Jonathan


> 
> >  	void		*sysdata;	/* Hook for sys-specific extension */
> >  	struct proc_dir_entry *procent;	/* Device entry in /proc/bus/pci */
> > -- 
> > 2.19.1
> >   



Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095651FD396
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jun 2020 19:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgFQRgS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Jun 2020 13:36:18 -0400
Received: from mga05.intel.com ([192.55.52.43]:27088 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726511AbgFQRgR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Jun 2020 13:36:17 -0400
IronPort-SDR: wyiIc6EcPcyPGsl9ZwWMeO/ejgyYdNiSbi0LwhFeugo4DglcBuMcp5aUgMgOYPxjEEGDh12Hni
 PB/653S04OPQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 10:36:02 -0700
IronPort-SDR: RmHIA1Hz6/FjIzKFUa6JCYw2oa871SVofTDawPI5UZEbs2MeHYenZM+7HliMU4sTmqCLetRl2B
 fRntj098jJYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,523,1583222400"; 
   d="scan'208";a="317589044"
Received: from pvenkat2-mobl1.amr.corp.intel.com (HELO arch-ashland-svkelley) ([10.254.38.219])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Jun 2020 10:36:01 -0700
Message-ID: <b0b952e26386dc4819726f50c61f86aaa00857b8.camel@linux.intel.com>
Subject: Re: [PATCH 2/2] PCI/AER: Add partial initial support for RCiEPs
 using RCEC or firmware first
From:   Sean V Kelley <sean.v.kelley@linux.intel.com>
Reply-To: sean.v.kelley@linux.intel.com
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linuxarm@huawei.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Date:   Wed, 17 Jun 2020 10:36:00 -0700
In-Reply-To: <20200616192441.GA1970947@bjorn-Precision-5520>
References: <20200616192441.GA1970947@bjorn-Precision-5520>
Organization: Intel Corporation
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2020-06-16 at 14:24 -0500, Bjorn Helgaas wrote:
> Bcc: 
> Subject: Re: [PATCH 2/2] PCI/AER: Add partial initial support for
> RCiEPs
>  using RCEC or firmware first
> Reply-To: 
> In-Reply-To: <20200521173134.2456773-3-Jonathan.Cameron@huawei.com>
> 
> [+cc Sathy, Sean]
> 
> On Fri, May 22, 2020 at 01:31:34AM +0800, Jonathan Cameron wrote:
> > Note this provides complete support for our usecase on an ARM
> > server using
> > Hardware Reduced ACPI and adds appropriate place for an RCEC driver
> > to hook
> > if someone else cares to write one, either for firmware first
> > handling on
> > non Hardware Reduced ACPI or for kernel first AER handling.
> 
> This provides complete support?  I'm really confused, since this
> relies on dev->rcec, which is never set.  And I don't see anything
> about hooks for RCEC drivers.
> 
> > For Root Complex integrated End Points (RCiEPs) there is no root
> > port to
> > discover and hence we cannot walk the bus from the root port to do
> > appropriate resets.
> > 
> > The PCI specification provides Root Complex Event Collectors to
> > deal with
> > this circumstance.  These are peer RCiEPs that provide (amongst
> > other
> > things) collection + interrupt facilities for AER reporting for a
> > set of
> > RCiEPs in the same root complex.
> > 
> > In the case of a Hardware Reduced ACPI platform, the AER errors are
> > reported via a GHESv2 path using CPER records as defined in the
> > UEFI
> > specification.  These are intended to provide complete information
> > and
> > appropriate hand shake in a fashion that does not require a
> > specific form
> > of error reporting hardware.  This is contrast to AER handling via
> > the
> > various HEST entries for PCI Root Port and PCI Device etc where we
> > do
> > require direct access to the RCEC.
> 
> Can you include pointers to relevant spec sections for these
> differences between hardware-reduced and other platforms?
> 
> This patch doesn't seem to depend on anything about ACPI, APEI,
> firmware-first, or hardware-reduced platforms.
> 
> > As such my interpretation of the spec is that a Reduced Hardware
> > ACPI
> > platform should not access the RCEC from the OS at all during AER
> > handling,
> > and in fact is welcome to use non standard hardware interfaces to
> > provide
> > the equivalent functionality in any fashion it wishes (as all
> > hidden beind
> > the firmware).


I'm not sure what you mean by Hardware Reduced ACPI platform, but you
seem to be implying that in this case your hardware lacks RCECs and so
are using firmware specific handling.

In 1.3.2.3 (Root Complex Integrated Endpoint rules)

If an RCiEP is associated with an optional Root Complex Event Collector
it must signal PME and error conditions through a Root Complex Event
Collector.

If the RCEC is not supported/present then the expectation prior to PCIe
5 is that the RCiEP will use the same mechanism as PCI
systems.  However, if the RCiEP asserts say an error signal there is no
Root Port and the OS has no way of knowing what interrupt the error is
conntected to.  Linux doesn't have support for that and this was
discussed prior here:

https://lore.kernel.org/lkml/20190709134538.GA35486@google.com/

In such a case, are you then implying that the _OSC method is not
granting control of PCIe Native Power Management Events to the OS and
so are falling back to your defined ACPI mechanism on your platform?

I'm currently working on adding support for RCECs in AER that would
make use of the extended capabilities for identifying the assocated
RCeIPs for purposes of the PME and error condition signaling.

Thanks,

Sean


> 
> A pointer to the spec you're interpreting would be helpful here, too.
> 
> s/Reduced Hardware/Hardware-Reduced/ to match terminology in spec
> (I'm
> looking at ACPI v6.3, sec 4.1).  Also below in code comments.
> 
> s/beind/behind/
> 
> > Hence I am making the provision of an RCEC optional.
> > 
> > The aim of the rest of the code was to replicate the actions that
> > would
> > have occurred if this had been an EP below a root port. Some of
> > them make
> > absolutely no sense, but I hope this RFC can start a discussion on
> > what
> > we should be doing under these circumstances.
> > 
> > It probably makes sense to pull this new block of code out to a
> > separate
> > function but for the RFC I've left it in place to keep it next to
> > the
> > existing path.
> 
> OK, my comment is: I really hope we don't need a separate path.  If
> we
> need a test or two for RCiEPs, that's fine.  But two paths sounds
> like
> a nightmare to maintain.
> 
> > It appears that the current kernel first code does not support
> > detecting
> > the multiple error bits being set in the root port error status
> > register.
> > This seems like a limitation both the normal EP / Root Port case
> > and
> > for RCiEPs.
> 
> Is this paragraph supposed to be a bug report?  It doesn't seem to
> say
> anything about what *this* patch does.  Maybe this should be part of
> the commit log for a separate patch?
> 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  drivers/pci/pcie/err.c | 61
> > ++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/pci.h    |  1 +
> >  2 files changed, 62 insertions(+)
> > 
> > diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> > index 14bb8f54723e..d34be4483f73 100644
> > --- a/drivers/pci/pcie/err.c
> > +++ b/drivers/pci/pcie/err.c
> > @@ -153,6 +153,67 @@ pci_ers_result_t pcie_do_recovery(struct
> > pci_dev *dev,
> >  	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
> >  	struct pci_bus *bus;
> >  
> > +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END) {
> > +		struct pci_dev *rcec = dev->rcec;
> > +		/* Not clear this makes any sense - we can't reset link
> > anyway...*/
> > +		if (state == pci_channel_io_frozen) {
> > +			report_frozen_detected(dev, &status);
> > +			pci_err(dev, "io is frozen and cannot reset
> > link\n");
> > +			goto failed;
> > +		} else {
> > +			report_normal_detected(dev, &status);
> > +		}
> 
> I don't understand where you're going with this.  I think you're
> adding recovery for RCiEPs (PCI_EXP_TYPE_RC_END).  It's true that
> there's no link leading to them, but we should still be able to reset
> the RCiEP (not the RCEC) via FLR, if it supports that.
> 
> And all the driver callbacks should be for the RCiEP, not the RCEC,
> shouldn't they?  I really hope we can avoid duplicating this whole
> path.  It will be hard to keep the two paths in sync.
> 
> > +		if (status == PCI_ERS_RESULT_CAN_RECOVER) {
> > +			status = PCI_ERS_RESULT_RECOVERED;
> > +			pci_dbg(dev, "broadcast mmio_enabled
> > message\n");
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
> > +		 * These two should be called on the RCEC  - but in
> > case
> > +		 * of firmware first they should be no-ops. Given that
> > +		 * in a reduced hardware ACPI system, it is possible
> > there
> > +		 * is no standard compliant RCEC at all.
> > +		 *
> > +		 * Add some sort of check on what type of HEST entries
> > we have?
> > +		 */
> > +		if (rcec) {
> > +			/*
> > +			 * Unlike the upstream port case for an EP, we
> > have not
> > +			 * issued a reset on all device the RCEC
> > handles, so
> > +			 * perhaps we should be more careful about
> > resetting
> > +			 * the status registers on the RCEC?
> > +			 *
> > +			 * In particular we may need provide a means to
> > handle
> > +			 * the multiple error bits being set in
> > PCI_ERR_ROOT_STATUS
> > +			 */
> > +			pci_aer_clear_device_status(rcec);
> > +			pci_aer_clear_nonfatal_status(rcec);
> > +			/*
> > +			 * Non RCiEP case uses the downstream port
> > above the device
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
> >  	 * Error recovery runs on all subordinates of the first
> > downstream port.
> >  	 * If the downstream port detected the error, it is cleared at
> > the end.
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 83ce1cdf5676..cb21dfe05f8c 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -298,6 +298,7 @@ struct pci_dev {
> >  	struct list_head bus_list;	/* Node in per-bus list */
> >  	struct pci_bus	*bus;		/* Bus this device is on */
> >  	struct pci_bus	*subordinate;	/* Bus this device bridges
> > to */
> > +	struct pci_dev	*rcec;		/* Root Complex Event
> > Collector used */
> 
> Nothing ever sets this, so I guess the critical connection between
> RCiEP and RCEC is missing?  Each patch needs to make sense on its
> own,
> so the patch that adds this struct member should also add something
> that sets it and uses it.
> 
> >  	void		*sysdata;	/* Hook for sys-specific
> > extension */
> >  	struct proc_dir_entry *procent;	/* Device entry in
> > /proc/bus/pci */
> > -- 
> > 2.19.1
> > 


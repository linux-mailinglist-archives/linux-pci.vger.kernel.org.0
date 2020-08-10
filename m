Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9DA240416
	for <lists+linux-pci@lfdr.de>; Mon, 10 Aug 2020 11:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgHJJeY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 10 Aug 2020 05:34:24 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2586 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726304AbgHJJeY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Aug 2020 05:34:24 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id CACCEA4E080892432639;
        Mon, 10 Aug 2020 10:34:21 +0100 (IST)
Received: from localhost (10.52.123.94) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 10 Aug
 2020 10:34:21 +0100
Date:   Mon, 10 Aug 2020 10:32:52 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Sean V Kelley <sean.v.kelley@intel.com>, <rjw@rjwysocki.net>
CC:     Bjorn Helgaas <helgaas@kernel.org>, <bhelgaas@google.com>,
        <ashok.raj@intel.com>, <tony.luck@intel.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 4/9] PCI/AER: Extend AER error handling to RCECs
Message-ID: <20200810103252.00000318@Huawei.com>
In-Reply-To: <D24FD705-BFE3-4623-AC7B-E53FCDC06EC5@intel.com>
References: <20200807225314.GA521346@bjorn-Precision-5520>
        <D24FD705-BFE3-4623-AC7B-E53FCDC06EC5@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.52.123.94]
X-ClientProxiedBy: lhreml733-chm.china.huawei.com (10.201.108.84) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 7 Aug 2020 17:55:17 -0700
Sean V Kelley <sean.v.kelley@intel.com> wrote:

> On 7 Aug 2020, at 15:53, Bjorn Helgaas wrote:
> 
> > On Tue, Aug 04, 2020 at 12:40:47PM -0700, Sean V Kelley wrote:  
> >> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >>
> >> Currently the kernel does not handle AER errors for Root Complex 
> >> integrated
> >> End Points (RCiEPs)[0]. These devices sit on a root bus within the 
> >> Root Complex
> >> (RC). AER handling is performed by a Root Complex Event Collector 
> >> (RCEC) [1]
> >> which is a effectively a type of RCiEP on the same root bus.
> >>
> >> For an RCEC (technically not a Bridge), error messages "received" 
> >> from
> >> associated RCiEPs must be enabled for "transmission" in order to 
> >> cause a
> >> System Error via the Root Control register or (when the Advanced 
> >> Error
> >> Reporting Capability is present) reporting via the Root Error Command
> >> register and logging in the Root Error Status register and Error 
> >> Source
> >> Identification register.
> >>
> >> In addition to the defined OS level handling of the reset flow for 
> >> the
> >> associated RCiEPs of an RCEC, it is possible to also have a firmware 
> >> first
> >> model. In that case there is no need to take any actions on the RCEC 
> >> because
> >> the firmware is responsible for them. This is true where APEI [2] is 
> >> used
> >> to report the AER errors via a GHES[v2] HEST entry [3] and relevant
> >> AER CPER record [4] and Firmware First handling is in use.  
> >
> > I don't see anything in the patch that mentions "firmware first." Do
> > we need it in the commit log?  After
> > https://git.kernel.org/linus/708b20003624 ("PCI/AER: Remove
> > HEST/FIRMWARE_FIRST parsing for AER ownership"), I think we no longer
> > know anything about firmware-first in the kernel.  
> 
> I’ll let Jonathan reply here.

This is a terminology question rather about what the distinction
between "Firmware First" vs "non native handling" is.

Note that in ARM world, native handling tends to be referred to as
'kernel first' and firmware based handling as 'firmware first' 
but that isn't that relevant here other than perhaps explaining why I used
this terminology. e.g.
http://connect.linaro.org.s3.amazonaws.com/hkg18/presentations/hkg18-116.pdf
The distinction is who receives the notification of the error from hardware
and hence who sees it 'first' - basically where does the interrupt go?

Anyhow, if we want to avoid confusion here, we can just use the phrase
"non native handling" which I think is unambiguous?


...
 
> >  
> >> + * including any bridged devices on buses under this bus.
> >> + * Call the provided callback on each device found.
> >> + *
> >> + * If the device provided has no subordinate bus, call the provided
> >> + * callback on the device itself.
> >> + */
> >> +static void pci_walk_dev_affected(struct pci_dev *dev, int 
> >> (*cb)(struct pci_dev *, void *),  
> >
> > I don't understand the "affected" reference in the function name.
> > This doesn't test anything to see whether devices are "affected".
> > Naming is the hardest part of programming :)  
> 
> In earlier discussion, Cameron had suggested pci_walk_aer_affected(). 
> But I thought perhaps that the focus should be on the devices.  Perhaps 
> a better description would be pci_walk_aer_devices() or something along 
> those lines.  The original incarnation was pci_walk_below_dev().
> 
> I’m open to anything, really.

Agreed. It is really hard to name this function and would be great to 
have a better option.

> >>  pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
> >>  			pci_channel_state_t state,
> >>  			pci_ers_result_t (*reset_link)(struct pci_dev *pdev))
> >>  {
> >>  	pci_ers_result_t 'status = PCI_ERS_RESULT_CAN_RECOVER;
> >> -	struct pci_bus *bus;
> >>
> >>  	/*
> >>  	 * Error recovery runs on all subordinates of the first downstream 
> >> port.
> >>  	 * If the downstream port detected the error, it is cleared at the 
> >> end.
> >> +	 * For RCiEPs we should reset just the RCiEP itself.
> >>  	 */
> >>  	if (!(pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> >> -	      pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM))
> >> +	      pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
> >> +	      pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END ||
> >> +	      pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC))
> >>  		dev = dev->bus->self;
> >> -	bus = dev->subordinate;
> >>
> >>  	pci_dbg(dev, "broadcast error_detected message\n");
> >>  	if (state == pci_channel_io_frozen) {
> >> -		pci_walk_bus(bus, report_frozen_detected, &status);
> >> +		pci_walk_dev_affected(dev, report_frozen_detected, &status);
> >> +		if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END) {
> >> +			pci_warn(dev, "link reset not possible for RCiEP\n");
> >> +			status = PCI_ERS_RESULT_NONE;
> >> +			goto failed;
> >> +		}
> >> +
> >>  		status = reset_link(dev);  
> >
> > reset_link() might be misnamed.  IIUC "dev" is a bridge, and the point
> > is really to reset any devices below "dev."  Whether we do that by
> > resetting link, DPC trigger, secondary bus reset, FLR, etc, is sort of
> > immaterial.  Some of those methods might be applicable for RCiEPs.
> >
> > But you didn't add that name; I'm just trying to understand this
> > better.  
> 
> Yes, that’s a confusing term with the _link attached. It’s difficult 
> to relate to the different resets that might be applicable. I was 
> thinking about that when looking at the callback path via the 
> “reset_link” of the RCiEP to the RCEC for the sole purpose of 
> clearing the Root Port Error Status. It would be worth time to spend 
> looking at better descriptive naming/methods.

Agreed, this caused me some some confusion as well so more descriptive
naming would be good.

> 
> >  
> >>  		if (status != PCI_ERS_RESULT_RECOVERED) {
> >>  			pci_warn(dev, "link reset failed\n");
> >>  			goto failed;
> >>  		}
> >>  	} else {
> >> -		pci_walk_bus(bus, report_normal_detected, &status);
> >> +		pci_walk_dev_affected(dev, report_normal_detected, &status);
> >>  	}
> >>
> >>  	if (status == PCI_ERS_RESULT_CAN_RECOVER) {
> >>  		status = PCI_ERS_RESULT_RECOVERED;
> >>  		pci_dbg(dev, "broadcast mmio_enabled message\n");
> >> -		pci_walk_bus(bus, report_mmio_enabled, &status);
> >> +		pci_walk_dev_affected(dev, report_mmio_enabled, &status);
> >>  	}
> >>
> >>  	if (status == PCI_ERS_RESULT_NEED_RESET) {
> >> @@ -188,18 +219,22 @@ pci_ers_result_t pcie_do_recovery(struct 
> >> pci_dev *dev,
> >>  		 */
> >>  		status = PCI_ERS_RESULT_RECOVERED;
> >>  		pci_dbg(dev, "broadcast slot_reset message\n");
> >> -		pci_walk_bus(bus, report_slot_reset, &status);
> >> +		pci_walk_dev_affected(dev, report_slot_reset, &status);
> >>  	}
> >>
> >>  	if (status != PCI_ERS_RESULT_RECOVERED)
> >>  		goto failed;
> >>
> >>  	pci_dbg(dev, "broadcast resume message\n");
> >> -	pci_walk_bus(bus, report_resume, &status);
> >> -
> >> -	if (pcie_aer_is_native(dev))
> >> -		pcie_clear_device_status(dev);
> >> -	pci_aer_clear_nonfatal_status(dev);
> >> +	pci_walk_dev_affected(dev, report_resume, &status);
> >> +
> >> +	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> >> +	     pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
> >> +	     pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)) {
> >> +		if (pcie_aer_is_native(dev))
> >> +			pcie_clear_device_status(dev);
> >> +		pci_aer_clear_nonfatal_status(dev);  
> >
> > This change (testing pci_pcie_type()) looks like it's not strictly
> > related to the rest of this patch and maybe should be split out into
> > its own patch?  
> 
> This change was also based on a commit (068c29a24) in the pci/next 
> branch. The type testing was brought over from Jonathan’s original V2, 
> but actually, it went full circle by adding the RC_EC type, because now 
> it was no longer a no-op. There was an original concern about the need 
> for those to be called on the RCEC from Jonathan’s RFC.

What this is doing is ensuring that we do not call these reset functions
if dev is an RCiEP.  This patch is introducing that possibility for the
first time.  Breaking it out to a precursor patch might be possible but
would seem a bit odd.  Perhaps we could invert the logic to check it
isn't PCI_EXP_TYPE_RC_END?  That seems less intuitive than a positive
check to me.  It might not be obvious to a future reader that we can't get
here with most of the other types.

Thanks,

Jonathan



> 
> Thoughts Jonathan?
> 
> Thanks,
> 
> Sean
> 
> >  
> >> +	}
> >>  	pci_info(dev, "device recovery successful\n");
> >>  	return status;
> >>
> >> -- 
> >> 2.27.0
> >>  



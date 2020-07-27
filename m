Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5ED222EA9B
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jul 2020 13:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbgG0LBq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jul 2020 07:01:46 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2532 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726946AbgG0LBq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Jul 2020 07:01:46 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 3074895898BFA8EF2322;
        Mon, 27 Jul 2020 12:01:43 +0100 (IST)
Received: from localhost (10.52.121.176) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Mon, 27 Jul
 2020 12:01:42 +0100
Date:   Mon, 27 Jul 2020 12:00:19 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Sean V Kelley <sean.v.kelley@intel.com>
CC:     <bhelgaas@google.com>, <rjw@rjwysocki.net>, <ashok.raj@kernel.org>,
        <tony.luck@intel.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 4/9] PCI/AER: Extend AER error handling to RCECs
Message-ID: <20200727120019.000030d2@Huawei.com>
In-Reply-To: <20200724172223.145608-5-sean.v.kelley@intel.com>
References: <20200724172223.145608-1-sean.v.kelley@intel.com>
        <20200724172223.145608-5-sean.v.kelley@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.121.176]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 24 Jul 2020 10:22:18 -0700
Sean V Kelley <sean.v.kelley@intel.com> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Currently the kernel does not handle AER errors for Root Complex integrated
> End Points (RCiEPs)[0]. These devices sit on a root bus within the Root Complex
> (RC). AER handling is performed by a Root Complex Event Collector (RCEC) [1]
> which is a effectively a type of RCiEP on the same root bus.
> 
> For an RCEC (technically not a Bridge), error messages "received" from
> associated RCiEPs must be enabled for "transmission" in order to cause a
> System Error via the Root Control register or (when the Advanced Error
> Reporting Capability is present) reporting via the Root Error Command
> register and logging in the Root Error Status register and Error Source
> Identification register.
> 
> In addition to the defined OS level handling of the reset flow for the
> associated RCiEPs of an RCEC, it is possible to also have a firmware first
> model. In that case there is no need to take any actions on the RCEC because
> the firmware is responsible for them. This is true where APEI [2] is used
> to report the AER errors via a GHES[v2] HEST entry [3] and relevant
> AER CPER record [4] and Firmware First handling is in use.
> 
> We effectively end up with two different types of discovery for
> purposes of handling AER errors:
> 
> 1) Normal bus walk - we pass the downstream port above a bus to which
> the device is attached and it walks everything below that point.
> 
> 2) An RCiEP with no visible association with an RCEC as there is no need to
> walk devices. In that case, the flow is to just call the callbacks for the actual
> device.
> 
> A new walk function, similar to pci_bus_walk is provided that takes a pci_dev
> instead of a bus. If that dev corresponds to a downstream port it will walk
> the subordinate bus of that downstream port. If the dev does not then it
> will call the function on that device alone.
> 
> [0] ACPI PCI Express Base Specification 5.0-1 1.3.2.3 Root Complex Integrated
>     Endpoint Rules.
> [1] ACPI PCI Express Base Specification 5.0-1 6.2 Error Signalling and Logging
> [2] ACPI Specification 6.3 Chapter 18 ACPI Platform Error Interface (APEI)
> [3] ACPI Specification 6.3 18.2.3.7 Generic Hardware Error Source
> [4] UEFI Specification 2.8, N.2.7 PCI Express Error Section
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
> ---
> Changes since v2 [1]:
> 
> - Renamed to pci_walk_dev_affected() to reflect the aer affected devices
Make sense.

> - Localized to err.c and made static

Makes sense.

> - Added check for RCEC to reflect
That comment probably needs a bit more...

> - Tightened up commit log from earlier inquiry focused RFC
Cool.


Looks good to me and I like the new naming.

A few really trivial tidy ups suggested for things that were less than neat in my patch.

Jonathan

> 
> [1] https://lore.kernel.org/linux-pci/20200622114402.892798-1-Jonathan.Cameron@huawei.com/
> ---
>  drivers/pci/pcie/err.c | 55 ++++++++++++++++++++++++++++++++++--------
>  1 file changed, 45 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 14bb8f54723e..044df004f20b 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -146,38 +146,69 @@ static int report_resume(struct pci_dev *dev, void *data)
>  	return 0;
>  }
>  
> +/** pci_walk_dev_affected - walk devices potentially AER affected
/**
 * pci_walk_dev_affected

There is a bit of a mixture in pci files between the two styles, but
I'm fairly sure kernel-doc is supposed to be as I'm suggesting
(I had this wrong due to cut and paste in earlier version!)

> + *  @dev      device which may be an RCEC with associated RCiEPs,
> + *            an RCiEP associated with an RCEC, or a Port.
> + *  @cb       callback to be called for each device found
> + *  @userdata arbitrary pointer to be passed to callback.
> + *
> + *  If the device provided is a port, walk the subordinate bus,
> + *  including any bridged devices on buses under this bus.
> + *  Call the provided callback on each device found.
> + *
> + *  If the device provided has no subordinate bus, call the provided
> + *  callback on the device itself.
> + *

I also had an ugly pointless newline here. oops :)

> + */
> +static void pci_walk_dev_affected(struct pci_dev *dev, int (*cb)(struct pci_dev *, void *),
> +				  void *userdata)
> +{
> +	if (dev->subordinate) {
> +		pci_walk_bus(dev->subordinate, cb, userdata);
> +	} else {
> +		cb(dev, userdata);
> +	}
> +}
> +
>  pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  			enum pci_channel_state state,
>  			pci_ers_result_t (*reset_link)(struct pci_dev *pdev))
>  {
>  	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
> -	struct pci_bus *bus;
>  
>  	/*
>  	 * Error recovery runs on all subordinates of the first downstream port.
>  	 * If the downstream port detected the error, it is cleared at the end.
> +	 * For RCiEPs we should reset just the RCiEP itself.
>  	 */
>  	if (!(pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> -	      pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM))
> +	      pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
> +	      pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END ||
> +	      pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC))
>  		dev = dev->bus->self;
> -	bus = dev->subordinate;
>  
>  	pci_dbg(dev, "broadcast error_detected message\n");
>  	if (state == pci_channel_io_frozen) {
> -		pci_walk_bus(bus, report_frozen_detected, &status);
> +		pci_walk_dev_affected(dev, report_frozen_detected, &status);
> +		if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END) {
> +			pci_warn(dev, "link reset not possible for RCiEP\n");
> +			status = PCI_ERS_RESULT_NONE;
> +			goto failed;
> +		}
> +
>  		status = reset_link(dev);
>  		if (status != PCI_ERS_RESULT_RECOVERED) {
>  			pci_warn(dev, "link reset failed\n");
>  			goto failed;
>  		}
>  	} else {
> -		pci_walk_bus(bus, report_normal_detected, &status);
> +		pci_walk_dev_affected(dev, report_normal_detected, &status);
>  	}
>  
>  	if (status == PCI_ERS_RESULT_CAN_RECOVER) {
>  		status = PCI_ERS_RESULT_RECOVERED;
>  		pci_dbg(dev, "broadcast mmio_enabled message\n");
> -		pci_walk_bus(bus, report_mmio_enabled, &status);
> +		pci_walk_dev_affected(dev, report_mmio_enabled, &status);
>  	}
>  
>  	if (status == PCI_ERS_RESULT_NEED_RESET) {
> @@ -188,17 +219,21 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  		 */
>  		status = PCI_ERS_RESULT_RECOVERED;
>  		pci_dbg(dev, "broadcast slot_reset message\n");
> -		pci_walk_bus(bus, report_slot_reset, &status);
> +		pci_walk_dev_affected(dev, report_slot_reset, &status);
>  	}
>  
>  	if (status != PCI_ERS_RESULT_RECOVERED)
>  		goto failed;
>  
>  	pci_dbg(dev, "broadcast resume message\n");
> -	pci_walk_bus(bus, report_resume, &status);
> +	pci_walk_dev_affected(dev, report_resume, &status);
>  
> -	pci_aer_clear_device_status(dev);
> -	pci_aer_clear_nonfatal_status(dev);
> +	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> +	     pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
> +	     pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)) {
> +		pci_aer_clear_device_status(dev);
> +		pci_aer_clear_nonfatal_status(dev);
> +	}
>  	pci_info(dev, "device recovery successful\n");
>  	return status;
>  



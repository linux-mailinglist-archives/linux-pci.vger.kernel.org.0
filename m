Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 739E823F507
	for <lists+linux-pci@lfdr.de>; Sat,  8 Aug 2020 00:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbgHGWxR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Aug 2020 18:53:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:58268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbgHGWxR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Aug 2020 18:53:17 -0400
Received: from localhost (130.sub-72-107-113.myvzw.com [72.107.113.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0491C20866;
        Fri,  7 Aug 2020 22:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596840796;
        bh=mjd4I6UIxWHXT6Qoh8/YMicEZ9FboUvw1K74+xrH7Tw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Gd34WugUs/6yfxod6L+Q756+93/0d6+XxCvaAZ9TfHbxOZNuHB8abyzXeZmZCc8b5
         2R0zr2o7V3Wzv0Y5Olh9B3P1Uwb4O5waZN8BIq3dRrBW5xnonwJyWsmE0Gq7ITZc0M
         HoDB1dYcEV8fxtm7UvIJiDc6ipR/A6nkWy/tPDqE=
Date:   Fri, 7 Aug 2020 17:53:14 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sean V Kelley <sean.v.kelley@intel.com>
Cc:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rjw@rjwysocki.net, ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 4/9] PCI/AER: Extend AER error handling to RCECs
Message-ID: <20200807225314.GA521346@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804194052.193272-5-sean.v.kelley@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 04, 2020 at 12:40:47PM -0700, Sean V Kelley wrote:
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

I don't see anything in the patch that mentions "firmware first." Do
we need it in the commit log?  After
https://git.kernel.org/linus/708b20003624 ("PCI/AER: Remove
HEST/FIRMWARE_FIRST parsing for AER ownership"), I think we no longer 
know anything about firmware-first in the kernel.

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

Maybe mention the new function name here?

Add "()" after function names in commit logs and comments so they
don't look like English words.

Wrap commit logs so they fit in 75 columns, so they don't wrap when
"git log" indents them in a default 80 column window.  Yes, I know I
could use wider windows, but I'd still want *some* default so commits
don't just have random widths.

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
>  drivers/pci/pcie/err.c | 59 +++++++++++++++++++++++++++++++++---------
>  1 file changed, 47 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index c543f419d8f9..682302dfb55b 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -146,38 +146,69 @@ static int report_resume(struct pci_dev *dev, void *data)
>  	return 0;
>  }
>  
> +/**
> + * pci_walk_dev_affected - walk devices potentially AER affected
> + * @dev      device which may be an RCEC with associated RCiEPs,
> + *           an RCiEP associated with an RCEC, or a Port.

Does this mean that if dev is an RCEC, we call the callback for the
*RCEC* itself?  I would have thought we'd want to do that for the
associated *RCiEPs*?

> + * @cb       callback to be called for each device found
> + * @userdata arbitrary pointer to be passed to callback.
> + *
> + * If the device provided is a port, walk the subordinate bus,

This usage of "port" doesn't seem quite right.  "Port" includes root
ports, switch upstream ports, switch downstream ports, *and* the
upstream ports on endpoints.  The endpoint upstream ports obviously
don't have subordinate buses.  We typically use "bridge" as the
generic term for something with a subordinate bus.

> + * including any bridged devices on buses under this bus.
> + * Call the provided callback on each device found.
> + *
> + * If the device provided has no subordinate bus, call the provided
> + * callback on the device itself.
> + */
> +static void pci_walk_dev_affected(struct pci_dev *dev, int (*cb)(struct pci_dev *, void *),

I don't understand the "affected" reference in the function name.
This doesn't test anything to see whether devices are "affected".
Naming is the hardest part of programming :)

> +				  void *userdata)
> +{
> +	if (dev->subordinate) {
> +		pci_walk_bus(dev->subordinate, cb, userdata);
> +	} else {
> +		cb(dev, userdata);
> +	}

Typical Linux style omits {} for single-line if/else branches.

> +}
> +
>  pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  			pci_channel_state_t state,
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

reset_link() might be misnamed.  IIUC "dev" is a bridge, and the point
is really to reset any devices below "dev."  Whether we do that by
resetting link, DPC trigger, secondary bus reset, FLR, etc, is sort of
immaterial.  Some of those methods might be applicable for RCiEPs.

But you didn't add that name; I'm just trying to understand this
better.

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
> @@ -188,18 +219,22 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
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
> -
> -	if (pcie_aer_is_native(dev))
> -		pcie_clear_device_status(dev);
> -	pci_aer_clear_nonfatal_status(dev);
> +	pci_walk_dev_affected(dev, report_resume, &status);
> +
> +	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> +	     pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
> +	     pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)) {
> +		if (pcie_aer_is_native(dev))
> +			pcie_clear_device_status(dev);
> +		pci_aer_clear_nonfatal_status(dev);

This change (testing pci_pcie_type()) looks like it's not strictly
related to the rest of this patch and maybe should be split out into
its own patch?

> +	}
>  	pci_info(dev, "device recovery successful\n");
>  	return status;
>  
> -- 
> 2.27.0
> 

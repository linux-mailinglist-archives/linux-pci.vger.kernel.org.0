Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7428280B3D
	for <lists+linux-pci@lfdr.de>; Fri,  2 Oct 2020 01:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733103AbgJAXOJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Oct 2020 19:14:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:55170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733012AbgJAXOJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Oct 2020 19:14:09 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B787206C1;
        Thu,  1 Oct 2020 23:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601594048;
        bh=hqUF91GLb9tSBXVkshwDq8qTQJUTbKw1ylzZoXJCt4k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=SgkpPd6kNPIAh6oECPKs6n6av/04S4i5vxsWufqvAloPsjqhNVRifXzcQ8NuoN2+b
         BlBuBOT8rzbfcikWygYQ9RxxpuyCsFZoN3HXAe2HlnLCsCczFDvxAMD78hRQe5emQq
         br3m4wY8/eA0M1d96L31u5UIDahb/0zUvNjY+hpc=
Date:   Thu, 1 Oct 2020 18:14:07 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sean V Kelley <seanvk.dev@oregontracks.org>
Cc:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: Re: [PATCH v7 07/13] PCI/AER: Extend AER error handling to RCECs
Message-ID: <20201001231407.GA2743007@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930215820.1113353-8-seanvk.dev@oregontracks.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 30, 2020 at 02:58:14PM -0700, Sean V Kelley wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Currently the kernel does not handle AER errors for Root Complex
> integrated End Points (RCiEPs)[0]. These devices sit on a root bus within
> the Root Complex (RC). AER handling is performed by a Root Complex Event
> Collector (RCEC) [1] which is a effectively a type of RCiEP on the same
> root bus.
> 
> For an RCEC (technically not a Bridge), error messages "received" from
> associated RCiEPs must be enabled for "transmission" in order to cause a
> System Error via the Root Control register or (when the Advanced Error
> Reporting Capability is present) reporting via the Root Error Command
> register and logging in the Root Error Status register and Error Source
> Identification register.
> 
> In addition to the defined OS level handling of the reset flow for the
> associated RCiEPs of an RCEC, it is possible to also have non-native
> handling. In that case there is no need to take any actions on the RCEC
> because the firmware is responsible for them. This is true where APEI [2]
> is used to report the AER errors via a GHES[v2] HEST entry [3] and
> relevant AER CPER record [4] and non-native handling is in use.
> 
> We effectively end up with two different types of discovery for
> purposes of handling AER errors:
> 
> 1) Normal bus walk - we pass the downstream port above a bus to which
> the device is attached and it walks everything below that point.
> 
> 2) An RCiEP with no visible association with an RCEC as there is no need
> to walk devices. In that case, the flow is to just call the callbacks for
> the actual device, which in turn references its associated RCEC.
> 
> A new walk function pci_walk_bridge(), similar to pci_walk_bus(),
> is provided that takes a pci_dev instead of a bus. If that bridge
> corresponds to a downstream port it will walk the subordinate bus of
> that bridge. If the device does not then it will call the function on
> that device alone.
> 
> [0] ACPI PCI Express Base Specification 5.0-1 1.3.2.3 Root Complex
> Integrated Endpoint Rules.
> [1] ACPI PCI Express Base Specification 5.0-1 6.2 Error Signalling and
> Logging
> [2] ACPI Specification 6.3 Chapter 18 ACPI Platform Error Interface (APEI)
> [3] ACPI Specification 6.3 18.2.3.7 Generic Hardware Error Source
> [4] UEFI Specification 2.8, N.2.7 PCI Express Error Section
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
> ---
>  drivers/pci/pcie/err.c | 52 +++++++++++++++++++++++++++++++++---------
>  1 file changed, 41 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 9e552330155b..c4ceca42a3bf 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -146,44 +146,73 @@ static int report_resume(struct pci_dev *dev, void *data)
>  	return 0;
>  }
>  
> +/**
> + * pci_walk_bridge - walk bridges potentially AER affected
> + * @bridge   bridge which may be an RCEC with associated RCiEPs,
> + *           an RCiEP associated with an RCEC, or a Port.
> + * @cb       callback to be called for each device found
> + * @userdata arbitrary pointer to be passed to callback.
> + *
> + * If the device provided is a bridge, walk the subordinate bus,
> + * including any bridged devices on buses under this bus.
> + * Call the provided callback on each device found.
> + *
> + * If the device provided has no subordinate bus, call the provided
> + * callback on the device itself.
> + */
> +static void pci_walk_bridge(struct pci_dev *bridge, int (*cb)(struct pci_dev *, void *),
> +			    void *userdata)
> +{
> +	if (bridge->subordinate)
> +		pci_walk_bus(bridge->subordinate, cb, userdata);
> +	else
> +		cb(bridge, userdata);
> +}
> +
>  pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  			pci_channel_state_t state,
>  			pci_ers_result_t (*reset_subordinate_devices)(struct pci_dev *pdev))
>  {
>  	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
> -	struct pci_bus *bus;
>  	struct pci_dev *bridge;
>  	int type;
>  
>  	/*
>  	 * Error recovery runs on all subordinates of the first downstream
>  	 * bridge. If the downstream bridge detected the error, it is
> -	 * cleared at the end.
> +	 * cleared at the end. For RCiEPs we should reset just the RCiEP itself.
>  	 */
>  	type = pci_pcie_type(dev);
>  	if (type == PCI_EXP_TYPE_ROOT_PORT ||
> -	    type == PCI_EXP_TYPE_DOWNSTREAM)
> +	    type == PCI_EXP_TYPE_DOWNSTREAM ||
> +	    type == PCI_EXP_TYPE_RC_EC ||
> +	    type == PCI_EXP_TYPE_RC_END)
>  		bridge = dev;
>  	else
>  		bridge = pci_upstream_bridge(dev);
>  
> -	bus = bridge->subordinate;
>  	pci_dbg(dev, "broadcast error_detected message\n");
>  	if (state == pci_channel_io_frozen) {
> -		pci_walk_bus(bus, report_frozen_detected, &status);
> -		status = reset_subordinate_device(dev);
> +		pci_walk_bridge(bridge, report_frozen_detected, &status);

Wonder if it would be worth splitting out the pci_walk_bus() to
pci_walk_bridge() change -- initially pci_walk_bridge() would do only
this:

  if (bridge->subordinate)
    pci_walk_bus(bridge->subordinate, cb, userdata);

so basically just rename it and move the bridge->subordinate
dereference out.

Then the next patch would be a lot smaller and would add the
!bridge->subordinate case (which I think is only for RC_EC & RC_END?)

> +		if (type == PCI_EXP_TYPE_RC_END) {
> +			pci_warn(dev, "subordinate device reset not possible for RCiEP\n");
> +			status = PCI_ERS_RESULT_NONE;
> +			goto failed;
> +		}
> +
> +		status = reset_subordinate_devices(bridge);

I missed the reason for this change:

  -		status = reset_subordinate_device(dev);
  +		status = reset_subordinate_devices(bridge);

>  		if (status != PCI_ERS_RESULT_RECOVERED) {
>  			pci_warn(dev, "subordinate device reset failed\n");
>  			goto failed;
>  		}
>  	} else {
> -		pci_walk_bus(bus, report_normal_detected, &status);
> +		pci_walk_bridge(bridge, report_normal_detected, &status);
>  	}
>  
>  	if (status == PCI_ERS_RESULT_CAN_RECOVER) {
>  		status = PCI_ERS_RESULT_RECOVERED;
>  		pci_dbg(dev, "broadcast mmio_enabled message\n");
> -		pci_walk_bus(bus, report_mmio_enabled, &status);
> +		pci_walk_bridge(bridge, report_mmio_enabled, &status);
>  	}
>  
>  	if (status == PCI_ERS_RESULT_NEED_RESET) {
> @@ -194,17 +223,18 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  		 */
>  		status = PCI_ERS_RESULT_RECOVERED;
>  		pci_dbg(dev, "broadcast slot_reset message\n");
> -		pci_walk_bus(bus, report_slot_reset, &status);
> +		pci_walk_bridge(bridge, report_slot_reset, &status);
>  	}
>  
>  	if (status != PCI_ERS_RESULT_RECOVERED)
>  		goto failed;
>  
>  	pci_dbg(dev, "broadcast resume message\n");
> -	pci_walk_bus(bus, report_resume, &status);
> +	pci_walk_bridge(bridge, report_resume, &status);
>  
>  	if (type == PCI_EXP_TYPE_ROOT_PORT ||
> -	    type == PCI_EXP_TYPE_DOWNSTREAM) {
> +	    type == PCI_EXP_TYPE_DOWNSTREAM ||
> +	    type == PCI_EXP_TYPE_RC_EC) {
>  		if (pcie_aer_is_native(bridge))
>  			pcie_clear_device_status(bridge);
>  		pci_aer_clear_nonfatal_status(bridge);
> -- 
> 2.28.0
> 

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFE2289A92
	for <lists+linux-pci@lfdr.de>; Fri,  9 Oct 2020 23:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391315AbgJIV1Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Oct 2020 17:27:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:38784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389123AbgJIV1Y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Oct 2020 17:27:24 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12A91215A4;
        Fri,  9 Oct 2020 21:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602278843;
        bh=NwIKZ+f6HMeX/oLRxsIlvognVA13GEfEwW6Ct7aIaqM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eW8l3AM7rf9hC2tqoamawjUHB+nTNgln6hqqfyORAUuj0HJlajVUPiI/NPQCDliBN
         XUwJqTSuvZzeknHQwG+6Qo5E6GxR9kO/Ojyf7hQlAxLGa+NpW8lJlD6knmEJpB5/3e
         6FQbj9v7VDJHAub0q/8241/9wgtTveA+AyX8UI4k=
Date:   Fri, 9 Oct 2020 16:27:21 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sean V Kelley <seanvk.dev@oregontracks.org>
Cc:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: Re: [PATCH v8 08/14] PCI/AER: Extend AER error handling to RCECs
Message-ID: <20201009212721.GA3503883@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002184735.1229220-9-seanvk.dev@oregontracks.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 02, 2020 at 11:47:29AM -0700, Sean V Kelley wrote:
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
> Modify pci_walk_bridge() to handle devices which lack a subordinate bus.
> If the device does not then it will call the function on that device
> alone.
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
>  drivers/pci/pcie/err.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 5ff1afa4763d..c4ceca42a3bf 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -148,19 +148,25 @@ static int report_resume(struct pci_dev *dev, void *data)
>  
>  /**
>   * pci_walk_bridge - walk bridges potentially AER affected
> - * @bridge   bridge which may be a Port.
> + * @bridge   bridge which may be an RCEC with associated RCiEPs,
> + *           an RCiEP associated with an RCEC, or a Port.
>   * @cb       callback to be called for each device found
>   * @userdata arbitrary pointer to be passed to callback.
>   *
>   * If the device provided is a bridge, walk the subordinate bus,
>   * including any bridged devices on buses under this bus.
>   * Call the provided callback on each device found.
> + *
> + * If the device provided has no subordinate bus, call the provided
> + * callback on the device itself.
>   */
>  static void pci_walk_bridge(struct pci_dev *bridge, int (*cb)(struct pci_dev *, void *),
>  			    void *userdata)
>  {
>  	if (bridge->subordinate)
>  		pci_walk_bus(bridge->subordinate, cb, userdata);
> +	else
> +		cb(bridge, userdata);
>  }
>  
>  pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
> @@ -174,11 +180,13 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
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

What is the case where an RCEC is passed to pcie_do_recovery()?  I
guess it's the case where an RCEC is reporting an error that it logged
itself, i.e., no RCiEP is involved at all?  In that case I guess we
should try an FLR on the RCEC and clear its status?

(I don't think the current series attempts the FLR.)

> +	    type == PCI_EXP_TYPE_RC_END)
>  		bridge = dev;
>  	else
>  		bridge = pci_upstream_bridge(dev);
> @@ -186,7 +194,13 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  	pci_dbg(dev, "broadcast error_detected message\n");
>  	if (state == pci_channel_io_frozen) {
>  		pci_walk_bridge(bridge, report_frozen_detected, &status);
> -		status = reset_subordinate_device(bridge);
> +		if (type == PCI_EXP_TYPE_RC_END) {
> +			pci_warn(dev, "subordinate device reset not possible for RCiEP\n");
> +			status = PCI_ERS_RESULT_NONE;
> +			goto failed;
> +		}
> +
> +		status = reset_subordinate_devices(bridge);
>  		if (status != PCI_ERS_RESULT_RECOVERED) {
>  			pci_warn(dev, "subordinate device reset failed\n");
>  			goto failed;
> @@ -219,7 +233,8 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  	pci_walk_bridge(bridge, report_resume, &status);
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

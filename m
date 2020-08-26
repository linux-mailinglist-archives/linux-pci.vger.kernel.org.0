Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18B072535F8
	for <lists+linux-pci@lfdr.de>; Wed, 26 Aug 2020 19:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgHZR0Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Aug 2020 13:26:16 -0400
Received: from mga09.intel.com ([134.134.136.24]:36965 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbgHZR0P (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Aug 2020 13:26:15 -0400
IronPort-SDR: X03etxTlp38VB8MggvimCd20cyvhm+jpnjwEBnpjK3MxcSi0Wf6zthqsDWahhRu+HmgEIWMzrM
 QHuRMo7hWEvg==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="157381172"
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="157381172"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 10:26:13 -0700
IronPort-SDR: lYRRwx8zJRH1GF/6F102nz9em3jKRJKNDZG+lyn44hPGCnH7NMhT07s+o3KcU+FwwdBYDGVUb9
 iphH3VAA8M8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="444126164"
Received: from yliang6-mobl1.ccr.corp.intel.com (HELO [10.254.84.68]) ([10.254.84.68])
  by orsmga004.jf.intel.com with ESMTP; 26 Aug 2020 10:26:12 -0700
Subject: Re: [PATCH v3 05/10] PCI/AER: Extend AER error handling to RCECs
To:     Sean V Kelley <sean.v.kelley@intel.com>, bhelgaas@google.com,
        Jonathan.Cameron@huawei.com, rjw@rjwysocki.net,
        ashok.raj@intel.com, tony.luck@intel.com, qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200812164659.1118946-1-sean.v.kelley@intel.com>
 <20200812164659.1118946-6-sean.v.kelley@intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <c235b1bb-4a2d-8959-d556-011620d5ae55@linux.intel.com>
Date:   Wed, 26 Aug 2020 10:26:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200812164659.1118946-6-sean.v.kelley@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/12/20 9:46 AM, Sean V Kelley wrote:
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
> the actual device.
> 
> A new walk function pci_walk_dev_affected(), similar to pci_bus_walk(),
> is provided that takes a pci_dev instead of a bus. If that dev corresponds
> to a downstream port it will walk the subordinate bus of that downstream
> port. If the dev does not then it will call the function on that device
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
>   drivers/pci/pcie/err.c | 54 ++++++++++++++++++++++++++++++++++--------
>   1 file changed, 44 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 14bb8f54723e..f4cfb37c26c1 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -146,38 +146,68 @@ static int report_resume(struct pci_dev *dev, void *data)
>   	return 0;
>   }
>   
> +/**
> + * pci_walk_dev_affected - walk devices potentially AER affected
> + * @dev      device which may be an RCEC with associated RCiEPs,
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
> +static void pci_walk_dev_affected(struct pci_dev *dev, int (*cb)(struct pci_dev *, void *),
> +				  void *userdata)
> +{
> +	if (dev->subordinate)
> +		pci_walk_bus(dev->subordinate, cb, userdata);
> +	else
> +		cb(dev, userdata);
> +}
> +
>   pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>   			enum pci_channel_state state,
>   			pci_ers_result_t (*reset_link)(struct pci_dev *pdev))
>   {
>   	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
> -	struct pci_bus *bus;
>   
>   	/*
>   	 * Error recovery runs on all subordinates of the first downstream port.
>   	 * If the downstream port detected the error, it is cleared at the end.
> +	 * For RCiEPs we should reset just the RCiEP itself.
>   	 */
>   	if (!(pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> -	      pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM))
> +	      pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
> +	      pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END ||
> +	      pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC))
>   		dev = dev->bus->self;
> -	bus = dev->subordinate;
>   
>   	pci_dbg(dev, "broadcast error_detected message\n");
>   	if (state == pci_channel_io_frozen) {
> -		pci_walk_bus(bus, report_frozen_detected, &status);
> +		pci_walk_dev_affected(dev, report_frozen_detected, &status);
> +		if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END) {
> +			pci_warn(dev, "link reset not possible for RCiEP\n");
> +			status = PCI_ERS_RESULT_NONE;
> +			goto failed;
reset_link is not applicable for RC_END, but why do you want to fail it?
> +		}
> +
>   		status = reset_link(dev);
>   		if (status != PCI_ERS_RESULT_RECOVERED) {
>   			pci_warn(dev, "link reset failed\n");
>   			goto failed;
>   		}
>   	} else {
> -		pci_walk_bus(bus, report_normal_detected, &status);
> +		pci_walk_dev_affected(dev, report_normal_detected, &status);
>   	}
>   
>   	if (status == PCI_ERS_RESULT_CAN_RECOVER) {
>   		status = PCI_ERS_RESULT_RECOVERED;
>   		pci_dbg(dev, "broadcast mmio_enabled message\n");
> -		pci_walk_bus(bus, report_mmio_enabled, &status);
> +		pci_walk_dev_affected(dev, report_mmio_enabled, &status);
>   	}
>   
>   	if (status == PCI_ERS_RESULT_NEED_RESET) {
> @@ -188,17 +218,21 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>   		 */
>   		status = PCI_ERS_RESULT_RECOVERED;
>   		pci_dbg(dev, "broadcast slot_reset message\n");
> -		pci_walk_bus(bus, report_slot_reset, &status);
> +		pci_walk_dev_affected(dev, report_slot_reset, &status);
>   	}
>   
>   	if (status != PCI_ERS_RESULT_RECOVERED)
>   		goto failed;
>   
>   	pci_dbg(dev, "broadcast resume message\n");
> -	pci_walk_bus(bus, report_resume, &status);
> +	pci_walk_dev_affected(dev, report_resume, &status);
>   
> -	pci_aer_clear_device_status(dev);
> -	pci_aer_clear_nonfatal_status(dev);
you want to prevent clearing status for RC_END ? Can you explain?
> +	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> +	     pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
> +	     pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)) {
> +		pci_aer_clear_device_status(dev);
> +		pci_aer_clear_nonfatal_status(dev);
> +	}
>   	pci_info(dev, "device recovery successful\n");
>   	return status;
>   
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E4C2B2799
	for <lists+linux-pci@lfdr.de>; Fri, 13 Nov 2020 22:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbgKMV67 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Nov 2020 16:58:59 -0500
Received: from mga09.intel.com ([134.134.136.24]:37631 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgKMV66 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Nov 2020 16:58:58 -0500
IronPort-SDR: VktBGymTB+01LhCxlE+YntDFhz5k/CIPZG1tU2d2LVESEb3ez2HUsZo3ZAjScGHt739N/NCGLp
 pxfSsnOQhhAA==
X-IronPort-AV: E=McAfee;i="6000,8403,9804"; a="170708427"
X-IronPort-AV: E=Sophos;i="5.77,476,1596524400"; 
   d="scan'208";a="170708427"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2020 13:58:57 -0800
IronPort-SDR: 7GIedGUUMHOxRhwMbuEkuuVVvmSeqxIqNe6yRE1UC0lMbaETe9XN+Q8bwHKmmMAiSZ8mHde6rZ
 4Tz4UBSnuuvw==
X-IronPort-AV: E=Sophos;i="5.77,476,1596524400"; 
   d="scan'208";a="355680466"
Received: from matownse-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.99.8])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2020 13:58:56 -0800
Subject: Re: [PATCH v8 1/2] PCI/ERR: Call pci_bus_reset() before calling
 ->slot_reset() callback
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, knsathya@kernel.org
References: <b464e4c8b3022ce3e0c69e64456619fc86378c15.1603740826.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <6374efd8-cac9-ef76-1854-32862d16a84d@linux.intel.com>
Date:   Fri, 13 Nov 2020 13:58:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b464e4c8b3022ce3e0c69e64456619fc86378c15.1603740826.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 10/26/20 12:37 PM, Kuppuswamy Sathyanarayanan wrote:
> Currently if report_error_detected() or report_mmio_enabled()
> functions requests PCI_ERS_RESULT_NEED_RESET, current
> pcie_do_recovery() implementation does not do the requested
> explicit device reset, but instead just calls the
> report_slot_reset() on all affected devices. Notifying about the
> reset via report_slot_reset() without doing the actual device
> reset is incorrect. So call pci_bus_reset() before triggering
> ->slot_reset() callback.
Any comments on this series?
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Sinan Kaya <okaya@kernel.org>
> Reviewed-by: Ashok Raj <ashok.raj@intel.com>
> ---
>   Changes since v7:
>    * Rebased on top of v5.10-rc1.
> 
>   Changes since v6:
>    * None.
> 
>   Changes since v5:
>    * Added Ashok's Reviewed-by tag.
> 
>   Changes since v4:
>    * Added check for pci_reset_bus() return value.
> 
>   drivers/pci/pcie/err.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index c543f419d8f9..315a4d559c4c 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -152,6 +152,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>   {
>   	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
>   	struct pci_bus *bus;
> +	int ret;
>   
>   	/*
>   	 * Error recovery runs on all subordinates of the first downstream port.
> @@ -181,11 +182,12 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>   	}
>   
>   	if (status == PCI_ERS_RESULT_NEED_RESET) {
> -		/*
> -		 * TODO: Should call platform-specific
> -		 * functions to reset slot before calling
> -		 * drivers' slot_reset callbacks?
> -		 */
> +		ret = pci_reset_bus(dev);
> +		if (ret < 0) {
> +			pci_err(dev, "Failed to reset %d\n", ret);
> +			status = PCI_ERS_RESULT_DISCONNECT;
> +			goto failed;
> +		}
>   		status = PCI_ERS_RESULT_RECOVERED;
>   		pci_dbg(dev, "broadcast slot_reset message\n");
>   		pci_walk_bus(bus, report_slot_reset, &status);
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

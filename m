Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA71D28C3C4
	for <lists+linux-pci@lfdr.de>; Mon, 12 Oct 2020 23:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730845AbgJLVFY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Oct 2020 17:05:24 -0400
Received: from mga09.intel.com ([134.134.136.24]:36633 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729366AbgJLVFY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Oct 2020 17:05:24 -0400
IronPort-SDR: EgjpjWzFDE1nt5bSfVRt3jeibG0fMCjUCPP9GTXZmMJwWhKNeeob/0wwMuA/oq2kWv/KpC2fku
 cOD0sVHwzqbQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="165916815"
X-IronPort-AV: E=Sophos;i="5.77,368,1596524400"; 
   d="scan'208";a="165916815"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 14:05:23 -0700
IronPort-SDR: tl18dfCNh77rDtbSe15IjWECAv5xjENNuRSZYXqTINQRazyM5o6iN3KRpOuz6ze7e16cupjpBI
 wmsDyZLv0OQw==
X-IronPort-AV: E=Sophos;i="5.77,368,1596524400"; 
   d="scan'208";a="530119031"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 14:05:23 -0700
Date:   Mon, 12 Oct 2020 14:05:22 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     sathyanarayanan.nkuppuswamy@gmail.com
Cc:     bhelgaas@google.com, okaya@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v4 1/2] PCI/ERR: Call pci_bus_reset() before calling
 ->slot_reset() callback
Message-ID: <20201012210522.GA86612@otc-nc-03>
References: <5c5bca0bdb958e456176fe6ede10ba8f838fbafc.1602263264.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c5bca0bdb958e456176fe6ede10ba8f838fbafc.1602263264.git.sathyanarayanan.kuppuswamy@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Oct 11, 2020 at 10:03:40PM -0700, sathyanarayanan.nkuppuswamy@gmail.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Currently if report_error_detected() or report_mmio_enabled()
> functions requests PCI_ERS_RESULT_NEED_RESET, current
> pcie_do_recovery() implementation does not do the requested
> explicit device reset, but instead just calls the
> report_slot_reset() on all affected devices. Notifying about the
> reset via report_slot_reset() without doing the actual device
> reset is incorrect. So call pci_bus_reset() before triggering
> ->slot_reset() callback.
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  drivers/pci/pcie/err.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index c543f419d8f9..067c58728b88 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -181,11 +181,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  	}
>  
>  	if (status == PCI_ERS_RESULT_NEED_RESET) {
> -		/*
> -		 * TODO: Should call platform-specific
> -		 * functions to reset slot before calling
> -		 * drivers' slot_reset callbacks?
> -		 */
> +		pci_reset_bus(dev);

pci_reset_bus() returns an error, do you need to consult that before
unconditionally setting PCI_ERS_RESULT_RECOVERED?

>  		status = PCI_ERS_RESULT_RECOVERED;
>  		pci_dbg(dev, "broadcast slot_reset message\n");
>  		pci_walk_bus(bus, report_slot_reset, &status);
> -- 
> 2.17.1
> 

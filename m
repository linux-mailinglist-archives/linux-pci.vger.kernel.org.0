Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F85C2880CB
	for <lists+linux-pci@lfdr.de>; Fri,  9 Oct 2020 05:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbgJIDqW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Oct 2020 23:46:22 -0400
Received: from mga07.intel.com ([134.134.136.100]:45009 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbgJIDqW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Oct 2020 23:46:22 -0400
IronPort-SDR: sAH5wkdwKvr49s5rBqK+N47Gs7teTsZQv2Ysu2OoOOWqtREX4XJUAXbtJpAOuaTbHvOzwffp0N
 tUIkBt2RirGg==
X-IronPort-AV: E=McAfee;i="6000,8403,9768"; a="229624589"
X-IronPort-AV: E=Sophos;i="5.77,353,1596524400"; 
   d="scan'208";a="229624589"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2020 20:46:20 -0700
IronPort-SDR: FpjiBfNdoN7koPf8fXg6fDEgVMPctALFUvERJN1oVb0s+aBw6dMeqtgXHkOelCOvEep486C0DU
 HCiG3AAiwEwA==
X-IronPort-AV: E=Sophos;i="5.77,353,1596524400"; 
   d="scan'208";a="462045333"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2020 20:46:20 -0700
Date:   Thu, 8 Oct 2020 20:46:14 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Hedi Berriche <hedi.berriche@hpe.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Russ Anderson <rja@hpe.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <keith.busch@intel.com>,
        Joerg Roedel <jroedel@suse.com>, stable@kernel.org,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v1 1/1] PCI/ERR: don't clobber status after reset_link()
Message-ID: <20201009034614.GB60852@otc-nc-03>
References: <20201009025251.2360659-1-hedi.berriche@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009025251.2360659-1-hedi.berriche@hpe.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 09, 2020 at 03:52:51AM +0100, Hedi Berriche wrote:
> Commit 6d2c89441571 ("PCI/ERR: Update error status after reset_link()")
> changed pcie_do_recovery() so that status is updated with the return
> value from reset_link(); this was to fix the problem where we would
> wrongly report recovery failure, despite a successful reset_link(),
> whenever the initial error status is PCI_ERS_RESULT_DISCONNECT or
> PCI_ERS_RESULT_NO_AER_DRIVER.
> 
> Unfortunately this breaks the flow of pcie_do_recovery() as it prevents

What is the reference to "this breaks" above?  

> the actions needed when the initial error is PCI_ERS_RESULT_CAN_RECOVER
> or PCI_ERS_RESULT_NEED_RESET from taking place which causes error
> recovery to fail.
> 
> Don't clobber status after reset_link() to restore the intended flow in
> pcie_do_recovery().
> 
> Fix the original problem by saving the return value from reset_link()
> and use it later on to decide whether error recovery should be deemed
> successful in the scenarios where the initial error status is
> PCI_ERS_RESULT_{DISCONNECT,NO_AER_DRIVER}.

I would rather rephrase the above to make it clear what is being proposed.
Since the description seems to talk about the old problem and new solution
all mixed up.

> 
> Fixes: 6d2c89441571 ("PCI/ERR: Update error status after reset_link()")
> Signed-off-by: Hedi Berriche <hedi.berriche@hpe.com>
> Cc: Russ Anderson <rja@hpe.com>
> Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: Joerg Roedel <jroedel@suse.com>
> 
> Cc: stable@kernel.org # v5.7+
> ---
>  drivers/pci/pcie/err.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index c543f419d8f9..dbd0b56bd6c1 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -150,7 +150,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  			pci_channel_state_t state,
>  			pci_ers_result_t (*reset_link)(struct pci_dev *pdev))
>  {
> -	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
> +	pci_ers_result_t post_reset_status, status = PCI_ERS_RESULT_CAN_RECOVER;

why call it post_reset_status? 

>  	struct pci_bus *bus;
>  
>  	/*
> @@ -165,8 +165,8 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  	pci_dbg(dev, "broadcast error_detected message\n");
>  	if (state == pci_channel_io_frozen) {
>  		pci_walk_bus(bus, report_frozen_detected, &status);
> -		status = reset_link(dev);
> -		if (status != PCI_ERS_RESULT_RECOVERED) {
> +		post_reset_status = reset_link(dev);
> +		if (post_reset_status != PCI_ERS_RESULT_RECOVERED) {
>  			pci_warn(dev, "link reset failed\n");
>  			goto failed;
>  		}
> @@ -174,6 +174,13 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  		pci_walk_bus(bus, report_normal_detected, &status);
>  	}
>  
> +	if ((status == PCI_ERS_RESULT_DISCONNECT ||
> +	     status == PCI_ERS_RESULT_NO_AER_DRIVER) &&
> +	     post_reset_status == PCI_ERS_RESULT_RECOVERED) {
> +		/* error recovery succeeded thanks to reset_link() */
> +		status = PCI_ERS_RESULT_RECOVERED;
> +	}
> +
>  	if (status == PCI_ERS_RESULT_CAN_RECOVER) {
>  		status = PCI_ERS_RESULT_RECOVERED;
>  		pci_dbg(dev, "broadcast mmio_enabled message\n");
> -- 
> 2.28.0
> 

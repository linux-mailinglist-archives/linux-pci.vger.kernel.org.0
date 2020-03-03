Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32902177CC1
	for <lists+linux-pci@lfdr.de>; Tue,  3 Mar 2020 18:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730534AbgCCREo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Mar 2020 12:04:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:58510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729000AbgCCREo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Mar 2020 12:04:44 -0500
Received: from localhost (odyssey.drury.edu [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4203D20836;
        Tue,  3 Mar 2020 17:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583255083;
        bh=bk85Xz7NknJrsTjKyhov1Bic6DhuQc8uI72oheQ6XTo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qNCb/zCik+KlUt63trn4jH/HOKpvdCE0AYNJTPur9ziG9LAGwYOv73I5VIFmF/7JB
         ZPj90kUy1w8igSGgUR6q7Rm7LT8wQzr+IOxG6YOa4of9kqMYaQDpcYl6ccbs12k2uT
         GCmC54BnsdxA3oveFfm/0R/btd6caA/zk3wSzX7E=
Date:   Tue, 3 Mar 2020 11:04:42 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com
Subject: Re: [PATCH v16 3/9] PCI/ERR: Remove service dependency in
 pcie_do_recovery()
Message-ID: <20200303170442.GA89997@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152c530a3ca8780ae85c2325f97f5f35f5d3602f.1582850766.git.sathyanarayanan.kuppuswamy@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 27, 2020 at 04:59:45PM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Currently we pass PCIe service type parameter to pcie_do_recovery()
> function which was in-turn used by reset_link() function to identify
> the underlying pci_port_service_driver and then initiate the driver
> specific reset_link call. Instead of using this roundabout way, we
> can just pass the driver specific reset_link callback function when
> calling pcie_do_recovery() function.

I love this!  And I think pcie_port_find_service() is now unused.  I
can add a patch to remove it.

> This change will also enable non PCIe service driver to call
> pcie_do_recovery() function. This is required for adding Error
> Disconnect Recover (EDR) support.
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  drivers/pci/pci.h      |  2 +-
>  drivers/pci/pcie/aer.c | 11 +++++------
>  drivers/pci/pcie/dpc.c |  2 +-
>  drivers/pci/pcie/err.c | 16 ++++++++--------
>  4 files changed, 15 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index a4c360515a69..2962200bfe35 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -548,7 +548,7 @@ static inline int pci_dev_specific_disable_acs_redir(struct pci_dev *dev)
>  
>  /* PCI error reporting and recovery */
>  void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
> -		      u32 service);
> +		      pci_ers_result_t (*reset_cb)(struct pci_dev *pdev));
>  
>  bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
>  #ifdef CONFIG_PCIEASPM
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 4a818b07a1af..1235eca0a2e6 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -102,6 +102,7 @@ struct aer_stats {
>  #define ERR_UNCOR_ID(d)			(d >> 16)
>  
>  static int pcie_aer_disable;
> +static pci_ers_result_t aer_root_reset(struct pci_dev *dev);
>  
>  void pci_no_aer(void)
>  {
> @@ -1053,11 +1054,9 @@ static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
>  					info->status);
>  		pci_aer_clear_device_status(dev);
>  	} else if (info->severity == AER_NONFATAL)
> -		pcie_do_recovery(dev, pci_channel_io_normal,
> -				 PCIE_PORT_SERVICE_AER);
> +		pcie_do_recovery(dev, pci_channel_io_normal, aer_root_reset);
>  	else if (info->severity == AER_FATAL)
> -		pcie_do_recovery(dev, pci_channel_io_frozen,
> -				 PCIE_PORT_SERVICE_AER);
> +		pcie_do_recovery(dev, pci_channel_io_frozen, aer_root_reset);
>  	pci_dev_put(dev);
>  }
>  
> @@ -1094,10 +1093,10 @@ static void aer_recover_work_func(struct work_struct *work)
>  		cper_print_aer(pdev, entry.severity, entry.regs);
>  		if (entry.severity == AER_NONFATAL)
>  			pcie_do_recovery(pdev, pci_channel_io_normal,
> -					 PCIE_PORT_SERVICE_AER);
> +					 aer_root_reset);
>  		else if (entry.severity == AER_FATAL)
>  			pcie_do_recovery(pdev, pci_channel_io_frozen,
> -					 PCIE_PORT_SERVICE_AER);
> +					 aer_root_reset);
>  		pci_dev_put(pdev);
>  	}
>  }
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 6b116d7fdb89..114358d62ddf 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -227,7 +227,7 @@ static irqreturn_t dpc_handler(int irq, void *context)
>  	}
>  
>  	/* We configure DPC so it only triggers on ERR_FATAL */
> -	pcie_do_recovery(pdev, pci_channel_io_frozen, PCIE_PORT_SERVICE_DPC);
> +	pcie_do_recovery(pdev, pci_channel_io_frozen, dpc_reset_link);
>  
>  	return IRQ_HANDLED;
>  }
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index eefefe03857a..05f87bc9d011 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -162,14 +162,13 @@ static pci_ers_result_t default_reset_link(struct pci_dev *dev)
>  	return rc ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED;
>  }
>  
> -static pci_ers_result_t reset_link(struct pci_dev *dev, u32 service)
> +static pci_ers_result_t reset_link(struct pci_dev *dev,
> +			pci_ers_result_t (*reset_cb)(struct pci_dev *pdev))
>  {
>  	pci_ers_result_t status;
> -	struct pcie_port_service_driver *driver = NULL;
>  
> -	driver = pcie_port_find_service(dev, service);
> -	if (driver && driver->reset_link) {
> -		status = driver->reset_link(dev);
> +	if (reset_cb) {
> +		status = reset_cb(dev);
>  	} else if (pcie_downstream_port(dev)) {
>  		status = default_reset_link(dev);
>  	} else {
> @@ -187,8 +186,9 @@ static pci_ers_result_t reset_link(struct pci_dev *dev, u32 service)
>  	return status;
>  }
>  
> -void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
> -		      u32 service)
> +void pcie_do_recovery(struct pci_dev *dev,
> +		      enum pci_channel_state state,
> +		      pci_ers_result_t (*reset_cb)(struct pci_dev *pdev))
>  {
>  	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
>  	struct pci_bus *bus;
> @@ -209,7 +209,7 @@ void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
>  		pci_walk_bus(bus, report_normal_detected, &status);
>  
>  	if (state == pci_channel_io_frozen) {
> -		status = reset_link(dev, service);
> +		status = reset_link(dev, reset_cb);
>  		if (status != PCI_ERS_RESULT_RECOVERED)
>  			goto failed;
>  	}
> -- 
> 2.21.0
> 

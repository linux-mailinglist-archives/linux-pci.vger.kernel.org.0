Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A16C28D114
	for <lists+linux-pci@lfdr.de>; Tue, 13 Oct 2020 17:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389109AbgJMPRv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Oct 2020 11:17:51 -0400
Received: from mga03.intel.com ([134.134.136.65]:22096 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389037AbgJMPRv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Oct 2020 11:17:51 -0400
IronPort-SDR: PrSCs7HYohF4d9oOmM3uLatoLugUo8bz4lsAVhIbQ77iPRJKoA7mrw0E/Qgqt+ojkcdEoZDs4/
 Bkruz6/mOf1A==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="165989357"
X-IronPort-AV: E=Sophos;i="5.77,371,1596524400"; 
   d="scan'208";a="165989357"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 08:17:42 -0700
IronPort-SDR: 044zPLbuBIIVUjmTdo4U7fsFwqakc35cG93d95yavvLXDtSSf9SRzswDKJAKHbpsD7y5Pt6T88
 mQ+5UBfolmxA==
X-IronPort-AV: E=Sophos;i="5.77,371,1596524400"; 
   d="scan'208";a="530429894"
Received: from isgomez-mobl.amr.corp.intel.com (HELO [10.252.133.97]) ([10.252.133.97])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 08:17:42 -0700
Subject: Re: [PATCH v4 2/2] PCI/ERR: Split the fatal and non-fatal error
 recovery handling
To:     Christoph Hellwig <hch@infradead.org>,
        sathyanarayanan.nkuppuswamy@gmail.com
Cc:     bhelgaas@google.com, okaya@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com
References: <5c5bca0bdb958e456176fe6ede10ba8f838fbafc.1602263264.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <c6e3f1168d5d88b207b59c434792a10a7331bb89.1602263264.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20201013115600.GA11976@infradead.org>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <2fa2e5ed-dbfb-f335-5429-8bbb13f004e2@linux.intel.com>
Date:   Tue, 13 Oct 2020 08:17:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201013115600.GA11976@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/13/20 4:56 AM, Christoph Hellwig wrote:
> You might want to split out pcie_do_fatal_recovery and get rid of the
> state argument:
This is how it was before Keith merged fatal and non-fatal error recovery
paths. When the comparison is between additional-parameter vs new-interface
, I choose the former. But I can merge your change in next version.

> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index fa12f7cbc1a095..eec0d3fe9fd967 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -556,7 +556,8 @@ static inline int pci_dev_specific_disable_acs_redir(struct pci_dev *dev)
>   
>   /* PCI error reporting and recovery */
>   pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
> -			pci_channel_state_t state,
> +			pci_ers_result_t (*reset_link)(struct pci_dev *pdev));
> +pci_ers_result_t pcie_do_fatal_recovery(struct pci_dev *dev,
>   			pci_ers_result_t (*reset_link)(struct pci_dev *pdev));
>   
>   bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 65dff5f3457ac0..4bf7ebb34cf854 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -947,9 +947,9 @@ static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
>   		if (pcie_aer_is_native(dev))
>   			pcie_clear_device_status(dev);
>   	} else if (info->severity == AER_NONFATAL)
> -		pcie_do_recovery(dev, pci_channel_io_normal, aer_root_reset);
> +		pcie_do_recovery(dev, aer_root_reset);
>   	else if (info->severity == AER_FATAL)
> -		pcie_do_recovery(dev, pci_channel_io_frozen, aer_root_reset);
> +		pcie_do_fatal_recovery(dev, aer_root_reset);
>   	pci_dev_put(dev);
>   }
>   
> @@ -985,11 +985,9 @@ static void aer_recover_work_func(struct work_struct *work)
>   		}
>   		cper_print_aer(pdev, entry.severity, entry.regs);
>   		if (entry.severity == AER_NONFATAL)
> -			pcie_do_recovery(pdev, pci_channel_io_normal,
> -					 aer_root_reset);
> +			pcie_do_recovery(pdev, aer_root_reset);
>   		else if (entry.severity == AER_FATAL)
> -			pcie_do_recovery(pdev, pci_channel_io_frozen,
> -					 aer_root_reset);
> +			pcie_do_fatal_recovery(pdev, aer_root_reset);
>   		pci_dev_put(pdev);
>   	}
>   }
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index daa9a4153776ce..74e7d1da3cf054 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -233,7 +233,7 @@ static irqreturn_t dpc_handler(int irq, void *context)
>   	dpc_process_error(pdev);
>   
>   	/* We configure DPC so it only triggers on ERR_FATAL */
> -	pcie_do_recovery(pdev, pci_channel_io_frozen, dpc_reset_link);
> +	pcie_do_fatal_recovery(pdev, dpc_reset_link);
>   
>   	return IRQ_HANDLED;
>   }
> diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
> index a6b9b479b97ad0..87379bc566f691 100644
> --- a/drivers/pci/pcie/edr.c
> +++ b/drivers/pci/pcie/edr.c
> @@ -183,7 +183,7 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
>   	 * or ERR_NONFATAL, since the link is already down, use the FATAL
>   	 * error recovery path for both cases.
>   	 */
> -	estate = pcie_do_recovery(edev, pci_channel_io_frozen, dpc_reset_link);
> +	estate = pcie_do_fatal_recovery(edev, dpc_reset_link);
>   
>   send_ost:
>   
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index c2ae4d08801a4d..11fcff16b17303 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -141,7 +141,7 @@ static int report_resume(struct pci_dev *dev, void *data)
>   	return 0;
>   }
>   
> -static pci_ers_result_t pcie_do_fatal_recovery(struct pci_dev *dev,
> +pci_ers_result_t pcie_do_fatal_recovery(struct pci_dev *dev,
>   			pci_ers_result_t (*reset_link)(struct pci_dev *pdev))
>   {
>   	struct pci_dev *udev;
> @@ -194,15 +194,11 @@ static pci_ers_result_t pcie_do_fatal_recovery(struct pci_dev *dev,
>   }
>   
>   pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
> -			pci_channel_state_t state,
>   			pci_ers_result_t (*reset_link)(struct pci_dev *pdev))
>   {
>   	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
>   	struct pci_bus *bus;
>   
> -	if (state == pci_channel_io_frozen)
> -		return pcie_do_fatal_recovery(dev, reset_link);
> -
>   	/*
>   	 * Error recovery runs on all subordinates of the first downstream port.
>   	 * If the downstream port detected the error, it is cleared at the end.
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

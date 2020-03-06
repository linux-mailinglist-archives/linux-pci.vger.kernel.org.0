Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F20D17B67F
	for <lists+linux-pci@lfdr.de>; Fri,  6 Mar 2020 06:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725829AbgCFFps (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Mar 2020 00:45:48 -0500
Received: from mga11.intel.com ([192.55.52.93]:31837 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbgCFFpr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Mar 2020 00:45:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 21:45:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,520,1574150400"; 
   d="scan'208";a="241074142"
Received: from skuppusw-mobl5.amr.corp.intel.com (HELO [10.252.200.198]) ([10.252.200.198])
  by orsmga003.jf.intel.com with ESMTP; 05 Mar 2020 21:45:46 -0800
Subject: Re: [PATCH v17 09/12] PCI/AER: Allow clearing Error Status Register
 in FF mode
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com
References: <cover.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <29fb514a0d86e9bcc75cec4ea8474cd4db33adbf.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <9e4a1632-9425-9fb6-fd1a-d7cee4e9b684@linux.intel.com>
Date:   Thu, 5 Mar 2020 21:45:46 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <29fb514a0d86e9bcc75cec4ea8474cd4db33adbf.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 3/3/2020 6:36 PM, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> As per PCI firmware specification r3.2 System Firmware Intermediary
> (SFI) _OSC and DPC Updates ECR
> (https://members.pcisig.com/wg/PCI-SIG/document/13563), sec titled "DPC
> Event Handling Implementation Note", page 10, Error Disconnect Recover
> (EDR) support allows OS to handle error recovery and clearing Error
> Registers even in FF mode. So create new API pci_aer_raw_clear_status()
> which allows clearing AER registers without FF mode checks.
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>   drivers/pci/pci.h      |  2 ++
>   drivers/pci/pcie/aer.c | 22 ++++++++++++++++++----
>   2 files changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index e57e78b619f8..c239e6dd2542 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -655,6 +655,7 @@ extern const struct attribute_group aer_stats_attr_group;
>   void pci_aer_clear_fatal_status(struct pci_dev *dev);
>   void pci_aer_clear_device_status(struct pci_dev *dev);
>   int pci_cleanup_aer_error_status_regs(struct pci_dev *dev);
> +int pci_aer_raw_clear_status(struct pci_dev *dev);
>   #else
>   static inline void pci_no_aer(void) { }
>   static inline void pci_aer_init(struct pci_dev *d) { }
> @@ -665,6 +666,7 @@ static inline int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
>   {
>   	return -EINVAL;
>   }
> +int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL; }
Its missing static specifier. It needs to be fixed. I can fix it in next 
version.
Bjorn, if there is no need for next version, can you please make this 
change ?
>   #endif
>   
>   #ifdef CONFIG_ACPI
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index c0540c3761dc..41afefa562b7 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -420,7 +420,16 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
>   		pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, status);
>   }
>   
> -int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
> +/**
> + * pci_aer_raw_clear_status - Clear AER error registers.
> + * @dev: the PCI device
> + *
> + * NOTE: Allows clearing error registers in both FF and
> + * non FF modes.
> + *
> + * Returns 0 on success, or negative on failure.
> + */
> +int pci_aer_raw_clear_status(struct pci_dev *dev)
>   {
>   	int pos;
>   	u32 status;
> @@ -433,9 +442,6 @@ int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
>   	if (!pos)
>   		return -EIO;
>   
> -	if (pcie_aer_get_firmware_first(dev))
> -		return -EIO;
> -
>   	port_type = pci_pcie_type(dev);
>   	if (port_type == PCI_EXP_TYPE_ROOT_PORT) {
>   		pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, &status);
> @@ -451,6 +457,14 @@ int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
>   	return 0;
>   }
>   
> +int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
> +{
> +	if (pcie_aer_get_firmware_first(dev))
> +		return -EIO;
> +
> +	return pci_aer_raw_clear_status(dev);
> +}
> +
>   void pci_save_aer_state(struct pci_dev *dev)
>   {
>   	struct pci_cap_saved_state *save_state;
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

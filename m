Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99F7B8529B
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2019 20:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389140AbfHGSDt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Aug 2019 14:03:49 -0400
Received: from mga06.intel.com ([134.134.136.31]:41993 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388615AbfHGSDs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Aug 2019 14:03:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2019 11:03:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,358,1559545200"; 
   d="scan'208";a="198748655"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 07 Aug 2019 11:03:46 -0700
Received: from [10.54.74.33] (skuppusw-desk.jf.intel.com [10.54.74.33])
        by linux.intel.com (Postfix) with ESMTP id EFD7058046E;
        Wed,  7 Aug 2019 11:03:46 -0700 (PDT)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v2] PCI/AER: Save and restore AER config state
To:     "Patel, Mayurkumar" <mayurkumar.patel@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc:     "Busch, Keith" <keith.busch@intel.com>,
        'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>
References: <92EBB4272BF81E4089A7126EC1E7B28479A895C7@IRSMSX101.ger.corp.intel.com>
From:   sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <f7fb5aa1-a6dc-fe1a-9abf-ac2f99a945b3@linux.intel.com>
Date:   Wed, 7 Aug 2019 11:01:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <92EBB4272BF81E4089A7126EC1E7B28479A895C7@IRSMSX101.ger.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 8/7/19 9:03 AM, Patel, Mayurkumar wrote:
> This patch provides AER config save and restore capabilities. After system
> resume AER config registers settings are lost. Not restoring AER root error
> command register bits on root port if they were set, disables generation
> of an AER interrupt reported by function as described in PCIe spec r4.0,
> sec 7.8.4.9. Moreover, AER config mask, severity and ECRC registers are
> also required to maintain same state prior to system suspend to maintain
> AER interrupts behavior.
Looks good to me
>
> Signed-off-by: Mayurkumar Patel <mayurkumar.patel@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>   drivers/pci/pci.c      |  2 ++
>   drivers/pci/pcie/aer.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   include/linux/aer.h    |  4 +++
>   3 files changed, 76 insertions(+)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8abc843..40d5507 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1340,6 +1340,7 @@ int pci_save_state(struct pci_dev *dev)
>   
>   	pci_save_ltr_state(dev);
>   	pci_save_dpc_state(dev);
> +	pci_save_aer_state(dev);
>   	return pci_save_vc_state(dev);
>   }
>   EXPORT_SYMBOL(pci_save_state);
> @@ -1453,6 +1454,7 @@ void pci_restore_state(struct pci_dev *dev)
>   	pci_restore_dpc_state(dev);
>   
>   	pci_cleanup_aer_error_status_regs(dev);
> +	pci_restore_aer_state(dev);
>   
>   	pci_restore_config_space(dev);
>   
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index b45bc47..fb067dc 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -448,6 +448,64 @@ int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
>   	return 0;
>   }
>   
> +static inline bool pcie_aer_cap_has_root_command(struct pci_dev *dev)
> +{
> +	return pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> +		pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC;
> +}
> +
> +void pci_save_aer_state(struct pci_dev *dev)
> +{
> +	struct pci_cap_saved_state *save_state;
> +	u32 *cap;
> +	int pos;
> +
> +	if (!pci_is_pcie(dev))
> +		return;
> +
> +	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_ERR);
> +	if (!save_state)
> +		return;
> +
> +	pos = dev->aer_cap;
> +	if (!pos)
> +		return;
> +
> +	cap = &save_state->cap.data[0];
> +	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, cap++);
> +	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, cap++);
> +	pci_read_config_dword(dev, pos + PCI_ERR_COR_MASK, cap++);
> +	pci_read_config_dword(dev, pos + PCI_ERR_CAP, cap++);
> +	if (pcie_aer_cap_has_root_command(dev))
> +		pci_read_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, cap++);
> +}
> +
> +void pci_restore_aer_state(struct pci_dev *dev)
> +{
> +	struct pci_cap_saved_state *save_state;
> +	u32 *cap;
> +	int pos;
> +
> +	if (!pci_is_pcie(dev))
> +		return;
> +
> +	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_ERR);
> +	if (!save_state)
> +		return;
> +
> +	pos = dev->aer_cap;
> +	if (!pos)
> +		return;
> +
> +	cap = &save_state->cap.data[0];
> +	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, *cap++);
> +	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, *cap++);
> +	pci_write_config_dword(dev, pos + PCI_ERR_COR_MASK, *cap++);
> +	pci_write_config_dword(dev, pos + PCI_ERR_CAP, *cap++);
> +	if (pcie_aer_cap_has_root_command(dev))
> +		pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, *cap++);
> +}
> +
>   void pci_aer_init(struct pci_dev *dev)
>   {
>   	dev->aer_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
> @@ -455,6 +513,18 @@ void pci_aer_init(struct pci_dev *dev)
>   	if (dev->aer_cap)
>   		dev->aer_stats = kzalloc(sizeof(struct aer_stats), GFP_KERNEL);
>   
> +	/*
> +	 * Since PCI_ERR_ROOT_COMMAND is only valid for root port and root
> +	 * complex event collector, as per PCIe 4.0 section 7.8.4, interpret
> +	 * the device/port type to determine the availability of additional
> +	 * root port and root complex event collector register.
> +	 */
> +	if (pcie_aer_cap_has_root_command(dev))
> +		pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_ERR,
> +					sizeof(u32) * 5);
> +	else
> +		pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_ERR,
> +					sizeof(u32) * 4);
>   	pci_cleanup_aer_error_status_regs(dev);
>   }
>   
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 514bffa..fa19e01 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -46,6 +46,8 @@ int pci_enable_pcie_error_reporting(struct pci_dev *dev);
>   int pci_disable_pcie_error_reporting(struct pci_dev *dev);
>   int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev);
>   int pci_cleanup_aer_error_status_regs(struct pci_dev *dev);
> +void pci_save_aer_state(struct pci_dev *dev);
> +void pci_restore_aer_state(struct pci_dev *dev);
>   #else
>   static inline int pci_enable_pcie_error_reporting(struct pci_dev *dev)
>   {
> @@ -63,6 +65,8 @@ static inline int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
>   {
>   	return -EINVAL;
>   }
> +static inline void pci_save_aer_state(struct pci_dev *dev) {}
> +static inline void pci_restore_aer_state(struct pci_dev *dev) {}
>   #endif
>   
>   void cper_print_aer(struct pci_dev *dev, int aer_severity,

-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer


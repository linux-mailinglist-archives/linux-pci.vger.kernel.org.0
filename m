Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2065163B22
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2019 20:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbfGISd1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jul 2019 14:33:27 -0400
Received: from mga03.intel.com ([134.134.136.65]:7155 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729339AbfGISd0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Jul 2019 14:33:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jul 2019 11:33:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,471,1557212400"; 
   d="scan'208";a="168065130"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 09 Jul 2019 11:33:23 -0700
Received: from [10.54.74.33] (skuppusw-desk.jf.intel.com [10.54.74.33])
        by linux.intel.com (Postfix) with ESMTP id EF5B75808B9;
        Tue,  9 Jul 2019 11:33:22 -0700 (PDT)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH] PCI/AER: save/restore AER registers during suspend/resume
To:     "Patel, Mayurkumar" <mayurkumar.patel@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        'Bjorn Helgaas' <helgaas@kernel.org>
Cc:     "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>
References: <92EBB4272BF81E4089A7126EC1E7B28479A7F14D@IRSMSX101.ger.corp.intel.com>
From:   sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <1fbfe79b-0123-7305-5fc3-4963599538a3@linux.intel.com>
Date:   Tue, 9 Jul 2019 11:31:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <92EBB4272BF81E4089A7126EC1E7B28479A7F14D@IRSMSX101.ger.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 7/9/19 1:00 AM, Patel, Mayurkumar wrote:
> After system suspend/resume cycle AER registers settings are
> lost. Not restoring Root Error Command Register bits if it were
> set, keeps AER interrupts disabled after system resume.
> Moreover, AER mask and severity registers are also required
> to be restored back to AER settings prior to system suspend.
>
> Signed-off-by: Mayurkumar Patel <mayurkumar.patel@intel.com>
> ---
>   drivers/pci/pci.c      |  2 ++
>   drivers/pci/pcie/aer.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>   include/linux/aer.h    |  4 ++++
>   3 files changed, 55 insertions(+)
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
> index b45bc47..1acc641 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -448,6 +448,54 @@ int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
>   	return 0;
>   }
>   
> +void pci_save_aer_state(struct pci_dev *dev)
> +{
> +	int pos = 0;
> +	struct pci_cap_saved_state *save_state;
> +	u32 *cap;
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
> +	pci_read_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, cap++);

I don't see AER driver modifying UNCOR_MASK/SEVER/COR_MASK register. If 
all it has is default value then why do you want to preserve it ?

Also, any reason for not preserving ECRC settings ?

> +}
> +
> +void pci_restore_aer_state(struct pci_dev *dev)
> +{
> +	int pos = 0;
> +	struct pci_cap_saved_state *save_state;
> +	u32 *cap;
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
> +	pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, *cap++);
> +}
> +
>   void pci_aer_init(struct pci_dev *dev)
>   {
>   	dev->aer_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
> @@ -1396,6 +1444,7 @@ static int aer_probe(struct pcie_device *dev)
>   		return status;
>   	}
>   
> +	pci_add_ext_cap_save_buffer(port, PCI_EXT_CAP_ID_ERR, sizeof(u32) * 4);
>   	aer_enable_rootport(rpc);
>   	pci_info(port, "enabled with IRQ %d\n", dev->irq);
>   	return 0;
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


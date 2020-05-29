Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE1A1E8BD3
	for <lists+linux-pci@lfdr.de>; Sat, 30 May 2020 01:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbgE2XQr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 May 2020 19:16:47 -0400
Received: from mga04.intel.com ([192.55.52.120]:9820 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726898AbgE2XQq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 May 2020 19:16:46 -0400
IronPort-SDR: C0p4/oBvwcigwNY94upWQdSSvGSP/TQ71ORBOp0HiSx3+aVNEwiVl7IbWIXzVqDCDgNdV1vXLT
 MasK3IQra07g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2020 16:15:44 -0700
IronPort-SDR: T8v5SKDzOICOymZXCDEuk01Q23dqANs1XKnpfhyFchScfmioHBW58o2b6a/iM+YcJKmxx8e+h2
 G+DzIwslxtQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,450,1583222400"; 
   d="scan'208";a="469654525"
Received: from unknown (HELO [10.251.23.52]) ([10.251.23.52])
  by fmsmga006.fm.intel.com with ESMTP; 29 May 2020 16:15:43 -0700
Subject: Re: [PATCH v4 0/5] Remove AER HEST table parser
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com
References: <20200529230915.GA479883@bjorn-Precision-5520>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <3dcad4cb-6961-0e35-59a7-74daf8cfab55@linux.intel.com>
Date:   Fri, 29 May 2020 16:15:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200529230915.GA479883@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 5/29/20 4:09 PM, Bjorn Helgaas wrote:
> On Tue, May 26, 2020 at 04:18:24PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>> Commit c100beb9ccfb ("PCI/AER: Use only _OSC to determine AER ownership")
>> removed HEST dependency in determining the AER ownership status. The
>> following patch set cleansup rest of the HEST table related code from
>> AER driver.
>>
>> This patchset also includes some minor AER driver fixes.
>>
>> Changes since v3:
>>   * Fixed compilation issues reported by kbuild test robot.
>>
>> Changes since v2:
>>   * Fixed commit sha id for patch "PCI/AER: Use only _OSC to determine AER ownership".
>>
>> Kuppuswamy Sathyanarayanan (5):
>>    PCI/AER: Remove redundant pci_is_pcie() checks.
>>    PCI/AER: Remove redundant dev->aer_cap checks.
>>    ACPI/PCI: Ignore _OSC negotiation result if pcie_ports_native is set.
>>    ACPI/PCI: Ignore _OSC DPC negotiation result if pcie_ports_dpc_native
>>      is set.
>>    PCI/AER: Replace pcie_aer_get_firmware_first() with
>>      pcie_aer_is_native()
> 
> I reordered these a bit and applied them as follows for v5.8:
> 
>    ("PCI/AER: Remove HEST/FIRMWARE_FIRST parsing for AER ownership")
>    ("PCI/AER: Remove redundant dev->aer_cap checks")
>    ("PCI/AER: Remove redundant pci_is_pcie() checks")
> 
> I added the trivial patch below on top.
> 
>>   drivers/acpi/pci_root.c    |  28 ++++----
>>   drivers/pci/pcie/aer.c     | 139 ++++---------------------------------
>>   drivers/pci/pcie/dpc.c     |   2 +-
>>   drivers/pci/pcie/portdrv.h |  15 +---
>>   include/linux/pci.h        |   2 +
>>   5 files changed, 34 insertions(+), 152 deletions(-)
> 
> commit 643a9f8854f9 ("PCI/AER: Use "aer" variable for capability offset")
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Fri May 29 17:56:09 2020 -0500
> 
>      PCI/AER: Use "aer" variable for capability offset
>      
>      Previously we used "pos" or "aer_pos" for the offset of the AER Capability.
>      Use "aer" consistently and initialize it the same way everywhere.  No
>      functional change intended.
>      
>      Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Looks good to me.
Reviewed-by: Kuppuswamy Sathyanarayanan 
<sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 61e8cb23e98b..3acf56683915 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -136,19 +136,18 @@ static const char * const ecrc_policy_str[] = {
>    */
>   static int enable_ecrc_checking(struct pci_dev *dev)
>   {
> -	int pos;
> +	int aer = dev->aer_cap;
>   	u32 reg32;
>   
> -	pos = dev->aer_cap;
> -	if (!pos)
> +	if (!aer)
>   		return -ENODEV;
>   
> -	pci_read_config_dword(dev, pos + PCI_ERR_CAP, &reg32);
> +	pci_read_config_dword(dev, aer + PCI_ERR_CAP, &reg32);
>   	if (reg32 & PCI_ERR_CAP_ECRC_GENC)
>   		reg32 |= PCI_ERR_CAP_ECRC_GENE;
>   	if (reg32 & PCI_ERR_CAP_ECRC_CHKC)
>   		reg32 |= PCI_ERR_CAP_ECRC_CHKE;
> -	pci_write_config_dword(dev, pos + PCI_ERR_CAP, reg32);
> +	pci_write_config_dword(dev, aer + PCI_ERR_CAP, reg32);
>   
>   	return 0;
>   }
> @@ -161,16 +160,15 @@ static int enable_ecrc_checking(struct pci_dev *dev)
>    */
>   static int disable_ecrc_checking(struct pci_dev *dev)
>   {
> -	int pos;
> +	int aer = dev->aer_cap;
>   	u32 reg32;
>   
> -	pos = dev->aer_cap;
> -	if (!pos)
> +	if (!aer)
>   		return -ENODEV;
>   
> -	pci_read_config_dword(dev, pos + PCI_ERR_CAP, &reg32);
> +	pci_read_config_dword(dev, aer + PCI_ERR_CAP, &reg32);
>   	reg32 &= ~(PCI_ERR_CAP_ECRC_GENE | PCI_ERR_CAP_ECRC_CHKE);
> -	pci_write_config_dword(dev, pos + PCI_ERR_CAP, reg32);
> +	pci_write_config_dword(dev, aer + PCI_ERR_CAP, reg32);
>   
>   	return 0;
>   }
> @@ -253,18 +251,18 @@ void pci_aer_clear_device_status(struct pci_dev *dev)
>   
>   int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>   {
> -	int pos = dev->aer_cap;
> +	int aer = dev->aer_cap;
>   	u32 status, sev;
>   
>   	if (!pcie_aer_is_native(dev))
>   		return -EIO;
>   
>   	/* Clear status bits for ERR_NONFATAL errors only */
> -	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
> -	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, &sev);
> +	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, &status);
> +	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_SEVER, &sev);
>   	status &= ~sev;
>   	if (status)
> -		pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, status);
> +		pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, status);
>   
>   	return 0;
>   }
> @@ -272,18 +270,18 @@ EXPORT_SYMBOL_GPL(pci_aer_clear_nonfatal_status);
>   
>   void pci_aer_clear_fatal_status(struct pci_dev *dev)
>   {
> -	int pos = dev->aer_cap;
> +	int aer = dev->aer_cap;
>   	u32 status, sev;
>   
>   	if (!pcie_aer_is_native(dev))
>   		return;
>   
>   	/* Clear status bits for ERR_FATAL errors only */
> -	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
> -	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, &sev);
> +	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, &status);
> +	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_SEVER, &sev);
>   	status &= sev;
>   	if (status)
> -		pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, status);
> +		pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, status);
>   }
>   
>   /**
> @@ -297,25 +295,24 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
>    */
>   int pci_aer_raw_clear_status(struct pci_dev *dev)
>   {
> -	int pos;
> +	int aer = dev->aer_cap;
>   	u32 status;
>   	int port_type;
>   
> -	pos = dev->aer_cap;
> -	if (!pos)
> +	if (!aer)
>   		return -EIO;
>   
>   	port_type = pci_pcie_type(dev);
>   	if (port_type == PCI_EXP_TYPE_ROOT_PORT) {
> -		pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, &status);
> -		pci_write_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, status);
> +		pci_read_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, &status);
> +		pci_write_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, status);
>   	}
>   
> -	pci_read_config_dword(dev, pos + PCI_ERR_COR_STATUS, &status);
> -	pci_write_config_dword(dev, pos + PCI_ERR_COR_STATUS, status);
> +	pci_read_config_dword(dev, aer + PCI_ERR_COR_STATUS, &status);
> +	pci_write_config_dword(dev, aer + PCI_ERR_COR_STATUS, status);
>   
> -	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
> -	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, status);
> +	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, &status);
> +	pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, status);
>   
>   	return 0;
>   }
> @@ -330,12 +327,11 @@ int pci_aer_clear_status(struct pci_dev *dev)
>   
>   void pci_save_aer_state(struct pci_dev *dev)
>   {
> +	int aer = dev->aer_cap;
>   	struct pci_cap_saved_state *save_state;
>   	u32 *cap;
> -	int pos;
>   
> -	pos = dev->aer_cap;
> -	if (!pos)
> +	if (!aer)
>   		return;
>   
>   	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_ERR);
> @@ -343,22 +339,21 @@ void pci_save_aer_state(struct pci_dev *dev)
>   		return;
>   
>   	cap = &save_state->cap.data[0];
> -	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, cap++);
> -	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, cap++);
> -	pci_read_config_dword(dev, pos + PCI_ERR_COR_MASK, cap++);
> -	pci_read_config_dword(dev, pos + PCI_ERR_CAP, cap++);
> +	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, cap++);
> +	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_SEVER, cap++);
> +	pci_read_config_dword(dev, aer + PCI_ERR_COR_MASK, cap++);
> +	pci_read_config_dword(dev, aer + PCI_ERR_CAP, cap++);
>   	if (pcie_cap_has_rtctl(dev))
> -		pci_read_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, cap++);
> +		pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, cap++);
>   }
>   
>   void pci_restore_aer_state(struct pci_dev *dev)
>   {
> +	int aer = dev->aer_cap;
>   	struct pci_cap_saved_state *save_state;
>   	u32 *cap;
> -	int pos;
>   
> -	pos = dev->aer_cap;
> -	if (!pos)
> +	if (!aer)
>   		return;
>   
>   	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_ERR);
> @@ -366,12 +361,12 @@ void pci_restore_aer_state(struct pci_dev *dev)
>   		return;
>   
>   	cap = &save_state->cap.data[0];
> -	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, *cap++);
> -	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, *cap++);
> -	pci_write_config_dword(dev, pos + PCI_ERR_COR_MASK, *cap++);
> -	pci_write_config_dword(dev, pos + PCI_ERR_CAP, *cap++);
> +	pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, *cap++);
> +	pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_SEVER, *cap++);
> +	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, *cap++);
> +	pci_write_config_dword(dev, aer + PCI_ERR_CAP, *cap++);
>   	if (pcie_cap_has_rtctl(dev))
> -		pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, *cap++);
> +		pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, *cap++);
>   }
>   
>   void pci_aer_init(struct pci_dev *dev)
> @@ -802,7 +797,7 @@ static int add_error_device(struct aer_err_info *e_info, struct pci_dev *dev)
>    */
>   static bool is_error_source(struct pci_dev *dev, struct aer_err_info *e_info)
>   {
> -	int pos;
> +	int aer = dev->aer_cap;
>   	u32 status, mask;
>   	u16 reg16;
>   
> @@ -837,17 +832,16 @@ static bool is_error_source(struct pci_dev *dev, struct aer_err_info *e_info)
>   	if (!(reg16 & PCI_EXP_AER_FLAGS))
>   		return false;
>   
> -	pos = dev->aer_cap;
> -	if (!pos)
> +	if (!aer)
>   		return false;
>   
>   	/* Check if error is recorded */
>   	if (e_info->severity == AER_CORRECTABLE) {
> -		pci_read_config_dword(dev, pos + PCI_ERR_COR_STATUS, &status);
> -		pci_read_config_dword(dev, pos + PCI_ERR_COR_MASK, &mask);
> +		pci_read_config_dword(dev, aer + PCI_ERR_COR_STATUS, &status);
> +		pci_read_config_dword(dev, aer + PCI_ERR_COR_MASK, &mask);
>   	} else {
> -		pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
> -		pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, &mask);
> +		pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, &status);
> +		pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, &mask);
>   	}
>   	if (status & ~mask)
>   		return true;
> @@ -918,16 +912,15 @@ static bool find_source_device(struct pci_dev *parent,
>    */
>   static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
>   {
> -	int pos;
> +	int aer = dev->aer_cap;
>   
>   	if (info->severity == AER_CORRECTABLE) {
>   		/*
>   		 * Correctable error does not need software intervention.
>   		 * No need to go through error recovery process.
>   		 */
> -		pos = dev->aer_cap;
> -		if (pos)
> -			pci_write_config_dword(dev, pos + PCI_ERR_COR_STATUS,
> +		if (aer)
> +			pci_write_config_dword(dev, aer + PCI_ERR_COR_STATUS,
>   					info->status);
>   		pci_aer_clear_device_status(dev);
>   	} else if (info->severity == AER_NONFATAL)
> @@ -1018,22 +1011,21 @@ EXPORT_SYMBOL_GPL(aer_recover_queue);
>    */
>   int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
>   {
> -	int pos, temp;
> +	int aer = dev->aer_cap;
> +	int temp;
>   
>   	/* Must reset in this function */
>   	info->status = 0;
>   	info->tlp_header_valid = 0;
>   
> -	pos = dev->aer_cap;
> -
>   	/* The device might not support AER */
> -	if (!pos)
> +	if (!aer)
>   		return 0;
>   
>   	if (info->severity == AER_CORRECTABLE) {
> -		pci_read_config_dword(dev, pos + PCI_ERR_COR_STATUS,
> +		pci_read_config_dword(dev, aer + PCI_ERR_COR_STATUS,
>   			&info->status);
> -		pci_read_config_dword(dev, pos + PCI_ERR_COR_MASK,
> +		pci_read_config_dword(dev, aer + PCI_ERR_COR_MASK,
>   			&info->mask);
>   		if (!(info->status & ~info->mask))
>   			return 0;
> @@ -1042,27 +1034,27 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
>   		   info->severity == AER_NONFATAL) {
>   
>   		/* Link is still healthy for IO reads */
> -		pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS,
> +		pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS,
>   			&info->status);
> -		pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_MASK,
> +		pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_MASK,
>   			&info->mask);
>   		if (!(info->status & ~info->mask))
>   			return 0;
>   
>   		/* Get First Error Pointer */
> -		pci_read_config_dword(dev, pos + PCI_ERR_CAP, &temp);
> +		pci_read_config_dword(dev, aer + PCI_ERR_CAP, &temp);
>   		info->first_error = PCI_ERR_CAP_FEP(temp);
>   
>   		if (info->status & AER_LOG_TLP_MASKS) {
>   			info->tlp_header_valid = 1;
>   			pci_read_config_dword(dev,
> -				pos + PCI_ERR_HEADER_LOG, &info->tlp.dw0);
> +				aer + PCI_ERR_HEADER_LOG, &info->tlp.dw0);
>   			pci_read_config_dword(dev,
> -				pos + PCI_ERR_HEADER_LOG + 4, &info->tlp.dw1);
> +				aer + PCI_ERR_HEADER_LOG + 4, &info->tlp.dw1);
>   			pci_read_config_dword(dev,
> -				pos + PCI_ERR_HEADER_LOG + 8, &info->tlp.dw2);
> +				aer + PCI_ERR_HEADER_LOG + 8, &info->tlp.dw2);
>   			pci_read_config_dword(dev,
> -				pos + PCI_ERR_HEADER_LOG + 12, &info->tlp.dw3);
> +				aer + PCI_ERR_HEADER_LOG + 12, &info->tlp.dw3);
>   		}
>   	}
>   
> @@ -1168,15 +1160,15 @@ static irqreturn_t aer_irq(int irq, void *context)
>   	struct pcie_device *pdev = (struct pcie_device *)context;
>   	struct aer_rpc *rpc = get_service_data(pdev);
>   	struct pci_dev *rp = rpc->rpd;
> +	int aer = rp->aer_cap;
>   	struct aer_err_source e_src = {};
> -	int pos = rp->aer_cap;
>   
> -	pci_read_config_dword(rp, pos + PCI_ERR_ROOT_STATUS, &e_src.status);
> +	pci_read_config_dword(rp, aer + PCI_ERR_ROOT_STATUS, &e_src.status);
>   	if (!(e_src.status & (PCI_ERR_ROOT_UNCOR_RCV|PCI_ERR_ROOT_COR_RCV)))
>   		return IRQ_NONE;
>   
> -	pci_read_config_dword(rp, pos + PCI_ERR_ROOT_ERR_SRC, &e_src.id);
> -	pci_write_config_dword(rp, pos + PCI_ERR_ROOT_STATUS, e_src.status);
> +	pci_read_config_dword(rp, aer + PCI_ERR_ROOT_ERR_SRC, &e_src.id);
> +	pci_write_config_dword(rp, aer + PCI_ERR_ROOT_STATUS, e_src.status);
>   
>   	if (!kfifo_put(&rpc->aer_fifo, e_src))
>   		return IRQ_HANDLED;
> @@ -1228,7 +1220,7 @@ static void set_downstream_devices_error_reporting(struct pci_dev *dev,
>   static void aer_enable_rootport(struct aer_rpc *rpc)
>   {
>   	struct pci_dev *pdev = rpc->rpd;
> -	int aer_pos;
> +	int aer = pdev->aer_cap;
>   	u16 reg16;
>   	u32 reg32;
>   
> @@ -1240,14 +1232,13 @@ static void aer_enable_rootport(struct aer_rpc *rpc)
>   	pcie_capability_clear_word(pdev, PCI_EXP_RTCTL,
>   				   SYSTEM_ERROR_INTR_ON_MESG_MASK);
>   
> -	aer_pos = pdev->aer_cap;
>   	/* Clear error status */
> -	pci_read_config_dword(pdev, aer_pos + PCI_ERR_ROOT_STATUS, &reg32);
> -	pci_write_config_dword(pdev, aer_pos + PCI_ERR_ROOT_STATUS, reg32);
> -	pci_read_config_dword(pdev, aer_pos + PCI_ERR_COR_STATUS, &reg32);
> -	pci_write_config_dword(pdev, aer_pos + PCI_ERR_COR_STATUS, reg32);
> -	pci_read_config_dword(pdev, aer_pos + PCI_ERR_UNCOR_STATUS, &reg32);
> -	pci_write_config_dword(pdev, aer_pos + PCI_ERR_UNCOR_STATUS, reg32);
> +	pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_STATUS, &reg32);
> +	pci_write_config_dword(pdev, aer + PCI_ERR_ROOT_STATUS, reg32);
> +	pci_read_config_dword(pdev, aer + PCI_ERR_COR_STATUS, &reg32);
> +	pci_write_config_dword(pdev, aer + PCI_ERR_COR_STATUS, reg32);
> +	pci_read_config_dword(pdev, aer + PCI_ERR_UNCOR_STATUS, &reg32);
> +	pci_write_config_dword(pdev, aer + PCI_ERR_UNCOR_STATUS, reg32);
>   
>   	/*
>   	 * Enable error reporting for the root port device and downstream port
> @@ -1256,9 +1247,9 @@ static void aer_enable_rootport(struct aer_rpc *rpc)
>   	set_downstream_devices_error_reporting(pdev, true);
>   
>   	/* Enable Root Port's interrupt in response to error messages */
> -	pci_read_config_dword(pdev, aer_pos + PCI_ERR_ROOT_COMMAND, &reg32);
> +	pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
>   	reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
> -	pci_write_config_dword(pdev, aer_pos + PCI_ERR_ROOT_COMMAND, reg32);
> +	pci_write_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, reg32);
>   }
>   
>   /**
> @@ -1270,8 +1261,8 @@ static void aer_enable_rootport(struct aer_rpc *rpc)
>   static void aer_disable_rootport(struct aer_rpc *rpc)
>   {
>   	struct pci_dev *pdev = rpc->rpd;
> +	int aer = pdev->aer_cap;
>   	u32 reg32;
> -	int pos;
>   
>   	/*
>   	 * Disable error reporting for the root port device and downstream port
> @@ -1279,15 +1270,14 @@ static void aer_disable_rootport(struct aer_rpc *rpc)
>   	 */
>   	set_downstream_devices_error_reporting(pdev, false);
>   
> -	pos = pdev->aer_cap;
>   	/* Disable Root's interrupt in response to error messages */
> -	pci_read_config_dword(pdev, pos + PCI_ERR_ROOT_COMMAND, &reg32);
> +	pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
>   	reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
> -	pci_write_config_dword(pdev, pos + PCI_ERR_ROOT_COMMAND, reg32);
> +	pci_write_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, reg32);
>   
>   	/* Clear Root's error status reg */
> -	pci_read_config_dword(pdev, pos + PCI_ERR_ROOT_STATUS, &reg32);
> -	pci_write_config_dword(pdev, pos + PCI_ERR_ROOT_STATUS, reg32);
> +	pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_STATUS, &reg32);
> +	pci_write_config_dword(pdev, aer + PCI_ERR_ROOT_STATUS, reg32);
>   }
>   
>   /**
> @@ -1344,28 +1334,27 @@ static int aer_probe(struct pcie_device *dev)
>    */
>   static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
>   {
> +	int aer = dev->aer_cap;
>   	u32 reg32;
> -	int pos;
>   	int rc;
>   
> -	pos = dev->aer_cap;
>   
>   	/* Disable Root's interrupt in response to error messages */
> -	pci_read_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, &reg32);
> +	pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
>   	reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
> -	pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, reg32);
> +	pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, reg32);
>   
>   	rc = pci_bus_error_reset(dev);
>   	pci_info(dev, "Root Port link has been reset\n");
>   
>   	/* Clear Root Error Status */
> -	pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, &reg32);
> -	pci_write_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, reg32);
> +	pci_read_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, &reg32);
> +	pci_write_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, reg32);
>   
>   	/* Enable Root Port's interrupt in response to error messages */
> -	pci_read_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, &reg32);
> +	pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
>   	reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
> -	pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, reg32);
> +	pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, reg32);
>   
>   	return rc ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED;
>   }
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

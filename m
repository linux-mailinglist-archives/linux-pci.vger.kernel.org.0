Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBB4B8A98A
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2019 23:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfHLVnQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Aug 2019 17:43:16 -0400
Received: from mga17.intel.com ([192.55.52.151]:52083 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726527AbfHLVnP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Aug 2019 17:43:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Aug 2019 14:43:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,379,1559545200"; 
   d="scan'208";a="177608221"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 12 Aug 2019 14:43:14 -0700
Received: from [10.54.74.33] (skuppusw-desk.jf.intel.com [10.54.74.33])
        by linux.intel.com (Postfix) with ESMTP id B3AE15806A0;
        Mon, 12 Aug 2019 14:43:14 -0700 (PDT)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v5 4/7] PCI/ATS: Add PRI support for PCIe VF devices
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com
References: <cover.1564702313.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <827d051ef8c8bbfa815908ce927e607870780cb6.1564702313.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20190812200456.GL11785@google.com>
From:   sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <f6ee630d-6db5-a39e-6660-6c96a27189b4@linux.intel.com>
Date:   Mon, 12 Aug 2019 14:40:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190812200456.GL11785@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 8/12/19 1:04 PM, Bjorn Helgaas wrote:
> On Thu, Aug 01, 2019 at 05:06:01PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>> When IOMMU tries to enable Page Request Interface (PRI) for VF device
>> in iommu_enable_dev_iotlb(), it always fails because PRI support for
>> PCIe VF device is currently broken. Current implementation expects
>> the given PCIe device (PF & VF) to implement PRI capability before
>> enabling the PRI support. But this assumption is incorrect. As per PCIe
>> spec r4.0, sec 9.3.7.11, all VFs associated with PF can only use the
>> PRI of the PF and not implement it. Hence we need to create exception
>> for handling the PRI support for PCIe VF device.
>>
>> Also, since PRI is a shared resource between PF/VF, following rules
>> should apply.
>>
>> 1. Use proper locking before accessing/modifying PF resources in VF
>>     PRI enable/disable call.
>> 2. Use reference count logic to track the usage of PRI resource.
>> 3. Disable PRI only if the PRI reference count (pri_ref_cnt) is zero.
>>
>> Cc: Ashok Raj <ashok.raj@intel.com>
>> Cc: Keith Busch <keith.busch@intel.com>
>> Suggested-by: Ashok Raj <ashok.raj@intel.com>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> ---
>>   drivers/pci/ats.c   | 143 ++++++++++++++++++++++++++++++++++----------
>>   include/linux/pci.h |   2 +
>>   2 files changed, 112 insertions(+), 33 deletions(-)
>>
>> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
>> index 1f4be27a071d..079dc5444444 100644
>> --- a/drivers/pci/ats.c
>> +++ b/drivers/pci/ats.c
>> @@ -189,6 +189,8 @@ void pci_pri_init(struct pci_dev *pdev)
>>   	if (pdev->is_virtfn)
>>   		return;
>>   
>> +	mutex_init(&pdev->pri_lock);
>> +
>>   	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
>>   	if (!pos)
>>   		return;
>> @@ -221,29 +223,57 @@ int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
>>   {
>>   	u16 control, status;
>>   	u32 max_requests;
>> +	int ret = 0;
>> +	struct pci_dev *pf = pci_physfn(pdev);
>>   
>> -	if (WARN_ON(pdev->pri_enabled))
>> -		return -EBUSY;
>> +	mutex_lock(&pf->pri_lock);
>>   
>> -	if (!pdev->pri_cap)
>> -		return -EINVAL;
>> +	if (WARN_ON(pdev->pri_enabled)) {
>> +		ret = -EBUSY;
>> +		goto pri_unlock;
>> +	}
>>   
>> -	pci_read_config_word(pdev, pdev->pri_cap + PCI_PRI_STATUS, &status);
>> -	if (!(status & PCI_PRI_STATUS_STOPPED))
>> -		return -EBUSY;
>> +	if (!pf->pri_cap) {
>> +		ret = -EINVAL;
>> +		goto pri_unlock;
>> +	}
>> +
>> +	if (pdev->is_virtfn && pf->pri_enabled)
>> +		goto update_status;
>> +
>> +	/*
>> +	 * Before updating PRI registers, make sure there is no
>> +	 * outstanding PRI requests.
>> +	 */
>> +	pci_read_config_word(pf, pf->pri_cap + PCI_PRI_STATUS, &status);
>> +	if (!(status & PCI_PRI_STATUS_STOPPED)) {
>> +		ret = -EBUSY;
>> +		goto pri_unlock;
>> +	}
>>   
>> -	pci_read_config_dword(pdev, pdev->pri_cap + PCI_PRI_MAX_REQ,
>> -			      &max_requests);
>> +	pci_read_config_dword(pf, pf->pri_cap + PCI_PRI_MAX_REQ, &max_requests);
>>   	reqs = min(max_requests, reqs);
>> -	pdev->pri_reqs_alloc = reqs;
>> -	pci_write_config_dword(pdev, pdev->pri_cap + PCI_PRI_ALLOC_REQ, reqs);
>> +	pf->pri_reqs_alloc = reqs;
>> +	pci_write_config_dword(pf, pf->pri_cap + PCI_PRI_ALLOC_REQ, reqs);
>>   
>>   	control = PCI_PRI_CTRL_ENABLE;
>> -	pci_write_config_word(pdev, pdev->pri_cap + PCI_PRI_CTRL, control);
>> +	pci_write_config_word(pf, pf->pri_cap + PCI_PRI_CTRL, control);
>>   
>> -	pdev->pri_enabled = 1;
>> +	/*
>> +	 * If PRI is not already enabled in PF, increment the PF
>> +	 * pri_ref_cnt to track the usage of PRI interface.
>> +	 */
>> +	if (pdev->is_virtfn && !pf->pri_enabled) {
>> +		atomic_inc(&pf->pri_ref_cnt);
>> +		pf->pri_enabled = 1;
>> +	}
>>   
>> -	return 0;
>> +update_status:
>> +	atomic_inc(&pf->pri_ref_cnt);
>> +	pdev->pri_enabled = 1;
>> +pri_unlock:
>> +	mutex_unlock(&pf->pri_lock);
>> +	return ret;
>>   }
>>   EXPORT_SYMBOL_GPL(pci_enable_pri);
>>   
>> @@ -256,18 +286,30 @@ EXPORT_SYMBOL_GPL(pci_enable_pri);
>>   void pci_disable_pri(struct pci_dev *pdev)
>>   {
>>   	u16 control;
>> +	struct pci_dev *pf = pci_physfn(pdev);
>>   
>> -	if (WARN_ON(!pdev->pri_enabled))
>> -		return;
>> +	mutex_lock(&pf->pri_lock);
>>   
>> -	if (!pdev->pri_cap)
>> -		return;
>> +	if (WARN_ON(!pdev->pri_enabled) || !pf->pri_cap)
>> +		goto pri_unlock;
>> +
>> +	atomic_dec(&pf->pri_ref_cnt);
>>   
>> -	pci_read_config_word(pdev, pdev->pri_cap + PCI_PRI_CTRL, &control);
>> +	/*
>> +	 * If pri_ref_cnt is not zero, then don't modify hardware
>> +	 * registers.
>> +	 */
>> +	if (atomic_read(&pf->pri_ref_cnt))
>> +		goto done;
>> +
>> +	pci_read_config_word(pf, pf->pri_cap + PCI_PRI_CTRL, &control);
>>   	control &= ~PCI_PRI_CTRL_ENABLE;
>> -	pci_write_config_word(pdev, pdev->pri_cap + PCI_PRI_CTRL, control);
>> +	pci_write_config_word(pf, pf->pri_cap + PCI_PRI_CTRL, control);
>>   
>> +done:
>>   	pdev->pri_enabled = 0;
>> +pri_unlock:
>> +	mutex_unlock(&pf->pri_lock);
>>   }
>>   EXPORT_SYMBOL_GPL(pci_disable_pri);
>>   
>> @@ -277,17 +319,31 @@ EXPORT_SYMBOL_GPL(pci_disable_pri);
>>    */
>>   void pci_restore_pri_state(struct pci_dev *pdev)
>>   {
>> -	u16 control = PCI_PRI_CTRL_ENABLE;
>> -	u32 reqs = pdev->pri_reqs_alloc;
>> +	u16 control;
>> +	u32 reqs;
>> +	struct pci_dev *pf = pci_physfn(pdev);
>>   
>>   	if (!pdev->pri_enabled)
>>   		return;
>>   
>> -	if (!pdev->pri_cap)
>> +	if (!pf->pri_cap)
>>   		return;
>>   
>> -	pci_write_config_dword(pdev, pdev->pri_cap + PCI_PRI_ALLOC_REQ, reqs);
>> -	pci_write_config_word(pdev, pdev->pri_cap + PCI_PRI_CTRL, control);
>> +	mutex_lock(&pf->pri_lock);
>> +
>> +	/* If PRI is already enabled by other VF's or PF, return */
>> +	pci_read_config_word(pf, pf->pri_cap + PCI_PRI_CTRL, &control);
>> +	if (control & PCI_PRI_CTRL_ENABLE)
>> +		goto pri_unlock;
>> +
>> +	reqs = pf->pri_reqs_alloc;
>> +	control = PCI_PRI_CTRL_ENABLE;
>> +
>> +	pci_write_config_dword(pf, pf->pri_cap + PCI_PRI_ALLOC_REQ, reqs);
>> +	pci_write_config_word(pf, pf->pri_cap + PCI_PRI_CTRL, control);
> Why use "control" here instead of just PCI_PRI_CTRL_ENABLE?
It can be done. Even in original code, using control did not serve any 
purpose. I just left the implementation as original code.
>
>> +pri_unlock:
>> +	mutex_unlock(&pf->pri_lock);
>>   }
>>   EXPORT_SYMBOL_GPL(pci_restore_pri_state);
>>   
>> @@ -300,18 +356,32 @@ EXPORT_SYMBOL_GPL(pci_restore_pri_state);
>>    */
>>   int pci_reset_pri(struct pci_dev *pdev)
>>   {
>> +	struct pci_dev *pf = pci_physfn(pdev);
>>   	u16 control;
>> +	int ret = 0;
>>   
>> -	if (WARN_ON(pdev->pri_enabled))
>> -		return -EBUSY;
>> +	mutex_lock(&pf->pri_lock);
>>   
>> -	if (!pdev->pri_cap)
>> -		return -EINVAL;
>> +	if (WARN_ON(pdev->pri_enabled)) {
>> +		ret = -EBUSY;
>> +		goto done;
>> +	}
>> +
>> +	if (!pf->pri_cap) {
>> +		ret = -EINVAL;
>> +		goto done;
>> +	}
>> +
>> +	/* If PRI is already enabled by other VF's or PF, return 0 */
>> +	if (pf->pri_enabled)
>> +		goto done;
>>   
>>   	control = PCI_PRI_CTRL_RESET;
>> -	pci_write_config_word(pdev, pdev->pri_cap + PCI_PRI_CTRL, control);
>>   
>> -	return 0;
>> +	pci_write_config_word(pf, pf->pri_cap + PCI_PRI_CTRL, control);
> Also here (you didn't add this one, but "control" is completely
> pointless in this function).
>
>> +done:
>> +	mutex_unlock(&pf->pri_lock);
>> +	return ret;
>>   }
>>   EXPORT_SYMBOL_GPL(pci_reset_pri);
>>   #endif /* CONFIG_PCI_PRI */
>> @@ -475,11 +545,18 @@ EXPORT_SYMBOL_GPL(pci_pasid_features);
>>   int pci_prg_resp_pasid_required(struct pci_dev *pdev)
>>   {
>>   	u16 status;
>> +	struct pci_dev *pf = pci_physfn(pdev);
>> +
>> +	mutex_lock(&pf->pri_lock);
>>   
>> -	if (!pdev->pri_cap)
>> +	if (!pf->pri_cap) {
>> +		mutex_unlock(&pf->pri_lock);
>>   		return 0;
>> +	}
>> +
>> +	pci_read_config_word(pf, pf->pri_cap + PCI_PRI_STATUS, &status);
>>   
>> -	pci_read_config_word(pdev, pdev->pri_cap + PCI_PRI_STATUS, &status);
>> +	mutex_unlock(&pf->pri_lock);
>>   
>>   	if (status & PCI_PRI_STATUS_PASID)
>>   		return 1;
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 27224c0db849..3c9c4c82be27 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -455,8 +455,10 @@ struct pci_dev {
>>   	atomic_t	ats_ref_cnt;	/* Number of VFs with ATS enabled */
>>   #endif
>>   #ifdef CONFIG_PCI_PRI
>> +	struct mutex	pri_lock;	/* PRI enable lock */
>>   	u16		pri_cap;	/* PRI Capability offset */
>>   	u32		pri_reqs_alloc; /* Number of PRI requests allocated */
>> +	atomic_t	pri_ref_cnt;	/* Number of PF/VF PRI users */
>>   #endif
>>   #ifdef CONFIG_PCI_PASID
>>   	u16		pasid_cap;	/* PASID Capability offset */
>> -- 
>> 2.21.0
>>
-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer


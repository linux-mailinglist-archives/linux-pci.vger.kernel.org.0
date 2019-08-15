Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B89AF8F71F
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2019 00:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731696AbfHOWlv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Aug 2019 18:41:51 -0400
Received: from mga04.intel.com ([192.55.52.120]:58766 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731244AbfHOWlu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Aug 2019 18:41:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 15:41:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,389,1559545200"; 
   d="scan'208";a="171245579"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 15 Aug 2019 15:41:49 -0700
Received: from [10.54.74.33] (skuppusw-desk.jf.intel.com [10.54.74.33])
        by linux.intel.com (Postfix) with ESMTP id AADFB5806C4;
        Thu, 15 Aug 2019 15:41:49 -0700 (PDT)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v5 4/7] PCI/ATS: Add PRI support for PCIe VF devices
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org
References: <cover.1564702313.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <827d051ef8c8bbfa815908ce927e607870780cb6.1564702313.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20190815222049.GL253360@google.com>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <f05eb779-9f78-f20f-7626-16b8bd28af40@linux.intel.com>
Date:   Thu, 15 Aug 2019 15:39:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190815222049.GL253360@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 8/15/19 3:20 PM, Bjorn Helgaas wrote:
> [+cc Joerg, David, iommu list: because IOMMU drivers are the only
> callers of pci_enable_pri() and pci_enable_pasid()]
>
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
> Wait, why do we need this at all?  I agree the spec says VFs may not
> implement PRI or PASID capabilities and that VFs use the PRI and
> PASID of the PF.
>
> But why do we need to support pci_enable_pri() and pci_enable_pasid()
> for VFs?  There's nothing interesting we can *do* in the VF, and
> passing it off to the PF adds all this locking mess.  For VFs, can we
> just make them do nothing or return -EINVAL?  What functionality would
> we be missing if we did that?

Currently PRI/PASID capabilities are not enabled by default. IOMMU can
enable PRI/PASID for VF first (and not enable it for PF). In this case,
doing nothing for VF device will break the functionality.

Also the PRI/PASID config options like "PRI Outstanding Page Request 
Allocation"
or "PASID Execute Permission" or "PASID Privileged Mode" are currently 
configured
as per device feature. And hence there is a chance for VF/PF to use 
different
values for these options.

> (Obviously returning -EINVAL would require tweaks in the callers to
> either avoid the call for VFs or handle the -EINVAL gracefully.)
>
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
>> +
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


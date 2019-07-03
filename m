Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1287C5EB87
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2019 20:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfGCSZw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jul 2019 14:25:52 -0400
Received: from mga01.intel.com ([192.55.52.88]:6475 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbfGCSZw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Jul 2019 14:25:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2019 11:25:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,446,1557212400"; 
   d="scan'208";a="315655248"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 03 Jul 2019 11:25:45 -0700
Received: from [10.54.74.33] (skuppusw-desk.jf.intel.com [10.54.74.33])
        by linux.intel.com (Postfix) with ESMTP id A021258060A;
        Wed,  3 Jul 2019 11:25:45 -0700 (PDT)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v3 1/7] PCI/ATS: Fix pci_prg_resp_pasid_required()
 dependency issues
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com
References: <cover.1561061640.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <a0534c2ec69e0d7e03c4da3e8d539e8591a5686c.1561061640.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20190703175654.GN128603@google.com>
From:   sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <a2ff2b65-3e7c-6aad-22d8-3a17dd4074b1@linux.intel.com>
Date:   Wed, 3 Jul 2019 11:23:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190703175654.GN128603@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 7/3/19 10:56 AM, Bjorn Helgaas wrote:
> On Thu, Jun 20, 2019 at 01:38:42PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>> Since pci_prg_resp_pasid_required() function has dependency on both
>> PASID and PRI, define it only if both CONFIG_PCI_PRI and
>> CONFIG_PCI_PASID config options are enabled.
> This is likely just confusion on my part, but I don't understand what
> you're doing here.
>
> pci_prg_resp_pasid_required() does not actually *depend* on the
> CONFIG_PCI_PRI config symbol.

pci_prg_resp_pasid_required() function internally reads the PRI status 
register to get the status of PASID required bit.

FILE:drivers/pci/ats.c

419         pci_read_config_word(pdev, pos + PCI_PRI_STATUS, &status);
420
421         if (status & PCI_PRI_STATUS_PASID)

Since pci_prg_resp_pasid_required()  function is only used if 
CONFIG_PCI_PASID is enabled, and since it also has internal PCI_PRI 
dependency, I have protected it with both CONFIG_PCI_PASID and 
CONFIG_PCI_PRI ifdefs.

>
> It is currently compiled only if CONFIG_PCI_ATS=y (which controls
> compilation of the entire ats.c) and CONFIG_PCI_PASID=y (since it's
> within #ifdef CONFIG_PCI_PASID).
>
> pci_prg_resp_pasid_required() is called by attach_device()
> (amd_iommu.c), which is only compiled if CONFIG_AMD_IOMMU=y, and that
> selects PCI_PRI.
pci_prg_resp_pasid_required() is also called by intel_iommu.c, and 
enabling CONFIG_INTEL_IOMMU does not enable PCI_PRI/PCI_PASID by default.
>
> It is also called by iommu_enable_dev_iotlb() (intel-iommu.c).  That
> file is compiled if CONFIG_INTEL_IOMMU=y and the call itself is inside
> #ifdef CONFIG_INTEL_IOMMU_SVM.  But I don't see the PCI_PRI connection
> here.
>
> If this is just to limit the visibility, say that.  But I don't think
> that's really a good reason.  The chain of config symbols seems a
> little too complicated.
>
>> Fixes: e5567f5f6762 ("PCI/ATS: Add pci_prg_resp_pasid_required()
>> interface.")
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> ---
>>   drivers/pci/ats.c       | 10 ++++++----
>>   include/linux/pci-ats.h | 12 +++++++++---
>>   2 files changed, 15 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
>> index 97c08146534a..f9eeb7db0db3 100644
>> --- a/drivers/pci/ats.c
>> +++ b/drivers/pci/ats.c
>> @@ -395,6 +395,8 @@ int pci_pasid_features(struct pci_dev *pdev)
>>   }
>>   EXPORT_SYMBOL_GPL(pci_pasid_features);
>>   
>> +#ifdef CONFIG_PCI_PRI
>> +
>>   /**
>>    * pci_prg_resp_pasid_required - Return PRG Response PASID Required bit
>>    *				 status.
>> @@ -402,10 +404,8 @@ EXPORT_SYMBOL_GPL(pci_pasid_features);
>>    *
>>    * Returns 1 if PASID is required in PRG Response Message, 0 otherwise.
>>    *
>> - * Even though the PRG response PASID status is read from PRI Status
>> - * Register, since this API will mainly be used by PASID users, this
>> - * function is defined within #ifdef CONFIG_PCI_PASID instead of
>> - * CONFIG_PCI_PRI.
>> + * Since this API has dependency on both PRI and PASID, protect it
>> + * with both CONFIG_PCI_PRI and CONFIG_PCI_PASID.
>>    */
>>   int pci_prg_resp_pasid_required(struct pci_dev *pdev)
>>   {
>> @@ -425,6 +425,8 @@ int pci_prg_resp_pasid_required(struct pci_dev *pdev)
>>   }
>>   EXPORT_SYMBOL_GPL(pci_prg_resp_pasid_required);
>>   
>> +#endif
>> +
>>   #define PASID_NUMBER_SHIFT	8
>>   #define PASID_NUMBER_MASK	(0x1f << PASID_NUMBER_SHIFT)
>>   /**
>> diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
>> index 1ebb88e7c184..1a0bdaee2f32 100644
>> --- a/include/linux/pci-ats.h
>> +++ b/include/linux/pci-ats.h
>> @@ -40,7 +40,6 @@ void pci_disable_pasid(struct pci_dev *pdev);
>>   void pci_restore_pasid_state(struct pci_dev *pdev);
>>   int pci_pasid_features(struct pci_dev *pdev);
>>   int pci_max_pasids(struct pci_dev *pdev);
>> -int pci_prg_resp_pasid_required(struct pci_dev *pdev);
>>   
>>   #else  /* CONFIG_PCI_PASID */
>>   
>> @@ -67,11 +66,18 @@ static inline int pci_max_pasids(struct pci_dev *pdev)
>>   	return -EINVAL;
>>   }
>>   
>> +#endif /* CONFIG_PCI_PASID */
>> +
>> +#if defined(CONFIG_PCI_PRI) && defined(CONFIG_PCI_PASID)
>> +
>> +int pci_prg_resp_pasid_required(struct pci_dev *pdev);
>> +
>> +#else /* CONFIG_PCI_PASID && CONFIG_PCI_PRI */
>> +
>>   static inline int pci_prg_resp_pasid_required(struct pci_dev *pdev)
>>   {
>>   	return 0;
>>   }
>> -#endif /* CONFIG_PCI_PASID */
>> -
>> +#endif
>>   
>>   #endif /* LINUX_PCI_ATS_H*/
>> -- 
>> 2.21.0
>>
-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A80E8D1C3C
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2019 00:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731134AbfJIWxi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Oct 2019 18:53:38 -0400
Received: from mga18.intel.com ([134.134.136.126]:32589 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730999AbfJIWxi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Oct 2019 18:53:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2019 15:53:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,277,1566889200"; 
   d="scan'208";a="205898798"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 09 Oct 2019 15:53:37 -0700
Received: from [10.54.74.33] (skuppusw-desk.jf.intel.com [10.54.74.33])
        by linux.intel.com (Postfix) with ESMTP id 9D6645802BC;
        Wed,  9 Oct 2019 15:53:37 -0700 (PDT)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v1 1/1] PCI/ATS: Optimize pci_prg_resp_pasid_required()
 function
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com
References: <20191009223056.GA139157@google.com>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <3cd33a40-8653-fe01-dd99-cf9b62b4327d@linux.intel.com>
Date:   Wed, 9 Oct 2019 15:51:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191009223056.GA139157@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Thanks for the review.

On 10/9/19 3:30 PM, Bjorn Helgaas wrote:
> On Mon, Oct 07, 2019 at 04:32:42PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>> Currently, pci_prg_resp_pasid_required() function reads the
>> PASID Required bit status from register every time we call
>> the function. Since PASID Required bit is a read-only value,
>> instead of reading it from register every time, read it once and
>> cache it in struct pci_dev.
>>
>> Also, since we are caching PASID Required bit in pci_pri_init()
>> function, move the caching of PRI Capability check result to the same
>> function. This will group all PRI related caching at one place.
>>
>> Since "pasid_required" structure member is protected by CONFIG_PRI,
>> its users should also be protected by same #ifdef. So correct the #ifdef
>> dependency of pci_prg_resp_pasid_required() function.
>>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> Cc: Ashok Raj <ashok.raj@intel.com>
>> Cc: Keith Busch <keith.busch@intel.com>
>> ---
>>   drivers/pci/ats.c   | 50 ++++++++++++++++++++++++---------------------
>>   include/linux/pci.h |  1 +
>>   2 files changed, 28 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
>> index cb4f62da7b8a..2b5df5ea208f 100644
>> --- a/drivers/pci/ats.c
>> +++ b/drivers/pci/ats.c
>> @@ -16,6 +16,24 @@
>>   
>>   #include "pci.h"
>>   
>> +static void pci_pri_init(struct pci_dev *pdev)
>> +{
>> +#ifdef CONFIG_PCI_PRI
>> +	int pos;
>> +	u16 status;
>> +
>> +	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
>> +	if (!pos)
>> +		return;
>> +
>> +	pdev->pri_cap = pos;
>> +
>> +	pci_read_config_word(pdev, pos + PCI_PRI_STATUS, &status);
>> +	if (status & PCI_PRI_STATUS_PASID)
>> +		pdev->pasid_required = 1;
>> +#endif
>> +}
> I like this patch a lot but:
>
> 1) You started out with a pci_pri_init(), and I screwed up when I
> suggested that you remove it.  I think it makes a lot of sense to have
> it and call it directly from pci_init_capabilities() just like we do
> for other capabilities.

Yes, we could do that. But, I thought may be there is a history for grouping
all PRI/PASID related code in ats.c. That's why I did not move PRI/PASID
related init code outside ats.c. If its not an issue, having it in 
pci_init_capabiliies() is
more appropriate.

>
> 2) The PCI_PRI/PCI_PASID #ifdef thing is still a mess.  Despite the
> fact that its name contains "pasid", pci_prg_resp_pasid_required()
> only looks at the PRI capability, so I think it should be under #ifdef
> CONFIG_PCI_PRI along with the other PRI stuff.
>
> 3) I'm not sure why pci_prg_resp_pasid_required() was under
> CONFIG_PCI_PASID, but it might be related to the fact that it's called
> from code in intel-iommu.c where CONFIG_PCI_PASID is always defined,
> but CONFIG_PCI_PRI may not be.
Main reason is, this function will only be used if PASID is enabled. 
Please check the following
code snippet from intel-iommu.c

1418         if (info->pasid_supported && !pci_enable_pasid(pdev, 
info->pasid_supported & ~1))
1419                 info->pasid_enabled = 1;
1420
1421         if (info->pri_supported &&
1422             (info->pasid_enabled ? 
pci_prg_resp_pasid_required(pdev) : 1)  &&
1423             !pci_reset_pri(pdev) && !pci_enable_pri(pdev, 32))
1424                 info->pri_enabled = 1;

After looking at this code again, since there is no compile time 
dependency, we could just move
the definition of pri_prg_resp_pasid_required() function under 
CONFIG_PCI_PRI. it should not be a
problem.

> I think this is an intel-iommu Kconfig
> defect.  I'll post patches to change the Kconfig and to move
> pci_prg_resp_pasid_required() under CONFIG_PCI_PRI.
>
> So I fiddled with all this and updated my pci/virtualization branch
> with the result.
>
> The interdiff from the v8 series is below.  This includes the
> intel-iommu Kconfig and pci_prg_resp_pasid_required() changes (which I
> haven't posted yet), and the branch includes some unrelated follow-on
> patches (which I also haven't posted yet).  Let me know what you
> think.
It looks good to me. Please go ahead.
>
> Bjorn
>
>>   void pci_ats_init(struct pci_dev *dev)
>>   {
>>   	int pos;
>> @@ -28,6 +46,8 @@ void pci_ats_init(struct pci_dev *dev)
>>   		return;
>>   
>>   	dev->ats_cap = pos;
>> +
>> +	pci_pri_init(dev);
>>   }
>>   
>>   /**
>> @@ -185,12 +205,8 @@ int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
>>   	if (WARN_ON(pdev->pri_enabled))
>>   		return -EBUSY;
>>   
>> -	if (!pri) {
>> -		pri = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
>> -		if (!pri)
>> -			return -EINVAL;
>> -		pdev->pri_cap = pri;
>> -	}
>> +	if (!pri)
>> +		return -EINVAL;
>>   
>>   	pci_read_config_word(pdev, pri + PCI_PRI_STATUS, &status);
>>   	if (!(status & PCI_PRI_STATUS_STOPPED))
>> @@ -425,6 +441,7 @@ int pci_pasid_features(struct pci_dev *pdev)
>>   }
>>   EXPORT_SYMBOL_GPL(pci_pasid_features);
>>   
>> +#ifdef CONFIG_PCI_PRI
>>   /**
>>    * pci_prg_resp_pasid_required - Return PRG Response PASID Required bit
>>    *				 status.
>> @@ -432,31 +449,18 @@ EXPORT_SYMBOL_GPL(pci_pasid_features);
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
>> -	u16 status;
>> -	int pri;
>> -
>>   	if (pdev->is_virtfn)
>>   		pdev = pci_physfn(pdev);
>>   
>> -	pri = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
>> -	if (!pri)
>> -		return 0;
>> -
>> -	pci_read_config_word(pdev, pri + PCI_PRI_STATUS, &status);
>> -
>> -	if (status & PCI_PRI_STATUS_PASID)
>> -		return 1;
>> -
>> -	return 0;
>> +	return pdev->pasid_required;
>>   }
>>   EXPORT_SYMBOL_GPL(pci_prg_resp_pasid_required);
>> +#endif /* CONFIG_PCI_PRI */
>>   
>>   #define PASID_NUMBER_SHIFT	8
>>   #define PASID_NUMBER_MASK	(0x1f << PASID_NUMBER_SHIFT)
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 6542100bd2dd..f1131fee7fcd 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -456,6 +456,7 @@ struct pci_dev {
>>   #ifdef CONFIG_PCI_PRI
>>   	u16		pri_cap;	/* PRI Capability offset */
>>   	u32		pri_reqs_alloc; /* Number of PRI requests allocated */
>> +	unsigned int	pasid_required:1; /* PRG Response PASID Required bit status */
>>   #endif
>>   #ifdef CONFIG_PCI_PASID
>>   	u16		pasid_cap;	/* PASID Capability offset */
>> -- 
>> 2.21.0
>>
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index e3842eabcfdd..b183c9f916b0 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -207,6 +207,7 @@ config INTEL_IOMMU_SVM
>   	bool "Support for Shared Virtual Memory with Intel IOMMU"
>   	depends on INTEL_IOMMU && X86
>   	select PCI_PASID
> +	select PCI_PRI
>   	select MMU_NOTIFIER
>   	help
>   	  Shared Virtual Memory (SVM) provides a facility for devices
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index cb4f62da7b8a..76ae518d55f4 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -159,6 +159,20 @@ int pci_ats_page_aligned(struct pci_dev *pdev)
>   EXPORT_SYMBOL_GPL(pci_ats_page_aligned);
>   
>   #ifdef CONFIG_PCI_PRI
> +void pci_pri_init(struct pci_dev *pdev)
> +{
> +	u16 status;
> +
> +	pdev->pri_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
> +
> +	if (!pdev->pri_cap)
> +		return;
> +
> +	pci_read_config_word(pdev, pdev->pri_cap + PCI_PRI_STATUS, &status);
> +	if (status & PCI_PRI_STATUS_PASID)
> +		pdev->pasid_required = 1;
> +}
> +
>   /**
>    * pci_enable_pri - Enable PRI capability
>    * @ pdev: PCI device structure
> @@ -185,12 +199,8 @@ int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
>   	if (WARN_ON(pdev->pri_enabled))
>   		return -EBUSY;
>   
> -	if (!pri) {
> -		pri = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
> -		if (!pri)
> -			return -EINVAL;
> -		pdev->pri_cap = pri;
> -	}
> +	if (!pri)
> +		return -EINVAL;
>   
>   	pci_read_config_word(pdev, pri + PCI_PRI_STATUS, &status);
>   	if (!(status & PCI_PRI_STATUS_STOPPED))
> @@ -290,9 +300,30 @@ int pci_reset_pri(struct pci_dev *pdev)
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(pci_reset_pri);
> +
> +/**
> + * pci_prg_resp_pasid_required - Return PRG Response PASID Required bit
> + *				 status.
> + * @pdev: PCI device structure
> + *
> + * Returns 1 if PASID is required in PRG Response Message, 0 otherwise.
> + */
> +int pci_prg_resp_pasid_required(struct pci_dev *pdev)
> +{
> +	if (pdev->is_virtfn)
> +		pdev = pci_physfn(pdev);
> +
> +	return pdev->pasid_required;
> +}
> +EXPORT_SYMBOL_GPL(pci_prg_resp_pasid_required);
>   #endif /* CONFIG_PCI_PRI */
>   
>   #ifdef CONFIG_PCI_PASID
> +void pci_pasid_init(struct pci_dev *pdev)
> +{
> +	pdev->pasid_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
> +}
> +
>   /**
>    * pci_enable_pasid - Enable the PASID capability
>    * @pdev: PCI device structure
> @@ -323,12 +354,8 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
>   	if (!pdev->eetlp_prefix_path)
>   		return -EINVAL;
>   
> -	if (!pasid) {
> -		pasid = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
> -		if (!pasid)
> -			return -EINVAL;
> -		pdev->pasid_cap = pasid;
> -	}
> +	if (!pasid)
> +		return -EINVAL;
>   
>   	pci_read_config_word(pdev, pasid + PCI_PASID_CAP, &supported);
>   	supported &= PCI_PASID_CAP_EXEC | PCI_PASID_CAP_PRIV;
> @@ -425,39 +452,6 @@ int pci_pasid_features(struct pci_dev *pdev)
>   }
>   EXPORT_SYMBOL_GPL(pci_pasid_features);
>   
> -/**
> - * pci_prg_resp_pasid_required - Return PRG Response PASID Required bit
> - *				 status.
> - * @pdev: PCI device structure
> - *
> - * Returns 1 if PASID is required in PRG Response Message, 0 otherwise.
> - *
> - * Even though the PRG response PASID status is read from PRI Status
> - * Register, since this API will mainly be used by PASID users, this
> - * function is defined within #ifdef CONFIG_PCI_PASID instead of
> - * CONFIG_PCI_PRI.
> - */
> -int pci_prg_resp_pasid_required(struct pci_dev *pdev)
> -{
> -	u16 status;
> -	int pri;
> -
> -	if (pdev->is_virtfn)
> -		pdev = pci_physfn(pdev);
> -
> -	pri = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
> -	if (!pri)
> -		return 0;
> -
> -	pci_read_config_word(pdev, pri + PCI_PRI_STATUS, &status);
> -
> -	if (status & PCI_PRI_STATUS_PASID)
> -		return 1;
> -
> -	return 0;
> -}
> -EXPORT_SYMBOL_GPL(pci_prg_resp_pasid_required);
> -
>   #define PASID_NUMBER_SHIFT	8
>   #define PASID_NUMBER_MASK	(0x1f << PASID_NUMBER_SHIFT)
>   /**
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 3f6947ee3324..ae84d28ba03a 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -456,6 +456,18 @@ static inline void pci_ats_init(struct pci_dev *d) { }
>   static inline void pci_restore_ats_state(struct pci_dev *dev) { }
>   #endif /* CONFIG_PCI_ATS */
>   
> +#ifdef CONFIG_PCI_PRI
> +void pci_pri_init(struct pci_dev *dev);
> +#else
> +static inline void pci_pri_init(struct pci_dev *dev) { }
> +#endif
> +
> +#ifdef CONFIG_PCI_PASID
> +void pci_pasid_init(struct pci_dev *dev);
> +#else
> +static inline void pci_pasid_init(struct pci_dev *dev) { }
> +#endif
> +
>   #ifdef CONFIG_PCI_IOV
>   int pci_iov_init(struct pci_dev *dev);
>   void pci_iov_release(struct pci_dev *dev);
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 3d5271a7a849..df2b77866f3b 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2324,6 +2324,12 @@ static void pci_init_capabilities(struct pci_dev *dev)
>   	/* Address Translation Services */
>   	pci_ats_init(dev);
>   
> +	/* Page Request Interface */
> +	pci_pri_init(dev);
> +
> +	/* Process Address Space ID */
> +	pci_pasid_init(dev);
> +
>   	/* Enable ACS P2P upstream forwarding */
>   	pci_enable_acs(dev);
>   
> diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
> index 1ebb88e7c184..a7a2b3d94fcc 100644
> --- a/include/linux/pci-ats.h
> +++ b/include/linux/pci-ats.h
> @@ -10,6 +10,7 @@ int pci_enable_pri(struct pci_dev *pdev, u32 reqs);
>   void pci_disable_pri(struct pci_dev *pdev);
>   void pci_restore_pri_state(struct pci_dev *pdev);
>   int pci_reset_pri(struct pci_dev *pdev);
> +int pci_prg_resp_pasid_required(struct pci_dev *pdev);
>   
>   #else /* CONFIG_PCI_PRI */
>   
> @@ -31,6 +32,10 @@ static inline int pci_reset_pri(struct pci_dev *pdev)
>   	return -ENODEV;
>   }
>   
> +static inline int pci_prg_resp_pasid_required(struct pci_dev *pdev)
> +{
> +	return 0;
> +}
>   #endif /* CONFIG_PCI_PRI */
>   
>   #ifdef CONFIG_PCI_PASID
> @@ -40,7 +45,6 @@ void pci_disable_pasid(struct pci_dev *pdev);
>   void pci_restore_pasid_state(struct pci_dev *pdev);
>   int pci_pasid_features(struct pci_dev *pdev);
>   int pci_max_pasids(struct pci_dev *pdev);
> -int pci_prg_resp_pasid_required(struct pci_dev *pdev);
>   
>   #else  /* CONFIG_PCI_PASID */
>   
> @@ -66,11 +70,6 @@ static inline int pci_max_pasids(struct pci_dev *pdev)
>   {
>   	return -EINVAL;
>   }
> -
> -static inline int pci_prg_resp_pasid_required(struct pci_dev *pdev)
> -{
> -	return 0;
> -}
>   #endif /* CONFIG_PCI_PASID */
>   
>   
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 6542100bd2dd..64d35e730fab 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -456,6 +456,7 @@ struct pci_dev {
>   #ifdef CONFIG_PCI_PRI
>   	u16		pri_cap;	/* PRI Capability offset */
>   	u32		pri_reqs_alloc; /* Number of PRI requests allocated */
> +	unsigned int	pasid_required:1; /* PRG Response PASID Required */
>   #endif
>   #ifdef CONFIG_PCI_PASID
>   	u16		pasid_cap;	/* PASID Capability offset */
>
-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer


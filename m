Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63E71CAAFC
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2019 19:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731461AbfJCRZv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Oct 2019 13:25:51 -0400
Received: from mga04.intel.com ([192.55.52.120]:34645 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730428AbfJCRZs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Oct 2019 13:25:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2019 10:22:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,253,1566889200"; 
   d="scan'208";a="191329490"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 03 Oct 2019 10:22:44 -0700
Received: from [10.54.74.33] (skuppusw-desk.jf.intel.com [10.54.74.33])
        by linux.intel.com (Postfix) with ESMTP id CC766580378;
        Thu,  3 Oct 2019 10:22:44 -0700 (PDT)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v7 1/7] PCI/ATS: Fix pci_prg_resp_pasid_required()
 dependency issues
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com
References: <cover.1567029860.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <ef40dbdc4eae32490caec47bed5b57eeb438dd80.1567029860.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20190905191854.GE103977@google.com>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <abfb75fc-6f88-7117-b0d8-1a374ee99d3e@linux.intel.com>
Date:   Thu, 3 Oct 2019 10:20:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190905191854.GE103977@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Thanks for looking into this patch set.

On 9/5/19 12:18 PM, Bjorn Helgaas wrote:
> On Wed, Aug 28, 2019 at 03:14:01PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>> Since pci_prg_resp_pasid_required() function has dependency on both
>> PASID and PRI, define it only if both CONFIG_PCI_PRI and
>> CONFIG_PCI_PASID config options are enabled.
>>
>> Fixes: e5567f5f6762 ("PCI/ATS: Add pci_prg_resp_pasid_required()
>> interface.")
> [Don't split tags, including "Fixes:" across lines]
>
> This definitely doesn't fix e5567f5f6762.  That commit added
> pci_prg_resp_pasid_required(), but with no dependency on
> CONFIG_PCI_PRI or CONFIG_PCI_PASID.
>
> This patch is only required when a subsequent patch is applied.  It
> should be squashed into the commit that requires it so it's obvious
> why it's needed.
>
> I've been poking at this series, and I'll post a v8 soon with this and
> other fixes.
In your v8 submission you did not merge this patch. You did not use
pri_cap or pasid_cap cached values. Instead you have re-read the
value from register. Is this intentional?

Since this function will be called for every VF device we might loose 
some performance benefit.

>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> ---
>>   drivers/pci/ats.c       | 10 ++++++----
>>   include/linux/pci-ats.h | 12 +++++++++---
>>   2 files changed, 15 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
>> index e18499243f84..cdd936d10f68 100644
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


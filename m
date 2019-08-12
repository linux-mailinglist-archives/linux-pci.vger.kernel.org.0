Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED5E08A850
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2019 22:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfHLUXk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Aug 2019 16:23:40 -0400
Received: from mga06.intel.com ([134.134.136.31]:40802 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbfHLUXj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Aug 2019 16:23:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Aug 2019 13:23:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,378,1559545200"; 
   d="scan'208";a="351319677"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 12 Aug 2019 13:23:38 -0700
Received: from [10.54.74.33] (skuppusw-desk.jf.intel.com [10.54.74.33])
        by linux.intel.com (Postfix) with ESMTP id D522B580372;
        Mon, 12 Aug 2019 13:23:38 -0700 (PDT)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v5 1/7] PCI/ATS: Fix pci_prg_resp_pasid_required()
 dependency issues
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com
References: <cover.1564702313.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <0d7e0e0d079c438897f4da8cdca4b55994b1233b.1564702313.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20190812200418.GJ11785@google.com>
From:   sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <09a2faf0-a26f-6374-130a-3b33b1b712d5@linux.intel.com>
Date:   Mon, 12 Aug 2019 13:20:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190812200418.GJ11785@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 8/12/19 1:04 PM, Bjorn Helgaas wrote:
> On Thu, Aug 01, 2019 at 05:05:58PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>> Since pci_prg_resp_pasid_required() function has dependency on both
>> PASID and PRI, define it only if both CONFIG_PCI_PRI and
>> CONFIG_PCI_PASID config options are enabled.
> I don't really like this.  It makes the #ifdefs more complicated and I
> don't think it really buys us anything.  Will anything break if we
> just drop this patch?
Yes, this function uses "pri_lock" mutex which is only defined if 
CONFIG_PCI_PRI is enabled. So not protecting this function within 
CONFIG_PCI_PRI will lead to compilation issues.
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


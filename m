Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318BF2A2E9E
	for <lists+linux-pci@lfdr.de>; Mon,  2 Nov 2020 16:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgKBPuo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Nov 2020 10:50:44 -0500
Received: from mga05.intel.com ([192.55.52.43]:45943 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbgKBPuo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Nov 2020 10:50:44 -0500
IronPort-SDR: uoN3wg8N2yGgffBLUPMx4yUgxETjK2P5uldLZ+MCcrJf5zldeSWENHZWeVhUo5oBrsfMOa69l9
 fVU0/XzR0ptw==
X-IronPort-AV: E=McAfee;i="6000,8403,9793"; a="253612834"
X-IronPort-AV: E=Sophos;i="5.77,445,1596524400"; 
   d="scan'208";a="253612834"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2020 07:50:43 -0800
IronPort-SDR: SiUGt6sTq+UirrfrqKaS73FIspwj0fSjeGyTBARGmipB8jNkWP/OeVVlr89k6dAMwixeR8DnQC
 Z4EAe/4e2yuQ==
X-IronPort-AV: E=Sophos;i="5.77,445,1596524400"; 
   d="scan'208";a="336205894"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.251.132.252]) ([10.251.132.252])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2020 07:50:42 -0800
Subject: Re: [PATCH] PCI: add helper function to find DVSEC
To:     Randy Dunlap <rdunlap@infradead.org>, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, david.e.box@intel.com,
        sean.v.kelly@intel.com, ashok.raj@intel.com
References: <160409768616.919324.13994867117217584719.stgit@djiang5-desk3.ch.intel.com>
 <b742b19e-7ac6-901d-909a-15fb266ccffe@infradead.org>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <cc84e2f1-b615-4c43-a338-2a782d8f7be1@intel.com>
Date:   Mon, 2 Nov 2020 08:50:39 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <b742b19e-7ac6-901d-909a-15fb266ccffe@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/30/2020 10:35 PM, Randy Dunlap wrote:
> On 10/30/20 3:42 PM, Dave Jiang wrote:
>> Add function that searches for DVSEC and returns the offset in PCI
>> configuration space for the interested DVSEC capability.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Ashok Raj <ashok.raj@intel.com>
>> ---
>>
>> The patch has dependency on David Box’s dvsec definition patch:
>> https://lore.kernel.org/linux-pci/bc5f059c5bae957daebde699945c80808286bf45.camel@linux.intel.com/T/#m1d0dc12e3b2c739e2c37106a45f325bb8f001774
>>
>>   drivers/pci/pci.c   |   30 ++++++++++++++++++++++++++++++
>>   include/linux/pci.h |    3 +++
>>   2 files changed, 33 insertions(+)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 6d4d5a2f923d..49e57b831509 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -589,6 +589,36 @@ int pci_find_ext_capability(struct pci_dev *dev, int cap)
>>   }
>>   EXPORT_SYMBOL_GPL(pci_find_ext_capability);
>>   
>> +/**
>> + * pci_find_dvsec - return position of DVSEC with provided vendor and DVSEC ID
>> + * @dev: the PCI device
>> + * @vendor: vendor for the DVSEC
>> + * @id: the DVSEC capibility ID
> 
>                       capability
> 
>> + *
>> + * Return the offset of DVSEC on success or -ENOTSUPP if not found
> 
>      * Return: the offset of DVSEC on success or -ENOTSUPP if not found
> 
>> + */
>> +int pci_find_dvsec(struct pci_dev *dev, u16 vendor, u16 id)
>> +{
>> +	u16 dev_vendor, dev_id;
>> +	int pos;
>> +
>> +	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DVSEC);
>> +	if (!pos)
>> +		return -ENOTSUPP;
>> +
>> +	while (pos) {
>> +		pci_read_config_word(dev, pos + PCI_DVSEC_HEADER1, &dev_vendor);
>> +		pci_read_config_word(dev, pos + PCI_DVSEC_HEADER2, &dev_id);
>> +		if (dev_vendor == vendor && dev_id == id)
>> +			return pos;
>> +
>> +		pos = pci_find_next_ext_capability(dev, pos, PCI_EXT_CAP_ID_DVSEC);
>> +	}
>> +
>> +	return -ENOTSUPP;
>> +}
>> +EXPORT_SYMBOL_GPL(pci_find_dvsec);
>> +
>>   /**
>>    * pci_get_dsn - Read and return the 8-byte Device Serial Number
>>    * @dev: PCI device to query
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 22207a79762c..6c692d32c82a 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -1069,6 +1069,7 @@ int pci_find_ext_capability(struct pci_dev *dev, int cap);
>>   int pci_find_next_ext_capability(struct pci_dev *dev, int pos, int cap);
>>   int pci_find_ht_capability(struct pci_dev *dev, int ht_cap);
>>   int pci_find_next_ht_capability(struct pci_dev *dev, int pos, int ht_cap);
>> +int pci_find_dvsec(struct pci_dev *dev, u16 vendor, u16 id);
>>   struct pci_bus *pci_find_next_bus(const struct pci_bus *from);
>>   
>>   u64 pci_get_dsn(struct pci_dev *dev);
>> @@ -1726,6 +1727,8 @@ static inline int pci_find_next_capability(struct pci_dev *dev, u8 post,
>>   { return 0; }
>>   static inline int pci_find_ext_capability(struct pci_dev *dev, int cap)
>>   { return 0; }
>> +static inline int pci_find_dvsec(struct pci_dev *dev, u16 vendor, u16 id)
>> +{ return 0; }
> 
> Why shouldn't this return -ENOTSUPP instead of 0?

Actually looking at the other find cap functions. Should I be returning 0 for 
all failures?

> 
>>   
>>   static inline u64 pci_get_dsn(struct pci_dev *dev)
>>   { return 0; }
>>
>>
> 

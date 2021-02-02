Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A130130C543
	for <lists+linux-pci@lfdr.de>; Tue,  2 Feb 2021 17:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235993AbhBBQRp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Feb 2021 11:17:45 -0500
Received: from mx.socionext.com ([202.248.49.38]:24641 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236044AbhBBQPd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Feb 2021 11:15:33 -0500
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 03 Feb 2021 01:13:27 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id EAA732059027;
        Wed,  3 Feb 2021 01:13:27 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 3 Feb 2021 01:13:27 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 6B16EB1D40;
        Wed,  3 Feb 2021 01:13:27 +0900 (JST)
Received: from [10.212.20.246] (unknown [10.212.20.246])
        by yuzu.css.socionext.com (Postfix) with ESMTP id C6B731202F7;
        Wed,  3 Feb 2021 01:13:26 +0900 (JST)
Subject: Re: [PATCH v2 1/3] PCI: endpoint: Add 'started' to pci_epc to set
 whether the controller is started
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
References: <1611500977-24816-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1611500977-24816-2-git-send-email-hayashi.kunihiko@socionext.com>
 <1253c4c9-4e5e-1456-6475-0334f3bb8634@ti.com>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <83a6ec4e-3f59-5084-2241-404169d50116@socionext.com>
Date:   Wed, 3 Feb 2021 01:13:26 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1253c4c9-4e5e-1456-6475-0334f3bb8634@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kishon,

On 2021/01/28 23:11, Kishon Vijay Abraham I wrote:
> Hi Kunihiko,
> 
> On 24/01/21 8:39 pm, Kunihiko Hayashi wrote:
>> This adds a member 'started' as a boolean value to struct pci_epc to set
>> whether the controller is started, and also adds a function to get the
>> value.
>>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> ---
>>   drivers/pci/endpoint/pci-epc-core.c | 2 ++
>>   include/linux/pci-epc.h             | 7 +++++++
>>   2 files changed, 9 insertions(+)
>>
>> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
>> index cc8f9eb..2904175 100644
>> --- a/drivers/pci/endpoint/pci-epc-core.c
>> +++ b/drivers/pci/endpoint/pci-epc-core.c
>> @@ -174,6 +174,7 @@ void pci_epc_stop(struct pci_epc *epc)
>>   
>>   	mutex_lock(&epc->lock);
>>   	epc->ops->stop(epc);
>> +	epc->started = false;
>>   	mutex_unlock(&epc->lock);
>>   }
>>   EXPORT_SYMBOL_GPL(pci_epc_stop);
>> @@ -196,6 +197,7 @@ int pci_epc_start(struct pci_epc *epc)
>>   
>>   	mutex_lock(&epc->lock);
>>   	ret = epc->ops->start(epc);
>> +	epc->started = true;
>>   	mutex_unlock(&epc->lock);
>>   
>>   	return ret;
>> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
>> index b82c9b1..5808952 100644
>> --- a/include/linux/pci-epc.h
>> +++ b/include/linux/pci-epc.h
>> @@ -131,6 +131,7 @@ struct pci_epc_mem {
>>    * @lock: mutex to protect pci_epc ops
>>    * @function_num_map: bitmap to manage physical function number
>>    * @notifier: used to notify EPF of any EPC events (like linkup)
>> + * @started: true if this EPC is started
>>    */
>>   struct pci_epc {
>>   	struct device			dev;
>> @@ -145,6 +146,7 @@ struct pci_epc {
>>   	struct mutex			lock;
>>   	unsigned long			function_num_map;
>>   	struct atomic_notifier_head	notifier;
>> +	bool				started;
>>   };
>>   
>>   /**
>> @@ -191,6 +193,11 @@ pci_epc_register_notifier(struct pci_epc *epc, struct notifier_block *nb)
>>   	return atomic_notifier_chain_register(&epc->notifier, nb);
>>   }
>>   
>> +static inline bool pci_epc_is_started(struct pci_epc *epc)
>> +{
>> +	return epc->started;
>> +}
> 
> This should also be protected.

Ok, I prepared this function for restart management in patch 2/3.
This also needs to be reconsidered.

Thank you,

---
Best Regards
Kunihiko Hayashi

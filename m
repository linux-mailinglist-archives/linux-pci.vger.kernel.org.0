Return-Path: <linux-pci+bounces-169-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6D07F972F
	for <lists+linux-pci@lfdr.de>; Mon, 27 Nov 2023 02:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7812E1F20418
	for <lists+linux-pci@lfdr.de>; Mon, 27 Nov 2023 01:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D486CEC4;
	Mon, 27 Nov 2023 01:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81ACE10F;
	Sun, 26 Nov 2023 17:34:10 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0Vx7cD-F_1701048846;
Received: from 30.240.112.131(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Vx7cD-F_1701048846)
          by smtp.aliyun-inc.com;
          Mon, 27 Nov 2023 09:34:08 +0800
Message-ID: <71fa699f-5130-401a-bf4a-3271579a8dda@linux.alibaba.com>
Date: Mon, 27 Nov 2023 09:34:05 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/5] PCI: Move pci_clear_and_set_dword() helper to PCI
 header
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: ilkka@os.amperecomputing.com, kaishen@linux.alibaba.com,
 yangyicong@huawei.com, will@kernel.org, Jonathan.Cameron@huawei.com,
 baolin.wang@linux.alibaba.com, robin.murphy@arm.com,
 chengyou@linux.alibaba.com, LKML <linux-kernel@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 rdunlap@infradead.org, mark.rutland@arm.com, zhuo.song@linux.alibaba.com,
 renyu.zj@linux.alibaba.com
References: <20231121013400.18367-1-xueshuai@linux.alibaba.com>
 <20231121013400.18367-4-xueshuai@linux.alibaba.com>
 <f2a31d7f-3acc-fbe8-2684-c61f355f1036@linux.intel.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <f2a31d7f-3acc-fbe8-2684-c61f355f1036@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

+ Bjorn for PCI.

On 2023/11/22 21:14, Ilpo Järvinen wrote:

Hi, Ilpo,

Thank you for your reply. Please see my comments inline.


> On Tue, 21 Nov 2023, Shuai Xue wrote:
> 
>> The clear and set pattern is commonly used for accessing PCI config,
>> move the helper pci_clear_and_set_dword() from aspm.c into PCI header.
>> In addition, rename to pci_clear_and_set_config_dword() to retain the
>> "config" information and match the other accessors.
>>
>> No functional change intended.
>>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>> Tested-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>> ---
>>  drivers/pci/access.c    | 12 ++++++++
>>  drivers/pci/pcie/aspm.c | 65 +++++++++++++++++++----------------------
>>  include/linux/pci.h     |  2 ++
>>  3 files changed, 44 insertions(+), 35 deletions(-)
>>
>> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
>> index 6554a2e89d36..6449056b57dd 100644
>> --- a/drivers/pci/access.c
>> +++ b/drivers/pci/access.c
>> @@ -598,3 +598,15 @@ int pci_write_config_dword(const struct pci_dev *dev, int where,
>>  	return pci_bus_write_config_dword(dev->bus, dev->devfn, where, val);
>>  }
>>  EXPORT_SYMBOL(pci_write_config_dword);
>> +
>> +void pci_clear_and_set_config_dword(const struct pci_dev *dev, int pos,
>> +				    u32 clear, u32 set)
> 
> Just noting that annoyingly the ordering within the name is inconsistent 
> between:
>   pci_clear_and_set_config_dword()
> and
>   pcie_capability_clear_and_set_dword()
> 
> And if changed, it would be again annoyingly inconsistent with 
> pci_read/write_config_*(), oh well... And renaming pci_read/write_config_* 
> into the hierarchical pci_config_read/write_*() form for would touch only 
> ~6k lines... ;-D

I think it is a good question, but I don't have a clear answer. I don't
know much about the name history.  As you mentioned, the above two
accessors are the foundation operation, may it comes to @Bjorn decision.

The pci_clear_and_set_config_dword() is a variant of bellow pci accessors:

    pci_read_config_dword()
    pci_write_config_dword()

At last, they are consistend :)

> 
>> +		pci_clear_and_set_config_dword(child,
>> +					       child->l1ss + PCI_L1SS_CTL1, 0,
>> +					       cl1_2_enables);
> 
> Adding clear and set only variants into the header like there are for 
> pcie_capability_*() would remove the need to add those 0 parameters.
> IMO, it improves code readability considerably.
> 

Agreed.


Best Regards,
Shuai


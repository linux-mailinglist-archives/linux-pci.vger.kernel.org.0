Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CD97E4E44
	for <lists+linux-pci@lfdr.de>; Wed,  8 Nov 2023 01:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbjKHAvQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Nov 2023 19:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234348AbjKHAvP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Nov 2023 19:51:15 -0500
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B91A1702;
        Tue,  7 Nov 2023 16:51:12 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0VvvcIdY_1699404667;
Received: from 30.240.112.123(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VvvcIdY_1699404667)
          by smtp.aliyun-inc.com;
          Wed, 08 Nov 2023 08:51:09 +0800
Message-ID: <98b1dbba-3b82-4fe3-bb72-7447c8118bf2@linux.alibaba.com>
Date:   Wed, 8 Nov 2023 08:51:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/5] PCI: move pci_clear_and_set_dword helper to pci
 header
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     kaishen@linux.alibaba.com, yangyicong@huawei.com, will@kernel.org,
        Jonathan.Cameron@huawei.com, baolin.wang@linux.alibaba.com,
        robin.murphy@arm.com, chengyou@linux.alibaba.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, rdunlap@infradead.org,
        mark.rutland@arm.com, zhuo.song@linux.alibaba.com,
        renyu.zj@linux.alibaba.com
References: <20231107150342.GA288219@bhelgaas>
Content-Language: en-US
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20231107150342.GA288219@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023/11/7 23:03, Bjorn Helgaas wrote:
> On Sat, Nov 04, 2023 at 09:32:14PM +0800, Shuai Xue wrote:
>> The clear and set pattern is commonly used for accessing pci config,
>> move the helper pci_clear_and_set_dword from aspm.c into pci header.
> 
> s/move/Move/ (in subject, capitalize first word)
> s/pci/PCI/ (capitalize in English text)
> s/pci_clear_and_set_dword/pci_clear_and_set_dword()/ (add parens to
> function names, also in subject)
> 
> With the fixes here and below:
> 
>   Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Hi, Bjorn,

Thank you for comments, will fix them in next version.

Best Regards,
Shuai

> 
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> ---
>>  drivers/pci/access.c    | 12 ++++++++++++
>>  drivers/pci/pcie/aspm.c | 11 -----------
>>  include/linux/pci.h     |  2 ++
>>  3 files changed, 14 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
>> index 6554a2e89d36..526360481d99 100644
>> --- a/drivers/pci/access.c
>> +++ b/drivers/pci/access.c
>> @@ -598,3 +598,15 @@ int pci_write_config_dword(const struct pci_dev *dev, int where,
>>  	return pci_bus_write_config_dword(dev->bus, dev->devfn, where, val);
>>  }
>>  EXPORT_SYMBOL(pci_write_config_dword);
>> +
>> +void pci_clear_and_set_dword(const struct pci_dev *dev, int pos,
>> +				    u32 clear, u32 set)
> 
> Rename to pci_clear_and_set_config_dword() to retain the "config"
> information and match the other accessors.

Got it. Will rename it.

> 
> Align "u32 clear" under "const struct ...".  pci_write_config_dword()
> above is an anomaly.
> 

Got it. Will align it.

>> +{
>> +	u32 val;
>> +
>> +	pci_read_config_dword(dev, pos, &val);
>> +	val &= ~clear;
>> +	val |= set;
>> +	pci_write_config_dword(dev, pos, val);
>> +}
>> +EXPORT_SYMBOL(pci_clear_and_set_dword);
>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>> index 1bf630059264..f4e64fedc048 100644
>> --- a/drivers/pci/pcie/aspm.c
>> +++ b/drivers/pci/pcie/aspm.c
>> @@ -423,17 +423,6 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
>>  	}
>>  }
>>  
>> -static void pci_clear_and_set_dword(struct pci_dev *pdev, int pos,
>> -				    u32 clear, u32 set)
>> -{
>> -	u32 val;
>> -
>> -	pci_read_config_dword(pdev, pos, &val);
>> -	val &= ~clear;
>> -	val |= set;
>> -	pci_write_config_dword(pdev, pos, val);
>> -}
>> -
>>  /* Calculate L1.2 PM substate timing parameters */
>>  static void aspm_calc_l12_info(struct pcie_link_state *link,
>>  				u32 parent_l1ss_cap, u32 child_l1ss_cap)
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 8c7c2c3c6c65..271f30fd7ca4 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -1213,6 +1213,8 @@ int pci_read_config_dword(const struct pci_dev *dev, int where, u32 *val);
>>  int pci_write_config_byte(const struct pci_dev *dev, int where, u8 val);
>>  int pci_write_config_word(const struct pci_dev *dev, int where, u16 val);
>>  int pci_write_config_dword(const struct pci_dev *dev, int where, u32 val);
>> +void pci_clear_and_set_dword(const struct pci_dev *dev, int pos,
>> +				    u32 clear, u32 set);
> 
> Align "u32 clear" again.

Thank you. Will align it.

> 
>>  int pcie_capability_read_word(struct pci_dev *dev, int pos, u16 *val);
>>  int pcie_capability_read_dword(struct pci_dev *dev, int pos, u32 *val);
>> -- 
>> 2.39.3
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

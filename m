Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D5372512D
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jun 2023 02:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbjFGAmS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jun 2023 20:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234392AbjFGAmR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jun 2023 20:42:17 -0400
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5802C8F;
        Tue,  6 Jun 2023 17:42:16 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VkYDTCU_1686098531;
Received: from 30.240.118.86(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VkYDTCU_1686098531)
          by smtp.aliyun-inc.com;
          Wed, 07 Jun 2023 08:42:13 +0800
Message-ID: <6d71292c-807d-a761-d517-7eb9e5c33bbb@linux.alibaba.com>
Date:   Wed, 7 Jun 2023 08:42:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.1
Subject: Re: [PATCH v6 2/4] PCI: Add Alibaba Vendor ID to linux/pci_ids.h
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     chengyou@linux.alibaba.com, kaishen@linux.alibaba.com,
        yangyicong@huawei.com, will@kernel.org,
        Jonathan.Cameron@huawei.com, baolin.wang@linux.alibaba.com,
        robin.murphy@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        rdunlap@infradead.org, mark.rutland@arm.com,
        zhuo.song@linux.alibaba.com
References: <20230606153143.GA1124867@bhelgaas>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20230606153143.GA1124867@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023/6/6 23:31, Bjorn Helgaas wrote:
> On Tue, Jun 06, 2023 at 03:49:36PM +0800, Shuai Xue wrote:
>> The Alibaba Vendor ID (0x1ded) is now used by Alibaba elasticRDMA ("erdma")
>> and will be shared with the upcoming PCIe PMU ("dwc_pcie_pmu"). Move the
>> Vendor ID to linux/pci_ids.h so that it can shared by several drivers
>> later.
>>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 

Thank you :)

Cheers,
Shuai

>> ---
>>  drivers/infiniband/hw/erdma/erdma_hw.h | 2 --
>>  include/linux/pci_ids.h                | 2 ++
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/erdma/erdma_hw.h b/drivers/infiniband/hw/erdma/erdma_hw.h
>> index 76ce2856be28..ee35ebef9ee7 100644
>> --- a/drivers/infiniband/hw/erdma/erdma_hw.h
>> +++ b/drivers/infiniband/hw/erdma/erdma_hw.h
>> @@ -11,8 +11,6 @@
>>  #include <linux/types.h>
>>  
>>  /* PCIe device related definition. */
>> -#define PCI_VENDOR_ID_ALIBABA 0x1ded
>> -
>>  #define ERDMA_PCI_WIDTH 64
>>  #define ERDMA_FUNC_BAR 0
>>  #define ERDMA_MISX_BAR 2
>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>> index 95f33dadb2be..9e8aec472f06 100644
>> --- a/include/linux/pci_ids.h
>> +++ b/include/linux/pci_ids.h
>> @@ -2586,6 +2586,8 @@
>>  #define PCI_VENDOR_ID_TEKRAM		0x1de1
>>  #define PCI_DEVICE_ID_TEKRAM_DC290	0xdc29
>>  
>> +#define PCI_VENDOR_ID_ALIBABA		0x1ded
>> +
>>  #define PCI_VENDOR_ID_TEHUTI		0x1fc9
>>  #define PCI_DEVICE_ID_TEHUTI_3009	0x3009
>>  #define PCI_DEVICE_ID_TEHUTI_3010	0x3010
>> -- 
>> 2.20.1.12.g72788fdb
>>

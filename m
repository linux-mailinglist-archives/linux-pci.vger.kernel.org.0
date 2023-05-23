Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0467670D24B
	for <lists+linux-pci@lfdr.de>; Tue, 23 May 2023 05:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjEWDWV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 May 2023 23:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjEWDWU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 May 2023 23:22:20 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3077190;
        Mon, 22 May 2023 20:22:17 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VjIKEmD_1684812131;
Received: from 30.240.113.228(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VjIKEmD_1684812131)
          by smtp.aliyun-inc.com;
          Tue, 23 May 2023 11:22:13 +0800
Message-ID: <dcf8c683-24e3-5e26-514c-58bf56fa784d@linux.alibaba.com>
Date:   Tue, 23 May 2023 11:22:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH v5 2/4] PCI: move Alibaba Vendor ID linux/pci_ids.h
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     chengyou@linux.alibaba.com, kaishen@linux.alibaba.com,
        yangyicong@huawei.com, will@kernel.org,
        Jonathan.Cameron@huawei.com, baolin.wang@linux.alibaba.com,
        robin.murphy@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        rdunlap@infradead.org, mark.rutland@arm.com,
        zhuo.song@linux.alibaba.com
References: <ZGuSimj1cuQl3W5L@bhelgaas>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <ZGuSimj1cuQl3W5L@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023/5/23 00:04, Bjorn Helgaas wrote:
> Please follow subject line capitalization style (learn it with "git
> log --oneline include/linux/pci_ids.h"):
> 
>   PCI: Add Alibaba Vendor ID

Sorry, I will rewrite the subject.

> 
> On Mon, May 22, 2023 at 11:54:26AM +0800, Shuai Xue wrote:
>> Move Alibaba Vendor ID (0x1ded) to linux/pci_ids.h so that it can shared by
>> several drivers.
> 
> It would be helpful for reviewers to list the drivers here, since only
> one is obvious from the patch.

Will add it.

Then, the commit log should be:


PCI: Add Alibaba Vendor ID to linux/pci_ids.h

The Alibaba Vendor ID (0x1ded) is now only used by Alibaba elasticRDMA
adapter driver. Move the Vendor ID to linux/pci_ids.h so that it can shared
by several drivers later.

> 
> Thanks for sorting the entry correctly!

Aha, you are welcome :)

Thank you for valuable comments.

Best Regards,
Shuai

> 
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
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
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

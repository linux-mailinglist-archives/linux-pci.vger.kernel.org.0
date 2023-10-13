Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFAD67C8389
	for <lists+linux-pci@lfdr.de>; Fri, 13 Oct 2023 12:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjJMKpU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Oct 2023 06:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjJMKpT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Oct 2023 06:45:19 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49247C2;
        Fri, 13 Oct 2023 03:45:13 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0Vu2-b8h_1697193908;
Received: from 30.240.114.194(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Vu2-b8h_1697193908)
          by smtp.aliyun-inc.com;
          Fri, 13 Oct 2023 18:45:09 +0800
Message-ID: <8e373bfc-3fa4-6de3-4994-b93f78699e2f@linux.alibaba.com>
Date:   Fri, 13 Oct 2023 18:45:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v7 3/4] drivers/perf: add DesignWare PCIe PMU driver
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, chengyou@linux.alibaba.com,
        kaishen@linux.alibaba.com, yangyicong@huawei.com, will@kernel.org,
        baolin.wang@linux.alibaba.com, robin.murphy@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, rdunlap@infradead.org,
        mark.rutland@arm.com, zhuo.song@linux.alibaba.com,
        renyu.zj@linux.alibaba.com
References: <20231012162512.GA1069387@bhelgaas>
 <a2265967-5088-7f17-35e5-29bf1c85c15f@linux.alibaba.com>
 <20231013094113.00003d72@Huawei.com>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20231013094113.00003d72@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023/10/13 16:41, Jonathan Cameron wrote:
> 
>>>   
>>>> +	depends on (ARM64 && PCI)  
>>>
>>> I don't see any actual ARM64 dependency in the code, so maybe omit
>>> ARM64 (as PCIE_DW_PLAT_HOST does) or add "|| COMPILE_TEST"?  
>>
>> I will remove the ARM64 dependency and add COMPILE_TEST.
> don't do both.  That makes no sense. either
> 
> 	depends on PCI && (ARM64 || COMPILE_TEST)
> or
> 	depends on PCI

Got it.

Thank you.

Best Regards,
Shuai

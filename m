Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F347EBAE6
	for <lists+linux-pci@lfdr.de>; Wed, 15 Nov 2023 02:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjKOB0d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Nov 2023 20:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjKOB0d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Nov 2023 20:26:33 -0500
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C0DC9;
        Tue, 14 Nov 2023 17:26:28 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0VwQy8g0_1700011584;
Received: from 30.240.112.215(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VwQy8g0_1700011584)
          by smtp.aliyun-inc.com;
          Wed, 15 Nov 2023 09:26:25 +0800
Message-ID: <011efd17-c384-4285-9de9-2e40640bec08@linux.alibaba.com>
Date:   Wed, 15 Nov 2023 09:26:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 4/5] drivers/perf: add DesignWare PCIe PMU driver
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     kaishen@linux.alibaba.com, helgaas@kernel.org,
        yangyicong@huawei.com, will@kernel.org,
        Jonathan.Cameron@huawei.com, baolin.wang@linux.alibaba.com,
        robin.murphy@arm.com, chengyou@linux.alibaba.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, rdunlap@infradead.org,
        mark.rutland@arm.com, zhuo.song@linux.alibaba.com,
        renyu.zj@linux.alibaba.com
References: <20231104133216.42056-1-xueshuai@linux.alibaba.com>
 <20231104133216.42056-5-xueshuai@linux.alibaba.com>
 <e053a5d-f2a8-86c7-5af-d211507140c4@os.amperecomputing.com>
Content-Language: en-US
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <e053a5d-f2a8-86c7-5af-d211507140c4@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023/11/15 08:07, Ilkka Koskinen wrote:
> 
> Hi Shuai,
> 
> On Sat, 4 Nov 2023, Shuai Xue wrote:
>> This commit adds the PCIe Performance Monitoring Unit (PMU) driver support
>> for T-Head Yitian SoC chip. Yitian is based on the Synopsys PCI Express
>> Core controller IP which provides statistics feature. The PMU is a PCIe
>> configuration space register block provided by each PCIe Root Port in a
>> Vendor-Specific Extended Capability named RAS D.E.S (Debug, Error
>> injection, and Statistics).
>>
>> To facilitate collection of statistics the controller provides the
>> following two features for each Root Port:
>>
>> - one 64-bit counter for Time Based Analysis (RX/TX data throughput and
>>  time spent in each low-power LTSSM state) and
>> - one 32-bit counter for Event Counting (error and non-error events for
>>  a specified lane)
>>
>> Note: There is no interrupt for counter overflow.
>>
>> This driver adds PMU devices for each PCIe Root Port. And the PMU device is
>> named based the BDF of Root Port. For example,
>>
>>    30:03.0 PCI bridge: Device 1ded:8000 (rev 01)
>>
>> the PMU device name for this Root Port is dwc_rootport_3018.
>>
>> Example usage of counting PCIe RX TLP data payload (Units of bytes)::
>>
>>    $# perf stat -a -e dwc_rootport_3018/Rx_PCIe_TLP_Data_Payload/
>>
>> average RX bandwidth can be calculated like this:
>>
>>    PCIe TX Bandwidth = Rx_PCIe_TLP_Data_Payload / Measure_Time_Window
>>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Yicong Yang <yangyicong@hisilicon.com>
> 
> Thanks for the driver! I finally found some time to test your driver on AmpereOne and it seemed to work fine. 

Glad to hear that. Could you please explicitly give me you tested-by tag? I could add it in next version.

I had to do a couple of changes though such as adding Ampere vendor ID and support multiple PCIe domains. Given your driver is already in v10 and you have got quite a few reviewed and acked bys, I wonder if it's better to add my changes to your patches or me to create new patches on top of yours? I'm fine with either. Any thoughts?

I prefer new separate patches, so that we can review them in a new loop.

> 
> Cheers, Ilkka

Best Regard,
Shuai

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83BCF4AD1EC
	for <lists+linux-pci@lfdr.de>; Tue,  8 Feb 2022 08:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbiBHHJB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Feb 2022 02:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbiBHHJB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Feb 2022 02:09:01 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8E9C0401F1;
        Mon,  7 Feb 2022 23:08:58 -0800 (PST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JtDXX4dRZz1FD31;
        Tue,  8 Feb 2022 15:04:44 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Feb 2022 15:08:55 +0800
CC:     <gregkh@linuxfoundation.org>, <helgaas@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <lorenzo.pieralisi@arm.com>,
        <will@kernel.org>, <mark.rutland@arm.com>,
        <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>, <leo.yan@linaro.org>,
        <daniel.thompson@linaro.org>, <joro@8bytes.org>,
        <john.garry@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
        <robin.murphy@arm.com>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <coresight@lists.linaro.org>, <linux-pci@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <prime.zeng@huawei.com>,
        <liuqi115@huawei.com>, <zhangshaokun@hisilicon.com>,
        <linuxarm@huawei.com>, <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH v3 4/8] hisi_ptt: Add tune function support for HiSilicon
 PCIe Tune and Trace device
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Yicong Yang <yangyicong@hisilicon.com>
References: <20220124131118.17887-1-yangyicong@hisilicon.com>
 <20220124131118.17887-5-yangyicong@hisilicon.com>
 <20220207114911.0000127e@Huawei.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <15ebb616-bc5a-f589-a435-c8322202661a@huawei.com>
Date:   Tue, 8 Feb 2022 15:08:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20220207114911.0000127e@Huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022/2/7 19:49, Jonathan Cameron wrote:
> On Mon, 24 Jan 2022 21:11:14 +0800
> Yicong Yang <yangyicong@hisilicon.com> wrote:
> 
>> Add tune function for the HiSilicon Tune and Trace device. The interface
>> of tune is exposed through sysfs attributes of PTT PMU device.
>>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> 
> A few trivial things inline, but looks good in general to me.
> With those tidied up
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 

Thanks for the comments.

> 
>> ---
>>  drivers/hwtracing/ptt/hisi_ptt.c | 154 +++++++++++++++++++++++++++++++
>>  drivers/hwtracing/ptt/hisi_ptt.h |  19 ++++
>>  2 files changed, 173 insertions(+)
>>
>> diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
>> index 2994354e690b..b11e702eb506 100644
>> --- a/drivers/hwtracing/ptt/hisi_ptt.c
>> +++ b/drivers/hwtracing/ptt/hisi_ptt.c
>> @@ -21,6 +21,159 @@
>>  
>>  #include "hisi_ptt.h"
>>  
>> +static int hisi_ptt_wait_tuning_finish(struct hisi_ptt *hisi_ptt)
>> +{
>> +	u32 val;
>> +
>> +	return readl_poll_timeout(hisi_ptt->iobase + HISI_PTT_TUNING_INT_STAT,
>> +				  val, !(val & HISI_PTT_TUNING_INT_STAT_MASK),
>> +				  HISI_PTT_WAIT_POLL_INTERVAL_US,
>> +				  HISI_PTT_WAIT_TIMEOUT_US);
>> +}
>> +
>> +static int hisi_ptt_tune_data_get(struct hisi_ptt *hisi_ptt,
>> +				  u32 event, u16 *data)
>> +{
>> +	u32 reg;
>> +
>> +	reg = readl(hisi_ptt->iobase + HISI_PTT_TUNING_CTRL);
>> +	reg &= ~(HISI_PTT_TUNING_CTRL_CODE | HISI_PTT_TUNING_CTRL_SUB);
>> +	reg |= FIELD_PREP(HISI_PTT_TUNING_CTRL_CODE | HISI_PTT_TUNING_CTRL_SUB,
>> +			  event);
>> +	writel(reg, hisi_ptt->iobase + HISI_PTT_TUNING_CTRL);
>> +
>> +	/* Write all 1 to indicates it's the read process */
>> +	writel(~0UL, hisi_ptt->iobase + HISI_PTT_TUNING_DATA);
> 
> Just to check, this is includes the bits above the DATA_VAL_MASK?
> Fine if so, just seems odd to define a field but then write 
> parts of the register that aren't part of that field.
> 

yes. The valid data field is [0,15]. But
all 1 is used here to indicate that it's a
read process rather than a write process.

>> +
>> +	if (hisi_ptt_wait_tuning_finish(hisi_ptt))
>> +		return -ETIMEDOUT;
>> +
>> +	reg = readl(hisi_ptt->iobase + HISI_PTT_TUNING_DATA);
>> +	reg &= HISI_PTT_TUNING_DATA_VAL_MASK;
>> +	*data = (u16)reg;
> 
> As below, prefer a FIELD_GET() for this.
> 

sure. will use field ops here and below.

Thanks.

>> +
>> +	return 0;
>> +}
>> +
>> +static int hisi_ptt_tune_data_set(struct hisi_ptt *hisi_ptt,
>> +				  u32 event, u16 data)
>> +{
>> +	u32 reg;
>> +
>> +	reg = readl(hisi_ptt->iobase + HISI_PTT_TUNING_CTRL);
>> +	reg &= ~(HISI_PTT_TUNING_CTRL_CODE | HISI_PTT_TUNING_CTRL_SUB);
>> +	reg |= FIELD_PREP(HISI_PTT_TUNING_CTRL_CODE | HISI_PTT_TUNING_CTRL_SUB,
>> +			  event);
>> +	writel(reg, hisi_ptt->iobase + HISI_PTT_TUNING_CTRL);
>> +
>> +	reg = data;
> Given you defined HISI_PTT_TUNING_DATA_VAL_MASK why not use it here
> 
> writel(FIELD_PREP(..), ...)? 
> 
>> +	writel(reg, hisi_ptt->iobase + HISI_PTT_TUNING_DATA);
>> +
>> +	if (hisi_ptt_wait_tuning_finish(hisi_ptt))
>> +		return -ETIMEDOUT;
>> +
>> +	return 0;
>> +}
>> +
> 
> 
> .
> 

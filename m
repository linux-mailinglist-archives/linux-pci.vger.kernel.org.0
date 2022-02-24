Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C1B4C22DE
	for <lists+linux-pci@lfdr.de>; Thu, 24 Feb 2022 05:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiBXEFX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Feb 2022 23:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiBXEFV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Feb 2022 23:05:21 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58FF25A94D;
        Wed, 23 Feb 2022 20:04:51 -0800 (PST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4K3zgs08J7zbbhm;
        Thu, 24 Feb 2022 11:59:53 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 24 Feb 2022 12:04:24 +0800
CC:     <prime.zeng@huawei.com>, <liuqi115@huawei.com>,
        <zhangshaokun@hisilicon.com>, <linuxarm@huawei.com>,
        <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH v4 3/8] hisi_ptt: Register PMU device for PTT trace
To:     John Garry <john.garry@huawei.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        <gregkh@linuxfoundation.org>, <helgaas@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <lorenzo.pieralisi@arm.com>,
        <will@kernel.org>, <mark.rutland@arm.com>,
        <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>, <leo.yan@linaro.org>,
        <jonathan.cameron@huawei.com>, <daniel.thompson@linaro.org>,
        <joro@8bytes.org>, <shameerali.kolothum.thodi@huawei.com>,
        <robin.murphy@arm.com>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <coresight@lists.linaro.org>, <linux-pci@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>
References: <20220221084307.33712-1-yangyicong@hisilicon.com>
 <20220221084307.33712-4-yangyicong@hisilicon.com>
 <f5b245a3-6a17-af4b-4dfe-a59868cacbb0@huawei.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <6cc5392d-528f-8e43-1792-866be8b7d6f9@huawei.com>
Date:   Thu, 24 Feb 2022 12:04:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <f5b245a3-6a17-af4b-4dfe-a59868cacbb0@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022/2/22 19:17, John Garry wrote:
> 
>> +
>>   static irqreturn_t hisi_ptt_irq(int irq, void *context)
>>   {
>>       struct hisi_ptt *hisi_ptt = context;
>> @@ -169,7 +233,7 @@ static irqreturn_t hisi_ptt_irq(int irq, void *context)
>>       if (!(status & HISI_PTT_TRACE_INT_STAT_MASK))
>>           return IRQ_NONE;
>>   -    return IRQ_HANDLED;
>> +    return IRQ_WAKE_THREAD;
>>   }
>>     static void hisi_ptt_irq_free_vectors(void *pdev)
>> @@ -192,8 +256,10 @@ static int hisi_ptt_register_irq(struct hisi_ptt *hisi_ptt)
>>       if (ret < 0)
>>           return ret;
>>   -    ret = devm_request_irq(&pdev->dev, pci_irq_vector(pdev, HISI_PTT_TRACE_DMA_IRQ),
>> -                   hisi_ptt_irq, 0, DRV_NAME, hisi_ptt);
>> +    ret = devm_request_threaded_irq(&pdev->dev,
> 
> why add code in patch 2/8 and then immediately change 3/8?
> 

My bad patch split. As replied to Patch 2, the whole IRQ handler part will be remove in Patch 2
and we won't have this changing here.

>> +                    pci_irq_vector(pdev, HISI_PTT_TRACE_DMA_IRQ),
>> +                    hisi_ptt_irq, hisi_ptt_isr, 0,
>> +                    DRV_NAME, hisi_ptt);
>>       if (ret) {
>>           pci_err(pdev, "failed to request irq %d, ret = %d.\n",
>>               pci_irq_vector(pdev, HISI_PTT_TRACE_DMA_IRQ), ret);
>> @@ -270,6 +336,429 @@ static void hisi_ptt_init_ctrls(struct hisi_ptt *hisi_ptt)
>>       hisi_ptt->trace_ctrl.default_cpu = cpumask_first(cpumask_of_node(dev_to_node(&pdev->dev)));
>>   }
>>   +#define HISI_PTT_PMU_FILTER_IS_PORT    BIT(19)
>> +#define HISI_PTT_PMU_FILTER_VAL_MASK    GENMASK(15, 0)
>> +#define HISI_PTT_PMU_DIRECTION_MASK    GENMASK(23, 20)
>> +#define HISI_PTT_PMU_TYPE_MASK        GENMASK(31, 24)
>> +#define HISI_PTT_PMU_FORMAT_MASK    GENMASK(35, 32)
>> +
>> +static ssize_t available_root_port_filters_show(struct device *dev,
>> +                        struct device_attribute *attr,
>> +                        char *buf)
>> +{
>> +    struct hisi_ptt *hisi_ptt = to_hisi_ptt(dev_get_drvdata(dev));
>> +    struct hisi_ptt_filter_desc *filter;
>> +    int pos = 0;
>> +
>> +    if (list_empty(&hisi_ptt->port_filters))
>> +        return sysfs_emit(buf, "\n");
>> +
>> +    mutex_lock(&hisi_ptt->mutex);
>> +    list_for_each_entry(filter, &hisi_ptt->port_filters, list)
>> +        pos += sysfs_emit_at(buf, pos, "%s    0x%05lx\n",
>> +                     pci_name(filter->pdev),
>> +                     hisi_ptt_get_filter_val(filter->pdev) |
>> +                     HISI_PTT_PMU_FILTER_IS_PORT);
>> +
>> +    mutex_unlock(&hisi_ptt->mutex);
>> +    return pos;
>> +}
>> +static DEVICE_ATTR_ADMIN_RO(available_root_port_filters);
>> +
>> +static ssize_t available_requester_filters_show(struct device *dev,
>> +                        struct device_attribute *attr,
>> +                        char *buf)
>> +{
>> +    struct hisi_ptt *hisi_ptt = to_hisi_ptt(dev_get_drvdata(dev));
>> +    struct hisi_ptt_filter_desc *filter;
>> +    int pos = 0;
>> +
>> +    if (list_empty(&hisi_ptt->port_filters))
> 
> is this supposed to be req_filters? And is it safe to access without locking?
> 

Thanks for catching this! will fix it.

>> +        return sysfs_emit(buf, "\n");
>> +
>> +    mutex_lock(&hisi_ptt->mutex);
>> +    list_for_each_entry(filter, &hisi_ptt->req_filters, list)
>> +        pos += sysfs_emit_at(buf, pos, "%s    0x%05x\n",
>> +                     pci_name(filter->pdev),
>> +                     hisi_ptt_get_filter_val(filter->pdev));
>> +
>> +    mutex_unlock(&hisi_ptt->mutex);
>> +    return pos;
>> +}
>> +static DEVICE_ATTR_ADMIN_RO(available_requester_filters);
>> +
>> +PMU_FORMAT_ATTR(filter,        "config:0-19");
>> +PMU_FORMAT_ATTR(direction,    "config:20-23");
>> +PMU_FORMAT_ATTR(type,        "config:24-31");
>> +PMU_FORMAT_ATTR(format,        "config:32-35");
>> +
>> +static struct attribute *hisi_ptt_pmu_format_attrs[] = {
>> +    &format_attr_filter.attr,
>> +    &format_attr_direction.attr,
>> +    &format_attr_type.attr,
>> +    &format_attr_format.attr,
>> +    NULL
>> +};
>> +
>> +static struct attribute_group hisi_ptt_pmu_format_group = {
>> +    .name = "format",
>> +    .attrs = hisi_ptt_pmu_format_attrs,
>> +};
>> +
>> +static struct attribute *hisi_ptt_pmu_filter_attrs[] = {
>> +    &dev_attr_available_root_port_filters.attr,
>> +    &dev_attr_available_requester_filters.attr,
>> +    NULL
>> +};
>> +
>> +static struct attribute_group hisi_ptt_pmu_filter_group = {
>> +    .attrs = hisi_ptt_pmu_filter_attrs,
>> +};
>> +
>> +static const struct attribute_group *hisi_ptt_pmu_groups[] = {
>> +    &hisi_ptt_pmu_format_group,
>> +    &hisi_ptt_pmu_filter_group,
>> +    NULL
>> +};
>> +
>> +/*
>> + * The supported value of the direction parameter. See hisi_ptt.rst
>> + * documentation for more details.
>> + */
>> +static u32 hisi_ptt_trace_available_direction[] = {
>> +    0,
>> +    1,
>> +    2,
>> +    3,
> 
> this seems a very odd array.
> 

I copied part of the definition of this parameter from the hisi_ptt.rst below:

When the desired format is 4DW, directions and related values
supported are shown below:
4'b0000: inbound TLPs (P, NP, CPL)
4'b0001: outbound TLPs (P, NP, CPL)
4'b0010: outbound TLPs (P, NP, CPL) and inbound TLPs (P, NP, CPL B)
4'b0011: outbound TLPs (P, NP, CPL) and inbound TLPs (CPL A)
When the desired format is 8DW, directions and related values supported are
shown below:
4'b0000: reserved
4'b0001: outbound TLPs (P, NP, CPL)
4'b0010: inbound TLPs (P, NP, CPL B)
4'b0011: inbound TLPs (CPL A)

Since the meaning of the `direction` highly depends on the configuration of the `format`
so the meaning is not commented here but redirect the readers to the documentation
where have detailed description.

> And I assume it is const as it is modified - can this be non-global and tied to the device context?
> 

ok. will make const and into the functions which use this.

Thanks,
Yicong

>> +};
>> +
>> +/* Different types can be set simultaneously */
>> +static u32 hisi_ptt_trace_available_type[] = {
>> +    1,    /* posted_request */
>> +    2,    /* non-posted_request */
>> +    4,    /* completion */
>> +};
>> +
>> +static u32 hisi_ptt_trace_availble_format[] = {
>> +    0,    /* 4DW */
>> +    1,    /* 8DW */
>> +};
>> +
> .

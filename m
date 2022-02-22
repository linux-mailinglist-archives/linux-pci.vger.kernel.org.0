Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070514BF715
	for <lists+linux-pci@lfdr.de>; Tue, 22 Feb 2022 12:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbiBVLRi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Feb 2022 06:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbiBVLRh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Feb 2022 06:17:37 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A0E13CE6;
        Tue, 22 Feb 2022 03:17:08 -0800 (PST)
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K2xSQ5vX9z67XJ2;
        Tue, 22 Feb 2022 19:16:22 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Tue, 22 Feb 2022 12:17:05 +0100
Received: from [10.47.92.123] (10.47.92.123) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 22 Feb
 2022 11:17:04 +0000
Message-ID: <f5b245a3-6a17-af4b-4dfe-a59868cacbb0@huawei.com>
Date:   Tue, 22 Feb 2022 11:17:01 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v4 3/8] hisi_ptt: Register PMU device for PTT trace
To:     Yicong Yang <yangyicong@hisilicon.com>,
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
CC:     <prime.zeng@huawei.com>, <liuqi115@huawei.com>,
        <zhangshaokun@hisilicon.com>, <linuxarm@huawei.com>,
        <song.bao.hua@hisilicon.com>
References: <20220221084307.33712-1-yangyicong@hisilicon.com>
 <20220221084307.33712-4-yangyicong@hisilicon.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220221084307.33712-4-yangyicong@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.92.123]
X-ClientProxiedBy: lhreml730-chm.china.huawei.com (10.201.108.81) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


> +
>   static irqreturn_t hisi_ptt_irq(int irq, void *context)
>   {
>   	struct hisi_ptt *hisi_ptt = context;
> @@ -169,7 +233,7 @@ static irqreturn_t hisi_ptt_irq(int irq, void *context)
>   	if (!(status & HISI_PTT_TRACE_INT_STAT_MASK))
>   		return IRQ_NONE;
>   
> -	return IRQ_HANDLED;
> +	return IRQ_WAKE_THREAD;
>   }
>   
>   static void hisi_ptt_irq_free_vectors(void *pdev)
> @@ -192,8 +256,10 @@ static int hisi_ptt_register_irq(struct hisi_ptt *hisi_ptt)
>   	if (ret < 0)
>   		return ret;
>   
> -	ret = devm_request_irq(&pdev->dev, pci_irq_vector(pdev, HISI_PTT_TRACE_DMA_IRQ),
> -			       hisi_ptt_irq, 0, DRV_NAME, hisi_ptt);
> +	ret = devm_request_threaded_irq(&pdev->dev,

why add code in patch 2/8 and then immediately change 3/8?

> +					pci_irq_vector(pdev, HISI_PTT_TRACE_DMA_IRQ),
> +					hisi_ptt_irq, hisi_ptt_isr, 0,
> +					DRV_NAME, hisi_ptt);
>   	if (ret) {
>   		pci_err(pdev, "failed to request irq %d, ret = %d.\n",
>   			pci_irq_vector(pdev, HISI_PTT_TRACE_DMA_IRQ), ret);
> @@ -270,6 +336,429 @@ static void hisi_ptt_init_ctrls(struct hisi_ptt *hisi_ptt)
>   	hisi_ptt->trace_ctrl.default_cpu = cpumask_first(cpumask_of_node(dev_to_node(&pdev->dev)));
>   }
>   
> +#define HISI_PTT_PMU_FILTER_IS_PORT	BIT(19)
> +#define HISI_PTT_PMU_FILTER_VAL_MASK	GENMASK(15, 0)
> +#define HISI_PTT_PMU_DIRECTION_MASK	GENMASK(23, 20)
> +#define HISI_PTT_PMU_TYPE_MASK		GENMASK(31, 24)
> +#define HISI_PTT_PMU_FORMAT_MASK	GENMASK(35, 32)
> +
> +static ssize_t available_root_port_filters_show(struct device *dev,
> +						struct device_attribute *attr,
> +						char *buf)
> +{
> +	struct hisi_ptt *hisi_ptt = to_hisi_ptt(dev_get_drvdata(dev));
> +	struct hisi_ptt_filter_desc *filter;
> +	int pos = 0;
> +
> +	if (list_empty(&hisi_ptt->port_filters))
> +		return sysfs_emit(buf, "\n");
> +
> +	mutex_lock(&hisi_ptt->mutex);
> +	list_for_each_entry(filter, &hisi_ptt->port_filters, list)
> +		pos += sysfs_emit_at(buf, pos, "%s	0x%05lx\n",
> +				     pci_name(filter->pdev),
> +				     hisi_ptt_get_filter_val(filter->pdev) |
> +				     HISI_PTT_PMU_FILTER_IS_PORT);
> +
> +	mutex_unlock(&hisi_ptt->mutex);
> +	return pos;
> +}
> +static DEVICE_ATTR_ADMIN_RO(available_root_port_filters);
> +
> +static ssize_t available_requester_filters_show(struct device *dev,
> +						struct device_attribute *attr,
> +						char *buf)
> +{
> +	struct hisi_ptt *hisi_ptt = to_hisi_ptt(dev_get_drvdata(dev));
> +	struct hisi_ptt_filter_desc *filter;
> +	int pos = 0;
> +
> +	if (list_empty(&hisi_ptt->port_filters))

is this supposed to be req_filters? And is it safe to access without 
locking?

> +		return sysfs_emit(buf, "\n");
> +
> +	mutex_lock(&hisi_ptt->mutex);
> +	list_for_each_entry(filter, &hisi_ptt->req_filters, list)
> +		pos += sysfs_emit_at(buf, pos, "%s	0x%05x\n",
> +				     pci_name(filter->pdev),
> +				     hisi_ptt_get_filter_val(filter->pdev));
> +
> +	mutex_unlock(&hisi_ptt->mutex);
> +	return pos;
> +}
> +static DEVICE_ATTR_ADMIN_RO(available_requester_filters);
> +
> +PMU_FORMAT_ATTR(filter,		"config:0-19");
> +PMU_FORMAT_ATTR(direction,	"config:20-23");
> +PMU_FORMAT_ATTR(type,		"config:24-31");
> +PMU_FORMAT_ATTR(format,		"config:32-35");
> +
> +static struct attribute *hisi_ptt_pmu_format_attrs[] = {
> +	&format_attr_filter.attr,
> +	&format_attr_direction.attr,
> +	&format_attr_type.attr,
> +	&format_attr_format.attr,
> +	NULL
> +};
> +
> +static struct attribute_group hisi_ptt_pmu_format_group = {
> +	.name = "format",
> +	.attrs = hisi_ptt_pmu_format_attrs,
> +};
> +
> +static struct attribute *hisi_ptt_pmu_filter_attrs[] = {
> +	&dev_attr_available_root_port_filters.attr,
> +	&dev_attr_available_requester_filters.attr,
> +	NULL
> +};
> +
> +static struct attribute_group hisi_ptt_pmu_filter_group = {
> +	.attrs = hisi_ptt_pmu_filter_attrs,
> +};
> +
> +static const struct attribute_group *hisi_ptt_pmu_groups[] = {
> +	&hisi_ptt_pmu_format_group,
> +	&hisi_ptt_pmu_filter_group,
> +	NULL
> +};
> +
> +/*
> + * The supported value of the direction parameter. See hisi_ptt.rst
> + * documentation for more details.
> + */
> +static u32 hisi_ptt_trace_available_direction[] = {
> +	0,
> +	1,
> +	2,
> +	3,

this seems a very odd array.

And I assume it is const as it is modified - can this be non-global and 
tied to the device context?

> +};
> +
> +/* Different types can be set simultaneously */
> +static u32 hisi_ptt_trace_available_type[] = {
> +	1,	/* posted_request */
> +	2,	/* non-posted_request */
> +	4,	/* completion */
> +};
> +
> +static u32 hisi_ptt_trace_availble_format[] = {
> +	0,	/* 4DW */
> +	1,	/* 8DW */
> +};
> +

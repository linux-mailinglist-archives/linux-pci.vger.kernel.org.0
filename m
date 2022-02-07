Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C357A4ABEE6
	for <lists+linux-pci@lfdr.de>; Mon,  7 Feb 2022 14:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiBGNMW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Feb 2022 08:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392273AbiBGMJG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Feb 2022 07:09:06 -0500
X-Greylist: delayed 368 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 04:01:45 PST
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA8EC03FED2;
        Mon,  7 Feb 2022 04:01:45 -0800 (PST)
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jskkk5Zbgz67y8Z;
        Mon,  7 Feb 2022 19:41:50 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 7 Feb 2022 12:42:31 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 7 Feb
 2022 11:42:29 +0000
Date:   Mon, 7 Feb 2022 11:42:28 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Yicong Yang <yangyicong@hisilicon.com>
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
Subject: Re: [PATCH v3 2/8] hisi_ptt: Register PMU device for PTT trace
Message-ID: <20220207114228.00002e6f@Huawei.com>
In-Reply-To: <20220124131118.17887-3-yangyicong@hisilicon.com>
References: <20220124131118.17887-1-yangyicong@hisilicon.com>
        <20220124131118.17887-3-yangyicong@hisilicon.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml733-chm.china.huawei.com (10.201.108.84) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 24 Jan 2022 21:11:12 +0800
Yicong Yang <yangyicong@hisilicon.com> wrote:

> Register PMU device of PTT trace, then users can use
> trace through perf command. The driver makes use of perf
> AUX trace and support following events to configure the
> trace:
> 
> - filter: select Root port or Endpoint to trace
> - type: select the type of traced TLP headers
> - direction: select the direction of traced TLP headers
> - format: select the data format of the traced TLP headers
> 
> This patch adds the PMU driver part of PTT trace. The perf
> command support of PTT trace is added in the following
> patch.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---


> @@ -294,6 +346,405 @@ static void hisi_ptt_init_ctrls(struct hisi_ptt *hisi_ptt)
>  	hisi_ptt->trace_ctrl.default_cpu = cpumask_first(cpumask_of_node(dev_to_node(&pdev->dev)));
>  }
>  
> +#define HISI_PTT_PMU_FILTER_IS_PORT	BIT(19)
> +#define HISI_PTT_PMU_FILTER_VAL_MASK	GENMASK(15, 0)
> +#define HISI_PTT_PMU_DIRECTION_MASK	GENMASK(23, 20)
> +#define HISI_PTT_PMU_TYPE_MASK		GENMASK(31, 24)
> +#define HISI_PTT_PMU_FORMAT_MASK	GENMASK(35, 32)
> +
> +static ssize_t available_filters_show(struct device *dev,
> +				      struct device_attribute *attr,
> +				      char *buf)
> +{
> +	struct hisi_ptt *hisi_ptt = to_hisi_ptt(dev_get_drvdata(dev));
> +	struct hisi_ptt_filter_desc *filter;
> +	int pos = 0;
> +
> +	if (list_empty(&hisi_ptt->port_filters))
> +		return sysfs_emit(buf, "#### No available filter ####\n");
> +

This is a very unusual sysfs attribute.
They are supposed to be one "thing" per file, so I'd have expected this to
be at least two files

root_ports_available_filters
request_available_filters
and no available filter is indicated by these attribute returning an empty
string.

However you need to match convention for hwtracing drivers so if
this is common approach perhaps you could point me to a similar
example? My grep skills didn't find me one.

> +	mutex_lock(&hisi_ptt->mutex);
> +	pos += sysfs_emit_at(buf, pos, "#### Root Ports ####\n");
> +	list_for_each_entry(filter, &hisi_ptt->port_filters, list)
> +		pos += sysfs_emit_at(buf, pos, "%s	0x%05lx\n",
> +				     pci_name(filter->pdev),
> +				     hisi_ptt_get_filter_val(filter->pdev) |
> +				     HISI_PTT_PMU_FILTER_IS_PORT);
> +
> +	pos += sysfs_emit_at(buf, pos, "#### Requesters ####\n");
> +	list_for_each_entry(filter, &hisi_ptt->req_filters, list)
> +		pos += sysfs_emit_at(buf, pos, "%s	0x%05x\n",
> +				     pci_name(filter->pdev),
> +				     hisi_ptt_get_filter_val(filter->pdev));
> +
> +	mutex_unlock(&hisi_ptt->mutex);
> +	return pos;
> +}
> +static DEVICE_ATTR_ADMIN_RO(available_filters);
> +

...


> +static int hisi_ptt_trace_valid_config_onehot(u32 val, u32 *available_list, u32 list_size)
> +{
> +	int i, ret = -EINVAL;
> +
> +	for (i = 0; i < list_size; i++)
> +		if (val == available_list[i]) {
> +			ret = 0;

return 0;

> +			break;
> +		}
> +
> +	return ret;

return -EINVAL;

> +}
> +

> +
> +static void hisi_ptt_pmu_free_aux(void *aux)
> +{
> +	struct hisi_ptt_pmu_buf *buf = aux;
> +
> +	vunmap(buf->base);
> +	kfree(buf);
> +}
> +


...

> +static int hisi_ptt_pmu_add(struct perf_event *event, int flags)
> +{
> +	struct hisi_ptt *hisi_ptt = to_hisi_ptt(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	int cpu = event->cpu;
> +
> +	if (cpu == -1 && smp_processor_id() != hisi_ptt->trace_ctrl.default_cpu)

This check is not entirely obvious to me. Perhaps a comment would help
readers understand why this condition is successful, but doesn't involve
actually starting the pmu?

> +		return 0;
> +
> +	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
> +
> +	if (flags & PERF_EF_START) {
> +		hisi_ptt_pmu_start(event, PERF_EF_RELOAD);
> +		if (hwc->state & PERF_HES_STOPPED)
> +			return -EINVAL;
> +	}
> +
> +	return 0;
> +}

...

>  /*
>   * The DMA of PTT trace can only use direct mapping, due to some
>   * hardware restriction. Check whether there is an iommu or the
> @@ -359,6 +810,12 @@ static int hisi_ptt_probe(struct pci_dev *pdev,
>  
>  	hisi_ptt_init_ctrls(hisi_ptt);
>  
> +	ret = hisi_ptt_register_pmu(hisi_ptt);
> +	if (ret) {
> +		pci_err(pdev, "failed to register pmu device, ret = %d", ret);

Given I think this exposes userspace interfaces, it should be the very
last thing done in probe(). Otherwise we have a race condition (at least in
theory) where someone starts using it before we then fail the iommu mapping check.


> +		return ret;
> +	}
> +
>  	ret = hisi_ptt_check_iommu_mapping(hisi_ptt);
>  	if (ret) {
>  		pci_err(pdev, "cannot work with non-direct DMA mapping.\n");

Thanks,

Jonathan


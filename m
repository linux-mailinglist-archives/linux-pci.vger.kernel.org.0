Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A233A4BE26D
	for <lists+linux-pci@lfdr.de>; Mon, 21 Feb 2022 18:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359028AbiBUN1B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Feb 2022 08:27:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359071AbiBUN1A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Feb 2022 08:27:00 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78925598;
        Mon, 21 Feb 2022 05:26:35 -0800 (PST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4K2NK81nbWz8wtB;
        Mon, 21 Feb 2022 21:23:08 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 21 Feb 2022 21:26:32 +0800
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
Subject: Re: [PATCH v4 3/8] hisi_ptt: Register PMU device for PTT trace
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Yicong Yang <yangyicong@hisilicon.com>
References: <20220221084307.33712-1-yangyicong@hisilicon.com>
 <20220221084307.33712-4-yangyicong@hisilicon.com>
 <20220221114428.000062cd@Huawei.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <b8e2ef7e-8a24-e2aa-bd60-0989202c865d@huawei.com>
Date:   Mon, 21 Feb 2022 21:26:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20220221114428.000062cd@Huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

On 2022/2/21 19:44, Jonathan Cameron wrote:
> On Mon, 21 Feb 2022 16:43:02 +0800
> Yicong Yang <yangyicong@hisilicon.com> wrote:
> 
>> Register PMU device of PTT trace, then users can use
>> trace through perf command. The driver makes use of perf
>> AUX trace and support following events to configure the
>> trace:
>>
>> - filter: select Root port or Endpoint to trace
>> - type: select the type of traced TLP headers
>> - direction: select the direction of traced TLP headers
>> - format: select the data format of the traced TLP headers
>>
>> This patch adds the PMU driver part of PTT trace. The perf
>> command support of PTT trace is added in the following
>> patch.
>>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> 
> A few minor comments inline.
> 

Thanks for the comments!

> Thanks,
> 
> Jonathan
> 
>> +static int hisi_ptt_trace_init_filter(struct hisi_ptt *hisi_ptt, u64 config)
>> +{
>> +	unsigned long val, port_mask = hisi_ptt->port_mask;
>> +	struct hisi_ptt_filter_desc *filter;
>> +	int ret = -EINVAL;
>> +
>> +	hisi_ptt->trace_ctrl.is_port = FIELD_GET(HISI_PTT_PMU_FILTER_IS_PORT, config);
>> +	val = FIELD_GET(HISI_PTT_PMU_FILTER_VAL_MASK, config);
>> +
>> +	/*
>> +	 * Port filters are defined as bit mask. For port filters, check
>> +	 * the bits in the @val are within the range of hisi_ptt->port_mask
>> +	 * and whether it's empty or not, otherwise user has specified
>> +	 * some unsupported root ports.
>> +	 *
>> +	 * For Requester ID filters, walk the available filter list to see
>> +	 * whether we have one matched.
>> +	 */
>> +	if (!hisi_ptt->trace_ctrl.is_port) {
>> +		list_for_each_entry(filter, &hisi_ptt->req_filters, list)
>> +			if (val == hisi_ptt_get_filter_val(filter->pdev)) {
>> +				ret = 0;
>> +				break;
>> +			}
>> +	} else if (bitmap_subset(&val, &port_mask, BITS_PER_LONG)) {
>> +		ret = 0;
>> +	}
>> +
>> +	if (ret)
>> +		return ret;
>> +
>> +	hisi_ptt->trace_ctrl.filter = val;
>> +	return 0;
>> +}
>> +
>> +static int hisi_ptt_pmu_event_init(struct perf_event *event)
>> +{
>> +	struct hisi_ptt *hisi_ptt = to_hisi_ptt(event->pmu);
>> +	struct hisi_ptt_trace_ctrl *ctrl = &hisi_ptt->trace_ctrl;
>> +	int ret;
>> +	u32 val;
>> +
>> +	if (event->attr.type != hisi_ptt->hisi_ptt_pmu.type)
>> +		return -ENOENT;
>> +
>> +	mutex_lock(&hisi_ptt->mutex);
>> +
>> +	ret = hisi_ptt_trace_init_filter(hisi_ptt, event->attr.config);
>> +	if (ret < 0)
>> +		goto out;
>> +
>> +	val = FIELD_GET(HISI_PTT_PMU_DIRECTION_MASK, event->attr.config);
>> +	ret = hisi_ptt_trace_valid_config_onehot(val, hisi_ptt_trace_available_direction,
>> +						 ARRAY_SIZE(hisi_ptt_trace_available_direction));
>> +	if (ret < 0)
>> +		goto out;
>> +	ctrl->direction = val;
>> +
>> +	val = FIELD_GET(HISI_PTT_PMU_TYPE_MASK, event->attr.config);
>> +
> 
> For consistency, no blank line here.
> 

will drop it.

>> +	ret = hisi_ptt_trace_valid_config(val, hisi_ptt_trace_available_type,
>> +					  ARRAY_SIZE(hisi_ptt_trace_available_type));
>> +	if (ret < 0)
>> +		goto out;
>> +	ctrl->type = val;
>> +
>> +	val = FIELD_GET(HISI_PTT_PMU_FORMAT_MASK, event->attr.config);
>> +	ret = hisi_ptt_trace_valid_config_onehot(val, hisi_ptt_trace_availble_format,
>> +						 ARRAY_SIZE(hisi_ptt_trace_availble_format));
>> +	if (ret < 0)
>> +		goto out;
>> +	ctrl->format = val;
>> +
>> +out:
>> +	mutex_unlock(&hisi_ptt->mutex);
>> +	return ret;
>> +}
> 
> ...
> 
>> +
>> +static void hisi_ptt_pmu_start(struct perf_event *event, int flags)
>> +{
>> +	struct hisi_ptt *hisi_ptt = to_hisi_ptt(event->pmu);
>> +	struct perf_output_handle *handle = &hisi_ptt->trace_ctrl.handle;
>> +	struct hw_perf_event *hwc = &event->hw;
>> +	struct hisi_ptt_pmu_buf *buf;
>> +	int cpu = event->cpu;
>> +	int ret;
>> +
>> +	hwc->state = 0;
>> +	mutex_lock(&hisi_ptt->mutex);
>> +	if (hisi_ptt->trace_ctrl.status == HISI_PTT_TRACE_STATUS_ON) {
>> +		pci_dbg(hisi_ptt->pdev, "trace has already started\n");
>> +		goto stop;
> 
> If it is already started setting the state to STOPPED without doing anything
> to change the hardware state doesn't feel right.

I think it won't happen as we follow the order to stop the hardware and then
set the HISI_PTT_TRACE_STATUS_OFF flags.

But it makes me read start/stop process again and I find that I should set the
HISI_PTT_TRACE_STATUS_ON first before I start the hardware. Now it maybe problematic.

> I'm assuming we only get here as a result of a bug, so perhaps its fine
> to do this.
> 
>> +	}
>> +
>> +	if (cpu == -1)
>> +		cpu = hisi_ptt->trace_ctrl.default_cpu;
>> +
>> +	/*
>> +	 * Handle the interrupt on the same cpu which starts the trace to avoid
>> +	 * context mismatch. Otherwise we'll trigger the WARN from the perf
>> +	 * core in event_function_local().
>> +	 */
>> +	WARN_ON(irq_set_affinity(pci_irq_vector(hisi_ptt->pdev, HISI_PTT_TRACE_DMA_IRQ),
>> +				 cpumask_of(cpu)));
>> +
>> +	ret = hisi_ptt_alloc_trace_buf(hisi_ptt);
>> +	if (ret) {
>> +		pci_dbg(hisi_ptt->pdev, "alloc trace buf failed, ret = %d\n", ret);
>> +		goto stop;
>> +	}
>> +
>> +	buf = perf_aux_output_begin(handle, event);
>> +	if (!buf) {
>> +		pci_dbg(hisi_ptt->pdev, "aux output begin failed\n");
>> +		goto stop;
>> +	}
>> +
>> +	buf->pos = handle->head % buf->length;
>> +
>> +	ret = hisi_ptt_trace_start(hisi_ptt);
>> +	if (ret) {
>> +		pci_dbg(hisi_ptt->pdev, "trace start failed, ret = %d\n", ret);
>> +		perf_aux_output_end(handle, 0);
>> +		goto stop;
>> +	}
>> +
>> +	mutex_unlock(&hisi_ptt->mutex);
>> +	return;
>> +stop:
>> +	event->hw.state |= PERF_HES_STOPPED;
>> +	mutex_unlock(&hisi_ptt->mutex);
>> +}
>> +
> 
> ...
> 
>> +static int hisi_ptt_register_pmu(struct hisi_ptt *hisi_ptt)
>> +{
>> +	u16 core_id, sicl_id;
>> +	char *pmu_name;
>> +	int ret;
>> +	u32 reg;
>> +
>> +	hisi_ptt->hisi_ptt_pmu = (struct pmu) {
>> +		.module		= THIS_MODULE,
>> +		.capabilities	= PERF_PMU_CAP_EXCLUSIVE | PERF_PMU_CAP_ITRACE,
>> +		.task_ctx_nr	= perf_sw_context,
>> +		.attr_groups	= hisi_ptt_pmu_groups,
>> +		.event_init	= hisi_ptt_pmu_event_init,
>> +		.setup_aux	= hisi_ptt_pmu_setup_aux,
>> +		.free_aux	= hisi_ptt_pmu_free_aux,
>> +		.start		= hisi_ptt_pmu_start,
>> +		.stop		= hisi_ptt_pmu_stop,
>> +		.add		= hisi_ptt_pmu_add,
>> +		.del		= hisi_ptt_pmu_del,
>> +	};
>> +
>> +	reg = readl(hisi_ptt->iobase + HISI_PTT_LOCATION);
>> +	core_id = FIELD_GET(HISI_PTT_CORE_ID, reg);
>> +	sicl_id = FIELD_GET(HISI_PTT_SICL_ID, reg);
>> +
>> +	pmu_name = devm_kasprintf(&hisi_ptt->pdev->dev, GFP_KERNEL, "hisi_ptt%u_%u",
>> +				  sicl_id, core_id);
>> +	if (!pmu_name)
>> +		return -ENOMEM;
>> +
>> +	ret = perf_pmu_register(&hisi_ptt->hisi_ptt_pmu, pmu_name, -1);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return devm_add_action_or_reset(&hisi_ptt->pdev->dev,
>> +					hisi_ptt_unregister_pmu,
>> +					&hisi_ptt->hisi_ptt_pmu);
> 
> This result in the cleanup of the driver being slightly out of order wrt to
> the setup as we have the filters cleared after this (in remove())
> Ideally the remove() ordering should be the precise reverse of the
> probe() order except where it is necessary to deviate from that and
> in those deviations I'd expect to see a comment saying why.
> 
> So either clear up the filters using a devm_add_action_or_reset()
> or do a manual unregister of the pmu in remove. I prefer the
> devm_add_action_or_reset for hisi_ptt_release_filters() option.
> 
> There may well not be a race here, but it is always good to avoid
> reviewers having to think about whether there might be one!
> 
> Note that other reviewers may have different views on this however
> so perhaps go with what they say as this subsystem isn't my area
> of expertise!
> 

I'd like to think a bit more time about the orders here before reply. :)

Thanks,
Yicong

>> +}
>> +
>>  /*
>>   * The DMA of PTT trace can only use direct mapping, due to some
>>   * hardware restriction. Check whether there is an IOMMU or the
>> @@ -337,6 +826,12 @@ static int hisi_ptt_probe(struct pci_dev *pdev,
>>  
>>  	hisi_ptt_init_ctrls(hisi_ptt);
>>  
>> +	ret = hisi_ptt_register_pmu(hisi_ptt);
>> +	if (ret) {
>> +		pci_err(pdev, "failed to register pmu device, ret = %d", ret);
>> +		return ret;
>> +	}
>> +
>>  	return 0;
>>  }
>>  
> .
> 

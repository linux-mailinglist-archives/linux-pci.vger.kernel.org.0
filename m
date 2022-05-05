Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBCF51BF04
	for <lists+linux-pci@lfdr.de>; Thu,  5 May 2022 14:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239091AbiEEMRg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 May 2022 08:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240101AbiEEMRg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 May 2022 08:17:36 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DBC6554;
        Thu,  5 May 2022 05:13:55 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KvCD767QrzHnV7;
        Thu,  5 May 2022 20:09:11 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 5 May 2022 20:13:52 +0800
CC:     <gregkh@linuxfoundation.org>, <helgaas@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <lorenzo.pieralisi@arm.com>,
        <will@kernel.org>, <mark.rutland@arm.com>,
        <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>, <jonathan.cameron@huawei.com>,
        <daniel.thompson@linaro.org>, <joro@8bytes.org>,
        <john.garry@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
        <robin.murphy@arm.com>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <coresight@lists.linaro.org>, <linux-pci@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <zhangshaokun@hisilicon.com>,
        <liuqi115@huawei.com>, <linuxarm@huawei.com>,
        <prime.zeng@huawei.com>, Yicong Yang <yangyicong@hisilicon.com>
Subject: Re: [PATCH v7 2/7] hwtracing: Add trace function support for
 HiSilicon PCIe Tune and Trace device
To:     Leo Yan <leo.yan@linaro.org>
References: <20220407125841.3678-1-yangyicong@hisilicon.com>
 <20220407125841.3678-3-yangyicong@hisilicon.com>
 <20220429160033.GA650111@leoy-ThinkPad-X240s>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <daab811c-1841-5bc7-1077-3becba4b3260@huawei.com>
Date:   Thu, 5 May 2022 20:13:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20220429160033.GA650111@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Leo,

Thanks for the comments. Some questions and replies below.

On 2022/4/30 0:00, Leo Yan wrote:
> On Thu, Apr 07, 2022 at 08:58:36PM +0800, Yicong Yang via iommu wrote:
>> HiSilicon PCIe tune and trace device(PTT) is a PCIe Root Complex integrated
>> Endpoint(RCiEP) device, providing the capability to dynamically monitor and
>> tune the PCIe traffic, and trace the TLP headers.
>>
>> Add the driver for the device to enable the trace function. Register PMU
>> device of PTT trace, then users can use trace through perf command. The
>> driver makes use of perf AUX trace and support following events to
>> configure the trace:
>>
>> - filter: select Root port or Endpoint to trace
>> - type: select the type of traced TLP headers
>> - direction: select the direction of traced TLP headers
>> - format: select the data format of the traced TLP headers
>>
>> This patch adds the driver part of PTT trace. The perf command support of
>> PTT trace is added in the following patch.
>>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
[...]
>> +static int hisi_ptt_update_aux(struct hisi_ptt *hisi_ptt, int index, bool stop)
>> +{
>> +	struct hisi_ptt_trace_ctrl *ctrl = &hisi_ptt->trace_ctrl;
>> +	struct perf_output_handle *handle = &ctrl->handle;
>> +	struct perf_event *event = handle->event;
>> +	struct hisi_ptt_pmu_buf *buf;
>> +	void *addr;
>> +
>> +	buf = perf_get_aux(handle);
>> +	if (!buf || !handle->size)
>> +		return -EINVAL;
>> +
>> +	addr = ctrl->trace_buf[ctrl->buf_index].addr;
>> +
>> +	memcpy(buf->base + buf->pos, addr, HISI_PTT_TRACE_BUF_SIZE);
>> +	memset(addr, 0, HISI_PTT_TRACE_BUF_SIZE);
> 
> I am a bit worry buffer usages, at least for below aspects:
> 
> The first thing is for memset(), which cleans up the buffer and the
> buffer size is 4MiB, this means it will consume much CPU time to
> cleanup the buffer, and trace_buf is mapped as non-cacheable, the
> performance would be get worse.
> 
> The second thing is here it always copies the trace data with size
> HISI_PTT_TRACE_BUF_SIZE, usually, the trace module can provide a read
> pointer register, so you can know the trace data length based on the
> delta value between write and read pointers.
> 
> The last thing is the ctrl->trace_buf[] works as bounce buffer, so it
> means actually there have an extra copy from bounce buffer to AUX
> buffer, is it possible to directly output PTT trace data to AUX buffer?
> 
> Sorry if I bring up duplicate questions and before have the simliar
> discussion when reviewed the patch.
> 

The hardware is designed to use 4 DMA buffers and fill the buffer with the
traced data one by one. When one buffer is full the device will notify the
driver by interrupt and continue to trace the PCIe TLPs in the following
buffer without pausing. If the interrupt status bit of the buffer going to
use is uncleared, the trace will be paused until the corresponding interrupt
status bit is cleared. So the buffer size of 4 MiB is calculated that even
at the max flow the driver can handle the traced data and clear the status
in time, so there won't be a data loss.

For the first thing, the performance is acceptable as we only handle 4MiB at
one time. It's in thread context so we won't block others. The hardware can
keep tracing in the following DMA buffer so handling here won't pause the
trace and will not cause data loss.

For the second thing, this function is called in 2 places: 1) in the IRQ thread
2) the trace is going to stop. In the 1st case the data length will always be
HISI_PTT_TRACE_BUF_SIZE as the interrupt only occurs when one buffer is full.
In the 2nd case we may not have HISI_PTT_TRACE_BUF_SIZE data, the unfilled buffer
is zeroed to be distinguished. We keep committing HISI_PTT_TRACE_BUF_SIZE data
to keep consistence with handling in interrupt and make it simpler here.
(HISI_PTT_TRACE_WR_STS register indicates will buffer is currently used and
the offset in the buffer data is currently writing to)

For the third thing, I'm not sure if we can map the AUX buffer as DMA buffer
and by taht way, considering the case the buffer is full and we need to commit
the AUX buffer and apply a new one, the trace is paused during the procedure and
any TLPs on the link will be missed. But by current approach we won't have
this problem as the tracing is still on even when we're committing the AUX
buffer as the hardware is not directly writing to it.

>> +	buf->pos += HISI_PTT_TRACE_BUF_SIZE;
>> +
>> +	if (stop) {
>> +		perf_aux_output_end(handle, buf->pos);
>> +	} else if (buf->length - buf->pos < HISI_PTT_TRACE_BUF_SIZE) {
>> +		perf_aux_output_skip(handle, buf->length - buf->pos);
>> +		perf_aux_output_end(handle, buf->pos);
>> +
>> +		buf = perf_aux_output_begin(handle, event);
>> +		if (!buf)
>> +			return -EINVAL;
>> +
>> +		buf->pos = handle->head % buf->length;
>> +		if (buf->length - buf->pos < HISI_PTT_TRACE_BUF_SIZE) {
>> +			perf_aux_output_end(handle, 0);
>> +			return -EINVAL;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
[...]
>> +static int hisi_ptt_pmu_event_init(struct perf_event *event)
>> +{
>> +	/*
>> +	 * The supported value of the direction parameter. See hisi_ptt.rst
>> +	 * documentation for more details.
>> +	 */
>> +	static const u32 hisi_ptt_trace_available_direction[] = {
>> +		0,
>> +		1,
>> +		2,
>> +		3,
>> +	};
>> +	/* Different types can be set simultaneously */
>> +	static const u32 hisi_ptt_trace_available_type[] = {
>> +		1,	/* posted_request */
>> +		2,	/* non-posted_request */
>> +		4,	/* completion */
>> +	};
>> +	static const u32 hisi_ptt_trace_availble_format[] = {
>> +		0,	/* 4DW */
>> +		1,	/* 8DW */
>> +	};
>> +	struct hisi_ptt *hisi_ptt = to_hisi_ptt(event->pmu);
>> +	struct hisi_ptt_trace_ctrl *ctrl = &hisi_ptt->trace_ctrl;
>> +	int ret;
>> +	u32 val;
>> +
>> +	if (event->attr.type != hisi_ptt->hisi_ptt_pmu.type)
>> +		return -ENOENT;
> 
> Does PTT support per-task mode?  Usually PMU not binding to CPU
> cannot support per-task mode, if this is the case, please add checking
> like below (copied code from arm_smmuv3_pmu.c):
> 

PTT doesn't support per-task mode. It's not relevant to a certain task.
Will add the check here.

>          if (event->cpu < 0) {
>                  dev_dbg(dev, "Per-task mode not supported\n");
>                  return -EOPNOTSUPP;
>          }
> 
>> +
>> +	mutex_lock(&hisi_ptt->mutex);
> 
> Here really need mutex for protection?  I think the question can be
> extended as "if the mutex is necessary for the whole driver"?
> 
> The reason is the perf core layer has provided the APIs
> perf_event_ctx_lock() and perf_event_ctx_unlock() to protect event
> context, and perf core layer has the mutex 'event->mmap_mutex' to
> protect setup_aux().
> 

But I don't think the same things are protected here. For PTT trace part,
the mutex intends to 1)protect the filter lists and 2) serialize perf
process to enter start stage.

For 1), the filters in initialized in probe stage and can be dynamically
updated (implemented in Patch 3/7). So the mutex is used to protect the
filter from concurrent access by perf and the updating process. (In this
patch it maybe unnecessary as the filter is static).

For 2), it's used below in ->start() to serialize the CPUs entering start().
Since we want only one CPU to really start the trace. Without the lock,
the cases below may happen:

CPU0				CPU1
start()
.				start()
.				//trace_ctrl.started=false, go on
.				.
hisi_ptt_trace_start()		.
  trace_ctrl.started=true	.
				hisi_ptt_trace_start()

There're some PMU drivers using driver_struct::pmu_lock to serialize the
access to hardware registers and I think the usage is similar (referred to
qcom_l2_pmu.c and arm_dsu_pmu.c).

One thing here as mentioned that I used the mutex for the whole driver,
maybe it's better to split the lock of protecting the filter list and for
the perf process. And the lock for serializing the perf process should
be spinlock as ->start() is in atomic context, I think.

> Please note, I think init_event() callback is not protected by lock,
> so you could see many PMU drivers use init_event() callback to
> validate if the event parameters (e.g. if can work as group events
> with other hardware events, support stack track, etc).
> 
> This means below initialise functions should be moved to add()
> or setup_aux() callbacks, since these functions have been protected by
> mutex in perf core layer.
> 

Thanks for the note. Then the handling here is not proper. Will check and
validate the configs here in ->event_init() and move the real initialization
to ->add()/->setup_aux().

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
>> +
>> +static void *hisi_ptt_pmu_setup_aux(struct perf_event *event, void **pages,
>> +				    int nr_pages, bool overwrite)
>> +{
>> +	struct hisi_ptt_pmu_buf *buf;
>> +	struct page **pagelist;
>> +	int i;
>> +
>> +	if (overwrite) {
>> +		dev_warn(event->pmu->dev, "Overwrite mode is not supported\n");
>> +		return NULL;
>> +	}
>> +
>> +	/* If the pages size less than buffers, we cannot start trace */
>> +	if (nr_pages < HISI_PTT_TRACE_TOTAL_BUF_SIZE / PAGE_SIZE)
>> +		return NULL;
>> +
>> +	buf = kzalloc(sizeof(*buf), GFP_KERNEL);
>> +	if (!buf)
>> +		return NULL;
>> +
>> +	pagelist = kcalloc(nr_pages, sizeof(*pagelist), GFP_KERNEL);
>> +	if (!pagelist) {
>> +		kfree(buf);
>> +		return NULL;
>> +	}
>> +
>> +	for (i = 0; i < nr_pages; i++)
>> +		pagelist[i] = virt_to_page(pages[i]);
>> +
>> +	buf->base = vmap(pagelist, nr_pages, VM_MAP, PAGE_KERNEL);
>> +	if (!buf->base) {
>> +		kfree(pagelist);
>> +		kfree(buf);
>> +		return NULL;
>> +	}
>> +
>> +	buf->nr_pages = nr_pages;
>> +	buf->length = nr_pages * PAGE_SIZE;
>> +	buf->pos = 0;
>> +
>> +	kfree(pagelist);
>> +	return buf;
>> +}
>> +
>> +static void hisi_ptt_pmu_free_aux(void *aux)
>> +{
>> +	struct hisi_ptt_pmu_buf *buf = aux;
>> +
>> +	vunmap(buf->base);
>> +	kfree(buf);
>> +}
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
>> +	if (hisi_ptt->trace_ctrl.started) {
>> +		pci_dbg(hisi_ptt->pdev, "trace has already started\n");
> 
> Essentialy this is not a PCI driver, it's good to use dev_dbg()
> variant in the whole driver.
> 

It does make sense. will change to use dev_dbg().

>> +		goto stop;
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
> 
> Nitpick: Can set the irq affinity in the probe phase?  Seems to me,
> the driver has enough info to set irq affinity in the probe phase,
> it's not very necessary to defer to set irq affinity at here.
> 

We incline to use the cpu on the same node with PTT device. But here intends to handle
the case that user has specified a certain cpu with `perf record -C xxx` and we have to
bind the IRQ to that cpu. In which case we cannot handle in the probe stage.

>> +
>> +	ret = hisi_ptt_alloc_trace_buf(hisi_ptt);
>> +	if (ret) {
>> +		pci_dbg(hisi_ptt->pdev, "alloc trace buf failed, ret = %d\n", ret);
>> +		goto stop;
>> +	}
> 
> It's not a good idea to allocate buffer in the start().  The reason is
> start() function might be invoked for multiple times in a perf
> session.  I understand the PTT driver doesn't support per-thread mode
> and snapshot mode, so the start() callback will be not invoked for
> multiple times, but you might need to consider if later support snapshot
> mode.
> 
> I think it's better to move the buffer allocation into setup_aux().
> 

Thanks for the suggestion. John has noticed the similar that we don't need to allocate
and configure the buffer every time we start trace. So I'll move the allocation
and configuration of DMA buffers into probe stage, then we only need to do it once
and just clear the buffers every time we start trace.

Thanks,
Yicong



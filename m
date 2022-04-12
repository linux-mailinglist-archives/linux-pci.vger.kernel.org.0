Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A554FDB89
	for <lists+linux-pci@lfdr.de>; Tue, 12 Apr 2022 12:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235948AbiDLKEv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Apr 2022 06:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389914AbiDLJYV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2022 05:24:21 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0698F237FC;
        Tue, 12 Apr 2022 01:39:37 -0700 (PDT)
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KczcX2BYzz67ySG;
        Tue, 12 Apr 2022 16:37:32 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Tue, 12 Apr 2022 10:39:35 +0200
Received: from [10.47.91.197] (10.47.91.197) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 12 Apr
 2022 09:39:33 +0100
Message-ID: <49b24812-dafc-4ff9-a79b-07d1e2c6364b@huawei.com>
Date:   Tue, 12 Apr 2022 09:39:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v7 2/7] hwtracing: Add trace function support for
 HiSilicon PCIe Tune and Trace device
To:     Yicong Yang <yangyicong@huawei.com>,
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
CC:     <prime.zeng@huawei.com>, <liuqi115@huawei.com>,
        <zhangshaokun@hisilicon.com>, <linuxarm@huawei.com>
References: <20220407125841.3678-1-yangyicong@hisilicon.com>
 <20220407125841.3678-3-yangyicong@hisilicon.com>
 <36eea2f6-3461-72ad-05c4-953484197911@huawei.com>
 <60159327-7b6c-38cc-97a9-bb4c594b494f@huawei.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <60159327-7b6c-38cc-97a9-bb4c594b494f@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.91.197]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

>>> +static int hisi_ptt_alloc_trace_buf(struct hisi_ptt *hisi_ptt)
>>> +{
>>> +    struct hisi_ptt_trace_ctrl *ctrl = &hisi_ptt->trace_ctrl;
>>> +    struct device *dev = &hisi_ptt->pdev->dev;
>>> +    int i;
>>> +
>>> +    hisi_ptt->trace_ctrl.buf_index = 0;
>>> +
>>> +    /* If the trace buffer has already been allocated, zero it. */
>>
>> I am not sure why this is not called from the probe
>>
> 
> The buffer allocation is done when necessary as driver will probe the device on booting but
> the user may never use it. In this condition it's a waste of memory if we allocate the buffers
> in probe. Currently we'll allocate 16M memory for 4 buffers.
> 

But that's just not how we do things. We setup the driver fully to be 
used in the probe. If the user cannot really afford the memory then 
he/she should not load the driver.

In addition, this driver would be used in a machine which will have 
gigbytes of memory, so I think that the memory mentioned here is 
relatively insignificant.

> So this function is called every time before we start trace. In the first time it will allocate
> the DMA buffers and it the other times it just zero the buffers to clear the data of last time.
> 
>>> +    if (ctrl->trace_buf) {
>>> +        for (i = 0; i < HISI_PTT_TRACE_BUF_CNT; i++)
>>> +            memset(ctrl->trace_buf[i].addr, 0, HISI_PTT_TRACE_BUF_SIZE);
>>> +        return 0;
>>> +    }
>>> +
>>> +    ctrl->trace_buf = devm_kcalloc(dev, HISI_PTT_TRACE_BUF_CNT,
>>> +                       sizeof(struct hisi_ptt_dma_buffer), GFP_KERNEL);
>>
>> sizeof(*ctrl->trace_buf) may be better
>>
> 
> ok.
> 
>>> +    if (!ctrl->trace_buf)
>>> +        return -ENOMEM;
>>> +
>>> +    for (i = 0; i < HISI_PTT_TRACE_BUF_CNT; ++i) {
>>> +        ctrl->trace_buf[i].addr = dmam_alloc_coherent(dev, HISI_PTT_TRACE_BUF_SIZE,
>>> +                                 &ctrl->trace_buf[i].dma,
>>> +                                 GFP_KERNEL);
>>> +        if (!ctrl->trace_buf[i].addr) {
>>> +            hisi_ptt_free_trace_buf(hisi_ptt);
>>> +            return -ENOMEM;
>>> +        }
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static void hisi_ptt_trace_end(struct hisi_ptt *hisi_ptt)
>>> +{
>>> +    writel(0, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
>>> +    hisi_ptt->trace_ctrl.started = false;
>>> +}
>>> +
>>> +static int hisi_ptt_trace_start(struct hisi_ptt *hisi_ptt)
>>> +{
>>> +    struct hisi_ptt_trace_ctrl *ctrl = &hisi_ptt->trace_ctrl;
>>> +    u32 val;
>>> +    int i;
>>> +
>>> +    /* Check device idle before start trace */
>>> +    if (!hisi_ptt_wait_trace_hw_idle(hisi_ptt)) {
>>> +        pci_err(hisi_ptt->pdev, "Failed to start trace, the device is still busy\n");
>>> +        return -EBUSY;
>>> +    }
>>> +
>>> +    ctrl->started = true;
>>> +
>>> +    /* Reset the DMA before start tracing */
>>> +    val = readl(hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
>>> +    val |= HISI_PTT_TRACE_CTRL_RST;
>>> +    writel(val, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
>>> +
>>> +    hisi_ptt_wait_dma_reset_done(hisi_ptt);
>>> +
>>> +    val = readl(hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
>>> +    val &= ~HISI_PTT_TRACE_CTRL_RST;
>>> +    writel(val, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
>>> +
>>> +    /* Clear the interrupt status */
>>> +    writel(HISI_PTT_TRACE_INT_STAT_MASK, hisi_ptt->iobase + HISI_PTT_TRACE_INT_STAT);
>>> +    writel(0, hisi_ptt->iobase + HISI_PTT_TRACE_INT_MASK);
>>> +
>>> +    /* Configure the trace DMA buffer */
>>
>> I am not sure why this sort of thing is done outside probing
>>

...

>>> +
>>> +    val = FIELD_GET(HISI_PTT_PMU_DIRECTION_MASK, event->attr.config);
>>> +    ret = hisi_ptt_trace_valid_config_onehot(val, hisi_ptt_trace_available_direction,
>>
>> how about put all those arrays in hisi_ptt_trace_valid_config_onehot() and pass some flag to say which array you want to use? Or something like that. Passing the arrays in this fashion is messy
>>
> 
> Since there are 3 configs (type, direction, format) with different available range and setting method (onehot, non-onehot),
> moving the arrays into the valid checking function means we need to recognize the config types (passed by the caller but need
> to know the available value array) and the checking method together. That may make the code more complex than now: 1st picking
> up the right array and judge wich checking method this array applied and 2nd do the checking.
> 
> Currently it's designed to decouple the checking method and the available value array. The hisi_ptt_trace_valid_config{_onehot}()
> won't care about which array to use since caller take responsibilty for this. So perhaps current approach is simple and clear
> enough.


A couple of points:
- hisi_ptt_trace_valid_config_type() only has 1x caller so can make it 
dedicated for that caller
- there is not much code in hisi_ptt_trace_valid_config_onshot(), so ok 
to duplicate if makes overall code look better

So I think dedicated functions make the code simpler, easier to follow, 
and maintain:

static int hisi_ptt_trace_valid_config_dir(u32 val)
{
	int i;
	/*
	 * The supported value of the direction parameter. See hisi_ptt.rst
	 * documentation for more details.
	 */
	static const u32 hisi_ptt_trace_available_direction[] = {
		0,
		1,
		2,
		3,
	};

	for (i = 0; i < ARRAY_SIZE(hisi_ptt_trace_available_direction); i++)
		if (val == hisi_ptt_trace_available_direction[i])
			return 0;

	return -EINVAL;
}

static int hisi_ptt_trace_valid_config_format(u32 val)
{
	int i;
	static const u32 hisi_ptt_trace_availble_format[] = {
		0,	/* 4DW */
		1,	/* 8DW */
	};

	for (i = 0; i < ARRAY_SIZE(hisi_ptt_trace_availble_format); i++)
		if (val == hisi_ptt_trace_availble_format[i])
			return 0;

	return -EINVAL;
}

static int hisi_ptt_trace_valid_config_type(u32 val)
{
	int i;
	/* Different types can be set simultaneously */
	static const u32 hisi_ptt_trace_available_type[] = {
		1,	/* posted_request */
		2,	/* non-posted_request */
		4,	/* completion */
	};

	for (i = 0; i < ARRAY_SIZE(hisi_ptt_trace_available_type); i++)
		val &= ~hisi_ptt_trace_available_type[i];

	if (val)
		return -EINVAL;
	return 0;
}

...

static int hisi_ptt_pmu_event_init(struct perf_event *event)
{

...

	val = FIELD_GET(HISI_PTT_PMU_DIRECTION_MASK, event->attr.config);
	ret = hisi_ptt_trace_valid_config_dir(val);
	if (ret < 0)
		goto out;
	ctrl->direction = val;

	val = FIELD_GET(HISI_PTT_PMU_TYPE_MASK, event->attr.config);
	ret = hisi_ptt_trace_valid_config_type(val);
	if (ret < 0)
		goto out;
	ctrl->type = val;

	val = FIELD_GET(HISI_PTT_PMU_FORMAT_MASK, event->attr.config);
	ret = hisi_ptt_trace_valid_config_format(val);
	if (ret < 0)
		goto out;
	ctrl->format = val;

	...
}
> 
>>
>>> +                         ARRAY_SIZE(hisi_ptt_trace_available_direction));
>>> +    if (ret < 0)
>>> +        goto out;
>>> +    ctrl->direction = val;
>>> +
>>> +    val = FIELD_GET(HISI_PTT_PMU_TYPE_MASK, event->attr.config);
>>> +    ret = hisi_ptt_trace_valid_config(val, hisi_ptt_trace_available_type,
>>> +                      ARRAY_SIZE(hisi_ptt_trace_available_type));
>>> +    if (ret < 0)
>>> +        goto out;
>>> +    ctrl->type = val;
>>> +
>>> +    val = FIELD_GET(HISI_PTT_PMU_FORMAT_MASK, event->attr.config);
>>> +    ret = hisi_ptt_trace_valid_config_onehot(val, hisi_ptt_trace_availble_format,
>>> +                         ARRAY_SIZE(hisi_ptt_trace_availble_format));
>>> +    if (ret < 0)
>>> +        goto out;
>>> +    ctrl->format = val;
>>> +
>>> +out:
>>> +    mutex_unlock(&hisi_ptt->mutex);
>>> +    return ret;
>>> +}
>>> +
>>> +static void *hisi_ptt_pmu_setup_aux(struct perf_event *event, void **pages,
>>> +                    int nr_pages, bool overwrite)
>>> +{
>>> +    struct hisi_ptt_pmu_buf *buf;
>>> +    struct page **pagelist;
>>> +    int i;
>>> +
>>> +    if (overwrite) {
>>> +        dev_warn(event->pmu->dev, "Overwrite mode is not supported\n");
>>> +        return NULL;
>>> +    }
>>> +
>>> +    /* If the pages size less than buffers, we cannot start trace */
>>> +    if (nr_pages < HISI_PTT_TRACE_TOTAL_BUF_SIZE / PAGE_SIZE)
>>> +        return NULL;
>>> +
>>> +    buf = kzalloc(sizeof(*buf), GFP_KERNEL);
>>> +    if (!buf)
>>> +        return NULL;
>>> +
>>> +    pagelist = kcalloc(nr_pages, sizeof(*pagelist), GFP_KERNEL);
>>> +    if (!pagelist) {
>>> +        kfree(buf);
>>> +        return NULL;
>>> +    }
>>> +
>>> +    for (i = 0; i < nr_pages; i++)
>>> +        pagelist[i] = virt_to_page(pages[i]);
>>> +
>>> +    buf->base = vmap(pagelist, nr_pages, VM_MAP, PAGE_KERNEL);
>>> +    if (!buf->base) {
>>> +        kfree(pagelist);
>>> +        kfree(buf);
>>> +        return NULL;
>>> +    }
>>> +
>>> +    buf->nr_pages = nr_pages;
>>> +    buf->length = nr_pages * PAGE_SIZE;
>>> +    buf->pos = 0;
>>> +
>>> +    kfree(pagelist);
>>> +    return buf;
>>> +}
>>> +
>>> +static void hisi_ptt_pmu_free_aux(void *aux)
>>> +{
>>> +    struct hisi_ptt_pmu_buf *buf = aux;
>>> +
>>> +    vunmap(buf->base);
>>> +    kfree(buf);
>>> +}
>>> +
>>> +static void hisi_ptt_pmu_start(struct perf_event *event, int flags)
>>> +{
>>> +    struct hisi_ptt *hisi_ptt = to_hisi_ptt(event->pmu);
>>> +    struct perf_output_handle *handle = &hisi_ptt->trace_ctrl.handle;
>>> +    struct hw_perf_event *hwc = &event->hw;
>>> +    struct hisi_ptt_pmu_buf *buf;
>>> +    int cpu = event->cpu;
>>> +    int ret;
>>> +
>>> +    hwc->state = 0;
>>> +    mutex_lock(&hisi_ptt->mutex);
>>> +    if (hisi_ptt->trace_ctrl.started) {
>>> +        pci_dbg(hisi_ptt->pdev, "trace has already started\n");
>>
>> doesn't perf core guard against this sort of thing?
>>
> 
> Maybe not as tested. The perf core will start the events 1)on the cpus user specified or
> 2)on all the cpus, but the PTT trace is intended to start once on one cpu.
> 
> For the 2) case, the driver will make default cpu to start the trace and block others
> in pmu::add(). For the 1) case we'll met the condition here. So the started status is
> test here to avoid a second start.

if this is a realistic and sensible usecase then it would be nice to 
handle in core perf code at some stage

> 
>>> +        goto stop;
>>> +    }
>>> +
>>> +    if (cpu == -1)
>>> +        cpu = hisi_ptt->trace_ctrl.default_cpu;
>>> +
>>> +    /*
>>> +     * Handle the interrupt on the same cpu which starts the trace to avoid
>>> +     * context mismatch. Otherwise we'll trigger the WARN from the perf
>>> +     * core in event_function_local().
>>> +     */
>>> +    WARN_ON(irq_set_affinity(pci_irq_vector(hisi_ptt->pdev, HISI_PTT_TRACE_DMA_IRQ),
>>> +                 cpumask_of(cpu)));
>>> +
>>> +    ret = hisi_ptt_alloc_trace_buf(hisi_ptt);
>>> +    if (ret) {
>>> +        pci_dbg(hisi_ptt->pdev, "alloc trace buf failed, ret = %d\n", ret);
>>> +        goto stop;
>>> +    }
>>> +
>>> +    buf = perf_aux_output_begin(handle, event);
>>> +    if (!buf) {
>>> +        pci_dbg(hisi_ptt->pdev, "aux output begin failed\n");
>>> +        goto stop;
>>> +    }
>>> +
>>> +    buf->pos = handle->head % buf->length;
>>> +
>>> +    ret = hisi_ptt_trace_start(hisi_ptt);
>>> +    if (ret) {
>>> +        pci_dbg(hisi_ptt->pdev, "trace start failed, ret = %d\n", ret);
>>> +        perf_aux_output_end(handle, 0);
>>> +        goto stop;
>>> +    }
>>> +
>>> +    mutex_unlock(&hisi_ptt->mutex);
>>> +    return;
>>> +stop:
>>> +    event->hw.state |= PERF_HES_STOPPED;
>>> +    mutex_unlock(&hisi_ptt->mutex);
>>> +}
>>> +
>>> +static void hisi_ptt_pmu_stop(struct perf_event *event, int flags)
>>> +{
>>> +    struct hisi_ptt *hisi_ptt = to_hisi_ptt(event->pmu);
>>> +    struct hw_perf_event *hwc = &event->hw;
>>> +
>>> +    if (hwc->state & PERF_HES_STOPPED)
>>> +        return;
>>> +
>>> +    mutex_lock(&hisi_ptt->mutex);
>>> +    if (hisi_ptt->trace_ctrl.started) {
>>> +        hisi_ptt_trace_end(hisi_ptt);
>>> +        WARN(!hisi_ptt_wait_trace_hw_idle(hisi_ptt), "Device is still busy");
>>> +        hisi_ptt_update_aux(hisi_ptt, hisi_ptt->trace_ctrl.buf_index, true);
>>> +    }
>>> +    mutex_unlock(&hisi_ptt->mutex);
>>> +
>>> +    hwc->state |= PERF_HES_STOPPED;
>>> +    perf_event_update_userpage(event);
>>> +    hwc->state |= PERF_HES_UPTODATE;
>>> +}
>>> +
>>> +static int hisi_ptt_pmu_add(struct perf_event *event, int flags)
>>> +{
>>> +    struct hisi_ptt *hisi_ptt = to_hisi_ptt(event->pmu);
>>> +    struct hw_perf_event *hwc = &event->hw;
>>> +    int cpu = event->cpu;
>>> +
>>> +    /*
>>> +     * Only allow the default cpu to add the event if user doesn't specify
>>> +     * the cpus.
>>> +     */
>>> +    if (cpu == -1 && smp_processor_id() != hisi_ptt->trace_ctrl.default_cpu)
>>> +        return 0;
>>> +
>>> +    hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
>>> +
>>> +    if (flags & PERF_EF_START) {
>>> +        hisi_ptt_pmu_start(event, PERF_EF_RELOAD);
>>> +        if (hwc->state & PERF_HES_STOPPED)
>>> +            return -EINVAL;
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static void hisi_ptt_pmu_del(struct perf_event *event, int flags)
>>> +{
>>> +    hisi_ptt_pmu_stop(event, PERF_EF_UPDATE);
>>> +}
>>> +
>>> +static int hisi_ptt_register_pmu(struct hisi_ptt *hisi_ptt)
>>> +{
>>> +    u16 core_id, sicl_id;
>>> +    char *pmu_name;
>>> +    u32 reg;
>>> +
>>> +    hisi_ptt->hisi_ptt_pmu = (struct pmu) {
>>> +        .module        = THIS_MODULE,
>>> +        .capabilities    = PERF_PMU_CAP_EXCLUSIVE | PERF_PMU_CAP_ITRACE,
>>> +        .task_ctx_nr    = perf_sw_context,
>>> +        .attr_groups    = hisi_ptt_pmu_groups,
>>> +        .event_init    = hisi_ptt_pmu_event_init,
>>> +        .setup_aux    = hisi_ptt_pmu_setup_aux,
>>> +        .free_aux    = hisi_ptt_pmu_free_aux,
>>> +        .start        = hisi_ptt_pmu_start,
>>> +        .stop        = hisi_ptt_pmu_stop,
>>> +        .add        = hisi_ptt_pmu_add,
>>> +        .del        = hisi_ptt_pmu_del,
>>> +    };
>>> +
>>> +    reg = readl(hisi_ptt->iobase + HISI_PTT_LOCATION);
>>> +    core_id = FIELD_GET(HISI_PTT_CORE_ID, reg);
>>> +    sicl_id = FIELD_GET(HISI_PTT_SICL_ID, reg);
>>> +
>>> +    pmu_name = devm_kasprintf(&hisi_ptt->pdev->dev, GFP_KERNEL, "hisi_ptt%u_%u",
>>> +                  sicl_id, core_id);
>>> +    if (!pmu_name)
>>> +        return -ENOMEM;
>>> +
>>> +    return perf_pmu_register(&hisi_ptt->hisi_ptt_pmu, pmu_name, -1);
>>> +}
>>> +
>>> +/*
>>> + * The DMA of PTT trace can only use direct mapping, due to some
>>> + * hardware restriction. Check whether there is an IOMMU or the
>>> + * policy of the IOMMU domain is passthrough, otherwise the trace
>>> + * cannot work.
>>> + *
>>> + * The PTT device is supposed to behind the ARM SMMUv3, which
>>
>> /s/ the ARM SMMUv3/an ARM SMMUv3/
>>
> ok.
>>> + * should have passthrough the device by a quirk.
>>> + */
>>> +static int hisi_ptt_check_iommu_mapping(struct pci_dev *pdev)
>>> +{
>>> +    struct iommu_domain *iommu_domain;
>>> +
>>> +    iommu_domain = iommu_get_domain_for_dev(&pdev->dev);
>>> +    if (!iommu_domain || iommu_domain->type == IOMMU_DOMAIN_IDENTITY)
>>> +        return 0;
>>> +
>>> +    return -EOPNOTSUPP;
>>> +}
>>> +
>>> +static int hisi_ptt_probe(struct pci_dev *pdev,
>>> +              const struct pci_device_id *id)
>>> +{
>>> +    struct hisi_ptt *hisi_ptt;
>>> +    int ret;
>>> +
>>> +    ret = hisi_ptt_check_iommu_mapping(pdev);
>>> +    if (ret) {
>>> +        pci_err(pdev, "requires direct DMA mappings\n");
>>> +        return ret;
>>> +    }
>>> +
>>> +    hisi_ptt = devm_kzalloc(&pdev->dev, sizeof(*hisi_ptt), GFP_KERNEL);
>>> +    if (!hisi_ptt)
>>> +        return -ENOMEM;
>>> +
>>> +    mutex_init(&hisi_ptt->mutex);
>>> +    hisi_ptt->pdev = pdev;
>>> +    pci_set_drvdata(pdev, hisi_ptt);
>>> +
>>> +    ret = pcim_enable_device(pdev);
>>> +    if (ret) {
>>> +        pci_err(pdev, "failed to enable device, ret = %d\n", ret);
>>> +        return ret;
>>> +    }
>>> +
>>> +    ret = pcim_iomap_regions(pdev, BIT(2), DRV_NAME);
>>> +    if (ret) {
>>> +        pci_err(pdev, "failed to remap io memory, ret = %d\n", ret);
>>> +        return ret;
>>> +    }
>>> +
>>> +    hisi_ptt->iobase = pcim_iomap_table(pdev)[2];
>>> +
>>> +    ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
>>> +    if (ret) {
>>> +        pci_err(pdev, "failed to set 64 bit dma mask, ret = %d\n", ret);
>>> +        return ret;
>>> +    }
>>> +
>>> +    pci_set_master(pdev);
>>> +
>>> +    ret = hisi_ptt_register_irq(hisi_ptt);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    ret = hisi_ptt_init_ctrls(hisi_ptt);
>>> +    if (ret) {
>>> +        pci_err(pdev, "failed to init controls, ret = %d\n", ret);
>>> +        return ret;
>>> +    }
>>> +
>>> +    ret = hisi_ptt_register_pmu(hisi_ptt);
>>> +    if (ret) {
>>> +        pci_err(pdev, "failed to register PMU device, ret = %d", ret);
>>> +        return ret;
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static void hisi_ptt_remove(struct pci_dev *pdev)
>>> +{
>>> +    struct hisi_ptt *hisi_ptt = pci_get_drvdata(pdev);
>>> +
>>> +    /*
>>> +     * We have to manually unregister the PMU device rather than make it
>>> +     * devres managed to keep order that the PMU device's unregistration
>>> +     * is prior to the release of DMA buffers. As the DMA buffers are
>>> +     * devm allocated when necessary which is after the registration of
>>> +     * the PMU device.
>>> +     */
>>
>> do you really need to mention all this?
>>
> 
> I think yes. Otherwise people may ask why not register PMU device in managed
> way as well.

I expect devres work to be done after hisi_ptt_remove() so I would know 
this...


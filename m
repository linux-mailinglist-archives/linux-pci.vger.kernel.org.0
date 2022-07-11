Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2691F57095C
	for <lists+linux-pci@lfdr.de>; Mon, 11 Jul 2022 19:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiGKRqX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jul 2022 13:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGKRqW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jul 2022 13:46:22 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5B02A947
        for <linux-pci@vger.kernel.org>; Mon, 11 Jul 2022 10:46:21 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id s21so5428003pjq.4
        for <linux-pci@vger.kernel.org>; Mon, 11 Jul 2022 10:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YYMZFqZAqRQUiBTPM+t4WTTlgpypkJBhKWoIbKZasIg=;
        b=aSg2COK0THYvcRDpSGfGG7AHq3RvK3OQCnx8mke/jsj3TbS+IPKlM/IY4Bs3JHeO2U
         5L+VWk13G7Jp3OBls1+dru2bYzdTHwapcI46TN1fkdshtvod7EOpZIkxGRo6XV/J+6nj
         n3a9we911Dsf6/I6XBb/Zz+4SYXw0VlGU4p8P1P9ugWHwT6g9E13nfUTpWs3g/staicH
         NhxPp4nVQTP728zl+J70O8JRLgydYjd9tuT1Flyk043ZLwGQUTTAfPdq7dNI0F+6PNWN
         zX9l5r9oDIw5AK/fL36Enasao+PtlyB94Ar9cgk4K/bgq173TLqVmUhzAWb/ZVIKpjeb
         J1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YYMZFqZAqRQUiBTPM+t4WTTlgpypkJBhKWoIbKZasIg=;
        b=28TrtiTYNxmzlTVA1Ye2sHTM8QAmniYklv4yF/OOH1XlPnuoz0UXS62MxSoz/sfJrO
         611J2awMPfDAL6UIUK3Gd1o7LaRHZkmR8m0BO9ezD4pCHgQfrvTF/5cXliXBowIEytSH
         ZuoBKwHJh9Ha/FP8W9VPuSL8zHzHwGMVFEdOFGzEYTdMoOpamwW317pNfWwunGVbG62F
         1ikh1TgmesCZ7l6rtA0qDDkrqaBP+pov+V1i470pilsIZhDJbKRIgrugj5fZJ3rT9Vzp
         bSdQZb7WTyG6Q4wELtSUYi6Rgc/CaRxnLgmFldywWPaMYxJqz2Dx/yi84snFeW7XHYH/
         wQvQ==
X-Gm-Message-State: AJIora9zyXaQ+4VN/yUKaDKwnp3UZ+tx25XBiv0dqoylQOhjSvsfOkI9
        KHBFJTaGxw3KPHN6GmUHBDBvKw==
X-Google-Smtp-Source: AGRyM1ueD/wRSfGpXgT7Q/Uc9wS+SkIfC/pQuBIrLLdDLlFeGd5icSPzPd5zI+gDedGBXpsqonWJYA==
X-Received: by 2002:a17:902:eb8e:b0:16c:5764:7dc0 with SMTP id q14-20020a170902eb8e00b0016c57647dc0mr1245219plg.63.1657561580581;
        Mon, 11 Jul 2022 10:46:20 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id a3-20020a170902ee8300b001640aad2f71sm4998545pld.180.2022.07.11.10.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 10:46:19 -0700 (PDT)
Date:   Mon, 11 Jul 2022 11:46:15 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     gregkh@linuxfoundation.org, alexander.shishkin@linux.intel.com,
        leo.yan@linaro.org, james.clark@arm.com, will@kernel.org,
        robin.murphy@arm.com, acme@kernel.org, jonathan.cameron@huawei.com,
        john.garry@huawei.com, helgaas@kernel.org,
        lorenzo.pieralisi@arm.com, suzuki.poulose@arm.com,
        mark.rutland@arm.com, joro@8bytes.org,
        shameerali.kolothum.thodi@huawei.com, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-perf-users@vger.kernel.org, iommu@lists.linux-foundation.org,
        prime.zeng@huawei.com, liuqi115@huawei.com,
        zhangshaokun@hisilicon.com, linuxarm@huawei.com
Subject: Re: [PATCH v9 2/8] hwtracing: hisi_ptt: Add trace function support
 for HiSilicon PCIe Tune and Trace device
Message-ID: <20220711174615.GB2868319@p14s>
References: <20220606115555.41103-1-yangyicong@hisilicon.com>
 <20220606115555.41103-3-yangyicong@hisilicon.com>
 <20220711174139.GA2868319@p14s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711174139.GA2868319@p14s>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[...]

> > +
> > +static int hisi_ptt_trace_valid_direction(u32 val)
> > +{
> > +	/*
> > +	 * The supported value of the direction parameter. See hisi_ptt.rst
> > +	 * documentation for more details.
> > +	 */
> > +	static const u32 hisi_ptt_trace_available_direction[] = {
> > +		0,
> > +		1,
> > +		2,
> > +		3,
> > +	};
> 
> I would not have commented otherwise but since you are re-spinning this, I think
> there would be value in documenting the value of the direction parameters like
> it was done in hisi_ptt_trace_valid_type().  That way one doesn't have to go
> fish out the values in hisi_ptt.rst
> 
> With the above: 
> Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> 

I am done reviewing this set.

Thanks,
Mathieu

> > +	int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(hisi_ptt_trace_available_direction); i++) {
> > +		if (val == hisi_ptt_trace_available_direction[i])
> > +			return 0;
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +static int hisi_ptt_trace_valid_type(u32 val)
> > +{
> > +	/* Different types can be set simultaneously */
> > +	static const u32 hisi_ptt_trace_available_type[] = {
> > +		1,	/* posted_request */
> > +		2,	/* non-posted_request */
> > +		4,	/* completion */
> > +	};
> > +	int i;
> > +
> > +	if (!val)
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * Walk the available list and clear the valid bits of
> > +	 * the config. If there is any resident bit after the
> > +	 * walk then the config is invalid.
> > +	 */
> > +	for (i = 0; i < ARRAY_SIZE(hisi_ptt_trace_available_type); i++)
> > +		val &= ~hisi_ptt_trace_available_type[i];
> > +
> > +	if (val)
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> > +
> > +static int hisi_ptt_trace_valid_format(u32 val)
> > +{
> > +	static const u32 hisi_ptt_trace_availble_format[] = {
> > +		0,	/* 4DW */
> > +		1,	/* 8DW */
> > +	};
> > +	int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(hisi_ptt_trace_availble_format); i++) {
> > +		if (val == hisi_ptt_trace_availble_format[i])
> > +			return 0;
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +static int hisi_ptt_trace_valid_filter(struct hisi_ptt *hisi_ptt, u64 config)
> > +{
> > +	unsigned long val, port_mask = hisi_ptt->port_mask;
> > +	struct hisi_ptt_filter_desc *filter;
> > +
> > +	hisi_ptt->trace_ctrl.is_port = FIELD_GET(HISI_PTT_PMU_FILTER_IS_PORT, config);
> > +	val = FIELD_GET(HISI_PTT_PMU_FILTER_VAL_MASK, config);
> > +
> > +	/*
> > +	 * Port filters are defined as bit mask. For port filters, check
> > +	 * the bits in the @val are within the range of hisi_ptt->port_mask
> > +	 * and whether it's empty or not, otherwise user has specified
> > +	 * some unsupported root ports.
> > +	 *
> > +	 * For Requester ID filters, walk the available filter list to see
> > +	 * whether we have one matched.
> > +	 */
> > +	if (!hisi_ptt->trace_ctrl.is_port) {
> > +		list_for_each_entry(filter, &hisi_ptt->req_filters, list) {
> > +			if (val == hisi_ptt_get_filter_val(filter->devid, filter->is_port))
> > +				return 0;
> > +		}
> > +	} else if (bitmap_subset(&val, &port_mask, BITS_PER_LONG)) {
> > +		return 0;
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +static void hisi_ptt_pmu_init_configs(struct hisi_ptt *hisi_ptt, struct perf_event *event)
> > +{
> > +	struct hisi_ptt_trace_ctrl *ctrl = &hisi_ptt->trace_ctrl;
> > +	u32 val;
> > +
> > +	val = FIELD_GET(HISI_PTT_PMU_FILTER_VAL_MASK, event->attr.config);
> > +	hisi_ptt->trace_ctrl.filter = val;
> > +
> > +	val = FIELD_GET(HISI_PTT_PMU_DIRECTION_MASK, event->attr.config);
> > +	ctrl->direction = val;
> > +
> > +	val = FIELD_GET(HISI_PTT_PMU_TYPE_MASK, event->attr.config);
> > +	ctrl->type = val;
> > +
> > +	val = FIELD_GET(HISI_PTT_PMU_FORMAT_MASK, event->attr.config);
> > +	ctrl->format = val;
> > +}
> > +
> > +static int hisi_ptt_pmu_event_init(struct perf_event *event)
> > +{
> > +	struct hisi_ptt *hisi_ptt = to_hisi_ptt(event->pmu);
> > +	int ret;
> > +	u32 val;
> > +
> > +	if (event->cpu < 0) {
> > +		dev_dbg(event->pmu->dev, "Per-task mode not supported\n");
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	if (event->attr.type != hisi_ptt->hisi_ptt_pmu.type)
> > +		return -ENOENT;
> > +
> > +	ret = hisi_ptt_trace_valid_filter(hisi_ptt, event->attr.config);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	val = FIELD_GET(HISI_PTT_PMU_DIRECTION_MASK, event->attr.config);
> > +	ret = hisi_ptt_trace_valid_direction(val);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	val = FIELD_GET(HISI_PTT_PMU_TYPE_MASK, event->attr.config);
> > +	ret = hisi_ptt_trace_valid_type(val);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	val = FIELD_GET(HISI_PTT_PMU_FORMAT_MASK, event->attr.config);
> > +	return hisi_ptt_trace_valid_format(val);
> > +}
> > +
> > +static void *hisi_ptt_pmu_setup_aux(struct perf_event *event, void **pages,
> > +				    int nr_pages, bool overwrite)
> > +{
> > +	struct hisi_ptt_pmu_buf *buf;
> > +	struct page **pagelist;
> > +	int i;
> > +
> > +	if (overwrite) {
> > +		dev_warn(event->pmu->dev, "Overwrite mode is not supported\n");
> > +		return NULL;
> > +	}
> > +
> > +	/* If the pages size less than buffers, we cannot start trace */
> > +	if (nr_pages < HISI_PTT_TRACE_TOTAL_BUF_SIZE / PAGE_SIZE)
> > +		return NULL;
> > +
> > +	buf = kzalloc(sizeof(*buf), GFP_KERNEL);
> > +	if (!buf)
> > +		return NULL;
> > +
> > +	pagelist = kcalloc(nr_pages, sizeof(*pagelist), GFP_KERNEL);
> > +	if (!pagelist)
> > +		goto err;
> > +
> > +	for (i = 0; i < nr_pages; i++)
> > +		pagelist[i] = virt_to_page(pages[i]);
> > +
> > +	buf->base = vmap(pagelist, nr_pages, VM_MAP, PAGE_KERNEL);
> > +	if (!buf->base) {
> > +		kfree(pagelist);
> > +		goto err;
> > +	}
> > +
> > +	buf->nr_pages = nr_pages;
> > +	buf->length = nr_pages * PAGE_SIZE;
> > +	buf->pos = 0;
> > +
> > +	kfree(pagelist);
> > +	return buf;
> > +err:
> > +	kfree(buf);
> > +	return NULL;
> > +}
> > +
> > +static void hisi_ptt_pmu_free_aux(void *aux)
> > +{
> > +	struct hisi_ptt_pmu_buf *buf = aux;
> > +
> > +	vunmap(buf->base);
> > +	kfree(buf);
> > +}
> > +
> > +static void hisi_ptt_pmu_start(struct perf_event *event, int flags)
> > +{
> > +	struct hisi_ptt *hisi_ptt = to_hisi_ptt(event->pmu);
> > +	struct perf_output_handle *handle = &hisi_ptt->trace_ctrl.handle;
> > +	struct hw_perf_event *hwc = &event->hw;
> > +	struct device *dev = event->pmu->dev;
> > +	struct hisi_ptt_pmu_buf *buf;
> > +	int cpu = event->cpu;
> > +	int ret;
> > +
> > +	hwc->state = 0;
> > +
> > +	/* Serialize the perf process if user specified several CPUs */
> > +	spin_lock(&hisi_ptt->pmu_lock);
> > +	if (hisi_ptt->trace_ctrl.started) {
> > +		dev_dbg(dev, "trace has already started\n");
> > +		goto stop;
> > +	}
> > +
> > +	/*
> > +	 * Handle the interrupt on the same cpu which starts the trace to avoid
> > +	 * context mismatch. Otherwise we'll trigger the WARN from the perf
> > +	 * core in event_function_local().
> > +	 */
> > +	WARN_ON(irq_set_affinity(pci_irq_vector(hisi_ptt->pdev, HISI_PTT_TRACE_DMA_IRQ),
> > +				 cpumask_of(cpu)));
> > +	hisi_ptt->trace_ctrl.on_cpu = cpu;
> > +
> > +	buf = perf_aux_output_begin(handle, event);
> > +	if (!buf) {
> > +		dev_dbg(dev, "aux output begin failed\n");
> > +		goto stop;
> > +	}
> > +
> > +	buf->pos = handle->head % buf->length;
> > +
> > +	hisi_ptt_pmu_init_configs(hisi_ptt, event);
> > +
> > +	ret = hisi_ptt_trace_start(hisi_ptt);
> > +	if (ret) {
> > +		dev_dbg(dev, "trace start failed, ret = %d\n", ret);
> > +		perf_aux_output_end(handle, 0);
> > +		goto stop;
> > +	}
> > +
> > +	spin_unlock(&hisi_ptt->pmu_lock);
> > +	return;
> > +stop:
> > +	event->hw.state |= PERF_HES_STOPPED;
> > +	spin_unlock(&hisi_ptt->pmu_lock);
> > +}
> > +
> > +static void hisi_ptt_pmu_stop(struct perf_event *event, int flags)
> > +{
> > +	struct hisi_ptt *hisi_ptt = to_hisi_ptt(event->pmu);
> > +	struct hw_perf_event *hwc = &event->hw;
> > +
> > +	if (hwc->state & PERF_HES_STOPPED)
> > +		return;
> > +
> > +	spin_lock(&hisi_ptt->pmu_lock);
> > +	if (hisi_ptt->trace_ctrl.started) {
> > +		hisi_ptt_trace_end(hisi_ptt);
> > +		WARN(!hisi_ptt_wait_trace_hw_idle(hisi_ptt), "Device is still busy");
> > +		hisi_ptt_update_aux(hisi_ptt, hisi_ptt->trace_ctrl.buf_index, true);
> > +	}
> > +	spin_unlock(&hisi_ptt->pmu_lock);
> > +
> > +	hwc->state |= PERF_HES_STOPPED;
> > +	perf_event_update_userpage(event);
> > +	hwc->state |= PERF_HES_UPTODATE;
> > +}
> > +
> > +static int hisi_ptt_pmu_add(struct perf_event *event, int flags)
> > +{
> > +	struct hisi_ptt *hisi_ptt = to_hisi_ptt(event->pmu);
> > +	struct hw_perf_event *hwc = &event->hw;
> > +	int cpu = event->cpu;
> > +
> > +	/* Only allow the cpus on the device's node to add the event */
> > +	if (!cpumask_test_cpu(cpu, cpumask_of_node(dev_to_node(&hisi_ptt->pdev->dev))))
> > +		return 0;
> > +
> > +	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
> > +
> > +	if (flags & PERF_EF_START) {
> > +		hisi_ptt_pmu_start(event, PERF_EF_RELOAD);
> > +		if (hwc->state & PERF_HES_STOPPED)
> > +			return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void hisi_ptt_pmu_del(struct perf_event *event, int flags)
> > +{
> > +	hisi_ptt_pmu_stop(event, PERF_EF_UPDATE);
> > +}
> > +
> > +static void hisi_ptt_remove_cpuhp_instance(void *hotplug_node)
> > +{
> > +	cpuhp_state_remove_instance(hisi_ptt_pmu_online, hotplug_node);
> > +}
> > +
> > +static void hisi_ptt_unregister_pmu(void *pmu)
> > +{
> > +	perf_pmu_unregister(pmu);
> > +}
> > +
> > +static int hisi_ptt_register_pmu(struct hisi_ptt *hisi_ptt)
> > +{
> > +	u16 core_id, sicl_id;
> > +	char *pmu_name;
> > +	u32 reg;
> > +	int ret;
> > +
> > +	ret = cpuhp_state_add_instance(hisi_ptt_pmu_online, &hisi_ptt->hotplug_node);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = devm_add_action_or_reset(&hisi_ptt->pdev->dev,
> > +				       hisi_ptt_remove_cpuhp_instance,
> > +				       &hisi_ptt->hotplug_node);
> > +	if (ret)
> > +		return ret;
> > +
> > +	spin_lock_init(&hisi_ptt->pmu_lock);
> > +
> > +	hisi_ptt->hisi_ptt_pmu = (struct pmu) {
> > +		.module		= THIS_MODULE,
> > +		.capabilities	= PERF_PMU_CAP_EXCLUSIVE | PERF_PMU_CAP_ITRACE,
> > +		.task_ctx_nr	= perf_sw_context,
> > +		.attr_groups	= hisi_ptt_pmu_groups,
> > +		.event_init	= hisi_ptt_pmu_event_init,
> > +		.setup_aux	= hisi_ptt_pmu_setup_aux,
> > +		.free_aux	= hisi_ptt_pmu_free_aux,
> > +		.start		= hisi_ptt_pmu_start,
> > +		.stop		= hisi_ptt_pmu_stop,
> > +		.add		= hisi_ptt_pmu_add,
> > +		.del		= hisi_ptt_pmu_del,
> > +	};
> > +
> > +	reg = readl(hisi_ptt->iobase + HISI_PTT_LOCATION);
> > +	core_id = FIELD_GET(HISI_PTT_CORE_ID, reg);
> > +	sicl_id = FIELD_GET(HISI_PTT_SICL_ID, reg);
> > +
> > +	pmu_name = devm_kasprintf(&hisi_ptt->pdev->dev, GFP_KERNEL, "hisi_ptt%u_%u",
> > +				  sicl_id, core_id);
> > +	if (!pmu_name)
> > +		return -ENOMEM;
> > +
> > +	ret = perf_pmu_register(&hisi_ptt->hisi_ptt_pmu, pmu_name, -1);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return devm_add_action_or_reset(&hisi_ptt->pdev->dev,
> > +					hisi_ptt_unregister_pmu,
> > +					&hisi_ptt->hisi_ptt_pmu);
> > +}
> > +
> > +/*
> > + * The DMA of PTT trace can only use direct mappings due to some
> > + * hardware restriction. Check whether there is no IOMMU or the
> > + * policy of the IOMMU domain is passthrough, otherwise the trace
> > + * cannot work.
> > + *
> > + * The PTT device is supposed to behind an ARM SMMUv3, which
> > + * should have passthrough the device by a quirk.
> > + */
> > +static int hisi_ptt_check_iommu_mapping(struct pci_dev *pdev)
> > +{
> > +	struct iommu_domain *iommu_domain;
> > +
> > +	iommu_domain = iommu_get_domain_for_dev(&pdev->dev);
> > +	if (!iommu_domain || iommu_domain->type == IOMMU_DOMAIN_IDENTITY)
> > +		return 0;
> > +
> > +	return -EOPNOTSUPP;
> > +}
> > +
> > +static int hisi_ptt_probe(struct pci_dev *pdev,
> > +			  const struct pci_device_id *id)
> > +{
> > +	struct hisi_ptt *hisi_ptt;
> > +	int ret;
> > +
> > +	ret = hisi_ptt_check_iommu_mapping(pdev);
> > +	if (ret) {
> > +		pci_err(pdev, "requires direct DMA mappings\n");
> > +		return ret;
> > +	}
> > +
> > +	hisi_ptt = devm_kzalloc(&pdev->dev, sizeof(*hisi_ptt), GFP_KERNEL);
> > +	if (!hisi_ptt)
> > +		return -ENOMEM;
> > +
> > +	hisi_ptt->pdev = pdev;
> > +	pci_set_drvdata(pdev, hisi_ptt);
> > +
> > +	ret = pcim_enable_device(pdev);
> > +	if (ret) {
> > +		pci_err(pdev, "failed to enable device, ret = %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	ret = pcim_iomap_regions(pdev, BIT(2), DRV_NAME);
> > +	if (ret) {
> > +		pci_err(pdev, "failed to remap io memory, ret = %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	hisi_ptt->iobase = pcim_iomap_table(pdev)[2];
> > +
> > +	ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
> > +	if (ret) {
> > +		pci_err(pdev, "failed to set 64 bit dma mask, ret = %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	pci_set_master(pdev);
> > +
> > +	ret = hisi_ptt_register_irq(hisi_ptt);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = hisi_ptt_init_ctrls(hisi_ptt);
> > +	if (ret) {
> > +		pci_err(pdev, "failed to init controls, ret = %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	ret = hisi_ptt_register_pmu(hisi_ptt);
> > +	if (ret) {
> > +		pci_err(pdev, "failed to register PMU device, ret = %d", ret);
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct pci_device_id hisi_ptt_id_tbl[] = {
> > +	{ PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, 0xa12e) },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(pci, hisi_ptt_id_tbl);
> > +
> > +static struct pci_driver hisi_ptt_driver = {
> > +	.name = DRV_NAME,
> > +	.id_table = hisi_ptt_id_tbl,
> > +	.probe = hisi_ptt_probe,
> > +};
> > +
> > +static int hisi_ptt_cpu_teardown(unsigned int cpu, struct hlist_node *node)
> > +{
> > +	struct hisi_ptt *hisi_ptt;
> > +	int target, src;
> > +
> > +	hisi_ptt = hlist_entry_safe(node, struct hisi_ptt, hotplug_node);
> > +	src = hisi_ptt->trace_ctrl.on_cpu;
> > +
> > +	if (!hisi_ptt->trace_ctrl.started || src != cpu)
> > +		return 0;
> > +
> > +	target = cpumask_any(cpumask_of_node(dev_to_node(&hisi_ptt->pdev->dev)));
> > +	if (target >= nr_cpu_ids) {
> > +		dev_err(hisi_ptt->hisi_ptt_pmu.dev,
> > +			"no available cpu for perf context migration\n");
> > +		return 0;
> > +	}
> > +
> > +	perf_pmu_migrate_context(&hisi_ptt->hisi_ptt_pmu, src, target);
> > +	WARN_ON(irq_set_affinity(pci_irq_vector(hisi_ptt->pdev, HISI_PTT_TRACE_DMA_IRQ),
> > +				 cpumask_of(cpu)));
> > +	hisi_ptt->trace_ctrl.on_cpu = target;
> > +
> > +	return 0;
> > +}
> > +
> > +static int __init hisi_ptt_init(void)
> > +{
> > +	int ret;
> > +
> > +	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN, DRV_NAME, NULL,
> > +				      hisi_ptt_cpu_teardown);
> > +	if (ret < 0)
> > +		return ret;
> > +	hisi_ptt_pmu_online = ret;
> > +
> > +	ret = pci_register_driver(&hisi_ptt_driver);
> > +	if (ret)
> > +		cpuhp_remove_multi_state(hisi_ptt_pmu_online);
> > +
> > +	return ret;
> > +}
> > +module_init(hisi_ptt_init);
> > +
> > +static void __exit hisi_ptt_exit(void)
> > +{
> > +	pci_unregister_driver(&hisi_ptt_driver);
> > +	cpuhp_remove_multi_state(hisi_ptt_pmu_online);
> > +}
> > +module_exit(hisi_ptt_exit);
> > +
> > +MODULE_LICENSE("GPL");
> > +MODULE_AUTHOR("Yicong Yang <yangyicong@hisilicon.com>");
> > +MODULE_DESCRIPTION("Driver for HiSilicon PCIe tune and trace device");
> > diff --git a/drivers/hwtracing/ptt/hisi_ptt.h b/drivers/hwtracing/ptt/hisi_ptt.h
> > new file mode 100644
> > index 000000000000..43b2fe77a770
> > --- /dev/null
> > +++ b/drivers/hwtracing/ptt/hisi_ptt.h
> > @@ -0,0 +1,177 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Driver for HiSilicon PCIe tune and trace device
> > + *
> > + * Copyright (c) 2022 HiSilicon Technologies Co., Ltd.
> > + * Author: Yicong Yang <yangyicong@hisilicon.com>
> > + */
> > +
> > +#ifndef _HISI_PTT_H
> > +#define _HISI_PTT_H
> > +
> > +#include <linux/bits.h>
> > +#include <linux/cpumask.h>
> > +#include <linux/list.h>
> > +#include <linux/pci.h>
> > +#include <linux/perf_event.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/types.h>
> > +
> > +#define DRV_NAME "hisi_ptt"
> > +
> > +/*
> > + * The definition of the device registers and register fields.
> > + */
> > +#define HISI_PTT_TRACE_ADDR_SIZE	0x0800
> > +#define HISI_PTT_TRACE_ADDR_BASE_LO_0	0x0810
> > +#define HISI_PTT_TRACE_ADDR_BASE_HI_0	0x0814
> > +#define HISI_PTT_TRACE_ADDR_STRIDE	0x8
> > +#define HISI_PTT_TRACE_CTRL		0x0850
> > +#define   HISI_PTT_TRACE_CTRL_EN	BIT(0)
> > +#define   HISI_PTT_TRACE_CTRL_RST	BIT(1)
> > +#define   HISI_PTT_TRACE_CTRL_RXTX_SEL	GENMASK(3, 2)
> > +#define   HISI_PTT_TRACE_CTRL_TYPE_SEL	GENMASK(7, 4)
> > +#define   HISI_PTT_TRACE_CTRL_DATA_FORMAT	BIT(14)
> > +#define   HISI_PTT_TRACE_CTRL_FILTER_MODE	BIT(15)
> > +#define   HISI_PTT_TRACE_CTRL_TARGET_SEL	GENMASK(31, 16)
> > +#define HISI_PTT_TRACE_INT_STAT		0x0890
> > +#define   HISI_PTT_TRACE_INT_STAT_MASK	GENMASK(3, 0)
> > +#define HISI_PTT_TRACE_INT_MASK		0x0894
> > +#define HISI_PTT_TRACE_WR_STS		0x08a0
> > +#define   HISI_PTT_TRACE_WR_STS_WRITE	GENMASK(27, 0)
> > +#define   HISI_PTT_TRACE_WR_STS_BUFFER	GENMASK(29, 28)
> > +#define HISI_PTT_TRACE_STS		0x08b0
> > +#define   HISI_PTT_TRACE_IDLE		BIT(0)
> > +#define HISI_PTT_DEVICE_RANGE		0x0fe0
> > +#define   HISI_PTT_DEVICE_RANGE_UPPER	GENMASK(31, 16)
> > +#define   HISI_PTT_DEVICE_RANGE_LOWER	GENMASK(15, 0)
> > +#define HISI_PTT_LOCATION		0x0fe8
> > +#define   HISI_PTT_CORE_ID		GENMASK(15, 0)
> > +#define   HISI_PTT_SICL_ID		GENMASK(31, 16)
> > +
> > +/* Parameters of PTT trace DMA part. */
> > +#define HISI_PTT_TRACE_DMA_IRQ			0
> > +#define HISI_PTT_TRACE_BUF_CNT			4
> > +#define HISI_PTT_TRACE_BUF_SIZE			SZ_4M
> > +#define HISI_PTT_TRACE_TOTAL_BUF_SIZE		(HISI_PTT_TRACE_BUF_SIZE * \
> > +						 HISI_PTT_TRACE_BUF_CNT)
> > +/* Wait time for hardware DMA to reset */
> > +#define HISI_PTT_RESET_TIMEOUT_US	10UL
> > +#define HISI_PTT_RESET_POLL_INTERVAL_US	1UL
> > +/* Poll timeout and interval for waiting hardware work to finish */
> > +#define HISI_PTT_WAIT_TRACE_TIMEOUT_US	100UL
> > +#define HISI_PTT_WAIT_POLL_INTERVAL_US	10UL
> > +
> > +#define HISI_PCIE_CORE_PORT_ID(devfn)	(PCI_FUNC(devfn) << 1)
> > +
> > +/* Definition of the PMU configs */
> > +#define HISI_PTT_PMU_FILTER_IS_PORT	BIT(19)
> > +#define HISI_PTT_PMU_FILTER_VAL_MASK	GENMASK(15, 0)
> > +#define HISI_PTT_PMU_DIRECTION_MASK	GENMASK(23, 20)
> > +#define HISI_PTT_PMU_TYPE_MASK		GENMASK(31, 24)
> > +#define HISI_PTT_PMU_FORMAT_MASK	GENMASK(35, 32)
> > +
> > +/**
> > + * struct hisi_ptt_dma_buffer - Describe a single trace buffer of PTT trace.
> > + *                              The detail of the data format is described
> > + *                              in the documentation of PTT device.
> > + * @dma:   DMA address of this buffer visible to the device
> > + * @addr:  virtual address of this buffer visible to the cpu
> > + */
> > +struct hisi_ptt_dma_buffer {
> > +	dma_addr_t dma;
> > +	void *addr;
> > +};
> > +
> > +/**
> > + * struct hisi_ptt_trace_ctrl - Control and status of PTT trace
> > + * @trace_buf: array of the trace buffers for holding the trace data.
> > + *             the length will be HISI_PTT_TRACE_BUF_CNT.
> > + * @handle:    perf output handle of current trace session
> > + * @buf_index: the index of current using trace buffer
> > + * @on_cpu:    current tracing cpu
> > + * @started:   current trace status, true for started
> > + * @is_port:   whether we're tracing root port or not
> > + * @direction: direction of the TLP headers to trace
> > + * @filter:    filter value for tracing the TLP headers
> > + * @format:    format of the TLP headers to trace
> > + * @type:      type of the TLP headers to trace
> > + */
> > +struct hisi_ptt_trace_ctrl {
> > +	struct hisi_ptt_dma_buffer *trace_buf;
> > +	struct perf_output_handle handle;
> > +	u32 buf_index;
> > +	int on_cpu;
> > +	bool started;
> > +	bool is_port;
> > +	u32 direction:2;
> > +	u32 filter:16;
> > +	u32 format:1;
> > +	u32 type:4;
> > +};
> > +
> > +/**
> > + * struct hisi_ptt_filter_desc - Descriptor of the PTT trace filter
> > + * @list:    entry of this descriptor in the filter list
> > + * @is_port: the PCI device of the filter is a Root Port or not
> > + * @devid:   the PCI device's devid of the filter
> > + */
> > +struct hisi_ptt_filter_desc {
> > +	struct list_head list;
> > +	bool is_port;
> > +	u16 devid;
> > +};
> > +
> > +/**
> > + * struct hisi_ptt_pmu_buf - Descriptor of the AUX buffer of PTT trace
> > + * @length:   size of the AUX buffer
> > + * @nr_pages: number of pages of the AUX buffer
> > + * @base:     start address of AUX buffer
> > + * @pos:      position in the AUX buffer to commit traced data
> > + */
> > +struct hisi_ptt_pmu_buf {
> > +	size_t length;
> > +	int nr_pages;
> > +	void *base;
> > +	long pos;
> > +};
> > +
> > +/**
> > + * struct hisi_ptt - Per PTT device data
> > + * @trace_ctrl:   the control information of PTT trace
> > + * @hotplug_node: node for register cpu hotplug event
> > + * @hisi_ptt_pmu: the pum device of trace
> > + * @iobase:       base IO address of the device
> > + * @pdev:         pci_dev of this PTT device
> > + * @pmu_lock:     lock to serialize the perf process
> > + * @upper_bdf:    the upper BDF range of the PCI devices managed by this PTT device
> > + * @lower_bdf:    the lower BDF range of the PCI devices managed by this PTT device
> > + * @port_filters: the filter list of root ports
> > + * @req_filters:  the filter list of requester ID
> > + * @port_mask:    port mask of the managed root ports
> > + */
> > +struct hisi_ptt {
> > +	struct hisi_ptt_trace_ctrl trace_ctrl;
> > +	struct hlist_node hotplug_node;
> > +	struct pmu hisi_ptt_pmu;
> > +	void __iomem *iobase;
> > +	struct pci_dev *pdev;
> > +	spinlock_t pmu_lock;
> > +	u32 upper_bdf;
> > +	u32 lower_bdf;
> > +
> > +	/*
> > +	 * The trace TLP headers can either be filtered by certain
> > +	 * root port, or by the requester ID. Organize the filters
> > +	 * by @port_filters and @req_filters here. The mask of all
> > +	 * the valid ports is also cached for doing sanity check
> > +	 * of user input.
> > +	 */
> > +	struct list_head port_filters;
> > +	struct list_head req_filters;
> > +	u16 port_mask;
> > +};
> > +
> > +#define to_hisi_ptt(pmu) container_of(pmu, struct hisi_ptt, hisi_ptt_pmu)
> > +
> > +#endif /* _HISI_PTT_H */
> > -- 
> > 2.24.0
> > 

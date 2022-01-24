Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35805498092
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jan 2022 14:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242873AbiAXNMk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jan 2022 08:12:40 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:31181 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242813AbiAXNMj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jan 2022 08:12:39 -0500
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Jj9LX513lz8wWb;
        Mon, 24 Jan 2022 21:09:40 +0800 (CST)
Received: from localhost.localdomain (10.67.164.66) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 21:12:35 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <gregkh@linuxfoundation.org>, <helgaas@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <lorenzo.pieralisi@arm.com>,
        <will@kernel.org>, <mark.rutland@arm.com>,
        <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>, <leo.yan@linaro.org>,
        <jonathan.cameron@huawei.com>, <daniel.thompson@linaro.org>,
        <joro@8bytes.org>, <john.garry@huawei.com>,
        <shameerali.kolothum.thodi@huawei.com>, <robin.murphy@arm.com>,
        <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <coresight@lists.linaro.org>, <linux-pci@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>
CC:     <prime.zeng@huawei.com>, <liuqi115@huawei.com>,
        <zhangshaokun@hisilicon.com>, <linuxarm@huawei.com>,
        <yangyicong@hisilicon.com>, <song.bao.hua@hisilicon.com>
Subject: [PATCH v3 2/8] hisi_ptt: Register PMU device for PTT trace
Date:   Mon, 24 Jan 2022 21:11:12 +0800
Message-ID: <20220124131118.17887-3-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220124131118.17887-1-yangyicong@hisilicon.com>
References: <20220124131118.17887-1-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Register PMU device of PTT trace, then users can use
trace through perf command. The driver makes use of perf
AUX trace and support following events to configure the
trace:

- filter: select Root port or Endpoint to trace
- type: select the type of traced TLP headers
- direction: select the direction of traced TLP headers
- format: select the data format of the traced TLP headers

This patch adds the PMU driver part of PTT trace. The perf
command support of PTT trace is added in the following
patch.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/hwtracing/ptt/hisi_ptt.c | 459 ++++++++++++++++++++++++++++++-
 drivers/hwtracing/ptt/hisi_ptt.h |  22 ++
 2 files changed, 480 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
index 6d0a0ca5c0a9..eeb8afc65a56 100644
--- a/drivers/hwtracing/ptt/hisi_ptt.c
+++ b/drivers/hwtracing/ptt/hisi_ptt.c
@@ -17,6 +17,7 @@
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/sysfs.h>
+#include <linux/vmalloc.h>
 
 #include "hisi_ptt.h"
 
@@ -161,16 +162,67 @@ static int hisi_ptt_trace_start(struct hisi_ptt *hisi_ptt)
 	return 0;
 }
 
+static int hisi_ptt_update_aux(struct hisi_ptt *hisi_ptt, int index, bool stop)
+{
+	struct perf_output_handle *handle = &hisi_ptt->trace_ctrl.handle;
+	struct perf_event *event = handle->event;
+	struct hisi_ptt_dma_buffer *cur;
+	struct hisi_ptt_pmu_buf *buf;
+
+	buf = perf_get_aux(handle);
+	if (!buf || !handle->size)
+		return -EINVAL;
+
+	list_for_each_entry(cur, &hisi_ptt->trace_ctrl.trace_buf, list)
+		if (cur->index == index)
+			break;
+
+	memcpy(buf->base + buf->pos, cur->addr, cur->size);
+	memset(cur->addr, 0, cur->size);
+	buf->pos += cur->size;
+
+	if (stop) {
+		perf_aux_output_end(handle, buf->pos);
+	} else if (buf->length - buf->pos < cur->size) {
+		perf_aux_output_skip(handle, buf->length - buf->pos);
+		perf_aux_output_end(handle, buf->pos);
+
+		buf = perf_aux_output_begin(handle, event);
+		if (!buf)
+			return -EINVAL;
+
+		buf->pos = handle->head % buf->length;
+		if (buf->length - buf->pos < cur->size) {
+			perf_aux_output_end(handle, 0);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 static irqreturn_t hisi_ptt_isr(int irq, void *context)
 {
 	struct hisi_ptt *hisi_ptt = context;
-	u32 status;
+	u32 status, buf_idx;
 
 	status = readl(hisi_ptt->iobase + HISI_PTT_TRACE_INT_STAT);
+	buf_idx = ffs(status) - 1;
 
 	/* Clear the interrupt status of buffer @buf_idx */
 	writel(status, hisi_ptt->iobase + HISI_PTT_TRACE_INT_STAT);
 
+	/*
+	 * Update the AUX buffer and cache the current buffer index,
+	 * as we need to know this and save the data when the trace
+	 * is ended out of the interrupt handler. End the trace
+	 * if the updating fails.
+	 */
+	if (hisi_ptt_update_aux(hisi_ptt, buf_idx, false))
+		hisi_ptt_trace_end(hisi_ptt);
+	else
+		hisi_ptt->trace_ctrl.buf_index = (buf_idx + 1) % HISI_PTT_TRACE_BUF_CNT;
+
 	return IRQ_HANDLED;
 }
 
@@ -294,6 +346,405 @@ static void hisi_ptt_init_ctrls(struct hisi_ptt *hisi_ptt)
 	hisi_ptt->trace_ctrl.default_cpu = cpumask_first(cpumask_of_node(dev_to_node(&pdev->dev)));
 }
 
+#define HISI_PTT_PMU_FILTER_IS_PORT	BIT(19)
+#define HISI_PTT_PMU_FILTER_VAL_MASK	GENMASK(15, 0)
+#define HISI_PTT_PMU_DIRECTION_MASK	GENMASK(23, 20)
+#define HISI_PTT_PMU_TYPE_MASK		GENMASK(31, 24)
+#define HISI_PTT_PMU_FORMAT_MASK	GENMASK(35, 32)
+
+static ssize_t available_filters_show(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf)
+{
+	struct hisi_ptt *hisi_ptt = to_hisi_ptt(dev_get_drvdata(dev));
+	struct hisi_ptt_filter_desc *filter;
+	int pos = 0;
+
+	if (list_empty(&hisi_ptt->port_filters))
+		return sysfs_emit(buf, "#### No available filter ####\n");
+
+	mutex_lock(&hisi_ptt->mutex);
+	pos += sysfs_emit_at(buf, pos, "#### Root Ports ####\n");
+	list_for_each_entry(filter, &hisi_ptt->port_filters, list)
+		pos += sysfs_emit_at(buf, pos, "%s	0x%05lx\n",
+				     pci_name(filter->pdev),
+				     hisi_ptt_get_filter_val(filter->pdev) |
+				     HISI_PTT_PMU_FILTER_IS_PORT);
+
+	pos += sysfs_emit_at(buf, pos, "#### Requesters ####\n");
+	list_for_each_entry(filter, &hisi_ptt->req_filters, list)
+		pos += sysfs_emit_at(buf, pos, "%s	0x%05x\n",
+				     pci_name(filter->pdev),
+				     hisi_ptt_get_filter_val(filter->pdev));
+
+	mutex_unlock(&hisi_ptt->mutex);
+	return pos;
+}
+static DEVICE_ATTR_ADMIN_RO(available_filters);
+
+PMU_FORMAT_ATTR(filter,		"config:0-19");
+PMU_FORMAT_ATTR(direction,	"config:20-23");
+PMU_FORMAT_ATTR(type,		"config:24-31");
+PMU_FORMAT_ATTR(format,		"config:32-35");
+
+static struct attribute *hisi_ptt_pmu_format_attrs[] = {
+	&format_attr_filter.attr,
+	&format_attr_direction.attr,
+	&format_attr_type.attr,
+	&format_attr_format.attr,
+	NULL
+};
+
+static struct attribute_group hisi_ptt_pmu_format_group = {
+	.name = "format",
+	.attrs = hisi_ptt_pmu_format_attrs,
+};
+
+static struct attribute *hisi_ptt_pmu_filter_attrs[] = {
+	&dev_attr_available_filters.attr,
+	NULL
+};
+
+static struct attribute_group hisi_ptt_pmu_filter_group = {
+	.attrs = hisi_ptt_pmu_filter_attrs,
+};
+
+static const struct attribute_group *hisi_ptt_pmu_groups[] = {
+	&hisi_ptt_pmu_format_group,
+	&hisi_ptt_pmu_filter_group,
+	NULL
+};
+
+/*
+ * The supported value of the direction parameter. See hisi_ptt.rst
+ * documentation for more details.
+ */
+static u32 hisi_ptt_trace_available_direction[] = {
+	0,
+	1,
+	2,
+	3,
+};
+
+/* Different types can be set simultaneously */
+static u32 hisi_ptt_trace_available_type[] = {
+	1,	/* posted_request */
+	2,	/* non-posted_request */
+	4,	/* completion */
+};
+
+static u32 hisi_ptt_trace_availble_format[] = {
+	0,	/* 4DW */
+	1,	/* 8DW */
+};
+
+/*
+ * Check whether the config is valid or not. Some configs are multi-selectable
+ * and can be set simultaneously, while some are single selectable (onehot).
+ * Use this function to check the non-onehot configs while
+ * hisi_ptt_trace_valid_config_onehot() for the onehot ones.
+ */
+static int hisi_ptt_trace_valid_config(u32 val, u32 *available_list, u32 list_size)
+{
+	int i;
+
+	/* The non-onehot configs cannot be 0. */
+	if (!val)
+		return -EINVAL;
+
+	/*
+	 * Walk the available list and clear the valid bits of
+	 * the config. If there is any resident bit after the
+	 * walk then the config is invalid.
+	 */
+	for (i = 0; i < list_size; i++)
+		val &= ~available_list[i];
+
+	return val ? -EINVAL : 0;
+}
+
+static int hisi_ptt_trace_valid_config_onehot(u32 val, u32 *available_list, u32 list_size)
+{
+	int i, ret = -EINVAL;
+
+	for (i = 0; i < list_size; i++)
+		if (val == available_list[i]) {
+			ret = 0;
+			break;
+		}
+
+	return ret;
+}
+
+static int hisi_ptt_trace_init_filter(struct hisi_ptt *hisi_ptt, u64 config)
+{
+	unsigned long val, port_mask = hisi_ptt->port_mask;
+	struct hisi_ptt_filter_desc *filter;
+	int ret = -EINVAL;
+
+	hisi_ptt->trace_ctrl.is_port = FIELD_GET(HISI_PTT_PMU_FILTER_IS_PORT, config);
+	val = FIELD_GET(HISI_PTT_PMU_FILTER_VAL_MASK, config);
+
+	/*
+	 * Port filters are defined as bit mask. For port filters, check
+	 * the bits in the @val are within the range of hisi_ptt->port_mask
+	 * and whether it's empty or not, otherwise user has specified
+	 * some unsupported root ports.
+	 *
+	 * For Requester ID filters, walk the available filter list to see
+	 * whether we have one matched.
+	 */
+	if (!hisi_ptt->trace_ctrl.is_port) {
+		list_for_each_entry(filter, &hisi_ptt->req_filters, list)
+			if (filter->val == val) {
+				ret = 0;
+				break;
+			}
+	} else if (bitmap_subset(&val, &port_mask, BITS_PER_LONG)) {
+		ret = 0;
+	}
+
+	if (ret)
+		return ret;
+
+	hisi_ptt->trace_ctrl.filter = val;
+	return 0;
+}
+
+static int hisi_ptt_pmu_event_init(struct perf_event *event)
+{
+	struct hisi_ptt *hisi_ptt = to_hisi_ptt(event->pmu);
+	struct hisi_ptt_trace_ctrl *ctrl = &hisi_ptt->trace_ctrl;
+	int ret;
+	u32 val;
+
+	if (event->attr.type != hisi_ptt->hisi_ptt_pmu.type)
+		return -ENOENT;
+
+	mutex_lock(&hisi_ptt->mutex);
+
+	ret = hisi_ptt_trace_init_filter(hisi_ptt, event->attr.config);
+	if (ret < 0)
+		goto out;
+
+	val = FIELD_GET(HISI_PTT_PMU_DIRECTION_MASK, event->attr.config);
+	ret = hisi_ptt_trace_valid_config_onehot(val, hisi_ptt_trace_available_direction,
+						 ARRAY_SIZE(hisi_ptt_trace_available_direction));
+	if (ret < 0)
+		goto out;
+	ctrl->direction = val;
+
+	val = FIELD_GET(HISI_PTT_PMU_TYPE_MASK, event->attr.config);
+
+	ret = hisi_ptt_trace_valid_config(val, hisi_ptt_trace_available_type,
+					  ARRAY_SIZE(hisi_ptt_trace_available_type));
+	if (ret < 0)
+		goto out;
+	ctrl->type = val;
+
+	val = FIELD_GET(HISI_PTT_PMU_FORMAT_MASK, event->attr.config);
+	ret = hisi_ptt_trace_valid_config_onehot(val, hisi_ptt_trace_availble_format,
+						 ARRAY_SIZE(hisi_ptt_trace_availble_format));
+	if (ret < 0)
+		goto out;
+	ctrl->format = val;
+
+out:
+	mutex_unlock(&hisi_ptt->mutex);
+	return ret;
+}
+
+static void *hisi_ptt_pmu_setup_aux(struct perf_event *event, void **pages,
+				    int nr_pages, bool overwrite)
+{
+	struct hisi_ptt_pmu_buf *buf;
+	struct page **pagelist;
+	int i;
+
+	if (overwrite) {
+		dev_warn(event->pmu->dev, "Overwrite mode is not supported\n");
+		return NULL;
+	}
+
+	/* If the pages size less than buffers, we cannot start trace */
+	if (nr_pages < HISI_PTT_TRACE_TOTAL_BUF_SIZE / PAGE_SIZE)
+		return NULL;
+
+	buf = kzalloc(sizeof(*buf), GFP_KERNEL);
+	if (!buf)
+		return NULL;
+
+	pagelist = kcalloc(nr_pages, sizeof(*pagelist), GFP_KERNEL);
+	if (!pagelist) {
+		kfree(buf);
+		return NULL;
+	}
+
+	for (i = 0; i < nr_pages; i++)
+		pagelist[i] = virt_to_page(pages[i]);
+
+	buf->base = vmap(pagelist, nr_pages, VM_MAP, PAGE_KERNEL);
+	if (!buf->base) {
+		kfree(pagelist);
+		kfree(buf);
+		return NULL;
+	}
+
+	buf->nr_pages = nr_pages;
+	buf->length = nr_pages * PAGE_SIZE;
+	buf->pos = 0;
+
+	kfree(pagelist);
+	return buf;
+}
+
+static void hisi_ptt_pmu_free_aux(void *aux)
+{
+	struct hisi_ptt_pmu_buf *buf = aux;
+
+	vunmap(buf->base);
+	kfree(buf);
+}
+
+static void hisi_ptt_pmu_start(struct perf_event *event, int flags)
+{
+	struct hisi_ptt *hisi_ptt = to_hisi_ptt(event->pmu);
+	struct perf_output_handle *handle = &hisi_ptt->trace_ctrl.handle;
+	struct hw_perf_event *hwc = &event->hw;
+	struct hisi_ptt_pmu_buf *buf;
+	int cpu = event->cpu;
+	int ret;
+
+	hwc->state = 0;
+	mutex_lock(&hisi_ptt->mutex);
+	if (hisi_ptt->trace_ctrl.status == HISI_PTT_TRACE_STATUS_ON) {
+		pci_dbg(hisi_ptt->pdev, "trace has already started\n");
+		goto stop;
+	}
+
+	if (cpu == -1)
+		cpu = hisi_ptt->trace_ctrl.default_cpu;
+
+	/*
+	 * Handle the interrupt on the same cpu which starts the trace to avoid
+	 * context mismatch. Otherwise we'll trigger the WARN from the perf
+	 * core in event_function_local().
+	 */
+	WARN_ON(irq_set_affinity(pci_irq_vector(hisi_ptt->pdev, HISI_PTT_TRACE_DMA_IRQ),
+				 cpumask_of(cpu)));
+
+	ret = hisi_ptt_alloc_trace_buf(hisi_ptt);
+	if (ret) {
+		pci_dbg(hisi_ptt->pdev, "alloc trace buf failed, ret = %d\n", ret);
+		goto stop;
+	}
+
+	buf = perf_aux_output_begin(handle, event);
+	if (!buf) {
+		pci_dbg(hisi_ptt->pdev, "aux output begin failed\n");
+		goto stop;
+	}
+
+	buf->pos = handle->head % buf->length;
+
+	ret = hisi_ptt_trace_start(hisi_ptt);
+	if (ret) {
+		pci_dbg(hisi_ptt->pdev, "trace start failed, ret = %d\n", ret);
+		perf_aux_output_end(handle, 0);
+		goto stop;
+	}
+
+	mutex_unlock(&hisi_ptt->mutex);
+	return;
+stop:
+	event->hw.state |= PERF_HES_STOPPED;
+	mutex_unlock(&hisi_ptt->mutex);
+}
+
+static void hisi_ptt_pmu_stop(struct perf_event *event, int flags)
+{
+	struct hisi_ptt *hisi_ptt = to_hisi_ptt(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (hwc->state & PERF_HES_STOPPED)
+		return;
+
+	mutex_lock(&hisi_ptt->mutex);
+	if (hisi_ptt->trace_ctrl.status == HISI_PTT_TRACE_STATUS_ON) {
+		hisi_ptt_trace_end(hisi_ptt);
+		WARN(hisi_ptt_wait_trace_hw_idle(hisi_ptt), "Device is still busy");
+		hisi_ptt_update_aux(hisi_ptt, hisi_ptt->trace_ctrl.buf_index, true);
+	}
+	mutex_unlock(&hisi_ptt->mutex);
+
+	hwc->state |= PERF_HES_STOPPED;
+	perf_event_update_userpage(event);
+	hwc->state |= PERF_HES_UPTODATE;
+}
+
+static int hisi_ptt_pmu_add(struct perf_event *event, int flags)
+{
+	struct hisi_ptt *hisi_ptt = to_hisi_ptt(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	int cpu = event->cpu;
+
+	if (cpu == -1 && smp_processor_id() != hisi_ptt->trace_ctrl.default_cpu)
+		return 0;
+
+	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
+
+	if (flags & PERF_EF_START) {
+		hisi_ptt_pmu_start(event, PERF_EF_RELOAD);
+		if (hwc->state & PERF_HES_STOPPED)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void hisi_ptt_pmu_del(struct perf_event *event, int flags)
+{
+	hisi_ptt_pmu_stop(event, PERF_EF_UPDATE);
+}
+
+static void hisi_ptt_unregister_pmu(void *priv)
+{
+	perf_pmu_unregister(priv);
+}
+
+static int hisi_ptt_register_pmu(struct hisi_ptt *hisi_ptt)
+{
+	char *pmu_name;
+	int ret;
+
+	hisi_ptt->hisi_ptt_pmu = (struct pmu) {
+		.module		= THIS_MODULE,
+		.capabilities	= PERF_PMU_CAP_EXCLUSIVE | PERF_PMU_CAP_ITRACE,
+		.task_ctx_nr	= perf_sw_context,
+		.attr_groups	= hisi_ptt_pmu_groups,
+		.event_init	= hisi_ptt_pmu_event_init,
+		.setup_aux	= hisi_ptt_pmu_setup_aux,
+		.free_aux	= hisi_ptt_pmu_free_aux,
+		.start		= hisi_ptt_pmu_start,
+		.stop		= hisi_ptt_pmu_stop,
+		.add		= hisi_ptt_pmu_add,
+		.del		= hisi_ptt_pmu_del,
+	};
+
+	pmu_name = devm_kasprintf(&hisi_ptt->pdev->dev, GFP_KERNEL, "hisi_ptt%u_%u",
+				  hisi_ptt->sicl_id, hisi_ptt->core_id);
+	if (!pmu_name)
+		return -ENOMEM;
+
+	ret = perf_pmu_register(&hisi_ptt->hisi_ptt_pmu, pmu_name, -1);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(&hisi_ptt->pdev->dev,
+					hisi_ptt_unregister_pmu,
+					&hisi_ptt->hisi_ptt_pmu);
+}
+
 /*
  * The DMA of PTT trace can only use direct mapping, due to some
  * hardware restriction. Check whether there is an iommu or the
@@ -359,6 +810,12 @@ static int hisi_ptt_probe(struct pci_dev *pdev,
 
 	hisi_ptt_init_ctrls(hisi_ptt);
 
+	ret = hisi_ptt_register_pmu(hisi_ptt);
+	if (ret) {
+		pci_err(pdev, "failed to register pmu device, ret = %d", ret);
+		return ret;
+	}
+
 	ret = hisi_ptt_check_iommu_mapping(hisi_ptt);
 	if (ret) {
 		pci_err(pdev, "cannot work with non-direct DMA mapping.\n");
diff --git a/drivers/hwtracing/ptt/hisi_ptt.h b/drivers/hwtracing/ptt/hisi_ptt.h
index 8aa5d6b78cc5..002b64dfa42d 100644
--- a/drivers/hwtracing/ptt/hisi_ptt.h
+++ b/drivers/hwtracing/ptt/hisi_ptt.h
@@ -13,6 +13,7 @@
 #include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
+#include <linux/perf_event.h>
 #include <linux/types.h>
 
 /*
@@ -83,6 +84,7 @@ struct hisi_ptt_dma_buffer {
 /**
  * struct hisi_ptt_trace_ctrl - control and status of PTT trace
  * @status:      current trace status
+ * @handle:      perf output handle of current trace session
  * @trace_buf:   the trace buffers for holding the trace data
  * @default_cpu: default cpu to start the trace session
  * @buffer_size: the size of each trace buffer in the list
@@ -95,6 +97,7 @@ struct hisi_ptt_dma_buffer {
  */
 struct hisi_ptt_trace_ctrl {
 	enum hisi_ptt_trace_status status;
+	struct perf_output_handle handle;
 	struct list_head trace_buf;
 	int default_cpu;
 	u32 buffer_size;
@@ -118,9 +121,25 @@ struct hisi_ptt_filter_desc {
 	u16 val;
 };
 
+
+/**
+ * struct hisi_ptt_pmu_buf - descriptor of the AUX buffer of PTT trace
+ * @length:   size of the AUX buffer
+ * @nr_pages: number of pages of the AUX buffer
+ * @base:     start address of AUX buffer
+ * @pos:      position in the AUX buffer to commit traced data
+ */
+struct hisi_ptt_pmu_buf {
+	size_t length;
+	int nr_pages;
+	void *base;
+	long pos;
+};
+
 /**
  * struct hisi_ptt - per PTT device data
  * @trace_ctrl:   the control information of PTT trace
+ * @hisi_ptt_pmu: the pum device of trace
  * @iobase:       base IO address of the device
  * @pdev:         pci_dev of this PTT device
  * @mutex:        mutex to protect the filter list and serialize the perf process.
@@ -135,6 +154,7 @@ struct hisi_ptt_filter_desc {
  */
 struct hisi_ptt {
 	struct hisi_ptt_trace_ctrl trace_ctrl;
+	struct pmu hisi_ptt_pmu;
 	void __iomem *iobase;
 	struct pci_dev *pdev;
 	struct mutex mutex;
@@ -156,4 +176,6 @@ struct hisi_ptt {
 	u16 port_mask;
 };
 
+#define to_hisi_ptt(pmu) container_of(pmu, struct hisi_ptt, hisi_ptt_pmu)
+
 #endif /* _HISI_PTT_H */
-- 
2.24.0


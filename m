Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6FC52865D
	for <lists+linux-pci@lfdr.de>; Mon, 16 May 2022 16:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239076AbiEPODs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 May 2022 10:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243947AbiEPODm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 May 2022 10:03:42 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80483A1B5;
        Mon, 16 May 2022 07:03:39 -0700 (PDT)
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L219d4xX2z67h1V;
        Mon, 16 May 2022 22:00:37 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 16 May 2022 16:03:37 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 16 May
 2022 15:03:35 +0100
Date:   Mon, 16 May 2022 15:03:33 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Yicong Yang <yangyicong@hisilicon.com>
CC:     <gregkh@linuxfoundation.org>, <alexander.shishkin@linux.intel.com>,
        <leo.yan@linaro.org>, <james.clark@arm.com>, <will@kernel.org>,
        <robin.murphy@arm.com>, <acme@kernel.org>, <john.garry@huawei.com>,
        <helgaas@kernel.org>, <lorenzo.pieralisi@arm.com>,
        <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mark.rutland@arm.com>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <prime.zeng@huawei.com>,
        <liuqi115@huawei.com>, <zhangshaokun@hisilicon.com>,
        <linuxarm@huawei.com>
Subject: Re: [PATCH v8 2/8] hwtracing: hisi_ptt: Add trace function support
 for HiSilicon PCIe Tune and Trace device
Message-ID: <20220516150333.000031d7@Huawei.com>
In-Reply-To: <20220516125223.32012-3-yangyicong@hisilicon.com>
References: <20220516125223.32012-1-yangyicong@hisilicon.com>
        <20220516125223.32012-3-yangyicong@hisilicon.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml736-chm.china.huawei.com (10.201.108.87) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 16 May 2022 20:52:17 +0800
Yicong Yang <yangyicong@hisilicon.com> wrote:

> HiSilicon PCIe tune and trace device(PTT) is a PCIe Root Complex integrated
> Endpoint(RCiEP) device, providing the capability to dynamically monitor and
> tune the PCIe traffic and trace the TLP headers.
> 
> Add the driver for the device to enable the trace function. Register PMU
> device of PTT trace, then users can use trace through perf command. The
> driver makes use of perf AUX trace function and support the following
> events to configure the trace:
> 
> - filter: select Root port or Endpoint to trace
> - type: select the type of traced TLP headers
> - direction: select the direction of traced TLP headers
> - format: select the data format of the traced TLP headers
> 
> This patch initially add a basic driver of PTT trace.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

Hi Yicong,

It's been a while since I looked at this driver, so I'll admit
I can't remember if any of the things I've raised below were
previously discussed. 

All minor stuff (biggest is question of failing cleanly in unlikely
case of failing the allocation in the filter addition vs carrying
on anyway), so feel free to add

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> diff --git a/drivers/hwtracing/ptt/Makefile b/drivers/hwtracing/ptt/Makefile
> new file mode 100644
> index 000000000000..908c09a98161
> --- /dev/null
> +++ b/drivers/hwtracing/ptt/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_HISI_PTT) += hisi_ptt.o
> diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
> new file mode 100644
> index 000000000000..ef25ce98f664
> --- /dev/null
> +++ b/drivers/hwtracing/ptt/hisi_ptt.c


...


> +
> +static int hisi_ptt_init_filters(struct pci_dev *pdev, void *data)
> +{
> +	struct hisi_ptt_filter_desc *filter;
> +	struct hisi_ptt *hisi_ptt = data;
> +
> +	filter = kzalloc(sizeof(*filter), GFP_KERNEL);
> +	if (!filter) {
> +		pci_err(hisi_ptt->pdev, "failed to add filter %s\n", pci_name(pdev));

If this fails we carry on anyway (no error checking on the bus_walk).
I think we should error out in that case (would need to use a flag placed
somewhere in hisi_ptt to tell we had an error).

That would complicate the unwind though.
Easiest way to do that unwind is probably to register a separate
devm_add_action_or_reset() callback for each filter.

If you prefer to carry on even with this allocation error, then maybe add a comment
here somewhere to make it clear that will happen.

> +		return -ENOMEM;
> +	}
> +
> +	filter->devid = PCI_DEVID(pdev->bus->number, pdev->devfn);
> +
> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) {
> +		filter->is_port = true;
> +		list_add_tail(&filter->list, &hisi_ptt->port_filters);
> +
> +		/* Update the available port mask */
> +		hisi_ptt->port_mask |= hisi_ptt_get_filter_val(filter->devid, true);
> +	} else {
> +		list_add_tail(&filter->list, &hisi_ptt->req_filters);
> +	}
> +
> +	return 0;
> +}
> +
> +static void hisi_ptt_release_filters(void *data)
> +{
> +	struct hisi_ptt_filter_desc *filter, *tmp;
> +	struct hisi_ptt *hisi_ptt = data;
> +
> +	list_for_each_entry_safe(filter, tmp, &hisi_ptt->req_filters, list) {
> +		list_del(&filter->list);
> +		kfree(filter);

I think with separate release per entry above, this bit become simpler as
we walk all the elements in the devm_ callback list rather than two lists here.

> +	}
> +
> +	list_for_each_entry_safe(filter, tmp, &hisi_ptt->port_filters, list) {
> +		list_del(&filter->list);
> +		kfree(filter);
> +	}
> +}
> +

...

> +
> +static int hisi_ptt_init_ctrls(struct hisi_ptt *hisi_ptt)
> +{
> +	struct pci_dev *pdev = hisi_ptt->pdev;
> +	struct pci_bus *bus;
> +	int ret;
> +	u32 reg;
> +
> +	INIT_LIST_HEAD(&hisi_ptt->port_filters);
> +	INIT_LIST_HEAD(&hisi_ptt->req_filters);
> +
> +	ret = hisi_ptt_config_trace_buf(hisi_ptt);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * The device range register provides the information about the
> +	 * root ports which the RCiEP can control and trace. The RCiEP
> +	 * and the root ports it support are on the same PCIe core, with
> +	 * same domain number but maybe different bus number. The device
> +	 * range register will tell us which root ports we can support,
> +	 * Bit[31:16] indicates the upper BDF numbers of the root port,
> +	 * while Bit[15:0] indicates the lower.
> +	 */
> +	reg = readl(hisi_ptt->iobase + HISI_PTT_DEVICE_RANGE);
> +	hisi_ptt->upper_bdf = FIELD_GET(HISI_PTT_DEVICE_RANGE_UPPER, reg);
> +	hisi_ptt->lower_bdf = FIELD_GET(HISI_PTT_DEVICE_RANGE_LOWER, reg);
> +
> +	bus = pci_find_bus(pci_domain_nr(pdev->bus), PCI_BUS_NUM(hisi_ptt->upper_bdf));
> +	if (bus)
> +		pci_walk_bus(bus, hisi_ptt_init_filters, hisi_ptt);
> +
> +	ret = devm_add_action_or_reset(&pdev->dev, hisi_ptt_release_filters, hisi_ptt);
> +	if (ret)
> +		return ret;
> +
> +	hisi_ptt->trace_ctrl.on_cpu = -1;
> +	return 0;
> +}
> +
> +static ssize_t available_root_port_filters_show(struct device *dev,
> +						struct device_attribute *attr,
> +						char *buf)
> +{
> +	struct hisi_ptt *hisi_ptt = to_hisi_ptt(dev_get_drvdata(dev));
> +	struct hisi_ptt_filter_desc *filter;
> +	int pos = 0;
> +
> +	if (list_empty(&hisi_ptt->port_filters)) {
> +		pos = sysfs_emit(buf, "\n");
> +		goto out;
> +	}
> +
> +	list_for_each_entry(filter, &hisi_ptt->port_filters, list) {
> +		u16 devid = filter->devid;
> +		pos += sysfs_emit_at(buf, pos, "%04x:%02x:%02x.%d\t0x%05lx\n",
> +				     pci_domain_nr(hisi_ptt->pdev->bus),
> +				     PCI_BUS_NUM(devid),
> +				     PCI_SLOT(devid & 0xff),
> +				     PCI_FUNC(devid & 0xff),
> +				     hisi_ptt_get_filter_val(devid, true) |
> +				     HISI_PTT_PMU_FILTER_IS_PORT);
> +	}
> +
> +out:

As below. I'd directly return in the empty case and drop the label.

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
> +	if (list_empty(&hisi_ptt->req_filters)) {
> +		pos = sysfs_emit(buf, "\n");
> +		goto out;
> +	}
> +
> +	list_for_each_entry(filter, &hisi_ptt->req_filters, list) {
> +		u16 devid = filter->devid;
> +		pos += sysfs_emit_at(buf, pos, "%04x:%02x:%02x.%d\t0x%05x\n",
> +				     pci_domain_nr(hisi_ptt->pdev->bus),
> +				     PCI_BUS_NUM(devid),
> +				     PCI_SLOT(devid & 0xff),
> +				     PCI_FUNC(devid & 0xff),
> +				     hisi_ptt_get_filter_val(devid, false));
> +	}
> +
> +out:

Why bother with the label?  Given empty is a special case, you can
just do
	return sysfs_emit(buf, "\n");

above.

> +	return pos;
> +}
> +static DEVICE_ATTR_ADMIN_RO(available_requester_filters);


> +static int hisi_ptt_trace_valid_filter(struct hisi_ptt *hisi_ptt, u64 config)
> +{
> +	unsigned long val, port_mask = hisi_ptt->port_mask;
> +	struct hisi_ptt_filter_desc *filter;
> +	int ret = -EINVAL;
> +
> +	hisi_ptt->trace_ctrl.is_port = FIELD_GET(HISI_PTT_PMU_FILTER_IS_PORT, config);
> +	val = FIELD_GET(HISI_PTT_PMU_FILTER_VAL_MASK, config);
> +
> +	/*
> +	 * Port filters are defined as bit mask. For port filters, check
> +	 * the bits in the @val are within the range of hisi_ptt->port_mask
> +	 * and whether it's empty or not, otherwise user has specified
> +	 * some unsupported root ports.
> +	 *
> +	 * For Requester ID filters, walk the available filter list to see
> +	 * whether we have one matched.
> +	 */
> +	if (!hisi_ptt->trace_ctrl.is_port) {
> +		list_for_each_entry(filter, &hisi_ptt->req_filters, list) {
> +			if (val == hisi_ptt_get_filter_val(filter->devid, filter->is_port)) {
> +				ret = 0;
				return 0; ?

Unless someone has previously requested this particular form...


> +				break;
> +			}
> +		}
> +	} else if (bitmap_subset(&val, &port_mask, BITS_PER_LONG)) {
> +		ret = 0;

		return 0;

> +	}
> +
> +	if (ret)
> +		return ret;

If you get here, return -EINVAL;

> +
> +	return 0;
> +}
> +
> +static void hisi_ptt_pmu_init_configs(struct hisi_ptt *hisi_ptt, struct perf_event *event)

> +static int hisi_ptt_pmu_event_init(struct perf_event *event)
> +{
> +	struct hisi_ptt *hisi_ptt = to_hisi_ptt(event->pmu);
> +	int ret;
> +	u32 val;
> +
> +	if (event->cpu < 0) {
> +		dev_dbg(event->pmu->dev, "Per-task mode not supported\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (event->attr.type != hisi_ptt->hisi_ptt_pmu.type)
> +		return -ENOENT;
> +
> +	ret = hisi_ptt_trace_valid_filter(hisi_ptt, event->attr.config);
> +	if (ret < 0)
> +		return ret;
> +
> +	val = FIELD_GET(HISI_PTT_PMU_DIRECTION_MASK, event->attr.config);
> +	ret = hisi_ptt_trace_valid_direction(val);
> +	if (ret < 0)
> +		return ret;
> +
> +	val = FIELD_GET(HISI_PTT_PMU_TYPE_MASK, event->attr.config);
> +	ret = hisi_ptt_trace_valid_type(val);
> +	if (ret < 0)
> +		return ret;
> +
> +	val = FIELD_GET(HISI_PTT_PMU_FORMAT_MASK, event->attr.config);
> +	ret = hisi_ptt_trace_valid_format(val);
You could do

	return hisi_ptt_trace_valid_format(val);

Up to you on this one.

> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +




> +/*
> + * The DMA of PTT trace can only use direct mapping, due to some
> + * hardware restriction. Check whether there is an IOMMU or the

"Check whether there is no IOMMU or the policy of the IOMMU domain
is passthrough, otherwise the trace cannot work."

(need the "no" for the IOMMU presence)

> + * policy of the IOMMU domain is passthrough, otherwise the trace
> + * cannot work.
> + *
> + * The PTT device is supposed to behind an ARM SMMUv3, which
> + * should have passthrough the device by a quirk.
> + */
> +static int hisi_ptt_check_iommu_mapping(struct pci_dev *pdev)
> +{
> +	struct iommu_domain *iommu_domain;
> +
> +	iommu_domain = iommu_get_domain_for_dev(&pdev->dev);
> +	if (!iommu_domain || iommu_domain->type == IOMMU_DOMAIN_IDENTITY)
> +		return 0;
> +
> +	return -EOPNOTSUPP;
> +}
> +

...

> +
> +static int hisi_ptt_cpu_teardown(unsigned int cpu, struct hlist_node *node)
> +{
> +	struct hisi_ptt *hisi_ptt;
> +	int target, src;
> +
> +	hisi_ptt = hlist_entry_safe(node, struct hisi_ptt, hotplug_node);
> +	src = hisi_ptt->trace_ctrl.on_cpu;
> +
> +	if (!hisi_ptt->trace_ctrl.started || src != cpu)
> +		return 0;
> +
> +	target = cpumask_any(cpumask_of_node(dev_to_node(&hisi_ptt->pdev->dev)));
> +	if (target < nr_cpumask_bits) {
> +		dev_err(hisi_ptt->hisi_ptt_pmu.dev, "no available cpu for perf context migration\n");

Very long line, and not obvious disadvantage in splitting it before the string.

> +		return 0;
> +	}
> +
> +	perf_pmu_migrate_context(&hisi_ptt->hisi_ptt_pmu, src, target);
> +	WARN_ON(irq_set_affinity(pci_irq_vector(hisi_ptt->pdev, HISI_PTT_TRACE_DMA_IRQ),
> +				 cpumask_of(cpu)));
> +	hisi_ptt->trace_ctrl.on_cpu = target;
> +
> +	return 0;
> +}
> +

> diff --git a/drivers/hwtracing/ptt/hisi_ptt.h b/drivers/hwtracing/ptt/hisi_ptt.h
> new file mode 100644
> index 000000000000..2344e4195648
> --- /dev/null
> +++ b/drivers/hwtracing/ptt/hisi_ptt.h


> +/**
> + * struct hisi_ptt_filter_desc - Descriptor of the PTT trace filter
> + * @list:    entry of this descriptor in the filter list
> + * @is_port: the PCI device of the filter is a Root Port or not
> + * @devid:   the PCI device's devid of the filter
> + */
> +struct hisi_ptt_filter_desc {
> +	struct list_head list;
> +	bool is_port;
> +	u16 devid;
> +};
> +
> +

Trivial if you are doing a v9: one blank line only.

> +/**
> + * struct hisi_ptt_pmu_buf - Descriptor of the AUX buffer of PTT trace
> + * @length:   size of the AUX buffer
> + * @nr_pages: number of pages of the AUX buffer
> + * @base:     start address of AUX buffer
> + * @pos:      position in the AUX buffer to commit traced data
> + */
> +struct hisi_ptt_pmu_buf {
> +	size_t length;
> +	int nr_pages;
> +	void *base;
> +	long pos;
> +};
> +


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 982871847FD
	for <lists+linux-pci@lfdr.de>; Fri, 13 Mar 2020 14:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgCMNYF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Mar 2020 09:24:05 -0400
Received: from foss.arm.com ([217.140.110.172]:55204 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbgCMNYF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Mar 2020 09:24:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41DB530E;
        Fri, 13 Mar 2020 06:24:04 -0700 (PDT)
Received: from [192.168.1.123] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB4F73F67D;
        Fri, 13 Mar 2020 06:24:02 -0700 (PDT)
Subject: Re: [PATCH RFC] perf:Add driver for HiSilicon PCIe PMU
To:     Qi Liu <liuqi115@huawei.com>, will@kernel.org,
        mark.rutland@arm.com, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linuxarm@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1584014816-1908-1-git-send-email-liuqi115@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <49a04327-b58b-3103-f992-97e8838c41df@arm.com>
Date:   Fri, 13 Mar 2020 13:23:53 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1584014816-1908-1-git-send-email-liuqi115@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020-03-12 12:06 pm, Qi Liu wrote:
> From: Qi liu <liuqi115@huawei.com>
> 
> PCIe PMU Root Complex Integrate End Point(IEP) device is
> supported to sample bandwidth, latency, buffer occupation,
> bandwidth utilization etc.
> Each PMU IEP device monitors multiple root ports, and each
> IEP is registered as a pmu in /sys/bus/event_source/devices,
> so users can select the target IEP, and use filter to select
> root port, function and event.
> Filtering options are:
> event:    - select the event.
> subevent: - select the subevent.
> port:     - select target root port.
> func:     - select target EP device under the port.
> 
> Example: hisi_pcie_00_14_00/event=0x08,subevent=0x04,   \
> port=0x05,func=0x00/ -I 1000
> 
> PMU IEP device is described by its bus, device and function,
> target root port is 0x05 and target EP under it is function
> 0x00. Subevent 0x04 of event 0x08 is sampled.
> 
> Note that in this RFC:
> 1. PCIe PMU IEP hardware is still in development.
> 2. Perf common event list is undetermined, and name of these
> events still need to be discussed.
> 3. port filter could only select one port each time.
> 4. There are two possible schemes of pmu registration, one is
> register each root port as a pmu, it is easier for users to
> select target port. The other one is register each IEP as pmu,
> for counters are per IEP, not per root port, the second scheme
> describes hardware PMC much more reasonable, but need to add
> "port" filter option to select port. We use the second one in
> this RFC.
> 
> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> ---
>   drivers/perf/Kconfig             |  10 +
>   drivers/perf/Makefile            |   1 +
>   drivers/perf/pci/Makefile        |   2 +
>   drivers/perf/pci/hisi_pcie_pmu.c | 887 +++++++++++++++++++++++++++++++++++++++
>   include/linux/cpuhotplug.h       |   1 +
>   5 files changed, 901 insertions(+)
>   create mode 100644 drivers/perf/pci/Makefile
>   create mode 100644 drivers/perf/pci/hisi_pcie_pmu.c
> 
> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index 09ae8a9..047022b 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -114,6 +114,16 @@ config THUNDERX2_PMU
>   	   The SoC has PMU support in its L3 cache controller (L3C) and
>   	   in the DDR4 Memory Controller (DMC).
>   
> +config PCIE_PMU
> +	tristate "PCIE PERF PMU"

Echoing Bjorn's comment on the config name, the user-visible prompt and 
help text need to be clearer as well. Without more context, my first 
association of "1630" is that it sounds like the model number for some 
old Adaptec SCSI card.

> +	depends on ARM64
There should be nothing architecture-specific about this. It does have a 
clear dependency on PCI though, so Kconfig should reflect that directly. 
(You can include one of the io-64-nonatomic-* headers to allow compile 
testing where readq()/writeq() aren't natively available)

> +	default m
> +	help
> +	   Provide support for 1630 PCIe performance monitoring unit (PMU)
> +	   IEP devices.
> +	   Adds the PCIe PMU into perf events system for monitoring latency,
> +	   bandwidth etc.
> +
>   config XGENE_PMU
>           depends on ARCH_XGENE
>           bool "APM X-Gene SoC PMU"
> diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
> index 2ebb4de..205f346 100644
> --- a/drivers/perf/Makefile
> +++ b/drivers/perf/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_ARM_PMU_ACPI) += arm_pmu_acpi.o
>   obj-$(CONFIG_ARM_SMMU_V3_PMU) += arm_smmuv3_pmu.o
>   obj-$(CONFIG_FSL_IMX8_DDR_PMU) += fsl_imx8_ddr_perf.o
>   obj-$(CONFIG_HISI_PMU) += hisilicon/
> +obj-$(CONFIG_PCIE_PMU) += pci/

The current drivers are collected by vendor, not by what "type" of PMU 
they are, so shouldn't this belong with the other HiSilicon drivers?

>   obj-$(CONFIG_QCOM_L2_PMU)	+= qcom_l2_pmu.o
>   obj-$(CONFIG_QCOM_L3_PMU) += qcom_l3_pmu.o
>   obj-$(CONFIG_THUNDERX2_PMU) += thunderx2_pmu.o
> diff --git a/drivers/perf/pci/Makefile b/drivers/perf/pci/Makefile
> new file mode 100644
> index 0000000..a729afc
> --- /dev/null
> +++ b/drivers/perf/pci/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_PCIE_PMU) += hisi_pcie_pmu.o
> \ No newline at end of file
> diff --git a/drivers/perf/pci/hisi_pcie_pmu.c b/drivers/perf/pci/hisi_pcie_pmu.c
> new file mode 100644
> index 0000000..1875953
> --- /dev/null
> +++ b/drivers/perf/pci/hisi_pcie_pmu.c
> @@ -0,0 +1,887 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * This driver adds support for PCIe PMU IEP device. Related
> + * perf events are bandwidth, bandwidth utilization, latency
> + * etc.
> + *
> + * Copyright (C) 2020 Hisilicon Limited
> + * Author: Qi Liu<liuqi115@huawei.com>
> + */
> +#include <linux/bitfield.h>
> +#include <linux/bitmap.h>
> +#include <linux/bug.h>
> +#include <linux/cpuhotplug.h>
> +#include <linux/cpumask.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/pci.h>
> +#include <linux/perf_event.h>
> +#include <linux/smp.h>
> +#include <linux/types.h>
> +#include <asm/local64.h>
> +
> +#define HISI_PCIE_NR_COUNTERS			4
> +#define HISI_PCIE_CHECK_EVENT			0xffff/* need to check */
> +#define HISI_PCIE_CHECK_SUBEVENT		0xffff/* need to check */
> +#define HISI_PCIE_CHECK_PORT			0x13
> +#define HISI_PCIE_CHECK_FUNC			0xff/* need to check */

What does "need to check" mean here - that you're not sure if these 
values are correct, or something else?

> +
> +/* define IRQ */
> +#define HISI_PCIE_IRQ_MIN_VECS			1
> +#define HISI_PCIE_IRQ_MAX_VECS			1
> +#define HISI_PCIE_EVENT_IRQ_VECTOR		0
> +/* define PCIE REGISTERS */
> +#define HISI_PCIE_PCI_BAR_NUM			2
> +#define HISI_PCIE_INT				0x0804
> +#define HISI_PCIE_INT_CTRL			0x0808
> +#define HISI_PCIE_INT_CLEAR			0x080C
> +#define HISI_PCIE_EVENT_CTRL			0x1E04
> +#define HISI_PCIE_PERF_CTRL			0x1E00
> +#define HISI_PCIE_PMC_BASE			0x1F00
> +#define HISI_PCIE_PMC_STEP			30
> +#define HISI_PCIE_CTRL_STEP			30
> +#define HISI_PCIE_BAR_VERSION			10
> +#define HISI_PCIE_BAR_VALID			20
> +/* define PCIE CTRL CMD */
> +#define HISI_PCIE_CTRL_EN			0x01
> +#define HISI_PCIE_DEVICE_ID			0xa250
> +/* Filter offset in ctrl regesiter*/
> +#define HISI_PCIE_EVENT_CTRL_SUBEVENT_OFF	32
> +#define HISI_PCIE_EVENT_CTRL_FUNC_OFF		16
> +#define HISI_PCIE_EVENT_CTRL_PORT_OFF		8
> +
> +#define HISI_PCIE_EVENT_SHIFT_M			GENMASK(15, 0)
> +#define HISI_PCIE_SUBEVENT_SHIFT_M		GENMASK(31, 16)
> +#define HISI_PCIE_SUBEVENT_SHIFT_S		16
> +#define HISI_PCIE_PORT_SHIFT_M			GENMASK(7, 0)
> +#define HISI_PCIE_FUNC_SHIFT_M			GENMASK(15, 8)
> +#define HISI_PCIE_FUNC_SHIFT_S			8

So "SHIFT_S" means "shift" and "SHIFT_M" actually means "mask"? That's 
unnecessarily confusing. Furthermore it might be helpful if there was a 
more obvious distinction between hardware register fields and config fields.

> +
> +#define to_pcie_pmu(p)	(container_of((p), struct hisi_pcie_pmu, pmu))
> +
> +#define HISI_PCIE_ATTR(_name, _func, _config)				    \
> +	(&((struct dev_ext_attribute[]) {				    \
> +		{ __ATTR(_name, 0444, _func, NULL), (void *)_config }       \
> +	})[0].attr.attr)
> +
> +#define HISI_PCIE_FORMAT_ATTR(_name, _config)				    \
> +	HISI_PCIE_ATTR(_name, hisi_pcie_format_sysfs_show, (void *)_config)
> +
> +#define HISI_PCIE_EVENT_ATTR(_name, _config)				    \
> +	HISI_PCIE_ATTR(_name, hisi_pcie_event_sysfs_show,		    \
> +		       (unsigned long)_config)
> +
> +struct hisi_pmu_events {
> +	struct perf_event *hw_events[HISI_PCIE_NR_COUNTERS];
> +	DECLARE_BITMAP(used_mask, HISI_PCIE_NR_COUNTERS);
> +};
> +
> +struct hisi_pcie_pmu {
> +	struct pmu pmu;
> +	struct hisi_pmu_events pmu_events;
> +	void __iomem *base;
> +	struct pci_dev *pdev;
> +	struct hlist_node node;
> +	int version;
> +	u32 domain_id;
> +	int device_id;
> +	int func_id;
> +	int bus_id;
> +	const char *dev_name;
> +	int check_event;
> +	int check_subevent;
> +	int check_func;
> +	int num_counters;
> +	int counter_bits;
> +	int irq;
> +	/* associated_cpus: All CPUs associated with the PMU */
> +	cpumask_t associated_cpus;
> +	/* CPU used for counting event */
> +	int on_cpu;
> +};
> +
> +/* PCIE PMU format attributes */
> +ssize_t hisi_pcie_format_sysfs_show(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	struct dev_ext_attribute *eattr;
> +
> +	eattr = container_of(attr, struct dev_ext_attribute, attr);
> +
> +	return sprintf(buf, "%s\n", (char *)eattr->var);
> +}
> +
> +/* PCIE PMU event attributes */
> +ssize_t hisi_pcie_event_sysfs_show(struct device *dev,
> +				   struct device_attribute *attr, char *page)
> +{
> +	struct dev_ext_attribute *eattr;
> +
> +	eattr = container_of(attr, struct dev_ext_attribute, attr);
> +
> +	return sprintf(page, "config=0x%lx\n", (unsigned long)eattr->var);
> +}
> +
> +/* PCIE PMU cpumask attributes */
> +ssize_t cpumask_show(struct device *dev, struct device_attribute *attr,
> +		     char *buf)
> +{
> +	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(dev_get_drvdata(dev));
> +
> +	return sprintf(buf, "%d\n", pcie_pmu->on_cpu);
> +}
> +
> +static bool hisi_validate_event_group(struct perf_event *event)
> +{
> +	struct perf_event *sibling, *leader = event->group_leader;
> +	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(event->pmu);
> +	/* Include count for the event */
> +	int counters = 1;
> +
> +	if (!is_software_event(leader)) {
> +		/*
> +		 * We must NOT create groups containing mixed PMUs, although
> +		 * software events are acceptable
> +		 */
> +		if (leader->pmu != event->pmu)
> +			return false;
> +
> +		/* Increment counter for the leader */
> +		if (leader != event)
> +			counters++;
> +	}
> +
> +	for_each_sibling_event(sibling, event->group_leader) {
> +		if (is_software_event(sibling))
> +			continue;
> +
> +		if (sibling->pmu != event->pmu)
> +			return false;
> +
> +		/* Increment counter for each sibling */
> +		counters++;
> +	}
> +
> +	/* The group can not count events more than the counters in the HW */
> +	return counters <= pcie_pmu->num_counters;
> +}
> +
> +static int is_valid_port(struct hisi_pcie_pmu *pcie_pmu, int port)
> +{
> +	u32 val;
> +
> +	if (port > HISI_PCIE_CHECK_PORT)
> +		return 0;
> +	val = readl(pcie_pmu->base + HISI_PCIE_BAR_VALID);
> +	val &= BIT(port);
> +	return val;
> +}
> +
> +int hisi_pcie_pmu_event_init(struct perf_event *event)
> +{
> +	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	u32 subevent_id, event_id, func_id, port_id;
> +
> +	if (event->attr.type != event->pmu->type)
> +		return -ENOENT;
> +
> +	/*
> +	 * We do not support sampling as the counters are all shared by all
> +	 * CPU cores in a CPU die(SCCL). Also we do not support attach to a

Do the PCIe counters have anything to do with CPU clusters at all?

> +	 * task(per-process mode)
> +	 */
> +	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
> +		return -EOPNOTSUPP;
> +
> +	/*
> +	 * The uncore counters not specific to any CPU, so cannot
> +	 * support per-task
> +	 */
> +	if (event->cpu < 0)
> +		return -EINVAL;
> +
> +	/*
> +	 * Validate if the events in group does not exceed the
> +	 * available counters in hardware.
> +	 */
> +	if (!hisi_validate_event_group(event))
> +		return -EINVAL;
> +
> +	event_id = event->attr.config && HISI_PCIE_EVENT_SHIFT_M;

Really? Are you sure you've tested this properly?

> +	subevent_id = (event->attr.config && HISI_PCIE_SUBEVENT_SHIFT_M)
> +		       >> HISI_PCIE_SUBEVENT_SHIFT_S;

Ditto.

> +	port_id = (event->attr.config1) & HISI_PCIE_PORT_SHIFT_M;
> +	func_id = (event->attr.config1) & HISI_PCIE_FUNC_SHIFT_M >>
> +		  HISI_PCIE_FUNC_SHIFT_S;
> +
> +	/* Check whether target port is managed by this IEP */
> +	if (!is_valid_port(pcie_pmu, port_id))
> +		return -EINVAL;
> +
> +	if (event_id > pcie_pmu->check_event || subevent_id >
> +	    pcie_pmu->check_subevent || func_id > pcie_pmu->check_func)
> +		return -EINVAL;
> +
> +	/*
> +	 * We don't assign an index until we actually place the event onto
> +	 * hardware. Use -1 to signify that we haven't decided where to put
> +	 * it yet.
> +	 */
> +	hwc->idx = -1;
> +
> +	/* Enforce to use the same CPU for all events in this PMU */
> +	event->cpu = pcie_pmu->on_cpu;
> +
> +	return 0;
> +}
> +
> +static u32 hisi_pcie_pmu_counter_off(int idx)
> +{
> +	return HISI_PCIE_PMC_BASE + HISI_PCIE_PMC_STEP * idx;
> +}
> +
> +static u32 hisi_pcie_pmu_ctrl_off(int idx)
> +{
> +	return HISI_PCIE_EVENT_CTRL + HISI_PCIE_CTRL_STEP * idx;
> +}
> +
> +int hisi_pcie_pmu_counter_valid(struct hisi_pcie_pmu *pcie_pmu, int idx)
> +{
> +	return idx >= 0 && idx < pcie_pmu->num_counters;
> +}
> +
> +int hisi_pcie_pmu_get_event_idx(struct hisi_pcie_pmu *pcie_pmu)
> +{
> +	unsigned long *used_mask = pcie_pmu->pmu_events.used_mask;
> +	u32 num_counters = pcie_pmu->num_counters;
> +	int idx;
> +
> +	idx = find_first_zero_bit(used_mask, num_counters);
> +	if (idx == num_counters)
> +		return -EAGAIN;
> +
> +	set_bit(idx, used_mask);
> +
> +	return idx;
> +}
> +
> +static void hisi_pcie_pmu_clear_event_idx(struct hisi_pcie_pmu *pcie_pmu,
> +					  int idx)
> +{
> +	if (!hisi_pcie_pmu_counter_valid(pcie_pmu, idx)) {
> +		pci_err(pcie_pmu->pdev, "Unsupported event index:%d!\n", idx);
> +		return;
> +	}
> +
> +	clear_bit(idx, pcie_pmu->pmu_events.used_mask);
> +}
> +
> +static void hisi_pcie_pmu_set_period(struct perf_event *event)
> +{
> +	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	/*
> +	 * Set PMC to 2^(counter_bits - 1) to account for the extreme interrupt
> +	 * latency. So we could hopefully handle the overflow interrupt before
> +	 * another 2^(counter_bits - 1) events occur and the counter overtakes
> +	 * its previous value.
> +	 */

Personally I have a standing objection to that comment being blindly 
copied around system PMU drivers which don't support sampling, but I 
guess that's not really your fault :)

(FWIW there are still some justifications for using the same pattern for 
simple overflow accumulation, but it's not as critical is it is for 
sampling periods).

> +	u64 val = BIT_ULL(pcie_pmu->counter_bits - 1);
> +
> +	local64_set(&hwc->prev_count, val);
> +	/* Write start value to the hardware event counter */
> +	if (!hisi_pcie_pmu_counter_valid(pcie_pmu, hwc->idx))
> +		writeq(val, pcie_pmu->base +
> +		       hisi_pcie_pmu_counter_off(hwc->idx));
> +}
> +
> +static void hisi_pcie_pmu_write_counter(struct hisi_pcie_pmu *pcie_pmu,
> +					struct hw_perf_event *hwc, u64 val)
> +{
> +	u32 idx = hwc->idx;
> +
> +	if (!hisi_pcie_pmu_counter_valid(pcie_pmu, idx)) {
> +		pci_err(pcie_pmu->pdev, "Unsupported event index:%d!\n", idx);
> +		return;
> +	}
> +
> +	writeq(val, pcie_pmu->base + hisi_pcie_pmu_counter_off(idx));
> +}
> +
> +static void hisi_pcie_pmu_enable_counter(struct hisi_pcie_pmu *pcie_pmu,
> +					 struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	u64 port, event_id, subevent, func;
> +	u64 val;
> +
> +	event_id = (event->attr.config) & HISI_PCIE_EVENT_SHIFT_M;
> +	subevent = (event->attr.config & HISI_PCIE_SUBEVENT_SHIFT_M) >>
> +		   HISI_PCIE_SUBEVENT_SHIFT_S;

You included bitfield.h, why not make use of it?

> +	port = (event->attr.config1) & HISI_PCIE_PORT_SHIFT_M;
> +	port = port & GENMASK(2, 0);

Why isn't HISI_PCIE_PORT_SHIFT_M the correct size to begin with?

> +	func = (event->attr.config1 & HISI_PCIE_FUNC_SHIFT_M) >>
> +		HISI_PCIE_FUNC_SHIFT_S;
> +
> +	/* Enable counter index in corresponding ctrl register */
> +	val = readq(pcie_pmu->base + hisi_pcie_pmu_ctrl_off(hwc->idx));
> +	val |= event_id;
> +	val |= subevent >> HISI_PCIE_EVENT_CTRL_SUBEVENT_OFF;

Really? Are you *sure* you've tested this properly?

> +	val |= func >> HISI_PCIE_EVENT_CTRL_FUNC_OFF;
> +	val |= port >> HISI_PCIE_EVENT_CTRL_PORT_OFF;

Ditto for those two.

> +	writeq(val, pcie_pmu->base + hisi_pcie_pmu_ctrl_off(hwc->idx));
> +}
> +
> +static void hisi_pcie_pmu_disable_counter(struct hisi_pcie_pmu *pcie_pmu,
> +					  struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	u64 port, event_id, subevent, func;
> +	u64 val;
> +
> +	event_id = (event->attr.config) & HISI_PCIE_EVENT_SHIFT_M;
> +	subevent = (event->attr.config & HISI_PCIE_SUBEVENT_SHIFT_M) >>
> +		   HISI_PCIE_SUBEVENT_SHIFT_S;
> +	func = event->attr.config1;
> +	port = (event->attr.config1) & HISI_PCIE_PORT_SHIFT_M;
> +	port = port & GENMASK(2, 0);
> +	func = (event->attr.config1) & HISI_PCIE_FUNC_SHIFT_M >>
> +		HISI_PCIE_FUNC_SHIFT_S;
> +
> +	/* Clear counter index in corresponding ctrl register */
> +	val = readq(pcie_pmu->base + hisi_pcie_pmu_ctrl_off(hwc->idx));
> +	val &= ~(event_id);

Why not just clear the whole field without having to bother with what 
the exact previous value was?

> +	val &= ~(subevent >> HISI_PCIE_EVENT_CTRL_SUBEVENT_OFF);
> +	val &= ~(func >> HISI_PCIE_EVENT_CTRL_FUNC_OFF);
> +	val &= ~(port >> HISI_PCIE_EVENT_CTRL_PORT_OFF);

Ditto for those, if they weren't entirely broken anyway.

> +	writeq(val, pcie_pmu->base + hisi_pcie_pmu_ctrl_off(hwc->idx));
> +}
> +
> +void hisi_pcie_pmu_enable_int(struct hisi_pcie_pmu *pcie_pmu,
> +			      struct hw_perf_event *hwc)
> +{
> +	u32 val;
> +
> +	val = readl(pcie_pmu->base + HISI_PCIE_INT_CTRL);
> +	/* Write 0 to enable interrupt */
> +	val &= ~(1 << hwc->idx);
> +	writel(val, pcie_pmu->base + HISI_PCIE_INT_CTRL);
> +}
> +
> +void hisi_pcie_pmu_disable_int(struct hisi_pcie_pmu *pcie_pmu,
> +			       struct hw_perf_event *hwc)
> +{
> +	u32 val;
> +
> +	val = readl(pcie_pmu->base + HISI_PCIE_INT_CTRL);
> +	/* Write 1 to mask interrupt */
> +	val |= (1 << hwc->idx);
> +	writel(val, pcie_pmu->base + HISI_PCIE_INT_CTRL);
> +}
> +
> +void hisi_pcie_pmu_start(struct perf_event *event, int flags)
> +{
> +	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	u64 prev_raw_count;
> +
> +	if (WARN_ON_ONCE(!(hwc->state & PERF_HES_STOPPED)))
> +		return;
> +
> +	WARN_ON_ONCE(!(hwc->state & PERF_HES_UPTODATE));
> +	hwc->state = 0;
> +	hisi_pcie_pmu_set_period(event);
> +
> +	if (flags & PERF_EF_RELOAD) {
> +		prev_raw_count =  local64_read(&hwc->prev_count);
> +		hisi_pcie_pmu_write_counter(pcie_pmu, hwc, prev_raw_count);
> +	}
> +
> +	hisi_pcie_pmu_enable_int(pcie_pmu, hwc);
> +	hisi_pcie_pmu_enable_counter(pcie_pmu, event);
> +	perf_event_update_userpage(event);
> +}
> +
> +void hisi_pcie_pmu_read(struct perf_event *event)
> +{
> +	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	u64 new_count, prev_count;
> +
> +	do {
> +		/* Read the count from the counter register */
> +		new_count = readq(pcie_pmu->base +
> +				  hisi_pcie_pmu_counter_off(hwc->idx));
> +		prev_count = local64_read(&hwc->prev_count);
> +	} while (local64_cmpxchg(&hwc->prev_count, prev_count,
> +				 new_count) != prev_count);
> +
> +	local64_add(new_count, &event->count);

What if a read happens just after the counter wraps to 0 but before the 
overflow interrupt is handled?

> +}
> +
> +void hisi_pcie_pmu_stop(struct perf_event *event, int flags)
> +{
> +	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	hisi_pcie_pmu_disable_counter(pcie_pmu, event);
> +	hisi_pcie_pmu_disable_int(pcie_pmu, hwc);
> +	WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
> +	hwc->state |= PERF_HES_STOPPED;
> +
> +	if (hwc->state & PERF_HES_UPTODATE)
> +		return;
> +
> +	/* Read hardware counter and update the perf counter statistics */
> +	hisi_pcie_pmu_read(event);
> +	hwc->state |= PERF_HES_UPTODATE;
> +}
> +
> +int hisi_pcie_pmu_add(struct perf_event *event, int flags)
> +{
> +	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	int idx;
> +
> +	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
> +
> +	/* Get an available counter index for counting */
> +	idx = hisi_pcie_pmu_get_event_idx(pcie_pmu);
> +	if (idx < 0)
> +		return idx;

FWIW the used_mask bitmap here really has no benefit over simply 
iterating hw_events to find a NULL entry.

> +
> +	event->hw.idx = idx;
> +	pcie_pmu->pmu_events.hw_events[idx] = event;
> +
> +	if (flags & PERF_EF_START)
> +		hisi_pcie_pmu_start(event, PERF_EF_RELOAD);
> +
> +	return 0;
> +}
> +
> +void hisi_pcie_pmu_del(struct perf_event *event, int flags)
> +{
> +	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	hisi_pcie_pmu_stop(event, PERF_EF_UPDATE);
> +	pcie_pmu->pmu_events.hw_events[hwc->idx] = NULL;
> +	hisi_pcie_pmu_clear_event_idx(pcie_pmu, hwc->idx);
> +	perf_event_update_userpage(event);
> +}
> +
> +void hisi_pcie_pmu_enable(struct pmu *pmu)
> +{
> +	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(pmu);
> +	int enabled = bitmap_weight(pcie_pmu->pmu_events.used_mask,
> +				    pcie_pmu->num_counters);
> +	u32 val;
> +
> +	if (!enabled)
> +		return;
> +
> +	/* Start counting for all enabled counters */
> +	val = readl(pcie_pmu->base + HISI_PCIE_PERF_CTRL);
> +	val |= HISI_PCIE_CTRL_EN;
> +	writel(val, pcie_pmu->base + HISI_PCIE_PERF_CTRL);
> +}
> +
> +void hisi_pcie_pmu_disable(struct pmu *pmu)
> +{
> +	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(pmu);
> +	u32 val;
> +
> +	/* Stop counting for all enabled counters */
> +	val = readl(pcie_pmu->base + HISI_PCIE_PERF_CTRL);
> +	val &= ~(HISI_PCIE_CTRL_EN);
> +	writel(val, pcie_pmu->base + HISI_PCIE_PERF_CTRL);
> +}
> +
> +static irqreturn_t hisi_pcie_pmu_irq(int irq, void *data)
> +{
> +	struct hisi_pcie_pmu *pcie_pmu = data;
> +	struct perf_event *event;
> +	unsigned long overflown;
> +	int idx;
> +
> +	overflown = readl(pcie_pmu->base + HISI_PCIE_INT);
> +	if (!overflown)
> +		return IRQ_NONE;
> +
> +	/*
> +	 * Find the counter index which overflowed if the bit was set
> +	 * and handle it.
> +	 */
> +	for_each_set_bit(idx, &overflown, HISI_PCIE_NR_COUNTERS) {
> +		/* Write 1 to clear the IRQ status flag */
> +		writel((1 << idx), pcie_pmu->base + HISI_PCIE_INT_CLEAR);
> +		/* Get the corresponding event struct */
> +		event = pcie_pmu->pmu_events.hw_events[idx];
> +		if (!event)
> +			continue;
> +
> +		hisi_pcie_pmu_read(event);
> +		hisi_pcie_pmu_set_period(event);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int hisi_pcie_pmu_irq_register(struct pci_dev *pdev,
> +				      struct hisi_pcie_pmu *pcie_pmu)
> +{
> +	int irq, ret;
> +
> +	irq = pci_irq_vector(pdev, HISI_PCIE_EVENT_IRQ_VECTOR);
> +	ret = request_irq(irq, hisi_pcie_pmu_irq, IRQF_SHARED,
> +			  pcie_pmu->dev_name, pcie_pmu);
> +	if (ret)
> +		return ret;
> +
> +	pcie_pmu->irq = irq;
> +	return ret;
> +}
> +
> +static int hisi_pcie_associate_cpu(struct hisi_pcie_pmu *pcie_pmu,
> +				   unsigned int cpu)
> +{
> +	struct device *dev = &pcie_pmu->pdev->dev;
> +	const struct cpumask *mask;
> +
> +	/*
> +	 * Check whether this CPU is associated with this PCIe PMU
> +	 * according to the NUMA node.
> +	 */
> +	mask = (dev_to_node(dev) == -1) ? cpu_online_mask :
> +		cpumask_of_node(dev_to_node(dev));
> +
> +	return cpumask_test_cpu(cpu, mask);
> +}
> +
> +int hisi_pcie_pmu_online_cpu(unsigned int cpu, struct hlist_node *node)
> +{
> +	struct hisi_pcie_pmu *pcie_pmu = hlist_entry_safe(node,
> +							  struct hisi_pcie_pmu,
> +							  node);
> +
> +	if (!hisi_pcie_associate_cpu(pcie_pmu, cpu))
> +		return 0;
> +
> +	cpumask_set_cpu(cpu, &pcie_pmu->associated_cpus);
> +	if (pcie_pmu->on_cpu != -1)
> +		return 0;
> +
> +	/* Use this CPU in cpumask for event counting */
> +	pcie_pmu->on_cpu = cpu;
> +
> +	return 0;
> +}
> +
> +int hisi_pcie_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
> +{
> +	struct hisi_pcie_pmu *pcie_pmu = hlist_entry_safe(node,
> +							  struct hisi_pcie_pmu,
> +							  node);
> +	cpumask_t pmu_online_cpus;
> +	unsigned int target;
> +
> +	if (!cpumask_test_and_clear_cpu(cpu, &pcie_pmu->associated_cpus))
> +		return 0;
> +
> +	if (pcie_pmu->on_cpu != cpu)
> +		return 0;
> +
> +	/* Give up ownership of the PMU */
> +	pcie_pmu->on_cpu = -1;
> +
> +	/* Choose a new CPU to migrate ownership of the PMU to */
> +	cpumask_and(&pmu_online_cpus, &pcie_pmu->associated_cpus,
> +		    cpu_online_mask);
> +	target = cpumask_any_but(&pmu_online_cpus, cpu);
> +	if (target >= nr_cpu_ids)
> +		return 0;
> +
> +	pcie_pmu->on_cpu = target;
> +	perf_pmu_migrate_context(&pcie_pmu->pmu, cpu, target);
> +
> +	return 0;
> +}
> +
> +static const struct pci_device_id hisi_pcie_pmu_ids[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, HISI_PCIE_DEVICE_ID) },
> +	{ 0, }
> +};
> +MODULE_DEVICE_TABLE(pci, hisi_pcie_pmu_ids);
> +
> +static struct attribute *hisi_pcie_pmu_events_attr[] = {
> +	/*
> +	 * common events list haven't been confirmed yet,
> +	 * and the name and code of event still need to
> +	 * be discussed.
> +	 */
> +	HISI_PCIE_EVENT_ATTR(upstream_wr_bandwidth,	0x00010008),
> +	HISI_PCIE_EVENT_ATTR(upstream_rd_bandwidth,	0x00100008),
> +	HISI_PCIE_EVENT_ATTR(downstream_wr_bandwidth,	0x00010009),
> +	HISI_PCIE_EVENT_ATTR(downstream_rd_bandwidth,	0x00080009),
> +	HISI_PCIE_EVENT_ATTR(upstream_wr_latency,	0x00010010),
> +	HISI_PCIE_EVENT_ATTR(upstream_rd_latency,	0x00040010),
> +	HISI_PCIE_EVENT_ATTR(downstream_wr_latency,	0x00010011),
> +	NULL,
> +};
> +
> +static const struct attribute_group hisi_pcie_pmu_events_group = {
> +	.name = "events",
> +	.attrs = hisi_pcie_pmu_events_attr,
> +};
> +
> +static struct attribute *hisi_pcie_pmu_format_attr[] = {
> +	HISI_PCIE_FORMAT_ATTR(event, "config:0-15"),
> +	HISI_PCIE_FORMAT_ATTR(subevent, "config:16-31"),
> +	HISI_PCIE_FORMAT_ATTR(port, "config1:0-7"),
> +	HISI_PCIE_FORMAT_ATTR(func, "config1:8-15"),
> +	NULL,
> +};
> +
> +static const struct attribute_group hisi_pcie_pmu_format_group = {
> +	.name = "format",
> +	.attrs = hisi_pcie_pmu_format_attr,
> +};
> +
> +static DEVICE_ATTR_RO(cpumask);
> +
> +static struct attribute *hisi_pcie_pmu_cpumask_attrs[] = {
> +	&dev_attr_cpumask.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group hisi_pcie_pmu_cpumask_attr_group = {
> +	.attrs = hisi_pcie_pmu_cpumask_attrs,
> +};
> +
> +static const struct attribute_group *hisi_pcie_pmu_attr_groups[] = {
> +	&hisi_pcie_pmu_events_group,
> +	&hisi_pcie_pmu_format_group,
> +	&hisi_pcie_pmu_cpumask_attr_group,
> +	NULL,
> +};
> +
> +static void hisi_get_pcie_pmu(struct pci_dev *pdev,
> +			      struct hisi_pcie_pmu *pcie_pmu)
> +{
> +	pcie_pmu->base = pci_ioremap_bar(pdev, HISI_PCIE_PCI_BAR_NUM);
> +	if (!pcie_pmu->base) {
> +		pci_err(pdev, "ioremap failed for pcie_pmu resource\n");
> +		goto err_release_regions;
> +	}
> +	pcie_pmu->pdev = pdev;
> +	pcie_pmu->device_id = PCI_SLOT(pdev->devfn);
> +	pcie_pmu->func_id = PCI_FUNC(pdev->devfn);
> +	pcie_pmu->version = readl(pcie_pmu->base + HISI_PCIE_BAR_VERSION);
> +	pcie_pmu->bus_id = pdev->bus->number;
> +	pcie_pmu->domain_id = pdev->bus->domain_nr;

Most of those are only used once at probe to generate a name - do they 
really need to be stored for the lifetime of the device?

> +	pcie_pmu->num_counters = HISI_PCIE_NR_COUNTERS;
> +	pcie_pmu->check_event = HISI_PCIE_CHECK_EVENT;
> +	pcie_pmu->check_subevent = HISI_PCIE_CHECK_SUBEVENT;
> +	pcie_pmu->check_func = HISI_PCIE_CHECK_FUNC;
> +	pcie_pmu->dev_name = "hisi_pcie_pmu";
> +	pcie_pmu->counter_bits = 48;

Similarly, why bother allocating dynamic storage for constant values - 
are there going to be other variants of the IP where these will differ?

> +	pcie_pmu->on_cpu = -1;
> +
> +err_release_regions:
> +	pci_release_regions(pdev);
> +}
> +
> +static int hisi_pcie_init_pmu(struct pci_dev *pdev,
> +			      struct hisi_pcie_pmu *pcie_pmu)
> +{
> +	char *name;
> +	int ret;
> +
> +	hisi_get_pcie_pmu(pdev, pcie_pmu);
> +
> +	ret = cpuhp_state_add_instance(CPUHP_AP_PERF_ARM_HISI_PCIE_PMU_ONLINE,
> +				       &pcie_pmu->node);
> +	if (ret) {
> +		pci_err(pdev, "Error %d registering hotplug;\n", ret);
> +		return ret;
> +	}
> +
> +	/*
> +	 * domain_id is 0x00 means continuous domain, we use bdf num to
> +	 * select IEP. Otherwise, use domain_id + bdf.
> +	 */
> +	name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
> +			      "hisi_pcie_%x_%x_%x", pcie_pmu->bus_id,
> +			      pcie_pmu->device_id, pcie_pmu->func_id);
> +
> +	pcie_pmu->pmu = (struct pmu) {
> +		.name		= name,
> +		.task_ctx_nr	= perf_invalid_context,
> +		.event_init	= hisi_pcie_pmu_event_init,
> +		.pmu_enable	= hisi_pcie_pmu_enable,
> +		.pmu_disable	= hisi_pcie_pmu_disable,
> +		.add		= hisi_pcie_pmu_add,
> +		.del		= hisi_pcie_pmu_del,
> +		.start		= hisi_pcie_pmu_start,
> +		.stop		= hisi_pcie_pmu_stop,
> +		.read		= hisi_pcie_pmu_read,
> +		.attr_groups	= hisi_pcie_pmu_attr_groups,
> +		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
> +	};
> +
> +	ret = hisi_pcie_pmu_irq_register(pdev, pcie_pmu);
> +	if (ret)
> +		goto err_free_irq_vectors;
> +
> +	ret = perf_pmu_register(&pcie_pmu->pmu, name, -1);
> +	if (ret) {
> +		pci_err(pdev, "PCIE PMU register failed!\n");
> +		cpuhp_state_remove_instance(
> +				CPUHP_AP_PERF_ARM_HISI_PCIE_PMU_ONLINE,
> +				&pcie_pmu->node);
> +	}
> +
> +	return ret;
> +
> +err_free_irq_vectors:
> +	pci_free_irq_vectors(pdev);

And the hotplug state?

> +	return ret;
> +}
> +
> +static void hisi_pcie_uninit_pmu(struct pci_dev *pdev,

pdev is never used here.

> +				 struct hisi_pcie_pmu *pcie_pmu)
> +{
> +	perf_pmu_unregister(&pcie_pmu->pmu);
> +	free_irq(pcie_pmu->irq, pcie_pmu);
> +	cpuhp_state_remove_instance(CPUHP_AP_PERF_ARM_HISI_PCIE_PMU_ONLINE,
> +				    &pcie_pmu->node);
> +	iounmap(pcie_pmu->base);
> +}
> +
> +static int hisi_pcie_init_dev(struct pci_dev *pdev)
> +{
> +	int ret;
> +
> +	ret = pci_enable_device(pdev);
> +	if (ret) {
> +		pci_err(pdev, "Failed to enable pci device!\n");
> +		return ret;
> +	}
> +
> +	ret = pci_request_mem_regions(pdev, "hisi_pcie_pmu");
> +	if (ret) {
> +		pci_err(pdev, "Failed to request pci memory regions!\n");
> +		goto err_disable_pcidev;
> +	}
> +
> +	ret = pci_alloc_irq_vectors(pdev, HISI_PCIE_IRQ_MIN_VECS,
> +				    HISI_PCIE_IRQ_MAX_VECS, PCI_IRQ_MSI);
> +	if (ret)
> +		pci_err(pdev, "Failed to enable MSI vectors!\n");
> +
> +	pci_set_master(pdev);
> +	return ret;
> +
> +err_disable_pcidev:
> +	pci_disable_device(pdev);
> +
> +	return ret;
> +}
> +
> +static void hisi_pcie_uninit_dev(struct pci_dev *pdev)
> +{
> +	pci_free_irq_vectors(pdev);
> +	pci_release_mem_regions(pdev);
> +	pci_disable_device(pdev);
> +}
> +
> +static int hisi_pcie_pmu_probe(struct pci_dev *pdev,
> +			       const struct pci_device_id *id)
> +{
> +	struct hisi_pcie_pmu *pcie_pmu;
> +	int ret;
> +
> +	pcie_pmu = devm_kzalloc(&pdev->dev, sizeof(*pcie_pmu), GFP_KERNEL);
> +	if (!pcie_pmu)
> +		return -ENOMEM;
> +
> +	pci_set_drvdata(pdev, pcie_pmu);
> +	ret = hisi_pcie_init_dev(pdev);
> +	if (ret)
> +		return ret;
> +
> +	ret = hisi_pcie_init_pmu(pdev, pcie_pmu);
> +	if (ret)

Surely you need to undo hisi_pcie_init_dev() here?

Robin.

> +		return ret;
> +
> +	return ret;
> +}
> +
> +static void hisi_pcie_pmu_remove(struct pci_dev *pdev)
> +{
> +	struct hisi_pcie_pmu *pcie_pmu;
> +
> +	pcie_pmu = pci_get_drvdata(pdev);
> +	hisi_pcie_uninit_pmu(pdev, pcie_pmu);
> +	hisi_pcie_uninit_dev(pdev);
> +}
> +
> +static pci_ers_result_t hisi_pcie_pmu_errhandle(struct pci_dev *pdev,
> +						pci_channel_state_t state)
> +{
> +	return PCI_ERS_RESULT_RECOVERED;
> +}
> +
> +static const struct pci_error_handlers hisi_pcie_pmu_err_handler = {
> +	.error_detected = hisi_pcie_pmu_errhandle,
> +};
> +
> +static struct pci_driver hisi_pcie_pmu_driver = {
> +	.name = "hisi_pcie_pmu",
> +	.id_table = hisi_pcie_pmu_ids,
> +	.probe = hisi_pcie_pmu_probe,
> +	.remove = hisi_pcie_pmu_remove,
> +	.err_handler = &hisi_pcie_pmu_err_handler,
> +};
> +
> +static int __init hisi_pcie_module_init(void)
> +{
> +	int ret;
> +
> +	ret = cpuhp_setup_state_multi(CPUHP_AP_PERF_ARM_HISI_PCIE_PMU_ONLINE,
> +				      "AP_PERF_ARM_HISI_PCIE_PMU_ONLINE",
> +				      hisi_pcie_pmu_online_cpu,
> +				      hisi_pcie_pmu_offline_cpu);
> +	if (ret) {
> +		pr_err("PCIE PMU: setup hotplug, ret = %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = pci_register_driver(&hisi_pcie_pmu_driver);
> +	if (ret) {
> +		cpuhp_remove_multi_state(
> +				CPUHP_AP_PERF_ARM_HISI_PCIE_PMU_ONLINE);
> +		pr_err("Failed to register pci driver.\n");
> +	}
> +
> +	return ret;
> +}
> +module_init(hisi_pcie_module_init);
> +
> +static void __exit hisi_pcie_module_exit(void)
> +{
> +	pci_unregister_driver(&hisi_pcie_pmu_driver);
> +	cpuhp_remove_multi_state(CPUHP_AP_PERF_ARM_HISI_PCIE_PMU_ONLINE);
> +}
> +module_exit(hisi_pcie_module_exit);
> +
> +MODULE_DESCRIPTION("HiSilicon PCIe PMU driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Qi Liu <liuqi115@huawei.com>");
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index e51ee77..1330e52 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -166,6 +166,7 @@ enum cpuhp_state {
>   	CPUHP_AP_PERF_ARM_HISI_DDRC_ONLINE,
>   	CPUHP_AP_PERF_ARM_HISI_HHA_ONLINE,
>   	CPUHP_AP_PERF_ARM_HISI_L3_ONLINE,
> +	CPUHP_AP_PERF_ARM_HISI_PCIE_PMU_ONLINE,
>   	CPUHP_AP_PERF_ARM_L2X0_ONLINE,
>   	CPUHP_AP_PERF_ARM_QCOM_L2_ONLINE,
>   	CPUHP_AP_PERF_ARM_QCOM_L3_ONLINE,
> 

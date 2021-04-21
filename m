Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7283666EE
	for <lists+linux-pci@lfdr.de>; Wed, 21 Apr 2021 10:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234573AbhDUIXb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Apr 2021 04:23:31 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:17386 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234500AbhDUIXb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Apr 2021 04:23:31 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FQD5l5T28zlYvF;
        Wed, 21 Apr 2021 16:20:59 +0800 (CST)
Received: from [127.0.0.1] (10.69.38.203) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.498.0; Wed, 21 Apr 2021
 16:22:49 +0800
Subject: Re: [PATCH v3 2/2] drivers/perf: hisi: Add driver for HiSilicon PCIe
 PMU
To:     John Garry <john.garry@huawei.com>, Qi Liu <liuqi115@huawei.com>,
        <will@kernel.org>, <mark.rutland@arm.com>, <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <zhangshaokun@hisilicon.com>
References: <1618490885-44612-1-git-send-email-liuqi115@huawei.com>
 <1618490885-44612-3-git-send-email-liuqi115@huawei.com>
 <778f067e-9ad1-a84f-807d-09fc6f143032@huawei.com>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <9fe957b3-2502-86ea-e427-9946771344bc@huawei.com>
Date:   Wed, 21 Apr 2021 16:22:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <778f067e-9ad1-a84f-807d-09fc6f143032@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.38.203]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi John,

On 2021/4/20 17:45, John Garry wrote:
> On 15/04/2021 13:48, Qi Liu wrote:
>> PCIe PMU Root Complex Integrated End Point(RCiEP) device is supported
>> to sample bandwidth, latency, buffer occupation etc.
>>
>> Each PMU RCiEP device monitors multiple Root Ports, and each RCiEP is
>> registered as a PMU in /sys/bus/event_source/devices, so users can
>> select target PMU, and use filter to do further sets.
>>
>> Filtering options contains:
>> event        - select the event.
>> subevent     - select the subevent.
>> port         - select target Root Ports. Information of Root Ports
>>                 are shown under sysfs.
>> bdf          - select requester_id of target EP device.
>> trig_len     - set trigger condition for starting event statistics.
>> trigger_mode - set trigger mode. 0 means starting to statistic when
>>                 bigger than trigger condition, and 1 means smaller.
>> thr_len      - set threshold for statistics.
>> thr_mode     - set threshold mode. 0 means count when bigger than
>>                 threshold, and 1 means smaller.
>>
>> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> 
> Some minor items and nits with coding style below, but generally looks ok:
> 
> Reviewed-by: John Garry <john.garry@huawei.com>
> 
>> ---
>>   MAINTAINERS                                |    6 +
>>   drivers/perf/Kconfig                       |    2 +
>>   drivers/perf/Makefile                      |    1 +
>>   drivers/perf/pci/Kconfig                   |   16 +
>>   drivers/perf/pci/Makefile                  |    2 +
>>   drivers/perf/pci/hisilicon/Makefile        |    3 +
>>   drivers/perf/pci/hisilicon/hisi_pcie_pmu.c | 1014 
>> ++++++++++++++++++++++++++++
>>   include/linux/cpuhotplug.h                 |    1 +
>>   8 files changed, 1045 insertions(+)
>>   create mode 100644 drivers/perf/pci/Kconfig
>>   create mode 100644 drivers/perf/pci/Makefile
>>   create mode 100644 drivers/perf/pci/hisilicon/Makefile
>>   create mode 100644 drivers/perf/pci/hisilicon/hisi_pcie_pmu.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 7fdc513..efe06cd 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -8084,6 +8084,12 @@ W:    http://www.hisilicon.com
>>   F:    Documentation/admin-guide/perf/hisi-pmu.rst
>>   F:    drivers/perf/hisilicon
>> +HISILICON PCIE PMU DRIVER
>> +M:    Qi Liu <liuqi115@huawei.com>
>> +S:    Maintained
>> +F:    Documentation/admin-guide/perf/hisi-pcie-pmu.rst
>> +F:    drivers/perf/pci/hisilicon/hisi_pcie_pmu.c
>> +
>>   HISILICON QM AND ZIP Controller DRIVER
>>   M:    Zhou Wang <wangzhou1@hisilicon.com>
>>   L:    linux-crypto@vger.kernel.org
>> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
>> index 77522e5..ddd82fa 100644
>> --- a/drivers/perf/Kconfig
>> +++ b/drivers/perf/Kconfig
>> @@ -139,4 +139,6 @@ config ARM_DMC620_PMU
>>   source "drivers/perf/hisilicon/Kconfig"
>> +source "drivers/perf/pci/Kconfig"
>> +
>>   endmenu
>> diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
>> index 5260b11..1208c08 100644
>> --- a/drivers/perf/Makefile
>> +++ b/drivers/perf/Makefile
>> @@ -14,3 +14,4 @@ obj-$(CONFIG_THUNDERX2_PMU) += thunderx2_pmu.o
>>   obj-$(CONFIG_XGENE_PMU) += xgene_pmu.o
>>   obj-$(CONFIG_ARM_SPE_PMU) += arm_spe_pmu.o
>>   obj-$(CONFIG_ARM_DMC620_PMU) += arm_dmc620_pmu.o
>> +obj-y += pci/
>> diff --git a/drivers/perf/pci/Kconfig b/drivers/perf/pci/Kconfig
>> new file mode 100644
>> index 0000000..9f30291
>> --- /dev/null
>> +++ b/drivers/perf/pci/Kconfig
>> @@ -0,0 +1,16 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +#
>> +# PCIe Performance Monitor Drivers
>> +#
>> +menu "PCIe Performance Monitor"
>> +
>> +config HISI_PCIE_PMU
>> +    tristate "HiSilicon PCIE PERF PMU"
>> +    depends on (ARM64 && PCI) || COMPILE_TEST
>> +    help
>> +      Provide support for HiSilicon PCIe performance monitoring unit 
>> (PMU)
>> +      RCiEP devices.
>> +      Adds the PCIe PMU into perf events system for monitoring latency,
>> +      bandwidth etc.
>> +
>> +endmenu
>> diff --git a/drivers/perf/pci/Makefile b/drivers/perf/pci/Makefile
>> new file mode 100644
>> index 0000000..a56b1a9
>> --- /dev/null
>> +++ b/drivers/perf/pci/Makefile
>> @@ -0,0 +1,2 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +obj-y += hisilicon/
>> diff --git a/drivers/perf/pci/hisilicon/Makefile 
>> b/drivers/perf/pci/hisilicon/Makefile
>> new file mode 100644
>> index 0000000..65b0bd7
>> --- /dev/null
>> +++ b/drivers/perf/pci/hisilicon/Makefile
>> @@ -0,0 +1,3 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +
>> +obj-$(CONFIG_HISI_PCIE_PMU) += hisi_pcie_pmu.o
>> diff --git a/drivers/perf/pci/hisilicon/hisi_pcie_pmu.c 
>> b/drivers/perf/pci/hisilicon/hisi_pcie_pmu.c
>> new file mode 100644
>> index 0000000..415bf39
>> --- /dev/null
>> +++ b/drivers/perf/pci/hisilicon/hisi_pcie_pmu.c
>> @@ -0,0 +1,1014 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * This driver adds support for PCIe PMU RCiEP device. Related
>> + * perf events are bandwidth, bandwidth utilization, latency
>> + * etc.
>> + *
>> + * Copyright (C) 2021 HiSilicon Limited
>> + * Author: Qi Liu<liuqi115@huawei.com>
>> + */
>> +#include <linux/bitfield.h>
>> +#include <linux/bitmap.h>
>> +#include <linux/bug.h>
>> +#include <linux/cpuhotplug.h>
>> +#include <linux/cpumask.h>
>> +#include <linux/device.h>
>> +#include <linux/err.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/irq.h>
>> +#include <linux/kernel.h>
>> +#include <linux/list.h>
>> +#include <linux/module.h>
>> +#include <linux/pci.h>
>> +#include <linux/perf_event.h>
>> +
>> +/* Define registers */
>> +#define HISI_PCIE_GLOBAL_CTRL        0x00
>> +#define HISI_PCIE_EVENT_CTRL        0x010
>> +#define HISI_PCIE_CNT            0x090
>> +#define HISI_PCIE_EXT_CNT        0x110
>> +#define HISI_PCIE_INT_STAT        0x150
>> +#define HISI_PCIE_INT_MASK        0x154
>> +#define HISI_PCIE_REG_BDF        0xfe0
>> +#define HISI_PCIE_REG_VERSION        0xfe4
>> +#define HISI_PCIE_REG_INFO        0xfe8
>> +#define HISI_PCIE_REG_FREQ        0xfec
>> +
>> +/* Define PCIE CTRL CMD */
>> +#define HISI_PCIE_GLOBAL_EN        0x01
>> +#define HISI_PCIE_GLOBAL_NONE        0
>> +#define HISI_PCIE_EVENT_EN        BIT(20)
>> +#define HISI_PCIE_RESET_CNT        BIT(22)
>> +#define HISI_PCIE_DEFAULT_SET        BIT(34)
>> +#define HISI_PCIE_THR_EN        BIT(26)
>> +#define HISI_PCIE_TARGET_EN        BIT(32)
>> +#define HISI_PCIE_TRIG_EN        BIT(52)
>> +
>> +/* Define offsets in event ctrl regesiter */
>> +#define HISI_PCIE_EVENT_M        GENMASK_ULL(7, 0)
>> +#define HISI_PCIE_SUBEVENT_M        GENMASK_ULL(15, 8)
>> +#define HISI_PCIE_THR_MODE_M        GENMASK_ULL(27, 27)
>> +#define HISI_PCIE_THR_M            GENMASK_ULL(31, 28)
>> +#define HISI_PCIE_TARGET_M        GENMASK_ULL(52, 36)
>> +#define HISI_PCIE_TRIG_MODE_M        GENMASK_ULL(53, 53)
>> +#define HISI_PCIE_TRIG_M        GENMASK_ULL(59, 56)
>> +
>> +#define HISI_PCIE_MAX_COUNTERS        8
>> +#define HISI_PCIE_REG_STEP        8
>> +#define HISI_PCIE_EVENT_MAX        0xa2
>> +#define HISI_PCIE_SUBEVENT_MAX        0x20
>> +#define HISI_PCIE_THR_MAX_VAL        10
>> +#define HISI_PCIE_TRIG_MAX_VAL        10
>> +#define HISI_PCIE_COUNTER_BITS        64
>> +#define HISI_PCIE_MAX_PERIOD        BIT_ULL(63)
>> +
>> +struct hisi_pcie_pmu {
>> +    struct perf_event *hw_events[HISI_PCIE_MAX_COUNTERS];
>> +    struct hlist_node node;
>> +    struct pci_dev *pdev;
>> +    struct pmu pmu;
>> +    void __iomem *base;
>> +    int irq;
>> +    u32 identifier;
>> +    /* Minimum and maximum bdf of root ports monitored by PMU */
>> +    u16 bdf_min;
>> +    u16 bdf_max;
>> +    int on_cpu;
>> +};
>> +
>> +#define to_pcie_pmu(p)  (container_of((p), struct hisi_pcie_pmu, pmu))
>> +#define GET_PCI_DEVFN(bdf)  ((bdf) & 0xff)
>> +
>> +#define HISI_PCIE_PMU_FILTER_ATTR(_name, _config, _hi, _lo)          \
>> +    static u64 hisi_pcie_get_##_name(struct perf_event *event)      \
>> +    {                                  \
>> +        return FIELD_GET(GENMASK(_hi, _lo), event->attr._config); \
>> +    }                                  \
>> +
>> +HISI_PCIE_PMU_FILTER_ATTR(event, config, 7, 0);
>> +HISI_PCIE_PMU_FILTER_ATTR(subevent, config, 15, 8);
>> +HISI_PCIE_PMU_FILTER_ATTR(thr_len, config1, 3, 0);
>> +HISI_PCIE_PMU_FILTER_ATTR(thr_mode, config1, 4, 4);
>> +HISI_PCIE_PMU_FILTER_ATTR(trig_len, config1, 8, 5);
>> +HISI_PCIE_PMU_FILTER_ATTR(trig_mode, config1, 9, 9);
>> +HISI_PCIE_PMU_FILTER_ATTR(port, config2, 15, 0);
>> +HISI_PCIE_PMU_FILTER_ATTR(bdf, config2, 31, 16);
>> +
>> +#define HISI_PCIE_BUILD_EVENTS(name)                         \
>> +    static bool is_##name##_event(u32 idx)                \
>> +    {                                \
>> +        return (idx >= name##_events_list[0] &&            \
>> +            idx <= name##_events_list[1]) ||        \
>> +            idx == name##_events_list[2];             \
>> +    }                                \
>> +
>> +/*
>> + * The first element of event list is minimum index of TL-layer events
>> + * and the second element is maximum index. The third element is index
>> + * of a DL-layer event.
>> + */
>> +static const u32 bw_events_list[] = {0x04, 0x08, 0x84};
>> +static const u32 latency_events_list[] = {0x10, 0x15, 0x85};
>> +static const u32 bus_util_events_list[] = {0x20, 0x24, 0x09};
>> +static const u32 buf_util_events_list[] = {0x28, 0x2a, 0x33};
>> +
>> +HISI_PCIE_BUILD_EVENTS(bw);
>> +HISI_PCIE_BUILD_EVENTS(latency);
>> +HISI_PCIE_BUILD_EVENTS(bus_util);
>> +HISI_PCIE_BUILD_EVENTS(buf_util);
>> +
>> +static ssize_t hisi_pcie_format_sysfs_show(struct device *dev,
>> +                    struct device_attribute *attr, char *buf)
>> +{
>> +    struct dev_ext_attribute *eattr;
>> +
>> +    eattr = container_of(attr, struct dev_ext_attribute, attr);
>> +
>> +    return sysfs_emit(buf, "%s\n", (char *)eattr->var);
>> +}
>> +
>> +static ssize_t hisi_pcie_event_sysfs_show(struct device *dev,
>> +                   struct device_attribute *attr, char *buf)
>> +{
>> +    struct dev_ext_attribute *eattr;
>> +
>> +    eattr = container_of(attr, struct dev_ext_attribute, attr);
>> +
>> +    return sysfs_emit(buf, "config=0x%lx\n", (unsigned long)eattr->var);
>> +}
> 
> As before, I hope that we can have common versions of these function for 
> all drivers in future
> 
got it, will do this latter.
>> +
>> +static int hisi_pcie_pmu_event_init(struct perf_event *event)
>> +{
>> +    struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(event->pmu);
>> +
>> +    event->cpu = pcie_pmu->on_cpu;
>> +
>> +    if (event->attr.type != event->pmu->type)
>> +        return -ENOENT;
>> +
>> +    /* Sampling is not supported. */
>> +    if (is_sampling_event(event) || event->attach_state & 
>> PERF_ATTACH_TASK)
>> +        return -EOPNOTSUPP;
>> +
>> +    if (!hisi_pcie_pmu_valid_filter(event, pcie_pmu)) {
>> +        pci_err(pcie_pmu->pdev, "Invalid filter!\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (!hisi_pcie_pmu_validate_event_group(event))
>> +        return -EINVAL;
>> +
>> +    return 0;
>> +}
>> +
> 
> again, if this is generic, then can factor out later
got it.
> 
>> +/*
>> + * The bandwidth, latency, bus utilization and buffer occupancy 
>> features are
>> + * calculated from data in HISI_PCIE_CNT and extern data in 
>> HISI_PCIE_EXT_CNT.
> 
> extern data? or extended data?
It should be "extended data" here, I'll fix this in next version. Thanks.
> 
>> + * Other features are obtained only by HISI_PCIE_CNT.
>> + * So data and data_ext are processed in this function to get 
>> performanace
>> + * value like, bandwidth, latency, etc.
>> + */
>> +static u64 hisi_pcie_pmu_get_performance(struct perf_event *event, 
>> u64 data,
>> +                     u64 data_ext)
>> +{
>> +#define CONVERT_DW_TO_BYTE(x)    (sizeof(u32) * (x))
>> +    struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(event->pmu);
>> +    u64 us_per_cycle = readl(pcie_pmu->base + HISI_PCIE_REG_FREQ);
>> +    u32 idx = hisi_pcie_get_event(event);
>> +
>> +    if (!data_ext)
>> +        return 0;
>> +
>> +    /* Process data to set unit of bandwidth as "Byte/ms". */
>> +    if (is_bw_event(idx)) {
> 
> ideally we could use a switch statement here, but with how macro 
> is_bw_event is defined, doesn't seem possible
> 
>> +        if (!data_ext / 1000)
>> +            return 0;
>> +
>> +        return (CONVERT_DW_TO_BYTE(data)) / (data_ext / 1000);
>> +    }
>> +
>> +    /* Process data to set unit of latency as "us". */
>> +    if (is_latency_event(idx))
>> +        return (data * us_per_cycle) / data_ext;
>> +
>> +    if (is_bus_util_event(idx))
>> +        return (data * us_per_cycle) / data_ext;
>> +
>> +    if (is_buf_util_event(idx))
>> +        return data / (data_ext * us_per_cycle);
>> +
>> +    return data;
>> +}
>> +
>> +static void hisi_pcie_pmu_read_counter(struct perf_event *event, u64 
>> *cnt,
>> +                       u64 *cnt_ext)
>> +{
>> +    struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(event->pmu);
>> +    u32 idx = event->hw.idx;
>> +
>> +    *cnt = hisi_pcie_pmu_readq(pcie_pmu, HISI_PCIE_CNT, idx);
>> +    *cnt_ext = hisi_pcie_pmu_readq(pcie_pmu, HISI_PCIE_EXT_CNT, idx);
>> +}
>> +
>> +static void hisi_pcie_pmu_write_counter(struct perf_event *event, u64 
>> val,
>> +                    u64 val_ext)
>> +{
>> +    struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(event->pmu);
>> +    u32 idx = event->hw.idx;
>> +
>> +    hisi_pcie_pmu_writeq(pcie_pmu, HISI_PCIE_CNT, idx, val);
>> +    hisi_pcie_pmu_writeq(pcie_pmu, HISI_PCIE_EXT_CNT, idx, val_ext);
>> +}
>> +
>> +static int hisi_pcie_pmu_get_event_idx(struct hisi_pcie_pmu *pcie_pmu)
>> +{
>> +    int idx;
>> +
>> +    for (idx = 0; idx < HISI_PCIE_MAX_COUNTERS; idx++) {
>> +        if (!pcie_pmu->hw_events[idx])
>> +            return idx;
>> +    }
>> +
>> +    return -EINVAL;
>> +}
>> +
>> +static void hisi_pcie_pmu_event_update(struct perf_event *event)
>> +{
>> +    struct hw_perf_event *hwc = &event->hw;
>> +    struct hw_perf_event_extra *hwc_ext = &hwc->extra_reg;
>> +    u64 new_cnt_ext, prev_cnt_ext;
>> +    u64 new_cnt, prev_cnt, delta;
>> +
>> +    hwc_ext = &hwc->extra_reg;
>> +    do {
>> +        prev_cnt = local64_read(&hwc->prev_count);
>> +        prev_cnt_ext = hwc_ext->config;
>> +        hisi_pcie_pmu_read_counter(event, &new_cnt, &new_cnt_ext);
>> +    } while (local64_cmpxchg(&hwc->prev_count, prev_cnt,
>> +                 new_cnt) != prev_cnt);
>> +
>> +    hwc_ext->config = new_cnt_ext;
>> +
>> +    delta = hisi_pcie_pmu_get_performance(event, new_cnt - prev_cnt,
>> +                          new_cnt_ext - prev_cnt_ext);
>> +    local64_add(delta, &event->count);
>> +}
> 
> ...
> 
>> +
>> +static int hisi_pcie_pmu_offline_cpu(unsigned int cpu, struct 
>> hlist_node *node)
>> +{
>> +    struct hisi_pcie_pmu *pcie_pmu = hlist_entry_safe(node,
>> +                     struct hisi_pcie_pmu, node);
>> +    unsigned int target;
>> +
>> +    /* Nothing to do if this CPU doesn't own the PMU */
>> +    if (pcie_pmu->on_cpu != cpu)
>> +        return 0;
>> +
>> +    /* Choose a new CPU from all online cpus. */
>> +    target = cpumask_any_but(cpu_online_mask, cpu);
> 
> I don't think cpu would ever be involved in cpu_online_mask at this 
> point. Not sure.
> 
You are righ, may be cpumask_first(cpu_online_mask) is enough
>> +    if (target >= nr_cpu_ids)
>> +        return 0;
> 
> might be worth an error message if this fails ...
ok, will add one in next version.
> 
>> +
>> +    perf_pmu_migrate_context(&pcie_pmu->pmu, cpu, target);
>> +    /* Use this CPU for event counting */
>> +    pcie_pmu->on_cpu = target;
>> +    WARN_ON(irq_set_affinity_hint(pcie_pmu->irq, cpumask_of(target)));
>> +
>> +    return 0;
>> +}
>> +
>> +/*
>> + * Events with the "dl" suffix in their names count performance in DL 
>> layer,
>> + * otherswise, events count performance in TL layer.
>> + */
>> +static struct attribute *hisi_pcie_pmu_events_attr[] = {
>> +    HISI_PCIE_PMU_EVENT_ATTR(bw_rx_mwr, 0x0104),
>> +    HISI_PCIE_PMU_EVENT_ATTR(bw_rx_mrd, 0x1005),
>> +    HISI_PCIE_PMU_EVENT_ATTR(bw_tx_mwr, 0x0105),
>> +    HISI_PCIE_PMU_EVENT_ATTR(bw_tx_mrd, 0x2004),
>> +    HISI_PCIE_PMU_EVENT_ATTR(lat_rx_mwr, 0x0010),
>> +    HISI_PCIE_PMU_EVENT_ATTR(lat_rx_mrd, 0x0210),
>> +    HISI_PCIE_PMU_EVENT_ATTR(lat_tx_mrd, 0x0011),
>> +    HISI_PCIE_PMU_EVENT_ATTR(lat_tx_cfg, 0x0111),
>> +    HISI_PCIE_PMU_EVENT_ATTR(bw_rx_dl, 0x0184),
>> +    HISI_PCIE_PMU_EVENT_ATTR(bw_tx_dl, 0x0384),
>> +    NULL
>> +};
>> +
>> +static struct attribute_group hisi_pcie_pmu_events_group = {
>> +    .name = "events",
>> +    .attrs = hisi_pcie_pmu_events_attr,
>> +};
>> +
>> +static struct attribute *hisi_pcie_pmu_format_attr[] = {
>> +    HISI_PCIE_PMU_FORMAT_ATTR(event, "config:0-7"),
>> +    HISI_PCIE_PMU_FORMAT_ATTR(subevent, "config:8-15"),
>> +    HISI_PCIE_PMU_FORMAT_ATTR(thr_len, "config1:0-3"),
>> +    HISI_PCIE_PMU_FORMAT_ATTR(thr_mode, "config1:4"),
>> +    HISI_PCIE_PMU_FORMAT_ATTR(trig_len, "config1:5-8"),
>> +    HISI_PCIE_PMU_FORMAT_ATTR(trig_mode, "config1:9"),
>> +    HISI_PCIE_PMU_FORMAT_ATTR(port, "config2:0-15"),
>> +    HISI_PCIE_PMU_FORMAT_ATTR(bdf, "config2:16-31"),
>> +    NULL
>> +};
>> +
>> +static struct attribute_group hisi_pcie_pmu_format_group = {
>> +    .name = "format",
>> +    .attrs = hisi_pcie_pmu_format_attr,
>> +};
>> +
>> +static struct device_attribute hisi_pcie_pmu_bus_attr =
>> +    __ATTR(bus, 0444, hisi_pcie_bus_show, NULL);
>> +
>> +static struct attribute *hisi_pcie_pmu_bus_attrs[] = {
>> +    &hisi_pcie_pmu_bus_attr.attr,
>> +    NULL
>> +};
>> +
>> +static struct attribute_group hisi_pcie_pmu_bus_attr_group = {
>> +    .attrs = hisi_pcie_pmu_bus_attrs,
>> +};
>> +
>> +static struct device_attribute hisi_pcie_pmu_cpumask_attr =
>> +    __ATTR(cpumask, 0444, hisi_pcie_cpumask_show, NULL);
>> +
>> +static struct attribute *hisi_pcie_pmu_cpumask_attrs[] = {
>> +    &hisi_pcie_pmu_cpumask_attr.attr,
>> +    NULL
>> +};
>> +
>> +static struct attribute_group hisi_pcie_pmu_cpumask_attr_group = {
>> +    .attrs = hisi_pcie_pmu_cpumask_attrs,
>> +};
>> +
>> +static struct device_attribute hisi_pcie_pmu_identifier_attr =
>> +    __ATTR(identifier, 0444, hisi_pcie_identifier_show, NULL);
>> +
>> +static struct attribute *hisi_pcie_pmu_identifier_attrs[] = {
>> +    &hisi_pcie_pmu_identifier_attr.attr,
>> +    NULL
>> +};
>> +
>> +static struct attribute_group hisi_pcie_pmu_identifier_attr_group = {
>> +    .attrs = hisi_pcie_pmu_identifier_attrs,
>> +};
>> +
>> +static const struct attribute_group *hisi_pcie_pmu_attr_groups[] = {
>> +    &hisi_pcie_pmu_events_group,
>> +    &hisi_pcie_pmu_format_group,
>> +    &hisi_pcie_pmu_bus_attr_group,
>> +    &hisi_pcie_pmu_cpumask_attr_group,
>> +    &hisi_pcie_pmu_identifier_attr_group,
>> +    NULL
>> +};
>> +
>> +static int hisi_pcie_alloc_pmu(struct pci_dev *pdev,
>> +                 struct hisi_pcie_pmu *pcie_pmu)
>> +{
>> +    u16 sicl_id, device_id;
>> +    char *name;
>> +
>> +    pcie_pmu->base = pci_ioremap_bar(pdev, 2);
>> +    if (!pcie_pmu->base) {
>> +        pci_err(pdev, "Ioremap failed for pcie_pmu resource.\n");
>> +        return -ENOMEM;
>> +    }
> 
> nit: this does not seem related to "alloc" functionality
> 
ok, I'll move this pcie_pmu->base to hisi_pcie_init_pmu() function.

Thanks,
Qi
>> +
>> +    hisi_pcie_parse_reg_value(pcie_pmu, HISI_PCIE_REG_BDF,
>> +                  &pcie_pmu->bdf_min, &pcie_pmu->bdf_max);
>> +    hisi_pcie_parse_reg_value(pcie_pmu, HISI_PCIE_REG_INFO, &device_id,
>> +                  &sicl_id);
>> +    name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
>> +                  "hisi_pcie%u_%u", sicl_id, device_id);
>> +    if (!name)
>> +        return -ENOMEM;
>> +
>> +    pcie_pmu->pdev = pdev;
>> +    pcie_pmu->on_cpu = -1;
>> +    pcie_pmu->identifier = readl(pcie_pmu->base + 
>> HISI_PCIE_REG_VERSION);
>> +    pcie_pmu->pmu = (struct pmu) {
>> +        .name        = name,
>> +        .module        = THIS_MODULE,
>> +        .event_init    = hisi_pcie_pmu_event_init,
>> +        .pmu_enable    = hisi_pcie_pmu_enable,
>> +        .pmu_disable    = hisi_pcie_pmu_disable,
>> +        .add        = hisi_pcie_pmu_add,
>> +        .del        = hisi_pcie_pmu_del,
>> +        .start        = hisi_pcie_pmu_start,
>> +        .stop        = hisi_pcie_pmu_stop,
>> +        .read        = hisi_pcie_pmu_read,
>> +        .task_ctx_nr    = perf_invalid_context,
>> +        .attr_groups    = hisi_pcie_pmu_attr_groups,
>> +        .capabilities    = PERF_PMU_CAP_NO_EXCLUDE,
>> +    };
>> +
>> +    return 0;
>> +}
>> +
> 
> .


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591BE35CF5C
	for <lists+linux-pci@lfdr.de>; Mon, 12 Apr 2021 19:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243615AbhDLRYT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Apr 2021 13:24:19 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2838 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241403AbhDLRYS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Apr 2021 13:24:18 -0400
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FJwM80zs5z67nYQ;
        Tue, 13 Apr 2021 01:14:12 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 12 Apr 2021 19:23:58 +0200
Received: from [10.47.11.100] (10.47.11.100) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 12 Apr
 2021 18:23:57 +0100
Subject: Re: [PATCH v2 1/2] drivers/perf: hisi: Add driver for HiSilicon PCIe
 PMU
To:     "liuqi (BA)" <liuqi115@huawei.com>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zhangshaokun <zhangshaokun@hisilicon.com>
References: <1617959157-22956-1-git-send-email-liuqi115@huawei.com>
 <1617959157-22956-2-git-send-email-liuqi115@huawei.com>
 <4cae4206-aa50-f111-2f6f-d035bc36856e@huawei.com>
 <9c577f11-46e7-55a0-95e8-6c3376077049@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <fb795e51-ce01-e976-ac09-d3f384307623@huawei.com>
Date:   Mon, 12 Apr 2021 18:21:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <9c577f11-46e7-55a0-95e8-6c3376077049@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.11.100]
X-ClientProxiedBy: lhreml739-chm.china.huawei.com (10.201.108.189) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/04/2021 14:34, liuqi (BA) wrote:
> 
> Hi John,
> 
> Thanks for reviewing this.
> On 2021/4/9 18:22, John Garry wrote:
>> On 09/04/2021 10:05, Qi Liu wrote:
>>> PCIe PMU Root Complex Integrated End Point(RCiEP) device is supported
>>> to sample bandwidth, latency, buffer occupation etc.
>>>
>>> Each PMU RCiEP device monitors multiple Root Ports, and each RCiEP is
>>> registered as a PMU in /sys/bus/event_source/devices, so users can
>>> select target PMU, and use filter to do further sets.

side note: it would be good to mention what baseline the series is based 
on in the cover letter

>>>
>>> Filtering options contains:
>>> event        - select the event.
>>> subevent     - select the subevent.
>>> port         - select target Root Ports. Information of Root Ports
>>>                  are shown under sysfs.
>>> bdf          - select requester_id of target EP device.
>>> trig_len     - set trigger condition for starting event statistics.
>>> trigger_mode - set trigger mode. 0 means starting to statistic when
>>>                  bigger than trigger condition, and 1 means smaller.
>>> thr_len      - set threshold for statistics.
>>> thr_mode     - set threshold mode. 0 means count when bigger than
>>>                  threshold, and 1 means smaller.
>>>
>>> Signed-off-by: Qi Liu <liuqi115@huawei.com>
>>> ---
>>>    MAINTAINERS                                |    6 +
>>>    drivers/perf/Kconfig                       |    2 +
>>>    drivers/perf/Makefile                      |    1 +
>>>    drivers/perf/pci/Kconfig                   |   16 +
>>>    drivers/perf/pci/Makefile                  |    2 +
>>>    drivers/perf/pci/hisilicon/Makefile        |    5 +
>>>    drivers/perf/pci/hisilicon/hisi_pcie_pmu.c | 1011
>>> ++++++++++++++++++++++++++++
>>>    include/linux/cpuhotplug.h                 |    1 +
>>>    8 files changed, 1044 insertions(+)
>>>    create mode 100644 drivers/perf/pci/Kconfig
>>>    create mode 100644 drivers/perf/pci/Makefile
>>>    create mode 100644 drivers/perf/pci/hisilicon/Makefile
>>>    create mode 100644 drivers/perf/pci/hisilicon/hisi_pcie_pmu.c
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 3353de0..46c7861 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -8023,6 +8023,12 @@ W:    http://www.hisilicon.com
>>>    F:    Documentation/admin-guide/perf/hisi-pmu.rst
>>>    F:    drivers/perf/hisilicon
>>> +HISILICON PCIE PMU DRIVER
>>> +M:    Qi Liu <liuqi115@huawei.com>
>>> +S:    Maintained
>>> +F:    Documentation/admin-guide/perf/hisi-pcie-pmu.rst
>>
>> nit: this does not exist yet...
>>
> thanks, I'll move this add-maintainer-part to the second patch.

that's why I advocate the documentation first :)

>>> +F:    drivers/perf/pci/hisilicon/hisi_pcie_pmu.c
>>> +
>>>    HISILICON QM AND ZIP Controller DRIVER
>>>    M:    Zhou Wang <wangzhou1@hisilicon.com>
>>>    L:    linux-crypto@vger.kernel.org
>>> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
>>> index 3075cf1..99d4760 100644
>>> --- a/drivers/perf/Kconfig
>>> +++ b/drivers/perf/Kconfig
>>> @@ -139,4 +139,6 @@ config ARM_DMC620_PMU
>>>    source "drivers/perf/hisilicon/Kconfig"
>>> +source "drivers/perf/pci/Kconfig"
>>> +
>>>    endmenu
>>> diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
>>> index 5260b11..1208c08 100644
>>> --- a/drivers/perf/Makefile
>>> +++ b/drivers/perf/Makefile
>>> @@ -14,3 +14,4 @@ obj-$(CONFIG_THUNDERX2_PMU) += thunderx2_pmu.o
>>>    obj-$(CONFIG_XGENE_PMU) += xgene_pmu.o
>>>    obj-$(CONFIG_ARM_SPE_PMU) += arm_spe_pmu.o
>>>    obj-$(CONFIG_ARM_DMC620_PMU) += arm_dmc620_pmu.o
>>> +obj-y += pci/
>>> diff --git a/drivers/perf/pci/Kconfig b/drivers/perf/pci/Kconfig
>>> new file mode 100644
>>> index 0000000..a119486
>>> --- /dev/null
>>> +++ b/drivers/perf/pci/Kconfig
>>> @@ -0,0 +1,16 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only
>>> +#
>>> +# PCIe Performance Monitor Drivers
>>> +#
>>> +menu "PCIe Performance Monitor"
>>> +
>>> +config HISI_PCIE_PMU
>>> +    tristate "HiSilicon PCIE PERF PMU"
>>> +    depends on ARM64 && PCI && HISI_PMU
>>
>> What from HISI_PMU is needed? I couldn't find anything here
> The event_sysfs_show() and format_sysfs_show() function of
> hisi_uncore_pmu.h can be reused in hisi_pcie_pmu.c, So I add path in
> Makefile and include "hisi_uncore_pmu.h".

Right, but it would be nice to be able to build this under COMPILE_TEST. 
CONFIG_HISI_PMU cannot be built under COMPILE_TEST, so nice to not 
depend on it.

So you could put hisi_event_sysfs_show() as a static inline in 
hisi_uncore_pmu.h, so the dependency can be removed

Having said that, there is nothing really hisi specific in those 
functions like hisi_event_sysfs_show().

Can't we just create generic functions here?

hisi_event_sysfs_show() == cci400_pmu_cycle_event_show() == 
xgene_pmu_event_show()

> 
>>
>>> +    help
>>> +      Provide support for HiSilicon PCIe performance monitoring unit
>>> (PMU)
>>> +      RCiEP devices.
>>> +      Adds the PCIe PMU into perf events system for monitoring latency,
>>> +      bandwidth etc.
>>> +





>>> +#define HISI_PCIE_CHECK_EVENTS(name, list)             \
>>
>> "check" in a function name is too vague, as it does not imply any
>> side-effect from calling this function.
>>
>> And I think "build" or similar would be good to be included in the macro
>> name.
>>
>>> +    static inline bool is_##name##_event(u32 idx)                  \
>>
>> why inline?
>>
>>> +
>>> {                                                                   \
>>> +        if ((idx >= list[0] && idx <= list[1]) || idx == list[2])  \
>>> +            return true;                                        \
>>> +        return false;                                               \
>>
>> isn't this just:
>> {
>>       return (idx >= list[0] && idx <= list[1]) || idx == list[2])
>> }
> 
> thanks, will address in next version.
>>
>>> +    }
>>> +
>>> +/*
>>> + * The first element of event list is minimum index of TL-layer events
>>> + * and the second element is maximum index. The third element is index
>>> + * of a DL-layer event.
>>> + */
>>> +static const u32 bw_events_list[] = {0x04, 0x08, 0x84};
>>> +static const u32 latency_events_list[] = {0x10, 0x15, 0x85};
>>> +static const u32 bus_util_events_list[] = {0x20, 0x24, 0x09};
>>> +static const u32 buf_util_events_list[] = {0x28, 0x2a, 0x33};
>>> +
>>> +HISI_PCIE_CHECK_EVENTS(bw, bw_events_list);
>>> +HISI_PCIE_CHECK_EVENTS(latency, latency_events_list);
>>> +HISI_PCIE_CHECK_EVENTS(bus_util, bus_util_events_list);
>>> +HISI_PCIE_CHECK_EVENTS(buf_util, buf_util_events_list);
>>
>> Surely the macro can be fixed such that you need to have:
>> HISI_PCIE_CHECK_EVENTS(buf_util);
>>
> will address in next version.
>>
>>> +
>>> +static ssize_t hisi_pcie_cpumask_show(struct device *dev,
>>> +                      struct device_attribute *attr, char *buf)
>>> +{
>>> +    struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(dev_get_drvdata(dev));
>>> +
>>> +    return cpumap_print_to_pagebuf(true, buf, &pcie_pmu->cpumask);
>>> +}
>>> +
>>> +static ssize_t hisi_pcie_identifier_show(struct device *dev,
>>> +                     struct device_attribute *attr,
>>> +                     char *buf)
>>> +{
>>> +    struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(dev_get_drvdata(dev));
>>> +
>>> +    return sysfs_emit(buf, "0x%x\n", pcie_pmu->identifier);
>>> +}
>>> +
>>> +static ssize_t hisi_pcie_bus_show(struct device *dev,
>>> +                  struct device_attribute *attr, char *buf)
>>> +{
>>> +    struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(dev_get_drvdata(dev));
>>> +
>>> +    return sysfs_emit(buf, "0x%02x\n", PCI_BUS_NUM(pcie_pmu->bdf_min));
>>> +}
>>> +
>>> +static void hisi_pcie_parse_data(struct hisi_pcie_pmu *pcie_pmu, u32
>>> reg_off,
>>
>> hisi_pcie_parse_data() name is way too vague. I mean, parse what data?
>>
>> is there is some standard format register we use for various data types,
>> then make that clear please
> Seems that we only have lower_32_bits() but do not have lower_16_bits().
> perhaps we could change the function name to hisi_pcie_parse_reg_value()?

ok, so even that name is better.

> 
>>
>>> +                   u16 *arg0, u16 *arg1)
>>> +{
>>> +    u32 val = readl(pcie_pmu->base + reg_off);
>>> +
>>> +    *arg0 = val & 0xffff;
>>> +    *arg1 = (val & 0xffff0000) >> 16;
>>> +}
>>> +
>>> +static u32 hisi_pcie_pmu_get_offset(u32 offset, u32 idx)
>>> +{
>>> +    return offset + HISI_PCIE_REG_STEP * idx;
>>> +}
>>> +
>>> +static u32 hisi_pcie_pmu_readl(struct hisi_pcie_pmu *pcie_pmu, u32
>>> reg_offset,
>>> +                   u32 idx)
>>> +{
>>> +    u32 offset = hisi_pcie_pmu_get_offset(reg_offset, idx);
>>> +
>>> +    return readl(pcie_pmu->base + offset);
>>> +}
>>> +
>>> +static void hisi_pcie_pmu_writel(struct hisi_pcie_pmu *pcie_pmu, u32
>>> reg_offset,
>>> +                 u32 idx, u32 val)
>>> +{
>>> +    u32 offset = hisi_pcie_pmu_get_offset(reg_offset, idx);
>>> +
>>> +    writel(val, pcie_pmu->base + offset);
>>> +}
>>> +
>>> +static u64 hisi_pcie_pmu_readq(struct hisi_pcie_pmu *pcie_pmu, u32
>>> reg_offset,
>>> +                   u32 idx)
>>> +{
>>> +    u32 offset = hisi_pcie_pmu_get_offset(reg_offset, idx);
>>> +
>>> +    return readq(pcie_pmu->base + offset);
>>> +}
>>> +
>>> +static void hisi_pcie_pmu_writeq(struct hisi_pcie_pmu *pcie_pmu, u32
>>> reg_offset,
>>> +                 u32 idx, u64 val)
>>> +{
>>> +    u32 offset = hisi_pcie_pmu_get_offset(reg_offset, idx);
>>> +
>>> +    writeq(val, pcie_pmu->base + offset);
>>> +}
>>> +
>>> +static u64 hisi_pcie_pmu_get_event(struct perf_event *event)
>>
>> that function name is too vague
>>
>>> +{
>>> +    return FIELD_PREP(HISI_PCIE_EVENT_M, hisi_pcie_get_event(event)) |
>>> +           FIELD_PREP(HISI_PCIE_SUBEVENT_M,
>>> hisi_pcie_get_subevent(event));
>>> +}
>>> +
>>> +static u64 hisi_pcie_pmu_get_target(struct perf_event *event)
>>
>> same here
>>
>>> +{
>>> +    u64 port, val;
>>> +
>>> +    port = hisi_pcie_get_port(event);
>>> +    if (port) {
>>> +        val = FIELD_PREP(HISI_PCIE_TARGET_M, port);
>>> +    } else {
>>> +        val = FIELD_PREP(HISI_PCIE_TARGET_M, hisi_pcie_get_bdf(event));
>>> +        val |= HISI_PCIE_TARGET_EN;
>>> +    }
>>> +
>>> +    return val;
>>> +}
>>> +
>>> +static u64 hisi_pcie_pmu_get_trigger(struct perf_event *event)
>>
>> and here
>>
>> what you really seem to be doing is getting the formatted fields for the
>> register
>>
>>
>> Having all these call-once functions seem to make life a bit more
>> difficult...
>>
> Do you mean config all the filters in one function?, will fix it, thanks.

Yes, I would suggest one function

> 
>>> +{
>>> +    u64 trig_len, val;
>>> +
>>> +    trig_len = hisi_pcie_get_trig_len(event);
>>> +    if (!trig_len)
>>> +        return 0;
>>> +
>>> +    val = FIELD_PREP(HISI_PCIE_TRIG_M, trig_len);
>>> +    val |= FIELD_PREP(HISI_PCIE_TRIG_MODE_M,
>>> +              hisi_pcie_get_trig_mode(event));
>>> +    val |= HISI_PCIE_TRIG_EN;
>>> +
>>> +    return val;
>>> +}
>>> +
>>> +static u64 hisi_pcie_pmu_get_thr(struct perf_event *event)
>>> +{
>>> +    u64 thr_len, val;
>>> +
>>> +    thr_len = hisi_pcie_get_thr_len(event);
>>> +    if (!thr_len)
>>> +        return 0;
>>> +
>>> +    val = FIELD_PREP(HISI_PCIE_THR_M, thr_len);
>>> +    val |= FIELD_PREP(HISI_PCIE_THR_MODE_M,
>>> hisi_pcie_get_thr_mode(event));
>>> +    val |= HISI_PCIE_THR_EN;
>>> +
>>> +    return val;
>>> +}
>>> +
>>> +static void hisi_pcie_pmu_config_filter(struct perf_event *event)
>>> +{
>>> +    struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(event->pmu);
>>> +    struct hw_perf_event *hwc = &event->hw;
>>> +    u32 idx = hwc->idx;
>>> +    u64 val;
>>> +
>>> +    val = HISI_PCIE_DEFAULT_SET;
>>> +    val |= hisi_pcie_pmu_get_event(event);
>>> +    val |= hisi_pcie_pmu_get_target(event);
>>> +    val |= hisi_pcie_pmu_get_trigger(event);
>>> +    val |= hisi_pcie_pmu_get_thr(event);
>>> +    hisi_pcie_pmu_writeq(pcie_pmu, HISI_PCIE_EVENT_CTRL, idx, val);
>>> +}
>>> +
>>> +static void hisi_pcie_pmu_clear_filter(struct perf_event *event)
>>> +{
>>> +    struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(event->pmu);
>>> +    struct hw_perf_event *hwc = &event->hw;
>>> +
>>> +    hisi_pcie_pmu_writeq(pcie_pmu, HISI_PCIE_EVENT_CTRL, hwc->idx,
>>> +                 HISI_PCIE_DEFAULT_SET);
>>> +}
>>> +
>>> +static bool hisi_pcie_pmu_valid_port(struct hisi_pcie_pmu *pcie_pmu,
>>> u16 bdf)
>>> +{
>>> +    return bdf <= pcie_pmu->bdf_max && bdf >= pcie_pmu->bdf_min;
>>
>> nit: it is standard to have:
>>
>>       if (x >= min && x <= max)
>>
>> i.e. have min on the left
>>
>> 2nd nit: it is passed bdf, yet "port" is in the name
>>
> will fix the function, bdf means the BDF of Root Port, I'll use rp_bdf
> in bext version to describe it.

ok

>>
>>> +}
>>> +
>>> +static bool hisi_pcie_pmu_valid_requester_id(struct hisi_pcie_pmu
>>> *pcie_pmu,
>>> +                        u32 bdf)
>>> +{
>>> +    struct pci_dev *root_port, *pdev;
>>> +
>>> +    pdev =
>>> pci_get_domain_bus_and_slot(pci_domain_nr(pcie_pmu->pdev->bus),
>>> +                       PCI_BUS_NUM(bdf),
>>> +                       GET_PCI_DEVFN(bdf));
>>> +    if (!pdev)
>>> +        return false;
>>> +
>>> +    root_port = pcie_find_root_port(pdev);
>>> +    if (!root_port)
>>> +        return false;
>>> +
>>> +    pci_dev_put(pdev);
>>> +    return hisi_pcie_pmu_valid_port(pcie_pmu, pci_dev_id(root_port));
>>> +}
>>> +
>>> +static bool hisi_pcie_pmu_valid_filter(struct perf_event *event,
>>> +                       struct hisi_pcie_pmu *pcie_pmu)
>>> +{
>>> +    u32 subev_idx = hisi_pcie_get_subevent(event);
>>> +    u32 event_idx = hisi_pcie_get_event(event);
>>> +    u32 requester_id = hisi_pcie_get_bdf(event);
>>> +
>>> +    if (subev_idx > HISI_PCIE_SUBEVENT_MAX ||
>>> +        event_idx > HISI_PCIE_EVENT_MAX) {
>>> +        pci_err(pcie_pmu->pdev,
>>> +            "Max event index and max subevent index is: %d, %d.\n",
>>> +            HISI_PCIE_EVENT_MAX, HISI_PCIE_SUBEVENT_MAX);
>>
>> if this is just going to be fed back to userspace, I don't see why we
>> need a kernel log
>>
>> and the only caller also triggers an error message, which I doubt is needed
>>
> Print out the HISI_PCIE_EVENT_MAX and HISI_PCIE_SUBEVENT_MAX here may be
> more convenient for users to get the right value.
> If you this is redundant I'll remove it. :)

Don't we already tell this to userspace?

>>> +        return false;
>>> +    }
>>> +
>>> +    if (hisi_pcie_get_thr_len(event) > HISI_PCIE_THR_MAX_VAL)
>>> +        return false;
>>> +
>>> +    if (hisi_pcie_get_trig_len(event) > HISI_PCIE_TRIG_MAX_VAL)
>>> +        return false;
>>> +
>>> +    if (requester_id) {
>>> +        if (!hisi_pcie_pmu_valid_requester_id(pcie_pmu, requester_id)) {
>>> +            pci_err(pcie_pmu->pdev, "Invalid requester id.\n");
>>
>> see previous comments
>>
>>> +            return false;
>>> +        }
>>> +    }
>>> +
>>> +    return true;
>>> +}
>>> +
>>> +static bool hisi_pcie_pmu_validate_event_group(struct perf_event *event)
>>> +{
>>> +    struct perf_event *sibling, *leader = event->group_leader;
>>> +    int counters = 1;
>>> +
>>> +    if (!is_software_event(leader)) {
>>> +        if (leader->pmu != event->pmu)
>>> +            return false;
>>> +
>>> +        if (leader != event)
>>> +            counters++;
>>> +    }
>>> +
>>> +    for_each_sibling_event(sibling, event->group_leader) {
>>> +        if (is_software_event(sibling))
>>> +            continue;
>>> +
>>> +        if (sibling->pmu != event->pmu)
>>> +            return false;
>>> +
>>> +        counters++;
>>> +    }
>>> +
>>> +    return counters <= HISI_PCIE_MAX_COUNTERS;
>>> +}
>>> +
>>> +static int hisi_pcie_pmu_event_init(struct perf_event *event)
>>> +{
>>> +    struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(event->pmu);
>>> +
>>> +    event->cpu = cpumask_first(&pcie_pmu->cpumask);
>>> +
>>> +    if (event->attr.type != event->pmu->type)
>>> +        return -ENOENT;
>>> +
>>> +    /* Sampling is not supported. */
>>> +    if (is_sampling_event(event) || event->attach_state &
>>> PERF_ATTACH_TASK)
>>> +        return -EOPNOTSUPP;
>>> +
>>> +    /* Per-task mode is not supported. */
>>> +    if (event->cpu < 0)
>>
>> cpumask_first() gives an unsigned int - this can never happen

please fix this!

>>
>>> +        return -EINVAL;
>>> +
>>> +    if (!hisi_pcie_pmu_valid_filter(event, pcie_pmu)) {
>>> +        pci_err(pcie_pmu->pdev, "Invalid filter!\n");
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    if (!hisi_pcie_pmu_validate_event_group(event))
>>> +        return -EINVAL;
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static u64 hisi_pcie_pmu_process_data(struct perf_event *event, u64 val,



>>> +
>>> +static void hisi_pcie_pmu_disable_int(struct hisi_pcie_pmu *pcie_pmu,
>>> +                      struct hw_perf_event *hwc)
>>> +{
>>> +    u32 idx = hwc->idx;
>>> +
>>> +    hisi_pcie_pmu_writel(pcie_pmu, HISI_PCIE_INT_MASK, idx, 1);
>>> +}
>>> +
>>> +static void hisi_pcie_pmu_reset_counter(struct hisi_pcie_pmu *pcie_pmu,
>>> +                    struct hw_perf_event *hwc)
>>> +{
>>> +    u32 idx = hwc->idx;
>>> +
>>> +    hisi_pcie_pmu_writeq(pcie_pmu, HISI_PCIE_EVENT_CTRL, idx,
>>> +                 HISI_PCIE_RESET_CNT);
>>> +    hisi_pcie_pmu_writeq(pcie_pmu, HISI_PCIE_EVENT_CTRL, idx,
>>> +                 HISI_PCIE_DEFAULT_SET);
>>> +}
>>> +
>>> +static void hisi_pcie_pmu_start(struct perf_event *event, int flags)
>>> +{
>>> +    struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(event->pmu);
>>> +    struct hw_perf_event *hwc = &event->hw;
>>> +    struct hw_perf_event_extra *hwc_ext;
>>> +    u64 prev_cnt, prev_cnt_ext;
>>> +
>>> +    hwc_ext = &hwc->extra_reg;
>>> +    if (WARN_ON_ONCE(!(hwc->state & PERF_HES_STOPPED)))
>>> +        return;
>>> +
>>> +    WARN_ON_ONCE(!(hwc->state & PERF_HES_UPTODATE));
>>> +    hwc->state = 0;
>>> +
>>> +    hisi_pcie_pmu_config_filter(event);
>>> +    hisi_pcie_pmu_enable_counter(pcie_pmu, hwc);
>>> +    hisi_pcie_pmu_enable_int(pcie_pmu, hwc);
>>> +    hisi_pcie_pmu_set_period(event);
>>> +
>>> +    if (flags & PERF_EF_RELOAD) {
>>> +        prev_cnt = local64_read(&hwc->prev_count);
>>> +        prev_cnt_ext = hwc_ext->config;
>>> +        hisi_pcie_pmu_write_counter(event, prev_cnt, prev_cnt_ext);
>>> +    }
>>> +
>>> +    perf_event_update_userpage(event);
>>> +}
>>> +
>>> +static void hisi_pcie_pmu_stop(struct perf_event *event, int flags)
>>> +{
>>> +    struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(event->pmu);
>>> +    struct hw_perf_event *hwc = &event->hw;
>>> +
>>> +    hisi_pcie_pmu_read(event);
>>
>> why do this - it just reads a register? and so why not check the return
>> value?
>>
> hisi_pcie_pmu_read() is a void function, perhaps I should use
> hisi_pcie_pmu_update_counter().

I am not sure what your intention is with calling hisi_pcie_pmu_read(), 
so cannot advise

>>> +    hisi_pcie_pmu_disable_int(pcie_pmu, hwc);
>>> +    hisi_pcie_pmu_disable_counter(pcie_pmu, hwc);
>>> +    hisi_pcie_pmu_clear_filter(event);
>>> +    WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
>>> +    hwc->state |= PERF_HES_STOPPED;
>>> +
>>> +    if (hwc->state & PERF_HES_UPTODATE)
>>> +        return;
>>> +
>>> +    hwc->state |= PERF_HES_UPTODATE;
>>> +}
>>> +
>>> +static int hisi_pcie_pmu_add(struct perf_event *event, int flags)
>>> +{
>>> +    struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(event->pmu);
>>> +    struct hw_perf_event *hwc = &event->hw;
>>> +    int idx;
>>> +
>>> +    hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
>>> +    idx = hisi_pcie_pmu_get_event_idx(pcie_pmu);
>>> +    if (idx < 0)
>>> +        return idx;
>>> +
>>> +    hwc->idx = idx;
>>> +    pcie_pmu->hw_events[idx] = event;
>>> +
>>> +    /* Reset PMC to avoid interference caused by previous statistic. */



>>> +
>>> +static void hisi_pcie_pmu_irq_unregister(struct pci_dev *pdev,
>>> +                     struct hisi_pcie_pmu *pcie_pmu)
>>> +{
>>> +    free_irq(pcie_pmu->irq, pcie_pmu);
>>> +    pci_free_irq_vectors(pdev);
>>> +}
>>> +
>>> +static int hisi_pcie_pmu_online_cpu(unsigned int cpu, struct
>>> hlist_node *node)
>>> +{
>>> +    struct hisi_pcie_pmu *pcie_pmu = hlist_entry_safe(node,
>>> +                     struct hisi_pcie_pmu, node);
>>> +
>>> +    if (cpumask_empty(&pcie_pmu->cpumask)) {
>>> +        cpumask_set_cpu(cpu, &pcie_pmu->cpumask);
>>> +        WARN_ON(irq_set_affinity_hint(pcie_pmu->irq, cpumask_of(cpu)));
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int hisi_pcie_pmu_offline_cpu(unsigned int cpu, struct
>>> hlist_node *node)
>>> +{
>>> +    struct hisi_pcie_pmu *pcie_pmu = hlist_entry_safe(node,
>>> +                     struct hisi_pcie_pmu, node);
>>> +    unsigned int target;
>>> +
>>> +    if (!cpumask_test_and_clear_cpu(cpu, &pcie_pmu->cpumask))
>>
>> I do wonder why we even need maintain pcie_pmu->cpumask
>>
>> Can't we just use cpu_online_mask as appropiate instead?

?

>>
>>> +        return 0;
>>> +
>>> +    /* Choose a new CPU from all online cpus. */
>>> +    target = cpumask_any_but(cpu_online_mask, cpu);
>>> +    if (target >= nr_cpu_ids)
>>> +        return 0;
>>> +
>>> +    perf_pmu_migrate_context(&pcie_pmu->pmu, cpu, target);
>>> +    WARN_ON(irq_set_affinity_hint(pcie_pmu->irq, cpumask_of(target)));
>>> +
>>> +    return 0;
>>> +}
>>> +

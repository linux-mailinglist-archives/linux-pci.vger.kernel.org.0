Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602C635DACB
	for <lists+linux-pci@lfdr.de>; Tue, 13 Apr 2021 11:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237069AbhDMJMs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Apr 2021 05:12:48 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16582 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbhDMJMr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Apr 2021 05:12:47 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FKKZB4LHrz1BGY7;
        Tue, 13 Apr 2021 17:10:10 +0800 (CST)
Received: from [127.0.0.1] (10.69.38.203) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.498.0; Tue, 13 Apr 2021
 17:12:17 +0800
Subject: Re: [PATCH v2 1/2] drivers/perf: hisi: Add driver for HiSilicon PCIe
 PMU
To:     John Garry <john.garry@huawei.com>,
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
 <fb795e51-ce01-e976-ac09-d3f384307623@huawei.com>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <b45b5443-b0a4-3e7b-7ba6-be18eb413cba@huawei.com>
Date:   Tue, 13 Apr 2021 17:12:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <fb795e51-ce01-e976-ac09-d3f384307623@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.38.203]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Hi John,

On 2021/4/13 1:21, John Garry wrote:
> On 12/04/2021 14:34, liuqi (BA) wrote:
>>
>> Hi John,
>>
>> Thanks for reviewing this.
>> On 2021/4/9 18:22, John Garry wrote:
>>> On 09/04/2021 10:05, Qi Liu wrote:
>>>> PCIe PMU Root Complex Integrated End Point(RCiEP) device is supported
>>>> to sample bandwidth, latency, buffer occupation etc.
>>>>
>>>> Each PMU RCiEP device monitors multiple Root Ports, and each RCiEP is
>>>> registered as a PMU in /sys/bus/event_source/devices, so users can
>>>> select target PMU, and use filter to do further sets.
> 
> side note: it would be good to mention what baseline the series is based 
> on in the cover letter
> 
Got it, will add it, thanks.

>>>>
>>>> Filtering options contains:
>>>> event        - select the event.
>>>> subevent     - select the subevent.
>>>> port         - select target Root Ports. Information of Root Ports
>>>>                  are shown under sysfs.
>>>> bdf          - select requester_id of target EP device.
>>>> trig_len     - set trigger condition for starting event statistics.
>>>> trigger_mode - set trigger mode. 0 means starting to statistic when
>>>>                  bigger than trigger condition, and 1 means smaller.
>>>> thr_len      - set threshold for statistics.
>>>> thr_mode     - set threshold mode. 0 means count when bigger than
>>>>                  threshold, and 1 means smaller.
>>>>
>>>> Signed-off-by: Qi Liu <liuqi115@huawei.com>
>>>> ---
>>>>    MAINTAINERS                                |    6 +
>>>>    drivers/perf/Kconfig                       |    2 +
>>>>    drivers/perf/Makefile                      |    1 +
>>>>    drivers/perf/pci/Kconfig                   |   16 +
>>>>    drivers/perf/pci/Makefile                  |    2 +
>>>>    drivers/perf/pci/hisilicon/Makefile        |    5 +
>>>>    drivers/perf/pci/hisilicon/hisi_pcie_pmu.c | 1011
>>>> ++++++++++++++++++++++++++++
>>>>    include/linux/cpuhotplug.h                 |    1 +
>>>>    8 files changed, 1044 insertions(+)
>>>>    create mode 100644 drivers/perf/pci/Kconfig
>>>>    create mode 100644 drivers/perf/pci/Makefile
>>>>    create mode 100644 drivers/perf/pci/hisilicon/Makefile
>>>>    create mode 100644 drivers/perf/pci/hisilicon/hisi_pcie_pmu.c
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 3353de0..46c7861 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -8023,6 +8023,12 @@ W:    http://www.hisilicon.com
>>>>    F:    Documentation/admin-guide/perf/hisi-pmu.rst
>>>>    F:    drivers/perf/hisilicon
>>>> +HISILICON PCIE PMU DRIVER
>>>> +M:    Qi Liu <liuqi115@huawei.com>
>>>> +S:    Maintained
>>>> +F:    Documentation/admin-guide/perf/hisi-pcie-pmu.rst
>>>
>>> nit: this does not exist yet...
>>>
>> thanks, I'll move this add-maintainer-part to the second patch.
> 
> that's why I advocate the documentation first :)
ok, I'll move document as the first patch.
> 
>>>> +F:    drivers/perf/pci/hisilicon/hisi_pcie_pmu.c
>>>> +
>>>>    HISILICON QM AND ZIP Controller DRIVER
>>>>    M:    Zhou Wang <wangzhou1@hisilicon.com>
>>>>    L:    linux-crypto@vger.kernel.org
>>>> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
>>>> index 3075cf1..99d4760 100644
>>>> --- a/drivers/perf/Kconfig
>>>> +++ b/drivers/perf/Kconfig
>>>> @@ -139,4 +139,6 @@ config ARM_DMC620_PMU
>>>>    source "drivers/perf/hisilicon/Kconfig"
>>>> +source "drivers/perf/pci/Kconfig"
>>>> +
>>>>    endmenu
>>>> diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
>>>> index 5260b11..1208c08 100644
>>>> --- a/drivers/perf/Makefile
>>>> +++ b/drivers/perf/Makefile
>>>> @@ -14,3 +14,4 @@ obj-$(CONFIG_THUNDERX2_PMU) += thunderx2_pmu.o
>>>>    obj-$(CONFIG_XGENE_PMU) += xgene_pmu.o
>>>>    obj-$(CONFIG_ARM_SPE_PMU) += arm_spe_pmu.o
>>>>    obj-$(CONFIG_ARM_DMC620_PMU) += arm_dmc620_pmu.o
>>>> +obj-y += pci/
>>>> diff --git a/drivers/perf/pci/Kconfig b/drivers/perf/pci/Kconfig
>>>> new file mode 100644
>>>> index 0000000..a119486
>>>> --- /dev/null
>>>> +++ b/drivers/perf/pci/Kconfig
>>>> @@ -0,0 +1,16 @@
>>>> +# SPDX-License-Identifier: GPL-2.0-only
>>>> +#
>>>> +# PCIe Performance Monitor Drivers
>>>> +#
>>>> +menu "PCIe Performance Monitor"
>>>> +
>>>> +config HISI_PCIE_PMU
>>>> +    tristate "HiSilicon PCIE PERF PMU"
>>>> +    depends on ARM64 && PCI && HISI_PMU
>>>
>>> What from HISI_PMU is needed? I couldn't find anything here
>> The event_sysfs_show() and format_sysfs_show() function of
>> hisi_uncore_pmu.h can be reused in hisi_pcie_pmu.c, So I add path in
>> Makefile and include "hisi_uncore_pmu.h".
> 
> Right, but it would be nice to be able to build this under COMPILE_TEST. 
> CONFIG_HISI_PMU cannot be built under COMPILE_TEST, so nice to not 
> depend on it.
> 
> So you could put hisi_event_sysfs_show() as a static inline in 
> hisi_uncore_pmu.h, so the dependency can be removed
> 
> Having said that, there is nothing really hisi specific in those 
> functions like hisi_event_sysfs_show().
> 
> Can't we just create generic functions here?
> 
> hisi_event_sysfs_show() == cci400_pmu_cycle_event_show() == 
> xgene_pmu_event_show()
> 
Got it, will address this.
>>
>>>
>>>> +    help
>>>> +      Provide support for HiSilicon PCIe performance monitoring unit
>>>> (PMU)
>>>> +      RCiEP devices.
>>>> +      Adds the PCIe PMU into perf events system for monitoring 
>>>> latency,
>>>> +      bandwidth etc.
>>>> +
> 
> 
> 
> 
>
[...]
>>>> +static bool hisi_pcie_pmu_valid_filter(struct perf_event *event,
>>>> +                       struct hisi_pcie_pmu *pcie_pmu)
>>>> +{
>>>> +    u32 subev_idx = hisi_pcie_get_subevent(event);
>>>> +    u32 event_idx = hisi_pcie_get_event(event);
>>>> +    u32 requester_id = hisi_pcie_get_bdf(event);
>>>> +
>>>> +    if (subev_idx > HISI_PCIE_SUBEVENT_MAX ||
>>>> +        event_idx > HISI_PCIE_EVENT_MAX) {
>>>> +        pci_err(pcie_pmu->pdev,
>>>> +            "Max event index and max subevent index is: %d, %d.\n",
>>>> +            HISI_PCIE_EVENT_MAX, HISI_PCIE_SUBEVENT_MAX);
>>>
>>> if this is just going to be fed back to userspace, I don't see why we
>>> need a kernel log
>>>
>>> and the only caller also triggers an error message, which I doubt is 
>>> needed
>>>
>> Print out the HISI_PCIE_EVENT_MAX and HISI_PCIE_SUBEVENT_MAX here may be
>> more convenient for users to get the right value.
>> If you this is redundant I'll remove it. :)
> 
> Don't we already tell this to userspace?
> 
"event" is a 8-bit filter, its max value is 0xff, but PCIE PMU only have 
0xa2 events， So if users input "event=0xa3", userspace only printout 
"<not supported>".
Perhaps driver could tell users the max value of event index here.
If you think this is redundant I'll remove it. :)


>>>> +        return false;
>>>> +    }
>>>> +
>>>> +    if (hisi_pcie_get_thr_len(event) > HISI_PCIE_THR_MAX_VAL)
>>>> +        return false;
>>>> +
>>>> +    if (hisi_pcie_get_trig_len(event) > HISI_PCIE_TRIG_MAX_VAL)
>>>> +        return false;
>>>> +
>>>> +    if (requester_id) {
>>>> +        if (!hisi_pcie_pmu_valid_requester_id(pcie_pmu, 
>>>> requester_id)) {
>>>> +            pci_err(pcie_pmu->pdev, "Invalid requester id.\n");
>>>
>>> see previous comments
>>>
>>>> +            return false;
>>>> +        }
>>>> +    }
>>>> +
>>>> +    return true;
>>>> +}
>>>> +
>>>> +static bool hisi_pcie_pmu_validate_event_group(struct perf_event 
>>>> *event)
>>>> +{
>>>> +    struct perf_event *sibling, *leader = event->group_leader;
>>>> +    int counters = 1;
>>>> +
>>>> +    if (!is_software_event(leader)) {
>>>> +        if (leader->pmu != event->pmu)
>>>> +            return false;
>>>> +
>>>> +        if (leader != event)
>>>> +            counters++;
>>>> +    }
>>>> +
>>>> +    for_each_sibling_event(sibling, event->group_leader) {
>>>> +        if (is_software_event(sibling))
>>>> +            continue;
>>>> +
>>>> +        if (sibling->pmu != event->pmu)
>>>> +            return false;
>>>> +
>>>> +        counters++;
>>>> +    }
>>>> +
>>>> +    return counters <= HISI_PCIE_MAX_COUNTERS;
>>>> +}
>>>> +
>>>> +static int hisi_pcie_pmu_event_init(struct perf_event *event)
>>>> +{
>>>> +    struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(event->pmu);
>>>> +
>>>> +    event->cpu = cpumask_first(&pcie_pmu->cpumask);
>>>> +
>>>> +    if (event->attr.type != event->pmu->type)
>>>> +        return -ENOENT;
>>>> +
>>>> +    /* Sampling is not supported. */
>>>> +    if (is_sampling_event(event) || event->attach_state &
>>>> PERF_ATTACH_TASK)
>>>> +        return -EOPNOTSUPP;
>>>> +
>>>> +    /* Per-task mode is not supported. */
>>>> +    if (event->cpu < 0)
>>>
>>> cpumask_first() gives an unsigned int - this can never happen
> 
> please fix this!
> 
Sorry, missed it yesterday. I'll fix this next version.
>>>
>>>> +        return -EINVAL;
>>>> +
>>>> +    if (!hisi_pcie_pmu_valid_filter(event, pcie_pmu)) {
>>>> +        pci_err(pcie_pmu->pdev, "Invalid filter!\n");
>>>> +        return -EINVAL;
>>>> +    }
>>>> +
>>>> +    if (!hisi_pcie_pmu_validate_event_group(event))
>>>> +        return -EINVAL;
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static u64 hisi_pcie_pmu_process_data(struct perf_event *event, u64 
>>>> val,
> 
> 
...
> 
>>>> +
>>>> +static void hisi_pcie_pmu_irq_unregister(struct pci_dev *pdev,
>>>> +                     struct hisi_pcie_pmu *pcie_pmu)
>>>> +{
>>>> +    free_irq(pcie_pmu->irq, pcie_pmu);
>>>> +    pci_free_irq_vectors(pdev);
>>>> +}
>>>> +
>>>> +static int hisi_pcie_pmu_online_cpu(unsigned int cpu, struct
>>>> hlist_node *node)
>>>> +{
>>>> +    struct hisi_pcie_pmu *pcie_pmu = hlist_entry_safe(node,
>>>> +                     struct hisi_pcie_pmu, node);
>>>> +
>>>> +    if (cpumask_empty(&pcie_pmu->cpumask)) {
>>>> +        cpumask_set_cpu(cpu, &pcie_pmu->cpumask);
>>>> +        WARN_ON(irq_set_affinity_hint(pcie_pmu->irq, 
>>>> cpumask_of(cpu)));
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int hisi_pcie_pmu_offline_cpu(unsigned int cpu, struct
>>>> hlist_node *node)
>>>> +{
>>>> +    struct hisi_pcie_pmu *pcie_pmu = hlist_entry_safe(node,
>>>> +                     struct hisi_pcie_pmu, node);
>>>> +    unsigned int target;
>>>> +
>>>> +    if (!cpumask_test_and_clear_cpu(cpu, &pcie_pmu->cpumask))
>>>
>>> I do wonder why we even need maintain pcie_pmu->cpumask
>>>
>>> Can't we just use cpu_online_mask as appropiate instead?
> 
> ?
Sorry, missed it yesterday.
It seems that cpumask is always same as cpu_online_mask, So do we need 
to reserve the cpumask sysfs interface?

Thanks,
Qi
> 
>>>
>>>> +        return 0;
>>>> +
>>>> +    /* Choose a new CPU from all online cpus. */
>>>> +    target = cpumask_any_but(cpu_online_mask, cpu);
>>>> +    if (target >= nr_cpu_ids)
>>>> +        return 0;
>>>> +
>>>> +    perf_pmu_migrate_context(&pcie_pmu->pmu, cpu, target);
>>>> +    WARN_ON(irq_set_affinity_hint(pcie_pmu->irq, cpumask_of(target)));
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
> 
> .


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0063B7F22
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jun 2021 10:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbhF3IkJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Jun 2021 04:40:09 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:9330 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbhF3IkJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Jun 2021 04:40:09 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GFF3m5wYlz74J1;
        Wed, 30 Jun 2021 16:33:24 +0800 (CST)
Received: from dggema757-chm.china.huawei.com (10.1.198.199) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 30 Jun 2021 16:37:37 +0800
Received: from [127.0.0.1] (10.69.38.203) by dggema757-chm.china.huawei.com
 (10.1.198.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 30
 Jun 2021 16:37:37 +0800
Subject: Re: [PATCH v7 2/2] drivers/perf: hisi: Add driver for HiSilicon PCIe
 PMU
To:     kajoljain <kjain@linux.ibm.com>, Linuxarm <linuxarm@huawei.com>,
        <will@kernel.org>, <mark.rutland@arm.com>, <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <zhangshaokun@hisilicon.com>
References: <1624532384-43002-1-git-send-email-liuqi115@huawei.com>
 <1624532384-43002-3-git-send-email-liuqi115@huawei.com>
 <88c32b01-ba6c-0b8a-c9eb-3cdf54a2d659@linux.ibm.com>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <ba2db3ff-f192-2671-6ed6-23eb2342f688@huawei.com>
Date:   Wed, 30 Jun 2021 16:37:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <88c32b01-ba6c-0b8a-c9eb-3cdf54a2d659@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.38.203]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema757-chm.china.huawei.com (10.1.198.199)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021/6/28 20:03, kajoljain wrote:
> 
> 
> On 6/24/21 4:29 PM, Qi Liu wrote:
>> PCIe PMU Root Complex Integrated End Point(RCiEP) device is supported
>> to sample bandwidth, latency, buffer occupation etc.
>>
>> Each PMU RCiEP device monitors multiple Root Ports, and each RCiEP is
>> registered as a PMU in /sys/bus/event_source/devices, so users can
>> select target PMU, and use filter to do further sets.
>>
>> Filtering options contains:
>> event        - select the event.
>> subevent     - select the subevent.
>> port         - select target Root Ports. Information of Root Ports
>>                 are shown under sysfs.
>> bdf          - select requester_id of target EP device.
>> trig_len     - set trigger condition for starting event statistics.
>> trigger_mode - set trigger mode. 0 means starting to statistic when
>>                 bigger than trigger condition, and 1 means smaller.
>> thr_len      - set threshold for statistics.
>> thr_mode     - set threshold mode. 0 means count when bigger than
>>                 threshold, and 1 means smaller.
>>
>> Reviewed-by: John Garry <john.garry@huawei.com>
>> Signed-off-by: Qi Liu <liuqi115@huawei.com>
>> ---
>>   MAINTAINERS                            |   2 +
>>   drivers/perf/hisilicon/Kconfig         |   9 +
>>   drivers/perf/hisilicon/Makefile        |   2 +
>>   drivers/perf/hisilicon/hisi_pcie_pmu.c | 967 +++++++++++++++++++++++++++++++++
>>   include/linux/cpuhotplug.h             |   1 +
>>   5 files changed, 981 insertions(+)
>>   create mode 100644 drivers/perf/hisilicon/hisi_pcie_pmu.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 81e1ede..8639c1c 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -8228,8 +8228,10 @@ F:	Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.yaml
>>   
>>   HISILICON PMU DRIVER
>>   M:	Shaokun Zhang <zhangshaokun@hisilicon.com>
>> +M:	Qi Liu <liuqi115@huawei.com>
>>   S:	Supported
>>   W:	http://www.hisilicon.com
>> +F:	Documentation/admin-guide/perf/hisi-pcie-pmu.rst
>>   F:	Documentation/admin-guide/perf/hisi-pmu.rst
>>   F:	drivers/perf/hisilicon
>>   
>> diff --git a/drivers/perf/hisilicon/Kconfig b/drivers/perf/hisilicon/Kconfig
>> index c5d1b701..5546218 100644
>> --- a/drivers/perf/hisilicon/Kconfig
>> +++ b/drivers/perf/hisilicon/Kconfig
>> @@ -5,3 +5,12 @@ config HISI_PMU
>>   	  help
>>   	  Support for HiSilicon SoC L3 Cache performance monitor, Hydra Home
>>   	  Agent performance monitor and DDR Controller performance monitor.
>> +
>> +config HISI_PCIE_PMU
>> +	tristate "HiSilicon PCIE PERF PMU"
>> +	depends on PCI && ARM64
>> +	help
>> +	  Provide support for HiSilicon PCIe performance monitoring unit (PMU)
>> +	  RCiEP devices.
>> +	  Adds the PCIe PMU into perf events system for monitoring latency,
>> +	  bandwidth etc.
>> diff --git a/drivers/perf/hisilicon/Makefile b/drivers/perf/hisilicon/Makefile
>> index 7643c9f..506ed39 100644
>> --- a/drivers/perf/hisilicon/Makefile
>> +++ b/drivers/perf/hisilicon/Makefile
>> @@ -2,3 +2,5 @@
>>   obj-$(CONFIG_HISI_PMU) += hisi_uncore_pmu.o hisi_uncore_l3c_pmu.o \
>>   			  hisi_uncore_hha_pmu.o hisi_uncore_ddrc_pmu.o hisi_uncore_sllc_pmu.o \
>>   			  hisi_uncore_pa_pmu.o
>> +
>> +obj-$(CONFIG_HISI_PCIE_PMU) += hisi_pcie_pmu.o
>> diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
>> new file mode 100644
>> index 0000000..50994e5
>> --- /dev/null
>> +++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
>> @@ -0,0 +1,967 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * This driver adds support for PCIe PMU RCiEP device. Related
>> + * perf events are bandwidth, bandwidth utilization, latency
>> + * etc.
>> + *
>> + * Copyright (C) 2021 HiSilicon Limited
>> + * Author: Qi Liu <liuqi115@huawei.com>
>> + */
>> +#include <linux/bitfield.h>
>> +#include <linux/bitmap.h>
>> +#include <linux/bug.h>
>> +#include <linux/cpuhotplug.h>
>> +#include <linux/cpumask.h>
> 
> Hi Qi liu,
>     I think we can skip adding headerfile cpumask.h and cpuhotplug.h here, as it
> get included via perf_event.h
> 

Hi kajoljain,
yes, will fix this next time, thanks.

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

[...]

>> +
>> +static int hisi_pcie_pmu_online_cpu(unsigned int cpu, struct hlist_node *node)
>> +{
>> +	struct hisi_pcie_pmu *pcie_pmu = hlist_entry_safe(node,
>> +					 struct hisi_pcie_pmu, node);
>> +
>> +	if (pcie_pmu->on_cpu == -1) {
>> +		pcie_pmu->on_cpu = cpu;
>> +		WARN_ON(irq_set_affinity(pcie_pmu->irq, cpumask_of(cpu)));
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int hisi_pcie_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
>> +{
>> +	struct hisi_pcie_pmu *pcie_pmu = hlist_entry_safe(node,
>> +					 struct hisi_pcie_pmu, node);
>> +	unsigned int target;
>> +
>> +	/* Nothing to do if this CPU doesn't own the PMU */
>> +	if (pcie_pmu->on_cpu != cpu)
>> +		return 0;
>> +
>> +	/* Choose a new CPU from all online cpus. */
>> +	target = cpumask_first(cpu_online_mask);
>> +	if (target >= nr_cpu_ids) {
>> +		pci_err(pcie_pmu->pdev, "There is no CPU to set!\n");
>> +		return 0;
>> +	}
>> +
> 
> Incase target >= nr_cpu_ids, pcie_pmu->on_cpu will still point to
> cpu which is offlining. We should also update pcie_pmu->on_cpu to -1 incase
> we didn't get valid cpu number?

yes, that's make sense, will fix it next time.
> 
>> +	perf_pmu_migrate_context(&pcie_pmu->pmu, cpu, target);
>> +	/* Use this CPU for event counting */
>> +	pcie_pmu->on_cpu = target;
>> +	WARN_ON(irq_set_affinity(pcie_pmu->irq, cpumask_of(target)));
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * Events with the "dl" suffix in their names count performance in DL layer,
>> + * otherswise, events count performance in TL layer.
>> + */
>> +static struct attribute *hisi_pcie_pmu_events_attr[] = {
>> +	HISI_PCIE_PMU_EVENT_ATTR(bw_rx_mwr, 0x010004),
>> +	HISI_PCIE_PMU_EVENT_ATTR(bw_rx_mrd, 0x100005),
>> +	HISI_PCIE_PMU_EVENT_ATTR(bw_tx_mwr, 0x010005),
>> +	HISI_PCIE_PMU_EVENT_ATTR(bw_tx_mrd, 0x200004),
>> +	HISI_PCIE_PMU_EVENT_ATTR(lat_rx_mwr, 0x000010),
>> +	HISI_PCIE_PMU_EVENT_ATTR(lat_rx_mrd, 0x020010),
>> +	HISI_PCIE_PMU_EVENT_ATTR(lat_tx_mrd, 0x000011),
>> +	HISI_PCIE_PMU_EVENT_ATTR(bw_rx_dl, 0x010084),
>> +	HISI_PCIE_PMU_EVENT_ATTR(bw_tx_dl, 0x030084),
>> +	NULL
>> +};
>> +
>> +static struct attribute_group hisi_pcie_pmu_events_group = {
>> +	.name = "events",
>> +	.attrs = hisi_pcie_pmu_events_attr,
>> +};
>> +
>> +static struct attribute *hisi_pcie_pmu_format_attr[] = {
>> +	HISI_PCIE_PMU_FORMAT_ATTR(event, "config:0-15"),
>> +	HISI_PCIE_PMU_FORMAT_ATTR(subevent, "config:16-23"),
>> +	HISI_PCIE_PMU_FORMAT_ATTR(thr_len, "config1:0-3"),
>> +	HISI_PCIE_PMU_FORMAT_ATTR(thr_mode, "config1:4"),
>> +	HISI_PCIE_PMU_FORMAT_ATTR(trig_len, "config1:5-8"),
>> +	HISI_PCIE_PMU_FORMAT_ATTR(trig_mode, "config1:9"),
>> +	HISI_PCIE_PMU_FORMAT_ATTR(port, "config2:0-15"),
>> +	HISI_PCIE_PMU_FORMAT_ATTR(bdf, "config2:16-31"),
>> +	NULL
>> +};
> 
> Just for my understanding, why we are not using config bits 24-63

I would like to keep all config bits for PMU events index, so users 
could set config=0xXX to select events, and config1/config2 bits for 
other formats.

Thanks.
Qi
> 
>> +
>> +static const struct attribute_group hisi_pcie_pmu_format_group = {
>> +	.name = "format",
>> +	.attrs = hisi_pcie_pmu_format_attr,
>> +};
>> +
>> +static struct attribute *hisi_pcie_pmu_bus_attrs[] = {
>> +	&dev_attr_bus.attr,
>> +	NULL
>> +};
>> +
>> +static const struct attribute_group hisi_pcie_pmu_bus_attr_group = {
>> +	.attrs = hisi_pcie_pmu_bus_attrs,
>> +};
>> +
>> +static struct attribute *hisi_pcie_pmu_cpumask_attrs[] = {
>> +	&dev_attr_cpumask.attr,
>> +	NULL
>> +};
>> +
>> +static const struct attribute_group hisi_pcie_pmu_cpumask_attr_group = {
>> +	.attrs = hisi_pcie_pmu_cpumask_attrs,
>> +};
>> +
>> +static struct attribute *hisi_pcie_pmu_identifier_attrs[] = {
>> +	&dev_attr_identifier.attr,
>> +	NULL
>> +};
>> +
>> +static const struct attribute_group hisi_pcie_pmu_identifier_attr_group = {
>> +	.attrs = hisi_pcie_pmu_identifier_attrs,
>> +};
>> +
>> +static const struct attribute_group *hisi_pcie_pmu_attr_groups[] = {
>> +	&hisi_pcie_pmu_events_group,
>> +	&hisi_pcie_pmu_format_group,
>> +	&hisi_pcie_pmu_bus_attr_group,
>> +	&hisi_pcie_pmu_cpumask_attr_group,
>> +	&hisi_pcie_pmu_identifier_attr_group,
>> +	NULL
>> +};
>> +
>> +static int hisi_pcie_alloc_pmu(struct pci_dev *pdev,
>> +			       struct hisi_pcie_pmu *pcie_pmu)
>> +{
>> +	struct hisi_pcie_reg_pair regs;
>> +	u16 sicl_id, device_id;
>> +	char *name;
>> +
>> +	regs = hisi_pcie_parse_reg_value(pcie_pmu, HISI_PCIE_REG_BDF);
>> +	pcie_pmu->bdf_min = regs.lo;
>> +	pcie_pmu->bdf_max = regs.hi;
>> +
>> +	regs = hisi_pcie_parse_reg_value(pcie_pmu, HISI_PCIE_REG_INFO);
>> +	sicl_id = regs.hi;
>> +	device_id = regs.lo;
>> +
>> +	name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
>> +			      "hisi_pcie%u_%u", sicl_id, device_id);
>> +	if (!name)
>> +		return -ENOMEM;
>> +
>> +	pcie_pmu->pdev = pdev;
>> +	pcie_pmu->on_cpu = -1;
>> +	pcie_pmu->identifier = readl(pcie_pmu->base + HISI_PCIE_REG_VERSION);
>> +	pcie_pmu->pmu = (struct pmu) {
>> +		.name		= name,
>> +		.module		= THIS_MODULE,
>> +		.event_init	= hisi_pcie_pmu_event_init,
>> +		.pmu_enable	= hisi_pcie_pmu_enable,
>> +		.pmu_disable	= hisi_pcie_pmu_disable,
>> +		.add		= hisi_pcie_pmu_add,
>> +		.del		= hisi_pcie_pmu_del,
>> +		.start		= hisi_pcie_pmu_start,
>> +		.stop		= hisi_pcie_pmu_stop,
>> +		.read		= hisi_pcie_pmu_read,
>> +		.task_ctx_nr	= perf_invalid_context,
>> +		.attr_groups	= hisi_pcie_pmu_attr_groups,
>> +		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
>> +	};
>> +
>> +	return 0;
>> +}
>> +
>> +static int hisi_pcie_init_pmu(struct pci_dev *pdev,
>> +			      struct hisi_pcie_pmu *pcie_pmu)
>> +{
>> +	int ret;
>> +
>> +	pcie_pmu->base = pci_ioremap_bar(pdev, 2);
>> +	if (!pcie_pmu->base) {
>> +		pci_err(pdev, "Ioremap failed for pcie_pmu resource.\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	ret = hisi_pcie_alloc_pmu(pdev, pcie_pmu);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = hisi_pcie_pmu_irq_register(pdev, pcie_pmu);
>> +	if (ret)
>> +		goto err_set_pmu_fail;
>> +
>> +	ret = cpuhp_state_add_instance(CPUHP_AP_PERF_ARM_HISI_PCIE_PMU_ONLINE,
>> +				       &pcie_pmu->node);
>> +	if (ret) {
>> +		pci_err(pdev, "Failed to register hotplug: %d.\n", ret);
>> +		goto err_irq_unregister;
>> +	}
>> +
>> +	ret = perf_pmu_register(&pcie_pmu->pmu, pcie_pmu->pmu.name, -1);
>> +	if (ret) {
>> +		pci_err(pdev, "Failed to register PCIe PMU: %d.\n", ret);
>> +		goto err_hotplug_unregister;
>> +	}
>> +
>> +	return ret;
>> +
>> +err_hotplug_unregister:
>> +	cpuhp_state_remove_instance_nocalls(
>> +		CPUHP_AP_PERF_ARM_HISI_PCIE_PMU_ONLINE, &pcie_pmu->node);
>> +
>> +err_irq_unregister:
>> +	hisi_pcie_pmu_irq_unregister(pdev, pcie_pmu);
>> +
>> +err_set_pmu_fail:
>> +	iounmap(pcie_pmu->base);
>> +
>> +	return ret;
>> +}
>> +
>> +static void hisi_pcie_uninit_pmu(struct pci_dev *pdev)
>> +{
>> +	struct hisi_pcie_pmu *pcie_pmu = pci_get_drvdata(pdev);
>> +
>> +	perf_pmu_unregister(&pcie_pmu->pmu);
>> +	cpuhp_state_remove_instance_nocalls(
>> +		CPUHP_AP_PERF_ARM_HISI_PCIE_PMU_ONLINE, &pcie_pmu->node);
>> +	hisi_pcie_pmu_irq_unregister(pdev, pcie_pmu);
>> +	iounmap(pcie_pmu->base);
>> +}
>> +
>> +static int hisi_pcie_init_dev(struct pci_dev *pdev)
>> +{
>> +	int ret;
>> +
>> +	ret = pci_enable_device(pdev);
>> +	if (ret) {
>> +		pci_err(pdev, "Failed to enable PCI device: %d.\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = pci_request_mem_regions(pdev, "hisi_pcie_pmu");
>> +	if (ret < 0) {
>> +		pci_err(pdev, "Failed to request PCI mem regions: %d.\n", ret);
>> +		pci_disable_device(pdev);
>> +		return ret;
>> +	}
>> +
>> +	pci_set_master(pdev);
>> +
>> +	return 0;
>> +}
>> +
>> +static void hisi_pcie_uninit_dev(struct pci_dev *pdev)
>> +{
>> +	pci_clear_master(pdev);
>> +	pci_release_mem_regions(pdev);
>> +	pci_disable_device(pdev);
>> +}
>> +
>> +static int hisi_pcie_pmu_probe(struct pci_dev *pdev,
>> +			       const struct pci_device_id *id)
>> +{
>> +	struct hisi_pcie_pmu *pcie_pmu;
>> +	int ret;
>> +
>> +	pcie_pmu = devm_kzalloc(&pdev->dev, sizeof(*pcie_pmu), GFP_KERNEL);
>> +	if (!pcie_pmu)
>> +		return -ENOMEM;
>> +
>> +	ret = hisi_pcie_init_dev(pdev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = hisi_pcie_init_pmu(pdev, pcie_pmu);
>> +	if (ret)
>> +		hisi_pcie_uninit_dev(pdev);
>> +
>> +	pci_set_drvdata(pdev, pcie_pmu);
>> +
>> +	return ret;
>> +}
>> +
>> +static void hisi_pcie_pmu_remove(struct pci_dev *pdev)
>> +{
>> +	hisi_pcie_uninit_pmu(pdev);
>> +	hisi_pcie_uninit_dev(pdev);
>> +	pci_set_drvdata(pdev, NULL);
>> +}
>> +
>> +static const struct pci_device_id hisi_pcie_pmu_ids[] = {
>> +	{ PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, 0xa12d) },
>> +	{ 0, }
>> +};
>> +MODULE_DEVICE_TABLE(pci, hisi_pcie_pmu_ids);
>> +
>> +static struct pci_driver hisi_pcie_pmu_driver = {
>> +	.name = "hisi_pcie_pmu",
>> +	.id_table = hisi_pcie_pmu_ids,
>> +	.probe = hisi_pcie_pmu_probe,
>> +	.remove = hisi_pcie_pmu_remove,
>> +};
>> +
>> +static int __init hisi_pcie_module_init(void)
>> +{
>> +	int ret;
>> +
>> +	ret = cpuhp_setup_state_multi(CPUHP_AP_PERF_ARM_HISI_PCIE_PMU_ONLINE,
>> +				      "AP_PERF_ARM_HISI_PCIE_PMU_ONLINE",
>> +				      hisi_pcie_pmu_online_cpu,
>> +				      hisi_pcie_pmu_offline_cpu);
>> +	if (ret) {
>> +		pr_err("Failed to setup PCIe PMU hotplug, ret = %d.\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = pci_register_driver(&hisi_pcie_pmu_driver);
>> +	if (ret)
>> +		cpuhp_remove_multi_state(
>> +				CPUHP_AP_PERF_ARM_HISI_PCIE_PMU_ONLINE);
>> +
>> +	return ret;
>> +}
>> +module_init(hisi_pcie_module_init);
>> +
>> +static void __exit hisi_pcie_module_exit(void)
>> +{
>> +	pci_unregister_driver(&hisi_pcie_pmu_driver);
>> +	cpuhp_remove_multi_state(CPUHP_AP_PERF_ARM_HISI_PCIE_PMU_ONLINE);
>> +}
>> +module_exit(hisi_pcie_module_exit);
>> +
>> +MODULE_DESCRIPTION("HiSilicon PCIe PMU driver");
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_AUTHOR("Qi Liu <liuqi115@huawei.com>");
>> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
>> index 4a62b39..a9776a2 100644
>> --- a/include/linux/cpuhotplug.h
>> +++ b/include/linux/cpuhotplug.h
>> @@ -180,6 +180,7 @@ enum cpuhp_state {
>>   	CPUHP_AP_PERF_ARM_HISI_L3_ONLINE,
>>   	CPUHP_AP_PERF_ARM_HISI_PA_ONLINE,
>>   	CPUHP_AP_PERF_ARM_HISI_SLLC_ONLINE,
>> +	CPUHP_AP_PERF_ARM_HISI_PCIE_PMU_ONLINE,
>>   	CPUHP_AP_PERF_ARM_L2X0_ONLINE,
>>   	CPUHP_AP_PERF_ARM_QCOM_L2_ONLINE,
>>   	CPUHP_AP_PERF_ARM_QCOM_L3_ONLINE,
>>
> .
> 


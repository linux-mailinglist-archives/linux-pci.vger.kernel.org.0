Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698F8529BCF
	for <lists+linux-pci@lfdr.de>; Tue, 17 May 2022 10:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241837AbiEQIJv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 May 2022 04:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236249AbiEQIJt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 May 2022 04:09:49 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4B13C739;
        Tue, 17 May 2022 01:09:47 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4L2TDh1X49zCsjb;
        Tue, 17 May 2022 16:04:52 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 17 May 2022 16:09:45 +0800
CC:     <helgaas@kernel.org>, <lorenzo.pieralisi@arm.com>,
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
To:     John Garry <john.garry@huawei.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        <gregkh@linuxfoundation.org>, <alexander.shishkin@linux.intel.com>,
        <leo.yan@linaro.org>, <james.clark@arm.com>, <will@kernel.org>,
        <robin.murphy@arm.com>, <acme@kernel.org>,
        <jonathan.cameron@huawei.com>
References: <20220516125223.32012-1-yangyicong@hisilicon.com>
 <20220516125223.32012-3-yangyicong@hisilicon.com>
 <90aafbc1-b7f6-1cc9-8f94-c72f05150f70@huawei.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <31113797-29c5-1400-f7ac-bff79853b3fe@huawei.com>
Date:   Tue, 17 May 2022 16:09:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <90aafbc1-b7f6-1cc9-8f94-c72f05150f70@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022/5/17 0:23, John Garry wrote:
> On 16/05/2022 13:52, Yicong Yang wrote:
>> HiSilicon PCIe tune and trace device(PTT) is a PCIe Root Complex integrated
>> Endpoint(RCiEP) device, providing the capability to dynamically monitor and
>> tune the PCIe traffic and trace the TLP headers.
>>
>> Add the driver for the device to enable the trace function. Register PMU
>> device of PTT trace, then users can use trace through perf command. The
>> driver makes use of perf AUX trace function and support the following
>> events to configure the trace:
>>
>> - filter: select Root port or Endpoint to trace
>> - type: select the type of traced TLP headers
>> - direction: select the direction of traced TLP headers
>> - format: select the data format of the traced TLP headers
>>
>> This patch initially add a basic driver of PTT trace.
> 
> Initially add basic trace support.
> 
>>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> 
> Generally this looks ok, apart from nitpicking below, so, FWIW:
> Reviewed-by: John Garry <john.garry@huawei.com>
> >> ---
>>   drivers/Makefile                 |   1 +
>>   drivers/hwtracing/Kconfig        |   2 +
>>   drivers/hwtracing/ptt/Kconfig    |  12 +
>>   drivers/hwtracing/ptt/Makefile   |   2 +
>>   drivers/hwtracing/ptt/hisi_ptt.c | 964 +++++++++++++++++++++++++++++++
>>   drivers/hwtracing/ptt/hisi_ptt.h | 178 ++++++
>>   6 files changed, 1159 insertions(+)
>>   create mode 100644 drivers/hwtracing/ptt/Kconfig
>>   create mode 100644 drivers/hwtracing/ptt/Makefile
>>   create mode 100644 drivers/hwtracing/ptt/hisi_ptt.c
>>   create mode 100644 drivers/hwtracing/ptt/hisi_ptt.h
>>

[...]

>> +static int hisi_ptt_cpu_teardown(unsigned int cpu, struct hlist_node *node)
>> +{
>> +    struct hisi_ptt *hisi_ptt;
>> +    int target, src;
>> +
>> +    hisi_ptt = hlist_entry_safe(node, struct hisi_ptt, hotplug_node);
>> +    src = hisi_ptt->trace_ctrl.on_cpu;
>> +
>> +    if (!hisi_ptt->trace_ctrl.started || src != cpu)
>> +        return 0;
>> +
>> +    target = cpumask_any(cpumask_of_node(dev_to_node(&hisi_ptt->pdev->dev)));
>> +    if (target < nr_cpumask_bits) {
> 
> the comment for cpumask_any() hints to check against nr_cpu_ids - any specific reason to check against nr_cpumask_bits?
> 

here should be:
	if (target >= nr_cpumask_bits) {

will fix this up.

>> +        dev_err(hisi_ptt->hisi_ptt_pmu.dev, "no available cpu for perf context migration\n");
>> +        return 0;
>> +    }
>> +
>> +    perf_pmu_migrate_context(&hisi_ptt->hisi_ptt_pmu, src, target);
>> +    WARN_ON(irq_set_affinity(pci_irq_vector(hisi_ptt->pdev, HISI_PTT_TRACE_DMA_IRQ),
>> +                 cpumask_of(cpu)));
>> +    hisi_ptt->trace_ctrl.on_cpu = target;
>> +
>> +    return 0;
>> +}
>> +
>> +static int __init hisi_ptt_init(void)
>> +{
>> +    int ret;
>> +
>> +    ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN, DRV_NAME, NULL,
>> +                      hisi_ptt_cpu_teardown);
>> +    if (ret < 0)
>> +        return ret;
>> +    hisi_ptt_pmu_online = ret;
>> +
>> +    ret = pci_register_driver(&hisi_ptt_driver);
>> +    if (ret)
>> +        cpuhp_remove_multi_state(hisi_ptt_pmu_online);
>> +
>> +    return ret;
>> +}
>> +module_init(hisi_ptt_init);
>> +
>> +static void __exit hisi_ptt_exit(void)
>> +{
>> +    pci_unregister_driver(&hisi_ptt_driver);
>> +    cpuhp_remove_multi_state(hisi_ptt_pmu_online);
>> +}
>> +module_exit(hisi_ptt_exit);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("Yicong Yang <yangyicong@hisilicon.com>");
>> +MODULE_DESCRIPTION("Driver for HiSilicon PCIe tune and trace device");
>> diff --git a/drivers/hwtracing/ptt/hisi_ptt.h b/drivers/hwtracing/ptt/hisi_ptt.h
>> new file mode 100644
>> index 000000000000..2344e4195648
>> --- /dev/null
>> +++ b/drivers/hwtracing/ptt/hisi_ptt.h
>> @@ -0,0 +1,178 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Driver for HiSilicon PCIe tune and trace device
>> + *
>> + * Copyright (c) 2022 HiSilicon Technologies Co., Ltd.
>> + * Author: Yicong Yang <yangyicong@hisilicon.com>
>> + */
>> +
>> +#ifndef _HISI_PTT_H
>> +#define _HISI_PTT_H
>> +
>> +#include <linux/bits.h>
>> +#include <linux/cpumask.h>
>> +#include <linux/list.h>
>> +#include <linux/pci.h>
>> +#include <linux/perf_event.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/types.h>
>> +
>> +#define DRV_NAME "hisi_ptt"
>> +
>> +/*
>> + * The definition of the device registers and register fields.
>> + */
>> +#define HISI_PTT_TRACE_ADDR_SIZE    0x0800
>> +#define HISI_PTT_TRACE_ADDR_BASE_LO_0    0x0810
>> +#define HISI_PTT_TRACE_ADDR_BASE_HI_0    0x0814
>> +#define HISI_PTT_TRACE_ADDR_STRIDE    0x8
>> +#define HISI_PTT_TRACE_CTRL        0x0850
>> +#define   HISI_PTT_TRACE_CTRL_EN    BIT(0)
>> +#define   HISI_PTT_TRACE_CTRL_RST    BIT(1)
>> +#define   HISI_PTT_TRACE_CTRL_RXTX_SEL    GENMASK(3, 2)
>> +#define   HISI_PTT_TRACE_CTRL_TYPE_SEL    GENMASK(7, 4)
>> +#define   HISI_PTT_TRACE_CTRL_DATA_FORMAT    BIT(14)
>> +#define   HISI_PTT_TRACE_CTRL_FILTER_MODE    BIT(15)
>> +#define   HISI_PTT_TRACE_CTRL_TARGET_SEL    GENMASK(31, 16)
>> +#define HISI_PTT_TRACE_INT_STAT        0x0890
>> +#define   HISI_PTT_TRACE_INT_STAT_MASK    GENMASK(3, 0)
>> +#define HISI_PTT_TRACE_INT_MASK        0x0894
>> +#define HISI_PTT_TRACE_WR_STS        0x08a0
>> +#define   HISI_PTT_TRACE_WR_STS_WRITE    GENMASK(27, 0)
>> +#define   HISI_PTT_TRACE_WR_STS_BUFFER    GENMASK(29, 28)
>> +#define HISI_PTT_TRACE_STS        0x08b0
>> +#define   HISI_PTT_TRACE_IDLE        BIT(0)
>> +#define HISI_PTT_DEVICE_RANGE        0x0fe0
>> +#define   HISI_PTT_DEVICE_RANGE_UPPER    GENMASK(31, 16)
>> +#define   HISI_PTT_DEVICE_RANGE_LOWER    GENMASK(15, 0)
>> +#define HISI_PTT_LOCATION        0x0fe8
>> +#define   HISI_PTT_CORE_ID        GENMASK(15, 0)
>> +#define   HISI_PTT_SICL_ID        GENMASK(31, 16)
>> +
>> +/* Parameters of PTT trace DMA part. */
>> +#define HISI_PTT_TRACE_DMA_IRQ            0
>> +#define HISI_PTT_TRACE_BUF_CNT            4
>> +#define HISI_PTT_TRACE_BUF_SIZE            SZ_4M
>> +#define HISI_PTT_TRACE_TOTAL_BUF_SIZE        (HISI_PTT_TRACE_BUF_SIZE * \
>> +                         HISI_PTT_TRACE_BUF_CNT)
>> +/* Wait time for hardware DMA to reset */
>> +#define HISI_PTT_RESET_TIMEOUT_US    10UL
>> +#define HISI_PTT_RESET_POLL_INTERVAL_US    1UL
>> +/* Poll timeout and interval for waiting hardware work to finish */
>> +#define HISI_PTT_WAIT_TRACE_TIMEOUT_US    100UL
>> +#define HISI_PTT_WAIT_POLL_INTERVAL_US    10UL
>> +
>> +#define HISI_PCIE_CORE_PORT_ID(devfn)    (PCI_FUNC(devfn) << 1)
>> +
>> +/* Definition of the PMU configs */
>> +#define HISI_PTT_PMU_FILTER_IS_PORT    BIT(19)
>> +#define HISI_PTT_PMU_FILTER_VAL_MASK    GENMASK(15, 0)
>> +#define HISI_PTT_PMU_DIRECTION_MASK    GENMASK(23, 20)
>> +#define HISI_PTT_PMU_TYPE_MASK        GENMASK(31, 24)
>> +#define HISI_PTT_PMU_FORMAT_MASK    GENMASK(35, 32)
>> +
>> +/**
>> + * struct hisi_ptt_dma_buffer - Describe a single trace buffer of PTT trace.
>> + *                              The detail of the data format is described
>> + *                              in the documentation of PTT device.
>> + * @dma:   DMA address of this buffer visible to the device
>> + * @addr:  virtual address of this buffer visible to the cpu
>> + */
>> +struct hisi_ptt_dma_buffer {
>> +    dma_addr_t dma;
>> +    void *addr;
>> +};
>> +
>> +/**
>> + * struct hisi_ptt_trace_ctrl - Control and status of PTT trace
>> + * @trace_buf: array of the trace buffers for holding the trace data.
>> + *             the length will be HISI_PTT_TRACE_BUF_CNT.
>> + * @handle:    perf output handle of current trace session
>> + * @buf_index: the index of current using trace buffer
>> + * @on_cpu:    current tracing cpu
>> + * @started:   current trace status, true for started
>> + * @is_port:   whether we're tracing root port or not
>> + * @direction: direction of the TLP headers to trace
>> + * @filter:    filter value for tracing the TLP headers
>> + * @format:    format of the TLP headers to trace
>> + * @type:      type of the TLP headers to trace
>> + */
>> +struct hisi_ptt_trace_ctrl {
>> +    struct hisi_ptt_dma_buffer *trace_buf;
>> +    struct perf_output_handle handle;
>> +    u32 buf_index;
>> +    int on_cpu;
>> +    bool started;
>> +    bool is_port;
>> +    u32 direction:2;
>> +    u32 filter:16;
>> +    u32 format:1;
>> +    u32 type:4;
>> +};
>> +
>> +/**
>> + * struct hisi_ptt_filter_desc - Descriptor of the PTT trace filter
>> + * @list:    entry of this descriptor in the filter list
>> + * @is_port: the PCI device of the filter is a Root Port or not
>> + * @devid:   the PCI device's devid of the filter
>> + */
>> +struct hisi_ptt_filter_desc {
>> +    struct list_head list;
>> +    bool is_port;
>> +    u16 devid;
>> +};
>> +
>> +
>> +/**
>> + * struct hisi_ptt_pmu_buf - Descriptor of the AUX buffer of PTT trace
>> + * @length:   size of the AUX buffer
>> + * @nr_pages: number of pages of the AUX buffer
>> + * @base:     start address of AUX buffer
>> + * @pos:      position in the AUX buffer to commit traced data
>> + */
>> +struct hisi_ptt_pmu_buf {
>> +    size_t length;
>> +    int nr_pages;
>> +    void *base;
>> +    long pos;
>> +};
>> +
>> +/**
>> + * struct hisi_ptt - Per PTT device data
>> + * @trace_ctrl:   the control information of PTT trace
>> + * @hotplug_node: node for register cpu hotplug event
>> + * @hisi_ptt_pmu: the pum device of trace
>> + * @iobase:       base IO address of the device
>> + * @pdev:         pci_dev of this PTT device
>> + * @pmu_lock:     lock to serialize the perf process
>> + * @upper_bdf:    the upper BDF range of the PCI devices managed by this PTT device
>> + * @lower_bdf:    the lower BDF range of the PCI devices managed by this PTT device
>> + * @port_filters: the filter list of root ports
>> + * @req_filters:  the filter list of requester ID
>> + * @port_mask:    port mask of the managed root ports
>> + */
>> +struct hisi_ptt {
>> +    struct hisi_ptt_trace_ctrl trace_ctrl;
>> +    struct hlist_node hotplug_node;
>> +    struct pmu hisi_ptt_pmu;
>> +    void __iomem *iobase;
>> +    struct pci_dev *pdev;
>> +    spinlock_t pmu_lock;
>> +    u32 upper_bdf;
>> +    u32 lower_bdf;
>> +
>> +    /*
>> +     * The trace TLP headers can either be filtered by certain
>> +     * root port, or by the requester ID. Organize the filters
>> +     * by @port_filters and @req_filters here. The mask of all
>> +     * the valid ports is also cached for doing sanity check
>> +     * of user input.
>> +     */
>> +    struct list_head port_filters;
>> +    struct list_head req_filters;
>> +    u16 port_mask;
>> +};
>> +
>> +#define to_hisi_ptt(pmu) container_of(pmu, struct hisi_ptt, hisi_ptt_pmu)
>> +
>> +#endif /* _HISI_PTT_H */
> 
> .

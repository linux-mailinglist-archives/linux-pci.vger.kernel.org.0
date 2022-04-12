Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B69C4FDB8F
	for <lists+linux-pci@lfdr.de>; Tue, 12 Apr 2022 12:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238210AbiDLKE7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Apr 2022 06:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353470AbiDLIDr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2022 04:03:47 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A0D583BF;
        Tue, 12 Apr 2022 00:36:12 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KcyCd4dRxzgYgl;
        Tue, 12 Apr 2022 15:34:21 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Apr 2022 15:36:10 +0800
CC:     <prime.zeng@huawei.com>, <liuqi115@huawei.com>,
        <zhangshaokun@hisilicon.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH v7 2/7] hwtracing: Add trace function support for
 HiSilicon PCIe Tune and Trace device
To:     John Garry <john.garry@huawei.com>,
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
References: <20220407125841.3678-1-yangyicong@hisilicon.com>
 <20220407125841.3678-3-yangyicong@hisilicon.com>
 <36eea2f6-3461-72ad-05c4-953484197911@huawei.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <60159327-7b6c-38cc-97a9-bb4c594b494f@huawei.com>
Date:   Tue, 12 Apr 2022 15:36:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <36eea2f6-3461-72ad-05c4-953484197911@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi John,

Thanks for the comments! some questions replied below.

On 2022/4/12 1:02, John Garry wrote:
> On 07/04/2022 13:58, Yicong Yang wrote:
>> HiSilicon PCIe tune and trace device(PTT) is a PCIe Root Complex integrated
>> Endpoint(RCiEP) device, providing the capability to dynamically monitor and
>> tune the PCIe traffic, and trace the TLP headers.
>>
>> Add the driver for the device to enable the trace function. Register PMU
>> device of PTT trace, then users can use trace through perf command. The
>> driver makes use of perf AUX trace and support following events to
> 
> "The driver makes use of perf AUX trace function and supports the following events to .."
> 
>> configure the trace:
>>
>> - filter: select Root port or Endpoint to trace
>> - type: select the type of traced TLP headers
>> - direction: select the direction of traced TLP headers
>> - format: select the data format of the traced TLP headers
>>
>> This patch adds the driver part of PTT trace. The perf command support of
>> PTT trace is added in the following patch.
> 
> I would not mention "following patch" and the like. Just have "initially add a basic driver"
> 

ok. will refine the commit here and above.

>>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>   drivers/Makefile                 |   1 +
>>   drivers/hwtracing/Kconfig        |   2 +
>>   drivers/hwtracing/ptt/Kconfig    |  12 +
>>   drivers/hwtracing/ptt/Makefile   |   2 +
>>   drivers/hwtracing/ptt/hisi_ptt.c | 874 +++++++++++++++++++++++++++++++
>>   drivers/hwtracing/ptt/hisi_ptt.h | 166 ++++++
>>   6 files changed, 1057 insertions(+)
>>   create mode 100644 drivers/hwtracing/ptt/Kconfig
>>   create mode 100644 drivers/hwtracing/ptt/Makefile
>>   create mode 100644 drivers/hwtracing/ptt/hisi_ptt.c
>>   create mode 100644 drivers/hwtracing/ptt/hisi_ptt.h
>>
>> diff --git a/drivers/Makefile b/drivers/Makefile
>> index 020780b6b4d2..662d50599467 100644
>> --- a/drivers/Makefile
>> +++ b/drivers/Makefile
>> @@ -175,6 +175,7 @@ obj-$(CONFIG_USB4)        += thunderbolt/
>>   obj-$(CONFIG_CORESIGHT)        += hwtracing/coresight/
>>   obj-y                += hwtracing/intel_th/
>>   obj-$(CONFIG_STM)        += hwtracing/stm/
>> +obj-$(CONFIG_HISI_PTT)        += hwtracing/ptt/
>>   obj-$(CONFIG_ANDROID)        += android/
>>   obj-$(CONFIG_NVMEM)        += nvmem/
>>   obj-$(CONFIG_FPGA)        += fpga/
>> diff --git a/drivers/hwtracing/Kconfig b/drivers/hwtracing/Kconfig
>> index 13085835a636..911ee977103c 100644
>> --- a/drivers/hwtracing/Kconfig
>> +++ b/drivers/hwtracing/Kconfig
>> @@ -5,4 +5,6 @@ source "drivers/hwtracing/stm/Kconfig"
>>     source "drivers/hwtracing/intel_th/Kconfig"
>>   +source "drivers/hwtracing/ptt/Kconfig"
>> +
>>   endmenu
>> diff --git a/drivers/hwtracing/ptt/Kconfig b/drivers/hwtracing/ptt/Kconfig
>> new file mode 100644
>> index 000000000000..8902a6f27563
>> --- /dev/null
>> +++ b/drivers/hwtracing/ptt/Kconfig
>> @@ -0,0 +1,12 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +config HISI_PTT
>> +    tristate "HiSilicon PCIe Tune and Trace Device"
>> +    depends on ARM64 || (COMPILE_TEST && 64BIT)
>> +    depends on PCI && HAS_DMA && HAS_IOMEM && PERF_EVENTS
>> +    help
>> +      HiSilicon PCIe Tune and Trace Device exists as a PCIe RCiEP
>> +      device, and it provides support for PCIe traffic tuning and
>> +      tracing TLP headers to the memory.
>> +
>> +      This driver can also be built as a module. If so, the module
>> +      will be called hisi_ptt.
>> diff --git a/drivers/hwtracing/ptt/Makefile b/drivers/hwtracing/ptt/Makefile
>> new file mode 100644
>> index 000000000000..908c09a98161
>> --- /dev/null
>> +++ b/drivers/hwtracing/ptt/Makefile
>> @@ -0,0 +1,2 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +obj-$(CONFIG_HISI_PTT) += hisi_ptt.o
>> diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
>> new file mode 100644
>> index 000000000000..242b41870380
>> --- /dev/null
>> +++ b/drivers/hwtracing/ptt/hisi_ptt.c
>> @@ -0,0 +1,874 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Driver for HiSilicon PCIe tune and trace device
>> + *
>> + * Copyright (c) 2022 HiSilicon Technologies Co., Ltd.
>> + * Author: Yicong Yang <yangyicong@hisilicon.com>
>> + */
>> +
>> +#include <linux/bitfield.h>
>> +#include <linux/bitops.h>
>> +#include <linux/delay.h>
>> +#include <linux/dma-iommu.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/iommu.h>
>> +#include <linux/iopoll.h>
>> +#include <linux/module.h>
>> +#include <linux/sysfs.h>
>> +#include <linux/vmalloc.h>
>> +
>> +#include "hisi_ptt.h"
>> +
>> +static u16 hisi_ptt_get_filter_val(struct pci_dev *pdev)
>> +{
>> +    if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT)
>> +        return BIT(HISI_PCIE_CORE_PORT_ID(PCI_SLOT(pdev->devfn)));
>> +
>> +    return PCI_DEVID(pdev->bus->number, pdev->devfn);
>> +}
>> +
>> +static bool hisi_ptt_wait_trace_hw_idle(struct hisi_ptt *hisi_ptt)
>> +{
>> +    u32 val;
>> +
>> +    return !readl_poll_timeout_atomic(hisi_ptt->iobase + HISI_PTT_TRACE_STS,
>> +                      val, val & HISI_PTT_TRACE_IDLE,
>> +                      HISI_PTT_WAIT_POLL_INTERVAL_US,
>> +                      HISI_PTT_WAIT_TRACE_TIMEOUT_US);
>> +}
>> +
>> +static bool hisi_ptt_wait_dma_reset_done(struct hisi_ptt *hisi_ptt)
>> +{
>> +    u32 val;
>> +
>> +    return !readl_poll_timeout_atomic(hisi_ptt->iobase + HISI_PTT_TRACE_WR_STS,
>> +                      val, !val, HISI_PTT_RESET_POLL_INTERVAL_US,
>> +                      HISI_PTT_RESET_TIMEOUT_US);
>> +}
>> +
>> +static void hisi_ptt_free_trace_buf(struct hisi_ptt *hisi_ptt)
>> +{
>> +    struct hisi_ptt_trace_ctrl *ctrl = &hisi_ptt->trace_ctrl;
>> +    struct device *dev = &hisi_ptt->pdev->dev;
>> +    int i;
>> +
>> +    if (!ctrl->trace_buf)
>> +        return;
>> +
>> +    for (i = 0; i < HISI_PTT_TRACE_BUF_CNT; i++) {
>> +        if (ctrl->trace_buf[i].addr)
>> +            dmam_free_coherent(dev, HISI_PTT_TRACE_BUF_SIZE,
>> +                       ctrl->trace_buf[i].addr,
>> +                       ctrl->trace_buf[i].dma);
>> +    }
>> +
>> +    devm_kfree(dev, ctrl->trace_buf);
>> +    ctrl->trace_buf = NULL;
>> +}
>> +
>> +static int hisi_ptt_alloc_trace_buf(struct hisi_ptt *hisi_ptt)
>> +{
>> +    struct hisi_ptt_trace_ctrl *ctrl = &hisi_ptt->trace_ctrl;
>> +    struct device *dev = &hisi_ptt->pdev->dev;
>> +    int i;
>> +
>> +    hisi_ptt->trace_ctrl.buf_index = 0;
>> +
>> +    /* If the trace buffer has already been allocated, zero it. */
> 
> I am not sure why this is not called from the probe
> 

The buffer allocation is done when necessary as driver will probe the device on booting but
the user may never use it. In this condition it's a waste of memory if we allocate the buffers
in probe. Currently we'll allocate 16M memory for 4 buffers.

So this function is called every time before we start trace. In the first time it will allocate
the DMA buffers and it the other times it just zero the buffers to clear the data of last time.

>> +    if (ctrl->trace_buf) {
>> +        for (i = 0; i < HISI_PTT_TRACE_BUF_CNT; i++)
>> +            memset(ctrl->trace_buf[i].addr, 0, HISI_PTT_TRACE_BUF_SIZE);
>> +        return 0;
>> +    }
>> +
>> +    ctrl->trace_buf = devm_kcalloc(dev, HISI_PTT_TRACE_BUF_CNT,
>> +                       sizeof(struct hisi_ptt_dma_buffer), GFP_KERNEL);
> 
> sizeof(*ctrl->trace_buf) may be better
>

ok.

>> +    if (!ctrl->trace_buf)
>> +        return -ENOMEM;
>> +
>> +    for (i = 0; i < HISI_PTT_TRACE_BUF_CNT; ++i) {
>> +        ctrl->trace_buf[i].addr = dmam_alloc_coherent(dev, HISI_PTT_TRACE_BUF_SIZE,
>> +                                 &ctrl->trace_buf[i].dma,
>> +                                 GFP_KERNEL);
>> +        if (!ctrl->trace_buf[i].addr) {
>> +            hisi_ptt_free_trace_buf(hisi_ptt);
>> +            return -ENOMEM;
>> +        }
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static void hisi_ptt_trace_end(struct hisi_ptt *hisi_ptt)
>> +{
>> +    writel(0, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
>> +    hisi_ptt->trace_ctrl.started = false;
>> +}
>> +
>> +static int hisi_ptt_trace_start(struct hisi_ptt *hisi_ptt)
>> +{
>> +    struct hisi_ptt_trace_ctrl *ctrl = &hisi_ptt->trace_ctrl;
>> +    u32 val;
>> +    int i;
>> +
>> +    /* Check device idle before start trace */
>> +    if (!hisi_ptt_wait_trace_hw_idle(hisi_ptt)) {
>> +        pci_err(hisi_ptt->pdev, "Failed to start trace, the device is still busy\n");
>> +        return -EBUSY;
>> +    }
>> +
>> +    ctrl->started = true;
>> +
>> +    /* Reset the DMA before start tracing */
>> +    val = readl(hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
>> +    val |= HISI_PTT_TRACE_CTRL_RST;
>> +    writel(val, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
>> +
>> +    hisi_ptt_wait_dma_reset_done(hisi_ptt);
>> +
>> +    val = readl(hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
>> +    val &= ~HISI_PTT_TRACE_CTRL_RST;
>> +    writel(val, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
>> +
>> +    /* Clear the interrupt status */
>> +    writel(HISI_PTT_TRACE_INT_STAT_MASK, hisi_ptt->iobase + HISI_PTT_TRACE_INT_STAT);
>> +    writel(0, hisi_ptt->iobase + HISI_PTT_TRACE_INT_MASK);
>> +
>> +    /* Configure the trace DMA buffer */
> 
> I am not sure why this sort of thing is done outside probing
> 

Since the buffers are allocated on necessary as illustrated above, we cannot configure the
buffer address in probe. As illustrated above.

>> +    for (i = 0; i < HISI_PTT_TRACE_BUF_CNT; i++) {
>> +        writel(lower_32_bits(ctrl->trace_buf[i].dma),
>> +               hisi_ptt->iobase + HISI_PTT_TRACE_ADDR_BASE_LO_0 +
>> +               i * HISI_PTT_TRACE_ADDR_STRIDE);
>> +        writel(upper_32_bits(ctrl->trace_buf[i].dma),
>> +               hisi_ptt->iobase + HISI_PTT_TRACE_ADDR_BASE_HI_0 +
>> +               i * HISI_PTT_TRACE_ADDR_STRIDE);
>> +    }
>> +    writel(HISI_PTT_TRACE_BUF_SIZE, hisi_ptt->iobase + HISI_PTT_TRACE_ADDR_SIZE);
>> +
>> +    /* Set the trace control register */
>> +    val = FIELD_PREP(HISI_PTT_TRACE_CTRL_TYPE_SEL, ctrl->type);
>> +    val |= FIELD_PREP(HISI_PTT_TRACE_CTRL_RXTX_SEL, ctrl->direction);
>> +    val |= FIELD_PREP(HISI_PTT_TRACE_CTRL_DATA_FORMAT, ctrl->format);
>> +    val |= FIELD_PREP(HISI_PTT_TRACE_CTRL_TARGET_SEL, hisi_ptt->trace_ctrl.filter);
>> +    if (!hisi_ptt->trace_ctrl.is_port)
>> +        val |= HISI_PTT_TRACE_CTRL_FILTER_MODE;
>> +
>> +    /* Start the Trace */
>> +    val |= HISI_PTT_TRACE_CTRL_EN;
>> +    writel(val, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
>> +
>> +    return 0;
>> +}
[...]
>> +static ssize_t available_root_port_filters_show(struct device *dev,
>> +                        struct device_attribute *attr,
>> +                        char *buf)
>> +{
>> +    struct hisi_ptt *hisi_ptt = to_hisi_ptt(dev_get_drvdata(dev));
>> +    struct hisi_ptt_filter_desc *filter;
>> +    int pos = 0;
>> +
>> +    mutex_lock(&hisi_ptt->mutex);
>> +    if (list_empty(&hisi_ptt->port_filters)) {
>> +        pos = sysfs_emit(buf, "\n");
>> +        goto out;
>> +    }
>> +
>> +    list_for_each_entry(filter, &hisi_ptt->port_filters, list)
>> +        pos += sysfs_emit_at(buf, pos, "%s    0x%05lx\n",
> 
> \t can be used for a formatting tab
> 

actually I used a tab here. maybe I can make it obvious like:

       pos += sysfs_emit_at(buf, pos, "%s\t0x%05lx\n",

>> +                     pci_name(filter->pdev),
>> +                     hisi_ptt_get_filter_val(filter->pdev) |
>> +                     HISI_PTT_PMU_FILTER_IS_PORT);
>> +
>> +out:
>> +    mutex_unlock(&hisi_ptt->mutex);
>> +    return pos;
>> +}
>> +static DEVICE_ATTR_ADMIN_RO(available_root_port_filters);
>> +
>> +static ssize_t available_requester_filters_show(struct device *dev,
>> +                        struct device_attribute *attr,
>> +                        char *buf)
>> +{
>> +    struct hisi_ptt *hisi_ptt = to_hisi_ptt(dev_get_drvdata(dev));
>> +    struct hisi_ptt_filter_desc *filter;
>> +    int pos = 0;
>> +
>> +    mutex_lock(&hisi_ptt->mutex);
>> +    if (list_empty(&hisi_ptt->req_filters)) {
>> +        pos = sysfs_emit(buf, "\n");
>> +        goto out;
>> +    }
>> +
>> +    list_for_each_entry(filter, &hisi_ptt->req_filters, list)
>> +        pos += sysfs_emit_at(buf, pos, "%s    0x%05x\n",
>> +                     pci_name(filter->pdev),
>> +                     hisi_ptt_get_filter_val(filter->pdev));
>> +
>> +out:
>> +    mutex_unlock(&hisi_ptt->mutex);
>> +    return pos;
>> +}
>> +static DEVICE_ATTR_ADMIN_RO(available_requester_filters);
>> +
>> +PMU_FORMAT_ATTR(filter,        "config:0-19");
>> +PMU_FORMAT_ATTR(direction,    "config:20-23");
>> +PMU_FORMAT_ATTR(type,        "config:24-31");
>> +PMU_FORMAT_ATTR(format,        "config:32-35");
>> +
>> +static struct attribute *hisi_ptt_pmu_format_attrs[] = {
>> +    &format_attr_filter.attr,
>> +    &format_attr_direction.attr,
>> +    &format_attr_type.attr,
>> +    &format_attr_format.attr,
>> +    NULL
>> +};
>> +
>> +static struct attribute_group hisi_ptt_pmu_format_group = {
>> +    .name = "format",
>> +    .attrs = hisi_ptt_pmu_format_attrs,
>> +};
>> +
>> +static struct attribute *hisi_ptt_pmu_filter_attrs[] = {
>> +    &dev_attr_available_root_port_filters.attr,
>> +    &dev_attr_available_requester_filters.attr,
>> +    NULL
>> +};
>> +
>> +static struct attribute_group hisi_ptt_pmu_filter_group = {
>> +    .attrs = hisi_ptt_pmu_filter_attrs,
>> +};
>> +
>> +static const struct attribute_group *hisi_ptt_pmu_groups[] = {
>> +    &hisi_ptt_pmu_format_group,
>> +    &hisi_ptt_pmu_filter_group,
>> +    NULL
>> +};
>> +
>> +/*
>> + * Check whether the config is valid or not. Some configs are multi-selectable
>> + * and can be set simultaneously, while some are single selectable (onehot).
>> + * Use this function to check the non-onehot configs while
>> + * hisi_ptt_trace_valid_config_onehot() for the onehot ones.
>> + */
>> +static int hisi_ptt_trace_valid_config(u32 val, const u32 *available_list, u32 list_size)
>> +{
>> +    int i;
>> +
>> +    /* The non-onehot configs cannot be 0. */
>> +    if (!val)
>> +        return -EINVAL;
>> +
>> +    /*
>> +     * Walk the available list and clear the valid bits of
>> +     * the config. If there is any resident bit after the
>> +     * walk then the config is invalid.
>> +     */
>> +    for (i = 0; i < list_size; i++)
>> +        val &= ~available_list[i];
>> +
>> +    return val ? -EINVAL : 0;
>> +}
>> +
>> +static int hisi_ptt_trace_valid_config_onehot(u32 val, const u32 *available_list, u32 list_size)
> 
> line too long
> 

will wrap it.

>> +{
>> +    int i;
>> +
>> +    for (i = 0; i < list_size; i++)
>> +        if (val == available_list[i])
>> +            return 0;
>> +
>> +    return -EINVAL;
>> +}
>> +
>> +static int hisi_ptt_trace_init_filter(struct hisi_ptt *hisi_ptt, u64 config)
>> +{
>> +    unsigned long val, port_mask = hisi_ptt->port_mask;
>> +    struct hisi_ptt_filter_desc *filter;
>> +    int ret = -EINVAL;
>> +
>> +    hisi_ptt->trace_ctrl.is_port = FIELD_GET(HISI_PTT_PMU_FILTER_IS_PORT, config);
>> +    val = FIELD_GET(HISI_PTT_PMU_FILTER_VAL_MASK, config);
>> +
>> +    /*
>> +     * Port filters are defined as bit mask. For port filters, check
>> +     * the bits in the @val are within the range of hisi_ptt->port_mask
>> +     * and whether it's empty or not, otherwise user has specified
>> +     * some unsupported root ports.
>> +     *
>> +     * For Requester ID filters, walk the available filter list to see
>> +     * whether we have one matched.
>> +     */
>> +    if (!hisi_ptt->trace_ctrl.is_port) {
>> +        list_for_each_entry(filter, &hisi_ptt->req_filters, list)
> 
> 
> use {} for this as well. the formatting looks strange
> 

ok.

>> +            if (val == hisi_ptt_get_filter_val(filter->pdev)) {
>> +                ret = 0;
>> +                break;
>> +            }
>> +    } else if (bitmap_subset(&val, &port_mask, BITS_PER_LONG)) {
>> +        ret = 0;
>> +    }
>> +
>> +    if (ret)
>> +        return ret;
>> +
>> +    hisi_ptt->trace_ctrl.filter = val;
>> +    return 0;
>> +}
>> +
>> +static int hisi_ptt_pmu_event_init(struct perf_event *event)
>> +{
>> +    /*
>> +     * The supported value of the direction parameter. See hisi_ptt.rst
>> +     * documentation for more details.
>> +     */
>> +    static const u32 hisi_ptt_trace_available_direction[] = {
>> +        0,
>> +        1,
>> +        2,
>> +        3,
>> +    };
>> +    /* Different types can be set simultaneously */
>> +    static const u32 hisi_ptt_trace_available_type[] = {
>> +        1,    /* posted_request */
>> +        2,    /* non-posted_request */
>> +        4,    /* completion */
>> +    };
>> +    static const u32 hisi_ptt_trace_availble_format[] = {
>> +        0,    /* 4DW */
>> +        1,    /* 8DW */
>> +    };
>> +    struct hisi_ptt *hisi_ptt = to_hisi_ptt(event->pmu);
>> +    struct hisi_ptt_trace_ctrl *ctrl = &hisi_ptt->trace_ctrl;
>> +    int ret;
>> +    u32 val;
>> +
>> +    if (event->attr.type != hisi_ptt->hisi_ptt_pmu.type)
>> +        return -ENOENT;
>> +
>> +    mutex_lock(&hisi_ptt->mutex);
>> +
>> +    ret = hisi_ptt_trace_init_filter(hisi_ptt, event->attr.config);
>> +    if (ret < 0)
>> +        goto out;
>> +
>> +    val = FIELD_GET(HISI_PTT_PMU_DIRECTION_MASK, event->attr.config);
>> +    ret = hisi_ptt_trace_valid_config_onehot(val, hisi_ptt_trace_available_direction,
> 
> how about put all those arrays in hisi_ptt_trace_valid_config_onehot() and pass some flag to say which array you want to use? Or something like that. Passing the arrays in this fashion is messy
> 

Since there are 3 configs (type, direction, format) with different available range and setting method (onehot, non-onehot),
moving the arrays into the valid checking function means we need to recognize the config types (passed by the caller but need
to know the available value array) and the checking method together. That may make the code more complex than now: 1st picking
up the right array and judge wich checking method this array applied and 2nd do the checking.

Currently it's designed to decouple the checking method and the available value array. The hisi_ptt_trace_valid_config{_onehot}()
won't care about which array to use since caller take responsibilty for this. So perhaps current approach is simple and clear
enough.

> 
>> +                         ARRAY_SIZE(hisi_ptt_trace_available_direction));
>> +    if (ret < 0)
>> +        goto out;
>> +    ctrl->direction = val;
>> +
>> +    val = FIELD_GET(HISI_PTT_PMU_TYPE_MASK, event->attr.config);
>> +    ret = hisi_ptt_trace_valid_config(val, hisi_ptt_trace_available_type,
>> +                      ARRAY_SIZE(hisi_ptt_trace_available_type));
>> +    if (ret < 0)
>> +        goto out;
>> +    ctrl->type = val;
>> +
>> +    val = FIELD_GET(HISI_PTT_PMU_FORMAT_MASK, event->attr.config);
>> +    ret = hisi_ptt_trace_valid_config_onehot(val, hisi_ptt_trace_availble_format,
>> +                         ARRAY_SIZE(hisi_ptt_trace_availble_format));
>> +    if (ret < 0)
>> +        goto out;
>> +    ctrl->format = val;
>> +
>> +out:
>> +    mutex_unlock(&hisi_ptt->mutex);
>> +    return ret;
>> +}
>> +
>> +static void *hisi_ptt_pmu_setup_aux(struct perf_event *event, void **pages,
>> +                    int nr_pages, bool overwrite)
>> +{
>> +    struct hisi_ptt_pmu_buf *buf;
>> +    struct page **pagelist;
>> +    int i;
>> +
>> +    if (overwrite) {
>> +        dev_warn(event->pmu->dev, "Overwrite mode is not supported\n");
>> +        return NULL;
>> +    }
>> +
>> +    /* If the pages size less than buffers, we cannot start trace */
>> +    if (nr_pages < HISI_PTT_TRACE_TOTAL_BUF_SIZE / PAGE_SIZE)
>> +        return NULL;
>> +
>> +    buf = kzalloc(sizeof(*buf), GFP_KERNEL);
>> +    if (!buf)
>> +        return NULL;
>> +
>> +    pagelist = kcalloc(nr_pages, sizeof(*pagelist), GFP_KERNEL);
>> +    if (!pagelist) {
>> +        kfree(buf);
>> +        return NULL;
>> +    }
>> +
>> +    for (i = 0; i < nr_pages; i++)
>> +        pagelist[i] = virt_to_page(pages[i]);
>> +
>> +    buf->base = vmap(pagelist, nr_pages, VM_MAP, PAGE_KERNEL);
>> +    if (!buf->base) {
>> +        kfree(pagelist);
>> +        kfree(buf);
>> +        return NULL;
>> +    }
>> +
>> +    buf->nr_pages = nr_pages;
>> +    buf->length = nr_pages * PAGE_SIZE;
>> +    buf->pos = 0;
>> +
>> +    kfree(pagelist);
>> +    return buf;
>> +}
>> +
>> +static void hisi_ptt_pmu_free_aux(void *aux)
>> +{
>> +    struct hisi_ptt_pmu_buf *buf = aux;
>> +
>> +    vunmap(buf->base);
>> +    kfree(buf);
>> +}
>> +
>> +static void hisi_ptt_pmu_start(struct perf_event *event, int flags)
>> +{
>> +    struct hisi_ptt *hisi_ptt = to_hisi_ptt(event->pmu);
>> +    struct perf_output_handle *handle = &hisi_ptt->trace_ctrl.handle;
>> +    struct hw_perf_event *hwc = &event->hw;
>> +    struct hisi_ptt_pmu_buf *buf;
>> +    int cpu = event->cpu;
>> +    int ret;
>> +
>> +    hwc->state = 0;
>> +    mutex_lock(&hisi_ptt->mutex);
>> +    if (hisi_ptt->trace_ctrl.started) {
>> +        pci_dbg(hisi_ptt->pdev, "trace has already started\n");
> 
> doesn't perf core guard against this sort of thing?
> 

Maybe not as tested. The perf core will start the events 1)on the cpus user specified or
2)on all the cpus, but the PTT trace is intended to start once on one cpu.

For the 2) case, the driver will make default cpu to start the trace and block others
in pmu::add(). For the 1) case we'll met the condition here. So the started status is
test here to avoid a second start.

>> +        goto stop;
>> +    }
>> +
>> +    if (cpu == -1)
>> +        cpu = hisi_ptt->trace_ctrl.default_cpu;
>> +
>> +    /*
>> +     * Handle the interrupt on the same cpu which starts the trace to avoid
>> +     * context mismatch. Otherwise we'll trigger the WARN from the perf
>> +     * core in event_function_local().
>> +     */
>> +    WARN_ON(irq_set_affinity(pci_irq_vector(hisi_ptt->pdev, HISI_PTT_TRACE_DMA_IRQ),
>> +                 cpumask_of(cpu)));
>> +
>> +    ret = hisi_ptt_alloc_trace_buf(hisi_ptt);
>> +    if (ret) {
>> +        pci_dbg(hisi_ptt->pdev, "alloc trace buf failed, ret = %d\n", ret);
>> +        goto stop;
>> +    }
>> +
>> +    buf = perf_aux_output_begin(handle, event);
>> +    if (!buf) {
>> +        pci_dbg(hisi_ptt->pdev, "aux output begin failed\n");
>> +        goto stop;
>> +    }
>> +
>> +    buf->pos = handle->head % buf->length;
>> +
>> +    ret = hisi_ptt_trace_start(hisi_ptt);
>> +    if (ret) {
>> +        pci_dbg(hisi_ptt->pdev, "trace start failed, ret = %d\n", ret);
>> +        perf_aux_output_end(handle, 0);
>> +        goto stop;
>> +    }
>> +
>> +    mutex_unlock(&hisi_ptt->mutex);
>> +    return;
>> +stop:
>> +    event->hw.state |= PERF_HES_STOPPED;
>> +    mutex_unlock(&hisi_ptt->mutex);
>> +}
>> +
>> +static void hisi_ptt_pmu_stop(struct perf_event *event, int flags)
>> +{
>> +    struct hisi_ptt *hisi_ptt = to_hisi_ptt(event->pmu);
>> +    struct hw_perf_event *hwc = &event->hw;
>> +
>> +    if (hwc->state & PERF_HES_STOPPED)
>> +        return;
>> +
>> +    mutex_lock(&hisi_ptt->mutex);
>> +    if (hisi_ptt->trace_ctrl.started) {
>> +        hisi_ptt_trace_end(hisi_ptt);
>> +        WARN(!hisi_ptt_wait_trace_hw_idle(hisi_ptt), "Device is still busy");
>> +        hisi_ptt_update_aux(hisi_ptt, hisi_ptt->trace_ctrl.buf_index, true);
>> +    }
>> +    mutex_unlock(&hisi_ptt->mutex);
>> +
>> +    hwc->state |= PERF_HES_STOPPED;
>> +    perf_event_update_userpage(event);
>> +    hwc->state |= PERF_HES_UPTODATE;
>> +}
>> +
>> +static int hisi_ptt_pmu_add(struct perf_event *event, int flags)
>> +{
>> +    struct hisi_ptt *hisi_ptt = to_hisi_ptt(event->pmu);
>> +    struct hw_perf_event *hwc = &event->hw;
>> +    int cpu = event->cpu;
>> +
>> +    /*
>> +     * Only allow the default cpu to add the event if user doesn't specify
>> +     * the cpus.
>> +     */
>> +    if (cpu == -1 && smp_processor_id() != hisi_ptt->trace_ctrl.default_cpu)
>> +        return 0;
>> +
>> +    hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
>> +
>> +    if (flags & PERF_EF_START) {
>> +        hisi_ptt_pmu_start(event, PERF_EF_RELOAD);
>> +        if (hwc->state & PERF_HES_STOPPED)
>> +            return -EINVAL;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static void hisi_ptt_pmu_del(struct perf_event *event, int flags)
>> +{
>> +    hisi_ptt_pmu_stop(event, PERF_EF_UPDATE);
>> +}
>> +
>> +static int hisi_ptt_register_pmu(struct hisi_ptt *hisi_ptt)
>> +{
>> +    u16 core_id, sicl_id;
>> +    char *pmu_name;
>> +    u32 reg;
>> +
>> +    hisi_ptt->hisi_ptt_pmu = (struct pmu) {
>> +        .module        = THIS_MODULE,
>> +        .capabilities    = PERF_PMU_CAP_EXCLUSIVE | PERF_PMU_CAP_ITRACE,
>> +        .task_ctx_nr    = perf_sw_context,
>> +        .attr_groups    = hisi_ptt_pmu_groups,
>> +        .event_init    = hisi_ptt_pmu_event_init,
>> +        .setup_aux    = hisi_ptt_pmu_setup_aux,
>> +        .free_aux    = hisi_ptt_pmu_free_aux,
>> +        .start        = hisi_ptt_pmu_start,
>> +        .stop        = hisi_ptt_pmu_stop,
>> +        .add        = hisi_ptt_pmu_add,
>> +        .del        = hisi_ptt_pmu_del,
>> +    };
>> +
>> +    reg = readl(hisi_ptt->iobase + HISI_PTT_LOCATION);
>> +    core_id = FIELD_GET(HISI_PTT_CORE_ID, reg);
>> +    sicl_id = FIELD_GET(HISI_PTT_SICL_ID, reg);
>> +
>> +    pmu_name = devm_kasprintf(&hisi_ptt->pdev->dev, GFP_KERNEL, "hisi_ptt%u_%u",
>> +                  sicl_id, core_id);
>> +    if (!pmu_name)
>> +        return -ENOMEM;
>> +
>> +    return perf_pmu_register(&hisi_ptt->hisi_ptt_pmu, pmu_name, -1);
>> +}
>> +
>> +/*
>> + * The DMA of PTT trace can only use direct mapping, due to some
>> + * hardware restriction. Check whether there is an IOMMU or the
>> + * policy of the IOMMU domain is passthrough, otherwise the trace
>> + * cannot work.
>> + *
>> + * The PTT device is supposed to behind the ARM SMMUv3, which
> 
> /s/ the ARM SMMUv3/an ARM SMMUv3/
> 
ok.
>> + * should have passthrough the device by a quirk.
>> + */
>> +static int hisi_ptt_check_iommu_mapping(struct pci_dev *pdev)
>> +{
>> +    struct iommu_domain *iommu_domain;
>> +
>> +    iommu_domain = iommu_get_domain_for_dev(&pdev->dev);
>> +    if (!iommu_domain || iommu_domain->type == IOMMU_DOMAIN_IDENTITY)
>> +        return 0;
>> +
>> +    return -EOPNOTSUPP;
>> +}
>> +
>> +static int hisi_ptt_probe(struct pci_dev *pdev,
>> +              const struct pci_device_id *id)
>> +{
>> +    struct hisi_ptt *hisi_ptt;
>> +    int ret;
>> +
>> +    ret = hisi_ptt_check_iommu_mapping(pdev);
>> +    if (ret) {
>> +        pci_err(pdev, "requires direct DMA mappings\n");
>> +        return ret;
>> +    }
>> +
>> +    hisi_ptt = devm_kzalloc(&pdev->dev, sizeof(*hisi_ptt), GFP_KERNEL);
>> +    if (!hisi_ptt)
>> +        return -ENOMEM;
>> +
>> +    mutex_init(&hisi_ptt->mutex);
>> +    hisi_ptt->pdev = pdev;
>> +    pci_set_drvdata(pdev, hisi_ptt);
>> +
>> +    ret = pcim_enable_device(pdev);
>> +    if (ret) {
>> +        pci_err(pdev, "failed to enable device, ret = %d\n", ret);
>> +        return ret;
>> +    }
>> +
>> +    ret = pcim_iomap_regions(pdev, BIT(2), DRV_NAME);
>> +    if (ret) {
>> +        pci_err(pdev, "failed to remap io memory, ret = %d\n", ret);
>> +        return ret;
>> +    }
>> +
>> +    hisi_ptt->iobase = pcim_iomap_table(pdev)[2];
>> +
>> +    ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
>> +    if (ret) {
>> +        pci_err(pdev, "failed to set 64 bit dma mask, ret = %d\n", ret);
>> +        return ret;
>> +    }
>> +
>> +    pci_set_master(pdev);
>> +
>> +    ret = hisi_ptt_register_irq(hisi_ptt);
>> +    if (ret)
>> +        return ret;
>> +
>> +    ret = hisi_ptt_init_ctrls(hisi_ptt);
>> +    if (ret) {
>> +        pci_err(pdev, "failed to init controls, ret = %d\n", ret);
>> +        return ret;
>> +    }
>> +
>> +    ret = hisi_ptt_register_pmu(hisi_ptt);
>> +    if (ret) {
>> +        pci_err(pdev, "failed to register PMU device, ret = %d", ret);
>> +        return ret;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static void hisi_ptt_remove(struct pci_dev *pdev)
>> +{
>> +    struct hisi_ptt *hisi_ptt = pci_get_drvdata(pdev);
>> +
>> +    /*
>> +     * We have to manually unregister the PMU device rather than make it
>> +     * devres managed to keep order that the PMU device's unregistration
>> +     * is prior to the release of DMA buffers. As the DMA buffers are
>> +     * devm allocated when necessary which is after the registration of
>> +     * the PMU device.
>> +     */
> 
> do you really need to mention all this?
> 

I think yes. Otherwise people may ask why not register PMU device in managed
way as well.

https://lore.kernel.org/lkml/20220308102157.00003725@Huawei.com/#t

>> +    perf_pmu_unregister(&hisi_ptt->hisi_ptt_pmu);
>> +}
>> +
[...]
>> +/**
>> + * struct hisi_ptt - per PTT device data
>> + * @trace_ctrl:   the control information of PTT trace
>> + * @hisi_ptt_pmu: the pum device of trace
>> + * @iobase:       base IO address of the device
>> + * @pdev:         pci_dev of this PTT device
>> + * @mutex:        mutex to protect the filter list and serialize the perf process.
>> + * @upper:        the upper BDF range of the PCI devices managed by this PTT device
>> + * @lower:        the lower BDF range of the PCI devices managed by this PTT device
>> + * @port_filters: the filter list of root ports
>> + * @req_filters:  the filter list of requester ID
>> + * @port_mask:    port mask of the managed root ports
>> + */
>> +struct hisi_ptt {
>> +    struct hisi_ptt_trace_ctrl trace_ctrl;
>> +    struct pmu hisi_ptt_pmu;
>> +    void __iomem *iobase;
>> +    struct pci_dev *pdev;
>> +    struct mutex mutex;
>> +    u32 upper;
> 
> upper_bdf would be a better name
> 
> people don't want to always refer to comments to check the meaning
> 

will change to upper_bdf and lower_bdf.

Thanks for the comments.

Regards,
Yicong


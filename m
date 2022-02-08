Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87FC94AD425
	for <lists+linux-pci@lfdr.de>; Tue,  8 Feb 2022 09:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352440AbiBHI5Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Feb 2022 03:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352679AbiBHI5X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Feb 2022 03:57:23 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23518C03FEC9;
        Tue,  8 Feb 2022 00:57:20 -0800 (PST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JtH1D5hm8zcclp;
        Tue,  8 Feb 2022 16:56:16 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Feb 2022 16:57:16 +0800
CC:     <prime.zeng@huawei.com>, <liuqi115@huawei.com>,
        <zhangshaokun@hisilicon.com>, <linuxarm@huawei.com>,
        <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH v3 1/8] hwtracing: Add trace function support for
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
References: <20220124131118.17887-1-yangyicong@hisilicon.com>
 <20220124131118.17887-2-yangyicong@hisilicon.com>
 <40f928c7-5671-ad4e-d208-250aab7d7a9b@huawei.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <3022ea4c-5088-c622-7a78-53cc67cf7a80@huawei.com>
Date:   Tue, 8 Feb 2022 16:57:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <40f928c7-5671-ad4e-d208-250aab7d7a9b@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi John,

Thanks for the comments. some replies inline.

On 2022/2/8 2:11, John Garry wrote:
> On 24/01/2022 13:11, Yicong Yang wrote:
>> HiSilicon PCIe tune and trace device(PTT) is a PCIe Root Complex
>> integrated Endpoint(RCiEP) device, providing the capability
>> to dynamically monitor and tune the PCIe traffic, and trace
>> the TLP headers.
>>
>> Add the driver for the device to enable the trace function.
>> This patch adds basic function of trace, including the device's
>> probe and initialization, functions for trace buffer allocation
>> and trace enable/disable, register an interrupt handler to
>> simply response to the DMA events. The user interface of trace
>> will be added in the following patch.
>>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
>>   drivers/Makefile                 |   1 +
>>   drivers/hwtracing/Kconfig        |   2 +
>>   drivers/hwtracing/ptt/Kconfig    |  11 +
>>   drivers/hwtracing/ptt/Makefile   |   2 +
>>   drivers/hwtracing/ptt/hisi_ptt.c | 398 +++++++++++++++++++++++++++++++
>>   drivers/hwtracing/ptt/hisi_ptt.h | 159 ++++++++++++
>>   6 files changed, 573 insertions(+)
>>   create mode 100644 drivers/hwtracing/ptt/Kconfig
>>   create mode 100644 drivers/hwtracing/ptt/Makefile
>>   create mode 100644 drivers/hwtracing/ptt/hisi_ptt.c
>>   create mode 100644 drivers/hwtracing/ptt/hisi_ptt.h
>>
>> diff --git a/drivers/Makefile b/drivers/Makefile
>> index a110338c860c..ab3411e4eba5 100644
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
>> index 000000000000..4f4f2459ac47
>> --- /dev/null
>> +++ b/drivers/hwtracing/ptt/Kconfig
>> @@ -0,0 +1,11 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +config HISI_PTT
>> +    tristate "HiSilicon PCIe Tune and Trace Device"
>> +    depends on ARM64 && PCI && HAS_DMA && HAS_IOMEM
>> +    help
>> +      HiSilicon PCIe Tune and Trace Device exist as a PCIe RCiEP
> 
> exists
> 
>> +      device, provides support for PCIe traffic tuning and
> 
> and it provides support...
> 

will fix, thanks.

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
>> index 000000000000..6d0a0ca5c0a9
>> --- /dev/null
>> +++ b/drivers/hwtracing/ptt/hisi_ptt.c
>> @@ -0,0 +1,398 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Driver for HiSilicon PCIe tune and trace device
>> + *
>> + * Copyright (c) 2022 HiSilicon Technologies Co., Ltd.
>> + * Author: Yicong Yang <yangyicong@hisilicon.com>
>> + */
>> +
[...]
>> +static int hisi_ptt_alloc_trace_buf(struct hisi_ptt *hisi_ptt)
>> +{
>> +    struct hisi_ptt_trace_ctrl *ctrl = &hisi_ptt->trace_ctrl;
>> +    struct device *dev = &hisi_ptt->pdev->dev;
>> +    struct hisi_ptt_dma_buffer *buffer;
>> +    int i, ret;
>> +
>> +    hisi_ptt->trace_ctrl.buf_index = 0;
>> +
>> +    /* Make sure the trace buffer is empty before allocating */
>> +    if (!list_empty(&ctrl->trace_buf)) {
>> +        list_for_each_entry(buffer, &ctrl->trace_buf, list)
>> +            memset(buffer->addr, 0, buffer->size);
>> +        return 0;
>> +    }
>> +
>> +    for (i = 0; i < HISI_PTT_TRACE_BUF_CNT; ++i) {
>> +        buffer = kzalloc(sizeof(*buffer), GFP_KERNEL);
> 
> I may have asked this before: why no devm usage?
> 

I remembered I was suggested for not using devm where we may need to manually
free it as it intends to be freed automically after the driver detachment.

>> +        if (!buffer) {
>> +            ret = -ENOMEM;
>> +            goto err;
>> +        }
>> +
>> +        buffer->addr = dma_alloc_coherent(dev, ctrl->buffer_size,
>> +                          &buffer->dma, GFP_KERNEL);
>> +        if (!buffer->addr) {
>> +            kfree(buffer);
>> +            ret = -ENOMEM;
>> +            goto err;
>> +        }
>> +
>> +        memset(buffer->addr, 0, buffer->size);
>> +
>> +        buffer->index = i;
>> +        buffer->size = ctrl->buffer_size;
> 
> please double check if we really need to store this info separately, i.e. is it const and same for all?
> 

yes. I stored it for convenience but seems unnecessary now, I'll remove it.

>> +        list_add_tail(&buffer->list, &ctrl->trace_buf);
>> +    }
>> +
>> +    return 0;
>> +err:
>> +    hisi_ptt_free_trace_buf(hisi_ptt);
>> +    return ret;
>> +}
>> +
>> +static void hisi_ptt_trace_end(struct hisi_ptt *hisi_ptt)
>> +{
>> +    writel(0, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
>> +    hisi_ptt->trace_ctrl.status = HISI_PTT_TRACE_STATUS_OFF;
>> +}
>> +
>> +static int hisi_ptt_trace_start(struct hisi_ptt *hisi_ptt)
>> +{
>> +    struct hisi_ptt_trace_ctrl *ctrl = &hisi_ptt->trace_ctrl;
>> +    struct hisi_ptt_dma_buffer *cur;
>> +    u32 val;
>> +
>> +    /* Check device idle before start trace */
>> +    if (hisi_ptt_wait_trace_hw_idle(hisi_ptt)) {
>> +        pci_err(hisi_ptt->pdev, "Failed to start trace, the device is still busy.\n");
>> +        return -EBUSY;
>> +    }
>> +
>> +    /* Reset the DMA before start tracing */
>> +    val = readl(hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
>> +    val |= HISI_PTT_TRACE_CTRL_RST;
>> +    writel(val, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
>> +
>> +    /*
>> +     * We'll be in the perf context where preemption is disabled,
>> +     * so use busy loop here.
> 
> what has preemption is disabled got to do with "busy loop"?
> 

The comment here to notice why we don't use a msleep() or similiar here as
we're in atomic context. Before we change to use perf, it's msleep() here.

>> +     */
>> +    mdelay(HISI_PTT_RESET_WAIT_MS);
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
>> +    list_for_each_entry(cur, &ctrl->trace_buf, list) {
>> +        writel(lower_32_bits(cur->dma),
>> +               hisi_ptt->iobase + HISI_PTT_TRACE_ADDR_BASE_LO_0 +
>> +               cur->index * HISI_PTT_TRACE_ADDR_STRIDE);
>> +        writel(upper_32_bits(cur->dma),
>> +               hisi_ptt->iobase + HISI_PTT_TRACE_ADDR_BASE_HI_0 +
>> +               cur->index * HISI_PTT_TRACE_ADDR_STRIDE);
>> +    }
>> +    writel(ctrl->buffer_size, hisi_ptt->iobase + HISI_PTT_TRACE_ADDR_SIZE);
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
>> +    ctrl->status = HISI_PTT_TRACE_STATUS_ON;
>> +
>> +    return 0;
>> +}
>> +
>> +static irqreturn_t hisi_ptt_isr(int irq, void *context)
>> +{
>> +    struct hisi_ptt *hisi_ptt = context;
>> +    u32 status;
>> +
>> +    status = readl(hisi_ptt->iobase + HISI_PTT_TRACE_INT_STAT);
>> +
>> +    /* Clear the interrupt status of buffer @buf_idx */
>> +    writel(status, hisi_ptt->iobase + HISI_PTT_TRACE_INT_STAT);
>> +
>> +    return IRQ_HANDLED;
>> +}
>> +
>> +static irqreturn_t hisi_ptt_irq(int irq, void *context)
>> +{
>> +    struct hisi_ptt *hisi_ptt = context;
>> +    u32 status;
>> +
>> +    status = readl(hisi_ptt->iobase + HISI_PTT_TRACE_INT_STAT);
>> +    if (!(status & HISI_PTT_TRACE_INT_STAT_MASK))
>> +        return IRQ_NONE;
>> +
>> +    return IRQ_WAKE_THREAD;
> 
> Adding empty handler like this is not helpful. And from checking the later code, the threaded part does nothing special, i.e nothing time consuming, so I don't know why everything cannot be done in the hard part for simplicity
> 

In the following patch we're copying and committing data to the AUX buffer so we need a threaded part here. For this
patch just adding the stub here. Maybe I can add some comments to mention it ?

>> +}
>> +
>> +static void hisi_ptt_irq_free_vectors(void *pdev)
>> +{
>> +    pci_free_irq_vectors(pdev);
>> +}
>> +
>> +static int hisi_ptt_register_irq(struct hisi_ptt *hisi_ptt)
>> +{
>> +    struct pci_dev *pdev = hisi_ptt->pdev;
>> +    int ret;
>> +
>> +    ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI);
>> +    if (ret < 0) {
>> +        pci_err(pdev, "failed to allocate irq vector, ret = %d.\n", ret);
>> +        return ret;
>> +    }
>> +
>> +    ret = devm_add_action_or_reset(&pdev->dev, hisi_ptt_irq_free_vectors, pdev);
>> +    if (ret < 0)
>> +        return ret;
>> +
>> +    ret = devm_request_threaded_irq(&pdev->dev,
>> +                    pci_irq_vector(pdev, HISI_PTT_TRACE_DMA_IRQ),
>> +                    hisi_ptt_irq, hisi_ptt_isr, 0,
>> +                    "hisi-ptt", hisi_ptt);
>> +    if (ret) {
>> +        pci_err(pdev, "failed to request irq %d, ret = %d.\n",
>> +            pci_irq_vector(pdev, HISI_PTT_TRACE_DMA_IRQ), ret);
>> +        return ret;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int hisi_ptt_init_filters(struct pci_dev *pdev, void *data)
>> +{
>> +    struct hisi_ptt_filter_desc *filter;
>> +    struct hisi_ptt *hisi_ptt = data;
>> +    struct list_head *target_list;
>> +
>> +    target_list = pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT ?
>> +              &hisi_ptt->port_filters : &hisi_ptt->req_filters;
>> +
>> +    filter = kzalloc(sizeof(*filter), GFP_KERNEL);
>> +    if (!filter)
>> +        return -ENOMEM;
>> +
>> +    filter->pdev = pdev;
>> +    filter->val = hisi_ptt_get_filter_val(pdev);
> 
> why do you need to store this also? if you're storing pdev, you seem to be able to directly get hisi_ptt_get_filter_val() for it
> 

checked the used places and I think it canbe dropped. thanks.

>> +    list_add_tail(&filter->list, target_list);
>> +
>> +    /* Update the available port mask */
>> +    if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT)
>> +        hisi_ptt->port_mask |= filter->val;
>> +
>> +    return 0;
>> +}
>> +
[...]
>> +/*
>> + * The DMA of PTT trace can only use direct mapping, due to some
>> + * hardware restriction. Check whether there is an iommu or the
>> + * policy of the iommu domain is passthrough, otherwise the trace
>> + * cannot work.
>> + */
>> +static int hisi_ptt_check_iommu_mapping(struct hisi_ptt *hisi_ptt)
>> +{
>> +    struct pci_dev *pdev = hisi_ptt->pdev;
>> +    struct iommu_domain *iommu_domain;
>> +
>> +    iommu_domain = iommu_get_domain_for_dev(&pdev->dev);
>> +    if (!iommu_domain || iommu_domain->type == IOMMU_DOMAIN_IDENTITY)
>> +        return 0;
> 
> so what stops us changing the domain type later?
> 

sorry but I don't think I got the point.

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
>> +    hisi_ptt = devm_kzalloc(&pdev->dev, sizeof(*hisi_ptt), GFP_KERNEL);
>> +    if (!hisi_ptt)
>> +        return -ENOMEM;
>> +
>> +    mutex_init(&hisi_ptt->mutex);
>> +    hisi_ptt->pdev = pdev;
>> +
>> +    /*
>> +     * Lifetime of pci_dev is longer than hisi_ptt,
>> +     * so directly reference to the pci name string.
>> +     */
>> +    hisi_ptt->name = pci_name(hisi_ptt->pdev);
>> +    pci_set_drvdata(pdev, hisi_ptt);
>> +
>> +    ret = pcim_enable_device(pdev);
>> +    if (ret) {
>> +        pci_err(pdev, "failed to enable device, ret = %d.\n", ret);
>> +        return ret;
>> +    }
>> +
>> +    ret = pcim_iomap_regions(pdev, BIT(2), hisi_ptt->name);
>> +    if (ret) {
>> +        pci_err(pdev, "failed to remap io memory, ret = %d.\n", ret);
>> +        return ret;
>> +    }
>> +
>> +    hisi_ptt->iobase = pcim_iomap_table(pdev)[2];
>> +
>> +    ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
>> +    if (ret) {
>> +        pci_err(pdev, "failed to set 64 bit dma mask, ret = %d.\n", ret);
>> +        return ret;
>> +    }
>> +    pci_set_master(pdev);
>> +
>> +    ret = hisi_ptt_register_irq(hisi_ptt);
>> +    if (ret)
>> +        return ret;
>> +
>> +    hisi_ptt_init_ctrls(hisi_ptt);
>> +
>> +    ret = hisi_ptt_check_iommu_mapping(hisi_ptt);
> 
> surely this should be done earlier in the probe
> 

yes it's a good point. will make it earlier.

>> +    if (ret) {
>> +        pci_err(pdev, "cannot work with non-direct DMA mapping.\n");
>> +        return ret;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
[...]
>> +/**
>> + * struct hisi_ptt - per PTT device data
>> + * @trace_ctrl:   the control information of PTT trace
>> + * @iobase:       base IO address of the device
>> + * @pdev:         pci_dev of this PTT device
>> + * @mutex:        mutex to protect the filter list and serialize the perf process.
>> + * @name:         name of the PTT device
>> + * @core_id:      PCIe core ID this PTT device locates
> 
> please don't put stuff in the common control struct which can be worked out on the fly. This is set in one function and then read in a callee.
> 

ok. will remove this.

Thanks,
Yicong

>> + * @sicl_id:      SICL ID this PTT device locates
>> + * @upper:        the upper BDF range of the PCI devices managed by this PTT device
>> + * @lower:        the lower BDF range of the PCI devices managed by this PTT device
>> + * @port_filters: the filter list of root ports
>> + * @req_filters:  the filter list of requester ID
>> + * @port_mask:    port mask of the managed root ports
>> + */
>> +struct hisi_ptt {
>> +    struct hisi_ptt_trace_ctrl trace_ctrl;
>> +    void __iomem *iobase;
>> +    struct pci_dev *pdev;
>> +    struct mutex mutex;
>> +    const char *name;
>> +    u16 core_id;
>> +    u16 sicl_id;
>> +    u32 upper;
>> +    u32 lower;
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
>> +#endif /* _HISI_PTT_H */
> 
> .

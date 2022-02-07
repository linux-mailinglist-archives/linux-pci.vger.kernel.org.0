Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23994AC866
	for <lists+linux-pci@lfdr.de>; Mon,  7 Feb 2022 19:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbiBGSSh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Feb 2022 13:18:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234460AbiBGSMS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Feb 2022 13:12:18 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92388C0401DA;
        Mon,  7 Feb 2022 10:12:16 -0800 (PST)
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JsvHS6XCvz67NtF;
        Tue,  8 Feb 2022 02:07:16 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 7 Feb 2022 19:12:13 +0100
Received: from [10.47.25.56] (10.47.25.56) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 7 Feb
 2022 18:11:59 +0000
Message-ID: <40f928c7-5671-ad4e-d208-250aab7d7a9b@huawei.com>
Date:   Mon, 7 Feb 2022 18:11:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v3 1/8] hwtracing: Add trace function support for
 HiSilicon PCIe Tune and Trace device
To:     Yicong Yang <yangyicong@hisilicon.com>,
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
CC:     <prime.zeng@huawei.com>, <liuqi115@huawei.com>,
        <zhangshaokun@hisilicon.com>, <linuxarm@huawei.com>,
        <song.bao.hua@hisilicon.com>
References: <20220124131118.17887-1-yangyicong@hisilicon.com>
 <20220124131118.17887-2-yangyicong@hisilicon.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220124131118.17887-2-yangyicong@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.25.56]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 24/01/2022 13:11, Yicong Yang wrote:
> HiSilicon PCIe tune and trace device(PTT) is a PCIe Root Complex
> integrated Endpoint(RCiEP) device, providing the capability
> to dynamically monitor and tune the PCIe traffic, and trace
> the TLP headers.
> 
> Add the driver for the device to enable the trace function.
> This patch adds basic function of trace, including the device's
> probe and initialization, functions for trace buffer allocation
> and trace enable/disable, register an interrupt handler to
> simply response to the DMA events. The user interface of trace
> will be added in the following patch.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>   drivers/Makefile                 |   1 +
>   drivers/hwtracing/Kconfig        |   2 +
>   drivers/hwtracing/ptt/Kconfig    |  11 +
>   drivers/hwtracing/ptt/Makefile   |   2 +
>   drivers/hwtracing/ptt/hisi_ptt.c | 398 +++++++++++++++++++++++++++++++
>   drivers/hwtracing/ptt/hisi_ptt.h | 159 ++++++++++++
>   6 files changed, 573 insertions(+)
>   create mode 100644 drivers/hwtracing/ptt/Kconfig
>   create mode 100644 drivers/hwtracing/ptt/Makefile
>   create mode 100644 drivers/hwtracing/ptt/hisi_ptt.c
>   create mode 100644 drivers/hwtracing/ptt/hisi_ptt.h
> 
> diff --git a/drivers/Makefile b/drivers/Makefile
> index a110338c860c..ab3411e4eba5 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -175,6 +175,7 @@ obj-$(CONFIG_USB4)		+= thunderbolt/
>   obj-$(CONFIG_CORESIGHT)		+= hwtracing/coresight/
>   obj-y				+= hwtracing/intel_th/
>   obj-$(CONFIG_STM)		+= hwtracing/stm/
> +obj-$(CONFIG_HISI_PTT)		+= hwtracing/ptt/
>   obj-$(CONFIG_ANDROID)		+= android/
>   obj-$(CONFIG_NVMEM)		+= nvmem/
>   obj-$(CONFIG_FPGA)		+= fpga/
> diff --git a/drivers/hwtracing/Kconfig b/drivers/hwtracing/Kconfig
> index 13085835a636..911ee977103c 100644
> --- a/drivers/hwtracing/Kconfig
> +++ b/drivers/hwtracing/Kconfig
> @@ -5,4 +5,6 @@ source "drivers/hwtracing/stm/Kconfig"
>   
>   source "drivers/hwtracing/intel_th/Kconfig"
>   
> +source "drivers/hwtracing/ptt/Kconfig"
> +
>   endmenu
> diff --git a/drivers/hwtracing/ptt/Kconfig b/drivers/hwtracing/ptt/Kconfig
> new file mode 100644
> index 000000000000..4f4f2459ac47
> --- /dev/null
> +++ b/drivers/hwtracing/ptt/Kconfig
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config HISI_PTT
> +	tristate "HiSilicon PCIe Tune and Trace Device"
> +	depends on ARM64 && PCI && HAS_DMA && HAS_IOMEM
> +	help
> +	  HiSilicon PCIe Tune and Trace Device exist as a PCIe RCiEP

exists

> +	  device, provides support for PCIe traffic tuning and

and it provides support...

> +	  tracing TLP headers to the memory.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called hisi_ptt.
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
> index 000000000000..6d0a0ca5c0a9
> --- /dev/null
> +++ b/drivers/hwtracing/ptt/hisi_ptt.c
> @@ -0,0 +1,398 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for HiSilicon PCIe tune and trace device
> + *
> + * Copyright (c) 2022 HiSilicon Technologies Co., Ltd.
> + * Author: Yicong Yang <yangyicong@hisilicon.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +#include <linux/dma-iommu.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/iommu.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/sysfs.h>
> +
> +#include "hisi_ptt.h"
> +
> +static u16 hisi_ptt_get_filter_val(struct pci_dev *pdev)
> +{
> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT)
> +		return BIT(HISI_PCIE_CORE_PORT_ID(PCI_SLOT(pdev->devfn)));
> +
> +	return PCI_DEVID(pdev->bus->number, pdev->devfn);
> +}
> +
> +static int hisi_ptt_wait_trace_hw_idle(struct hisi_ptt *hisi_ptt)
> +{
> +	u32 val;
> +
> +	return readl_poll_timeout(hisi_ptt->iobase + HISI_PTT_TRACE_STS, val,
> +				  val & HISI_PTT_TRACE_IDLE,
> +				  HISI_PTT_WAIT_POLL_INTERVAL_US,
> +				  HISI_PTT_WAIT_TIMEOUT_US);
> +}
> +
> +static void hisi_ptt_free_trace_buf(struct hisi_ptt *hisi_ptt)
> +{
> +	struct hisi_ptt_trace_ctrl *ctrl = &hisi_ptt->trace_ctrl;
> +	struct device *dev = &hisi_ptt->pdev->dev;
> +	struct hisi_ptt_dma_buffer *buffer, *tbuffer;
> +
> +	list_for_each_entry_safe(buffer, tbuffer, &ctrl->trace_buf, list) {
> +		list_del(&buffer->list);
> +		dma_free_coherent(dev, buffer->size, buffer->addr,
> +				  buffer->dma);
> +		kfree(buffer);
> +	}
> +}
> +
> +static int hisi_ptt_alloc_trace_buf(struct hisi_ptt *hisi_ptt)
> +{
> +	struct hisi_ptt_trace_ctrl *ctrl = &hisi_ptt->trace_ctrl;
> +	struct device *dev = &hisi_ptt->pdev->dev;
> +	struct hisi_ptt_dma_buffer *buffer;
> +	int i, ret;
> +
> +	hisi_ptt->trace_ctrl.buf_index = 0;
> +
> +	/* Make sure the trace buffer is empty before allocating */
> +	if (!list_empty(&ctrl->trace_buf)) {
> +		list_for_each_entry(buffer, &ctrl->trace_buf, list)
> +			memset(buffer->addr, 0, buffer->size);
> +		return 0;
> +	}
> +
> +	for (i = 0; i < HISI_PTT_TRACE_BUF_CNT; ++i) {
> +		buffer = kzalloc(sizeof(*buffer), GFP_KERNEL);

I may have asked this before: why no devm usage?

> +		if (!buffer) {
> +			ret = -ENOMEM;
> +			goto err;
> +		}
> +
> +		buffer->addr = dma_alloc_coherent(dev, ctrl->buffer_size,
> +						  &buffer->dma, GFP_KERNEL);
> +		if (!buffer->addr) {
> +			kfree(buffer);
> +			ret = -ENOMEM;
> +			goto err;
> +		}
> +
> +		memset(buffer->addr, 0, buffer->size);
> +
> +		buffer->index = i;
> +		buffer->size = ctrl->buffer_size;

please double check if we really need to store this info separately, 
i.e. is it const and same for all?

> +		list_add_tail(&buffer->list, &ctrl->trace_buf);
> +	}
> +
> +	return 0;
> +err:
> +	hisi_ptt_free_trace_buf(hisi_ptt);
> +	return ret;
> +}
> +
> +static void hisi_ptt_trace_end(struct hisi_ptt *hisi_ptt)
> +{
> +	writel(0, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
> +	hisi_ptt->trace_ctrl.status = HISI_PTT_TRACE_STATUS_OFF;
> +}
> +
> +static int hisi_ptt_trace_start(struct hisi_ptt *hisi_ptt)
> +{
> +	struct hisi_ptt_trace_ctrl *ctrl = &hisi_ptt->trace_ctrl;
> +	struct hisi_ptt_dma_buffer *cur;
> +	u32 val;
> +
> +	/* Check device idle before start trace */
> +	if (hisi_ptt_wait_trace_hw_idle(hisi_ptt)) {
> +		pci_err(hisi_ptt->pdev, "Failed to start trace, the device is still busy.\n");
> +		return -EBUSY;
> +	}
> +
> +	/* Reset the DMA before start tracing */
> +	val = readl(hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
> +	val |= HISI_PTT_TRACE_CTRL_RST;
> +	writel(val, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
> +
> +	/*
> +	 * We'll be in the perf context where preemption is disabled,
> +	 * so use busy loop here.

what has preemption is disabled got to do with "busy loop"?

> +	 */
> +	mdelay(HISI_PTT_RESET_WAIT_MS);
> +
> +	val = readl(hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
> +	val &= ~HISI_PTT_TRACE_CTRL_RST;
> +	writel(val, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
> +
> +	/* Clear the interrupt status */
> +	writel(HISI_PTT_TRACE_INT_STAT_MASK, hisi_ptt->iobase + HISI_PTT_TRACE_INT_STAT);
> +	writel(0, hisi_ptt->iobase + HISI_PTT_TRACE_INT_MASK);
> +
> +	/* Configure the trace DMA buffer */
> +	list_for_each_entry(cur, &ctrl->trace_buf, list) {
> +		writel(lower_32_bits(cur->dma),
> +		       hisi_ptt->iobase + HISI_PTT_TRACE_ADDR_BASE_LO_0 +
> +		       cur->index * HISI_PTT_TRACE_ADDR_STRIDE);
> +		writel(upper_32_bits(cur->dma),
> +		       hisi_ptt->iobase + HISI_PTT_TRACE_ADDR_BASE_HI_0 +
> +		       cur->index * HISI_PTT_TRACE_ADDR_STRIDE);
> +	}
> +	writel(ctrl->buffer_size, hisi_ptt->iobase + HISI_PTT_TRACE_ADDR_SIZE);
> +
> +	/* Set the trace control register */
> +	val = FIELD_PREP(HISI_PTT_TRACE_CTRL_TYPE_SEL, ctrl->type);
> +	val |= FIELD_PREP(HISI_PTT_TRACE_CTRL_RXTX_SEL, ctrl->direction);
> +	val |= FIELD_PREP(HISI_PTT_TRACE_CTRL_DATA_FORMAT, ctrl->format);
> +	val |= FIELD_PREP(HISI_PTT_TRACE_CTRL_TARGET_SEL, hisi_ptt->trace_ctrl.filter);
> +	if (!hisi_ptt->trace_ctrl.is_port)
> +		val |= HISI_PTT_TRACE_CTRL_FILTER_MODE;
> +
> +	/* Start the Trace */
> +	val |= HISI_PTT_TRACE_CTRL_EN;
> +	writel(val, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
> +
> +	ctrl->status = HISI_PTT_TRACE_STATUS_ON;
> +
> +	return 0;
> +}
> +
> +static irqreturn_t hisi_ptt_isr(int irq, void *context)
> +{
> +	struct hisi_ptt *hisi_ptt = context;
> +	u32 status;
> +
> +	status = readl(hisi_ptt->iobase + HISI_PTT_TRACE_INT_STAT);
> +
> +	/* Clear the interrupt status of buffer @buf_idx */
> +	writel(status, hisi_ptt->iobase + HISI_PTT_TRACE_INT_STAT);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t hisi_ptt_irq(int irq, void *context)
> +{
> +	struct hisi_ptt *hisi_ptt = context;
> +	u32 status;
> +
> +	status = readl(hisi_ptt->iobase + HISI_PTT_TRACE_INT_STAT);
> +	if (!(status & HISI_PTT_TRACE_INT_STAT_MASK))
> +		return IRQ_NONE;
> +
> +	return IRQ_WAKE_THREAD;

Adding empty handler like this is not helpful. And from checking the 
later code, the threaded part does nothing special, i.e nothing time 
consuming, so I don't know why everything cannot be done in the hard 
part for simplicity

> +}
> +
> +static void hisi_ptt_irq_free_vectors(void *pdev)
> +{
> +	pci_free_irq_vectors(pdev);
> +}
> +
> +static int hisi_ptt_register_irq(struct hisi_ptt *hisi_ptt)
> +{
> +	struct pci_dev *pdev = hisi_ptt->pdev;
> +	int ret;
> +
> +	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI);
> +	if (ret < 0) {
> +		pci_err(pdev, "failed to allocate irq vector, ret = %d.\n", ret);
> +		return ret;
> +	}
> +
> +	ret = devm_add_action_or_reset(&pdev->dev, hisi_ptt_irq_free_vectors, pdev);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = devm_request_threaded_irq(&pdev->dev,
> +					pci_irq_vector(pdev, HISI_PTT_TRACE_DMA_IRQ),
> +					hisi_ptt_irq, hisi_ptt_isr, 0,
> +					"hisi-ptt", hisi_ptt);
> +	if (ret) {
> +		pci_err(pdev, "failed to request irq %d, ret = %d.\n",
> +			pci_irq_vector(pdev, HISI_PTT_TRACE_DMA_IRQ), ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int hisi_ptt_init_filters(struct pci_dev *pdev, void *data)
> +{
> +	struct hisi_ptt_filter_desc *filter;
> +	struct hisi_ptt *hisi_ptt = data;
> +	struct list_head *target_list;
> +
> +	target_list = pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT ?
> +		      &hisi_ptt->port_filters : &hisi_ptt->req_filters;
> +
> +	filter = kzalloc(sizeof(*filter), GFP_KERNEL);
> +	if (!filter)
> +		return -ENOMEM;
> +
> +	filter->pdev = pdev;
> +	filter->val = hisi_ptt_get_filter_val(pdev);

why do you need to store this also? if you're storing pdev, you seem to 
be able to directly get hisi_ptt_get_filter_val() for it

> +	list_add_tail(&filter->list, target_list);
> +
> +	/* Update the available port mask */
> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT)
> +		hisi_ptt->port_mask |= filter->val;
> +
> +	return 0;
> +}
> +
> +static void hisi_ptt_release_filters(struct hisi_ptt *hisi_ptt)
> +{
> +	struct hisi_ptt_filter_desc *filter, *tfilter;
> +
> +	list_for_each_entry_safe(filter, tfilter, &hisi_ptt->req_filters, list) {
> +		list_del(&filter->list);
> +		kfree(filter);
> +	}
> +
> +	list_for_each_entry_safe(filter, tfilter, &hisi_ptt->port_filters, list) {
> +		list_del(&filter->list);
> +		kfree(filter);
> +	}
> +}
> +
> +static void hisi_ptt_init_ctrls(struct hisi_ptt *hisi_ptt)
> +{
> +	struct pci_dev *pdev = hisi_ptt->pdev;
> +	struct pci_bus *bus;
> +	u32 reg;
> +
> +	INIT_LIST_HEAD(&hisi_ptt->port_filters);
> +	INIT_LIST_HEAD(&hisi_ptt->req_filters);
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
> +	hisi_ptt->upper = reg >> 16;
> +	hisi_ptt->lower = reg & 0xffff;
> +
> +	reg = readl(hisi_ptt->iobase + HISI_PTT_LOCATION);
> +	hisi_ptt->core_id = FIELD_GET(HISI_PTT_CORE_ID, reg);
> +	hisi_ptt->sicl_id = FIELD_GET(HISI_PTT_SICL_ID, reg);
> +
> +	bus = pci_find_bus(pci_domain_nr(pdev->bus), PCI_BUS_NUM(hisi_ptt->upper));
> +	if (bus)
> +		pci_walk_bus(bus, hisi_ptt_init_filters, hisi_ptt);
> +
> +	/* Initialize trace controls */
> +	INIT_LIST_HEAD(&hisi_ptt->trace_ctrl.trace_buf);
> +	hisi_ptt->trace_ctrl.buffer_size = HISI_PTT_TRACE_BUF_SIZE;
> +	hisi_ptt->trace_ctrl.default_cpu = cpumask_first(cpumask_of_node(dev_to_node(&pdev->dev)));
> +}
> +
> +/*
> + * The DMA of PTT trace can only use direct mapping, due to some
> + * hardware restriction. Check whether there is an iommu or the
> + * policy of the iommu domain is passthrough, otherwise the trace
> + * cannot work.
> + */
> +static int hisi_ptt_check_iommu_mapping(struct hisi_ptt *hisi_ptt)
> +{
> +	struct pci_dev *pdev = hisi_ptt->pdev;
> +	struct iommu_domain *iommu_domain;
> +
> +	iommu_domain = iommu_get_domain_for_dev(&pdev->dev);
> +	if (!iommu_domain || iommu_domain->type == IOMMU_DOMAIN_IDENTITY)
> +		return 0;

so what stops us changing the domain type later?

> +
> +	return -EOPNOTSUPP;
> +}
> +
> +static int hisi_ptt_probe(struct pci_dev *pdev,
> +			  const struct pci_device_id *id)
> +{
> +	struct hisi_ptt *hisi_ptt;
> +	int ret;
> +
> +	hisi_ptt = devm_kzalloc(&pdev->dev, sizeof(*hisi_ptt), GFP_KERNEL);
> +	if (!hisi_ptt)
> +		return -ENOMEM;
> +
> +	mutex_init(&hisi_ptt->mutex);
> +	hisi_ptt->pdev = pdev;
> +
> +	/*
> +	 * Lifetime of pci_dev is longer than hisi_ptt,
> +	 * so directly reference to the pci name string.
> +	 */
> +	hisi_ptt->name = pci_name(hisi_ptt->pdev);
> +	pci_set_drvdata(pdev, hisi_ptt);
> +
> +	ret = pcim_enable_device(pdev);
> +	if (ret) {
> +		pci_err(pdev, "failed to enable device, ret = %d.\n", ret);
> +		return ret;
> +	}
> +
> +	ret = pcim_iomap_regions(pdev, BIT(2), hisi_ptt->name);
> +	if (ret) {
> +		pci_err(pdev, "failed to remap io memory, ret = %d.\n", ret);
> +		return ret;
> +	}
> +
> +	hisi_ptt->iobase = pcim_iomap_table(pdev)[2];
> +
> +	ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
> +	if (ret) {
> +		pci_err(pdev, "failed to set 64 bit dma mask, ret = %d.\n", ret);
> +		return ret;
> +	}
> +	pci_set_master(pdev);
> +
> +	ret = hisi_ptt_register_irq(hisi_ptt);
> +	if (ret)
> +		return ret;
> +
> +	hisi_ptt_init_ctrls(hisi_ptt);
> +
> +	ret = hisi_ptt_check_iommu_mapping(hisi_ptt);

surely this should be done earlier in the probe

> +	if (ret) {
> +		pci_err(pdev, "cannot work with non-direct DMA mapping.\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +void hisi_ptt_remove(struct pci_dev *pdev)
> +{
> +	struct hisi_ptt *hisi_ptt = pci_get_drvdata(pdev);
> +
> +	if (hisi_ptt->trace_ctrl.status == HISI_PTT_TRACE_STATUS_ON)
> +		hisi_ptt_trace_end(hisi_ptt);
> +
> +	hisi_ptt_free_trace_buf(hisi_ptt);
> +	hisi_ptt_release_filters(hisi_ptt);
> +}
> +
> +static const struct pci_device_id hisi_ptt_id_tbl[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, 0xa12e) },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(pci, hisi_ptt_id_tbl);
> +
> +static struct pci_driver hisi_ptt_driver = {
> +	.name = "hisi_ptt",
> +	.id_table = hisi_ptt_id_tbl,
> +	.probe = hisi_ptt_probe,
> +	.remove = hisi_ptt_remove,
> +};
> +module_pci_driver(hisi_ptt_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Yicong Yang <yangyicong@hisilicon.com>");
> +MODULE_DESCRIPTION("Driver for HiSilicon PCIe tune and trace device");
> diff --git a/drivers/hwtracing/ptt/hisi_ptt.h b/drivers/hwtracing/ptt/hisi_ptt.h
> new file mode 100644
> index 000000000000..8aa5d6b78cc5
> --- /dev/null
> +++ b/drivers/hwtracing/ptt/hisi_ptt.h
> @@ -0,0 +1,159 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Driver for HiSilicon PCIe tune and trace device
> + *
> + * Copyright (c) 2022 HiSilicon Technologies Co., Ltd.
> + * Author: Yicong Yang <yangyicong@hisilicon.com>

I saw "spinoff the declarations to a separate header" in the revision 
notes. I don't understand the reasoning for that - if the declarations 
are only used in the .c file then they can be declared there. They are 
not an interface nor shared declarations.

Anyway it's the maintainers choice.

> + */
> +
> +#ifndef _HISI_PTT_H
> +#define _HISI_PTT_H
> +
> +#include <linux/bits.h>
> +#include <linux/list.h>
> +#include <linux/mutex.h>
> +#include <linux/pci.h>
> +#include <linux/types.h>
> +
> +/*
> + * The definition of the device registers and register fields.
> + */
> +#define HISI_PTT_TRACE_ADDR_SIZE	0x0800
> +#define HISI_PTT_TRACE_ADDR_BASE_LO_0	0x0810
> +#define HISI_PTT_TRACE_ADDR_BASE_HI_0	0x0814
> +#define HISI_PTT_TRACE_ADDR_STRIDE	0x8
> +#define HISI_PTT_TRACE_CTRL		0x0850
> +#define   HISI_PTT_TRACE_CTRL_EN	BIT(0)
> +#define   HISI_PTT_TRACE_CTRL_RST	BIT(1)
> +#define   HISI_PTT_TRACE_CTRL_RXTX_SEL	GENMASK(3, 2)
> +#define   HISI_PTT_TRACE_CTRL_TYPE_SEL	GENMASK(7, 4)
> +#define   HISI_PTT_TRACE_CTRL_DATA_FORMAT	BIT(14)
> +#define   HISI_PTT_TRACE_CTRL_FILTER_MODE	BIT(15)
> +#define   HISI_PTT_TRACE_CTRL_TARGET_SEL	GENMASK(31, 16)
> +#define HISI_PTT_TRACE_INT_STAT		0x0890
> +#define   HISI_PTT_TRACE_INT_STAT_MASK	GENMASK(3, 0)
> +#define HISI_PTT_TRACE_INT_MASK		0x0894
> +#define HISI_PTT_TRACE_WR_STS		0x08a0
> +#define   HISI_PTT_TRACE_WR_STS_WRITE	GENMASK(27, 0)
> +#define   HISI_PTT_TRACE_WR_STS_BUFFER	GENMASK(29, 28)
> +#define HISI_PTT_TRACE_STS		0x08b0
> +#define   HISI_PTT_TRACE_IDLE		BIT(0)
> +#define HISI_PTT_DEVICE_RANGE		0x0fe0
> +#define HISI_PTT_LOCATION		0x0fe8
> +#define   HISI_PTT_CORE_ID		GENMASK(15, 0)
> +#define   HISI_PTT_SICL_ID		GENMASK(31, 16)
> +
> +/* Parameters of PTT trace DMA part. */
> +#define HISI_PTT_TRACE_DMA_IRQ			0
> +#define HISI_PTT_TRACE_BUF_CNT			4
> +#define HISI_PTT_TRACE_BUF_SIZE			SZ_4M
> +#define HISI_PTT_TRACE_TOTAL_BUF_SIZE		(HISI_PTT_TRACE_BUF_SIZE * \
> +						 HISI_PTT_TRACE_BUF_CNT)
> +/* Wait time for DMA hardware to reset */
> +#define HISI_PTT_RESET_WAIT_MS		1000UL
> +/* Poll timeout and interval for waiting hardware work to finish */
> +#define HISI_PTT_WAIT_TIMEOUT_US	1000000UL
> +#define HISI_PTT_WAIT_POLL_INTERVAL_US	100UL
> +
> +#define HISI_PCIE_CORE_PORT_ID(devfn)	(PCI_FUNC(devfn) << 1)
> +
> +enum hisi_ptt_trace_status {
> +	HISI_PTT_TRACE_STATUS_OFF = 0,
> +	HISI_PTT_TRACE_STATUS_ON,
> +};
> +
> +/**
> + * struct hisi_ptt_dma_buffer - describe a single trace buffer of PTT trace.
> + *                              The detail of the data format is described
> + *                              in the documentation of PTT device.
> + * @list:  entry of this buffer in the buffer list
> + * @size:  size of this buffer
> + * @dma:   DMA address of this buffer visible to the device
> + * @addr:  virtual address of this buffer visible to the cpu
> + * @index: index of this buffer in the buffer list
> + */
> +struct hisi_ptt_dma_buffer {
> +	struct list_head list;
> +	unsigned int size;
> +	dma_addr_t dma;
> +	void *addr;
> +	int index;
> +};
> +
> +/**
> + * struct hisi_ptt_trace_ctrl - control and status of PTT trace
> + * @status:      current trace status
> + * @trace_buf:   the trace buffers for holding the trace data
> + * @default_cpu: default cpu to start the trace session
> + * @buffer_size: the size of each trace buffer in the list
> + * @buf_index:   the index of current using trace buffer
> + * @is_port:     whether we're tracing root port or not
> + * @direction:   direction of the TLP headers to trace
> + * @filter:      filter value for tracing the TLP headers
> + * @format:      format of the TLP headers to trace
> + * @type:        type of the TLP headers to trace
> + */
> +struct hisi_ptt_trace_ctrl {
> +	enum hisi_ptt_trace_status status;
> +	struct list_head trace_buf;
> +	int default_cpu;
> +	u32 buffer_size;
> +	u32 buf_index;
> +	bool is_port;
> +	u32 direction:2;
> +	u32 filter:16;
> +	u32 format:1;
> +	u32 type:4;
> +};
> +
> +/**
> + * struct hisi_ptt_filter_desc - descriptor of the PTT trace filter
> + * @list: entry of this descriptor in the filter list
> + * @pdev: pci_dev related to this filter
> + * @val:  filter value for the device
> + */
> +struct hisi_ptt_filter_desc {
> +	struct list_head list;
> +	struct pci_dev *pdev;
> +	u16 val;
> +};
> +
> +/**
> + * struct hisi_ptt - per PTT device data
> + * @trace_ctrl:   the control information of PTT trace
> + * @iobase:       base IO address of the device
> + * @pdev:         pci_dev of this PTT device
> + * @mutex:        mutex to protect the filter list and serialize the perf process.
> + * @name:         name of the PTT device
> + * @core_id:      PCIe core ID this PTT device locates

please don't put stuff in the common control struct which can be worked 
out on the fly. This is set in one function and then read in a callee.

> + * @sicl_id:      SICL ID this PTT device locates
> + * @upper:        the upper BDF range of the PCI devices managed by this PTT device
> + * @lower:        the lower BDF range of the PCI devices managed by this PTT device
> + * @port_filters: the filter list of root ports
> + * @req_filters:  the filter list of requester ID
> + * @port_mask:    port mask of the managed root ports
> + */
> +struct hisi_ptt {
> +	struct hisi_ptt_trace_ctrl trace_ctrl;
> +	void __iomem *iobase;
> +	struct pci_dev *pdev;
> +	struct mutex mutex;
> +	const char *name;
> +	u16 core_id;
> +	u16 sicl_id;
> +	u32 upper;
> +	u32 lower;
> +
> +	/*
> +	 * The trace TLP headers can either be filtered by certain
> +	 * root port, or by the requester ID. Organize the filters
> +	 * by @port_filters and @req_filters here. The mask of all
> +	 * the valid ports is also cached for doing sanity check
> +	 * of user input.
> +	 */
> +	struct list_head port_filters;
> +	struct list_head req_filters;
> +	u16 port_mask;
> +};
> +
> +#endif /* _HISI_PTT_H */


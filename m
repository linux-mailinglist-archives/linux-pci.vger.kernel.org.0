Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96D55840C0
	for <lists+linux-pci@lfdr.de>; Thu, 28 Jul 2022 16:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbiG1OM3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Jul 2022 10:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiG1OMP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jul 2022 10:12:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7582653;
        Thu, 28 Jul 2022 07:11:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B826B82325;
        Thu, 28 Jul 2022 14:11:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A98F1C433D7;
        Thu, 28 Jul 2022 14:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659017516;
        bh=UyHj2Qs+zObdENIfUjhuUMU8rZHr7MhJe+97jLP8Drc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sGm4t71D7UP8zh0jvstjSWyHNYGDOmThhWX3LFprlbBz+GlqaZDhwYku1dd8cD4xP
         dBEzWM9VFn5pfcYCYSO/8JHZ5yTjJ5aJo41iAAjmJkKPZ3yHU/Gjo5E8LtB5JjyiHg
         zMA/Je1UcKtLWq+6kX7gtEK+aqN9sAlkUOeosnLo=
Date:   Thu, 28 Jul 2022 16:11:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     yangyicong@huawei.com
Cc:     alexander.shishkin@linux.intel.com, leo.yan@linaro.org,
        james.clark@arm.com, will@kernel.org, robin.murphy@arm.com,
        acme@kernel.org, peterz@infradead.org, corbet@lwn.net,
        mathieu.poirier@linaro.org, mark.rutland@arm.com,
        jonathan.cameron@huawei.com, john.garry@huawei.com,
        helgaas@kernel.org, lorenzo.pieralisi@arm.com,
        suzuki.poulose@arm.com, joro@8bytes.org,
        shameerali.kolothum.thodi@huawei.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-perf-users@vger.kernel.org,
        iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-doc@vger.kernel.org, prime.zeng@huawei.com,
        liuqi115@huawei.com, zhangshaokun@hisilicon.com,
        linuxarm@huawei.com, yangyicong@hisilicon.com, bagasdotme@gmail.com
Subject: Re: [PATCH v11 2/8] hwtracing: hisi_ptt: Add trace function support
 for HiSilicon PCIe Tune and Trace device
Message-ID: <YuKZKGKMz+UcbETM@kroah.com>
References: <20220721130116.43366-1-yangyicong@huawei.com>
 <20220721130116.43366-3-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721130116.43366-3-yangyicong@huawei.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 21, 2022 at 09:01:10PM +0800, yangyicong@huawei.com wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
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
> This patch initially add basic trace support of PTT device.
> 
> Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: John Garry <john.garry@huawei.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  drivers/Makefile                 |   1 +
>  drivers/hwtracing/Kconfig        |   2 +
>  drivers/hwtracing/ptt/Kconfig    |  12 +
>  drivers/hwtracing/ptt/Makefile   |   2 +
>  drivers/hwtracing/ptt/hisi_ptt.c | 901 +++++++++++++++++++++++++++++++
>  drivers/hwtracing/ptt/hisi_ptt.h | 177 ++++++
>  6 files changed, 1095 insertions(+)
>  create mode 100644 drivers/hwtracing/ptt/Kconfig
>  create mode 100644 drivers/hwtracing/ptt/Makefile
>  create mode 100644 drivers/hwtracing/ptt/hisi_ptt.c
>  create mode 100644 drivers/hwtracing/ptt/hisi_ptt.h
> 
> diff --git a/drivers/Makefile b/drivers/Makefile
> index 9a30842b22c5..bf67e0e23c18 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -176,6 +176,7 @@ obj-$(CONFIG_USB4)		+= thunderbolt/
>  obj-$(CONFIG_CORESIGHT)		+= hwtracing/coresight/
>  obj-y				+= hwtracing/intel_th/
>  obj-$(CONFIG_STM)		+= hwtracing/stm/
> +obj-$(CONFIG_HISI_PTT)		+= hwtracing/ptt/
>  obj-$(CONFIG_ANDROID)		+= android/
>  obj-$(CONFIG_NVMEM)		+= nvmem/
>  obj-$(CONFIG_FPGA)		+= fpga/
> diff --git a/drivers/hwtracing/Kconfig b/drivers/hwtracing/Kconfig
> index 13085835a636..911ee977103c 100644
> --- a/drivers/hwtracing/Kconfig
> +++ b/drivers/hwtracing/Kconfig
> @@ -5,4 +5,6 @@ source "drivers/hwtracing/stm/Kconfig"
>  
>  source "drivers/hwtracing/intel_th/Kconfig"
>  
> +source "drivers/hwtracing/ptt/Kconfig"
> +
>  endmenu
> diff --git a/drivers/hwtracing/ptt/Kconfig b/drivers/hwtracing/ptt/Kconfig
> new file mode 100644
> index 000000000000..6d46a09ffeb9
> --- /dev/null
> +++ b/drivers/hwtracing/ptt/Kconfig
> @@ -0,0 +1,12 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config HISI_PTT
> +	tristate "HiSilicon PCIe Tune and Trace Device"
> +	depends on ARM64 || (COMPILE_TEST && 64BIT)
> +	depends on PCI && HAS_DMA && HAS_IOMEM && PERF_EVENTS
> +	help
> +	  HiSilicon PCIe Tune and Trace device exists as a PCIe RCiEP
> +	  device, and it provides support for PCIe traffic tuning and
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
> index 000000000000..c64642097f8b
> --- /dev/null
> +++ b/drivers/hwtracing/ptt/hisi_ptt.c
> @@ -0,0 +1,901 @@
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
> +#include <linux/cpuhotplug.h>
> +#include <linux/delay.h>
> +#include <linux/dma-iommu.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/iommu.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/sysfs.h>
> +#include <linux/vmalloc.h>
> +
> +#include "hisi_ptt.h"
> +
> +/* Dynamic CPU hotplug state used by PTT */
> +static enum cpuhp_state hisi_ptt_pmu_online;
> +
> +static u16 hisi_ptt_get_filter_val(u16 devid, bool is_port)
> +{
> +	if (is_port)
> +		return BIT(HISI_PCIE_CORE_PORT_ID(devid & 0xff));
> +
> +	return devid;
> +}
> +
> +static bool hisi_ptt_wait_trace_hw_idle(struct hisi_ptt *hisi_ptt)
> +{
> +	u32 val;
> +
> +	return !readl_poll_timeout_atomic(hisi_ptt->iobase + HISI_PTT_TRACE_STS,
> +					  val, val & HISI_PTT_TRACE_IDLE,
> +					  HISI_PTT_WAIT_POLL_INTERVAL_US,
> +					  HISI_PTT_WAIT_TRACE_TIMEOUT_US);
> +}
> +
> +static void hisi_ptt_wait_dma_reset_done(struct hisi_ptt *hisi_ptt)
> +{
> +	u32 val;
> +
> +	readl_poll_timeout_atomic(hisi_ptt->iobase + HISI_PTT_TRACE_WR_STS,
> +				  val, !val, HISI_PTT_RESET_POLL_INTERVAL_US,
> +				  HISI_PTT_RESET_TIMEOUT_US);
> +}
> +
> +static void hisi_ptt_trace_end(struct hisi_ptt *hisi_ptt)
> +{
> +	writel(0, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
> +	hisi_ptt->trace_ctrl.started = false;
> +}
> +
> +static int hisi_ptt_trace_start(struct hisi_ptt *hisi_ptt)
> +{
> +	struct hisi_ptt_trace_ctrl *ctrl = &hisi_ptt->trace_ctrl;
> +	u32 val;
> +	int i;
> +
> +	/* Check device idle before start trace */
> +	if (!hisi_ptt_wait_trace_hw_idle(hisi_ptt)) {
> +		pci_err(hisi_ptt->pdev, "Failed to start trace, the device is still busy\n");
> +		return -EBUSY;
> +	}
> +
> +	ctrl->started = true;
> +
> +	/* Reset the DMA before start tracing */
> +	val = readl(hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
> +	val |= HISI_PTT_TRACE_CTRL_RST;
> +	writel(val, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
> +
> +	hisi_ptt_wait_dma_reset_done(hisi_ptt);
> +
> +	val = readl(hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
> +	val &= ~HISI_PTT_TRACE_CTRL_RST;
> +	writel(val, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
> +
> +	/* Reset the index of current buffer */
> +	hisi_ptt->trace_ctrl.buf_index = 0;
> +
> +	/* Zero the trace buffers */
> +	for (i = 0; i < HISI_PTT_TRACE_BUF_CNT; i++)
> +		memset(ctrl->trace_buf[i].addr, 0, HISI_PTT_TRACE_BUF_SIZE);
> +
> +	/* Clear the interrupt status */
> +	writel(HISI_PTT_TRACE_INT_STAT_MASK, hisi_ptt->iobase + HISI_PTT_TRACE_INT_STAT);
> +	writel(0, hisi_ptt->iobase + HISI_PTT_TRACE_INT_MASK);
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
> +	return 0;
> +}
> +
> +static int hisi_ptt_update_aux(struct hisi_ptt *hisi_ptt, int index, bool stop)
> +{
> +	struct hisi_ptt_trace_ctrl *ctrl = &hisi_ptt->trace_ctrl;
> +	struct perf_output_handle *handle = &ctrl->handle;
> +	struct perf_event *event = handle->event;
> +	struct hisi_ptt_pmu_buf *buf;
> +	size_t size;
> +	void *addr;
> +
> +	buf = perf_get_aux(handle);
> +	if (!buf || !handle->size)
> +		return -EINVAL;
> +
> +	addr = ctrl->trace_buf[ctrl->buf_index].addr;
> +
> +	/*
> +	 * If we're going to stop, read the size of already traced data from
> +	 * HISI_PTT_TRACE_WR_STS. Otherwise we're coming from the interrupt,
> +	 * the data size is always HISI_PTT_TRACE_BUF_SIZE.
> +	 */
> +	if (stop) {
> +		u32 reg;
> +
> +		reg = readl(hisi_ptt->iobase + HISI_PTT_TRACE_WR_STS);
> +		size = FIELD_GET(HISI_PTT_TRACE_WR_STS_WRITE, reg);
> +	} else {
> +		size = HISI_PTT_TRACE_BUF_SIZE;
> +	}
> +
> +	memcpy(buf->base + buf->pos, addr, size);
> +	buf->pos += size;
> +
> +	/*
> +	 * Just commit the traced data if we're going to stop. Otherwise if the
> +	 * resident AUX buffer cannot contain the data of next trace buffer,
> +	 * apply a new one.
> +	 */
> +	if (stop) {
> +		perf_aux_output_end(handle, buf->pos);
> +	} else if (buf->length - buf->pos < HISI_PTT_TRACE_BUF_SIZE) {
> +		perf_aux_output_end(handle, buf->pos);
> +
> +		buf = perf_aux_output_begin(handle, event);
> +		if (!buf)
> +			return -EINVAL;
> +
> +		buf->pos = handle->head % buf->length;
> +		if (buf->length - buf->pos < HISI_PTT_TRACE_BUF_SIZE) {
> +			perf_aux_output_end(handle, 0);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static irqreturn_t hisi_ptt_isr(int irq, void *context)
> +{
> +	struct hisi_ptt *hisi_ptt = context;
> +	u32 status, buf_idx;
> +
> +	status = readl(hisi_ptt->iobase + HISI_PTT_TRACE_INT_STAT);
> +	if (!(status & HISI_PTT_TRACE_INT_STAT_MASK))
> +		return IRQ_NONE;
> +
> +	buf_idx = ffs(status) - 1;
> +
> +	/* Clear the interrupt status of buffer @buf_idx */
> +	writel(status, hisi_ptt->iobase + HISI_PTT_TRACE_INT_STAT);
> +
> +	/*
> +	 * Update the AUX buffer and cache the current buffer index,
> +	 * as we need to know this and save the data when the trace
> +	 * is ended out of the interrupt handler. End the trace
> +	 * if the updating fails.
> +	 */
> +	if (hisi_ptt_update_aux(hisi_ptt, buf_idx, false))
> +		hisi_ptt_trace_end(hisi_ptt);
> +	else
> +		hisi_ptt->trace_ctrl.buf_index = (buf_idx + 1) % HISI_PTT_TRACE_BUF_CNT;
> +
> +	return IRQ_HANDLED;
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
> +		pci_err(pdev, "failed to allocate irq vector, ret = %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = devm_add_action_or_reset(&pdev->dev, hisi_ptt_irq_free_vectors, pdev);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = devm_request_threaded_irq(&pdev->dev,
> +					pci_irq_vector(pdev, HISI_PTT_TRACE_DMA_IRQ),
> +					NULL, hisi_ptt_isr, 0,
> +					DRV_NAME, hisi_ptt);
> +	if (ret) {
> +		pci_err(pdev, "failed to request irq %d, ret = %d\n",
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
> +
> +	/*
> +	 * We won't fail the probe if filter allocation failed here. The filters
> +	 * should be partial initialized and users would know which filter fails
> +	 * through the log. Other functions of PTT device are still available.
> +	 */
> +	filter = kzalloc(sizeof(*filter), GFP_KERNEL);
> +	if (!filter) {
> +		pci_err(hisi_ptt->pdev, "failed to add filter %s\n", pci_name(pdev));
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
> +	}
> +
> +	list_for_each_entry_safe(filter, tmp, &hisi_ptt->port_filters, list) {
> +		list_del(&filter->list);
> +		kfree(filter);
> +	}
> +}
> +
> +static int hisi_ptt_config_trace_buf(struct hisi_ptt *hisi_ptt)
> +{
> +	struct hisi_ptt_trace_ctrl *ctrl = &hisi_ptt->trace_ctrl;
> +	struct device *dev = &hisi_ptt->pdev->dev;
> +	int i;
> +
> +	ctrl->trace_buf = devm_kcalloc(dev, HISI_PTT_TRACE_BUF_CNT,
> +				       sizeof(*ctrl->trace_buf), GFP_KERNEL);
> +	if (!ctrl->trace_buf)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < HISI_PTT_TRACE_BUF_CNT; ++i) {
> +		ctrl->trace_buf[i].addr = dmam_alloc_coherent(dev, HISI_PTT_TRACE_BUF_SIZE,
> +							     &ctrl->trace_buf[i].dma,
> +							     GFP_KERNEL);
> +		if (!ctrl->trace_buf[i].addr)
> +			return -ENOMEM;
> +	}
> +
> +	/* Configure the trace DMA buffer */
> +	for (i = 0; i < HISI_PTT_TRACE_BUF_CNT; i++) {
> +		writel(lower_32_bits(ctrl->trace_buf[i].dma),
> +		       hisi_ptt->iobase + HISI_PTT_TRACE_ADDR_BASE_LO_0 +
> +		       i * HISI_PTT_TRACE_ADDR_STRIDE);
> +		writel(upper_32_bits(ctrl->trace_buf[i].dma),
> +		       hisi_ptt->iobase + HISI_PTT_TRACE_ADDR_BASE_HI_0 +
> +		       i * HISI_PTT_TRACE_ADDR_STRIDE);
> +	}
> +	writel(HISI_PTT_TRACE_BUF_SIZE, hisi_ptt->iobase + HISI_PTT_TRACE_ADDR_SIZE);
> +
> +	return 0;
> +}
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
> +	 * The device range register provides the information about the root
> +	 * ports which the RCiEP can control and trace. The RCiEP and the root
> +	 * ports which it supports are on the same PCIe core, with same domain
> +	 * number but maybe different bus number. The device range register
> +	 * will tell us which root ports we can support, Bit[31:16] indicates
> +	 * the upper BDF numbers of the root port, while Bit[15:0] indicates
> +	 * the lower.
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
> +static ssize_t cpumask_show(struct device *dev, struct device_attribute *attr,
> +			    char *buf)
> +{
> +	struct hisi_ptt *hisi_ptt = to_hisi_ptt(dev_get_drvdata(dev));
> +	const cpumask_t *cpumask = cpumask_of_node(dev_to_node(&hisi_ptt->pdev->dev));
> +
> +	return cpumap_print_to_pagebuf(true, buf, cpumask);
> +}
> +static DEVICE_ATTR_RO(cpumask);
> +
> +static struct attribute *hisi_ptt_cpumask_attrs[] = {
> +	&dev_attr_cpumask.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group hisi_ptt_cpumask_attr_group = {
> +	.attrs = hisi_ptt_cpumask_attrs,
> +};
> +
> +/*
> + * Bit 19 indicates the filter type, 1 for Root Port filter and 0 for Requester
> + * filter. Bit[15:0] indicates the filter value, for Root Port filter it's
> + * a bit mask of desired ports and for Requester filter it's the Requester ID
> + * of the desired PCIe function. Bit[18:16] is reserved for extension.
> + *
> + * See hisi_ptt.rst documentation for detailed information.
> + */
> +PMU_FORMAT_ATTR(filter,		"config:0-19");
> +PMU_FORMAT_ATTR(direction,	"config:20-23");
> +PMU_FORMAT_ATTR(type,		"config:24-31");
> +PMU_FORMAT_ATTR(format,		"config:32-35");
> +
> +static struct attribute *hisi_ptt_pmu_format_attrs[] = {
> +	&format_attr_filter.attr,
> +	&format_attr_direction.attr,
> +	&format_attr_type.attr,
> +	&format_attr_format.attr,
> +	NULL
> +};
> +
> +static struct attribute_group hisi_ptt_pmu_format_group = {
> +	.name = "format",
> +	.attrs = hisi_ptt_pmu_format_attrs,
> +};
> +
> +static const struct attribute_group *hisi_ptt_pmu_groups[] = {
> +	&hisi_ptt_cpumask_attr_group,
> +	&hisi_ptt_pmu_format_group,
> +	NULL
> +};
> +
> +static int hisi_ptt_trace_valid_direction(u32 val)
> +{
> +	/*
> +	 * The direction values have different effects according to the data
> +	 * format (specified in the parentheses). TLP set A/B means different
> +	 * set of TLP types. See hisi_ptt.rst documentation for more details.
> +	 */
> +	static const u32 hisi_ptt_trace_available_direction[] = {
> +		0,	/* inbound(4DW) or reserved(8DW) */
> +		1,	/* outbound(4DW) */
> +		2,	/* {in, out}bound(4DW) or inbound(8DW), TLP set A */
> +		3,	/* {in, out}bound(4DW) or inbound(8DW), TLP set B */
> +	};
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(hisi_ptt_trace_available_direction); i++) {
> +		if (val == hisi_ptt_trace_available_direction[i])
> +			return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int hisi_ptt_trace_valid_type(u32 val)
> +{
> +	/* Different types can be set simultaneously */
> +	static const u32 hisi_ptt_trace_available_type[] = {
> +		1,	/* posted_request */
> +		2,	/* non-posted_request */
> +		4,	/* completion */
> +	};
> +	int i;
> +
> +	if (!val)
> +		return -EINVAL;
> +
> +	/*
> +	 * Walk the available list and clear the valid bits of
> +	 * the config. If there is any resident bit after the
> +	 * walk then the config is invalid.
> +	 */
> +	for (i = 0; i < ARRAY_SIZE(hisi_ptt_trace_available_type); i++)
> +		val &= ~hisi_ptt_trace_available_type[i];
> +
> +	if (val)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int hisi_ptt_trace_valid_format(u32 val)
> +{
> +	static const u32 hisi_ptt_trace_availble_format[] = {
> +		0,	/* 4DW */
> +		1,	/* 8DW */
> +	};
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(hisi_ptt_trace_availble_format); i++) {
> +		if (val == hisi_ptt_trace_availble_format[i])
> +			return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int hisi_ptt_trace_valid_filter(struct hisi_ptt *hisi_ptt, u64 config)
> +{
> +	unsigned long val, port_mask = hisi_ptt->port_mask;
> +	struct hisi_ptt_filter_desc *filter;
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
> +			if (val == hisi_ptt_get_filter_val(filter->devid, filter->is_port))
> +				return 0;
> +		}
> +	} else if (bitmap_subset(&val, &port_mask, BITS_PER_LONG)) {
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static void hisi_ptt_pmu_init_configs(struct hisi_ptt *hisi_ptt, struct perf_event *event)
> +{
> +	struct hisi_ptt_trace_ctrl *ctrl = &hisi_ptt->trace_ctrl;
> +	u32 val;
> +
> +	val = FIELD_GET(HISI_PTT_PMU_FILTER_VAL_MASK, event->attr.config);
> +	hisi_ptt->trace_ctrl.filter = val;
> +
> +	val = FIELD_GET(HISI_PTT_PMU_DIRECTION_MASK, event->attr.config);
> +	ctrl->direction = val;
> +
> +	val = FIELD_GET(HISI_PTT_PMU_TYPE_MASK, event->attr.config);
> +	ctrl->type = val;
> +
> +	val = FIELD_GET(HISI_PTT_PMU_FORMAT_MASK, event->attr.config);
> +	ctrl->format = val;
> +}
> +
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
> +	return hisi_ptt_trace_valid_format(val);
> +}
> +
> +static void *hisi_ptt_pmu_setup_aux(struct perf_event *event, void **pages,
> +				    int nr_pages, bool overwrite)
> +{
> +	struct hisi_ptt_pmu_buf *buf;
> +	struct page **pagelist;
> +	int i;
> +
> +	if (overwrite) {
> +		dev_warn(event->pmu->dev, "Overwrite mode is not supported\n");
> +		return NULL;
> +	}
> +
> +	/* If the pages size less than buffers, we cannot start trace */
> +	if (nr_pages < HISI_PTT_TRACE_TOTAL_BUF_SIZE / PAGE_SIZE)
> +		return NULL;
> +
> +	buf = kzalloc(sizeof(*buf), GFP_KERNEL);
> +	if (!buf)
> +		return NULL;
> +
> +	pagelist = kcalloc(nr_pages, sizeof(*pagelist), GFP_KERNEL);
> +	if (!pagelist)
> +		goto err;
> +
> +	for (i = 0; i < nr_pages; i++)
> +		pagelist[i] = virt_to_page(pages[i]);
> +
> +	buf->base = vmap(pagelist, nr_pages, VM_MAP, PAGE_KERNEL);
> +	if (!buf->base) {
> +		kfree(pagelist);
> +		goto err;
> +	}
> +
> +	buf->nr_pages = nr_pages;
> +	buf->length = nr_pages * PAGE_SIZE;
> +	buf->pos = 0;
> +
> +	kfree(pagelist);
> +	return buf;
> +err:
> +	kfree(buf);
> +	return NULL;
> +}
> +
> +static void hisi_ptt_pmu_free_aux(void *aux)
> +{
> +	struct hisi_ptt_pmu_buf *buf = aux;
> +
> +	vunmap(buf->base);
> +	kfree(buf);
> +}
> +
> +static void hisi_ptt_pmu_start(struct perf_event *event, int flags)
> +{
> +	struct hisi_ptt *hisi_ptt = to_hisi_ptt(event->pmu);
> +	struct perf_output_handle *handle = &hisi_ptt->trace_ctrl.handle;
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct device *dev = event->pmu->dev;
> +	struct hisi_ptt_pmu_buf *buf;
> +	int cpu = event->cpu;
> +	int ret;
> +
> +	hwc->state = 0;
> +
> +	/* Serialize the perf process if user specified several CPUs */
> +	spin_lock(&hisi_ptt->pmu_lock);
> +	if (hisi_ptt->trace_ctrl.started) {
> +		dev_dbg(dev, "trace has already started\n");
> +		goto stop;
> +	}
> +
> +	/*
> +	 * Handle the interrupt on the same cpu which starts the trace to avoid
> +	 * context mismatch. Otherwise we'll trigger the WARN from the perf
> +	 * core in event_function_local().
> +	 */
> +	WARN_ON(irq_set_affinity(pci_irq_vector(hisi_ptt->pdev, HISI_PTT_TRACE_DMA_IRQ),
> +				 cpumask_of(cpu)));

If this hits, you just crashed the machine :(

Please properly recover from errors if you hit them, like this.  Don't
just give up and throw a message to userspace and watch the machine
reboot with all data lost.

Same for the other WARN_ON() instances here.  Handle the error and
report it properly up the call chain.

thanks,

greg k-h

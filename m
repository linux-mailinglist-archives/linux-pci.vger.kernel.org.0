Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C4B51501F
	for <lists+linux-pci@lfdr.de>; Fri, 29 Apr 2022 18:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376319AbiD2QEL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Apr 2022 12:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347604AbiD2QEJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Apr 2022 12:04:09 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530CC3EA9C
        for <linux-pci@vger.kernel.org>; Fri, 29 Apr 2022 09:00:46 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 7so2970833pga.12
        for <linux-pci@vger.kernel.org>; Fri, 29 Apr 2022 09:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IAKM+whz/N0t2XsPvVl4LMbON8KN+/HMOMHq1IHo8nc=;
        b=KvqwJzJ6Ka7NZ0qkVWeMKqzp+mBqG7UILub4/OOCsdtDNm93VnrYzKeKBs+e6T4pYq
         6HTVLfbjICr+RpQi5qjb57R0kwTv1fTGtNwk5TVt5D9beM0niSBwD1AvNgwmhVbfGywx
         hd0eR+Zpt+tf6RPitblFgqb+XhsaNYems2gE8dkaJOuNZWkaPI9AqBqu8WoOxTMbFXCu
         eMbUwaPF87t1an7CFmdTwaDW5Gcp5+X7nlkTEH72F086wTV7A57KPC33yYGbR14ZXBFR
         1EgVspBRGmxZ7sTdTxMBXUEN7zOuTHRC7n3vkC0e34g5cWg9q90aKZ+WCj/DP5nnapzx
         JobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IAKM+whz/N0t2XsPvVl4LMbON8KN+/HMOMHq1IHo8nc=;
        b=jpTK3EXKOcMxYIaUqol3Cg0PNwiPy4AuYWjkUvvFdBmJMsf0NwgbUxXKaHHK7YrHXA
         fP12IoCGb9TIXpZQOIf6+lHGwNibf52QL5wwCvE6JT053GhZjwy5N6+pZySwjDXQ3GI3
         ITwwfNYxMbTrcs212EWcYiJMhSAHsB0Rgfu+jog6cKN18dZzXmsqa2PNrEeWvofDVobc
         02QEF8vAMyPr3RLhmnOSHsAvX5xODqKdsRYy2D/xrSGJnr5K5c0v61e99boLf55ce/yd
         h/BNB0eOsESadAtxbNzBfSlmxQK1qzd8gcf/fdQwde9HEG59hT/ueq74JnRqDxh1N2y7
         OxGQ==
X-Gm-Message-State: AOAM531zyDtTwTmnJeL8iw8JDFguGDR8hdttFP31JSh0AfGF3e3cVDlu
        ENaiykDqGs8FYILQ3yey2yVFIg==
X-Google-Smtp-Source: ABdhPJy+cms/BSnCgVUGvfa2sixjbP5SnzyJC1dIYA4xQXVOMf7cWvXd3XRaD4wo6a0oM7HWU/vL1A==
X-Received: by 2002:a63:ec50:0:b0:39d:2d53:76e7 with SMTP id r16-20020a63ec50000000b0039d2d5376e7mr78794pgj.338.1651248045038;
        Fri, 29 Apr 2022 09:00:45 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id i23-20020a056a00225700b0050d38d0f58dsm3385438pfu.213.2022.04.29.09.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 09:00:44 -0700 (PDT)
Date:   Sat, 30 Apr 2022 00:00:33 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     gregkh@linuxfoundation.org, helgaas@kernel.org,
        alexander.shishkin@linux.intel.com, lorenzo.pieralisi@arm.com,
        will@kernel.org, mark.rutland@arm.com, mathieu.poirier@linaro.org,
        suzuki.poulose@arm.com, mike.leach@linaro.org,
        jonathan.cameron@huawei.com, daniel.thompson@linaro.org,
        joro@8bytes.org, john.garry@huawei.com,
        shameerali.kolothum.thodi@huawei.com, robin.murphy@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        coresight@lists.linaro.org, linux-pci@vger.kernel.org,
        linux-perf-users@vger.kernel.org, iommu@lists.linux-foundation.org,
        zhangshaokun@hisilicon.com, liuqi115@huawei.com,
        linuxarm@huawei.com, prime.zeng@huawei.com
Subject: Re: [PATCH v7 2/7] hwtracing: Add trace function support for
 HiSilicon PCIe Tune and Trace device
Message-ID: <20220429160033.GA650111@leoy-ThinkPad-X240s>
References: <20220407125841.3678-1-yangyicong@hisilicon.com>
 <20220407125841.3678-3-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407125841.3678-3-yangyicong@hisilicon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 07, 2022 at 08:58:36PM +0800, Yicong Yang via iommu wrote:
> HiSilicon PCIe tune and trace device(PTT) is a PCIe Root Complex integrated
> Endpoint(RCiEP) device, providing the capability to dynamically monitor and
> tune the PCIe traffic, and trace the TLP headers.
> 
> Add the driver for the device to enable the trace function. Register PMU
> device of PTT trace, then users can use trace through perf command. The
> driver makes use of perf AUX trace and support following events to
> configure the trace:
> 
> - filter: select Root port or Endpoint to trace
> - type: select the type of traced TLP headers
> - direction: select the direction of traced TLP headers
> - format: select the data format of the traced TLP headers
> 
> This patch adds the driver part of PTT trace. The perf command support of
> PTT trace is added in the following patch.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/Makefile                 |   1 +
>  drivers/hwtracing/Kconfig        |   2 +
>  drivers/hwtracing/ptt/Kconfig    |  12 +
>  drivers/hwtracing/ptt/Makefile   |   2 +
>  drivers/hwtracing/ptt/hisi_ptt.c | 874 +++++++++++++++++++++++++++++++
>  drivers/hwtracing/ptt/hisi_ptt.h | 166 ++++++
>  6 files changed, 1057 insertions(+)
>  create mode 100644 drivers/hwtracing/ptt/Kconfig
>  create mode 100644 drivers/hwtracing/ptt/Makefile
>  create mode 100644 drivers/hwtracing/ptt/hisi_ptt.c
>  create mode 100644 drivers/hwtracing/ptt/hisi_ptt.h
> 
> diff --git a/drivers/Makefile b/drivers/Makefile
> index 020780b6b4d2..662d50599467 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -175,6 +175,7 @@ obj-$(CONFIG_USB4)		+= thunderbolt/
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
> index 000000000000..8902a6f27563
> --- /dev/null
> +++ b/drivers/hwtracing/ptt/Kconfig
> @@ -0,0 +1,12 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config HISI_PTT
> +	tristate "HiSilicon PCIe Tune and Trace Device"
> +	depends on ARM64 || (COMPILE_TEST && 64BIT)
> +	depends on PCI && HAS_DMA && HAS_IOMEM && PERF_EVENTS
> +	help
> +	  HiSilicon PCIe Tune and Trace Device exists as a PCIe RCiEP
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
> index 000000000000..242b41870380
> --- /dev/null
> +++ b/drivers/hwtracing/ptt/hisi_ptt.c
> @@ -0,0 +1,874 @@
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
> +#include <linux/vmalloc.h>
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
> +static bool hisi_ptt_wait_dma_reset_done(struct hisi_ptt *hisi_ptt)
> +{
> +	u32 val;
> +
> +	return !readl_poll_timeout_atomic(hisi_ptt->iobase + HISI_PTT_TRACE_WR_STS,
> +					  val, !val, HISI_PTT_RESET_POLL_INTERVAL_US,
> +					  HISI_PTT_RESET_TIMEOUT_US);
> +}
> +
> +static void hisi_ptt_free_trace_buf(struct hisi_ptt *hisi_ptt)
> +{
> +	struct hisi_ptt_trace_ctrl *ctrl = &hisi_ptt->trace_ctrl;
> +	struct device *dev = &hisi_ptt->pdev->dev;
> +	int i;
> +
> +	if (!ctrl->trace_buf)
> +		return;
> +
> +	for (i = 0; i < HISI_PTT_TRACE_BUF_CNT; i++) {
> +		if (ctrl->trace_buf[i].addr)
> +			dmam_free_coherent(dev, HISI_PTT_TRACE_BUF_SIZE,
> +					   ctrl->trace_buf[i].addr,
> +					   ctrl->trace_buf[i].dma);
> +	}
> +
> +	devm_kfree(dev, ctrl->trace_buf);
> +	ctrl->trace_buf = NULL;
> +}
> +
> +static int hisi_ptt_alloc_trace_buf(struct hisi_ptt *hisi_ptt)
> +{
> +	struct hisi_ptt_trace_ctrl *ctrl = &hisi_ptt->trace_ctrl;
> +	struct device *dev = &hisi_ptt->pdev->dev;
> +	int i;
> +
> +	hisi_ptt->trace_ctrl.buf_index = 0;
> +
> +	/* If the trace buffer has already been allocated, zero it. */
> +	if (ctrl->trace_buf) {
> +		for (i = 0; i < HISI_PTT_TRACE_BUF_CNT; i++)
> +			memset(ctrl->trace_buf[i].addr, 0, HISI_PTT_TRACE_BUF_SIZE);
> +		return 0;
> +	}
> +
> +	ctrl->trace_buf = devm_kcalloc(dev, HISI_PTT_TRACE_BUF_CNT,
> +				       sizeof(struct hisi_ptt_dma_buffer), GFP_KERNEL);
> +	if (!ctrl->trace_buf)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < HISI_PTT_TRACE_BUF_CNT; ++i) {
> +		ctrl->trace_buf[i].addr = dmam_alloc_coherent(dev, HISI_PTT_TRACE_BUF_SIZE,
> +							     &ctrl->trace_buf[i].dma,
> +							     GFP_KERNEL);
> +		if (!ctrl->trace_buf[i].addr) {
> +			hisi_ptt_free_trace_buf(hisi_ptt);
> +			return -ENOMEM;
> +		}
> +	}
> +
> +	return 0;
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
> +	/* Clear the interrupt status */
> +	writel(HISI_PTT_TRACE_INT_STAT_MASK, hisi_ptt->iobase + HISI_PTT_TRACE_INT_STAT);
> +	writel(0, hisi_ptt->iobase + HISI_PTT_TRACE_INT_MASK);
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
> +	void *addr;
> +
> +	buf = perf_get_aux(handle);
> +	if (!buf || !handle->size)
> +		return -EINVAL;
> +
> +	addr = ctrl->trace_buf[ctrl->buf_index].addr;
> +
> +	memcpy(buf->base + buf->pos, addr, HISI_PTT_TRACE_BUF_SIZE);
> +	memset(addr, 0, HISI_PTT_TRACE_BUF_SIZE);

I am a bit worry buffer usages, at least for below aspects:

The first thing is for memset(), which cleans up the buffer and the
buffer size is 4MiB, this means it will consume much CPU time to
cleanup the buffer, and trace_buf is mapped as non-cacheable, the
performance would be get worse.

The second thing is here it always copies the trace data with size
HISI_PTT_TRACE_BUF_SIZE, usually, the trace module can provide a read
pointer register, so you can know the trace data length based on the
delta value between write and read pointers.

The last thing is the ctrl->trace_buf[] works as bounce buffer, so it
means actually there have an extra copy from bounce buffer to AUX
buffer, is it possible to directly output PTT trace data to AUX buffer?

Sorry if I bring up duplicate questions and before have the simliar
discussion when reviewed the patch.

> +	buf->pos += HISI_PTT_TRACE_BUF_SIZE;
> +
> +	if (stop) {
> +		perf_aux_output_end(handle, buf->pos);
> +	} else if (buf->length - buf->pos < HISI_PTT_TRACE_BUF_SIZE) {
> +		perf_aux_output_skip(handle, buf->length - buf->pos);
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
> +					hisi_ptt_irq, hisi_ptt_isr, 0,
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
> +	struct list_head *target_list;
> +
> +	target_list = pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT ?
> +		      &hisi_ptt->port_filters : &hisi_ptt->req_filters;
> +
> +	filter = kzalloc(sizeof(*filter), GFP_KERNEL);
> +	if (!filter) {
> +		pci_err(hisi_ptt->pdev, "failed to add filter %s\n", pci_name(pdev));
> +		return -ENOMEM;
> +	}
> +
> +	filter->pdev = pdev;
> +	list_add_tail(&filter->list, target_list);
> +
> +	/* Update the available port mask */
> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT)
> +		hisi_ptt->port_mask |= hisi_ptt_get_filter_val(pdev);
> +
> +	return 0;
> +}
> +
> +static void hisi_ptt_release_filters(void *data)
> +{
> +	struct hisi_ptt_filter_desc *filter, *tfilter;
> +	struct hisi_ptt *hisi_ptt = data;
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
> +	hisi_ptt->upper = FIELD_GET(HISI_PTT_DEVICE_RANGE_UPPER, reg);
> +	hisi_ptt->lower = FIELD_GET(HISI_PTT_DEVICE_RANGE_LOWER, reg);
> +
> +	bus = pci_find_bus(pci_domain_nr(pdev->bus), PCI_BUS_NUM(hisi_ptt->upper));
> +	if (bus)
> +		pci_walk_bus(bus, hisi_ptt_init_filters, hisi_ptt);
> +
> +	ret = devm_add_action_or_reset(&pdev->dev, hisi_ptt_release_filters, hisi_ptt);
> +	if (ret)
> +		return ret;
> +
> +	hisi_ptt->trace_ctrl.default_cpu = cpumask_first(cpumask_of_node(dev_to_node(&pdev->dev)));
> +
> +	return 0;
> +}
> +
> +#define HISI_PTT_PMU_FILTER_IS_PORT	BIT(19)
> +#define HISI_PTT_PMU_FILTER_VAL_MASK	GENMASK(15, 0)
> +#define HISI_PTT_PMU_DIRECTION_MASK	GENMASK(23, 20)
> +#define HISI_PTT_PMU_TYPE_MASK		GENMASK(31, 24)
> +#define HISI_PTT_PMU_FORMAT_MASK	GENMASK(35, 32)
> +
> +static ssize_t available_root_port_filters_show(struct device *dev,
> +						struct device_attribute *attr,
> +						char *buf)
> +{
> +	struct hisi_ptt *hisi_ptt = to_hisi_ptt(dev_get_drvdata(dev));
> +	struct hisi_ptt_filter_desc *filter;
> +	int pos = 0;
> +
> +	mutex_lock(&hisi_ptt->mutex);
> +	if (list_empty(&hisi_ptt->port_filters)) {
> +		pos = sysfs_emit(buf, "\n");
> +		goto out;
> +	}
> +
> +	list_for_each_entry(filter, &hisi_ptt->port_filters, list)
> +		pos += sysfs_emit_at(buf, pos, "%s	0x%05lx\n",
> +				     pci_name(filter->pdev),
> +				     hisi_ptt_get_filter_val(filter->pdev) |
> +				     HISI_PTT_PMU_FILTER_IS_PORT);
> +
> +out:
> +	mutex_unlock(&hisi_ptt->mutex);
> +	return pos;
> +}
> +static DEVICE_ATTR_ADMIN_RO(available_root_port_filters);
> +
> +static ssize_t available_requester_filters_show(struct device *dev,
> +						struct device_attribute *attr,
> +						char *buf)
> +{
> +	struct hisi_ptt *hisi_ptt = to_hisi_ptt(dev_get_drvdata(dev));
> +	struct hisi_ptt_filter_desc *filter;
> +	int pos = 0;
> +
> +	mutex_lock(&hisi_ptt->mutex);
> +	if (list_empty(&hisi_ptt->req_filters)) {
> +		pos = sysfs_emit(buf, "\n");
> +		goto out;
> +	}
> +
> +	list_for_each_entry(filter, &hisi_ptt->req_filters, list)
> +		pos += sysfs_emit_at(buf, pos, "%s	0x%05x\n",
> +				     pci_name(filter->pdev),
> +				     hisi_ptt_get_filter_val(filter->pdev));
> +
> +out:
> +	mutex_unlock(&hisi_ptt->mutex);
> +	return pos;
> +}
> +static DEVICE_ATTR_ADMIN_RO(available_requester_filters);
> +
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
> +static struct attribute *hisi_ptt_pmu_filter_attrs[] = {
> +	&dev_attr_available_root_port_filters.attr,
> +	&dev_attr_available_requester_filters.attr,
> +	NULL
> +};
> +
> +static struct attribute_group hisi_ptt_pmu_filter_group = {
> +	.attrs = hisi_ptt_pmu_filter_attrs,
> +};
> +
> +static const struct attribute_group *hisi_ptt_pmu_groups[] = {
> +	&hisi_ptt_pmu_format_group,
> +	&hisi_ptt_pmu_filter_group,
> +	NULL
> +};
> +
> +/*
> + * Check whether the config is valid or not. Some configs are multi-selectable
> + * and can be set simultaneously, while some are single selectable (onehot).
> + * Use this function to check the non-onehot configs while
> + * hisi_ptt_trace_valid_config_onehot() for the onehot ones.
> + */
> +static int hisi_ptt_trace_valid_config(u32 val, const u32 *available_list, u32 list_size)
> +{
> +	int i;
> +
> +	/* The non-onehot configs cannot be 0. */
> +	if (!val)
> +		return -EINVAL;
> +
> +	/*
> +	 * Walk the available list and clear the valid bits of
> +	 * the config. If there is any resident bit after the
> +	 * walk then the config is invalid.
> +	 */
> +	for (i = 0; i < list_size; i++)
> +		val &= ~available_list[i];
> +
> +	return val ? -EINVAL : 0;
> +}
> +
> +static int hisi_ptt_trace_valid_config_onehot(u32 val, const u32 *available_list, u32 list_size)
> +{
> +	int i;
> +
> +	for (i = 0; i < list_size; i++)
> +		if (val == available_list[i])
> +			return 0;
> +
> +	return -EINVAL;
> +}
> +
> +static int hisi_ptt_trace_init_filter(struct hisi_ptt *hisi_ptt, u64 config)
> +{
> +	unsigned long val, port_mask = hisi_ptt->port_mask;
> +	struct hisi_ptt_filter_desc *filter;
> +	int ret = -EINVAL;
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
> +		list_for_each_entry(filter, &hisi_ptt->req_filters, list)
> +			if (val == hisi_ptt_get_filter_val(filter->pdev)) {
> +				ret = 0;
> +				break;
> +			}
> +	} else if (bitmap_subset(&val, &port_mask, BITS_PER_LONG)) {
> +		ret = 0;
> +	}
> +
> +	if (ret)
> +		return ret;
> +
> +	hisi_ptt->trace_ctrl.filter = val;
> +	return 0;
> +}
> +
> +static int hisi_ptt_pmu_event_init(struct perf_event *event)
> +{
> +	/*
> +	 * The supported value of the direction parameter. See hisi_ptt.rst
> +	 * documentation for more details.
> +	 */
> +	static const u32 hisi_ptt_trace_available_direction[] = {
> +		0,
> +		1,
> +		2,
> +		3,
> +	};
> +	/* Different types can be set simultaneously */
> +	static const u32 hisi_ptt_trace_available_type[] = {
> +		1,	/* posted_request */
> +		2,	/* non-posted_request */
> +		4,	/* completion */
> +	};
> +	static const u32 hisi_ptt_trace_availble_format[] = {
> +		0,	/* 4DW */
> +		1,	/* 8DW */
> +	};
> +	struct hisi_ptt *hisi_ptt = to_hisi_ptt(event->pmu);
> +	struct hisi_ptt_trace_ctrl *ctrl = &hisi_ptt->trace_ctrl;
> +	int ret;
> +	u32 val;
> +
> +	if (event->attr.type != hisi_ptt->hisi_ptt_pmu.type)
> +		return -ENOENT;

Does PTT support per-task mode?  Usually PMU not binding to CPU
cannot support per-task mode, if this is the case, please add checking
like below (copied code from arm_smmuv3_pmu.c):

         if (event->cpu < 0) {
                 dev_dbg(dev, "Per-task mode not supported\n");
                 return -EOPNOTSUPP;
         }

> +
> +	mutex_lock(&hisi_ptt->mutex);

Here really need mutex for protection?  I think the question can be
extended as "if the mutex is necessary for the whole driver"?

The reason is the perf core layer has provided the APIs
perf_event_ctx_lock() and perf_event_ctx_unlock() to protect event
context, and perf core layer has the mutex 'event->mmap_mutex' to
protect setup_aux().

Please note, I think init_event() callback is not protected by lock,
so you could see many PMU drivers use init_event() callback to
validate if the event parameters (e.g. if can work as group events
with other hardware events, support stack track, etc).

This means below initialise functions should be moved to add()
or setup_aux() callbacks, since these functions have been protected by
mutex in perf core layer.

> +
> +	ret = hisi_ptt_trace_init_filter(hisi_ptt, event->attr.config);
> +	if (ret < 0)
> +		goto out;
> +
> +	val = FIELD_GET(HISI_PTT_PMU_DIRECTION_MASK, event->attr.config);
> +	ret = hisi_ptt_trace_valid_config_onehot(val, hisi_ptt_trace_available_direction,
> +						 ARRAY_SIZE(hisi_ptt_trace_available_direction));
> +	if (ret < 0)
> +		goto out;
> +	ctrl->direction = val;
> +
> +	val = FIELD_GET(HISI_PTT_PMU_TYPE_MASK, event->attr.config);
> +	ret = hisi_ptt_trace_valid_config(val, hisi_ptt_trace_available_type,
> +					  ARRAY_SIZE(hisi_ptt_trace_available_type));
> +	if (ret < 0)
> +		goto out;
> +	ctrl->type = val;
> +
> +	val = FIELD_GET(HISI_PTT_PMU_FORMAT_MASK, event->attr.config);
> +	ret = hisi_ptt_trace_valid_config_onehot(val, hisi_ptt_trace_availble_format,
> +						 ARRAY_SIZE(hisi_ptt_trace_availble_format));
> +	if (ret < 0)
> +		goto out;
> +	ctrl->format = val;
> +
> +out:
> +	mutex_unlock(&hisi_ptt->mutex);
> +	return ret;
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
> +	if (!pagelist) {
> +		kfree(buf);
> +		return NULL;
> +	}
> +
> +	for (i = 0; i < nr_pages; i++)
> +		pagelist[i] = virt_to_page(pages[i]);
> +
> +	buf->base = vmap(pagelist, nr_pages, VM_MAP, PAGE_KERNEL);
> +	if (!buf->base) {
> +		kfree(pagelist);
> +		kfree(buf);
> +		return NULL;
> +	}
> +
> +	buf->nr_pages = nr_pages;
> +	buf->length = nr_pages * PAGE_SIZE;
> +	buf->pos = 0;
> +
> +	kfree(pagelist);
> +	return buf;
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
> +	struct hisi_ptt_pmu_buf *buf;
> +	int cpu = event->cpu;
> +	int ret;
> +
> +	hwc->state = 0;
> +	mutex_lock(&hisi_ptt->mutex);
> +	if (hisi_ptt->trace_ctrl.started) {
> +		pci_dbg(hisi_ptt->pdev, "trace has already started\n");

Essentialy this is not a PCI driver, it's good to use dev_dbg()
variant in the whole driver.

> +		goto stop;
> +	}
> +
> +	if (cpu == -1)
> +		cpu = hisi_ptt->trace_ctrl.default_cpu;
> +
> +	/*
> +	 * Handle the interrupt on the same cpu which starts the trace to avoid
> +	 * context mismatch. Otherwise we'll trigger the WARN from the perf
> +	 * core in event_function_local().
> +	 */
> +	WARN_ON(irq_set_affinity(pci_irq_vector(hisi_ptt->pdev, HISI_PTT_TRACE_DMA_IRQ),
> +				 cpumask_of(cpu)));

Nitpick: Can set the irq affinity in the probe phase?  Seems to me,
the driver has enough info to set irq affinity in the probe phase,
it's not very necessary to defer to set irq affinity at here.

> +
> +	ret = hisi_ptt_alloc_trace_buf(hisi_ptt);
> +	if (ret) {
> +		pci_dbg(hisi_ptt->pdev, "alloc trace buf failed, ret = %d\n", ret);
> +		goto stop;
> +	}

It's not a good idea to allocate buffer in the start().  The reason is
start() function might be invoked for multiple times in a perf
session.  I understand the PTT driver doesn't support per-thread mode
and snapshot mode, so the start() callback will be not invoked for
multiple times, but you might need to consider if later support snapshot
mode.

I think it's better to move the buffer allocation into setup_aux().

Will continue to review the perf userspace patch.

Thanks,
Leo

> +
> +	buf = perf_aux_output_begin(handle, event);
> +	if (!buf) {
> +		pci_dbg(hisi_ptt->pdev, "aux output begin failed\n");
> +		goto stop;
> +	}
> +
> +	buf->pos = handle->head % buf->length;
> +
> +	ret = hisi_ptt_trace_start(hisi_ptt);
> +	if (ret) {
> +		pci_dbg(hisi_ptt->pdev, "trace start failed, ret = %d\n", ret);
> +		perf_aux_output_end(handle, 0);
> +		goto stop;
> +	}
> +
> +	mutex_unlock(&hisi_ptt->mutex);
> +	return;
> +stop:
> +	event->hw.state |= PERF_HES_STOPPED;
> +	mutex_unlock(&hisi_ptt->mutex);
> +}
> +
> +static void hisi_ptt_pmu_stop(struct perf_event *event, int flags)
> +{
> +	struct hisi_ptt *hisi_ptt = to_hisi_ptt(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	if (hwc->state & PERF_HES_STOPPED)
> +		return;
> +
> +	mutex_lock(&hisi_ptt->mutex);
> +	if (hisi_ptt->trace_ctrl.started) {
> +		hisi_ptt_trace_end(hisi_ptt);
> +		WARN(!hisi_ptt_wait_trace_hw_idle(hisi_ptt), "Device is still busy");
> +		hisi_ptt_update_aux(hisi_ptt, hisi_ptt->trace_ctrl.buf_index, true);
> +	}
> +	mutex_unlock(&hisi_ptt->mutex);
> +
> +	hwc->state |= PERF_HES_STOPPED;
> +	perf_event_update_userpage(event);
> +	hwc->state |= PERF_HES_UPTODATE;
> +}
> +
> +static int hisi_ptt_pmu_add(struct perf_event *event, int flags)
> +{
> +	struct hisi_ptt *hisi_ptt = to_hisi_ptt(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	int cpu = event->cpu;
> +
> +	/*
> +	 * Only allow the default cpu to add the event if user doesn't specify
> +	 * the cpus.
> +	 */
> +	if (cpu == -1 && smp_processor_id() != hisi_ptt->trace_ctrl.default_cpu)
> +		return 0;
> +
> +	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
> +
> +	if (flags & PERF_EF_START) {
> +		hisi_ptt_pmu_start(event, PERF_EF_RELOAD);
> +		if (hwc->state & PERF_HES_STOPPED)
> +			return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static void hisi_ptt_pmu_del(struct perf_event *event, int flags)
> +{
> +	hisi_ptt_pmu_stop(event, PERF_EF_UPDATE);
> +}
> +
> +static int hisi_ptt_register_pmu(struct hisi_ptt *hisi_ptt)
> +{
> +	u16 core_id, sicl_id;
> +	char *pmu_name;
> +	u32 reg;
> +
> +	hisi_ptt->hisi_ptt_pmu = (struct pmu) {
> +		.module		= THIS_MODULE,
> +		.capabilities	= PERF_PMU_CAP_EXCLUSIVE | PERF_PMU_CAP_ITRACE,
> +		.task_ctx_nr	= perf_sw_context,
> +		.attr_groups	= hisi_ptt_pmu_groups,
> +		.event_init	= hisi_ptt_pmu_event_init,
> +		.setup_aux	= hisi_ptt_pmu_setup_aux,
> +		.free_aux	= hisi_ptt_pmu_free_aux,
> +		.start		= hisi_ptt_pmu_start,
> +		.stop		= hisi_ptt_pmu_stop,
> +		.add		= hisi_ptt_pmu_add,
> +		.del		= hisi_ptt_pmu_del,
> +	};
> +
> +	reg = readl(hisi_ptt->iobase + HISI_PTT_LOCATION);
> +	core_id = FIELD_GET(HISI_PTT_CORE_ID, reg);
> +	sicl_id = FIELD_GET(HISI_PTT_SICL_ID, reg);
> +
> +	pmu_name = devm_kasprintf(&hisi_ptt->pdev->dev, GFP_KERNEL, "hisi_ptt%u_%u",
> +				  sicl_id, core_id);
> +	if (!pmu_name)
> +		return -ENOMEM;
> +
> +	return perf_pmu_register(&hisi_ptt->hisi_ptt_pmu, pmu_name, -1);
> +}
> +
> +/*
> + * The DMA of PTT trace can only use direct mapping, due to some
> + * hardware restriction. Check whether there is an IOMMU or the
> + * policy of the IOMMU domain is passthrough, otherwise the trace
> + * cannot work.
> + *
> + * The PTT device is supposed to behind the ARM SMMUv3, which
> + * should have passthrough the device by a quirk.
> + */
> +static int hisi_ptt_check_iommu_mapping(struct pci_dev *pdev)
> +{
> +	struct iommu_domain *iommu_domain;
> +
> +	iommu_domain = iommu_get_domain_for_dev(&pdev->dev);
> +	if (!iommu_domain || iommu_domain->type == IOMMU_DOMAIN_IDENTITY)
> +		return 0;
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
> +	ret = hisi_ptt_check_iommu_mapping(pdev);
> +	if (ret) {
> +		pci_err(pdev, "requires direct DMA mappings\n");
> +		return ret;
> +	}
> +
> +	hisi_ptt = devm_kzalloc(&pdev->dev, sizeof(*hisi_ptt), GFP_KERNEL);
> +	if (!hisi_ptt)
> +		return -ENOMEM;
> +
> +	mutex_init(&hisi_ptt->mutex);
> +	hisi_ptt->pdev = pdev;
> +	pci_set_drvdata(pdev, hisi_ptt);
> +
> +	ret = pcim_enable_device(pdev);
> +	if (ret) {
> +		pci_err(pdev, "failed to enable device, ret = %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = pcim_iomap_regions(pdev, BIT(2), DRV_NAME);
> +	if (ret) {
> +		pci_err(pdev, "failed to remap io memory, ret = %d\n", ret);
> +		return ret;
> +	}
> +
> +	hisi_ptt->iobase = pcim_iomap_table(pdev)[2];
> +
> +	ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
> +	if (ret) {
> +		pci_err(pdev, "failed to set 64 bit dma mask, ret = %d\n", ret);
> +		return ret;
> +	}
> +
> +	pci_set_master(pdev);
> +
> +	ret = hisi_ptt_register_irq(hisi_ptt);
> +	if (ret)
> +		return ret;
> +
> +	ret = hisi_ptt_init_ctrls(hisi_ptt);
> +	if (ret) {
> +		pci_err(pdev, "failed to init controls, ret = %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = hisi_ptt_register_pmu(hisi_ptt);
> +	if (ret) {
> +		pci_err(pdev, "failed to register PMU device, ret = %d", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void hisi_ptt_remove(struct pci_dev *pdev)
> +{
> +	struct hisi_ptt *hisi_ptt = pci_get_drvdata(pdev);
> +
> +	/*
> +	 * We have to manually unregister the PMU device rather than make it
> +	 * devres managed to keep order that the PMU device's unregistration
> +	 * is prior to the release of DMA buffers. As the DMA buffers are
> +	 * devm allocated when necessary which is after the registration of
> +	 * the PMU device.
> +	 */
> +	perf_pmu_unregister(&hisi_ptt->hisi_ptt_pmu);
> +}
> +
> +static const struct pci_device_id hisi_ptt_id_tbl[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, 0xa12e) },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(pci, hisi_ptt_id_tbl);
> +
> +static struct pci_driver hisi_ptt_driver = {
> +	.name = DRV_NAME,
> +	.id_table = hisi_ptt_id_tbl,
> +	.probe = hisi_ptt_probe,
> +	.remove = hisi_ptt_remove,
> +};
> +module_pci_driver(hisi_ptt_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Yicong Yang <yangyicong@hisilicon.com>");
> +MODULE_DESCRIPTION("Driver for HiSilicon PCIe tune and trace device");
> diff --git a/drivers/hwtracing/ptt/hisi_ptt.h b/drivers/hwtracing/ptt/hisi_ptt.h
> new file mode 100644
> index 000000000000..29b6d6293d6c
> --- /dev/null
> +++ b/drivers/hwtracing/ptt/hisi_ptt.h
> @@ -0,0 +1,166 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Driver for HiSilicon PCIe tune and trace device
> + *
> + * Copyright (c) 2022 HiSilicon Technologies Co., Ltd.
> + * Author: Yicong Yang <yangyicong@hisilicon.com>
> + */
> +
> +#ifndef _HISI_PTT_H
> +#define _HISI_PTT_H
> +
> +#include <linux/bits.h>
> +#include <linux/list.h>
> +#include <linux/mutex.h>
> +#include <linux/pci.h>
> +#include <linux/perf_event.h>
> +#include <linux/types.h>
> +
> +#define DRV_NAME "hisi_ptt"
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
> +#define   HISI_PTT_DEVICE_RANGE_UPPER	GENMASK(31, 16)
> +#define   HISI_PTT_DEVICE_RANGE_LOWER	GENMASK(15, 0)
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
> +/* Wait time for hardware DMA to reset */
> +#define HISI_PTT_RESET_TIMEOUT_US	10UL
> +#define HISI_PTT_RESET_POLL_INTERVAL_US	1UL
> +/* Poll timeout and interval for waiting hardware work to finish */
> +#define HISI_PTT_WAIT_TRACE_TIMEOUT_US	100UL
> +#define HISI_PTT_WAIT_POLL_INTERVAL_US	10UL
> +
> +#define HISI_PCIE_CORE_PORT_ID(devfn)	(PCI_FUNC(devfn) << 1)
> +
> +/**
> + * struct hisi_ptt_dma_buffer - describe a single trace buffer of PTT trace.
> + *                              The detail of the data format is described
> + *                              in the documentation of PTT device.
> + * @dma:   DMA address of this buffer visible to the device
> + * @addr:  virtual address of this buffer visible to the cpu
> + */
> +struct hisi_ptt_dma_buffer {
> +	dma_addr_t dma;
> +	void *addr;
> +};
> +
> +/**
> + * struct hisi_ptt_trace_ctrl - control and status of PTT trace
> + * @trace_buf:   array of the trace buffers for holding the trace data.
> + *               the length will be HISI_PTT_TRACE_BUF_CNT.
> + * @handle:      perf output handle of current trace session
> + * @default_cpu: default cpu to start the trace session
> + * @buf_index:   the index of current using trace buffer
> + * @started:     current trace status, true for started
> + * @is_port:     whether we're tracing root port or not
> + * @direction:   direction of the TLP headers to trace
> + * @filter:      filter value for tracing the TLP headers
> + * @format:      format of the TLP headers to trace
> + * @type:        type of the TLP headers to trace
> + */
> +struct hisi_ptt_trace_ctrl {
> +	struct hisi_ptt_dma_buffer *trace_buf;
> +	struct perf_output_handle handle;
> +	int default_cpu;
> +	u32 buf_index;
> +	bool started;
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
> + */
> +struct hisi_ptt_filter_desc {
> +	struct list_head list;
> +	struct pci_dev *pdev;
> +};
> +
> +
> +/**
> + * struct hisi_ptt_pmu_buf - descriptor of the AUX buffer of PTT trace
> + * @length:   size of the AUX buffer
> + * @nr_pages: number of pages of the AUX buffer
> + * @base:     start address of AUX buffer
> + * @pos:      position in the AUX buffer to commit traced data
> + */
> +struct hisi_ptt_pmu_buf {
> +	size_t length;
> +	int nr_pages;
> +	void *base;
> +	long pos;
> +};
> +
> +/**
> + * struct hisi_ptt - per PTT device data
> + * @trace_ctrl:   the control information of PTT trace
> + * @hisi_ptt_pmu: the pum device of trace
> + * @iobase:       base IO address of the device
> + * @pdev:         pci_dev of this PTT device
> + * @mutex:        mutex to protect the filter list and serialize the perf process.
> + * @upper:        the upper BDF range of the PCI devices managed by this PTT device
> + * @lower:        the lower BDF range of the PCI devices managed by this PTT device
> + * @port_filters: the filter list of root ports
> + * @req_filters:  the filter list of requester ID
> + * @port_mask:    port mask of the managed root ports
> + */
> +struct hisi_ptt {
> +	struct hisi_ptt_trace_ctrl trace_ctrl;
> +	struct pmu hisi_ptt_pmu;
> +	void __iomem *iobase;
> +	struct pci_dev *pdev;
> +	struct mutex mutex;
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
> +#define to_hisi_ptt(pmu) container_of(pmu, struct hisi_ptt, hisi_ptt_pmu)
> +
> +#endif /* _HISI_PTT_H */
> -- 
> 2.24.0
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu

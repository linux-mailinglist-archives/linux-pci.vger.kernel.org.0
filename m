Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24F94ABF05
	for <lists+linux-pci@lfdr.de>; Mon,  7 Feb 2022 14:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356793AbiBGNMZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Feb 2022 08:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392319AbiBGMJW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Feb 2022 07:09:22 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F733C03FEE5;
        Mon,  7 Feb 2022 04:02:24 -0800 (PST)
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jskdk473Xz67WVb;
        Mon,  7 Feb 2022 19:37:30 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 7 Feb 2022 12:42:26 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 7 Feb
 2022 11:42:24 +0000
Date:   Mon, 7 Feb 2022 11:42:23 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Yicong Yang <yangyicong@hisilicon.com>
CC:     <gregkh@linuxfoundation.org>, <helgaas@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <lorenzo.pieralisi@arm.com>,
        <will@kernel.org>, <mark.rutland@arm.com>,
        <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>, <leo.yan@linaro.org>,
        <daniel.thompson@linaro.org>, <joro@8bytes.org>,
        <john.garry@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
        <robin.murphy@arm.com>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <coresight@lists.linaro.org>, <linux-pci@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <prime.zeng@huawei.com>,
        <liuqi115@huawei.com>, <zhangshaokun@hisilicon.com>,
        <linuxarm@huawei.com>, <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH v3 1/8] hwtracing: Add trace function support for
 HiSilicon PCIe Tune and Trace device
Message-ID: <20220207114223.00001d2a@Huawei.com>
In-Reply-To: <20220124131118.17887-2-yangyicong@hisilicon.com>
References: <20220124131118.17887-1-yangyicong@hisilicon.com>
        <20220124131118.17887-2-yangyicong@hisilicon.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml733-chm.china.huawei.com (10.201.108.84) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 24 Jan 2022 21:11:11 +0800
Yicong Yang <yangyicong@hisilicon.com> wrote:

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
Hi Yicong,

I've not been following all the earlier discussion on this driver closely
so I may well raise something that has already been addressed. If so
just ignore the comment.

Thanks,

Jonathan

> ---
>  drivers/Makefile                 |   1 +
>  drivers/hwtracing/Kconfig        |   2 +
>  drivers/hwtracing/ptt/Kconfig    |  11 +
>  drivers/hwtracing/ptt/Makefile   |   2 +
>  drivers/hwtracing/ptt/hisi_ptt.c | 398 +++++++++++++++++++++++++++++++
>  drivers/hwtracing/ptt/hisi_ptt.h | 159 ++++++++++++
>  6 files changed, 573 insertions(+)
>  create mode 100644 drivers/hwtracing/ptt/Kconfig
>  create mode 100644 drivers/hwtracing/ptt/Makefile
>  create mode 100644 drivers/hwtracing/ptt/hisi_ptt.c
>  create mode 100644 drivers/hwtracing/ptt/hisi_ptt.h
> 
> diff --git a/drivers/Makefile b/drivers/Makefile
> index a110338c860c..ab3411e4eba5 100644
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
> +	  device, provides support for PCIe traffic tuning and
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

This comment is misleading as it suggests it not being empty is
a bad thing but the code handles it as an acceptable path.
Perhaps:
	/*
	 * If the trace buffer has already been allocated, zero the
	 * memory.
	 */

> +	if (!list_empty(&ctrl->trace_buf)) {
> +		list_for_each_entry(buffer, &ctrl->trace_buf, list)
> +			memset(buffer->addr, 0, buffer->size);
> +		return 0;
> +	}
> +
> +	for (i = 0; i < HISI_PTT_TRACE_BUF_CNT; ++i) {
> +		buffer = kzalloc(sizeof(*buffer), GFP_KERNEL);
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
See:
https://lore.kernel.org/lkml/20190108130701.14161-4-hch@lst.de/
dma_alloc_coherent() always zeros the memory for us hence there
is no longer a dma_kzalloc_coherent()

> +
> +		buffer->index = i;

Carrying an index inside a list which corresponds directly
to the position in the list is not particularly nice.
Why can't we compute this index on the fly where the list
is walked?  Or am I misunderstanding and the order of the buffers
is changed in a later patch?

As a side note, is a list actually appropriate when we always
have 4 of these buffers?  Feels like an array of buffer
structures might be cheaper.

> +		buffer->size = ctrl->buffer_size;
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
> +	 */
> +	mdelay(HISI_PTT_RESET_WAIT_MS);

Busy look for 1 second?  Ouch.  If we can reduce this in any way
that would be great or if there is a means to do it before
we disable preemption.

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

I comment on the use of cur->index above.  Here it would be easy to compute
the index as we go for example assuming we never end up with holes
in the list.

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

...

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
Trivial:
Perhaps worthing define HISI_PTT_DEVICE_RANGE_UPPER_MASK etc adn using
FIELD_GET?

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


...

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

Why not just use a boolean given we only have off and on states?



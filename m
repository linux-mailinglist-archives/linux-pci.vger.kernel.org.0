Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 391EB45D662
	for <lists+linux-pci@lfdr.de>; Thu, 25 Nov 2021 09:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353732AbhKYIpB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Nov 2021 03:45:01 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:28107 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353377AbhKYInB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Nov 2021 03:43:01 -0500
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4J0B7t21X3z1DJdb;
        Thu, 25 Nov 2021 16:37:14 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.20; Thu, 25 Nov 2021 16:39:47 +0800
Received: from [10.67.102.169] (10.67.102.169) by
 dggema772-chm.china.huawei.com (10.1.198.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Thu, 25 Nov 2021 16:39:47 +0800
CC:     <yangyicong@hisilicon.com>, <gregkh@linuxfoundation.org>,
        <helgaas@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <lorenzo.pieralisi@arm.com>, <will@kernel.org>,
        <mark.rutland@arm.com>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>, <leo.yan@linaro.org>,
        <jonathan.cameron@huawei.com>, <daniel.thompson@linaro.org>,
        <joro@8bytes.org>, <john.garry@huawei.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <coresight@lists.linaro.org>, <linux-pci@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <prime.zeng@huawei.com>,
        <liuqi115@huawei.com>, <zhangshaokun@hisilicon.com>,
        <linuxarm@huawei.com>, <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH v2 2/6] hwtracing: Add trace function support for
 HiSilicon PCIe Tune and Trace device
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
References: <20211116090625.53702-1-yangyicong@hisilicon.com>
 <20211116090625.53702-3-yangyicong@hisilicon.com>
 <20211124185145.GB35341@p14s>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <904f8bda-5bc6-0d0e-5187-656bcd4fd8ae@hisilicon.com>
Date:   Thu, 25 Nov 2021 16:39:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20211124185145.GB35341@p14s>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Mathieu,

Thanks for the comments! Replies inline.

On 2021/11/25 2:51, Mathieu Poirier wrote:
> Hi Yicong,
> 
> On Tue, Nov 16, 2021 at 05:06:21PM +0800, Yicong Yang wrote:
>> HiSilicon PCIe tune and trace device(PTT) is a PCIe Root Complex
>> integrated Endpoint(RCiEP) device, providing the capability
>> to dynamically monitor and tune the PCIe traffic(tune),
>> and trace the TLP headers(trace).
>>
> 
> Is there a reason to put "tune" and "trace" are whithin parentheses?  
> 

yeah. I want to use these single word to denote the related function, and
place them in the parantheses near the function's description to make sure
readers can match them.

>> Add the driver for the device to enable the trace function. The driver
>> will create PMU device for each PTT device, and users can start trace
>> through perf command.
>>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
>>  drivers/Makefile                       |    1 +
>>  drivers/hwtracing/Kconfig              |    2 +
>>  drivers/hwtracing/hisilicon/Kconfig    |    8 +
>>  drivers/hwtracing/hisilicon/Makefile   |    2 +
>>  drivers/hwtracing/hisilicon/hisi_ptt.c | 1146 ++++++++++++++++++++++++
> 
> Not sure about the "hisilicon" directory.  Right now we have "coresight",
> "intel_th" and "stm" - they concentrate on the technology rather than the
> vendor.  I think "ptt" would be just fine: 
> 
> drivers/hwtracing/ptt/Kconfig 
> drivers/hwtracing/ptt/Makefile
> drivers/hwtracing/ptt/hisi_ptt.c
> 
> That way if other vendors want to introduce support for the same kind of
> technology we can simply put them under "drivers/hwtracing/ptt/" and things are
> still accurate.
> 

sure. sounds sensible. will rename the directory to "ptt" if no objection.

> 
>>  5 files changed, 1159 insertions(+)
>>  create mode 100644 drivers/hwtracing/hisilicon/Kconfig
>>  create mode 100644 drivers/hwtracing/hisilicon/Makefile
>>  create mode 100644 drivers/hwtracing/hisilicon/hisi_ptt.c
>>
>> diff --git a/drivers/Makefile b/drivers/Makefile
>> index be5d40ae1488..bb0dc9b55ea2 100644
>> --- a/drivers/Makefile
>> +++ b/drivers/Makefile
>> @@ -176,6 +176,7 @@ obj-$(CONFIG_USB4)		+= thunderbolt/
>>  obj-$(CONFIG_CORESIGHT)		+= hwtracing/coresight/
>>  obj-y				+= hwtracing/intel_th/
>>  obj-$(CONFIG_STM)		+= hwtracing/stm/
>> +obj-$(CONFIG_HISI_PTT)         += hwtracing/hisilicon/
>>  obj-$(CONFIG_ANDROID)		+= android/
>>  obj-$(CONFIG_NVMEM)		+= nvmem/
>>  obj-$(CONFIG_FPGA)		+= fpga/
>> diff --git a/drivers/hwtracing/Kconfig b/drivers/hwtracing/Kconfig
>> index 13085835a636..e3796b17541a 100644
>> --- a/drivers/hwtracing/Kconfig
>> +++ b/drivers/hwtracing/Kconfig
>> @@ -5,4 +5,6 @@ source "drivers/hwtracing/stm/Kconfig"
>>  
>>  source "drivers/hwtracing/intel_th/Kconfig"
>>  
>> +source "drivers/hwtracing/hisilicon/Kconfig"
>> +
>>  endmenu
>> diff --git a/drivers/hwtracing/hisilicon/Kconfig b/drivers/hwtracing/hisilicon/Kconfig
>> new file mode 100644
>> index 000000000000..9c3ab80d99fe
>> --- /dev/null
>> +++ b/drivers/hwtracing/hisilicon/Kconfig
>> @@ -0,0 +1,8 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +config HISI_PTT
>> +	tristate "HiSilicon PCIe Tune and Trace Device"
>> +	depends on PCI && HAS_DMA && HAS_IOMEM
> 
> What Arm architecture are you aiming this for?  Can it be found on both armv7
> and armv8?
> 

currently the device will appear on Kunpeng 930, which is armv8.

>> +	help
>> +	  HiSilicon PCIe Tune and Trace Device exist as a PCIe RCiEP
>> +	  device, provides support for PCIe traffic tuning and
>> +	  tracing TLP headers to the memory.
> 
> Please indicate what the name of the driver will be when compiled as a module.
> 

sure. will add the module's name here.

>> diff --git a/drivers/hwtracing/hisilicon/Makefile b/drivers/hwtracing/hisilicon/Makefile
>> new file mode 100644
>> index 000000000000..908c09a98161
>> --- /dev/null
>> +++ b/drivers/hwtracing/hisilicon/Makefile
>> @@ -0,0 +1,2 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +obj-$(CONFIG_HISI_PTT) += hisi_ptt.o
>> diff --git a/drivers/hwtracing/hisilicon/hisi_ptt.c b/drivers/hwtracing/hisilicon/hisi_ptt.c
>> new file mode 100644
>> index 000000000000..e11e9b6cc2a8
>> --- /dev/null
>> +++ b/drivers/hwtracing/hisilicon/hisi_ptt.c
>> @@ -0,0 +1,1146 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Driver for HiSilicon PCIe tune and trace device
>> + *
>> + * Copyright (c) 2021 HiSilicon Limited.
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
>> +#include <linux/kfifo.h>
>> +#include <linux/module.h>
>> +#include <linux/notifier.h>
>> +#include <linux/pci.h>
>> +#include <linux/perf_event.h>
>> +#include <linux/sizes.h>
>> +#include <linux/sysfs.h>
>> +#include <linux/vmalloc.h>
>> +#include <linux/workqueue.h>
>> +
>> +#define HISI_PTT_TRACE_ADDR_SIZE	0x0800
>> +#define HISI_PTT_TRACE_ADDR_BASE_LO_0	0x0810
>> +#define HISI_PTT_TRACE_ADDR_BASE_HI_0	0x0814
>> +#define HISI_PTT_TRACE_ADDR_STRIDE	0x8
>> +#define HISI_PTT_TRACE_CTRL		0x0850
>> +#define   HISI_PTT_TRACE_CTRL_EN	BIT(0)
>> +#define   HISI_PTT_TRACE_CTRL_RST	BIT(1)
>> +#define   HISI_PTT_TRACE_CTRL_RXTX_SEL	GENMASK(3, 2)
>> +#define   HISI_PTT_TRACE_CTRL_TYPE_SEL	GENMASK(7, 4)
>> +#define   HISI_PTT_TRACE_CTRL_DATA_FORMAT	BIT(14)
>> +#define   HISI_PTT_TRACE_CTRL_FILTER_MODE	BIT(15)
>> +#define   HISI_PTT_TRACE_CTRL_TARGET_SEL	GENMASK(31, 16)
>> +#define HISI_PTT_TRACE_INT_STAT		0x0890
>> +#define   HISI_PTT_TRACE_INT_STAT_MASK	GENMASK(3, 0)
>> +#define HISI_PTT_TRACE_INT_MASK		0x0894
>> +#define HISI_PTT_TRACE_WR_STS		0x08a0
>> +#define   HISI_PTT_TRACE_WR_STS_WRITE	GENMASK(27, 0)
>> +#define   HISI_PTT_TRACE_WR_STS_BUFFER	GENMASK(29, 28)
>> +#define HISI_PTT_TRACE_STS		0x08b0
>> +#define   HISI_PTT_TRACE_IDLE		BIT(0)
>> +#define HISI_PTT_DEVICE_RANGE		0x0fe0
>> +#define HISI_PTT_LOCATION		0x0fe8
>> +#define   HISI_PTT_CORE_ID		GENMASK(15, 0)
>> +#define   HISI_PTT_SICL_ID		GENMASK(31, 16)
> 
> Extra spaces between #define and the literals.  Please align the values with
> that of HISI_PTT_TRACE_DMA_IRQ below.
> 

Spaces are intended to distinguish the definition of the register offset and
related register fields. also used in include/uapi/linux/pci_regs.h.

HISI_PTT_TRACE_DMA_IRQ is well aligned with tab but seems with problem display
in the mail text, maybe because the tab is not 8 characters when display.

>> +
>> +#define HISI_PTT_TRACE_DMA_IRQ			0
>> +#define HISI_PTT_TRACE_BUFLETS_CNT		4
>> +#define HISI_PTT_TRACE_BUFLET_SIZE		SZ_4M
>> +#define HISI_PTT_TRACE_BUFFER_SIZE		(HISI_PTT_TRACE_BUFLET_SIZE * \
>> +						 HISI_PTT_TRACE_BUFLETS_CNT)
>> +#define HISI_PTT_FILTER_UPDATE_FIFO_SIZE	16
>> +
>> +/* Delay time for filter updating work */
>> +#define HISI_PTT_WORK_DELAY_MS		100UL
>> +/* Wait time for DMA hardware to reset */
>> +#define HISI_PTT_RESET_WAIT_MS		1000UL
>> +/* Poll timeout and interval for waiting hardware work to finish */
>> +#define HISI_PTT_WAIT_TIMEOUT_US	1000000UL
>> +#define HISI_PTT_WAIT_POLL_INTERVAL_US	100UL
>> +
>> +#define HISI_PCIE_CORE_PORT_ID(devfn)	(PCI_FUNC(devfn) << 1)
>> +
>> +enum hisi_ptt_trace_status {
>> +	HISI_PTT_TRACE_STATUS_OFF = 0,
>> +	HISI_PTT_TRACE_STATUS_ON,
>> +};
>> +
>> +struct hisi_ptt_dma_buflet {
> 
> I'm not sure what a "buflet" is...  Probably best to just call this
> hisi_ptt_dma_buffer" if it pertains to a buffer.  On that note it is hard to
> know due to the lack of proper structure documentation.  Please have a look at
> how "coresight_device" is documented.  The same applies to the rest of the
> structures declared below.
> 

It's mentioned in section 5 of hisi_ptt.rst as "Driver will allocate each DMA buffer
(we call it buflet) of 4MiB ...".

The total DMA buffer of PTT device is divided into 4 parts, and each part is called
a 'buflet', which means a small buffer (there exists other words with similiar
format: droplet, wavelet, ...).

The device is designed like this to make sure we won't lose any data when we have to change
the buffer address, the device can continue to write to the next buflet and don't
neet to pause.

>> +	struct list_head list;
>> +	unsigned int size;
>> +	dma_addr_t dma;
>> +
>> +	/*
>> +	 * The address of the buflet holding the trace data.
>> +	 * See Documentation/trace/hisi-ptt.rst for the details
> 
> As of this writing, hisi-ptt.rst doesn't exist.
> 

The comment intends to direct the user to the documentation if the user
want to know details about the data format. The data format is decribed
in the section 4 of the doc.

>> +	 * of the data format.
>> +	 */
>> +	void *addr;
>> +	int index;
>> +};
>> +
>> +struct hisi_ptt_trace_ctrl {
>> +	enum hisi_ptt_trace_status status;
>> +	struct perf_output_handle handle;
>> +	struct list_head trace_buf;
>> +	/*
>> +	 * The index of the buffer which trace data
>> +	 * currently is writing to.
>> +	 */
>> +	u32 buf_index;
>> +
>> +	int default_cpu;
>> +	u32 buflet_size;
>> +	bool is_port;
>> +	u32 format:1;		/* Format of the traced TLP headers */
>> +	u32 type:4;		/* Type of the TLP headers to trace */
>> +	u32 direction:2;	/* Direction of the TLP headers to trace */
>> +	u32 filter:16;		/* Root port or Requester to filter the TLP headers */
>> +
>> +	phys_addr_t rmr_addr;
>> +	size_t rmr_length;
>> +	bool has_rmr;
>> +};
>> +
>> +struct hisi_ptt_filter_desc {
>> +	struct list_head list;
>> +	struct pci_dev *pdev;
>> +	u16 val;
>> +};
>> +
>> +struct hisi_ptt_pmu_buf {
>> +	size_t length;
>> +	int nr_pages;
>> +	void *base;
>> +	long pos;
>> +};
>> +
>> +/* Structure containing the information for filter updating */
>> +struct hisi_ptt_filter_update_info {
>> +	struct pci_dev *pdev;
>> +	u32 port_devid;
>> +	bool is_port;
>> +	bool is_add;
>> +	u16 val;
>> +};
>> +
>> +struct hisi_ptt {
>> +	struct hisi_ptt_trace_ctrl trace_ctrl;
>> +	struct notifier_block hisi_ptt_nb;
>> +	struct pmu hisi_ptt_pmu;
>> +	void __iomem *iobase;
>> +	struct pci_dev *pdev;
>> +	/*
>> +	 * Use the mutex to protect the filter list and
>> +	 * serialize the perf process.
>> +	 */
>> +	struct mutex mutex;
>> +	const char *name;
>> +	u16 core_id;
>> +	u16 sicl_id;
>> +	/* PCI device range managed by the PTT device */
>> +	u32 upper;
>> +	u32 lower;
>> +	u8 busnr;
>> +
>> +	/*
>> +	 * The trace TLP headers can either be filtered by certain
>> +	 * root port, or by the requester ID. Organize the filters
>> +	 * by @port_filters and @req_filters here. The mask of all
>> +	 * the valid ports is also cached for doing sanity check
>> +	 * of user input.
>> +	 */
>> +	struct list_head port_filters;
>> +	struct list_head req_filters;
>> +	u16 port_mask;
>> +
>> +	/*
>> +	 * We use a delayed work here to avoid indefinitely waiting for
>> +	 * the hisi_ptt->mutex which protecting the filter list. The
>> +	 * work will be delayed only if the mutex can not be held,
>> +	 * otherwise no delay will be applied.
>> +	 */
>> +	struct delayed_work work;
>> +	spinlock_t filter_update_lock;
>> +	DECLARE_KFIFO(filter_update_kfifo, struct hisi_ptt_filter_update_info,
>> +		      HISI_PTT_FILTER_UPDATE_FIFO_SIZE);
>> +};
> 
> It might be a good idea to spinoff a hisi_ptt.h for the above declarations.
> 

I'm not sure whether it is common or permitted to provide a header which is only used by
this driver with a single file.

>> +
>> +static inline struct hisi_ptt *to_hisi_ptt(struct pmu *pmu)
>> +{
>> +	return container_of(pmu, struct hisi_ptt, hisi_ptt_pmu);
>> +}
> 
> I'm not sure there is any value to this inline function.  I suggest to simply
> call container_of() whenever it is needed.
> 

ok.

>> +
>> +static u16 hisi_ptt_get_filter_val(struct pci_dev *pdev)
>> +{
>> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT)
>> +		return BIT(HISI_PCIE_CORE_PORT_ID(PCI_SLOT(pdev->devfn)));
>> +
>> +	return PCI_DEVID(pdev->bus->number, pdev->devfn);
>> +}
>> +
>> +static int hisi_ptt_wait_trace_hw_idle(struct hisi_ptt *hisi_ptt)
>> +{
>> +	u32 val;
>> +
>> +	return readl_poll_timeout(hisi_ptt->iobase + HISI_PTT_TRACE_STS, val,
>> +				  val & HISI_PTT_TRACE_IDLE,
>> +				  HISI_PTT_WAIT_POLL_INTERVAL_US,
>> +				  HISI_PTT_WAIT_TIMEOUT_US);
>> +}
>> +
>> +static void hisi_ptt_free_trace_buf(struct hisi_ptt *hisi_ptt)
>> +{
>> +	struct hisi_ptt_trace_ctrl *ctrl = &hisi_ptt->trace_ctrl;
>> +	struct device *dev = &hisi_ptt->pdev->dev;
>> +	struct hisi_ptt_dma_buflet *buflet, *tbuflet;
>> +
>> +	list_for_each_entry_safe(buflet, tbuflet, &ctrl->trace_buf, list) {
>> +		list_del(&buflet->list);
>> +
>> +		if (ctrl->has_rmr)
>> +			memunmap(buflet->addr);
>> +		else
>> +			dma_free_coherent(dev, buflet->size, buflet->addr,
>> +					  buflet->dma);
>> +
>> +		kfree(buflet);
>> +	}
>> +}
>> +
>> +static int hisi_ptt_alloc_trace_buf(struct hisi_ptt *hisi_ptt)
>> +{
>> +	struct hisi_ptt_trace_ctrl *ctrl = &hisi_ptt->trace_ctrl;
>> +	struct device *dev = &hisi_ptt->pdev->dev;
>> +	struct hisi_ptt_dma_buflet *buflet;
>> +	int i, ret;
>> +
>> +	hisi_ptt->trace_ctrl.buf_index = 0;
>> +
>> +	/* Make sure the trace buffer is empty before allocating */
>> +	if (!list_empty(&ctrl->trace_buf)) {
>> +		list_for_each_entry(buflet, &ctrl->trace_buf, list)
>> +			memset(buflet->addr, 0, buflet->size);
>> +		return 0;
>> +	}
>> +
>> +	for (i = 0; i < HISI_PTT_TRACE_BUFLETS_CNT; ++i) {
>> +		buflet = kzalloc(sizeof(*buflet), GFP_KERNEL);
>> +		if (!buflet) {
>> +			ret = -ENOMEM;
>> +			goto err;
>> +		}
>> +
>> +		if (ctrl->has_rmr) {
>> +			phys_addr_t base = ctrl->rmr_addr + i * ctrl->buflet_size;
>> +
>> +			buflet->dma = base;
>> +			buflet->addr = memremap(base, ctrl->buflet_size, MEMREMAP_WB);
>> +		} else {
>> +			buflet->addr = dma_alloc_coherent(dev, ctrl->buflet_size,
>> +							  &buflet->dma, GFP_KERNEL);
>> +		}
>> +
>> +		if (!buflet->addr) {
>> +			kfree(buflet);
>> +			ret = -ENOMEM;
>> +			goto err;
>> +		}
>> +
>> +		memset(buflet->addr, 0, buflet->size);
>> +
>> +		buflet->index = i;
>> +		buflet->size = ctrl->buflet_size;
>> +		list_add_tail(&buflet->list, &ctrl->trace_buf);
>> +	}
>> +
>> +	return 0;
>> +err:
>> +	hisi_ptt_free_trace_buf(hisi_ptt);
>> +	return ret;
>> +}
>> +
>> +static void hisi_ptt_trace_end(struct hisi_ptt *hisi_ptt)
>> +{
>> +	writel(0, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
>> +	hisi_ptt->trace_ctrl.status = HISI_PTT_TRACE_STATUS_OFF;
>> +}
>> +
>> +static int hisi_ptt_trace_start(struct hisi_ptt *hisi_ptt)
>> +{
>> +	struct hisi_ptt_trace_ctrl *ctrl = &hisi_ptt->trace_ctrl;
>> +	struct hisi_ptt_dma_buflet *cur;
>> +	u32 val;
>> +
>> +	/* Check device idle before start trace */
>> +	if (hisi_ptt_wait_trace_hw_idle(hisi_ptt)) {
>> +		pci_err(hisi_ptt->pdev, "Failed to start trace, the device is still busy.\n");
>> +		return -EBUSY;
>> +	}
>> +
>> +	/* Reset the DMA before start tracing */
>> +	val = readl(hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
>> +	val |= HISI_PTT_TRACE_CTRL_RST;
>> +	writel(val, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
>> +
>> +	/*
>> +	 * We'll be in the perf context where preemption is disabled,
>> +	 * so use busy loop here.
>> +	 */
>> +	mdelay(HISI_PTT_RESET_WAIT_MS);
>> +
>> +	val = readl(hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
>> +	val &= ~HISI_PTT_TRACE_CTRL_RST;
>> +	writel(val, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
>> +
>> +	/* clear the interrupt status */
>> +	writel(HISI_PTT_TRACE_INT_STAT_MASK, hisi_ptt->iobase + HISI_PTT_TRACE_INT_STAT);
>> +	writel(0, hisi_ptt->iobase + HISI_PTT_TRACE_INT_MASK);
>> +
>> +	list_for_each_entry(cur, &ctrl->trace_buf, list) {
>> +		writel(lower_32_bits(cur->dma),
>> +		       hisi_ptt->iobase + HISI_PTT_TRACE_ADDR_BASE_LO_0 +
>> +		       cur->index * HISI_PTT_TRACE_ADDR_STRIDE);
>> +		writel(upper_32_bits(cur->dma),
>> +		       hisi_ptt->iobase + HISI_PTT_TRACE_ADDR_BASE_HI_0 +
>> +		       cur->index * HISI_PTT_TRACE_ADDR_STRIDE);
>> +	}
>> +	writel(ctrl->buflet_size, hisi_ptt->iobase + HISI_PTT_TRACE_ADDR_SIZE);
>> +
>> +	/* set the trace control register */
>> +	val = FIELD_PREP(HISI_PTT_TRACE_CTRL_TYPE_SEL, ctrl->type);
>> +	val |= FIELD_PREP(HISI_PTT_TRACE_CTRL_RXTX_SEL, ctrl->direction);
>> +	val |= FIELD_PREP(HISI_PTT_TRACE_CTRL_DATA_FORMAT, ctrl->format);
>> +	val |= FIELD_PREP(HISI_PTT_TRACE_CTRL_TARGET_SEL, hisi_ptt->trace_ctrl.filter);
>> +	if (!hisi_ptt->trace_ctrl.is_port)
>> +		val |= HISI_PTT_TRACE_CTRL_FILTER_MODE;
>> +
>> +	val |= HISI_PTT_TRACE_CTRL_EN;
>> +	writel(val, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
>> +
>> +	ctrl->status = HISI_PTT_TRACE_STATUS_ON;
>> +
>> +	return 0;
>> +}
>> +
>> +static int hisi_ptt_update_aux(struct hisi_ptt *hisi_ptt, int index, bool stop)
>> +{
>> +	struct perf_output_handle *handle = &hisi_ptt->trace_ctrl.handle;
>> +	struct perf_event *event = handle->event;
>> +	struct hisi_ptt_dma_buflet *cur;
>> +	struct hisi_ptt_pmu_buf *buf;
>> +
>> +	buf = perf_get_aux(handle);
>> +	if (!buf || !handle->size)
>> +		return -EINVAL;
>> +
>> +	list_for_each_entry(cur, &hisi_ptt->trace_ctrl.trace_buf, list)
>> +		if (cur->index == index)
>> +			break;
>> +
>> +	memcpy(buf->base + buf->pos, cur->addr, cur->size);
>> +	memset(cur->addr, 0, cur->size);
>> +	buf->pos += cur->size;
>> +
>> +	if (stop) {
>> +		perf_aux_output_end(handle, buf->pos);
>> +	} else if (buf->length - buf->pos < cur->size) {
>> +		perf_aux_output_skip(handle, buf->length - buf->pos);
>> +		perf_aux_output_end(handle, buf->pos);
>> +
>> +		buf = perf_aux_output_begin(handle, event);
>> +		if (!buf)
>> +			return -EINVAL;
>> +
>> +		buf->pos = handle->head % buf->length;
>> +		if (buf->length - buf->pos < cur->size) {
>> +			perf_aux_output_end(handle, 0);
>> +			return -EINVAL;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static irqreturn_t hisi_ptt_isr(int irq, void *context)
>> +{
>> +	struct hisi_ptt *hisi_ptt = context;
>> +	u32 status, buf_idx;
>> +
>> +	status = readl(hisi_ptt->iobase + HISI_PTT_TRACE_INT_STAT);
>> +	buf_idx = ffs(status) - 1;
>> +
>> +	/* Clear the interrupt status of buflet @buf_idx */
>> +	writel(status, hisi_ptt->iobase + HISI_PTT_TRACE_INT_STAT);
>> +
>> +	/*
>> +	 * Update the AUX buffer and cache the current buflet index,
>> +	 * as we need to know this and save the data when the trace
>> +	 * is ended out of the interrupt handler. End the trace
>> +	 * if the updating fails.
>> +	 */
>> +	if (hisi_ptt_update_aux(hisi_ptt, buf_idx, false))
>> +		hisi_ptt_trace_end(hisi_ptt);
>> +	else
>> +		hisi_ptt->trace_ctrl.buf_index = (buf_idx + 1) % HISI_PTT_TRACE_BUFLETS_CNT;
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static irqreturn_t hisi_ptt_irq(int irq, void *context)
>> +{
>> +	struct hisi_ptt *hisi_ptt = context;
>> +	u32 status;
>> +
>> +	status = readl(hisi_ptt->iobase + HISI_PTT_TRACE_INT_STAT);
>> +	if (!(status & HISI_PTT_TRACE_INT_STAT_MASK))
>> +		return IRQ_NONE;
>> +
>> +	return IRQ_WAKE_THREAD;
>> +}
>> +
>> +static void hisi_ptt_irq_free_vectors(void *pdev)
>> +{
>> +	pci_free_irq_vectors(pdev);
>> +}
>> +
>> +static int hisi_ptt_register_irq(struct hisi_ptt *hisi_ptt)
>> +{
>> +	struct pci_dev *pdev = hisi_ptt->pdev;
>> +	int ret;
>> +
>> +	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI);
>> +	if (ret < 0) {
>> +		pci_err(pdev, "failed to allocate irq vector, ret = %d.\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = devm_add_action_or_reset(&pdev->dev, hisi_ptt_irq_free_vectors, pdev);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret = devm_request_threaded_irq(&pdev->dev,
>> +					pci_irq_vector(pdev, HISI_PTT_TRACE_DMA_IRQ),
>> +					hisi_ptt_irq, hisi_ptt_isr, 0,
>> +					"hisi-ptt", hisi_ptt);
>> +	if (ret) {
>> +		pci_err(pdev, "failed to request irq %d, ret = %d.\n",
>> +			pci_irq_vector(pdev, HISI_PTT_TRACE_DMA_IRQ), ret);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void hisi_ptt_update_filters(struct work_struct *work)
>> +{
>> +	struct delayed_work *delayed_work = to_delayed_work(work);
>> +	struct hisi_ptt_filter_update_info info;
>> +	struct hisi_ptt_filter_desc *filter;
>> +	struct list_head *target_list;
>> +	struct hisi_ptt *hisi_ptt;
>> +
>> +	hisi_ptt = container_of(delayed_work, struct hisi_ptt, work);
>> +
>> +	if (!mutex_trylock(&hisi_ptt->mutex)) {
>> +		schedule_delayed_work(&hisi_ptt->work, HISI_PTT_WORK_DELAY_MS);
>> +		return;
>> +	}
>> +
>> +	while (kfifo_get(&hisi_ptt->filter_update_kfifo, &info)) {
>> +		target_list = info.is_port ? &hisi_ptt->port_filters :
>> +			      &hisi_ptt->req_filters;
>> +
>> +		if (info.is_add) {
>> +			filter = kzalloc(sizeof(*filter), GFP_KERNEL);
>> +			if (!filter)
>> +				continue;
>> +
>> +			filter->pdev = info.pdev;
>> +			filter->val = info.val;
>> +
>> +			list_add_tail(&filter->list, target_list);
>> +		} else {
>> +			list_for_each_entry(filter, target_list, list)
>> +				if (filter->val == info.val) {
>> +					list_del(&filter->list);
>> +					kfree(filter);
>> +					break;
>> +				}
>> +		}
>> +
>> +		/* Update the available port mask */
>> +		if (!info.is_port)
>> +			continue;
>> +
>> +		if (info.is_add)
>> +			hisi_ptt->port_mask |= info.val;
>> +		else
>> +			hisi_ptt->port_mask &= ~info.val;
>> +	}
>> +
>> +	mutex_unlock(&hisi_ptt->mutex);
>> +}
>> +
>> +static void hisi_ptt_update_fifo_in(struct hisi_ptt *hisi_ptt,
>> +				    struct hisi_ptt_filter_update_info *info)
>> +{
>> +	struct pci_dev *root_port = pcie_find_root_port(info->pdev);
>> +
>> +	if (!root_port)
>> +		return;
>> +
>> +	info->port_devid = PCI_DEVID(root_port->bus->number, root_port->devfn);
>> +	if (info->port_devid < hisi_ptt->lower ||
>> +	    info->port_devid > hisi_ptt->upper)
>> +		return;
>> +
>> +	info->is_port = pci_pcie_type(info->pdev) == PCI_EXP_TYPE_ROOT_PORT;
>> +	info->val = hisi_ptt_get_filter_val(info->pdev);
>> +
>> +	if (kfifo_in_spinlocked(&hisi_ptt->filter_update_kfifo, info, 1,
>> +				&hisi_ptt->filter_update_lock))
>> +		schedule_delayed_work(&hisi_ptt->work, 0);
>> +	else
>> +		pci_warn(hisi_ptt->pdev,
>> +			 "filter update fifo overflow for target %s\n",
>> +			 pci_name(info->pdev));
>> +}
>> +
>> +/*
>> + * A PCI bus notifier is used here for dynamically updating the filter
>> + * list.
>> + */
>> +static int hisi_ptt_notifier_call(struct notifier_block *nb, unsigned long action,
>> +				  void *data)
>> +{
>> +	struct hisi_ptt *hisi_ptt = container_of(nb, struct hisi_ptt, hisi_ptt_nb);
>> +	struct hisi_ptt_filter_update_info info;
>> +	struct device *dev = data;
>> +	struct pci_dev *pdev = to_pci_dev(dev);
>> +
>> +	info.pdev = pdev;
>> +
>> +	switch (action) {
>> +	case BUS_NOTIFY_ADD_DEVICE:
>> +		info.is_add = true;
>> +		break;
>> +	case BUS_NOTIFY_DEL_DEVICE:
>> +		info.is_add = false;
>> +		break;
>> +	default:
>> +		return 0;
>> +	}
>> +
>> +	hisi_ptt_update_fifo_in(hisi_ptt, &info);
>> +
>> +	return 0;
>> +}
>> +
>> +static int hisi_ptt_init_filters(struct pci_dev *pdev, void *data)
>> +{
>> +	struct hisi_ptt_filter_update_info info = {
>> +		.pdev = pdev,
>> +		.is_add = true,
>> +	};
>> +	struct hisi_ptt *hisi_ptt = data;
>> +
>> +	hisi_ptt_update_fifo_in(hisi_ptt, &info);
>> +
>> +	return 0;
>> +}
>> +
>> +static void hisi_ptt_release_filters(struct hisi_ptt *hisi_ptt)
>> +{
>> +	struct hisi_ptt_filter_desc *filter, *tfilter;
>> +
>> +	list_for_each_entry_safe(filter, tfilter, &hisi_ptt->req_filters, list) {
>> +		list_del(&filter->list);
>> +		kfree(filter);
>> +	}
>> +
>> +	list_for_each_entry_safe(filter, tfilter, &hisi_ptt->port_filters, list) {
>> +		list_del(&filter->list);
>> +		kfree(filter);
>> +	}
>> +}
>> +
>> +static void hisi_ptt_init_ctrls(struct hisi_ptt *hisi_ptt)
>> +{
>> +	struct pci_dev *pdev = hisi_ptt->pdev;
>> +	struct pci_bus *bus;
>> +	u32 reg;
>> +
>> +	INIT_DELAYED_WORK(&hisi_ptt->work, hisi_ptt_update_filters);
>> +	spin_lock_init(&hisi_ptt->filter_update_lock);
>> +	INIT_KFIFO(hisi_ptt->filter_update_kfifo);
>> +	INIT_LIST_HEAD(&hisi_ptt->port_filters);
>> +	INIT_LIST_HEAD(&hisi_ptt->req_filters);
>> +
>> +	/*
>> +	 * The device range register provides the information about the
>> +	 * root ports which the RCiEP can control and trace. The RCiEP
>> +	 * and the root ports it support are on the same PCIe core, with
>> +	 * same domain number but maybe different bus number. The device
>> +	 * range register will tell us which root ports we can support,
>> +	 * Bit[31:16] indicates the upper BDF numbers of the root port,
>> +	 * while Bit[15:0] indicates the lower.
>> +	 */
>> +	reg = readl(hisi_ptt->iobase + HISI_PTT_DEVICE_RANGE);
>> +	hisi_ptt->upper = reg >> 16;
>> +	hisi_ptt->lower = reg & 0xffff;
>> +	hisi_ptt->busnr = PCI_BUS_NUM(hisi_ptt->upper);
>> +
>> +	reg = readl(hisi_ptt->iobase + HISI_PTT_LOCATION);
>> +	hisi_ptt->core_id = FIELD_GET(HISI_PTT_CORE_ID, reg);
>> +	hisi_ptt->sicl_id = FIELD_GET(HISI_PTT_SICL_ID, reg);
>> +
>> +	bus = pci_find_bus(pci_domain_nr(pdev->bus), hisi_ptt->busnr);
>> +	if (bus)
>> +		pci_walk_bus(bus, hisi_ptt_init_filters, hisi_ptt);
> 
> What happens if bus is NULL?  Should this be reported to the caller and cause
> hisi_ptt_probe() to fail?  Please add a comment that describes the scenario.
> 

It's ok if the list is NULL in the probe process,
as the device maybe hotplugged after the PTT driver probe, in which case
we can detect the event and update the list as we register a bus notifier.

>> +
>> +	/* Initialize trace controls */
>> +	INIT_LIST_HEAD(&hisi_ptt->trace_ctrl.trace_buf);
>> +	hisi_ptt->trace_ctrl.buflet_size = HISI_PTT_TRACE_BUFLET_SIZE;
>> +	hisi_ptt->trace_ctrl.default_cpu = cpumask_first(cpumask_of_node(dev_to_node(&pdev->dev)));
>> +}
>> +
>> +#define HISI_PTT_PMU_FILTER_IS_PORT	BIT(19)
>> +#define HISI_PTT_PMU_FILTER_VAL_MASK	GENMASK(15, 0)
>> +#define HISI_PTT_PMU_DIRECTION_MASK	GENMASK(23, 20)
>> +#define HISI_PTT_PMU_TYPE_MASK		GENMASK(31, 24)
>> +#define HISI_PTT_PMU_FORMAT_MASK	GENMASK(35, 32)
>> +
>> +static ssize_t available_filters_show(struct device *dev,
>> +				      struct device_attribute *attr,
>> +				      char *buf)
>> +{
>> +	struct hisi_ptt *hisi_ptt = to_hisi_ptt(dev_get_drvdata(dev));
>> +	struct hisi_ptt_filter_desc *filter;
>> +	int pos = 0;
>> +
>> +	if (list_empty(&hisi_ptt->port_filters))
>> +		return sysfs_emit(buf, "#### No available filter ####\n");
>> +
>> +	mutex_lock(&hisi_ptt->mutex);
>> +	pos += sysfs_emit_at(buf, pos, "#### Root Ports ####\n");
>> +	list_for_each_entry(filter, &hisi_ptt->port_filters, list)
>> +		pos += sysfs_emit_at(buf, pos, "%s	0x%05lx\n",
>> +				     pci_name(filter->pdev),
>> +				     hisi_ptt_get_filter_val(filter->pdev) |
>> +				     HISI_PTT_PMU_FILTER_IS_PORT);
>> +
>> +	pos += sysfs_emit_at(buf, pos, "#### Requesters ####\n");
>> +	list_for_each_entry(filter, &hisi_ptt->req_filters, list)
>> +		pos += sysfs_emit_at(buf, pos, "%s	0x%05x\n",
>> +				     pci_name(filter->pdev),
>> +				     hisi_ptt_get_filter_val(filter->pdev));
>> +
>> +	mutex_unlock(&hisi_ptt->mutex);
>> +	return pos;
>> +}
>> +static DEVICE_ATTR_ADMIN_RO(available_filters);
>> +
>> +PMU_FORMAT_ATTR(filter,		"config:0-19");
>> +PMU_FORMAT_ATTR(direction,	"config:20-23");
>> +PMU_FORMAT_ATTR(type,		"config:24-31");
>> +PMU_FORMAT_ATTR(format,		"config:32-35");
>> +
>> +static struct attribute *hisi_ptt_pmu_format_attrs[] = {
>> +	&format_attr_filter.attr,
>> +	&format_attr_direction.attr,
>> +	&format_attr_type.attr,
>> +	&format_attr_format.attr,
>> +	NULL
>> +};
>> +
>> +static struct attribute_group hisi_ptt_pmu_format_group = {
>> +	.name = "format",
>> +	.attrs = hisi_ptt_pmu_format_attrs,
>> +};
>> +
>> +static struct attribute *hisi_ptt_pmu_filter_attrs[] = {
>> +	&dev_attr_available_filters.attr,
>> +	NULL
>> +};
>> +
>> +static struct attribute_group hisi_ptt_pmu_filter_group = {
>> +	.attrs = hisi_ptt_pmu_filter_attrs,
>> +};
>> +
>> +static const struct attribute_group *hisi_ptt_pmu_groups[] = {
>> +	&hisi_ptt_pmu_format_group,
>> +	&hisi_ptt_pmu_filter_group,
>> +	NULL
>> +};
>> +
>> +/*
>> + * The supported value of the direction parameter. See hisi_ptt.rst
>> + * documentation for more details.
>> + */
>> +static u32 hisi_ptt_trace_available_direction[] = {
>> +	0,
>> +	1,
>> +	2,
>> +	3,
>> +};
>> +
>> +/* Different types can be set simultaneously */
>> +static u32 hisi_ptt_trace_available_type[] = {
>> +	1,	/* posted_request */
>> +	2,	/* non-posted_request */
>> +	4,	/* completion */
>> +};
>> +
>> +static u32 hisi_ptt_trace_availble_format[] = {
>> +	0,	/* 4DW */
>> +	1,	/* 8DW */
>> +};
>> +
>> +/*
>> + * Check whether the config is valid or not. Some configs are multi-selectable
>> + * and can be set simultaneously, while some are single selectable (onehot).
>> + * Use this function to check the non-onehot configs while
>> + * hisi_ptt_trace_valid_config_onehot() for the onehot ones.
>> + */
>> +static int hisi_ptt_trace_valid_config(u32 val, u32 *available_list, u32 list_size)
>> +{
>> +	int i;
>> +
>> +	/*
>> +	 * The non-onehot configs cannot be 0. Walk the available
>> +	 * list and clear the valid bits of the config. If there
>> +	 * is any resident bit after the walk then the config is
>> +	 * invalid.
>> +	 */
>> +	for (i = 0; i < list_size; i++)
>> +		val &= ~available_list[i];
>> +
>> +	return val ? -EINVAL : 0;
>> +}
>> +
>> +static int hisi_ptt_trace_valid_config_onehot(u32 val, u32 *available_list, u32 list_size)
>> +{
>> +	int i, ret = -EINVAL;
>> +
>> +	for (i = 0; i < list_size; i++)
>> +		if (val == available_list[i]) {
>> +			ret = 0;
>> +			break;
>> +		}
>> +
>> +	return ret;
>> +}
>> +
>> +static int hisi_ptt_trace_init_filter(struct hisi_ptt *hisi_ptt, u64 config)
>> +{
>> +	unsigned long val, port_mask = hisi_ptt->port_mask;
>> +	struct hisi_ptt_filter_desc *filter;
>> +	int ret = -EINVAL;
>> +
>> +	hisi_ptt->trace_ctrl.is_port = FIELD_GET(HISI_PTT_PMU_FILTER_IS_PORT, config);
>> +	val = FIELD_GET(HISI_PTT_PMU_FILTER_VAL_MASK, config);
>> +
>> +	/*
>> +	 * Port filters are defined as bit mask. For port filters, check
>> +	 * the bits in the @val are within the range of hisi_ptt->port_mask
>> +	 * and whether it's empty or not, otherwise user has specified
>> +	 * some unsupported root ports.
>> +	 *
>> +	 * For Requester ID filters, walk the available filter list to see
>> +	 * whether we have one matched.
>> +	 */
>> +	if (hisi_ptt->trace_ctrl.is_port &&
>> +	    bitmap_subset(&val, &port_mask, BITS_PER_LONG)) {
>> +		ret = 0;
>> +	} else {
>> +		list_for_each_entry(filter, &hisi_ptt->req_filters, list)
>> +			if (filter->val == val) {
>> +				ret = 0;
>> +				break;
>> +			}
>> +	}
>> +
>> +	if (ret)
>> +		return ret;
>> +
>> +	hisi_ptt->trace_ctrl.filter = val;
>> +	return 0;
>> +}
>> +
>> +static int hisi_ptt_pmu_event_init(struct perf_event *event)
>> +{
>> +	struct hisi_ptt *hisi_ptt = to_hisi_ptt(event->pmu);
>> +	struct hisi_ptt_trace_ctrl *ctrl = &hisi_ptt->trace_ctrl;
>> +	int ret;
>> +	u32 val;
>> +
>> +	if (event->attr.type != hisi_ptt->hisi_ptt_pmu.type)
>> +		return -ENOENT;
>> +
>> +	mutex_lock(&hisi_ptt->mutex);
>> +
>> +	ret = hisi_ptt_trace_init_filter(hisi_ptt, event->attr.config);
>> +	if (ret < 0)
>> +		goto out;
>> +
>> +	val = FIELD_GET(HISI_PTT_PMU_DIRECTION_MASK, event->attr.config);
>> +	ret = hisi_ptt_trace_valid_config_onehot(val, hisi_ptt_trace_available_direction,
>> +						 ARRAY_SIZE(hisi_ptt_trace_available_direction));
>> +	if (ret < 0)
>> +		goto out;
>> +	ctrl->direction = val;
>> +
>> +	val = FIELD_GET(HISI_PTT_PMU_TYPE_MASK, event->attr.config);
>> +
>> +	ret = hisi_ptt_trace_valid_config(val, hisi_ptt_trace_available_type,
>> +					  ARRAY_SIZE(hisi_ptt_trace_available_type));
>> +	if (ret < 0)
>> +		goto out;
>> +	ctrl->type = val;
>> +
>> +	val = FIELD_GET(HISI_PTT_PMU_FORMAT_MASK, event->attr.config);
>> +	ret = hisi_ptt_trace_valid_config_onehot(val, hisi_ptt_trace_availble_format,
>> +						 ARRAY_SIZE(hisi_ptt_trace_availble_format));
>> +	if (ret < 0)
>> +		goto out;
>> +	ctrl->format = val;
>> +
>> +out:
>> +	mutex_unlock(&hisi_ptt->mutex);
>> +	return ret;
>> +}
>> +
>> +static void *hisi_ptt_pmu_setup_aux(struct perf_event *event, void **pages,
>> +				    int nr_pages, bool overwrite)
>> +{
>> +	struct hisi_ptt_pmu_buf *buf;
>> +	struct page **pagelist;
>> +	int i;
>> +
>> +	if (overwrite) {
>> +		dev_warn(event->pmu->dev, "Overwrite mode is not supported\n");
>> +		return NULL;
>> +	}
>> +
>> +	/* If the pages size less than buflets, we cannot start trace */
>> +	if (nr_pages < HISI_PTT_TRACE_BUFFER_SIZE / PAGE_SIZE)
>> +		return NULL;
>> +
>> +	buf = kzalloc(sizeof(*buf), GFP_KERNEL);
>> +	if (!buf)
>> +		return NULL;
>> +
>> +	pagelist = kcalloc(nr_pages, sizeof(*pagelist), GFP_KERNEL);
>> +	if (!pagelist) {
>> +		kfree(buf);
>> +		return NULL;
>> +	}
>> +
>> +	for (i = 0; i < nr_pages; i++)
>> +		pagelist[i] = virt_to_page(pages[i]);
>> +
>> +	buf->base = vmap(pagelist, nr_pages, VM_MAP, PAGE_KERNEL);
>> +	if (!buf->base) {
>> +		kfree(pagelist);
>> +		kfree(buf);
>> +		return NULL;
>> +	}
>> +
>> +	buf->nr_pages = nr_pages;
>> +	buf->length = nr_pages * PAGE_SIZE;
>> +	buf->pos = 0;
>> +
>> +	kfree(pagelist);
>> +	return buf;
>> +}
>> +
>> +static void hisi_ptt_pmu_free_aux(void *aux)
>> +{
>> +	struct hisi_ptt_pmu_buf *buf = aux;
>> +
>> +	vunmap(buf->base);
>> +	kfree(buf);
>> +}
>> +
>> +static void hisi_ptt_pmu_start(struct perf_event *event, int flags)
>> +{
>> +	struct hisi_ptt *hisi_ptt = to_hisi_ptt(event->pmu);
>> +	struct perf_output_handle *handle = &hisi_ptt->trace_ctrl.handle;
>> +	struct hw_perf_event *hwc = &event->hw;
>> +	struct hisi_ptt_pmu_buf *buf;
>> +	int cpu = event->cpu;
>> +	int ret;
>> +
>> +	hwc->state = 0;
>> +	mutex_lock(&hisi_ptt->mutex);
>> +	if (hisi_ptt->trace_ctrl.status == HISI_PTT_TRACE_STATUS_ON) {
>> +		pci_dbg(hisi_ptt->pdev, "trace has already started\n");
>> +		goto stop;
>> +	}
>> +
>> +	if (cpu == -1)
>> +		cpu = hisi_ptt->trace_ctrl.default_cpu;
>> +
>> +	/*
>> +	 * Handle the interrupt on the same cpu which starts the trace to avoid
>> +	 * context mismatch. Otherwise we'll trigger the WARN from the perf
>> +	 * core in event_function_local().
>> +	 */
>> +	WARN_ON(irq_set_affinity(pci_irq_vector(hisi_ptt->pdev, HISI_PTT_TRACE_DMA_IRQ),
>> +				 cpumask_of(cpu)));
>> +
>> +	ret = hisi_ptt_alloc_trace_buf(hisi_ptt);
>> +	if (ret) {
>> +		pci_dbg(hisi_ptt->pdev, "alloc trace buf failed, ret = %d\n", ret);
>> +		goto stop;
>> +	}
>> +
>> +	buf = perf_aux_output_begin(handle, event);
>> +	if (!buf) {
>> +		pci_dbg(hisi_ptt->pdev, "aux output begin failed\n");
>> +		goto stop;
>> +	}
>> +
>> +	buf->pos = handle->head % buf->length;
>> +
>> +	ret = hisi_ptt_trace_start(hisi_ptt);
>> +	if (ret) {
>> +		pci_dbg(hisi_ptt->pdev, "trace start failed, ret = %d\n", ret);
>> +		perf_aux_output_end(handle, 0);
>> +		goto stop;
>> +	}
>> +
>> +	mutex_unlock(&hisi_ptt->mutex);
>> +	return;
>> +stop:
>> +	event->hw.state |= PERF_HES_STOPPED;
>> +	mutex_unlock(&hisi_ptt->mutex);
>> +}
>> +
>> +static void hisi_ptt_pmu_stop(struct perf_event *event, int flags)
>> +{
>> +	struct hisi_ptt *hisi_ptt = to_hisi_ptt(event->pmu);
>> +	struct hw_perf_event *hwc = &event->hw;
>> +
>> +	if (hwc->state & PERF_HES_STOPPED)
>> +		return;
>> +
>> +	mutex_lock(&hisi_ptt->mutex);
>> +	if (hisi_ptt->trace_ctrl.status == HISI_PTT_TRACE_STATUS_ON) {
>> +		hisi_ptt_trace_end(hisi_ptt);
>> +		WARN(hisi_ptt_wait_trace_hw_idle(hisi_ptt), "Device is still busy");
>> +		hisi_ptt_update_aux(hisi_ptt, hisi_ptt->trace_ctrl.buf_index, true);
>> +	}
>> +	mutex_unlock(&hisi_ptt->mutex);
>> +
>> +	hwc->state |= PERF_HES_STOPPED;
>> +	perf_event_update_userpage(event);
>> +	hwc->state |= PERF_HES_UPTODATE;
>> +}
>> +
>> +static int hisi_ptt_pmu_add(struct perf_event *event, int flags)
>> +{
>> +	struct hisi_ptt *hisi_ptt = to_hisi_ptt(event->pmu);
>> +	struct hw_perf_event *hwc = &event->hw;
>> +	int cpu = event->cpu;
>> +
>> +	if (cpu == -1 && smp_processor_id() != hisi_ptt->trace_ctrl.default_cpu)
>> +		return 0;
>> +
>> +	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
>> +
>> +	if (flags & PERF_EF_START) {
>> +		hisi_ptt_pmu_start(event, PERF_EF_RELOAD);
>> +		if (hwc->state & PERF_HES_STOPPED)
>> +			return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void hisi_ptt_pmu_del(struct perf_event *event, int flags)
>> +{
>> +	hisi_ptt_pmu_stop(event, PERF_EF_UPDATE);
>> +}
>> +
>> +static void hisi_ptt_unregister_pmu(void *priv)
>> +{
>> +	perf_pmu_unregister(priv);
>> +}
>> +
>> +static int hisi_ptt_register_pmu(struct hisi_ptt *hisi_ptt)
>> +{
>> +	char *pmu_name;
>> +	int ret;
>> +
>> +	hisi_ptt->hisi_ptt_pmu = (struct pmu) {
>> +		.module		= THIS_MODULE,
>> +		.capabilities	= PERF_PMU_CAP_EXCLUSIVE | PERF_PMU_CAP_ITRACE,
>> +		.task_ctx_nr	= perf_sw_context,
>> +		.attr_groups	= hisi_ptt_pmu_groups,
>> +		.event_init	= hisi_ptt_pmu_event_init,
>> +		.setup_aux	= hisi_ptt_pmu_setup_aux,
>> +		.free_aux	= hisi_ptt_pmu_free_aux,
>> +		.start		= hisi_ptt_pmu_start,
>> +		.stop		= hisi_ptt_pmu_stop,
>> +		.add		= hisi_ptt_pmu_add,
>> +		.del		= hisi_ptt_pmu_del,
>> +	};
>> +
>> +	pmu_name = devm_kasprintf(&hisi_ptt->pdev->dev, GFP_KERNEL, "hisi_ptt%u_%u",
>> +				  hisi_ptt->sicl_id, hisi_ptt->core_id);
>> +	if (!pmu_name)
>> +		return -ENOMEM;
>> +
>> +	ret = perf_pmu_register(&hisi_ptt->hisi_ptt_pmu, pmu_name, -1);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return devm_add_action_or_reset(&hisi_ptt->pdev->dev,
>> +					hisi_ptt_unregister_pmu,
>> +					&hisi_ptt->hisi_ptt_pmu);
>> +}
>> +
>> +/*
>> + * Get RMR address if provided by the firmware.
>> + * Return 0 if the IOMMU doesn't present or the policy of the
>> + * IOMMU domain is passthrough or we get a usable RMR region.
>> + * Otherwise a negative value is returned.
>> + */
>> +static int hisi_ptt_get_rmr(struct hisi_ptt *hisi_ptt)
>> +{
>> +	struct pci_dev *pdev = hisi_ptt->pdev;
>> +	struct iommu_domain *iommu_domain;
>> +	struct iommu_resv_region *region;
>> +	LIST_HEAD(list);
>> +
>> +	/*
>> +	 * Use direct DMA if IOMMU does not present or the policy of the
>> +	 * IOMMU domain is passthrough.
>> +	 */
>> +	iommu_domain = iommu_get_domain_for_dev(&pdev->dev);
>> +	if (!iommu_domain || iommu_domain->type == IOMMU_DOMAIN_IDENTITY)
>> +		return 0;
>> +
>> +	iommu_get_resv_regions(&pdev->dev, &list);
>> +	list_for_each_entry(region, &list, list)
>> +		if (region->type == IOMMU_RESV_DIRECT &&
>> +		    region->length >= HISI_PTT_TRACE_BUFFER_SIZE) {
>> +			hisi_ptt->trace_ctrl.has_rmr = true;
>> +			hisi_ptt->trace_ctrl.rmr_addr = region->start;
>> +			hisi_ptt->trace_ctrl.rmr_length = region->length;
>> +			break;
>> +		}
>> +
>> +	iommu_put_resv_regions(&pdev->dev, &list);
>> +	return hisi_ptt->trace_ctrl.has_rmr ? 0 : -ENOMEM;
>> +}
>> +
>> +static int hisi_ptt_probe(struct pci_dev *pdev,
>> +			  const struct pci_device_id *id)
>> +{
>> +	struct hisi_ptt *hisi_ptt;
>> +	int ret;
>> +
>> +	hisi_ptt = devm_kzalloc(&pdev->dev, sizeof(*hisi_ptt), GFP_KERNEL);
>> +	if (!hisi_ptt)
>> +		return -ENOMEM;
>> +
>> +	mutex_init(&hisi_ptt->mutex);
>> +	hisi_ptt->pdev = pdev;
>> +
>> +	/*
>> +	 * Lifetime of pci_dev is longer than hisi_ptt,
>> +	 * so directly reference to the pci name string.
>> +	 */
>> +	hisi_ptt->name = pci_name(hisi_ptt->pdev);
>> +	pci_set_drvdata(pdev, hisi_ptt);
>> +
>> +	ret = pcim_enable_device(pdev);
>> +	if (ret) {
>> +		pci_err(pdev, "failed to enable device, ret = %d.\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = pcim_iomap_regions(pdev, BIT(2), hisi_ptt->name);
>> +	if (ret) {
>> +		pci_err(pdev, "failed to remap io memory, ret = %d.\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	hisi_ptt->iobase = pcim_iomap_table(pdev)[2];
>> +
>> +	ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
>> +	if (ret) {
>> +		pci_err(pdev, "failed to set 64 bit dma mask, ret = %d.\n", ret);
>> +		return ret;
>> +	}
>> +	pci_set_master(pdev);
>> +
>> +	ret = hisi_ptt_register_irq(hisi_ptt);
>> +	if (ret)
>> +		return ret;
>> +
>> +	hisi_ptt_init_ctrls(hisi_ptt);
>> +
>> +	ret = hisi_ptt_register_pmu(hisi_ptt);
>> +	if (ret) {
>> +		pci_err(pdev, "failed to register pmu device, ret = %d", ret);
>> +		return ret;
>> +	}
> 
> If this fails the pci_free_irq_vectors() is not called.
> 

It'll be called as we've registered a devm callback when
allocating the irq vector. See hisi_ptt_register_irq().

> I am out of time for today - I will continue tomorrow.
> 

Sure. Thanks!
Yicong

> Thanks,
> Mathieu
> 
>> +
>> +	ret = hisi_ptt_get_rmr(hisi_ptt);
>> +	if (ret) {
>> +		pci_err(pdev, "failed to get RMR region, ret = %d", ret);
>> +		return ret;
>> +	}
>> +
>> +	/* Register the bus notifier for dynamically updating the filter list */
>> +	hisi_ptt->hisi_ptt_nb.notifier_call = hisi_ptt_notifier_call;
>> +	ret = bus_register_notifier(&pci_bus_type, &hisi_ptt->hisi_ptt_nb);
>> +	if (ret)
>> +		pci_warn(pdev, "failed to register filter update notifier, ret = %d", ret);
>> +
>> +	return 0;
>> +}
>> +
>> +void hisi_ptt_remove(struct pci_dev *pdev)
>> +{
>> +	struct hisi_ptt *hisi_ptt = pci_get_drvdata(pdev);
>> +
>> +	bus_unregister_notifier(&pci_bus_type, &hisi_ptt->hisi_ptt_nb);
>> +
>> +	/* Cancel any work that has been queued */
>> +	cancel_delayed_work_sync(&hisi_ptt->work);
>> +
>> +	if (hisi_ptt->trace_ctrl.status == HISI_PTT_TRACE_STATUS_ON)
>> +		hisi_ptt_trace_end(hisi_ptt);
>> +
>> +	hisi_ptt_free_trace_buf(hisi_ptt);
>> +	hisi_ptt_release_filters(hisi_ptt);
>> +}
>> +
>> +static const struct pci_device_id hisi_ptt_id_tbl[] = {
>> +	{ PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, 0xa12e) },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(pci, hisi_ptt_id_tbl);
>> +
>> +static struct pci_driver hisi_ptt_driver = {
>> +	.name = "hisi_ptt",
>> +	.id_table = hisi_ptt_id_tbl,
>> +	.probe = hisi_ptt_probe,
>> +	.remove = hisi_ptt_remove,
>> +};
>> +module_pci_driver(hisi_ptt_driver);
>> +
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_AUTHOR("Yicong Yang <yangyicong@hisilicon.com>");
>> +MODULE_DESCRIPTION("Driver for HiSilicon PCIe tune and trace device");
>> -- 
>> 2.33.0
>>
> .
> 

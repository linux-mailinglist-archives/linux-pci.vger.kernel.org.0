Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8826207104
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jun 2020 12:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388197AbgFXKVQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Jun 2020 06:21:16 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48982 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390260AbgFXKUo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Jun 2020 06:20:44 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B1666BD84DA055A7F0AE;
        Wed, 24 Jun 2020 18:20:33 +0800 (CST)
Received: from [10.65.58.147] (10.65.58.147) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Wed, 24 Jun 2020
 18:20:24 +0800
Subject: Re: [RFC PATCH] hwtracing: Add HiSilicon PCIe Tune and Trace device
 driver
To:     <linux-kernel@vger.kernel.org>,
        <alexander.shishkin@linux.intel.com>, <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>
References: <1592040733-32329-1-git-send-email-yangyicong@hisilicon.com>
CC:     <linuxarm@huawei.com>, <mathieu.poirier@linaro.org>,
        <suzuki.poulose@arm.com>, <mike.leach@linaro.org>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <59f149a3-c297-797f-5eff-0858e3185a87@hisilicon.com>
Date:   Wed, 24 Jun 2020 18:20:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <1592040733-32329-1-git-send-email-yangyicong@hisilicon.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.58.147]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all,

As it's a new tracing device for PCIe traffic, any comments about
the driver or the user interface is appreciated.

Thanks.


On 2020/6/13 17:32, Yicong Yang wrote:
> HiSilicon PCIe tune and trace device(PTT) is a PCIe Root Complex
> integrated Endpoint(RCiEP) device, providing the capability
> to dynamically monitor and tune the PCIe traffic parameters(tune),
> and trace the TLP headers to the memory(trace).
>
> Add the driver for the device to enable its functions. The driver
> will create debugfs directory for each PTT device, and users can
> operate the device through the files under its directory.
>
> RFC:
> - The hardware interface is not yet finalized.
> - The interface to the users is through debugfs, and the usage will
>   be further illustrated in the document.
> - The driver is intended to be put under drivers/hwtracing, where
>   we think best match the device's function.
>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  Documentation/trace/hisi-ptt.rst       |  272 ++++++++
>  drivers/hwtracing/Kconfig              |    2 +
>  drivers/hwtracing/hisilicon/Kconfig    |    8 +
>  drivers/hwtracing/hisilicon/Makefile   |    2 +
>  drivers/hwtracing/hisilicon/hisi_ptt.c | 1172 ++++++++++++++++++++++++++++++++
>  5 files changed, 1456 insertions(+)
>  create mode 100644 Documentation/trace/hisi-ptt.rst
>  create mode 100644 drivers/hwtracing/hisilicon/Kconfig
>  create mode 100644 drivers/hwtracing/hisilicon/Makefile
>  create mode 100644 drivers/hwtracing/hisilicon/hisi_ptt.c
>
> diff --git a/Documentation/trace/hisi-ptt.rst b/Documentation/trace/hisi-ptt.rst
> new file mode 100644
> index 0000000..c99fbf9
> --- /dev/null
> +++ b/Documentation/trace/hisi-ptt.rst
> @@ -0,0 +1,272 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +======================================
> +HiSilicon PCIe Tune and Trace device
> +======================================
> +
> +Introduction
> +============
> +
> +HiSilicon PCIe tune and trace device(PTT) is a PCIe Root Complex
> +integrated Endpoint(RCiEP) device, providing the capability
> +to dynamically monitor and tune the PCIe link's events(tune),
> +and trace the TLP headers to the memory(trace). The two functions
> +are inpendent, but is recommended to use them together to analyze
> +and enhance the PCIe link's performance.
> +
> +On Hip09, the PCIe root complex is composed of several PCIe cores.
> +And each core is composed of several root ports, RCiEPs, and one
> +PTT device, like below. The PTT device is capable of tuning and
> +tracing the link on and downstream the PCIe core.
> +::
> +          +--------------Core 0-------+
> +          |       |       [   PTT   ] |
> +          |       |       [Root Port]---[Endpoint]
> +          |       |       [Root Port]---[Endpoint]
> +          |       |       [Root Port]---[Endpoint]
> +    Root Complex  |------Core 1-------+
> +          |       |       [   PTT   ] |
> +          |       |       [Root Port]---[ Switch ]---[Endpoint]
> +          |       |       [Root Port]---[Endpoint] `-[Endpoint]
> +          |       |       [Root Port]---[Endpoint]
> +          +---------------------------+
> +
> +The PTT device driver cannot be loaded if debugfs is not mounted.
> +Each PTT device will be presented under /sys/kernel/debugfs/hisi_ptt
> +as its root directory, with name of its BDF number.
> +::
> +
> +    /sys/kernel/debug/hisi_ptt/<domain>:<bus>:<device>.<function>
> +
> +Tune
> +====
> +
> +PTT tune is designed for monitoring and adjusting PCIe link parameters(events).
> +Currently we support events 4 classes. The scope of the events
> +covers the PCIe core with which the PTT device belongs to.
> +
> +Each event is presented as a file under $(PTT root dir)/$(BDF)/tune, and
> +mostly this will be a simple open/read/write/close cycle to tune
> +the event.
> +::
> +    $ cd /sys/kernel/debug/hisi_ptt/$(BDF)/tune
> +    $ ls
> +    buf_rx_cpld buf_rx_pd   dllp_link_ack_freq  link_credit_rx_cplh
> +    link_credit_rx_ph       qos_tx_dp           qos_tx_dp
> +    $ cat qos_tx_dp
> +    100
> +    $ echo 50 > qos_tx_dp
> +    $ cat qos_tx_dp
> +    50
> +
> +Current value(numerical value) of the event can be get by simply
> +read the file, and write the desired value to the file to tune.
> +Tune multiple events at the same time is not permitted, which means
> +you cannot read or write more than one tune file at one time.
> +
> +1. Link credit control
> +----------------------
> +
> +Following files are provided for tune the link credit events of the PCIe core.
> +PCIe link uses credit to control the flow, refer to the PCIe Spec for further
> +information.
> +
> +- link_credit_rx_nph: rx non-posted request headers' credit
> +- link_credit_rx_npd: rx non-posted request data payload's credit
> +- link_credit_rx_ph: rx posted request headers' credit
> +- link_credit_rx_pd: rx posted request data payload's credit
> +- link_credit_rx_cplh: rx completion headers' credit
> +- link_credit_rx_cpld: rx completion data payload's credit
> +
> +Note that the event value is not accurate but a probable one to indicate
> +the level of each event, for example, perhaps 100 for high level,
> +50 for median and 0 for low.
> +
> +2. Link DLLP control
> +--------------------
> +
> +Following files are provided for tune the link events of DLLP of the PCIe core.
> +
> +- dllp_link_ack_freq: frequency of DLLP ACKs
> +- dllp_link_updatefc_freq: frequency of DLLP flow control updates
> +- dllp_link_ssc: spread spectrum control of DLLP link
> +
> +Note that the event value just indicates a probable level, but not
> +accurate.
> +
> +3. Buffer control
> +-----------------
> +
> +Following files are provided for tune the rx/tx buffer depth of the PCIe core.
> +
> +- buf_tx_header: buffer depth for tx packets headers
> +- buf_tx_data: buffer depth for tx packets data payloads
> +- buf_rx_ph: buffer depth for rx posted request packets headers
> +- buf_rx_pd: buffer depth for rx posted request packets data payloads
> +- buf_rx_nph: buffer depth for rx non-posted request packets headers
> +- buf_rx_npd: buffer depth for rx non-posted request packets data payloads
> +- buf_rx_cplh: buffer depth for rx completion packets headers
> +- buf_rx_cpld: buffer depth for rx completion packets data payloads
> +
> +Note that the event value just indicates a probable level, but not
> +accurate.
> +
> +4. Data path QoS control
> +------------------------
> +
> +Following files are provided for tune the QoS of the data path of the PCIe core.
> +
> +- qos_tx_dp: QoS for tx data path
> +- qos_rx_dp: QoS for rx data path
> +
> +Note that the event value just indicates a probable level, but not
> +accurate.
> +
> +Trace
> +=====
> +
> +PTT trace is designed for dumping the TLP headers to the memory, which
> +can be used to analyze the transactions and usage condition of the PCIe
> +Link. You can choose to trace the headers either by its requester ID,
> +or the headers from the link downstream certain root ports, which are
> +on the same core of PTT device. It's also support to trace the headers
> +of certain type and of certain direction.
> +
> +In order to start trace, you need to configure the parameters first.
> +The parameters files is provided under $(PTT root dir)/$(BDF)/trace.
> +::
> +    $ cd /sys/kernel/debug/hisi_ptt/$(BDF)/trace
> +    $ ls
> +    free_buffer     filter      buflet_nums     buflet_size
> +    direction       type        data            trace_on
> +
> +1. filter
> +---------
> +
> +You can configure the filter of TLP headers through the file. The filter
> +is provided as BDF numbers of either root port or subordinates, which
> +belong to the same PCIe core. You can get the filters available and
> +currently configure by read the file, and write the desired BDF to the
> +file to set the filters. The default filter is the first root port on
> +the core, and write invalid BDF(not in the available list) will return
> +a failure.
> +::
> +    $ echo 0000:80:04.0 > filter
> +    $ cat filter
> +    0000:80:00.0    [0000:80:04.0]  0000:81:00.0    0000:81:00.1   0000:82:00.0
> +
> +2. type
> +-------
> +
> +You can trace the TLP headers of certain types by configure the file.
> +Read the file will get available types and current setting, and write
> +the desired type to the file to configure. The default type is
> +`posted_request` and write types not in the available list will return
> +a failure.
> +::
> +    $ echo completion > type
> +    $ cat type
> +    posted_request  non-posted_request  [completion]    all
> +
> +3. direction
> +------------
> +
> +You can trace the TLP headers from certain direction, which is relative
> +to the root port or the PCIe core. Read the file to get available
> +directions and current configurition, and write the desired direction
> +to configure. The default value is `rx` and any invalid direction will
> +return a failure. Note `rxtx_no_dma_p2p` means the headers of both
> +directions, but not include P2P DMA access.
> +::
> +    $ echo rxtx > direction
> +    $ cat direction
> +    rx  tx  [rxtx]  rxtx_no_dma_p2p
> +
> +4. buflet_size
> +--------------
> +
> +The traced TLP headers will be written to the memory allocated
> +by the driver. The hardware accept 4 DMA address with same size,
> +and write the buflet sequetially like below. If DMA addr 3 is
> +finished and the trace is still on, it will return to addr 0.
> +Driver will allocated each DMA buffer (we call it buflet) and
> +swap a preallocated one if it has been finished.
> +::
> +    +->[DMA addr 0]->[DMA addr 1]->[DMA addr 2]->[DMA addr 3]-+
> +    +---------------------------------------------------------+
> +
> +You should both configure the buflet_size and buflet_nums to
> +configure the `trace buffer` to receive the TLP headers. The
> +total trace buffer size is buflet_size * buflet_nums. Note
> +that the trace buffer will not be allocated immediately after you
> +configure the parameters, but will be allocated right before
> +the trace starts.
> +
> +This file configures the buflet size. Read the file will get
> +available buflet size and size set currently, write the desired
> +size to the file to configure. The default size is 2 MiB and any
> +invalid size written will return a failure.
> +::
> +    $ cat buflet_size
> +    [2 MiB]     4 MiB     6 MiB     8 MiB     10 MiB
> +    $ echo 8 > buflet_size
> +    $ cat buflet_size
> +    2 MiB     4 MiB     6 MiB     [8 MiB]     10 MiB
> +
> +5. buflet_nums
> +--------------
> +
> +You can write the desired buflet counts to the file to configure,
> +and read the file to get current buflet counts. The default
> +value is 64. And any positive value is valid. Note that big value
> +may lead to DMA memory allocation failure, and you will not be
> +able to start tracing. If it happens, you should consider adjusting
> +buflet_nums or buflet_size.
> +::
> +    $ cat buflet_nums
> +    64
> +    $ echo 128 > buflet_nums
> +    $ cat buflet_nums
> +    128
> +
> +6. data
> +-------
> +
> +The file to access the traced data. You can read the file to get the
> +binary blob of traced TLP headers. The format of the headers is
> +4 Dword length and is just as defined by the PCIe Spec r4.0,
> +Sec 2.2.4.1, or 8 Dword length with additional 4 Dword extra
> +information.
> +
> +echo "" > data will free all the trace buffers allocated as well as
> +the traced datas.
> +
> +7. trace_on
> +-----------
> +
> +Start or end the trace by simple writing to the file, and monitor the
> +trace status by reading the file.
> +::
> +    $ echo 1 > trace_on     # start trace
> +    $ cat trace_on          # get the trace status
> +    1
> +    $ echo 0 > trace_on     # manually end trace
> +
> +The read value of the trace_on will be auto cleared if the buffer
> +allocated is full. 1 indicates the trace is running and 0 for
> +stopped. Write any non-zero value to the file can start trace.
> +
> +8. free_buffer
> +--------------
> +
> +File to indicate the trace buffer status and to manually free the
> +trace buffer. The read value of 1 indicates the trace buffer has
> +been allocated and exists in the memory, while 0 indicates there
> +is no buffer allocated. Write 1 to the file to free the trace
> +buffer as well as the traced datas.
> +::
> +    $ cat free_buffer
> +    1                       # indicate the buffer exists
> +    $ echo 1 > free_buffer  # free the trace buffer
> +    $ cat free_buffer
> +    0
> diff --git a/drivers/hwtracing/Kconfig b/drivers/hwtracing/Kconfig
> index 1308583..e3796b1 100644
> --- a/drivers/hwtracing/Kconfig
> +++ b/drivers/hwtracing/Kconfig
> @@ -5,4 +5,6 @@ source "drivers/hwtracing/stm/Kconfig"
>  
>  source "drivers/hwtracing/intel_th/Kconfig"
>  
> +source "drivers/hwtracing/hisilicon/Kconfig"
> +
>  endmenu
> diff --git a/drivers/hwtracing/hisilicon/Kconfig b/drivers/hwtracing/hisilicon/Kconfig
> new file mode 100644
> index 0000000..95e91b9
> --- /dev/null
> +++ b/drivers/hwtracing/hisilicon/Kconfig
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config HISI_PTT
> +	tristate "HiSilicon PCIe Tune and Trace Device"
> +	depends on PCI && HAS_DMA && HAS_IOMEM
> +	help
> +	  HiSilicon PCIe Tune and Trace Device exist as a PCIe iEP
> +	  device, provides support for PCIe traffic tuning and
> +	  tracing TLP headers to the memory.
> diff --git a/drivers/hwtracing/hisilicon/Makefile b/drivers/hwtracing/hisilicon/Makefile
> new file mode 100644
> index 0000000..908c09a
> --- /dev/null
> +++ b/drivers/hwtracing/hisilicon/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_HISI_PTT) += hisi_ptt.o
> diff --git a/drivers/hwtracing/hisilicon/hisi_ptt.c b/drivers/hwtracing/hisilicon/hisi_ptt.c
> new file mode 100644
> index 0000000..c58a3cc
> --- /dev/null
> +++ b/drivers/hwtracing/hisilicon/hisi_ptt.c
> @@ -0,0 +1,1172 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for HiSilicon PCIe tune and trace device
> + *
> + * Copyright (c) 2020 HiSilicon Limited.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/debugfs.h>
> +#include <linux/delay.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/seq_file.h>
> +#include <linux/pci.h>
> +
> +#define HISI_PTT_CTRL_STR_LEN	40
> +#define HISI_PTT_DEFAULT_TRACE_BUF_CNT	64
> +
> +#define HISI_PTT_RESET_WAIT_MS 1000UL
> +
> +#define HISI_PTT_IRQ_NUMS	1
> +#define HISI_PTT_DMA_IRQ	0
> +#define HISI_PTT_DMA_NUMS	4
> +
> +#define HISI_PTT_TUNING_CTRL		0x0380
> +#define   HISI_PTT_TUNING_CTRL_CODE	GENMASK(3, 0)
> +#define   HISI_PTT_TUNING_CTRL_EN	GENMASK(23, 16)
> +#define HISI_PTT_TUNING_DATA		0x0384
> +#define   HISI_PTT_TUNING_DATA_VAL	GENMASK(15, 0)
> +#define HISI_PTT_TRACE_ADDR_SIZE	0x0400
> +#define HISI_PTT_TRACE_ADDR_BASE_LO_0	0x0410
> +#define HISI_PTT_TRACE_ADDR_BASE_HI_0	0x0414
> +#define HISI_PTT_TRACE_CTRL		0x0450
> +#define   HISI_PTT_TRACE_CTRL_EN	BIT(0)
> +#define   HISI_PTT_TRACE_CTRL_RST	BIT(1)
> +#define   HISI_PTT_TRACE_CTRL_RXTX_SEL	GENMASK(3, 2)
> +#define   HISI_PTT_TRACE_CTRL_TYPE_SEL	GENMASK(7, 4)
> +#define   HISI_PTT_TRACE_CTRL_DATA_FORMAT	BIT(14)
> +#define   HISI_PTT_TRACE_CTRL_FILTER_MODE	BIT(15)
> +#define   HISI_PTT_TRACE_CTRL_TARGET_SEL	GENMASK(31, 16)
> +#define HISI_PTT_TRACE_INT_STAT		0x0490
> +#define   HISI_PTT_TRACE_INT_STAT_MASK	GENMASK(3, 0)
> +#define HISI_PTT_TRACE_WR_STS		0x04a0
> +#define   HISI_PTT_TRACE_WR_STS_WRITE	GENMASK(27, 0)
> +#define   HISI_PTT_TRACE_WR_STS_BUFFER	GENMASK(29, 28)
> +#define HISI_PTT_TRACE_STS		0x04b0
> +#define   HISI_PTT_TRACE_IDLE		BIT(0)
> +#define HISI_PTT_MAILBOX_0		0x07e0
> +
> +static struct dentry *hisi_ptt_debugfs_root;
> +
> +struct event_desc {
> +	const char *name;
> +	u32 event_code;
> +};
> +
> +static struct event_desc tune_events[] = {
> +	{ "link_credit_rx_nph",		0x1 | (BIT(1) << 16) },
> +	{ "link_credit_rx_npd",		0x1 | (BIT(2) << 16) },
> +	{ "link_credit_rx_ph",		0x1 | (BIT(3) << 16) },
> +	{ "link_credit_rx_pd",		0x1 | (BIT(4) << 16) },
> +	{ "link_credit_rx_cplh",	0x1 | (BIT(5) << 16) },
> +	{ "link_credit_rx_cpld",	0x1 | (BIT(6) << 16) },
> +	{ "dllp_link_ack_freq",		0x2 | (BIT(1) << 16) },
> +	{ "dllp_link_updatefc_freq",	0x2 | (BIT(2) << 16) },
> +	{ "dllp_link_ssc",		0x2 | (BIT(2) << 16) },
> +	{ "buf_tx_header",		0x3 | (BIT(1) << 16) },
> +	{ "buf_tx_data",		0x3 | (BIT(2) << 16) },
> +	{ "buf_rx_ph",			0x3 | (BIT(3) << 16) },
> +	{ "buf_rx_pd",			0x3 | (BIT(4) << 16) },
> +	{ "buf_rx_nph",			0x3 | (BIT(5) << 16) },
> +	{ "buf_rx_npd",			0x3 | (BIT(6) << 16) },
> +	{ "buf_rx_cplh",		0x3 | (BIT(7) << 16) },
> +	{ "buf_rx_cpld",		0x3 | (BIT(8) << 16) },
> +	{ "qos_tx_dp",			0x4 | (BIT(1) << 16) },
> +	{ "qos_rx_dp",			0x4 | (BIT(1) << 16) },
> +};
> +
> +static struct event_desc trace_rxtx[] = {
> +	{ "rx", 0 },
> +	{ "tx", 1 },
> +	{ "rxtx", 2 },
> +	{ "rxtx_no_dma_p2p", 3 },
> +};
> +
> +static struct event_desc trace_events[] = {
> +	{ "posted_request", 0 },
> +	{ "non-posted_request",  2 },
> +	{ "completion",  4 },
> +	{ "all", 8 },
> +};
> +
> +static const int available_buflet_size[] = {
> +	0x00200000,	/* 2  MiB */
> +	0x00400000,	/* 4  MiB */
> +	0x00600000,	/* 6  MiB */
> +	0x00800000,	/* 8  MiB */
> +	0x00a00000,	/* 10 MiB */
> +};
> +
> +struct debugfs_file_desc {
> +	struct hisi_ptt *hisi_ptt;
> +	const char *name;
> +	const struct file_operations *fops;
> +	int index;
> +};
> +
> +struct dma_buflet {
> +	struct list_head list;
> +	dma_addr_t dma;
> +	void *addr;
> +	int index;
> +	u64 size;
> +};
> +
> +struct ptt_trace_ctrl {
> +	struct list_head trace_buf;
> +	struct dma_buflet *cur;
> +	atomic_t status; /* 0:idle, 1:tracing */
> +	u64 buflet_nums;
> +	u32 buflet_size;
> +	u32 tr_event;
> +	u32 rxtx;
> +};
> +
> +struct per_func_info {
> +	struct list_head list;
> +	struct pci_dev *pdev;
> +};
> +
> +struct hisi_ptt {
> +	struct ptt_trace_ctrl trace_ctrl;
> +	struct per_func_info *target_func;
> +	struct list_head avail_devfns;
> +	struct dentry *debugfs_dir;
> +	void __iomem *iobase;
> +	struct pci_dev *pdev;
> +	struct mutex mutex; /* protects the hisi_ptt structure */
> +	const char *name;
> +	u32 tune_event;
> +	u32 domain;
> +	u32 bus;
> +};
> +
> +static u32 hisi_ptt_tune_data_read(struct hisi_ptt *hisi_ptt)
> +{
> +	u32 val;
> +
> +	writel(hisi_ptt->tune_event, hisi_ptt->iobase + HISI_PTT_TUNING_CTRL);
> +
> +	val = readl(hisi_ptt->iobase + HISI_PTT_TUNING_DATA);
> +	val &= HISI_PTT_TUNING_DATA_VAL;
> +
> +	return val;
> +}
> +
> +static void hisi_ptt_tune_data_write(struct hisi_ptt *hisi_ptt, u32 data)
> +{
> +	writel(hisi_ptt->tune_event, hisi_ptt->iobase + HISI_PTT_TUNING_CTRL);
> +	data &= HISI_PTT_TUNING_DATA_VAL;
> +	writel(data, hisi_ptt->iobase + HISI_PTT_TUNING_DATA);
> +}
> +
> +static ssize_t hisi_ptt_tune_common_read(struct file *filp, char __user *buf,
> +					 size_t count, loff_t *pos)
> +{
> +	struct debugfs_file_desc *desc = filp->private_data;
> +	struct hisi_ptt *hisi_ptt = desc->hisi_ptt;
> +	char tbuf[HISI_PTT_CTRL_STR_LEN];
> +	int len;
> +	u32 val;
> +
> +	if (!mutex_trylock(&hisi_ptt->mutex))
> +		return -EBUSY;
> +	hisi_ptt->tune_event = tune_events[desc->index].event_code;
> +	val = hisi_ptt_tune_data_read(hisi_ptt);
> +	mutex_unlock(&hisi_ptt->mutex);
> +
> +	len = snprintf(tbuf, HISI_PTT_CTRL_STR_LEN,
> +		       "%d\n", val);
> +
> +	return simple_read_from_buffer(buf, count, pos, tbuf, len);
> +}
> +
> +static ssize_t hisi_ptt_tune_common_write(struct file *filp,
> +			const char __user *buf, size_t count, loff_t *pos)
> +{
> +	struct debugfs_file_desc *desc = filp->private_data;
> +	struct hisi_ptt *hisi_ptt = desc->hisi_ptt;
> +	char tbuf[HISI_PTT_CTRL_STR_LEN], *cp;
> +	int len, val;
> +
> +	len = simple_write_to_buffer(tbuf, HISI_PTT_CTRL_STR_LEN - 1,
> +				     pos, buf, count);
> +	if (len < 0)
> +		return -EINVAL;
> +	cp = strchr(tbuf, '\n');
> +	if (cp)
> +		*cp = '\0';
> +	if (kstrtouint(tbuf, 0, &val))
> +		return -EINVAL;
> +
> +	if (!mutex_trylock(&hisi_ptt->mutex))
> +		return -EBUSY;
> +	hisi_ptt->tune_event = tune_events[desc->index].event_code;
> +	hisi_ptt_tune_data_write(hisi_ptt, val);
> +	mutex_unlock(&hisi_ptt->mutex);
> +
> +	return count;
> +}
> +
> +static const struct file_operations tune_common_fops = {
> +	.owner		= THIS_MODULE,
> +	.open		= simple_open,
> +	.read		= hisi_ptt_tune_common_read,
> +	.write		= hisi_ptt_tune_common_write,
> +	.llseek		= no_llseek,
> +};
> +
> +static void hisi_ptt_free_trace_buf(struct hisi_ptt *hisi_ptt)
> +{
> +	struct ptt_trace_ctrl *ctrl = &hisi_ptt->trace_ctrl;
> +	struct device *dev = &hisi_ptt->pdev->dev;
> +	struct dma_buflet *buflet, *tbuflet;
> +
> +	if (list_empty(&ctrl->trace_buf))
> +		return;
> +
> +	list_for_each_entry_safe(buflet, tbuflet, &ctrl->trace_buf, list) {
> +		dma_free_coherent(dev, buflet->size, buflet->addr, buflet->dma);
> +		list_del(&buflet->list);
> +		kfree(buflet);
> +	}
> +}
> +
> +static int hisi_ptt_alloc_trace_buf(struct hisi_ptt *hisi_ptt)
> +{
> +	struct ptt_trace_ctrl *ctrl = &hisi_ptt->trace_ctrl;
> +	struct device *dev = &hisi_ptt->pdev->dev;
> +	struct dma_buflet *buflet;
> +	int i, ret;
> +
> +	/* Make sure the trace buffer is empty before allocating */
> +	if (!list_empty(&ctrl->trace_buf))
> +		hisi_ptt_free_trace_buf(hisi_ptt);
> +
> +	for (i = 0; i < ctrl->buflet_nums; ++i) {
> +		buflet = kzalloc(sizeof(*buflet), GFP_KERNEL);
> +		if (!buflet) {
> +			ret = -ENOMEM;
> +			goto err;
> +		}
> +		buflet->addr = dma_alloc_coherent(dev, ctrl->buflet_size,
> +						 &buflet->dma, GFP_KERNEL);
> +		if (!buflet->addr) {
> +			kfree(buflet);
> +			ret = -ENOMEM;
> +			goto err;
> +		}
> +		buflet->index = i;
> +		buflet->size = ctrl->buflet_size;
> +		list_add_tail(&buflet->list, &ctrl->trace_buf);
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
> +	atomic_dec(&hisi_ptt->trace_ctrl.status);
> +	hisi_ptt->trace_ctrl.cur = NULL;
> +}
> +
> +static int hisi_ptt_trace_start(struct hisi_ptt *hisi_ptt)
> +{
> +	struct ptt_trace_ctrl *ctrl = &hisi_ptt->trace_ctrl;
> +	struct pci_dev *pdev, *rp;
> +	u32 val;
> +	int i;
> +
> +	if (!hisi_ptt->target_func) {
> +		pci_err(hisi_ptt->pdev, "No available root port/function\n");
> +		return -ENODEV;
> +	}
> +	pdev = hisi_ptt->target_func->pdev;
> +	rp = pcie_find_root_port(pdev);
> +
> +	val = readl(hisi_ptt->iobase + HISI_PTT_TRACE_STS);
> +	if (!(val & HISI_PTT_TRACE_IDLE)) /* Trace has already started */
> +		return -EBUSY;
> +
> +	/* reset the DMA before start tracing */
> +	val = readl(hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
> +	val |= HISI_PTT_TRACE_CTRL_RST;
> +	writel(val, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
> +
> +	msleep(HISI_PTT_RESET_WAIT_MS);
> +
> +	val = readl(hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
> +	val &= ~HISI_PTT_TRACE_CTRL_RST;
> +	writel(val, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
> +
> +	/* clear the interrupt status */
> +	writel(0, hisi_ptt->iobase + HISI_PTT_TRACE_INT_STAT);
> +
> +	for (i = 0; i < HISI_PTT_DMA_NUMS; ++i) {
> +		if (!ctrl->cur)
> +			ctrl->cur = list_first_entry(&ctrl->trace_buf, struct dma_buflet, list);
> +		else
> +			ctrl->cur = list_next_entry(ctrl->cur, list);
> +
> +		writel(ctrl->cur->dma,
> +		       hisi_ptt->iobase + HISI_PTT_TRACE_ADDR_BASE_LO_0 + i * 8);
> +		writel(ctrl->cur->dma >> 32,
> +		       hisi_ptt->iobase + HISI_PTT_TRACE_ADDR_BASE_HI_0 + i * 8);
> +	}
> +	writel(ctrl->buflet_size, hisi_ptt->iobase + HISI_PTT_TRACE_ADDR_SIZE);
> +
> +	/* set the trace control register */
> +	val = 0;
> +	val |= FIELD_PREP(HISI_PTT_TRACE_CTRL_TYPE_SEL, ctrl->tr_event);
> +	val |= FIELD_PREP(HISI_PTT_TRACE_CTRL_RXTX_SEL, ctrl->rxtx);
> +	/*
> +	 * The TLP headers can be filtered either by the root port,
> +	 * or by the requester ID.
> +	 */
> +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT) {
> +		val |= FIELD_PREP(HISI_PTT_TRACE_CTRL_TARGET_SEL, pdev->bus->number << 8 | pdev->devfn);
> +		val |= HISI_PTT_TRACE_CTRL_FILTER_MODE;
> +	} else {
> +		val |= FIELD_PREP(HISI_PTT_TRACE_CTRL_TARGET_SEL, BIT(PCI_SLOT(rp->devfn)));
> +	}
> +
> +	val |= HISI_PTT_TRACE_CTRL_EN;
> +	writel(val, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
> +
> +	atomic_inc(&ctrl->status);
> +
> +	return 0;
> +}
> +
> +#define TRACE_ATTR(__name)						\
> +static int __name ## _open(struct inode *inode, struct file *filp)	\
> +{									\
> +	struct debugfs_file_desc *desc = inode->i_private;		\
> +	struct hisi_ptt *hisi_ptt = desc->hisi_ptt;			\
> +	if (!mutex_trylock(&hisi_ptt->mutex))				\
> +		return -EBUSY;						\
> +	return single_open(filp, __name ## _show, hisi_ptt);		\
> +}									\
> +static int __name ## _release(struct inode *inode, struct file *filp)	\
> +{									\
> +	struct debugfs_file_desc *desc = inode->i_private;		\
> +	struct hisi_ptt *hisi_ptt = desc->hisi_ptt;			\
> +	mutex_unlock(&hisi_ptt->mutex);					\
> +	return seq_release(inode, filp);				\
> +}									\
> +static const struct file_operations __name ## _fops = {			\
> +	.owner		= THIS_MODULE,					\
> +	.open		= __name ## _open,				\
> +	.read		= seq_read,					\
> +	.write		= __name ## _write,				\
> +	.llseek		= seq_lseek,					\
> +	.release	= __name ## _release,				\
> +}
> +
> +static int set_filter_show(struct seq_file *m, void *v)
> +{
> +	struct hisi_ptt *hisi_ptt = m->private;
> +	struct per_func_info *func;
> +
> +	list_for_each_entry(func, &hisi_ptt->avail_devfns, list) {
> +		struct pci_dev *pdev = func->pdev;
> +
> +		if (func == hisi_ptt->target_func)
> +			seq_printf(m, "[%04x:%02x:%02x.%d]\n",
> +				   pci_domain_nr(pdev->bus),
> +				   pdev->bus->number, PCI_SLOT(pdev->devfn),
> +				   PCI_FUNC(pdev->devfn));
> +		else
> +			seq_printf(m, "%04x:%02x:%02x.%d\n",
> +				   pci_domain_nr(pdev->bus),
> +				   pdev->bus->number, PCI_SLOT(pdev->devfn),
> +				   PCI_FUNC(pdev->devfn));
> +	}
> +
> +	return 0;
> +}
> +
> +static ssize_t set_filter_write(struct file *filp, const char __user *buf,
> +				    size_t count, loff_t *pos)
> +{
> +	struct seq_file *m = filp->private_data;
> +	struct hisi_ptt *hisi_ptt = m->private;
> +	char tbuf[HISI_PTT_CTRL_STR_LEN], *cp;
> +	u32 domain, bus, dev, fn, devfn;
> +	struct per_func_info *tfunc;
> +	int len, num;
> +	bool found = false;
> +
> +	if (list_empty(&hisi_ptt->avail_devfns))
> +		return -EINVAL;
> +	len = simple_write_to_buffer(tbuf, HISI_PTT_CTRL_STR_LEN - 1, pos, buf, count);
> +	if (len < 0)
> +		return -EINVAL;
> +	cp = strchr(tbuf, '\n');
> +	if (cp)
> +		*cp = '\0';
> +
> +	/*
> +	 * the input should be like 0000:80:01.1, etc. Parse it
> +	 * and check whether it's in the available func list.
> +	 */
> +	num = sscanf(tbuf, "%04x:%02x:%02x.%d", &domain, &bus, &dev, &fn);
> +	if (num != 4)
> +		return -EINVAL;
> +
> +	devfn = PCI_DEVFN(dev, fn);
> +	list_for_each_entry(tfunc, &hisi_ptt->avail_devfns, list) {
> +		struct pci_dev *pdev = tfunc->pdev;
> +
> +		if (domain == pci_domain_nr(pdev->bus) &&
> +		    bus == pdev->bus->number && devfn == pdev->devfn) {
> +			hisi_ptt->target_func = tfunc;
> +			found = true;
> +			break;
> +		}
> +	}
> +
> +	if (!found)
> +		return -EINVAL;
> +
> +	return count;
> +}
> +TRACE_ATTR(set_filter);
> +
> +static int set_direction_show(struct seq_file *m, void *v)
> +{
> +	struct hisi_ptt *hisi_ptt = m->private;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(trace_rxtx); ++i) {
> +		if (hisi_ptt->trace_ctrl.rxtx == trace_rxtx[i].event_code)
> +			seq_printf(m, "[%s]  ", trace_rxtx[i].name);
> +		else
> +			seq_printf(m, "%s  ", trace_rxtx[i].name);
> +	}
> +	seq_putc(m, '\n');
> +
> +	return 0;
> +}
> +
> +static ssize_t set_direction_write(struct file *filp, const char __user *buf,
> +				   size_t count, loff_t *pos)
> +{
> +	struct seq_file *m = filp->private_data;
> +	struct hisi_ptt *hisi_ptt = m->private;
> +	char tbuf[HISI_PTT_CTRL_STR_LEN], *cp;
> +	bool set = false;
> +	int len, i;
> +
> +	len = simple_write_to_buffer(tbuf, HISI_PTT_CTRL_STR_LEN, pos, buf, count);
> +	if (len < 0)
> +		return -EINVAL;
> +	cp = strchr(tbuf, '\n');
> +	if (cp)
> +		*cp = '\0';
> +
> +	for (i = 0; i < ARRAY_SIZE(trace_rxtx); ++i) {
> +		if (!strcmp(tbuf, trace_rxtx[i].name)) {
> +			hisi_ptt->trace_ctrl.rxtx = trace_rxtx[i].event_code;
> +			set = true;
> +			break;
> +		}
> +	}
> +
> +	if (!set)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +TRACE_ATTR(set_direction);
> +
> +static int set_trace_type_show(struct seq_file *m, void *v)
> +{
> +	struct hisi_ptt *hisi_ptt = m->private;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(trace_events); ++i) {
> +		if (hisi_ptt->trace_ctrl.tr_event == trace_events[i].event_code)
> +			seq_printf(m, "[%s]  ", trace_events[i].name);
> +		else
> +			seq_printf(m, "%s  ", trace_events[i].name);
> +	}
> +	seq_putc(m, '\n');
> +
> +	return 0;
> +}
> +
> +static ssize_t set_trace_type_write(struct file *filp, const char __user *buf,
> +			       size_t count, loff_t *pos)
> +{
> +	struct seq_file *m = filp->private_data;
> +	struct hisi_ptt *hisi_ptt = m->private;
> +	char tbuf[HISI_PTT_CTRL_STR_LEN], *cp;
> +	bool set = false;
> +	int len, i;
> +
> +	len = simple_write_to_buffer(tbuf, HISI_PTT_CTRL_STR_LEN, pos, buf, count);
> +	if (len < 0)
> +		return -EINVAL;
> +	cp = strchr(tbuf, '\n');
> +	if (cp)
> +		*cp = '\0';
> +
> +	for (i = 0; i < ARRAY_SIZE(trace_events); ++i) {
> +		if (!strcmp(tbuf, trace_events[i].name)) {
> +			hisi_ptt->trace_ctrl.tr_event = trace_events[i].event_code;
> +			set = true;
> +			break;
> +		}
> +	}
> +
> +	if (!set)
> +		return -EINVAL;
> +
> +	return count;
> +}
> +TRACE_ATTR(set_trace_type);
> +
> +static int trace_on_get(void *data, u64 *val)
> +{
> +	struct debugfs_file_desc *desc = data;
> +	struct hisi_ptt *hisi_ptt = desc->hisi_ptt;
> +
> +	if (!mutex_trylock(&hisi_ptt->mutex))
> +		return -EBUSY;
> +
> +	*val = atomic_read(&hisi_ptt->trace_ctrl.status);
> +
> +	mutex_unlock(&hisi_ptt->mutex);
> +
> +	return 0;
> +}
> +
> +static int trace_on_set(void *data, u64 val)
> +{
> +	struct debugfs_file_desc *desc = data;
> +	struct hisi_ptt *hisi_ptt = desc->hisi_ptt;
> +	int ret = 0;
> +
> +	if (!mutex_trylock(&hisi_ptt->mutex))
> +		return -EBUSY;
> +
> +	if (val) {
> +		if (atomic_read(&hisi_ptt->trace_ctrl.status))
> +			goto out;
> +		if (hisi_ptt_alloc_trace_buf(hisi_ptt)) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +		if (hisi_ptt_trace_start(hisi_ptt)) {
> +			ret = -EBUSY;
> +			goto out;
> +		}
> +	} else {
> +		if (!atomic_read(&hisi_ptt->trace_ctrl.status))
> +			goto out;
> +		hisi_ptt_trace_end(hisi_ptt);
> +	}
> +
> +out:
> +	hisi_ptt_free_trace_buf(hisi_ptt);
> +	mutex_unlock(&hisi_ptt->mutex);
> +	return ret;
> +}
> +DEFINE_DEBUGFS_ATTRIBUTE(trace_on_fops, trace_on_get,
> +			 trace_on_set, "%lld\n");
> +
> +static int set_trace_buf_nums_get(void *data, u64 *val)
> +{
> +	struct debugfs_file_desc *desc = data;
> +	struct hisi_ptt *hisi_ptt = desc->hisi_ptt;
> +
> +	if (!mutex_trylock(&hisi_ptt->mutex))
> +		return -EBUSY;
> +
> +	*val = hisi_ptt->trace_ctrl.buflet_nums;
> +
> +	mutex_unlock(&hisi_ptt->mutex);
> +	return 0;
> +}
> +
> +static int set_trace_buf_nums_set(void *data, u64 val)
> +{
> +	struct debugfs_file_desc *desc = data;
> +	struct hisi_ptt *hisi_ptt = desc->hisi_ptt;
> +
> +	if (!mutex_trylock(&hisi_ptt->mutex))
> +		return -EBUSY;
> +
> +	hisi_ptt->trace_ctrl.buflet_nums = val;
> +
> +	mutex_unlock(&hisi_ptt->mutex);
> +	return 0;
> +}
> +DEFINE_DEBUGFS_ATTRIBUTE(set_trace_buf_nums_fops, set_trace_buf_nums_get,
> +			 set_trace_buf_nums_set, "%lld\n");
> +
> +static int set_trace_buflet_size_show(struct seq_file *m, void *v)
> +{
> +	struct hisi_ptt *hisi_ptt = m->private;
> +	struct ptt_trace_ctrl *ctrl = &hisi_ptt->trace_ctrl;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(available_buflet_size); ++i) {
> +		if (ctrl->buflet_size == available_buflet_size[i]) {
> +			seq_printf(m, "[%dMiB]  ",
> +				   available_buflet_size[i] >> 20);
> +			continue;
> +		}
> +		seq_printf(m, "%dMiB  ", available_buflet_size[i] >> 20);
> +	}
> +	seq_putc(m, '\n');
> +
> +	return 0;
> +}
> +
> +static ssize_t set_trace_buflet_size_write(struct file *filp,
> +			const char __user *buf, size_t count, loff_t *pos)
> +{
> +	struct seq_file *m = filp->private_data;
> +	struct hisi_ptt *hisi_ptt = m->private;
> +	struct ptt_trace_ctrl *ctrl = &hisi_ptt->trace_ctrl;
> +	char tbuf[HISI_PTT_CTRL_STR_LEN], *cp;
> +	int i, len, size, set = 0;
> +
> +	len = simple_write_to_buffer(tbuf, HISI_PTT_CTRL_STR_LEN, pos, buf, count);
> +	cp = strchr(tbuf, '\n');
> +	if (cp)
> +		*cp = '\0';
> +	if (kstrtouint(tbuf, 0, &size))
> +		return -EINVAL;
> +	size <<= 20;
> +
> +	for (i = 0; i < ARRAY_SIZE(available_buflet_size); ++i) {
> +		if (available_buflet_size[i] == size) {
> +			ctrl->buflet_size = size;
> +			set = 1;
> +			break;
> +		}
> +	}
> +
> +	if (!set)
> +		return -EINVAL;
> +
> +	return count;
> +}
> +TRACE_ATTR(set_trace_buflet_size);
> +
> +static int free_trace_buf_get(void *data, u64 *val)
> +{
> +	struct debugfs_file_desc *desc = data;
> +	struct hisi_ptt *hisi_ptt = desc->hisi_ptt;
> +
> +	if (!mutex_trylock(&hisi_ptt->mutex))
> +		return -EBUSY;
> +
> +	*val = list_empty(&hisi_ptt->trace_ctrl.trace_buf);
> +
> +	mutex_unlock(&hisi_ptt->mutex);
> +	return 0;
> +}
> +
> +static int free_trace_buf_set(void *data, u64 val)
> +{
> +	struct debugfs_file_desc *desc = data;
> +	struct hisi_ptt *hisi_ptt = desc->hisi_ptt;
> +	int ret = 0;
> +
> +	if (!mutex_trylock(&hisi_ptt->mutex))
> +		return -EBUSY;
> +
> +	if (!list_empty(&hisi_ptt->trace_ctrl.trace_buf)) {
> +		if (atomic_read(&hisi_ptt->trace_ctrl.status))
> +			ret = -EBUSY;
> +		else
> +			hisi_ptt_free_trace_buf(hisi_ptt);
> +	}
> +
> +	mutex_unlock(&hisi_ptt->mutex);
> +	return ret;
> +}
> +DEFINE_DEBUGFS_ATTRIBUTE(free_trace_buf_fops, free_trace_buf_get,
> +			 free_trace_buf_set, "%lld\n");
> +
> +static void *trace_data_next(struct seq_file *m, void *v, loff_t *pos)
> +{
> +	struct hisi_ptt *hisi_ptt = m->private;
> +	struct dma_buflet *buflet = v;
> +
> +	(*pos)++;
> +
> +	if (!list_is_last(&buflet->list, &hisi_ptt->trace_ctrl.trace_buf))
> +		return list_next_entry(buflet, list);
> +
> +	return NULL;
> +}
> +
> +static void *trace_data_start(struct seq_file *m, loff_t *pos)
> +{
> +	struct hisi_ptt *hisi_ptt = m->private;
> +	struct dma_buflet *buflet;
> +	loff_t off = 0;
> +
> +	buflet = list_first_entry(&hisi_ptt->trace_ctrl.trace_buf, struct dma_buflet, list);
> +	while (off < *pos)
> +		buflet = trace_data_next(m, buflet, &off);
> +
> +	return buflet;
> +}
> +
> +static void trace_data_stop(struct seq_file *m, void *p)
> +{
> +	/* Nothing to do, only a stub */
> +}
> +
> +static int trace_data_show(struct seq_file *m, void *v)
> +{
> +	struct dma_buflet *buflet = v;
> +
> +	if (buflet)
> +		seq_write(m, buflet->addr, buflet->size);
> +
> +	return 0;
> +}
> +
> +static const struct seq_operations trace_data_seq_ops = {
> +	.start	= trace_data_start,
> +	.next	= trace_data_next,
> +	.stop	= trace_data_stop,
> +	.show	= trace_data_show,
> +};
> +
> +static int trace_data_open(struct inode *inode, struct file *filep)
> +{
> +	struct hisi_ptt *hisi_ptt = inode->i_private;
> +	struct seq_file *m;
> +	int ret;
> +
> +	/*
> +	 * Check the trace status, we cannot read the
> +	 * data if the trace is still on. Then hold the
> +	 * lock when reading the traced data.
> +	 */
> +	if (atomic_read(&hisi_ptt->trace_ctrl.status) ||
> +	    !mutex_trylock(&hisi_ptt->mutex))
> +		return -EBUSY;
> +
> +	if (list_empty(&hisi_ptt->trace_ctrl.trace_buf)) {
> +		ret = -ENOTTY;
> +		goto err;
> +	}
> +
> +	ret = seq_open(filep, &trace_data_seq_ops);
> +	if (ret)
> +		goto err;
> +
> +	m = filep->private_data;
> +	m->private = hisi_ptt;
> +
> +	return 0;
> +err:
> +	mutex_unlock(&hisi_ptt->mutex);
> +	return ret;
> +}
> +
> +static ssize_t trace_data_write(struct file *filp, const char __user *buf,
> +				size_t count, loff_t *off)
> +{
> +	struct seq_file *m = filp->private_data;
> +	struct hisi_ptt *hisi_ptt = m->private;
> +	char tbuf[HISI_PTT_CTRL_STR_LEN], *cp;
> +	int len;
> +
> +	len = simple_write_to_buffer(tbuf, HISI_PTT_CTRL_STR_LEN, off, buf, count);
> +	cp = strchr(tbuf, '\n');
> +	if (cp)
> +		*cp = '\0';
> +
> +	/* Free the trace buffer when echo "" > trace_data */
> +	if (!strlen(tbuf) && !list_empty(&hisi_ptt->trace_ctrl.trace_buf)) {
> +		if (atomic_read(&hisi_ptt->trace_ctrl.status))
> +			return -EBUSY;
> +		hisi_ptt_free_trace_buf(hisi_ptt);
> +	}
> +
> +	return count;
> +}
> +
> +static int trace_data_release(struct inode *inode, struct file *filp)
> +{
> +	struct hisi_ptt *hisi_ptt = inode->i_private;
> +
> +	mutex_unlock(&hisi_ptt->mutex);
> +
> +	return seq_release(inode, filp);
> +}
> +
> +static const struct file_operations trace_data_fops = {
> +	.owner		= THIS_MODULE,
> +	.open		= trace_data_open,
> +	.read		= seq_read,
> +	.write		= trace_data_write,
> +	.llseek		= no_llseek,
> +	.release	= trace_data_release,
> +};
> +
> +static struct debugfs_file_desc trace_entries[] = {
> +	{ NULL, "filter", &set_filter_fops, 0 },
> +	{ NULL, "direction", &set_direction_fops, 0 },
> +	{ NULL, "type", &set_trace_type_fops, 0 },
> +	{ NULL, "trace_on", &trace_on_fops, 0 },
> +	{ NULL, "buf_nums", &set_trace_buf_nums_fops, 0 },
> +	{ NULL, "buflet_size", &set_trace_buflet_size_fops, 0 },
> +	{ NULL, "free_buffer", &free_trace_buf_fops, 0 },
> +	{ NULL, "data", &trace_data_fops, 0 },
> +};
> +
> +irqreturn_t hisi_ptt_isr(int irq, void *context)
> +{
> +	struct hisi_ptt *hisi_ptt = context;
> +	struct dma_buflet *next, *cur;
> +	u32 val, buf_idx;
> +
> +	val = readl(hisi_ptt->iobase + HISI_PTT_TRACE_INT_STAT);
> +	buf_idx = __ffs(val & HISI_PTT_TRACE_INT_STAT_MASK);
> +	/*
> +	 * Check whether the trace buffer is full. Stop tracing
> +	 * when the last DMA buffer is finished. Otherwise, assign
> +	 * the address of next buflet to the DMA register.
> +	 */
> +	cur = hisi_ptt->trace_ctrl.cur;
> +	if (list_is_last(&cur->list, &hisi_ptt->trace_ctrl.trace_buf)) {
> +		if ((val & HISI_PTT_TRACE_INT_STAT_MASK) == HISI_PTT_TRACE_INT_STAT_MASK)
> +			hisi_ptt_trace_end(hisi_ptt);
> +	} else {
> +		next = list_next_entry(cur, list);
> +		writel(next->dma, hisi_ptt->iobase + HISI_PTT_TRACE_ADDR_BASE_LO_0 + buf_idx * 8);
> +		writel(next->dma >> 32, hisi_ptt->iobase + HISI_PTT_TRACE_ADDR_BASE_HI_0 + buf_idx * 8);
> +		hisi_ptt->trace_ctrl.cur = next;
> +		val &= ~BIT(buf_idx);
> +		writel(val, hisi_ptt->iobase + HISI_PTT_TRACE_INT_STAT);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +irqreturn_t hisi_ptt_irq(int irq, void *context)
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
> +static int hisi_ptt_irq_register(struct hisi_ptt *hisi_ptt)
> +{
> +	struct pci_dev *pdev = hisi_ptt->pdev;
> +	int ret;
> +
> +	ret = pci_alloc_irq_vectors(pdev, HISI_PTT_IRQ_NUMS, HISI_PTT_IRQ_NUMS,
> +				    PCI_IRQ_MSI);
> +	if (ret < 0) {
> +		pci_err(pdev, "allocate irq vector failed %d", ret);
> +		return ret;
> +	}
> +
> +	ret = request_threaded_irq(pci_irq_vector(pdev, HISI_PTT_DMA_IRQ),
> +				   hisi_ptt_irq, hisi_ptt_isr, IRQF_SHARED,
> +				   hisi_ptt->name, hisi_ptt);
> +
> +	if (ret) {
> +		pci_err(pdev, "request irq %d failed",
> +			pci_irq_vector(pdev, HISI_PTT_DMA_IRQ));
> +		pci_free_irq_vectors(pdev);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void hisi_ptt_irq_unregister(struct hisi_ptt *hisi_ptt)
> +{
> +	struct pci_dev *pdev = hisi_ptt->pdev;
> +
> +	free_irq(pci_irq_vector(pdev, HISI_PTT_DMA_IRQ), hisi_ptt);
> +	pci_free_irq_vectors(pdev);
> +}
> +
> +static void hisi_ptt_init_ctrls(struct hisi_ptt *hisi_ptt)
> +{
> +	struct pci_dev *pdev = hisi_ptt->pdev, *tpdev;
> +	struct pci_bus *child_bus;
> +	unsigned long port_mask, bit;
> +
> +	hisi_ptt->domain = pci_domain_nr(pdev->bus);
> +	hisi_ptt->bus = pdev->bus->number;
> +	/*
> +	 * The mailbox register provides the information about the
> +	 * root ports which the RCiEP can control and monitor.
> +	 */
> +	port_mask = readl(hisi_ptt->iobase + HISI_PTT_MAILBOX_0);
> +
> +	/*
> +	 * The ports traced by the RCiEP are masked by the register.
> +	 * Some ports may not exists even if they are masked. We'll check
> +	 * whether one port is enabled by finding its pci_dev structure
> +	 * in the device list, and add it and its subordinates
> +	 * in the available devfns list.
> +	 */
> +	for_each_set_bit(bit, &port_mask, sizeof(port_mask) * 8) {
> +		struct per_func_info *func;
> +
> +		tpdev = pci_get_domain_bus_and_slot(hisi_ptt->domain,
> +						    hisi_ptt->bus,
> +						    PCI_DEVFN(bit, 0));
> +		/*
> +		 * If the root port is not existed in the system,
> +		 * just skip it and check next one.
> +		 */
> +		if (!tpdev)
> +			continue;
> +
> +		func = devm_kmalloc(&pdev->dev, sizeof(*func), GFP_KERNEL);
> +		if (!func)
> +			continue;
> +		func->pdev = tpdev;
> +		pci_dev_put(tpdev);
> +
> +		list_add_tail(&func->list, &hisi_ptt->avail_devfns);
> +
> +		/*
> +		 * The PTT can designate function for trace.
> +		 * Add the root port's subordinates in the list as we
> +		 * can specify certain function.
> +		 */
> +		child_bus = tpdev->subordinate;
> +		list_for_each_entry(tpdev, &child_bus->devices, bus_list) {
> +			func = devm_kmalloc(&pdev->dev, sizeof(*func),
> +					    GFP_KERNEL);
> +			if (!func)
> +				continue;
> +			func->pdev = tpdev;
> +			list_add_tail(&func->list, &hisi_ptt->avail_devfns);
> +		}
> +	}
> +
> +	/* Initialize the target function */
> +	if (!list_empty(&hisi_ptt->avail_devfns))
> +		hisi_ptt->target_func = list_first_entry(&hisi_ptt->avail_devfns,
> +						struct per_func_info, list);
> +
> +	/* Initialize trace controls */
> +	INIT_LIST_HEAD(&hisi_ptt->trace_ctrl.trace_buf);
> +	hisi_ptt->trace_ctrl.buflet_nums = HISI_PTT_DEFAULT_TRACE_BUF_CNT;
> +	hisi_ptt->trace_ctrl.buflet_size = available_buflet_size[0];
> +	hisi_ptt->trace_ctrl.tr_event = trace_events[0].event_code;
> +	hisi_ptt->trace_ctrl.rxtx = trace_rxtx[0].event_code;
> +}
> +
> +static int hisi_ptt_create_debugfs_entries(struct hisi_ptt *hisi_ptt)
> +{
> +	struct dentry *tdir;
> +	int i;
> +
> +	hisi_ptt->debugfs_dir = debugfs_create_dir(hisi_ptt->name,
> +						   hisi_ptt_debugfs_root);
> +	if (IS_ERR(hisi_ptt->debugfs_dir))
> +		return -ENOENT;
> +
> +	tdir = debugfs_create_dir("tune", hisi_ptt->debugfs_dir);
> +	if (IS_ERR(tdir))
> +		goto err;
> +	for (i = 0; i < ARRAY_SIZE(tune_events); ++i) {
> +		struct debugfs_file_desc *tune_file;
> +
> +		tune_file = devm_kzalloc(&hisi_ptt->pdev->dev,
> +					 sizeof(*tune_file), GFP_KERNEL);
> +		if (!tune_file)
> +			goto err;
> +		tune_file->hisi_ptt = hisi_ptt;
> +		/* We use tune event string as control file name. */
> +		tune_file->name = tune_events[i].name;
> +		tune_file->fops = &tune_common_fops;
> +		tune_file->index = i;
> +		if (IS_ERR(debugfs_create_file(tune_events[i].name, 0600,
> +					       tdir, tune_file,
> +					       &tune_common_fops)))
> +			goto err;
> +	}
> +
> +	tdir = debugfs_create_dir("trace", hisi_ptt->debugfs_dir);
> +	if (IS_ERR(tdir))
> +		goto err;
> +	for (i = 0; i < ARRAY_SIZE(trace_entries); ++i) {
> +		trace_entries[i].hisi_ptt = hisi_ptt;
> +		trace_entries[i].index = i;
> +		if (IS_ERR(debugfs_create_file(trace_entries[i].name, 0600,
> +					       tdir, &trace_entries[i],
> +					       trace_entries[i].fops)))
> +			goto err;
> +	}
> +
> +	return 0;
> +err:
> +	pci_err(hisi_ptt->pdev, "create debugfs entries failed\n");
> +	debugfs_remove_recursive(hisi_ptt->debugfs_dir);
> +	return -ENOENT;
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
> +	INIT_LIST_HEAD(&hisi_ptt->avail_devfns);
> +	hisi_ptt->pdev = pdev;
> +	/*
> +	 * Lifetime of pci_dev is longer than hisi_ptt,
> +	 * so directly reference to the pci name string.
> +	 */
> +	hisi_ptt->name = pci_name(pdev);
> +	pci_set_drvdata(pdev, hisi_ptt);
> +
> +	ret = pcim_enable_device(pdev);
> +	if (ret) {
> +		pci_err(pdev, "fail to enable device\n");
> +		return ret;
> +	}
> +
> +	ret = pcim_iomap_regions(pdev, BIT(0), hisi_ptt->name);
> +	if (ret) {
> +		pci_err(pdev, "fail to remap io memory\n");
> +		return ret;
> +	}
> +
> +	ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
> +	if (ret) {
> +		pci_err(pdev, "fail to set 64 bit dma mask %d", ret);
> +		return ret;
> +	}
> +	pci_set_master(pdev);
> +
> +	ret = hisi_ptt_irq_register(hisi_ptt);
> +	if (ret)
> +		return ret;
> +
> +	hisi_ptt_init_ctrls(hisi_ptt);
> +
> +	ret = hisi_ptt_create_debugfs_entries(hisi_ptt);
> +	if (ret) {
> +		hisi_ptt_irq_unregister(hisi_ptt);
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
> +	hisi_ptt_free_trace_buf(hisi_ptt);
> +	debugfs_remove_recursive(hisi_ptt->debugfs_dir);
> +	hisi_ptt_irq_unregister(hisi_ptt);
> +}
> +
> +static pci_ers_result_t hisi_ptt_err_detected(struct pci_dev *pdev,
> +						pci_channel_state_t state)
> +{
> +	/* The PTT device doesn't support error recovery */
> +	return PCI_ERS_RESULT_RECOVERED;
> +}
> +
> +static const struct pci_error_handlers hisi_ptt_err_handler = {
> +	.error_detected = hisi_ptt_err_detected,
> +};
> +
> +#define PCI_DEVICE_ID_HISI_PTT 0xa250
> +static const struct pci_device_id hisi_ptt_id_tbl[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HISI_PTT) },
> +	{ 0, }
> +};
> +
> +static struct pci_driver hisi_ptt_driver = {
> +	.name = "hisi_ptt",
> +	.id_table = hisi_ptt_id_tbl,
> +	.probe = hisi_ptt_probe,
> +	.remove = hisi_ptt_remove,
> +	.err_handler = &hisi_ptt_err_handler,
> +};
> +
> +static int hisi_ptt_register_debugfs(void)
> +{
> +	if (!debugfs_initialized()) {
> +		pr_err("error: debugfs uninitialized\n");
> +		return -ENOENT;
> +	}
> +
> +	hisi_ptt_debugfs_root = debugfs_create_dir("hisi_ptt", NULL);
> +	if (IS_ERR(hisi_ptt_debugfs_root)) {
> +		pr_err("error: fail to create debugfs directory\n");
> +		return -ENOENT;
> +	}
> +
> +	return 0;
> +}
> +
> +static void hisi_ptt_unregister_debugfs(void)
> +{
> +	debugfs_remove_recursive(hisi_ptt_debugfs_root);
> +}
> +
> +static int __init hisi_ptt_module_init(void)
> +{
> +	int ret;
> +
> +	/* The driver cannot work without debugfs entry */
> +	ret = hisi_ptt_register_debugfs();
> +	if (ret)
> +		return ret;
> +
> +	ret = pci_register_driver(&hisi_ptt_driver);
> +	if (ret) {
> +		pr_err("error: fail to register hisi ptt driver\n");
> +		hisi_ptt_unregister_debugfs();
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void __exit hisi_ptt_module_exit(void)
> +{
> +	pci_unregister_driver(&hisi_ptt_driver);
> +	hisi_ptt_unregister_debugfs();
> +}
> +
> +module_init(hisi_ptt_module_init);
> +module_exit(hisi_ptt_module_exit);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Yicong Yang <yangyicong@hisilicon.com>");
> +MODULE_DESCRIPTION("Driver for HiSilicon PCIe tune and trace device");


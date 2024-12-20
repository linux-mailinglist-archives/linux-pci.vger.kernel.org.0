Return-Path: <linux-pci+bounces-18869-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2299F8E6E
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 09:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51FA81606B3
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 08:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E4F1A726B;
	Fri, 20 Dec 2024 08:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCxmYMrP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A5C1A0BFA
	for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 08:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734685148; cv=none; b=rGHHnTcI1d4yHRk8GmWTmUNLK61RctXrkVpZe3PQEzcnrJEOK/w58+Fy13coie00D4nvNYbVX1x8m38LrEpPB4aALDOx49bjItOp8iDpMZeiOt+big96gV0Kd7bQXd5CxKhDjZZ0/Ti0Gk6sIm3Px1Zw4uLxMjqAu7j2lXk3LMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734685148; c=relaxed/simple;
	bh=eHV3LoXS0tJ7c4AvcXhLOVu/Zv01u/ETeZjRXDrdPmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=llJxJLLQQ7+V5M5QOFcKgNqgBH5RU2US7e1MxuDXRpyZo4CZrHZLKx/hzSIxIx9H6+DlSz9UoUJz8yoFeY2K1ggKfPgzJqPOXMqzWRkLjKIhg8eNnIeSIZagNhY0mSyNm14KNRIbeqPbbq97aRfcoFqF7iQQSNs/4EeNpx6Ev5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCxmYMrP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93CF4C4CECD;
	Fri, 20 Dec 2024 08:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734685148;
	bh=eHV3LoXS0tJ7c4AvcXhLOVu/Zv01u/ETeZjRXDrdPmk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GCxmYMrPwU4Fcn7iJ8lw6DwdzFhMxNF4QfIJJMmcytQPRsfpdKl+79Aa1bZKUG8xP
	 JixexehRtXVQHGykXsaMedSLqvDBZb83KOweSdQo+kyjq3y76DRz+Zwuh7+QRPyTqP
	 Hm/SywaCtOP0ccyA/ixndXu83KuSwpDZdXvLHyefkh77lJvPgk3zzLQ+nGaGf5MBGL
	 YYK4pTr6FyNZTfDUwT4vyMKZotUoP+A3w2x0RsqlG+E1NJMo9SIJnUfRNfdmwf9SLs
	 1TZahntHn3fPMT9yA20VOrF4t+6SsAp2KqUXjwa3oPZjLBtcpXDWwuEGK9CIYdcu5b
	 OGGNqqknln6ew==
Message-ID: <eb787b7e-f141-4120-a6b0-e1b3f6bebd2d@kernel.org>
Date: Fri, 20 Dec 2024 17:59:05 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 17/18] nvmet: New NVMe PCI endpoint function target
 driver
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-pci@vger.kernel.org, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Rick Wertenbroek <rick.wertenbroek@gmail.com>,
 Niklas Cassel <cassel@kernel.org>
References: <20241220035441.600193-1-dlemoal@kernel.org>
 <20241220035441.600193-18-dlemoal@kernel.org>
 <20241220081229.pij52jwfdyeygux7@thinkpad>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241220081229.pij52jwfdyeygux7@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/20/24 17:12, Manivannan Sadhasivam wrote:
> On Fri, Dec 20, 2024 at 12:54:40PM +0900, Damien Le Moal wrote:
>> Implement a PCI target driver using the PCI endpoint framework. This
>> requires hardware with a PCI controller capable of executing in endpoint
>> mode.
>>
>> The PCI endpoint framework is used to set up a PCI endpoint function
>> and its BAR compatible with a NVMe PCI controller. The framework is also
>> used to map local memory to the PCI address space to execute MMIO
>> accesses for retrieving NVMe commands from submission queues and posting
>> completion entries to completion queues. If supported, DMA is used for
>> command retreival and command data transfers, based on the PCI address
>> segments indicated by the command using either PRPs or SGLs.
>>
>> The NVMe target driver relies on the NVMe target core code to execute
>> all commands isssued by the host. The PCI target driver is mainly
>> responsible for the following:
>>  - Initialization and teardown of the endpoint device and its backend
>>    PCI target controller. The PCI target controller is created using a
>>    subsystem and a port defined through configfs. The port used must be
>>    initialized with the "pci" transport type. The target controller is
>>    allocated and initialized when the PCI endpoint is started by binding
>>    it to the endpoint PCI device (nvmet_pci_epf_epc_init() function).
>>
>>  - Manage the endpoint controller state according to the PCI link state
>>    and the actions of the host (e.g. checking the CC.EN register) and
>>    propagate these actions to the PCI target controller. Polling of the
>>    controller enable/disable is done using a delayed work scheduled
>>    every 5ms (nvmet_pci_epf_poll_cc() function). This work is started
>>    whenever the PCI link comes up (nvmet_pci_epf_link_up() notifier
>>    function) and stopped when the PCI link comes down
>>    (nvmet_pci_epf_link_down() notifier function).
>>    nvmet_pci_epf_poll_cc() enables and disables the PCI controller using
>>    the functions nvmet_pci_epf_enable_ctrl() and
>>    nvmet_pci_epf_disable_ctrl(). The controller admin queue is created
>>    using nvmet_pci_epf_create_cq(), which calls nvmet_cq_create(), and
>>    nvmet_pci_epf_create_sq() which uses nvmet_sq_create().
>>    nvmet_pci_epf_disable_ctrl() always resets the PCI controller to its
>>    initial state so that nvmet_pci_epf_enable_ctrl() can be called
>>    again. This ensures correct operation if, for instance, the host
>>    reboots causing the PCI link to be temporarily down.
>>
>>  - Manage the controller admin and I/O submission queues using local
>>    memory. Commands are obtained from submission queues using a work
>>    item that constantly polls the doorbells of all submissions queues
>>    (nvmet_pci_epf_poll_sqs() function). This work is started whenever
>>    the controller is enabled (nvmet_pci_epf_enable_ctrl() function) and
>>    stopped when the controller is disabled (nvmet_pci_epf_disable_ctrl()
>>    function). When new commands are submitted by the host, DMA transfers
>>    are used to retrieve the commands.
>>
>>  - Initiate the execution of all admin and I/O commands using the target
>>    core code, by calling a requests execute() function. All commands are
>>    individually handled using a per-command work item
>>    (nvmet_pci_epf_iod_work() function). A command overall execution
>>    includes: initializing a struct nvmet_req request for the command,
>>    using nvmet_req_transfer_len() to get a command data transfer length,
>>    parse the command PRPs or SGLs to get the PCI address segments of
>>    the command data buffer, retrieve data from the host (if the command
>>    is a write command), call req->execute() to execute the command and
>>    transfer data to the host (for read commands).
>>
>>  - Handle the completions of commands as notified by the
>>    ->queue_response() operation of the PCI target controller
>>    (nvmet_pci_epf_queue_response() function). Completed commands are
>>    added to a list of completed command for their CQ. Each CQ list of
>>    completed command is processed using a work item
>>    (nvmet_pci_epf_cq_work() function) which posts entries for the
>>    completed commands in the CQ memory and raise an IRQ to the host to
>>    signal the completion. IRQ coalescing is supported as mandated by the
>>    NVMe base specification for PCI controllers. Of note is that
>>    completion entries are transmitted to the host using MMIO, after
>>    mapping the completion queue memory to the host PCI address space.
>>    Unlike for retrieving commands from SQs, DMA is not used as it
>>    degrades performance due to the transfer serialization needed (which
>>    delays completion entries transmission).
>>
>> The configuration of a NVMe PCI endpoint controller is done using
>> configfs. First the NVMe PCI target controller configuration must be
>> done to set up a subsystem and a port with the "pci" addr_trtype
>> attribute. The subsystem can be setup using a file or block device
>> backed namespace or using a passthrough NVMe device. After this, the
>> PCI endpoint can be configured and bound to the PCI endpoint controller
>> to start the NVMe endpoint controller.
>>
>> In order to not overcomplicate this initial implementation of an
>> endpoint PCI target controller driver, protection information is not
>> for now supported. If the PCI controller port and namespace are
>> configured with protection information support, an error will be
>> returned when the controller is created and initialized when the
>> endpoint function is started. Protection information support will be
>> added in a follow-up patch series.
>>
>> Using a Rock5B board (Rockchip RK3588 SoC, PCI Gen3x4 endpoint
>> controller) with a target PCI controller setup with 4 I/O queues and a
>> null_blk block device as a namespace, the maximum performance using fio
>> was measured at 131 KIOPS for random 4K reads and up to 2.8 GB/S
>> throughput. Some data points are:
>>
>> Rnd read,   4KB,  QD=1, 1 job : IOPS=16.9k, BW=66.2MiB/s (69.4MB/s)
>> Rnd read,   4KB, QD=32, 1 job : IOPS=78.5k, BW=307MiB/s (322MB/s)
>> Rnd read,   4KB, QD=32, 4 jobs: IOPS=131k, BW=511MiB/s (536MB/s)
>> Seq read, 512KB, QD=32, 1 job : IOPS=5381, BW=2691MiB/s (2821MB/s)
>>
>> The NVMe PCI endpoint target driver is not intended for production use.
>> It is a tool for learning NVMe, exploring existing features and testing
>> implementations of new NVMe features.
>>
>> Co-developed-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> ---
>>  drivers/nvme/target/Kconfig   |   10 +
>>  drivers/nvme/target/Makefile  |    2 +
>>  drivers/nvme/target/pci-epf.c | 2598 +++++++++++++++++++++++++++++++++
>>  3 files changed, 2610 insertions(+)
>>  create mode 100644 drivers/nvme/target/pci-epf.c
>>
>> diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
>> index 46be031f91b4..e3cd5d8fa63d 100644
>> --- a/drivers/nvme/target/Kconfig
>> +++ b/drivers/nvme/target/Kconfig
>> @@ -115,3 +115,13 @@ config NVME_TARGET_AUTH
>>  	  target side.
>>  
>>  	  If unsure, say N.
>> +
>> +config NVME_TARGET_PCI_EPF
>> +	tristate "NVMe PCI Endpoint Function target support"
>> +	depends on NVME_TARGET && PCI_ENDPOINT
>> +	help
>> +	  This enables the NVMe PCI endpoint function target driver support,
>> +	  which allows creating a NVMe PCI controller using an endpoint mode
>> +	  capable PCI controller.
>> +
>> +	  If unsure, say N.
>> diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile
>> index f2b025bbe10c..ed8522911d1f 100644
>> --- a/drivers/nvme/target/Makefile
>> +++ b/drivers/nvme/target/Makefile
>> @@ -8,6 +8,7 @@ obj-$(CONFIG_NVME_TARGET_RDMA)		+= nvmet-rdma.o
>>  obj-$(CONFIG_NVME_TARGET_FC)		+= nvmet-fc.o
>>  obj-$(CONFIG_NVME_TARGET_FCLOOP)	+= nvme-fcloop.o
>>  obj-$(CONFIG_NVME_TARGET_TCP)		+= nvmet-tcp.o
>> +obj-$(CONFIG_NVME_TARGET_PCI_EPF)	+= nvmet-pci-epf.o
>>  
>>  nvmet-y		+= core.o configfs.o admin-cmd.o fabrics-cmd.o \
>>  			discovery.o io-cmd-file.o io-cmd-bdev.o pr.o
>> @@ -20,4 +21,5 @@ nvmet-rdma-y	+= rdma.o
>>  nvmet-fc-y	+= fc.o
>>  nvme-fcloop-y	+= fcloop.o
>>  nvmet-tcp-y	+= tcp.o
>> +nvmet-pci-epf-y	+= pci-epf.o
>>  nvmet-$(CONFIG_TRACING)	+= trace.o
>> diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
>> new file mode 100644
>> index 000000000000..8db084f1b20b
>> --- /dev/null
>> +++ b/drivers/nvme/target/pci-epf.c
>> @@ -0,0 +1,2598 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * NVMe PCI Endpoint Function driver.
>> + *
>> + * Copyright (c) 2024, Western Digital Corporation or its affiliates.
>> + * Copyright (c) 2024, Rick Wertenbroek <rick.wertenbroek@gmail.com>
>> + *                     REDS Institute, HEIG-VD, HES-SO, Switzerland
>> + */
>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>> +
>> +#include <linux/delay.h>
>> +#include <linux/dmaengine.h>
>> +#include <linux/io.h>
>> +#include <linux/mempool.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +#include <linux/nvme.h>
>> +#include <linux/pci_ids.h>
>> +#include <linux/pci-epc.h>
>> +#include <linux/pci-epf.h>
>> +#include <linux/pci_regs.h>
>> +#include <linux/slab.h>
>> +
>> +#include "nvmet.h"
>> +
>> +static LIST_HEAD(nvmet_pci_epf_ports);
>> +static DEFINE_MUTEX(nvmet_pci_epf_ports_mutex);
>> +
>> +/*
>> + * Default and maximum allowed data transfer size. For the default,
>> + * allow up to 128 page-sized segments. For the maximum allowed,
>> + * use 4 times the default (which is completely arbitrary).
>> + */
>> +#define NVMET_PCI_EPF_MAX_SEGS		128
>> +#define NVMET_PCI_EPF_MDTS_KB		\
>> +	(NVMET_PCI_EPF_MAX_SEGS << (PAGE_SHIFT - 10))
>> +#define NVMET_PCI_EPF_MAX_MDTS_KB	(NVMET_PCI_EPF_MDTS_KB * 4)
>> +
>> +/*
>> + * IRQ vector coalescing threshold: by default, post 8 CQEs before raising an
>> + * interrupt vector to the host. This default 8 is completely arbitrary and can
>> + * be changed by the host with a nvme_set_features command.
>> + */
>> +#define NVMET_PCI_EPF_IV_THRESHOLD	8
>> +
>> +/*
>> + * BAR CC register and SQ polling intervals.
>> + */
>> +#define NVMET_PCI_EPF_CC_POLL_INTERVAL	msecs_to_jiffies(5)
>> +#define NVMET_PCI_EPF_SQ_POLL_INTERVAL	msecs_to_jiffies(5)
>> +#define NVMET_PCI_EPF_SQ_POLL_IDLE	msecs_to_jiffies(5000)
>> +
>> +/*
>> + * SQ arbitration burst default: fetch at most 8 commands at a time from an SQ.
>> + */
>> +#define NVMET_PCI_EPF_SQ_AB		8
>> +
>> +/*
>> + * Handling of CQs is normally immediate, unless we fail to map a CQ or the CQ
>> + * is full, in which case we retry the CQ processing after this interval.
>> + */
>> +#define NVMET_PCI_EPF_CQ_RETRY_INTERVAL	msecs_to_jiffies(1)
>> +
>> +enum nvmet_pci_epf_queue_flags {
>> +	/* The queue is a submission queue */
>> +	NVMET_PCI_EPF_Q_IS_SQ = 0,
>> +	/* The queue is live */
>> +	NVMET_PCI_EPF_Q_LIVE,
>> +	/* IRQ is enabled for this queue */
>> +	NVMET_PCI_EPF_Q_IRQ_ENABLED,
>> +};
>> +
>> +/*
>> + * IRQ vector descriptor.
>> + */
>> +struct nvmet_pci_epf_irq_vector {
>> +	unsigned int	vector;
>> +	unsigned int	ref;
>> +	bool		cd;
>> +	int		nr_irqs;
>> +};
>> +
>> +struct nvmet_pci_epf_queue {
>> +	union {
>> +		struct nvmet_sq		nvme_sq;
>> +		struct nvmet_cq		nvme_cq;
>> +	};
>> +	struct nvmet_pci_epf_ctrl	*ctrl;
>> +	unsigned long			flags;
>> +
>> +	u64				pci_addr;
>> +	size_t				pci_size;
>> +	struct pci_epc_map		pci_map;
>> +
>> +	u16				qid;
>> +	u16				depth;
>> +	u16				vector;
>> +	u16				head;
>> +	u16				tail;
>> +	u16				phase;
>> +	u32				db;
>> +
>> +	size_t				qes;
>> +
>> +	struct nvmet_pci_epf_irq_vector	*iv;
>> +	struct workqueue_struct		*iod_wq;
>> +	struct delayed_work		work;
>> +	spinlock_t			lock;
>> +	struct list_head		list;
>> +};
>> +
>> +/*
>> + * PCI memory segment for mapping an admin or IO command buffer to PCI space.
>> + */
>> +struct nvmet_pci_epf_segment {
>> +	void				*buf;
>> +	u64				pci_addr;
>> +	u32				length;
>> +};
>> +
>> +/*
>> + * Command descriptors.
>> + */
>> +struct nvmet_pci_epf_iod {
>> +	struct list_head		link;
>> +
>> +	struct nvmet_req		req;
>> +	struct nvme_command		cmd;
>> +	struct nvme_completion		cqe;
>> +	unsigned int			status;
>> +
>> +	struct nvmet_pci_epf_ctrl	*ctrl;
>> +
>> +	struct nvmet_pci_epf_queue	*sq;
>> +	struct nvmet_pci_epf_queue	*cq;
>> +
>> +	/* Data transfer size and direction for the command. */
>> +	size_t				data_len;
>> +	enum dma_data_direction		dma_dir;
>> +
>> +	/*
>> +	 * RC PCI address data segments: if nr_data_segs is 1, we use only
>> +	 * @data_seg. Otherwise, the array of segments @data_segs is allocated
>> +	 * to manage multiple PCI address data segments. @data_sgl and @data_sgt
>> +	 * are used to setup the command request for execution by the target
>> +	 * core.
>> +	 */
>> +	unsigned int			nr_data_segs;
>> +	struct nvmet_pci_epf_segment	data_seg;
>> +	struct nvmet_pci_epf_segment	*data_segs;
>> +	struct scatterlist		data_sgl;
>> +	struct sg_table			data_sgt;
>> +
>> +	struct work_struct		work;
>> +	struct completion		done;
>> +};
>> +
>> +/*
>> + * PCI target controller private data.
>> + */
>> +struct nvmet_pci_epf_ctrl {
>> +	struct nvmet_pci_epf		*nvme_epf;
>> +	struct nvmet_port		*port;
>> +	struct nvmet_ctrl		*tctrl;
>> +	struct device			*dev;
>> +
>> +	unsigned int			nr_queues;
>> +	struct nvmet_pci_epf_queue	*sq;
>> +	struct nvmet_pci_epf_queue	*cq;
>> +	unsigned int			sq_ab;
>> +
>> +	mempool_t			iod_pool;
>> +	void				*bar;
>> +	u64				cap;
>> +	u32				cc;
>> +	u32				csts;
>> +
>> +	size_t				io_sqes;
>> +	size_t				io_cqes;
>> +
>> +	size_t				mps_shift;
>> +	size_t				mps;
>> +	size_t				mps_mask;
>> +
>> +	unsigned int			mdts;
>> +
>> +	struct delayed_work		poll_cc;
>> +	struct delayed_work		poll_sqs;
>> +
>> +	struct mutex			irq_lock;
>> +	struct nvmet_pci_epf_irq_vector	*irq_vectors;
>> +	unsigned int			irq_vector_threshold;
>> +
>> +	bool				link_up;
>> +	bool				enabled;
>> +};
>> +
>> +/*
>> + * PCI EPF driver private data.
>> + */
>> +struct nvmet_pci_epf {
>> +	struct pci_epf			*epf;
>> +
>> +	const struct pci_epc_features	*epc_features;
>> +
>> +	void				*reg_bar;
>> +	size_t				msix_table_offset;
>> +
>> +	unsigned int			irq_type;
>> +	unsigned int			nr_vectors;
>> +
>> +	struct nvmet_pci_epf_ctrl	ctrl;
>> +
>> +	bool				dma_enabled;
>> +	struct dma_chan			*dma_tx_chan;
>> +	struct mutex			dma_tx_lock;
>> +	struct dma_chan			*dma_rx_chan;
>> +	struct mutex			dma_rx_lock;
>> +
>> +	struct mutex			mmio_lock;
>> +
>> +	/* PCI endpoint function configfs attributes */
>> +	struct config_group		group;
>> +	__le16				portid;
>> +	char				subsysnqn[NVMF_NQN_SIZE];
>> +	unsigned int			mdts_kb;
>> +};
>> +
>> +static inline u32 nvmet_pci_epf_bar_read32(struct nvmet_pci_epf_ctrl *ctrl,
>> +					   u32 off)
>> +{
>> +	__le32 *bar_reg = ctrl->bar + off;
>> +
>> +	return le32_to_cpu(READ_ONCE(*bar_reg));
>> +}
>> +
>> +static inline void nvmet_pci_epf_bar_write32(struct nvmet_pci_epf_ctrl *ctrl,
>> +					     u32 off, u32 val)
>> +{
>> +	__le32 *bar_reg = ctrl->bar + off;
>> +
>> +	WRITE_ONCE(*bar_reg, cpu_to_le32(val));
>> +}
>> +
>> +static inline u64 nvmet_pci_epf_bar_read64(struct nvmet_pci_epf_ctrl *ctrl,
>> +					   u32 off)
>> +{
>> +	return (u64)nvmet_pci_epf_bar_read32(ctrl, off) |
>> +		((u64)nvmet_pci_epf_bar_read32(ctrl, off + 4) << 32);
>> +}
>> +
>> +static inline void nvmet_pci_epf_bar_write64(struct nvmet_pci_epf_ctrl *ctrl,
>> +					     u32 off, u64 val)
>> +{
>> +	nvmet_pci_epf_bar_write32(ctrl, off, val & 0xFFFFFFFF);
>> +	nvmet_pci_epf_bar_write32(ctrl, off + 4, (val >> 32) & 0xFFFFFFFF);
>> +}
>> +
>> +static inline int nvmet_pci_epf_mem_map(struct nvmet_pci_epf *nvme_epf,
>> +		u64 pci_addr, size_t size, struct pci_epc_map *map)
>> +{
>> +	struct pci_epf *epf = nvme_epf->epf;
>> +
>> +	return pci_epc_mem_map(epf->epc, epf->func_no, epf->vfunc_no,
>> +			       pci_addr, size, map);
>> +}
>> +
>> +static inline void nvmet_pci_epf_mem_unmap(struct nvmet_pci_epf *nvme_epf,
>> +					   struct pci_epc_map *map)
>> +{
>> +	struct pci_epf *epf = nvme_epf->epf;
>> +
>> +	pci_epc_mem_unmap(epf->epc, epf->func_no, epf->vfunc_no, map);
>> +}
>> +
>> +struct nvmet_pci_epf_dma_filter {
>> +	struct device *dev;
>> +	u32 dma_mask;
>> +};
>> +
>> +static bool nvmet_pci_epf_dma_filter(struct dma_chan *chan, void *arg)
>> +{
>> +	struct nvmet_pci_epf_dma_filter *filter = arg;
>> +	struct dma_slave_caps caps;
>> +
>> +	memset(&caps, 0, sizeof(caps));
>> +	dma_get_slave_caps(chan, &caps);
>> +
>> +	return chan->device->dev == filter->dev &&
>> +		(filter->dma_mask & caps.directions);
>> +}
>> +
>> +static void nvmet_pci_epf_init_dma(struct nvmet_pci_epf *nvme_epf)
>> +{
>> +	struct pci_epf *epf = nvme_epf->epf;
>> +	struct device *dev = &epf->dev;
>> +	struct nvmet_pci_epf_dma_filter filter;
>> +	struct dma_chan *chan;
>> +	dma_cap_mask_t mask;
>> +
>> +	mutex_init(&nvme_epf->dma_rx_lock);
>> +	mutex_init(&nvme_epf->dma_tx_lock);
>> +
>> +	dma_cap_zero(mask);
>> +	dma_cap_set(DMA_SLAVE, mask);
>> +
>> +	filter.dev = epf->epc->dev.parent;
>> +	filter.dma_mask = BIT(DMA_DEV_TO_MEM);
>> +
>> +	chan = dma_request_channel(mask, nvmet_pci_epf_dma_filter, &filter);
>> +	if (!chan)
>> +		goto out_dma_no_rx;
>> +
>> +	nvme_epf->dma_rx_chan = chan;
>> +
>> +	filter.dma_mask = BIT(DMA_MEM_TO_DEV);
>> +	chan = dma_request_channel(mask, nvmet_pci_epf_dma_filter, &filter);
>> +	if (!chan)
>> +		goto out_dma_no_tx;
>> +
>> +	nvme_epf->dma_tx_chan = chan;
>> +
>> +	nvme_epf->dma_enabled = true;
>> +
>> +	dev_dbg(dev, "Using DMA RX channel %s, maximum segment size %u B\n",
>> +		dma_chan_name(chan),
>> +		dma_get_max_seg_size(dmaengine_get_dma_device(chan)));
>> +
>> +	dev_dbg(dev, "Using DMA TX channel %s, maximum segment size %u B\n",
>> +		dma_chan_name(chan),
>> +		dma_get_max_seg_size(dmaengine_get_dma_device(chan)));
>> +
>> +	return;
>> +
>> +out_dma_no_tx:
>> +	dma_release_channel(nvme_epf->dma_rx_chan);
>> +	nvme_epf->dma_rx_chan = NULL;
>> +
>> +out_dma_no_rx:
>> +	mutex_destroy(&nvme_epf->dma_rx_lock);
>> +	mutex_destroy(&nvme_epf->dma_tx_lock);
>> +	nvme_epf->dma_enabled = false;
>> +
>> +	dev_info(&epf->dev, "DMA not supported, falling back to MMIO\n");
>> +}
>> +
>> +static void nvmet_pci_epf_deinit_dma(struct nvmet_pci_epf *nvme_epf)
>> +{
>> +	if (!nvme_epf->dma_enabled)
>> +		return;
>> +
>> +	dma_release_channel(nvme_epf->dma_tx_chan);
>> +	nvme_epf->dma_tx_chan = NULL;
>> +	dma_release_channel(nvme_epf->dma_rx_chan);
>> +	nvme_epf->dma_rx_chan = NULL;
>> +	mutex_destroy(&nvme_epf->dma_rx_lock);
>> +	mutex_destroy(&nvme_epf->dma_tx_lock);
>> +	nvme_epf->dma_enabled = false;
>> +}
>> +
>> +static int nvmet_pci_epf_dma_transfer(struct nvmet_pci_epf *nvme_epf,
>> +		struct nvmet_pci_epf_segment *seg, enum dma_data_direction dir)
>> +{
>> +	struct pci_epf *epf = nvme_epf->epf;
>> +	struct dma_async_tx_descriptor *desc;
>> +	struct dma_slave_config sconf = {};
>> +	struct device *dev = &epf->dev;
>> +	struct device *dma_dev;
>> +	struct dma_chan *chan;
>> +	dma_cookie_t cookie;
>> +	dma_addr_t dma_addr;
>> +	struct mutex *lock;
>> +	int ret;
>> +
>> +	switch (dir) {
>> +	case DMA_FROM_DEVICE:
>> +		lock = &nvme_epf->dma_rx_lock;
>> +		chan = nvme_epf->dma_rx_chan;
>> +		sconf.direction = DMA_DEV_TO_MEM;
>> +		sconf.src_addr = seg->pci_addr;
>> +		break;
>> +	case DMA_TO_DEVICE:
>> +		lock = &nvme_epf->dma_tx_lock;
>> +		chan = nvme_epf->dma_tx_chan;
>> +		sconf.direction = DMA_MEM_TO_DEV;
>> +		sconf.dst_addr = seg->pci_addr;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	mutex_lock(lock);
>> +
>> +	dma_dev = dmaengine_get_dma_device(chan);
>> +	dma_addr = dma_map_single(dma_dev, seg->buf, seg->length, dir);
>> +	ret = dma_mapping_error(dma_dev, dma_addr);
>> +	if (ret)
>> +		goto unlock;
>> +
>> +	ret = dmaengine_slave_config(chan, &sconf);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to configure DMA channel\n");
>> +		goto unmap;
>> +	}
>> +
>> +	desc = dmaengine_prep_slave_single(chan, dma_addr, seg->length,
>> +					   sconf.direction, DMA_CTRL_ACK);
>> +	if (!desc) {
>> +		dev_err(dev, "Failed to prepare DMA\n");
>> +		ret = -EIO;
>> +		goto unmap;
>> +	}
>> +
>> +	cookie = dmaengine_submit(desc);
>> +	ret = dma_submit_error(cookie);
>> +	if (ret) {
>> +		dev_err(dev, "DMA submit failed %d\n", ret);
>> +		goto unmap;
>> +	}
>> +
>> +	if (dma_sync_wait(chan, cookie) != DMA_COMPLETE) {
>> +		dev_err(dev, "DMA transfer failed\n");
>> +		ret = -EIO;
>> +	}
>> +
>> +	dmaengine_terminate_sync(chan);
>> +
>> +unmap:
>> +	dma_unmap_single(dma_dev, dma_addr, seg->length, dir);
>> +
>> +unlock:
>> +	mutex_unlock(lock);
>> +
>> +	return ret;
>> +}
>> +
>> +static int nvmet_pci_epf_mmio_transfer(struct nvmet_pci_epf *nvme_epf,
>> +		struct nvmet_pci_epf_segment *seg, enum dma_data_direction dir)
>> +{
>> +	u64 pci_addr = seg->pci_addr;
>> +	u32 length = seg->length;
>> +	void *buf = seg->buf;
>> +	struct pci_epc_map map;
>> +	int ret = -EINVAL;
>> +
>> +	/*
>> +	 * Note: MMIO transfers do not need serialization but this is a
>> +	 * simple way to avoid using too many mapping windows.
>> +	 */
>> +	mutex_lock(&nvme_epf->mmio_lock);
>> +
>> +	while (length) {
>> +		ret = nvmet_pci_epf_mem_map(nvme_epf, pci_addr, length, &map);
>> +		if (ret)
>> +			break;
>> +
>> +		switch (dir) {
>> +		case DMA_FROM_DEVICE:
>> +			memcpy_fromio(buf, map.virt_addr, map.pci_size);
>> +			break;
>> +		case DMA_TO_DEVICE:
>> +			memcpy_toio(map.virt_addr, buf, map.pci_size);
>> +			break;
>> +		default:
>> +			ret = -EINVAL;
>> +			goto unlock;
>> +		}
>> +
>> +		pci_addr += map.pci_size;
>> +		buf += map.pci_size;
>> +		length -= map.pci_size;
>> +
>> +		nvmet_pci_epf_mem_unmap(nvme_epf, &map);
>> +	}
>> +
>> +unlock:
>> +	mutex_unlock(&nvme_epf->mmio_lock);
>> +
>> +	return ret;
>> +}
>> +
>> +static inline int nvmet_pci_epf_transfer_seg(struct nvmet_pci_epf *nvme_epf,
>> +		struct nvmet_pci_epf_segment *seg, enum dma_data_direction dir)
>> +{
>> +	if (nvme_epf->dma_enabled)
>> +		return nvmet_pci_epf_dma_transfer(nvme_epf, seg, dir);
>> +
>> +	return nvmet_pci_epf_mmio_transfer(nvme_epf, seg, dir);
>> +}
>> +
>> +static inline int nvmet_pci_epf_transfer(struct nvmet_pci_epf_ctrl *ctrl,
>> +					 void *buf, u64 pci_addr, u32 length,
>> +					 enum dma_data_direction dir)
>> +{
>> +	struct nvmet_pci_epf_segment seg = {
>> +		.buf = buf,
>> +		.pci_addr = pci_addr,
>> +		.length = length,
>> +	};
>> +
>> +	return nvmet_pci_epf_transfer_seg(ctrl->nvme_epf, &seg, dir);
>> +}
>> +
>> +static int nvmet_pci_epf_alloc_irq_vectors(struct nvmet_pci_epf_ctrl *ctrl)
>> +{
>> +	ctrl->irq_vectors = kcalloc(ctrl->nr_queues,
>> +				    sizeof(struct nvmet_pci_epf_irq_vector),
>> +				    GFP_KERNEL);
>> +	if (!ctrl->irq_vectors)
>> +		return -ENOMEM;
>> +
>> +	mutex_init(&ctrl->irq_lock);
>> +
>> +	return 0;
>> +}
>> +
>> +static void nvmet_pci_epf_free_irq_vectors(struct nvmet_pci_epf_ctrl *ctrl)
>> +{
>> +	if (ctrl->irq_vectors) {
>> +		mutex_destroy(&ctrl->irq_lock);
>> +		kfree(ctrl->irq_vectors);
>> +		ctrl->irq_vectors = NULL;
>> +	}
>> +}
>> +
>> +static struct nvmet_pci_epf_irq_vector *
>> +nvmet_pci_epf_find_irq_vector(struct nvmet_pci_epf_ctrl *ctrl, u16 vector)
>> +{
>> +	struct nvmet_pci_epf_irq_vector *iv;
>> +	int i;
>> +
>> +	lockdep_assert_held(&ctrl->irq_lock);
>> +
>> +	for (i = 0; i < ctrl->nr_queues; i++) {
>> +		iv = &ctrl->irq_vectors[i];
>> +		if (iv->ref && iv->vector == vector)
>> +			return iv;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +static struct nvmet_pci_epf_irq_vector *
>> +nvmet_pci_epf_add_irq_vector(struct nvmet_pci_epf_ctrl *ctrl, u16 vector)
>> +{
>> +	struct nvmet_pci_epf_irq_vector *iv;
>> +	int i;
>> +
>> +	mutex_lock(&ctrl->irq_lock);
>> +
>> +	iv = nvmet_pci_epf_find_irq_vector(ctrl, vector);
>> +	if (iv) {
>> +		iv->ref++;
>> +		goto unlock;
>> +	}
>> +
>> +	for (i = 0; i < ctrl->nr_queues; i++) {
>> +		iv = &ctrl->irq_vectors[i];
>> +		if (!iv->ref)
>> +			break;
>> +	}
>> +
>> +	if (WARN_ON_ONCE(!iv))
>> +		goto unlock;
>> +
>> +	iv->ref = 1;
>> +	iv->vector = vector;
>> +	iv->nr_irqs = 0;
>> +
>> +unlock:
>> +	mutex_unlock(&ctrl->irq_lock);
>> +
>> +	return iv;
>> +}
>> +
>> +static void nvmet_pci_epf_remove_irq_vector(struct nvmet_pci_epf_ctrl *ctrl,
>> +					    u16 vector)
>> +{
>> +	struct nvmet_pci_epf_irq_vector *iv;
>> +
>> +	mutex_lock(&ctrl->irq_lock);
>> +
>> +	iv = nvmet_pci_epf_find_irq_vector(ctrl, vector);
>> +	if (iv) {
>> +		iv->ref--;
>> +		if (!iv->ref) {
>> +			iv->vector = 0;
>> +			iv->nr_irqs = 0;
>> +		}
>> +	}
>> +
>> +	mutex_unlock(&ctrl->irq_lock);
>> +}
>> +
>> +static bool nvmet_pci_epf_should_raise_irq(struct nvmet_pci_epf_ctrl *ctrl,
>> +		struct nvmet_pci_epf_queue *cq, bool force)
>> +{
>> +	struct nvmet_pci_epf_irq_vector *iv = cq->iv;
>> +	bool ret;
>> +
>> +	if (!test_bit(NVMET_PCI_EPF_Q_IRQ_ENABLED, &cq->flags))
>> +		return false;
>> +
>> +	/* IRQ coalescing for the admin queue is not allowed. */
>> +	if (!cq->qid)
>> +		return true;
>> +
>> +	if (iv->cd)
>> +		return true;
>> +
>> +	if (force) {
>> +		ret = iv->nr_irqs > 0;
>> +	} else {
>> +		iv->nr_irqs++;
>> +		ret = iv->nr_irqs >= ctrl->irq_vector_threshold;
>> +	}
>> +	if (ret)
>> +		iv->nr_irqs = 0;
>> +
>> +	return ret;
>> +}
>> +
>> +static void nvmet_pci_epf_raise_irq(struct nvmet_pci_epf_ctrl *ctrl,
>> +		struct nvmet_pci_epf_queue *cq, bool force)
>> +{
>> +	struct nvmet_pci_epf *nvme_epf = ctrl->nvme_epf;
>> +	struct pci_epf *epf = nvme_epf->epf;
>> +	int ret = 0;
>> +
>> +	if (!test_bit(NVMET_PCI_EPF_Q_LIVE, &cq->flags))
>> +		return;
>> +
>> +	mutex_lock(&ctrl->irq_lock);
>> +
>> +	if (!nvmet_pci_epf_should_raise_irq(ctrl, cq, force))
>> +		goto unlock;
>> +
>> +	switch (nvme_epf->irq_type) {
>> +	case PCI_IRQ_MSIX:
>> +	case PCI_IRQ_MSI:
>> +		ret = pci_epc_raise_irq(epf->epc, epf->func_no, epf->vfunc_no,
>> +					nvme_epf->irq_type, cq->vector + 1);
>> +		if (!ret)
>> +			break;
>> +		/*
>> +		 * If we got an error, it is likely because the host is using
>> +		 * legacy IRQs (e.g. BIOS, grub).
>> +		 */
>> +		fallthrough;
>> +	case PCI_IRQ_INTX:
>> +		ret = pci_epc_raise_irq(epf->epc, epf->func_no, epf->vfunc_no,
>> +					PCI_IRQ_INTX, 0);
>> +		break;
>> +	default:
>> +		WARN_ON_ONCE(1);
>> +		ret = -EINVAL;
>> +		break;
>> +	}
>> +
>> +	if (ret)
>> +		dev_err(ctrl->dev, "Raise IRQ failed %d\n", ret);
>> +
>> +unlock:
>> +	mutex_unlock(&ctrl->irq_lock);
>> +}
>> +
>> +static inline const char *nvmet_pci_epf_iod_name(struct nvmet_pci_epf_iod *iod)
>> +{
>> +	return nvme_opcode_str(iod->sq->qid, iod->cmd.common.opcode);
>> +}
>> +
>> +static void nvmet_pci_epf_exec_iod_work(struct work_struct *work);
>> +
>> +static struct nvmet_pci_epf_iod *
>> +nvmet_pci_epf_alloc_iod(struct nvmet_pci_epf_queue *sq)
>> +{
>> +	struct nvmet_pci_epf_ctrl *ctrl = sq->ctrl;
>> +	struct nvmet_pci_epf_iod *iod;
>> +
>> +	iod = mempool_alloc(&ctrl->iod_pool, GFP_KERNEL);
>> +	if (unlikely(!iod))
>> +		return NULL;
>> +
>> +	memset(iod, 0, sizeof(*iod));
>> +	iod->req.cmd = &iod->cmd;
>> +	iod->req.cqe = &iod->cqe;
>> +	iod->req.port = ctrl->port;
>> +	iod->ctrl = ctrl;
>> +	iod->sq = sq;
>> +	iod->cq = &ctrl->cq[sq->qid];
>> +	INIT_LIST_HEAD(&iod->link);
>> +	iod->dma_dir = DMA_NONE;
>> +	INIT_WORK(&iod->work, nvmet_pci_epf_exec_iod_work);
>> +	init_completion(&iod->done);
>> +
>> +	return iod;
>> +}
>> +
>> +/*
>> + * Allocate or grow a command table of PCI segments.
>> + */
>> +static int nvmet_pci_epf_alloc_iod_data_segs(struct nvmet_pci_epf_iod *iod,
>> +					     int nsegs)
>> +{
>> +	struct nvmet_pci_epf_segment *segs;
>> +	int nr_segs = iod->nr_data_segs + nsegs;
>> +
>> +	segs = krealloc(iod->data_segs,
>> +			nr_segs * sizeof(struct nvmet_pci_epf_segment),
>> +			GFP_KERNEL | __GFP_ZERO);
>> +	if (!segs)
>> +		return -ENOMEM;
>> +
>> +	iod->nr_data_segs = nr_segs;
>> +	iod->data_segs = segs;
>> +
>> +	return 0;
>> +}
>> +
>> +static void nvmet_pci_epf_free_iod(struct nvmet_pci_epf_iod *iod)
>> +{
>> +	int i;
>> +
>> +	if (iod->data_segs) {
>> +		for (i = 0; i < iod->nr_data_segs; i++)
>> +			kfree(iod->data_segs[i].buf);
>> +		if (iod->data_segs != &iod->data_seg)
>> +			kfree(iod->data_segs);
>> +	}
>> +	if (iod->data_sgt.nents > 1)
>> +		sg_free_table(&iod->data_sgt);
>> +	mempool_free(iod, &iod->ctrl->iod_pool);
>> +}
>> +
>> +static int nvmet_pci_epf_transfer_iod_data(struct nvmet_pci_epf_iod *iod)
>> +{
>> +	struct nvmet_pci_epf *nvme_epf = iod->ctrl->nvme_epf;
>> +	struct nvmet_pci_epf_segment *seg = &iod->data_segs[0];
>> +	int i, ret;
>> +
>> +	/* Split the data transfer according to the PCI segments. */
>> +	for (i = 0; i < iod->nr_data_segs; i++, seg++) {
>> +		ret = nvmet_pci_epf_transfer_seg(nvme_epf, seg, iod->dma_dir);
>> +		if (ret) {
>> +			iod->status = NVME_SC_DATA_XFER_ERROR | NVME_STATUS_DNR;
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static inline u64 nvmet_pci_epf_prp_addr(struct nvmet_pci_epf_ctrl *ctrl,
>> +					 u64 prp)
>> +{
>> +	return prp & ~ctrl->mps_mask;
>> +}
>> +
>> +static inline u32 nvmet_pci_epf_prp_ofst(struct nvmet_pci_epf_ctrl *ctrl,
>> +					 u64 prp)
>> +{
>> +	return prp & ctrl->mps_mask;
>> +}
>> +
>> +static inline size_t nvmet_pci_epf_prp_size(struct nvmet_pci_epf_ctrl *ctrl,
>> +					    u64 prp)
>> +{
>> +	return ctrl->mps - nvmet_pci_epf_prp_ofst(ctrl, prp);
>> +}
>> +
>> +/*
>> + * Transfer a PRP list from the host and return the number of prps.
>> + */
>> +static int nvmet_pci_epf_get_prp_list(struct nvmet_pci_epf_ctrl *ctrl, u64 prp,
>> +				      size_t xfer_len, __le64 *prps)
>> +{
>> +	size_t nr_prps = (xfer_len + ctrl->mps_mask) >> ctrl->mps_shift;
>> +	u32 length;
>> +	int ret;
>> +
>> +	/*
>> +	 * Compute the number of PRPs required for the number of bytes to
>> +	 * transfer (xfer_len). If this number overflows the memory page size
>> +	 * with the PRP list pointer specified, only return the space available
>> +	 * in the memory page, the last PRP in there will be a PRP list pointer
>> +	 * to the remaining PRPs.
>> +	 */
>> +	length = min(nvmet_pci_epf_prp_size(ctrl, prp), nr_prps << 3);
>> +	ret = nvmet_pci_epf_transfer(ctrl, prps, prp, length, DMA_FROM_DEVICE);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return length >> 3;
>> +}
>> +
>> +static int nvmet_pci_epf_iod_parse_prp_list(struct nvmet_pci_epf_ctrl *ctrl,
>> +					    struct nvmet_pci_epf_iod *iod)
>> +{
>> +	struct nvme_command *cmd = &iod->cmd;
>> +	struct nvmet_pci_epf_segment *seg;
>> +	size_t size = 0, ofst, prp_size, xfer_len;
>> +	size_t transfer_len = iod->data_len;
>> +	int nr_segs, nr_prps = 0;
>> +	u64 pci_addr, prp;
>> +	int i = 0, ret;
>> +	__le64 *prps;
>> +
>> +	prps = kzalloc(ctrl->mps, GFP_KERNEL);
>> +	if (!prps)
>> +		goto err_internal;
>> +
>> +	/*
>> +	 * Allocate PCI segments for the command: this considers the worst case
>> +	 * scenario where all prps are discontiguous, so get as many segments
>> +	 * as we can have prps. In practice, most of the time, we will have
>> +	 * far less PCI segments than prps.
>> +	 */
>> +	prp = le64_to_cpu(cmd->common.dptr.prp1);
>> +	if (!prp)
>> +		goto err_invalid_field;
>> +
>> +	ofst = nvmet_pci_epf_prp_ofst(ctrl, prp);
>> +	nr_segs = (transfer_len + ofst + ctrl->mps - 1) >> ctrl->mps_shift;
>> +
>> +	ret = nvmet_pci_epf_alloc_iod_data_segs(iod, nr_segs);
>> +	if (ret)
>> +		goto err_internal;
>> +
>> +	/* Set the first segment using prp1 */
>> +	seg = &iod->data_segs[0];
>> +	seg->pci_addr = prp;
>> +	seg->length = nvmet_pci_epf_prp_size(ctrl, prp);
>> +
>> +	size = seg->length;
>> +	pci_addr = prp + size;
>> +	nr_segs = 1;
>> +
>> +	/*
>> +	 * Now build the PCI address segments using the PRP lists, starting
>> +	 * from prp2.
>> +	 */
>> +	prp = le64_to_cpu(cmd->common.dptr.prp2);
>> +	if (!prp)
>> +		goto err_invalid_field;
>> +
>> +	while (size < transfer_len) {
>> +		xfer_len = transfer_len - size;
>> +
>> +		if (!nr_prps) {
>> +			/* Get the PRP list */
>> +			nr_prps = nvmet_pci_epf_get_prp_list(ctrl, prp,
>> +							     xfer_len, prps);
>> +			if (nr_prps < 0)
>> +				goto err_internal;
>> +
>> +			i = 0;
>> +			ofst = 0;
>> +		}
>> +
>> +		/* Current entry */
>> +		prp = le64_to_cpu(prps[i]);
>> +		if (!prp)
>> +			goto err_invalid_field;
>> +
>> +		/* Did we reach the last PRP entry of the list ? */
>> +		if (xfer_len > ctrl->mps && i == nr_prps - 1) {
>> +			/* We need more PRPs: PRP is a list pointer */
>> +			nr_prps = 0;
>> +			continue;
>> +		}
>> +
>> +		/* Only the first PRP is allowed to have an offset */
>> +		if (nvmet_pci_epf_prp_ofst(ctrl, prp))
>> +			goto err_invalid_offset;
>> +
>> +		if (prp != pci_addr) {
>> +			/* Discontiguous prp: new segment */
>> +			nr_segs++;
>> +			if (WARN_ON_ONCE(nr_segs > iod->nr_data_segs))
>> +				goto err_internal;
>> +
>> +			seg++;
>> +			seg->pci_addr = prp;
>> +			seg->length = 0;
>> +			pci_addr = prp;
>> +		}
>> +
>> +		prp_size = min_t(size_t, ctrl->mps, xfer_len);
>> +		seg->length += prp_size;
>> +		pci_addr += prp_size;
>> +		size += prp_size;
>> +
>> +		i++;
>> +	}
>> +
>> +	iod->nr_data_segs = nr_segs;
>> +	ret = 0;
>> +
>> +	if (size != transfer_len) {
>> +		dev_err(ctrl->dev, "PRPs transfer length mismatch %zu / %zu\n",
>> +			size, transfer_len);
>> +		goto err_internal;
>> +	}
>> +
>> +	kfree(prps);
>> +
>> +	return 0;
>> +
>> +err_invalid_offset:
>> +	dev_err(ctrl->dev, "PRPs list invalid offset\n");
>> +	iod->status = NVME_SC_PRP_INVALID_OFFSET | NVME_STATUS_DNR;
>> +	goto err;
>> +
>> +err_invalid_field:
>> +	dev_err(ctrl->dev, "PRPs list invalid field\n");
>> +	iod->status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
>> +	goto err;
>> +
>> +err_internal:
>> +	dev_err(ctrl->dev, "PRPs list internal error\n");
>> +	iod->status = NVME_SC_INTERNAL | NVME_STATUS_DNR;
>> +
>> +err:
>> +	kfree(prps);
>> +	return -EINVAL;
>> +}
>> +
>> +static int nvmet_pci_epf_iod_parse_prp_simple(struct nvmet_pci_epf_ctrl *ctrl,
>> +					      struct nvmet_pci_epf_iod *iod)
>> +{
>> +	struct nvme_command *cmd = &iod->cmd;
>> +	size_t transfer_len = iod->data_len;
>> +	int ret, nr_segs = 1;
>> +	u64 prp1, prp2 = 0;
>> +	size_t prp1_size;
>> +
>> +	/* prp1 */
>> +	prp1 = le64_to_cpu(cmd->common.dptr.prp1);
>> +	prp1_size = nvmet_pci_epf_prp_size(ctrl, prp1);
>> +
>> +	/* For commands crossing a page boundary, we should have a valid prp2 */
>> +	if (transfer_len > prp1_size) {
>> +		prp2 = le64_to_cpu(cmd->common.dptr.prp2);
>> +		if (!prp2) {
>> +			iod->status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
>> +			return -EINVAL;
>> +		}
>> +		if (nvmet_pci_epf_prp_ofst(ctrl, prp2)) {
>> +			iod->status =
>> +				NVME_SC_PRP_INVALID_OFFSET | NVME_STATUS_DNR;
>> +			return -EINVAL;
>> +		}
>> +		if (prp2 != prp1 + prp1_size)
>> +			nr_segs = 2;
>> +	}
>> +
>> +	if (nr_segs == 1) {
>> +		iod->nr_data_segs = 1;
>> +		iod->data_segs = &iod->data_seg;
>> +		iod->data_segs[0].pci_addr = prp1;
>> +		iod->data_segs[0].length = transfer_len;
>> +		return 0;
>> +	}
>> +
>> +	ret = nvmet_pci_epf_alloc_iod_data_segs(iod, nr_segs);
>> +	if (ret) {
>> +		iod->status = NVME_SC_INTERNAL | NVME_STATUS_DNR;
>> +		return ret;
>> +	}
>> +
>> +	iod->data_segs[0].pci_addr = prp1;
>> +	iod->data_segs[0].length = prp1_size;
>> +	iod->data_segs[1].pci_addr = prp2;
>> +	iod->data_segs[1].length = transfer_len - prp1_size;
>> +
>> +	return 0;
>> +}
>> +
>> +static int nvmet_pci_epf_iod_parse_prps(struct nvmet_pci_epf_iod *iod)
>> +{
>> +	struct nvmet_pci_epf_ctrl *ctrl = iod->ctrl;
>> +	u64 prp1 = le64_to_cpu(iod->cmd.common.dptr.prp1);
>> +	size_t ofst;
>> +
>> +	/* Get the PCI address segments for the command using its PRPs */
>> +	ofst = nvmet_pci_epf_prp_ofst(ctrl, prp1);
>> +	if (ofst & 0x3) {
>> +		iod->status = NVME_SC_PRP_INVALID_OFFSET | NVME_STATUS_DNR;
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (iod->data_len + ofst <= ctrl->mps * 2)
>> +		return nvmet_pci_epf_iod_parse_prp_simple(ctrl, iod);
>> +
>> +	return nvmet_pci_epf_iod_parse_prp_list(ctrl, iod);
>> +}
>> +
>> +/*
>> + * Transfer an SGL segment from the host and return the number of data
>> + * descriptors and the next segment descriptor, if any.
>> + */
>> +static struct nvme_sgl_desc *
>> +nvmet_pci_epf_get_sgl_segment(struct nvmet_pci_epf_ctrl *ctrl,
>> +			      struct nvme_sgl_desc *desc, unsigned int *nr_sgls)
>> +{
>> +	struct nvme_sgl_desc *sgls;
>> +	u32 length = le32_to_cpu(desc->length);
>> +	int nr_descs, ret;
>> +	void *buf;
>> +
>> +	buf = kmalloc(length, GFP_KERNEL);
>> +	if (!buf)
>> +		return NULL;
>> +
>> +	ret = nvmet_pci_epf_transfer(ctrl, buf, le64_to_cpu(desc->addr), length,
>> +				     DMA_FROM_DEVICE);
>> +	if (ret) {
>> +		kfree(buf);
>> +		return NULL;
>> +	}
>> +
>> +	sgls = buf;
>> +	nr_descs = length / sizeof(struct nvme_sgl_desc);
>> +	if (sgls[nr_descs - 1].type == (NVME_SGL_FMT_SEG_DESC << 4) ||
>> +	    sgls[nr_descs - 1].type == (NVME_SGL_FMT_LAST_SEG_DESC << 4)) {
>> +		/*
>> +		 * We have another SGL segment following this one: do not count
>> +		 * it as a regular data SGL descriptor and return it to the
>> +		 * caller.
>> +		 */
>> +		*desc = sgls[nr_descs - 1];
>> +		nr_descs--;
>> +	} else {
>> +		/* We do not have another SGL segment after this one. */
>> +		desc->length = 0;
>> +	}
>> +
>> +	*nr_sgls = nr_descs;
>> +
>> +	return sgls;
>> +}
>> +
>> +static int nvmet_pci_epf_iod_parse_sgl_segments(struct nvmet_pci_epf_ctrl *ctrl,
>> +						struct nvmet_pci_epf_iod *iod)
>> +{
>> +	struct nvme_command *cmd = &iod->cmd;
>> +	struct nvme_sgl_desc seg = cmd->common.dptr.sgl;
>> +	struct nvme_sgl_desc *sgls = NULL;
>> +	int n = 0, i, nr_sgls;
>> +	int ret;
>> +
>> +	/*
>> +	 * We do not support inline data nor keyed SGLs, so we should be seeing
>> +	 * only segment descriptors.
>> +	 */
>> +	if (seg.type != (NVME_SGL_FMT_SEG_DESC << 4) &&
>> +	    seg.type != (NVME_SGL_FMT_LAST_SEG_DESC << 4)) {
>> +		iod->status = NVME_SC_SGL_INVALID_TYPE | NVME_STATUS_DNR;
>> +		return -EIO;
>> +	}
>> +
>> +	while (seg.length) {
>> +		sgls = nvmet_pci_epf_get_sgl_segment(ctrl, &seg, &nr_sgls);
>> +		if (!sgls) {
>> +			iod->status = NVME_SC_INTERNAL | NVME_STATUS_DNR;
>> +			return -EIO;
>> +		}
>> +
>> +		/* Grow the PCI segment table as needed */
>> +		ret = nvmet_pci_epf_alloc_iod_data_segs(iod, nr_sgls);
>> +		if (ret) {
>> +			iod->status = NVME_SC_INTERNAL | NVME_STATUS_DNR;
>> +			goto out;
>> +		}
>> +
>> +		/*
>> +		 * Parse the SGL descriptors to build the PCI segment table,
>> +		 * checking the descriptor type as we go.
>> +		 */
>> +		for (i = 0; i < nr_sgls; i++) {
>> +			if (sgls[i].type != (NVME_SGL_FMT_DATA_DESC << 4)) {
>> +				iod->status = NVME_SC_SGL_INVALID_TYPE |
>> +					NVME_STATUS_DNR;
>> +				goto out;
>> +			}
>> +			iod->data_segs[n].pci_addr = le64_to_cpu(sgls[i].addr);
>> +			iod->data_segs[n].length = le32_to_cpu(sgls[i].length);
>> +			n++;
>> +		}
>> +
>> +		kfree(sgls);
>> +	}
>> +
>> + out:
>> +	if (iod->status != NVME_SC_SUCCESS) {
>> +		kfree(sgls);
>> +		return -EIO;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int nvmet_pci_epf_iod_parse_sgls(struct nvmet_pci_epf_iod *iod)
>> +{
>> +	struct nvmet_pci_epf_ctrl *ctrl = iod->ctrl;
>> +	struct nvme_sgl_desc *sgl = &iod->cmd.common.dptr.sgl;
>> +
>> +	if (sgl->type == (NVME_SGL_FMT_DATA_DESC << 4)) {
>> +		/* Single data descriptor case */
>> +		iod->nr_data_segs = 1;
>> +		iod->data_segs = &iod->data_seg;
>> +		iod->data_seg.pci_addr = le64_to_cpu(sgl->addr);
>> +		iod->data_seg.length = le32_to_cpu(sgl->length);
>> +		return 0;
>> +	}
>> +
>> +	return nvmet_pci_epf_iod_parse_sgl_segments(ctrl, iod);
>> +}
>> +
>> +static int nvmet_pci_epf_alloc_iod_data_buf(struct nvmet_pci_epf_iod *iod)
>> +{
>> +	struct nvmet_pci_epf_ctrl *ctrl = iod->ctrl;
>> +	struct nvmet_req *req = &iod->req;
>> +	struct nvmet_pci_epf_segment *seg;
>> +	struct scatterlist *sg;
>> +	int ret, i;
>> +
>> +	if (iod->data_len > ctrl->mdts) {
>> +		iod->status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
>> +		return -EINVAL;
>> +	}
>> +
>> +	/*
>> +	 * Get the PCI address segments for the command data buffer using either
>> +	 * its SGLs or PRPs.
>> +	 */
>> +	if (iod->cmd.common.flags & NVME_CMD_SGL_ALL)
>> +		ret = nvmet_pci_epf_iod_parse_sgls(iod);
>> +	else
>> +		ret = nvmet_pci_epf_iod_parse_prps(iod);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Get a command buffer using SGLs matching the PCI segments. */
>> +	if (iod->nr_data_segs == 1) {
>> +		sg_init_table(&iod->data_sgl, 1);
>> +		iod->data_sgt.sgl = &iod->data_sgl;
>> +		iod->data_sgt.nents = 1;
>> +		iod->data_sgt.orig_nents = 1;
>> +	} else {
>> +		ret = sg_alloc_table(&iod->data_sgt, iod->nr_data_segs,
>> +				     GFP_KERNEL);
>> +		if (ret)
>> +			goto err_nomem;
>> +	}
>> +
>> +	for_each_sgtable_sg(&iod->data_sgt, sg, i) {
>> +		seg = &iod->data_segs[i];
>> +		seg->buf = kmalloc(seg->length, GFP_KERNEL);
>> +		if (!seg->buf)
>> +			goto err_nomem;
>> +		sg_set_buf(sg, seg->buf, seg->length);
>> +	}
>> +
>> +	req->transfer_len = iod->data_len;
>> +	req->sg = iod->data_sgt.sgl;
>> +	req->sg_cnt = iod->data_sgt.nents;
>> +
>> +	return 0;
>> +
>> +err_nomem:
>> +	iod->status = NVME_SC_INTERNAL | NVME_STATUS_DNR;
>> +	return -ENOMEM;
>> +}
>> +
>> +static void nvmet_pci_epf_complete_iod(struct nvmet_pci_epf_iod *iod)
>> +{
>> +	struct nvmet_pci_epf_queue *cq = iod->cq;
>> +	unsigned long flags;
>> +
>> +	/* Do not print an error message for AENs */
>> +	iod->status = le16_to_cpu(iod->cqe.status) >> 1;
>> +	if (iod->status && iod->cmd.common.opcode != nvme_admin_async_event)
>> +		dev_err(iod->ctrl->dev,
>> +			"CQ[%d]: Command %s (0x%x) status 0x%0x\n",
>> +			iod->sq->qid, nvmet_pci_epf_iod_name(iod),
>> +			iod->cmd.common.opcode, iod->status);
>> +
>> +	/*
>> +	 * Add the command to the list of completed commands and schedule the
>> +	 * CQ work.
>> +	 */
>> +	spin_lock_irqsave(&cq->lock, flags);
>> +	list_add_tail(&iod->link, &cq->list);
>> +	queue_delayed_work(system_highpri_wq, &cq->work, 0);
>> +	spin_unlock_irqrestore(&cq->lock, flags);
>> +}
>> +
>> +static void nvmet_pci_epf_drain_queue(struct nvmet_pci_epf_queue *queue)
>> +{
>> +	struct nvmet_pci_epf_iod *iod;
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&queue->lock, flags);
>> +	while (!list_empty(&queue->list)) {
>> +		iod = list_first_entry(&queue->list, struct nvmet_pci_epf_iod,
>> +				       link);
>> +		list_del_init(&iod->link);
>> +		nvmet_pci_epf_free_iod(iod);
>> +	}
>> +	spin_unlock_irqrestore(&queue->lock, flags);
>> +}
>> +
>> +static int nvmet_pci_epf_add_port(struct nvmet_port *port)
>> +{
>> +	mutex_lock(&nvmet_pci_epf_ports_mutex);
>> +	list_add_tail(&port->entry, &nvmet_pci_epf_ports);
>> +	mutex_unlock(&nvmet_pci_epf_ports_mutex);
>> +	return 0;
>> +}
>> +
>> +static void nvmet_pci_epf_remove_port(struct nvmet_port *port)
>> +{
>> +	mutex_lock(&nvmet_pci_epf_ports_mutex);
>> +	list_del_init(&port->entry);
>> +	mutex_unlock(&nvmet_pci_epf_ports_mutex);
>> +}
>> +
>> +static struct nvmet_port *
>> +nvmet_pci_epf_find_port(struct nvmet_pci_epf_ctrl *ctrl, __le16 portid)
>> +{
>> +	struct nvmet_port *p, *port = NULL;
>> +
>> +	/* For now, always use the first port */
>> +	mutex_lock(&nvmet_pci_epf_ports_mutex);
>> +	list_for_each_entry(p, &nvmet_pci_epf_ports, entry) {
>> +		if (p->disc_addr.portid == portid) {
>> +			port = p;
>> +			break;
>> +		}
>> +	}
>> +	mutex_unlock(&nvmet_pci_epf_ports_mutex);
>> +
>> +	return port;
>> +}
>> +
>> +static void nvmet_pci_epf_queue_response(struct nvmet_req *req)
>> +{
>> +	struct nvmet_pci_epf_iod *iod =
>> +		container_of(req, struct nvmet_pci_epf_iod, req);
>> +
>> +	iod->status = le16_to_cpu(req->cqe->status) >> 1;
>> +
>> +	/* If we have no data to transfer, directly complete the command. */
>> +	if (!iod->data_len || iod->dma_dir != DMA_TO_DEVICE) {
>> +		nvmet_pci_epf_complete_iod(iod);
>> +		return;
>> +	}
>> +
>> +	complete(&iod->done);
>> +}
>> +
>> +static u8 nvmet_pci_epf_get_mdts(const struct nvmet_ctrl *tctrl)
>> +{
>> +	struct nvmet_pci_epf_ctrl *ctrl = tctrl->drvdata;
>> +	int page_shift = NVME_CAP_MPSMIN(tctrl->cap) + 12;
>> +
>> +	return ilog2(ctrl->mdts) - page_shift;
>> +}
>> +
>> +static u16 nvmet_pci_epf_create_cq(struct nvmet_ctrl *tctrl,
>> +		u16 cqid, u16 flags, u16 qsize, u64 pci_addr, u16 vector)
>> +{
>> +	struct nvmet_pci_epf_ctrl *ctrl = tctrl->drvdata;
>> +	struct nvmet_pci_epf_queue *cq = &ctrl->cq[cqid];
>> +	u16 status;
>> +
>> +	if (test_and_set_bit(NVMET_PCI_EPF_Q_LIVE, &cq->flags))
>> +		return NVME_SC_QID_INVALID | NVME_STATUS_DNR;
>> +
>> +	if (!(flags & NVME_QUEUE_PHYS_CONTIG))
>> +		return NVME_SC_INVALID_QUEUE | NVME_STATUS_DNR;
>> +
>> +	if (flags & NVME_CQ_IRQ_ENABLED)
>> +		set_bit(NVMET_PCI_EPF_Q_IRQ_ENABLED, &cq->flags);
>> +
>> +	cq->pci_addr = pci_addr;
>> +	cq->qid = cqid;
>> +	cq->depth = qsize + 1;
>> +	cq->vector = vector;
>> +	cq->head = 0;
>> +	cq->tail = 0;
>> +	cq->phase = 1;
>> +	cq->db = NVME_REG_DBS + (((cqid * 2) + 1) * sizeof(u32));
>> +	nvmet_pci_epf_bar_write32(ctrl, cq->db, 0);
>> +
>> +	if (!cqid)
>> +		cq->qes = sizeof(struct nvme_completion);
>> +	else
>> +		cq->qes = ctrl->io_cqes;
>> +	cq->pci_size = cq->qes * cq->depth;
>> +
>> +	cq->iv = nvmet_pci_epf_add_irq_vector(ctrl, vector);
>> +	if (!cq->iv) {
>> +		status = NVME_SC_INTERNAL | NVME_STATUS_DNR;
>> +		goto err;
>> +	}
>> +
>> +	status = nvmet_cq_create(tctrl, &cq->nvme_cq, cqid, cq->depth);
>> +	if (status != NVME_SC_SUCCESS)
>> +		goto err;
>> +
>> +	dev_dbg(ctrl->dev, "CQ[%u]: %u entries of %zu B, IRQ vector %u\n",
>> +		cqid, qsize, cq->qes, cq->vector);
>> +
>> +	return NVME_SC_SUCCESS;
>> +
>> +err:
>> +	clear_bit(NVMET_PCI_EPF_Q_IRQ_ENABLED, &cq->flags);
>> +	clear_bit(NVMET_PCI_EPF_Q_LIVE, &cq->flags);
>> +	return status;
>> +}
>> +
>> +static u16 nvmet_pci_epf_delete_cq(struct nvmet_ctrl *tctrl, u16 cqid)
>> +{
>> +	struct nvmet_pci_epf_ctrl *ctrl = tctrl->drvdata;
>> +	struct nvmet_pci_epf_queue *cq = &ctrl->cq[cqid];
>> +
>> +	if (!test_and_clear_bit(NVMET_PCI_EPF_Q_LIVE, &cq->flags))
>> +		return NVME_SC_QID_INVALID | NVME_STATUS_DNR;
>> +
>> +	cancel_delayed_work_sync(&cq->work);
>> +	nvmet_pci_epf_drain_queue(cq);
>> +	nvmet_pci_epf_remove_irq_vector(ctrl, cq->vector);
>> +
>> +	return NVME_SC_SUCCESS;
>> +}
>> +
>> +static u16 nvmet_pci_epf_create_sq(struct nvmet_ctrl *tctrl,
>> +		u16 sqid, u16 flags, u16 qsize, u64 pci_addr)
>> +{
>> +	struct nvmet_pci_epf_ctrl *ctrl = tctrl->drvdata;
>> +	struct nvmet_pci_epf_queue *sq = &ctrl->sq[sqid];
>> +	u16 status;
>> +
>> +	if (test_and_set_bit(NVMET_PCI_EPF_Q_LIVE, &sq->flags))
>> +		return NVME_SC_QID_INVALID | NVME_STATUS_DNR;
>> +
>> +	if (!(flags & NVME_QUEUE_PHYS_CONTIG))
>> +		return NVME_SC_INVALID_QUEUE | NVME_STATUS_DNR;
>> +
>> +	sq->pci_addr = pci_addr;
>> +	sq->qid = sqid;
>> +	sq->depth = qsize + 1;
>> +	sq->head = 0;
>> +	sq->tail = 0;
>> +	sq->phase = 0;
>> +	sq->db = NVME_REG_DBS + (sqid * 2 * sizeof(u32));
>> +	nvmet_pci_epf_bar_write32(ctrl, sq->db, 0);
>> +	if (!sqid)
>> +		sq->qes = 1UL << NVME_ADM_SQES;
>> +	else
>> +		sq->qes = ctrl->io_sqes;
>> +	sq->pci_size = sq->qes * sq->depth;
>> +
>> +	status = nvmet_sq_create(tctrl, &sq->nvme_sq, sqid, sq->depth);
>> +	if (status != NVME_SC_SUCCESS)
>> +		goto out_clear_bit;
>> +
>> +	sq->iod_wq = alloc_workqueue("sq%d_wq", WQ_UNBOUND,
>> +				min_t(int, sq->depth, WQ_MAX_ACTIVE), sqid);
>> +	if (!sq->iod_wq) {
>> +		dev_err(ctrl->dev, "Failed to create SQ %d work queue\n", sqid);
>> +		status = NVME_SC_INTERNAL | NVME_STATUS_DNR;
>> +		goto out_destroy_sq;
>> +	}
>> +
>> +	dev_dbg(ctrl->dev, "SQ[%u]: %u entries of %zu B\n",
>> +		sqid, qsize, sq->qes);
>> +
>> +	return NVME_SC_SUCCESS;
>> +
>> +out_destroy_sq:
>> +	nvmet_sq_destroy(&sq->nvme_sq);
>> +out_clear_bit:
>> +	clear_bit(NVMET_PCI_EPF_Q_LIVE, &sq->flags);
>> +	return status;
>> +}
>> +
>> +static u16 nvmet_pci_epf_delete_sq(struct nvmet_ctrl *tctrl, u16 sqid)
>> +{
>> +	struct nvmet_pci_epf_ctrl *ctrl = tctrl->drvdata;
>> +	struct nvmet_pci_epf_queue *sq = &ctrl->sq[sqid];
>> +
>> +	if (!test_and_clear_bit(NVMET_PCI_EPF_Q_LIVE, &sq->flags))
>> +		return NVME_SC_QID_INVALID | NVME_STATUS_DNR;
>> +
>> +	flush_workqueue(sq->iod_wq);
>> +	destroy_workqueue(sq->iod_wq);
>> +	sq->iod_wq = NULL;
>> +
>> +	nvmet_pci_epf_drain_queue(sq);
>> +
>> +	if (sq->nvme_sq.ctrl)
>> +		nvmet_sq_destroy(&sq->nvme_sq);
>> +
>> +	return NVME_SC_SUCCESS;
>> +}
>> +
>> +static u16 nvmet_pci_epf_get_feat(const struct nvmet_ctrl *tctrl,
>> +				  u8 feat, void *data)
>> +{
>> +	struct nvmet_pci_epf_ctrl *ctrl = tctrl->drvdata;
>> +	struct nvmet_feat_arbitration *arb;
>> +	struct nvmet_feat_irq_coalesce *irqc;
>> +	struct nvmet_feat_irq_config *irqcfg;
>> +	struct nvmet_pci_epf_irq_vector *iv;
>> +	u16 status;
>> +
>> +	switch (feat) {
>> +	case NVME_FEAT_ARBITRATION:
>> +		arb = data;
>> +		if (!ctrl->sq_ab)
>> +			arb->ab = 0x7;
>> +		else
>> +			arb->ab = ilog2(ctrl->sq_ab);
>> +		return NVME_SC_SUCCESS;
>> +
>> +	case NVME_FEAT_IRQ_COALESCE:
>> +		irqc = data;
>> +		irqc->thr = ctrl->irq_vector_threshold;
>> +		irqc->time = 0;
>> +		return NVME_SC_SUCCESS;
>> +
>> +	case NVME_FEAT_IRQ_CONFIG:
>> +		irqcfg = data;
>> +		mutex_lock(&ctrl->irq_lock);
>> +		iv = nvmet_pci_epf_find_irq_vector(ctrl, irqcfg->iv);
>> +		if (iv) {
>> +			irqcfg->cd = iv->cd;
>> +			status = NVME_SC_SUCCESS;
>> +		} else {
>> +			status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
>> +		}
>> +		mutex_unlock(&ctrl->irq_lock);
>> +		return status;
>> +
>> +	default:
>> +		return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
>> +	}
>> +}
>> +
>> +static u16 nvmet_pci_epf_set_feat(const struct nvmet_ctrl *tctrl,
>> +				  u8 feat, void *data)
>> +{
>> +	struct nvmet_pci_epf_ctrl *ctrl = tctrl->drvdata;
>> +	struct nvmet_feat_arbitration *arb;
>> +	struct nvmet_feat_irq_coalesce *irqc;
>> +	struct nvmet_feat_irq_config *irqcfg;
>> +	struct nvmet_pci_epf_irq_vector *iv;
>> +	u16 status;
>> +
>> +	switch (feat) {
>> +	case NVME_FEAT_ARBITRATION:
>> +		arb = data;
>> +		if (arb->ab == 0x7)
>> +			ctrl->sq_ab = 0;
>> +		else
>> +			ctrl->sq_ab = 1 << arb->ab;
>> +		return NVME_SC_SUCCESS;
>> +
>> +	case NVME_FEAT_IRQ_COALESCE:
>> +		/*
>> +		 * Note: since we do not implement precise IRQ coalescing
>> +		 * timing, ignore the time field.
>> +		 */
>> +		irqc = data;
>> +		ctrl->irq_vector_threshold = irqc->thr + 1;
>> +		return NVME_SC_SUCCESS;
>> +
>> +	case NVME_FEAT_IRQ_CONFIG:
>> +		irqcfg = data;
>> +		mutex_lock(&ctrl->irq_lock);
>> +		iv = nvmet_pci_epf_find_irq_vector(ctrl, irqcfg->iv);
>> +		if (iv) {
>> +			iv->cd = irqcfg->cd;
>> +			status = NVME_SC_SUCCESS;
>> +		} else {
>> +			status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
>> +		}
>> +		mutex_unlock(&ctrl->irq_lock);
>> +		return status;
>> +
>> +	default:
>> +		return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
>> +	}
>> +}
>> +
>> +static const struct nvmet_fabrics_ops nvmet_pci_epf_fabrics_ops = {
>> +	.owner		= THIS_MODULE,
>> +	.type		= NVMF_TRTYPE_PCI,
>> +	.add_port	= nvmet_pci_epf_add_port,
>> +	.remove_port	= nvmet_pci_epf_remove_port,
>> +	.queue_response = nvmet_pci_epf_queue_response,
>> +	.get_mdts	= nvmet_pci_epf_get_mdts,
>> +	.create_cq	= nvmet_pci_epf_create_cq,
>> +	.delete_cq	= nvmet_pci_epf_delete_cq,
>> +	.create_sq	= nvmet_pci_epf_create_sq,
>> +	.delete_sq	= nvmet_pci_epf_delete_sq,
>> +	.get_feature	= nvmet_pci_epf_get_feat,
>> +	.set_feature	= nvmet_pci_epf_set_feat,
>> +};
>> +
>> +static void nvmet_pci_epf_cq_work(struct work_struct *work);
>> +
>> +static void nvmet_pci_epf_init_queue(struct nvmet_pci_epf_ctrl *ctrl,
>> +				     unsigned int qid, bool sq)
>> +{
>> +	struct nvmet_pci_epf_queue *queue;
>> +
>> +	if (sq) {
>> +		queue = &ctrl->sq[qid];
>> +		set_bit(NVMET_PCI_EPF_Q_IS_SQ, &queue->flags);
>> +	} else {
>> +		queue = &ctrl->cq[qid];
>> +		INIT_DELAYED_WORK(&queue->work, nvmet_pci_epf_cq_work);
>> +	}
>> +	queue->ctrl = ctrl;
>> +	queue->qid = qid;
>> +	spin_lock_init(&queue->lock);
>> +	INIT_LIST_HEAD(&queue->list);
>> +}
>> +
>> +static int nvmet_pci_epf_alloc_queues(struct nvmet_pci_epf_ctrl *ctrl)
>> +{
>> +	unsigned int qid;
>> +
>> +	ctrl->sq = kcalloc(ctrl->nr_queues,
>> +			   sizeof(struct nvmet_pci_epf_queue), GFP_KERNEL);
>> +	if (!ctrl->sq)
>> +		return -ENOMEM;
>> +
>> +	ctrl->cq = kcalloc(ctrl->nr_queues,
>> +			   sizeof(struct nvmet_pci_epf_queue), GFP_KERNEL);
>> +	if (!ctrl->cq) {
>> +		kfree(ctrl->sq);
>> +		ctrl->sq = NULL;
>> +		return -ENOMEM;
>> +	}
>> +
>> +	for (qid = 0; qid < ctrl->nr_queues; qid++) {
>> +		nvmet_pci_epf_init_queue(ctrl, qid, true);
>> +		nvmet_pci_epf_init_queue(ctrl, qid, false);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void nvmet_pci_epf_free_queues(struct nvmet_pci_epf_ctrl *ctrl)
>> +{
>> +	kfree(ctrl->sq);
>> +	ctrl->sq = NULL;
>> +	kfree(ctrl->cq);
>> +	ctrl->cq = NULL;
>> +}
>> +
>> +static int nvmet_pci_epf_map_queue(struct nvmet_pci_epf_ctrl *ctrl,
>> +				   struct nvmet_pci_epf_queue *queue)
>> +{
>> +	struct nvmet_pci_epf *nvme_epf = ctrl->nvme_epf;
>> +	int ret;
>> +
>> +	ret = nvmet_pci_epf_mem_map(nvme_epf, queue->pci_addr,
>> +				      queue->pci_size, &queue->pci_map);
>> +	if (ret) {
>> +		dev_err(ctrl->dev, "Failed to map queue %u (err=%d)\n",
>> +			queue->qid, ret);
>> +		return ret;
>> +	}
>> +
>> +	if (queue->pci_map.pci_size < queue->pci_size) {
>> +		dev_err(ctrl->dev, "Invalid partial mapping of queue %u\n",
>> +			queue->qid);
>> +		nvmet_pci_epf_mem_unmap(nvme_epf, &queue->pci_map);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static inline void nvmet_pci_epf_unmap_queue(struct nvmet_pci_epf_ctrl *ctrl,
>> +					     struct nvmet_pci_epf_queue *queue)
>> +{
>> +	nvmet_pci_epf_mem_unmap(ctrl->nvme_epf, &queue->pci_map);
>> +}
>> +
>> +static void nvmet_pci_epf_exec_iod_work(struct work_struct *work)
>> +{
>> +	struct nvmet_pci_epf_iod *iod =
>> +		container_of(work, struct nvmet_pci_epf_iod, work);
>> +	struct nvmet_req *req = &iod->req;
>> +	int ret;
>> +
>> +	if (!iod->ctrl->link_up) {
>> +		nvmet_pci_epf_free_iod(iod);
>> +		return;
>> +	}
>> +
>> +	if (!test_bit(NVMET_PCI_EPF_Q_LIVE, &iod->sq->flags)) {
>> +		iod->status = NVME_SC_QID_INVALID | NVME_STATUS_DNR;
>> +		goto complete;
>> +	}
>> +
>> +	if (!nvmet_req_init(req, &iod->cq->nvme_cq, &iod->sq->nvme_sq,
>> +			    &nvmet_pci_epf_fabrics_ops))
>> +		goto complete;
>> +
>> +	iod->data_len = nvmet_req_transfer_len(req);
>> +	if (iod->data_len) {
>> +		/*
>> +		 * Get the data DMA transfer direction. Here "device" means the
>> +		 * PCI root-complex host.
>> +		 */
>> +		if (nvme_is_write(&iod->cmd))
>> +			iod->dma_dir = DMA_FROM_DEVICE;
>> +		else
>> +			iod->dma_dir = DMA_TO_DEVICE;
>> +
>> +		/*
>> +		 * Setup the command data buffer and get the command data from
>> +		 * the host if needed.
>> +		 */
>> +		ret = nvmet_pci_epf_alloc_iod_data_buf(iod);
>> +		if (!ret && iod->dma_dir == DMA_FROM_DEVICE)
>> +			ret = nvmet_pci_epf_transfer_iod_data(iod);
>> +		if (ret) {
>> +			nvmet_req_uninit(req);
>> +			goto complete;
>> +		}
>> +	}
>> +
>> +	req->execute(req);
>> +
>> +	/*
>> +	 * If we do not have data to transfer after the command execution
>> +	 * finishes, nvmet_pci_epf_queue_response() will complete the command
>> +	 * directly. No need to wait for the completion in this case.
>> +	 */
>> +	if (!iod->data_len || iod->dma_dir != DMA_TO_DEVICE)
>> +		return;
>> +
>> +	wait_for_completion(&iod->done);
>> +
>> +	if (iod->status == NVME_SC_SUCCESS) {
>> +		WARN_ON_ONCE(!iod->data_len || iod->dma_dir != DMA_TO_DEVICE);
>> +		nvmet_pci_epf_transfer_iod_data(iod);
>> +	}
>> +
>> +complete:
>> +	nvmet_pci_epf_complete_iod(iod);
>> +}
>> +
>> +static int nvmet_pci_epf_process_sq(struct nvmet_pci_epf_ctrl *ctrl,
>> +				    struct nvmet_pci_epf_queue *sq)
>> +{
>> +	struct nvmet_pci_epf_iod *iod;
>> +	int ret, n = 0;
>> +
>> +	sq->tail = nvmet_pci_epf_bar_read32(ctrl, sq->db);
>> +	while (sq->head != sq->tail && (!ctrl->sq_ab || n < ctrl->sq_ab)) {
>> +		iod = nvmet_pci_epf_alloc_iod(sq);
>> +		if (!iod)
>> +			break;
>> +
>> +		/* Get the NVMe command submitted by the host */
>> +		ret = nvmet_pci_epf_transfer(ctrl, &iod->cmd,
>> +					     sq->pci_addr + sq->head * sq->qes,
>> +					     sizeof(struct nvme_command),
>> +					     DMA_FROM_DEVICE);
>> +		if (ret) {
>> +			/* Not much we can do... */
>> +			nvmet_pci_epf_free_iod(iod);
>> +			break;
>> +		}
>> +
>> +		dev_dbg(ctrl->dev, "SQ[%u]: head %u, tail %u, command %s\n",
>> +			sq->qid, sq->head, sq->tail,
>> +			nvmet_pci_epf_iod_name(iod));
>> +
>> +		sq->head++;
>> +		if (sq->head == sq->depth)
>> +			sq->head = 0;
>> +		n++;
>> +
>> +		queue_work_on(WORK_CPU_UNBOUND, sq->iod_wq, &iod->work);
>> +
>> +		sq->tail = nvmet_pci_epf_bar_read32(ctrl, sq->db);
>> +	}
>> +
>> +	return n;
>> +}
>> +
>> +static void nvmet_pci_epf_poll_sqs_work(struct work_struct *work)
>> +{
>> +	struct nvmet_pci_epf_ctrl *ctrl =
>> +		container_of(work, struct nvmet_pci_epf_ctrl, poll_sqs.work);
>> +	struct nvmet_pci_epf_queue *sq;
>> +	unsigned long last = 0;
>> +	int i, nr_sqs;
>> +
>> +	while (ctrl->link_up && ctrl->enabled) {
>> +		nr_sqs = 0;
>> +		/* Do round-robin command arbitration */
>> +		for (i = 0; i < ctrl->nr_queues; i++) {
>> +			sq = &ctrl->sq[i];
>> +			if (!test_bit(NVMET_PCI_EPF_Q_LIVE, &sq->flags))
>> +				continue;
>> +			if (nvmet_pci_epf_process_sq(ctrl, sq))
>> +				nr_sqs++;
>> +		}
>> +
>> +		if (nr_sqs) {
>> +			last = jiffies;
>> +			continue;
>> +		}
>> +
>> +		/*
>> +		 * If we have not received any command on any queue for more
>> +		 * than NVMET_PCI_EPF_SQ_POLL_IDLE, assume we are idle and
>> +		 * reschedule. This avoids "burning" a CPU when the controller
>> +		 * is idle for a long time.
>> +		 */
>> +		if (time_is_before_jiffies(last + NVMET_PCI_EPF_SQ_POLL_IDLE))
>> +			break;
>> +
>> +		cpu_relax();
>> +	}
>> +
>> +	schedule_delayed_work(&ctrl->poll_sqs, NVMET_PCI_EPF_SQ_POLL_INTERVAL);
>> +}
>> +
>> +static void nvmet_pci_epf_cq_work(struct work_struct *work)
>> +{
>> +	struct nvmet_pci_epf_queue *cq =
>> +		container_of(work, struct nvmet_pci_epf_queue, work.work);
>> +	struct nvmet_pci_epf_ctrl *ctrl = cq->ctrl;
>> +	struct nvme_completion *cqe;
>> +	struct nvmet_pci_epf_iod *iod;
>> +	unsigned long flags;
>> +	int ret, n = 0;
>> +
>> +	ret = nvmet_pci_epf_map_queue(ctrl, cq);
>> +	if (ret)
>> +		goto again;
>> +
>> +	while (test_bit(NVMET_PCI_EPF_Q_LIVE, &cq->flags) && ctrl->link_up) {
>> +
>> +		/* Check that the CQ is not full. */
>> +		cq->head = nvmet_pci_epf_bar_read32(ctrl, cq->db);
>> +		if (cq->head == cq->tail + 1) {
>> +			ret = -EAGAIN;
>> +			break;
>> +		}
>> +
>> +		spin_lock_irqsave(&cq->lock, flags);
>> +		iod = list_first_entry_or_null(&cq->list,
>> +					       struct nvmet_pci_epf_iod, link);
>> +		if (iod)
>> +			list_del_init(&iod->link);
>> +		spin_unlock_irqrestore(&cq->lock, flags);
>> +
>> +		if (!iod)
>> +			break;
>> +
>> +		/* Post the IOD completion entry. */
>> +		cqe = &iod->cqe;
>> +		cqe->status = cpu_to_le16((iod->status << 1) | cq->phase);
>> +
>> +		dev_dbg(ctrl->dev,
>> +			"CQ[%u]: %s status 0x%x, result 0x%llx, head %u, tail %u, phase %u\n",
>> +			cq->qid, nvmet_pci_epf_iod_name(iod), iod->status,
>> +			le64_to_cpu(cqe->result.u64), cq->head, cq->tail,
>> +			cq->phase);
>> +
>> +		memcpy_toio(cq->pci_map.virt_addr + cq->tail * cq->qes, cqe,
>> +			    sizeof(struct nvme_completion));
>> +
>> +		/* Advance the tail */
>> +		cq->tail++;
>> +		if (cq->tail >= cq->depth) {
>> +			cq->tail = 0;
>> +			cq->phase ^= 1;
>> +		}
>> +
>> +		nvmet_pci_epf_free_iod(iod);
>> +
>> +		/* Signal the host. */
>> +		nvmet_pci_epf_raise_irq(ctrl, cq, false);
>> +		n++;
>> +	}
>> +
>> +	nvmet_pci_epf_unmap_queue(ctrl, cq);
>> +
>> +	/*
>> +	 * We do not support precise IRQ coalescing time (100ns units as per
>> +	 * NVMe specifications). So if we have posted completion entries without
>> +	 * reaching the interrupt coalescing threshold, raise an interrupt.
>> +	 */
>> +	if (n)
>> +		nvmet_pci_epf_raise_irq(ctrl, cq, true);
>> +
>> +again:
>> +	if (ret < 0)
>> +		queue_delayed_work(system_highpri_wq, &cq->work,
>> +				   NVMET_PCI_EPF_CQ_RETRY_INTERVAL);
>> +}
>> +
>> +static int nvmet_pci_epf_enable_ctrl(struct nvmet_pci_epf_ctrl *ctrl)
>> +{
>> +	u64 pci_addr, asq, acq;
>> +	u32 aqa;
>> +	u16 status, qsize;
>> +
>> +	if (ctrl->enabled)
>> +		return 0;
>> +
>> +	dev_info(ctrl->dev, "Enabling controller\n");
>> +
>> +	ctrl->mps_shift = nvmet_cc_mps(ctrl->cc) + 12;
>> +	ctrl->mps = 1UL << ctrl->mps_shift;
>> +	ctrl->mps_mask = ctrl->mps - 1;
>> +
>> +	ctrl->io_sqes = 1UL << nvmet_cc_iosqes(ctrl->cc);
>> +	ctrl->io_cqes = 1UL << nvmet_cc_iocqes(ctrl->cc);
>> +
>> +	if (ctrl->io_sqes < sizeof(struct nvme_command)) {
>> +		dev_err(ctrl->dev, "Unsupported IO SQES %zu (need %zu)\n",
>> +			ctrl->io_sqes, sizeof(struct nvme_command));
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (ctrl->io_cqes < sizeof(struct nvme_completion)) {
>> +		dev_err(ctrl->dev, "Unsupported IO CQES %zu (need %zu)\n",
>> +			ctrl->io_sqes, sizeof(struct nvme_completion));
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Create the admin queue. */
>> +	aqa = nvmet_pci_epf_bar_read32(ctrl, NVME_REG_AQA);
>> +	asq = nvmet_pci_epf_bar_read64(ctrl, NVME_REG_ASQ);
>> +	acq = nvmet_pci_epf_bar_read64(ctrl, NVME_REG_ACQ);
>> +
>> +	qsize = (aqa & 0x0fff0000) >> 16;
>> +	pci_addr = acq & GENMASK(63, 12);
>> +	status = nvmet_pci_epf_create_cq(ctrl->tctrl, 0,
>> +				NVME_CQ_IRQ_ENABLED | NVME_QUEUE_PHYS_CONTIG,
>> +				qsize, pci_addr, 0);
>> +	if (status != NVME_SC_SUCCESS) {
>> +		dev_err(ctrl->dev, "Failed to create admin completion queue\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	qsize = aqa & 0x00000fff;
>> +	pci_addr = asq & GENMASK(63, 12);
>> +	status = nvmet_pci_epf_create_sq(ctrl->tctrl, 0, NVME_QUEUE_PHYS_CONTIG,
>> +					 qsize, pci_addr);
>> +	if (status != NVME_SC_SUCCESS) {
>> +		dev_err(ctrl->dev, "Failed to create admin submission queue\n");
>> +		nvmet_pci_epf_delete_cq(ctrl->tctrl, 0);
>> +		return -EINVAL;
>> +	}
>> +
>> +	ctrl->sq_ab = NVMET_PCI_EPF_SQ_AB;
>> +	ctrl->irq_vector_threshold = NVMET_PCI_EPF_IV_THRESHOLD;
>> +	ctrl->enabled = true;
>> +
>> +	/* Start polling the controller SQs */
>> +	schedule_delayed_work(&ctrl->poll_sqs, 0);
>> +
>> +	return 0;
>> +}
>> +
>> +static void nvmet_pci_epf_disable_ctrl(struct nvmet_pci_epf_ctrl *ctrl)
>> +{
>> +	int qid;
>> +
>> +	if (!ctrl->enabled)
>> +		return;
>> +
>> +	dev_info(ctrl->dev, "Disabling controller\n");
>> +
>> +	ctrl->enabled = false;
>> +	cancel_delayed_work_sync(&ctrl->poll_sqs);
>> +
>> +	/* Delete all IO queues */
>> +	for (qid = 1; qid < ctrl->nr_queues; qid++)
>> +		nvmet_pci_epf_delete_sq(ctrl->tctrl, qid);
>> +
>> +	for (qid = 1; qid < ctrl->nr_queues; qid++)
>> +		nvmet_pci_epf_delete_cq(ctrl->tctrl, qid);
>> +
>> +	/* Delete the admin queue last */
>> +	nvmet_pci_epf_delete_sq(ctrl->tctrl, 0);
>> +	nvmet_pci_epf_delete_cq(ctrl->tctrl, 0);
>> +}
>> +
>> +static void nvmet_pci_epf_poll_cc_work(struct work_struct *work)
>> +{
>> +	struct nvmet_pci_epf_ctrl *ctrl =
>> +		container_of(work, struct nvmet_pci_epf_ctrl, poll_cc.work);
>> +	u32 old_cc, new_cc;
>> +	int ret;
>> +
>> +	if (!ctrl->tctrl)
>> +		return;
>> +
>> +	old_cc = ctrl->cc;
>> +	new_cc = nvmet_pci_epf_bar_read32(ctrl, NVME_REG_CC);
>> +	ctrl->cc = new_cc;
>> +
>> +	if (nvmet_cc_en(new_cc) && !nvmet_cc_en(old_cc)) {
>> +		/* Enable the controller */
>> +		ret = nvmet_pci_epf_enable_ctrl(ctrl);
>> +		if (ret)
>> +			return;
>> +		ctrl->csts |= NVME_CSTS_RDY;
>> +	}
>> +
>> +	if (!nvmet_cc_en(new_cc) && nvmet_cc_en(old_cc)) {
>> +		nvmet_pci_epf_disable_ctrl(ctrl);
>> +		ctrl->csts &= ~NVME_CSTS_RDY;
>> +	}
>> +
>> +	if (nvmet_cc_shn(new_cc) && !nvmet_cc_shn(old_cc)) {
>> +		nvmet_pci_epf_disable_ctrl(ctrl);
>> +		ctrl->csts |= NVME_CSTS_SHST_CMPLT;
>> +	}
>> +
>> +	if (!nvmet_cc_shn(new_cc) && nvmet_cc_shn(old_cc))
>> +		ctrl->csts &= ~NVME_CSTS_SHST_CMPLT;
>> +
>> +	nvmet_update_cc(ctrl->tctrl, ctrl->cc);
>> +	nvmet_pci_epf_bar_write32(ctrl, NVME_REG_CSTS, ctrl->csts);
>> +
>> +	schedule_delayed_work(&ctrl->poll_cc, NVMET_PCI_EPF_CC_POLL_INTERVAL);
>> +}
>> +
>> +static void nvmet_pci_epf_init_bar(struct nvmet_pci_epf_ctrl *ctrl)
>> +{
>> +	struct nvmet_ctrl *tctrl = ctrl->tctrl;
>> +
>> +	ctrl->bar = ctrl->nvme_epf->reg_bar;
>> +
>> +	/* Copy the target controller capabilities as a base */
>> +	ctrl->cap = tctrl->cap;
>> +
>> +	/* Contiguous Queues Required (CQR) */
>> +	ctrl->cap |= 0x1ULL << 16;
>> +
>> +	/* Set Doorbell stride to 4B (DSTRB) */
>> +	ctrl->cap &= ~GENMASK(35, 32);
>> +
>> +	/* Clear NVM Subsystem Reset Supported (NSSRS) */
>> +	ctrl->cap &= ~(0x1ULL << 36);
>> +
>> +	/* Clear Boot Partition Support (BPS) */
>> +	ctrl->cap &= ~(0x1ULL << 45);
>> +
>> +	/* Clear Persistent Memory Region Supported (PMRS) */
>> +	ctrl->cap &= ~(0x1ULL << 56);
>> +
>> +	/* Clear Controller Memory Buffer Supported (CMBS) */
>> +	ctrl->cap &= ~(0x1ULL << 57);
>> +
>> +	/* Controller configuration */
>> +	ctrl->cc = tctrl->cc & (~NVME_CC_ENABLE);
>> +
>> +	/* Controller status */
>> +	ctrl->csts = ctrl->tctrl->csts;
>> +
>> +	nvmet_pci_epf_bar_write64(ctrl, NVME_REG_CAP, ctrl->cap);
>> +	nvmet_pci_epf_bar_write32(ctrl, NVME_REG_VS, tctrl->subsys->ver);
>> +	nvmet_pci_epf_bar_write32(ctrl, NVME_REG_CSTS, ctrl->csts);
>> +	nvmet_pci_epf_bar_write32(ctrl, NVME_REG_CC, ctrl->cc);
>> +}
>> +
>> +static int nvmet_pci_epf_create_ctrl(struct nvmet_pci_epf *nvme_epf,
>> +				     unsigned int max_nr_queues)
>> +{
>> +	struct nvmet_pci_epf_ctrl *ctrl = &nvme_epf->ctrl;
>> +	struct nvmet_alloc_ctrl_args args = {};
>> +	char hostnqn[NVMF_NQN_SIZE];
>> +	uuid_t id;
>> +	int ret;
>> +
>> +	memset(ctrl, 0, sizeof(*ctrl));
>> +	ctrl->dev = &nvme_epf->epf->dev;
>> +	mutex_init(&ctrl->irq_lock);
>> +	ctrl->nvme_epf = nvme_epf;
>> +	ctrl->mdts = nvme_epf->mdts_kb * SZ_1K;
>> +	INIT_DELAYED_WORK(&ctrl->poll_cc, nvmet_pci_epf_poll_cc_work);
>> +	INIT_DELAYED_WORK(&ctrl->poll_sqs, nvmet_pci_epf_poll_sqs_work);
>> +
>> +	ret = mempool_init_kmalloc_pool(&ctrl->iod_pool,
>> +					max_nr_queues * NVMET_MAX_QUEUE_SIZE,
>> +					sizeof(struct nvmet_pci_epf_iod));
>> +	if (ret) {
>> +		dev_err(ctrl->dev, "Failed to initialize iod mempool\n");
>> +		return ret;
>> +	}
>> +
>> +	ctrl->port = nvmet_pci_epf_find_port(ctrl, nvme_epf->portid);
>> +	if (!ctrl->port) {
>> +		dev_err(ctrl->dev, "Port not found\n");
>> +		ret = -EINVAL;
>> +		goto out_mempool_exit;
>> +	}
>> +
>> +	/* Create the target controller */
>> +	uuid_gen(&id);
>> +	snprintf(hostnqn, NVMF_NQN_SIZE,
>> +		 "nqn.2014-08.org.nvmexpress:uuid:%pUb", &id);
>> +	args.port = ctrl->port;
>> +	args.subsysnqn = nvme_epf->subsysnqn;
>> +	memset(&id, 0, sizeof(uuid_t));
>> +	args.hostid = &id;
>> +	args.hostnqn = hostnqn;
>> +	args.ops = &nvmet_pci_epf_fabrics_ops;
>> +
>> +	ctrl->tctrl = nvmet_alloc_ctrl(&args);
>> +	if (!ctrl->tctrl) {
>> +		dev_err(ctrl->dev, "Failed to create target controller\n");
>> +		ret = -ENOMEM;
>> +		goto out_mempool_exit;
>> +	}
>> +	ctrl->tctrl->drvdata = ctrl;
>> +
>> +	/* We do not support protection information for now. */
>> +	if (ctrl->tctrl->pi_support) {
>> +		dev_err(ctrl->dev,
>> +			"Protection information (PI) is not supported\n");
>> +		ret = -ENOTSUPP;
>> +		goto out_put_ctrl;
>> +	}
>> +
>> +	/* Allocate our queues, up to the maximum number */
>> +	ctrl->nr_queues = min(ctrl->tctrl->subsys->max_qid + 1, max_nr_queues);
>> +	ret = nvmet_pci_epf_alloc_queues(ctrl);
>> +	if (ret)
>> +		goto out_put_ctrl;
>> +
>> +	/*
>> +	 * Allocate the IRQ vectors descriptors. We cannot have more than the
>> +	 * maximum number of queues.
>> +	 */
>> +	ret = nvmet_pci_epf_alloc_irq_vectors(ctrl);
>> +	if (ret)
>> +		goto out_free_queues;
>> +
>> +	dev_info(ctrl->dev,
>> +		 "New PCI ctrl \"%s\", %u I/O queues, mdts %u B\n",
>> +		 ctrl->tctrl->subsys->subsysnqn, ctrl->nr_queues - 1,
>> +		 ctrl->mdts);
>> +
>> +	/* Initialize BAR 0 using the target controller CAP */
>> +	nvmet_pci_epf_init_bar(ctrl);
>> +
>> +	return 0;
>> +
>> +out_free_queues:
>> +	nvmet_pci_epf_free_queues(ctrl);
>> +out_put_ctrl:
>> +	nvmet_ctrl_put(ctrl->tctrl);
>> +	ctrl->tctrl = NULL;
>> +out_mempool_exit:
>> +	mempool_exit(&ctrl->iod_pool);
>> +	return ret;
>> +}
>> +
>> +static void nvmet_pci_epf_start_ctrl(struct nvmet_pci_epf_ctrl *ctrl)
>> +{
>> +	schedule_delayed_work(&ctrl->poll_cc, NVMET_PCI_EPF_CC_POLL_INTERVAL);
>> +}
>> +
>> +static void nvmet_pci_epf_stop_ctrl(struct nvmet_pci_epf_ctrl *ctrl)
>> +{
>> +	cancel_delayed_work_sync(&ctrl->poll_cc);
>> +
>> +	nvmet_pci_epf_disable_ctrl(ctrl);
>> +}
>> +
>> +static void nvmet_pci_epf_destroy_ctrl(struct nvmet_pci_epf_ctrl *ctrl)
>> +{
>> +	if (!ctrl->tctrl)
>> +		return;
>> +
>> +	dev_info(ctrl->dev, "Destroying PCI ctrl \"%s\"\n",
>> +		 ctrl->tctrl->subsys->subsysnqn);
>> +
>> +	nvmet_pci_epf_stop_ctrl(ctrl);
>> +
>> +	nvmet_pci_epf_free_queues(ctrl);
>> +	nvmet_pci_epf_free_irq_vectors(ctrl);
>> +
>> +	nvmet_ctrl_put(ctrl->tctrl);
>> +	ctrl->tctrl = NULL;
>> +
>> +	mempool_exit(&ctrl->iod_pool);
>> +}
>> +
>> +static int nvmet_pci_epf_configure_bar(struct nvmet_pci_epf *nvme_epf)
>> +{
>> +	struct pci_epf *epf = nvme_epf->epf;
>> +	const struct pci_epc_features *epc_features = nvme_epf->epc_features;
>> +	size_t reg_size, reg_bar_size;
>> +	size_t msix_table_size = 0;
>> +
>> +	/*
>> +	 * The first free BAR will be our register BAR and per NVMe
>> +	 * specifications, it must be BAR 0.
>> +	 */
>> +	if (pci_epc_get_first_free_bar(epc_features) != BAR_0) {
>> +		dev_err(&epf->dev, "BAR 0 is not free\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	/* Initialize BAR flags */
>> +	if (epc_features->bar[BAR_0].only_64bit)
>> +		epf->bar[BAR_0].flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
>> +
>> +	/*
>> +	 * Calculate the size of the register bar: NVMe registers first with
>> +	 * enough space for the doorbells, followed by the MSI-X table
>> +	 * if supported.
>> +	 */
>> +	reg_size = NVME_REG_DBS + (NVMET_NR_QUEUES * 2 * sizeof(u32));
>> +	reg_size = ALIGN(reg_size, 8);
>> +
>> +	if (epc_features->msix_capable) {
>> +		size_t pba_size;
>> +
>> +		msix_table_size = PCI_MSIX_ENTRY_SIZE * epf->msix_interrupts;
>> +		nvme_epf->msix_table_offset = reg_size;
>> +		pba_size = ALIGN(DIV_ROUND_UP(epf->msix_interrupts, 8), 8);
>> +
>> +		reg_size += msix_table_size + pba_size;
>> +	}
>> +
>> +	if (epc_features->bar[BAR_0].type == BAR_FIXED) {
>> +		if (reg_size > epc_features->bar[BAR_0].fixed_size) {
>> +			dev_err(&epf->dev,
>> +				"BAR 0 size %llu B too small, need %zu B\n",
>> +				epc_features->bar[BAR_0].fixed_size,
>> +				reg_size);
>> +			return -ENOMEM;
>> +		}
>> +		reg_bar_size = epc_features->bar[BAR_0].fixed_size;
>> +	} else {
>> +		reg_bar_size = ALIGN(reg_size, max(epc_features->align, 4096));
>> +	}
>> +
>> +	nvme_epf->reg_bar = pci_epf_alloc_space(epf, reg_bar_size, BAR_0,
>> +						epc_features, PRIMARY_INTERFACE);
>> +	if (!nvme_epf->reg_bar) {
>> +		dev_err(&epf->dev, "Failed to allocate BAR 0\n");
>> +		return -ENOMEM;
>> +	}
>> +	memset(nvme_epf->reg_bar, 0, reg_bar_size);
>> +
>> +	return 0;
>> +}
>> +
>> +static void nvmet_pci_epf_clear_bar(struct nvmet_pci_epf *nvme_epf)
>> +{
>> +	struct pci_epf *epf = nvme_epf->epf;
>> +
>> +	pci_epc_clear_bar(epf->epc, epf->func_no, epf->vfunc_no,
>> +			  &epf->bar[BAR_0]);
>> +	pci_epf_free_space(epf, nvme_epf->reg_bar, BAR_0, PRIMARY_INTERFACE);
>> +	nvme_epf->reg_bar = NULL;
> 
> Memory for BAR 0 is allocated in nvmet_pci_epf_bind(), but it is freed in both
> nvmet_pci_epf_epc_deinit() and nvmet_pci_epf_bind(). This will cause NULL ptr
> dereference if epc_deinit() gets called after nvmet_pci_epf_bind() and then
> epc_init() is called (we call epc_deinit() once PERST# is deasserted to cleanup
> the EPF for platforms requiring refclk from host).
> 
> So please move pci_epf_free_space() and 'nvme_epf->reg_bar = NULL' to a
> separate helper nvmet_pci_epf_free_bar() and call that only from
> nvmet_pci_epf_unbind() (outside of 'epc->init_complete' check).

I do not get PERST# on the RK3588... So I never noticed this.
Does this work for you ?

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 8db084f1b20b..4d2a66668e73 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -2170,14 +2170,23 @@ static int nvmet_pci_epf_configure_bar(struct
nvmet_pci_epf *nvme_epf)
        return 0;
 }

+static void nvmet_pci_epf_free_bar(struct nvmet_pci_epf *nvme_epf)
+{
+       struct pci_epf *epf = nvme_epf->epf;
+
+       if (!nvme_epf->reg_bar)
+               return;
+
+       pci_epf_free_space(epf, nvme_epf->reg_bar, BAR_0, PRIMARY_INTERFACE);
+       nvme_epf->reg_bar = NULL;
+}
+
 static void nvmet_pci_epf_clear_bar(struct nvmet_pci_epf *nvme_epf)
 {
        struct pci_epf *epf = nvme_epf->epf;

        pci_epc_clear_bar(epf->epc, epf->func_no, epf->vfunc_no,
                          &epf->bar[BAR_0]);
-       pci_epf_free_space(epf, nvme_epf->reg_bar, BAR_0, PRIMARY_INTERFACE);
-       nvme_epf->reg_bar = NULL;
 }

 static int nvmet_pci_epf_init_irq(struct nvmet_pci_epf *nvme_epf)
@@ -2319,8 +2328,6 @@ static void nvmet_pci_epf_epc_deinit(struct pci_epf *epf)

        nvmet_pci_epf_deinit_dma(nvme_epf);
        nvmet_pci_epf_clear_bar(nvme_epf);
-
-       mutex_destroy(&nvme_epf->mmio_lock);
 }

 static int nvmet_pci_epf_link_up(struct pci_epf *epf)
@@ -2390,8 +2397,9 @@ static void nvmet_pci_epf_unbind(struct pci_epf *epf)
        if (epc->init_complete) {
                nvmet_pci_epf_deinit_dma(nvme_epf);
                nvmet_pci_epf_clear_bar(nvme_epf);
-               mutex_destroy(&nvme_epf->mmio_lock);
        }
+
+       nvmet_pci_epf_free_bar(nvme_epf);
 }

 static struct pci_epf_header nvme_epf_pci_header = {

> With the above change, I'm able to get this EPF driver working on my Qcom RC/EP
> setup.

With the above, does it work for you ?

Thanks for testing.

-- 
Damien Le Moal
Western Digital Research


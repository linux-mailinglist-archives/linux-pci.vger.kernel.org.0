Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C855C21C093
	for <lists+linux-pci@lfdr.de>; Sat, 11 Jul 2020 01:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgGJXJR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jul 2020 19:09:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:60188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726645AbgGJXJQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Jul 2020 19:09:16 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF7D4205CB;
        Fri, 10 Jul 2020 23:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594422555;
        bh=5kD2khx2eqRV4V2CjqspZjzyl62vb2tRCBkGFLVzUM8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=giSg9Q91lI/e7G7d3BlBgDXXRE6fwO2g772hZtXTVzH8G6tIa62iXyDgu0wUHbMiu
         CKWuaz97db1IVBqp4AvbAvzl16qA2Ygv2hxc+dQSOBzs8lRK0B+1Fsj6KtkYqpw5ye
         oCuEn4Swpi+MdCDKjZ9k0BL23S8ZwLLLRfxtNg1c=
Date:   Fri, 10 Jul 2020 18:09:13 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        linux-pci@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [RFC PATCH] hwtracing: Add HiSilicon PCIe Tune and Trace device
 driver
Message-ID: <20200710230913.GA90375@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592040733-32329-1-git-send-email-yangyicong@hisilicon.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jun 13, 2020 at 05:32:13PM +0800, Yicong Yang wrote:
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

Add a space before "(".  Many occurrences above and below, too.

s/inpendent/independent/

What does "TLP headers to the memory" mean?  TLPs can go either
upstream (i.e., device DMA to system memory) or downstream (i.e., CPU
MMIO writes to device).  It sounds like maybe you can trace only the
upstream ones heading toward system memory?

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

I guess this means each PTT can tune/trace all the Root Ports in the
same PCIe core?

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

All of these look like things that have the potential to break the
PCIe protocol and cause errors like timeouts, receiver overflows, etc.
That's OK for a debug/analysis situation, but it should taint the
kernel somehow because I don't want to debug problems like that if
they're caused by users tweaking things.

That might even be a reason *not* to merge the tune side of this.  I
can see how it might be useful for you internally, but it's not
obvious to me how it will benefit other users.  Maybe that part should
be an out-of-tree module?

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

This part looks really neat.  I often wish we had something like this
because some things are impossible to debug without a PCIe analyzer,
and those are hard to come by.

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

s/sequetially/sequentially/  Maybe just run a spell checker on the
whole file.

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

I don't know anything about the hwtracing infrastructure, so just
random minor style comments below.

> +	/* reset the DMA before start tracing */

Some of your comments start with a capital letter, others with a
lower-case.  It'd be nice to make them all the same.

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

Could do something like

  pre = (func == hisi_ptt->target_func) ? "[" : "";
  post = (func == hisi_ptt->target_func) ? "]" : "";
  seq_printf(m, "%s%04x...%s\n", pre, pci_domain_nr(...), ..., post);

> +	devfn = PCI_DEVFN(dev, fn);
> +	list_for_each_entry(tfunc, &hisi_ptt->avail_devfns, list) {
> +		struct pci_dev *pdev = tfunc->pdev;
> +
> +		if (domain == pci_domain_nr(pdev->bus) &&
> +		    bus == pdev->bus->number && devfn == pdev->devfn) {
> +			hisi_ptt->target_func = tfunc;
> +			found = true;

Just "return count" here.

> +			break;
> +		}
> +	}
> +
> +	if (!found)
> +		return -EINVAL;

Then this is just "return -EINVAL" and "found" isn't needed at all.

> +
> +	return count;
> +}

> +	for (i = 0; i < ARRAY_SIZE(trace_events); ++i) {
> +		if (!strcmp(tbuf, trace_events[i].name)) {
> +			hisi_ptt->trace_ctrl.tr_event = trace_events[i].event_code;
> +			set = true;
> +			break;

"return count" as above.

> +		}
> +	}
> +
> +	if (!set)
> +		return -EINVAL;

"return -EINVAL", get rid of "set".
> +
> +	return count;
> +}

> +	for (i = 0; i < ARRAY_SIZE(available_buflet_size); ++i) {
> +		if (ctrl->buflet_size == available_buflet_size[i]) {
> +			seq_printf(m, "[%dMiB]  ",
> +				   available_buflet_size[i] >> 20);
> +			continue;
> +		}
> +		seq_printf(m, "%dMiB  ", available_buflet_size[i] >> 20);

This is a different pattern than the "if/else" you use above.  Pick
one so they aren't unnecessarily different.

> +	}

> +	for (i = 0; i < ARRAY_SIZE(available_buflet_size); ++i) {
> +		if (available_buflet_size[i] == size) {
> +			ctrl->buflet_size = size;
> +			set = 1;
> +			break;

"return count", etc. as above.

> +		}
> +	}
> +
> +	if (!set)
> +		return -EINVAL;
> +
> +	return count;
> +}

> +irqreturn_t hisi_ptt_isr(int irq, void *context)

Can this be static?

> +{
> +	struct hisi_ptt *hisi_ptt = context;
> +	struct dma_buflet *next, *cur;
> +	u32 val, buf_idx;
> +
> +	val = readl(hisi_ptt->iobase + HISI_PTT_TRACE_INT_STAT);
> +	buf_idx = __ffs(val & HISI_PTT_TRACE_INT_STAT_MASK);

Usual style would have a blank line here.

> +	/*
> +	 * Check whether the trace buffer is full. Stop tracing
> +	 * when the last DMA buffer is finished. Otherwise, assign
> +	 * the address of next buflet to the DMA register.
> +	 */

> +irqreturn_t hisi_ptt_irq(int irq, void *context)

Static?

> +static void hisi_ptt_init_ctrls(struct hisi_ptt *hisi_ptt)
> +{
> +	struct pci_dev *pdev = hisi_ptt->pdev, *tpdev;
> +	struct pci_bus *child_bus;
> +	unsigned long port_mask, bit;
> +
> +	hisi_ptt->domain = pci_domain_nr(pdev->bus);
> +	hisi_ptt->bus = pdev->bus->number;

Blank line here?

> +	/*
> +	 * The mailbox register provides the information about the
> +	 * root ports which the RCiEP can control and monitor.
> +	 */

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

Hmmm.  Not thrilled with another use of pci_get_domain_bus_and_slot().
I think that interface is problematic in general.  I guess there's at
least no hotplug possible here, since you're looking for Root Ports,
right?  So maybe in this restricted case it's ok.

> +		/*
> +		 * If the root port is not existed in the system,
> +		 * just skip it and check next one.

s/is not existed/does not exist/

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

*This* looks like a potential problem with hotplug.  How do you deal
with devices being added/removed after this loop?

> +			func = devm_kmalloc(&pdev->dev, sizeof(*func),
> +					    GFP_KERNEL);
> +			if (!func)
> +				continue;
> +			func->pdev = tpdev;
> +			list_add_tail(&func->list, &hisi_ptt->avail_devfns);
> +		}
> +	}

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

Blank line?

> +	/*
> +	 * Lifetime of pci_dev is longer than hisi_ptt,
> +	 * so directly reference to the pci name string.
> +	 */
> +	hisi_ptt->name = pci_name(pdev);
> +	pci_set_drvdata(pdev, hisi_ptt);

> +static pci_ers_result_t hisi_ptt_err_detected(struct pci_dev *pdev,
> +						pci_channel_state_t state)
> +{
> +	/* The PTT device doesn't support error recovery */
> +	return PCI_ERS_RESULT_RECOVERED;
> +}

Why do you have this at all?  Can't you just omit the .err_handler
pointer below?

> +static const struct pci_error_handlers hisi_ptt_err_handler = {
> +	.error_detected = hisi_ptt_err_detected,
> +};
> +
> +#define PCI_DEVICE_ID_HISI_PTT 0xa250

I think these single-use #defines are sort of falling out of favor,
since they don't really add any information.

> +static const struct pci_device_id hisi_ptt_id_tbl[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HISI_PTT) },
> +	{ 0, }

The "0," part is unnecessary.

> +};
> +
> +static struct pci_driver hisi_ptt_driver = {
> +	.name = "hisi_ptt",
> +	.id_table = hisi_ptt_id_tbl,
> +	.probe = hisi_ptt_probe,
> +	.remove = hisi_ptt_remove,
> +	.err_handler = &hisi_ptt_err_handler,
> +};

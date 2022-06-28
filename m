Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8480955E64D
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 18:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345249AbiF1OQe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 10:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiF1OQe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 10:16:34 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862C42EA10;
        Tue, 28 Jun 2022 07:16:31 -0700 (PDT)
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LXRTF6Y9Dz689t8;
        Tue, 28 Jun 2022 22:15:45 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 28 Jun 2022 16:16:28 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 28 Jun
 2022 15:16:27 +0100
Date:   Tue, 28 Jun 2022 15:16:26 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Li, Ming" <ming4.li@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V12 3/9] PCI: Create PCIe library functions in support
 of DOE mailboxes.
Message-ID: <20220628151626.00001c0f@Huawei.com>
In-Reply-To: <20220628041527.742333-4-ira.weiny@intel.com>
References: <20220628041527.742333-1-ira.weiny@intel.com>
        <20220628041527.742333-4-ira.weiny@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 27 Jun 2022 21:15:21 -0700
ira.weiny@intel.com wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Introduced in a PCIe r6.0, sec 6.30, DOE provides a config space based
> mailbox with standard protocol discovery.  Each mailbox is accessed
> through a DOE Extended Capability.
> 
> Each DOE mailbox must support the DOE discovery protocol in addition to
> any number of additional protocols.
> 
> Define core PCIe functionality to manage a single PCIe DOE mailbox at a
> defined config space offset.  Functionality includes iterating,
> creating, query of supported protocol, and task submission.  Destruction
> of the mailboxes is device managed.
> 
> If interrupts are desired, the interrupt number can be queried and
> passed to the create function.  Passing a negative value disables
> interrupts for that mailbox.  It is the caller's responsibility to ensure
> enough interrupt vectors are allocated.
> 
> Cc: "Li, Ming" <ming4.li@intel.com>
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
Hi Ira,

Thanks for keeping at this!

I think this has reintroduced some of the races around that annoying
interrupt source form BUSY transitioning to low that has
no explicit 'cause' flag.  I think we'd hammered all those out in the
previous version but maybe there were still some there...

I 'think' it will work as is, but depending on the timing a given DOE
implementation has, the interrupt may be completely pointless as it
will be signaling the wrong event.

Jonathan

> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 0da6b1ebc694..2680e4c92f0a 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -31,6 +31,7 @@ obj-$(CONFIG_PCI_ECAM)		+= ecam.o
>  obj-$(CONFIG_PCI_P2PDMA)	+= p2pdma.o
>  obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
>  obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
> +obj-$(CONFIG_PCI_DOE)		+= doe.o
>  
>  # Endpoint library must be initialized before its users
>  obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> new file mode 100644
> index 000000000000..4a7a1e988124
> --- /dev/null
> +++ b/drivers/pci/doe.c


> +/**
> + * struct pci_doe_mb - State for a single DOE mailbox
> + *
> + * This state is used to manage a single DOE mailbox capability.  All fields
> + * should be considered opaque to the consumers and the structure passed into
> + * the helpers below after being created by devm_pci_doe_create()
> + *
> + * @pdev: PCI device this mailbox belongs to
> + * @cap_offset: Capability offset
> + * @int_msg_num: DOE Interrupt Message Number; negative if irqs are not used
> + * @prots: Array of protocols supported (encoded as long values)
> + * @wq: Wait queue for work items awaiting irq/abort
> + * @work_queue: Queue of pci_doe_work items
> + * @flags: Bit array of PCI_DOE_FLAG_* flags
> + *
> + * Note: @prots can't be allocated with struct size because the number of
> + * protocols is not known until after this structure is in use.  However, the
> + * single discovery protocol is always required to query for the number of
> + * protocols.
> + */
> +struct pci_doe_mb {
> +	struct pci_dev *pdev;
> +	u16 cap_offset;
> +	int int_msg_num;
> +	struct xarray prots;
> +
> +	wait_queue_head_t wq;
> +	struct workqueue_struct *work_queue;
> +	unsigned long flags;
> +};
> +
> +static irqreturn_t pci_doe_irq_handler(int irq, void *data)
> +{
> +	struct pci_doe_mb *doe_mb = data;
> +	struct pci_dev *pdev = doe_mb->pdev;
> +	int offset = doe_mb->cap_offset;
> +	u32 val;
> +
> +	pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
> +	if (FIELD_GET(PCI_DOE_STATUS_INT_STATUS, val)) {
> +		pci_write_config_dword(pdev, offset + PCI_DOE_STATUS,
> +					PCI_DOE_STATUS_INT_STATUS);
> +		set_bit(PCI_DOE_FLAG_IRQ, &doe_mb->flags);
> +		wake_up(&doe_mb->wq);
> +		return IRQ_HANDLED;
> +	}
> +
> +	return IRQ_NONE;
> +}
> +

> +/*
> + * Returned from the wait functions to indicate that an abort has been issued
> + */
> +#define DOE_WAIT_ABORT 1
> +
> +static int pci_doe_arm_wait(struct pci_doe_mb *doe_mb)

Feels like there should be a naming to convey the return value as
a boolean rather than pushing through a flag value.

> +{
> +	if (test_and_clear_bit(PCI_DOE_FLAG_ABORT, &doe_mb->flags))
> +		return DOE_WAIT_ABORT;
> +	clear_bit(PCI_DOE_FLAG_IRQ, &doe_mb->flags);
> +	return 0;
> +}
> +

> +static void pci_doe_write_ctrl(struct pci_doe_mb *doe_mb, u32 val)
> +{
> +	struct pci_dev *pdev = doe_mb->pdev;
> +	int offset = doe_mb->cap_offset;
> +
> +	if (pci_doe_irq_enabled(doe_mb))
> +		val |= PCI_DOE_CTRL_INT_EN;
> +	pci_write_config_dword(pdev, offset + PCI_DOE_CTRL, val);
> +}
> +
> +static int pci_doe_issue_abort(struct pci_doe_mb *doe_mb)
Can we rename this as it does more than simply issue the abort,
it waits for it to finish

> +{
> +	struct pci_dev *pdev = doe_mb->pdev;
> +	int offset = doe_mb->cap_offset;
> +	unsigned long timeout_jiffies;
> +
> +	pci_dbg(pdev, "[%x] Issuing Abort\n", offset);
> +
> +	/*
> +	 * Abort detected while aborting; something is really broken or the
> +	 * mailbox is being destroyed.
> +	 */
> +	if (pci_doe_arm_wait(doe_mb))
> +		return -EIO;
> +
> +	timeout_jiffies = jiffies + PCI_DOE_TIMEOUT;
> +	pci_doe_write_ctrl(doe_mb, PCI_DOE_CTRL_ABORT);
> +
> +	do {
> +		u32 val;
> +
> +		/*
> +		 * Abort detected while aborting; something is really broken or
> +		 * the mailbox is being destroyed.
> +		 */
> +		if (pci_doe_wait_irq_or_poll(doe_mb))
> +			return -EIO;
> +		pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
> +
> +		/* Abort success! */
> +		if (!FIELD_GET(PCI_DOE_STATUS_ERROR, val) &&
> +		    !FIELD_GET(PCI_DOE_STATUS_BUSY, val))
> +			return 0;
> +
> +	} while (!time_after(jiffies, timeout_jiffies));
> +
> +	/* Abort has timed out and the MB is dead */
> +	pci_err(pdev, "[%x] ABORT timed out\n", offset);

Does this print mention it's a DOE somewhere? 

> +	return -EIO;
> +}
> +

...

> +static int pci_doe_recv_resp(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
> +{
> +	struct pci_dev *pdev = doe_mb->pdev;
> +	int offset = doe_mb->cap_offset;
> +	size_t length, payload_length;
> +	u32 val;
> +	int i;
> +
> +	/* Read the first dword to get the protocol */
> +	pci_read_config_dword(pdev, offset + PCI_DOE_READ, &val);
> +	if ((FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_VID, val) != task->prot.vid) ||
> +	    (FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, val) != task->prot.type)) {
> +		pci_err(pdev,
> +			"[%x] expected [VID, Protocol] = [%04x, %02x], got [%04x, %02x]\n",
> +			doe_mb->cap_offset,
> +			task->prot.vid, task->prot.type,
> +			FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_VID, val),
> +			FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, val));
> +		return -EIO;
> +	}
> +
> +	pci_write_config_dword(pdev, offset + PCI_DOE_READ, 0);
> +	/* Read the second dword to get the length */
> +	pci_read_config_dword(pdev, offset + PCI_DOE_READ, &val);
> +	pci_write_config_dword(pdev, offset + PCI_DOE_READ, 0);
> +
> +	length = FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH, val);
> +	if (length > SZ_1M || length < 2)
> +		return -EIO;
> +
> +	/* First 2 dwords have already been read */
> +	length -= 2;
> +	payload_length = min(length, task->response_pl_sz / sizeof(u32));
> +	/* Read the rest of the response payload */
> +	for (i = 0; i < payload_length; i++) {
> +		pci_read_config_dword(pdev, offset + PCI_DOE_READ,
> +				      &task->response_pl[i]);
> +		/* Prior to the last ack, ensure Data Object Ready */
> +		if (i == (payload_length-1) && !pci_doe_data_obj_ready(doe_mb))

spaces around - 

> +			return -EIO;
> +		pci_write_config_dword(pdev, offset + PCI_DOE_READ, 0);
> +	}
> +
> +	/* Flush excess length */
> +	for (; i < length; i++) {
> +		pci_read_config_dword(pdev, offset + PCI_DOE_READ, &val);
> +		pci_write_config_dword(pdev, offset + PCI_DOE_READ, 0);
> +	}
> +
> +	/* Final error check to pick up on any since Data Object Ready */
> +	pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
> +	if (FIELD_GET(PCI_DOE_STATUS_ERROR, val))
> +		return -EIO;
> +
> +	return min(length, task->response_pl_sz / sizeof(u32)) * sizeof(u32);
> +}
> +

> +
> +static void doe_statemachine_work(struct work_struct *work)
> +{
> +	struct pci_doe_task *task = container_of(work, struct pci_doe_task,
> +						 work);
> +	struct pci_doe_mb *doe_mb = task->doe_mb;
> +	struct pci_dev *pdev = doe_mb->pdev;
> +	int offset = doe_mb->cap_offset;
> +	unsigned int busy_retries = 0;
> +	unsigned long timeout_jiffies;
> +	u32 val;
> +	int rc;
> +
> +	if (test_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags)) {
> +		signal_task_complete(task, -EIO);
> +		return;
> +	}
> +
> +	/* Send request */
> +retry_req:
> +	if (pci_doe_arm_wait(doe_mb)) {
> +		signal_task_abort(task, -EIO);
> +		return;
> +	}

Is there a race here?  If Busy drops at this point we queue up
a message, but IRQ bit is already set.  Hence when we hit
wait_event_timeout() the flag is already set and IIRC we'll
drop straight through.

It'll probably be fine because it will end up polling below
but doesn't look ideal.

Upshot is that you sort of have to handle "spurious interrupts"
cleanly and rewait on the interrupt if you get one whilst also handling
race conditions around RW1C of the interrupt status flag.


> +
> +	rc = pci_doe_send_req(doe_mb, task);
> +
> +	/*
> +	 * The specification does not provide any guidance on how long
> +	 * some other entity could keep the DOE busy, so try for 1
> +	 * second then fail. Busy handling is best effort only, because
> +	 * there is no way of avoiding racing against another user of
> +	 * the DOE.
> +	 */
> +	if (rc == -EBUSY) {
> +		busy_retries++;
> +		if (busy_retries == PCI_DOE_BUSY_MAX_RETRIES) {
> +			pci_warn(pdev,
> +				"[%x] busy for too long (> 1 sec)\n",
> +				offset);
> +			signal_task_complete(task, rc);
> +			return;
> +		}
> +		if (pci_doe_wait_poll(doe_mb, HZ / PCI_DOE_BUSY_MAX_RETRIES)) {
> +			signal_task_abort(task, rc);
> +			return;
> +		}
> +		goto retry_req;
> +	} else if (rc) {
> +		signal_task_abort(task, rc);
> +		return;
> +	}
> +
> +	timeout_jiffies = jiffies + HZ;
> +	if (pci_doe_wait_irq_or_poll(doe_mb)) {

So this may well be passed as a result of a BUSY transition to 0 very soon
after the doe_send_req but well before the data is ready....


> +		signal_task_abort(task, -EIO);
> +		return;
> +	}
> +
> +	/* Poll for response */
> +retry_resp:
> +	if (pci_doe_arm_wait(doe_mb)) {
I think we can get here between Busy drop and Object Ready which means
this can get another IRQ_FLAG setting just after it.  Does it matter?
Don't think so, as we don't use that bit again in this run through
and it will be cleared at beginning of next one, but if so why is
this call here?  I think it's only useful for detecting an abort, if
so do that explicitly. 

> +		signal_task_abort(task, -EIO);
> +		return;
> +	}
> +
> +	pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
> +	if (FIELD_GET(PCI_DOE_STATUS_ERROR, val)) {
> +		signal_task_abort(task, -EIO);
> +		return;
> +	}
> +
> +	if (!FIELD_GET(PCI_DOE_STATUS_DATA_OBJECT_READY, val)) {
> +		if (time_after(jiffies, timeout_jiffies)) {
> +			signal_task_abort(task, -ETIMEDOUT);
> +			return;
> +		}
> +		if (pci_doe_wait_poll(doe_mb, PCI_DOE_POLL_INTERVAL)) {

Following on from above....
As a result of the interrupt having fired on the BUSY off transition,
I think we will almost always end up spinning here until Object Ready
is set.  Fine, but seems a shame we don't let an interrupt do this
for us in most cases.  (note in QEMU response is instantaneous so
when the interrupt for Busy drop is set, object ready also true so
by the time we get here data ready will already be sent).

> +			signal_task_abort(task, -EIO);
> +			return;
> +		}
> +		goto retry_resp;
> +	}
> +
> +	rc  = pci_doe_recv_resp(doe_mb, task);
> +	if (rc < 0) {
> +		signal_task_abort(task, rc);
> +		return;
> +	}
> +
> +	signal_task_complete(task, rc);
> +}
> +


> +static void pci_doe_free_mb(struct pci_doe_mb *doe_mb)
> +{
> +	if (doe_mb->work_queue)

I'm not a great fan of free functions that check a bunch of conditions
because they may be called before things are set up.  To my
mind that generally means we should be calling individual cleanup
in the appropriate error handlers.

Either that or just use devm handling for each item. Sure
it's a few more lines of code, but I find it a lot easier to go

Oh look that thing we just set up is cleaned up by this.


> +		destroy_workqueue(doe_mb->work_queue);
> +	if (pci_doe_irq_enabled(doe_mb))
> +		pci_free_irq(doe_mb->pdev, doe_mb->int_msg_num, doe_mb);
> +	xa_destroy(&doe_mb->prots);
> +	kfree(doe_mb);
> +}
> +

...

> +
> +static void pci_doe_destroy_mb(void *mb)
> +{
> +	struct pci_doe_mb *doe_mb = mb;
> +
> +	/* Mark going down */
> +	set_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags);
> +
> +	/* Abort any in progress work items */
> +	pci_doe_abort(doe_mb);

Abort is getting used for two things in here. Perhaps
rename this one to 
pci_doe_abort_tasks() or something like that?

> +
> +	/* Flush remaining work items */
> +	flush_workqueue(doe_mb->work_queue);
> +
> +	pci_doe_free_mb(doe_mb);
> +}
> +
> +/**
> + * pcim_doe_create_mb() - Create a DOE mailbox object
> + *
> + * @pdev: PCI device to create the DOE mailbox for
> + * @cap_offset: Offset of the DOE mailbox
> + * @int_msg_num: Interrupt message number to use; a negative value means don't
> + *		 use interrupts
> + *
> + * Create a single mailbox object to manage the mailbox protocol at the
> + * cap_offset specified.
> + *
> + * Caller should allocate PCI IRQ vectors before passing a possitive value for

positive

> + * int_msg_num.
> + *
> + * RETURNS: created mailbox object on success
> + *	    ERR_PTR(-errno) on failure
> + */
> +struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset,
> +				      int int_msg_num)
> +{
> +	struct pci_doe_mb *doe_mb;
> +	int rc;
> +
> +	doe_mb = kzalloc(sizeof(*doe_mb), GFP_KERNEL);
> +	if (!doe_mb)
> +		return ERR_PTR(-ENOMEM);
> +
> +	doe_mb->pdev = pdev;
> +	doe_mb->int_msg_num = -1;
> +	doe_mb->cap_offset = cap_offset;
> +
> +	xa_init(&doe_mb->prots);
> +	init_waitqueue_head(&doe_mb->wq);
> +
> +	if (int_msg_num >= 0) {
> +		rc = pci_doe_enable_irq(doe_mb, int_msg_num);
> +		if (rc)
> +			pci_err(pdev,
> +				"[%x] enable requested IRQ (%d) failed : %d\n",
> +				doe_mb->cap_offset, int_msg_num, rc);

If we are printing an error, I'd argue we should not continue.
Or at very least we should a comment here to say why we should do so...


> +	}
> +
> +	doe_mb->work_queue = alloc_ordered_workqueue("DOE: [%x]", 0,
> +						     doe_mb->cap_offset);
> +	if (!doe_mb->work_queue) {
> +		pci_err(pdev, "[%x] failed to allocate work queue\n",
> +			doe_mb->cap_offset);
> +		pci_doe_free_mb(doe_mb);

As above, I'd rather this explicitly freed what has been set up
and only that rather than calling a free function that does a bunch of
stuff conditionally.


> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	/* Reset the mailbox by issuing an abort */
> +	rc = pci_doe_issue_abort(doe_mb);
> +	if (rc) {
> +		pci_err(pdev, "[%x] failed to reset : %d\n",
> +			doe_mb->cap_offset, rc);
> +		pci_doe_free_mb(doe_mb);
> +		return ERR_PTR(rc);
> +	}
> +
> +	if (devm_add_action_or_reset(&pdev->dev, pci_doe_destroy_mb, doe_mb))
> +		return ERR_PTR(-EIO);
> +
> +	rc = pci_doe_cache_protocols(doe_mb);
> +	if (rc) {
> +		pci_err(pdev, "[%x] failed to cache protocols : %d\n",
> +			doe_mb->cap_offset, rc);
> +		return ERR_PTR(rc);
> +	}
> +
> +	return doe_mb;
> +}
> +EXPORT_SYMBOL_GPL(pcim_doe_create_mb);
> +




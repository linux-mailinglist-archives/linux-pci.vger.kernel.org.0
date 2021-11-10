Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D427E44BB60
	for <lists+linux-pci@lfdr.de>; Wed, 10 Nov 2021 06:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbhKJFs3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Nov 2021 00:48:29 -0500
Received: from mga03.intel.com ([134.134.136.65]:24017 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229485AbhKJFs2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Nov 2021 00:48:28 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10163"; a="232553516"
X-IronPort-AV: E=Sophos;i="5.87,222,1631602800"; 
   d="scan'208";a="232553516"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 21:45:41 -0800
X-IronPort-AV: E=Sophos;i="5.87,222,1631602800"; 
   d="scan'208";a="452188232"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 21:45:41 -0800
Date:   Tue, 9 Nov 2021 21:45:41 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/5] PCI/DOE: Add Data Object Exchange Aux Driver
Message-ID: <20211110054541.GI3538886@iweiny-DESK2.sc.intel.com>
References: <20211105235056.3711389-1-ira.weiny@intel.com>
 <20211105235056.3711389-3-ira.weiny@intel.com>
 <20211108121546.000034b2@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108121546.000034b2@Huawei.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 08, 2021 at 12:15:46PM +0000, Jonathan Cameron wrote:
> On Fri, 5 Nov 2021 16:50:53 -0700
> <ira.weiny@intel.com> wrote:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Introduced in a PCI ECN [1], DOE provides a config space based mailbox
> > with standard protocol discovery.  Each mailbox is accessed through a
> > DOE Extended Capability.
> > 
> > Define an auxiliary device driver which control DOE auxiliary devices
> > registered on the auxiliary bus.
> > 
> > A DOE mailbox is allowed to support any number of protocols while some
> > DOE protocol specifications apply additional restrictions.
> > 
> > The protocols supported are queried and cached.  pci_doe_supports_prot()
> > can be used to determine if the DOE device supports the protocol
> > specified.
> > 
> > A synchronous interface is provided in pci_doe_exchange_sync() to
> > perform a single query / response exchange from the driver through the
> > device specified.
> > 
> > Testing was conducted against QEMU using:
> > 
> > https://lore.kernel.org/qemu-devel/1619454964-10190-1-git-send-email-cbrowy@avery-design.com/
> > 
> > This code is based on Jonathan's V4 series here:
> > 
> > https://lore.kernel.org/linux-cxl/20210524133938.2815206-1-Jonathan.Cameron@huawei.com/
> > 
> > [1] https://members.pcisig.com/wg/PCI-SIG/document/14143
> >     Data Object Exchange (DOE) - Approved 12 March 2020
> > 
> > Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Hi Ira,
> 
> Thanks for taking this on!

NP I'm just sorry I'm so slow to get it moving.

> 
> I'm sure at least half the comments below are about things I wrote
> then forgot about. I'm not sure if it's a good thing but I've ignored
> this for long enough I'm almost reviewing it as fresh code :(
> 
> I was carrying a local patch for the interrupt handler having 
> figured out I'd missread the spec.   Note that I've since concluded
> my local patch has it's own issues (it was unnecessarily complex)
> so I've made some suggestions below that I'm fairly sure
> fix things up.  Note these paths are hard to test and require adding
> some fiddly state machines to QEMU to open up race windows...
> 
> > 
> > ---
> > Changes from Jonathan's V4
> > 	Move the DOE MB code into the DOE auxiliary driver
> > 	Remove Task List in favor of a wait queue
> > 
> > Changes from Ben
> > 	remove CXL references
> > 	propagate rc from pci functions on error
> 
> ...
> 
> 
> > diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> > new file mode 100644
> > index 000000000000..2e702fdc7879
> > --- /dev/null
> > +++ b/drivers/pci/doe.c
> > @@ -0,0 +1,701 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Data Object Exchange ECN
> > + * https://members.pcisig.com/wg/PCI-SIG/document/14143
> > + *
> > + * Copyright (C) 2021 Huawei
> > + *     Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/delay.h>
> > +#include <linux/jiffies.h>
> > +#include <linux/list.h>
> > +#include <linux/mutex.h>
> > +#include <linux/pci.h>
> > +#include <linux/pci-doe.h>
> > +#include <linux/workqueue.h>
> > +#include <linux/module.h>
> > +
> > +#define PCI_DOE_PROTOCOL_DISCOVERY 0
> > +
> > +#define PCI_DOE_BUSY_MAX_RETRIES 16
> > +#define PCI_DOE_POLL_INTERVAL (HZ / 128)
> > +
> > +/* Timeout of 1 second from 6.xx.1 (Operation), ECN - Data Object Exchange */
> > +#define PCI_DOE_TIMEOUT HZ
> > +
> > +enum pci_doe_state {
> > +	DOE_IDLE,
> > +	DOE_WAIT_RESP,
> > +	DOE_WAIT_ABORT,
> > +	DOE_WAIT_ABORT_ON_ERR,
> > +};
> > +
> > +/*
> 
> /**
> 
> Given it's in kernel-doc syntax, we might as well mark it as such.

Yep done.

> 
> > + * struct pci_doe_task - description of a query / response task
> > + * @ex: The details of the task to be done
> > + * @rv: Return value.  Length of received response or error
> > + * @cb: Callback for completion of task
> > + * @private: Private data passed to callback on completion
> > + */
> > +struct pci_doe_task {
> > +	struct pci_doe_exchange *ex;
> > +	int rv;
> > +	void (*cb)(void *private);
> > +	void *private;
> > +};
> > +
> > +/**
> > + * struct pci_doe - A single DOE mailbox driver
> > + *
> > + * @doe_dev: The DOE Auxiliary device being driven
> > + * @abort_c: Completion used for initial abort handling
> > + * @irq: Interrupt used for signaling DOE ready or abort
> > + * @irq_name: Name used to identify the irq for a particular DOE
> > + * @prots: Array of identifiers for protocols supported
> > + * @num_prots: Size of prots array
> > + * @cur_task: Current task the state machine is working on
> > + * @wq: Wait queue to wait on if a query is in progress
> > + * @state_lock: Protect the state of cur_task, abort, and dead
> > + * @statemachine: Work item for the DOE state machine
> > + * @state: Current state of this DOE
> > + * @timeout_jiffies: 1 second after GO set
> > + * @busy_retries: Count of retry attempts
> > + * @abort: Request a manual abort (e.g. on init)
> > + * @dead: Used to mark a DOE for which an ABORT has timed out. Further messages
> > + *        will immediately be aborted with error
> > + */
> > +struct pci_doe {
> > +	struct pci_doe_dev *doe_dev;
> > +	struct completion abort_c;
> > +	int irq;
> > +	char *irq_name;
> > +	struct pci_doe_protocol *prots;
> > +	int num_prots;
> > +
> > +	struct pci_doe_task *cur_task;
> > +	wait_queue_head_t wq;
> > +	struct mutex state_lock;
> > +	struct delayed_work statemachine;
> > +	enum pci_doe_state state;
> > +	unsigned long timeout_jiffies;
> > +	unsigned int busy_retries;
> > +	unsigned int abort:1;
> > +	unsigned int dead:1;
> > +};
> > +
> > +static irqreturn_t pci_doe_irq(int irq, void *data)
> 
> I was carrying a rework of this locally because I managed
> to convince myself this is wrong.  It's been a while and naturally
> I didn't write a comprehensive set of notes on why it was wrong...
> (Note you can't trigger the problem paths in QEMU without some
> nasty hacks as it relies on opening up race windows that make
> limited sense for the QEMU implementation).
> 
> It's all centered on some details of exactly what causes an interrupt
> on a DOE.  Section 6.xx.3 Interrupt Generation states:
> 
> If enabled, an interrupt message must be triggered every time the
> logical AND of the following conditions transitions from FALSE to TRUE:
> 
> * The associated vector is unmasked ...
> * The value of the DOE interrupt enable bit is 1b
> * The value of the DOE interrupt status bit is 1b
> (only last one really maters to us I think).
> 
> The interrupt status bit is an OR conditional.
> 
> Must be set.. Data Object Read bit or DOE error bit set or DOE busy bit cleared.
> 
> > +{
> > +	struct pci_doe *doe = data;
> > +	struct pci_dev *pdev = doe->doe_dev->pdev;
> > +	int offset = doe->doe_dev->cap_offset;
> > +	u32 val;
> > +
> > +	pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
> > +	if (FIELD_GET(PCI_DOE_STATUS_INT_STATUS, val)) {
> 
> So this bit is set on any of: BUSY dropped, READY or ERROR.
> If it's set on BUSY drop, but then in between the read above and this clear
> READY becomes true, then my reading is that we will not get another interrupt.
> That is fine because we will read it again in the state machine and see the
> new state. We could do more of the dance in the interrupt controller by doing
> a reread after clear of INT_STATUS but I think it's cleaner to leave
> it in the state machine.
> 
> It might look nicer here to only write BIT(1) - RW1C, but that doesn't matter as
> all the rest of the register is RO.
> 
> > +		pci_write_config_dword(pdev, offset + PCI_DOE_STATUS, val);
> > +		mod_delayed_work(system_wq, &doe->statemachine, 0);
> > +		return IRQ_HANDLED;
> > +	}
> > +	/* Leave the error case to be handled outside IRQ */
> > +	if (FIELD_GET(PCI_DOE_STATUS_ERROR, val)) {
> 
> I don't think we can get here because int status already true.
> So should do this before the above general check to avoid clearning
> the interrupt (we don't want more interrupts during the abort though
> I'd hope the hardware wouldn't generate them).
> 
> So move this before the previous check.
> 
> > +		mod_delayed_work(system_wq, &doe->statemachine, 0);
> > +		return IRQ_HANDLED;
> > +	}
> > +
> > +	/*
> > +	 * Busy being cleared can result in an interrupt, but as
> > +	 * the original Busy may not have been detected, there is no
> > +	 * way to separate such an interrupt from a spurious interrupt.
> > +	 */
> 
> This is misleading - as Busy bit clear would have resulted in INT_STATUS being true above
> (that was a misread of the spec from me in v4).
> So I don't think we can get here in any valid path.
> 
> return IRQ_NONE; should be safe.
> 
> 
> > +	return IRQ_HANDLED;
> > +}
> 
> Summary of above suggested changes:
> 1) Move the DOE_STATUS_ERROR block before the DOE_STATUS_INT_STATUS one
> 2) Possibly uses
>    pci_write_config_dword(pdev, offset + PCI_DOE_STATUS, PCI_DOE_STATUS_INT_STATUS);
>    to be explicit on the write one to clear bit.
> 3) IRQ_NONE for the final return path as I'm fairly sure there is no valid route to that.
>    

Done.

But just to ensure that I understand.  If STATUS_ERROR is indicated we are
basically not clearing the irq because we are resetting the mailbox?  Because
with this new code I don't see a pci_write_config_dword to clear INT_STATUS.

But if we are resetting the mailbox I think that is ok.

> ...
> 
> > +
> > +static void pci_doe_task_complete(void *private)
> > +{
> > +	complete(private);
> > +}
> 
> I wonder why this is up here? I'd move it down to just above the _sync()
> function where it's used. This one was definitely one of mine :)

Done.

> 
> > +
> > +static void doe_statemachine_work(struct work_struct *work)
> 
> I developed an interesting "relationship" with this state machine during
> the original development ;)  I've just walked the paths and convinced
> myself it works so all good.

Sweet!  :-D

> 
> > +{
> > +	struct delayed_work *w = to_delayed_work(work);
> > +	struct pci_doe *doe = container_of(w, struct pci_doe, statemachine);
> > +	struct pci_dev *pdev = doe->doe_dev->pdev;
> > +	int offset = doe->doe_dev->cap_offset;
> > +	struct pci_doe_task *task;
> > +	bool abort;
> > +	u32 val;
> > +	int rc;
> > +
> > +	mutex_lock(&doe->state_lock);
> > +	task = doe->cur_task;
> > +	abort = doe->abort;
> > +	doe->abort = false;
> > +	mutex_unlock(&doe->state_lock);
> > +
> > +	if (abort) {
> > +		/*
> > +		 * Currently only used during init - care needed if
> > +		 * pci_doe_abort() is generally exposed as it would impact
> > +		 * queries in flight.
> > +		 */
> > +		WARN_ON(task);
> > +		doe->state = DOE_WAIT_ABORT;
> > +		pci_doe_abort_start(doe);
> > +		return;
> > +	}
> > +
> > +	switch (doe->state) {
> > +	case DOE_IDLE:
> > +		if (task == NULL)
> > +			return;
> > +
> > +		/* Nothing currently in flight so queue a task */
> > +		rc = pci_doe_send_req(doe, task->ex);
> > +		/*
> > +		 * The specification does not provide any guidance on how long
> > +		 * some other entity could keep the DOE busy, so try for 1
> > +		 * second then fail. Busy handling is best effort only, because
> > +		 * there is no way of avoiding racing against another user of
> > +		 * the DOE.
> > +		 */
> > +		if (rc == -EBUSY) {
> > +			doe->busy_retries++;
> > +			if (doe->busy_retries == PCI_DOE_BUSY_MAX_RETRIES) {
> > +				/* Long enough, fail this request */
> > +				pci_WARN(pdev, true, "DOE busy for too long\n");
> > +				doe->busy_retries = 0;
> > +				goto err_busy;
> > +			}
> > +			schedule_delayed_work(w, HZ / PCI_DOE_BUSY_MAX_RETRIES);
> > +			return;
> > +		}
> > +		if (rc)
> > +			goto err_abort;
> > +		doe->busy_retries = 0;
> > +
> > +		doe->state = DOE_WAIT_RESP;
> > +		doe->timeout_jiffies = jiffies + HZ;
> > +		/* Now poll or wait for IRQ with timeout */
> > +		if (doe->irq > 0)
> > +			schedule_delayed_work(w, PCI_DOE_TIMEOUT);
> > +		else
> > +			schedule_delayed_work(w, PCI_DOE_POLL_INTERVAL);
> > +		return;
> > +
> > +	case DOE_WAIT_RESP:
> > +		/* Not possible to get here with NULL task */
> > +		pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
> > +		if (FIELD_GET(PCI_DOE_STATUS_ERROR, val)) {
> > +			rc = -EIO;
> > +			goto err_abort;
> > +		}
> > +
> > +		if (!FIELD_GET(PCI_DOE_STATUS_DATA_OBJECT_READY, val)) {
> > +			/* If not yet at timeout reschedule otherwise abort */
> > +			if (time_after(jiffies, doe->timeout_jiffies)) {
> > +				rc = -ETIMEDOUT;
> > +				goto err_abort;
> > +			}
> > +			schedule_delayed_work(w, PCI_DOE_POLL_INTERVAL);
> > +			return;
> > +		}
> > +
> > +		rc  = pci_doe_recv_resp(doe, task->ex);
> > +		if (rc < 0)
> > +			goto err_abort;
> > +
> > +		doe->state = DOE_IDLE;
> > +
> > +		mutex_lock(&doe->state_lock);
> > +		doe->cur_task = NULL;
> > +		mutex_unlock(&doe->state_lock);
> > +		wake_up_interruptible(&doe->wq);
> > +
> > +		/* Set the return value to the length of received payload */
> > +		task->rv = rc;
> > +		task->cb(task->private);
> > +
> > +		return;
> > +
> > +	case DOE_WAIT_ABORT:
> > +	case DOE_WAIT_ABORT_ON_ERR:
> > +		pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
> > +
> > +		if (!FIELD_GET(PCI_DOE_STATUS_ERROR, val) &&
> > +		    !FIELD_GET(PCI_DOE_STATUS_BUSY, val)) {
> > +			/* Back to normal state - carry on */
> > +			mutex_lock(&doe->state_lock);
> > +			doe->cur_task = NULL;
> > +			mutex_unlock(&doe->state_lock);
> > +			wake_up_interruptible(&doe->wq);
> > +
> > +			/*
> > +			 * For deliberately triggered abort, someone is
> > +			 * waiting.
> > +			 */
> > +			if (doe->state == DOE_WAIT_ABORT)
> > +				complete(&doe->abort_c);
> > +
> > +			doe->state = DOE_IDLE;
> > +			return;
> > +		}
> > +		if (time_after(jiffies, doe->timeout_jiffies)) {
> > +			/* Task has timed out and is dead - abort */
> > +			pci_err(pdev, "DOE ABORT timed out\n");
> > +			mutex_lock(&doe->state_lock);
> > +			doe->dead = true;
> > +			doe->cur_task = NULL;
> > +			mutex_unlock(&doe->state_lock);
> > +			wake_up_interruptible(&doe->wq);
> > +
> > +			if (doe->state == DOE_WAIT_ABORT)
> > +				complete(&doe->abort_c);
> > +		}
> > +		return;
> > +	}
> > +
> > +err_abort:
> > +	doe->state = DOE_WAIT_ABORT_ON_ERR;
> > +	pci_doe_abort_start(doe);
> > +err_busy:
> > +	task->rv = rc;
> > +	task->cb(task->private);
> > +	/* If here via err_busy, signal the task done. */
> > +	if (doe->state == DOE_IDLE) {
> > +		mutex_lock(&doe->state_lock);
> > +		doe->cur_task = NULL;
> > +		mutex_unlock(&doe->state_lock);
> > +		wake_up_interruptible(&doe->wq);
> > +	}
> > +}
> > +
> > +/**
> > + * pci_doe_exchange_sync() - Send a request, then wait for and receive a response
> > + * @doe: DOE mailbox state structure
> > + * @ex: Description of the buffers and Vendor ID + type used in this
> > + *      request/response pair
> > + *
> > + * Excess data will be discarded.
> > + *
> > + * RETURNS: payload in bytes on success, < 0 on error
> > + */
> > +int pci_doe_exchange_sync(struct pci_doe_dev *doe_dev, struct pci_doe_exchange *ex)
> > +{
> > +	struct pci_doe *doe = dev_get_drvdata(&doe_dev->adev.dev);
> > +	struct pci_doe_task task;
> > +	DECLARE_COMPLETION_ONSTACK(c);
> > +
> > +	if (!doe)
> > +		return -EAGAIN;
> > +
> > +	/* DOE requests must be a whole number of DW */
> > +	if (ex->request_pl_sz % sizeof(u32))
> > +		return -EINVAL;
> > +
> > +	task.ex = ex;
> > +	task.cb = pci_doe_task_complete;
> > +	task.private = &c;
> > +
> > +again:
> 
> Hmm.   Whether having this code at this layer makes sense hinges on
> whether we want to easily support async use of the DOE in future.

I struggled with this.  I was trying to strike a balance with making this a
synchronous call with only 1 outstanding task while leaving the statemachine
alone.

FWIW I think the queue you had was just fine even though there was only this
synchronous call.

> 
> In v4 some of the async handling had ended up in this function and
> should probably have been factored out to give us a 
> 'queue up work' then 'wait for completion' sequence.
> 
> Given there is now more to be done in here perhaps we need to think
> about such a separation to keep it clear that this is fundamentally
> a synchronous wrapper around an asynchronous operation.

I think that would be moving back in a direction of having a queue like you
defined in V4.  Eliminating the queue really defined this function to sleep
waiting for the state machine to be available.  Doing anything more would have
messed with the state machine you wrote and I did not want to do that.

Dan should we move back to having a queue_task/wait_task like Jonathan had
before?

> 
> > +	mutex_lock(&doe->state_lock);
> > +	if (doe->cur_task) {
> > +		mutex_unlock(&doe->state_lock);
> > +		wait_event_interruptible(doe->wq, doe->cur_task == NULL);
> > +		goto again;
> > +	}
> > +
> > +	if (doe->dead) {
> > +		mutex_unlock(&doe->state_lock);
> > +		return -EIO;
> > +	}
> > +	doe->cur_task = &task;
> > +	schedule_delayed_work(&doe->statemachine, 0);
> > +	mutex_unlock(&doe->state_lock);
> > +
> > +	wait_for_completion(&c);
> > +
> > +	return task.rv;
> > +}
> > +EXPORT_SYMBOL_GPL(pci_doe_exchange_sync);
> > +
> > +/**
> > + * pci_doe_supports_prot() - Return if the DOE instance supports the given protocol
> > + * @pdev: Device on which to find the DOE instance
> > + * @vid: Protocol Vendor ID
> > + * @type: protocol type
> > + *
> > + * This device can then be passed to pci_doe_exchange_sync() to execute a mailbox
> > + * exchange through that DOE mailbox.
> > + *
> > + * RETURNS: True if the DOE device supports the protocol specified
> > + */
> > +bool pci_doe_supports_prot(struct pci_doe_dev *doe_dev, u16 vid, u8 type)
> > +{
> > +	struct pci_doe *doe = dev_get_drvdata(&doe_dev->adev.dev);
> > +	int i;
> > +
> > +	if (!doe)
> > +		return false;
> 
> How would this happen?  I don't think it can...  Probably
> false paranoia from me...

The driver may not be loaded at this point.  The call operates on the aux
device not the driver.  Without a driver loaded I don't think we should return
any protocol support.  Even if the driver was loaded and there were some
protocols previously supported.

> 
> > +
> > +	for (i = 0; i < doe->num_prots; i++)
> > +		if ((doe->prots[i].vid == vid) &&
> > +		    (doe->prots[i].type == type))
> > +			return true;
> > +
> > +	return false;
> > +}
> > +EXPORT_SYMBOL_GPL(pci_doe_supports_prot);
> 
> ...
> 
> > +static void pci_doe_release_irq(struct pci_doe *doe)
> > +{
> > +	if (doe->irq > 0)
> > +		free_irq(doe->irq, doe);
> 
> Is this trivial wrapper worth bothering with?  Maybe just
> put the code inline?

Personally I like it this way because it is called in 2 places.

> 
> > +}
> > +
> 
> ...
> 
> > +
> > +static void pci_doe_unregister(struct pci_doe *doe)
> > +{
> > +	pci_doe_release_irq(doe);
> > +	kfree(doe->irq_name);
> > +	put_device(&doe->doe_dev->pdev->dev);
> 
> This makes me wonder if we should be doing the get_device()
> earlier in probe?  Limited harm in moving it to near the start
> and then ending up with it being 'obviously' correct...

Well...  get_device() is in pci_doe_register...  And it does it's own irq
unwinding.

I guess we could call pci_doe_unregister() from that if we refactored this...

How about this?  (Diff to this code)

diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index 76acf4063b6b..6f2a419b3c93 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -545,10 +545,12 @@ static int pci_doe_abort(struct pci_doe *doe)
        return 0;
 }
 
-static void pci_doe_release_irq(struct pci_doe *doe)
+static void pci_doe_unregister(struct pci_doe *doe)
 {
        if (doe->irq > 0)
                free_irq(doe->irq, doe);
+       kfree(doe->irq_name);
+       put_device(&doe->doe_dev->pdev->dev);
 }
 
 static int pci_doe_register(struct pci_doe *doe)
@@ -559,21 +561,28 @@ static int pci_doe_register(struct pci_doe *doe)
        int rc, irq;
        u32 val;
 
+       /* Ensure the pci device remains until this driver is done with it */
+       get_device(&pdev->dev);
+
        pci_read_config_dword(pdev, offset + PCI_DOE_CAP, &val);
 
        if (!poll && FIELD_GET(PCI_DOE_CAP_INT, val)) {
                irq = pci_irq_vector(pdev, FIELD_GET(PCI_DOE_CAP_IRQ, val));
-               if (irq < 0)
-                       return irq;
+               if (irq < 0) {
+                       rc = irq;
+                       goto unregister;
+               }
 
                doe->irq_name = kasprintf(GFP_KERNEL, "DOE[%s]",
                                          doe->doe_dev->adev.name);
-               if (!doe->irq_name)
-                       return -ENOMEM;
+               if (!doe->irq_name) {
+                       rc = -ENOMEM;
+                       goto unregister;
+               }
 
                rc = request_irq(irq, pci_doe_irq, 0, doe->irq_name, doe);
                if (rc)
-                       goto err_free_name;
+                       goto unregister;
 
                doe->irq = irq;
                pci_write_config_dword(pdev, offset + PCI_DOE_CTRL,
@@ -583,27 +592,15 @@ static int pci_doe_register(struct pci_doe *doe)
        /* Reset the mailbox by issuing an abort */
        rc = pci_doe_abort(doe);
        if (rc)
-               goto err_free_irq;
-
-       /* Ensure the pci device remains until this driver is done with it */
-       get_device(&pdev->dev);
+               goto unregister;
 
        return 0;
 
-err_free_irq:
-       pci_doe_release_irq(doe);
-err_free_name:
-       kfree(doe->irq_name);
+unregister:
+       pci_doe_unregister(doe);
        return rc;
 }
 
-static void pci_doe_unregister(struct pci_doe *doe)
-{
-       pci_doe_release_irq(doe);
-       kfree(doe->irq_name);
-       put_device(&doe->doe_dev->pdev->dev);
-}
-
 /*
  * pci_doe_probe() - Set up the Mailbox
  * @aux_dev: Auxiliary Device


> 
> > +}
> > +
> > +/*
> > + * pci_doe_probe() - Set up the Mailbox
> > + * @aux_dev: Auxiliary Device
> > + * @id: Auxiliary device ID
> > + *
> > + * Probe the mailbox found for all protocols and set up the Mailbox
> > + *
> > + * RETURNS: 0 on success, < 0 on error
> > + */
> > +static int pci_doe_probe(struct auxiliary_device *aux_dev,
> > +			 const struct auxiliary_device_id *id)
> > +{
> > +	struct pci_doe_dev *doe_dev = container_of(aux_dev,
> > +					struct pci_doe_dev,
> > +					adev);
> > +	struct pci_doe *doe;
> > +	int rc;
> > +
> > +	doe = kzalloc(sizeof(*doe), GFP_KERNEL);
> 
> Could go devm_ for this I think, though may not be worthwhile.

Yes I think it is worth it...  I should use it more.

BTW why did you not use devm_krealloc() for the protocols?

I did not realize that call existed before you mentioned it in the other patch
review.

Any issue with using it there?

> 
> > +	if (!doe)
> > +		return -ENOMEM;
> > +
> > +	mutex_init(&doe->state_lock);
> > +	init_completion(&doe->abort_c);
> > +	doe->doe_dev = doe_dev;
> > +	init_waitqueue_head(&doe->wq);
> > +	INIT_DELAYED_WORK(&doe->statemachine, doe_statemachine_work);
> > +	dev_set_drvdata(&aux_dev->dev, doe);
> > +
> > +	rc = pci_doe_register(doe);
> > +	if (rc)
> > +		goto err_free;
> > +
> > +	rc = pci_doe_cache_protocols(doe);
> > +	if (rc) {
> > +		pci_doe_unregister(doe);
> 
> Mixture of different forms of error handling here.
> I'd move this below and add an err_unregister label.

Actually with the devm_kzalloc() we don't need the goto at all.  We can just
return.  I _think_?  Right?

> 
> > +		goto err_free;
> > +	}
> > +
> > +	return 0;
> > +
> > +err_free:
> > +	kfree(doe);
> > +	return rc;
> > +}
> > +
> > +static void pci_doe_remove(struct auxiliary_device *aux_dev)
> > +{
> > +	struct pci_doe *doe = dev_get_drvdata(&aux_dev->dev);
> > +
> > +	/* First halt the state machine */
> > +	cancel_delayed_work_sync(&doe->statemachine);
> > +	kfree(doe->prots);
> 
> Logical flow to me is unregister first, free protocols second
> (to reverse what we do in probe)

No this is the reverse of the probe order I think.

Order is
	register
	cache protocols

Then we
	free 'uncache' protocols
	unregister

Right?

> 
> > +	pci_doe_unregister(doe);
> > +	kfree(doe);
> > +}
> > +
> > +static const struct auxiliary_device_id pci_doe_auxiliary_id_table[] = {
> > +	{.name = "cxl_pci.doe", },
> 
> I'd like to hear from Bjorn on whether registering this from the CXL
> device is the right approach or if we should perhaps just do it directly from
> somewhere in PCI. (really applies to patch 3) I'll talk more about this there.

Actually I think this could be left blank until the next patch...  It's just
odd to define an empty table in the next few structures.  But technically this
is not needed until the devices are defined.

I'm ok waiting to see what Bjorn thinks regarding the CXL vs PCI placement
though.

> 
> > +	{},
> > +};
> > +
> > +MODULE_DEVICE_TABLE(auxiliary, pci_doe_auxiliary_id_table);
> > +
> > +struct auxiliary_driver pci_doe_auxiliary_drv = {
> > +	.name = "pci_doe_drv",
> 
> I would assume this is only used in contexts where the _drv is
> obvious?  I would go with "pci_doe".

Sure. done.

> 
> > +	.id_table = pci_doe_auxiliary_id_table,
> > +	.probe = pci_doe_probe,
> > +	.remove = pci_doe_remove
> > +};
> > +
> > +static int __init pci_doe_init_module(void)
> > +{
> > +	int ret;
> > +
> > +	ret = auxiliary_driver_register(&pci_doe_auxiliary_drv);
> > +	if (ret) {
> > +		pr_err("Failed pci_doe auxiliary_driver_register() ret=%d\n",
> > +		       ret);
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void __exit pci_doe_exit_module(void)
> > +{
> > +	auxiliary_driver_unregister(&pci_doe_auxiliary_drv);
> > +}
> > +
> > +module_init(pci_doe_init_module);
> > +module_exit(pci_doe_exit_module);
> 
> Seems like the auxiliary bus would benefit from a
> module_auxiliary_driver() macro to cover this simple registration stuff
> similar to module_i2c_driver() etc.
> 
> Mind you, looking at 5.15 this would be the only user, so maybe one
> for the 'next' case on basis two instances proves it's 'common' ;)

I'm inclined to leave this alone ATM.  I tried to clean up the auxiliary device
documentation and got a bunch more work asked of me by Greg KH.  So I'm behind
on that ATM.

Later we can investigate that a bit I think.

> 
> > +MODULE_LICENSE("GPL v2");
> > diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
> > new file mode 100644
> > index 000000000000..8380b7ad33d4
> > --- /dev/null
> > +++ b/include/linux/pci-doe.h
> > @@ -0,0 +1,63 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Data Object Exchange was added as an ECN to the PCIe r5.0 spec.
> > + *
> > + * Copyright (C) 2021 Huawei
> > + *     Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > + */
> > +
> > +#include <linux/completion.h>
> > +#include <linux/list.h>
> > +#include <linux/mutex.h>
> 
> Not used in this header that I can see, so push down to the c files.

oops...  thanks.

> 
> > +#include <linux/auxiliary_bus.h>
> > +
> > +#ifndef LINUX_PCI_DOE_H
> > +#define LINUX_PCI_DOE_H
> > +
> > +#define DOE_DEV_NAME "doe"
> 
> Not sure this is used?

Used in the next patch...  and it kind of goes along with the table_id name...

I'll see about moving both of those to the next patch where it makes more sense
for now.

Thanks for the review,
Ira


Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5AC437AC6E
	for <lists+linux-pci@lfdr.de>; Tue, 11 May 2021 18:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbhEKQw6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 May 2021 12:52:58 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3063 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbhEKQw6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 May 2021 12:52:58 -0400
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FfkM40Bf1z6wlMD;
        Wed, 12 May 2021 00:45:52 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 11 May 2021 18:51:49 +0200
Received: from localhost (10.52.125.126) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 11 May
 2021 17:51:49 +0100
Date:   Tue, 11 May 2021 17:50:06 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Chris Browy <cbrowy@avery-design.com>,
        <linux-acpi@vger.kernel.org>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <linuxarm@huawei.com>,
        Fangjian <f.fangjian@huawei.com>
Subject: Re: [RFC PATCH v3 2/4] PCI/doe: Add Data Object Exchange support
Message-ID: <20210511175006.00007861@Huawei.com>
In-Reply-To: <20210506215934.GJ1904484@iweiny-DESK2.sc.intel.com>
References: <20210419165451.2176200-1-Jonathan.Cameron@huawei.com>
        <20210419165451.2176200-3-Jonathan.Cameron@huawei.com>
        <20210506215934.GJ1904484@iweiny-DESK2.sc.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.125.126]
X-ClientProxiedBy: lhreml730-chm.china.huawei.com (10.201.108.81) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 6 May 2021 14:59:34 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> On Tue, Apr 20, 2021 at 12:54:49AM +0800, Jonathan Cameron wrote:
> > +
> > +static int pci_doe_send_req(struct pci_doe *doe, struct pci_doe_exchange *ex)
> > +{
> > +	struct pci_dev *pdev = doe->pdev;
> > +	u32 val;
> > +	int i;
> > +
> > +	/*
> > +	 * Check the DOE busy bit is not set. If it is set, this could indicate
> > +	 * someone other than Linux (e.g. firmware) is using the mailbox. Note
> > +	 * it is expected that firmware and OS will negotiate access rights via
> > +	 * an, as yet to be defined method.
> > +	 */
> > +	pci_read_config_dword(pdev, doe->cap + PCI_DOE_STATUS, &val);
> > +	if (FIELD_GET(PCI_DOE_STATUS_BUSY, val))
> > +		return -EBUSY;  
> 
> In discussion with Dan we believe that user space could also be issuing
> commands and would potentially cause us to be locked out.
> 
> We agree that firmware should be out of the way here and if it is blocking
> the OS there is not much we can do about it.
> 
> However, if user space is using the mailbox we need to synchronize with them
> via pci_cfg_access_[try]lock().  This should avoid this EBUSY condition.

Hi Ira, thanks for taking a look.

So the question here is whether we can ever safely work with a
userspace that is accessing the DOE.  I think the answer is no we can't.

We'd have no way of knowing that userspace left the DOE in a clean state
without resetting every time we want to use it (which can take 1 second)
or doing significant sanity checking (can we tell if something is
in flight?).  Note that if userspace and kernel were talking different
protocols nothing sensible could be done to prevent them receiving each
other's answers (unless you can rely on userspace holding the lock until
it is done - which you can't as who trusts userspace?) You could do
something horrible like back off after peeking at the protocol to see
if it might be yours, but even that only works assuming the two are
trying to talk different protocols (talking the same protocol isn't allowed
but no way to enforce that using just pci_cfg_access_lock()).

I can't see a way to tell that the DOE might not have responded to an
earlier request.  DOE busy indicates the write mailbox register cannot
receive data at the moment.  If it's set then there is a message in
flight, but if it is not set there might still be a message in flight.
Busy only indicates if the write mailbox register can sink a request
which doesn't in general tell us anything about the underlying state.

So if userspace sent a request then quit.  Kernel driver would have
no way of knowing if the next response was due to the request it sent
or some earlier one (other than matching IDs)  Note you aren't allowed
to have multiple requests for a single protocol in flight at the same
time.  With just a lock you would have no way of preventing this.

So we are back to every request the kernel sent having to be proceeded
by an abort and potentially a 1 second delay whilst some chunk of the
device firmware reboots.

This came up in dicussion when Dan proposed the patch
[PATCH] PCI: Allow drivers to claim exclusive access to config regions
https://lore.kernel.org/linux-pci/161663543465.1867664.5674061943008380442.stgit@dwillia2-desk3.amr.corp.intel.com/
Summarizing outcome of that thread.

1) Reads of DOE registers are always safe, so we shouldn't stop lspci
and similar accessing config space.
2) You are on your own if any userspace writes to pci config space.
There are loads of ways it can break the system so it doesn't make much
sense to protect against one more.

If there is a reason to provide a userspace interface to a DOE for a
device with a driver attached, then I would agree with Dan's suggestion
to use a proper driver for it.

Dan briefly mentioned that temporary blocking might be needed. I'm guessing
that was to try and let userspace safely use the DOE.

The driver would work fine ignoring busy entirely and would perhaps be
less confusing as a result.  We reset the DOE at startup anyway and that
would clear existing busy.  Any future times busy is set would have no
impact on the flow.

> 
> [snip]
> 
> > +
> > +static int pci_doe_recv_resp(struct pci_doe *doe, struct pci_doe_exchange *ex)
> > +{
> > +	struct pci_dev *pdev = doe->pdev;
> > +	size_t length;
> > +	u32 val;
> > +	int i;
> > +
> > +	/* Read the first two dwords to get the length and protocol */
> > +	pci_read_config_dword(pdev, doe->cap + PCI_DOE_READ, &val);
> > +	if ((FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_VID, val) != ex->vid) ||
> > +	    (FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, val) != ex->protocol)) {
> > +		pci_err(pdev,
> > +			"Expected [VID, Protocol] = [%x, %x], got [%x, %x]\n",
> > +			ex->vid, ex->protocol,
> > +			FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_VID, val),
> > +			FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, val));
> > +		return -EIO;
> > +	}
> > +
> > +	pci_write_config_dword(pdev, doe->cap + PCI_DOE_READ, 0);  
> 
> I'm quite unfamiliar with the spec here: but it seems like this needs to be
> done before the above if statement indicate we got the value?

Perhaps it's the comment that caused confusion here. It covered
the next few lines as well. You need to read the first DW to get protocol
(and write it to be able to read the next one back)
The second dw is then need to get to the length which follows this.

I'll split the comment into two parts so that it's clearer what it is referring
to.

On any error here, we end up calling a abort anyway so state on error paths of
the DOE doesn't matter.

> 
> [snip]
> 
> > +
> > +static void doe_statemachine_work(struct work_struct *work)
> > +{
> > +	struct delayed_work *w = to_delayed_work(work);
> > +	struct pci_doe *doe = container_of(w, struct pci_doe, statemachine);
> > +	struct pci_dev *pdev = doe->pdev;
> > +	struct pci_doe_task *task;
> > +	bool abort;
> > +	u32 val;
> > +	int rc;
> > +
> > +	mutex_lock(&doe->tasks_lock);
> > +	task = list_first_entry_or_null(&doe->tasks, struct pci_doe_task, h);
> > +	abort = doe->abort;
> > +	doe->abort = false;
> > +	mutex_unlock(&doe->tasks_lock);
> > +
> > +	if (abort) {
> > +		/*
> > +		 * Currently only used during init - care needed if we want to
> > +		 * generally expose pci_doe_abort() as it would impact queries
> > +		 * in flight.
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
> > +				doe->busy_retries = 0;
> > +				goto err_busy;  
> 
> With the addition of pci_cfg_access_[try]lock():
> 
> Should we have some sort of WARN_ON() here to indicate that the system is
> behaving badly?

Makes sense. I'll add a pci_WARN() here

> 
> [snip]
> 
> > +	case DOE_WAIT_ABORT:
> > +	case DOE_WAIT_ABORT_ON_ERR:
> > +		pci_read_config_dword(pdev, doe->cap + PCI_DOE_STATUS, &val);
> > +
> > +		if (!FIELD_GET(PCI_DOE_STATUS_ERROR, val) &&
> > +		    !FIELD_GET(PCI_DOE_STATUS_BUSY, val)) {
> > +			/* Back to normal state - carry on */
> > +			mutex_lock(&doe->tasks_lock);
> > +			if (!list_empty(&doe->tasks))
> > +				schedule_delayed_work(w, 0);
> > +			mutex_unlock(&doe->tasks_lock);
> > +
> > +			/*
> > +			 * For deliberately triggered abort, someone is
> > +			 * waiting.
> > +			 */
> > +			if (doe->state == DOE_WAIT_ABORT)
> > +				complete(&doe->abort_c);
> > +			doe->state = DOE_IDLE;
> > +
> > +			return;
> > +		}
> > +		if (time_after(jiffies, doe->timeout_jiffies)) {
> > +			struct pci_doe_task *t, *n;
> > +
> > +			/* We are dead - abort all queued tasks */
> > +			pci_err(pdev, "DOE ABORT timed out\n");
> > +			mutex_lock(&doe->tasks_lock);
> > +			doe->dead = true;
> > +			list_for_each_entry_safe(t, n, &doe->tasks, h) {
> > +				t->rv = -EIO;
> > +				t->cb(t->private);
> > +				list_del(&t->h);
> > +			}
> > +
> > +			mutex_unlock(&doe->tasks_lock);
> > +			if (doe->state == DOE_WAIT_ABORT)
> > +				complete(&doe->abort_c);
> > +		}
> > +		return;
> > +	}
> > +
> > +err_abort:
> > +	pci_doe_abort_start(doe);
> > +	doe->state = DOE_WAIT_ABORT_ON_ERR;  
> 
> Should this be before pci_doe_abort_start() to ensure that state is set when
> the statemachine runs?

Don't think it's a bug (single work item) but it's definitely
clearer the other way around.

> 
> [snip]
> 
> > +
> > +/**
> > + * struct pci_doe - State to support use of DOE mailbox
> > + * @cap: Config space offset to base of DOE capability.
> > + * @pdev: PCI device that hosts this DOE.
> > + * @abort_c: Completion used for initial abort handling.
> > + * @irq: Interrupt used for signaling DOE ready or abort.
> > + * @prots: Cache of identifiers for protocols supported.
> > + * @num_prots: Size of prots cache.
> > + * @h: Used for DOE instance lifetime management.
> > + * @wq: Workqueue used to handle state machine and polling / timeouts.
> > + * @tasks: List of task in flight + pending.
> > + * @tasks_lock: Protect the tasks list.  
> 
> This protects more than just the task list.  It appears to protect abort and
> dead as well.  I'm not sure if it is worth mentioning but...

Added 'abort state' to that comment.

> 
> > + * @statemachine: Work item for the DOE state machine.
> > + * @state: Current state of this DOE.
> > + * @timeout_jiffies: 1 second after GO set.
> > + * @busy_retries: Count of retry attempts.
> > + * @abort: Request a manual abort (e.g. on init).
> > + * @dead: Used to mark a DOE for which an ABORT has timed out. Further messages
> > + *        will immediately be aborted with error.
> > + */
> > +struct pci_doe {
> > +	int cap;
> > +	struct pci_dev *pdev;
> > +	struct completion abort_c;
> > +	int irq;
> > +	struct pci_doe_prot *prots;
> > +	int num_prots;
> > +	struct list_head h;
> > +
> > +	struct workqueue_struct *wq;
> > +	struct list_head tasks;
> > +	struct mutex tasks_lock;
> > +	struct delayed_work statemachine;
> > +	enum pci_doe_state state;
> > +	unsigned long timeout_jiffies;
> > +	unsigned int busy_retries;
> > +	unsigned int abort:1;
> > +	unsigned int dead:1;
> > +};  
> 
> [snip]
> 
> Ira
> 
Thanks!

Jonathan



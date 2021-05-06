Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2FF9375D09
	for <lists+linux-pci@lfdr.de>; Thu,  6 May 2021 23:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhEFWAe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 May 2021 18:00:34 -0400
Received: from mga01.intel.com ([192.55.52.88]:54248 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229894AbhEFWAd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 May 2021 18:00:33 -0400
IronPort-SDR: dWO6Edr+qrmtgvEybk2Pm74c8JiJr3NopPUwZAvpWjHdLrYABL6YUVcEaRdqvF1+SGGxBT595L
 hSxgee0bcXjQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9976"; a="219478071"
X-IronPort-AV: E=Sophos;i="5.82,279,1613462400"; 
   d="scan'208";a="219478071"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 14:59:34 -0700
IronPort-SDR: 8YyvleQwpQmBmS5PbD+A1+kfPx3sWCxKlrBGBXuua/6KQvOSjTpnMiLE364l2QxvaMz9Bsjf2l
 rZzPeMJW792A==
X-IronPort-AV: E=Sophos;i="5.82,279,1613462400"; 
   d="scan'208";a="434594966"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 14:59:34 -0700
Date:   Thu, 6 May 2021 14:59:34 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Chris Browy <cbrowy@avery-design.com>,
        linux-acpi@vger.kernel.org, alison.schofield@intel.com,
        vishal.l.verma@intel.com, linuxarm@huawei.com,
        Fangjian <f.fangjian@huawei.com>
Subject: Re: [RFC PATCH v3 2/4] PCI/doe: Add Data Object Exchange support
Message-ID: <20210506215934.GJ1904484@iweiny-DESK2.sc.intel.com>
References: <20210419165451.2176200-1-Jonathan.Cameron@huawei.com>
 <20210419165451.2176200-3-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210419165451.2176200-3-Jonathan.Cameron@huawei.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 20, 2021 at 12:54:49AM +0800, Jonathan Cameron wrote:
> +
> +static int pci_doe_send_req(struct pci_doe *doe, struct pci_doe_exchange *ex)
> +{
> +	struct pci_dev *pdev = doe->pdev;
> +	u32 val;
> +	int i;
> +
> +	/*
> +	 * Check the DOE busy bit is not set. If it is set, this could indicate
> +	 * someone other than Linux (e.g. firmware) is using the mailbox. Note
> +	 * it is expected that firmware and OS will negotiate access rights via
> +	 * an, as yet to be defined method.
> +	 */
> +	pci_read_config_dword(pdev, doe->cap + PCI_DOE_STATUS, &val);
> +	if (FIELD_GET(PCI_DOE_STATUS_BUSY, val))
> +		return -EBUSY;

In discussion with Dan we believe that user space could also be issuing
commands and would potentially cause us to be locked out.

We agree that firmware should be out of the way here and if it is blocking
the OS there is not much we can do about it.

However, if user space is using the mailbox we need to synchronize with them
via pci_cfg_access_[try]lock().  This should avoid this EBUSY condition.

[snip]

> +
> +static int pci_doe_recv_resp(struct pci_doe *doe, struct pci_doe_exchange *ex)
> +{
> +	struct pci_dev *pdev = doe->pdev;
> +	size_t length;
> +	u32 val;
> +	int i;
> +
> +	/* Read the first two dwords to get the length and protocol */
> +	pci_read_config_dword(pdev, doe->cap + PCI_DOE_READ, &val);
> +	if ((FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_VID, val) != ex->vid) ||
> +	    (FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, val) != ex->protocol)) {
> +		pci_err(pdev,
> +			"Expected [VID, Protocol] = [%x, %x], got [%x, %x]\n",
> +			ex->vid, ex->protocol,
> +			FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_VID, val),
> +			FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, val));
> +		return -EIO;
> +	}
> +
> +	pci_write_config_dword(pdev, doe->cap + PCI_DOE_READ, 0);

I'm quite unfamiliar with the spec here: but it seems like this needs to be
done before the above if statement indicate we got the value?

[snip]

> +
> +static void doe_statemachine_work(struct work_struct *work)
> +{
> +	struct delayed_work *w = to_delayed_work(work);
> +	struct pci_doe *doe = container_of(w, struct pci_doe, statemachine);
> +	struct pci_dev *pdev = doe->pdev;
> +	struct pci_doe_task *task;
> +	bool abort;
> +	u32 val;
> +	int rc;
> +
> +	mutex_lock(&doe->tasks_lock);
> +	task = list_first_entry_or_null(&doe->tasks, struct pci_doe_task, h);
> +	abort = doe->abort;
> +	doe->abort = false;
> +	mutex_unlock(&doe->tasks_lock);
> +
> +	if (abort) {
> +		/*
> +		 * Currently only used during init - care needed if we want to
> +		 * generally expose pci_doe_abort() as it would impact queries
> +		 * in flight.
> +		 */
> +		WARN_ON(task);
> +		doe->state = DOE_WAIT_ABORT;
> +		pci_doe_abort_start(doe);
> +		return;
> +	}
> +
> +	switch (doe->state) {
> +	case DOE_IDLE:
> +		if (task == NULL)
> +			return;
> +
> +		/* Nothing currently in flight so queue a task */
> +		rc = pci_doe_send_req(doe, task->ex);
> +		/*
> +		 * The specification does not provide any guidance on how long
> +		 * some other entity could keep the DOE busy, so try for 1
> +		 * second then fail. Busy handling is best effort only, because
> +		 * there is no way of avoiding racing against another user of
> +		 * the DOE.
> +		 */
> +		if (rc == -EBUSY) {
> +			doe->busy_retries++;
> +			if (doe->busy_retries == PCI_DOE_BUSY_MAX_RETRIES) {
> +				/* Long enough, fail this request */
> +				doe->busy_retries = 0;
> +				goto err_busy;

With the addition of pci_cfg_access_[try]lock():

Should we have some sort of WARN_ON() here to indicate that the system is
behaving badly?

[snip]

> +	case DOE_WAIT_ABORT:
> +	case DOE_WAIT_ABORT_ON_ERR:
> +		pci_read_config_dword(pdev, doe->cap + PCI_DOE_STATUS, &val);
> +
> +		if (!FIELD_GET(PCI_DOE_STATUS_ERROR, val) &&
> +		    !FIELD_GET(PCI_DOE_STATUS_BUSY, val)) {
> +			/* Back to normal state - carry on */
> +			mutex_lock(&doe->tasks_lock);
> +			if (!list_empty(&doe->tasks))
> +				schedule_delayed_work(w, 0);
> +			mutex_unlock(&doe->tasks_lock);
> +
> +			/*
> +			 * For deliberately triggered abort, someone is
> +			 * waiting.
> +			 */
> +			if (doe->state == DOE_WAIT_ABORT)
> +				complete(&doe->abort_c);
> +			doe->state = DOE_IDLE;
> +
> +			return;
> +		}
> +		if (time_after(jiffies, doe->timeout_jiffies)) {
> +			struct pci_doe_task *t, *n;
> +
> +			/* We are dead - abort all queued tasks */
> +			pci_err(pdev, "DOE ABORT timed out\n");
> +			mutex_lock(&doe->tasks_lock);
> +			doe->dead = true;
> +			list_for_each_entry_safe(t, n, &doe->tasks, h) {
> +				t->rv = -EIO;
> +				t->cb(t->private);
> +				list_del(&t->h);
> +			}
> +
> +			mutex_unlock(&doe->tasks_lock);
> +			if (doe->state == DOE_WAIT_ABORT)
> +				complete(&doe->abort_c);
> +		}
> +		return;
> +	}
> +
> +err_abort:
> +	pci_doe_abort_start(doe);
> +	doe->state = DOE_WAIT_ABORT_ON_ERR;

Should this be before pci_doe_abort_start() to ensure that state is set when
the statemachine runs?

[snip]

> +
> +/**
> + * struct pci_doe - State to support use of DOE mailbox
> + * @cap: Config space offset to base of DOE capability.
> + * @pdev: PCI device that hosts this DOE.
> + * @abort_c: Completion used for initial abort handling.
> + * @irq: Interrupt used for signaling DOE ready or abort.
> + * @prots: Cache of identifiers for protocols supported.
> + * @num_prots: Size of prots cache.
> + * @h: Used for DOE instance lifetime management.
> + * @wq: Workqueue used to handle state machine and polling / timeouts.
> + * @tasks: List of task in flight + pending.
> + * @tasks_lock: Protect the tasks list.

This protects more than just the task list.  It appears to protect abort and
dead as well.  I'm not sure if it is worth mentioning but...

> + * @statemachine: Work item for the DOE state machine.
> + * @state: Current state of this DOE.
> + * @timeout_jiffies: 1 second after GO set.
> + * @busy_retries: Count of retry attempts.
> + * @abort: Request a manual abort (e.g. on init).
> + * @dead: Used to mark a DOE for which an ABORT has timed out. Further messages
> + *        will immediately be aborted with error.
> + */
> +struct pci_doe {
> +	int cap;
> +	struct pci_dev *pdev;
> +	struct completion abort_c;
> +	int irq;
> +	struct pci_doe_prot *prots;
> +	int num_prots;
> +	struct list_head h;
> +
> +	struct workqueue_struct *wq;
> +	struct list_head tasks;
> +	struct mutex tasks_lock;
> +	struct delayed_work statemachine;
> +	enum pci_doe_state state;
> +	unsigned long timeout_jiffies;
> +	unsigned int busy_retries;
> +	unsigned int abort:1;
> +	unsigned int dead:1;
> +};

[snip]

Ira


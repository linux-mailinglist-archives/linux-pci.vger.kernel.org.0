Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71664DBAC3
	for <lists+linux-pci@lfdr.de>; Wed, 16 Mar 2022 23:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbiCPWwN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Mar 2022 18:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiCPWwM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Mar 2022 18:52:12 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9D41D31F;
        Wed, 16 Mar 2022 15:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647471056; x=1679007056;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4CXDSI61WyAyZ2s6eVhb+R26vQx8nQPq8x+h9eOUlHk=;
  b=nvHPPHF7v/bSytx4NpO+JafSur5Uq4ozJ3h5qJ3qRB9/HDMryi/UjtpQ
   c9q7qtbvEcIHtUScR5DKh9I9ZFMPByolv4RK1SgIOl6jEIAOWI8Tmu1yb
   QKQa+OqWp5e4fiirlyJDdbgQQBdiK4Z89XXHa93Y28MIFOmKfDl/YHVq4
   jvjZClk9l42H6DBIU4F+G2ClqVd5Dm3+p57IKBEobuVn/LbpO84ey7Tql
   wu/vxVtGKnJuhKjrkqaOZG5BHOk3LrN9O7dJCBh9FIXzrCQdRGnb9oA/k
   yjnt3SA5+StBn/Fvyf0g58XohwNC2zg4S6tPwrLTd36c+9fUR5tiuJFva
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="256457444"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="256457444"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 15:50:56 -0700
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="516528785"
Received: from mbhanuva-mobl.amr.corp.intel.com (HELO localhost) ([10.212.30.158])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 15:50:55 -0700
Date:   Wed, 16 Mar 2022 15:50:55 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V6 03/10] PCI/DOE: Add Data Object Exchange Aux Driver
Message-ID: <YjJpzzKAtV4vgM+H@iweiny-desk3>
References: <20220201071952.900068-1-ira.weiny@intel.com>
 <20220201071952.900068-4-ira.weiny@intel.com>
 <CAPcyv4hYAgyf-WcArGvbWHAJgc5+p=OO_6ah_dXJhNM5cXcVTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hYAgyf-WcArGvbWHAJgc5+p=OO_6ah_dXJhNM5cXcVTw@mail.gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 08, 2022 at 04:59:39PM -0800, Dan Williams wrote:
> On Mon, Jan 31, 2022 at 11:20 PM <ira.weiny@intel.com> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Introduced in a PCI ECN [1], DOE provides a config space based mailbox
> > with standard protocol discovery.  Each mailbox is accessed through a
> > DOE Extended Capability.
> >
> > Define an auxiliary device driver which control DOE auxiliary devices
> 
> s/control/controls/

Done.

[snip]

> >
> > diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> > index 43e615aa12ff..8de51b64067c 100644
> > --- a/drivers/pci/Kconfig
> > +++ b/drivers/pci/Kconfig
> > @@ -118,6 +118,16 @@ config XEN_PCIDEV_FRONTEND
> >           The PCI device frontend driver allows the kernel to import arbitrary
> >           PCI devices from a PCI backend to support PCI driver domains.
> >
> > +config PCI_DOE_DRIVER
> > +       tristate "PCI Data Object Exchange (DOE) driver"
> > +       select AUXILIARY_BUS
> 
> See below near the comment about the odd usage of MODULE_DEVICE_TABLE,
> perhaps the auxiliary device / driver should be registered by the
> client of this core code, not the core itself.

I'll look into it more.

> > +
> > +/**
> > + * struct pci_doe_task - description of a query / response task
> > + * @ex: The details of the task to be done
> > + * @rv: Return value.  Length of received response or error
> > + * @cb: Callback for completion of task
> > + * @private: Private data passed to callback on completion
> > + */
> > +struct pci_doe_task {
> > +       struct pci_doe_exchange *ex;
> > +       int rv;
> > +       void (*cb)(void *private);
> 
> s/cb/end_task/?

Sounds good.

> 
> Why does this need to abandon all semblance of type safety?
> 
> I would expect:
> 
> void (*end_task)(struct pci_doe_task *task);
> 
> ...and let the caller attach any follow on data to task->private if necessary.

I kind of like this too.  But to be fair the code pattern is likely going
to be the caller only using pivate in end_task() which remains opaque.

I'll change it.

> 
> > +       void *private;
> > +};
> > +
> > +/**
> > + * struct pci_doe - A single DOE mailbox driver
> 
> This is driver *state*, right? I.e. not something that wraps "struct
> device_driver" which is what I would expect something claiming to be a
> "driver" would do.

Yes.

> 
> > + *
> > + * @doe_dev: The DOE Auxiliary device being driven
> > + * @abort_c: Completion used for initial abort handling
> > + * @irq: Interrupt used for signaling DOE ready or abort
> > + * @irq_name: Name used to identify the irq for a particular DOE
> > + * @prots: Array of identifiers for protocols supported
> 
> "prot" already has a meaning in the kernel, just spell out
> "protocols". This also looks like something that can be allocated
> inline rather than out of line i.e.:
> 
> struct pci_doe {
> ...
>     int nr_protocols
>     struct pci_doe_protocol protocols[];
> }
> 
> ...and then use struct_size() to allocate it.

As Jonathan said this needs to be more dynamic than that.  I'll add a comment.

[snip]

> > +
> > +/*
> > + * Only call when safe to directly access the DOE, either because no tasks yet
> > + * queued, or called from doe_statemachine_work() which has exclusive access to
> > + * the DOE config space.
> 
> It doesn't have exclusive access unless the patch to lock out
> userspace config writes are revived. Instead, I like Bjorn's idea of
> tracking and warning / tainting, but not blocking conflicting
> userspace access to sensitive configuration registers.
> 
> Yes, it was somewhat of a throw-away comment from Bjorn in that
> thread, "(and IMO should taint the kernel)", but DOE can do so much
> subtle damage (compliance test modes, link-encryption / disruption,
> vendor private who-knows-what...) that I think it behooves us as
> kernel developers to know when we are debugging system behavior that
> may be the result of non-kernel mitigated DOE access. The proposal is
> that when kernel lockdown is not enabled, use the approach from the
> exclusive config access patch [2] to trap, warn (once per device?),
> and taint when userspace writes to DOE registers that have been
> claimed by the kernel. This lets strict environments use
> kernel-lockdown to block userspace DOE access altogether, in
> non-strict environment it discourages userspace from clobbering DOE
> driver state, and it allows a warn-free path if userspace takes the
> step of at least unbinding the kernel DOE driver before running
> userspace DOE cycles.
> 
> [1]: https://lore.kernel.org/r/20211203235617.GA3036259@bhelgaas
> [2]: https://lore.kernel.org/all/161663543465.1867664.5674061943008380442.stgit@dwillia2-desk3.amr.corp.intel.com/
> 

Reading through the threads there seems to be a number
of ways to deal with this.  Let me try to numerate them:

1) Use pci_cfg_access_lock() to block user space access while the kernel DOE
   state machine is working
   	issue - how to ensure the kernel does not interrupt an in progress user
	space transaction.

2) Develop a user space interface to marshal the transactions through with the
   kernel transactions
   	issue - requires new user space APIs

3) Add Dan's patch [2] above which allows for exclusive claim of the resource.
   Require user space to unload driver for the device which then allows user
   space access without worry of conflict with kernel space.

I'm going in the direction of #3 via the use of the auxiliary bus.

To that end I'm going to pull [2] into this series and use it within the DOE
driver.

> > + */
> > +static void pci_doe_abort_start(struct pci_doe *doe)
> > +{
> > +       struct pci_dev *pdev = doe->doe_dev->pdev;
> > +       int offset = doe->doe_dev->cap_offset;
> > +       u32 val;
> > +
> > +       val = PCI_DOE_CTRL_ABORT;
> > +       if (doe->irq)
> > +               val |= PCI_DOE_CTRL_INT_EN;
> > +       pci_write_config_dword(pdev, offset + PCI_DOE_CTRL, val);
> > +
> > +       doe->timeout_jiffies = jiffies + HZ;
> > +       schedule_delayed_work(&doe->statemachine, HZ);
> 
> Given the spec timeout is 1 second and the device clock might be
> slightly off from the host clock how about make this a more generous
> 1.5 or 2 seconds?

Also I wonder why this was not using the PCI_DOE_TIMEOUT?

> 
> > +}
> > +
> > +static int pci_doe_send_req(struct pci_doe *doe, struct pci_doe_exchange *ex)
> 
> The relationship between tasks, requests, responses, and exchanges is
> not immediately clear to me. For example, can this helper be renamed
> in terms of its relationship to a task? A theory of operation document
> would help, but it seems there is also room for the implementation to
> be more self documenting.

Ok yea.  The difference between exchange and task was rather vague when I
looked at this with fresher eyes...

I've merged pci_doe_exchange and pci_doe_task into pci_doe_task and eliminated
pci_doe_exchange_sync() in favor of a pci_doe_submit_task() call per Dan's
suggestion above.

> 
> > +{
> > +       struct pci_dev *pdev = doe->doe_dev->pdev;
> > +       int offset = doe->doe_dev->cap_offset;
> > +       u32 val;
> > +       int i;
> > +
> > +       /*
> > +        * Check the DOE busy bit is not set. If it is set, this could indicate
> > +        * someone other than Linux (e.g. firmware) is using the mailbox. Note
> > +        * it is expected that firmware and OS will negotiate access rights via
> > +        * an, as yet to be defined method.
> > +        */
> > +       pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
> > +       if (FIELD_GET(PCI_DOE_STATUS_BUSY, val))
> > +               return -EBUSY;
> > +
> > +       if (FIELD_GET(PCI_DOE_STATUS_ERROR, val))
> > +               return -EIO;
> > +
> > +       /* Write DOE Header */
> > +       val = FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_1_VID, ex->prot.vid) |
> > +               FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, ex->prot.type);
> > +       pci_write_config_dword(pdev, offset + PCI_DOE_WRITE, val);
> > +       /* Length is 2 DW of header + length of payload in DW */
> > +       pci_write_config_dword(pdev, offset + PCI_DOE_WRITE,
> > +                              FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH,
> > +                                         2 + ex->request_pl_sz /
> > +                                               sizeof(u32)));
> > +       for (i = 0; i < ex->request_pl_sz / sizeof(u32); i++)
> > +               pci_write_config_dword(pdev, offset + PCI_DOE_WRITE,
> > +                                      ex->request_pl[i]);
> > +
> > +       val = PCI_DOE_CTRL_GO;
> > +       if (doe->irq)
> > +               val |= PCI_DOE_CTRL_INT_EN;
> > +
> > +       pci_write_config_dword(pdev, offset + PCI_DOE_CTRL, val);
> > +       /* Request is sent - now wait for poll or IRQ */
> > +       return 0;
> > +}
> > +
> > +static int pci_doe_recv_resp(struct pci_doe *doe, struct pci_doe_exchange *ex)
> > +{
> > +       struct pci_dev *pdev = doe->doe_dev->pdev;
> > +       int offset = doe->doe_dev->cap_offset;
> > +       size_t length;
> > +       u32 val;
> > +       int i;
> > +
> > +       /* Read the first dword to get the protocol */
> > +       pci_read_config_dword(pdev, offset + PCI_DOE_READ, &val);
> > +       if ((FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_VID, val) != ex->prot.vid) ||
> > +           (FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, val) != ex->prot.type)) {
> > +               pci_err(pdev,
> > +                       "Expected [VID, Protocol] = [%#x, %#x], got [%#x, %#x]\n",
> > +                       ex->prot.vid, ex->prot.type,
> > +                       FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_VID, val),
> > +                       FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, val));
> > +               return -EIO;
> > +       }
> > +
> > +       pci_write_config_dword(pdev, offset + PCI_DOE_READ, 0);
> > +       /* Read the second dword to get the length */
> > +       pci_read_config_dword(pdev, offset + PCI_DOE_READ, &val);
> > +       pci_write_config_dword(pdev, offset + PCI_DOE_READ, 0);
> > +
> > +       length = FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH, val);
> > +       if (length > SZ_1M || length < 2)
> > +               return -EIO;
> > +
> > +       /* First 2 dwords have already been read */
> > +       length -= 2;
> > +       /* Read the rest of the response payload */
> > +       for (i = 0; i < min(length, ex->response_pl_sz / sizeof(u32)); i++) {
> > +               pci_read_config_dword(pdev, offset + PCI_DOE_READ,
> > +                                     &ex->response_pl[i]);
> > +               pci_write_config_dword(pdev, offset + PCI_DOE_READ, 0);
> > +       }
> > +
> > +       /* Flush excess length */
> > +       for (; i < length; i++) {
> > +               pci_read_config_dword(pdev, offset + PCI_DOE_READ, &val);
> > +               pci_write_config_dword(pdev, offset + PCI_DOE_READ, 0);
> > +       }
> > +       /* Final error check to pick up on any since Data Object Ready */
> > +       pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
> > +       if (FIELD_GET(PCI_DOE_STATUS_ERROR, val))
> > +               return -EIO;
> > +
> > +       return min(length, ex->response_pl_sz / sizeof(u32)) * sizeof(u32);
> > +}
> > +
> > +static void doe_statemachine_work(struct work_struct *work)
> > +{
> > +       struct delayed_work *w = to_delayed_work(work);
> > +       struct pci_doe *doe = container_of(w, struct pci_doe, statemachine);
> > +       struct pci_dev *pdev = doe->doe_dev->pdev;
> > +       int offset = doe->doe_dev->cap_offset;
> > +       struct pci_doe_task *task;
> > +       bool abort;
> > +       u32 val;
> > +       int rc;
> > +
> > +       mutex_lock(&doe->state_lock);
> > +       task = doe->cur_task;
> > +       abort = doe->abort;
> > +       doe->abort = false;
> > +       mutex_unlock(&doe->state_lock);
> > +
> > +       if (abort) {
> > +               /*
> > +                * Currently only used during init - care needed if
> > +                * pci_doe_abort() is generally exposed as it would impact
> > +                * queries in flight.
> > +                */
> > +               WARN_ON(task);
> 
> Why is it worth potentially crashing the kernel here? Is this purely a
> situation that will only happen during development  and refactoring of
> the driver? Otherwise I would expect handling the error without WARN.

I think currently this is only something which may happen during development.
But I think it would be worth throwing a pr_err() and we need to completing the
task when the state machine finally resets.

As I work on this I'm seeing a number of ways to simplify the state machine.
If Jonathan does not mind I'm going to send a series of small patches to the
state machine directly to him for review before I squash them into this patch.

I think that will be easier to review the changes I'm making and hopefully
verify correctness.

[snip]

> > +
> > +       case DOE_WAIT_ABORT:
> > +       case DOE_WAIT_ABORT_ON_ERR:
> > +               pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
> > +
> > +               if (!FIELD_GET(PCI_DOE_STATUS_ERROR, val) &&
> > +                   !FIELD_GET(PCI_DOE_STATUS_BUSY, val)) {
> > +                       /* Back to normal state - carry on */
> > +                       mutex_lock(&doe->state_lock);
> > +                       doe->cur_task = NULL;
> > +                       mutex_unlock(&doe->state_lock);
> > +                       wake_up_interruptible(&doe->wq);
> > +
> > +                       /*
> > +                        * For deliberately triggered abort, someone is
> > +                        * waiting.
> > +                        */
> > +                       if (doe->state == DOE_WAIT_ABORT)
> > +                               complete(&doe->abort_c);
> 
> Why is a completion and waitqueue needed? I.e. a waiter could simply
> look for an abort completion flag to be set instead.

I agree with Dan here regarding the reduction of machinery but it seems that a
call to abort could come from someone not waiting on the current task?  Is that
true?

This is why their is a separate completion AFAICS.  But I don't follow the use
case for that?

What is currently done is for the DOE mailbox to signal an abort without a task
running.  Therefore there is nothing waiting on the wait queue.

We could flag a special task called 'abort' but this will not support a thread
calling abort separate from the task queue.  Essentially there would not be a
way to abort a queue of waiters.  But again I don't see that use case
currently.

[snip]

> > +
> > +/**
> > + * pci_doe_exchange_sync() - Send a request, then wait for and receive a
> > + *                          response
> > + * @doe_dev: DOE mailbox state structure
> > + * @ex: Description of the buffers and Vendor ID + type used in this
> > + *      request/response pair
> > + *
> > + * Excess data will be discarded.
> > + *
> > + * RETURNS: payload in bytes on success, < 0 on error
> > + */
> > +int pci_doe_exchange_sync(struct pci_doe_dev *doe_dev,
> > +                         struct pci_doe_exchange *ex)
> > +{
> > +       struct pci_doe *doe = dev_get_drvdata(&doe_dev->adev.dev);
> > +       struct pci_doe_task task;
> > +       DECLARE_COMPLETION_ONSTACK(c);
> > +
> > +       if (!doe)
> > +               return -EAGAIN;
> > +
> > +       /* DOE requests must be a whole number of DW */
> > +       if (ex->request_pl_sz % sizeof(u32))
> > +               return -EINVAL;
> > +
> > +       task.ex = ex;
> > +       task.cb = pci_doe_task_complete;
> > +       task.private = &c;
> > +
> > +again:
> > +       mutex_lock(&doe->state_lock);
> > +       if (doe->cur_task) {
> > +               mutex_unlock(&doe->state_lock);
> > +               wait_event_interruptible(doe->wq, doe->cur_task == NULL);
> > +               goto again;
> > +       }
> > +
> > +       if (doe->dead) {
> > +               mutex_unlock(&doe->state_lock);
> > +               return -EIO;
> > +       }
> > +       doe->cur_task = &task;
> > +       schedule_delayed_work(&doe->statemachine, 0);
> > +       mutex_unlock(&doe->state_lock);
> > +
> > +       wait_for_completion(&c);
> 
> I would expect that the caller of this routine would want to specify
> the task and end_task() callback and use that as the completion
> signal. It may also want "no wait" behavior where it is prepared for
> the DOE result to come back sometime later. With that change the
> exchange fields can move into the task directly.

Yep done.

[snip]

> > +
> > +static int pci_doe_abort(struct pci_doe *doe)
> > +{
> > +       reinit_completion(&doe->abort_c);
> > +       mutex_lock(&doe->state_lock);
> > +       doe->abort = true;
> 
> Why not a flags field where atomic bitops can be used without need for a mutex.

At first I agreed with Jonathan however, after some refactoring I think the
atomics would be nice.

> 
> > +       mutex_unlock(&doe->state_lock);
> > +       schedule_delayed_work(&doe->statemachine, 0);
> > +       wait_for_completion(&doe->abort_c);
> > +
> > +       if (doe->dead)
> 
> dead could also be another atomic flag.

Yep.

I've also changed state_lock to be task_lock as that clarifies what is being
protected.

[snip]

> > +static int pci_doe_probe(struct auxiliary_device *aux_dev,
> > +                        const struct auxiliary_device_id *id)
> > +{
> > +       struct pci_doe_dev *doe_dev = container_of(aux_dev,
> > +                                       struct pci_doe_dev,
> > +                                       adev);
> > +       struct pci_doe *doe;
> > +       int rc;
> > +
> > +       doe = devm_kzalloc(&aux_dev->dev, sizeof(*doe), GFP_KERNEL);
> > +       if (!doe)
> > +               return -ENOMEM;
> > +
> > +       mutex_init(&doe->state_lock);
> > +       init_completion(&doe->abort_c);
> > +       doe->doe_dev = doe_dev;
> > +       init_waitqueue_head(&doe->wq);
> > +       INIT_DELAYED_WORK(&doe->statemachine, doe_statemachine_work);
> > +       dev_set_drvdata(&aux_dev->dev, doe);
> > +
> > +       rc = pci_doe_reg_irq(doe);
> > +       if (rc)
> > +               return rc;
> > +
> > +       /* Reset the mailbox by issuing an abort */
> > +       rc = pci_doe_abort(doe);
> > +       if (rc)
> > +               return rc;
> > +
> > +       rc = pci_doe_cache_protocols(doe);
> > +       if (rc)
> > +               return rc;
> 
> This can just be:
> 
>  return pci_doe_cache_protocols(doe);

Already suggested by Bjorn and done.

> 
> > +
> > +       return 0;
> > +}
> > +
> > +static void pci_doe_remove(struct auxiliary_device *aux_dev)
> > +{
> > +       struct pci_doe *doe = dev_get_drvdata(&aux_dev->dev);
> > +
> > +       /* First halt the state machine */
> > +       cancel_delayed_work_sync(&doe->statemachine);
> > +}
> > +
> > +static const struct auxiliary_device_id pci_doe_auxiliary_id_table[] = {
> > +       {},
> > +};
> > +
> > +MODULE_DEVICE_TABLE(auxiliary, pci_doe_auxiliary_id_table);
> 
> Why is this empty table here?

Filling the id table was done in the next patch.

The split of the patches may have been a bit arbitrary here.  This patch was
focused on the state machine and probing of the mailboxes.  The next patch
provided the helper function to create all the DOE devices for a given
PCI device; pci_doe_create_doe_devices()

> 
> > +
> > +struct auxiliary_driver pci_doe_auxiliary_drv = {
> > +       .name = "pci_doe",
> > +       .id_table = pci_doe_auxiliary_id_table,
> > +       .probe = pci_doe_probe,
> > +       .remove = pci_doe_remove
> > +};
> 
> I expect that these helpers would be provided by the PCI core, but
> then a subsystem like CXL would have code to register their auxiliary
> devices and drivers that mostly just wrap the PCI core DOE
> implementation.

Ah ok, I think I see what you are saying.  That is not quite as straight
forward a use of the auxiliary bus but I _think_ it will work.  I'll also
attempt to clarify with documentation how the above probe/remove functions are
to be used by those defining their own drivers.

Ira

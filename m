Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 855234AF69E
	for <lists+linux-pci@lfdr.de>; Wed,  9 Feb 2022 17:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237039AbiBIQ1T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Feb 2022 11:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236957AbiBIQ0z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Feb 2022 11:26:55 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C80EC05CB8E
        for <linux-pci@vger.kernel.org>; Wed,  9 Feb 2022 08:26:54 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id 10so2670913plj.1
        for <linux-pci@vger.kernel.org>; Wed, 09 Feb 2022 08:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OICp1HRczZzYOkc4wKUE1yhT6mvj2zAlw95OIF05MXg=;
        b=4Vdl3xZpfYBUxqUCysoimWFjvBPNCUQL7lgN0dQPuT3n31n6jz/IHzqnAyVfmX3ygo
         ryS0wlZqrXTwjTs/wvdSdboznwDexfxViPmqyu4jtvmL8tFQOrckTbzjNCE4osu/WDuz
         Xhf7wBL0WJNCNnjWZMZ99AymjSc1A65fHD6nOxIe7hxh5pfSsk2txWt+IDeNLjP9knCD
         KI2M7b5oU66ndrke1RWrrRcMgpSUhS3eqMhS4b1w8390/xjOdig40Q4t7T8EivaYT2WZ
         SsPTpbcfqJqpbOZ1QwoAJSx+y0nUnCE4A+ZSODy3Zj+3hXzx+eWjHQpB/5rqkavG5zBN
         rzQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OICp1HRczZzYOkc4wKUE1yhT6mvj2zAlw95OIF05MXg=;
        b=r3pGpwSYRVoYSAVhi94eFTu/qZPiwMzN6h+nz706qSzYtgXgGhA2NR468F91adYUu5
         DnJfu68oBSILVtloJX+Hh6eQ+VmTO2pbvjcaqpUMGR7XYKDULvLZKVjRcMzXCcfai90n
         yyd3JBVaTEmds5tJRmM0k6EbGr8GU6heB4aR1RXMgOgHjjp1csagO4fqVoOFcFeoU2jB
         FooP082cLb/U71jQ9CYOWHZ5AhzFWVBR0Jo6YuaWyZIpsHMoJ07DVl7uwi6s2kYsQch6
         NBs5dfZk3inDCN1Uc+qHDd0N4FoakWPGa8R63LCiPzg0MlE53wZ5JNyu4BNcdeoTUAFY
         KVtg==
X-Gm-Message-State: AOAM531wLHEQwa4IycP3i5hxYx19hVhbzZj+PqEFfjvEZhwLBpuARsZh
        adcwpRns953Q+9tbPphcMGXhmLropWjN70LeL3gGwQ==
X-Google-Smtp-Source: ABdhPJzrtLR9qU2+zlBusWYhBUolzrRbT6Vyuvr3sPn1I+jDO/rkU0A9BDoZHK+wxpyvvC3ToUijdFpTPHDbG+9+0Sc=
X-Received: by 2002:a17:90b:3ece:: with SMTP id rm14mr3391273pjb.220.1644424014258;
 Wed, 09 Feb 2022 08:26:54 -0800 (PST)
MIME-Version: 1.0
References: <20220201071952.900068-1-ira.weiny@intel.com> <20220201071952.900068-4-ira.weiny@intel.com>
 <CAPcyv4hYAgyf-WcArGvbWHAJgc5+p=OO_6ah_dXJhNM5cXcVTw@mail.gmail.com> <20220209101320.00000473@Huawei.com>
In-Reply-To: <20220209101320.00000473@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 9 Feb 2022 08:26:43 -0800
Message-ID: <CAPcyv4g2nNHKPuYVOEH3TbJtCiB1rkRNCVbfDWHnWkotvTAcJg@mail.gmail.com>
Subject: Re: [PATCH V6 03/10] PCI/DOE: Add Data Object Exchange Aux Driver
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     "Weiny, Ira" <ira.weiny@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 9, 2022 at 2:13 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
[..]
> > > + *
> > > + * @doe_dev: The DOE Auxiliary device being driven
> > > + * @abort_c: Completion used for initial abort handling
> > > + * @irq: Interrupt used for signaling DOE ready or abort
> > > + * @irq_name: Name used to identify the irq for a particular DOE
> > > + * @prots: Array of identifiers for protocols supported
> >
> > "prot" already has a meaning in the kernel, just spell out
> > "protocols". This also looks like something that can be allocated
> > inline rather than out of line i.e.:
> >
> > struct pci_doe {
> > ...
> >     int nr_protocols
> >     struct pci_doe_protocol protocols[];
> > }
> >
> > ...and then use struct_size() to allocate it.
>
> Can't do that. The size isn't known when we first start using
> this structure - We need to use it to query what protocols are
> supported.  It's initially set to 1 to cover the discovery
> protocol and then we realloc to expand it as we discover more
> protocols.

Ok.

>
> >
> > > + * @num_prots: Size of prots array
> > > + * @cur_task: Current task the state machine is working on
> > > + * @wq: Wait queue to wait on if a query is in progress
> > > + * @state_lock: Protect the state of cur_task, abort, and dead
> > > + * @statemachine: Work item for the DOE state machine
> > > + * @state: Current state of this DOE
> > > + * @timeout_jiffies: 1 second after GO set
> > > + * @busy_retries: Count of retry attempts
> > > + * @abort: Request a manual abort (e.g. on init)
> > > + * @dead: Used to mark a DOE for which an ABORT has timed out. Further messages
> > > + *        will immediately be aborted with error
> > > + */
> > > +struct pci_doe {
> > > +       struct pci_doe_dev *doe_dev;
> > > +       struct completion abort_c;
> > > +       int irq;
> > > +       char *irq_name;
> > > +       struct pci_doe_protocol *prots;
> > > +       int num_prots;
> > > +
> > > +       struct pci_doe_task *cur_task;
> > > +       wait_queue_head_t wq;
> > > +       struct mutex state_lock;
> > > +       struct delayed_work statemachine;
> > > +       enum pci_doe_state state;
> > > +       unsigned long timeout_jiffies;
> > > +       unsigned int busy_retries;
> > > +       unsigned int abort:1;
> > > +       unsigned int dead:1;
> > > +};
> > > +
> > > +static irqreturn_t pci_doe_irq(int irq, void *data)
> > > +{
> > > +       struct pci_doe *doe = data;
> > > +       struct pci_dev *pdev = doe->doe_dev->pdev;
> > > +       int offset = doe->doe_dev->cap_offset;
> > > +       u32 val;
> > > +
> > > +       pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
> > > +
> > > +       /* Leave the error case to be handled outside IRQ */
> > > +       if (FIELD_GET(PCI_DOE_STATUS_ERROR, val)) {
> > > +               mod_delayed_work(system_wq, &doe->statemachine, 0);
> > > +               return IRQ_HANDLED;
> > > +       }
> > > +
> > > +       if (FIELD_GET(PCI_DOE_STATUS_INT_STATUS, val)) {
> > > +               pci_write_config_dword(pdev, offset + PCI_DOE_STATUS,
> > > +                                       PCI_DOE_STATUS_INT_STATUS);
> > > +               mod_delayed_work(system_wq, &doe->statemachine, 0);
> > > +               return IRQ_HANDLED;
> > > +       }
> > > +
> > > +       return IRQ_NONE;
> > > +}
> > > +
> > > +/*
> > > + * Only call when safe to directly access the DOE, either because no tasks yet
> > > + * queued, or called from doe_statemachine_work() which has exclusive access to
> > > + * the DOE config space.
> >
> > It doesn't have exclusive access unless the patch to lock out
> > userspace config writes are revived. Instead, I like Bjorn's idea of
> > tracking and warning / tainting, but not blocking conflicting
> > userspace access to sensitive configuration registers.
> >
> > Yes, it was somewhat of a throw-away comment from Bjorn in that
> > thread, "(and IMO should taint the kernel)", but DOE can do so much
> > subtle damage (compliance test modes, link-encryption / disruption,
> > vendor private who-knows-what...) that I think it behooves us as
> > kernel developers to know when we are debugging system behavior that
> > may be the result of non-kernel mitigated DOE access. The proposal is
> > that when kernel lockdown is not enabled, use the approach from the
> > exclusive config access patch [2] to trap, warn (once per device?),
> > and taint when userspace writes to DOE registers that have been
> > claimed by the kernel. This lets strict environments use
> > kernel-lockdown to block userspace DOE access altogether, in
> > non-strict environment it discourages userspace from clobbering DOE
> > driver state, and it allows a warn-free path if userspace takes the
> > step of at least unbinding the kernel DOE driver before running
> > userspace DOE cycles.
> >
> > [1]: https://lore.kernel.org/r/20211203235617.GA3036259@bhelgaas
> > [2]: https://lore.kernel.org/all/161663543465.1867664.5674061943008380442.stgit@dwillia2-desk3.amr.corp.intel.com/
>
> Good info. I'd missed some of the subtle parts of that discussion.
>
> >
> > > + */
> > > +static void pci_doe_abort_start(struct pci_doe *doe)
> > > +{
> > > +       struct pci_dev *pdev = doe->doe_dev->pdev;
> > > +       int offset = doe->doe_dev->cap_offset;
> > > +       u32 val;
> > > +
> > > +       val = PCI_DOE_CTRL_ABORT;
> > > +       if (doe->irq)
> > > +               val |= PCI_DOE_CTRL_INT_EN;
> > > +       pci_write_config_dword(pdev, offset + PCI_DOE_CTRL, val);
> > > +
> > > +       doe->timeout_jiffies = jiffies + HZ;
> > > +       schedule_delayed_work(&doe->statemachine, HZ);
> >
> > Given the spec timeout is 1 second and the device clock might be
> > slightly off from the host clock how about make this a more generous
> > 1.5 or 2 seconds?
>
> Makes sense. Though if a clock is bad enough we need 2 seconds that
> is pretty awful! :)

Perhaps, though DOE is not a fast path, and block I/O defaults to a 30
second timeout, so I don't think anyone would blink at a 2 seconds for
DOE.

>
> >
> > > +}
> > > +
> > > +static int pci_doe_send_req(struct pci_doe *doe, struct pci_doe_exchange *ex)
> >
> > The relationship between tasks, requests, responses, and exchanges is
> > not immediately clear to me. For example, can this helper be renamed
> > in terms of its relationship to a task? A theory of operation document
> > would help, but it seems there is also room for the implementation to
> > be more self documenting.
>
> Not totally sure what such naming would be.
>
> A task is the management wrapper around an exchange which is a request
> + response pair.  In the sense you queue a task which will carry out
> and exchange by sending a request and receiving a response.
>
> Could rename this pci_doe_start_exchange() but that then obscures
> that we mean send the request to the hardware and removes the resemblance
> to what I recall the specification uses.

I'm not a big fan of copying spec names *if* Linux has a more
idiomatic name for the concept. I am mainly reviewing this from the
perspective that 'struct bio' and 'struct request' naming /
organization is idiomatic for Linux driver transaction flows. Up to
this point in the review I was mapping tasks to bios and exchanges to
requests but then the usage of "req" in this function name threw off
my ontology. At a minimum a decoder ring style comment, like your
reply, about the relationship between these terms would help avoid
this exercise again.

> > > +       case DOE_WAIT_ABORT:
> > > +       case DOE_WAIT_ABORT_ON_ERR:
> > > +               pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
> > > +
> > > +               if (!FIELD_GET(PCI_DOE_STATUS_ERROR, val) &&
> > > +                   !FIELD_GET(PCI_DOE_STATUS_BUSY, val)) {
> > > +                       /* Back to normal state - carry on */
> > > +                       mutex_lock(&doe->state_lock);
> > > +                       doe->cur_task = NULL;
> > > +                       mutex_unlock(&doe->state_lock);
> > > +                       wake_up_interruptible(&doe->wq);
> > > +
> > > +                       /*
> > > +                        * For deliberately triggered abort, someone is
> > > +                        * waiting.
> > > +                        */
> > > +                       if (doe->state == DOE_WAIT_ABORT)
> > > +                               complete(&doe->abort_c);
> >
> > Why is a completion and waitqueue needed? I.e. a waiter could simply
> > look for an abort completion flag to be set instead.
>
> You mean use the main completion (the one for the non abort case)
> and a flag?
>
> Or a wait_event() with appropriate check?
>
> Could do that but I'm not sure I understand why we care either way?

Just reduction in machinery that needs to be maintained /
comprehended. 2 wait primitives when one will do will always be a
tempting cleanup target.

[..]
> > > +/**
> > > + * pci_doe_exchange_sync() - Send a request, then wait for and receive a
> > > + *                          response
> > > + * @doe_dev: DOE mailbox state structure
> > > + * @ex: Description of the buffers and Vendor ID + type used in this
> > > + *      request/response pair
> > > + *
> > > + * Excess data will be discarded.
> > > + *
> > > + * RETURNS: payload in bytes on success, < 0 on error
> > > + */
> > > +int pci_doe_exchange_sync(struct pci_doe_dev *doe_dev,
> > > +                         struct pci_doe_exchange *ex)
> > > +{
> > > +       struct pci_doe *doe = dev_get_drvdata(&doe_dev->adev.dev);
> > > +       struct pci_doe_task task;
> > > +       DECLARE_COMPLETION_ONSTACK(c);
> > > +
> > > +       if (!doe)
> > > +               return -EAGAIN;
> > > +
> > > +       /* DOE requests must be a whole number of DW */
> > > +       if (ex->request_pl_sz % sizeof(u32))
> > > +               return -EINVAL;
> > > +
> > > +       task.ex = ex;
> > > +       task.cb = pci_doe_task_complete;
> > > +       task.private = &c;
> > > +
> > > +again:
> > > +       mutex_lock(&doe->state_lock);
> > > +       if (doe->cur_task) {
> > > +               mutex_unlock(&doe->state_lock);
> > > +               wait_event_interruptible(doe->wq, doe->cur_task == NULL);
> > > +               goto again;
> > > +       }
> > > +
> > > +       if (doe->dead) {
> > > +               mutex_unlock(&doe->state_lock);
> > > +               return -EIO;
> > > +       }
> > > +       doe->cur_task = &task;
> > > +       schedule_delayed_work(&doe->statemachine, 0);
> > > +       mutex_unlock(&doe->state_lock);
> > > +
> > > +       wait_for_completion(&c);
> >
> > I would expect that the caller of this routine would want to specify
> > the task and end_task() callback and use that as the completion
> > signal. It may also want "no wait" behavior where it is prepared for
> > the DOE result to come back sometime later. With that change the
> > exchange fields can move into the task directly.
>
> This is the simple synchronous wrapper around an async core.
> If we want an async path at somepoint in the future where we have
> someone using it then sure, we can have an async version that
> takes the callback.

It just seems an unnecessary hunk of code for the core to carry when
it's trivial for a client of the core to do:

task->private = &completion;
task->end_task = complete_completion;
submit_task()
wait_for_completion(&completion);

> > > +       return task.rv;
> > > +}
> > > +EXPORT_SYMBOL_GPL(pci_doe_exchange_sync);
> > > +
> > > +/**
> > > + * pci_doe_supports_prot() - Return if the DOE instance supports the given
> > > + *                          protocol
> > > + * @pdev: Device on which to find the DOE instance
> > > + * @vid: Protocol Vendor ID
> > > + * @type: protocol type
> > > + *
> > > + * This device can then be passed to pci_doe_exchange_sync() to execute a
> > > + * mailbox exchange through that DOE mailbox.
> > > + *
> > > + * RETURNS: True if the DOE device supports the protocol specified
> > > + */
> > > +bool pci_doe_supports_prot(struct pci_doe_dev *doe_dev, u16 vid, u8 type)
> > > +{
> > > +       struct pci_doe *doe = dev_get_drvdata(&doe_dev->adev.dev);
> > > +       int i;
> > > +
> > > +       if (!doe)
> > > +               return false;
> > > +
> > > +       for (i = 0; i < doe->num_prots; i++)
> > > +               if ((doe->prots[i].vid == vid) &&
> > > +                   (doe->prots[i].type == type))
> > > +                       return true;
> > > +
> > > +       return false;
> > > +}
> > > +EXPORT_SYMBOL_GPL(pci_doe_supports_prot);
> > > +
> > > +static int pci_doe_discovery(struct pci_doe *doe, u8 *index, u16 *vid,
> > > +                            u8 *protocol)
> > > +{
> > > +       u32 request_pl = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX,
> > > +                                   *index);
> > > +       u32 response_pl;
> > > +       struct pci_doe_exchange ex = {
> > > +               .prot.vid = PCI_VENDOR_ID_PCI_SIG,
> > > +               .prot.type = PCI_DOE_PROTOCOL_DISCOVERY,
> > > +               .request_pl = &request_pl,
> > > +               .request_pl_sz = sizeof(request_pl),
> > > +               .response_pl = &response_pl,
> > > +               .response_pl_sz = sizeof(response_pl),
> > > +       };
> > > +       int ret;
> > > +
> > > +       ret = pci_doe_exchange_sync(doe->doe_dev, &ex);
> > > +       if (ret < 0)
> > > +               return ret;
> > > +
> > > +       if (ret != sizeof(response_pl))
> > > +               return -EIO;
> > > +
> > > +       *vid = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID, response_pl);
> > > +       *protocol = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL,
> > > +                             response_pl);
> > > +       *index = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX,
> > > +                          response_pl);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int pci_doe_cache_protocols(struct pci_doe *doe)
> > > +{
> > > +       u8 index = 0;
> > > +       int num_prots;
> > > +       int rc;
> > > +
> > > +       /* Discovery protocol must always be supported and must report itself */
> > > +       num_prots = 1;
> > > +       doe->prots = devm_kcalloc(&doe->doe_dev->adev.dev, num_prots,
> > > +                                 sizeof(*doe->prots), GFP_KERNEL);
> > > +       if (doe->prots == NULL)
> > > +               return -ENOMEM;
> > > +
> > > +       do {
> > > +               struct pci_doe_protocol *prot;
> > > +
> > > +               prot = &doe->prots[num_prots - 1];
> > > +               rc = pci_doe_discovery(doe, &index, &prot->vid, &prot->type);
> > > +               if (rc)
> > > +                       return rc;
> > > +
> > > +               if (index) {
> > > +                       struct pci_doe_protocol *prot_new;
> > > +
> > > +                       num_prots++;
> > > +                       prot_new = devm_krealloc(&doe->doe_dev->adev.dev,
> > > +                                                doe->prots,
> > > +                                                sizeof(*doe->prots) *
> > > +                                                       num_prots,
> > > +                                                GFP_KERNEL);
> > > +                       if (prot_new == NULL)
> > > +                               return -ENOMEM;
> > > +                       doe->prots = prot_new;
> > > +               }
> > > +       } while (index);
> > > +
> > > +       doe->num_prots = num_prots;
> > > +       return 0;
> > > +}
> > > +
> > > +static int pci_doe_abort(struct pci_doe *doe)
> > > +{
> > > +       reinit_completion(&doe->abort_c);
> > > +       mutex_lock(&doe->state_lock);
> > > +       doe->abort = true;
> >
> > Why not a flags field where atomic bitops can be used without need for a mutex.
>
> I'll go the other way, why bother with atomics when this isn't a high performance
> path or something expected to happen often?

It obfuscates what the lock is protecting if it's used for state
management and atomic flag management, but I am not holding the pen
here, so I can let this arbitrary trade-off go.

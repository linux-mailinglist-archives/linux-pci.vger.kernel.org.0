Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92159560223
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 16:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbiF2OJ4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 10:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbiF2OJz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 10:09:55 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567732CE13;
        Wed, 29 Jun 2022 07:09:52 -0700 (PDT)
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LY3FF44dbz67MtT;
        Wed, 29 Jun 2022 22:07:29 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 29 Jun 2022 16:09:50 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.24; Wed, 29 Jun
 2022 15:09:48 +0100
Date:   Wed, 29 Jun 2022 15:09:47 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
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
Message-ID: <20220629150947.000012be@Huawei.com>
In-Reply-To: <YrtGcNWcmzumj2gA@iweiny-desk3>
References: <20220628041527.742333-1-ira.weiny@intel.com>
 <20220628041527.742333-4-ira.weiny@intel.com>
 <20220628151626.00001c0f@Huawei.com>
 <YrtGcNWcmzumj2gA@iweiny-desk3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
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

On Tue, 28 Jun 2022 11:20:32 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> On Tue, Jun 28, 2022 at 03:16:26PM +0100, Jonathan Cameron wrote:
> > On Mon, 27 Jun 2022 21:15:21 -0700
> > ira.weiny@intel.com wrote:
> >   
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > 
> > > Introduced in a PCIe r6.0, sec 6.30, DOE provides a config space based
> > > mailbox with standard protocol discovery.  Each mailbox is accessed
> > > through a DOE Extended Capability.
> > > 
> > > Each DOE mailbox must support the DOE discovery protocol in addition to
> > > any number of additional protocols.
> > > 
> > > Define core PCIe functionality to manage a single PCIe DOE mailbox at a
> > > defined config space offset.  Functionality includes iterating,
> > > creating, query of supported protocol, and task submission.  Destruction
> > > of the mailboxes is device managed.
> > > 
> > > If interrupts are desired, the interrupt number can be queried and
> > > passed to the create function.  Passing a negative value disables
> > > interrupts for that mailbox.  It is the caller's responsibility to ensure
> > > enough interrupt vectors are allocated.
> > > 
> > > Cc: "Li, Ming" <ming4.li@intel.com>
> > > Cc: Bjorn Helgaas <helgaas@kernel.org>
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > >   
> > Hi Ira,
> > 
> > Thanks for keeping at this!
> > 
> > I think this has reintroduced some of the races around that annoying
> > interrupt source form BUSY transitioning to low that has
> > no explicit 'cause' flag.  I think we'd hammered all those out in the
> > previous version but maybe there were still some there...  
> 
> Well I really tried hard not to introduce races which would be a problem.  But
> I would not be surprised.
> 
> > 
> > I 'think' it will work as is, but depending on the timing a given DOE
> > implementation has, the interrupt may be completely pointless as it
> > will be signaling the wrong event.  
> 
> :-/
> 
> There is a chance that an IRQ comes in just after we timeout waiting for it.  I
> think that has always been the case and the IRQ will effectively be missed I
> _think_.

The timeout case I'm not that worried about as it means the device
is out of spec, so whilst it might happen and we don't want to break in that
case it should be uncommon enough that a perf disadvantage doesn't matter.


...

> > > +
> > > +static void doe_statemachine_work(struct work_struct *work)
> > > +{
> > > +	struct pci_doe_task *task = container_of(work, struct pci_doe_task,
> > > +						 work);
> > > +	struct pci_doe_mb *doe_mb = task->doe_mb;
> > > +	struct pci_dev *pdev = doe_mb->pdev;
> > > +	int offset = doe_mb->cap_offset;
> > > +	unsigned int busy_retries = 0;
> > > +	unsigned long timeout_jiffies;
> > > +	u32 val;
> > > +	int rc;
> > > +
> > > +	if (test_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags)) {
> > > +		signal_task_complete(task, -EIO);
> > > +		return;
> > > +	}
> > > +
> > > +	/* Send request */
> > > +retry_req:
> > > +	if (pci_doe_arm_wait(doe_mb)) {
> > > +		signal_task_abort(task, -EIO);
> > > +		return;
> > > +	}  
> > 
> > Is there a race here?  If Busy drops at this point we queue up
> > a message, but IRQ bit is already set.  Hence when we hit
> > wait_event_timeout() the flag is already set and IIRC we'll
> > drop straight through.
> >  
> 
> I did not realize that the device would interrupt when Busy dropped?  I was
> thinking that V11 did not respond to IRQ but indeed it did via setting the work
> item to run immediately...
> 
> However, I only see this in the spec:
> 
> 1) System firmware/software checks that the DOE Busy bit is Clear to ensure
>    that the DOE instance is ready to receive a DOE request.

I missed this particular one originally and someone else pointed it out in
review (can't remember who though). The busy drop is mentioned in the
bit definition. It's in the capability definition.

"DOE Interrupt Status - This bit must be Set when an interrupt is generated
to indicate that the Data Object Ready bit or the DOE Error bit has been Set. or
 that the DOE Busy bit has been Cleared."
(the formatting is in the release spec.. hohum)

Anyhow, upshot is that the status can be set as a result of Busy Bit clearing.
6.30.3 Interrupt Geneeration:  then says that interrupt is generate on a
transition of the logical AND of

1. Vector unmasked
2. DOE interrupt Enable bit is 1
3. Value of the DOE interrupt Status bit is 1.

So if interrupt status bit is set to 1 due to a Busy drop and we then
clear it before Data Object Ready, we'll get 2 interrupts.

There is another vague bit of language that sort of allows other
uses of this interrupt for protocol specific stuff.  Hopefully
no one falls for that, but we should safely handle that case (perf
drop as a result is fine though!)  I can't remember where the exact
language is, but I've had a few 'polite discussions' to persuade
people using it that way would be a very bad idea...



> 
> > 
> > It'll probably be fine because it will end up polling below
> > but doesn't look ideal.  
> 
> I agree it would not be ideal but I think if we are waiting for Busy to be
> cleared then the pci_doe_arm_wait() should be benign.

I think in some of these paths we are waiting for Data Object Ready to be
set, the busy drop is effectively acting as a spurious interrupt if we
clear the status before the data object ready event which could be much later
because of Busy can clear really quickly.

> 
> > 
> > Upshot is that you sort of have to handle "spurious interrupts"
> > cleanly and rewait on the interrupt if you get one whilst also handling
> > race conditions around RW1C of the interrupt status flag.  
> 
> Sorry I'm not sure what 'RW1C' means here?

Read / Write 1 to clear.  In this case I meant reading it and then clearing it
without looking at the other status bits.

> 
> Anyway, spurious interrupts was something I was concerned about but I don't
> think there is anything we can do about an interrupt coming in when we are
> expecting one but the device did not really send one.  AFAIK that is virtually
> impossible anyway.

In this case seeing 2 interrupts is highly likely.
We see the Busy drop one and the interrupt handler clears the Interrupt Status
Bit, then data object becomes ready and we go around again.

> 
> If we actually 'miss' one because we timed out before the device sent it then I
> think we are going to ignore the PCI_DOE_FLAG_IRQ flag on the next go around.
> 
> Actually timeout is handled by the abort call and that IRQ will, depending on
> timing, cause a full PCI_DOE_TIMEOUT to expire.  :-(  That is indeed not
> ideal.  However, by that time the error and busy flags should be clear and we
> can safely continue.  Otherwise we are going to take the mailbox down.
> 
> It may seem better to arm wait on each iteration through the abort loop.  But
> this is not logically correct because the abort operation should trigger an
> IRQ.  So there is always a race if we missed an IRQ because we timed out early.

I probably stuck that comment in the wrong place.  The initial call to clear
the flag before this should be fine (short of the 'spurious' case of people
using the interrupt for protocol specific usage).

> 
> > 
> >   
> > > +
> > > +	rc = pci_doe_send_req(doe_mb, task);
> > > +
> > > +	/*
> > > +	 * The specification does not provide any guidance on how long
> > > +	 * some other entity could keep the DOE busy, so try for 1
> > > +	 * second then fail. Busy handling is best effort only, because
> > > +	 * there is no way of avoiding racing against another user of
> > > +	 * the DOE.
> > > +	 */
> > > +	if (rc == -EBUSY) {
> > > +		busy_retries++;
> > > +		if (busy_retries == PCI_DOE_BUSY_MAX_RETRIES) {
> > > +			pci_warn(pdev,
> > > +				"[%x] busy for too long (> 1 sec)\n",
> > > +				offset);
> > > +			signal_task_complete(task, rc);
> > > +			return;
> > > +		}
> > > +		if (pci_doe_wait_poll(doe_mb, HZ / PCI_DOE_BUSY_MAX_RETRIES)) {
> > > +			signal_task_abort(task, rc);
> > > +			return;
> > > +		}
> > > +		goto retry_req;
> > > +	} else if (rc) {
> > > +		signal_task_abort(task, rc);
> > > +		return;
> > > +	}
> > > +
> > > +	timeout_jiffies = jiffies + HZ;
> > > +	if (pci_doe_wait_irq_or_poll(doe_mb)) {  
> > 
> > So this may well be passed as a result of a BUSY transition to 0 very soon
> > after the doe_send_req but well before the data is ready....  
> 
> I think the simple fix is to make the BUSY wait on an IRQ.  Something like:

 
> 
> 21:13:53 > git di
> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> index 12f9f8045eb7..afd326320798 100644
> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c
> @@ -352,7 +352,7 @@ static void doe_statemachine_work(struct work_struct *work)
>                         signal_task_complete(task, rc);
>                         return;
>                 }
> -               if (pci_doe_wait_poll(doe_mb, HZ / PCI_DOE_BUSY_MAX_RETRIES)) {
> +               if (pci_doe_wait_irq_or_poll(...)) {
>                         signal_task_abort(task, rc);
>                         return;

This case (which I think is the -EBUSY from pci_doe_send_req() handling)
isn't important because it's trying to paper over a weird condition. We
don't normally expect to get here.

I was concerned with the line just above my comment which may not act as
a gate at all because it's tripped by the the Busy Drop, which may be
well before the data object ready that we are actually waiting for.


>                 }
> 
> > 
> >   
> > > +		signal_task_abort(task, -EIO);
> > > +		return;
> > > +	}
> > > +
> > > +	/* Poll for response */
> > > +retry_resp:
> > > +	if (pci_doe_arm_wait(doe_mb)) {  
> > I think we can get here between Busy drop and Object Ready which means
> > this can get another IRQ_FLAG setting just after it.  Does it matter?
> > Don't think so, as we don't use that bit again in this run through
> > and it will be cleared at beginning of next one,  
> 
> Yea basically I agree.
> 
> > but if so why is
> > this call here?  
> 
> Seemed like the right thing to do at the time...  ;-)  j/k
> 
> > I think it's only useful for detecting an abort, if
> > so do that explicitly.  
> 
> Actually it is the right thing to do...  However, the wait poll below also
> needs to be an IRQ or poll.  I'm not sure how I missed that logic.

Sounds write though without whole code laid out to follow through I'm
not 100% sure yet!

> 
> >   
> > > +		signal_task_abort(task, -EIO);
> > > +		return;
> > > +	}
> > > +
> > > +	pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
> > > +	if (FIELD_GET(PCI_DOE_STATUS_ERROR, val)) {
> > > +		signal_task_abort(task, -EIO);
> > > +		return;
> > > +	}
> > > +
> > > +	if (!FIELD_GET(PCI_DOE_STATUS_DATA_OBJECT_READY, val)) {
> > > +		if (time_after(jiffies, timeout_jiffies)) {
> > > +			signal_task_abort(task, -ETIMEDOUT);
> > > +			return;
> > > +		}
> > > +		if (pci_doe_wait_poll(doe_mb, PCI_DOE_POLL_INTERVAL)) {  
> > 
> > Following on from above....
> > As a result of the interrupt having fired on the BUSY off transition,
> > I think we will almost always end up spinning here until Object Ready
> > is set.  Fine, but seems a shame we don't let an interrupt do this
> > for us in most cases.  (note in QEMU response is instantaneous so
> > when the interrupt for Busy drop is set, object ready also true so
> > by the time we get here data ready will already be sent).  
> 
> This needs to be pci_doe_wait_irq_or_poll() as well and the arm wait above
> ensures we continue to look for that interrupt.
> 
> I'm starting to see how I got confused.  The timeout values all vary and
> mod_delayed_work() made it very easy for you to interrupt any of those.

Yeah.  That was a nice suggestion Dan made long ago but it doesn't play well
with the single workqueue.

> 
> I tried to bundle the poll vs interrupt modes in pci_doe_wait_irq_or_poll() and
> got confused.  :-(
> 
> >   
> > > +			signal_task_abort(task, -EIO);
> > > +			return;
> > > +		}
> > > +		goto retry_resp;
> > > +	}
> > > +
> > > +	rc  = pci_doe_recv_resp(doe_mb, task);
> > > +	if (rc < 0) {
> > > +		signal_task_abort(task, rc);
> > > +		return;
> > > +	}
> > > +
> > > +	signal_task_complete(task, rc);
> > > +}
> > > +  
> > 
> >   
> > > +static void pci_doe_free_mb(struct pci_doe_mb *doe_mb)
> > > +{
> > > +	if (doe_mb->work_queue)  
> > 
> > I'm not a great fan of free functions that check a bunch of conditions
> > because they may be called before things are set up.  
> 
> I'll see what I can do.  I do kind of like this but I think it gets muddled and
> I'm not dead set on either way.
> 
> > To my
> > mind that generally means we should be calling individual cleanup
> > in the appropriate error handlers.
> > 
> > Either that or just use devm handling for each item. Sure
> > it's a few more lines of code, but I find it a lot easier to go
> > 
> > Oh look that thing we just set up is cleaned up by this.
> > 
> >   
> > > +		destroy_workqueue(doe_mb->work_queue);
> > > +	if (pci_doe_irq_enabled(doe_mb))
> > > +		pci_free_irq(doe_mb->pdev, doe_mb->int_msg_num, doe_mb);
> > > +	xa_destroy(&doe_mb->prots);
> > > +	kfree(doe_mb);
> > > +}
> > > +  
> > 
> > ...
> >   
> > > +
> > > +static void pci_doe_destroy_mb(void *mb)
> > > +{
> > > +	struct pci_doe_mb *doe_mb = mb;
> > > +
> > > +	/* Mark going down */
> > > +	set_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags);
> > > +
> > > +	/* Abort any in progress work items */
> > > +	pci_doe_abort(doe_mb);  
> > 
> > Abort is getting used for two things in here. Perhaps
> > rename this one to 
> > pci_doe_abort_tasks() or something like that?  
> 
> What do you mean two things?  Oh I think I see.  You mean abort the work item
> vs abort sent to the hardware?

yup.

> 
> This no longer aborts all the tasks just the one which may be in progress.
> Because the work queue is ordered only one task may be in progress.  I'll clean
> up the comment too.

Hmm. It puts a requirement on the caller to not queue multiple requests that
might require ordering.  One advantage of flushing the lot was ordering was
unaffected (though any caller that queued multiple items would have to then
requeue multiple items so would have to maintain their own retry buffer).

> 
> This sets the abort flag and wakes it up if it is sleeping.  If not then the
> abort flag will be detected in the next arm.
> 
> FWIW I think I may just remove this call and open code it here.

Sounds good, avoid naming confusion by getting rid of the name :)



> > > +
> > > +	doe_mb->work_queue = alloc_ordered_workqueue("DOE: [%x]", 0,
> > > +						     doe_mb->cap_offset);
> > > +	if (!doe_mb->work_queue) {
> > > +		pci_err(pdev, "[%x] failed to allocate work queue\n",
> > > +			doe_mb->cap_offset);
> > > +		pci_doe_free_mb(doe_mb);  
> > 
> > As above, I'd rather this explicitly freed what has been set up
> > and only that rather than calling a free function that does a bunch of
> > stuff conditionally.  
> 
> I think I can make that work.  This is the only conditional in free however,
> because the other conditional is the IRQ support which may not be set up.

If you split to multiple devm_ calls you can not setup a tear down for the
irq if we don't have one. Or, don't use pci_request_irq() but call
devm_request_threaded_irq() directly and let that clean up for you.


> 
> Thanks again for the in depth review!

No problem. I know how nasty this seemingly simple little bit of code
is, so you have my sympathies :)


Jonathan

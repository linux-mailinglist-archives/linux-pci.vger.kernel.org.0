Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26CF55577C2
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jun 2022 12:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiFWKYQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jun 2022 06:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiFWKYP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jun 2022 06:24:15 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57FE31391;
        Thu, 23 Jun 2022 03:24:13 -0700 (PDT)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LTGTs4XkFz686kD;
        Thu, 23 Jun 2022 18:20:17 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 23 Jun 2022 12:24:11 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 23 Jun
 2022 11:24:10 +0100
Date:   Thu, 23 Jun 2022 11:24:08 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V11 3/8] PCI: Create PCI library functions in support of
 DOE mailboxes.
Message-ID: <20220623112408.00006cd2@Huawei.com>
In-Reply-To: <YrOy3vodu3FcRjUY@iweiny-desk3>
References: <20220610202259.3544623-1-ira.weiny@intel.com>
        <20220610202259.3544623-4-ira.weiny@intel.com>
        <62ad06a643ddf_844b1294f@dwillia2-xfh.notmuch>
        <YrObe+AdfziEPlYB@iweiny-desk3>
        <62b39e5eead1_32f38a294b6@dwillia2-xfh.notmuch>
        <YrOy3vodu3FcRjUY@iweiny-desk3>
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

On Wed, 22 Jun 2022 17:25:02 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> On Wed, Jun 22, 2022 at 03:57:34PM -0700, Dan Williams wrote:
> > Ira Weiny wrote:  
> > > On Fri, Jun 17, 2022 at 03:56:38PM -0700, Dan Williams wrote:  
> > [..]  
> > > > > +static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16 *vid,
> > > > > +			     u8 *protocol)
> > > > > +{
> > > > > +	u32 request_pl = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX,
> > > > > +				    *index);
> > > > > +	u32 response_pl;
> > > > > +	DECLARE_COMPLETION_ONSTACK(c);
> > > > > +	struct pci_doe_task task = {
> > > > > +		.prot.vid = PCI_VENDOR_ID_PCI_SIG,
> > > > > +		.prot.type = PCI_DOE_PROTOCOL_DISCOVERY,
> > > > > +		.request_pl = &request_pl,
> > > > > +		.request_pl_sz = sizeof(request_pl),
> > > > > +		.response_pl = &response_pl,
> > > > > +		.response_pl_sz = sizeof(response_pl),
> > > > > +		.complete = pci_doe_task_complete,
> > > > > +		.private = &c,
> > > > > +	};
> > > > > +	int ret;
> > > > > +
> > > > > +	ret = pci_doe_submit_task(doe_mb, &task);
> > > > > +	if (ret < 0)
> > > > > +		return ret;
> > > > > +
> > > > > +	wait_for_completion(&c);  
> > > > 
> > > > Another place where the need for a completion can be replaced with
> > > > flush_work().  
> > > 
> > > No not here.  While this call is internal it is actually acting like an
> > > external caller.  This specific wait is for that response to get back.
> > > 
> > > This pattern was specifically asked for by you.  Previously Jonathan had a
> > > synchronous call which took care of this but you said let all callers just
> > > handle it themselves.  So all callers submit a task and if they want to wait
> > > for the response they have to do so themselves.  
> > 
> > Ah, true I remember that. The nice thing about a doing your own
> > wait_for_completion() like this is that you can make it
> > wait_for_completion_interruptible() to give up on the DOE if it gets
> > stalled. However, if you have a work item per-task and you're willing to
> > do an uninterruptible sleep, then flush_work(&task->work) is identical.  
> 
> So when you mentioned a work item per task I really jumped on that idea.  But I
> realize now that it is a bit more complicated than that.
> 
> Currently a work item is actually one step of the state machine.  The state
> machine queues the next step of work as a new work item.
> 
> I'm going to have to change the state machine quite a bit.  I still agree with
> the one work item per task but it is going to take a bit of work to get the
> state machine to operate within that single task.
> 
> I don't like what might result if I layer a work queue on top of using the
> system work queue for the individual steps of the state machine.  So stay
> tuned.

Yup.  I went through that (between RFC v1 and RFC v2) and it wasn't pretty
- maybe it's worth a revisit though.

To throw another view point in the mix. Note that I want a solution and
in my view DOE is slow and never on a fast path + I don't see it being
high churn code so needs to be fairly maintainable but not super simple
or architecturally clean (at the level of state machines / work queues etc
- interfaces need to be clean!)

If we go back to RFC v1, which IIRC was basically queue on a mutex, and
consider it in the light of where we've ended up.  I wussed out on arguing much
about this at the time because consensus + moving forward was more
important to me than the chosen architecture.

Taking a slightly black and white view of requirements. I don't think
we loose anything by using this list...

1. Synchronous (if anyone needs async at level of caller, they can spin
   a thread up).  Async is the corner case, not the common one.
2. Small number (< 3 I'm guessing) of protocols per instance.
3. Very rare there is significant contention.  Fairness doesn't matter.
   Normally the only reason we'd get contention is userspace triggering
   access to multiple protocols at a time - probably via sysfs or other slow
   method.
4. Per protocol ordering can be maintained by the protocol, not the DOE layer.
5. DOE is basically a bus over which we are talking to different devices
  - think of it like I2C but rather than address we have protocol IDs.

That last analogy brings us back to how I think almost all slow buses are
handled.

At level of a bus, a lock is used for mutual exclusion (often also protecting
bus controller register state etc). No workqueues or similar complexity
- Underlying hardware typically doing DMA of result into a provided buffer
with only one transaction in flight at that layer at anyone time.
Note there is more complex handling for high perf cases, but in many cases
its not really used.

We have a bus lock that can ensure exclusion over sequences if necessary
(there's one in SPI).

If a given driver needs to ensure exclusion for RMW or similar sequences
of operations it takes a driver specific mutex and holds it across these
sequences of slow operations, which usually sleep, include interrupts and all
sorts of fun.  Normally there is a completion in there somewhere to
get from the 'done' interrupt on the bus controller back to the
i2c_smbus_bus_read() etc that is waiting on the result.

This model works, is super simple and layered.

In case of no contention (perhaps 99% of time), it immediately runs the
DOE/bus access in the thread that made the read/write request.
So no overhead of going to a workqueue.  

Implementation is one linear function, no state machine needed.

Anyhow, to refer back to my initial comment.  I'm not that fussed on how
we do this but it's a blocker on other work so quick solution is more
important to me than perfect one.

Jonathan





> 
> Ira


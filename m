Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0F353FA9F
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jun 2022 11:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240554AbiFGJ6r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Jun 2022 05:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240374AbiFGJ6T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Jun 2022 05:58:19 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6E86D971;
        Tue,  7 Jun 2022 02:58:16 -0700 (PDT)
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LHQfM4y71z687wp;
        Tue,  7 Jun 2022 17:53:31 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 7 Jun 2022 11:58:13 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 7 Jun
 2022 10:58:12 +0100
Date:   Tue, 7 Jun 2022 10:58:11 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Lukas Wunner <lukas@wunner.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V8 03/10] PCI: Create PCI library functions in support
 of DOE mailboxes.
Message-ID: <20220607105811.000021d5@Huawei.com>
In-Reply-To: <Yp5b1TSxw28hCZ+z@iweiny-desk3>
References: <20220414203237.2198665-1-ira.weiny@intel.com>
        <20220414203237.2198665-4-ira.weiny@intel.com>
        <20220530190657.GA14765@wunner.de>
        <20220531113350.0000421e@Huawei.com>
        <YpbWCYujYDEkMm1B@iweiny-desk3>
        <20220601071808.GA19924@wunner.de>
        <Ypee328j+l6ZdbUT@iweiny-desk3>
        <20220606154646.00001663@Huawei.com>
        <Yp5b1TSxw28hCZ+z@iweiny-desk3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml732-chm.china.huawei.com (10.201.108.83) To
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

On Mon, 6 Jun 2022 12:56:05 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> On Mon, Jun 06, 2022 at 03:46:46PM +0100, Jonathan Cameron wrote:
> > On Wed, 1 Jun 2022 10:16:15 -0700
> > Ira Weiny <ira.weiny@intel.com> wrote:
> >   
> > > On Wed, Jun 01, 2022 at 09:18:08AM +0200, Lukas Wunner wrote:  
> > > > On Tue, May 31, 2022 at 07:59:21PM -0700, Ira Weiny wrote:    
> > > > > On Tue, May 31, 2022 at 11:33:50AM +0100, Jonathan Cameron wrote:    
> > > > > > On Mon, 30 May 2022 21:06:57 +0200 Lukas Wunner <lukas@wunner.de> wrote:    
> > > > > > > On Thu, Apr 14, 2022 at 01:32:30PM -0700, ira.weiny@intel.com wrote:    
> > >   
> > > > 
> > > >     
> > > > > > > > +static irqreturn_t pci_doe_irq_handler(int irq, void *data)
> > > > > > > > +{
> > > > > > > > +	struct pci_doe_mb *doe_mb = data;
> > > > > > > > +	struct pci_dev *pdev = doe_mb->pdev;
> > > > > > > > +	int offset = doe_mb->cap_offset;
> > > > > > > > +	u32 val;
> > > > > > > > +
> > > > > > > > +	pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
> > > > > > > > +
> > > > > > > > +	/* Leave the error case to be handled outside IRQ */
> > > > > > > > +	if (FIELD_GET(PCI_DOE_STATUS_ERROR, val)) {
> > > > > > > > +		mod_delayed_work(system_wq, &doe_mb->statemachine, 0);
> > > > > > > > +		return IRQ_HANDLED;
> > > > > > > > +	}
> > > > > > > > +
> > > > > > > > +	if (FIELD_GET(PCI_DOE_STATUS_INT_STATUS, val)) {
> > > > > > > > +		pci_write_config_dword(pdev, offset + PCI_DOE_STATUS,
> > > > > > > > +					PCI_DOE_STATUS_INT_STATUS);
> > > > > > > > +		mod_delayed_work(system_wq, &doe_mb->statemachine, 0);
> > > > > > > > +		return IRQ_HANDLED;
> > > > > > > > +	}
> > > > > > > > +
> > > > > > > > +	return IRQ_NONE;
> > > > > > > > +}      
> > > > > > > 
> > > > > > > PCIe 6.0, table 7-316 says that an interrupt is also raised when
> > > > > > > "the DOE Busy bit has been Cleared", yet such an interrupt is
> > > > > > > not handled here.  It is incorrectly treated as a spurious
> > > > > > > interrupt by returning IRQ_NONE.  The right thing to do
> > > > > > > is probably to wake the state machine in case it's polling
> > > > > > > for the Busy flag to clear.    
> > > > > > 
> > > > > > Ah. I remember testing this via a lot of hacking on the QEMU code
> > > > > > to inject the various races that can occur (it was really ugly to do).
> > > > > > 
> > > > > > Guess we lost the handling at some point.  I think your fix
> > > > > > is the right one.    
> > > > > 
> > > > > Perhaps I am missing something but digging into this more.  I disagree
> > > > > that the handler fails to handle this case.  If I read the spec correctly
> > > > > DOE Interrupt Status must be set when an interrupt is generated.
> > > > > The handler wakes the state machine in that case.  The state machine
> > > > > then checks for busy if there is work to be done.    
> > > > 
> > > > Right, I was mistaken, sorry for the noise.    
> > > 
> > > NP I'm not always following this either.
> > >   
> > > > 
> > > >     
> > > > > Normally we would not even need to check for status error.  But that is
> > > > > special cased because clearing that status is left to the state machine.    
> > > > 
> > > > That however looks wrong because the DOE Interrupt Status bit is never
> > > > cleared after a DOE Error is signaled.  The state machine performs an
> > > > explicit abort upon an error by setting the DOE Abort bit, but that
> > > > doesn't seem to clear DOE Interrupt Status:
> > > > 
> > > > Per section 6.30.2, "At any time, the system firmware/software is
> > > > permitted to set the DOE Abort bit in the DOE Control Register,
> > > > and the DOE instance must Clear the Data Object Ready bit,
> > > > if not already Clear, and Clear the DOE Error bit, if already Set,
> > > > in the DOE Status Register, within 1 second."    
> > > 
> > > I thought that meant the hardware (the DOE instance) must clear those bits
> > > within 1 second?
> > >   
> > > > 
> > > > No mention of the DOE Interrupt Status bit, so we cannot assume that
> > > > it's cleared by a DOE Abort and we must clear it explicitly.    
> > > 
> > > Oh...  yea.  Jonathan?  We discussed this before and I was convinced it worked
> > > but I think Lukas is correct here.  
> > 
> > Hmm. I thought we were good as well, but Lukas is correct in saying
> > the interrupt status bit isn't cleared (which is 'novel' give the associated
> > bit to tell you what the interrupt means will be cleared). 
> > 
> > I'm not sure I want to think around the race conditions that result...
> >   
> > > 
> > > Should we drop the special case in pci_doe_irq_handler() and just clear the
> > > status always?  Or should we wait and clear it is pci_doe_abort_start?  
> > 
> > I don't think it matters.  pci_doe_irq_handler() seems a little cleaner.  
> 
> I agree and that is what V10 does.
> 
> > 
> > I've not figured out completely if there are races however...  
> 
> This is why I reworked the handling of cur_task in those error cases.
> 
> > 
> > It is set when no already set and we get transitions of any of the following:
> > - DOE error bit set (this can't happen until abort so no race here)
> > 
> > - Data Object Ready bit is set: Can this happen with the DOE error set? I don't
> >   immediately see language saying it can't. However, I don't think it can
> >   for any of the challenge response protocols yet defined (and there are other
> >   problems if anyone wants to implement unsolicited messages)
> > 
> > - DOE busy bit has cleared - can definitely happen after an abort (which is
> >   fine as nothing to do anyway, so we'll handle a pointless interrupt).
> >   Could it in theory happen when error is set? I think not but only because
> >   of the statement  "Clear this bit when it is able to receive a new data
> >   object."
> > 
> > So I think we are fine doing it preabort,  
> 
> That is what I though for V10 especially after reworking the cur_task locking.
> An extra interrupt would either start processing the next task or return with
> nothing to do.
> 
> > but wouldn't put it past a hardware
> > designer to find some path through that which results in a bonus interrupt
> > and potentially us resetting twice.
> > 
> > If we clear it at the end of abort instead, what happens?
> > Definitely no interrupts until we clear it. As we are doing query response
> > protocols only, no new data until state machine moves on, so fine there.
> > 
> > So what about just doing it unconditionally..
> > 
> > +	case DOE_WAIT_ABORT:
> > +	case DOE_WAIT_ABORT_ON_ERR:
> > +		pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
> > +
> > +		if (!FIELD_GET(PCI_DOE_STATUS_ERROR, val) &&
> > +		    !FIELD_GET(PCI_DOE_STATUS_BUSY, val)) {
> > 
> > 	here...
> > 
> > +			/* Back to normal state - carry on */
> > +			retire_cur_task(doe_mb);
> > 
> > This feels a little bit more 'standard' as we are allowing new interrupts
> > only after everything is back to a nice state.  
> 
> As I reworked the cur_task locking I really thought about locking cur_task
> throughout doe_statemachine_work().  It seems a lot safer for a lot of reasons.
> Doing so would make the extra work item no big deal.
> 
> So I looked at this again because you got me worried.  If mod_delayed_work()
> can cause doe_statemachine_work() while another thread is in the middle of
> processing the interrupt there is a chance that signal_task_complete() is
> called a second time on a given task pointer.
> 
> However, I _don't_ _think_ that can happen.  Because I don't think
> mod_delayed_work() can cause the work item to run while it is already running.

You are correct. I remember looking into that exact question for
a different project a while ago.

> 
> So unless I misunderstand how mod_delayed_work() works we are guaranteed that
> the extra interrupt will see the correct mailbox state and do the right thing.

Agreed.  Far as I can tell we are fine.  More eyes always good though if anyone
else wants to take a look!

Jonathan

p.s. I liked the original heavy weight queuing the whole thing on a mutex as it
was a lot easier to reason about :)  Was ugly though!


> 
> Ira


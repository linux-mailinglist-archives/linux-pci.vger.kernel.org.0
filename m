Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73F153EEF3
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jun 2022 21:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbiFFT4g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jun 2022 15:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbiFFT4Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jun 2022 15:56:25 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B7FE64F4;
        Mon,  6 Jun 2022 12:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654545368; x=1686081368;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rvMXoxpRuDnCE4wJwCq4WiYxb2zBU8ejJRlWm/twmeE=;
  b=jd9GyOfxiBU8mylYThX3R9mwi6jyaI+SrAk/ZQVfOqSjA3QT2d4FRCoc
   Ta6ceGHNtzCzptZ7jWo44lHsFez7afa+tjaHNHUDEJFFTe8fJmUIsFP/K
   6TgMoqWz6Bk7li4rosMmOuU0fFW5OfIFY6BXWF35dqb5P87jPrt5040yY
   veREIdydcyHC73exzd59v975GnlYPC7+pQcu66c+ZsYA3MalWBoICV/BL
   NCweXZVO7nQLgmHonm9InC7u7s+UHOLBBjyronKediUkvvTbK9YTxzbDZ
   JSbFaaKMD0vA6tUOK3FDJCEJTDwtstiEwHGd886TYsldegJxDCaoqv4O2
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="259170509"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="259170509"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 12:56:07 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="826009834"
Received: from sarojkum-mobl.amr.corp.intel.com (HELO localhost) ([10.212.220.176])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 12:56:06 -0700
Date:   Mon, 6 Jun 2022 12:56:05 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V8 03/10] PCI: Create PCI library functions in support of
 DOE mailboxes.
Message-ID: <Yp5b1TSxw28hCZ+z@iweiny-desk3>
References: <20220414203237.2198665-1-ira.weiny@intel.com>
 <20220414203237.2198665-4-ira.weiny@intel.com>
 <20220530190657.GA14765@wunner.de>
 <20220531113350.0000421e@Huawei.com>
 <YpbWCYujYDEkMm1B@iweiny-desk3>
 <20220601071808.GA19924@wunner.de>
 <Ypee328j+l6ZdbUT@iweiny-desk3>
 <20220606154646.00001663@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606154646.00001663@Huawei.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 06, 2022 at 03:46:46PM +0100, Jonathan Cameron wrote:
> On Wed, 1 Jun 2022 10:16:15 -0700
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > On Wed, Jun 01, 2022 at 09:18:08AM +0200, Lukas Wunner wrote:
> > > On Tue, May 31, 2022 at 07:59:21PM -0700, Ira Weiny wrote:  
> > > > On Tue, May 31, 2022 at 11:33:50AM +0100, Jonathan Cameron wrote:  
> > > > > On Mon, 30 May 2022 21:06:57 +0200 Lukas Wunner <lukas@wunner.de> wrote:  
> > > > > > On Thu, Apr 14, 2022 at 01:32:30PM -0700, ira.weiny@intel.com wrote:  
> > 
> > > 
> > >   
> > > > > > > +static irqreturn_t pci_doe_irq_handler(int irq, void *data)
> > > > > > > +{
> > > > > > > +	struct pci_doe_mb *doe_mb = data;
> > > > > > > +	struct pci_dev *pdev = doe_mb->pdev;
> > > > > > > +	int offset = doe_mb->cap_offset;
> > > > > > > +	u32 val;
> > > > > > > +
> > > > > > > +	pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
> > > > > > > +
> > > > > > > +	/* Leave the error case to be handled outside IRQ */
> > > > > > > +	if (FIELD_GET(PCI_DOE_STATUS_ERROR, val)) {
> > > > > > > +		mod_delayed_work(system_wq, &doe_mb->statemachine, 0);
> > > > > > > +		return IRQ_HANDLED;
> > > > > > > +	}
> > > > > > > +
> > > > > > > +	if (FIELD_GET(PCI_DOE_STATUS_INT_STATUS, val)) {
> > > > > > > +		pci_write_config_dword(pdev, offset + PCI_DOE_STATUS,
> > > > > > > +					PCI_DOE_STATUS_INT_STATUS);
> > > > > > > +		mod_delayed_work(system_wq, &doe_mb->statemachine, 0);
> > > > > > > +		return IRQ_HANDLED;
> > > > > > > +	}
> > > > > > > +
> > > > > > > +	return IRQ_NONE;
> > > > > > > +}    
> > > > > > 
> > > > > > PCIe 6.0, table 7-316 says that an interrupt is also raised when
> > > > > > "the DOE Busy bit has been Cleared", yet such an interrupt is
> > > > > > not handled here.  It is incorrectly treated as a spurious
> > > > > > interrupt by returning IRQ_NONE.  The right thing to do
> > > > > > is probably to wake the state machine in case it's polling
> > > > > > for the Busy flag to clear.  
> > > > > 
> > > > > Ah. I remember testing this via a lot of hacking on the QEMU code
> > > > > to inject the various races that can occur (it was really ugly to do).
> > > > > 
> > > > > Guess we lost the handling at some point.  I think your fix
> > > > > is the right one.  
> > > > 
> > > > Perhaps I am missing something but digging into this more.  I disagree
> > > > that the handler fails to handle this case.  If I read the spec correctly
> > > > DOE Interrupt Status must be set when an interrupt is generated.
> > > > The handler wakes the state machine in that case.  The state machine
> > > > then checks for busy if there is work to be done.  
> > > 
> > > Right, I was mistaken, sorry for the noise.  
> > 
> > NP I'm not always following this either.
> > 
> > > 
> > >   
> > > > Normally we would not even need to check for status error.  But that is
> > > > special cased because clearing that status is left to the state machine.  
> > > 
> > > That however looks wrong because the DOE Interrupt Status bit is never
> > > cleared after a DOE Error is signaled.  The state machine performs an
> > > explicit abort upon an error by setting the DOE Abort bit, but that
> > > doesn't seem to clear DOE Interrupt Status:
> > > 
> > > Per section 6.30.2, "At any time, the system firmware/software is
> > > permitted to set the DOE Abort bit in the DOE Control Register,
> > > and the DOE instance must Clear the Data Object Ready bit,
> > > if not already Clear, and Clear the DOE Error bit, if already Set,
> > > in the DOE Status Register, within 1 second."  
> > 
> > I thought that meant the hardware (the DOE instance) must clear those bits
> > within 1 second?
> > 
> > > 
> > > No mention of the DOE Interrupt Status bit, so we cannot assume that
> > > it's cleared by a DOE Abort and we must clear it explicitly.  
> > 
> > Oh...  yea.  Jonathan?  We discussed this before and I was convinced it worked
> > but I think Lukas is correct here.
> 
> Hmm. I thought we were good as well, but Lukas is correct in saying
> the interrupt status bit isn't cleared (which is 'novel' give the associated
> bit to tell you what the interrupt means will be cleared). 
> 
> I'm not sure I want to think around the race conditions that result...
> 
> > 
> > Should we drop the special case in pci_doe_irq_handler() and just clear the
> > status always?  Or should we wait and clear it is pci_doe_abort_start?
> 
> I don't think it matters.  pci_doe_irq_handler() seems a little cleaner.

I agree and that is what V10 does.

> 
> I've not figured out completely if there are races however...

This is why I reworked the handling of cur_task in those error cases.

> 
> It is set when no already set and we get transitions of any of the following:
> - DOE error bit set (this can't happen until abort so no race here)
> 
> - Data Object Ready bit is set: Can this happen with the DOE error set? I don't
>   immediately see language saying it can't. However, I don't think it can
>   for any of the challenge response protocols yet defined (and there are other
>   problems if anyone wants to implement unsolicited messages)
> 
> - DOE busy bit has cleared - can definitely happen after an abort (which is
>   fine as nothing to do anyway, so we'll handle a pointless interrupt).
>   Could it in theory happen when error is set? I think not but only because
>   of the statement  "Clear this bit when it is able to receive a new data
>   object."
> 
> So I think we are fine doing it preabort,

That is what I though for V10 especially after reworking the cur_task locking.
An extra interrupt would either start processing the next task or return with
nothing to do.

> but wouldn't put it past a hardware
> designer to find some path through that which results in a bonus interrupt
> and potentially us resetting twice.
> 
> If we clear it at the end of abort instead, what happens?
> Definitely no interrupts until we clear it. As we are doing query response
> protocols only, no new data until state machine moves on, so fine there.
> 
> So what about just doing it unconditionally..
> 
> +	case DOE_WAIT_ABORT:
> +	case DOE_WAIT_ABORT_ON_ERR:
> +		pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
> +
> +		if (!FIELD_GET(PCI_DOE_STATUS_ERROR, val) &&
> +		    !FIELD_GET(PCI_DOE_STATUS_BUSY, val)) {
> 
> 	here...
> 
> +			/* Back to normal state - carry on */
> +			retire_cur_task(doe_mb);
> 
> This feels a little bit more 'standard' as we are allowing new interrupts
> only after everything is back to a nice state.

As I reworked the cur_task locking I really thought about locking cur_task
throughout doe_statemachine_work().  It seems a lot safer for a lot of reasons.
Doing so would make the extra work item no big deal.

So I looked at this again because you got me worried.  If mod_delayed_work()
can cause doe_statemachine_work() while another thread is in the middle of
processing the interrupt there is a chance that signal_task_complete() is
called a second time on a given task pointer.

However, I _don't_ _think_ that can happen.  Because I don't think
mod_delayed_work() can cause the work item to run while it is already running.

So unless I misunderstand how mod_delayed_work() works we are guaranteed that
the extra interrupt will see the correct mailbox state and do the right thing.

Ira

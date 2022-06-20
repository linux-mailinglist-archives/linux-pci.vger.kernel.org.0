Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D2D5515B1
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jun 2022 12:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbiFTKXl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Jun 2022 06:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240116AbiFTKXi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jun 2022 06:23:38 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80EADE9A;
        Mon, 20 Jun 2022 03:23:34 -0700 (PDT)
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LRQhb4GzDz688G2;
        Mon, 20 Jun 2022 18:23:11 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Mon, 20 Jun 2022 12:23:30 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 20 Jun
 2022 11:23:30 +0100
Date:   Mon, 20 Jun 2022 11:23:28 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <ira.weiny@intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V11 3/8] PCI: Create PCI library functions in support of
 DOE mailboxes.
Message-ID: <20220620112328.00004f63@Huawei.com>
In-Reply-To: <62ad06a643ddf_844b1294f@dwillia2-xfh.notmuch>
References: <20220610202259.3544623-1-ira.weiny@intel.com>
        <20220610202259.3544623-4-ira.weiny@intel.com>
        <62ad06a643ddf_844b1294f@dwillia2-xfh.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml748-chm.china.huawei.com (10.201.108.198) To
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

On Fri, 17 Jun 2022 15:56:38 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> ira.weiny@ wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Introduced in a PCI r6.0, sec 6.30, DOE provides a config space based
> > mailbox with standard protocol discovery.  Each mailbox is accessed
> > through a DOE Extended Capability.
> > 
> > Each DOE mailbox must support the DOE discovery protocol in addition to
> > any number of additional protocols.
> > 
> > Define core PCI functionality to manage a single PCI DOE mailbox at a
> > defined config space offset.  Functionality includes iterating,
> > creating, query of supported protocol, task submission, and destruction
> > of the mailboxes.
> > 
> > If interrupts are desired, the interrupt number can be queried and
> > passed to the create function.  Passing a negative value disables
> > interrupts for that mailbox.  It is the callers responsibility to ensure  
> 
> s/callers/caller's/
> 
> > enough interrupt vectors are allocated.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 

...

> > + * @task_lock: Protect cur_task  
> 
> Protect what about cur_task? Assigning and clearing a pointer is atomic.
> 
> > + * @statemachine: Work item for the DOE state machine  
> 
> Why does the pci_doe_mb have a work item? I would expect a work item per
> task. Then this gets a waitqueue for free to wait for task completion.
> Otherwise I suspect this introduces complexity in the DOE implementation
> to simulate per-task-work that a workqueue per DOE and a work item per
> task gets you for free, and for recalling hardware context from one
> firing of the state machine to the next. Just run the task work all
> in-line in one context.

We went through a model that looked rather more like that.  Maybe
I misunderstood your feedback at the time (way back around the first RFC)
where you suggested using timeouts via delayed workqueue and limiting
the access to the DOE to a single thread (explicitly by using a single
work item). See description of changes in v2.
https://lore.kernel.org/all/20210413160159.935663-3-Jonathan.Cameron@huawei.com/

This logic has been fundamentally the same since around v2.

...

> > +static irqreturn_t pci_doe_irq_handler(int irq, void *data)
> > +{
> > +	struct pci_doe_mb *doe_mb = data;
> > +	struct pci_dev *pdev = doe_mb->pdev;
> > +	int offset = doe_mb->cap_offset;
> > +	u32 val;
> > +
> > +	pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
> > +	if (FIELD_GET(PCI_DOE_STATUS_INT_STATUS, val)) {
> > +		pci_write_config_dword(pdev, offset + PCI_DOE_STATUS,
> > +					PCI_DOE_STATUS_INT_STATUS);
> > +		mod_delayed_work(system_wq, &doe_mb->statemachine, 0);  
> 
> Wait, no, not system_wq. I expected this wants a dedicated / ordered queue
> per doe and this likely wants a queue that can sleep while processing a
> task and just not support overlapping tasks.
> 
> In that model the irq is just waking up any tasks in execution that are
> awaiting a polling timeout. The irq handler does:
> 
> wake_up(&doe_mb->wait);
> 
> ...and then task that is executing in the queue continues what it was
> doing.

Sure that should work. 


> 
> > +		return IRQ_HANDLED;
> > +	}
> > +
> > +	return IRQ_NONE;
> > +}
> > +
> > +/*
> > + * Only called when safe to directly access the DOE from
> > + * doe_statemachine_work().  Outside access is not protected.  Users who
> > + * perform such access are left with the pieces.  
> 
> What pieces, where? I expect the abort implementation would be something
> like:
> 
> set_bit(ABORT_PENDING) <== blocks new task submissions until clear
> flush_workqueue() <== make sure all in-flight tasks see the abort
> do_doe_abort(...) <== do the abort
> clear_bit(ABORT_PENDING) <== optionally restart the tasks that were
> cancelled, or just expect them to be resubmitted.

I think this is an artifact of trying to act on suggestion to only access
the DOE from a single thread. Without that complexity something like you
suggest should work.

Fundamentally should still only be called from within the state machine
though (as that's the only place it makes sense) and will need to
interrupt work in flight (waiting for interrupt / polling for timeout etc).


> > +static int pci_doe_abort(struct pci_doe_mb *doe_mb)
> > +{
> > +	reinit_completion(&doe_mb->abort_c);
> > +	set_bit(PCI_DOE_FLAG_ABORT, &doe_mb->flags);
> > +	schedule_delayed_work(&doe_mb->statemachine, 0);
> > +	wait_for_completion(&doe_mb->abort_c);
> > +
> > +	if (test_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags))
> > +		return -EIO;
> > +
> > +	return 0;
> > +}
> > +
> > +static int pci_doe_enable_irq(struct pci_doe_mb *doe_mb, unsigned int irq)
> > +{
> > +	struct pci_dev *pdev = doe_mb->pdev;
> > +	int offset = doe_mb->cap_offset;
> > +	int rc;
> > +
> > +	/*
> > +	 * Enabling bus mastering is required for MSI/MSIx.  It is safe to call
> > +	 * this multiple times and thus is called here to ensure that mastering
> > +	 * is enabled even if the driver has done so.
> > +	 */  
> 
> It is required for MSI/MSIx to work, yes, but if the caller that created
> the doe object has not set it yet that's its prerogative.

We went around this in one of the earlier threads, and I think consensus
was that it made sense to have this in core code.

> 
> > +	pci_set_master(pdev);
> > +	rc = pci_request_irq(pdev, irq, pci_doe_irq_handler, NULL, doe_mb,
> > +			     "DOE[%d:%s]", irq, pci_name(pdev));  
> 
> If the DOE object creation is use devm_ then this wants to be
> devm_request_irq(), although I now notice that devm_pci_doe_create()
> only existed in the code comments, not the implementation.
> 
> Is there any need for the unmanaged version of this API?
> 
> > +	if (rc)
> > +		return rc;
> > +
> > +	doe_mb->irq = irq;
> > +	pci_write_config_dword(pdev, offset + PCI_DOE_CTRL,
> > +			       PCI_DOE_CTRL_INT_EN);
> > +	return 0;
> > +}
> > +

Thanks,


Jonathan

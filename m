Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E851A62A32F
	for <lists+linux-pci@lfdr.de>; Tue, 15 Nov 2022 21:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiKOUlk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Nov 2022 15:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiKOUlj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2022 15:41:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFA212D27;
        Tue, 15 Nov 2022 12:41:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFF4C617C1;
        Tue, 15 Nov 2022 20:41:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 332B4C433D6;
        Tue, 15 Nov 2022 20:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668544897;
        bh=UirLT+h/qQSTPhdoM/GR2xuPda9LMXFhKZt+E/mrMBE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ijYbiT71+mxsXe6VTo7NOq36arByH8CfjuO17EXAcEF3soVFeYLVw28FMnveHRS1V
         kLj0UmSOxO8rqXFGHiZzig2SufKES6KD54TI5VyGy6BlFT7EYICAuefPdZk3rM2A/+
         hTXUDvO3ZPfgROjgiac/ORctbv7USDISLxAhnthXkhqUVj7Bw57wxkTnYxGgew/7u4
         pahl3zLWTFLi+q/rTOpIJUWW8dLdcY2QzkGENk9jPNdGFWHmY9DKDccYuJQ3DlGf6R
         P3po1zPf8WnE53+bgJgb4/M6mQ2WnxgrPEazlO9j2e9BMH/e87Sy3Pvpm9jA3pKVmW
         Ib4nd3Dr1JJ5w==
Date:   Tue, 15 Nov 2022 14:41:35 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gregory Price <gregory.price@memverge.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/doe: Fix work struct declaration
Message-ID: <20221115204135.GA1037921@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3P0Hp7eK3V7xRLN@iweiny-mobl>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 15, 2022 at 12:18:38PM -0800, Ira Weiny wrote:
> On Tue, Nov 15, 2022 at 01:44:24PM -0600, Bjorn Helgaas wrote:
> > and say something more specific than "fix struct"?
> 
> How about?
> 
> PCI/DOE: Fix initialization of work struct in pci_doe_task

The importance of this has to do with whether something is on the
stack, so I think something about that would be useful.

I'm afraid this subject line bike-shedding has made you overlook my
other questions below ...

> > On Mon, Nov 14, 2022 at 05:19:43PM -0800, ira.weiny@intel.com wrote:
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > The callers of pci_doe_submit_task() allocate the pci_doe_task on the
> > > stack.  This causes the work structure to be allocated on the stack
> > > without pci_doe_submit_task() knowing.  Work item initialization needs
> > > to be done with either INIT_WORK_ONSTACK() or INIT_WORK() depending on
> > > how the work item is allocated.
> > > 
> > > Jonathan suggested creating doe task allocation macros such as
> > > DECLARE_CDAT_DOE_TASK_ONSTACK().[1]  The issue with this is the work
> > > function is not known to the callers and must be initialized correctly.
> > > 
> > > A follow up suggestion was to have an internal 'pci_doe_work' item
> > > allocated by pci_doe_submit_task().[2]  This requires an allocation which
> > > could restrict the context where tasks are used.
> > > 
> > > Compromise with an intermediate step to initialize the task struct with
> > > a new call pci_doe_init_task() which must be called prior to submit
> > > task.
> > 
> > I'm not really a fan of passing a parameter to say "this struct is on
> > the stack" because that seems kind of error-prone and I don't know
> > what the consequence of getting it wrong would be.  Sounds like it
> > *could* be some memory corruption or reading garbage data that would
> > be hard to debug.
> > 
> > Do we have cases today where pci_doe_submit_task() can't do the
> > kzalloc() as in your patch at [3]?  If the current use cases allow a
> > kzalloc(), why not do that now and defer this until it becomes an
> > issue?
> > 
> > Bjorn
> > 
> > > [1] https://lore.kernel.org/linux-cxl/20221014151045.24781-1-Jonathan.Cameron@huawei.com/T/#m88a7f50dcce52f30c8bf5c3dcc06fa9843b54a2d
> > > [2] https://lore.kernel.org/linux-cxl/20221014151045.24781-1-Jonathan.Cameron@huawei.com/T/#m63c636c5135f304480370924f4d03c00357be667
> > 
> > [3] https://lore.kernel.org/linux-cxl/Y2AnKB88ALYm9c5L@iweiny-desk3/
> > 
> > > Cc: Bjorn Helgaas <helgaas@kernel.org>
> > > Reported-by: Gregory Price <gregory.price@memverge.com>
> > > Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > ---
> > >  drivers/cxl/core/pci.c  |  2 ++
> > >  drivers/pci/doe.c       | 14 ++++++++++++--
> > >  include/linux/pci-doe.h |  8 +++++---
> > >  3 files changed, 19 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> > > index 9240df53ed87..a19c1fa0e2f4 100644
> > > --- a/drivers/cxl/core/pci.c
> > > +++ b/drivers/cxl/core/pci.c
> > > @@ -525,6 +525,7 @@ static int cxl_cdat_get_length(struct device *dev,
> > >  	DECLARE_CDAT_DOE_TASK(CDAT_DOE_REQ(0), t);
> > >  	int rc;
> > >  
> > > +	pci_doe_init_task(cdat_doe, &t.task, true);
> > >  	rc = pci_doe_submit_task(cdat_doe, &t.task);
> > >  	if (rc < 0) {
> > >  		dev_err(dev, "DOE submit failed: %d", rc);
> > > @@ -554,6 +555,7 @@ static int cxl_cdat_read_table(struct device *dev,
> > >  		u32 *entry;
> > >  		int rc;
> > >  
> > > +		pci_doe_init_task(cdat_doe, &t.task, true);
> > >  		rc = pci_doe_submit_task(cdat_doe, &t.task);
> > >  		if (rc < 0) {
> > >  			dev_err(dev, "DOE submit failed: %d", rc);
> > > diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> > > index e402f05068a5..cabeae4ae955 100644
> > > --- a/drivers/pci/doe.c
> > > +++ b/drivers/pci/doe.c
> > > @@ -319,6 +319,7 @@ static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16 *vid,
> > >  	};
> > >  	int rc;
> > >  
> > > +	pci_doe_init_task(doe_mb, &task, true);
> > >  	rc = pci_doe_submit_task(doe_mb, &task);
> > >  	if (rc < 0)
> > >  		return rc;
> > > @@ -495,6 +496,14 @@ bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type)
> > >  }
> > >  EXPORT_SYMBOL_GPL(pci_doe_supports_prot);
> > >  
> > > +void pci_doe_init_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task,
> > > +		       bool onstack)
> > > +{
> > > +	task->doe_mb = doe_mb;
> > > +	__INIT_WORK(&task->work, doe_statemachine_work, onstack);
> > > +}
> > > +EXPORT_SYMBOL_GPL(pci_doe_init_task);
> > > +
> > >  /**
> > >   * pci_doe_submit_task() - Submit a task to be processed by the state machine
> > >   *
> > > @@ -517,6 +526,9 @@ int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
> > >  	if (!pci_doe_supports_prot(doe_mb, task->prot.vid, task->prot.type))
> > >  		return -EINVAL;
> > >  
> > > +	if (WARN_ON_ONCE(task->work.func != doe_statemachine_work))
> > > +		return -EINVAL;
> > > +
> > >  	/*
> > >  	 * DOE requests must be a whole number of DW and the response needs to
> > >  	 * be big enough for at least 1 DW
> > > @@ -528,8 +540,6 @@ int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
> > >  	if (test_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags))
> > >  		return -EIO;
> > >  
> > > -	task->doe_mb = doe_mb;
> > > -	INIT_WORK(&task->work, doe_statemachine_work);
> > >  	queue_work(doe_mb->work_queue, &task->work);
> > >  	return 0;
> > >  }
> > > diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
> > > index ed9b4df792b8..457fc0e53d64 100644
> > > --- a/include/linux/pci-doe.h
> > > +++ b/include/linux/pci-doe.h
> > > @@ -31,8 +31,8 @@ struct pci_doe_mb;
> > >   * @rv: Return value.  Length of received response or error (bytes)
> > >   * @complete: Called when task is complete
> > >   * @private: Private data for the consumer
> > > - * @work: Used internally by the mailbox
> > > - * @doe_mb: Used internally by the mailbox
> > > + * @work: Used internally by the mailbox [see pci_doe_init_task()]
> > > + * @doe_mb: Used internally by the mailbox [see pci_doe_init_task()]
> > >   *
> > >   * The payload sizes and rv are specified in bytes with the following
> > >   * restrictions concerning the protocol.
> > > @@ -53,7 +53,7 @@ struct pci_doe_task {
> > >  	void (*complete)(struct pci_doe_task *task);
> > >  	void *private;
> > >  
> > > -	/* No need for the user to initialize these fields */
> > > +	/* Call pci_doe_init_task() for these */
> > >  	struct work_struct work;
> > >  	struct pci_doe_mb *doe_mb;
> > >  };
> > > @@ -72,6 +72,8 @@ struct pci_doe_task {
> > >  
> > >  struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset);
> > >  bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type);
> > > +void pci_doe_init_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task,
> > > +		       bool onstack);
> > >  int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task);
> > >  
> > >  #endif
> > > 
> > > base-commit: 30a0b95b1335e12efef89dd78518ed3e4a71a763
> > > -- 
> > > 2.37.2
> > > 

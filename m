Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E0663777E
	for <lists+linux-pci@lfdr.de>; Thu, 24 Nov 2022 12:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiKXLUF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 06:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiKXLT4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 06:19:56 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121B4120B7;
        Thu, 24 Nov 2022 03:19:53 -0800 (PST)
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NHwWP5pt8z689hv;
        Thu, 24 Nov 2022 19:19:45 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 24 Nov 2022 12:19:50 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 24 Nov
 2022 11:19:50 +0000
Date:   Thu, 24 Nov 2022 11:19:49 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Gregory Price <gregory.price@memverge.com>,
        "Li, Ming" <ming4.li@intel.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V2 1/2] PCI/DOE: Remove the pci_doe_flush_mb() call
Message-ID: <20221124111949.00007bd9@Huawei.com>
In-Reply-To: <Y35Z6fB8Sm4JcPdK@iweiny-desk3>
References: <20221122155324.1878416-1-ira.weiny@intel.com>
        <20221122155324.1878416-2-ira.weiny@intel.com>
        <20221122163426.0000467c@Huawei.com>
        <Y35Z6fB8Sm4JcPdK@iweiny-desk3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 23 Nov 2022 09:35:37 -0800
Ira Weiny <ira.weiny@intel.com> wrote:

> On Tue, Nov 22, 2022 at 04:34:26PM +0000, Jonathan Cameron wrote:
> > On Tue, 22 Nov 2022 07:53:23 -0800
> > ira.weiny@intel.com wrote:
> >   
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > Each struct doe_mb is managed as part of the PCI device.  They can't go
> > > away as long as the PCI device exists.  pci_doe_flush_mb() was set up to
> > > flush the workqueue and prevent any further submissions to the mailboxes
> > > when the PCI device goes away.  Unfortunately, this was fundamentally
> > > flawed.  There was no guarantee that a struct doe_mb remained after
> > > pci_doe_flush_mb() returned.  Therefore, the doe_mb state could be
> > > invalid when those threads waiting on the workqueue were flushed.
> > > 
> > > Fortunately the current code is safe because all callers make a
> > > synchronous call to pci_doe_submit_task() and maintain a reference on the
> > > PCI device.
> > > 
> > > For these reasons, pci_doe_flush_mb() will never be called while tasks
> > > are being processed and there is no use for it.
> > > 
> > > Remove the dead code around pci_doe_flush_mb().
> > > 
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>  
> > 
> > Looks fine I think, though one question inline.
> >    
> > > ---
> > >  drivers/pci/doe.c | 48 ++++-------------------------------------------
> > >  1 file changed, 4 insertions(+), 44 deletions(-)
> > > 
> > > diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> > > index e402f05068a5..260313e9052e 100644
> > > --- a/drivers/pci/doe.c
> > > +++ b/drivers/pci/doe.c
> > > @@ -24,10 +24,9 @@
> > >  
> > >  /* Timeout of 1 second from 6.30.2 Operation, PCI Spec r6.0 */
> > >  #define PCI_DOE_TIMEOUT HZ
> > > -#define PCI_DOE_POLL_INTERVAL	(PCI_DOE_TIMEOUT / 128)
> > > +#define PCI_DOE_POLL_INTERVAL	8  
> > 
> > Why this change?    
> 
> msleep_interruptible() takes a millisecond value and wait_event_timeout() takes
> jiffies.  1/128 of a second is ~8ms.
> 
> While for most configs (HZ == 1000) the value does not change.  I don't believe
> this would be true for all configs.  Thus a more explicit define.
> 

Makes sense. Maybe add a postfix as well to make it clear it's not in same units
as the PCI_DOE_TIMEOUT?
PCI_DOE_POLL_INTERVAL_MSECS




> I'll add a comment.
> 
> Ira
> 
> >   
> > >  
> > > -#define PCI_DOE_FLAG_CANCEL	0
> > > -#define PCI_DOE_FLAG_DEAD	1
> > > +#define PCI_DOE_FLAG_DEAD	0
> > >  
> > >  /**
> > >   * struct pci_doe_mb - State for a single DOE mailbox
> > > @@ -53,15 +52,6 @@ struct pci_doe_mb {
> > >  	unsigned long flags;
> > >  };
> > >  
> > > -static int pci_doe_wait(struct pci_doe_mb *doe_mb, unsigned long timeout)
> > > -{
> > > -	if (wait_event_timeout(doe_mb->wq,
> > > -			       test_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flags),
> > > -			       timeout))
> > > -		return -EIO;
> > > -	return 0;
> > > -}
> > > -
> > >  static void pci_doe_write_ctrl(struct pci_doe_mb *doe_mb, u32 val)
> > >  {
> > >  	struct pci_dev *pdev = doe_mb->pdev;
> > > @@ -82,12 +72,9 @@ static int pci_doe_abort(struct pci_doe_mb *doe_mb)
> > >  	pci_doe_write_ctrl(doe_mb, PCI_DOE_CTRL_ABORT);
> > >  
> > >  	do {
> > > -		int rc;
> > >  		u32 val;
> > >  
> > > -		rc = pci_doe_wait(doe_mb, PCI_DOE_POLL_INTERVAL);
> > > -		if (rc)
> > > -			return rc;
> > > +		msleep_interruptible(PCI_DOE_POLL_INTERVAL);
> > >  		pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
> > >  
> > >  		/* Abort success! */
> > > @@ -278,11 +265,7 @@ static void doe_statemachine_work(struct work_struct *work)
> > >  			signal_task_abort(task, -EIO);
> > >  			return;
> > >  		}
> > > -		rc = pci_doe_wait(doe_mb, PCI_DOE_POLL_INTERVAL);
> > > -		if (rc) {
> > > -			signal_task_abort(task, rc);
> > > -			return;
> > > -		}
> > > +		msleep_interruptible(PCI_DOE_POLL_INTERVAL);
> > >  		goto retry_resp;
> > >  	}
> > >  
> > > @@ -383,21 +366,6 @@ static void pci_doe_destroy_workqueue(void *mb)
> > >  	destroy_workqueue(doe_mb->work_queue);
> > >  }
> > >  
> > > -static void pci_doe_flush_mb(void *mb)
> > > -{
> > > -	struct pci_doe_mb *doe_mb = mb;
> > > -
> > > -	/* Stop all pending work items from starting */
> > > -	set_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags);
> > > -
> > > -	/* Cancel an in progress work item, if necessary */
> > > -	set_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flags);
> > > -	wake_up(&doe_mb->wq);
> > > -
> > > -	/* Flush all work items */
> > > -	flush_workqueue(doe_mb->work_queue);
> > > -}
> > > -
> > >  /**
> > >   * pcim_doe_create_mb() - Create a DOE mailbox object
> > >   *
> > > @@ -450,14 +418,6 @@ struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset)
> > >  		return ERR_PTR(rc);
> > >  	}
> > >  
> > > -	/*
> > > -	 * The state machine and the mailbox should be in sync now;
> > > -	 * Set up mailbox flush prior to using the mailbox to query protocols.
> > > -	 */
> > > -	rc = devm_add_action_or_reset(dev, pci_doe_flush_mb, doe_mb);
> > > -	if (rc)
> > > -		return ERR_PTR(rc);
> > > -
> > >  	rc = pci_doe_cache_protocols(doe_mb);
> > >  	if (rc) {
> > >  		pci_err(pdev, "[%x] failed to cache protocols : %d\n",  
> >   
> 


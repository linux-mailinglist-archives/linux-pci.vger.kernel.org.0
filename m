Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33399632B7E
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 18:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbiKURwn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 12:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbiKURwe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 12:52:34 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD3C10AB;
        Mon, 21 Nov 2022 09:52:28 -0800 (PST)
Received: from frapeml500001.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NGFGB636zz689Gt;
        Tue, 22 Nov 2022 01:47:30 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 frapeml500001.china.huawei.com (7.182.85.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 18:52:26 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 21 Nov
 2022 17:52:26 +0000
Date:   Mon, 21 Nov 2022 17:52:25 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Hillf Danton <hdanton@sina.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Li Ming <ming4.li@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Alison Schofield" <alison.schofield@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI/DOE: Remove asynchronous task support
Message-ID: <20221121175225.00001b7b@Huawei.com>
In-Reply-To: <Y3oyQhHUbYZGA80M@iweiny-mobl>
References: <20221119222527.1799836-1-ira.weiny@intel.com>
        <20221120022735.4671-1-hdanton@sina.com>
        <Y3oyQhHUbYZGA80M@iweiny-mobl>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
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

On Sun, 20 Nov 2022 05:57:22 -0800
Ira Weiny <ira.weiny@intel.com> wrote:

> On Sun, Nov 20, 2022 at 10:27:35AM +0800, Hillf Danton wrote:
> > On Sat, 19 Nov 2022 14:25:27 -0800 Ira Weiny <ira.weiny@intel.com>  
> > > @@ -529,8 +492,18 @@ int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
> > >  		return -EIO;
> > >  
> > >  	task->doe_mb = doe_mb;
> > > -	INIT_WORK(&task->work, doe_statemachine_work);
> > > -	queue_work(doe_mb->work_queue, &task->work);
> > > +
> > > +again:
> > > +	if (!mutex_trylock(&doe_mb->exec_lock)) {
> > > +		if (wait_event_timeout(task->doe_mb->wq,
> > > +				test_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flags),
> > > +				PCI_DOE_POLL_INTERVAL))
> > > +			return -EIO;  
> > 
> > Is EIO worth a line of pr_warn()?  
> 
> Maybe but I'm not sure it is worth it.  This was paralleling the original code
> which called pci_doe_flush_mb() to shut down the mailbox.  So this is likely to
> never happen.  The callers could print something if needed.
> 
> >   
> > > +		goto again;
> > > +	}
> > > +	exec_task(task);
> > > +	mutex_unlock(&doe_mb->exec_lock);
> > > +  
> > 
> > If it is likely to take two minutes to acquire the exec_lock after
> > rounds of trying again, trylock + wait timeout barely make sense given EIO.  
> 
> I'm not sure where 2 minutes come from?
> 
> #define PCI_DOE_TIMEOUT HZ
> #define PCI_DOE_POLL_INTERVAL   (PCI_DOE_TIMEOUT / 128)
> 
> It is also not anticipated that more than 1 task is being given to the mailbox
> but the protection needs to be there because exec_task() will get confused if
> more than 1 thread submits at the same time.

Given multiple protocols can be on the same DOE and they may be handled by
either subdrivers or indeed driven by userspace interface, there is a high
chance that more than one task will be queued up (once we have a few more
supported protocols).

> 
> All this said I've now convinced myself that there is a race in the use of
> PCI_DOE_FLAG_CANCEL even with the existing code.
> 
> I believe that if the pci device goes away the doe_mb structure may get free'ed
> prior to other threads having a chance to check doe_mb->flags.  Worse yet the
> work queue itself (doe_mb->wq) may become invalid...
> 
> I don't believe this can currently happen because anyone using the doe_mb
> structure has a reference to the pci device.
> 
> With this patch I think all the doe_mb->flags and the wait queue can go away.
> pci_doe_wait() can be replaced with a simple msleep_interruptible().
> 
> Let me work through that a bit.
> 
> Ira
> 
> > 
> > Hillf
> > 
> > /**
> >  * wait_event_timeout - sleep until a condition gets true or a timeout elapses
> >  * @wq_head: the waitqueue to wait on
> >  * @condition: a C expression for the event to wait for
> >  * @timeout: timeout, in jiffies
> >  *
> >  * The process is put to sleep (TASK_UNINTERRUPTIBLE) until the
> >  * @condition evaluates to true. The @condition is checked each time
> >  * the waitqueue @wq_head is woken up.
> >  *
> >  * wake_up() has to be called after changing any variable that could
> >  * change the result of the wait condition.
> >  *
> >  * Returns:
> >  * 0 if the @condition evaluated to %false after the @timeout elapsed,
> >  * 1 if the @condition evaluated to %true after the @timeout elapsed,
> >  * or the remaining jiffies (at least 1) if the @condition evaluated
> >  * to %true before the @timeout elapsed.
> >  */  


Return-Path: <linux-pci+bounces-36420-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B7EB84F18
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 16:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2781E7B7EA4
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 13:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71521F63D9;
	Thu, 18 Sep 2025 14:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="snU8wzfN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6B12AD02;
	Thu, 18 Sep 2025 14:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758204020; cv=none; b=I8FewDoEW+nE5YP7KdiO+r22uvn/Ls2BbFG1dbxMtFeKRvaKVGpkK2+Krsc0+e1t87Uj/vQA2l5wCGqhrEGJlcSHVp7T6npzPPGNMFaXSesadUIKK8iLiuOnytCfEl01nmjZJBhVbItuNFMgTtu24SOcTIc2aq1N8HOth9RCpVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758204020; c=relaxed/simple;
	bh=XMVU+sHDWjhNf7yz3skhy780y+rTanxteszC2S1bpOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+IEHR6yGAVRVaJr+BXh1uvIP8tjn2QDazhFpa+gyt2ZS2MaooT4YENY+y5Mx/BQ0BmuJAU+N4OSrQ7nAbPqtXAOPOnC2sC9m1gFTs1EQBkd0AHgbc3x7QImncedcCRA7rTbu59MBcfYW1wMYWuCkRG8bbn8lumoc/BO8SnR3gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=snU8wzfN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10739C4CEE7;
	Thu, 18 Sep 2025 14:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758204020;
	bh=XMVU+sHDWjhNf7yz3skhy780y+rTanxteszC2S1bpOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=snU8wzfNao7CQ6+eadp7FCIQKqkHyCCmXDpHUc1Ht4gK7Zf57kxA+8KsOnxdWMnQb
	 Uw52TMd4Vp7MbPXTalxJS3vBB6sXBHhOWU822uaLR7CRXZdLrKmwsi7xjOuiy7UYJK
	 fRuyQfYI9k7p1MlfUvBeBTcTZcir9/kn3FYR7HmOz+3/tYsQto8EV29e31g/f+Ai8i
	 zRvAZOrPVS+8+j+s6jV19TEn7RD6/iNS6gGycEgX235M23DelgYNl+iMMiObrI+BfV
	 ivBcTYwzuENOhFLOa1EfqcrzrATM1Y/jRb+Tgt8k2swIaqbfiiucRE5uZrSNT//bTb
	 dCRq7Th0DyDmg==
Date: Thu, 18 Sep 2025 16:00:17 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Waiman Long <llong@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 02/33] PCI: Protect against concurrent change of
 housekeeping cpumask
Message-ID: <aMwQcVZeTwuk2Q8A@localhost.localdomain>
References: <20250829154814.47015-1-frederic@kernel.org>
 <20250829154814.47015-3-frederic@kernel.org>
 <458c5db8-0c31-4c02-9c41-b7eca851d04a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <458c5db8-0c31-4c02-9c41-b7eca851d04a@redhat.com>

Le Fri, Aug 29, 2025 at 06:01:17PM -0400, Waiman Long a écrit :
> On 8/29/25 11:47 AM, Frederic Weisbecker wrote:
> > HK_TYPE_DOMAIN will soon integrate cpuset isolated partitions and
> > therefore be made modifyable at runtime. Synchronize against the cpumask
> > update using RCU.
> > 
> > The RCU locked section includes both the housekeeping CPU target
> > election for the PCI probe work and the work enqueue.
> > 
> > This way the housekeeping update side will simply need to flush the
> > pending related works after updating the housekeeping mask in order to
> > make sure that no PCI work ever executes on an isolated CPU.
> > 
> > Signed-off-by: Frederic Weisbecker<frederic@kernel.org>
> > ---
> >   drivers/pci/pci-driver.c | 40 +++++++++++++++++++++++++++++++---------
> >   1 file changed, 31 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > index 63665240ae87..cf2b83004886 100644
> > --- a/drivers/pci/pci-driver.c
> > +++ b/drivers/pci/pci-driver.c
> > @@ -302,9 +302,8 @@ struct drv_dev_and_id {
> >   	const struct pci_device_id *id;
> >   };
> > -static long local_pci_probe(void *_ddi)
> > +static int local_pci_probe(struct drv_dev_and_id *ddi)
> >   {
> > -	struct drv_dev_and_id *ddi = _ddi;
> >   	struct pci_dev *pci_dev = ddi->dev;
> >   	struct pci_driver *pci_drv = ddi->drv;
> >   	struct device *dev = &pci_dev->dev;
> > @@ -338,6 +337,19 @@ static long local_pci_probe(void *_ddi)
> >   	return 0;
> >   }
> > +struct pci_probe_arg {
> > +	struct drv_dev_and_id *ddi;
> > +	struct work_struct work;
> > +	int ret;
> > +};
> > +
> > +static void local_pci_probe_callback(struct work_struct *work)
> > +{
> > +	struct pci_probe_arg *arg = container_of(work, struct pci_probe_arg, work);
> > +
> > +	arg->ret = local_pci_probe(arg->ddi);
> > +}
> > +
> >   static bool pci_physfn_is_probed(struct pci_dev *dev)
> >   {
> >   #ifdef CONFIG_PCI_IOV
> > @@ -362,34 +374,44 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
> >   	dev->is_probed = 1;
> >   	cpu_hotplug_disable();
> > -
> >   	/*
> >   	 * Prevent nesting work_on_cpu() for the case where a Virtual Function
> >   	 * device is probed from work_on_cpu() of the Physical device.
> >   	 */
> >   	if (node < 0 || node >= MAX_NUMNODES || !node_online(node) ||
> >   	    pci_physfn_is_probed(dev)) {
> > -		cpu = nr_cpu_ids;
> > +		error = local_pci_probe(&ddi);
> >   	} else {
> >   		cpumask_var_t wq_domain_mask;
> > +		struct pci_probe_arg arg = { .ddi = &ddi };
> > +
> > +		INIT_WORK_ONSTACK(&arg.work, local_pci_probe_callback);
> >   		if (!zalloc_cpumask_var(&wq_domain_mask, GFP_KERNEL)) {
> >   			error = -ENOMEM;
> >   			goto out;
> >   		}
> > +
> > +		rcu_read_lock();
> >   		cpumask_and(wq_domain_mask,
> >   			    housekeeping_cpumask(HK_TYPE_WQ),
> >   			    housekeeping_cpumask(HK_TYPE_DOMAIN));
> >   		cpu = cpumask_any_and(cpumask_of_node(node),
> >   				      wq_domain_mask);
> > +		if (cpu < nr_cpu_ids) {
> > +			schedule_work_on(cpu, &arg.work);
> > +			rcu_read_unlock();
> > +			flush_work(&arg.work);
> > +			error = arg.ret;
> > +		} else {
> > +			rcu_read_unlock();
> > +			error = local_pci_probe(&ddi);
> > +		}
> > +
> >   		free_cpumask_var(wq_domain_mask);
> > +		destroy_work_on_stack(&arg.work);
> >   	}
> > -
> > -	if (cpu < nr_cpu_ids)
> > -		error = work_on_cpu(cpu, local_pci_probe, &ddi);
> > -	else
> > -		error = local_pci_probe(&ddi);
> >   out:
> >   	dev->is_probed = 0;
> >   	cpu_hotplug_enable();
> 
> A question. Is the purpose of open-coding work_on_cpu() to avoid calling
> INIT_WORK_ONSTACK() and destroy_work_on_stack() in RCU read-side critical
> section? These two macro/function may call debugobjects code which I don't
> know if they are allowed inside rcu_read_lock() critical section.
> 
> Cheers, Longman

No the point is that I need to keep the target selection
(housekeeping_cpumask() read) and the work queue within the same
RCU critical section so that things are synchronized that way:

    CPU 0                                          CPU 1
    -----                                          -----
    rcu_read_lock()                                housekeeping_update()
    cpu = cpumask_any(housekeeping_cpumask(...))       housekeeping_cpumask &= ~val
    queue_work_on(cpu, pci_probe_wq, work)             synchronize_rcu()
    rcu_read_unlock()                                  flush_workqueue(pci_probe_wq)
    flush_work(work)
        
And I can't include the whole work_on_cpu() within rcu_read_lock() because
flush_work() may sleep.

Also now that you mention it, I need to create that pci_probe_wq and flush it :-)

-- 
Frederic Weisbecker
SUSE Labs


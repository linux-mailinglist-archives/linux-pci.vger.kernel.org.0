Return-Path: <linux-pci+bounces-21648-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B678A38A0C
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 17:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26B093A67BC
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 16:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76368225A42;
	Mon, 17 Feb 2025 16:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S1Y+LOrJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF73F225794
	for <linux-pci@vger.kernel.org>; Mon, 17 Feb 2025 16:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739811052; cv=none; b=glTQTGjCATPR43PlK4QPtf7q7LdlRm7uwD11BNzwbkScDzLGL0w1A6t3wuWzSpxHFtiob+4tr3t/HSKHy60pHGo7WNaciIad5MqMI2FU19Q7yLV6W6E0iuk9rKTYMEeXJzYd+114FnKBBtkTdtPdgOeGYOOmjUBezoTNhKOLujI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739811052; c=relaxed/simple;
	bh=g1iM3E0eko5yyQkBY2WQrPad/kXZVJL9BM7/AuP06Go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZ93zpxNt4tME7aozDKYLvDIYcSEDzPlgyP1DLVjQ5jMyy66xo6qQaSQ8ETRqD+kQZv2kzG46NyxEv99ZRvl0MCn3HthIF4cZduWtypCJZGg8C1spPU8IY2EYMFS9fVWEVAWy4LnW6XJcWYk1XldbpCARDVnueu7P2jgax/X20M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S1Y+LOrJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739811048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SfrDqzy3zKld0aEmzBn8pAQDzQM1IhY2QV5TIc1FvQM=;
	b=S1Y+LOrJHHYQYnqBPRpdceIoHcOS9FhiEqwZEq6BU5EkXuTxOZhn8l3ycdF5e7KHZEGQXf
	lT9n4EioBzGD9a6riczqQcmFXlw2LEar33BCQz46nwp+nbMPDCQdG/uHDzX+iLO/rLvzX/
	uWRtWIK9aosXX9z6PiTZ5afmcHZKYFk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-102-tWhqy1umOme5TKnrBszsZQ-1; Mon,
 17 Feb 2025 11:50:43 -0500
X-MC-Unique: tWhqy1umOme5TKnrBszsZQ-1
X-Mimecast-MFC-AGG-ID: tWhqy1umOme5TKnrBszsZQ_1739811041
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B082A180087E;
	Mon, 17 Feb 2025 16:50:40 +0000 (UTC)
Received: from localhost (unknown [10.22.80.58])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 510CB1800365;
	Mon, 17 Feb 2025 16:50:39 +0000 (UTC)
Date: Mon, 17 Feb 2025 13:50:37 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Ryo Takakura <ryotkkr98@gmail.com>
Cc: bhelgaas@google.com, jonathan.derrick@linux.dev, kw@linux.com,
	lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org,
	nirmal.patel@linux.intel.com, robh@kernel.org,
	bigeasy@linutronix.de, rostedt@goodmis.org, kbusch@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v3] PCI: vmd: Fix spinlock usage on config access for RT
 kernel
Message-ID: <Z7No3XzmE3t54qNi@uudg.org>
References: <20241219014549.24427-1-ryotkkr98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219014549.24427-1-ryotkkr98@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Thu, Dec 19, 2024 at 10:45:49AM +0900, Ryo Takakura wrote:
> PCI config access is locked with pci_lock which is raw_spinlock.
> Convert cfg_lock to raw_spinlock so that the lock usage is consistent
> for RT kernel.

Any movement here?

Tested-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Acked-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>

Best,
Luis

> Reported as following:
> [   18.756807] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
> [   18.756810] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 1617, name: nodedev-init
> [   18.756810] preempt_count: 1, expected: 0
> [   18.756811] RCU nest depth: 0, expected: 0
> [   18.756811] INFO: lockdep is turned off.
> [   18.756812] irq event stamp: 0
> [   18.756812] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> [   18.756815] hardirqs last disabled at (0): [<ffffffff864f1fe2>] copy_process+0xa62/0x2d90
> [   18.756819] softirqs last  enabled at (0): [<ffffffff864f1fe2>] copy_process+0xa62/0x2d90
> [   18.756820] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [   18.756822] CPU: 3 UID: 0 PID: 1617 Comm: nodedev-init Tainted: G        W          6.12.1 #11
> [   18.756823] Tainted: [W]=WARN
> [   18.756824] Hardware name: Dell Inc. Vostro 3710/0K1D6X, BIOS 1.14.0 06/09/2023
> [   18.756825] Call Trace:
> [   18.756826]  <TASK>
> [   18.756827]  dump_stack_lvl+0x9b/0xf0
> [   18.756830]  dump_stack+0x10/0x20
> [   18.756831]  __might_resched+0x158/0x230
> [   18.756833]  rt_spin_lock+0x4e/0x130
> [   18.756837]  ? vmd_pci_read+0x8d/0x100 [vmd]
> [   18.756839]  vmd_pci_read+0x8d/0x100 [vmd]
> [   18.756840]  pci_user_read_config_byte+0x6f/0xe0
> [   18.756843]  pci_read_config+0xfe/0x290
> [   18.756845]  sysfs_kf_bin_read+0x68/0x90
> [   18.756847]  kernfs_fop_read_iter+0xd7/0x200
> [   18.756850]  vfs_read+0x26d/0x360
> [   18.756853]  ksys_read+0x70/0xf0
> [   18.756855]  __x64_sys_read+0x1a/0x20
> [   18.756857]  x64_sys_call+0x1715/0x20d0
> [   18.756859]  do_syscall_64+0x8f/0x170
> [   18.756861]  ? syscall_exit_to_user_mode+0xcd/0x2c0
> [   18.756863]  ? do_syscall_64+0x9b/0x170
> [   18.756865]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
> 
> ---
> 
> Hi!
> 
> This is same as the first version of the patch as discussed over v2.
> 
> v1:
> https://lore.kernel.org/lkml/20241215141321.383144-1-ryotkkr98@gmail.com/T/
> 
> Changes since v2:
> https://lore.kernel.org/lkml/20241218115951.83062-1-ryotkkr98@gmail.com/T/
> 
> - In case if CONFIG_PCI_LOCKLESS_CONFIG is set, vmd_pci_read/write()
>   still neeed cfg_lock for their serialization. So instead of removing
>   it, convert it to raw spinlock.
> 
> ---
>  drivers/pci/controller/vmd.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 9d9596947..94ceec50a 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -125,7 +125,7 @@ struct vmd_irq_list {
>  struct vmd_dev {
>  	struct pci_dev		*dev;
>  
> -	spinlock_t		cfg_lock;
> +	raw_spinlock_t		cfg_lock;
>  	void __iomem		*cfgbar;
>  
>  	int msix_count;
> @@ -391,7 +391,7 @@ static int vmd_pci_read(struct pci_bus *bus, unsigned int devfn, int reg,
>  	if (!addr)
>  		return -EFAULT;
>  
> -	spin_lock_irqsave(&vmd->cfg_lock, flags);
> +	raw_spin_lock_irqsave(&vmd->cfg_lock, flags);
>  	switch (len) {
>  	case 1:
>  		*value = readb(addr);
> @@ -406,7 +406,7 @@ static int vmd_pci_read(struct pci_bus *bus, unsigned int devfn, int reg,
>  		ret = -EINVAL;
>  		break;
>  	}
> -	spin_unlock_irqrestore(&vmd->cfg_lock, flags);
> +	raw_spin_unlock_irqrestore(&vmd->cfg_lock, flags);
>  	return ret;
>  }
>  
> @@ -426,7 +426,7 @@ static int vmd_pci_write(struct pci_bus *bus, unsigned int devfn, int reg,
>  	if (!addr)
>  		return -EFAULT;
>  
> -	spin_lock_irqsave(&vmd->cfg_lock, flags);
> +	raw_spin_lock_irqsave(&vmd->cfg_lock, flags);
>  	switch (len) {
>  	case 1:
>  		writeb(value, addr);
> @@ -444,7 +444,7 @@ static int vmd_pci_write(struct pci_bus *bus, unsigned int devfn, int reg,
>  		ret = -EINVAL;
>  		break;
>  	}
> -	spin_unlock_irqrestore(&vmd->cfg_lock, flags);
> +	raw_spin_unlock_irqrestore(&vmd->cfg_lock, flags);
>  	return ret;
>  }
>  
> @@ -1009,7 +1009,7 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	if (features & VMD_FEAT_OFFSET_FIRST_VECTOR)
>  		vmd->first_vec = 1;
>  
> -	spin_lock_init(&vmd->cfg_lock);
> +	raw_spin_lock_init(&vmd->cfg_lock);
>  	pci_set_drvdata(dev, vmd);
>  	err = vmd_enable_domain(vmd, features);
>  	if (err)
> -- 
> 2.34.1
> 
---end quoted text---



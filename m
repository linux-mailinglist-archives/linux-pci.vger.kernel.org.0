Return-Path: <linux-pci+bounces-18511-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 630AA9F334B
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 15:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E2F97A22B0
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 14:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2032205E3B;
	Mon, 16 Dec 2024 14:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IquAZmyA"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8225204588
	for <linux-pci@vger.kernel.org>; Mon, 16 Dec 2024 14:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734359647; cv=none; b=uwYWLpQBn9mF6yqN6nFfPuVfvjFFZ+yYBpYyTeV29KmN/YvD6qdrD/UyjkrnedSisZtrYJto7MMksk/h+XYIpeN/sHoUThUmARvPSqtT0O5aQSr3K+0qklePQTxpNisGeBmxPxRJDuYR7Z437Nk0p9BrDeEBbY56xKzWx+IGtls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734359647; c=relaxed/simple;
	bh=oTRXj583qhXYalltzk7nvbwA7tflotqemGH5c0pkMus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Es8kvvoOeAdUv1JXzfxuyz9oMg0x2gxBtijSCwVe/We3KP1/K9B/2oublMjY9eCgQR1rDnkGoEX7I+5O6afEtEWHrq3xkBZuFaoXo5fomEAKyYzwILFSw0ef0/h+9ABQQC7480bBYBKraqtPsA4S9KaRbrcMQKhXoZgXhWSZEbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IquAZmyA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734359644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VkhxEwUUHPw94KlIQ0Cbt2szuO3qNDjFa8Hwl+dqHhw=;
	b=IquAZmyAJ2X6IK2jXMe3WoErqfv2mP7qPrJ+vxGM+m++/WL3Y23XIm5B36Hq579U57z63z
	yD3MaKb1mykAFNYv9CTB6/g3nPZ8liZWcfy540V5QPw8BB+tHG5jhLmftdNt7CaCVg+qf3
	C9Ww64gOCSOrIn0+bTSuvFgPGir6j+4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-idgB9--NMKaO44SRTukU3g-1; Mon,
 16 Dec 2024 09:34:01 -0500
X-MC-Unique: idgB9--NMKaO44SRTukU3g-1
X-Mimecast-MFC-AGG-ID: idgB9--NMKaO44SRTukU3g
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7D53D1955F77;
	Mon, 16 Dec 2024 14:33:59 +0000 (UTC)
Received: from localhost (unknown [10.22.88.147])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5B32419560A3;
	Mon, 16 Dec 2024 14:33:58 +0000 (UTC)
Date: Mon, 16 Dec 2024 11:33:56 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Ryo Takakura <ryotkkr98@gmail.com>
Cc: nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
	lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] PCI: vmd: Fix spinlock usage on config access for RT
 kernel
Message-ID: <Z2A6VEMN5jkXg2lr@uudg.org>
References: <20241215141321.383144-1-ryotkkr98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241215141321.383144-1-ryotkkr98@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Sun, Dec 15, 2024 at 11:13:21PM +0900, Ryo Takakura wrote:
> PCI config access is locked with pci_lock which is raw_spinlock.
> Convert cfg_lock to raw_spinlock so that the lock usage is consistent
> for RT kernel.
> 
> Reported as following:
> [   18.756807] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
> [   18.756810] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 1617, name: nodedev-init
> [   18.756810] preempt_count: 1, expected: 0
> [   18.756811] RCU nest depth: 0, expected: 0
> [   18.756811] INFO: lockdep is turned off.
> [   18.756812] irq event stamp: 0

This problem has been discussed in the past at:

    [PATCH v6.4-rc5-rt4] rt: vmd: make cfg_lock a raw spinlock
    https://lore.kernel.org/linux-rt-users/20230608210232.056e731f@gandalf.local.home/T/#t

And there was a suggestion to remove the lock altogether as (at the time) the
only two call sites of vmd_pci_read() were already protected by pci_lock.

I wrote the patch removing the lock and it worked as expected, but never
sent it to the list. If you think that for the current code that makes
sense, please have fun removing the lock. :)

Best regards,
Luis

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
> 
---end quoted text---



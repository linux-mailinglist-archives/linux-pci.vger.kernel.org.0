Return-Path: <linux-pci+bounces-18696-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E2E9F672B
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 14:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC3C21648A1
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 13:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B208B1F0E32;
	Wed, 18 Dec 2024 13:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KonLLg+n"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE2B1EF093
	for <linux-pci@vger.kernel.org>; Wed, 18 Dec 2024 13:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734527854; cv=none; b=mqF9tAqzHe/3bxT70HzR5ESw3ORAyz/SfskRhABOs1zuw0HWV4rSwnQZM/W2S09LuskH/X/7qicjK2WOJAEe5Slg3V6N/XTm7BkTBs3A+2YlC8yfqvFFwS6GZIHXWbJlRd5SYvfSfrxK8hrpgijv9pbD/qgqu4bSI3UiDIDBXms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734527854; c=relaxed/simple;
	bh=KmHYa21lj826stnbrgZHHiVgcWy3kG6DgaDRpDonehM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xn7YvhQgatTEPPkYLrPWcjKZvS89MvFMNHp/0nH4PWZADpq61jIyMVk2ZMJwTIAKP/9I+8+iBy9I3tXl0Xyip8SDZUQAAOmCL3whkHwlrMDJAicHCNOWyvS9jS36rPN6iPtuAwGqfG931Ozp5jbhyhgyRFY4kDb4w72nNblzCIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KonLLg+n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734527851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dkUmObNyd3luMSujCoF8tqBFETH6TbAw8siM2qHvUZI=;
	b=KonLLg+nSyx36QgEI/CkYRlB7Kz6VhvkGR4idg9ilT93t037r0P8ZxzNcSHoZnOITcvR/C
	9kcyFMO5yf8D+b0UXA/Oveo30Y+695XUyD5yaxSDckiy0rns8Cuyc/FBJk3rK+MzsE6ykT
	53fq2sTtDOS3lkSId2ADxf8/jsvTdwk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-_zNPhDJjMLyU4yij0oEiwg-1; Wed,
 18 Dec 2024 08:17:25 -0500
X-MC-Unique: _zNPhDJjMLyU4yij0oEiwg-1
X-Mimecast-MFC-AGG-ID: _zNPhDJjMLyU4yij0oEiwg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8273E1955EF9;
	Wed, 18 Dec 2024 13:17:19 +0000 (UTC)
Received: from localhost (unknown [10.22.80.196])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7202519560AD;
	Wed, 18 Dec 2024 13:17:18 +0000 (UTC)
Date: Wed, 18 Dec 2024 10:17:17 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Ryo Takakura <ryotkkr98@gmail.com>
Cc: bhelgaas@google.com, jonathan.derrick@linux.dev, kw@linux.com,
	lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org,
	nirmal.patel@linux.intel.com, robh@kernel.org,
	bigeasy@linutronix.de, rostedt@goodmis.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2] PCI: vmd: Fix spinlock usage on config access for RT
 kernel
Message-ID: <Z2LLXUwxEtjNNc8K@uudg.org>
References: <20241218115951.83062-1-ryotkkr98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218115951.83062-1-ryotkkr98@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Wed, Dec 18, 2024 at 08:59:51PM +0900, Ryo Takakura wrote:
> PCI config access is locked with pci_lock which serializes
> pci_user/bus_write_config*() and pci_user/bus_read_config*().
> The subsequently invoked vmd_pci_write() and vmd_pci_read() are also
> serialized as they are only invoked by them respectively.
> 
> Remove cfg_lock which is taken by vmd_pci_write() and vmd_pci_read()
> for their serialization as its already serialized by pci_lock.
> 
> This fixes the spinlock_t(cfg_lock) usage within
> raw_spinlock_t(pci_lock) on RT kernels where spinlock_t becomes
> sleepable.
> 
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
> ---

Reviewed-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>

Best regards,
Luis
 
> Thanks Luis for feedback!
> 
> Changes since v1:
> https://lore.kernel.org/lkml/20241215141321.383144-1-ryotkkr98@gmail.com/T/
> 
> - Remove cfg_lock instead of converting it to raw spinlock as suggested
>   by Sebastian[0].
>   
> [0] https://lore.kernel.org/linux-rt-users/20230620154434.MosrzRUh@linutronix.de/
> 
> ---
>  drivers/pci/controller/vmd.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 9d9596947..2be898424 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -125,7 +125,6 @@ struct vmd_irq_list {
>  struct vmd_dev {
>  	struct pci_dev		*dev;
>  
> -	spinlock_t		cfg_lock;
>  	void __iomem		*cfgbar;
>  
>  	int msix_count;
> @@ -385,13 +384,11 @@ static int vmd_pci_read(struct pci_bus *bus, unsigned int devfn, int reg,
>  {
>  	struct vmd_dev *vmd = vmd_from_bus(bus);
>  	void __iomem *addr = vmd_cfg_addr(vmd, bus, devfn, reg, len);
> -	unsigned long flags;
>  	int ret = 0;
>  
>  	if (!addr)
>  		return -EFAULT;
>  
> -	spin_lock_irqsave(&vmd->cfg_lock, flags);
>  	switch (len) {
>  	case 1:
>  		*value = readb(addr);
> @@ -406,7 +403,6 @@ static int vmd_pci_read(struct pci_bus *bus, unsigned int devfn, int reg,
>  		ret = -EINVAL;
>  		break;
>  	}
> -	spin_unlock_irqrestore(&vmd->cfg_lock, flags);
>  	return ret;
>  }
>  
> @@ -420,13 +416,11 @@ static int vmd_pci_write(struct pci_bus *bus, unsigned int devfn, int reg,
>  {
>  	struct vmd_dev *vmd = vmd_from_bus(bus);
>  	void __iomem *addr = vmd_cfg_addr(vmd, bus, devfn, reg, len);
> -	unsigned long flags;
>  	int ret = 0;
>  
>  	if (!addr)
>  		return -EFAULT;
>  
> -	spin_lock_irqsave(&vmd->cfg_lock, flags);
>  	switch (len) {
>  	case 1:
>  		writeb(value, addr);
> @@ -444,7 +438,6 @@ static int vmd_pci_write(struct pci_bus *bus, unsigned int devfn, int reg,
>  		ret = -EINVAL;
>  		break;
>  	}
> -	spin_unlock_irqrestore(&vmd->cfg_lock, flags);
>  	return ret;
>  }
>  
> @@ -1009,7 +1002,6 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	if (features & VMD_FEAT_OFFSET_FIRST_VECTOR)
>  		vmd->first_vec = 1;
>  
> -	spin_lock_init(&vmd->cfg_lock);
>  	pci_set_drvdata(dev, vmd);
>  	err = vmd_enable_domain(vmd, features);
>  	if (err)
> -- 
> 2.34.1
> 
---end quoted text---



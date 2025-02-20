Return-Path: <linux-pci+bounces-21934-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C181A3E7EA
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 00:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 829CB3B993A
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 22:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60608265CAC;
	Thu, 20 Feb 2025 22:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2iTOlc8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2529B265635;
	Thu, 20 Feb 2025 22:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740092391; cv=none; b=vF0WY+obiBFt8/jbk8JzU2ysDYuYCdUgP3kNLhVC7BRAXh2JWAPg0et/1uzib1KNRape8FJO3jRrU5Zd8QpPY2uw8v88RsK1QwKtOn1LRh1X7fMTcFICFfV2WIr40GTsjuErPrJzeZiNnOWIO4LUl59p1qDtTb4zTmJVELZbHbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740092391; c=relaxed/simple;
	bh=3S+TCq9Fx8ACf/yVx79pjGFNRic4JKbeNZIjQEJfLqA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KW/ffsdjhzX2+cZo993Tgwf/wR0R8wE8/xVg7vK0MLfyVSQ27qju5OtiqvgCddWAn5R++FD7ALhj2ERC9Wx12yngxGVIVsyRK0N0+yDZY1ufUFIVelg3r9ZvuIA3KdSpDVP6Mrvse5u7MMLKLDeqvhod/Nr0iCExaUxgNGc6ELc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g2iTOlc8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732FAC4CED1;
	Thu, 20 Feb 2025 22:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740092390;
	bh=3S+TCq9Fx8ACf/yVx79pjGFNRic4JKbeNZIjQEJfLqA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=g2iTOlc8adtYCkf1+qhUD/uYV0fpGwPYOjAx3hyOYjjGrVwAPYZpWFgZzgS4Q3FSa
	 dzIs3ecCv/1IA1mMkKHHWdabeEd1R5DX6SVwuccVrUthK0+g8ZPaIKlcKfNEp96dG4
	 imUaah3p4TyAFFBVrXjcgw+PgzpeYJzxByDFj5WczTSIkNKqHu6qQt3ycYeMkz2gem
	 whsD4yTnIEqCOs/I+n2QC0UqwH79Q38cerLhdjfWzHygvx66OYzBlwB2hi0fGTDGd2
	 Pyq+uq6IWv7Qm/NJFlFswkyfKY7N8ImT90T6ackUhRZtVDKq9d2ZfMpbG8JOiHN5Gx
	 RpHVIbfPVxS9g==
Date: Thu, 20 Feb 2025 16:59:48 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-pci@vger.kernel.org,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Ryo Takakura <ryotkkr98@gmail.com>, bhelgaas@google.com,
	jonathan.derrick@linux.dev, kw@linux.com, lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org, nirmal.patel@linux.intel.com,
	robh@kernel.org, rostedt@goodmis.org, kbusch@kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v4] PCI: vmd: Make vmd_dev::cfg_lock a raw_spinlock_t.
Message-ID: <20250220225948.GA318342@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218080830.ufw3IgyX@linutronix.de>

On Tue, Feb 18, 2025 at 09:08:30AM +0100, Sebastian Andrzej Siewior wrote:
> From: Ryo Takakura <ryotkkr98@gmail.com>
> 
> The access to the PCI config space via pci_ops::read and pci_ops::write
> is a low-level hardware access. The functions can be accessed with
> disabled interrupts even on PREEMPT_RT. The pci_lock has been made a
> raw_spinlock_t for this purpose. A spinlock_t becomes a sleeping lock on
> PREEMPT_RT can not be acquired with disabled interrupts.

I think this is missing a word or two and should say:

  A spinlock_t becomes a sleeping lock on PREEMPT_RT, so it cannot be
  acquired with disabled interrupts.

pci_ops.read() is called while holding the non-sleepable
raw_spinlock_t pci_lock, so pci_ops.read() must also be non-sleepable.

It's not really relevant that "pci_ops.read() can be called with
disabled interrupts even on PREEMPT_RT".  It can *always* be called
with interrupts disabled.

> The vmd_dev::cfg_lock is accessed in the same context as the pci_lock.
> 
> Make vmd_dev::cfg_lock a raw_spinlock_t.
> 
> [bigeasy: Reword commit message.]
> 
> Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
> Tested-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
> Acked-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> Changes since v3 https://lore.kernel.org/all/20241219014549.24427-1-ryotkkr98@gmail.com/
> - Repost with updated changelog.
> 
> Changes since v2 https://lore.kernel.org/lkml/20241218115951.83062-1-ryotkkr98@gmail.com/
> - In case if CONFIG_PCI_LOCKLESS_CONFIG is set, vmd_pci_read/write()
>   still neeed cfg_lock for their serialization. So instead of removing
>   it, convert it to raw spinlock.
> 
> v1: https://lore.kernel.org/lkml/20241215141321.383144-1-ryotkkr98@gmail.com/
> 
>  drivers/pci/controller/vmd.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 9d9596947350f..94ceec50a2b94 100644
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
> 2.47.2
> 


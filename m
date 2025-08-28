Return-Path: <linux-pci+bounces-35010-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAD4B39DED
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 14:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16BD87B5478
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 12:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DB330FC33;
	Thu, 28 Aug 2025 12:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="o4svpt7O"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1E3264623;
	Thu, 28 Aug 2025 12:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756385956; cv=none; b=JtZQWK/6ZcHCKZcUXDTcA0x/mRv2UocACjJsGOi5b40bTgdIxly73i13aeawXVnG9t9xyA1wwoT+A5pT7+tKMjsxqIaF5wufNsk/LgK1K9fiR2xK+xeiK8J/ePmP+RRTG2M7HwUFX0MGV/cDIPtcIoBIrBfwxPIwsTV+OBpxzDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756385956; c=relaxed/simple;
	bh=Z7hCE0cBvCLsWktaSW1in1f7sYjUXfEi77iTLjXRdy0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=aa+zN9nCabhOGV1BoOQnOqQL0dVw8Oly1gwEIrjdIIsABtnvxn5z5POO9F2T32e4ZOb/dTcsNEnzd6CvvhJkn/VxSLHi/2g4P9wbKb5bAA3VsCNTMY8YMsXZ2VqZBBwdIMkzLpid2xVTaN6Rvo7LliyVa8Wok8GW10MBQTHNiRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=o4svpt7O; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=tej4xDeR9oan5Z8XsFTq7lWWeBWrWd6d7/yJqeS6Ne0=;
  b=o4svpt7OwJF42mm71/IFLOVdYtcypaaeCy5PXhc6mpZVgKIXD2KuC+Sj
   +eFs8563Fsw9c1hxBoFS3hhafNvl0mZwm6CwwH7hMOMsnm7by+ogY5O+F
   xHQfaYmP6fEeE1X6lyUZNTprw8KNI6ggeDs2Pkrsn7fYMvOgW+agg2w5L
   E=;
X-CSE-ConnectionGUID: Gv2Er3lWSF2JFSKFOFvTWA==
X-CSE-MsgGUID: 0uP848FURrKgLVZQKcJxKA==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.18,217,1751234400"; 
   d="scan'208";a="236493481"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 14:58:02 +0200
Date: Thu, 28 Aug 2025 14:58:02 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Erick Karanja <karanja99erick@gmail.com>
cc: bhelgaas@google.com, linux-pci@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/VGA: Replace manual locks with lock guards
In-Reply-To: <20250828122524.1233749-1-karanja99erick@gmail.com>
Message-ID: <41608ee8-855-ca43-36a0-3544d6b5c9a@inria.fr>
References: <20250828122524.1233749-1-karanja99erick@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Thu, 28 Aug 2025, Erick Karanja wrote:

> Switch from explicit lock/unlock pairs to scoped lock guards.
> This simplifies error handling and improves code readability.
>
> Generated-by: Coccinelle SmPL
>
> Signed-off-by: Erick Karanja <karanja99erick@gmail.com>
> ---
>  drivers/pci/vgaarb.c | 87 ++++++++++++++++----------------------------
>  1 file changed, 32 insertions(+), 55 deletions(-)
>
> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> index 78748e8d2dba..6a00ee00e362 100644
> --- a/drivers/pci/vgaarb.c
> +++ b/drivers/pci/vgaarb.c
> @@ -501,8 +501,6 @@ EXPORT_SYMBOL(vga_get);
>  static int vga_tryget(struct pci_dev *pdev, unsigned int rsrc)
>  {
>  	struct vga_device *vgadev;
> -	unsigned long flags;
> -	int rc = 0;
>
>  	vga_check_first_use();
>
> @@ -511,17 +509,13 @@ static int vga_tryget(struct pci_dev *pdev, unsigned int rsrc)
>  		pdev = vga_default_device();
>  	if (pdev == NULL)
>  		return 0;
> -	spin_lock_irqsave(&vga_lock, flags);
> +	guard(spinlock_irqsave)(&vga_lock);
>  	vgadev = vgadev_find(pdev);
> -	if (vgadev == NULL) {
> -		rc = -ENODEV;
> -		goto bail;
> -	}
> +	if (vgadev == NULL)
> +		return -ENODEV;
>  	if (__vga_tryget(vgadev, rsrc))
> -		rc = -EBUSY;
> -bail:
> -	spin_unlock_irqrestore(&vga_lock, flags);
> -	return rc;
> +		return -EBUSY;
> +	return 0;
>  }
>
>  /**
> @@ -537,20 +531,17 @@ static int vga_tryget(struct pci_dev *pdev, unsigned int rsrc)
>  void vga_put(struct pci_dev *pdev, unsigned int rsrc)
>  {
>  	struct vga_device *vgadev;
> -	unsigned long flags;
>
>  	/* The caller should check for this, but let's be sure */
>  	if (pdev == NULL)
>  		pdev = vga_default_device();
>  	if (pdev == NULL)
>  		return;
> -	spin_lock_irqsave(&vga_lock, flags);
> +	guard(spinlock_irqsave)(&vga_lock);
>  	vgadev = vgadev_find(pdev);
>  	if (vgadev == NULL)
> -		goto bail;
> +		return;
>  	__vga_put(vgadev, rsrc);
> -bail:
> -	spin_unlock_irqrestore(&vga_lock, flags);
>  }
>  EXPORT_SYMBOL(vga_put);
>
> @@ -912,29 +903,20 @@ static void __vga_set_legacy_decoding(struct pci_dev *pdev,
>  				      bool userspace)
>  {
>  	struct vga_device *vgadev;
> -	unsigned long flags;
>
>  	decodes &= VGA_RSRC_LEGACY_MASK;
>
> -	spin_lock_irqsave(&vga_lock, flags);
> +	guard(spinlock_irqsave)(&vga_lock);
>  	vgadev = vgadev_find(pdev);
>  	if (vgadev == NULL)
> -		goto bail;
> +		return;
>
>  	/* Don't let userspace futz with kernel driver decodes */
>  	if (userspace && vgadev->set_decode)
> -		goto bail;
> +		return;
>
>  	/* Update the device decodes + counter */
>  	vga_update_device_decodes(vgadev, decodes);
> -
> -	/*
> -	 * XXX If somebody is going from "doesn't decode" to "decodes"
> -	 * state here, additional care must be taken as we may have pending
> -	 * ownership of non-legacy region.
> -	 */

Maybe the comment should be kept somehow?

julia

> -bail:
> -	spin_unlock_irqrestore(&vga_lock, flags);
>  }
>
>  /**
> @@ -981,14 +963,13 @@ EXPORT_SYMBOL(vga_set_legacy_decoding);
>  int vga_client_register(struct pci_dev *pdev,
>  		unsigned int (*set_decode)(struct pci_dev *pdev, bool decode))
>  {
> -	unsigned long flags;
>  	struct vga_device *vgadev;
>
> -	spin_lock_irqsave(&vga_lock, flags);
> -	vgadev = vgadev_find(pdev);
> -	if (vgadev)
> -		vgadev->set_decode = set_decode;
> -	spin_unlock_irqrestore(&vga_lock, flags);
> +	scoped_guard (spinlock_irqsave, &vga_lock) {
> +		vgadev = vgadev_find(pdev);
> +		if (vgadev)
> +			vgadev->set_decode = set_decode;
> +	}
>  	if (!vgadev)
>  		return -ENODEV;
>  	return 0;
> @@ -1411,7 +1392,6 @@ static __poll_t vga_arb_fpoll(struct file *file, poll_table *wait)
>  static int vga_arb_open(struct inode *inode, struct file *file)
>  {
>  	struct vga_arb_private *priv;
> -	unsigned long flags;
>
>  	pr_debug("%s\n", __func__);
>
> @@ -1421,9 +1401,8 @@ static int vga_arb_open(struct inode *inode, struct file *file)
>  	spin_lock_init(&priv->lock);
>  	file->private_data = priv;
>
> -	spin_lock_irqsave(&vga_user_lock, flags);
> -	list_add(&priv->list, &vga_user_list);
> -	spin_unlock_irqrestore(&vga_user_lock, flags);
> +	scoped_guard (spinlock_irqsave, &vga_user_lock)
> +		list_add(&priv->list, &vga_user_list);
>
>  	/* Set the client's lists of locks */
>  	priv->target = vga_default_device(); /* Maybe this is still null! */
> @@ -1438,25 +1417,25 @@ static int vga_arb_release(struct inode *inode, struct file *file)
>  {
>  	struct vga_arb_private *priv = file->private_data;
>  	struct vga_arb_user_card *uc;
> -	unsigned long flags;
>  	int i;
>
>  	pr_debug("%s\n", __func__);
>
> -	spin_lock_irqsave(&vga_user_lock, flags);
> -	list_del(&priv->list);
> -	for (i = 0; i < MAX_USER_CARDS; i++) {
> -		uc = &priv->cards[i];
> -		if (uc->pdev == NULL)
> -			continue;
> -		vgaarb_dbg(&uc->pdev->dev, "uc->io_cnt == %d, uc->mem_cnt == %d\n",
> -			uc->io_cnt, uc->mem_cnt);
> -		while (uc->io_cnt--)
> -			vga_put(uc->pdev, VGA_RSRC_LEGACY_IO);
> -		while (uc->mem_cnt--)
> -			vga_put(uc->pdev, VGA_RSRC_LEGACY_MEM);
> +	scoped_guard (spinlock_irqsave, &vga_user_lock) {
> +		list_del(&priv->list);
> +		for (i = 0; i < MAX_USER_CARDS; i++) {
> +			uc = &priv->cards[i];
> +			if (uc->pdev == NULL)
> +				continue;
> +			vgaarb_dbg(&uc->pdev->dev,
> +				   "uc->io_cnt == %d, uc->mem_cnt == %d\n",
> +				   uc->io_cnt, uc->mem_cnt);
> +			while (uc->io_cnt--)
> +				vga_put(uc->pdev, VGA_RSRC_LEGACY_IO);
> +			while (uc->mem_cnt--)
> +				vga_put(uc->pdev, VGA_RSRC_LEGACY_MEM);
> +		}
>  	}
> -	spin_unlock_irqrestore(&vga_user_lock, flags);
>
>  	kfree(priv);
>
> @@ -1470,7 +1449,6 @@ static int vga_arb_release(struct inode *inode, struct file *file)
>  static void vga_arbiter_notify_clients(void)
>  {
>  	struct vga_device *vgadev;
> -	unsigned long flags;
>  	unsigned int new_decodes;
>  	bool new_state;
>
> @@ -1479,7 +1457,7 @@ static void vga_arbiter_notify_clients(void)
>
>  	new_state = (vga_count > 1) ? false : true;
>
> -	spin_lock_irqsave(&vga_lock, flags);
> +	guard(spinlock_irqsave)(&vga_lock);
>  	list_for_each_entry(vgadev, &vga_list, list) {
>  		if (vgadev->set_decode) {
>  			new_decodes = vgadev->set_decode(vgadev->pdev,
> @@ -1487,7 +1465,6 @@ static void vga_arbiter_notify_clients(void)
>  			vga_update_device_decodes(vgadev, new_decodes);
>  		}
>  	}
> -	spin_unlock_irqrestore(&vga_lock, flags);
>  }
>
>  static int pci_notify(struct notifier_block *nb, unsigned long action,
> --
> 2.43.0
>
>


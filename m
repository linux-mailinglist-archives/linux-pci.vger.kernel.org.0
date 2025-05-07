Return-Path: <linux-pci+bounces-27357-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 625DDAAD923
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 09:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B1A84E2028
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 07:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C486672603;
	Wed,  7 May 2025 07:53:12 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42785145355;
	Wed,  7 May 2025 07:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746604392; cv=none; b=jMM/dlMXP7nE0Ut4qk3MxjvsET1RPZkR6uDgFuqBht4zNDToyZe4T0RwfS/q7V7b/mXwsfpaMtsB9IapDD27QoxbWBRRHWF0ir26MSfKwyNNedrhR7mM6P8+5XtoMMIshywihAyHZ1Lf+ddywnIJWJm0vdocHhzS26MNJA6BW8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746604392; c=relaxed/simple;
	bh=MJuwd2b++CNgDZM6eBK4/4HxoWjd1OiIQLoYKR090Fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AJhf4B+W6G+jZyZtO1HphhE28C9QFMXGm8ur5Z7MUXUNvTTvEO/3Mzk1TJBsisHX08yxXzIG3EBFrxIoZB0reksMQqP9mmLU82NIHI4O+1q5MjnV1u9NdtQyzH3MFxgPk1EwP2t3BT4FdyrEcikWFibM378pVCM0gWDMDdYoGZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id D557B2C000B2;
	Wed,  7 May 2025 09:52:42 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 34DB813178; Wed,  7 May 2025 09:53:00 +0200 (CEST)
Date: Wed, 7 May 2025 09:53:00 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Zijiang Huang <huangzjsmile@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zijiang Huang <kerayhuang@tencent.com>,
	Hao Peng <flyingpeng@tencent.com>
Subject: Re: [PATCH] PCI: Using lockless config space accessors based on
 Kconfig option
Message-ID: <aBsRXO6Us_wsdhji@wunner.de>
References: <20250507073028.2071852-1-kerayhuang@tencent.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507073028.2071852-1-kerayhuang@tencent.com>

[cc += Thomas, start of thread:
https://lore.kernel.org/r/20250507073028.2071852-1-kerayhuang@tencent.com
]

On Wed, May 07, 2025 at 03:30:28PM +0800, Zijiang Huang wrote:
> The generic PCI configuration space accessors are globally serialized via
> pci_lock. On larger systems this causes massive lock contention when the
> configuration space has to be accessed frequently. One such access pattern
> is the Intel Uncore performance counter unit.

Verbatim copy-paste from Thomas Gleixner's commit 714fe383d6c9
("PCI: Provide Kconfig option for lockless config space accessors").

> All x86 PCI configuration space accessors have either their own
> serialization or can operate completely lockless, So Disable the global
> lock in the generic PCI configuration space accessors

Also copied and rephrased from the above-mentioned commit.

The question is, why did the commit only replace raw_spin_lock()
with pci_lock_config() in the in-kernel PCI accessors, but not in
the user space accessors?  Is it safe to replace it there as well?

Why is performance of the user space accessors important?
Perhaps because of vfio?

That's the information I'm missing in the commit message.

Thanks,

Lukas

> Signed-off-by: Zijiang Huang <kerayhuang@tencent.com>
> Reviewed-by: Hao Peng <flyingpeng@tencent.com>
> ---
>  drivers/pci/access.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index 3c230ca3d..5200f7bbc 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -216,20 +216,21 @@ static noinline void pci_wait_cfg(struct pci_dev *dev)
>  }
>  
>  /* Returns 0 on success, negative values indicate error. */
> -#define PCI_USER_READ_CONFIG(size, type)					\
> +#define PCI_USER_READ_CONFIG(size, type)				\
>  int pci_user_read_config_##size						\
>  	(struct pci_dev *dev, int pos, type *val)			\
>  {									\
>  	int ret = PCIBIOS_SUCCESSFUL;					\
>  	u32 data = -1;							\
> +	unsigned long flags;						\
>  	if (PCI_##size##_BAD)						\
>  		return -EINVAL;						\
> -	raw_spin_lock_irq(&pci_lock);				\
> +	pci_lock_config(flags);						\
>  	if (unlikely(dev->block_cfg_access))				\
>  		pci_wait_cfg(dev);					\
>  	ret = dev->bus->ops->read(dev->bus, dev->devfn,			\
>  					pos, sizeof(type), &data);	\
> -	raw_spin_unlock_irq(&pci_lock);				\
> +	pci_unlock_config(flags);					\
>  	if (ret)							\
>  		PCI_SET_ERROR_RESPONSE(val);				\
>  	else								\
> @@ -244,14 +245,15 @@ int pci_user_write_config_##size					\
>  	(struct pci_dev *dev, int pos, type val)			\
>  {									\
>  	int ret = PCIBIOS_SUCCESSFUL;					\
> +	unsigned long flags;						\
>  	if (PCI_##size##_BAD)						\
>  		return -EINVAL;						\
> -	raw_spin_lock_irq(&pci_lock);				\
> +	pci_lock_config(flags);						\
>  	if (unlikely(dev->block_cfg_access))				\
>  		pci_wait_cfg(dev);					\
>  	ret = dev->bus->ops->write(dev->bus, dev->devfn,		\
>  					pos, sizeof(type), val);	\
> -	raw_spin_unlock_irq(&pci_lock);				\
> +	pci_unlock_config(flags);					\
>  	return pcibios_err_to_errno(ret);				\
>  }									\
>  EXPORT_SYMBOL_GPL(pci_user_write_config_##size);
> -- 
> 2.43.5


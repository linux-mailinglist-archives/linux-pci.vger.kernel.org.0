Return-Path: <linux-pci+bounces-14884-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B21949A499A
	for <lists+linux-pci@lfdr.de>; Sat, 19 Oct 2024 00:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 299E2B23563
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 22:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D61020E33E;
	Fri, 18 Oct 2024 22:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWfS7fxM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34446190462
	for <linux-pci@vger.kernel.org>; Fri, 18 Oct 2024 22:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729290135; cv=none; b=Om77iCvLqT6+e4Aa3wdgVUvfriwWv5eAvMkozuqbfIAQi+o5mfG7raOAdQFEgHFnsa+XI3tXc2ZCiWVU4HHL6gApxxt9fw3Ws4GnO97gUJlYGLozgjCEsXi1Yh7dS/2ScbgwwbDNjr4LUQlZhPLWD4fmYO2rkzxFvTX+UPaW5H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729290135; c=relaxed/simple;
	bh=rF3sr5UzZo2UZMyl1sbe0OwC1Jf5UtqZHirAXPaIgms=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gEom7BOuCjPFMchsX4uB18rIq1ajdX/7fijxYV9P/dJYpPmkG+Xh+oEw0Dq+F4iVjs/XqjMCWzDv5OZAfQNFRMbjlQ37MUFxSpp0E8pq8yWH7QHF5rtxTkV7w72QANLB10GmJSZrBu7KK/XkZd1SW91Zk+hJyS75xtIPaLCM8ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWfS7fxM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D156C4CEC3;
	Fri, 18 Oct 2024 22:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729290134;
	bh=rF3sr5UzZo2UZMyl1sbe0OwC1Jf5UtqZHirAXPaIgms=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=WWfS7fxMx5yBwrncFzIkoKN+PnuWw37dGKQ7s3SCR1VcKPbJIdloRkaduPb1Nfb1K
	 cmFrZ9CYVo/kPCLk5MoEctodwIgOie0Mlty0fK0vwhLysnXOA091Rwuo9Fi0Pg/re9
	 CImGVIlX5lUhGb3joIswrd55ALUBPJDIkM9NkOn2tSbEvl+jlAli80eqRfLonBca4Q
	 NeMAasaYkhCGl5J05bCXh/4m3nlNDYLOPQQPyhb+YYwJl3ij+iaVN2yW1rc2jNkyl2
	 2JfwT2cSw10g6gMc5BnVwUfDpburQYq6/6yo6d2Vp+Plg/WMdzyj4EP/PbEBB4GyAq
	 I4f9244QGKrdg==
Date: Fri, 18 Oct 2024 17:22:13 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: optimize proc sequential file read
Message-ID: <20241018222213.GA764583@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018054728.116519-1-kanie@linux.alibaba.com>

On Fri, Oct 18, 2024 at 01:47:28PM +0800, Guixin Liu wrote:
> PCI driver will traverse pci device list in pci_seq_start in every
> sequential file reading, use xarry to store all pci devices to
> accelerate finding the start.
>
> Use "time cat /proc/bus/pci/devices" to test on a machine with 13k
> pci devices,  get an increase of about 90%.

s/pci/PCI/ (several times)
s/pci_seq_start/pci_seq_start()/
s/xarry/xarray/
s/,  /, / (remove extra space)

> Without this patch:
>   real 0m0.917s
>   user 0m0.000s
>   sys  0m0.913s
> With this patch:
>   real 0m0.093s
>   user 0m0.000s
>   sys  0m0.093s

Nice speedup, for sure!

> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>  drivers/pci/pci.h    |  3 +++
>  drivers/pci/probe.c  |  1 +
>  drivers/pci/proc.c   | 64 +++++++++++++++++++++++++++++++++++++++-----
>  drivers/pci/remove.c |  1 +
>  include/linux/pci.h  |  2 ++
>  5 files changed, 64 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 14d00ce45bfa..1a7da91eeb80 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -962,4 +962,7 @@ void pcim_release_region(struct pci_dev *pdev, int bar);
>  	(PCI_CONF1_ADDRESS(bus, dev, func, reg) | \
>  	 PCI_CONF1_EXT_REG(reg))
>  
> +void pci_seq_tree_add_dev(struct pci_dev *dev);
> +void pci_seq_tree_remove_dev(struct pci_dev *dev);
> +
>  #endif /* DRIVERS_PCI_H */
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 4f68414c3086..1fd9e9022f70 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2592,6 +2592,7 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
>  	WARN_ON(ret < 0);
>  
>  	pci_npem_create(dev);
> +	pci_seq_tree_add_dev(dev);
>  }
>  
>  struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn)
> diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
> index f967709082d6..30ca071ccad5 100644
> --- a/drivers/pci/proc.c
> +++ b/drivers/pci/proc.c
> @@ -19,6 +19,9 @@
>  
>  static int proc_initialized;	/* = 0 */
>  
> +DEFINE_XARRAY_FLAGS(pci_seq_tree, 0);
> +static unsigned long pci_max_idx;
> +
>  static loff_t proc_bus_pci_lseek(struct file *file, loff_t off, int whence)
>  {
>  	struct pci_dev *dev = pde_data(file_inode(file));
> @@ -334,25 +337,72 @@ static const struct proc_ops proc_bus_pci_ops = {
>  #endif /* HAVE_PCI_MMAP */
>  };
>  
> +void pci_seq_tree_add_dev(struct pci_dev *dev)
> +{
> +	int ret;
> +
> +	if (dev) {

I don't think we should test "dev" for NULL here.  If it's NULL, I
think we have bigger problems and we should oops.

> +		xa_lock(&pci_seq_tree);
> +		pci_dev_get(dev);
> +		ret = __xa_insert(&pci_seq_tree, pci_max_idx, dev, GFP_KERNEL);
> +		if (!ret) {
> +			dev->proc_seq_idx = pci_max_idx;
> +			pci_max_idx++;
> +		} else {
> +			pci_dev_put(dev);
> +			WARN_ON(ret);
> +		}
> +		xa_unlock(&pci_seq_tree);
> +	}
> +}
> +
> +void pci_seq_tree_remove_dev(struct pci_dev *dev)
> +{
> +	unsigned long idx = dev->proc_seq_idx;
> +	struct pci_dev *latest_dev = NULL;
> +	struct pci_dev *ret;
> +
> +	if (!dev)
> +		return;

Same comment about testing "dev" for NULL.

> +	xa_lock(&pci_seq_tree);
> +	__xa_erase(&pci_seq_tree, idx);
> +	pci_dev_put(dev);
> +	/*
> +	 * Move the latest pci_dev to this idx to keep the continuity.
> +	 */
> +	if (idx != pci_max_idx - 1) {
> +		latest_dev = __xa_erase(&pci_seq_tree, pci_max_idx - 1);
> +		ret = __xa_cmpxchg(&pci_seq_tree, idx, NULL, latest_dev,
> +				GFP_KERNEL);
> +		if (!ret)
> +			latest_dev->proc_seq_idx = idx;
> +		WARN_ON(ret);
> +	}
> +	pci_max_idx--;
> +	xa_unlock(&pci_seq_tree);
> +}
> +
>  /* iterator */
>  static void *pci_seq_start(struct seq_file *m, loff_t *pos)
>  {
> -	struct pci_dev *dev = NULL;
> +	struct pci_dev *dev;
>  	loff_t n = *pos;
>  
> -	for_each_pci_dev(dev) {
> -		if (!n--)
> -			break;
> -	}
> +	dev = xa_load(&pci_seq_tree, n);
> +	if (dev)
> +		pci_dev_get(dev);
>  	return dev;

I'm a little hesitant to add another place that keeps track of every
PCI device.  It's a fair bit of code here, and it's redundant
information, which means more work to keep them all synchronized.

This proc interface feels inherently racy.  We keep track of the
current item (n) in a struct seq_file, but I don't think there's
anything to prevent a pci_dev hot-add or -remove between calls to
pci_seq_start().

Is the proc interface the only place to get this information?  If
there's a way to get it from sysfs, maybe that is better and we don't
need to spend effort optimizing the less-desirable path?

>  }
>  
>  static void *pci_seq_next(struct seq_file *m, void *v, loff_t *pos)
>  {
> -	struct pci_dev *dev = v;
> +	struct pci_dev *dev;
>  
>  	(*pos)++;
> -	dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev);
> +	dev = xa_load(&pci_seq_tree, *pos);
> +	if (dev)
> +		pci_dev_get(dev);

Where is the pci_dev_put() that corresponds with this new
pci_dev_get()?

>  	return dev;
>  }
>  
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index e4ce1145aa3e..257ea46233a3 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -53,6 +53,7 @@ static void pci_destroy_dev(struct pci_dev *dev)
>  	pci_npem_remove(dev);
>  
>  	device_del(&dev->dev);
> +	pci_seq_tree_remove_dev(dev);
>  
>  	down_write(&pci_bus_sem);
>  	list_del(&dev->bus_list);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 573b4c4c2be6..aeb3d4cce06a 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -534,6 +534,8 @@ struct pci_dev {
>  
>  	/* These methods index pci_reset_fn_methods[] */
>  	u8 reset_methods[PCI_NUM_RESET_METHODS]; /* In priority order */
> +
> +	unsigned long long	proc_seq_idx;
>  };
>  
>  static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
> -- 
> 2.43.0
> 


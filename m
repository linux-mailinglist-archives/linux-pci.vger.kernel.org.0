Return-Path: <linux-pci+bounces-30441-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC79AE4C5B
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 20:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79A7E18999EC
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 18:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6669254873;
	Mon, 23 Jun 2025 18:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0+ObjRm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB833D3B8;
	Mon, 23 Jun 2025 18:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750702050; cv=none; b=J9RNvsCMtEZ+GUMPiq4mIXHqRhnDRNyw92rMQW5v3N0HPJq1aOwYJ7QAZ/6e/WFGOFuCyBHF/CiwRg0IaZc6AY5HkY7/9C/8E/LRmRuKq7EGG3VJCiS0vI/GqWsy9d2SAist+he2Lf4oyD8ozy1CNrhiw+BqqEhbbmrcPPGO8y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750702050; c=relaxed/simple;
	bh=YQN1c0w6pAHc4AUlqq8mKTbhGCshs2QcFFuFaq/b+nE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=thoSZy8EAMSF/UJnxxn3rNJPIx7BgKweR/TRFEn3MICrwcZj/YY8izENz2DxgpEHZs84glxX5nMxVk1ncjsa8A3Rk4t8Y9YT6Jz9/kfG2KDuEi0Tcwrbkw5Wg9JN1F2FWI7md9QEnp+nNGkZqZU6KDiVlghdrYShXZdhE8BQ5Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0+ObjRm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC982C4CEEA;
	Mon, 23 Jun 2025 18:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750702050;
	bh=YQN1c0w6pAHc4AUlqq8mKTbhGCshs2QcFFuFaq/b+nE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=O0+ObjRmUZ3jcM1at0R40MOrl3oFoP+ZTJBirWZjnd/57ajyaXE3CNGIyiKTVjzEm
	 Gv/M57LA3ROZ2Nfo6gXARwS8dKYPtZknEqLghiFOJwJciina9snQgAgoNjFxhiGrpj
	 GRWqXzDhDlw2GraXSchuiYN2ZcTiz2vlip+SjfzLrj0uwjbTEDv4zl2e+y8EIgujJ+
	 c/cd76n2Y00FD9X748apAnf52amFbBDZjKWQMGHn7igCr4FNoxA5hsJi66WE5EpTuO
	 4geD7E4h8GFm+TF9E11Bk8ejjWl7hX6tBpm00a4B4y3qhoWThYcUro7NaLqrccNdv7
	 caN9oQOieN7QQ==
Date: Mon, 23 Jun 2025 13:07:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH] PCI/PTM: Build debugfs code only if CONFIG_DEBUG_FS is
 enabled
Message-ID: <20250623180728.GA1435004@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250608033305.15214-1-manivannan.sadhasivam@linaro.org>

On Sun, Jun 08, 2025 at 09:03:05AM +0530, Manivannan Sadhasivam wrote:
> Otherwise, the following build error will happen for CONFIG_DEBUG_FS=n &&
> CONFIG_PCIE_PTM=y.
> 
>     drivers/pci/pcie/ptm.c:498:25: error: redefinition of 'pcie_ptm_create_debugfs'
>       498 | struct pci_ptm_debugfs *pcie_ptm_create_debugfs(struct device *dev, void *pdata,
>           |                         ^
>     ./include/linux/pci.h:1915:2: note: previous definition is here
>      1915 | *pcie_ptm_create_debugfs(struct device *dev, void *pdata,
>           |  ^
>     drivers/pci/pcie/ptm.c:546:6: error: redefinition of 'pcie_ptm_destroy_debugfs'
>       546 | void pcie_ptm_destroy_debugfs(struct pci_ptm_debugfs *ptm_debugfs)
>           |      ^
>     ./include/linux/pci.h:1918:1: note: previous definition is here
>      1918 | pcie_ptm_destroy_debugfs(struct pci_ptm_debugfs *ptm_debugfs) { }

Why are struct pci_ptm_debugfs, pcie_ptm_create_debugfs_file(), and
pcie_ptm_destroy_debugfs() in include/linux/pci.h?  They look like
things that should be in drivers/pci/pci.h.

> Fixes: 132833405e61 ("PCI: Add debugfs support for exposing PTM context")
> Reported-by: Eric Biggers <ebiggers@kernel.org>
> Closes: https://lore.kernel.org/linux-pci/20250607025506.GA16607@sol
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Applied to pci/for-linus for v6.16, thanks!

> ---
>  drivers/pci/pcie/ptm.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
> index ee5f615a9023..4bd73f038ffb 100644
> --- a/drivers/pci/pcie/ptm.c
> +++ b/drivers/pci/pcie/ptm.c
> @@ -254,6 +254,7 @@ bool pcie_ptm_enabled(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL(pcie_ptm_enabled);
>  
> +#if IS_ENABLED(CONFIG_DEBUG_FS)
>  static ssize_t context_update_write(struct file *file, const char __user *ubuf,
>  			     size_t count, loff_t *ppos)
>  {
> @@ -552,3 +553,4 @@ void pcie_ptm_destroy_debugfs(struct pci_ptm_debugfs *ptm_debugfs)
>  	debugfs_remove_recursive(ptm_debugfs->debugfs);
>  }
>  EXPORT_SYMBOL_GPL(pcie_ptm_destroy_debugfs);
> +#endif
> -- 
> 2.43.0
> 


Return-Path: <linux-pci+bounces-29180-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE6CAD1639
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 02:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 337143AA321
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 00:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AF71FC3;
	Mon,  9 Jun 2025 00:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uckZpCtB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CA04A21;
	Mon,  9 Jun 2025 00:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749427711; cv=none; b=NyS/C9uShkZCVa+xqEoJa/HT7LHVLAZXH2ewxlKdQxSMEbexmDgHrHRRRkH41Gx4hc6YViIOsu6ggp49AWY7goiG3cetE+ySUVjKz2q8bYRbxmUy43iSvqCJOoQk+sdprSLZd/lWi8W56gNbHxKxv4ClXeNmS9WnFa7Vyd9KmgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749427711; c=relaxed/simple;
	bh=qoyuDzJg4qS6425nWPfzdVfWiQ7VOYnsrToxyM4TgpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlcIf/3w9Dr0gIrGbGDkFY/esmX5qMaVfgyb0qBtiUJFM6tmUpuMgm9eCppwt2KvElMftuFTaCsDc3ZQ3wH5/DZ3X0/F4foy0mUqmQyz1IDyouRlnYHr5+Vf4qityMbEXJ6FqfXeVxF7Jqxrcpcon1WAxJH86X4HgCbZwkQR5mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uckZpCtB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3FDFC4CEEE;
	Mon,  9 Jun 2025 00:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749427710;
	bh=qoyuDzJg4qS6425nWPfzdVfWiQ7VOYnsrToxyM4TgpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uckZpCtBui73oG+DtytjH4q6jXppCHx8UVPRNYgdeLU8bOnuccqRRe1eaCmjug4QY
	 FV3roKvNohNDyT1avMYF1e/7fvmJZRW7Gw1MgU9cYFaGR9CIWOUlLYN9cAUx2dNpS4
	 +vie/uXZ9Fr209p6X98ppcO95P0URVXHROWEWRBAV9FKr3FbCzCZbeUcOob0rmRNlP
	 H1AmzlcHfbwiqp7eQZ9BHIsdEJ0G5/DVQAybRYT1A/YyDJEiz9lk31vzUh7jGgLFfd
	 gbtb/XgbaiqUKai5/FQyO7cBH7WBbb3PDWqrWOAyqS33pd7Rv6zvxSO4jscLgiqrGs
	 8b8A8Fpx9pweA==
Date: Sun, 8 Jun 2025 17:08:09 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/PTM: Build debugfs code only if CONFIG_DEBUG_FS is
 enabled
Message-ID: <20250609000809.GH1259@sol>
References: <20250608033305.15214-1-manivannan.sadhasivam@linaro.org>
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
>           |
> 
> Fixes: 132833405e61 ("PCI: Add debugfs support for exposing PTM context")
> Reported-by: Eric Biggers <ebiggers@kernel.org>
> Closes: https://lore.kernel.org/linux-pci/20250607025506.GA16607@sol
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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

Tested-by: Eric Biggers <ebiggers@kernel.org>

DEBUG_FS is a bool, not a tristate.  It would be more conventional to write
'#ifdef CONFIG_DEBUG_FS' instead of '#if IS_ENABLED(CONFIG_DEBUG_FS)'.

Also, the #if guards 300 lines of code.  Perhaps they belong in a separate .c
file?

- Eric


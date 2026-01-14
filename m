Return-Path: <linux-pci+bounces-44706-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E3BD1CD61
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 08:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C656306C3D5
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 07:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722AE3612D4;
	Wed, 14 Jan 2026 07:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEft+/Ux"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB8035F8B8;
	Wed, 14 Jan 2026 07:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768375745; cv=none; b=e75Gc4aIFdLPMCHEP1ccIAM/knEflz3BokIi0vmwwoWu8QPQdKX2eQ1nBxueeA6piK++9//ayl1FX5FX+XR8/whRPvBkfKf1aiynUz+pQnZ0as10F+/iTkyKnlxYDS1OYRbGQfstLUEqlWFtGPcv4BoNFAUuuCUBzv9EFWm8/gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768375745; c=relaxed/simple;
	bh=PipNcmVLnZeSRlFmhNc8IHdpn7qzJzaJ1NqlBHIsfYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L47wXCfiqA4eSIBlbRsZxSFWec87eHevXopCtQGJPwNMUJRihLnFiDjML+/IqTSmKUYRIPsbj0odbU5wK80XlQYAp1QyjsvXOwLhqedmpAwiUuLl38Au8tv4wmMhClizoSX6FaC2ubR/a/Jo7KF9PCdVX7+JBkatVT8vuLDvbpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEft+/Ux; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A8EC19424;
	Wed, 14 Jan 2026 07:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768375745;
	bh=PipNcmVLnZeSRlFmhNc8IHdpn7qzJzaJ1NqlBHIsfYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KEft+/UxHMwH1ZZZesAE9EeoGEenYFCGCqWZMIS+LRjwvo/gM0IinRjYGfL9WpbJb
	 qF9mjqr+Ljvg8cxv40UMF/G1H1xZRtoVSIK2pt9dAlu7pZwgOVtTJL+G3Nbc2RdPvd
	 G761CanSiBl99a+DmBVA8jW6/IoPJ7uBzrOEYVmBhfRqXzaQu1+FTKWsjyOwW4/s9v
	 B+7+1T0ynhUimPcjXJRsHxluyyDX1O5iN3E4K9AMD8PzpzYwsBluInGk7qSqIjD9Th
	 8tCvaznsq+aRDW0VQnTCM4QhjXRvtde2Hq+zvOdEKRxOtG1aDmh4E6+lBF+wzLpYfB
	 z1ATcypWby4Xw==
Date: Wed, 14 Jan 2026 12:58:56 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Aadityarangan Shridhar Iyengar <adiyenga@cisco.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/PTM: Fix memory leak in pcie_ptm_create_debugfs()
 error path
Message-ID: <pdp4xc4d5ee3e547mmdro5riui3mclduqdl7j6iclfbozo2a4c@7m3qdm6yrhuv>
References: <20260111163650.33168-1-adiyenga@cisco.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260111163650.33168-1-adiyenga@cisco.com>

On Sun, Jan 11, 2026 at 10:06:50PM +0530, Aadityarangan Shridhar Iyengar wrote:
> In pcie_ptm_create_debugfs(), if devm_kasprintf() fails after successfully
> allocating ptm_debugfs with kzalloc(), the function returns NULL without
> freeing the allocated memory, resulting in a memory leak.
> 
> Fix this by adding kfree(ptm_debugfs) before returning NULL in the
> devm_kasprintf() error path.
> 
> This leak is particularly problematic during memory pressure situations
> where devm_kasprintf() is more likely to fail, potentially compounding
> the memory exhaustion issue.
> 
> Fixes: 132833405e61 ("PCI: Add debugfs support for exposing PTM context")
> Signed-off-by: Aadityarangan Shridhar Iyengar <adiyenga@cisco.com>
> ---
>  drivers/pci/pcie/ptm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
> index ed0f9691e7d1..09c0167048a3 100644
> --- a/drivers/pci/pcie/ptm.c
> +++ b/drivers/pci/pcie/ptm.c
> @@ -542,8 +542,10 @@ struct pci_ptm_debugfs *pcie_ptm_create_debugfs(struct device *dev, void *pdata,
>  		return NULL;
>  
>  	dirname = devm_kasprintf(dev, GFP_KERNEL, "pcie_ptm_%s", dev_name(dev));
> -	if (!dirname)
> +	if (!dirname) {
> +		kfree(ptm_debugfs);
>  		return NULL;
> +	}

Thanks for spotting the leak. I also forgot to remove it in
pcie_ptm_destroy_debugfs(). Since this one got applied, Bjorn could you please
squash the below fix as well?

diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index ed0f9691e7d1..2c27bee0773d 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -574,6 +574,7 @@ void pcie_ptm_destroy_debugfs(struct pci_ptm_debugfs *ptm_debugfs)
 
        mutex_destroy(&ptm_debugfs->lock);
        debugfs_remove_recursive(ptm_debugfs->debugfs);
+       kfree(ptm_debugfs);
 }
 EXPORT_SYMBOL_GPL(pcie_ptm_destroy_debugfs);
 #endif

For this patch,

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

-- 
மணிவண்ணன் சதாசிவம்


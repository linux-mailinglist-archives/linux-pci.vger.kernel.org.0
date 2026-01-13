Return-Path: <linux-pci+bounces-44661-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAE0D1AEBF
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 19:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7B40300D40D
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 18:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F0028CF49;
	Tue, 13 Jan 2026 18:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+aXVn1T"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51493A41;
	Tue, 13 Jan 2026 18:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768330753; cv=none; b=lJwkguouGlO/HYTqCLmRss2btISuLPDTCTMobi1qifL71Y2g65p3Cd9JTZyzjoLuorM0mGQY3ETHMRdJojlh3qib6Womxmqc0zjVv4cAqlZ3fGAAteliAKgfYPbQCQKtMqZPH0IVwECfkmBh1zTIe6wmAXJAf/t/zlPUZz/MX4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768330753; c=relaxed/simple;
	bh=TUhpc7h4f1goFTnoVdec4wOHVp5qPUfDa63F4ef3kcE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pYIjauXb7IPWrCcYqOIV0mZMcjjSGBEwx5wk505xgKJqk18VQ2a6EmHYuSuz31xrXG6rf/W6DIpUJ5SsqUo7/Sicdy7a2RLnX5FP7sk/dAEtFmHgSA4M+sUuwMVNNO+B+9kZD7uU0lKxdcnebzd1/nMtmGUBs4QKbO0Pxechf30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+aXVn1T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4329BC116C6;
	Tue, 13 Jan 2026 18:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768330752;
	bh=TUhpc7h4f1goFTnoVdec4wOHVp5qPUfDa63F4ef3kcE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=V+aXVn1TO2lz/SmgvR2rh+B62MQl061q+buDB2Ns6WYzbZpKk+FXCf0GShuIBAXfP
	 pjaLNnuoPSbe1NWTjWk02W9rkAlaBvFCvFsbBi524OVWSy7QaqguBr7LeM+B3NnOi3
	 ygR9KEKIg0ljOZZ1tq9Znz+5gh9ZA9H6lrHLvt8jWnJZmpWZSIETmZUuV6fDEQn2AW
	 pkAkfJ29pPgAnUJs42GpBMhXZQKwwWe0LpsUBpR12jEL0XZOXRmxFS/QkVu6birkS+
	 FCmkUgyiv/vMciPhKGSNNzTEko5z+VyevwYkUTWOSIOhQRuRfNJCnfn2w3961nFJLk
	 SNtr2TCChUPJw==
Date: Tue, 13 Jan 2026 12:59:11 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Aadityarangan Shridhar Iyengar <adiyenga@cisco.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH] PCI/PTM: Fix memory leak in pcie_ptm_create_debugfs()
 error path
Message-ID: <20260113185911.GA775194@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260111163650.33168-1-adiyenga@cisco.com>

[+cc Mani, author of 132833405e61]

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

Applied to pci/ptm for v6.20, thanks!

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
>  
>  	ptm_debugfs->debugfs = debugfs_create_dir(dirname, NULL);
>  	ptm_debugfs->pdata = pdata;
> -- 
> 2.35.6
> 


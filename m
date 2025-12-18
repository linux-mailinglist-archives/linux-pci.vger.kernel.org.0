Return-Path: <linux-pci+bounces-43301-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DB4CCBF1A
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 14:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCB823010A99
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 13:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E95343210;
	Thu, 18 Dec 2025 13:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkKvgiPo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A2F343208;
	Thu, 18 Dec 2025 13:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766063674; cv=none; b=Ku4ZUF/t2FTgyA73Dxm2zYO7xdJGzcdBgnPx3xgJOLceZxguehlENG2kOlYjYgNOM8pkTqrupSa/tV5/qkZ9LC3Ame18MGb2Khtf+QMKzc6Wn02tJwt++EQFGknePooN5wluWTNp8WdyldEFMIp5j1Zom1X3d8lAkq8XRRd/Hok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766063674; c=relaxed/simple;
	bh=IjUpMsiPC2X0Nu3tv0tNZRe1sV4zwg2lN0zest+uSWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqAxv1oYqvBnMJ9zt9GSxkP05nysGE8qYJBlaTu/pgvgXRLScdchQJ5Nx17ta8KMpWmHGdJtFt9LcrTLNlGn2buVrB7guc7I2nmHOtR8PW+PQ110plWTrQrpMU3tBOR79Jpc0INxHp+CFTq0stKNmKT1QbEpkXZgnE3g7YAfEls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkKvgiPo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C95C4CEFB;
	Thu, 18 Dec 2025 13:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766063673;
	bh=IjUpMsiPC2X0Nu3tv0tNZRe1sV4zwg2lN0zest+uSWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JkKvgiPoTvb3rcoWcXYnl/KK1aWTARrbyCVhX98N2Z5yxvwnY7chEuGmcbzOSFVtF
	 XC8OWU1vidNrYWGJlJPoTnsQduX86T16+h6kBhvVzT69IA5E+Ecrn3ERge2JV2o0gY
	 Ji7D2buPz4nE4PEJro+yw6diXv10PpOgOq9hQRJ2Pk9cSLBz4f+Z+cycZYXqyh3yWX
	 8NhOvENiQzRYJjlCCwchgGLit3OIGAzFwJ2uNHpbtbYvcoSqzYrhPpVoKDQsKRK+4f
	 0nrbp4frSgdkxZ/Te9FNH+UNia+5xUY77MNDvIu9xHCtNYAvT8YSGcoRXPnxzc+Aa8
	 H7vZPBf/YHWAA==
Date: Thu, 18 Dec 2025 18:44:27 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Haotian Zhang <vulab@iscas.ac.cn>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
	bhelgaas@google.com, michal.simek@amd.com, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: xilinx: Fix INTx IRQ domain leak when MSI
 allocation fails
Message-ID: <hxxoboh4z7wrstodn3g263zj334sybearuj53myhmzmnocywij@w3rkiu7xiaxi>
References: <20251119033301.518-1-vulab@iscas.ac.cn>
 <20251218102314.1474-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251218102314.1474-1-vulab@iscas.ac.cn>

On Thu, Dec 18, 2025 at 06:23:14PM +0800, Haotian Zhang wrote:
> In xilinx_pcie_init_irq_domain(), if xilinx_allocate_msi_domains()
> fails after pcie->leg_domain has been successfully created via
> irq_domain_create_linear(), the function returns directly without
> cleaning up the allocated IRQ domain, resulting in a resource leak.
> 
> Add irq_domain_remove() call in the error path to properly release the
> IRQ domain before returning the error.
> 
> Fixes: 313b64c3ae52 ("PCI: xilinx: Convert to MSI domains")
> Suggested-by: Manivannan Sadhasivam <mani@kernel.org>

Sorry, I didn't suggest this change ;)

> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
> ---
> Changes in v2:
>   - Correct the Fixes tag to point to the commit that introduced the
>     legacy IRQ domain leak on MSI allocation failure.
> ---
>  drivers/pci/controller/pcie-xilinx.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/pcie-xilinx.c
> index 937ea6ae1ac4..e8cf320f3764 100644
> --- a/drivers/pci/controller/pcie-xilinx.c
> +++ b/drivers/pci/controller/pcie-xilinx.c
> @@ -480,8 +480,10 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie *pcie)
>  		phys_addr_t pa = ALIGN_DOWN(virt_to_phys(pcie), SZ_4K);
>  
>  		ret = xilinx_allocate_msi_domains(pcie);
> -		if (ret)
> +		if (ret) {
> +			irq_domain_remove(pcie->leg_domain);
>  			return ret;
> +		}

Looks like this domain is not removed in the further failure path. You need to
rename xilinx_free_msi_domains() to xilinx_free_irq_domains() and remove this
domain in that function as well.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


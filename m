Return-Path: <linux-pci+bounces-43262-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0CBCCAF7A
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 09:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A11783018EEF
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 08:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827E4330668;
	Thu, 18 Dec 2025 08:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYTsZB76"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A00D330662;
	Thu, 18 Dec 2025 08:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766045529; cv=none; b=QPGPsDMJPoD+ocVAQK+dQBkYVFf+xuy9XV70o7o3zor+UHTAjwWljxm/SelBPZsjJBQ6dsyRv99TTt9Gt30FvgfLmpqtCyR5sSZzzSh0rg93mdhKO5LrFStvBmDJzdE1c0MmPZedHP2cX9wVlMpvbeih0bzTSVQiZDJfq2A2cpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766045529; c=relaxed/simple;
	bh=IjrB11SdaPLV5NaGWPvfB9w9VeD/+npcJivOYx8PYM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7S0rQ5bt/tYThmGFuBEHkz2HksB0ysTPwMg+1RIhU71ncI6uqeiRsrmS7/e7CP//Ra95bga92zZIM/k4yoLoWy/t4UdItEgmQNTV40l/fTLZ046x6oka7KdURULnA1d8mAFbv7x6yYS7xeTSvi1b+JUtLzsEGBvLV2SVx/EFcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYTsZB76; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC494C4CEFB;
	Thu, 18 Dec 2025 08:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766045528;
	bh=IjrB11SdaPLV5NaGWPvfB9w9VeD/+npcJivOYx8PYM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nYTsZB76hS3lGlVOK1YECoiOFzqD9h2VsGi4szEhcspTTExuwq+TccXresnRbaS1w
	 qgci9nrWl25AsbNpAkLFxC0xWPau1K6y+UAH53+uWjY0TZSM+u1ys5e3t6s84yF5AI
	 58FbrYarZtCJsUsWI4cBjfWAf3kCYyK6pdTB7O0AV+9cuYKBl7oUhcqR+uAa6wqHMu
	 yL5zuNsBB03PM8XzJXM3dTOVZbrdEI6ncHUpgVW0Kc5mSL8yeMlluKbFgaMS0Snqja
	 zXLL4d8aKSzNerNsHvi6dQC/x+ckI6RsqFoHt/cqHEb3nWadT8dUBHYG6zLcbkctX4
	 w5R6mjGu/A1hg==
Date: Thu, 18 Dec 2025 13:41:55 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Haotian Zhang <vulab@iscas.ac.cn>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
	bhelgaas@google.com, michal.simek@amd.com, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: xilinx: Fix INTx IRQ domain leak when MSI
 allocation fails
Message-ID: <oelexrnhxsvscyxsrsl2gh25kvfqclxnrah6x27anjj3knuqg7@yexgfqzba6fr>
References: <20251119033301.518-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251119033301.518-1-vulab@iscas.ac.cn>

On Wed, Nov 19, 2025 at 11:33:01AM +0800, Haotian Zhang wrote:
> In xilinx_pcie_init_irq_domain(), if xilinx_allocate_msi_domains()
> fails after pcie->leg_domain has been successfully created via
> irq_domain_create_linear(), the function returns directly without
> cleaning up the allocated IRQ domain, resulting in a resource leak.
> 
> Add irq_domain_remove() call in the error path to properly release the
> IRQ domain before returning the error.
> 
> Fixes: 699ca3016268 ("PCI: xilinx: Check for __get_free_pages() failure")

Is this the correct tag?

- Mani

> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
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
>  
>  		pcie_write(pcie, upper_32_bits(pa), XILINX_PCIE_REG_MSIBASE1);
>  		pcie_write(pcie, lower_32_bits(pa), XILINX_PCIE_REG_MSIBASE2);
> -- 
> 2.50.1.windows.1
> 

-- 
மணிவண்ணன் சதாசிவம்


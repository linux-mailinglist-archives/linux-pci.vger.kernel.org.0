Return-Path: <linux-pci+bounces-36534-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2245B8AEF6
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 20:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 680FF5A6A57
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 18:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55E1261B64;
	Fri, 19 Sep 2025 18:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IdrwFbGN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B120211A28;
	Fri, 19 Sep 2025 18:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758306949; cv=none; b=AjldrDDLfOFmAjVktW0l34GogjKhP7NhlB94TMGe/Lvy+Drs4Z4l0KvRLw8mUU9kLDqsUbR+RxMC77368vjQqN3LCz1hF+s/naFgXCgfQbwe3SbJ9FwjA1CFuKCFdtcK3qX3PSmlxyNLSdpQnublKAHPdUub1GEfTp6ga05umw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758306949; c=relaxed/simple;
	bh=oo7MnNncuxbbEuJjYzS+KOutOdZkuh1LO0HXaCxkr0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJqB9USV83xWjHCm8aXPDoRfDLzXAzRdTGKQ4tBDjwkCiVFevMCpB1z70ee/8mkTDwC69jZ1juJ2lAStI2Qhh8sAUmbKL1fKL4UfcOHl9cC8ce+rx3sIzIdLop+Fyr4n7VdxsY4nSqoNmqiil5xbDUBm4FJ1udAhOi+oTHASO4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IdrwFbGN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8416C4CEF7;
	Fri, 19 Sep 2025 18:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758306949;
	bh=oo7MnNncuxbbEuJjYzS+KOutOdZkuh1LO0HXaCxkr0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IdrwFbGNBg+mcvrizzNAt938gwJnXeswj9demaxuYxuALGgDanebsnojheH/LeTzJ
	 9zpYxwBE4U4OObrIalWu5Azd0xgXyIe7ef5TUkP9SXKVp+Dm6iabs9fPwjGAL54A6l
	 zvPlmsCPiHxpeVc75UBZzAaSRhSe480HrH60JEfrG5qPZc0uCIvKKTx+47NF/0++0D
	 akeE47J1lxg4PC9L9ZJTxuUfImYiQl4JK4sh5BC2NQR8p08XW1frHb+DOOxi0arqtQ
	 GP6UCIKLk4gfk5efeBDwblvyTTWLJ/CqFpZCoKhJo4rMMkmI4xO5H5tafJQwa55POk
	 t79asfELyLhKg==
Date: Sat, 20 Sep 2025 00:05:38 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
	bhelgaas@google.com, jingoohan1@gmail.com, christian.bruel@foss.st.com, 
	qiang.yu@oss.qualcomm.com, mayank.rana@oss.qualcomm.com, thippeswamy.havalige@amd.com, 
	shradha.t@samsung.com, quic_schintav@quicinc.com, inochiama@gmail.com, 
	cassel@kernel.org, kishon@kernel.org, sergio.paracuellos@gmail.com, 
	18255117159@163.com, rongqianfeng@vivo.com, jirislaby@kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, srk@ti.com
Subject: Re: [PATCH v2 06/10] PCI: keystone: Add ks_pcie_free_intx_irq()
 helper for cleanup
Message-ID: <7sbyvk6vyrbyox5ghvhokrv67r2el4s4f6k42aygmfo3rltj27@6v5pjxbhdl5w>
References: <20250912122356.3326888-1-s-vadapalli@ti.com>
 <20250912122356.3326888-7-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250912122356.3326888-7-s-vadapalli@ti.com>

On Fri, Sep 12, 2025 at 05:46:17PM +0530, Siddharth Vadapalli wrote:
> Introduce the helper function ks_pcie_free_intx_irq() which will undo the
> configuration performed by the ks_pcie_config_intx_irq() function. This
> will be required for implementing a future helper function to undo the
> configuration performed by the ks_pcie_host_init() function.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Please squash all patches introducing new helpers.

- Mani

> ---
> 
> v1: https://lore.kernel.org/r/20250903124505.365913-7-s-vadapalli@ti.com/
> No changes since v1.
> 
>  drivers/pci/controller/dwc/pci-keystone.c | 29 +++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index 81c3686688c0..074566fb1d74 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -745,6 +745,35 @@ static int ks_pcie_config_msi_irq(struct keystone_pcie *ks_pcie)
>  	return ret;
>  }
>  
> +static void ks_pcie_free_intx_irq(struct keystone_pcie *ks_pcie)
> +{
> +	struct device_node *np = ks_pcie->np;
> +	struct device_node *intc_np;
> +	int irq_count, i;
> +	u32 val;
> +
> +	/* Nothing to do if INTx Interrupt Controller does not exist */
> +	intc_np = of_get_child_by_name(np, "legacy-interrupt-controller");
> +	if (!intc_np)
> +		return;
> +
> +	/* irq_count should be non-zero. Else, ks_pcie_host_init would have failed. */
> +	irq_count = of_irq_count(intc_np);
> +
> +	/* Disable all legacy interrupts */
> +	for (i = 0; i < PCI_NUM_INTX; i++) {
> +		val = ks_pcie_app_readl(ks_pcie, IRQ_ENABLE_SET(i));
> +		val &= ~INTx_EN;
> +		ks_pcie_app_writel(ks_pcie, IRQ_ENABLE_SET(i), val);
> +	}
> +
> +	irq_domain_remove(ks_pcie->intx_irq_domain);
> +	for (i = 0; i < irq_count; i++)
> +		irq_set_chained_handler(ks_pcie->intx_host_irqs[i], NULL);
> +
> +	of_node_put(intc_np);
> +}
> +
>  static int ks_pcie_config_intx_irq(struct keystone_pcie *ks_pcie)
>  {
>  	struct device *dev = ks_pcie->pci->dev;
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்


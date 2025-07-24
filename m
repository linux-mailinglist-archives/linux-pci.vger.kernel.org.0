Return-Path: <linux-pci+bounces-32905-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C4AB1145A
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 01:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDDC71C22C5C
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 23:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6000B23C516;
	Thu, 24 Jul 2025 23:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSLVJCpj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3828223C4F8;
	Thu, 24 Jul 2025 23:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753398643; cv=none; b=Nl0RQvpBvpkntqRPYlWfy72wUWBE2VJ2RS41IQ6pVNzS7J943Ub/5/5obnf9YCGmDy+UPKn+ru1PP5L5Ox9I8w0Gie8YBDqa5jzKHEisurQNKamF3eFc32E7s93EWTu/wQPUycTdPxMWA64pEwF24uE4VfKJzKCMFHiOeei4u0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753398643; c=relaxed/simple;
	bh=ctpeYJqI/YS0Fz29wSZX7bb68pB9rc2aEqPRsFb/1KE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lMvis+JyZPDrGyvzUzRg5JrOsp6enJ3HJUdmxG2+lZlpT1zXThKyhuf57nPzf5zJXNLpAtM0uzkJ+6ra2awd5pUEekac6PH+QDkuy3hAFmAStXCvL2NNdH6mNsLeUxpFoIUrQrWEb05YVNMmAxeQRsMdQH0LlDXGEdOhdRMynmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSLVJCpj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991B9C4CEED;
	Thu, 24 Jul 2025 23:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753398642;
	bh=ctpeYJqI/YS0Fz29wSZX7bb68pB9rc2aEqPRsFb/1KE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=lSLVJCpjYwUU6EPqgYYzdE0EdZ8oDFYV/0lJmwugU9tGIjO60nUjs09D8lBXA2yD2
	 Fg+poR+eB1EfvBNYE2i3RVYyZPST5UK5sfIj0LypqPXmp1bLQmkPURstpTK+B6NMSp
	 /Sfgh0pY4nlMuB4/0ij4qBxIT6xYfSu0rWD5a5iWx9teYnuxBtAVIOpRb4pEi2dvr6
	 /+sNmOe5f5CmDySNo8eMIeR8BaeiOIXW+stkdtE+1inF9pSsOOSVuhZ3wj5IbR5BCb
	 L9VNWckESPamfiqs1XMgM9OgC7CiGY92IF4J3JD1+WqxMkRUfrloP9aTViDrQ2cT2n
	 UDut2GywlmQhg==
Date: Thu, 24 Jul 2025 18:10:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: bhelgaas@google.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
	Joyce Ooi <joyce.ooi@intel.com>, Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Michal Simek <michal.simek@amd.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>,
	Nam Cao <namcao@linutronix.de>
Subject: Re: [PATCH] PCI: controller: use dev_fwnode()
Message-ID: <20250724231041.GA3079592@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250723065907.1841758-1-jirislaby@kernel.org>

[+cc Arnd, Nam]

On Wed, Jul 23, 2025 at 08:59:07AM +0200, Jiri Slaby (SUSE) wrote:
> All irq_domain functions now accept fwnode instead of of_node. But many
> PCI controllers still extract dev to of_node and then of_node to fwnode.
> 
> Instead, clean this up and simply use the dev_fwnode() helper to extract
> fwnode directly from dev. Internally, it still does dev => of_node =>
> fwnode steps, but it's now hidden from the users.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Link: https://lore.kernel.org/all/4ee9c7c0-4a3f-4afa-ae5a-7fd8a750c92b@kernel.org/
> Link: https://lore.kernel.org/all/4bc0e1ca-a523-424a-8759-59e353317fba@kernel.org/

Thanks, Jiri, I applied this on pci/controller/msi-parent for v6.17;
it's at
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=controller/msi-parent

The dev_fwnode() conversions touched the same places as Nam's changes
to use msi_create_parent_irq_domain().  The previous dev_fwnode()
conversions were *before* Nam's changes and these are *after*, and it
all ended up looking more complicated than I wanted, so I squashed all
the dev_fwnode() conversions together in
https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/commit/?id=a103d2dede56
("PCI: controller: Use dev_fwnode() instead of of_fwnode_handle()")
and then added Nam's msi_create_parent_irq_domain() patches on top.

So a103d2dede56 ("PCI: controller: Use dev_fwnode() instead of
of_fwnode_handle()") ends up *looking* different from the patch below,
but I think having them all together makes it more obvious that
they're all making the same conversion, and I think the end result is
identical.

Bjorn

> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>
> Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Cc: Joyce Ooi <joyce.ooi@intel.com>
> Cc: Ryder Lee <ryder.lee@mediatek.com>
> Cc: Jianjun Wang <jianjun.wang@mediatek.com>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Daire McNamara <daire.mcnamara@microchip.com>
> ---
> Cc: linux-pci@vger.kernel.org
> Cc: linux-mediatek@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c    | 3 +--
>  drivers/pci/controller/mobiveil/pcie-mobiveil-host.c | 3 +--
>  drivers/pci/controller/pcie-altera-msi.c             | 3 +--
>  drivers/pci/controller/pcie-mediatek.c               | 4 +---
>  drivers/pci/controller/pcie-xilinx-dma-pl.c          | 3 +--
>  drivers/pci/controller/pcie-xilinx-nwl.c             | 3 +--
>  drivers/pci/controller/plda/pcie-plda-host.c         | 3 +--
>  7 files changed, 7 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 4af7da14b350..952f8594b501 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -214,9 +214,8 @@ static const struct irq_domain_ops dw_pcie_msi_domain_ops = {
>  int dw_pcie_allocate_domains(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> -	struct fwnode_handle *fwnode = of_fwnode_handle(pci->dev->of_node);
>  	struct irq_domain_info info = {
> -		.fwnode		= fwnode,
> +		.fwnode		= dev_fwnode(pci->dev),
>  		.ops		= &dw_pcie_msi_domain_ops,
>  		.size		= pp->num_vectors,
>  		.host_data	= pp,
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> index d17e887b6b61..dbc72c73fd0a 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> @@ -439,13 +439,12 @@ static const struct irq_domain_ops msi_domain_ops = {
>  static int mobiveil_allocate_msi_domains(struct mobiveil_pcie *pcie)
>  {
>  	struct device *dev = &pcie->pdev->dev;
> -	struct fwnode_handle *fwnode = of_fwnode_handle(dev->of_node);
>  	struct mobiveil_msi *msi = &pcie->rp.msi;
>  
>  	mutex_init(&msi->lock);
>  
>  	struct irq_domain_info info = {
> -		.fwnode		= fwnode,
> +		.fwnode		= dev_fwnode(dev),
>  		.ops		= &msi_domain_ops,
>  		.host_data	= pcie,
>  		.size		= msi->num_of_vectors,
> diff --git a/drivers/pci/controller/pcie-altera-msi.c b/drivers/pci/controller/pcie-altera-msi.c
> index 2e48acd632c5..ea2ca2e70f20 100644
> --- a/drivers/pci/controller/pcie-altera-msi.c
> +++ b/drivers/pci/controller/pcie-altera-msi.c
> @@ -166,9 +166,8 @@ static const struct irq_domain_ops msi_domain_ops = {
>  
>  static int altera_allocate_domains(struct altera_msi *msi)
>  {
> -	struct fwnode_handle *fwnode = of_fwnode_handle(msi->pdev->dev.of_node);
>  	struct irq_domain_info info = {
> -		.fwnode		= fwnode,
> +		.fwnode		= dev_fwnode(&msi->pdev->dev),
>  		.ops		= &msi_domain_ops,
>  		.host_data	= msi,
>  		.size		= msi->num_of_vectors,
> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index 3ac5d14dd543..24cc30a2ab6c 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -487,12 +487,10 @@ static const struct msi_parent_ops mtk_msi_parent_ops = {
>  
>  static int mtk_pcie_allocate_msi_domains(struct mtk_pcie_port *port)
>  {
> -	struct fwnode_handle *fwnode = of_fwnode_handle(port->pcie->dev->of_node);
> -
>  	mutex_init(&port->lock);
>  
>  	struct irq_domain_info info = {
> -		.fwnode		= fwnode,
> +		.fwnode		= dev_fwnode(port->pcie->dev),
>  		.ops		= &msi_domain_ops,
>  		.host_data	= port,
>  		.size		= MTK_MSI_IRQS_NUM,
> diff --git a/drivers/pci/controller/pcie-xilinx-dma-pl.c b/drivers/pci/controller/pcie-xilinx-dma-pl.c
> index fbc379fd118b..b037c8f315e4 100644
> --- a/drivers/pci/controller/pcie-xilinx-dma-pl.c
> +++ b/drivers/pci/controller/pcie-xilinx-dma-pl.c
> @@ -465,9 +465,8 @@ static int xilinx_pl_dma_pcie_init_msi_irq_domain(struct pl_dma_pcie *port)
>  	struct device *dev = port->dev;
>  	struct xilinx_msi *msi = &port->msi;
>  	int size = BITS_TO_LONGS(XILINX_NUM_MSI_IRQS) * sizeof(long);
> -	struct fwnode_handle *fwnode = of_fwnode_handle(port->dev->of_node);
>  	struct irq_domain_info info = {
> -		.fwnode		= fwnode,
> +		.fwnode		= dev_fwnode(port->dev),
>  		.ops		= &dev_msi_domain_ops,
>  		.host_data	= port,
>  		.size		= XILINX_NUM_MSI_IRQS,
> diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
> index de76c836915f..05b8c205493c 100644
> --- a/drivers/pci/controller/pcie-xilinx-nwl.c
> +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
> @@ -498,10 +498,9 @@ static int nwl_pcie_init_msi_irq_domain(struct nwl_pcie *pcie)
>  {
>  #ifdef CONFIG_PCI_MSI
>  	struct device *dev = pcie->dev;
> -	struct fwnode_handle *fwnode = of_fwnode_handle(dev->of_node);
>  	struct nwl_msi *msi = &pcie->msi;
>  	struct irq_domain_info info = {
> -		.fwnode		= fwnode,
> +		.fwnode		= dev_fwnode(dev),
>  		.ops		= &dev_msi_domain_ops,
>  		.host_data	= pcie,
>  		.size		= INT_PCI_MSI_NR,
> diff --git a/drivers/pci/controller/plda/pcie-plda-host.c b/drivers/pci/controller/plda/pcie-plda-host.c
> index 92866840875e..8e2db2e5b64b 100644
> --- a/drivers/pci/controller/plda/pcie-plda-host.c
> +++ b/drivers/pci/controller/plda/pcie-plda-host.c
> @@ -153,13 +153,12 @@ static const struct msi_parent_ops plda_msi_parent_ops = {
>  static int plda_allocate_msi_domains(struct plda_pcie_rp *port)
>  {
>  	struct device *dev = port->dev;
> -	struct fwnode_handle *fwnode = of_fwnode_handle(dev->of_node);
>  	struct plda_msi *msi = &port->msi;
>  
>  	mutex_init(&port->msi.lock);
>  
>  	struct irq_domain_info info = {
> -		.fwnode		= fwnode,
> +		.fwnode		= dev_fwnode(dev),
>  		.ops		= &msi_domain_ops,
>  		.host_data	= port,
>  		.size		= msi->num_vectors,
> -- 
> 2.50.1
> 


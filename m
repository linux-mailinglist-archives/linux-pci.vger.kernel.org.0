Return-Path: <linux-pci+bounces-25424-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 211ECA7E94C
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 20:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE8123B779A
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 18:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC36219A9D;
	Mon,  7 Apr 2025 18:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RttCvuN6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B227D21146F;
	Mon,  7 Apr 2025 18:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049023; cv=none; b=cJ2jAULFqKPAAPIaghHFVIxZRIvr4PFldjXeHj9IF3+YOMUe7zRjxMpdKWV6+i+jMggxmYTWX9fkcuCyRojq2+/Ypt2Vachut04ICScQQO/ycLLm0dLAN3zn25QWpou7cZdswnjDZNBbZB4dvP79yGdAvBl6ljsugTZf6gatH5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049023; c=relaxed/simple;
	bh=YHIy5Y1koKmkECfrSnEDyoWYCat4HjXEskfIpv3fwuc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=CPU728wXrKkt3/MO+3gzG5ulVPef7xtq0bYulk/Q9fLscX+pjdzq5PODYHSUCflD/aFERrUtnGMfgUMXlwM6f1QBXGwOfAoVdZ7P8HXYxJXkBr1mBt5PGSlIylCwvYXt9RRqnNSUA1wAdatArICk9kKyFI6+0FJjsNYguTVlMms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RttCvuN6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0CDAC4CEDD;
	Mon,  7 Apr 2025 18:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049023;
	bh=YHIy5Y1koKmkECfrSnEDyoWYCat4HjXEskfIpv3fwuc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=RttCvuN6FYjIuyMSpBvHJlb4NGyWZ/3GBZXejCnlcffyyRb6qBm7entEeT5evaQPe
	 LF0Y0672+3ZAnwDw6WTDneKn3v8souc6WjSgylaiDpxYunKnwcZj2aCfx1rd5invPL
	 tBhB17TFw4gFjshVKtaDfsnXWzrIe8GsvSp0EKT1tgW4qdDsoptaI4oabflYTQKqah
	 0S0QDF0bxdh3qiwItJEEY2RlOOnJ8Yd1d4s+7BKH0GEopNDPQU+7M4phafo7qggkpP
	 qmvHquthg0WYzrN/WkyrxyW/lHo+3k6cCJK2Ffia4l+TYXQIuehc971AnL7F8FZX1I
	 x1p5l2w16/ZBw==
Date: Mon, 7 Apr 2025 13:03:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: tglx@linutronix.de, maz@kernel.org, linux-kernel@vger.kernel.org,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
	Toan Le <toan@os.amperecomputing.com>,
	Joyce Ooi <joyce.ooi@intel.com>, Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Michal Simek <michal.simek@amd.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 07/57] irqdomain: pci: Switch to of_fwnode_handle()
Message-ID: <20250407180341.GA189772@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250319092951.37667-8-jirislaby@kernel.org>

On Wed, Mar 19, 2025 at 10:29:00AM +0100, Jiri Slaby (SUSE) wrote:
> of_node_to_fwnode() is irqdomain's reimplementation of the "officially"
> defined of_fwnode_handle(). The former is in the process of being
> removed, so use the latter instead.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: "Krzysztof Wilczyński" <kw@linux.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>
> Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Cc: Toan Le <toan@os.amperecomputing.com>
> Cc: Joyce Ooi <joyce.ooi@intel.com>
> Cc: Jim Quinlan <jim2101024@gmail.com>
> Cc: Nicolas Saenz Julienne <nsaenz@kernel.org>
> Cc: Florian Fainelli <florian.fainelli@broadcom.com>
> Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: Ryder Lee <ryder.lee@mediatek.com>
> Cc: Jianjun Wang <jianjun.wang@mediatek.com>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Daire McNamara <daire.mcnamara@microchip.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-rpi-kernel@lists.infradead.org
> Cc: linux-mediatek@lists.infradead.org

Applied to pci/irq for v6.16, thanks!

> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c    | 2 +-
>  drivers/pci/controller/mobiveil/pcie-mobiveil-host.c | 2 +-
>  drivers/pci/controller/pci-xgene-msi.c               | 2 +-
>  drivers/pci/controller/pcie-altera-msi.c             | 2 +-
>  drivers/pci/controller/pcie-brcmstb.c                | 2 +-
>  drivers/pci/controller/pcie-iproc-msi.c              | 2 +-
>  drivers/pci/controller/pcie-mediatek.c               | 2 +-
>  drivers/pci/controller/pcie-xilinx-dma-pl.c          | 2 +-
>  drivers/pci/controller/pcie-xilinx-nwl.c             | 2 +-
>  drivers/pci/controller/plda/pcie-plda-host.c         | 2 +-
>  10 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index ecc33f6789e3..d1cd48efad43 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -227,7 +227,7 @@ static const struct irq_domain_ops dw_pcie_msi_domain_ops = {
>  int dw_pcie_allocate_domains(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> -	struct fwnode_handle *fwnode = of_node_to_fwnode(pci->dev->of_node);
> +	struct fwnode_handle *fwnode = of_fwnode_handle(pci->dev->of_node);
>  
>  	pp->irq_domain = irq_domain_create_linear(fwnode, pp->num_vectors,
>  					       &dw_pcie_msi_domain_ops, pp);
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> index 0e088e74155d..6628eed9d26e 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> @@ -435,7 +435,7 @@ static const struct irq_domain_ops msi_domain_ops = {
>  static int mobiveil_allocate_msi_domains(struct mobiveil_pcie *pcie)
>  {
>  	struct device *dev = &pcie->pdev->dev;
> -	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
> +	struct fwnode_handle *fwnode = of_fwnode_handle(dev->of_node);
>  	struct mobiveil_msi *msi = &pcie->rp.msi;
>  
>  	mutex_init(&msi->lock);
> diff --git a/drivers/pci/controller/pci-xgene-msi.c b/drivers/pci/controller/pci-xgene-msi.c
> index 7bce327897c9..69a9c0a87639 100644
> --- a/drivers/pci/controller/pci-xgene-msi.c
> +++ b/drivers/pci/controller/pci-xgene-msi.c
> @@ -247,7 +247,7 @@ static int xgene_allocate_domains(struct xgene_msi *msi)
>  	if (!msi->inner_domain)
>  		return -ENOMEM;
>  
> -	msi->msi_domain = pci_msi_create_irq_domain(of_node_to_fwnode(msi->node),
> +	msi->msi_domain = pci_msi_create_irq_domain(of_fwnode_handle(msi->node),
>  						    &xgene_msi_domain_info,
>  						    msi->inner_domain);
>  
> diff --git a/drivers/pci/controller/pcie-altera-msi.c b/drivers/pci/controller/pcie-altera-msi.c
> index e1cee3c0575f..5fb3a2e0017e 100644
> --- a/drivers/pci/controller/pcie-altera-msi.c
> +++ b/drivers/pci/controller/pcie-altera-msi.c
> @@ -164,7 +164,7 @@ static const struct irq_domain_ops msi_domain_ops = {
>  
>  static int altera_allocate_domains(struct altera_msi *msi)
>  {
> -	struct fwnode_handle *fwnode = of_node_to_fwnode(msi->pdev->dev.of_node);
> +	struct fwnode_handle *fwnode = of_fwnode_handle(msi->pdev->dev.of_node);
>  
>  	msi->inner_domain = irq_domain_add_linear(NULL, msi->num_of_vectors,
>  					     &msi_domain_ops, msi);
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 8b2b099e81eb..1f356fca07a2 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -581,7 +581,7 @@ static const struct irq_domain_ops msi_domain_ops = {
>  
>  static int brcm_allocate_domains(struct brcm_msi *msi)
>  {
> -	struct fwnode_handle *fwnode = of_node_to_fwnode(msi->np);
> +	struct fwnode_handle *fwnode = of_fwnode_handle(msi->np);
>  	struct device *dev = msi->dev;
>  
>  	msi->inner_domain = irq_domain_add_linear(NULL, msi->nr, &msi_domain_ops, msi);
> diff --git a/drivers/pci/controller/pcie-iproc-msi.c b/drivers/pci/controller/pcie-iproc-msi.c
> index 649fcb449f34..804b3a5787c5 100644
> --- a/drivers/pci/controller/pcie-iproc-msi.c
> +++ b/drivers/pci/controller/pcie-iproc-msi.c
> @@ -451,7 +451,7 @@ static int iproc_msi_alloc_domains(struct device_node *node,
>  	if (!msi->inner_domain)
>  		return -ENOMEM;
>  
> -	msi->msi_domain = pci_msi_create_irq_domain(of_node_to_fwnode(node),
> +	msi->msi_domain = pci_msi_create_irq_domain(of_fwnode_handle(node),
>  						    &iproc_msi_domain_info,
>  						    msi->inner_domain);
>  	if (!msi->msi_domain) {
> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index 811a8b4acd50..efcc4a7c17be 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -485,7 +485,7 @@ static struct msi_domain_info mtk_msi_domain_info = {
>  
>  static int mtk_pcie_allocate_msi_domains(struct mtk_pcie_port *port)
>  {
> -	struct fwnode_handle *fwnode = of_node_to_fwnode(port->pcie->dev->of_node);
> +	struct fwnode_handle *fwnode = of_fwnode_handle(port->pcie->dev->of_node);
>  
>  	mutex_init(&port->lock);
>  
> diff --git a/drivers/pci/controller/pcie-xilinx-dma-pl.c b/drivers/pci/controller/pcie-xilinx-dma-pl.c
> index dd117f07fc95..71cf13ae51c7 100644
> --- a/drivers/pci/controller/pcie-xilinx-dma-pl.c
> +++ b/drivers/pci/controller/pcie-xilinx-dma-pl.c
> @@ -470,7 +470,7 @@ static int xilinx_pl_dma_pcie_init_msi_irq_domain(struct pl_dma_pcie *port)
>  	struct device *dev = port->dev;
>  	struct xilinx_msi *msi = &port->msi;
>  	int size = BITS_TO_LONGS(XILINX_NUM_MSI_IRQS) * sizeof(long);
> -	struct fwnode_handle *fwnode = of_node_to_fwnode(port->dev->of_node);
> +	struct fwnode_handle *fwnode = of_fwnode_handle(port->dev->of_node);
>  
>  	msi->dev_domain = irq_domain_add_linear(NULL, XILINX_NUM_MSI_IRQS,
>  						&dev_msi_domain_ops, port);
> diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
> index 8d6e2a89b067..9cf8a96f7bc4 100644
> --- a/drivers/pci/controller/pcie-xilinx-nwl.c
> +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
> @@ -495,7 +495,7 @@ static int nwl_pcie_init_msi_irq_domain(struct nwl_pcie *pcie)
>  {
>  #ifdef CONFIG_PCI_MSI
>  	struct device *dev = pcie->dev;
> -	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
> +	struct fwnode_handle *fwnode = of_fwnode_handle(dev->of_node);
>  	struct nwl_msi *msi = &pcie->msi;
>  
>  	msi->dev_domain = irq_domain_add_linear(NULL, INT_PCI_MSI_NR,
> diff --git a/drivers/pci/controller/plda/pcie-plda-host.c b/drivers/pci/controller/plda/pcie-plda-host.c
> index 4153214ca410..4c7a9fa311e3 100644
> --- a/drivers/pci/controller/plda/pcie-plda-host.c
> +++ b/drivers/pci/controller/plda/pcie-plda-host.c
> @@ -150,7 +150,7 @@ static struct msi_domain_info plda_msi_domain_info = {
>  static int plda_allocate_msi_domains(struct plda_pcie_rp *port)
>  {
>  	struct device *dev = port->dev;
> -	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
> +	struct fwnode_handle *fwnode = of_fwnode_handle(dev->of_node);
>  	struct plda_msi *msi = &port->msi;
>  
>  	mutex_init(&port->msi.lock);
> -- 
> 2.49.0
> 


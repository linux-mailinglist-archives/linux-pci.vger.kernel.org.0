Return-Path: <linux-pci+bounces-8490-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 650D09010F7
	for <lists+linux-pci@lfdr.de>; Sat,  8 Jun 2024 11:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50E281C20921
	for <lists+linux-pci@lfdr.de>; Sat,  8 Jun 2024 09:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F76B178381;
	Sat,  8 Jun 2024 09:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fw+w9GB1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396C5178380;
	Sat,  8 Jun 2024 09:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717837331; cv=none; b=JJNQCZOBQoZeVVJ3Az+uqJsIpqf7FZa4iKW2yk7+/+/cfUB4ec446i8kpTi8eA89ytbDwuang8VypIpb5Rem0V/H4B3gABH3b8oohqkdDvZKU97WT0QmrR8IjJ0w4hScsrC/QYNpTRKKw0Q+wp+9l1YWycgCtXCyJRbIDxbBiVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717837331; c=relaxed/simple;
	bh=pn6sRt29wjeooIZHAWfVIge2Odfg9sfeFnnF7t2PQuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XppbbWg0Ns2Qa5HRC2tN8MiUBKrRnQGNE7WKoVlNV2dTuz++pTYjgqn9hFTHyeDwGk9StL7MgEyDf/nb+Xvo4DALImofCWnUtcRlQfa/hCQuvtkWmwogY/ue7gGi03wOGfBpfhb1kACDYxV61mcaDZgbttFlL7gxrExD8I4f2ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fw+w9GB1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA99C3277B;
	Sat,  8 Jun 2024 09:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717837331;
	bh=pn6sRt29wjeooIZHAWfVIge2Odfg9sfeFnnF7t2PQuk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fw+w9GB1UmC8TQLf64V1fuur1RM2TjOW/V8lr4NXyEn6EUHIfKYiNfhRMmFPDKmP+
	 dVge0rIhzSrAw6QofLByJrE/cNLWbUXA32ccna84Yq6XMoIKpkSLMFm/FRRCRLL5xt
	 BI0LQixNhmeqlU2UP/zxrcwYi2RRk9AUZ3wuLPbwKSa6NPQi/j+zSMcvtUrrZq7o4Y
	 gW1dHg41ja/7I0eG0rBvW9kIV8U7WVUYdLs5wjOTxY4C6AnJxY/jt43JknorAADdj3
	 DkzGwbkBRu+j3P0B8NQCLODsqiMLaQ75cXph3YBq9OzU+RXsunrCiKLVIVnXZutifq
	 H4Sav7rFkWzTg==
Date: Sat, 8 Jun 2024 14:31:52 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Jianjun Wang <jianjun.wang@mediatek.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Marc Zyngier <maz@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>,
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	jieyy.yang@mediatek.com, chuanjia.liu@mediatek.com,
	qizhong.cheng@mediatek.com, jian.yang@mediatek.com,
	jianguo.zhang@mediatek.com
Subject: Re: [PATCH v2 1/3] PCI: mediatek: Allocate MSI address with
 dmam_alloc_coherent()
Message-ID: <20240608090152.GB3282@thinkpad>
References: <20231211085256.31292-1-jianjun.wang@mediatek.com>
 <20231211085256.31292-2-jianjun.wang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231211085256.31292-2-jianjun.wang@mediatek.com>

On Mon, Dec 11, 2023 at 04:52:54PM +0800, Jianjun Wang wrote:
> Use dmam_alloc_coherent() to allocate the MSI address, instead of using
> virt_to_phys().
> 

What is the reason for this change? So now PCIE_MSI_VECTOR becomes unused?

- Mani

> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> ---
>  drivers/pci/controller/pcie-mediatek.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index 66a8f73296fc..2fb9e44369f8 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -178,6 +178,7 @@ struct mtk_pcie_soc {
>   * @phy: pointer to PHY control block
>   * @slot: port slot
>   * @irq: GIC irq
> + * @msg_addr: MSI message address
>   * @irq_domain: legacy INTx IRQ domain
>   * @inner_domain: inner IRQ domain
>   * @msi_domain: MSI IRQ domain
> @@ -198,6 +199,7 @@ struct mtk_pcie_port {
>  	struct phy *phy;
>  	u32 slot;
>  	int irq;
> +	dma_addr_t msg_addr;
>  	struct irq_domain *irq_domain;
>  	struct irq_domain *inner_domain;
>  	struct irq_domain *msi_domain;
> @@ -394,12 +396,10 @@ static struct pci_ops mtk_pcie_ops_v2 = {
>  static void mtk_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  {
>  	struct mtk_pcie_port *port = irq_data_get_irq_chip_data(data);
> -	phys_addr_t addr;
>  
>  	/* MT2712/MT7622 only support 32-bit MSI addresses */
> -	addr = virt_to_phys(port->base + PCIE_MSI_VECTOR);
>  	msg->address_hi = 0;
> -	msg->address_lo = lower_32_bits(addr);
> +	msg->address_lo = lower_32_bits(port->msg_addr);
>  
>  	msg->data = data->hwirq;
>  
> @@ -494,6 +494,14 @@ static struct msi_domain_info mtk_msi_domain_info = {
>  static int mtk_pcie_allocate_msi_domains(struct mtk_pcie_port *port)
>  {
>  	struct fwnode_handle *fwnode = of_node_to_fwnode(port->pcie->dev->of_node);
> +	void *msi_vaddr;
> +
> +	msi_vaddr = dmam_alloc_coherent(port->pcie->dev, sizeof(dma_addr_t), &port->msg_addr,
> +					GFP_KERNEL);
> +	if (!msi_vaddr) {
> +		dev_err(port->pcie->dev, "failed to alloc and map MSI address\n");
> +		return -ENOMEM;
> +	}
>  
>  	mutex_init(&port->lock);
>  
> @@ -501,6 +509,7 @@ static int mtk_pcie_allocate_msi_domains(struct mtk_pcie_port *port)
>  						      &msi_domain_ops, port);
>  	if (!port->inner_domain) {
>  		dev_err(port->pcie->dev, "failed to create IRQ domain\n");
> +		dmam_free_coherent(port->pcie->dev, sizeof(dma_addr_t), msi_vaddr, port->msg_addr);
>  		return -ENOMEM;
>  	}
>  
> @@ -508,6 +517,7 @@ static int mtk_pcie_allocate_msi_domains(struct mtk_pcie_port *port)
>  						     port->inner_domain);
>  	if (!port->msi_domain) {
>  		dev_err(port->pcie->dev, "failed to create MSI domain\n");
> +		dmam_free_coherent(port->pcie->dev, sizeof(dma_addr_t), msi_vaddr, port->msg_addr);
>  		irq_domain_remove(port->inner_domain);
>  		return -ENOMEM;
>  	}
> @@ -518,10 +528,8 @@ static int mtk_pcie_allocate_msi_domains(struct mtk_pcie_port *port)
>  static void mtk_pcie_enable_msi(struct mtk_pcie_port *port)
>  {
>  	u32 val;
> -	phys_addr_t msg_addr;
>  
> -	msg_addr = virt_to_phys(port->base + PCIE_MSI_VECTOR);
> -	val = lower_32_bits(msg_addr);
> +	val = lower_32_bits(port->msg_addr);
>  	writel(val, port->base + PCIE_IMSI_ADDR);
>  
>  	val = readl(port->base + PCIE_INT_MASK);
> @@ -588,7 +596,7 @@ static int mtk_pcie_init_irq_domain(struct mtk_pcie_port *port,
>  	if (IS_ENABLED(CONFIG_PCI_MSI)) {
>  		ret = mtk_pcie_allocate_msi_domains(port);
>  		if (ret)
> -			return ret;
> +			dev_warn(dev, "no MSI supported, only INTx available\n");
>  	}
>  
>  	return 0;
> @@ -732,7 +740,7 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
>  	val &= ~INTX_MASK;
>  	writel(val, port->base + PCIE_INT_MASK);
>  
> -	if (IS_ENABLED(CONFIG_PCI_MSI))
> +	if (IS_ENABLED(CONFIG_PCI_MSI) && port->msi_domain)
>  		mtk_pcie_enable_msi(port);
>  
>  	/* Set AHB to PCIe translation windows */
> -- 
> 2.18.0
> 
> 

-- 
மணிவண்ணன் சதாசிவம்


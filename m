Return-Path: <linux-pci+bounces-19914-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23889A129E2
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 18:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C0B4188ADAD
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 17:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4800199244;
	Wed, 15 Jan 2025 17:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r4XCWv0V"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2947B1990C5
	for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2025 17:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736962331; cv=none; b=jV6UO4jZESxuGiZtyyT3lLZgnukV5bJ//zorucpDwi240li0ITM7uJ+iZab4TkQ4/pX1dmIK10go+PIcKdLFKP/UFnUlpnY/njL3qHi94OUjk+2FF01aTUMWbB1aHez4rrCvQ/78K6Gqa2zzlGAbzmn3rSCiKHm5/nisx9gTGDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736962331; c=relaxed/simple;
	bh=XlgRTd4Zx+OlM5PahflOwmKhPGSoYvzyix33P1fFNvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aT6n0MF3VW5svRd+zIHBYpjzs+4aODCZUpbQooXltZgwh4uPvKrZpnCxjfuA0OTY1XtGj3dCMewzzHL2DM9RWfLs7NBtdS/j10zJIs9FBwN/lyiudaTc8P0LNwGMrML9zzaa7BPFHPfDR6AuF6sVjq4qBBFcDv47c7CBUJvUNWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r4XCWv0V; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2163b0c09afso132128065ad.0
        for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2025 09:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736962328; x=1737567128; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mefQhuFSpESwaWyEeCQcodcETTlSwT/UegGsRwZi/b0=;
        b=r4XCWv0VDF1QdNkZ5tt6Mk+8LD3nj3bXQBaqACIjflDvEh1od71WhU/IeMyk2mvk9s
         XUBjg/WK4qXwNA4Qy6qrpHfSo87RCAI2uk5aIhJiJVPPyEgzcwg0PQcHermHEfCXcgJy
         FcR9sqyO7bxGjP/vBK7klcTrkEFTWBCk9DI5edZSTfoOmme6wxZyelEHIo6OyzMWFmeK
         AIll8KJQJyHjMdQTZzQD+PKxFm6J/lawJE1E+Lx/fdk/hB+yVt/2Fs2jO2TLcx9L4EWF
         m60zk/pG0jmr1hmpF4SrKVPROYmZ3frzMVzsNobF9TkJ7E3XifVInlA2oE2SffXBqei9
         NOiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736962328; x=1737567128;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mefQhuFSpESwaWyEeCQcodcETTlSwT/UegGsRwZi/b0=;
        b=dDS4tCoQE3xEc8yiOWnloWTrATWMIG8SO7h/vwQyNAGiLgZ/loc5R3bMAPvTCD6Qak
         T1GI54B/y93exTOIG1kCAg0Xxzqc3sYRUwBUIq+Yqdkifb4oyYtCcryOVk4R1qcLZ0ji
         0Kab67+k/EhAF/MysYr0vC7cqHNmtUj3GuAFP6X7std+qEN5wsIU6Re+ZxTOBqx2fa1F
         SyxNmDq1ramdLnPgpgO3XTA/e1i3GAGR6Hukgb6OG4/cgozzmVM+Aci2bqrgBszJGF+3
         lKsltCngfQMAdthIfgp/6QxIkWQH2x5YJfR9lsx5/AYRqUD54TVz7MgnzIRtY14kMZtP
         LG4g==
X-Forwarded-Encrypted: i=1; AJvYcCXFRA5mwPHxSwipvM6PFt3X8wLb/MYwJGyp/UOHf3XFqskOt+K8HzUlh0AKzNW1jPcFj0Qh4N65u/k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyu2EKCe4ddfatG8rXOIZFtTyr2AiRk+SFj4WZ9JIAfApP8MNX
	uAefto2CQUFH5JgzAQphdKLWpuq/ab9Y6e+nyucijoX2//cX8PCaOeNsMRJHFQ==
X-Gm-Gg: ASbGnctQJS9i1R9uFU79OA4H249u9eAKlA8vAke0O7VPtQg1UmQHKlwW5FlQ1arYURN
	CaxA+KBQa6It0KdNHGVPBi+Z6B4YDR5XTlQuEvRSLHlOkCs1Q2ISYJ6v4RzxF0wmmXPXeqraRwD
	kKhCm9gibbcRmpTPwLVq70lVq84byc4LKoGImsuNvUjN5UjtMJOz9PZnVyPEql0hQKhQAKgwEJc
	bzbvLj1Vb0FkaINNJSfE30VNYqgX2J09IwurjJs/qf5RFbO7XEmfOCKj6VvTjdcPzY=
X-Google-Smtp-Source: AGHT+IFoPbnCjN1tgNPCYljOFQm2tsMB7bBFWGIOdh7Y1887G14VhNx7Fz3KiZvw9oD86u6cjeHF0g==
X-Received: by 2002:a17:90a:e18f:b0:2ee:5bc9:75b5 with SMTP id 98e67ed59e1d1-2f548ea6493mr42162362a91.4.1736962328427;
        Wed, 15 Jan 2025 09:32:08 -0800 (PST)
Received: from thinkpad ([120.60.139.68])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f72c1cc867sm1643077a91.26.2025.01.15.09.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 09:32:06 -0800 (PST)
Date: Wed, 15 Jan 2025 23:01:56 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Jianjun Wang <jianjun.wang@mediatek.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryder Lee <ryder.lee@mediatek.com>, linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: mediatek: Remove the usage of virt_to_phys
Message-ID: <20250115173156.a73ntoyyn3xy52ze@thinkpad>
References: <20250107052108.8643-1-jianjun.wang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250107052108.8643-1-jianjun.wang@mediatek.com>

On Tue, Jan 07, 2025 at 01:20:58PM +0800, Jianjun Wang wrote:
> Remove the usage of virt_to_phys, as it will cause sparse warnings when
> building on some platforms.
> 

Strange. What are those warnings and platforms?

- Mani

> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> ---
>  drivers/pci/controller/pcie-mediatek.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index 3bcfc4e58ba2..dc1e5fd6c7aa 100644
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
> +	phys_addr_t msg_addr;
>  	struct irq_domain *irq_domain;
>  	struct irq_domain *inner_domain;
>  	struct irq_domain *msi_domain;
> @@ -393,12 +395,10 @@ static struct pci_ops mtk_pcie_ops_v2 = {
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
> @@ -510,10 +510,8 @@ static int mtk_pcie_allocate_msi_domains(struct mtk_pcie_port *port)
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
> @@ -913,6 +911,7 @@ static int mtk_pcie_parse_port(struct mtk_pcie *pcie,
>  	struct mtk_pcie_port *port;
>  	struct device *dev = pcie->dev;
>  	struct platform_device *pdev = to_platform_device(dev);
> +	struct resource *regs;
>  	char name[10];
>  	int err;
>  
> @@ -921,12 +920,18 @@ static int mtk_pcie_parse_port(struct mtk_pcie *pcie,
>  		return -ENOMEM;
>  
>  	snprintf(name, sizeof(name), "port%d", slot);
> -	port->base = devm_platform_ioremap_resource_byname(pdev, name);
> +	regs = platform_get_resource_byname(pdev, IORESOURCE_MEM, name);
> +	if (!regs)
> +		return -EINVAL;
> +
> +	port->base = devm_ioremap_resource(dev, regs);
>  	if (IS_ERR(port->base)) {
>  		dev_err(dev, "failed to map port%d base\n", slot);
>  		return PTR_ERR(port->base);
>  	}
>  
> +	port->msg_addr = regs->start + PCIE_MSI_VECTOR;
> +
>  	snprintf(name, sizeof(name), "sys_ck%d", slot);
>  	port->sys_ck = devm_clk_get(dev, name);
>  	if (IS_ERR(port->sys_ck)) {
> -- 
> 2.46.0
> 

-- 
மணிவண்ணன் சதாசிவம்


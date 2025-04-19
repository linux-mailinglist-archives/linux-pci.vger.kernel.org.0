Return-Path: <linux-pci+bounces-26273-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F233A94253
	for <lists+linux-pci@lfdr.de>; Sat, 19 Apr 2025 10:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B6D07A98E1
	for <lists+linux-pci@lfdr.de>; Sat, 19 Apr 2025 08:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392651A5B9B;
	Sat, 19 Apr 2025 08:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FBH+Fftj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEE91AF0C8
	for <linux-pci@vger.kernel.org>; Sat, 19 Apr 2025 08:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745051817; cv=none; b=S4T1znSBElK73nXySgzuON740tv3b7S8y6CCofHOHij0/IbV3lKEGxmT+6ckN/1o2S6rHtUuVCoX9SsDdfdmWPbosvCXL0z/E8sHQRq75eGEXLKYmZ7yB5KXMjaeBBOjGiwPy+weXSHY3Fxtz+BMnLU9yY9luqL3/ShHj2d1KIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745051817; c=relaxed/simple;
	bh=/cjQX46TG/1tQiEUY53/IXcAF6SECujuKDfyckSZ8M4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LAKBSOQDDDO+lKzkXHSUKP+ouB3aXKq5R0Fup+4U5e0pqCp0+aBGZssdWkPdDWCmqe8IW2+pdEk0F403C1ZsdpZIyrqKhFDvLpke9elq5us20eLyPezQD1oq0aqVYtVfCJNA/RDLFwbgU0bib02SDLDkJHKaVgOWvpih2VburpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FBH+Fftj; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-736dd9c4b40so3258564b3a.0
        for <linux-pci@vger.kernel.org>; Sat, 19 Apr 2025 01:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745051815; x=1745656615; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hWIuLilHx+0m0PNW09Z0k4xV/guGg8/Qmv8ZqaHqGFA=;
        b=FBH+Fftj2XjkPn1OXUXpglgOKQBZrDNs0XOGePtrDCn/llECg2us4NDnv/1orXblln
         RBr6QmduX8nm1HYmJcMHYym4LWjzOm8aZVAnZpDwT+spTXd/DqiOSUrv8OhF3uSxPIUD
         X6XLFWkHwIdEBlUoMS9IO814rclcW7FvQRQd243h+tXXdCUYPWu99YcQ+8JM9L/wVdYe
         B5jJFvADu1ae27WPcbBO1+m+0V/XB1i3hBO3BMc2vXDfULPHEwE6mraU7dCPUDv9vVDz
         hGipwmCxZL6SDp1VqwkEoOTopG4weYngMgYXWyhzGDtR1SsbTHV9mxwf1LMpFSXFv2zo
         T60A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745051815; x=1745656615;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hWIuLilHx+0m0PNW09Z0k4xV/guGg8/Qmv8ZqaHqGFA=;
        b=qHnt6MpVUVG+7XF+KWGFA8ii8k+RmdIt9yHTjDN3JJylB8/6FCFD3Z3oKnDk19dKC0
         IKkeJoRHf7ignd4t3ExH3TlLWeYe5yq83h1mWQ458NkGyKszzOmnZgdp3mJJsOhlhpx0
         oBZhPl4agv5YZXbi78MuMTRvJo566mk9tlaGXWpxHqbSt4wCNb1vio4xmvoYyTiAn/N0
         yrRm7ESzsHrib3WzSsezGPpHespE4C/YP2OdXif8Qv9cZh2eDJoMEnLaVe7s8LMmvZRm
         COPAJx3mx5FfsZPP4wEhv2fc7ZS6DteIAzN6yafl1Jl8V2oK2nVlZK88+0AcFB0gd62N
         zh0w==
X-Forwarded-Encrypted: i=1; AJvYcCVYhkZbj/X4p+Z47wRVtt4gQhkgqTRvqt1cQ6IFmvZGBrgBAMy41MgvaEdfjE2s9C0Ptg3Baa2Updw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3AWz9zRMe97b8gawj7cBqyMvxAZXbpSDsiKxr4JHHq5pLmQyf
	O7XVqRR4PiIshtUPfgua/BglpuX7FetgKNnrJvvDiJb0+30pLC///ir2MxQvHA==
X-Gm-Gg: ASbGncuq5nyRcqyBuaixUncawFqHPrmh7MvRz0fqtwYeDiPZWQDip80dbvZBec0usK8
	+imtqFVgXpgawsie7w1DNZBI5T0XseSezLA7Rc3reVGVL0SRcXY0Fm4G/hrndkDPZR0NzY2da2/
	ogtjcDQfnyxGbJc8Ce4JmWjQ51n1WnHJW5RDenCLqYsxi8qhUcK60lAmJgScsB0DyUIcBtsEv5n
	EvPZptM/81Kzc7UY+/VVafTRtkZP63BEnzqJcrO2W456CZCrThPvdhHpiXKvnZFI8dycUhGJ0yD
	9KmGIjganXUcNSnOKp0HW8AjuByQxjzNMFbhZH3vDgVieFRjQkApStWiTwlnQA==
X-Google-Smtp-Source: AGHT+IH3NDcdNNb8pbSv2t3bDQf2H8zk313Y64ucJBKvLy8gNjS7N5oRSvDjpG+wLPNMUPr2fDtP/Q==
X-Received: by 2002:a05:6a20:9c9a:b0:1f3:20be:c18a with SMTP id adf61e73a8af0-203cc60880bmr6254890637.10.1745051814740;
        Sat, 19 Apr 2025 01:36:54 -0700 (PDT)
Received: from thinkpad ([36.255.17.167])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0db14488casm2467771a12.56.2025.04.19.01.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 01:36:54 -0700 (PDT)
Date: Sat, 19 Apr 2025 14:06:49 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Jianjun Wang <jianjun.wang@mediatek.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Ryder Lee <ryder.lee@mediatek.com>, linux-pci@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: mediatek: Remove the usage of virt_to_phys
Message-ID: <oiwee2kiwex6dz3scmvpwc2x25tq4qmdah6kcvgqhhukmku3uj@va465i7ofstd>
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
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>

I'm changing the status of this patch as 'Changes Requested' in patchwork. Feel
free to submit the next iteration incorporating review comments.

- Mani

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


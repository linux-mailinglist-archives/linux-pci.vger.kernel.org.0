Return-Path: <linux-pci+bounces-28255-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 953ACAC0445
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 07:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD1431BA4ACE
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 05:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4330C1F130B;
	Thu, 22 May 2025 05:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vin+gr0A"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182EC1EB5E6;
	Thu, 22 May 2025 05:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747893237; cv=none; b=rGrXRmXzkcgIG6ugJBo3f5VGwl5CRwNZCG77vf1LtZIrb0J+IsIorX6cneXV5E1i6sUvETjVSiICuyHBPO6t/j/VGx5xLDiudhfaAXChdS4lmOwWJUc71zx+ll/w5ddTlnC+xZu2UqKcFNV/z9pzM0i6IVN5vrFqMHNt8wfJ9Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747893237; c=relaxed/simple;
	bh=rjBn3jaI7WED46iiLo2bx2xm3nr8nu81n+DpP6ZwvbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I1iVz67iiLFhRIGeNvCUvem6/tcy76JqwIW0FQnuN9VNLkmKyBnvttKMmpbw4fbQS6p36RZUqEIn5iTnaLzYiXSEsVDTcB992Jmq2GYJ/iB7FGVk1RFEZagMBTN38T9Uz9LoEDPNTZoO9WDXMDNXFrwPIm9NCgiNI+BUCAstz00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vin+gr0A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 132BAC4CEE4;
	Thu, 22 May 2025 05:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747893236;
	bh=rjBn3jaI7WED46iiLo2bx2xm3nr8nu81n+DpP6ZwvbM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Vin+gr0AnHt+5qTPw4fLZhQSP/ljRNH5ChLLWvy0LHfAvpHNzRwbfo5p/T+iSz6L0
	 blDWAHtcdeJnyYgDMN96IdxsP39vPSqppsTdRI4X7ovepDAT7dohFlFuy+dLYB7982
	 9XgtS2iKT1W7H5K6n7ZnI7/xEC1rNJnSH07a23hYNCpuY/XrgQYvr6GJ4/GIF9Kvu3
	 07HVqFlv/Mm/N1Zf3LfqACjB0xUDslZDHmko+dQNjNTrj/GwqA/RVoNWzHIVtwvzZr
	 sFQUxMmXCoD3cUKpedyUTPjvQMUn4BOolMmmRDw3sYiKD0HekBr3cJ4tQ5AHauYn5c
	 L8hUOTzUjQ5fw==
Message-ID: <e926d3ba-5ed2-4942-b928-a969ca085f63@kernel.org>
Date: Thu, 22 May 2025 07:53:53 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pci: altera: remove unused 'node' variable
To: Arnd Bergmann <arnd@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Joyce Ooi <joyce.ooi@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250521163329.2137973-1-arnd@kernel.org>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20250521163329.2137973-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21. 05. 25, 18:29, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This variable is only used when CONFIG_OF is enabled:
> 
> drivers/pci/controller/pcie-altera.c: In function 'altera_pcie_init_irq_domain':
> drivers/pci/controller/pcie-altera.c:855:29: error: unused variable 'node' [-Werror=unused-variable]
>    855 |         struct device_node *node = dev->of_node;
> 
> Use dev_fwnode() in place of of_node_to_fwnode() to avoid this.

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

Right, this reminds me that my dev_fwnode() patches (in my local queue 
-- they were supposed to be in v3) are not only cleanup, but also fix 
warnings.

I was thinking to send those after the merge window (so that I can route 
through subsys maintainers and not bother Thomas, as they touch many 
files [1]), but I will send them when I am back from a conf.

[1]
arch/powerpc/platforms/8xx/cpm1-ic.c
arch/powerpc/sysdev/fsl_msi.c
drivers/edac/altera_edac.c
drivers/gpio/gpio-brcmstb.c
drivers/gpio/gpio-davinci.c
drivers/gpio/gpio-em.c
drivers/gpio/gpio-grgpio.c
drivers/gpio/gpio-lpc18xx.c
drivers/gpio/gpio-mvebu.c
drivers/gpio/gpio-mxc.c
drivers/gpio/gpio-mxs.c
drivers/gpio/gpio-pxa.c
drivers/gpio/gpio-rockchip.c
drivers/gpio/gpio-sodaville.c
drivers/gpio/gpio-tb10x.c
drivers/gpio/gpio-twl4030.c
drivers/gpu/drm/msm/msm_mdss.c
drivers/gpu/ipu-v3/ipu-common.c
drivers/i2c/muxes/i2c-mux-pca954x.c
drivers/iio/adc/stm32-adc-core.c
drivers/irqchip/irq-imgpdc.c
drivers/irqchip/irq-imx-irqsteer.c
drivers/irqchip/irq-keystone.c
drivers/irqchip/irq-mvebu-pic.c
drivers/irqchip/irq-pruss-intc.c
drivers/irqchip/irq-renesas-intc-irqpin.c
drivers/irqchip/irq-renesas-irqc.c
drivers/irqchip/irq-renesas-rza1.c
drivers/irqchip/irq-renesas-rzg2l.c
drivers/irqchip/irq-renesas-rzv2h.c
drivers/irqchip/irq-stm32mp-exti.c
drivers/irqchip/irq-ti-sci-inta.c
drivers/irqchip/irq-ti-sci-intr.c
drivers/irqchip/irq-ts4800.c
drivers/mailbox/qcom-ipcc.c
drivers/memory/omap-gpmc.c
drivers/mfd/88pm860x-core.c
drivers/mfd/ab8500-core.c
drivers/mfd/fsl-imx25-tsadc.c
drivers/mfd/lp8788-irq.c
drivers/mfd/max8925-core.c
drivers/mfd/mt6358-irq.c
drivers/mfd/mt6397-irq.c
drivers/mfd/qcom-pm8xxx.c
drivers/mfd/stmfx.c
drivers/mfd/tps65217.c
drivers/mfd/tps6586x.c
drivers/mfd/twl4030-irq.c
drivers/mfd/twl6030-irq.c
drivers/mfd/wm831x-irq.c
drivers/misc/hi6421v600-irq.c
drivers/net/dsa/microchip/ksz_common.c
drivers/net/dsa/microchip/ksz_ptp.c
drivers/net/dsa/mv88e6xxx/global2.c
drivers/net/dsa/qca/ar9331.c
drivers/net/usb/lan78xx.c
drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
drivers/pci/controller/pcie-altera.c
drivers/pci/controller/pcie-mediatek-gen3.c
drivers/pinctrl/mediatek/mtk-eint.c
drivers/pinctrl/pinctrl-at91-pio4.c
drivers/pinctrl/sunxi/pinctrl-sunxi.c
drivers/soc/fsl/qe/qe_ic.c
drivers/soc/tegra/pmc.c
drivers/thermal/qcom/lmh.c
drivers/thermal/tegra/soctherm.c


> Fixes: bbc94e6f72f2 ("PCI: Switch to irq_domain_create_linear()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ----
> I checked the other PCI host bridge drivers as well, this is the
> only one with that problem.
> ---
>   drivers/pci/controller/pcie-altera.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
> index 0fc77176a52e..3dbb7adc421c 100644
> --- a/drivers/pci/controller/pcie-altera.c
> +++ b/drivers/pci/controller/pcie-altera.c
> @@ -852,10 +852,9 @@ static void aglx_isr(struct irq_desc *desc)
>   static int altera_pcie_init_irq_domain(struct altera_pcie *pcie)
>   {
>   	struct device *dev = &pcie->pdev->dev;
> -	struct device_node *node = dev->of_node;
>   
>   	/* Setup INTx */
> -	pcie->irq_domain = irq_domain_create_linear(of_fwnode_handle(node), PCI_NUM_INTX,
> +	pcie->irq_domain = irq_domain_create_linear(dev_fwnode(dev), PCI_NUM_INTX,
>   					&intx_domain_ops, pcie);
>   	if (!pcie->irq_domain) {
>   		dev_err(dev, "Failed to get a INTx IRQ domain\n");

thanks,
-- 
js
suse labs


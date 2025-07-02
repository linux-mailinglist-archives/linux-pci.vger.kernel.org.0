Return-Path: <linux-pci+bounces-31256-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2616BAF45DB
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 15:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A70E81C42CBB
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 13:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41487274FC6;
	Wed,  2 Jul 2025 13:05:06 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0331E485;
	Wed,  2 Jul 2025 13:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751461506; cv=none; b=Jpk35XJH09Rt1ld6zUrLiHds5d1zhfQtHpU170HSiENcetKGwfFsAe+vAgBfPOV5bVgvDWL3k4lgSvASJKx4nOo5MvTSFeWvf24i81RPxw2AFhKWEnMYj5ynl4aLK024k0IfsIMGgzWHXahGXC+Kl7gSrm6lNyM3dd46pHlaXZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751461506; c=relaxed/simple;
	bh=HjgWc25q2uiagIerSLRdcUn1MeXY7b5/hcSUH9aomzo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M/ox2eGfdWq8SP3GXkw6zZSPbVu4Z/ZENeOzTrH271+EL3Qvr9VrFxtFCWICbtvPNc3NgASuWQ/dXvfyg5zf8E/yzQJPIUm/XuZ8D6GGRunFNJft+M1hPaDIVxDkgaqkBKC1pyd+tWOnSiqCCfxEHsfr/g+4E5FPJoE8wfZHwmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bXKpt1TgDz6M4tL;
	Wed,  2 Jul 2025 21:04:06 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id CBD6314038F;
	Wed,  2 Jul 2025 21:05:01 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 2 Jul
 2025 15:05:01 +0200
Date: Wed, 2 Jul 2025 14:04:59 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
CC: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Sascha
 Bischoff" <sascha.bischoff@arm.com>, Timothy Hayes <timothy.hayes@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>, "Liam R. Howlett"
	<Liam.Howlett@oracle.com>, Peter Maydell <peter.maydell@linaro.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Jiri Slaby <jirislaby@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v6 21/31] irqchip/gic-v5: Add GICv5 IRS/SPI support
Message-ID: <20250702140459.000063ef@huawei.com>
In-Reply-To: <20250626-gicv5-host-v6-21-48e046af4642@kernel.org>
References: <20250626-gicv5-host-v6-0-48e046af4642@kernel.org>
	<20250626-gicv5-host-v6-21-48e046af4642@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)



There are more ID masks not using FIELD_PREP() in here, but
as mentioned in earlier reply, even if we decide those are worth
cleaning up, no reason it can't be as a trivial patch on top of the
series.

Otherwise just one comment walking back some feedback on an earlier
patch (as what you had there now makes sense)

Jonathan

> diff --git a/drivers/irqchip/irq-gic-v5-irs.c b/drivers/irqchip/irq-gic-v5-irs.c
> new file mode 100644
> index 000000000000..fba8efceb26e
> --- /dev/null
> +++ b/drivers/irqchip/irq-gic-v5-irs.c
> @@ -0,0 +1,434 @@

> -static int gicv5_irq_ppi_domain_translate(struct irq_domain *d,
> -					  struct irq_fwspec *fwspec,
> -					  irq_hw_number_t *hwirq,
> -					  unsigned int *type)
> +static const struct irq_chip gicv5_spi_irq_chip = {
> +	.name			= "GICv5-SPI",
> +	.irq_mask		= gicv5_spi_irq_mask,
> +	.irq_unmask		= gicv5_spi_irq_unmask,
> +	.irq_eoi		= gicv5_spi_irq_eoi,
> +	.irq_set_type		= gicv5_spi_irq_set_type,
> +	.irq_set_affinity	= gicv5_spi_irq_set_affinity,
> +	.irq_retrigger		= gicv5_spi_irq_retrigger,
> +	.irq_get_irqchip_state	= gicv5_spi_irq_get_irqchip_state,
> +	.irq_set_irqchip_state	= gicv5_spi_irq_set_irqchip_state,
> +	.flags			= IRQCHIP_SET_TYPE_MASKED |
> +				  IRQCHIP_SKIP_SET_WAKE	  |
> +				  IRQCHIP_MASK_ON_SUSPEND,
> +};
> +
> +static __always_inline int gicv5_irq_domain_translate(struct irq_domain *d,
> +						      struct irq_fwspec *fwspec,
> +						      irq_hw_number_t *hwirq,
> +						      unsigned int *type,
> +						      const u8 hwirq_typ)

>  {
>  	if (!is_of_node(fwspec->fwnode))
>  		return -EINVAL;
> @@ -235,20 +428,39 @@ static int gicv5_irq_ppi_domain_translate(struct irq_domain *d,
>  	if (fwspec->param_count < 3)
>  		return -EINVAL;
>  
> -	if (fwspec->param[0] != GICV5_HWIRQ_TYPE_PPI)
> +	if (fwspec->param[0] != hwirq_type)
>  		return -EINVAL;
>  
>  	*hwirq = fwspec->param[1];
>  
> -	/*
> -	 * Handling mode is hardcoded for PPIs, set the type using
> -	 * HW reported value.
> -	 */
> -	*type = gicv5_ppi_irq_is_level(*hwirq) ? IRQ_TYPE_LEVEL_LOW : IRQ_TYPE_EDGE_RISING;
> +	switch (hwirq_type) {
> +	case GICV5_HWIRQ_TYPE_PPI:
> +		/*
> +		 * Handling mode is hardcoded for PPIs, set the type using
> +		 * HW reported value.
> +		 */
> +		*type = gicv5_ppi_irq_is_level(*hwirq) ? IRQ_TYPE_LEVEL_LOW :
> +							 IRQ_TYPE_EDGE_RISING;
> +		break;
> +	case GICV5_HWIRQ_TYPE_SPI:
> +		*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;

Ah fair enough in earlier patches on just enforcing 3 parameters for all cases.
Seems like a sensible simplification once this is taken into account. So ignore that one!

> +		break;
> +	default:
> +		BUILD_BUG_ON(1);
> +	}
>  
>  	return 0;
>  }


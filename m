Return-Path: <linux-pci+bounces-8861-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 996CE90994A
	for <lists+linux-pci@lfdr.de>; Sat, 15 Jun 2024 19:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1B12281C95
	for <lists+linux-pci@lfdr.de>; Sat, 15 Jun 2024 17:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF9A383B1;
	Sat, 15 Jun 2024 17:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hP2DLm/d"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456B61EB3E;
	Sat, 15 Jun 2024 17:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718472249; cv=none; b=LXYZ9IFYO35YAsmH+aHvzLqVyxzZdi4wcvFgW3jrJqPSRS4JGG+GD2T8g30MnZUNXzbupR1Wb/lpPwP/q2+AakZWp5me+sNEYrNMUyZ6ueB4vmLf4TIcT4z9Vzg0MoEi6tUzJSt10t7opKVVZYdvsbnyu6aoCZ6HqKrKJRE0Slg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718472249; c=relaxed/simple;
	bh=le7fDVc9cjR9e9+nug6jndZDflrnZEi5eYgU/1s8wqg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oXZXQzt540PoVSMYhY4CV/Rg8YMAf8YHX/oHDaqsbYkWjofszdpeizSxhdWVUvOIzPV1m+5OElcEt9G9C0sz2K2QU3oPbz0UHEsYL0L5IvWOKJhBubjeK9EEc3goIe4/ChWOuRun0G8eyIrpjWW17WWY620p35H8/LmnlPKIewU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hP2DLm/d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A31EEC116B1;
	Sat, 15 Jun 2024 17:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718472248;
	bh=le7fDVc9cjR9e9+nug6jndZDflrnZEi5eYgU/1s8wqg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hP2DLm/deqsXgPgT38e0Sodakqx1XB9uSIkp+W1LvraGoXryG7Mo/akJfqX4dSYcS
	 +ATbnQ37NuniAmmPQo5Zo8i3sX7DhcgaY35+DL1djBwlQNvi1Qhp0RIJCnCeienFrg
	 5Z3rdzR9Juk/XYPnwItncDZfx/x1O9OvbZMXyIldZT4AZqjVQpZ9eDsY1f0ytvu3ID
	 veeW2KTjWb9F+2hryME7cDN6Beq2oGMTJR3O/ALBE59GGLBSn/+J4lWRwSasLpgDsh
	 IR1Mp3lPt/Kuy01kWcAe86wJZLjYDP2r287w1gWAA4+l36bOGfA24HpGx4iA5A0B1i
	 rS+vCyTrRJzFA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1sIX8H-004BDN-PL;
	Sat, 15 Jun 2024 18:24:05 +0100
Date: Sat, 15 Jun 2024 18:24:05 +0100
Message-ID: <86le36jf0q.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	tglx@linutronix.de,
	anna-maria@linutronix.de,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com,
	bhelgaas@google.com,
	rdunlap@infradead.org,
	vidyas@nvidia.com,
	ilpo.jarvinen@linux.intel.com,
	apatel@ventanamicro.com,
	kevin.tian@intel.com,
	nipun.gupta@amd.com,
	den@valinux.co.jp,
	andrew@lunn.ch,
	gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	alex.williamson@redhat.com,
	will@kernel.org,
	lorenzo.pieralisi@arm.com,
	jgg@mellanox.com,
	ammarfaizi2@gnuweeb.org,
	robin.murphy@arm.com,
	lpieralisi@kernel.org,
	nm@ti.com,
	kristo@kernel.org,
	vkoul@kernel.org,
	okaya@kernel.org,
	agross@kernel.org,
	andersson@kernel.org,
	mark.rutland@arm.com,
	shameerali.kolothum.thodi@huawei.com,
	yuzenghui@huawei.com
Subject: Re: [PATCH v3 14/24] genirq/gic-v3-mbi: Remove unused wired MSI mechanics
In-Reply-To: <20240614102403.13610-15-shivamurthy.shastri@linutronix.de>
References: <20240614102403.13610-1-shivamurthy.shastri@linutronix.de>
	<20240614102403.13610-15-shivamurthy.shastri@linutronix.de>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.2
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: shivamurthy.shastri@linutronix.de, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, tglx@linutronix.de, anna-maria@linutronix.de, shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, bhelgaas@google.com, rdunlap@infradead.org, vidyas@nvidia.com, ilpo.jarvinen@linux.intel.com, apatel@ventanamicro.com, kevin.tian@intel.com, nipun.gupta@amd.com, den@valinux.co.jp, andrew@lunn.ch, gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com, gregkh@linuxfoundation.org, rafael@kernel.org, alex.williamson@redhat.com, will@kernel.org, lorenzo.pieralisi@arm.com, jgg@mellanox.com, ammarfaizi2@gnuweeb.org, robin.murphy@arm.com, lpieralisi@kernel.org, nm@ti.com, kristo@kernel.org, vkoul@kernel.org, okaya@kernel.org, agross@kernel.org, andersson@kernel.org, mark.rutland@arm.com, shameerali.kolothum.thodi@huawei.com, yuzenghui@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Fri, 14 Jun 2024 11:23:53 +0100,
Shivamurthy Shastri <shivamurthy.shastri@linutronix.de> wrote:
> 
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Nothing builds a platform_device MSI domain for wire to MSI on top of
> this. The "regular" users of the platform MSI domain just provide their own
> irq_write_msi_msg() callback.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/irqchip/irq-gic-v3-mbi.c | 17 +----------------
>  1 file changed, 1 insertion(+), 16 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-mbi.c b/drivers/irqchip/irq-gic-v3-mbi.c
> index dbb8b1efda44..19298cc6c2ee 100644
> --- a/drivers/irqchip/irq-gic-v3-mbi.c
> +++ b/drivers/irqchip/irq-gic-v3-mbi.c
> @@ -199,31 +199,16 @@ static int mbi_allocate_pci_domain(struct irq_domain *nexus_domain,
>  }
>  #endif
>  
> -static void mbi_compose_mbi_msg(struct irq_data *data, struct msi_msg *msg)
> -{
> -	mbi_compose_msi_msg(data, msg);
> -
> -	msg[1].address_hi = upper_32_bits(mbi_phys_base + GICD_CLRSPI_NSR);
> -	msg[1].address_lo = lower_32_bits(mbi_phys_base + GICD_CLRSPI_NSR);
> -	msg[1].data = data->parent_data->hwirq;
> -
> -	iommu_dma_compose_msi_msg(irq_data_get_msi_desc(data), &msg[1]);
> -}
> -
>  /* Platform-MSI specific irqchip */
>  static struct irq_chip mbi_pmsi_irq_chip = {
>  	.name			= "pMSI",
> -	.irq_set_type		= irq_chip_set_type_parent,
> -	.irq_compose_msi_msg	= mbi_compose_mbi_msg,
> -	.flags			= IRQCHIP_SUPPORTS_LEVEL_MSI,
>  };
>  
>  static struct msi_domain_ops mbi_pmsi_ops = {
>  };
>  
>  static struct msi_domain_info mbi_pmsi_domain_info = {
> -	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
> -		   MSI_FLAG_LEVEL_CAPABLE),
> +	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
>  	.ops	= &mbi_pmsi_ops,
>  	.chip	= &mbi_pmsi_irq_chip,
>  };

This patch doesn't do what it says. It simply kills any form of level
MSI support for *endpoints*, and has nothing to do with any sort of
"wire to MSI".

What replaces it?

	M.

-- 
Without deviation from the norm, progress is not possible.


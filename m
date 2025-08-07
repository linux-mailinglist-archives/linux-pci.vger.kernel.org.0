Return-Path: <linux-pci+bounces-33533-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9308EB1D458
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 10:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 524606281F2
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 08:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394DE25394A;
	Thu,  7 Aug 2025 08:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYhUSCRn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2B9243378;
	Thu,  7 Aug 2025 08:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754555992; cv=none; b=Y9ElEN46Xp92Sf+aRlWNNf6srLLRMo6LI4Rs20c8VZihO3+VNI9Prmck497O1/b9GRVBMmq3l4ChHeQhnhh592F7jXci/DFPeo6eBgFd4K0izZwaPPa1kGqYgeYECmoJkQV2GYgRi6TqAZ4F+LVPchLhVnlUsW8csPb3ydciBng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754555992; c=relaxed/simple;
	bh=AJJPiy1agRwTpowv6EP+XoQUHx8R5qQZZKujEl0mnSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6DXhX1t1h5SABKVZbfQ2WQkTL5vY5yZlagVlbFjQgTxSKDGK6qHp/l623LXT06aAIzghmACW438+U6t72EGprHPa3J62VnnRNKJARTUQFZBdv6uxPd9e+9BGOatfuqh7vIvwCUk9ASTYg8zc8hxexi9lN66gv2xgOaKUYSFZY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYhUSCRn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE24C4CEEB;
	Thu,  7 Aug 2025 08:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754555991;
	bh=AJJPiy1agRwTpowv6EP+XoQUHx8R5qQZZKujEl0mnSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WYhUSCRnbFzRVQVuJl3VU70y9U0HGu8e/e6ji9e91TXFx6kNBt/05Di5eZKI6gkqS
	 ixEc/xQc33xfDrQ1lIm9GP7lTnkMPcuWznChsGwkY7psf1NzKgVCc6rW2BB43dOy3k
	 RqC6/zt2xVxOL1E1e2ltdkVPaiQQk2rlLmdGQm+27JIL6+L70KLKoHNz2TOAq2Skg/
	 3bO3z1z/Ke1K8WW5DM5OeELprOLf2fjvY8EN/AyGTrIB4Fti3VbWbTwU+m4K4CkrNA
	 2ok+6mcFtZwHcMg+RQS5VY5JpIVRLT3VSqgrEBuCJZNSBOG9YyUNlTcyBB+n9Y2uOY
	 sWHR1vpm9I/gg==
Date: Thu, 7 Aug 2025 14:09:43 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>, 
	Jonathan Derrick <jonathan.derrick@linux.dev>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kenneth Crudup <kenny@panix.com>, 
	Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: Re: [PATCH v2] PCI: vmd: Fix wrong kfree() in vmd_msi_free()
Message-ID: <rbwjykknpgx5hgu36t7ncxbs6kpq4a6ty2234velg5kt7ntq4v@5jkqysy62rch>
References: <20250807081051.2253962-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250807081051.2253962-1-namcao@linutronix.de>

On Thu, Aug 07, 2025 at 10:10:51AM GMT, Nam Cao wrote:
> vmd_msi_alloc() allocates struct vmd_irq and stashes it into
> irq_data->chip_data associated with the VMD's interrupt domain.
> vmd_msi_free() extracts the pointer by calling irq_get_chip_data() and
> frees it.
> 
> irq_get_chip_data() returns the chip_data associated with the top interrupt
> domain. This worked in the past, because VMD's interrupt domain was the top
> domain.
> 
> But since commit d7d8ab87e3e7 ("PCI: vmd: Switch to
> msi_create_parent_irq_domain()") changed the interrupt domain hierarchy,
> VMD's interrupt domain is not the top domain anymore. irq_get_chip_data()
> now returns the chip_data at the MSI devices' interrupt domains. It is
> therefore broken for vmd_msi_free() to kfree() this chip_data.
> 
> Fix this issue, correctly extract the chip_data associated with the VMD's
> interrupt domain.
> 
> Fixes: d7d8ab87e3e7 ("PCI: vmd: Switch to msi_create_parent_irq_domain()")
> Reported-by: Kenneth Crudup <kenny@panix.com>
> Closes: https://lore.kernel.org/linux-pci/dfa40e48-8840-4e61-9fda-25cdb3ad81c1@panix.com/
> Reported-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
> Closes: https://lore.kernel.org/linux-pci/ed53280ed15d1140700b96cca2734bf327ee92539e5eb68e80f5bbbf0f01@linux.gnuweeb.org/
> Tested-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
> Tested-by: Kenneth Crudup <kenny@panix.com>
> Signed-off-by: Nam Cao <namcao@linutronix.de>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
> v2: Fix typo and describe the change more precisely
> ---
>  drivers/pci/controller/vmd.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 9bbb0ff4cc15..b679c7f28f51 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -280,10 +280,12 @@ static int vmd_msi_alloc(struct irq_domain *domain, unsigned int virq,
>  static void vmd_msi_free(struct irq_domain *domain, unsigned int virq,
>  			 unsigned int nr_irqs)
>  {
> +	struct irq_data *irq_data;
>  	struct vmd_irq *vmdirq;
>  
>  	for (int i = 0; i < nr_irqs; ++i) {
> -		vmdirq = irq_get_chip_data(virq + i);
> +		irq_data = irq_domain_get_irq_data(domain, virq + i);
> +		vmdirq = irq_data->chip_data;
>  
>  		synchronize_srcu(&vmdirq->irq->srcu);
>  
> -- 
> 2.39.5
> 

-- 
மணிவண்ணன் சதாசிவம்


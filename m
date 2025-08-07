Return-Path: <linux-pci+bounces-33569-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DD1B1DBB5
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 18:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51F66721704
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 16:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BD21E51E1;
	Thu,  7 Aug 2025 16:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/qMeCmJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A945649641;
	Thu,  7 Aug 2025 16:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754584391; cv=none; b=FXh8RGIwfgI/Sbwio/Ob4nkM9ZJQe5F4zvnpNxqzwFrosnl7WWt5RpgyFFtIOXljm2PpfqeKRDXeALlKpvaGbw5mMRfBQjHWIUR04XrSHPeLbjr0VOFbGa/rz/tM6/vp96Kqv/QGxVShV3BJj4O4TaxMHp1a7O5gLTBJzifxjyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754584391; c=relaxed/simple;
	bh=R6wziohqzAyqWQcmIyLYK3UiENCAPnWGC1l3VgdV62c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KsT/X8Kc2p+lIKGXN434/i47oy3dabFSuYRiv/npRF7sRPDspHwwZCOTq+Pau6tUsni7+ecLXv1aXdL/wz+Sn5e4jsp/NeErKteS+0X1W4zTLF+LV5k/4E5Qp+Wdrm4hP6BX7ZSHWy2Fx1P3STYUytoRn4lNz69rFcxBE/BOJZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/qMeCmJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07425C4CEEB;
	Thu,  7 Aug 2025 16:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754584391;
	bh=R6wziohqzAyqWQcmIyLYK3UiENCAPnWGC1l3VgdV62c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=h/qMeCmJUufsgq3ilDl14k38h6fpZTXSOsKwgHIZ1qdRoi3/fQUnog2bYh3CC3CyZ
	 isUtYQ2rwEcWgx5lj2OQ6Shhqnk+5tV5J5STLRNjbRur6a9Z3juS1cJWZ7sBTXZucG
	 WUX3tERI7diE1NTUqicz4p29uTG6+BR1N8m/CW0xGIaq6OZdDYgpHGlSjab3ubITNh
	 /ZziDQn9bc3vBri7bcZn1fNjnFSSbSSPnHHLbxefIa9Uc1jAvig4bXUwoeMEGgO+21
	 /cvyelJTHcwSKslWNfX12x4l4DzcUsuRWnMRWpln5Q9XQ0vd+5dVLEKi7bsGMRyHgn
	 YJDTQyUsZRWcg==
Date: Thu, 7 Aug 2025 11:33:09 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kenneth Crudup <kenny@panix.com>,
	Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: Re: [PATCH v2] PCI: vmd: Fix wrong kfree() in vmd_msi_free()
Message-ID: <20250807163309.GA52078@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807081051.2253962-1-namcao@linutronix.de>

On Thu, Aug 07, 2025 at 10:10:51AM +0200, Nam Cao wrote:
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

Applied to pci/for-linus for v6.17, thanks!

I assume you checked the other msi_create_parent_irq_domain() changes
for similar problems?

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


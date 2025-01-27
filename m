Return-Path: <linux-pci+bounces-20399-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A2DA1D415
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jan 2025 11:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33DCB166531
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jan 2025 10:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944A51FDA7E;
	Mon, 27 Jan 2025 10:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YiDr9AGg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9841FDA84
	for <linux-pci@vger.kernel.org>; Mon, 27 Jan 2025 10:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737972472; cv=none; b=Tua/OCbtKcCeYqWyEwSxao3oFerZVeXl7AkRzD6JpP3G2fU8jxOIi8/UmRrZ8nEgUMCb6KbKPytbPgbUKm82hfthRGJq8ZiGBpWKGnIidGcOlG8uWKog5mQdULpVhpEJRObcmYHhvkAGz+VyVfjiR9t0P0BqJD3z7wosNtoKj2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737972472; c=relaxed/simple;
	bh=eL5/43sgCUlqrJSROK17HVYRRpMfXDtN+7cw1v/9OX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gf4X/LZW0nB8iRy0IsjPvRUzFscgH9eK3jrjtoqICRKWtbp9znA2HcSQZI3hxLqAtotVEePYbjHhGm+4Unv327i3T066lzDEuh/VEnYlAaSyVETqa5JelxA3UGYoz/hVnK0l7n+5QXYmWGUuoq8kUT/Cv79rvWTuK/siyTu/x6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YiDr9AGg; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2166360285dso69373765ad.1
        for <linux-pci@vger.kernel.org>; Mon, 27 Jan 2025 02:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737972470; x=1738577270; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=070oXrw6JzlQMhj9jx9C9mBIZS3mua+LEXrhoFmHLoo=;
        b=YiDr9AGg5K5plCy7smvTgyvGODhhTdB99pNZ+ixNNGKcEUPoYpffdlOxIV6yzZL4/f
         2uf7zR0FV6TeqeSV8Ask9Hq37mlvFGTrcZ06to6Qoqk64t2BLQDiMQ0gogai218IkyAm
         oRMGtAii+IdMsA8IyRI+LDlGNV8HWXqSYajDL5TK7ZqP2S4ls0fMaGzE2qSa4LQW5MFC
         gwFnaM5NSKKmFpOXG5NciKxKxZNhDYUp5HZWLKe1tfyLFNCpke7P+6/8XILVVVk+ppng
         JZafNafmxn62kiWRG1Cl7ICC9YMPGBmFzbfOSZLBLBeiL/xMDWKaQXEyZMUhzyHSfQW0
         GcGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737972470; x=1738577270;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=070oXrw6JzlQMhj9jx9C9mBIZS3mua+LEXrhoFmHLoo=;
        b=kPZrBweub59Ii/GO3VlqkCt+WP6ECQfI48NJb7ujKlNAeI34gBUn63P2LekUE0dDTZ
         s6YxwHS06srkhtCN82gjA9ifVhjPuKsBD8Qsfgpe3Bu9a4zUKZFK+IiAmK7ZK11qNH8x
         /G0IIGsI4DfhFzYaa+j5n1bAqSj3KrnJXuUdZIZyM7qEdbS73VawV77GRDDeiHS4jrKR
         wXEgZoJ4HslZ6dAqa4Mq8QmSzaiwtSVdKEq0dpgXWAPGTMJTuXAUWfMZ3YuAHIKkfWrS
         TuL6WZ0QgC9o6TdN47GCGkqGozODtQmPhkuwG794OX1lsV+mQNv3ELsvzYurzlo/T135
         krlg==
X-Forwarded-Encrypted: i=1; AJvYcCUHf2Qx/PJbe4QImR0OiXGKNq/T1PJcTlq2Q9gY5SUWQJfN4n889e9qlN4d5ZGPCAkTjn1cZ2xBAJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YybPN30Vn1d7rz9rSIRebc/XdkQja4FwxIXpIGR69HayA2jb/ZF
	SOZVkbyyXiRfW3JiRGj9ndE68HDDho52hPlJekI9jtgCL5ZNNC+J/heJcIdTbQ==
X-Gm-Gg: ASbGncuWqlxTudIBCaN/Y2TV39h13uElSops25qS6nwyHjbbcqdctHBw0mVLiwQJXi9
	RM0NAN56Z2dFLf6t92bt394+tg90wD2W8Octf37fz9FuN/WtCurp3vWuyTPVMbJ6AGnU42uVTYK
	nyOv6hIEw/ps+YPMGu1g9/WhNyhGVJzb/FBcBLJjxpdHFVBVnESVLDJVnvzkJFM9+G3S7gqD6Si
	TAiRUMtOzNH0cQr4UtUwDrqCRBaAtde+v9rv017EtZahBgVywYlc7ML7KkMKbBNIX+4alxVUi0K
	8Nbe+MTWedATgEI=
X-Google-Smtp-Source: AGHT+IHee6gZn25MWqnfAN2HN9vXXC5H6tQFag5Q+tJiCVAy9I4SFkdjChUG8SjSThBL4GQOPibqPA==
X-Received: by 2002:a17:902:c950:b0:215:7dbf:f3de with SMTP id d9443c01a7336-21c35558d37mr676086415ad.28.1737972469930;
        Mon, 27 Jan 2025 02:07:49 -0800 (PST)
Received: from thinkpad ([120.60.139.80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da3d9e1besm59681075ad.11.2025.01.27.02.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 02:07:49 -0800 (PST)
Date: Mon, 27 Jan 2025 15:37:40 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Daniel Tsai <danielsftsai@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: Separate MSI out to different controller
Message-ID: <20250127100740.fqvg2bflu4fpqbr5@thinkpad>
References: <20250115083215.2781310-1-danielsftsai@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250115083215.2781310-1-danielsftsai@google.com>

Subject needs to be improved. Something like,

PCI: dwc: Support IRQ affinity by assigning MSIs to supported MSI controller

On Wed, Jan 15, 2025 at 08:32:15AM +0000, Daniel Tsai wrote:
> From: Tsai Sung-Fu <danielsftsai@google.com>
> 
> Setup the struct irq_affinity at EP side,

What do you mean by 'EP side'?

> and passing that as 1 of the
> function parameter when endpoint calls pci_alloc_irq_vectors_affinity,
> this could help to setup non-default irq_affinity for target irq (end up
> in irq_desc->irq_common_data.affinity), and we can make use of that to
> separate msi vector out to bind to other msi controller.
> 

BY 'other msi controller' you mean the parent interrupt controller that is
chained by the DWC MSI controller?

> In current design, we have 8 msi controllers, and each of them own up to

Current design of what?

I believe that you guys at Google want to add support for your secret future
SoC, but atleast mention that in the patch descriptions. Otherwise, we don't
know whether the patch applies to currently submitted platforms or future ones.

> 32 msi vectors, layout as below
> 
> msi_controller0 <- msi_vector0 ~ 31
> msi_controller1 <- msi_vector32 ~ 63
> msi_controller2 <- msi_vector64 ~ 95
> .
> .
> .
> msi_controller7 <- msi_vector224 ~ 255
> 
> dw_pcie_irq_domain_alloc is allocating msi vector number in a contiguous
> fashion, that would end up those allocated msi vectors all handled by
> the same msi_controller, which all of them would have irq affinity in
> equal. To separate out to different CPU, we need to distribute msi
> vectors to different msi_controller, which require to allocate the msi
> vector in a stride fashion.
> 
> To do that, the CL make use the cpumask_var_t setup by the endpoint,

What is 'CL'?

> compare against to see if the affinities are the same, if they are,
> bind to msi controller which previously allocated msi vector goes to, if
> they are not, assign to new msi controller.
> 
> Signed-off-by: Tsai Sung-Fu <danielsftsai@google.com>
> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 80 +++++++++++++++----
>  drivers/pci/controller/dwc/pcie-designware.h  |  2 +
>  2 files changed, 67 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index d2291c3ceb8be..192d05c473b3b 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -181,25 +181,75 @@ static int dw_pcie_irq_domain_alloc(struct irq_domain *domain,
>  				    void *args)
>  {
>  	struct dw_pcie_rp *pp = domain->host_data;
> -	unsigned long flags;
> -	u32 i;
> -	int bit;
> +	const struct cpumask *mask;
> +	unsigned long flags, index, start, size;
> +	int irq, ctrl, p_irq, *msi_vec_index;
> +	unsigned int controller_count = (pp->num_vectors / MAX_MSI_IRQS_PER_CTRL);
> +
> +	/*
> +	 * All IRQs on a given controller will use the same parent interrupt,
> +	 * and therefore the same CPU affinity. We try to honor any CPU spreading
> +	 * requests by assigning distinct affinity masks to distinct vectors.
> +	 * So instead of always allocating the msi vectors in a contiguous fashion,
> +	 * the algo here honor whoever comes first can bind the msi controller to
> +	 * its irq affinity mask, or compare its cpumask against
> +	 * currently recorded to decide if binding to this msi controller.
> +	 */
> +
> +	msi_vec_index = kcalloc(nr_irqs, sizeof(*msi_vec_index), GFP_KERNEL);
> +	if (!msi_vec_index)
> +		return -ENOMEM;
>  
>  	raw_spin_lock_irqsave(&pp->lock, flags);
>  
> -	bit = bitmap_find_free_region(pp->msi_irq_in_use, pp->num_vectors,
> -				      order_base_2(nr_irqs));
> +	for (irq = 0; irq < nr_irqs; irq++) {
> +		mask = irq_get_affinity_mask(virq + irq);
> +		for (ctrl = 0; ctrl < controller_count; ctrl++) {
> +			start = ctrl * MAX_MSI_IRQS_PER_CTRL;
> +			size = start + MAX_MSI_IRQS_PER_CTRL;
> +			if (find_next_bit(pp->msi_irq_in_use, size, start) >= size) {
> +				cpumask_copy(&pp->msi_ctrl_to_cpu[ctrl], mask);
> +				break;

I don't see how this relates to the affinity setting of the parent interrupt
line that the MSI controller is muxed to. Here you are just copying the target
MSI affinity mask to the msi_ctrl_to_cpu[] array entry of the controller. And as
per the hierarchial IRQ domain implementation, DWC MSI cannot set the IRQ
affinity on its own and that's why MSI_FLAG_NO_AFFINITY flag is set in this
driver.

So I don't see how this patch is relevant. Am I missing something?

- Mani

> +			}
>  
> -	raw_spin_unlock_irqrestore(&pp->lock, flags);
> +			if (cpumask_equal(&pp->msi_ctrl_to_cpu[ctrl], mask) &&
> +			    find_next_zero_bit(pp->msi_irq_in_use, size, start) < size)
> +				break;
> +		}
>  
> -	if (bit < 0)
> -		return -ENOSPC;
> +		/*
> +		 * no msi controller matches, we would error return (no space) and
> +		 * clear those previously allocated bit, because all those msi vectors
> +		 * didn't really successfully allocated, so we shouldn't occupied that
> +		 * position in the bitmap in case other endpoint may still make use of
> +		 * those. An extra step when choosing to not allocate in contiguous
> +		 * fashion.
> +		 */
> +		if (ctrl == controller_count) {
> +			for (p_irq = irq - 1; p_irq >= 0; p_irq--)
> +				bitmap_clear(pp->msi_irq_in_use, msi_vec_index[p_irq], 1);
> +			raw_spin_unlock_irqrestore(&pp->lock, flags);
> +			kfree(msi_vec_index);
> +			return -ENOSPC;
> +		}
> +
> +		index = bitmap_find_next_zero_area(pp->msi_irq_in_use,
> +						   size,
> +						   start,
> +						   1,
> +						   0);
> +		bitmap_set(pp->msi_irq_in_use, index, 1);
> +		msi_vec_index[irq] = index;
> +	}
>  
> -	for (i = 0; i < nr_irqs; i++)
> -		irq_domain_set_info(domain, virq + i, bit + i,
> +	raw_spin_unlock_irqrestore(&pp->lock, flags);
> +
> +	for (irq = 0; irq < nr_irqs; irq++)
> +		irq_domain_set_info(domain, virq + irq, msi_vec_index[irq],
>  				    pp->msi_irq_chip,
>  				    pp, handle_edge_irq,
>  				    NULL, NULL);
> +	kfree(msi_vec_index);
>  
>  	return 0;
>  }
> @@ -207,15 +257,15 @@ static int dw_pcie_irq_domain_alloc(struct irq_domain *domain,
>  static void dw_pcie_irq_domain_free(struct irq_domain *domain,
>  				    unsigned int virq, unsigned int nr_irqs)
>  {
> -	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
> +	struct irq_data *d;
>  	struct dw_pcie_rp *pp = domain->host_data;
>  	unsigned long flags;
>  
>  	raw_spin_lock_irqsave(&pp->lock, flags);
> -
> -	bitmap_release_region(pp->msi_irq_in_use, d->hwirq,
> -			      order_base_2(nr_irqs));
> -
> +	for (int i = 0; i < nr_irqs; i++) {
> +		d = irq_domain_get_irq_data(domain, virq + i);
> +		bitmap_clear(pp->msi_irq_in_use, d->hwirq, 1);
> +	}
>  	raw_spin_unlock_irqrestore(&pp->lock, flags);
>  }
>  
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 347ab74ac35aa..95629b37a238e 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -14,6 +14,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/bitops.h>
>  #include <linux/clk.h>
> +#include <linux/cpumask.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/dma/edma.h>
>  #include <linux/gpio/consumer.h>
> @@ -373,6 +374,7 @@ struct dw_pcie_rp {
>  	struct irq_chip		*msi_irq_chip;
>  	u32			num_vectors;
>  	u32			irq_mask[MAX_MSI_CTRLS];
> +	struct cpumask		msi_ctrl_to_cpu[MAX_MSI_CTRLS];
>  	struct pci_host_bridge  *bridge;
>  	raw_spinlock_t		lock;
>  	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
> -- 
> 2.48.0.rc2.279.g1de40edade-goog
> 

-- 
மணிவண்ணன் சதாசிவம்


Return-Path: <linux-pci+bounces-1272-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4016081BE41
	for <lists+linux-pci@lfdr.de>; Thu, 21 Dec 2023 19:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D23E1C2438D
	for <lists+linux-pci@lfdr.de>; Thu, 21 Dec 2023 18:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DC1848C;
	Thu, 21 Dec 2023 18:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4f2BZSd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74B428E1
	for <linux-pci@vger.kernel.org>; Thu, 21 Dec 2023 18:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50e616ef769so1018473e87.1
        for <linux-pci@vger.kernel.org>; Thu, 21 Dec 2023 10:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703183611; x=1703788411; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v8cjikh7BWqrVOQ9qWfW7viyodcta5oKd81+zMFXVi8=;
        b=F4f2BZSdouCeQvbvsuPs45WZpAwn8U8HaK87dJkpQPk3ijshqaw13ek43bbmA4dMnc
         P53j0NDwSrAiYQkbz8An05sFKui49oUrLukCaHYXg5a0lrKkiwUSfKJArFAPfofnZ1bS
         PDS8Zh7kBwdZofqYOckLxWWaRYqNeju4U1LYnxPLxXjvz1OzABhM15rS2bkRjNEzkCn6
         H4PZp0uzaiyAqBxYfTcuybZAyKPulAN7vEfGE/JeONTGFKMDAkRFYhgKqI5XzgyIwp/+
         l1l1G021sZCz4X8Km7U4WhwphVKvWaR5DSOscja9Dhu3qCFhTR/uvDcQhU58bjTH6+26
         3JCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703183611; x=1703788411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v8cjikh7BWqrVOQ9qWfW7viyodcta5oKd81+zMFXVi8=;
        b=lcmBgHXVZmFhvuB6SSP4+BecDTIMLtiJIXym1UIifWl5djUNzOXXF8A9x8eLXhGU1Q
         HdF/fygMfSerfQ/lIE31gBRQWU6N3dHyJtW98Brq0o3WnXvc4RuXCyu7fCDS/jy3JlSX
         o4cDLIl5krG/epmlFjkwfdD3/G9LRjneiSskhhGd/dtp7FCxQApPda+fg6JJFRLVVzGW
         /olwnEdOiKZ3X+Y1G8eVu1ejxjfI2g8Gls90xaqAKPIiVcNIUMEoIYypE9ecmiLJwtzX
         8ZhWY8JQQMfcnyVZsJ7Ji4It6xB/+hv5F2ZqUOH3dbNf4iti/iShJLY9M5fNcyxcapCW
         nAcQ==
X-Gm-Message-State: AOJu0Yx/Uv7tvtkMyUs7mCmpMT1C4U4FJZTaLpH++LzhMUjUDGXtYccT
	SoDFaRi56d+tWTPveDu1VaTBsc9tb+9i4A==
X-Google-Smtp-Source: AGHT+IHa0xcR10FlGqAVdLVtcQwflE3XnBgralkFtdXGX3oO6JO4vB7wFBoA6LsuNo5xBf+om1vyrw==
X-Received: by 2002:ac2:4da1:0:b0:50e:5fd3:4d24 with SMTP id h1-20020ac24da1000000b0050e5fd34d24mr33718lfe.21.1703183610461;
        Thu, 21 Dec 2023 10:33:30 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id b25-20020ac25639000000b0050e62032216sm180418lff.204.2023.12.21.10.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 10:33:16 -0800 (PST)
Date: Thu, 21 Dec 2023 21:33:06 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Ajay Agarwal <ajayagarwal@google.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Manu Gautam <manugautam@google.com>, Sajid Dalvi <sdalvi@google.com>, 
	William McVicker <willmcvicker@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: Set DMA mask to 32 only if ZONE_DMA32 is
 enabled
Message-ID: <y64obwzmcwo2raskreebfyda4sofncnsedzvnh4xo2zrnchokl@ovv4mtqzl7xb>
References: <20231221174051.35420-1-ajayagarwal@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221174051.35420-1-ajayagarwal@google.com>

Hi Ajay

On Thu, Dec 21, 2023 at 11:10:51PM +0530, Ajay Agarwal wrote:
> If CONFIG_ZONE_DMA32 is disabled, then the dmam_alloc_coherent
> will fail to allocate the memory if there are no 32-bit addresses
> available. This will lead to the PCIe RC probe failure.
> Fix this by setting the DMA mask to 32 bits only if the kernel
> configuration enables DMA32 zone. Else, leave the mask as is.
> 
> Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 7991f0e179b2..163a78c5f9d8 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -377,10 +377,17 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
>  	 * Note until there is a better alternative found the reservation is
>  	 * done by allocating from the artificially limited DMA-coherent
>  	 * memory.
> +	 *
> +	 * Set the coherent DMA mask to 32 bits only if the DMA32 zone is
> +	 * supported. Otherwise, leave the mask as is.
> +	 * This ensures that the dmam_alloc_coherent is successful in
> +	 * allocating the memory.
>  	 */
> +#ifdef CONFIG_ZONE_DMA32
>  	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
>  	if (ret)
>  		dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
> +#endif

Without setting the mask the allocation below may cause having MSI
data from above 4GB which in its turn will cause MSI not working for
peripheral PCI-devices supporting 32-bit MSI only. That's the gist of
this questionable code above and below.

The discussion around it can be found here:
https://lore.kernel.org/linux-pci/20220825185026.3816331-2-willmcvicker@google.com
and a problem similar to what you described was reported here:
https://lore.kernel.org/linux-pci/decae9e4-3446-2384-4fc5-4982b747ac03@yadro.com/

The easiest solution in this case is to somehow pre-define
pp->msi_data with a PCI-bus address free from RAM behind and avoid
allocation below at all. The only question is how to do that. See the
discussions above for details.

-Serge(y)

>  
>  	msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
>  					GFP_KERNEL);
> -- 
> 2.43.0.195.gebba966016-goog
> 
> 


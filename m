Return-Path: <linux-pci+bounces-27564-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E57D2AB302D
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 09:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5156F189AF96
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 07:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A3419F121;
	Mon, 12 May 2025 07:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LrRyrH4v"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362C32561B7
	for <linux-pci@vger.kernel.org>; Mon, 12 May 2025 07:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747033210; cv=none; b=bfxxmdCvJNXsFhiIajNdQNtX7Q9rWHQXhivnS2WF7cwp6kqU1o/l3P6aLwjDDyqpk0ROtXDDhGrn3UcX/uxIlnscqyXf4KuU+Oea5Hm5Zqg7PxXS+pWjltT4jZh02Y03cUlphIhKUQhsCa5jzfJ4G6G9UynB60ttLgjnLR1O+1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747033210; c=relaxed/simple;
	bh=Bqq1A3Sa6qHoWnzKdhLS1uicwJ9gxYebr4/OhwLudB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DPg32Zm0ITF+UycUpahhC81byLPsolQICjyxAgxeV6P9A21uvoPTOqmCWQ8vh0QIeSpzSHx8FT0/qo1wtdAexLcwSb8+uYDLH3LAIvg6fUyoMQmLtyBBmsDDAg4J3OjM4L6/mCHlp2kynXknS7g/dqPqGziKkcAoGpY5yXxP7pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LrRyrH4v; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cf848528aso35142795e9.2
        for <linux-pci@vger.kernel.org>; Mon, 12 May 2025 00:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747033206; x=1747638006; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f9NnMsqvqzW4Dp+QMCFVbmE2fyembB/PnH3RgqpZhfQ=;
        b=LrRyrH4vsevmMD2hAXOiENfRTMFTaQxc0n6C9fRY3af7C0IDgC+FEXjaMpHyiTXg4d
         W3797QZ7ZhZGTQUlHFCG8JcqKmvpBE4n3MuaBizsSiArrI7NEju1PAp7PwXhqMECQ5w7
         mZzYfESREY/IAzPGDk5c0n40l/Vpin45AuhXFpDVTjbUUxcIy2hPNqGm0C6ATMathILL
         kvTKeOqckeehFzAbe8B3vY3zlH/TlOkGQ1rKlvG79xg70h1eq3m9/bxxnzwE4BVhQpe4
         S1WRjAWdXonNVqFUmJRXWq2nv+DqhZL0vjR91CpE4d4uuQcUOt7IIX74G81r66LV2oSG
         iyUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747033206; x=1747638006;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f9NnMsqvqzW4Dp+QMCFVbmE2fyembB/PnH3RgqpZhfQ=;
        b=AnuQ1aW21CT5g9wgtse9RxBoLtUmM+/GKuiHz7VxK/xRfYfNpLsu1ymJZ22exxu/3Y
         GhaeikgTgBi7D7W1cYnxuWcXcPthHI7FqWg/dO2zEsCm9+lVSaUbEkZ5otiEcKEMCK4h
         dXKIRCe1I/o76v3zXZFW/Y65ktd4wNXracKlFw1E2N87J3nu0+Z7HmN6g40jWSSJDvkn
         YZ7KHjh2koSJstav6+n3JYNPBebqa/wD94Z6CjQwhUO0IBIe9DpzdHzwlzCHZWdNo18W
         hu592WAsafpHu29RHADEVy033tSNQmlu1FNYmUEqfS11b0vxABMQNHr7XypX4RC1KMoJ
         JmWw==
X-Forwarded-Encrypted: i=1; AJvYcCXYdhID6XS4ZTL+5RpCEysTN71DKdm7NwjkEKf+hqfh7ObEb89rjSsPOBpPIpcFpGH2dZySdyOb5t0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK8f9H3JCS1h+ua2GPTVji7G9sevFuolexJyAV7rWecBA4jbvt
	+Y2iI+w+gkSAOjyqIpw1DRzcPmfxYr0342kzmLxhBz4+zWajVqTrrr/clVbckg==
X-Gm-Gg: ASbGncuGVlTiHZcBYfcS/s2caU3cB/svj0Fu/67O8//XRFKLBtCzv2aHSXkyt/tuV7K
	rxlatFfxEnwUj7cQvzrp2Gl7+B6TDdc/WhJ37qR5AlG/RMtbE1zM8yv+APnHeaiB4KykfBYi2Ir
	wmrI1uVKBEUdRnFQS8yJE2XJ+jonMVJ4zCgGJ2Mt8P7KhLyr1DFEwiAkyHhgTNyD9Pl3jGS1t12
	MRGvu1z1dMXFTpo6DBgCjXzvM99MtnU1RWhVVKPkWleVo+sQAfMXnbtYw2gtEBqzKGamdxOLKnD
	HeFxsE+hzyRYJ1MC2Fqtxnavk889L19dkKq0VmWIJWuejnvEEoASjWL9S69aLnvUSbpzqG++kA=
	=
X-Google-Smtp-Source: AGHT+IF0taVe2Cjr6rPU4zVe3n0h7u5iibv2A6s+QVlkQE644yCZv4nsG7uDfUXl8mm25LJJmLR7mg==
X-Received: by 2002:a05:600c:511f:b0:43d:4686:5cfb with SMTP id 5b1f17b1804b1-442d6de2e97mr85863985e9.27.1747033206152;
        Mon, 12 May 2025 00:00:06 -0700 (PDT)
Received: from thinkpad ([130.93.163.156])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd3aeb79sm157284445e9.27.2025.05.12.00.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 00:00:05 -0700 (PDT)
Date: Mon, 12 May 2025 12:30:04 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=EF=BF=BD~Dski?= <kw@linux.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Haiyang Zhang <haiyangz@microsoft.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nipun Gupta <nipun.gupta@amd.com>, Yury Norov <yury.norov@gmail.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Cameron <Jonathan.Cameron@huwei.com>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Kevin Tian <kevin.tian@intel.com>, 
	Long Li <longli@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Konstantin Taranov <kotaranov@microsoft.com>, 
	Simon Horman <horms@kernel.org>, Leon Romanovsky <leon@kernel.org>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Erni Sri Satya Vennela <ernis@linux.microsoft.com>, 
	Peter Zijlstra <peterz@infradead.org>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	Paul Rosswurm <paulros@microsoft.com>, Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH v3 2/4] PCI: hv: Allow dynamic MSI-X vector allocation
Message-ID: <plrpscito5e76t4dvtukgqm724stsfxim3zv3xqwnjewenee53@72dipu3yunlr>
References: <1746785566-4337-1-git-send-email-shradhagupta@linux.microsoft.com>
 <1746785602-4600-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1746785602-4600-1-git-send-email-shradhagupta@linux.microsoft.com>

On Fri, May 09, 2025 at 03:13:22AM -0700, Shradha Gupta wrote:
> Allow dynamic MSI-X vector allocation for pci_hyperv PCI controller
> by adding support for the flag MSI_FLAG_PCI_MSIX_ALLOC_DYN and using
> pci_msix_prepare_desc() to prepare the MSI-X descriptors.
> 
> Feature support added for both x86 and ARM64
> 
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  Changes in v3:
>  * Add arm64 support
> ---
>  Changes in v2:
>  * split the patch to keep changes in PCI and pci_hyperv controller
>    seperate
>  * replace strings "pci vectors" by "MSI-X vectors"
> ---
>  drivers/pci/controller/pci-hyperv.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index ac27bda5ba26..8c8882cb0ad2 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -598,7 +598,8 @@ static unsigned int hv_msi_get_int_vector(struct irq_data *data)
>  	return cfg->vector;
>  }
>  
> -#define hv_msi_prepare		pci_msi_prepare
> +#define hv_msi_prepare			pci_msi_prepare
> +#define hv_msix_prepare_desc		pci_msix_prepare_desc

Please do not use custom macro unless its defintion changes based on some
conditional. In this case, you should use pci_msix_prepare_desc directly for
prepare_desc() callback.

- Mani

--
மணிவண்ணன் சதாசிவம்


Return-Path: <linux-pci+bounces-1732-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F07825F5D
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jan 2024 12:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D9DD1F226B4
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jan 2024 11:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60976FB5;
	Sat,  6 Jan 2024 11:39:28 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477066FA4;
	Sat,  6 Jan 2024 11:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3bbc7746812so433939b6e.2;
        Sat, 06 Jan 2024 03:39:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704541166; x=1705145966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4aBvxAPfagC6kuMJsXEP+HsUh4f67uuppDzujaVx5Y=;
        b=UoP9JHOQCGlnGApUEhhV0DFfHDDy2IxW4ZhR9m/34ESOnXJGdIS0NAl5F/kRnk0M1V
         p4w1I5iuk5cZE/4FYdJBiJxxIdRAhJK7McwArnjWKIrwV7m0PzXtgWYicGHe4eEfsdZw
         iFMNs8QF6K1VOxvmQ2A39Zzs/cwat+/5qjKLU49ftUP0bvVRU5tWCabwbAG+v3lV4kz2
         Dfx1Iqa1zrfwarEx9vdg8vOWXs9y7I2VEjdHowaP0qP3EyWhCltmDhWJLoXeSWpMGuoU
         GT3ozqIUpvLvD1Hrmx31/h8j/1BEfR1X9R592EiXsIByDw5h0VKMegnXX9a2ihqKuw+h
         7aCw==
X-Gm-Message-State: AOJu0YxUdvSg7b1lv/CfswJaQ9sXPenSS9x7JshG6rv/da5EhPoq0b7m
	t9LDKquRAMT1hMwlEw8jyls=
X-Google-Smtp-Source: AGHT+IHtt7Ebhm64abLBP+hiZj3KfFPWNDsN+KAlSQP0xK1nAEoWCbzhDv2unHiitrskCWf22gjd1Q==
X-Received: by 2002:a05:6808:f8a:b0:3bd:21f5:4889 with SMTP id o10-20020a0568080f8a00b003bd21f54889mr531743oiw.5.1704541166284;
        Sat, 06 Jan 2024 03:39:26 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id w6-20020aa78586000000b006d9b38f2e75sm2894625pfn.32.2024.01.06.03.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 03:39:25 -0800 (PST)
Date: Sat, 6 Jan 2024 20:39:23 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Michal Simek <michal.simek@amd.com>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, dan.carpenter@linaro.org,
	kernel-janitors@vger.kernel.org, error27@gmail.com
Subject: Re: [PATCH next] PCI: xilinx-xdma: Fix error code in
 xilinx_pl_dma_pcie_init_irq_domain()
Message-ID: <20240106113923.GA3450972@rocinante>
References: <20231030072757.3236546-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030072757.3236546-1-harshit.m.mogalapalli@oracle.com>

Hello,

> Return -ENOMEM instead of zero(success) when it fails to get IRQ domain.
> 
> Fixes: 8d786149d78c ("PCI: xilinx-xdma: Add Xilinx XDMA Root Port driver")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> This is found with smatch and the patch is only compile tested.
> ---
>  drivers/pci/controller/pcie-xilinx-dma-pl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-xilinx-dma-pl.c b/drivers/pci/controller/pcie-xilinx-dma-pl.c
> index 2f7d676c683c..52f3211d11cd 100644
> --- a/drivers/pci/controller/pcie-xilinx-dma-pl.c
> +++ b/drivers/pci/controller/pcie-xilinx-dma-pl.c
> @@ -576,7 +576,7 @@ static int xilinx_pl_dma_pcie_init_irq_domain(struct pl_dma_pcie *port)
>  						  &intx_domain_ops, port);
>  	if (!port->intx_domain) {
>  		dev_err(dev, "Failed to get a INTx IRQ domain\n");
> -		return PTR_ERR(port->intx_domain);
> +		return -ENOMEM;
>  	}

This looks good.

However, there is probably another issue here on the failure path.  I don't
see any of_node_put() to release the pcie_intc_node taken at the top of the
xilinx_pl_dma_pcie_init_irq_domain() function.

I would imagine a similar approach to the error handling as what we can see
from xilinx_cpm_pcie_init_irq_domain() function in the older driver.

Thippeswamy, can you have a look and see if this can be improved?  I would
love to get a fix before Bjorn sends a Pull Request for the next release.

	Krzysztof


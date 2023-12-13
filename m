Return-Path: <linux-pci+bounces-900-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFCC811D4A
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 19:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C94A91F21998
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 18:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986105EE9E;
	Wed, 13 Dec 2023 18:48:34 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434FBE4;
	Wed, 13 Dec 2023 10:48:32 -0800 (PST)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d35dc7e1bbso5244025ad.1;
        Wed, 13 Dec 2023 10:48:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702493311; x=1703098111;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mgP80Yyu6IvFK797HjxiOfl5XynuTDj7ZNa6KXUx8cI=;
        b=ktdZTHfwEv+bA0TgZ7zJGQ8ma2s5oIYtrDSMYzYfwLPl7Sv6M+Vy/b695rFLtpSf+v
         H/co8NvXeq+MTPJnZD6BPRP35qrqpyxE/fnVqfTylTnPVuMm4gJzxHSSI3+loyGyCkcX
         R9BWPvOeQHkwwcOzkUuZ9Juu5WzUyMZClKwp2FhaIK1YQdwS5PYDQeN6uCsdtG3H3Vie
         gzGkN8wcqnCfkyCo1WxOlkwEtcrUaCYzecN0RUDk8h55uNzmyMLHqt1fhfBREWkBYc+Z
         tpICZoPzhkbkGG8RHq40kTgUOiqPGRB8S4HlDmUxJg4wP4/XoCezZpLtNR5Gbiq+S+h9
         VMhA==
X-Gm-Message-State: AOJu0Yz/s7kDI93cS9qBp3yWZF3cs6i9n4VOKKVYamQl/3ICoxYocCK8
	meKvKazUd68H0N99whfW/z0=
X-Google-Smtp-Source: AGHT+IEzlIEd9Q6eLCCZLjW8OK193jqfOJ0Gqr0iKW0nJNMRppuRTXGR720gnDCd+2nqnislHC1Peg==
X-Received: by 2002:a17:902:ec8a:b0:1d0:d18c:bc5a with SMTP id x10-20020a170902ec8a00b001d0d18cbc5amr10203494plg.121.1702493311471;
        Wed, 13 Dec 2023 10:48:31 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id t14-20020a1709027fce00b001cf8c062610sm11107415plb.127.2023.12.13.10.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 10:48:30 -0800 (PST)
Date: Thu, 14 Dec 2023 03:48:29 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: lpieralisi@kernel.org, kishon@kernel.org, bhelgaas@google.com,
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] PCI: epf-mhi: Enable MHI async read/write support
Message-ID: <20231213184829.GA924726@rocinante>
References: <20231127124529.78203-1-manivannan.sadhasivam@linaro.org>
 <20231127124529.78203-7-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231127124529.78203-7-manivannan.sadhasivam@linaro.org>

Hello,

Manivannan, you will be taking this through the MHI tree, correct?

> Now that both eDMA and iATU are prepared to support async transfer, let's
> enable MHI async read/write by supplying the relevant callbacks.
> 
> In the absence of eDMA, iATU will be used for both sync and async
> operations.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/endpoint/functions/pci-epf-mhi.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> index 3d09a37e5f7c..d3d6a1054036 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> @@ -766,12 +766,13 @@ static int pci_epf_mhi_link_up(struct pci_epf *epf)
>  	mhi_cntrl->raise_irq = pci_epf_mhi_raise_irq;
>  	mhi_cntrl->alloc_map = pci_epf_mhi_alloc_map;
>  	mhi_cntrl->unmap_free = pci_epf_mhi_unmap_free;
> +	mhi_cntrl->read_sync = mhi_cntrl->read_async = pci_epf_mhi_iatu_read;
> +	mhi_cntrl->write_sync = mhi_cntrl->write_async = pci_epf_mhi_iatu_write;
>  	if (info->flags & MHI_EPF_USE_DMA) {
>  		mhi_cntrl->read_sync = pci_epf_mhi_edma_read;
>  		mhi_cntrl->write_sync = pci_epf_mhi_edma_write;
> -	} else {
> -		mhi_cntrl->read_sync = pci_epf_mhi_iatu_read;
> -		mhi_cntrl->write_sync = pci_epf_mhi_iatu_write;
> +		mhi_cntrl->read_async = pci_epf_mhi_edma_read_async;
> +		mhi_cntrl->write_async = pci_epf_mhi_edma_write_async;
>  	}

Looks good!

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

	Krzysztof


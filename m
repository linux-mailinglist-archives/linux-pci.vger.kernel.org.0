Return-Path: <linux-pci+bounces-1012-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40373813AD5
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 20:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7277C1C20D02
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 19:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527A669794;
	Thu, 14 Dec 2023 19:35:26 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1B768B98;
	Thu, 14 Dec 2023 19:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-58df5988172so5525759eaf.0;
        Thu, 14 Dec 2023 11:35:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702582523; x=1703187323;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iiR1aavtw7vArPnIPdT1sVPg3JZoC8VIGjwfufazkGQ=;
        b=e95qb7PtP8Q58av97i3tG2kLALEme2kdQeDRy0mSNHJ1LwjgNIiwHRJFH8GPfSvx18
         1r8qeOxZuu5NGEZ2t7APsuy6YvH6B+nmQIZhbZ9XPt9sJKV3fUdtjh2FYepWCFtwqZgz
         MOrsSbx3a5xda1Iv2X2H87YMtXRXawDHmFj84isZM7becCezye9Sz7M3buQZMb4dVVbG
         WM2NqzMHuz496WIurC1WKPdGeBYPcVMq7CzVf7aY+7c/ECzmow5jKTnSoPUzRfYkGDj1
         uq5YUMmg0jfXT7OtVRCTmkkBYP5spS3CTLrX0O4i6l7di//9xWQPwCyVVxQi0WvDXJJD
         WG0g==
X-Gm-Message-State: AOJu0YzTpUTw+MOnCgs8Pvmw49sRymlY0zNRga3iC8DwOFS2j8H7WT62
	vScdp8NqDCnwakaSDh0O6TfCHxjm6uisYkA1
X-Google-Smtp-Source: AGHT+IH7vqScE0kZe88g0sxyvnMj8xa9jTh9cSHu9m3GZT/ciag+w7PInjd+itvmhYZiWmWyBphbZg==
X-Received: by 2002:a05:6358:5e11:b0:16e:508e:1706 with SMTP id q17-20020a0563585e1100b0016e508e1706mr15025215rwn.25.1702582522873;
        Thu, 14 Dec 2023 11:35:22 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id y2-20020a655282000000b00588e8421fa8sm10434729pgp.84.2023.12.14.11.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 11:35:22 -0800 (PST)
Date: Fri, 15 Dec 2023 04:35:21 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: lpieralisi@kernel.org, bhelgaas@google.com, kishon@kernel.org,
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: epf-mhi: Fix the DMA data direction of
 dma_unmap_single()
Message-ID: <20231214193521.GA2147106@rocinante>
References: <20231214063328.40657-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231214063328.40657-1-manivannan.sadhasivam@linaro.org>

Hello,

> In the error path of pci_epf_mhi_edma_write() function, the DMA data
> direction passed (DMA_FROM_DEVICE) doesn't match the actual direction used
> for the data transfer. Fix it by passing the correct one (DMA_TO_DEVICE).

Nice catch!

> Fixes: 7b99aaaddabb ("PCI: epf-mhi: Add eDMA support")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
> 
> Bjorn, Krzysztof, I'd like to apply this patch to MHI tree on top of eDMA
> async patches due to dependency:
> https://lore.kernel.org/linux-pci/20231127124529.78203-1-manivannan.sadhasivam@linaro.org/

Sounds good to me!  We still have a little time, so let me know if you
change your mind about who should take this patch and the other series. :)

>  drivers/pci/endpoint/functions/pci-epf-mhi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> index 472bc489b754..d3d6a1054036 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> @@ -424,7 +424,7 @@ static int pci_epf_mhi_edma_write(struct mhi_ep_cntrl *mhi_cntrl,
>  	}
>  
>  err_unmap:
> -	dma_unmap_single(dma_dev, src_addr, buf_info->size, DMA_FROM_DEVICE);
> +	dma_unmap_single(dma_dev, src_addr, buf_info->size, DMA_TO_DEVICE);
>  err_unlock:
>  	mutex_unlock(&epf_mhi->lock);

Looks good!

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

	Krzysztof


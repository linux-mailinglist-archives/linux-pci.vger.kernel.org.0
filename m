Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B3C633E38
	for <lists+linux-pci@lfdr.de>; Tue, 22 Nov 2022 14:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbiKVN4A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Nov 2022 08:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbiKVNz7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Nov 2022 08:55:59 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A4567F49
        for <linux-pci@vger.kernel.org>; Tue, 22 Nov 2022 05:55:58 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id g62so14414751pfb.10
        for <linux-pci@vger.kernel.org>; Tue, 22 Nov 2022 05:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yfTOQwrrcPpkrDlf5AiVxig6mnCOgOA2GN9rJdoHhPA=;
        b=ODNsLVJ8fAT1RlWHmW4dMx9bHa2yzInu2BdbuIbnbv9s/RLQ6XMWzhhHocxKANR+H2
         /lS3pt8vRihLOXlyj7/I3ZL0sk47MELMzlhUf8rCCOSdfN0+okOZsdpyeIxzdEk4HuoZ
         jnrPlZVI2ZY8/RDnR3bF7xxfn0CzzB073MvyvadIIbojGPqawV4vLLCsODlZUf96ej6u
         SZFx8SzacV7Dd5GnNc1kHKC7Bbg/85DVbgeVl6zV50i0MNKMYdPubT5Xo+bPWZbv2Wlk
         Em9dGgk+adwIz2CyaMCj+e8bGJB0IarG9xnONkf+SCHT01a0lH7bUj8Qr73AIhB3U6Al
         eh7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yfTOQwrrcPpkrDlf5AiVxig6mnCOgOA2GN9rJdoHhPA=;
        b=bUftjiuCSJcWy0QB5G3OxDlIaa6mX/bvN+XibGrVL4YsKyKjZuT4yAQrriO4xe6gv0
         cAOg8NtIBaANtb6Tr0xFdIj0JGKKjhmqkrB6Jizyaawh80VO76ebFrhWLVna/FFjhFza
         AQvp9ti2vHAPqrQaYKT17H3w7MLkhwK/mB6R6ebME3/Q399TQtI9DjPSAv96YonMyuxI
         yBhrJ7WS7zpJ+f1AhPTm0TvX+Txl0mfqN5mg7GWxVCm3grMqtnuGSZKSAL9ZPFTV3N03
         zLhaB4pMS+F/tiDnbAdoQp1hyn0+JOyisRLscss6fdpCIC8GhPcUV9Ht4aGAOm3jUgeB
         D0Pw==
X-Gm-Message-State: ANoB5pm4hSRYGtF4a0VivGGQcs7MZxlJyKkVlw6bSvqfLhr07gfrjb7P
        rCGqck/cflutu5i4LrX6NJBO
X-Google-Smtp-Source: AA0mqf7vdyeNuz6rQCI3cxxJYL9kYFQBG7ovuALu6oqJ5NJSdY+RgjWdUAbZR80KavjWS6cKtwRlqA==
X-Received: by 2002:a63:110d:0:b0:46f:6225:c2f9 with SMTP id g13-20020a63110d000000b0046f6225c2f9mr22148675pgl.225.1669125357907;
        Tue, 22 Nov 2022 05:55:57 -0800 (PST)
Received: from thinkpad ([59.92.98.84])
        by smtp.gmail.com with ESMTPSA id r12-20020a63e50c000000b00476dc914262sm9271620pgh.1.2022.11.22.05.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 05:55:56 -0800 (PST)
Date:   Tue, 22 Nov 2022 19:25:50 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, krzk+dt@kernel.org,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        fancer.lancer@gmail.com, Sergey.Semin@baikalelectronics.ru
Subject: Re: [PATCH v7 5/9] PCI: dwc: Avoid reading a register to detect
 whether eDMA exists
Message-ID: <20221122135550.GD157542@thinkpad>
References: <20221121124400.1282768-1-yoshihiro.shimoda.uh@renesas.com>
 <20221121124400.1282768-6-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221121124400.1282768-6-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+ Serge (who authored EDMA support)

Thanks,
Mani

On Mon, Nov 21, 2022 at 09:43:56PM +0900, Yoshihiro Shimoda wrote:
> Since reading value of PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL was
> 0x00000000 on one of SoCs (R-Car S4-8), it cannot find the eDMA.
> So, directly read the eDMA register if edma.reg_base is not zero.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 637d01807c67..2cc8584da6f4 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -836,8 +836,7 @@ static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
>  {
>  	u32 val;
>  
> -	val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
> -	if (val == 0xFFFFFFFF && pci->edma.reg_base) {
> +	if (pci->edma.reg_base) {
>  		pci->edma.mf = EDMA_MF_EDMA_UNROLL;
>  
>  		val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
> @@ -845,6 +844,7 @@ static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
>  		pci->edma.mf = EDMA_MF_EDMA_LEGACY;
>  
>  		pci->edma.reg_base = pci->dbi_base + PCIE_DMA_VIEWPORT_BASE;
> +		val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
>  	} else {
>  		return -ENODEV;
>  	}
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

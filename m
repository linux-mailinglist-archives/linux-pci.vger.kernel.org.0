Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C39525134
	for <lists+linux-pci@lfdr.de>; Thu, 12 May 2022 17:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355899AbiELPYN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 May 2022 11:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355586AbiELPYJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 May 2022 11:24:09 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DA220E0BB
        for <linux-pci@vger.kernel.org>; Thu, 12 May 2022 08:24:07 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id j10-20020a17090a94ca00b001dd2131159aso8171101pjw.0
        for <linux-pci@vger.kernel.org>; Thu, 12 May 2022 08:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wZ9fK0uQcOXF6KZtm59SA3PoAaj1ZmZIPuDsmvsxhvg=;
        b=unjy7OVrAJK4B5ZZwpszk8c42gcbCTZgQFBDKY4t7RLDiFhFmikPpcG8zNSa1GwW5g
         ZIpWe81H65ezBUGZeF4/30DZO86VLz2XykWOM+X/ldd9HU4QnaJomJua37FhCYO9VkVb
         K2dR7J9Ic9/jUaeMUxfjf/CsLznV0kJ0iJ+oSGu5uatF4Gh6MHB3FL4A984AtktbgSgs
         xlfEnlC47yD3wREAXLPwjChwLzBsR6jb/Dp8Us6uLGcxxbJcFhw1xwf3TXlJoGystAvs
         XAAyxhOg51ZWFLF4XtjGcybqLLKU2X0gqARb1WRxDdi2yq9Sz5OCcnKTL5g3HRZISYu0
         imHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wZ9fK0uQcOXF6KZtm59SA3PoAaj1ZmZIPuDsmvsxhvg=;
        b=ycekJ8eZjtivviNJs885itrWV5eIZ/REoBvegg9AWclxy0GoHCwJCqiOkdLzQJYLuI
         yGHMQL1p8Hi9VrO4WFACesUIfJScnxyn1P84UPCmciHbY58wWNJduURlFQN5EytVydCz
         oO/yQMBlChj14qslpoSmgYSH+jRNog2iLx79D1RU79g7F21kDEQ2Xf+WpXJJ24vG4wX2
         giPUVMBhXZA+iUsNLSoh9HzbnlkpvYp3UB/2SVPDei0CRuFWSGqoz2oGIGuIE9VDsvHg
         Z5Lyu5nQk7picNuBxbSURrGiKOaOehtd4n3hOa+p9i25RP2ne+LqIDSEaaMQ/8ajlNva
         8Ndg==
X-Gm-Message-State: AOAM533md1os1Gknx9hkw0o0G4MpDxon/9HwnO8Sw6U5BbUW2JfB7tRy
        N6EEeMDCWoMHclVT1w1XNfbe
X-Google-Smtp-Source: ABdhPJx5cgDgJuvo7bgLaWkO/6wh4Oa6GVVr7CBUY0HZkyXteomni4vqivunBkH4hPeIlnCdePTC8A==
X-Received: by 2002:a17:902:7d86:b0:15e:b761:3ca6 with SMTP id a6-20020a1709027d8600b0015eb7613ca6mr128925plm.56.1652369046791;
        Thu, 12 May 2022 08:24:06 -0700 (PDT)
Received: from thinkpad ([117.202.184.202])
        by smtp.gmail.com with ESMTPSA id p11-20020a170902e74b00b0015e8d4eb1d8sm71070plf.34.2022.05.12.08.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 08:24:04 -0700 (PDT)
Date:   Thu, 12 May 2022 20:53:54 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Frank Li <Frank.Li@nxp.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 24/26] dmaengine: dw-edma: Skip cleanup procedure if
 no private data found
Message-ID: <20220512152354.GO35848@thinkpad>
References: <20220503225104.12108-1-Sergey.Semin@baikalelectronics.ru>
 <20220503225104.12108-25-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220503225104.12108-25-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 04, 2022 at 01:51:02AM +0300, Serge Semin wrote:
> DW eDMA driver private data is preserved in the passed DW eDMA chip info
> structure. If either probe procedure failed or for some reason the passed
> info object doesn't have private data pointer initialized we need to halt
> the DMA device cleanup procedure in order to prevent possible system
> crashes.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

As I said in the previous iteration, I'm not sure we will hit this issue.
But I don't object the patch. So,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/dma/dw-edma/dw-edma-core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index 908607785401..561686b51915 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -1035,6 +1035,10 @@ int dw_edma_remove(struct dw_edma_chip *chip)
>  	struct dw_edma *dw = chip->dw;
>  	int i;
>  
> +	/* Skip removal if no private data found */
> +	if (!dw)
> +		return -ENODEV;
> +
>  	/* Disable eDMA */
>  	dw_edma_v0_core_off(dw);
>  
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்

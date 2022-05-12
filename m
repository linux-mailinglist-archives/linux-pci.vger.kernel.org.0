Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B45052506E
	for <lists+linux-pci@lfdr.de>; Thu, 12 May 2022 16:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354555AbiELOl4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 May 2022 10:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355489AbiELOlz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 May 2022 10:41:55 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FA0633A6
        for <linux-pci@vger.kernel.org>; Thu, 12 May 2022 07:41:53 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id i1so5064022plg.7
        for <linux-pci@vger.kernel.org>; Thu, 12 May 2022 07:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=THMV7qBfGHCnlJOjQih5vLNyRsOAcoDzGxFt208dGu4=;
        b=UbWumBa7yY1Xw+NaPBUMufOeoJu1dgpBoySaGRRBs71aEpKas6Ce/MWMDlAxgrUro0
         UAIZ8Nwjob2jBkbaJ904XL1JgX3FJTmnblKLBXM0hW0qRoqrwE/a2DpAq4llq4X/GEs5
         JcPB9unrb0xULhz6iz95Yof1U3ZuKdLACvuQeqSIIfPGpz1iMA7XaZBITwf2HJZPwBOn
         UQPuUpNAL74LgdrQek/DkVQz1IBOFHMkMtvShOay9MEKlccIq60SWbSkjiPD/fRTFkQU
         q+4LrCf4zWIe9L8k3KgUAx84ZtYAyOj/rEFizUgKNbBVrIpEwJhLfoe/MR8ks10I1nhi
         lYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=THMV7qBfGHCnlJOjQih5vLNyRsOAcoDzGxFt208dGu4=;
        b=oSypjMH9lrz4BnHGHIF5P5uG9g0ov04359cgym1aCzSGU06SrWc/9XDmV9QXTZDKL6
         QnjWkMIl4Xm9AJfp82niEU2qC9Jtj4p02BWS8F4IimtAOoyY7luvS1iq3/T2V0Jo/TFX
         JGpcq3rOrCFRrJ1oi1D/VnW0QKR0Fxi5QAZXbgFcUiWH1Y4su/FdrrffyKNsjHHL9E8f
         hnYbZOK2A/t70U/FK3hhp5Tc+lgRhntdqd2s/g0CwbAGZPFV2TKXpvqzpqAMoSZxwogU
         cZzR1DlfhPWa2b0kCN+abJfS4+Ul/oW/BdMkOqoYhzPiTLmkDGpSCC2yCW+RC7//BRDS
         QDTQ==
X-Gm-Message-State: AOAM532RjdiXledySZEuNtAfzJ3I0+ssqR/EFWt9JyJkBd+VyezhG3Q9
        JasjWJuTGKRKtLtJFuzCGrmd
X-Google-Smtp-Source: ABdhPJxCSSw5bHNaT//Ydnd2YrZDuaUnaM9WoqXjjcpFokoUN6rNEeORPq2Yxmp9IWULlcl81z2ngg==
X-Received: by 2002:a17:90b:4a03:b0:1dc:756a:2463 with SMTP id kk3-20020a17090b4a0300b001dc756a2463mr11313605pjb.68.1652366512715;
        Thu, 12 May 2022 07:41:52 -0700 (PDT)
Received: from thinkpad ([117.202.184.202])
        by smtp.gmail.com with ESMTPSA id t9-20020a632249000000b003c652a0134asm2008843pgm.10.2022.05.12.07.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 07:41:52 -0700 (PDT)
Date:   Thu, 12 May 2022 20:11:44 +0530
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
Subject: Re: [PATCH v2 06/26] dmaengine: dw-edma: Don't permit non-inc
 interleaved xfers
Message-ID: <20220512144144.GI35848@thinkpad>
References: <20220503225104.12108-1-Sergey.Semin@baikalelectronics.ru>
 <20220503225104.12108-7-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220503225104.12108-7-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 04, 2022 at 01:50:44AM +0300, Serge Semin wrote:
> DW eDMA controller always increments both source and destination
> addresses. Permitting DMA interleaved transfers with no src_inc/dst_inc
> flags set may lead to unexpected behaviour for the device users. Let's fix
> that by terminating the interleaved transfers if at least one of the
> dma_interleaved_template.{src_inc,dst_inc} flag is initialized with false
> value. Note in addition to that we need to increase the source and
> destination addresses accordingly after each iteration.
> 
> Fixes: 85e7518f42c8 ("dmaengine: dw-edma: Add device_prep_interleave_dma() support")
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/dma/dw-edma/dw-edma-core.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index f0ef87d75ea9..225eab58acb7 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -386,6 +386,8 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
>  			return NULL;
>  		if (xfer->xfer.il->numf > 0 && xfer->xfer.il->frame_size > 0)
>  			return NULL;
> +		if (!xfer->xfer.il->src_inc || !xfer->xfer.il->dst_inc)
> +			return NULL;
>  	} else {
>  		return NULL;
>  	}
> @@ -485,15 +487,13 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
>  			struct dma_interleaved_template *il = xfer->xfer.il;
>  			struct data_chunk *dc = &il->sgl[i];
>  
> -			if (il->src_sgl) {
> -				src_addr += burst->sz;
> +			src_addr += burst->sz;
> +			if (il->src_sgl)
>  				src_addr += dmaengine_get_src_icg(il, dc);
> -			}
>  
> -			if (il->dst_sgl) {
> -				dst_addr += burst->sz;
> +			dst_addr += burst->sz;
> +			if (il->dst_sgl)
>  				dst_addr += dmaengine_get_dst_icg(il, dc);
> -			}
>  		}
>  	}
>  
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்

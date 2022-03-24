Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7801A4E6812
	for <lists+linux-pci@lfdr.de>; Thu, 24 Mar 2022 18:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243733AbiCXRuv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Mar 2022 13:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243702AbiCXRuu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Mar 2022 13:50:50 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2CA4551C
        for <linux-pci@vger.kernel.org>; Thu, 24 Mar 2022 10:49:17 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id p4-20020a17090ad30400b001c7ca87c05bso1381215pju.1
        for <linux-pci@vger.kernel.org>; Thu, 24 Mar 2022 10:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zEwJykqsXAZ6X80xdCJsmBhU7Y1GHKU0ry7GcuK4lio=;
        b=KNzmAnw4v0LR2R3oCMvi/wlaTekZsKDXsi4Qe81GMseHMhbOywsjMAhCmOEWNNMMOc
         jLvZm0uH99Lb9Zg5Ce7rsj1Rq85IXk0qy/gXAIuewjSd7Za/vQ7BGsajcB451j9AuAlV
         LWGAhlXSFiUx1KR/QyoTN50rUQvqOKT0uEJBa/Q17tIbEXmmiAlN7WC+lFwzVGekNJ7h
         GfiA2mv6/f849mXI0+O1iDkPp4Rov+res0dYoU4S31ALwE4kyHhX6YCTpS+tNM8JRFZR
         rJ+bVybxlTX/JPSLsipYICfkEV6jZZW5CBeC+o4B6H3SO76GkmUEcsDTsszzuknQaY7t
         yOtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zEwJykqsXAZ6X80xdCJsmBhU7Y1GHKU0ry7GcuK4lio=;
        b=0WCF0Z23pOL6PHZJFZGRreXYyQbSx4ERBU1tadN3k+ZFb3MHkgDEthMIE9U3hZ+QYl
         6Hrg7Dx6/M2oyL2nPCQsAeztjbR9InrCECtZpW3eQTS1cM8zRYAnvLRhs6FU1iKyBnf5
         jpxHOt7BdDrLAk+A/v4mm+3UJmp7wCo/rVUqSVhHZ1T+SMlpgRaFh6wxC83TiTwqU4KI
         vTiTzrAuavAe8czz9ANqHTvVhrcbjuXE/HAfaeBzrmmGq07JGY7yvIQkx4t+gT0eiRVn
         O1qc3ydWO6B8bEVeugjDnbANYJdikS1yfN4ghiBUqVyd6fF2614OQf1zRd4DmGihSfYp
         Cl3A==
X-Gm-Message-State: AOAM533YFzT9VXN4asEJllVIpKxdrXwLelZEYf/HBeeVVFy/JqJ5IEq/
        0hk4M5vOXv6fr1yLxnvla7EM
X-Google-Smtp-Source: ABdhPJx+2PcTCwtG8eip5f/lpHYC7MS4hNIrcymtpB+qRqNlhfPaastqMgbD2iLPyqrdaiwzL79H1w==
X-Received: by 2002:a17:902:f70b:b0:14d:643d:9c99 with SMTP id h11-20020a170902f70b00b0014d643d9c99mr7222253plo.18.1648144157256;
        Thu, 24 Mar 2022 10:49:17 -0700 (PDT)
Received: from thinkpad ([27.111.75.218])
        by smtp.gmail.com with ESMTPSA id 132-20020a62168a000000b004f40e8b3133sm4374690pfw.188.2022.03.24.10.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 10:49:10 -0700 (PDT)
Date:   Thu, 24 Mar 2022 23:18:59 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/25] dmaengine: dw-edma: Fix DebugFS reg entry type
Message-ID: <20220324174859.GU2854@thinkpad>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
 <20220324014836.19149-13-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324014836.19149-13-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 24, 2022 at 04:48:23AM +0300, Serge Semin wrote:
> debugfs_entries structure declared in the dw-edma-v0-debugfs.c module
> contains the DebugFS node' register address. The address is declared as
> dma_addr_t type, but first it's assigned with virtual CPU IOMEM address
> and then it's cast back to the virtual address. Even though the castes
> sandwich will unlikely cause any problem since normally DMA address is at
> least of the same size as the CPU virtual address, it's at the very least
> redundant if not to say logically incorrect. Let's fix it by just stop
> casting the pointer back and worth and just preserve the address as a
> pointer to void with __iomem qualifier.
> 
> Fixes: 305aebeff879 ("dmaengine: Add Synopsys eDMA IP version 0 debugfs support")
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/dma/dw-edma/dw-edma-v0-debugfs.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> index 3a899f7f4e8d..12845a2dc016 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> @@ -14,7 +14,7 @@
>  #include "dw-edma-core.h"
>  
>  #define REGS_ADDR(name) \
> -	((void __force *)&regs->name)
> +	((void __iomem *)&regs->name)
>  #define REGISTER(name) \
>  	{ #name, REGS_ADDR(name) }
>  
> @@ -48,12 +48,13 @@ static struct {
>  
>  struct debugfs_entries {
>  	const char				*name;
> -	dma_addr_t				*reg;
> +	void __iomem				*reg;
>  };
>  
>  static int dw_edma_debugfs_u32_get(void *data, u64 *val)
>  {
> -	void __iomem *reg = (void __force __iomem *)data;
> +	void __iomem *reg = data;
> +
>  	if (dw->chip->mf == EDMA_MF_EDMA_LEGACY &&
>  	    reg >= (void __iomem *)&regs->type.legacy.ch) {
>  		void __iomem *ptr = &regs->type.legacy.ch;
> -- 
> 2.35.1
> 

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E1A75F536
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jul 2023 13:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjGXLgG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jul 2023 07:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjGXLgE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jul 2023 07:36:04 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB371FCC
        for <linux-pci@vger.kernel.org>; Mon, 24 Jul 2023 04:35:40 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-666e6ecb52dso2254150b3a.2
        for <linux-pci@vger.kernel.org>; Mon, 24 Jul 2023 04:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690198529; x=1690803329;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Nq+WD11NKB4CXcEv93Ud41HBi4eLx3VHmopZE3v/plY=;
        b=okTJNX3NPbF3G51qRtyVNKm80OBvG3dKzI7rkFmxSlzP7OmN8SBEt0He0rbvd+Xtgo
         YN3Dbhtl0gVz2j6iwSJqKapELXo6vXO/EIOR2hVulgnstfUGiPvWIq/e0uMuI29MWUAW
         Z63Ns4Xq4nFfNhI28HDB3iSoynEGn45tB9U+aKR2/GDO9L7jnSuCcCqEprW07yvGd88x
         x0JUivRn6QOJdXPaWfSJYvroU/jsKVopHdiJBSepYJ+xRraEesE5hTKHS6mK11hgvwOy
         wxabIlMSJMnvxUTxLmOFnOCbLqePa+oq5KX3kmtAFz85ORGYoLPS+UwjPaBNPSAHTR0t
         nh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690198529; x=1690803329;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nq+WD11NKB4CXcEv93Ud41HBi4eLx3VHmopZE3v/plY=;
        b=gP+G0Su1a0ZotKqFGTICFzYEykxgPTTxctLOX8tRRG6iC1fIdyR6cOOroPtSyZSH/+
         kkprGoLcmVWNUOLaP4sOIRaXJy3zpz9HtgQLb56HwIcqfWmqabRDPjmVqFlDJL857R8J
         a9IBMb0yILecMlfxaVthCFDkdXj81/5XpxQIxyrJe/amjRPuVg6/3fUd03bLSxpXR5Rw
         4nBs7ZSvP+YMcywry5rxTD+NlMhi83YvOxlISSXW0I7WTGky1bhR+uEzgim2tOawdWTU
         kUVu+bFph2VMoY0ccOV3H7JttC5l3TmBdmjI//72U13of9uofwhGXJOktUNNy3i7UfK+
         F9eA==
X-Gm-Message-State: ABy/qLbBnPW0yZw1Z3BnhuexGnnEtzxQN9sAtbcvhSlelZfF6q8ElCki
        7KHnPv9BwcVBvrWSoE5kccuL
X-Google-Smtp-Source: APBJJlGj/DRjzrBVCUXmiE8BzEgzvxUx4ah3hIYdCVLFv2yCQuRG9vnvJiRkhR1pRC/961sFgsf9XQ==
X-Received: by 2002:a05:6a20:13da:b0:138:92ef:78f9 with SMTP id ho26-20020a056a2013da00b0013892ef78f9mr4638511pzc.6.1690198529261;
        Mon, 24 Jul 2023 04:35:29 -0700 (PDT)
Received: from thinkpad ([117.206.118.29])
        by smtp.gmail.com with ESMTPSA id r2-20020a170902be0200b001b85bb5fd77sm8665833pls.119.2023.07.24.04.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 04:35:28 -0700 (PDT)
Date:   Mon, 24 Jul 2023 17:05:21 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, kishon@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        marek.vasut+renesas@gmail.com, fancer.lancer@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v18 11/20] PCI: dwc: Add EDMA_UNROLL capability flag
Message-ID: <20230724113521.GJ6291@thinkpad>
References: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
 <20230721074452.65545-12-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230721074452.65545-12-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 21, 2023 at 04:44:43PM +0900, Yoshihiro Shimoda wrote:
> Renesas R-Car Gen4 PCIe controllers have an unexpected register value on
> the dbi+0x97b register. So, add a new capability flag "EDMA_UNROLL"

s/in the dbi+0x97b/in the eDMA CTRL

> which would force the unrolled eDMA mapping for the problematic device.
> 
> Suggested-by: Serge Semin <fancer.lancer@gmail.com>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 8 +++++++-
>  drivers/pci/controller/dwc/pcie-designware.h | 5 +++--
>  2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index c4998194fe74..4812ce040f1e 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -883,8 +883,14 @@ static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
>  	 * Indirect eDMA CSRs access has been completely removed since v5.40a
>  	 * thus no space is now reserved for the eDMA channels viewport and
>  	 * former DMA CTRL register is no longer fixed to FFs.
> +	 *
> +	 * Note that Renesas R-Car S4-8's PCIe controllers for unknown reason
> +	 * have zeros in the eDMA CTRL register even though the HW-manual
> +	 * explicitly states there must FFs if the unrolled mapping is enabled.
> +	 * For such cases the low-level drivers are supposed to manually
> +	 * activate the unrolled mapping to bypass the auto-detection procedure.
>  	 */
> -	if (dw_pcie_ver_is_ge(pci, 540A))
> +	if (dw_pcie_ver_is_ge(pci, 540A) || dw_pcie_cap_is(pci, EDMA_UNROLL))
>  		val = 0xFFFFFFFF;
>  	else
>  		val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 94bc20f5f600..6821446d7c66 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -51,8 +51,9 @@
>  
>  /* DWC PCIe controller capabilities */
>  #define DW_PCIE_CAP_REQ_RES		0
> -#define DW_PCIE_CAP_IATU_UNROLL		1
> -#define DW_PCIE_CAP_CDM_CHECK		2
> +#define DW_PCIE_CAP_EDMA_UNROLL		1
> +#define DW_PCIE_CAP_IATU_UNROLL		2
> +#define DW_PCIE_CAP_CDM_CHECK		3
>  
>  #define dw_pcie_cap_is(_pci, _cap) \
>  	test_bit(DW_PCIE_CAP_ ## _cap, &(_pci)->caps)
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

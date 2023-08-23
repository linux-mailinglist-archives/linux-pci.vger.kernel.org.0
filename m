Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B307855CE
	for <lists+linux-pci@lfdr.de>; Wed, 23 Aug 2023 12:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbjHWKsH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Aug 2023 06:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233086AbjHWKsG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2023 06:48:06 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC859E73;
        Wed, 23 Aug 2023 03:47:35 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4ff91f2d7e2so7843424e87.0;
        Wed, 23 Aug 2023 03:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692787579; x=1693392379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0SdUcxggZa354MLv/2aerz0woV5d1XgULCJmry0vrNY=;
        b=UHPXFBzHxI6HIdP7uw6/aXgyKFwLZ+mCScBPQdpVB889arir0acmJGAVn9Svdn3YWZ
         2u6oZjm4zucdjMt0xXlS8BDab5Ya1oRu73k4DRtEaI1cTsbzfAWjFDRl5EPjPihX4aA2
         xYrem4V+jN4YE8M4XRqyUii92pXHBdrJqE38wH4bgYLzqBl6Zkz3T6cuqKQEQkjymImz
         sRPSG3lHbgslbJ3zGHTrQkiZ04bxklpxwPZQU6/Re4FND532huNio6Os4cNfieF9ynXI
         xrKLMxkLyQ4WQA0AHmmH1FQ9pVcE58+PoqOd0fINesoWAuAEyNd4tgvmC69txVRew6VO
         I9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692787579; x=1693392379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0SdUcxggZa354MLv/2aerz0woV5d1XgULCJmry0vrNY=;
        b=dMl+j0X2CClcoceP/PL+5dxojEpFfLhOJbJKZUG/g2isZZJMCyxd/D5hAgO3IYEpRu
         hD9TKv98QxrewFzN5qb1dro2oOEbKHDrjojD44wR8obrB7AT3xwaDuAXNvmEoXYAsg4B
         yOuJFlRS5J7UZCE9r5rtggdFtDLXcZkUipPt9LKPJyEaVKnXqz7NToSjHQx+TJ0JniTF
         6xd6XEBroEHi6DV/OFPcrCZunUAY2Wec23jheOFn3htMrqAgCuwg2fiXB9YGbjgR7HA9
         e1iNDF0hzpedBOViCOAm4lRnLEx6q0eE4ZrNCS/YYbcr4BB0oGWjdcVcy6HkWEjX6GGK
         io5g==
X-Gm-Message-State: AOJu0YybHxGlQFN6bpG3Erkvd/8W6GjnM3UIxRefJhaldI4qgnQSNKAo
        ZCj9gkBYCZGpCAd8IMK/jQ8=
X-Google-Smtp-Source: AGHT+IH4m79m4BXjhZ8i0PZCGMtPhFznRXwjdAiHRaJoIN9nIme6g2RfzbP39Ero6FsTx6L3Kz7MdA==
X-Received: by 2002:a05:6512:3191:b0:4fb:9f93:365f with SMTP id i17-20020a056512319100b004fb9f93365fmr11529040lfe.38.1692787578611;
        Wed, 23 Aug 2023 03:46:18 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id l14-20020ac24a8e000000b004ff8f090057sm2593054lfp.59.2023.08.23.03.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 03:46:18 -0700 (PDT)
Date:   Wed, 23 Aug 2023 13:46:15 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
        kishon@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v19 05/19] PCI: dwc: endpoint: Add multiple PFs support
 for dbi2
Message-ID: <ku43dl3ssq4c6zewwt6ckiwjdolgpmt33iemwfx62oqu65zjlr@5ctyxmqigkbb>
References: <20230823091153.2578417-1-yoshihiro.shimoda.uh@renesas.com>
 <20230823091153.2578417-6-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823091153.2578417-6-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 23, 2023 at 06:11:39PM +0900, Yoshihiro Shimoda wrote:
> The commit 24ede430fa49 ("PCI: designware-ep: Add multiple PFs support
> for DWC") added .func_conf_select() to get the configuration space of
> different PFs and assumed that the offsets between dbi and dbi2 would
> be the same. However, Renesas R-Car Gen4 PCIe controllers have different
> offsets of function 1: dbi (+0x1000) and dbi2 (+0x800). To get
> the offset for dbi2, add .get_dbi2_offset() and
> dw_pcie_ep_get_dbi2_offset().
> 
> Note:

>  - .func_conf_select() should be renamed later.

That's the problem with half-measured solutions. The code now looks
clumsy and thus weakly readable.

>  - dw_pcie_ep_get_dbi2_offset() will call .func_conf_select()
>    if .get_dbi2_offset() doesn't exist for backward compatibility.

>  - dw_pcie_writeX_{dbi/dbi2} APIs accepted the func_no argument,
>    so that these offset calculations are contained in the API
>    definitions itself as it should.

I very much hope you'll get to do that after this patchset is merged
in.)

-Serge(y)

> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 32 ++++++++++++++-----
>  drivers/pci/controller/dwc/pcie-designware.h  |  1 +
>  2 files changed, 25 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 4a8c116cdd4b..500b092984b0 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -54,21 +54,35 @@ static unsigned int dw_pcie_ep_func_select(struct dw_pcie_ep *ep, u8 func_no)
>  	return func_offset;
>  }
>  
> +static unsigned int dw_pcie_ep_get_dbi2_offset(struct dw_pcie_ep *ep, u8 func_no)
> +{
> +	unsigned int dbi2_offset = 0;
> +
> +	if (ep->ops->get_dbi2_offset)
> +		dbi2_offset = ep->ops->get_dbi2_offset(ep, func_no);
> +	else if (ep->ops->func_conf_select)     /* for backward compatibility */
> +		dbi2_offset = ep->ops->func_conf_select(ep, func_no);
> +
> +	return dbi2_offset;
> +}
> +
>  static void __dw_pcie_ep_reset_bar(struct dw_pcie *pci, u8 func_no,
>  				   enum pci_barno bar, int flags)
>  {
> -	u32 reg;
> -	unsigned int func_offset = 0;
> +	unsigned int func_offset, dbi2_offset;
>  	struct dw_pcie_ep *ep = &pci->ep;
> +	u32 reg, reg_dbi2;
>  
>  	func_offset = dw_pcie_ep_func_select(ep, func_no);
> +	dbi2_offset = dw_pcie_ep_get_dbi2_offset(ep, func_no);
>  
>  	reg = func_offset + PCI_BASE_ADDRESS_0 + (4 * bar);
> +	reg_dbi2 = dbi2_offset + PCI_BASE_ADDRESS_0 + (4 * bar);
>  	dw_pcie_dbi_ro_wr_en(pci);
> -	dw_pcie_writel_dbi2(pci, reg, 0x0);
> +	dw_pcie_writel_dbi2(pci, reg_dbi2, 0x0);
>  	dw_pcie_writel_dbi(pci, reg, 0x0);
>  	if (flags & PCI_BASE_ADDRESS_MEM_TYPE_64) {
> -		dw_pcie_writel_dbi2(pci, reg + 4, 0x0);
> +		dw_pcie_writel_dbi2(pci, reg_dbi2 + 4, 0x0);
>  		dw_pcie_writel_dbi(pci, reg + 4, 0x0);
>  	}
>  	dw_pcie_dbi_ro_wr_dis(pci);
> @@ -229,16 +243,18 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  {
>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	unsigned int func_offset, dbi2_offset;
>  	enum pci_barno bar = epf_bar->barno;
>  	size_t size = epf_bar->size;
>  	int flags = epf_bar->flags;
> -	unsigned int func_offset = 0;
> +	u32 reg, reg_dbi2;
>  	int ret, type;
> -	u32 reg;
>  
>  	func_offset = dw_pcie_ep_func_select(ep, func_no);
> +	dbi2_offset = dw_pcie_ep_get_dbi2_offset(ep, func_no);
>  
>  	reg = PCI_BASE_ADDRESS_0 + (4 * bar) + func_offset;
> +	reg_dbi2 = PCI_BASE_ADDRESS_0 + (4 * bar) + dbi2_offset;
>  
>  	if (!(flags & PCI_BASE_ADDRESS_SPACE))
>  		type = PCIE_ATU_TYPE_MEM;
> @@ -254,11 +270,11 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  
>  	dw_pcie_dbi_ro_wr_en(pci);
>  
> -	dw_pcie_writel_dbi2(pci, reg, lower_32_bits(size - 1));
> +	dw_pcie_writel_dbi2(pci, reg_dbi2, lower_32_bits(size - 1));
>  	dw_pcie_writel_dbi(pci, reg, flags);
>  
>  	if (flags & PCI_BASE_ADDRESS_MEM_TYPE_64) {
> -		dw_pcie_writel_dbi2(pci, reg + 4, upper_32_bits(size - 1));
> +		dw_pcie_writel_dbi2(pci, reg_dbi2 + 4, upper_32_bits(size - 1));
>  		dw_pcie_writel_dbi(pci, reg + 4, 0);
>  	}
>  
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index c17e5255fab6..7d02401fc783 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -343,6 +343,7 @@ struct dw_pcie_ep_ops {
>  	 * driver.
>  	 */
>  	unsigned int (*func_conf_select)(struct dw_pcie_ep *ep, u8 func_no);
> +	unsigned int (*get_dbi2_offset)(struct dw_pcie_ep *ep, u8 func_no);
>  };
>  
>  struct dw_pcie_ep_func {
> -- 
> 2.25.1
> 

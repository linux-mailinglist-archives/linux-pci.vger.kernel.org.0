Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594FF7D9A7C
	for <lists+linux-pci@lfdr.de>; Fri, 27 Oct 2023 15:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346014AbjJ0Nxf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Oct 2023 09:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345994AbjJ0Nxe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Oct 2023 09:53:34 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D45192
        for <linux-pci@vger.kernel.org>; Fri, 27 Oct 2023 06:53:32 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6b709048d8eso1942484b3a.2
        for <linux-pci@vger.kernel.org>; Fri, 27 Oct 2023 06:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698414811; x=1699019611; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RPwG2QcwboihMKc7vz66bqzH6hNuU2qBnSDnXgA9jsQ=;
        b=Bh4UsKhGuYPWpigmnJYJvCeJy8RjJI7noqKQ+7SL2wqVRJm8H9owThUNsOQMsMoe8d
         UkgC0H/a+4QPmy8gopVivMoT+GBSLw+cEF582TvpTlUIQxICJX8buFnjmBpP8tqGGmA9
         nklEQv5F1/FR/0q0uaxh2IELG6RCMWQLTzaht8Jnxnr6/4tAUB694gTjztmSFCd69Zrp
         Q0y20+yoDjkEr96p8rfXzETitgkcinUBS7TgFBoLk2CVcYuoqgM2OSStLbMcl0hwa6dp
         IubOR3k0uyPSyzafPDd5qI+U9v/YU9YyHvLTGFQRlaMObpRycjeBmhlbshho3ZOnNWj6
         wxyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698414811; x=1699019611;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RPwG2QcwboihMKc7vz66bqzH6hNuU2qBnSDnXgA9jsQ=;
        b=ZvikUMvAlYSTGdavSf3sYygolplgpYojfO0scfJ18wnzFH+bcFAWGVnEzLgnTf+A4b
         I6n+nozFmPsrXD+H3yua6a1l1p0FTr7M0ECTYdjcJo30kth8o/SWJjIcOmOFz5ZPommP
         XBXExEqjeiJi1lUpqSY+uvOi1iJRWfrdSYLCP+Y69U4DZwzSSXHgK2zOMhLmvbf4yD3s
         hEdv8qReq5qxBKLUE30P0gYn6t02RnZW4D2gzaHuDIi8shgSvZkNN0Dge6j165aINAAi
         +8LOAhgaClo8dVPaqIKZGxOBA58VI0ol3YCERFBAZ5uu26MwxrCtE2b5qzFICr5dtHPO
         Flwg==
X-Gm-Message-State: AOJu0YwS3Nd1QAg79C/XaAYdk8SvcKNStNzFBxBvCOAL8e3cNuo0tbH5
        nfOgOsvu5hIYC29tBcbKIMJ+
X-Google-Smtp-Source: AGHT+IHFERWxa0DWPsFP/6ZVX0E8T/43L76IsFNz5+4AXW7mzc2yvPbKGP8rugKLwa+l8LoMrWvx6g==
X-Received: by 2002:a05:6a21:7989:b0:161:3120:e888 with SMTP id bh9-20020a056a21798900b001613120e888mr3140556pzc.46.1698414811168;
        Fri, 27 Oct 2023 06:53:31 -0700 (PDT)
Received: from thinkpad ([120.138.12.43])
        by smtp.gmail.com with ESMTPSA id s21-20020a056a00195500b0069309cbc220sm1379599pfk.121.2023.10.27.06.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 06:53:29 -0700 (PDT)
Date:   Fri, 27 Oct 2023 19:23:24 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Shradha Todi <shradha.t@samsung.com>
Cc:     jingoohan1@gmail.com, lpieralisi@kernel.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com,
        krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        pankaj.dubey@samsung.com
Subject: Re: [PATCH] PCI: exynos: Change macro names to exynos specific
Message-ID: <20231027135324.GB23716@thinkpad>
References: <CGME20231009062058epcas5p4dc1fb50210c920137ac906b0bdf99e1b@epcas5p4.samsung.com>
 <20231009062052.5407-1-shradha.t@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231009062052.5407-1-shradha.t@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 09, 2023 at 11:50:52AM +0530, Shradha Todi wrote:
> Prefix macro names in exynos file with the term "EXYNOS" as the current
> macro names seem to be generic to PCIe.
> 
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> ---

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

>  drivers/pci/controller/dwc/pci-exynos.c | 116 ++++++++++++------------
>  1 file changed, 58 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
> index 6319082301d6..9e42cfcd99cc 100644
> --- a/drivers/pci/controller/dwc/pci-exynos.c
> +++ b/drivers/pci/controller/dwc/pci-exynos.c
> @@ -26,30 +26,30 @@
>  #define to_exynos_pcie(x)	dev_get_drvdata((x)->dev)
>  
>  /* PCIe ELBI registers */
> -#define PCIE_IRQ_PULSE			0x000
> -#define IRQ_INTA_ASSERT			BIT(0)
> -#define IRQ_INTB_ASSERT			BIT(2)
> -#define IRQ_INTC_ASSERT			BIT(4)
> -#define IRQ_INTD_ASSERT			BIT(6)
> -#define PCIE_IRQ_LEVEL			0x004
> -#define PCIE_IRQ_SPECIAL		0x008
> -#define PCIE_IRQ_EN_PULSE		0x00c
> -#define PCIE_IRQ_EN_LEVEL		0x010
> -#define PCIE_IRQ_EN_SPECIAL		0x014
> -#define PCIE_SW_WAKE			0x018
> -#define PCIE_BUS_EN			BIT(1)
> -#define PCIE_CORE_RESET			0x01c
> -#define PCIE_CORE_RESET_ENABLE		BIT(0)
> -#define PCIE_STICKY_RESET		0x020
> -#define PCIE_NONSTICKY_RESET		0x024
> -#define PCIE_APP_INIT_RESET		0x028
> -#define PCIE_APP_LTSSM_ENABLE		0x02c
> -#define PCIE_ELBI_RDLH_LINKUP		0x074
> -#define PCIE_ELBI_XMLH_LINKUP		BIT(4)
> -#define PCIE_ELBI_LTSSM_ENABLE		0x1
> -#define PCIE_ELBI_SLV_AWMISC		0x11c
> -#define PCIE_ELBI_SLV_ARMISC		0x120
> -#define PCIE_ELBI_SLV_DBI_ENABLE	BIT(21)
> +#define EXYNOS_PCIE_IRQ_PULSE			0x000
> +#define EXYNOS_IRQ_INTA_ASSERT			BIT(0)
> +#define EXYNOS_IRQ_INTB_ASSERT			BIT(2)
> +#define EXYNOS_IRQ_INTC_ASSERT			BIT(4)
> +#define EXYNOS_IRQ_INTD_ASSERT			BIT(6)
> +#define EXYNOS_PCIE_IRQ_LEVEL			0x004
> +#define EXYNOS_PCIE_IRQ_SPECIAL		0x008
> +#define EXYNOS_PCIE_IRQ_EN_PULSE		0x00c
> +#define EXYNOS_PCIE_IRQ_EN_LEVEL		0x010
> +#define EXYNOS_PCIE_IRQ_EN_SPECIAL		0x014
> +#define EXYNOS_PCIE_SW_WAKE			0x018
> +#define EXYNOS_PCIE_BUS_EN			BIT(1)
> +#define EXYNOS_PCIE_CORE_RESET			0x01c
> +#define EXYNOS_PCIE_CORE_RESET_ENABLE		BIT(0)
> +#define EXYNOS_PCIE_STICKY_RESET		0x020
> +#define EXYNOS_PCIE_NONSTICKY_RESET		0x024
> +#define EXYNOS_PCIE_APP_INIT_RESET		0x028
> +#define EXYNOS_PCIE_APP_LTSSM_ENABLE		0x02c
> +#define EXYNOS_PCIE_ELBI_RDLH_LINKUP		0x074
> +#define EXYNOS_PCIE_ELBI_XMLH_LINKUP		BIT(4)
> +#define EXYNOS_PCIE_ELBI_LTSSM_ENABLE		0x1
> +#define EXYNOS_PCIE_ELBI_SLV_AWMISC		0x11c
> +#define EXYNOS_PCIE_ELBI_SLV_ARMISC		0x120
> +#define EXYNOS_PCIE_ELBI_SLV_DBI_ENABLE	BIT(21)
>  
>  struct exynos_pcie {
>  	struct dw_pcie			pci;
> @@ -105,49 +105,49 @@ static void exynos_pcie_sideband_dbi_w_mode(struct exynos_pcie *ep, bool on)
>  {
>  	u32 val;
>  
> -	val = exynos_pcie_readl(ep->elbi_base, PCIE_ELBI_SLV_AWMISC);
> +	val = exynos_pcie_readl(ep->elbi_base, EXYNOS_PCIE_ELBI_SLV_AWMISC);
>  	if (on)
> -		val |= PCIE_ELBI_SLV_DBI_ENABLE;
> +		val |= EXYNOS_PCIE_ELBI_SLV_DBI_ENABLE;
>  	else
> -		val &= ~PCIE_ELBI_SLV_DBI_ENABLE;
> -	exynos_pcie_writel(ep->elbi_base, val, PCIE_ELBI_SLV_AWMISC);
> +		val &= ~EXYNOS_PCIE_ELBI_SLV_DBI_ENABLE;
> +	exynos_pcie_writel(ep->elbi_base, val, EXYNOS_PCIE_ELBI_SLV_AWMISC);
>  }
>  
>  static void exynos_pcie_sideband_dbi_r_mode(struct exynos_pcie *ep, bool on)
>  {
>  	u32 val;
>  
> -	val = exynos_pcie_readl(ep->elbi_base, PCIE_ELBI_SLV_ARMISC);
> +	val = exynos_pcie_readl(ep->elbi_base, EXYNOS_PCIE_ELBI_SLV_ARMISC);
>  	if (on)
> -		val |= PCIE_ELBI_SLV_DBI_ENABLE;
> +		val |= EXYNOS_PCIE_ELBI_SLV_DBI_ENABLE;
>  	else
> -		val &= ~PCIE_ELBI_SLV_DBI_ENABLE;
> -	exynos_pcie_writel(ep->elbi_base, val, PCIE_ELBI_SLV_ARMISC);
> +		val &= ~EXYNOS_PCIE_ELBI_SLV_DBI_ENABLE;
> +	exynos_pcie_writel(ep->elbi_base, val, EXYNOS_PCIE_ELBI_SLV_ARMISC);
>  }
>  
>  static void exynos_pcie_assert_core_reset(struct exynos_pcie *ep)
>  {
>  	u32 val;
>  
> -	val = exynos_pcie_readl(ep->elbi_base, PCIE_CORE_RESET);
> -	val &= ~PCIE_CORE_RESET_ENABLE;
> -	exynos_pcie_writel(ep->elbi_base, val, PCIE_CORE_RESET);
> -	exynos_pcie_writel(ep->elbi_base, 0, PCIE_STICKY_RESET);
> -	exynos_pcie_writel(ep->elbi_base, 0, PCIE_NONSTICKY_RESET);
> +	val = exynos_pcie_readl(ep->elbi_base, EXYNOS_PCIE_CORE_RESET);
> +	val &= ~EXYNOS_PCIE_CORE_RESET_ENABLE;
> +	exynos_pcie_writel(ep->elbi_base, val, EXYNOS_PCIE_CORE_RESET);
> +	exynos_pcie_writel(ep->elbi_base, 0, EXYNOS_PCIE_STICKY_RESET);
> +	exynos_pcie_writel(ep->elbi_base, 0, EXYNOS_PCIE_NONSTICKY_RESET);
>  }
>  
>  static void exynos_pcie_deassert_core_reset(struct exynos_pcie *ep)
>  {
>  	u32 val;
>  
> -	val = exynos_pcie_readl(ep->elbi_base, PCIE_CORE_RESET);
> -	val |= PCIE_CORE_RESET_ENABLE;
> +	val = exynos_pcie_readl(ep->elbi_base, EXYNOS_PCIE_CORE_RESET);
> +	val |= EXYNOS_PCIE_CORE_RESET_ENABLE;
>  
> -	exynos_pcie_writel(ep->elbi_base, val, PCIE_CORE_RESET);
> -	exynos_pcie_writel(ep->elbi_base, 1, PCIE_STICKY_RESET);
> -	exynos_pcie_writel(ep->elbi_base, 1, PCIE_NONSTICKY_RESET);
> -	exynos_pcie_writel(ep->elbi_base, 1, PCIE_APP_INIT_RESET);
> -	exynos_pcie_writel(ep->elbi_base, 0, PCIE_APP_INIT_RESET);
> +	exynos_pcie_writel(ep->elbi_base, val, EXYNOS_PCIE_CORE_RESET);
> +	exynos_pcie_writel(ep->elbi_base, 1, EXYNOS_PCIE_STICKY_RESET);
> +	exynos_pcie_writel(ep->elbi_base, 1, EXYNOS_PCIE_NONSTICKY_RESET);
> +	exynos_pcie_writel(ep->elbi_base, 1, EXYNOS_PCIE_APP_INIT_RESET);
> +	exynos_pcie_writel(ep->elbi_base, 0, EXYNOS_PCIE_APP_INIT_RESET);
>  }
>  
>  static int exynos_pcie_start_link(struct dw_pcie *pci)
> @@ -155,21 +155,21 @@ static int exynos_pcie_start_link(struct dw_pcie *pci)
>  	struct exynos_pcie *ep = to_exynos_pcie(pci);
>  	u32 val;
>  
> -	val = exynos_pcie_readl(ep->elbi_base, PCIE_SW_WAKE);
> -	val &= ~PCIE_BUS_EN;
> -	exynos_pcie_writel(ep->elbi_base, val, PCIE_SW_WAKE);
> +	val = exynos_pcie_readl(ep->elbi_base, EXYNOS_PCIE_SW_WAKE);
> +	val &= ~EXYNOS_PCIE_BUS_EN;
> +	exynos_pcie_writel(ep->elbi_base, val, EXYNOS_PCIE_SW_WAKE);
>  
>  	/* assert LTSSM enable */
> -	exynos_pcie_writel(ep->elbi_base, PCIE_ELBI_LTSSM_ENABLE,
> -			  PCIE_APP_LTSSM_ENABLE);
> +	exynos_pcie_writel(ep->elbi_base, EXYNOS_PCIE_ELBI_LTSSM_ENABLE,
> +			  EXYNOS_PCIE_APP_LTSSM_ENABLE);
>  	return 0;
>  }
>  
>  static void exynos_pcie_clear_irq_pulse(struct exynos_pcie *ep)
>  {
> -	u32 val = exynos_pcie_readl(ep->elbi_base, PCIE_IRQ_PULSE);
> +	u32 val = exynos_pcie_readl(ep->elbi_base, EXYNOS_PCIE_IRQ_PULSE);
>  
> -	exynos_pcie_writel(ep->elbi_base, val, PCIE_IRQ_PULSE);
> +	exynos_pcie_writel(ep->elbi_base, val, EXYNOS_PCIE_IRQ_PULSE);
>  }
>  
>  static irqreturn_t exynos_pcie_irq_handler(int irq, void *arg)
> @@ -182,12 +182,12 @@ static irqreturn_t exynos_pcie_irq_handler(int irq, void *arg)
>  
>  static void exynos_pcie_enable_irq_pulse(struct exynos_pcie *ep)
>  {
> -	u32 val = IRQ_INTA_ASSERT | IRQ_INTB_ASSERT |
> -		  IRQ_INTC_ASSERT | IRQ_INTD_ASSERT;
> +	u32 val = EXYNOS_IRQ_INTA_ASSERT | EXYNOS_IRQ_INTB_ASSERT |
> +		  EXYNOS_IRQ_INTC_ASSERT | EXYNOS_IRQ_INTD_ASSERT;
>  
> -	exynos_pcie_writel(ep->elbi_base, val, PCIE_IRQ_EN_PULSE);
> -	exynos_pcie_writel(ep->elbi_base, 0, PCIE_IRQ_EN_LEVEL);
> -	exynos_pcie_writel(ep->elbi_base, 0, PCIE_IRQ_EN_SPECIAL);
> +	exynos_pcie_writel(ep->elbi_base, val, EXYNOS_PCIE_IRQ_EN_PULSE);
> +	exynos_pcie_writel(ep->elbi_base, 0, EXYNOS_PCIE_IRQ_EN_LEVEL);
> +	exynos_pcie_writel(ep->elbi_base, 0, EXYNOS_PCIE_IRQ_EN_SPECIAL);
>  }
>  
>  static u32 exynos_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base,
> @@ -244,9 +244,9 @@ static struct pci_ops exynos_pci_ops = {
>  static int exynos_pcie_link_up(struct dw_pcie *pci)
>  {
>  	struct exynos_pcie *ep = to_exynos_pcie(pci);
> -	u32 val = exynos_pcie_readl(ep->elbi_base, PCIE_ELBI_RDLH_LINKUP);
> +	u32 val = exynos_pcie_readl(ep->elbi_base, EXYNOS_PCIE_ELBI_RDLH_LINKUP);
>  
> -	return (val & PCIE_ELBI_XMLH_LINKUP);
> +	return (val & EXYNOS_PCIE_ELBI_XMLH_LINKUP);
>  }
>  
>  static int exynos_pcie_host_init(struct dw_pcie_rp *pp)
> -- 
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்

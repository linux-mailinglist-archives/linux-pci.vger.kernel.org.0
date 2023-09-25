Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34DF47AD66E
	for <lists+linux-pci@lfdr.de>; Mon, 25 Sep 2023 12:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjIYKxS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Sep 2023 06:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjIYKxS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Sep 2023 06:53:18 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0405CAB;
        Mon, 25 Sep 2023 03:53:11 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c123eed8b2so100119131fa.0;
        Mon, 25 Sep 2023 03:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695639189; x=1696243989; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S3lrauD378Jr7Nrlj6HavsU9T7AmaNkJ1AONfkx4VFY=;
        b=FXj6MPCUkfxPQ+uwo1lU6GYjLrOctlbxhg62i+L/eae0frOUpOo6psOQa3Bt0yH2m7
         jYr/Z+nx+xIq6iIdGWotZ2dPL204GnlxN/+MUrR3bsRuVWXoiDwtLvdMTkpf6hMhX1x5
         WOpR1TYedw+1RVBFjQfXG+bCH0Exh8bLHxvwZ6vVW6/JKxotHfPq5RI/nIh18c8/EMFk
         t3pgSM8Op99mqQzXgN8T0KkquxNghXk8tEPiR//bN6EQX+pU4/OA9MjR3NjxRAQcZBlU
         1BFI1elxDMiW/BC4A2WiP0gCFneOX+SDWAq++zS5CHVrN0HD11RmhvdWVhJcHOfHLUmG
         6B5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695639189; x=1696243989;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S3lrauD378Jr7Nrlj6HavsU9T7AmaNkJ1AONfkx4VFY=;
        b=bDNOW9TwE0bo9R0IxZdKBGqR4n8K9pCj7ZmuBpxzHirnJQ/y/A7jS+eiQfMB+WuQHK
         UU/9nHhRFmBFCewWRQPglllbp7ZgQNPM2MDBETeUTxC8JUrSPNAHk4f2tsg+Q5/DeGVI
         WteAlQt9XuA5oxjBFCBu4V470NtpquwFh16STggzQ1QYOXgjZg4B0mre4TwNaoeaAFNM
         ym9cCQhnKf+1ucqb8f1TR+HwIYsNofBqhhLp4Qn6teCdDugegXZsqwVCUAHWLva/R/+L
         wy/ClgNb4CUcELSaI0VKa6ZfpLI957BBrW2ICwr1fMZL980hoKHwCbFESJjam95O9XLx
         a/ng==
X-Gm-Message-State: AOJu0Yxez4FWCV2FOtDHSRhpzfZ26NKOClx68ayPZnt6muipSPrbCL0G
        Dv5QD5Ddzkel87uu62LnSiZDIfsgfEM=
X-Google-Smtp-Source: AGHT+IEcPUbo2olSid5MywiypDV/KTKaOBAG1YhXaQQndiRHZhNTRNpk4QQc+q7TcGibFEN0QKJGnQ==
X-Received: by 2002:a2e:a0cd:0:b0:2bb:b626:5044 with SMTP id f13-20020a2ea0cd000000b002bbb6265044mr5654055ljm.6.1695639188973;
        Mon, 25 Sep 2023 03:53:08 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id a10-20020a2eb16a000000b002bfc44dd6b3sm2079962ljm.63.2023.09.25.03.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 03:53:08 -0700 (PDT)
Date:   Mon, 25 Sep 2023 13:53:06 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mani@kernel.org,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v22 14/16] PCI: dwc: rcar-gen4: Add R-Car Gen4 PCIe
 Endpoint support
Message-ID: <bdv2lgm42igl2anvmyvekasiyioa43prhi3cxskxk33r2zxmba@2mbrybbdyo3i>
References: <20230925072130.3901087-1-yoshihiro.shimoda.uh@renesas.com>
 <20230925072130.3901087-15-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230925072130.3901087-15-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 25, 2023 at 04:21:28PM +0900, Yoshihiro Shimoda wrote:
> Add R-Car Gen4 PCIe controller for endpoint mode. This controller is based
> on Synopsys DesignWare PCIe.
> 
> Link: https://lore.kernel.org/linux-pci/20230825093219.2685912-18-yoshihiro.shimoda.uh@renesas.com
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> ---
>  drivers/pci/controller/dwc/Kconfig          |  11 ++
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c | 136 +++++++++++++++++++-
>  2 files changed, 144 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index bc69fcab2e2a..e7fd37717998 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -429,4 +429,15 @@ config PCIE_RCAR_GEN4_HOST
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called pcie-rcar-gen4.ko. This uses the DesignWare core.
>  
> +config PCIE_RCAR_GEN4_EP
> +	tristate "Renesas R-Car Gen4 PCIe controller (endpoint mode)"
> +	depends on ARCH_RENESAS || COMPILE_TEST
> +	depends on PCI_ENDPOINT
> +	select PCIE_DW_EP
> +	select PCIE_RCAR_GEN4
> +	help
> +	  Say Y here if you want PCIe controller (endpoint mode) on R-Car Gen4
> +	  SoCs. To compile this driver as a module, choose M here: the module
> +	  will be called pcie-rcar-gen4.ko. This uses the DesignWare core.
> +
>  endmenu
> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> index f6b3c3ef187c..d1b31ea909ba 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> @@ -45,6 +45,9 @@
>  #define RCAR_NUM_SPEED_CHANGE_RETRIES	10
>  #define RCAR_MAX_LINK_SPEED		4
>  
> +#define RCAR_GEN4_PCIE_EP_FUNC_DBI_OFFSET	0x1000
> +#define RCAR_GEN4_PCIE_EP_FUNC_DBI2_OFFSET	0x800
> +
>  struct rcar_gen4_pcie {
>  	struct dw_pcie dw;
>  	void __iomem *base;
> @@ -53,6 +56,7 @@ struct rcar_gen4_pcie {
>  };
>  #define to_rcar_gen4_pcie(_dw)	container_of(_dw, struct rcar_gen4_pcie, dw)
>  
> +/* Common */
>  static void rcar_gen4_pcie_ltssm_enable(struct rcar_gen4_pcie *rcar,
>  					bool enable)
>  {
> @@ -311,6 +315,9 @@ static int rcar_gen4_add_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
>  {
>  	struct dw_pcie_rp *pp = &rcar->dw.pp;
>  
> +	if (!IS_ENABLED(CONFIG_PCIE_RCAR_GEN4_HOST))
> +		return -ENODEV;
> +
>  	pp->num_vectors = MAX_MSI_IRQS;
>  	pp->ops = &rcar_gen4_pcie_host_ops;
>  	rcar->mode = DW_PCIE_RC_TYPE;
> @@ -323,8 +330,114 @@ static void rcar_gen4_remove_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
>  	dw_pcie_host_deinit(&rcar->dw.pp);
>  }
>  
> +/* Endpoind mode */
> +static void rcar_gen4_pcie_ep_pre_init(struct dw_pcie_ep *ep)
> +{
> +	struct dw_pcie *dw = to_dw_pcie_from_ep(ep);
> +	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
> +	int ret;
> +
> +	ret = rcar_gen4_pcie_common_init(rcar);
> +	if (ret)
> +		return;
> +
> +	writel(PCIEDMAINTSTSEN_INIT, rcar->base + PCIEDMAINTSTSEN);
> +}
> +
> +static void rcar_gen4_pcie_ep_init(struct dw_pcie_ep *ep)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	enum pci_barno bar;
> +
> +	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
> +		dw_pcie_ep_reset_bar(pci, bar);
> +}
> +
> +static void rcar_gen4_pcie_ep_deinit(struct dw_pcie_ep *ep)
> +{
> +	struct dw_pcie *dw = to_dw_pcie_from_ep(ep);
> +	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
> +
> +	writel(0, rcar->base + PCIEDMAINTSTSEN);
> +	rcar_gen4_pcie_common_deinit(rcar);
> +}
> +
> +static int rcar_gen4_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> +				       unsigned int type, u16 interrupt_num)
> +{
> +	struct dw_pcie *dw = to_dw_pcie_from_ep(ep);
> +
> +	switch (type) {
> +	case PCI_IRQ_LEGACY:
> +		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
> +	case PCI_IRQ_MSI:
> +		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> +	default:
> +		dev_err(dw->dev, "Unknown IRQ type\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct pci_epc_features rcar_gen4_pcie_epc_features = {
> +	.linkup_notifier = false,
> +	.msi_capable = true,
> +	.msix_capable = false,
> +	.reserved_bar = 1 << BAR_1 | 1 << BAR_3 | 1 << BAR_5,
> +	.align = SZ_1M,
> +};
> +
> +static const struct pci_epc_features*
> +rcar_gen4_pcie_ep_get_features(struct dw_pcie_ep *ep)
> +{
> +	return &rcar_gen4_pcie_epc_features;
> +}
> +
> +static unsigned int rcar_gen4_pcie_ep_func_conf_select(struct dw_pcie_ep *ep,
> +						       u8 func_no)
> +{
> +	return func_no * RCAR_GEN4_PCIE_EP_FUNC_DBI_OFFSET;
> +}
> +
> +static unsigned int rcar_gen4_pcie_ep_get_dbi2_offset(struct dw_pcie_ep *ep,
> +						      u8 func_no)
> +{
> +	return func_no * RCAR_GEN4_PCIE_EP_FUNC_DBI2_OFFSET;
> +}
> +
> +static const struct dw_pcie_ep_ops pcie_ep_ops = {
> +	.pre_init = rcar_gen4_pcie_ep_pre_init,
> +	.ep_init = rcar_gen4_pcie_ep_init,
> +	.deinit = rcar_gen4_pcie_ep_deinit,
> +	.raise_irq = rcar_gen4_pcie_ep_raise_irq,
> +	.get_features = rcar_gen4_pcie_ep_get_features,
> +	.func_conf_select = rcar_gen4_pcie_ep_func_conf_select,
> +	.get_dbi2_offset = rcar_gen4_pcie_ep_get_dbi2_offset,
> +};
> +
> +static int rcar_gen4_add_dw_pcie_ep(struct rcar_gen4_pcie *rcar)
> +{
> +	struct dw_pcie_ep *ep = &rcar->dw.ep;
> +
> +	if (!IS_ENABLED(CONFIG_PCIE_RCAR_GEN4_EP))
> +		return -ENODEV;
> +
> +	rcar->mode = DW_PCIE_EP_TYPE;
> +	ep->ops = &pcie_ep_ops;
> +
> +	return dw_pcie_ep_init(ep);
> +}
> +
> +static void rcar_gen4_remove_dw_pcie_ep(struct rcar_gen4_pcie *rcar)
> +{
> +	dw_pcie_ep_exit(&rcar->dw.ep);
> +}
> +
> +/* Common */
>  static int rcar_gen4_pcie_probe(struct platform_device *pdev)
>  {
> +	enum dw_pcie_device_mode mode;
>  	struct rcar_gen4_pcie *rcar;
>  	int err;
>  
> @@ -340,7 +453,13 @@ static int rcar_gen4_pcie_probe(struct platform_device *pdev)
>  	if (err)
>  		return err;
>  

> -	err = rcar_gen4_add_dw_pcie_rp(rcar);
> +	mode = (enum dw_pcie_device_mode)of_device_get_match_data(&pdev->dev);
> +
> +	if (mode == DW_PCIE_RC_TYPE)
> +		err = rcar_gen4_add_dw_pcie_rp(rcar);
> +	else if (mode == DW_PCIE_EP_TYPE)
> +		err = rcar_gen4_add_dw_pcie_ep(rcar);
> +

So now you have two places with the controller mode initialization:
1. rcar_gen4_pcie_of_match
2. rcar_gen4_add_dw_pcie_rp() and rcar_gen4_add_dw_pcie_ep()
It looks a bit clumsy and less maintainable than could be. What I
suggest is to create a new method which would do what is done above,
but also would initialize the rcar_gen4_pcie->mode field:

static int rcar_gen4_add_dw_pcie(struct rcar_gen4_pcie *rcar)
{
	rcar->mode = device_get_match_data(&rcar->pdev->dev);
	switch (rcar->mode) {
	case DW_PCIE_RC_TYPE:
		return rcar_gen4_add_dw_pcie_rp(rcar);
	case DW_PCIE_EP_TYPE:
		return rcar_gen4_add_dw_pcie_ep(rcar);
	}

	return -EINVAL;
}

Of course the rcar_gen4_pcie->mode field initialization should be
dropped from the rcar_gen4_add_dw_pcie_rp() and
rcar_gen4_add_dw_pcie_ep() methods.

and ...

>  	if (err)
>  		goto err_unprepare;
>  
> @@ -356,12 +475,23 @@ static void rcar_gen4_pcie_remove(struct platform_device *pdev)
>  {
>  	struct rcar_gen4_pcie *rcar = platform_get_drvdata(pdev);
>  

> -	rcar_gen4_remove_dw_pcie_rp(rcar);
> +	if (rcar->mode == DW_PCIE_RC_TYPE)
> +		rcar_gen4_remove_dw_pcie_rp(rcar);
> +	else if (rcar->mode == DW_PCIE_EP_TYPE)
> +		rcar_gen4_remove_dw_pcie_ep(rcar);
> +

... similarly I would have added a respective antagonist:

static void rcar_gen4_remove_dw_pcie(struct rcar_gen4_pcie *rcar)
{
	switch (rcar->mode) {
	case DW_PCIE_RC_TYPE:
		rcar_gen4_remove_dw_pcie_rp(rcar);
		break;
	case DW_PCIE_EP_TYPE:
		rcar_gen4_remove_dw_pcie_ep(rcar);
		break;
	}
}

which would have been called from here instead of the open-coded
switch-case statement. Thus the driver design will be preserved (a set
of the init/deinit, add/remove, probe/remove and functional helper
methods) and the mode initialization will be localized in a single
place.

-Serge(y)

>  	rcar_gen4_pcie_unprepare(rcar);
>  }
>  
>  static const struct of_device_id rcar_gen4_pcie_of_match[] = {
> -	{ .compatible = "renesas,rcar-gen4-pcie", },
> +	{
> +		.compatible = "renesas,rcar-gen4-pcie",
> +		.data = (void *)DW_PCIE_RC_TYPE,
> +	},
> +	{
> +		.compatible = "renesas,rcar-gen4-pcie-ep",
> +		.data = (void *)DW_PCIE_EP_TYPE,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, rcar_gen4_pcie_of_match);
> -- 
> 2.25.1
> 

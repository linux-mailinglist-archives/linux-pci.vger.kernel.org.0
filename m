Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3444FFFAC
	for <lists+linux-pci@lfdr.de>; Wed, 13 Apr 2022 21:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238223AbiDMT7e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Apr 2022 15:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbiDMT7d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Apr 2022 15:59:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C27B7628B;
        Wed, 13 Apr 2022 12:57:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1195061E33;
        Wed, 13 Apr 2022 19:57:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A960C385A4;
        Wed, 13 Apr 2022 19:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649879828;
        bh=QW4TS3+CmibhUThZppcuPGVHWwui1EY6C4HZSeus11M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=iQopFFnTmL47IjLfeuij/23EMHNzQAOjNgRu2/FSadHgSGeGq8XL//Y1iXQSbJMol
         4dgawxB2BHCL24xyfUIi3Mv2Ks1vMz5tV27Pi6h3CRUU2VPhgT5CWGu7y1m3iz38yi
         pWm3GRWI8Bd/DuS/TM/6i+/Hk1Eiv2VSvHfXwWMRV+jrw9E2SvbFzUPA+46JCfm/94
         of2Q4SL4zYnJqf5EjtcMNo2ZnD7HLreerzSv+uU6cQoRo1RFjqhgZh4zIunCJu0FlI
         ABKOvih5sfyFFSpiDD0UMM7XlTEj5AymXnflMWGi343ib5g79qYk4ToHceC8jGe38N
         hDzqp11wW1AgQ==
Date:   Wed, 13 Apr 2022 14:57:06 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH 1/4] PCI: qcom: Handle MSI IRQs properly
Message-ID: <20220413195706.GA686050@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411114926.1975363-2-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 11, 2022 at 02:49:23PM +0300, Dmitry Baryshkov wrote:
> On Qualcomm platforms each group of MSI interrupts is routed to the
> separate GIC interrupt. Thus to receive higher MSI vectors properly,
> we have to setup and chain more MSI interrupts. However to remain
> compatible with existing DTS files, do not fail if the platform doesn't
> provide all 8 MSI interrupts. Instead of that, limit the amount of
> supported MSI vectors.

It would be superb if the subject line included a hint about what the
fix is.  Obviously previous work tried to handle MSI IRQs properly,
too, so I think this patch is not just a bug fix but adds some extra
functionality.

Perhaps splitting this into 2-3 patches would allow the first patch to
do the simple "convert msi_irq to msi_irq[MAX_MSI_CTRLS]" and the
related mechanical changes to other drivers.

Then a follow-on patch or two could add the "has_split_msi_irq"
functionality and its use in qcom.  The commit log for this one could
then mention the DT change needed to take advantage of it.

> Fixes: 8ae0117418f3 ("PCI: qcom: Add support for handling MSIs from 8 endpoints")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/pci/controller/dwc/pci-dra7xx.c       |  2 +-
>  drivers/pci/controller/dwc/pci-exynos.c       |  2 +-
>  .../pci/controller/dwc/pcie-designware-host.c | 54 ++++++++++++++-----
>  drivers/pci/controller/dwc/pcie-designware.h  |  3 +-
>  drivers/pci/controller/dwc/pcie-keembay.c     |  2 +-
>  drivers/pci/controller/dwc/pcie-qcom.c        |  1 +
>  drivers/pci/controller/dwc/pcie-spear13xx.c   |  2 +-
>  drivers/pci/controller/dwc/pcie-tegra194.c    |  2 +-
>  8 files changed, 50 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
> index dfcdeb432dc8..0919c96dcdbd 100644
> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> @@ -483,7 +483,7 @@ static int dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
>  		return pp->irq;
>  
>  	/* MSI IRQ is muxed */
> -	pp->msi_irq = -ENODEV;
> +	pp->msi_irq[0] = -ENODEV;
>  
>  	ret = dra7xx_pcie_init_irq_domain(pp);
>  	if (ret < 0)
> diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
> index 467c8d1cd7e4..4f2010bd9cd7 100644
> --- a/drivers/pci/controller/dwc/pci-exynos.c
> +++ b/drivers/pci/controller/dwc/pci-exynos.c
> @@ -292,7 +292,7 @@ static int exynos_add_pcie_port(struct exynos_pcie *ep,
>  	}
>  
>  	pp->ops = &exynos_pcie_host_ops;
> -	pp->msi_irq = -ENODEV;
> +	pp->msi_irq[0] = -ENODEV;
>  
>  	ret = dw_pcie_host_init(pp);
>  	if (ret) {
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 2fa86f32d964..15e230d6606e 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -257,8 +257,11 @@ int dw_pcie_allocate_domains(struct pcie_port *pp)
>  
>  static void dw_pcie_free_msi(struct pcie_port *pp)
>  {
> -	if (pp->msi_irq)
> -		irq_set_chained_handler_and_data(pp->msi_irq, NULL, NULL);
> +	u32 ctrl;
> +
> +	for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++)
> +		if (pp->msi_irq[ctrl])
> +			irq_set_chained_handler_and_data(pp->msi_irq[ctrl], NULL, NULL);
>  
>  	irq_domain_remove(pp->msi_domain);
>  	irq_domain_remove(pp->irq_domain);
> @@ -368,12 +371,37 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  			for (ctrl = 0; ctrl < num_ctrls; ctrl++)
>  				pp->irq_mask[ctrl] = ~0;
>  
> -			if (!pp->msi_irq) {
> -				pp->msi_irq = platform_get_irq_byname_optional(pdev, "msi");
> -				if (pp->msi_irq < 0) {
> -					pp->msi_irq = platform_get_irq(pdev, 0);
> -					if (pp->msi_irq < 0)
> -						return pp->msi_irq;
> +			if (!pp->msi_irq[0]) {
> +				int irq = platform_get_irq_byname_optional(pdev, "msi");
> +
> +				if (irq < 0) {
> +					irq = platform_get_irq(pdev, 0);
> +					if (irq < 0)
> +						return irq;
> +				}
> +				pp->msi_irq[0] = irq;
> +			}
> +
> +			if (pp->has_split_msi_irq) {
> +				char irq_name[] = "msiXXX";
> +				int irq;
> +
> +				for (ctrl = 1; ctrl < num_ctrls; ctrl++) {
> +					if (pp->msi_irq[ctrl])
> +						continue;
> +
> +					snprintf(irq_name, sizeof(irq_name), "msi%d", ctrl + 1);
> +					irq = platform_get_irq_byname_optional(pdev, irq_name);
> +					if (irq == -ENXIO) {
> +						num_ctrls = ctrl;
> +						pp->num_vectors = num_ctrls * MAX_MSI_IRQS_PER_CTRL;
> +						dev_warn(dev, "Limiting amount of MSI irqs to %d\n", pp->num_vectors);
> +						break;
> +					}
> +					if (irq < 0)
> +						return irq;
> +
> +					pp->msi_irq[ctrl] = irq;
>  				}
>  			}
>  
> @@ -383,10 +411,12 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  			if (ret)
>  				return ret;
>  
> -			if (pp->msi_irq > 0)
> -				irq_set_chained_handler_and_data(pp->msi_irq,
> -							    dw_chained_msi_isr,
> -							    pp);
> +			for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
> +				if (pp->msi_irq[ctrl] > 0)
> +					irq_set_chained_handler_and_data(pp->msi_irq[ctrl],
> +									 dw_chained_msi_isr,
> +									 pp);
> +			}
>  
>  			ret = dma_set_mask(pci->dev, DMA_BIT_MASK(32));
>  			if (ret)
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index aadb14159df7..e34076320632 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -179,6 +179,7 @@ struct dw_pcie_host_ops {
>  
>  struct pcie_port {
>  	bool			has_msi_ctrl:1;
> +	bool			has_split_msi_irq:1;
>  	u64			cfg0_base;
>  	void __iomem		*va_cfg0_base;
>  	u32			cfg0_size;
> @@ -187,7 +188,7 @@ struct pcie_port {
>  	u32			io_size;
>  	int			irq;
>  	const struct dw_pcie_host_ops *ops;
> -	int			msi_irq;
> +	int			msi_irq[MAX_MSI_CTRLS];
>  	struct irq_domain	*irq_domain;
>  	struct irq_domain	*msi_domain;
>  	u16			msi_msg;
> diff --git a/drivers/pci/controller/dwc/pcie-keembay.c b/drivers/pci/controller/dwc/pcie-keembay.c
> index 1ac29a6eef22..297e6e926c00 100644
> --- a/drivers/pci/controller/dwc/pcie-keembay.c
> +++ b/drivers/pci/controller/dwc/pcie-keembay.c
> @@ -338,7 +338,7 @@ static int keembay_pcie_add_pcie_port(struct keembay_pcie *pcie,
>  	int ret;
>  
>  	pp->ops = &keembay_pcie_host_ops;
> -	pp->msi_irq = -ENODEV;
> +	pp->msi_irq[0] = -ENODEV;
>  
>  	ret = keembay_pcie_setup_msi_irq(pcie);
>  	if (ret)
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 6bb90003ed58..e33811aabc2a 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1534,6 +1534,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  	pci->ops = &dw_pcie_ops;
>  	pp = &pci->pp;
>  	pp->num_vectors = MAX_MSI_IRQS;
> +	pp->has_split_msi_irq = true;
>  
>  	pcie->pci = pci;
>  
> diff --git a/drivers/pci/controller/dwc/pcie-spear13xx.c b/drivers/pci/controller/dwc/pcie-spear13xx.c
> index 1569e82b5568..cc7776833810 100644
> --- a/drivers/pci/controller/dwc/pcie-spear13xx.c
> +++ b/drivers/pci/controller/dwc/pcie-spear13xx.c
> @@ -172,7 +172,7 @@ static int spear13xx_add_pcie_port(struct spear13xx_pcie *spear13xx_pcie,
>  	}
>  
>  	pp->ops = &spear13xx_pcie_host_ops;
> -	pp->msi_irq = -ENODEV;
> +	pp->msi_irq[0] = -ENODEV;
>  
>  	ret = dw_pcie_host_init(pp);
>  	if (ret) {
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index b1b5f836a806..e75712db85b0 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -2271,7 +2271,7 @@ static void tegra194_pcie_shutdown(struct platform_device *pdev)
>  
>  	disable_irq(pcie->pci.pp.irq);
>  	if (IS_ENABLED(CONFIG_PCI_MSI))
> -		disable_irq(pcie->pci.pp.msi_irq);
> +		disable_irq(pcie->pci.pp.msi_irq[0]);
>  
>  	tegra194_pcie_pme_turnoff(pcie);
>  	tegra_pcie_unconfig_controller(pcie);
> -- 
> 2.35.1
> 

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18264525534
	for <lists+linux-pci@lfdr.de>; Thu, 12 May 2022 20:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357815AbiELSzo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 May 2022 14:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356238AbiELSzn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 May 2022 14:55:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62300635E;
        Thu, 12 May 2022 11:55:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBB4661A78;
        Thu, 12 May 2022 18:55:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1199C385B8;
        Thu, 12 May 2022 18:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652381740;
        bh=WWAAPtxxtrtCt/U+Ck9agHdEIF6m1EJtXt8aBqRS4zA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=E64vmSecjpiNKtMh6u9O9WROcYkltlTr6S5NYbDhQ/JWNCTeE7zbQoDywPEwXIJSo
         xwpUtZktVDk6EQZHq0HwOyjJw7eDSv+5f0Xrdfy6tg9+pKnJH/EKjC7AWsXK+nO5vF
         TTLET8ZbiOk2hCFZtu09bURK6ut0khpQ1JlnUnHQU84CaQAcsJuh5pR4mPsGYaohHk
         QOor43jLv90t2Cfe1YrCryaJ0cYi6/xFQhW+sqTxt3roBA087gsqy0NfZ8QpUyEiSw
         EHMuBxv7JvovBbD054Zhc3R5Ju8/wD8qhF6Hy5R7+GRJUDBp2QbQ3e1yk+6ZF9Ov/o
         mdMax5xEvn7vg==
Date:   Thu, 12 May 2022 13:55:37 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v8 06/10] PCI: dwc: Handle MSIs routed to multiple GIC
 interrupts
Message-ID: <20220512185537.GA861067@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512104545.2204523-7-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 12, 2022 at 01:45:41PM +0300, Dmitry Baryshkov wrote:
> On some of Qualcomm platforms each group of 32 MSI vectors is routed to the
> separate GIC interrupt. Implement support for such configuraions by
> parsing "msi0" ... "msi7" interrupts and attaching them to the chained
> handler.

Again, only if you have some other reason to repost:

s/configuraions/configurations/

> Note, that if DT doesn't list an array of MSI interrupts and uses single
> "msi" IRQ, the driver will limit the amount of supported MSI vectors
> accordingly (to 32).
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 33 ++++++++++++++++++-
>  drivers/pci/controller/dwc/pcie-designware.h  |  1 +
>  2 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 6b0c7b75391f..258bafa306dc 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -291,7 +291,8 @@ static void dw_pcie_msi_init(struct pcie_port *pp)
>  static int dw_pcie_msi_host_init(struct pcie_port *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> -	struct platform_device *pdev = to_platform_device(pci->dev);
> +	struct device *dev = pci->dev;
> +	struct platform_device *pdev = to_platform_device(dev);
>  	int ret;
>  	u32 ctrl, num_ctrls;
>  
> @@ -299,6 +300,36 @@ static int dw_pcie_msi_host_init(struct pcie_port *pp)
>  	for (ctrl = 0; ctrl < num_ctrls; ctrl++)
>  		pp->irq_mask[ctrl] = ~0;
>  
> +	if (pp->has_split_msi_irq) {
> +		char irq_name[] = "msiXX";
> +		int irq;
> +
> +		if (!pp->msi_irq[0]) {
> +			irq = platform_get_irq_byname_optional(pdev, irq_name);
> +			if (irq == -ENXIO) {
> +				num_ctrls = 1;
> +				pp->num_vectors = min((u32)MAX_MSI_IRQS_PER_CTRL, pp->num_vectors);
> +				dev_warn(dev, "No additional MSI IRQs, limiting amount of MSI vectors to %d\n",
> +					 pp->num_vectors);
> +			} else {
> +				pp->msi_irq[0] = irq;
> +			}
> +		}
> +
> +		/* If we fallback to the single MSI ctrl IRQ, this loop will be skipped as num_ctrls is 1 */
> +		for (ctrl = 1; ctrl < num_ctrls; ctrl++) {
> +			if (pp->msi_irq[ctrl])
> +				continue;
> +
> +			snprintf(irq_name, sizeof(irq_name), "msi%d", ctrl);
> +			irq = platform_get_irq_byname(pdev, irq_name);
> +			if (irq < 0)
> +				return irq;
> +
> +			pp->msi_irq[ctrl] = irq;
> +		}
> +	}
> +
>  	if (!pp->msi_irq[0]) {
>  		int irq = platform_get_irq_byname_optional(pdev, "msi");
>  
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 9c1a38b0a6b3..3aa840a5b19c 100644
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
> -- 
> 2.35.1
> 

Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250D7526167
	for <lists+linux-pci@lfdr.de>; Fri, 13 May 2022 13:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378780AbiEMLxA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 May 2022 07:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344951AbiEMLw7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2022 07:52:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA9E16D109;
        Fri, 13 May 2022 04:52:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9DA761E78;
        Fri, 13 May 2022 11:52:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2455AC34100;
        Fri, 13 May 2022 11:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652442777;
        bh=plVoKs5ntKkRyOTvVf6qPt7Mg+ey65/xaSr7OIeYHG4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KvY1A2fpAaWG76TwJ7ZSnbB/+Pkh5lZDtgWNc1l/e9AD3PHbLCRrkzz8+RATy91zz
         VAbJqsZm/mfimXsTaEz8/uQ7E433reluMmPSsuPPY5nKIeDqi6K+NMvej069jCA9JR
         15T9d/Q3FluHS9KhKLN55VD3pIM4bxDegujIwVJhG0mbc2mok2YuaCrgzxgQFWBqSC
         HZXaGQInC6CJGm4ETP9P0OJer9lyIZ0cimsqJuBVM2P5A7pyUyLvvq70r3YecW+6dG
         fF42G1Om00IRbQD4uDaKMLGJMRFAGM58Hi/uOxLmTAF8PJHb1pqbVfrf420UBYFyG6
         sJUArU4HUmSiw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1npTqn-0002JJ-2I; Fri, 13 May 2022 13:52:53 +0200
Date:   Fri, 13 May 2022 13:52:53 +0200
From:   Johan Hovold <johan@kernel.org>
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
Message-ID: <Yn5GlR0UD2/pcOiy@hovoldconsulting.com>
References: <20220512104545.2204523-1-dmitry.baryshkov@linaro.org>
 <20220512104545.2204523-7-dmitry.baryshkov@linaro.org>
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
> 
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

This looks broken; you're requesting "msiXX", not "msi0".

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

Johan

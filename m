Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9787F526211
	for <lists+linux-pci@lfdr.de>; Fri, 13 May 2022 14:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380336AbiEMMe2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 May 2022 08:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380325AbiEMMe1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2022 08:34:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B0D68304;
        Fri, 13 May 2022 05:34:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69E5F61F0E;
        Fri, 13 May 2022 12:34:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D3FC34100;
        Fri, 13 May 2022 12:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652445240;
        bh=3mygAL0D6We1NHlHF0j1QWTNoRFTYQzT7KU3jjjbnG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mCy4BK5cjoTY7P1uL6BtzOUjOM68Bkv2loTbAYJyUKDTaq8Sk7QKOXfArO7IHCPLi
         +yqG0+cJjbUOdpwKT3BAdU1+hrSo7RjyjbsicOZKcRiwV5QIVaF/Y8CVQtA4SIOm40
         46S/q+rqLB+ROiGi7oPEJ+DNPCZyzptyZStmpsaYe9uTo+9efVO+qsB6lPqSdG1TOd
         SHW3nYj4s9mq2olYOysB3rgbpXK4X4GI4Uz0RcwmdmCP37hFCaLYxI/ZactjBHvzv5
         m2j1CSGoyw9wL4KhcD34F9X7xB72B8YDpQC6IiDQYl2U64QoZ06iYWFL277EdWaFTx
         oStY29ePuwL5A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1npUUW-0002aA-UT; Fri, 13 May 2022 14:33:57 +0200
Date:   Fri, 13 May 2022 14:33:56 +0200
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
Message-ID: <Yn5QNF8OxXcicNE8@hovoldconsulting.com>
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
> +			if (irq == -ENXIO) {
> +				num_ctrls = 1;
> +				pp->num_vectors = min((u32)MAX_MSI_IRQS_PER_CTRL, pp->num_vectors);

min_t()?

> +				dev_warn(dev, "No additional MSI IRQs, limiting amount of MSI vectors to %d\n",
> +					 pp->num_vectors);

We already print the number of vectors used a bit further down in this
function, no need to repeat it here.

This will also be printed when booting with devicetrees which only have
a single "msi" interrupt (which isn't deprecated).

Perhaps a debug printk is sufficient, or at least something less verbose.

> +			} else {
> +				pp->msi_irq[0] = irq;
> +			}
> +		}
> +
> +		/* If we fallback to the single MSI ctrl IRQ, this loop will be skipped as num_ctrls is 1 */

Please break lines at 80 columns unless not doing so improves
readability.

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

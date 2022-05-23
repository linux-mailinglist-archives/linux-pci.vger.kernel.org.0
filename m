Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083D4530A54
	for <lists+linux-pci@lfdr.de>; Mon, 23 May 2022 10:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbiEWHxp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 May 2022 03:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbiEWHxo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 May 2022 03:53:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2782B20F6B;
        Mon, 23 May 2022 00:53:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD551B80F10;
        Mon, 23 May 2022 07:53:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33439C385AA;
        Mon, 23 May 2022 07:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653292418;
        bh=Xq4Me4uoPFHoirID66CAuT9yC8SWOqcALamohE0HdT4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JV0slQaJamIu1d4cBTwR9O0Hq7yJEwGQxcBeH2sFgZSLdizWPn4b6ZAgN5IvHEwUs
         1+FOzMIwySE5l1ffcmsSPKjXjxwVyZDdyptZwqmyjBHB+zbRHslLsj6gODNDNzPROP
         ywpekfban2GV1Uwdt5/CBfonyeDdlRSMWPnaADtaUr9JK6TqftKb8H6TxcyO6Pjz8H
         2M//tY+2mAkn+0LjNmH1s/R598VF4eXipuA6G4PfG6RA4FX+fEi9TNDRypVnd1n1FP
         Q9AJyZIGMbFSYiMSH2KPs7Ma9TxjprOqOUqvKpI+NbMSQ/8Nat8qsRoEin1Z5vRzOK
         Kf4gx3+YvkfMg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nt2sg-0001gy-Vl; Mon, 23 May 2022 09:53:35 +0200
Date:   Mon, 23 May 2022 09:53:34 +0200
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
Subject: Re: [PATCH v11 3/7] PCI: dwc: Handle MSIs routed to multiple GIC
 interrupts
Message-ID: <Yos9fkgxAN1jJ4jO@hovoldconsulting.com>
References: <20220520183114.1356599-1-dmitry.baryshkov@linaro.org>
 <20220520183114.1356599-4-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520183114.1356599-4-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 20, 2022 at 09:31:10PM +0300, Dmitry Baryshkov wrote:
> On some of Qualcomm platforms each group of 32 MSI vectors is routed to the
> separate GIC interrupt. Implement support for such configurations by
> parsing "msi0" ... "msiN" interrupts and attaching them to the chained
> handler.
> 
> Note, that if DT doesn't list an array of MSI interrupts and uses single
> "msi" IRQ, the driver will limit the amount of supported MSI vectors
> accordingly (to 32).
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 58 +++++++++++++++++--
>  1 file changed, 54 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index a076abe6611c..381bc24d5715 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -288,6 +288,43 @@ static void dw_pcie_msi_init(struct pcie_port *pp)
>  	dw_pcie_writel_dbi(pci, PCIE_MSI_ADDR_HI, upper_32_bits(msi_target));
>  }
>  
> +static const char * const split_msi_names[] = {
> +	"msi0", "msi1", "msi2", "msi3",
> +	"msi4", "msi5", "msi6", "msi7",
> +};
> +
> +static int dw_pcie_parse_split_msi_irq(struct pcie_port *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct device *dev = pci->dev;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	int irq;
> +	u32 ctrl;
> +
> +	irq = platform_get_irq_byname_optional(pdev, split_msi_names[0]);
> +	if (irq == -ENXIO)
> +		return -ENXIO;

You still need to check for other errors and -EPROBE_DEFER here.

> +
> +	pp->msi_irq[0] = irq;
> +
> +	/* Parse as many IRQs as described in the DTS. */

s/DTS/devicetree/

> +	for (ctrl = 1; ctrl < MAX_MSI_CTRLS; ctrl++) {
> +		irq = platform_get_irq_byname_optional(pdev, split_msi_names[ctrl]);
> +		if (irq == -ENXIO)
> +			break;
> +		if (irq < 0)
> +			return dev_err_probe(dev, irq,
> +					     "Failed to parse MSI IRQ '%s'\n",
> +					     split_msi_names[ctrl]);
> +
> +		pp->msi_irq[ctrl] = irq;
> +	}
> +
> +	pp->num_vectors = ctrl * MAX_MSI_IRQS_PER_CTRL;
> +
> +	return 0;
> +}
> +
>  static int dw_pcie_msi_host_init(struct pcie_port *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> @@ -295,22 +332,34 @@ static int dw_pcie_msi_host_init(struct pcie_port *pp)
>  	struct platform_device *pdev = to_platform_device(dev);
>  	int ret;
>  	u32 ctrl, num_ctrls;
> +	bool has_split_msi_irq = false;

This one should go in the follow-on patch that starts using it.

> -	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
> -	for (ctrl = 0; ctrl < num_ctrls; ctrl++)
> +	for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++)
>  		pp->irq_mask[ctrl] = ~0;
>  
> +	if (!pp->msi_irq[0]) {
> +		ret = dw_pcie_parse_split_msi_irq(pp);
> +		if (ret < 0 && ret != -ENXIO)
> +			return ret;
> +	}
> +
> +	if (!pp->num_vectors)
> +		pp->num_vectors = MSI_DEF_NUM_VECTORS;

This works, but now you override num_vectors unconditionally when using
split msis (and not just when num_vectors is set to zero).

Is it work allowing to use num_vectors as a maximum as in previous
versions (if only for consistency)?

> +	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
> +
>  	if (!pp->msi_irq[0]) {
>  		int irq = platform_get_irq_byname_optional(pdev, "msi");
>  
>  		if (irq < 0) {
>  			irq = platform_get_irq(pdev, 0);
>  			if (irq < 0)
> -				return irq;
> +				return dev_err_probe(dev, irq, "Failed to parse MSI irq\n");
>  		}
>  		pp->msi_irq[0] = irq;
>  	}
>  
> +	dev_dbg(dev, "Using %d MSI vectors\n", pp->num_vectors);
> +
>  	pp->msi_irq_chip = &dw_pci_msi_bottom_irq_chip;
>  
>  	ret = dw_pcie_allocate_domains(pp);
> @@ -407,7 +456,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  				     of_property_read_bool(np, "msi-parent") ||
>  				     of_property_read_bool(np, "msi-map"));
>  
> -		if (!pp->num_vectors) {
> +		/* for the has_msi_ctrl the default assignment is handled inside dw_pcie_msi_host_init() */
> +		if (!pp->has_msi_ctrl && !pp->num_vectors) {
>  			pp->num_vectors = MSI_DEF_NUM_VECTORS;
>  		} else if (pp->num_vectors > MAX_MSI_IRQS) {
>  			dev_err(dev, "Invalid number of vectors\n");

Johan

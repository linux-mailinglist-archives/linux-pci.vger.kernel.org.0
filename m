Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B2153BA8F
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jun 2022 16:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbiFBOSb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jun 2022 10:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbiFBOSb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jun 2022 10:18:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1333C14084B;
        Thu,  2 Jun 2022 07:18:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B914EB81F60;
        Thu,  2 Jun 2022 14:18:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56EFCC385A5;
        Thu,  2 Jun 2022 14:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654179507;
        bh=eRDPmv4c+U9nynMolfy/A09s2kdNZCpH6noPD5U/wOg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eylHqOT2Dkwv9k40DXpO3x/oKCSrkDdYa0wD10+LzJHxQQh1F000mVNOnHZAw8p4r
         Ji6gH5B3uZls6kLBspVxy1FqepkT5TGzB+gYrvJ9BoeRNIZG/fk98UXQoR2YbHhQV1
         q3gRmcKTVSET2/tioTMfgi32mS9DjVlMOGSSmHFY7OVRx3JA7HC2nr+RHeSdUje05W
         JVrBDIPN1b86l71e8/+G1RMFBIb1Tx3egW4kUREHHZCx9xoA2KSQuHeOxfCfzKr7e7
         1UVH0dT/KgbfTaHfZAVblMn4qfbdMDb3KFpeigGzjA6rN9FAFmlUKjqch53oBH6ziL
         lVMc+znUaFKvQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nwlea-0007mB-7g; Thu, 02 Jun 2022 16:18:24 +0200
Date:   Thu, 2 Jun 2022 16:18:24 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v12 5/8] PCI: dwc: Handle MSIs routed to multiple GIC
 interrupts
Message-ID: <YpjGsOT2y2IDTHAU@hovoldconsulting.com>
References: <20220523181836.2019180-1-dmitry.baryshkov@linaro.org>
 <20220523181836.2019180-6-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523181836.2019180-6-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 23, 2022 at 09:18:33PM +0300, Dmitry Baryshkov wrote:
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
>  .../pci/controller/dwc/pcie-designware-host.c | 61 +++++++++++++++++--
>  1 file changed, 57 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index a076abe6611c..98a57249ecaf 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -288,6 +288,47 @@ static void dw_pcie_msi_init(struct pcie_port *pp)
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
> +	u32 ctrl, max_vectors;
> +
> +	/* Parse as many IRQs as described in the devicetree. */
> +	for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++) {
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
> +	/* If there were no "msiN" IRQs at all, fallback to the standard "msi" IRQ. */
> +	if (ctrl == 0)
> +		return -ENXIO;
> +
> +	max_vectors = ctrl * MAX_MSI_IRQS_PER_CTRL;
> +	if (pp->num_vectors > max_vectors) {
> +		dev_warn(dev, "Exceeding number of MSI vectors, limiting to %d\n", max_vectors);

%u

break line after last comma?

> +		pp->num_vectors = max_vectors;
> +	}
> +	if (!pp->num_vectors)
> +		pp->num_vectors = max_vectors;
> +
> +	return 0;
> +}
> +
>  static int dw_pcie_msi_host_init(struct pcie_port *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> @@ -296,21 +337,32 @@ static int dw_pcie_msi_host_init(struct pcie_port *pp)
>  	int ret;
>  	u32 ctrl, num_ctrls;
>  
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
> @@ -407,7 +459,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  				     of_property_read_bool(np, "msi-parent") ||
>  				     of_property_read_bool(np, "msi-map"));
>  
> -		if (!pp->num_vectors) {
> +		/* for the has_msi_ctrl the default assignment is handled inside dw_pcie_msi_host_init() */

Add the missing "case" after "has_msi_ctrl".

s/inside/in/

Please make this a multiline comment split at < 80 chars.

And follow the comment style of the driver and start with a capital
letter.

> +		if (!pp->has_msi_ctrl && !pp->num_vectors) {
>  			pp->num_vectors = MSI_DEF_NUM_VECTORS;
>  		} else if (pp->num_vectors > MAX_MSI_IRQS) {
>  			dev_err(dev, "Invalid number of vectors\n");

Looks good now otherwise. 

But please consider Rob's suggestion for generating the interrupt names.

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
